------------------------------------------
-- Make references to important items
------------------------------------------
Services = {
	HttpService = Game:GetService( 'HttpService' );
	Workspace = Game:GetService( 'Workspace' );
	ContentProvider = Game:GetService( 'ContentProvider' );
	CoreGui = Game:GetService( 'CoreGui' );
	Selection = Game:GetService( 'Selection' );
	Players = Game:GetService 'Players';
};

bt_logo = 'http://www.roblox.com/asset/?id=129747824';
plugin_icon = 'http://www.roblox.com/asset/?id=144549739';
export_base_url = 'http://www.f3xteam.com/bt/export/%s';

-- Create the plugin
Plugin = plugin;
Toolbar = Plugin:CreateToolbar( 'Building Tools by F3X' );
Launcher = Toolbar:CreateButton( '', 'Import from Building Tools by F3X', plugin_icon );
local GUI;

------------------------------------------
-- Load external dependencies
------------------------------------------
RbxUtility = LoadLibrary( 'RbxUtility' );
Services.ContentProvider:Preload( bt_logo );

------------------------------------------
-- Define functions that are depended-upon
------------------------------------------
function _findTableOccurrences( haystack, needle )
	-- Returns the positions of instances of `needle` in table `haystack`
	local positions = {};

	-- Add any indexes from `haystack` that have `needle`
	for index, value in pairs( haystack ) do
		if value == needle then
			table.insert( positions, index );
		end;
	end;

	return positions;
end;

