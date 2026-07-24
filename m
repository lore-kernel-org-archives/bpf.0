Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776A37BE63
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924427; cv=none; b=raQAD4cshYx/HySl3RR+/xdkn1NByVtZpCcui+ijvPvHTrI0x71JERoGAmH7shkwq5xE7+8P+3m6ynohLOmgyPGNu35AyNrOvEHO3yuacoKccsQdzygT32lQ6QLXnolgSVwYPwNIkayKpmWYlaElPIWCvI7My5nfugAfQBSKxtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924427; c=relaxed/simple;
	bh=aqk0nRDaJYYSoo7DY5/PaKov2S1O+SFJo+jTP4cNsh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PehmPEO2PR7nUR12tsY/qz76FZMY0KQ/I/gdF/9oVWt8+XgyxtvjHwmL1h74JXJh+ksT8xGbLsTIzQfm70BjSe+alY2pMm/0Cspk0L05Wzh5KmTpqLIvQuIwQnInEcIGnfcM3rHuQ4ii3JMhodufs5P9PpvxZiR7cPxNkXVxmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ftt0i8C2; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ftt0i8C2"
Message-ID: <d4f34e9c-5bb6-4011-903b-70a0f6005901@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784924421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FoCtdI4UaVVOccypj8I/i+MzPn2uw5myRnK0ojI8nPE=;
	b=ftt0i8C20O69R7wJRucDQL0+OF2+SBu99kPf7qbQWgoZL7Czth2bjFew5DVziBv5b7Cq3X
	Pt6nDheIYs8WAcir0Phq4xFVCVPQ+/BuYQx3Ip3x99io9zkEoEqBkw5uq3v3kmttyktXLP
	ZviTWGc7zx/SuC5CqPyJbO2NPNadlPA=
Date: Fri, 24 Jul 2026 13:20:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/9] bpf: Disable preemption in stack map code
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>,
 Tao Chen <chen.dylane@linux.dev>, STAR Labs SG <info@starlabs.sg>
References: <20260720085351.655075-1-jolsa@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260720085351.655075-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026-07-20 1:53 a.m., Jiri Olsa wrote:
> hi,
> we need to disable preemption for get_perf_callchain and keep it disabled
> as long as we are accessing its returned trace entries buffer.
> 
> This patchset refactors both bpf_get_stack and bpf_get_stackid helpers as
> suggested by Andrii [1] before applying the actual preemption fix.
> 
> Note the initial fix was sent by Tao Chen [2], but there was no follow up
> on this since February, hence this post.
> 
> thanks,
> jirka
> 
> 
> [1] https://lore.kernel.org/bpf/CAEf4BzZwvAUgLwz-M0Y_NJLTmedyY9U6s7LrSmn751hQdTP4Uw@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@linux.dev/
> ---
> Daniel Borkmann (1):
>        bpf: Disable preemption in __bpf_get_stack
> 
> Jiri Olsa (8):
>        bpf: Factor stackid_init function from __bpf_get_stackid
>        bpf: Factor stackid_fastpath function from __bpf_get_stackid
>        bpf: Factor stackid_new_bucket from __bpf_get_stackid
>        bpf: Use stack id functions instead of __bpf_get_stackid
>        bpf: Disable preemption in bpf_get_stackid
>        bpf: Factor callchain_store function from __bpf_get_stack
>        bpf: Factor callchain_finalize function from __bpf_get_stack
>        bpf: Remove trace_in argument from __bpf_get_stack

Hi Jiri.

It took me some effort to wrap my head around the problem, but with
that the refactoring and the fix make sense overall.

I think there is one blocker which was flagged by sashiko and should
be simple to fix. Sending details on patch #9 in a bit.

Thank you for picking this up!


> 
>   kernel/bpf/stackmap.c | 292 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------
>   1 file changed, 198 insertions(+), 94 deletions(-)

