Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210488;
	b=Dmux4cAC27BtGUezs7hAEVPEOf0Im6o0ZjCbEU3ji5hBTeemIM+7Zt45oGQnwj+UJaqs
	 Z5oFDHU1sT+bcopTVhQWShihzjWKXJYV24ufBEuLqpta5fjUpTD958NmsOg89bHU7PoOv
	 qXgMAhEgHTOPd9aXJX1yCGFpUJ1+w4QukeV4k0hfzTcvnZfH/gPUM694ksNL2cax/8kVL
	 e2WajrMRstlNBjWXQJbKSWgKFRQtGtKbV5wqLH0DiSDsv65iiNYQpQx1OevA+CunH3dVq
	 yQpxMaoQHM54+CKhocvbxWxkWyETSHTKG28+IkncQx6wK/ZXhr2qiwubObH9MPxtmcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210488;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=IiMBlpAtiK9aSrDZ5lWv+iMHUMpkntAyUv4AWrwzaLA=;
	b=fpjXullBFaS82la7xnMryg8NwM+mjTvcDBaHhGw67K88BHOwnrryh/rB2LIBFBjze2JK
	 LBeBh4SAhOrpZuP51o9VH1vSEpR9X2rA3CdSHxbaw5CjkyuG6NmDjz7b9uJLmRZl4RHrw
	 jIJID0epg/jgWl1CW1uHB4R29+Lmw+1iR0x+tw/75uJsV3PqAr/xYR6nPgWrQA9fO2MvE
	 rZv6pnQ1Zve+mrii4NKXljjGQtO1BwDl27/fyM8xK4wAJoqIKOW3PVYGNO8QoHNgvbRQh
	 vFPhpmujYqWFF4p09OeBnXlACrW3wNoNQ7g+7tzwnFuwnKFqD6mdDdEB0qLLvco+pNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4QSlG+5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F497606A69E;
	Fri, 20 Nov 2026 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4QSlG+5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10651F000EE;
	Fri, 20 Nov 2026 21:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210487;
	bh=IiMBlpAtiK9aSrDZ5lWv+iMHUMpkntAyUv4AWrwzaLA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P4QSlG+5sXe4X9+9BPisjG2vjWo315l7HGYcy2MVzVG47XQ5l0F0PUNisJG7MUCE9
	 bFpmEAgByIwnRmZYplAY/1TuY6jGZf0h/F5mw8YAcPsg+dpsoLUytr8WNF9BtpN+rt
	 RqAnGO68JFesRZAHqvgdg+1Rhzx0nGXjOF+rdTYT/oejQSvxQwUNIyvWtsmvlLDUke
	 qk53QlIEFt1J2oL3P1HERY6fYze0tonGpO+1IXz8SzBM9z1k/H/deWYaZ0RkDAze37
	 HIEQH6nIwDziceYbKoa3ZoPogINPcUvTVHyYfuZJ3L334X819nzu4eaopeYCaT8mN7
	 rV450NjtjLipw==
Content-Type: multipart/mixed; boundary="===============6117775374168138411=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8676fc63d1b69002f39adee94811f9384c19bb8f6e89d08576e5aaab283c6aa2@mail.kernel.org>
In-Reply-To: <20261120-bpf-ringbuf-fixes-v3-2-ff7ca15d6c37@kernel.org>
References: <20261120-bpf-ringbuf-fixes-v3-2-ff7ca15d6c37@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/8] libbpf: ringbuf: Use compiler atomics
From: bot+bpf-ci@kernel.org
To: tamird@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,arighi@nvidia.com,xukuohai@huawei.com,andrea.righi@canonical.com,billy@starlabs.sg,void@manifault.com,ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,awerner32@gmail.com,zeffron@riotgames.com,andriin@fb.com,tamird@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:34:44 +0000 (UTC)

--===============6117775374168138411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: ringbuf: Use compiler atomics

TL;DR: On arm64 builds targeting RCpc (ldapr), this patch may lose stlr->ldar
ordering, allowing a missed ring buffer wakeup until the later fence patch;
the changelog's "unchanged" claim looks wrong, which matters for bisection.

> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c

[ ... ]

> @@ -270,13 +270,13 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
>  	if (n == 0)
>  		return 0;
>  
> -	cons_pos = smp_load_acquire(r->consumer_pos);
> +	cons_pos = __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
>  	do {
>  		got_new_data = false;
> -		prod_pos = smp_load_acquire(r->producer_pos);
> +		prod_pos = __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);

[ ... ]

> @@ -290,14 +290,13 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
>  				cnt++;
>  			}
>  
> -			smp_store_release(r->consumer_pos, cons_pos);
> +			__atomic_store_n(r->consumer_pos, cons_pos, __ATOMIC_RELEASE);
>  
>  			if (cnt >= n)
>  				goto done;

The commit message says "Acquire and release ordering is unchanged".  Is
that true on arm64?

The old tools helpers in tools/arch/arm64/include/asm/barrier.h are inline
asm, so smp_store_release() emits stlr and smp_load_acquire() emits ldar.
ldar is RCsc, so a store-release followed by a load-acquire cannot be
reordered.

With __atomic_load_n(..., __ATOMIC_ACQUIRE) the compiler may emit ldapr
(RCpc) when targeting FEAT_LRCPC, for example with -march=armv8.3-a or
later, or -mcpu for cores such as Neoverse N1.  libbpf accepts these
through EXTRA_CFLAGS.

With RCpc, the release store of consumer_pos can then be reordered with
the following acquire load of producer_pos, or of the record header in
ringbuf_process_ring().

The consumer publishes cons_pos == X and then reads the old producer_pos
(or sees a BUSY header at X) and returns.  Meanwhile the kernel producer
runs bpf_ringbuf_commit():

    xchg(&hdr->len, new_len);
    smp_load_acquire(&rb->consumer_pos);

It reads the old consumer position, decides cons_pos != rec_pos and skips
irq_work_queue().  The consumer then waits without a notification even
though a record is queued.

Before this commit the stlr->ldar ordering ruled that interleaving out on
arm64.  After this commit it is possible on RCpc-targeted builds.  On
x86_64, ppc, riscv and the generic fallback the window already existed, so
the new exposure is limited to arm64.

This is fixed later in the series by commit 2010ab86a493 ("libbpf: ringbuf:
Prevent missed wakeups"), which adds __atomic_thread_fence(__ATOMIC_SEQ_CST)
after each consumer_pos publication and before the next producer_pos load.
The arm64 exposure therefore exists only at this commit, which matters for
bisection.

Could the fence patch come first, or could this patch carry the fence?
Alternatively, could the changelog note that arm64 loses the stlr->ldar
(RCsc) ordering until the next patch?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44815895103
--===============6117775374168138411==--
