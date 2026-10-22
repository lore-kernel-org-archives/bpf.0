Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712445;
	b=sXZd/HUx8xgjOpzoEeK8V+QWcGJe4RWUCWtpbsygGj1XcT9wI3W36yNzMvvlWC5mInZz
	 yiJL52z//Po47ZPFdYPWkHxkra4HM03gP2FAtWqFaUGIlPZNXLFCRvT3jTudO8pHQwuUu
	 wOCRw+pnCofV3udH1qevPSo7nKPP5QLOxUl3z+UD5szyC7+75zyi4++AdnL80WDGT38es
	 po+vLn9VuuYMytyVL9w3a43O/iqvpPllEuKJm/FYpA0ODDi7RIZzbo/232Ee+CAkK0ilM
	 pJc0wTp3pAdzHmmDDUA8GN6nug58gvss/1shzzdTAueLwFNpGwVp6IuSfXIOfNwMODg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To;
	bh=4COu8/i4pPQl5oR/keQYHoxeQlFyOLVoxBN7EZG+NeI=;
	b=1dtgjoQ9R2CNzjL2xVLpgSijLeYAhZ/hj/QVCGHC7mcgSmVHfgNAHWAHaA3S2u8eAMdc
	 i03q6/oWg5uaQc1Dwt79OoPLiWgkc4LTkVQCeHAbgLTpPmC0YZHIGhi4jh7mZGMIehDf7
	 ElWBBg6niF1GtBEUXMaos+7DCPnfTRlVHQXTbhietnxmDTTonrTsPVyf47tjYkiYvZ3Yq
	 TiOKbxdEUOYiFDD9TnRTCnQAwWbSypzQuURcpx8fTJot/4R6pe/TTlc2sxf6SwI6qFZY4
	 vKsW/FqleQIA346TDJgX1OVtN6EBEqiHR3ly5YwH/9mTvLqSF7AhZz61EEitz5RpfyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=pkSb+64k;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140D606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 23:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4140D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=pkSb+64k
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8b20a899fso1480915ad.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 16:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792712443; x=1793317243; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4COu8/i4pPQl5oR/keQYHoxeQlFyOLVoxBN7EZG+NeI=;
        b=pkSb+64kaphFLFqMrHMhaTq+HTXiddkEGsa9Z4QTlIUKyeXOfck14mkDMdvRvo9wWq
         4HPOVe+QQicXFmjdqhOOuNOB47lmN5C3jzlYDW0YqCW8ISuuRUYx2Y1MlAD9kURu04wN
         HU43XaTQYF9CinVQ1M9nY64avzf94qCylnueijaPNwulxxZ4QNWveeJc4PkwVQ1cktvy
         jc103K6ygd2sPAsnN4s9XTYbGKXaz0eFHbs2pvjV57tzWOUkg2djRta94jvyMR6rMLMJ
         lCUqbkxB3+EZvW7jw7TZWvfRGYn5NihKtN4FAQj1mVJACi0qAyD1bXgOLmGZZ3Pr3vxk
         BZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792712443; x=1793317243;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4COu8/i4pPQl5oR/keQYHoxeQlFyOLVoxBN7EZG+NeI=;
        b=w7+RSaaUAKM9LGlWpAxDlVr7850BZ7sTLXYtbWzYOrC+Xer0K5nF//NTQ2pL2nJFZm
         hqaNPgG8aB32mnpJ1Iu5P/aQ0a4IG81iCfKrZDwxBODsNRi4Eh+9W/K4+hPJNjhwchbA
         cppVnJcYcyNuO3uv9vuZbhVUcwYiL44Jfy958+5gKuTyq24/UvfJq/7poAt4MEpMlZPn
         HNEYNffDXu8GIN6fAl9E2MemNfFgyM7lEmuYNQ5MRtgr1vO6u0xMJaeUSyX8lgX4iiQt
         VjG9OqdaCgKG+nQLAEjGGLslYlWV4bh0K7nxgY5EO4cR+xHjN+vth7t814VCcp4hbZp4
         of+A==
