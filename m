Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33C34FF78
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764921; cv=none; b=DhAVvVtG5sLCtcrUOXnHMrmFahUJXBB5sR3RMYsIWiAcbZhOBy127OC23M2sLg/u90WqkUU0Z0n8cpBrlF3O5xoQsDmyKGNqoUKeUIjxeoMbL+cWn00njyvamk4LEyCq8OWjn22vTi7/GgMydcN/n24Qa5vEE5uClmy1uhrf+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764921; c=relaxed/simple;
	bh=7z7rFVfq3N/QcZqXeg0TorLymH8gTqPV44j/HuhDaGo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Cm5a+s02J90RQZLMz/u+SvXjLFspfJNh8eA3ASqWIFDq6kLaozn9ZFl10mdivIKx76iQ4Ru78IBgNqxz7TFKYUu4d8ot3Qyy9gOcIy//tQFsxkshzoI6KHT9nR2u5ZJoUJDT23btkI1nKZ0do68qG8TLVwNMEUWvTzjxGRf0z3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=TTnmIRYo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="TTnmIRYo"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so214732a91.2
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 23:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781764916; x=1782369716; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ItFCfybx0ZD8S2a6ZaD9XV0K7xnLCnKs+Inx+8dh6k=;
        b=TTnmIRYo+aOLCYXFf93KtcqyY/DrbXvk4ZmGcHL9fWEW0a+eA0QomBlXH8sElY0pSb
         5O9nDtsmfT0d/hXl0jxdQ6duxaxm/8zGLz/Cdo2zVHVmJAEvdqDJKOQkgTLUYvmm75nS
         BlzLdtCwPFnVwowMaZGvkevf8RDBUu3lTLBfNxpk7e3LMeTNmkgBmmDtZipZcIl7rh9G
         CGd+70UrPzm0JNJEh6Br42FrYl0BVXbmsGD3fqxhcGcTqDOoQoA0nBw4Fcyt0J8G0ldH
         Invq24OPZAFQ5XoAJKPgcS8otUAqxvQf1uuchrL7fjp8zdxciGPTBVhHDbPYXFpO8QyZ
         /oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781764916; x=1782369716;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ItFCfybx0ZD8S2a6ZaD9XV0K7xnLCnKs+Inx+8dh6k=;
        b=X9bryk6LRoHHqVTDg/o3RhVTyenKy7PuI0I4ZQSVchT3/lLIpWDV8kkI0yYPXNYXR9
         fS7KbqT3yRQcMgzr0R0Y1PrYb8w1oVTk4Gq5faeaNUOfymuIsOn65OG49oe3LSd9xrMF
         RE7AHaPnxDWZDEcR0PQRhbBKUg9GAU8Cq+JViL7ZWtZmmK1UY0ZtjS3EmbGDObeIS2m4
         VD+iwoZ1Q7Q7vZ46te7US3UqEQq8MAP23RUS4D8Fn83EZXGN1I0gC7tuT3FhO7LPkZvi
         m1717z1O8okW4bOGes4H+GOAGm5ysk+evyuwJGypZW+kri4McV6lMOYKXdSXg8W7iBeS
         UMag==
X-Gm-Message-State: AOJu0YxcVtJrWqHSd4urBKlzyz5JkdjTArCMnbrrGU+2AFpRhPVOulGw
	Tkb4Fqor2jFipI1uPmQhdGT5R60Lu5VGbM6WD9HgjwBy3m8nShZdqRX0PDTB8cdpZb0=
