Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4D179A3
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109104; cv=none; b=ET+g4qoWVUz8GsAqRyJJzKZeBrKRkVGf2LBuzn2yHe41C/QbX/Mb298Gh6ee6dKvdBU+vSMIrRZisgqZN8o9FXrv3uBrGtconf2iSmXwhvbjLsuvxxYsc+Ht3Xbw4WN+Y8MG3yzw/Kbq0SDuqzgfErmWyyNY8UEHD71VCjxkUGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109104; c=relaxed/simple;
	bh=GXKfFwgjHHgF0PebKqYDQY5UgIsiuPO65El8dMA3QOg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ffwFAujnG6jfTkE7moOAtElg89c0uZyeP0nt7fe+Grm5dzXagm8Nk7VvYaOXykvC3d5FcmunfeYkJpHtxXUJRJUwZPSmwDsPWpw+8Dq6byZ8RWaM/NflWwY+5pNWUqB1+f4ug4mFaJ+4Be8U3Ik1ZN0a1LNzLtFPRoPOicVhInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=hwNVqJ+3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="hwNVqJ+3"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b042c0759so4298932f8f.2
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792109101; x=1792713901; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ObgGVV2jCfXEjeBR/MfGrHygBVccr3+aswSyVS4yBxU=;
        b=hwNVqJ+3TCmSYrCZobVmLBUmmjAsuy9QWijKmMqgOIjb+sfETHsN807McfFd0ib5O1
         7i2HfIQ+Ee3R49IFBlK7fzhOrmhn79KV1Q0gMgCxsuzcc+PRjHcFfUBgzxDSazuu1D/n
         Itji50TAJyt6fGRV2xUcfbULMIvEesfHqwNx/n4Q9QYNdAK/++H9ZPvfiirPeUTeeMOt
         BFVlmwXAuXr20CH33uiRAYhHqz6oBDunkky91LJDACJJDGZbHBovqjS+N2MQp07NVDYY
         4xURnygSNFLCXciat0pOSwKFkxDsG3bY/bHuFm6afZj1ewQXrZFrp0x3yDt/GbeF2jBx
         N+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792109101; x=1792713901;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ObgGVV2jCfXEjeBR/MfGrHygBVccr3+aswSyVS4yBxU=;
        b=nm4eMXR1Zp7Vw2RIEWyDcGq2jIHYS7k+ZIIKAHEEbVYojf8tZmzfy+QtPNMJ7rVTjX
         vadtdiBSUJ25IEFqorRVsM+6SStZR1qKu/6OCqKqSgZV4UesGSadO6djTQydoA52jtIr
         9f1CL+4QKtAX46vrQ3bAvmEqSZLxWoY9d+miIA3csO/h2HiIQmM2cKLl6U9wdoXhngVt
         NeuERqktdHrO6EZ5qigEeAPGudKDwJUHp8SAhM9Et27fJg4HmNCDgn4tXqligIkcdhuV
         deRSUmJ/jAQgn87L/Ftf7ehPyF2qzgYflDGFvmN4i7YtGy/LNqgr92QlWvJpFLP5MUNN
         FkGw==
X-Forwarded-Encrypted: i=1; AKwUvBwrDBCB50MeoAWbBooyW90wDxMniFbl6Wn2YPMqOc4sHWxO/pXcWtS0TCeWuymREaOWhxU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZUgzeImAk76cKe5kwv/j5LiTfCpmrHPggqr5Dpil3efRRsWPH
	3OFxkVwFVAELGWvdigFpTozKEsoNBoKdMdFkLElXJjZLezEjq5+Jaqkyvt3aHafmCxE=
X-Gm-Gg: AYBFou389K3ntwpQ6TqwjCLwwi2D1aIoq6JxguetRviZidSEiXu4zaNhUsifaHZRbcw
	5D4dCq4Pls24/Q3REbYHk9Eg1YSCDzh2/2YbLa+CHauB5pzWwkVk/M43/hxPi1rVIVYdH+PiSW/
	wJWAvYoPKpUPJant8oZ2kW5ntMDprcGGLQode3MD219cSR+DJ3cns80OQ68ey+TUVo90PvSAldo
	s3M1FZuwpieipOMrcAbgpDg+MUuGXiXjFAk2h+vY5Pwm5I0bmtTK3EoietXWgUM6o3DQyB2O8eq
	NIdvQmRYfQSsXjbDjQnkkNpJJAY/IN6lJJJQMZDPIxqtryC5/OjvmsCviabR3KfhtCK+YyzTDI+
	ZDnEaUxbyMiltgwUgBcjBWOQrsb04+wCrhHBIxHv+4r8vUETZl7svgoeAnsMozADzB8PqS+tWux
	zI/txV+5oj2zUpB+tkyKag+TiQLE9Xa9sPaiavNF7q4nhxcC2khRkYltg=
