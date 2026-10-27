Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126907;
	b=KdawShhuydU5vx5xtSMYo345dgUsbxFjkbFuYDf25sh3hEXTFy7RhGjFbsjLJshwKdOD
	 iq6Zop5ZKh8JOI/afbNkFMAzOVQySkJtHshKMyttTOtlm+D4NMJ/l4tq5R0Qcne/7B961
	 +8x8xV/UNTjHR7p7Yv6Q2ORcgzT3zXTj2oDtWHMJjl6yzjZnObTIW12rAvyxrW+1HYkdn
	 IQ0YaeYXpCgbQNauDJA45Am57J+7ZkfAnNCwAS9IW6mnAL8xefCcOuryrKnesDiAXj0T1
	 AyDkM2voR+t36Ba2y8dJWC/SkQu3pSPwLC4tdn9i/P8Tf1/jzCwejXZy1xNKfV6mBdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=LSFaznbuOQ+uxmdx/4va9jmv6eJhsUjrnyeRc7YdC00=;
	b=GlT9U6/kVT+cEIf1+gv5Nqk1iQrdX/odpjqKaSq2lH0Jk8wfKmBvGy/SkjJkj6bBiIA8
	 qFXfJU84VQeVRG30Zik8NZAu6Gu8vYvYg//1Fp+MOQhAoOXf+6/s9gBA1cL4i3fhgpw55
	 cOjZ49RfGuAULJt3ksNiM8eX+VoKqoC6u77BFRYNNDxOs8sIwoyHivrYTeH8EwrL87RYZ
	 lCB0EOJOs0s2R3LkZYn+OCG33pR4mGkKafVX1UXFOqRlqnq/t7nWtaM6p21ItPLepWxvi
	 DWa8eeEvTDW6/8zjE/n6MBSSHe+eMdla8tFvZUPVsRk6ZZ/mWfKwS0AX/mqio+jIhZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nw5rrMdO;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E0606A31E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 675E0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nw5rrMdO
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so1357625e9.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793126906; x=1793731706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LSFaznbuOQ+uxmdx/4va9jmv6eJhsUjrnyeRc7YdC00=;
        b=nw5rrMdOp0TYEl9JoKQnemMC1gMbq2N680wtMJPF/UINyy1xhTQ+raluWjIibAUI5B
         q6LzZemepo/DuXqeBqZWNHXnoIhmAUAX9SWiVbhJ4DLMLNDRFXwiC973OCYbpe6eqws8
         aHCj3srVFBes9syZDCA+HTNf0EhPz6l453dWlWqMldIYFQCSQ3IC8sAflSteWvlmfTGv
         QJVo95j9BStfCM2hovZru3ovVAX2cRBY2MOBNT6nSjPQWCcTfsiPjic1zLH1BcwFKOQQ
         wyBt3n2uFHRULjRBDdY4guxXWlrhyyR5gO01GoT4ZvrUYlIgm9BaWBvQEgDEijK+JFuK
         PXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793126906; x=1793731706;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LSFaznbuOQ+uxmdx/4va9jmv6eJhsUjrnyeRc7YdC00=;
        b=Cdvw4wxjbOU8KWDzmaibCd1jK8hDRdudDk/QFvk1j5nDMc0BsBE7QFB55fxpR2bIJ0
         ZafNpUq9hiJdyWExgzZUkx38dnmXeHj+4HPmMtIoWTHLwsslNq2L9HDysphstJjwR/H6
         MMsvHvvds1JoZjqx2QqIwVGlv/ykQMlZe/5/jwm+2/bazv5MF0SZrdNHzJRLbI0cZRxC
         364yWEfwaRv6vZtRTKCuzqAzsFYc2eHs2w3Oc4wmWrLT4seCEopGpnxDGmGN03OMuwSK
         JNbWZIfY8YUcEGDNXFlIMLzPNuwtPSLKeFexkw/1HsQlo2UTeajiPV+Z1i43T19sQ3uR
         N3SQ==
X-Forwarded-Encrypted: i=1; AKwUvBy39sjjGku5S52GQ4Ki0+Jqzr9WlZN2ZqPmDRt2OTwuuJcsXS+enwOtZnDRLsHRnzGN6qU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKU0RR0kKz2lhEm+Wfa602fPqaWp7RiKMFwrwGicZlcYcIObvfp
	ZS7tWk+DPbCrpGwuPOvQQAIWW7dPMz5XXSuI/P/6DNYuu3O6E5CBQmjr
