Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35909396B68
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344593; cv=none; b=lmos77z1vGPZJjCVOrc5ruwzRPpTFCmM1xGA6J3qA9Q2DgdC+iDrymh1SE32x56juVTdG7HVOWY6PPdfjj78fYSlJBdXn9BPnyTJ8Mu00JGPG8CIh8YVx9Ii4XVC7tk12Y4ZrGVG+v0KyEBT0e02y2F2AZ/VFkinDre+bznsqxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344593; c=relaxed/simple;
	bh=oWEIc+lUhdxSETwB1umCKp0ytYefDHz9aJtoED2gv8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jlqjCpIlO6JqnYHjfsYH/uzTw2+W1aLb+vTmypKwCcHCSNSs81uA4+Kmv/zMalrYcvaVPvD6IsJSRH3nykXSPHuNovcTxtBMgkAFrednZSbcqNuKTa3MK4QoKMXamfb+dHM0Q3mNqbOVZhn13vIB/j15LVKLIhMJ5nnFFWty6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkG0rf8x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkG0rf8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E370FC2BCAF;
	Thu, 16 Apr 2026 13:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776344593;
	bh=oWEIc+lUhdxSETwB1umCKp0ytYefDHz9aJtoED2gv8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hkG0rf8xr1x40ybbYg3G9olG275FDvlYbCrNwUmgejYgs1v+CumxT9EwIe+JYg0v+
	 t/TKGSXpDW8kDcNeqD8czkkg5HMVmxWMvKR67qNl/XOH4qfXpVASvXJc8W52/x21hj
	 B3hbQQiUmckdJFFxc9pyt3xh29XkIQlOwD31w9T1N67+Dn2C4U8RAvRImaXN8/PZD5
	 0HaC9eMDTI4jy7516ql5ywDJb8urA8VGDqgdKeH/oss6F1A8o7rbfZlSaXceLH1zog
	 EtLlXMOuV5JstI97peVpBic1ci0aaE6qE2dmfVAZvFdpb+/Zc+nOZOaH9RWbKw0XLb
	 7XbfWxppNAigw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: allow UTF-8 literals in
 bpf_bprintf_prepare()
Reply-To: sashiko@lists.linux.dev
To: "Yihan Ding" <dingyihan@uniontech.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416120142.1420646-2-dingyihan@uniontech.com>
References: <20260416120142.1420646-2-dingyihan@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 13:03:12 +0000
Message-Id: <20260416130312.E370FC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] UTF-8 literals are incorrectly rejected when placed immediately =
after '%s' or '%p' format specifiers.
--

commit c7ffc79748019b47230d65f7c4646b2bba78f020
Author: Yihan Ding <dingyihan@uniontech.com>

bpf: allow UTF-8 literals in bpf_bprintf_prepare()

This commit modifies bpf_bprintf_prepare() to permit bytes >=3D 0x80 in
plain text, allowing UTF-8 literals to pass through unchanged while still
rejecting ASCII control bytes.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index bb95e287b0dc8..2bb60200c2665 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -845,7 +845,13 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_siz=
e, const u64 *raw_args,
>  		data->buf =3D buffers->buf;
> =20
>  	for (i =3D 0; i < fmt_size; i++) {
> -		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
> +		unsigned char c =3D fmt[i];
> +
> +		/*
> +		 * Permit bytes >=3D 0x80 in plain text so UTF-8 literals can pass
> +		 * through unchanged, while still rejecting ASCII control bytes.
> +		 */
> +		if (isascii(c) && !isprint(c) && !isspace(c)) {
>  			err =3D -EINVAL;
>  			goto out;
>  		}

Does this change overlook the lookahead checks performed on characters
immediately following format specifiers like %s and %p?

For example, looking at the parsing logic for %s:

kernel/bpf/helpers.c:bpf_bprintf_prepare() {
    ...
		} else if (fmt[i] =3D=3D 's') {
			fmt_ptype =3D fmt[i];
fmt_str:
			if (fmt[i + 1] !=3D 0 &&
			    !isspace(fmt[i + 1]) &&
			    !ispunct(fmt[i + 1])) {
				err =3D -EINVAL;
				goto out;
			}
    ...
}

Because the initial loop now permits bytes >=3D 0x80, these bytes can appear
immediately after a format specifier. If a UTF-8 literal is placed immediat=
ely
after the specifier, such as in the string "%s=E4=BD=A0=E5=A5=BD", fmt[i + =
1] will be the
first byte of the UTF-8 character.

Since isspace() and ispunct() only match ASCII characters, both will
evaluate to false. Will this cause the parser to incorrectly reject valid
UTF-8 strings with -EINVAL?

A similar lookahead check exists for %p:

kernel/bpf/helpers.c:bpf_bprintf_prepare() {
    ...
		if (fmt[i] =3D=3D 'p') {
			sizeof_cur_arg =3D sizeof(long);

			if (fmt[i + 1] =3D=3D 0 || isspace(fmt[i + 1]) ||
			    ispunct(fmt[i + 1])) {
				if (tmp_buf)
					cur_arg =3D raw_args[num_spec];
				goto nocopy_fmt;
			}
    ...
}

If fmt[i + 1] is a UTF-8 character, it won't match isspace() or ispunct().
It will then fall through to the %pI4/%pi4 checks and also be rejected with
-EINVAL.

Can the lookahead checks be updated to also permit bytes >=3D 0x80, matching
the new plain text parsing rules?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416120142.1420=
646-1-dingyihan@uniontech.com?part=3D1