X-Gm-Gg: AfdE7ck10TGfmZhdETQoEg93Mbmtbx4Cp91B+jNk3J1ug4BTbzeDyA+Hv3MQohitOvQ
	49FzZ01ainoirMcUe7lHwfVOXU6w++aYMSoyTsfVIo/AG1pMGPa6vfEKtIvuvqQbWrGf0GDziDf
	YvPJKGukWgZrT4JHd2OxTHPRBe4nQAnlY1sbMy0vwQrMSBLcprYMG8dLOoU/klxefcjYp5qqYoG
	C4Xotzxq5+VvQVr8rH7buNGM6TvsJfxsdZ4zc/Oyslyop6nE2tuuJgxl50RqTG4uyVq+gQmKTYC
	Gyu+G4RA5JEVTFQqX7c1w3Mvc4RBMfBAUScaAYEy7lb9lTDgNg+zlDFQCkbawHfk1aPX5Px0Zon
	5pB8070wmMbudbEmYCUdEmkrZFZrXpTB3dASkIuElD1gTrzBPpPTAFm0Oay+prpfBpbvALWOa8K
	uNljpAXoYC2Waq8gROWPyJYfEi3zNUnnAanfuiuoADctVY
X-Received: by 2002:a17:90b:37c8:b0:36b:9798:4f6a with SMTP id 98e67ed59e1d1-37ce44ead65mr2031950a91.10.1781764915590;
        Wed, 17 Jun 2026 23:41:55 -0700 (PDT)
Received: from localhost (S0106d8b37028eeb5.vc.shawcable.net. [24.84.91.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37ce68cab02sm1178167a91.7.2026.06.17.23.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 23:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 02:41:54 -0400
Message-Id: <DJBYY5JF4YBQ.2QJVU2QKJ16N2@etsalapatis.com>
Subject: Re: [PATCH bpf 5/6] libbpf: ringbuf: Prevent missed wakeups
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tamir Duberstein" <tamird@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Andrea Righi" <arighi@nvidia.com>, "Xu Kuohai"
 <xukuohai@huawei.com>, "Andrea Righi" <andrea.righi@canonical.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, "Andrew Werner" <awerner32@gmail.com>,
 "Zvi Effron" <zeffron@riotgames.com>, "Andrii Nakryiko" <andriin@fb.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
 <20260613-bpf-ringbuf-fixes-v1-5-e623481cb724@kernel.org>
In-Reply-To: <20260613-bpf-ringbuf-fixes-v1-5-e623481cb724@kernel.org>

On Sat Jun 13, 2026 at 9:48 PM EDT, Tamir Duberstein wrote:
> After consuming the last visible record, ringbuf_process_ring()
> publishes the consumer position and checks the producer position. These
> operations lack a full StoreLoad barrier. A producer can therefore
> commit a new record but read the old consumer position while the
> consumer reads the old producer position. The producer sends no
> notification and the consumer waits despite a queued record.
>
> Insert a full barrier before checking for new data, ensuring that either
> the consumer observes the producer update or the producer observes the
> consumer update and sends a notification. Apply the same handshake when
> a busy record follows records whose consumer position was published.
>
> Add an edge-triggered epoll test with a concurrent producer. Without the
> barrier, a missed notification leaves the producer dropping records from
> a full ring while the consumer times out. Document that bounded
> consumers and callbacks that terminate consumption must drain before
> waiting again.
>
> Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
> Reported-by: Andrew Werner <awerner32@gmail.com>
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
>  tools/lib/bpf/libbpf.h                           | 22 +++++++
>  tools/lib/bpf/ringbuf.c                          | 14 +++-
>  tools/testing/selftests/bpf/prog_tests/ringbuf.c | 84 ++++++++++++++++++=
++++++
>  3 files changed, 117 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 9ba6b9ad3498..a3b8f606a91d 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1439,6 +1439,10 @@ struct ring_buffer;
>  struct ring;
>  struct user_ring_buffer;
> =20
> +/* A negative return stops consumption; non-negative values continue. St=
opping

Sashiko is right on this, let's use regular kernel style for new
comments.

> + * can leave records queued without a new readiness notification. Before
> + * waiting for readiness again, consume until no records remain.
> + */
>  typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size)=
;
> =20
>  struct ring_buffer_opts {
> @@ -1455,6 +1459,20 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer=
 *rb, int map_fd,
>  				ring_buffer_sample_fn sample_cb, void *ctx);
>  LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)=
;
>  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> +
> +/**
> + * @brief **ring_buffer__consume_n()** consumes up to a requested number=
 of
> + * records from a ring buffer manager without event polling.
> + *
> + * @param rb A ring buffer manager object.
> + * @param n Maximum number of records to consume.
> + * @return The number of records consumed, or a negative error code on f=
ailure.
> + *
> + * Reaching the requested bound does not establish that every ring is em=
pty.
> + * Records can remain queued without a new readiness notification. Befor=
e
> + * waiting on ring_buffer__epoll_fd(), call ring_buffer__consume() until=
 it
> + * returns 0.
> + */
>  LIBBPF_API int ring_buffer__consume_n(struct ring_buffer *rb, size_t n);
>  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
> =20
> @@ -1537,6 +1555,10 @@ LIBBPF_API int ring__consume(struct ring *r);
>   * @param r A ringbuffer object.
>   * @param n Maximum number of records to consume.
>   * @return The number of records consumed, or a negative error code on f=
ailure.
> + *
> + * Reaching the requested bound does not establish that the ring is empt=
y.
> + * Records can remain queued without a new readiness notification. Befor=
e
> + * waiting on ring__map_fd(), call ring__consume() until it returns 0.
>   */
>  LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
> =20
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 1c24a83f59d5..ea8909fec4e9 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -255,7 +255,7 @@ static int64_t ringbuf_process_ring(struct ring *r, s=
ize_t n)
>  	/* 64-bit to avoid overflow in case of extreme application behavior */
>  	int64_t cnt =3D 0;
>  	unsigned long cons_pos, prod_pos;
> -	bool got_new_data;
> +	bool got_new_data, needs_wakeup =3D false;

