Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206837;
	b=OXzvnKcs2szbTA6Ow79NWgg7NJ/IDJQykkrGT0SbcOivr4Y+l8ppXIUNbqUm0bxcHJek
	 8vX4l/v0lT2i0oymRagFM348saA7epJvnK5+DPVuPPqoBKzxvZ1hBevTEiff4DnPHmM2W
	 CtnzekRfDmgZwGvtZc9DEuSZYrN36HVw/0J93+ekQCo/FeECu/qfQgTxD8eVJUCiVzTBO
	 9MePA7SnXtQcQpGjeNL4wCy6OCSBfGGVn9lpxk5TFlF+Lz4MZhEJJNM4Ujf0uUbCALQ4w
	 VCJwsMYRU2TRFKcPJfvufhuQQ0bqPkx6h7At5VcqNQbPxeR+rF8OrtzzS2Q/BTeBLQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=n5NroT65/ceg4aQz6ziv+4l6Cu9nfFdwow8xq6Vbj+8=;
	b=5oB+QoTVjosKnfx444mtBDsaPTncc+GjFJZIYsM4lAi8MxLLSg5bqr2gw2mWlI5D0Zv0
	 JmT5EuGLiD8wUpf1/lG9d5gCltqrSuzsbwqyN5jLLLodXuosNcvPJ04iIp3s8PIp9YCtx
	 uvwk7e7C/uXDH96Usr4ARtxoxDhRnA2hMCeSQFbBDfCd5yhzU0F5E1JeQZfMJmT65G7H0
	 n8cqNSQUeZiKzRxjsJHLeXc4XiqCPm1BcDgja3RyLuYD1BIneAqVftltRXn6wMgRBpd/g
	 sb93Z2MzQU0OypyybRLH5AsmvN9k0S0rp2/yGfHFVZQ2NgEloZcdYDy3X3dppVdRT2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E2hUsea2;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA95606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 17:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FA95606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E2hUsea2
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso7361895e9.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206835; x=1793811635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5NroT65/ceg4aQz6ziv+4l6Cu9nfFdwow8xq6Vbj+8=;
        b=E2hUsea2LuSYRU4I7G1JbYmRhpRDwH471Lk8D6Ck5EjKQiTRTdeCeAzYNcjoLoOKQD
         LZUkpfAS7rOoPKC2Vg9BTUxRj7s40cIy+iiJtOSfjQjJhvzbzsWuP9cCXhvROOk0Ncha
         DHLTLXOHi9JUFrgUg7JdH30muChs9ghQAgDJgcUgr1GZaAI5J6ONsQ7Mrc98/X8KRrp1
         IZ/yBdOOC7fIIkF9UR9/wxOmedvPOFb+HBsIoRTL7m/Z75NVuMN5Wn8u09cJJIErWYTJ
         nFj0Q2OlfiBu33aYs/4K9qxkJONU9SxvnWtVCr9c/DrmoZVVIf5bkvocC+T+vW80nhtF
         ckAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206835; x=1793811635;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n5NroT65/ceg4aQz6ziv+4l6Cu9nfFdwow8xq6Vbj+8=;
        b=YbZzhhkBaLqtLMs6o6fQgtwalH9w8FsLLmjKma5hTcg3B3HRjgyK2HkZ4p8OVRmKW7
         yjp1hZvG/44Z+Mxr5YCQR7C3Ss/4AHYcl6bfxDSvV6RVXBrXhalpTsGjbofVQ6ms8xTR
         JbL8hhKjEOFI5UKL7Oh2VMqKl/owh3Kj1tHmHNG/60zQRsQaj7+PCvZbAWoWODVbQUSa
         DudO/xesWMxXkM++WX/WFrIe6J2J9kLF3TsdCPHckD72mv21eWjt4ODl9IsxOqNUkCOI
         8PJ6UYL/84dx7LSpo0R6oVGKq0EJ6UZgxfPkGPgFRPRh6x2lKft2N207WmdRe52royBY
         fvxw==
X-Forwarded-Encrypted: i=1; AKwUvByxB96qix7fK84KvVj6R0ncfrDHBUmisgDRwZE1Nsa3ANkXhMrzLvCL+247g/3YedjPimg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgnt/0Cz4equ3QXvO3Pn5SHHrmUjwPYotZX0QORTVRSniF0cVr
	tMaEasNYxqqhC29fD0D8r4uabmUjDV0hRPSd8mbjw7uMZIUhKnOlzShM
