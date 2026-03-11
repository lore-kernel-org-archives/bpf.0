Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B413A9D9F
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214231; cv=pass; b=P1JeGjfzFaIKOX+6JfbOTt5DuaFW7uoYULhD0JCe2SAhtfBK8mmQ1etXSfYGK95vyAKAboyBv+OVnl5lGqmCrWaj8XV2959zyPfD1deIihfA+rQMj0kwjoZ5lr6on4FjIPMFbHALc+EKUWToiw23ICgD9SwRoVGbO5beM2cXlNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214231; c=relaxed/simple;
	bh=H8/FiWaNGhJJte5rWNMs/F/MZA0wC/V1eA9sTWnkG2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avvHFUrl0OFH0hbPxpJ64ffmLWtrlWktEMSnU1qtzs6O6aJFzAy0lyl3CRGfBunGnDcnQQS/aXUOtFkVWynakA2vX/C2ARbx42GzgtOsln1VkTEMZInIxO4TAvKtrJ7lAYELtlyUPh+QLb8eDomkiKKGplhSX2AuplJNnjlTOgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbLShmpl; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbLShmpl"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50906a98ffeso452991cf.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 00:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773214222; cv=none;
        d=google.com; s=arc-20240605;
        b=G/3Czq667ks0UzdKC4UrAb11/aCEFxe9D2l6B07ECtIlSkvCYqUfB5TPaPhA7pV2hb
         f45tJH7ulgaFliVNV1Hnpf2W8nu2SLQQGT7JU14rW+Jsgm4MO5pZKDHB5jCIRQT+j42S
         dDJ+qNhPL6Nf0qjMK1YwpQ29iQNQr2d/fAB9iRCCEblpLRzS3jxQInnPWDY41wJIx7te
         HEk3nfptMGa9UQ1a4zzbVF5Fq/l5NOF4nowi+nOIU9Glgoae7aO15sYC+ayXNrx+LQjh
         bI9KaDrB66vXmfilVUlaTs2KxsJbM3JYKWOKh/1y2XZjxkbXxaqtar/5AKqM7C4gcOIP
         LVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t31ZXnqtqcleggzMvKNbvy7pSVYvoYusm5tH26uIFr4=;
        fh=Zu/o8Lv9FPwoRPhS04gQAPbJgmWHGbnefd2N94E+/hI=;
        b=SRVLq0FI8Tnbt4B6Rvjw9FaCCRmbFJeKgXsal4RSwAIqLjkEE7HgRmzDZcHR3IZTQD
         Zi9HMtBz/EsFrmM2yYPsNEpSFNIRGBC3L+CFLBwtYIyjCgqyXl+J1G91HYIOoqHdcuNz
         uJ6k8VEdubvcycyLE0sNeaR1RbnDEj1W+9pQTwyCyHQbZlqsknkkAJRPCeNsTKXzvOzA
         cMt3Q+XxuTWTOmMyIZHrKsFxWck6ymt0JepaRRim2yZIKB6lQTzUiIuAcaq1/+xED04W
         1jptLTMzgvDL1MVe8LZQpwk2ufQRmeD/8vJKsrxCfInthtTUwNovADSInvUjAHjCPCx4
         nHsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773214222; x=1773819022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t31ZXnqtqcleggzMvKNbvy7pSVYvoYusm5tH26uIFr4=;
        b=KbLShmplwiha/FzLifctIBBoG019l3Yl37d1kJSPr9s6o39bQj4ccd9FkDxzxJ714R
         2Kd2QGbCf5YGGJl8jP4F6cIqQaZIgyUzUmQnwzX6MX1M9MlCAow+s67yhxeRkMTWKrLw
         1+ugDr7/frHSNzUas9EcoBOilzo41qXY8rs46arWV4TcKxtNlOfy6BKEMYq/Iiu91OZ5
         OMKMwceKCU5yal1USiAecPLFkGtr4sK1Q1ABeZew4bp6rnzQYhNecqAjmcMXI4xBzbO9
         +kt3tPebyKJaFPwVOlHjCpMbndAQbMByylLK6hqOIx8F8byQJbpr6s/Y03ZBTltmva5k
         M8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773214222; x=1773819022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t31ZXnqtqcleggzMvKNbvy7pSVYvoYusm5tH26uIFr4=;
        b=bhcXNAtZFi48dU7HDC+6DtjJuPsPnEGBreLKRQLDwqhC/sGkP06Os7Z/k+OyxnSEdF
         A9k7figGvmpppbdrlOUTw0raXlj2jEvRGuvPAv7SGSKUL+BMoEaN4wOlbr03pgkjKiv2
         wM8FJyUzzYWPi63omYYv3f1JEEyV1QY41B0RaRF6KtpTxXQhG/Vx1TGQCyfyZWKhosFL
         qLtA/hhDNy1d17NTW9zBkL11BxQLf7+5zMJ3gu0O83J4TXdmem8KpumMMn8zEdQgNML0
         ascYyKCtkugc/okFNIykxK0lta31b0rHfceYY/35kr7fXH/p3E5qlIa6ELxTbsDzW/fB
         Xjyw==