The extra new variable feels overly complicated. I think this is becuase
the new code is going off of the got_new_data pattern, which imo is also
unnecessary. We should just remove got_new data and just do:

while (true) {
	prod_pos =3D __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
	if (cons_pos =3D=3D prod_pos)
		break;

	while (cons_pos !=3D prod_pos) {
		...
	}
}

>  	void *sample;
> =20
>  	err =3D ringbuf_validate(r);
> @@ -267,14 +267,21 @@ static int64_t ringbuf_process_ring(struct ring *r,=
 size_t n)
>  	cons_pos =3D __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
>  	do {
>  		got_new_data =3D false;
> +		if (needs_wakeup) {
> +			/* Ensure either this sees a new record or its producer sees
> +			 * the updated consumer position and sends a notification.
> +			 */
> +			__atomic_thread_fence(__ATOMIC_SEQ_CST);
> +			needs_wakeup =3D false;
> +		}

Now on this, I think to address Sashiko's warning instead of the if
above...

>  		prod_pos =3D __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
>  		while (cons_pos !=3D prod_pos) {
>  			len_ptr =3D r->data + (cons_pos & r->mask);
>  			len =3D __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE);
> =20
> -			/* sample not committed yet, bail out for now */
> +			/* Retry a busy record once after publishing prior records. */
>  			if (len & BPF_RINGBUF_BUSY_BIT)
> -				goto done;
> +				break;
> =20
>  			got_new_data =3D true;
>  			cons_pos +=3D roundup_len(len);
> @@ -294,6 +301,7 @@ static int64_t ringbuf_process_ring(struct ring *r, s=
ize_t n)
> =20
>  			__atomic_store_n(r->consumer_pos, cons_pos,
>  					 __ATOMIC_RELEASE);
> +			needs_wakeup =3D true;
> =20
>  			if (cnt >=3D n)
>  				goto done;

We just add an smp_mb() here. And since AFAICT smb_mb is available here,
we can also avoid the move from smp_* to __atomic in the previous patch.

> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
> index 9ce996bcea8c..5f0c679bf9a6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -492,6 +492,88 @@ static void ringbuf_null_cb_subtest(void)
>  	test_ringbuf_n_lskel__destroy(skel_n);
>  }
> =20
> +#define N_WAKEUP_SAMPLES 20000
> +
> +struct wakeup_ctx {
> +	bool stop;
> +};
> +
> +static void *wakeup_producer(void *arg)
> +{
> +	struct wakeup_ctx *ctx =3D arg;
> +
> +	while (!__atomic_load_n(&ctx->stop, __ATOMIC_RELAXED))

Why __ATOMIC_RELAXED here? Maybe just declare the variable volatile and
do regular reads?

> +		syscall(__NR_getpgid);
> +	return NULL;
> +}
> +
> +static void ringbuf_wakeup_subtest(void)
> +{
> +	struct test_ringbuf_n_lskel *skel_n;
> +	struct ring_buffer *ringbuf =3D NULL;
> +	struct epoll_event event =3D {
> +		.events =3D EPOLLIN | EPOLLET,
> +	};
> +	struct wakeup_ctx ctx =3D {};
> +	pthread_t producer;
> +	int epoll_fd =3D -1;
> +	int err, total =3D 0;
> +
> +	skel_n =3D test_ringbuf_n_lskel__open();
> +	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
> +		return;
> +
> +	skel_n->maps.ringbuf.max_entries =3D getpagesize();
> +	skel_n->bss->pid =3D getpid();
> +	skel_n->bss->value =3D SAMPLE_VALUE;
> +
> +	err =3D test_ringbuf_n_lskel__load(skel_n);
> +	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
> +		goto cleanup;
> +
> +	err =3D test_ringbuf_n_lskel__attach(skel_n);
> +	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
> +		goto cleanup;
> +
> +	ringbuf =3D ring_buffer__new(skel_n->maps.ringbuf.map_fd,
> +				   process_noop_sample, NULL, NULL);
> +	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
> +		goto cleanup;
> +
> +	epoll_fd =3D epoll_create1(EPOLL_CLOEXEC);
> +	if (!ASSERT_OK_FD(epoll_fd, "epoll_create1"))
> +		goto cleanup_ringbuf;
> +
> +	err =3D epoll_ctl(epoll_fd, EPOLL_CTL_ADD, skel_n->maps.ringbuf.map_fd,
> +			&event);
> +	if (!ASSERT_OK(err, "epoll_ctl"))
> +		goto cleanup_epoll;
> +
> +	err =3D pthread_create(&producer, NULL, wakeup_producer, &ctx);
> +	if (!ASSERT_OK(err, "pthread_create"))
> +		goto cleanup_epoll;
> +
> +	while (total < N_WAKEUP_SAMPLES) {
> +		err =3D epoll_wait(epoll_fd, &event, 1, 1000);
> +		if (!ASSERT_EQ(err, 1, "epoll_wait"))
> +			goto cleanup_thread;
> +		while ((err =3D ring_buffer__consume(ringbuf)) > 0)
> +			total +=3D err;
> +		if (!ASSERT_OK(err, "ring_buffer__consume"))
> +			goto cleanup_thread;

Label is unnecessary, just call break;

> +	}
> +
> +cleanup_thread:
> +	__atomic_store_n(&ctx.stop, true, __ATOMIC_RELAXED);
> +	pthread_join(producer, NULL);
> +cleanup_epoll:
> +	close(epoll_fd);
> +cleanup_ringbuf:
> +	ring_buffer__free(ringbuf);
> +cleanup:
> +	test_ringbuf_n_lskel__destroy(skel_n);
> +}
> +
>  static void ringbuf_n_subtest(void)
>  {
>  	struct test_ringbuf_n_lskel *skel_n;
> @@ -672,6 +754,8 @@ void test_ringbuf(void)
>  		ringbuf_n_subtest();
>  	if (test__start_subtest("ringbuf_null_cb"))
>  		ringbuf_null_cb_subtest();
> +	if (test__start_subtest("ringbuf_wakeup"))
> +		ringbuf_wakeup_subtest();
>  	if (test__start_subtest("ringbuf_map_key"))
>  		ringbuf_map_key_subtest();
>  	if (test__start_subtest("ringbuf_write"))


pw-bot: cr
