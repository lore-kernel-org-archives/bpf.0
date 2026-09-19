Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB43ACF1D
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780118; cv=none; b=U/WkhFrb0dJzRzP2QwAWrnDBNl1wjUp4aSBOJLXjSUSRo7bRBRX0AOAz8qkB9tKpnULdBHSCJ8YUkYVGgLbWLW5vG2ogragH/BbXkjsd381tLItCZcUgfXwbaC5h9MkX7z3gJL7Y3Cv2rTrAzSZ2SH3dilCECt3LqGoXVF+ZwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780118; c=relaxed/simple;
	bh=JQENncyQU5ErwQCU2ALcuv4Vjn22oiRqWdGuRzn7ZzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MMItdqmPP4GLD8prWv0Lk33VCjDnzYVbSPJ1RthIEN2OPn2A8jKm0ARGvVSVQPV5ke5/LWDkfiLT/7q3Q7zMmF2k7iVxv7skP0aCF/oY57JmgZ1YQT509nGgV2eIGAvHu+vSE/pe31caLjDXkM/osrgyPtTsg0a6vDptbbl6Fyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+t8Eye+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+t8Eye+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9211F00898;
	Sat, 19 Sep 2026 01:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780110;
	bh=4c7Tpx6YynhTMWWWO0P0+3Z5wtz9UWkRrQ/s6as6UpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+t8Eye+7TT1zU59wlFLEhXYHheOXNbf/wKRxsWUiqNZaEHpp2c112sQCsOiNisiy
	 KuyDOa8sqJUdaXmKp6Ii89ApbnUZrH1V+4zmi4WkspiIodZYuVKrzEctFIVUI9Gk2m
	 SFFuGQNEsEYKx7mVCwCmewFn0hhCse+MX76y3LWOkFHUxb/I5A4kr8HXYBqJpwZOCZ
	 xZge3AgExMuz5hOQIpakcAc2jILYSTZ+TklhvzZMp+5TWjRCj0BHq9m5hH5G5lDmmD
	 0uwHb1306nPhlqsysPE4sZ8MGR0O2H96FQEM3I0/Ip3KBFGoUyiEPFpXU8/NWffzlh
	 4WRNT5/V5p1Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: Compare stack frames in regs_exact()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260919004327.1403382-2-memxor@gmail.com>
References: <20260919004327.1403382-1-memxor@gmail.com>
 <20260919004327.1403382-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:08:29 +0000
Message-Id: <20260919010829.EE9211F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: Out-of-bounds array read in bpf_func() due to frameno aliasing
--

commit e17b850ba98b74f1dac193b96d8c0646c06a22d0
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Compare stack frames in regs_exact()

This commit moves frameno into the type-specific metadata union, ahead of
id, to compare stack frames in regs_exact(). It also moves the
states_maybe_looping() boundary from frameno to precise.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index a7202b44ab105..17be5f7df35af 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -45,6 +45,14 @@ struct bpf_reg_state {
>  	union {
>  		/* valid when type =3D=3D PTR_TO_PACKET */
>  		int range;
> +		/*
> +		 * Inside the callee two registers can be both PTR_TO_STACK like
> +		 * R1=3Dfp-8 and R2=3Dfp-8, but one of them points to this function st=
ack
> +		 * while another to the caller's stack. To differentiate them 'frameno'
> +		 * is used which is an index in bpf_verifier_state->frame[] array
> +		 * pointing to bpf_func_state.
> +		 */
> +		u8 frameno;

[Severity: High]
Does moving frameno into this union cause an out-of-bounds array read in
bpf_func()?

For non-stack registers (like PTR_TO_MAP_VALUE), frameno will now contain
arbitrary aliased bytes (such as the lowest byte of a map address).

In kernel/bpf/verifier.c, functions like get_constant_map_key() and
process_iter_arg() call bpf_func() unconditionally before verifying the
register is a stack pointer:

kernel/bpf/verifier.c:get_constant_map_key() {
    ...
	struct bpf_func_state *state =3D bpf_func(env, key);
    ...
	if (key->type !=3D PTR_TO_STACK)
		return -EOPNOTSUPP;
    ...
}

bpf_func() evaluates env->cur_state->frame[reg->frameno]:

include/linux/bpf_verifier.h:bpf_func() {
	struct bpf_verifier_state *cur =3D env->cur_state;

	return cur->frame[reg->frameno];
}

If a BPF program passes a non-stack register as an argument, and frameno
evaluates to a large value (e.g. 255) due to aliasing, it indexes far
outside the frame array, causing an out-of-bounds read and potential KASAN
panics during program verification.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919004327.1403=
382-1-memxor@gmail.com?part=3D1
