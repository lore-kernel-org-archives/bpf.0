Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD7320CD3
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272432; cv=none; b=Kt/6+o/gFsREDf8fFfr6LIePwNhvNbadYZ4SVkTBjeapTXxJ884K7/Lu7tPh1jUMRK9rpTWLeShTpIytqV61X+pr6Timx3AnUXbBsmKsDwpNIMShg3CsaoG66o8wp/1ClCZwNZQfW4SGNl7n55DlbTm5qAigdNR9hZlorbIIkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272432; c=relaxed/simple;
	bh=eePVeUqfT74CeSNKWnwOLAgS0vQUgHjYcXtO0uKmwkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ima0mTe/Ne4RB1L74WvklWZMHZUdrtrSm4dUMSiphkkn/GnoD+bQKUB04QqtFcsySVwXMi1NcyfH54RqB3ahgrcNRj6zMBQl2cFOXb9FaCa+sgVnkZ3lvwGE8oI3vbWhaT5WbNfY/BPO/WIVEaFiknvkLJw5kCw/nqgXrcXuwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu5mocb0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu5mocb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5ACC4CEF7;
	Wed, 11 Mar 2026 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773272431;
	bh=eePVeUqfT74CeSNKWnwOLAgS0vQUgHjYcXtO0uKmwkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iu5mocb047rq1bGOxxdMMLWdFFGAQe1R7yTTRW+oJVcvyf7vm+x54K71sqKogYma0
	 CiIua2pU8Ak/JKG47nRjYQV+T8kNrWP6pOHTuAQoUJVOyMAF0tOU/aTcPMbrEFqgk8
	 vZM78Jbwjq1CBiNyLLK3qmGdcGAjM+gd+CgLwa7nGqhXDhLBa1RrTUdRLrKW0JqcNW
	 o9AYXBO2BlyQS6UNbalyZGwjrWyrgZu2ADK7zvoC/WmjI1Xfqzi4s1+cMF6RLg6rCa
	 RP71zA0zNEURHk/RUuAGGWS9/fT0s2FWop8R9788bVQTWnxwj6Nb6xoIEFKGkDIWt+
	 xNiOLQIbGQATg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Verifier support for sleepable raw
 tracepoint programs
In-Reply-To: <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
 <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
Date: Wed, 11 Mar 2026 23:40:27 +0000
Message-ID: <m2h5qmj5p0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> writes:

> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add BPF_TRACE_RAW_TP to the set of tracing program attach types
> that can be loaded as sleepable in can_be_sleepable().
>
> Reject sleepable programs that target non-faultable tracepoints
> at load time in bpf_check_attach_target(), providing a clear
> verifier error message.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Puranjay Mohan <puranjay@kernel.org>

> ---
>  kernel/bpf/verifier.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8e4f69918693..95b33b85698f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -25216,6 +25216,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  		btp = bpf_get_raw_tracepoint(tname);
>  		if (!btp)
>  			return -EINVAL;
> +		if (prog->sleepable && !tracepoint_is_faultable(btp->tp)) {
> +			bpf_log(log, "Sleepable program cannot attach to non-faultable tracepoint %s\n",
> +				tname);
> +			bpf_put_raw_tracepoint(btp);
> +			return -EINVAL;
> +		}
>  		fname = kallsyms_lookup((unsigned long)btp->bpf_func, NULL, NULL, NULL,
>  					trace_symbol);
>  		bpf_put_raw_tracepoint(btp);
> @@ -25432,6 +25438,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
>  		case BPF_MODIFY_RETURN:
>  		case BPF_TRACE_ITER:
>  		case BPF_TRACE_FSESSION:
> +		case BPF_TRACE_RAW_TP:
>  			return true;
>  		default:
>  			return false;
> @@ -25461,7 +25468,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>  	}
>  
>  	if (prog->sleepable && !can_be_sleepable(prog)) {
> -		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
> +		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, struct_ops, and raw_tp programs can be sleepable\n");
>  		return -EINVAL;
>  	}
>  
>
> -- 
> 2.52.0
