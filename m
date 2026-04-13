Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E001D5AD4
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098172; cv=none; b=lg5hQIjp2qKKDU2/ZFQ59xDQpXAv4+z504cM8g5fpyWAiAUPmCuAmixSyI1sBI+CX41p1biQ/z1wGDnVBj+ifw6Ymoanf2occgH/jb72oXprEb8tw9mHKhvvbYcJDWc5dONmjEzzgdK4boBJ/rF1LkcJravQSg/pk4dvBw+240c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098172; c=relaxed/simple;
	bh=ZVSs1Q1Ca6aqWmwCaLZCX6QTUsOHWBEsX/rkDdXDHjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8uE+JRdI75jjsrHz6YhodXs0CkxSLTnKWERTEFf5x5dbWotGieJqFyZDXL0vxntuyeR8+QtFBcysbQW/55JeLIO3Icz8S63Kc/KuRqzXjyiioIgmf1/pktpeRYGOTaj87HlDu16nC2tVbL9VqNcIJUDMb3HwkOENTKeNBPvSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RNZ3EGHV; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RNZ3EGHV"
Message-ID: <26b3bb62-ca7b-4a1b-aec6-b5e779e2fc84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776098168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjvLwXEvfP1zSzKUp2Fqd77zPSu/0mjcpiEaIPUoU0w=;
	b=RNZ3EGHVErZcYQjES60y1Exqb6C0QQfEJP14MNBI5sFgnToDWGZv8SUCnVB/Omr7sdUi/c
	Ek7u8NOe/e2vmfBzaOO7ZhQtdPIgJrnepntm9MRasdhOoOUu3acqMk7Fu0U7+F1FsausTC
	+j4BvUicwFkk0Pdq3fX8wK7GNm2PI68=
Date: Mon, 13 Apr 2026 09:36:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 10/18] bpf: Fix interaction between stack
 argument PTR_TO_STACK and dead slot poisoning
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260412050000.262030-1-yonghong.song@linux.dev>
 <928fac5880ee0f617245a8cb45a88a00eb03fa2137e18fc8943a4505a3df50be@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <928fac5880ee0f617245a8cb45a88a00eb03fa2137e18fc8943a4505a3df50be@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/11/26 10:43 PM, bot+bpf-ci@kernel.org wrote:
> commit 7570556100592966981ed4784bb775307405e5f0
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Fix interaction between stack argument PTR_TO_STACK and dead slot poisoning
>
> This commit fixes a false rejection where the verifier rejects valid
> cross-frame stack reads because the static liveness pass cannot track
> indirect references through stack-argument-passed pointers, causing
> parent frame slots to be incorrectly poisoned.
>
> This patch fixes a bug introduced by an earlier commit in the same
> series but does not include a Fixes: tag. The issue is introduced
> when stack argument support is added, because BPF_REG_STACK_ARG_BASE
> (r12) is not tracked by the liveness pass. Without attribution, it
> is harder to identify the scope of the fix during bisection or
> stable backporting.
>
> Would it make sense to add:
>
>      Fixes: 442d7da1edaf ("bpf: Support stack arguments for bpf functions")

I will swap this patch vs. the previous patch to avoid bisection issue.
There is no need to have Fixes tag then.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635

