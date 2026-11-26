Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665634;
	b=zgTKl8H+3XozUWz0Sib86ly3v6IY2M8XA4AfvN9TI3PwBmgxplurO4u6MjrBceZ9Gpo7
	 +a0ITequTTZxwyAq29oKI5g69ArPgI8E08wM6sN6br4UIYex/VSbEMSpXHHX7BKzbipdy
	 FAS4ycgf4ThqVhXWQnkepMSP7jNGNiLUxDLz1NU7+LqsyJfac40ZISXOBAQFvo0CCIxL2
	 VQF0UOIfK7ciXwULVS1NlI1cJNHiM0sDL+pmfrnXJExscJKlzV8vDXHO0MvxY+zxSMYXr
	 aNSjlVFevvZYqZrX07iIwanwc3ONlaDWwDb7rza5iUXAhR/C84LfnGd0TtwiA4eWk1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665634;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/HPS6EkeQA9RkkLl3eNW2WJ9QbHQGpKEWqfpK4/AxEs=;
	b=en0oeQQKGi/GVhQjTvlGUmeTXnuHUYSldrLKOaKq0YpZCIgC58VXowWZ4PV0WZF3OXnh
	 uj07lWOFrJjzcCbAPNmLLNI5gHwBsC47UkEZcXiY8sRqlNfemGhMrB6L6VU0WK8J6OpMK
	 1/JMtIugwpdHMwGowUMERRXn30a1jX9NcepzOGHzuJpJ+LBER1LZgnYEBxubGJrJj1vx0
	 ZvOxnyOKzUOTvYtmD4yR0VpOdbVmDB+v4nZqGbLYbl/lG74RtDTSwpeLbSVo4ZSUNIeVN
	 f0xu7/TL07Q/Af4pJdsBYpLgq8J1mP3sEbI4sFC63A6wE8cQvYZf4pQseA1YUY8Ji4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exiuZSLD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD880606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exiuZSLD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61251F000C4;
	Thu, 26 Nov 2026 04:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665634;
	bh=/HPS6EkeQA9RkkLl3eNW2WJ9QbHQGpKEWqfpK4/AxEs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=exiuZSLDeG3IwJSaVhPqJ4yAdC5w/76WotaDoBA32SOH+duAlYidAReR28bV+6Nzh
	 Ep/S3cyTGZxwtRSPuMEULlIwRMvpNPe0xUCthMiM88F8XVfiZ8S12SxV6fK8ST0s0w
	 u9rpNbOXZaUBeE0djrsyeSzRhhsuaoJlqv8LDhDVg9tF2ndSAhfsD53u0wLVNKAtGV
	 ow0GzKpFsG5vk0NrR/AzfGXjmPKI8Ao9dmtHuYTtdExRaLtxT2LRv4QvMdsgC3cqqS
	 uQDPG63TKDVFIe8oemjDfseoSbO02qsSXrwQ+vbBtaKs7TSL9H/zhOJIckzK71uouL
	 u7xLPr14Qdc4g==
Message-ID: <sashiko-outbox-234714@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Set the run context for async callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261126033114.4111944-1-alexei.starovoitov@gmail.com>
References: <20261126033114.4111944-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 04:00:33 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] bpf: use-after-free in bpf_timer_cb() [1]
--

commit dec841fde8b353a2dff54ed68ef5d92e5156f040
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Set the run context for async callbacks

This commit sets a dedicated run context (bpf_async_run_ctx) for BPF
asynchronous callbacks and rejects helpers that rely on the arming hook's
task or socket context.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1b95fe795b4d9..490dd14b6a70c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1219,12 +1219,25 @@ static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtim=
er_running);
> =20
>  static void bpf_async_refcount_put(struct bpf_async_cb *cb);
> =20
> +struct bpf_run_ctx bpf_async_run_ctx;
> +
> +static void bpf_run_async_cb(struct bpf_prog *prog, bpf_callback_t callb=
ack_fn,
> +			     struct bpf_map *map, void *key, void *value)
> +{
> +	struct bpf_run_ctx *old_ctx =3D bpf_set_run_ctx(&bpf_async_run_ctx);
> +	struct bpf_timed_may_goto saved;
> +
> +	bpf_timed_may_goto_save(prog, &saved);
> +	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
> +	bpf_timed_may_goto_restore(prog, &saved);
> +	bpf_reset_run_ctx(old_ctx);
> +}
> +
>  static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>  {
>  	struct bpf_hrtimer *t =3D container_of(hrtimer, struct bpf_hrtimer, tim=
er);
>  	struct bpf_map *map =3D READ_ONCE(t->cb.map);
>  	struct bpf_prog *prog =3D READ_ONCE(t->cb.prog);
> -	struct bpf_timed_may_goto saved;
>  	void *value =3D t->cb.value;
>  	bpf_callback_t callback_fn;
>  	void *key;
> @@ -1245,10 +1258,8 @@ static enum hrtimer_restart bpf_timer_cb(struct hr=
timer *hrtimer)
> =20
>  	key =3D map_key_from_value(map, value, &idx);
> =20
> -	bpf_timed_may_goto_save(prog, &saved);
> -	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
>  	/* The verifier checked that return value is zero. */
> -	bpf_timed_may_goto_restore(prog, &saved);
> +	bpf_run_async_cb(prog, callback_fn, map, key, value);

[Severity: Critical]
This problem wasn't introduced by this patch, but can bpf_timer_cb() pass a
freed map element value to callback_fn() [1]?

htab_map_delete_elem() unlinks the element and cancels any existing async
callbacks in free_htab_elem(), but another CPU that looked up the element
under RCU before it was unlinked can still call __bpf_async_init() and arm
a new timer on it:

CPU0                                CPU1
htab_map_delete_elem()
  hlist_nulls_del_rcu(&l->hash_node)
  free_htab_elem()
    ...                             __bpf_async_init()
                                      hrtimer_setup(&t->timer, ...)
                                      cmpxchg(&async->cb, NULL, cb)
                                    ...
  /* RCU grace period expires, l is freed */
                                    bpf_timer_cb()
                                      bpf_run_async_cb(..., value)
                                        <-- use-after-free

Because the element has already passed free_htab_elem(), nothing cancels
the newly initialized timer before the element is freed after the RCU grace
period, leaving bpf_timer_cb() to pass reclaimed memory to the BPF program.

[1] https://sashiko.dev/#/bug/linux-25136054-3592-42c2-bca7-ba4763a56761

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126033114.4111=
944-1-alexei.starovoitov@gmail.com?part=3D1