X-Gm-Message-State: AFq9FYILQKaGbD/7NwdiAQ23Y1tx0Gv8y5uyshKLoQMTkrdT20rULEUP
	TwS8dTY++Fklifa9s3G5RdDT4b6R4QpYKMzv0D3ZK0sgYN4A2V1dAkxbveR9l6Zfg+J6z/SS+iv
	WUzPP6rfDUg==
X-Gm-Gg: AYBFou2pEt5DJZBfPLLPfJ2HH5v48ukhMd+nU5rVjVNtMFTYpTTCoywzxT6b6eBxseU
	6pjwDGBynm7zt091wIHtkqG5ZH8yNa/RE+zANTwF+Dja40O42FONRtvbsaS8pMs8TtJdBYdrEeN
	yJ3ooaGHzuzxf3yigh8LkLjMLZwjphH338PehNlp4A3swePltR9+uReBjnLaq0Xuh7dFFul6oth
	cuHJgtlqJEK/PEP63kdQuQA+4WspZ3r3fplFGqWlNBNr49RJfcgSmZODY1hLs9X+o1oip5M51qH
	A0ESZFuWbpmFdI06Fnsr1OQmC0Fw2G8wfk6arn6bUJs4kANSIh8MjdMEsuSykGj2ly5dmATWLOC
	Lu8VaRtPqVznKw+J0yNZ5Y1DgCAsLnZG1Ff1Mm+lu8OTk6JCULOsfFDuV4WUR5P52cOpZoWcHch
	a2EDsHTD05LLXhmw/S3k9tjRJbfF8LR3cIyS2O+eYDbK/MRcv1GKYN5riKfTc+ZcuFcLen3V+Yc
	HVtDx0lS676jJuJZntvJTPVJ+J+Cpe9Al5KIDz2wusOC4/0v1c6Hor2NnJ2d/9uDSZTL99zvXa1
	LYIj5doocA==
X-Received: by 2002:a17:90b:3f4b:b0:3ac:a1c7:20fd with SMTP id 98e67ed59e1d1-3adcdc87c58mr383559a91.4.1792712443361;
        Thu, 22 Oct 2026 16:40:43 -0700 (PDT)
Received: from localhost (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4954979sm6126486a91.17.2026.10.22.16.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 16:40:42 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 23:40:41 +0000
Message-Id: <DMBRIUEJD3IW.3AXK142IA7TBH@etsalapatis.com>
To: "Harry Yoo" <harry@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 3/7] selftests/bpf: libarena: Add buddy
 per-CPU caches
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20261021232641.10063-1-emil@etsalapatis.com>
 <20261021232641.10063-4-emil@etsalapatis.com>
 <atoAxMKmTpuUiqMf@thinkstation>
In-Reply-To: <atoAxMKmTpuUiqMf@thinkstation>

