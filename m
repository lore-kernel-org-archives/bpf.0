Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCD334C09
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432795; cv=none; b=uS6MLt8wpew22Q5p4crNZFYbi+OMfzc15P5HF76jWNhR/1gWpTaX7Aoc1m3l8qBuJPUC80bJysBOiF1alv/u6SWpTnzacx2P2Zbvt83tONayUHY1Sid091Sav2qmn32Sgn8C4R9L3v1cspfPCknN4kQsTXhTUbH4sOvblPMdr7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432795; c=relaxed/simple;
	bh=NlSDiJr33ehDGjxJ09xDjQU0T4fFY34dpbKtaNGgyvc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tcwbm4urte2O3OpkMgYEgUDF/YMnw8MzzPWsEnpVEWdbk8CBe9MsFe23ecSqta6WkjlSdE/cuT0f4WAz6ZU9v8ar8MvYsP/mkFOsTf9nC8VIk9JPIvPqPkbuL6HT+l0o0VThDsjEI13ntthhIt0XwK3RwjrGkGyZv/GZOfGRKDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVXvYOxL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVXvYOxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486F7C116D0;
	Wed, 18 Feb 2026 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771432795;
	bh=NlSDiJr33ehDGjxJ09xDjQU0T4fFY34dpbKtaNGgyvc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gVXvYOxLG9V3Ymzf2gnQy+wgv/IlSNIk3r0F6nDSc1lccMlGI7mnME/PWnhNiVVOQ
	 kRBCU4rcOhqOsBAjbzy/WapxGDKA6Iq2pPDNyzn+cT2T4pueK0stF8cwkFNgGUuEhP
	 4Fl/GAJ4H7BwrudMYVPS9jbqaQmHlWDg/ZZyO7H/zNZXtgy+eEz2Oe2TIHeW05Te4F
	 AqhWHekl2p5ZVec6KsJn8uYvPh0esOdxALc11e3Z9PJATvm245XPhM7vLabvgWCZaK
	 ZdNBLZoryqHKe2R3DkOtZGE7Pxf8CKGwYelZcSAwVwf5HOdEt/s662GQm8c1WtRS53
	 tSYZTaTFF8yjA==
Content-Type: multipart/mixed; boundary="===============4635727485845967774=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <93d3beffa6257d070935d2e2d6be55a32dcc6a33e6b22ab393c4085167cdb7f3@mail.kernel.org>
In-Reply-To: <20260218-sleepable_tracepoints-v1-1-ec2705497208@meta.com>
References: <20260218-sleepable_tracepoints-v1-1-ec2705497208@meta.com>
Subject: Re: [PATCH RFC bpf-next 1/6] bpf: Allow sleepable programs for BPF_TRACE_RAW_TP attach type
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,ameryhung@gmail.com,puranjay@kernel.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 18 Feb 2026 16:39:55 +0000 (UTC)

--===============4635727485845967774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0162f946032f..1973184306e4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -25186,6 +25186,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
>  		case BPF_MODIFY_RETURN:
>  		case BPF_TRACE_ITER:
>  		case BPF_TRACE_FSESSION:
> +		case BPF_TRACE_RAW_TP:
>  			return true;
>  		default:
>  			return false;

With this change, a sleepable BPF_TRACE_RAW_TP program can be loaded
and then attached to any raw tracepoint, including non-faultable ones,
because bpf_raw_tp_link_attach() does not check whether the target
tracepoint is faultable when prog->sleepable is set.

The verifier sets in_sleepable based on prog->sleepable, so sleepable
helpers like bpf_copy_from_user() would be allowed. At runtime, the
dispatch goes through __bpf_trace_run() in kernel/trace/bpf_trace.c:

    cant_sleep();
    ...
    rcu_read_lock();
    (void) bpf_prog_run(prog, args);
    rcu_read_unlock();

If the program calls a sleepable helper here, would that result in
sleeping in atomic context?

This appears to be addressed by patch 2/6 of this series on lore
("bpf: Reject sleepable raw_tp programs on non-faultable tracepoints")
which adds the missing attach-time check, but that patch is not present
in this tree.

> @@ -25215,7 +25216,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22147696553

AI-authorship-score: low
AI-authorship-explanation: Small, targeted change with natural technical language consistent with domain expertise; no markers of AI generation.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Sleepable BPF program can attach to non-faultable tracepoint and sleep in atomic context due to missing attach-time enforcement; fix exists in series patch 2/6 but is not present in this tree.

--===============4635727485845967774==--
