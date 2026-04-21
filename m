Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9A383C70
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776741797; cv=none; b=dOWGUB+1lB8E38Pa/hGhQXAmrUQ1tU26VCHb3VbO+3ovkOnjCIMV33Z3oAQU2V54ojDC335rX1xJALFfhPl5w2Ujvyu/NBThCuo2xU9qEsVgPAsc/CU2X5TWHB2qz38zY3AJzRKViu2HoSYfaDpVuX6T0XzLLj4lReecDaN8rL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776741797; c=relaxed/simple;
	bh=/Op4bqrwzPQUnu10bVS1K0p2V4C0ThrEiVUR/+IoIeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RHJUEfDzdN5tax1Urc/qsjCH5G/LvBgx6CW7GKvPfC7+8/CEmNbdSI65rH92s3D6xnYuHvEenNk8RIx+PWR9jWsEYdClRy1szwPIkupei7+cXgVjdGLctXuYcGWpHWFf5Uu1O3hsf7ViwjBEhmlIvaNg3DeC2EAoPDO3LqluHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsEIb1Sq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsEIb1Sq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37923C2BCB3;
	Tue, 21 Apr 2026 03:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776741797;
	bh=/Op4bqrwzPQUnu10bVS1K0p2V4C0ThrEiVUR/+IoIeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BsEIb1SqmRcle/fvtU+GEuAj7Tt9QCFnas90dx/4exPGYY630MTI0hjjhgdvBfLmb
	 0prE0jhz2EwJlwF4fCRIX29ecmFh/ndz9PBkGjWDJwDpqPEu3mpS9gVrcsESOh6VIh
	 Hc+QvExt+wOSsVx/uStmJRWa92CoHx1gy1li6yzxvIibxA8tuDYpNc76+JogJAB3Tp
	 algNVBz7QPj+XBLq6+3C1uwPCgDgNF2lw4wtI3YSQSFz8LxcpoTDLmVM0n1hxo5F6t
	 /WFpQHTjByyQuxZaBFnziBz5FFv4ja7UQNJp3skfdb2ZgJFRw4Sd1pEsCMfEVPp9dY
	 CzjGwY7pk7gBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/10] ipe: Add BPF program load policy enforcement
 via Hornet integration
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420212653.438685-11-bboscaccy@linux.microsoft.com>
References: <20260420212653.438685-11-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 03:23:16 +0000
Message-Id: <20260421032317.37923C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Compilation failure in `evaluate_property()` when `CONFIG_IPE_PROP_=
BPF_SIGNATURE` is disabled due to unconditional access to `ctx->bpf_kernel`.
--

commit f674a6cd60a4a820baf0e01920f42c00f9ad8225
Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

ipe: Add BPF program load policy enforcement via Hornet integration

Add support for the bpf_prog_load_post_integrity LSM hook, enabling IPE
to make policy decisions about BPF program loading based on integrity
verdicts provided by the Hornet LSM.

> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> index 21439c5be3364..9a6d583fea125 100644
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
> +	case IPE_PROP_BPF_SIG_OK:
> +		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_OK);
> +	case IPE_PROP_BPF_SIG_UNSIGNED:
> +		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_UNSIGNED);
> +	case IPE_PROP_BPF_SIG_PARTIALSIG:
> +		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_PARTIALSIG);
> +	case IPE_PROP_BPF_SIG_UNKNOWNKEY:
> +		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_UNKNOWNKEY);
> +	case IPE_PROP_BPF_SIG_UNEXPECTED:
> +		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_UNEXPECTED);
> +	case IPE_PROP_BPF_SIG_FAULT:
> +		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_FAULT);
> +	case IPE_PROP_BPF_SIG_BADSIG:
> +		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_BADSIG);
> +	case IPE_PROP_BPF_KEYRING_BUILTIN:
> +		return evaluate_bpf_keyring(ctx, 0);
> +	case IPE_PROP_BPF_KEYRING_SECONDARY:
> +		return evaluate_bpf_keyring(ctx, (s32)(unsigned long)VERIFY_USE_SECOND=
ARY_KEYRING);
> +	case IPE_PROP_BPF_KEYRING_PLATFORM:
> +		return evaluate_bpf_keyring(ctx, (s32)(unsigned long)VERIFY_USE_PLATFO=
RM_KEYRING);
> +	case IPE_PROP_BPF_KERNEL_FALSE:
> +		return !ctx->bpf_kernel;
> +	case IPE_PROP_BPF_KERNEL_TRUE:
> +		return ctx->bpf_kernel;

Will this cause a build failure when CONFIG_IPE_PROP_BPF_SIGNATURE is disab=
led?

In security/ipe/eval.h, the bpf_kernel field in struct ipe_eval_ctx is
protected by #ifdef CONFIG_IPE_PROP_BPF_SIGNATURE:

struct ipe_eval_ctx {
...
#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
	enum lsm_integrity_verdict bpf_verdict;
	s32 bpf_keyring_id;
	bool bpf_kernel;
#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
};

However, evaluate_property() unconditionally accesses ctx->bpf_kernel for
IPE_PROP_BPF_KERNEL_FALSE and IPE_PROP_BPF_KERNEL_TRUE. If the kernel is
configured without CONFIG_IPE_PROP_BPF_SIGNATURE (for example, if
CONFIG_SECURITY_HORNET is disabled), it appears the build will fail due to
the missing struct member.

>  	default:
>  		return false;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420212653.4386=
85-1-bboscaccy@linux.microsoft.com?part=3D10
