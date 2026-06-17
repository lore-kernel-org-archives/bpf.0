Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB12BDC0B
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781657060; cv=none; b=YyIZY+XQhaxR/20fmxwYHq3fOYSiPtOjj7jLEy8WrS8Klh+y7x5Xa2pSZc7XyBQJQXJRmTB8rwM2ST3bNpM8Fqni0fKs5ygaZXhAsSkA8hnB7GUjqWCxoJjA4aOLMn9m5DGVdzI6SLxRlqH7NRgW1XhSJKIzHM1IgJLHWUzA4kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781657060; c=relaxed/simple;
	bh=DEN/111C1FkE7tXQJWjifv5zKhxGnTDUz4W0b0nsrKo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sjUqCBSBpDkwLob3+zM8Ho4hZKYXEL2iU42WoSVsw6Ljok7zwSU/QrSMN28EhBBS0j+NPbCPOBx9UkFr5YH4wksopeS8yPv/Z8FJ5NAJFTj1zUtEHng6HhVLm8+DYunditKb+Bc6stiCqz3fd4T8noDY6r8gxQl9+i28cB74K0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=fVq2QUwj; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="fVq2QUwj"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-137eb0d76beso344615c88.0
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 17:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781657057; x=1782261857; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQq++K17JRNcTpXKTVWZr3Aw/CAliMfIgrA0KhotXMI=;
        b=fVq2QUwjxVMDOQ8RXtvHRIwNcEzrY6BrwTjVWlOyrm3dvTteIPj1K0nhQ75MkeU3jr
         2HdfD2//1Rc4b9K8r20bswGCwagnjvYhuqTBoRMAjM4vCMMVcecC8khNCkpg6YYusO49
         sI3ziNYHTHaelHrZJC6GpWC/IXr5+CMH3CRWZ8wsLphsAuP+F5FwmmqFZ7sgZsDcTvPW
         07nBZgFlH2noudLqZq5FOGZeMsTupOC4VOdmW9cqnCjuwope1l55ELqFwrcJV5VQUHTc
         sU2u3eD/u67bVjUDa9h3m7m3uKwT1nNSQ704IRutbFK6Dm+gwpE3tMoKQaysbwfvl4dz
         9z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781657057; x=1782261857;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQq++K17JRNcTpXKTVWZr3Aw/CAliMfIgrA0KhotXMI=;
        b=ZnzKFl9hqJN85jyfMNbwAbTqOj2UBuRdYHntYfHQvj0AdApXdHDnbxL21Sau5oGkh9
         qqkR26iOL/925mKQmcw9CZ5u9QqEqe0JS+MIjCcyR/0N2ytYy2VsreqeHOmHIRVxqjze
         T/mNJ0Qk/m7xsmM03l1iZ9Isnegghg6UnbhNk8jHFtNOyOWBqKKCLZrkOqRlhPyg+yPx
         aHB5KaW5VJz+7F5yxyNxIX0YE4bXJ5ONwOheeQvKfD1Ia0IZnEAJxfmRruZ6nmcDCYdz
         +BK42caGelv6bBPzYc0Fm97oUx9/XDB4uyi2qXlzLlEOMmZ/BGEB+zb/jPAE0yvAO2wK
         C1dg==
X-Gm-Message-State: AOJu0Yz3/o0Jb3q/GsrcWXfdVDbTboPIh/RUhPvfFhzADUU229U5go3L
	0B7DrGkuDgv47vaqRTEzGHuIrN0tBTkH+QMmJJdGBeuIUN6Wb50uGO7a4luMV/TTcDc=