X-Gm-Gg: AYBFou3AVNP37qEYRgbFZsmW5StQrTHK17nkKnnMogbLnPM9tzIvrxkDOmlSsSB2Jea
	iY/uxr3rCQVKAqJMaU94uYg6Kq+PqyDnJP/yXxfMqp0WJ4AVvpgbVDCwIPWSPXbD9vSI4CmbPHQ
	RPKoGFVUX7Hvo+wPFhxKtPUBWgbUR2Z5H0ERK6V9NdElgKpfSVN611a/HOBAVKAdhU0FdZpEqPn
	PqNXDhOHkp8YDxnLYIfnnq5ysXo11LbtGTRcUKud47njLFWRadleXsD6SxqFJOu4fprsTO8403q
	EwknA6GXMwTn2Twwh/bSyauiRySfZ2c5K/fwiuYgv93ZSi4K6xOTig4FGYGedXMElelk+HrVSv1
	DbznMeloOo+roPnMbfJM8fKm3dwPMYFvnLVFU6XKVwD7Hp8CAWmCXw8GZuNMeZHXoWKbDAlnAQz
	ipBSEQUZEMbLLwCJ4m5BFckWdzq8P5BSMedSHzyeKD808KUApo9TLt00vboJhfr8ieCKD88lSNN
	3h+bLH4yHQluFc9MCe1L36W/xnrVNSHONqIIhgdm0VMtafipaSfcLn7MaIeI6rUa5uMRcf2nq6q
	5PpJOgsw8xZVddd2hno=
X-Received: by 2002:a05:600c:4704:b0:4a2:967:dfb8 with SMTP id 5b1f17b1804b1-4a35acb115cmr224336505e9.20.1793126905543;
        Tue, 27 Oct 2026 11:48:25 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a9493bc4a8sm4645705e9.0.2026.10.27.11.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:48:25 -0700 (PDT)
Date: Tue, 27 Oct 2026 19:48:23 +0100
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Mani Tofigh <mt4022@columbia.edu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, tz2294@columbia.edu
Subject: Re: [PATCH bpf] bpf: Fix bpf_timer callback running on a freed map
Message-ID: <auDx91tmsF-aKKdz@gmail.com>
References: <20261027-bpf-timer-freed-map-v1-1-30402b0ee99b@columbia.edu>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-bpf-timer-freed-map-v1-1-30402b0ee99b@columbia.edu>

On Tue, Oct 27, 2026 at 01:03:42PM -0400, Mani Tofigh wrote:
> A bpf_timer in an inner map can fire after the map has been freed, and
> bpf_timer_cb() then reads the freed map:
> 
>   [   50.709520] BUG: KASAN: slab-use-after-free in bpf_timer_cb+0x249/0x290
>   [   50.709540] Read of size 4 at addr ff11000003bc1030 by task bpftimer/72
>   ...
>   [   50.710783] Freed by task 12:
>   ...
>   [   50.710826]  bpf_map_free+0x1a2/0x380
> 
> When user space closes the map, its timers are cancelled and their
> callbacks are cleared.  Since commit 1bfbc267ec91 ("bpf: Enable
> bpf_timer and bpf_wq in any context"), bpf_timer_set_callback() and
> bpf_timer_start() run without a lock, so a program that found the timer
> just before the close can still use it afterwards:
> 
>   Task A                  Task B                  Task C
>   ------                  ------                  ------
>   bpf_timer_start()
>     finds the timer
>                           bpf_timer_set_callback()
>                             finds the timer
>                                                   close(map_fd)
>                                                     clears the callback
>                                                     cancels the timer
>                             sets the callback
>     arms the timer
>                                                   deletes the map from
>                                                   the outer map
>                                                     map is freed
>   the timer fires
>     bpf_timer_cb() reads the freed map
> 
> The timer is cancelled once more when it is finally freed, but that
> happens well after the inner map is freed, so a timer started this way
> can still fire on the freed map.
> 
> Clear the timer's map pointer in bpf_async_cancel_and_free() before the
> map can be freed, and make the bpf_timer and bpf_wq callbacks return
> early when it is NULL.  The map is not freed until callbacks that are
> already running have finished, so a callback either sees the map while
> it is still valid or sees NULL.
> 
> The reproducer below calls the two helpers in a loop on two CPUs while a
> third CPU keeps creating an inner map with a timer, closing it and
> removing it from the outer map.  This bug was identified and confirmed
> with the help of a deterministic hypervisor currently under development,
> but the non-deterministic C reproducer can typically trigger it in the
> 1-50s time range.  With the fix, nothing is triggered after 600 seconds.
> 
> Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>

Tested-by: Mahe Tardy <mahe.tardy@gmail.com>

See below for testings details.

Review-by: Mahe Tardy <mahe.tardy@gmail.com>

For the review part, I'm not a concurency expert but this looks good to
me, bpf_timer_cb() should run within RCU protection from the softirq
context that calls it and bpf_wq_work() is explicitely calling the
rcu_rea_lock()/unlock(), thus:
- the callbacks read the pointer before the cleanup clears it: it's fine
  since it's not freed yet thanks to RCU protection (and for
  bpf_wq_work(), the read was moved in the RCU section).
