Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4C33D4F0
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 01:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819496; cv=none; b=hoOzBIt5VnxUISBuzo6/zuKetLyiNU/MTSRsv6m5hgHQtN5btepYFT6+hjVIwcRc7t1SPaiRrYbwmTFv7m5susmd8pAgMemQJ3rjmLJy4GYocFusp2dwVCfsJ4eKXsbUoAE4432Hf2d3Lgm0TLmJoWdWnUcbrr2A6SARf7YaQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819496; c=relaxed/simple;
	bh=1s5UyunYI7KdhEUoLlFubHact/TE0ynLT2GpKVFvoKE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FzPtt/kTnQyG7KXIFKjdGw+FWo+WUjAHW6s0YTB1XQKmRP/R9LacCocZF+lurKTqGFVzH9pxssyAhidcRrsSXu7F4dgqgENCk+Gk1p09M7+ttCmBVY+x6hDjgk1pFsJtUpx5LhOvwvGH4MSS3k+pXoSrLC5mY0EgiqqJ/dTaTYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UekFWkbf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UekFWkbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963061F00898;
	Thu,  1 Oct 2026 01:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790819494;
	bh=HmPmopqAqR3Rc6Vnqnmu2MrMD8IF3sc/9HEoUqYYeME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UekFWkbfrsfaGLY9ASgVAbgD2cbWspAzPKHbfxM59TT1voSY3Xs+nup62dKlVOMhg
	 4iy71BeMPB3rXeEk7z/3NUFIxbZfLJLy/vI/W5yfpHlYKiJBB2q4Ii4faNGExxjKNq
	 a3L7SvC5lwU7m8d33cxY+ECAzWf+JBN92p7UXWCEb2qVIIw1ZSFhgSUBLm86rOTSkp
	 6Q+Ix0pQGff/k27SefGYZ7agcyDEA8IP3P/zD1ll5yUX0uYlwPuKxSCR5ju2ut9bSf
	 JzyPgoZ9jHaWbzXlIZiocDTZtZwocBrYhHAdBeNek1cODnXLQ069XoOVnmPSMfqN8u
	 dyLOmR4kBjOgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/6] tools: ynl: convert enum selector to
 string for sub-message parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930-ynl_rt_encap-v3-2-4106c21b9ee7@kylinos.cn>
References: <20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn>
 <20260930-ynl_rt_encap-v3-2-4106c21b9ee7@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 01:51:34 +0000
Message-Id: <20261001015134.963061F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ynl: early return 0 aborts entire parsing loop on unknown sub-mess=
age
- [Medium] ynl: invalid C code generated for external enum selectors
--

commit f2c434cd3f008807f1723585dcbfd634aa3f28b7
Author: Hangbin Liu <liuhangbin@kylinos.cn>

tools: ynl: convert enum selector to string for sub-message parsing

YNL sub-message parsing expects a string selector for strcmp(). So for
non-external enum selectors, convert the integer value to its string form
via the family's {enum}_str() helper. This enables correct decoding of
sub-messages keyed by enum values.

> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_g=
en_c.py
> index 15c79849c6096..783242537fe48 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -951,13 +951,31 @@ class TypeSubMessage(TypeNest):
>              sel_var =3D f"_sel_{sel}"
>          else:
>              sel_var =3D f"{var}->{sel}"
> -        get_lines =3D [f'if (!{sel_var})',
> -                     f'return ynl_submsg_failed(yarg, "{self.name}", "{s=
elector}");',
> -                     f"if ({self.nested_render_name}_parse(&parg, {sel_v=
ar}, attr))",
> -                     "return YNL_PARSE_CB_ERROR;"]
> +
> +        local_vars =3D None
> +
> +        if self.selector.is_enum_val():
            ^^^^

[Severity: Medium]
Will this generate invalid C code for external enum selectors?

The condition doesn't check if the selector is external. If a YAML spec
defines a sub-message with an external enum selector, it appears this will
generate a non-existent structure member access for the presence variable:

    pres_var =3D f"{var}->_present.{sel}"

and try to pass the string pointer to the enum string helper, which expects
an integer. Should this check include `and not self.selector.is_external()`?

> +            enum =3D self.family.consts[self.selector.get_enum_name()]
> +            pres_var =3D f"{var}->_present.{sel}"
> +            parse_sel =3D f"{sel}_str"
> +            local_vars =3D [f'const char *{parse_sel};']
> +
> +            get_lines =3D [
> +                f'if (!{pres_var})',
> +                f'return ynl_submsg_failed(yarg, "{self.name}", "{select=
or}");',
> +                f'{parse_sel} =3D {enum.render_name}_str({sel_var});',
> +                f'if (!{parse_sel})',
> +                'return 0;']
                 ^^^^

[Severity: High]
Does returning 0 here abort the entire parsing loop?

If a generated YNL parser encounters an unrecognized sub-message enum
selector (for example, sent by a newer kernel), it looks like `return 0;`
executes directly inside the attribute loop of the parsing function.

This would silently abort processing the remainder of the Netlink message a=
nd
drop all trailing attributes without returning an error. Is it possible to
skip the attribute and continue parsing instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-ynl_rt_enc=
ap-v3-0-4106c21b9ee7@kylinos.cn?part=3D2