X-Received: by 2002:a05:6000:2992:10b0:488:654b:ccd8 with SMTP id ffacd0b85a97d-48dba7819famr29185674f8f.6.1792109100653;
        Thu, 15 Oct 2026 17:05:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:95e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5008e7sm1220978f8f.43.2026.10.15.17.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 17:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 00:04:55 +0000
Message-Id: <DM5TNKREPDWB.2OEYD0RXX572F@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, "Puranjay Mohan"
 <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v4 0/8] bpf: Fix arena memory incoherence
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261014233442.8392-1-emil@etsalapatis.com>
 <DM5TMNILXYE6.3EKVZL31MY64O@etsalapatis.com>
In-Reply-To: <DM5TMNILXYE6.3EKVZL31MY64O@etsalapatis.com>

On Fri Oct 16, 2026 at 12:03 AM UTC, Emil Tsalapatis wrote:
> On Wed Oct 14, 2026 at 11:34 PM UTC, Emil Tsalapatis wrote:
>> Setting up arena memory for a task currently requires two operations:
>> Adjusting its range tree, used for tracking which memory is allocated;
>> and adjusting its page tables/flushing its TLB state. These operations
>> cannot happen atomically because their critical sections do not nest.
>> This lack of atomicity is the source of two bugs that can lead to
>> incoherence between different users of the same arena, wherein they
>> observe different pages for the same address.
>>
>> Address the problem by more finely tracking the state of each address.
>> Expand the range tree used for address state tracking with a third
>> state, used to denote whether an address range is unavailable, either
>> because it is being freed or because it is being populated by a VM
>> fault. Use this extra state in the arena page freeing/fault logic
>> to ensure that operations on a single address properly serialize.
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Cc: Puranjay Mohan <puranjay@kernel.org>
>
> I also have an alternative fix that is way simpler at the cost of holding
> the arena lock for longer during frees. I think it's a perfectly acceptab=
le
> tradeoff since applications are expected to leave off actual page allocat=
ion/
> freeing to the allocator, and the allocator shouldn't be constantly churn=
ing
> the mapping with kfunc calls.

Sorry for the double email, forgot to actually add the link to the patchset
(just posting the link for now to avoid having two parallel extant versions=
 here):

https://github.com/etsal/linux/tree/arena_race

>
>>
>> v3 -> v4 (https://lore.kernel.org/bpf/20260923191125.5311-1-emil@etsalap=
atis.com/)
>>
>> - Add per-arena anonymous mappings and associate pages with them
>> - Return VM_FAULT_LOCKED and let generic MM install user PTEs; wait
>>   for locked fault pages before TLB flushing and zapping (Alexei).
>> - Add mutual exclusion between arena free and fault operations to
>>   prevent incoherency.
>> - Return VM_FAULT_NOPAGE for non-retryable GUP faults when progress is
>>   impossible.
>> - Stop and drain self-requeueing deferred frees before map teardown.
>> - Track ownership of unavailable ranges independently of free progress
>>   and retry worker reservations on -ENOMEM without starting teardown.
>> - Make arena free span state machine explicit.
>>
>> v2 -> v3 (https://lore.kernel.org/bpf/20260923061425.7045-1-emil@etsalap=
atis.com/)
>>
>> - Rebase on bpf-next and resolve conflicts
>> - Fold in the atomic mark_available range tree operation into initial
>>   fix patches
>>
>> v1 -> v2 (https://lore.kernel.org/bpf/20260902070239.16968-1-emil@etsala=
patis.com/)
>>
>> - Use __range_iter_next() in is_range_tree_set() (bot-ci)
>> - Move -EAGAIN handling to the patch where the errno is introduced (bot-=
ci)
>> - Add refactoring patch for (Puranjay)
>> - Avoid leaking unavailable range tree nodes with atomic mark_available
>>   operation()
>> - Avoid retries on res spinlock locking for -EDEADLK (Puranjay)
>>
>>
>> Emil Tsalapatis (8):
>>   bpf: Use mapping tree to zap arena VMAs
>>   bpf: Associate arena pages with their mapping
>>   bpf: arena: Stop deferred frees before map teardown
>>   bpf: Update is_range_tree_set to work for consecutive ranges
>>   bpf: Track availability information for ranges in range tree
>>   bpf: Fix arena race between page free and alloc leading to incoherency
>>   bpf: Synchronize arena page faults with page freeing
>>   selftests/bpf: Add arena allocation race tests
>>
>>  include/linux/bpf.h                           |   1 +
>>  kernel/bpf/arena.c                            | 452 ++++++++++++++----
>>  kernel/bpf/range_tree.c                       | 240 ++++++++--
>>  kernel/bpf/range_tree.h                       |   7 +-
>>  kernel/bpf/syscall.c                          |   2 +
>>  .../selftests/bpf/prog_tests/arena_race.c     | 285 +++++++++++
>>  .../testing/selftests/bpf/progs/arena_race.c  | 159 ++++++
>>  7 files changed, 1013 insertions(+), 133 deletions(-)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c