X-Forwarded-Encrypted: i=1; AJvYcCXNDJPf0ryWCz2ZFxRd0py+Xj+1ZRc/aq4b4TzXALoAFa2kO2Y140UDiGHPE7bTNmc43Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMRBg81Y8089ZWdpgjsJOQHE8AsKmC1fGtq03R7hMIHuUKFNwn
	m1Dr4EAB23hyFE0fWmprMMOGrFkSsoBOgdUR0DT9SLQpsd/f6iaH+4PYg9AUssUFSDYVSL62OB7
	qit6zIZy5lI1T4QIFFElD/zOQI/7TPDu4N37U6ZLh
X-Gm-Gg: ATEYQzznxfVvKZrWRvZWzz0GOPLw/U7YSYKh5BNN8+qKxXqB4DNNg9NEwry3UHQpXRp
	nDApmXjGNdPznWfK1dt+K74ZXGF0/pZXiByI759DiVy4Jdl0zlEjBMhDErI6MwFQu/oC5i6Ml6G
	iyelC8Yn5uK4JXeuun1t9zRaQ6JEOSHS/BzJv/c/OWexxNa1B7XOKZ19AoF17jnKrzw45uNUuch
	nM1VqrrL0BdzazMfiZN+UzXAuGLEgeaZH2M/i9TggVM0nwUGiOzM9miG0z3yM7ySZCiMZs03NnM
	dncJI9s75Vlik4kSXKa3Rbt+NlUbuq/9V6DiKy/M+vvmXnVUsw==
X-Received: by 2002:ac8:7dcc:0:b0:506:a3c8:d44d with SMTP id
 d75a77b69052e-50939a11387mr7655101cf.9.1773214221216; Wed, 11 Mar 2026
 00:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307182424.2889780-1-shakeel.butt@linux.dev>
In-Reply-To: <20260307182424.2889780-1-shakeel.butt@linux.dev>
From: Greg Thelen <gthelen@google.com>
Date: Wed, 11 Mar 2026 00:29:45 -0700
X-Gm-Features: AaiRm52ewDXuj78L5TdgZnsKsJPibJbmvYXCb1R6-Es0rphZaXLYpR2TicuVGA0
Message-ID: <CAHH2K0ZBJV1peAZVZC9Lm=rFRzSfxsvbrxRjyB=+0xkHGRcdLA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Alexei Starovoitov <ast@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hui Zhu <hui.zhu@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, Muchun Song <muchun.song@linux.dev>, 
	Geliang Tang <geliang@kernel.org>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, 
	Emil Tsalapatis <emil@etsalapatis.com>, David Rientjes <rientjes@google.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 10:24=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Over the last couple of weeks, I have been brainstorming on how I would g=
o
> about redesigning memcg, taking inspiration from sched_ext and bpfoom, wi=
th a
> focus on existing challenges and issues. This proposal outlines the high-=
level
> direction. Followup emails and patch series will cover and brainstorm the
> mechanisms (of course BPF) to achieve these goals.
>
> Memory cgroups provide memory accounting and the ability to control memor=
y usage
> of workloads through two categories of limits. Throttling limits (memory.=
max and
> memory.high) cap memory consumption. Protection limits (memory.min and
> memory.low) shield a workload's memory from reclaim under external memory
> pressure.
>
> Challenges
> ----------
>
> - Workload owners rarely know their actual memory requirements, leading t=
o
>   overprovisioned limits, lower utilization, and higher infrastructure co=
sts.
>
> - Throttling limit enforcement is synchronous in the allocating task's co=
ntext,
>   which can stall latency-sensitive threads.
>
> - The stalled thread may hold shared locks, causing priority inversion --=
 all
>   waiters are blocked regardless of their priority.
>
> - Enforcement is indiscriminate -- there is no way to distinguish a
>   performance-critical or latency-critical allocator from a latency-toler=
ant
>   one.
>
> - Protection limits assume static working sets size, forcing owners to ei=
ther
>   overprovision or build complex userspace infrastructure to dynamically =
adjust
>   them.
>
> Feature Wishlist
> ----------------
>
> Here is the list of features and capabilities I want to enable in the
> redesigned memcg limit enforcement world.
>
> Per-Memcg Background Reclaim
>
> In the new memcg world, with the goal of (mostly) eliminating direct sync=
hronous
> reclaim for limit enforcement, provide per-memcg background reclaimers wh=
ich can
> scale across CPUs with the allocation rate.
>
> Lock-Aware Throttling
>
> The ability to avoid throttling an allocating task that is holding locks,=
 to
