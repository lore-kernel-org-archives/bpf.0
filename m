Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815346C825
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713419; cv=none; b=mO5ujxNrmXrQWofmmc1LxtIOmK9fh09irfkAopgqXz4YcQPuJOEP80qiqSk4QPSegQrm7jKnJtTBbnW8Xk+KEJK9yb+XOSB7CovZFMgQr5+LZLlDW+KrDgnuD0dudzZjF15m5lNg9Wem9skcskt/gNExX2FaZgNRSeDne456d2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713419; c=relaxed/simple;
	bh=j0EWkHKGbdeFGuPJoqaUfCaMREd2RWIkjv/RxrVLGwI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kg8Lac/Rifni4EPU4ZZI5K+JDxsswWafQ/HFUQijvTVNcHIEDSx+w3/yPF88t0lKp237mIwJGQEuitCaGY90m/RkUEQWaDNj65DxttUlMZ5/jACTba0HU6XJpASAMKWtBBqPcVUojq1LH0Pxowr0uuXUMvxbtTAA11WnYsFwJfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csnnWlMC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csnnWlMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D10F1F00899;
	Fri, 18 Sep 2026 06:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713417;
	bh=OHDrfpu1qzgKukH20elWivqdUuRwO1nt2V4poFzbM78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=csnnWlMCBdi4mHAIkiX0X1VjI5Ms65bBZonOTK5EpOYA3tT/JDpNCUqsn+vB8g6Bj
	 r+NOo8QEnc4wI7iXIi/uJ4r/bLcdG3hX0QLxqweMlf65KyZ/CnOxLgIvNm5XlGriV8
	 8IYH4L9ik7VGFV56HTuCuXVE614IkeU8LiwxViBcBfzBSJzJZ/pTIPbmK2pXrI0pG2
	 NnuWNo7Ve8pyUquIKLFSeXBxKgUdNNq+Qr0hcipE/xl5858GG/AvVKPmv+ApcADrBk
	 G5sqct+Ft2xLDhJOonN9eZhbXFpDUq3laS2tQdT2iKMjW2PLQ4hcRwmLG5B0SbxzSc
	 u/YXQOh74IwhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/6] tools: ynl: convert enum selector to
 string for sub-message parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917-ynl_rt_encap-v1-2-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
 <20260917-ynl_rt_encap-v1-2-fbbe6e680571@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:36:56 +0000
Message-Id: <20260918063657.4D10F1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ynl: NULL pointer dereference in generated sub-message parser
--

commit fe174a522fe7b9577c0684fb882e6edfa773326f
Author: Hangbin Liu <liuhangbin@kylinos.cn>

tools: ynl: convert enum selector to string for sub-message parsing
   =20
YNL sub-message parsing expects a string selector for strcmp(). So for
non-external enum selectors, convert the integer value to its string form
via the family's {enum}_str() helper. This enables correct decoding of
sub-messages keyed by enum values.

> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_g=
en_c.py
> index 2b3483db1b60c..45bd7bc834b49 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -951,9 +951,17 @@ class TypeSubMessage(TypeNest):
>              sel_var =3D f"_sel_{sel}"
>          else:
>              sel_var =3D f"{var}->{sel}"
> +
> +        parse_sel =3D sel_var
> +        if not self.selector.is_external() and self.selector.attr and \
> +           "enum" in self.selector.attr.attr:
> +            enum_name =3D self.selector.attr.attr["enum"]
> +            str_fn =3D c_lower(self.family.ident_name + "-" + enum_name)=
 + "_str"
> +            parse_sel =3D f"{str_fn}({sel_var})"
> +
>          get_lines =3D [f'if (!{sel_var})',
>                       f'return ynl_submsg_failed(yarg, "{self.name}", "{s=
elector}");',
> -                     f"if ({self.nested_render_name}_parse(&parg, {sel_v=
ar}, attr))",
> +                     f"if ({self.nested_render_name}_parse(&parg, {parse=
_sel}, attr))",

[Severity: High]
Can this generated code cause a null pointer dereference in the user-space
client when it communicates with a newer kernel?

The generated code checks if (!sel_var) first, which only catches a 0 value.
However, if a non-zero unknown enum value is received, the auto-generated
{enum}_str(sel_var) helper returns a null pointer.

This null string is then passed into the sub-message's _parse() function as
the sel argument, where the generated code unconditionally evaluates it:

    if (!strcmp(sel, "name")) {
        ...
    }

Passing a null pointer to strcmp() will cause a segmentation fault in the
client when processing unrecognized enum selectors.

>                       "return YNL_PARSE_CB_ERROR;"]
>          init_lines =3D [f"parg.rsp_policy =3D &{self.nested_render_name}=
_nest;",
>                        f"parg.data =3D &{var}->{self.c_name};"]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-ynl_rt_enc=
ap-v1-0-fbbe6e680571@kylinos.cn?part=3D2
