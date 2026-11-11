Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367598;
	b=tN9YtR4EFhbk1CVpBfSx0/8wm6nkERm75bzh6thnxtQDSE6lKVpZURkgAwR8TZrJvXL3
	 UXIdumLkHN2Wiwr9lrnZtirfzDOcApraUXTKfD7Seg62Va98m2qjkVn0e1HUBva6IVU9m
	 yU3RFFYlHxXy06qnSTkFkDlsySp8xXqHxFGnPWkDGQqU/FzweVdXeFJrrSer5+rWS3ED3
	 4r9+U7eEm06K/defjFrbVZ6ftuoFk2MiGmcHzeOMKQ2L8JcT6cOK9S2wGAWz9nBEKmDir
	 pA14Aa5hHNZz52R42M3Y+o4D1fkaw9eifAE5lZoGyasVCooXf1QHIvg2gePbh4PaeeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hTry4qF1g7TCZ3FI+vYm/86G67YWfgMY0W1qBsQJ1PY=;
	b=0kOXb5RHVdboJJpoGeRwQCgUPB8rvaV8DTsZAJe/6IzVWjdjZUgHc+gPnLLcTAl17bTP
	 fLOmg3fA9AadDgBI1jq7fdyFwEudtZD8b6TnWFA/V9dffP7XN4M43YmVl76hQ202J/vqb
	 xSjuhQ0EwDUEJw4Q5Px0RfqX4f9c5emkw+O5zXyh1TJvyDGGtEZ3tQx/9Fw7TJsTKeWy4
	 4EooK5SOC+FD05BWyNPgJejR7Z2jyYix5PYiDcxeSoCWNDEeRLb2tS0qbbGJ3PCndjiGU
	 qNi5KDlLNH+W+1BEUUzpt0tioxB7nH/Yb6/L+RTegSQlFDVxou5e7Fx0JNrfPd+AWrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHfoWWaW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69164606A320
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHfoWWaW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E895A1F0089F;
	Wed, 11 Nov 2026 03:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794367598;
	bh=hTry4qF1g7TCZ3FI+vYm/86G67YWfgMY0W1qBsQJ1PY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JHfoWWaWwN/rKuXkAocUZ021rAZfftPzy6x2jEfwefxSmekbiJ5tW5Ezgksc32F/6
	 88xJ7FiAndBGwhy2V/pim5fgo7aR4FcDTNMW7UAV5jTZbm0CQ01cdIXSOYVkR2v1cu
	 OLp3HH5aAW+X5MiwuesWi3BdpL5Rj+YhCZ2s88B5YG5fhjbb1FMs6xawkswZZ0r/6j
	 6N8FlsJAdjko0Ue7yMWP0jT/w4ePa4byRlCnxYpcJJkfA/KIZrBpOkA4javLE+Ikza
	 +xZD9Aqdbai+Yz7+pGzFts9gEXcfJmX9ouhfZBOabCQqTn8XVxz5xdgZanLUbfHU8A
	 yX9RrIUHRwxsg==
Message-ID: <sashiko-outbox-208194@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Mark task work FREED before
 detaching it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Lu" <luyun_611@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261111024333.228633-2-luyun_611@163.com>
References: <20261111024333.228633-1-luyun_611@163.com>
 <20261111024333.228633-2-luyun_611@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:26:37 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf: race in bpf_task_work_cancel_and_free() on concurrent
  cancellation
--

commit ba93530a5f1bdfb22fe067f66a5dec0d9c8f3f5a
Author: Yun Lu <luyun@kylinos.cn>

bpf: Mark task work FREED before detaching it

This commit marks a BPF task work context as BPF_TW_FREED before clearing
the map value's context slot in bpf_task_work_cancel_and_free() so a
concurrent map deletion does not observe an empty slot while a detached
context can still transition to BPF_TW_RUNNING.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 937a0d7d68390..4b252ca61166b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -5174,11 +5174,21 @@ void bpf_task_work_cancel_and_free(void *val)
>  	struct bpf_task_work_ctx *ctx;
>  	enum bpf_task_work_state state;
> =20
> -	ctx =3D xchg(&twk->ctx, NULL);
> +	/* Another canceller can release the map-owned context reference. */
> +	guard(rcu)();
> +	/* Order a preceding unlink before observing an empty slot. */
> +	smp_mb();
> +	ctx =3D READ_ONCE(twk->ctx);
>  	if (!ctx)
>  		return;
> =20
> +	/* Stop callbacks before making the context invisible to deletion. */
>  	state =3D xchg(&ctx->state, BPF_TW_FREED);
> +	/* Only the first FREED transition detaches ctx and owns the map's ref.=
 */
> +	if (state =3D=3D BPF_TW_FREED)
> +		return;
> +	WRITE_ONCE(twk->ctx, NULL);

[Severity: Medium]
Can a second concurrent bpf_task_work_cancel_and_free() return with the
BPF_TW_FREED context still attached to twk->ctx, or miss a newly published
context?

array_map_update_elem() updates an element in place and calls
bpf_obj_cancel_fields() without a lock:

  array_map_update_elem()
    bpf_obj_cancel_fields()
      bpf_task_work_cancel_and_free()
        ctx =3D READ_ONCE(twk->ctx)
        xchg(&ctx->state, BPF_TW_FREED)
        <irq>
          array_map_update_elem()
            bpf_obj_cancel_fields()
              bpf_task_work_cancel_and_free()
                ctx =3D READ_ONCE(twk->ctx)
                state =3D xchg(&ctx->state, BPF_TW_FREED)
                if (state =3D=3D BPF_TW_FREED)
                  return;
            bpf_task_work_schedule_signal()
              bpf_task_work_acquire_ctx()
                bpf_task_work_fetch_ctx()  <-- sees old BPF_TW_FREED ctx
        WRITE_ONCE(twk->ctx, NULL)

Because twk->ctx has not been cleared when the second canceller returns,
bpf_task_work_fetch_ctx() sees the non-NULL pointer and returns the dead
BPF_TW_FREED context instead of allocating a new one, causing
bpf_task_work_acquire_ctx() to fail with -EBUSY.

Conversely, if the second canceller reads the old context C1 before the
first canceller clears twk->ctx, and a concurrent bpf_task_work_fetch_ctx()
installs a new context C2 once twk->ctx becomes NULL, the second canceller
sees C1->state =3D=3D BPF_TW_FREED and returns without detaching or cancell=
ing
C2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111024333.2286=
33-1-luyun_611@163.com?part=3D1
