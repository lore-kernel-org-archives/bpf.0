Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E705B5AB
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109033; cv=none; b=Hie4iIXoMNZgCsawgcPzzCe42ZoZwwUrAXWFqRZFRiNrsJs0+wynydMcS6aMI4IMNVyiWLDD4Rj/5MNbafDTo34dmWlGLJxPSOVDQ20y8Y5VaZ4XQZ0EuzVRy/KkrpmHkBnagW02IhsrYrj86Ip9zCa1bSyllPFarfUECSqkKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109033; c=relaxed/simple;
	bh=jDkWU8QkAC0vx4BluRuIGb8C2/bONJeSNmXgD/FbM9g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=KQY1XqQD47NgpLoEOn+e5zPhVpM1XKRjqfoYCG2NAXmZGFuEGwEHBAx2fUYtP8yTwLRxn8RnSNwcAN29YZFUPAaOkZwrcwp3ysWmGJ1B2kVvuhWLgomEWflMnSTEgFgAzoa/aYx7Pj52zzcA4/xsVQUncMYVKEczsKDgKR5sYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gZ9NCwxN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="gZ9NCwxN"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so859834f8f.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792109030; x=1792713830; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QoKDWc8PB1daw2sSeHA2JLSXF3S7HT1p0XJArfChWUw=;
        b=gZ9NCwxNvTce180ahChiOGzAtzzXxgknClKPE+KPEOgZN7qEpgUI7qLYXh0wDwe57O
         UmIR2jlTj2JRDMQ/wLB5dqPGVLHswQRtLgNDjC8GcbaleLao1dLeZhoBFNt4NSS/UgPR
         lEYFbtEHZnxL466BxSX5Alcv14jorlH/a6piDZNOdy3/hhaRR4JrxhdB7iwpLIa475Qe
         lj1TM7moM9b+/8d6IHhPj0Mp2pJMgz2eI0GVmpRI+gAZkQt7ueqYFC5dhj2oNcxCTYAC
         rzL+9rp7QDnG440msNMiJIOrMZ0DvFkbg0jG/e0XNK/F2LQnPj0eAb93mYPPCUwIU9mD
         3XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792109030; x=1792713830;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QoKDWc8PB1daw2sSeHA2JLSXF3S7HT1p0XJArfChWUw=;
        b=U3AeRPJQgwqhqZ3Y8GEa2jQwtIPSgBmyNjm3xMyqFywgRHp97a2EjmX0dP9UFez89M
         StwrLyE7bXf2Ve7FI4P71pV+/28hPyK6ul5j2kClfr37xyFuqN578zIxdEJFu+BIm0AQ
         pm1ZlnU7eoBGeywuB6XzLIbN0ZJgXlhq28SCl5fQbNG87+wPAyRDGz/mb+cGGq7A2/Xo
         Guvonyx62buq2VDOiS1OZ/aQxwS7UXxzRQ8bz3NsaqpED+od0lrx4Tx5pSjHFVLsXp2P
         RZzgjO8GhlAHxXymtWpVrbjQMgTj++4oZ0CCkUPhi0gB26zf7cgW7KyDyAjoND/pleZt
         Kvsw==
X-Forwarded-Encrypted: i=1; AKwUvByv5MjfDY2W0GpV80D9YL0adUwTUAqPqv0LTlIhNZbRrYX5TrAVfXaAL3b6WdlAH9uicYo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLa0N2oKtG3OvVj4qNqbGnunOg4b32JZKF67x/EhjuYRGSBgg9/
	HC9pEacaerDqqscA0jOAqyimtMQ3rmQB21lI/bHwlgvE0jBaxFt5Aw39cSX+CVriohM=
X-Gm-Gg: AYBFou05lVZ1U/i7HqO81fNTLE38C6Rx9BF7yY3Vg52qEyQad1bSn8ZKKNfNjj/Kym3
	L97v+aodHACn9tne0P+qZsrw3k03wk9oUFzKRy96PMY6+OBpGNYYOe6SjVr3Z+/3mCXtXRxgC01
	xYrZRQljfVWwUnYVzgdLf5c84efBmwy55d8AORU3CQEkGxl+VQ3ttzrv1iT9TVmUTh9DQmbQBjH
	LNg/ZMXK9YQscLy1s9p3id5Hf+0j67K/wZU21fPUGvgJYbaIDMoavmJt2LWn1k/AUezZ+DqVCWf
	jWa60RTSaJOyMpC6pB5dKdTeLQIn8ODbQDeQ8H4VDGYme+ga1XkAqP1v55o2DVCSIWHrw3MDewF
	XacdZVXkN4d2mYuKsCqvkl06koeDM3CTItTNvtSBCap2U/b3DFdYU2D94pnYFYYqV5I28+wur1W
	TvhSqU1S+N7c9OVof0mSPDAa3bHNw0SXZB9Y40GCUpP2sIyypo6gZDDDs=