------------------------------------------
-- Provide actual functionality
------------------------------------------
function showGUI( message, ok_text )

	-- Make sure the UI isn't already open
	if GUI then
		hideGUI();
	end;

	local Create = RbxUtility.Create;

	GUI = Create 'ScreenGui' {
		Name = 'BTImportUI';
		Parent = Services.CoreGui;
	};

	local Container = Create 'Frame' {
		Name = 'Container';
		Parent = GUI;
		BackgroundTransparency = 1;
		Size = UDim2.new( 1, 0, 0, 0 );
		BorderSizePixel = 0;
		ClipsDescendants = true;
	};

	local Highlight = Create 'Frame' {
		Name = 'Highlight';
		Parent = Container;
		ZIndex = 2;
		BackgroundColor3 = Color3.new( 1, 1, 1 );
		BackgroundTransparency = 0.95;
		BorderSizePixel = 0;
		Position = UDim2.new( 0, 0, 0, 270 );
		Size = UDim2.new( 1, 0, 0, 180 );
		ZIndex = 2;
	};

	if message then
		local OkButton = Create 'TextButton' {
			Name = 'OkButton';
			Parent = Highlight;
			BackgroundColor3 = Color3.new( 1, 162 / 255, 47 / 255 );
			BorderSizePixel = 0;
			Position = UDim2.new( 0.3, 0, 1, -60 );
			Size = UDim2.new( 0.4, 0, 0, 40 );
			ZIndex = 2;
			Font = Enum.Font.SourceSansBold;
			FontSize = Enum.FontSize.Size24;
			Text = ok_text;
			TextColor3 = Color3.new( 1, 1, 1 );
			TextStrokeColor3 = Color3.new( 0, 0, 0 );
			TextStrokeTransparency = 0.85;
			TextWrapped = true;
			[Create.E 'MouseButton1Up'] = function ()
				hideGUI();
			end;
		};
		Create 'Frame' {
			Name = 'Bevel';
			Parent = OkButton;
			BorderSizePixel = 0;
			BackgroundColor3 = Color3.new( 184 / 255, 116 / 255, 33 / 255 );
			Position = UDim2.new( 0, 0, 1, -2 );
			Size = UDim2.new( 1, 0, 0, 2 );
			ZIndex = 2;
		};
		local Message = Create 'TextLabel' {
			Name = 'Message';
			Parent = Highlight;
			BackgroundTransparency = 1;
			BorderSizePixel = 0;
			Position = UDim2.new( 0.1, 0, 0, 0 );
			Size = UDim2.new( 0.8, 0, 1, -30 );
			Font = Enum.Font.Arial;
			FontSize = Enum.FontSize.Size24;
			Text = message;
			TextColor3 = Color3.new( 1, 1, 1 );
			TextWrapped = true;
		};
	end;

	local Interface = Create 'Frame' {
		Name = 'Interface';
		Parent = Container;
		ZIndex = 2;
		Size = UDim2.new( 0.6, 0, 0, 110 );
		Position = UDim2.new( 0.2, 0, 0, 300 );
		BorderSizePixel = 0;
		BackgroundTransparency = 1;
		Visible = not message;
	};

	local CreationID = Create 'Frame' {
		Name = 'CreationID';
		Parent = Interface;
		BackgroundTransparency = 1;
		BorderSizePixel = 0;
		Position = UDim2.new( 0, 0, 0, 10 );
		Size = UDim2.new( 1, 0, 0, 30 );
		ZIndex = 2;
	};

	Create 'Frame' {
		Name = 'BottomBorder';
		Parent = CreationID;
		BorderSizePixel = 0;
		BackgroundColor3 = Color3.new( 1, 162 / 255, 47 / 255 );
		Position = UDim2.new( 0, 0, 1, -1 );
		Size = UDim2.new( 1, 0, 0, 1 );
		ZIndex = 2;
	};

	Create 'Frame' {
		Name = 'LeftBorder';
		Parent = CreationID;
		BorderSizePixel = 0;
		BackgroundColor3 = Color3.new( 1, 162 / 255, 47 / 255 );
		Position = UDim2.new( 0, 0, 0.8, 0 );
		Size = UDim2.new( 0, 1, 0.2, 0 );
		ZIndex = 2;
	};

	Create 'Frame' {
		Name = 'RightBorder';
		Parent = CreationID;
		BorderSizePixel = 0;
		BackgroundColor3 = Color3.new( 1, 162 / 255, 47 / 255 );
		Position = UDim2.new( 1, -1, 0.8, 0 );
		Size = UDim2.new( 0, 1, 0.2, 0 );
		ZIndex = 2;
	};

	local TextBox;
	TextBox = Create 'TextBox' {
		Parent = CreationID;
		BackgroundTransparency = 1;
		BorderSizePixel = 0;
		ClearTextOnFocus = true;
		Position = UDim2.new( 0, 10, 0, -10 );
		Size = UDim2.new( 1, -10, 1, 10 );
		ZIndex = 2;
		Font = Enum.Font.SourceSans;
		FontSize = Enum.FontSize.Size24;
		Text = "What's your creation's ID?";
		TextColor3 = Color3.new( 1, 1, 1 );
		TextTransparency = 0.3;
		TextXAlignment = Enum.TextXAlignment.Left;
		[Create.E 'FocusLost'] = function ( enter_pressed )
			if not enter_pressed then
				return;
			end;
			import( TextBox.Text:lower() );
		end;
	};

	local CancelButton = Create 'TextButton' {
		Parent = Interface;
		BackgroundColor3 = Color3.new( 1, 162 / 255, 47 / 255 );
		BackgroundTransparency = 0.3;
		BorderSizePixel = 0;
		Name = 'CancelButton';
		Position = UDim2.new( 0.55, 0, 0, 65 );
		Size = UDim2.new( 0.45, 0, 0, 40 );
		ZIndex = 2;
		Font = Enum.Font.SourceSansBold;
		FontSize = Enum.FontSize.Size24;
		Text = 'Cancel';
		TextColor3 = Color3.new( 1, 1, 1 );
		TextStrokeColor3 = Color3.new( 0, 0, 0 );
		TextStrokeTransparency = 0.85;
		TextTransparency = 0.3;
		[Create.E 'MouseButton1Up'] = function ()
			hideGUI();
		end;
	};

	Create 'Frame' {
		Parent = CancelButton;
		BackgroundColor3 = Color3.new( 131 / 255, 83 / 255, 23 / 255 );
		BorderSizePixel = 0;
		Name = 'Bevel';
		Position = UDim2.new( 0, 0, 1, -2 );
		Size = UDim2.new( 1, 0, 0, 2 );
		ZIndex = 2;
	};

	local ImportButton = Create 'TextButton' {
		Parent = Interface;
		BackgroundColor3 = Color3.new( 1, 162 / 255, 47 / 255 );
		BorderSizePixel = 0;
		Name = 'ImportButton';
		Position = UDim2.new( 0, 0, 0, 65 );
		Size = UDim2.new( 0.45, 0, 0, 40 );
		ZIndex = 2;
		Font = Enum.Font.SourceSansBold;
		FontSize = Enum.FontSize.Size24;
		Text = 'Import';
		TextColor3 = Color3.new( 1, 1, 1 );
		TextStrokeColor3 = Color3.new( 0, 0, 0 );
		TextStrokeTransparency = 0.85;
		[Create.E 'MouseButton1Up'] = function ()
			import( TextBox.Text:lower() );
		end;
	};

	Create 'Frame' {
		Parent = ImportButton;
		BackgroundColor3 = Color3.new( 204 / 255, 129 / 255, 37 / 255 );
		BorderSizePixel = 0;
		Name = 'Bevel';
		Position = UDim2.new( 0, 0, 1, -2 );
		Size = UDim2.new( 1, 0, 0, 2 );
		ZIndex = 2;
	};

	Create 'Frame' {
		Name = 'Overlay';
		Parent = Container;
		BackgroundColor3 = Color3.new( 0, 0, 0 );
		BackgroundTransparency = 0.25;
		BorderSizePixel = 0;
		Size = UDim2.new( 1, 0, 1, 0 );
	};

	local Logo = Create 'ImageLabel' {
		Name = 'Logo';
		Parent = Container;
		BackgroundTransparency = 1;
		BorderSizePixel = 0;
		Image = bt_logo;
		Position = UDim2.new( 0, GUI.AbsoluteSize.x / 2 - 128, 0, 0 );
		Size = UDim2.new( 0, 256, 0, 256 );
		ZIndex = 2;
	};
	GUI.Changed:connect( function ( property )
		if property == 'AbsoluteSize' then
			Logo.Position = UDim2.new( 0, GUI.AbsoluteSize.x / 2 - 128, 0, 0 );
		end;
	end );

	Container:TweenSize( UDim2.new( 1, 0, 1, 0 ), Enum.EasingDirection.Out, Enum.EasingStyle.Bounce, 0.5, true );