X-Gm-Gg: AYBFou1Sm3/TTiwVBHSiEi3qaLqyx2K/agB120FlVDX5ES+7xj89HTeUnyaNCtexKxi
	ljN3hIAhImTiST+DjVsmnxfFpyryPujMEm/HsYBF1x9b2E51LvWvo0kBlZv88+n2E3UmTzQEz6u
	C3b2LlmGY9yP0tp82DAzlf7wrxZNSGR6L4uH02tB7vhmumGTh/w/4N4jtvef8AP8AGH+FT+LC5P
	AvTOGOKuNh9nim8C37awejhfcPGB0SPsrLH30aYgoHmNJe8PLucirZ6KgcfkXWMAtPwzVp+f4xr
	gZpiyp/v0Pe1YM+0nPkRALO4SJ6Gi9ldro8bitiSW93fkLnh6iJg3+fDIXl5BHTq4Qz34zZ6UB5
	lrQgwayJjZ9twyReNfdYlRwpwqdf3YZoRbc1vJSeOBTiNNnCYU7KdwamhIZB6dMTJ+DZ41jbJpw
	KPmCq35QggBKhJaGH6bOVKkGyyybHYaRoqE/J3RVTg483TjHLvbhkonKTrTdXIbHUMA2JI70PcU
	Yc755BPkJs8HZyTOT08B1OCPA1K0ZDogb8qLJxRK6C44XQy6AlhT7PQYz7y0MAGRQC1gCClJjUF
	dQzs+udEGYUdDw2TeFDElsvMfMb/1DhLT9nILtwLvL0GWV8ReK4p19NuQSebdtG71D1o
X-Received: by 2002:a05:600c:8b28:b0:4a8:9a2f:d27 with SMTP id 5b1f17b1804b1-4a9672f91c6mr55353825e9.25.1793206834521;
        Wed, 28 Oct 2026 10:00:34 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:b155:8c68:f317:3997? ([2620:10d:c092:600::1:1503])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm29562988f8f.21.2026.10.28.10.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:00:34 -0700 (PDT)
Message-ID: <6a6a2500-6f9c-46f9-bf09-05961d8fc53c@gmail.com>
Date: Wed, 28 Oct 2026 17:00:31 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] bpf: Fix task work use-after-free on
 deletion
To: Yun Lu <luyun_611@163.com>, bpf@vger.kernel.org
Cc: Yun Lu <luyun@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko
 <yatsenko@meta.com>, Shuah Khan <shuah@kernel.org>
References: <20261028073525.1035605-1-luyun_611@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20261028073525.1035605-1-luyun_611@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/26 7:35 AM, Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> This series fixes a task-work use-after-free when a BPF program schedules
> through a map value pointer retained across deletion. Review of the
> earlier task-work series [1] pointed out that cancellation can leave
> the deleted value open to context reinitialization.
> 
> The original reader keeps the element alive while it queues new work,
> but that does not make the new callback part of the grace period freeing
> the element. If the callback enters RUNNING outside that waiting set, the
> final destructor cannot stop it from accessing the freed key or value.
> Patch 1 includes an allowed interleaving and a KASAN stack excerpt from a
> controlled reproducer on the base unfixed kernel.
> 
> Patch 1 retires task-work slots before non-preallocated HASH/RHASH storage
> is returned to the allocator, including abandoned RHASH candidates. It
> also orders ordinary cancellation as FREED, conditional unpublish, then
> map-owned reference disposal. Existing callback read-side protection and
> element grace periods provide the lifetime guarantee.
> 
> Patch 2 adds 24 selftests for the retirement gate and compatibility: both
> notification modes, live updates, and last-user-reference cleanup followed
> by reopening the map by ID. Its callback only counts deliveries, allowing
> an unfixed-kernel comparison without deliberately dereferencing freed
> storage.
> 
> This is a separate series from the captured-task and irq_work BUSY fixes.
> It is based on bpf-next commit 7c3188f84b54, which contains those fixes.
> 
> Testing on x86-64 QEMU/KVM:
> 
> - Same test_progs binary on both kernels, with KASAN, PROVE_LOCKING and
>   PROVE_RCU: the unfixed kernel fails exactly the six retirement
>   return-value assertions and passes the other 18 cases; the fixed
>   kernel passes all 24, with no skips.
> - An out-of-tree reproducer triggers the native KASAN report quoted in
>   patch 1 on the unfixed kernel on every tested boot; on the fixed kernel
>   the stale-pointer schedule is rejected with -ENOENT and no report
>   occurs.

It looks like this problem should affect wq and timers (I did not validate though).
The change looks very invasive, especially if we take wq and timers into 
consideration.
We rejected poisoning of the special fields before
https://lore.kernel.org/all/20260216131341.1285427-1-mykyta.yatsenko5@gmail.com/
Maybe this time we should fix it in the allocator as well?

> 
> [1] https://lore.kernel.org/all/20261012061915.231254-1-luyun_611@163.com/
> 
> Yun Lu (2):
>   bpf: Retire task work before reclaiming hash elements
>   selftests/bpf: Check task work scheduling on retired values
> 
>  include/linux/bpf.h                           |   2 +
>  kernel/bpf/hashtab.c                          |   7 +
>  kernel/bpf/helpers.c                          |  80 +++++-
>  .../bpf/prog_tests/task_work_retire.c         | 240 ++++++++++++++++++
>  .../selftests/bpf/progs/task_work_retire.c    |  84 ++++++
>  5 files changed, 403 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_work_retire.c
>  create mode 100644 tools/testing/selftests/bpf/progs/task_work_retire.c
> 
> 
> base-commit: 7c3188f84b54d8e7643f6ec8454824df2823ba73

