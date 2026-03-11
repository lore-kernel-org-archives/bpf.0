Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9036230BD9
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255198; cv=none; b=DviCwybOuTAOmpbwxtSvfJXNA5dVJ/YYH6XUc5q+AAZuC+V/6lgvzzNABUAEsDoScgQsO2Ae+5wzUZb7baQI0eOY7+Po1qw0nr8/U8/H+IfcSZtpXkZZa7ilT3f5FE4RASNEGiJGP5b0AdHAHG4bQpOQLul2b691OOkieCU9i0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255198; c=relaxed/simple;
	bh=cCCMY1fVMfJdGFcuCmoB5PJ4aRbJG7ZEVmDBBurx+Gw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BdQzAPuc2QlVoITjP7XxQ1Ugi6t67EEkJT44kdwpVHxquvI8mPq+1MbHefeFeJzDS3KcsM0rlJJw4ZBN66hXvDQ2zVV6tgo364ML2MmyXevqU4D0uKaufeh028yOd1wM3SMPW6bgV1tP0Pg/ZJdQXUamR/iKgPoTe/6GIrEX0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+FJcVNM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+FJcVNM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B2DC4CEF7;
	Wed, 11 Mar 2026 18:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773255197;
	bh=cCCMY1fVMfJdGFcuCmoB5PJ4aRbJG7ZEVmDBBurx+Gw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=q+FJcVNMktjxC7PZ+3tqXOIzwgRvsmWmPgdGlJ2CkHRC27G60sZgCiycxVI+Z54Oq
	 aLeYcKfK2OSuItrBv3FBmJ++tNii7wWfZxnVgbL5hA/GCwoxcG6Oh38jU20mLF8wX/
	 scVYoRNDnGhByUh5UfHX7lYmQiVusc2dWTuFtvdRXex4K4YGZSsRuzXL613kgTpGkB
	 EYHjZkmOnruYC8jtwf/yDsPChlZ4BCGmp6n7SXVDKvaQ8gTgoFiSlT2xPr+2rRb90S
	 EPSPK0DZARYOCYWNnnqKw2PCzsje5tvCaUSaG/NnEUxGkVrOYOzzBxj8XwjenHMUdA
	 7eMFrdGMmTyow==
Content-Type: multipart/mixed; boundary="===============8797009171284123211=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <26aec9bced7c1d13ca1d7bbe344485c2bdd7b85bcf4489cef17293f6e278528f@mail.kernel.org>
In-Reply-To: <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
References: <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Verifier support for sleepable raw tracepoint programs
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 11 Mar 2026 18:53:17 +0000 (UTC)

--===============8797009171284123211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -25435,6 +25441,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
>  		case BPF_MODIFY_RETURN:
>  		case BPF_TRACE_ITER:
>  		case BPF_TRACE_FSESSION:
> +		case BPF_TRACE_RAW_TP:
>  			return true;
>  		default:
>  			return false;
> @@ -25464,7 +25471,7 @@ struct bpf_attach_target_info tgt_info = {};
>  	}
>
>  	if (prog->sleepable && !can_be_sleepable(prog)) {
> -		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
> +		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, struct_ops, and raw_tp programs can be sleepable\n");

The updated error message adds raw_tp but still omits fsession,
which is listed in can_be_sleepable() just above. Should this
read "fentry/fexit/fmod_ret/fsession, lsm, iter, uprobe,
struct_ops, and raw_tp"?

>  		return -EINVAL;
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22968403755
--===============8797009171284123211==--
