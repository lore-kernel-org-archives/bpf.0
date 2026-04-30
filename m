Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B682E63C
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509112; cv=none; b=uVlaEwjoH+eQSyohotsbJ9F0GB9x0PUqVduFRr0NNJlI9XLuAX4hPIEvGYxFvvM3OO7SLuRvu0f0i0hR98nv+HL+xx3EkHaLD35nJzcnJBmydWnG8y+MnYC7jT8tl8uIX86ha4dIhiKpmZnWrKIw762Dz1akk13lrs53frg/KWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509112; c=relaxed/simple;
	bh=M+RkB+8Rnys/ZZ9UQuEl3jP8D5ca43+eti7gHYBjvHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CtbMmWoehT/4sbIkI9lSqL5PXFdR3Ia9hWN7tAWcnex4UuFoENWFSgxuJoGe/s0ZLCBFs7drLUZQ0zpbzV0caKjRRg0s1r1rkZBrNxmcjqv/nr9xShm6Fj/XbMWNfTVOP/gLSs5wNLJeN6NDVZUShch4RZ3UART7Jk1pmo1XchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNrUf/2t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNrUf/2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827D0C19425;
	Thu, 30 Apr 2026 00:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777509111;
	bh=M+RkB+8Rnys/ZZ9UQuEl3jP8D5ca43+eti7gHYBjvHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CNrUf/2tvLE5xE3fBfCRbadKzLbBT4+zlkPQQLz4AijbRN4fuY3TnLySmxVPM6uFD
	 MUnJA5hRwOP9huuQuX+glt4EEvKld0+rSOV9wYpvGiJ4j39J9yDvs7jAUFFLsBi+ph
	 +WB3HcK/J6tIWu5ckSRwz95HedV57z7fG5Q13w+rN4qbsl3AVh00c9yAECnrWFQmtj
	 dPLRZJbWsrQio/hcR0Dl32fXOeDwd6f7D++jWWO2KERcF0Ctv14aX82FJLJ8up2J8r
	 L/xXAqPCStRnPjE2E/qV3Qd2jQe3LBKwjCaqJZRbCQB5AjqD2FV9/sssMWBpV4V1sB
	 Q9Plk1rrlit8A==
From: sashiko-bot@kernel.org
Subject: Re: [v6 10/10] ipe: Add BPF program load policy enforcement via
 Hornet integration
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429191431.2345448-11-bboscaccy@linux.microsoft.com>
References: <20260429191431.2345448-11-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 00:31:50 +0000
Message-Id: <20260430003151.827D0C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Silent fail-open of `BPF_PROG_LOAD` policies when `CONFIG_IPE_PROP=
_BPF_SIGNATURE` is disabled
- [Low] Build failure due to unconditional access to conditionally compiled=
 field `ctx->bpf_kernel`
--

commit 168706f9eca9b1981fccd36319334eda60264af6
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

ipe: Add BPF program load policy enforcement via Hornet integration

This commit adds support for the bpf_prog_load_post_integrity LSM hook,
enabling IPE to make policy decisions about BPF program loading based on
integrity verdicts from the Hornet LSM. It introduces the BPF_PROG_LOAD
operation and multiple properties like bpf_signature, bpf_keyring, and
bpf_kernel.

> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> index 21439c5be336..9a6d583fea12 100644
> --- a/security/ipe/eval.c
> +++ b/security/ipe/eval.c
[ ... ]
> @@ -297,6 +342,32 @@ static bool evaluate_property(const struct ipe_eval_=
ctx *const ctx,
>  		return evaluate_fsv_sig_false(ctx);
>  	case IPE_PROP_FSV_SIG_TRUE:
>  		return evaluate_fsv_sig_true(ctx);
> +	case IPE_PROP_BPF_SIG_NONE:
> +		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_NONE);
[ ... ]
> +	case IPE_PROP_BPF_KERNEL_FALSE:
> +		return !ctx->bpf_kernel;
> +	case IPE_PROP_BPF_KERNEL_TRUE:
> +		return ctx->bpf_kernel;

If the kernel is compiled with CONFIG_IPE_PROP_BPF_SIGNATURE disabled,
will this cause a build failure?

In security/ipe/eval.h, the bpf_kernel field is conditionally compiled:

#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
	enum lsm_integrity_verdict bpf_verdict;
	s32 bpf_keyring_id;
	bool bpf_kernel;
#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */

Since evaluate_property() accesses ctx->bpf_kernel unconditionally, it seems
this would result in an undefined struct member error when the config is
turned off.

>  	default:
>  		return false;
>  	}

> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> index 495bb765de1b..5af13903287f 100644
> --- a/security/ipe/ipe.c
> +++ b/security/ipe/ipe.c
[ ... ]
> @@ -60,6 +70,10 @@ static struct security_hook_list ipe_hooks[] __ro_afte=
r_init =3D {
>  #ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
>  	LSM_HOOK_INIT(inode_setintegrity, ipe_inode_setintegrity),
>  #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
> +#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
> +	LSM_HOOK_INIT(bpf_prog_load_post_integrity, ipe_bpf_prog_load_post_inte=
grity),
> +	LSM_HOOK_INIT(bpf_prog_load, ipe_bpf_prog_load),
> +#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
>  };

Does this create a scenario where policies fail-open silently if
CONFIG_IPE_PROP_BPF_SIGNATURE is disabled?

> diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
> index 6fa5bebf8471..71f63de56616 100644
> --- a/security/ipe/policy_parser.c
> +++ b/security/ipe/policy_parser.c
[ ... ]
> @@ -237,6 +237,7 @@ static const match_table_t operation_tokens =3D {
>  	{IPE_OP_KEXEC_INITRAMFS,	"op=3DKEXEC_INITRAMFS"},
>  	{IPE_OP_POLICY,			"op=3DPOLICY"},
>  	{IPE_OP_X509,			"op=3DX509_CERT"},
> +	{IPE_OP_BPF_PROG_LOAD,		"op=3DBPF_PROG_LOAD"},
>  	{IPE_OP_INVALID,		NULL}
>  };

Because BPF_PROG_LOAD is added unconditionally to the parser, an administra=
tor
could load a policy containing "DEFAULT op=3DBPF_PROG_LOAD action=3DDENY"
successfully.

However, because the LSM hooks are not registered, IPE will never evaluate
BPF program loads. This results in all BPF loads being silently allowed,
which contradicts the loaded policy.

Could the parser be updated to reject BPF_PROG_LOAD rules when the
corresponding enforcement hooks are disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429191431.2345=
448-1-bboscaccy@linux.microsoft.com?part=3D10