X-Gm-Gg: AfdE7ckvzBtxnbIwrINX44Ohpgi/A87JhswIhMhKc9wlyEQX9EzBvXwljW/xrz301pc
	CV84s9dHGk/vJeDKMmsU7vEM/Otk1m3niUbo+Wkmw8oST0q9JHr/T4Ym/SVHWTpCK0Vo6Xt6Xqj
	6vx5XyaCxjX5KiltGZKlQH8jfvV8M6pWjAKQwi4B8VyX7EqKl2LqLW9HFPZE77cKaAq59gJy4Gi
	k8CamLz1Av3gqCOP77XU+F16A2IgkqNbDmGXNfJRO6T+sMwad0P85ckBZJ3HHIAty6hrO+aB33V
	B1bhNobquI4BLVCsJtv6NmkJa7ktY0t5QXY0u5AmipDVkyHdv7tKGyHZJNmMHUBwVqXzOT/7rjA
	mgkhjP0iOnpJTw4N8xGFHqnawtWJRkLLk/UVs6ZsCnOdpVcYdEBTfvGfX34KOXTHKu7ZZBEa98n
	Gf8QD7
X-Received: by 2002:a05:7301:578a:b0:2ee:7b2e:8a3e with SMTP id 5a478bee46e88-30bcee0e1e2mr582639eec.1.1781657056551;
        Tue, 16 Jun 2026 17:44:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2568])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30b6191bf9asm15241079eec.31.2026.06.16.17.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 17:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 20:44:13 -0400
Message-Id: <DJAWPR7RA9VX.2LHJ0V3EVGR7S@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, "Andrew Werner" <awerner32@gmail.com>,
 "Zvi Effron" <zeffron@riotgames.com>, "Andrii Nakryiko" <andriin@fb.com>
Subject: Re: [PATCH bpf 2/6] libbpf: ringbuf: Prevent NULL callback crash
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tamir Duberstein" <tamird@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Andrea Righi" <arighi@nvidia.com>, "Xu Kuohai"
 <xukuohai@huawei.com>, "Andrea Righi" <andrea.righi@canonical.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
 <20260613-bpf-ringbuf-fixes-v1-2-e623481cb724@kernel.org>
In-Reply-To: <20260613-bpf-ringbuf-fixes-v1-2-e623481cb724@kernel.org>

On Sat Jun 13, 2026 at 9:48 PM EDT, Tamir Duberstein wrote:
> ring_buffer__new() and ring_buffer__add() allow a NULL sample
> callback. When callback-based consumption reaches such a ring, it calls
> through the NULL function pointer and crashes.
>
> Validate every ring in a manager before polling or consuming. Return
> -EINVAL without consuming records from an earlier valid ring or waiting
> for an event. Perform the same check before honoring a zero record bound
> so invalid callback consumption consistently reports the error.
>

Can we just prevent a ring from being added with a NULL sample_cb?
What's the use for permitting it? Even if we don't, rechecking the
callbacks every single time we consume the ringbuf seems overkill.

> Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
>  tools/lib/bpf/libbpf.h                           | 11 ++-
>  tools/lib/bpf/ringbuf.c                          | 41 +++++++++--
>  tools/testing/selftests/bpf/prog_tests/ringbuf.c | 93 ++++++++++++++++++=
++++++
>  3 files changed, 134 insertions(+), 11 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index bba4e8464396..9ba6b9ad3498 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1526,18 +1526,17 @@ LIBBPF_API int ring__map_fd(const struct ring *r)=
;
>   *
>   * @param r A ringbuffer object.
>   * @return The number of records consumed (or INT_MAX, whichever is less=
), or
> - * a negative number if any of the callbacks return an error.
> + * a negative error code on failure.
>   */
>  LIBBPF_API int ring__consume(struct ring *r);
> =20
>  /**
> - * @brief **ring__consume_n()** consumes up to a requested amount of ite=
ms from
> - * a ringbuffer without event polling.
> + * @brief **ring__consume_n()** consumes up to a requested number of rec=
ords
> + * from a ringbuffer without event polling.
>   *
>   * @param r A ringbuffer object.
> - * @param n Maximum amount of items to consume.
> - * @return The number of items consumed, or a negative number if any of =
the
> - * callbacks return an error.
> + * @param n Maximum number of records to consume.
> + * @return The number of records consumed, or a negative error code on f=
ailure.
>   */
>  LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
> =20
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index f2bb619d5a75..ae7fa79b6217 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -231,6 +231,24 @@ static inline int roundup_len(__u32 len)
>  	return (len + 7) / 8 * 8;
>  }
> =20
> +static int ringbuf_validate(const struct ring *r)
> +{
> +	return r->sample_cb ? 0 : -EINVAL;
> +}
> +
> +static int ringbuf_validate_callbacks(const struct ring_buffer *rb)
> +{
> +	int i, err;
> +
> +	for (i =3D 0; i < rb->ring_cnt; i++) {
> +		err =3D ringbuf_validate(rb->rings[i]);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static int64_t ringbuf_process_ring(struct ring *r, size_t n)
>  {
>  	int *len_ptr, len, err;
> @@ -240,6 +258,9 @@ static int64_t ringbuf_process_ring(struct ring *r, s=
ize_t n)
>  	bool got_new_data;
>  	void *sample;
> =20
> +	err =3D ringbuf_validate(r);
> +	if (err)
> +		return err;
>  	if (n =3D=3D 0)
>  		return 0;
> =20
> @@ -284,14 +305,17 @@ static int64_t ringbuf_process_ring(struct ring *r,=
 size_t n)
>   * records.
>   *
>   * Returns number of records consumed across all registered ring buffers=
 (or
> - * n, whichever is less), or negative number if any of the callbacks ret=
urn
> - * error.
> + * n, whichever is less), or a negative error code on failure.
>   */
>  int ring_buffer__consume_n(struct ring_buffer *rb, size_t n)
>  {
>  	int64_t err, res =3D 0;
>  	int i;
> =20
> +	err =3D ringbuf_validate_callbacks(rb);
> +	if (err)
> +		return libbpf_err(err);
> +
>  	for (i =3D 0; i < rb->ring_cnt; i++) {
>  		struct ring *ring =3D rb->rings[i];
> =20
> @@ -309,14 +333,17 @@ int ring_buffer__consume_n(struct ring_buffer *rb, =
size_t n)
> =20
>  /* Consume available ring buffer(s) data without event polling.
>   * Returns number of records consumed across all registered ring buffers=
 (or
> - * INT_MAX, whichever is less), or negative number if any of the callbac=
ks
> - * return error.
> + * INT_MAX, whichever is less), or a negative error code on failure.
>   */
>  int ring_buffer__consume(struct ring_buffer *rb)
>  {
>  	int64_t err, res =3D 0;
>  	int i;
> =20
> +	err =3D ringbuf_validate_callbacks(rb);
> +	if (err)
> +		return libbpf_err(err);
> +
>  	for (i =3D 0; i < rb->ring_cnt; i++) {
>  		struct ring *ring =3D rb->rings[i];
> =20
> @@ -334,13 +361,17 @@ int ring_buffer__consume(struct ring_buffer *rb)
> =20
>  /* Poll for available data and consume records, if any are available.
>   * Returns number of records consumed (or INT_MAX, whichever is less), o=
r
> - * negative number, if any of the registered callbacks returned error.
> + * a negative error code on failure.
>   */
>  int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
>  {
>  	int i, cnt;
>  	int64_t err, res =3D 0;
> =20
> +	err =3D ringbuf_validate_callbacks(rb);
> +	if (err)
> +		return libbpf_err(err);
> +
>  	cnt =3D epoll_wait(rb->epoll_fd, rb->events, rb->ring_cnt, timeout_ms);
>  	if (cnt < 0)
>  		return libbpf_err(-errno);
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
> index 4f0558f14847..9ce996bcea8c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -401,6 +401,97 @@ static int process_n_sample(void *ctx, void *data, s=
ize_t len)
>  	return 0;
>  }
> =20
> +static int process_noop_sample(void *ctx, void *data, size_t len)
> +{
> +	return 0;
> +}
> +
> +static void ringbuf_null_cb_subtest(void)
> +{
> +	struct test_ringbuf_n_lskel *skel_n;
> +	struct ring_buffer *ringbuf =3D NULL;
> +	struct ring *ring;
> +	unsigned long consumer_pos;
> +	int no_cb_map_fd =3D -1;
> +	int err;
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
> +	syscall(__NR_getpgid);
> +
> +	no_cb_map_fd =3D bpf_map_create(BPF_MAP_TYPE_RINGBUF, NULL, 0, 0,
> +				      getpagesize(), NULL);
> +	if (!ASSERT_OK_FD(no_cb_map_fd, "bpf_map_create"))
> +		goto cleanup;
> +
> +	/* Manager APIs must validate all rings before consuming any of them. *=
/
> +	ringbuf =3D ring_buffer__new(skel_n->maps.ringbuf.map_fd,
> +				   process_noop_sample, NULL, NULL);
> +	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
> +		goto cleanup_fd;
> +
> +	ring =3D ring_buffer__ring(ringbuf, 0);
> +	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
> +		goto cleanup_ringbuf;
> +
> +	err =3D ring_buffer__add(ringbuf, no_cb_map_fd, NULL, NULL);
> +	if (!ASSERT_OK(err, "ring_buffer__add_no_cb"))
> +		goto cleanup_ringbuf;
> +
> +	consumer_pos =3D ring__consumer_pos(ring);
> +	ASSERT_GT(ring__producer_pos(ring), consumer_pos,
> +		  "producer_pos_mixed_cb");
> +
> +	err =3D ring_buffer__consume_n(ringbuf, 0);
> +	ASSERT_EQ(err, -EINVAL, "ringbuf_consume_zero_mixed_cb");
> +	err =3D ring_buffer__consume(ringbuf);
> +	ASSERT_EQ(err, -EINVAL, "ringbuf_consume_mixed_cb");
> +	err =3D ring_buffer__poll(ringbuf, 0);
> +	ASSERT_EQ(err, -EINVAL, "ringbuf_poll_mixed_cb");
> +	ASSERT_EQ(ring__consumer_pos(ring), consumer_pos,
> +		  "consumer_pos_mixed_cb");
> +
> +	ring_buffer__free(ringbuf);
> +	ringbuf =3D
> +		ring_buffer__new(skel_n->maps.ringbuf.map_fd, NULL, NULL, NULL);
> +	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new_no_cb"))
> +		goto cleanup_fd;
> +
> +	ring =3D ring_buffer__ring(ringbuf, 0);
> +	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring_no_cb"))
> +		goto cleanup_ringbuf;
> +	consumer_pos =3D ring__consumer_pos(ring);
> +
> +	err =3D ring_buffer__consume_n(ringbuf, 0);
> +	ASSERT_EQ(err, -EINVAL, "ringbuf_consume_zero_no_cb");
> +	err =3D ring__consume_n(ring, 0);
> +	ASSERT_EQ(err, -EINVAL, "ring_consume_zero_no_cb");
> +	err =3D ring__consume(ring);
> +	ASSERT_EQ(err, -EINVAL, "ring_consume_no_cb");
> +	ASSERT_EQ(ring__consumer_pos(ring), consumer_pos, "consumer_pos_no_cb")=
;
> +
> +cleanup_ringbuf:
> +	ring_buffer__free(ringbuf);
> +cleanup_fd:
> +	close(no_cb_map_fd);
> +cleanup:
> +	test_ringbuf_n_lskel__destroy(skel_n);
> +}
> +
>  static void ringbuf_n_subtest(void)
>  {
>  	struct test_ringbuf_n_lskel *skel_n;
> @@ -579,6 +670,8 @@ void test_ringbuf(void)
>  		ringbuf_subtest();
>  	if (test__start_subtest("ringbuf_n"))
>  		ringbuf_n_subtest();
> +	if (test__start_subtest("ringbuf_null_cb"))
> +		ringbuf_null_cb_subtest();
>  	if (test__start_subtest("ringbuf_map_key"))
>  		ringbuf_map_key_subtest();
>  	if (test__start_subtest("ringbuf_write"))