On Thu Oct 22, 2026 at 12:53 PM UTC, Harry Yoo wrote:
> On Wed, Oct 21, 2026 at 11:26:37PM +0000, Emil Tsalapatis wrote:
>> Every small allocation currently reaches the central buddy allocator and
>> takes its lock. This serializes otherwise independent callers and touche=
s
>> the buddy metadata on every allocation and free.
>>=20
>> Add a fixed-size LIFO array for each cached order and CPU. Keep the
>> per-CPU cache pointers in struct buddy and allocate each CPU's packed
>> cache from the buddy during initialization. Cache the eight smallest
>> allocation orders, up to 2 KiB. Each array holds 16 objects, bounding ea=
ch
>> CPU's cache to about 1.5 KiB.
>
> TIL the min alloc size is not PAGE_SIZE in BPF buddy allocator :)
>
>> Allocations pop from the local array and frees push onto it without taki=
ng
>> the buddy lock. Empty and full arrays fall through to the central buddy
>> allocator. Packed arrays keep the fast path to a bounds check and a sing=
le
>> slot access.
>>=20
>> BPF programs only disable migration, so another task can preempt a cache
>> operation and run on the same CPU, and an IRQ or NMI program can interru=
pt
>> one. Claim the CPU with a cmpxchg on a per-CPU flag before touching its
>> arrays, following the model used by the main BPF memory allocator. An
>> operation that finds the CPU already claimed falls through to the centra=
l
>> buddy allocator.
>>=20
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  .../bpf/libarena/include/libarena/buddy.h     |  34 +++
>>  .../bpf/libarena/include/libarena/common.h    |   4 +
>>  .../bpf/libarena/selftests/test_buddy.bpf.c   |   9 +
>>  .../selftests/bpf/libarena/src/buddy.bpf.c    | 215 +++++++++++++++++-
>>  4 files changed, 257 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy=
.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
>> index f150e1c37e3d..66349915745b 100644
>> --- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
>> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
>> @@ -65,10 +65,44 @@ struct buddy_chunk {
>>  	struct buddy_chunk __arena	*next;
>>  };
>> =20
>> +/* Constants related to the buddy allocator's object caches. */
>> +enum buddy_cache_consts {
>> +	/*
>> +	 * Do not cache larger allocations to avoid excessive
>> +	 * memory consumption from the per-cpu lists.
>> +	 */
>> +	BUDDY_CACHE_NUM_ORDERS =3D 1 << 3,
>> +
>> +	/*
>> +	 * Just like arena spinlocks, hardcode percpu state to a maximum numbe=
r of CPUs.
>> +	 * Since arena spinlocks are a hard dependency, use the exact same lim=
it.
>> +	 */
>> +	BUDDY_CACHE_MAX_CPUS =3D 1024,
>
> Is there no way to get nr_cpu_ids from the kernel in BPF?
> NR_CPUS is upper bound supported by the kernel but during the boot
> process, the kernel updates nr_cpu_ids based on the processor of the
> system.
>
> Kernels built with CONFIG_MAXSMP won't be able to use this because
> it uses very high NR_CPUS? (8192 on x86)

Agreed, but we should make the change in tandem with the arena spinlock cod=
e
since it is also hardcoding the same constant. In fact, we should probably
restructure the headers to make sure they are always in lockstep. I didn't
do it in this series because I was planning it as a followup, we can also
add the refactor as a preparatory commit here.

>
>> +	/*
>> +	 * Objects retained locally for each allocation order.
>> +	 */
>> +	BUDDY_CACHE_CAPACITY =3D 16,
>> +};
>> +
>> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/buddy.bpf.c
>> index 6dfaa23089a9..c41e163b014f 100644
>> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
>> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
>> @@ -7,6 +7,9 @@
>>  /*
>>   * Buddy allocator arena-based implementation.
>>   *
>> +static __always_inline struct buddy_cache __arena *
>> +buddy_cache_enter(struct buddy __arena *buddy)
>> +{
>> +	struct buddy_cache __arena *cache;
>> +
>> +	/* The caches only exist between buddy_init() and buddy_destroy(). */
>> +	cache =3D buddy->percpu[bpf_get_smp_processor_id()];
>> +	if (unlikely(!cache))
>> +		return NULL;
>> +
>> +	/*
>> +	 * No support for cache operations from contexts that interrupted or
>> +	 * preempted an in-flight operation on the same CPU, just like the
>> +	 * kernel's BPF memory allocator.
>> +	 */
>> +	if (cmpxchg(&cache->active, 0, 1))
>> +		return NULL;
>
> Maybe use cmpxchg_local() instead of cmpxchg() because this is percpu?
> Not sure if there's cmpxchg_local() equivalent in BPF...

We don't really have cmpxchg_local() available in BPF. I hacked up a protot=
ype
and the benefits were actually not that significant, about 2ns for hot allo=
c
free loops.

>
> On x86, cmpxchg instruction should be cheaper without LOCK prefix.
>
>> +
>> +	return cache;
>> +}
>> +
>> +static __always_inline void buddy_cache_exit(struct buddy_cache __arena=
 *cache)
>> +{
>> +	smp_store_release(&cache->active, 0);
>> +}
>
> We don't need this barrier because this is percpu?


... this, however did matter significantly for hot loop frees. I will add i=
t
to v3 and respin.

