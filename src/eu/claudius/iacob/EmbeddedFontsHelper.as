package eu.claudius.iacob {
import flash.text.Font;
 
public final class EmbeddedFontsHelper {
// Embedding compiled fonts
[Embed(source="../../../../fonts-compiled/serif_italic.swf", symbol="serif_embedded")]
public static const serif_italic_font_class : Class;

[Embed(source="../../../../fonts-compiled/maidens_bold.swf", symbol="maidens_embedded")]
public static const maidens_bold_font_class : Class;

[Embed(source="../../../../fonts-compiled/serif.swf", symbol="serif_embedded")]
public static const serif_font_class : Class;

[Embed(source="../../../../fonts-compiled/maidens.swf", symbol="maidens_embedded")]
public static const maidens_font_class : Class;

[Embed(source="../../../../fonts-compiled/sans.swf", symbol="sans_embedded")]
public static const sans_font_class : Class;

[Embed(source="../../../../fonts-compiled/serif_bold.swf", symbol="serif_embedded")]
public static const serif_bold_font_class : Class;

/* Explicitly registers all embedded fonts on-demand. */
public static function initFonts () : void {
Font.registerFont(serif_italic_font_class);
Font.registerFont(maidens_bold_font_class);
Font.registerFont(serif_font_class);
Font.registerFont(maidens_font_class);
Font.registerFont(sans_font_class);
Font.registerFont(serif_bold_font_class);
}
}
}