> prevent priority inversion. In Meta's fleet, we have observed lock holder=
s stuck
> in memcg reclaim, blocking all waiters regardless of their priority or
> criticality.
>
> Thread-Level Throttling Control
>
> Workloads should be able to indicate at the thread level which threads ca=
n be
> synchronously throttled and which cannot. For example, while experimentin=
g with
> sched_ext, we drastically improved the performance of AI training workloa=
ds by
> prioritizing threads interacting with the GPU. Similarly, applications ca=
n
> identify the threads or thread pools on their performance-critical paths =
and
> the memcg enforcement mechanism should not throttle them.
>
> Combined Memory and Swap Limits
>
> Some users (Google actually) need the ability to enforce limits based on
> combined memory and swap usage, similar to cgroup v1's memsw limit, provi=
ding a
> ceiling on total memory commitment rather than treating memory and swap
> independently.
>
> Dynamic Protection Limits
>
> Rather than static protection limits, the kernel should support defining
> protection based on the actual working set of the workload, leveraging si=
gnals
> such as working set estimation, PSI, refault rates, or a combination ther=
eof to
> automatically adapt to the workload's current memory needs.
>
> Shared Memory Semantics
>
> With more flexibility in limit enforcement, the kernel should be able to
> account for memory shared between workloads (cgroups) during enforcement.
> Today, enforcement only looks at each workload's memory usage independent=
ly.
> Sensible shared memory semantics would allow the enforcer to consider
> cross-cgroup sharing when making reclaim and throttling decisions.
>
> Memory Tiering
>
> With a flexible limit enforcement mechanism, the kernel can balance memor=
y
> usage of different workloads across memory tiers based on their performan=
ce
> requirements. Tier accounting and hotness tracking are orthogonal, but th=
e
> decisions of when and how to balance memory between tiers should be handl=
ed by
> the enforcer.
>
> Collaborative Load Shedding
>
> Many workloads communicate with an external entity for load balancing and=
 rely
> on their own usage metrics like RSS or memory pressure to signal whether =
they
> can accept more or less work. This is guesswork. Instead of the
> workload guessing, the limit enforcer -- which is actually managing the
> workload's memory usage -- should be able to communicate available headro=
om or
> request the workload to shed load or reduce memory usage. This collaborat=
ive
> load shedding mechanism would allow workloads to make informed decisions =
rather
> than reacting to coarse signals.
>
> Cross-Subsystem Collaboration
>
> Finally, the limit enforcement mechanism should collaborate with the CPU
> scheduler and other subsystems that can release memory. For example, dirt=
y
> memory is not reclaimable and the memory subsystem wakes up flushers to t=
rigger
> writeback. However, flushers need CPU to run -- asking the CPU scheduler =
to
> prioritize them ensures the kernel does not lack reclaimable memory under
> stressful conditions. Similarly, some subsystems free memory through work=
queues
> or RCU callbacks. While this may seem orthogonal to limit enforcement, we=
 can
> definitely take advantage by having visibility into these situations.
>
> Putting It All Together
> -----------------------
>
> To illustrate the end goal, here is an example of the scenario I want to
> enable. Suppose there is an AI agent controlling the resources of a host.=
 I
> should be able to provide the following policy and everything should work=
 out
> of the box:
>
> Policy: "keep system-level memory utilization below 95 percent;
> avoid priority inversions by not throttling allocators holding locks; tri=
m each
> workload's usage to its working set without regressing its relevant perfo=
rmance
> metrics; collaborate with workloads on load shedding and memory trimming
> decisions; and under extreme memory pressure, collaborate with the OOM ki=
ller
> and the central job scheduler to kill and clean up a workload."
>
> Initially I added this example for fun, but from [1] it seems like there =
is a
> real need to enable such capabilities.
>
> [1] https://arxiv.org/abs/2602.09345
>

Very interesting set of topics. A few more come to mind.

I've wondered about preallocating memory or guaranteeing access to
physical memory for a job. Memcg has max limits and min protections,
but no preallocation (i.e. no conceptual memcg free list). So if a job
is configured with 1GB min workingset protection that only ensures 1GB
won't be reclaimed, not that 1GB can be allocated in a reasonable
amount of time. This isn't just a job startup problem: if a page is
freed with MADV_DONTNEED a subsequent pgfault may require a lot of
time to handle, even if usage is below min.

Initial allocation policies are controlled by mempolicy/cpuset. Should
we continue to keep allocation policies and resource accounting
separate? It's a little strange that memcg can (1) cap max usage of
tier X memory, and (2) provide minimum protection for tier X usage,
but has no influence on where memory is initially allocated?