- the callbacks read the pointer after the cleanup clears it: it's NULL
  and we have new if (!map) checks so that it returns early.

> ---
> This is a different use-after-free from the one fixed by "bpf:
> Dissociate struct_ops progs before the grace period of the map" in
> Qiliang Yuan's v6 struct_ops series [1].  There, a timer callback
> returns into the freed trampoline of a struct_ops map.  Here, the
> callback reads the freed map that holds the timer.
> 
> [1] https://lore.kernel.org/all/20261022-selftests-bpf-struct-ops-assoc-timer-v6-2-2c0f18e82582@gmail.com/
> 
> Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/bpftimer.c

I tested the reproducer and indeed on bpf-next HEAD (which was
4169c9c90532 ("powerpc/irq: Fix build with CONFIG_PROC_FS=n")), I could
reproduce the issue quickly:

	[+] bpftimer: bug: the kernel reported an error after 275 rounds, 0.5 s (taint 0 -> 32)
	LB-RESULT bug rounds=275 seconds=0.5

with: 

	[   16.088731] BUG: KASAN: slab-use-after-free in bpf_timer_cb+0x205/0x270
	[   16.088772] Read of size 4 at addr ffff888138615838 by task a.out/539

And after applying your fix:

	bpftimer: maps and programs loaded, racing for up to 600 s
	bpftimer: 17794 rounds, 30 s
	[...]
	bpftimer: 350440 rounds, 570 s
	[+] bpftimer: no bug in 369186 rounds, 600.0 s
	LB-RESULT none rounds=369186 seconds=600.0

> ---
>  kernel/bpf/helpers.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 648abe1ba63a..58e357302850 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1221,7 +1221,7 @@ static void bpf_async_refcount_put(struct bpf_async_cb *cb);
>  static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>  {
>  	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
> -	struct bpf_map *map = t->cb.map;
> +	struct bpf_map *map = READ_ONCE(t->cb.map);
>  	void *value = t->cb.value;
>  	bpf_callback_t callback_fn;
>  	void *key;
> @@ -1229,7 +1229,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>  
>  	BTF_TYPE_EMIT(struct bpf_timer);
>  	callback_fn = rcu_dereference_check(t->cb.callback_fn, rcu_read_lock_bh_held());
> -	if (!callback_fn)
> +	if (!callback_fn || !map)
>  		goto out;
>  
>  	/* bpf_timer_cb() runs in hrtimer_run_softirq. It doesn't migrate and
> @@ -1254,7 +1254,7 @@ static void bpf_wq_work(struct work_struct *work)
>  {
>  	struct bpf_work *w = container_of(work, struct bpf_work, work);
>  	struct bpf_async_cb *cb = &w->cb;
> -	struct bpf_map *map = cb->map;
> +	struct bpf_map *map;
>  	bpf_callback_t callback_fn;
>  	void *value = cb->value;
>  	void *key;
> @@ -1265,8 +1265,9 @@ static void bpf_wq_work(struct work_struct *work)
>  	/* keeps the program that callback_fn belongs to */
>  	rcu_read_lock_trace();
>  
> +	map = READ_ONCE(cb->map);
>  	callback_fn = READ_ONCE(cb->callback_fn);
> -	if (!callback_fn)
> +	if (!callback_fn || !map)
>  		goto out;
>  
>  	key = map_key_from_value(map, value, &idx);
> @@ -1733,6 +1734,8 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
>  	if (!cb)
>  		return;
>  
> +	/* Callbacks that run after this see NULL and return. */
> +	WRITE_ONCE(cb->map, NULL);
>  	bpf_async_update_prog_callback(cb, NULL, NULL);
>  	/*
>  	 * No refcount_inc_not_zero(&cb->refcnt) here. Dropping the last
> 
> ---
> base-commit: 195a3519ff27bff5575e05b5086e38ee92715776
> change-id: 20261026-bpf-timer-freed-map-ab8dbd268b51
> 
> Best regards,
> --  
> Mani Tofigh <mt4022@columbia.edu>
> 