X-Received: by 2002:a05:6000:38e:b0:48d:db77:d119 with SMTP id ffacd0b85a97d-48ddb77d2ebmr27073053f8f.2.1792109029450;
        Thu, 15 Oct 2026 17:03:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:2edc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a35sm1065064f8f.7.2026.10.15.17.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 17:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 00:03:42 +0000
Message-Id: <DM5TMNILXYE6.3EKVZL31MY64O@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 0/8] bpf: Fix arena memory incoherence
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, "Puranjay Mohan"
 <puranjay@kernel.org>
X-Mailer: aerc 0.21.0
References: <20261014233442.8392-1-emil@etsalapatis.com>
In-Reply-To: <20261014233442.8392-1-emil@etsalapatis.com>

On Wed Oct 14, 2026 at 11:34 PM UTC, Emil Tsalapatis wrote:
> Setting up arena memory for a task currently requires two operations:
> Adjusting its range tree, used for tracking which memory is allocated;
> and adjusting its page tables/flushing its TLB state. These operations
> cannot happen atomically because their critical sections do not nest.
> This lack of atomicity is the source of two bugs that can lead to
> incoherence between different users of the same arena, wherein they
> observe different pages for the same address.
>
> Address the problem by more finely tracking the state of each address.
> Expand the range tree used for address state tracking with a third
> state, used to denote whether an address range is unavailable, either
> because it is being freed or because it is being populated by a VM
> fault. Use this extra state in the arena page freeing/fault logic
> to ensure that operations on a single address properly serialize.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> Cc: Puranjay Mohan <puranjay@kernel.org>

I also have an alternative fix that is way simpler at the cost of holding
the arena lock for longer during frees. I think it's a perfectly acceptable
tradeoff since applications are expected to leave off actual page allocatio=
n/
freeing to the allocator, and the allocator shouldn't be constantly churnin=
g
the mapping with kfunc calls.

>
> v3 -> v4 (https://lore.kernel.org/bpf/20260923191125.5311-1-emil@etsalapa=
tis.com/)
>
> - Add per-arena anonymous mappings and associate pages with them
> - Return VM_FAULT_LOCKED and let generic MM install user PTEs; wait
>   for locked fault pages before TLB flushing and zapping (Alexei).
> - Add mutual exclusion between arena free and fault operations to
>   prevent incoherency.
> - Return VM_FAULT_NOPAGE for non-retryable GUP faults when progress is
>   impossible.
> - Stop and drain self-requeueing deferred frees before map teardown.
> - Track ownership of unavailable ranges independently of free progress
>   and retry worker reservations on -ENOMEM without starting teardown.
> - Make arena free span state machine explicit.
>
> v2 -> v3 (https://lore.kernel.org/bpf/20260923061425.7045-1-emil@etsalapa=
tis.com/)
>
> - Rebase on bpf-next and resolve conflicts
> - Fold in the atomic mark_available range tree operation into initial
>   fix patches
>
> v1 -> v2 (https://lore.kernel.org/bpf/20260902070239.16968-1-emil@etsalap=
atis.com/)
>
> - Use __range_iter_next() in is_range_tree_set() (bot-ci)
> - Move -EAGAIN handling to the patch where the errno is introduced (bot-c=
i)
> - Add refactoring patch for (Puranjay)
> - Avoid leaking unavailable range tree nodes with atomic mark_available
>   operation()
> - Avoid retries on res spinlock locking for -EDEADLK (Puranjay)
>
>
> Emil Tsalapatis (8):
>   bpf: Use mapping tree to zap arena VMAs
>   bpf: Associate arena pages with their mapping
>   bpf: arena: Stop deferred frees before map teardown
>   bpf: Update is_range_tree_set to work for consecutive ranges
>   bpf: Track availability information for ranges in range tree
>   bpf: Fix arena race between page free and alloc leading to incoherency
>   bpf: Synchronize arena page faults with page freeing
>   selftests/bpf: Add arena allocation race tests
>
>  include/linux/bpf.h                           |   1 +
>  kernel/bpf/arena.c                            | 452 ++++++++++++++----
>  kernel/bpf/range_tree.c                       | 240 ++++++++--
>  kernel/bpf/range_tree.h                       |   7 +-
>  kernel/bpf/syscall.c                          |   2 +
>  .../selftests/bpf/prog_tests/arena_race.c     | 285 +++++++++++
>  .../testing/selftests/bpf/progs/arena_race.c  | 159 ++++++
>  7 files changed, 1013 insertions(+), 133 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
>  create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c

