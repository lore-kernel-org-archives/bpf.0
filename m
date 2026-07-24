Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606246AEEF
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922430; cv=none; b=WfXEZWMLEFMe11kRl63rNUTHdJYQu7zZKUVkOshqmYwtFUbbg5taLO5xypUPSsrFT/Kg4hX0GwHkxa3fB5s6Plr0utTypVYVPERR9/RuXpAIsXYVoSBYoHflJwN59t7XpogPIML83NS6I2K/Kn48oeGLHIX2xtych4zGEuWPKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922430; c=relaxed/simple;
	bh=eWHdlM0PPbWob7O4URBBpSz/LBeALF92QvwqYIttKRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f6zsYTz+DR7ObwcaTRSJer0KWDF2afBuwsT3LSm3zOuvdhbrSIWYieze9sBnV3cxV0/PB5yfSK/NBHolcFOs6+QkoDhdJbbtsONToCMPDIlIxDGjWr6Fl4/FtLXLkjdexb3SmqoqkHsgtnSDcrZ3DHv7rCBQTxDRk+712scrOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVj73T7x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVj73T7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F79D1F000E9;
	Fri, 24 Jul 2026 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784922426;
	bh=HHPS6Mbl3eUcRqoBjsJUB6UE32RyyQ9+2aUk369QOXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mVj73T7xRZMNeSH1QozwTdOMm3U6NadvkuZNDz3v56n0d9NaJgqjUyny53Tsk52nu
	 bjUmmSUi8XNkYz1pCSl8F+ZeRnwPkm7hV9JePw+nE+dM01+ViF46h0EgtSu1cXrljG
	 Sgr/yEv3QOIsCJ8CLkzUyyftC4AdCgD0hl4VeVm4EiF78GFBERHHaxf+RFszVKPeU1
	 fw12yKmVPrVO/PVTULHTunT8dw9pHvEId8CZKiZwLNHavoaOU6W4235C5yiaLCyUA8
	 cIr+jYnhmPLeNAzpbL0FHITIRQFrnNV95JDKcozqiCjLdxnGlbGoHNTSSUJMpbKw+W
	 G/9fmsbPeuAXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 14/18] bpf: Check helper mem+size in
 ARG_PTR_TO_MEM case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260724190813.1458271-15-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
 <20260724190813.1458271-15-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 19:47:05 +0000
Message-Id: <20260724194706.0F79D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling check_mem_size_reg() on the size register before validatin=
g its type allows an unprivileged user to trigger a kernel warning (WARN_ON=
CE) and potential panic, leading to a local Denial of Service.
--

--- Patch [14]: [PATCH bpf-next v2 14/18] bpf: Check helper mem+size in ARG=
_PTR_TO_MEM case ---
commit 49ede5ce4d16f1df74560df7eef17176d13cb3e1
Author: Amery Hung <ameryhung@gmail.com>

bpf: Check helper mem+size in ARG_PTR_TO_MEM case

This commit modifies the BPF verifier to check variable-size memory argumen=
ts
and their associated size registers simultaneously during the ARG_PTR_TO_MEM
case, rather than waiting for the ARG_MEM_SIZE argument. It looks ahead to
regno + 1 to process the size register.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 144c2d8aa4922..2326b12a15313 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8515,14 +8512,15 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
>  				return err;
>  			if (arg_type & MEM_ALIGNED)
>  				err =3D check_ptr_alignment(env, reg, 0, fn->arg_size[arg], true);
> +		} else {
> +			struct bpf_reg_state *size_reg =3D reg_state(env, regno + 1);
> +
> +			err =3D check_mem_size_reg(env, reg, size_reg, argno,
> +						 argno_from_reg(regno + 1),
> +						 arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
> +						 fn->arg_type[arg + 1] & SCALAR_MAYBE_ZERO, meta);

[Severity: High]
Could this call to check_mem_size_reg() process a non-scalar register?

By looking ahead and processing size_reg at regno + 1 here, it seems this is
happening before the size register's type is validated in the next loop
iteration of check_func_arg().

If a BPF program passes a pointer (like PTR_TO_MAP_VALUE with var_off=3D0)
instead of a scalar for the size argument, it appears it would bypass the
scalar bounds checks. When check_mem_size_reg() subsequently calls
mark_chain_precision() on that non-scalar register, could this trigger a
verifier_bug() and BPF_WARN_ONCE()?

On systems with panic_on_warn enabled, this might lead to a local denial
of service.

>  		}
>  		break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724190813.1458=
271-1-ameryhung@gmail.com?part=3D14
