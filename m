Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95FB54704D
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790399744; cv=none; b=IT3fXn3mUTdpeayZ43LIsZq0OPULU+o+ClyoRiWZGGu7rsTo0UQXXeU00FzwMAsphTFtTbJnjRpSGSieyNAaSSoTdCH1KXT573SlWJBPHjw/0hRuhtwb+NTCcaXlNdeo7a/ikD0PKavr3lFEorMyvo3dwUB7NrFtfRBX7vgUOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790399744; c=relaxed/simple;
	bh=ecom5t2VYn41kaEoimxmdqd67PfV/cE1hTfY5x8U/aM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tVkxMte3U1GFFzW97aYgfbda9pokVZQWnCLm8e/B0fgn+xztID1wVKHEKSo6aGsHLlddLe3xdGECHMNnwR5fCp5fODK/sGa68OctWdsPbPE7RNjnKZiO74rFgsnM4TxusAn2+VVKMFM4EXgvQLMSZvdv8ZFGW+XoKZ6vnZJG8ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zhb0y757; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zhb0y757"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF841F000FF;
	Sat, 26 Sep 2026 05:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790399742;
	bh=6MwCQ7wdZvANbWmtfJKtSyrNb03kNAAQa1g7iiHaP8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zhb0y757Y+2mqo5B5inmsw2lHthVNfAmjoa35ty/7HS90R+QRT0slJ6iWKnPMRGiN
	 zAvaJiA2/F0lYKJJwSiokydJRhFmAxSUrvU6Kh1kt4L4stlefuwV6qelA2RnXWqh49
	 mjXCvXY9LVjVr1GczMtI7BHqbL/IQY5nOsSalmpbxxqXN9YkB6ppXfFnNionStZZBB
	 bDD1jhBHjYRbvWElVT3eo+396XOrNadGsZoLaBOos/+BuB2iRIix3IFA7E5/W47p2V
	 ly+Zj4yuYgOjJ6WVvLHcBXxNTglGC3CoIQQVk5ghfP8+d0hA/yrn3rgQvLwEXyuqCA
	 ba6+fGkfG9xXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 11/21] bpf, x86: Dispatch exception cleanup
 pads at run time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926050102.2218021-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050102.2218021-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:15:41 +0000
Message-Id: <20260926051542.4DF841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf, x86: missing JIT epilogue for exit-less subprograms crashes e=
xception unwinder
--

commit 9bb870f715bdf91026578628a6afaf5325f80183
Author: Yonghong Song <yonghong.song@linux.dev>

bpf, x86: Dispatch exception cleanup pads at run time

This commit updates the x86 BPF JIT to dispatch exception cleanup pads at r=
un
time, setting up native cleanup tables and populating the epilogue IP to al=
low
redirecting a frame to its landing pad during an ORC stack walk.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 6c7a0578760e7..fb7e8ca1aab21 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -3278,6 +3279,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
>  			seen_exit =3D true;
>  			/* Update cleanup_addr */
>  			ctx->cleanup_addr =3D proglen;
> +			/* Where an unwind sends a frame with no pad. */
> +			bpf_prog->aux->epilogue_ip =3D (u64)image + proglen;

[Severity: High]
What happens if a BPF subprogram only terminates via a noreturn kfunc like
bpf_throw(), meaning it lacks a BPF_EXIT instruction entirely?

Since the x86 JIT generates the epilogue lazily when the first BPF_EXIT is
encountered, wouldn't do_jit() produce no epilogue at all for such a progra=
m,
leaving epilogue_ip as 0?

If an exception unwinds through this subprogram's frame, the unwinder relies
on epilogue_ip to rewrite the return address. Wouldn't it hit this error pa=
th
and abort the unwind?

kernel/bpf/helpers.c:bpf_unwind_rewrite() {
    ...
    } else if (prog->aux->epilogue_ip) {
        *ra =3D prog->aux->epilogue_ip;
    } else {
        WARN_ON_ONCE(1);
        return false;
    }
}

Could this lead to corrupted exception handling that can be triggered by
user-supplied BPF programs?

>  			if (bpf_prog_was_classic(bpf_prog) &&
>  			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
>  				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926050006.2213=
110-1-yonghong.song@linux.dev?part=3D11