end;

function hideGUI()

	-- Hide the current GUI
	if GUI then
		GUI:Destroy();
	end;

end;

Launcher.Click:connect( function ()
	if SoloMode then
		showGUI( 'Use regular Studio to import.', 'Sure' );
	else
		showGUI();
	end;
end );

function import( creation_id )

	hideGUI();

	-- Try to download the creation
	local creation_data;
	local download_attempt, download_error = ypcall( function ()
		creation_data = Services.HttpService:GetAsync( export_base_url:format( creation_id ) );
	end );

	-- Fail graciously
	if not download_attempt and download_error == 'Http requests are not enabled' then
		print 'Import from Building Tools by F3X: Please enable HTTP requests (see http://wiki.roblox.com/index.php?title=Sending_HTTP_requests#Http_requests_are_not_enabled)';
		showGUI( 'Please enable HTTP requests (see Output)', 'Got it' );
		return false;
	end;
	if not download_attempt then
		print( 'Import from Building Tools by F3X (download request error): ' .. tostring( download_error ) );
		showGUI( "We couldn't get your creation", 'Oh' );
		return false;
	end;
	if not ( creation_data and type( creation_data ) == 'string' and creation_data:len() > 0 ) then
		showGUI( "We couldn't get your creation", ':(' );
		return false;
	end;
	if not pcall( function () creation_data = RbxUtility.DecodeJSON( creation_data ); end ) then
		showGUI( "We couldn't get your creation", ":'(" );
		return false;
	end;

	-- Create a container to hold the creation
	local Container = Instance.new( 'Model', Services.Workspace );
	Container.Name = 'BTExport';

	if creation_data.version == 1 then

		local objects = {};

		for part_id, part_data in pairs( creation_data.parts ) do
			local Part;

			local part_type = part_data[1];
			if part_type == 1 then
				Part = Instance.new( "Part" );
			elseif part_type == 2 then
				Part = Instance.new( "TrussPart" );
			elseif part_type == 3 then
				Part = Instance.new( "WedgePart" );
			elseif part_type == 4 then
				Part = Instance.new( "CornerWedgePart" );
			elseif part_type == 5 then
				Part = Instance.new( "Part" );
				Part.Shape = "Cylinder";
			elseif part_type == 6 then
				Part = Instance.new( "Part" );
				Part.Shape = "Ball";
			elseif part_type == 7 then
				Part = Instance.new( "Seat" );
			elseif part_type == 8 then
				Part = Instance.new( "VehicleSeat" );
			elseif part_type == 9 then
				Part = Instance.new( "SpawnLocation" );
			end;
			objects[part_id] = Part;

			if ( pcall( function () local test = Part.FormFactor; end ) ) then
				Part.FormFactor = "Custom";
			end;

			Part.Size = Vector3.new( unpack( part_data[2] ) );
			Part.CFrame = CFrame.new( unpack( part_data[3] ) );
			Part.BrickColor = BrickColor.new( part_data[4] );
			Part.Material = part_data[5];
			Part.Anchored = part_data[6];
			Part.CanCollide = part_data[7];
			Part.Reflectance = part_data[8];
			Part.Transparency = part_data[9];
			Part.TopSurface = part_data[10];
			Part.BottomSurface = part_data[11];
			Part.LeftSurface = part_data[12];
			Part.RightSurface = part_data[13];
			Part.FrontSurface = part_data[14];
			Part.BackSurface = part_data[15];

			Part.Parent = Container;

			-- Add the part ID if it's referenced somewhere else
			if creation_data.welds then
				for _, Weld in pairs( creation_data.welds ) do
					if Weld[1] == part_id or Weld[2] == part_id then
						RbxUtility.Create 'StringValue' {
							Name = 'BTID';
							Parent = Part;
							Value = part_id;
						};
						break;
					end;
				end;
			end;

		end;

		if creation_data.welds then
			local weld_count = 0;
			for _, __ in pairs( creation_data.welds ) do
				weld_count = weld_count + 1;
			end;
			if weld_count > 0 then
				local WeldScript = Instance.new( 'Script' );
				WeldScript.Name = 'BTWelder';
				WeldScript.Source = [[-- This script creates the welds between parts imported by the Building Tools by F3X plugin.

local create = LoadLibrary( 'RbxUtility' ).Create;
function _getAllDescendants( Parent )
	-- Recursively gets all the descendants of  `Parent` and returns them

	local descendants = {};

	for _, Child in pairs( Parent:GetChildren() ) do

		-- Add the direct descendants of `Parent`
		table.insert( descendants, Child );

		-- Add the descendants of each child
		for _, Subchild in pairs( _getAllDescendants( Child ) ) do
			table.insert( descendants, Subchild );
		end;

	end;

	return descendants;

end;
function findExportedPart( part_id )
	for _, Object in pairs( _getAllDescendants( Game:GetService( 'Workspace' ) ) ) do
		if Object:IsA( 'StringValue' ) then
			if Object.Name == 'BTID' and Object.Value == part_id then
				return Object.Parent;
			end;
		end;
	end;
end;

]];

				for weld_id, weld_data in pairs( creation_data.welds ) do
					WeldScript.Source = WeldScript.Source .. [[

( function ()
	local Part0 = findExportedPart( ']] .. weld_data[1] .. [[' );
	local Part1 = findExportedPart( ']] .. weld_data[2] .. [[' );
	if not Part0 or not Part1 then
		return;
	end;
	create 'Weld' {
		Name = 'BTWeld';
		Parent = Game.JointsService;
		Archivable = false;
		Part0 = Part0;
		Part1 = Part1;
		C1 = CFrame.new( ]] .. table.concat( weld_data[3], ', ' ) .. [[ );
	};
end )();
	]];
				end;
				WeldScript.Parent = Container;
			end;
		end;

		if creation_data.meshes then
			for mesh_id, mesh_data in pairs( creation_data.meshes ) do

				-- Create, place, and register the mesh
				local Mesh = Instance.new( "SpecialMesh", objects[mesh_data[1]] );
				objects[mesh_id] = Mesh;

				-- Set the mesh's properties
				Mesh.MeshType = mesh_data[2];
				Mesh.Scale = Vector3.new( unpack( mesh_data[3] ) );
				Mesh.MeshId = mesh_data[4];
				Mesh.TextureId = mesh_data[5];
				Mesh.VertexColor = Vector3.new( unpack( mesh_data[6] ) );

			end;
		end;

		if creation_data.textures then
			for texture_id, texture_data in pairs( creation_data.textures ) do

				-- Create, place, and register the texture
				local texture_class;
				if texture_data[2] == 1 then
					texture_class = 'Decal';
				elseif texture_data[2] == 2 then
					texture_class = 'Texture';
				end;
				local Texture = Instance.new( texture_class, objects[texture_data[1]] );
				objects[texture_id] = Texture;

				-- Set the texture's properties
				Texture.Face = texture_data[3];
				Texture.Texture = texture_data[4];
				Texture.Transparency = texture_data[5];
				if Texture:IsA( "Texture" ) then
					Texture.StudsPerTileU = texture_data[6];
					Texture.StudsPerTileV = texture_data[7];
				end;

			end;
		end;

		if creation_data.lights then
			for light_id, light_data in pairs( creation_data.lights ) do

				-- Create, place, and register the light
				local light_class;
				if light_data[2] == 1 then
					light_class = 'PointLight';
				elseif light_data[2] == 2 then
					light_class = 'SpotLight';
				end;
				local Light = Instance.new( light_class, objects[light_data[1]] )
				objects[light_id] = Light;

				-- Set the light's properties
				Light.Color = Color3.new( unpack( light_data[3] ) );
				Light.Brightness = light_data[4];
				Light.Range = light_data[5];
				Light.Shadows = light_data[6];
				if Light:IsA( 'SpotLight' ) then
					Light.Angle = light_data[7];
					Light.Face = light_data[8];
				end;

			end;
		end;

		if creation_data.decorations then
			for decoration_id, decoration_data in pairs( creation_data.decorations ) do

				-- Create and register the decoration
				if decoration_data[2] == 1 then
					local Smoke = RbxUtility.Create 'Smoke' {
						Parent = objects[decoration_data[1]];
						Color = Color3.new( unpack( decoration_data[3] ) );
						Opacity = decoration_data[4];
						RiseVelocity = decoration_data[5];
						Size = decoration_data[6];
					};
					objects[decoration_id] = Smoke;

				elseif decoration_data[2] == 2 then
					local Fire = RbxUtility.Create 'Fire' {
						Parent = objects[decoration_data[1]];
						Color = Color3.new( unpack( decoration_data[3] ) );
						SecondaryColor = Color3.new( unpack( decoration_data[4] ) );
						Heat = decoration_data[5];
						Size = decoration_data[6];
					};
					objects[decoration_id] = Fire;

				elseif decoration_data[2] == 3 then
					local Sparkles = RbxUtility.Create 'Sparkles' {
						Parent = objects[decoration_data[1]];
						SparkleColor = Color3.new( unpack( decoration_data[3] ) );
					};
					objects[decoration_id] = Sparkles;
				end;

			end;
		end;

		Container:MakeJoints();
		Services.Selection:Set( { Container } );

	end;

end;