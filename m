Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2DF359A97
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582914; cv=pass; b=GcdCNJoTKRaCPC+qvhAgxqSa9hqP1Vk+H7mP6sO4zBJDSJhxQIngUYMF2+fxMIgn0eF/ZDL9cpMxtecRsWcJj8Lsm2AkvqkwNkoPpFgvvagYCf2BEkZga9UCVAfbMr17zpGlH5bgEZSNlE/uJV3ZcbLmXLwLEwdV4JAqQqqAgGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582914; c=relaxed/simple;
	bh=5Ru2YhEXAI7dlMIm2PMqAIu5X4YlrOQ5+v6CxXLlNy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsJf2yQOUIRNlLrVG8MdGvx356M1DWmoSYdQxSME1LlV5eyUzru4Gi1+nr61jdura2yV7o4s/FfBBlVHhGQbDoKkmMXWBoKp/r4GWxhlhSiThLhsH175La6T9MGCTrow6pjVWlpSfdleCRc/QTVRaKrgOAXIlf8pXGxHz0XsQk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJzyd9bE; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJzyd9bE"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-482f454be5bso25083475e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 20:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774582912; cv=none;
        d=google.com; s=arc-20240605;
        b=IRqtsrbqrmVGj1QPyAZ6payKlWO8JO49xbG/DtCnIaIpu6IquQwjH/4V3dKAIj2cGZ
         Q7hnOjQNLu7YqbNM2UY7nO0Yo1DjZpjRUtUGWb2nZkhNsQwT9b/jmyVH6anMyDIUnxlM
         4GLhFNowpgmwp7nkHgF9wNxE5jOzRWGg2RJu8/XzfFbdcY2Nmixjm5k3BBFNMKWeNi48
         0mVzhzr4irClzxah/Fc7pBMhpuAvSIrqD3ShA2zLX1tQLR9gWQZvzwI0rhaPsG8lRlxX
         7B9S0Un8Lb5dDyB15M6kE4YK+X6DmVzjVGwpZ4oRm9u/WnvUEMIFvje0Wlv/jvlm9+WS
         Ef3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NQN8Z3BXWFXzQgAxpw3e9/69wwl9g9s6ecFNIDS+jrk=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=FF7LnNhKtCyDOYSZlGrYhaHdVdNS89eCq8g6SPpiekcdKYV4A0yXKJ5E2GR5EpdtnJ
         pbJePyrQkx6LW9rgf76OjJdfS5+uFGYDUE/tTcwJuHbvCClfxS573zhmX42bWFx/222A
         C26EwaXcv9D2MRtBvhyHY7ejsnJihUN3kTCP0tv9ucuEEhdhiRXu1owjHz5rJil6QN1X
         /s6xFs0XWIp+ztSLisIXH1PgC0hQ/kE0St5paJh+iKSea0DcCom84RRl59TBvPCTN2Eu
         Al6Y96tZ5hBUa6HUBVGdHapXSW90XpKsTHyXm3i3aU+n/lXJG+JgJU6tQbdcb4ydTqum
         zuAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774582912; x=1775187712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NQN8Z3BXWFXzQgAxpw3e9/69wwl9g9s6ecFNIDS+jrk=;
        b=oJzyd9bE46RTNVz0yVU5nAkYEaUmu9gC4kpxyPk9kFlD+9YB8o9RhIHKhId3bLhtJj
         t5NvfwlJGJ1NxxuUAy3Q+gLOCxvwaZvKfC7R+l3EeE6iwzbnk8rDb36rNLUeRysANQOl
         vD51XSLyejIIL+eH3yofygLOWZOFzlqOyQtRjd32bNn2uYt4EbXYoizd5ajj19XxDGIH
         LCeWEZAkfFvrUmQrhu1h4pXU3+gqp8/uFbjgep6ZoK8+MCxHJS2s/l8+JWZTw3vOaGA7
         BipYGV1Ib2pgZ2v8tfLJQ06FucztEKc6ur/pxq5U0AnIhlr34MXaPNE/HHYDIp+Eug6G
         wt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774582912; x=1775187712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQN8Z3BXWFXzQgAxpw3e9/69wwl9g9s6ecFNIDS+jrk=;
        b=U5yrCfDtCFLJ6eSXL0GXLicw+F+hvqCxtiguyXthaoO2/Gsx3IERoOyXVvm1ypEaQ9
         f6v5ZSqloV4uq5CBhWwZwVKnqXEoPv8vd0U36S8UJ/PTLy3AOxBbfsfJ0eyeEj3Lt/qa
         RrnyjeixU43J3qK6hpemktpLeRgaxldPxdHqo6Soy1fDpT2QaO/sd7s8Nn00AAgMI5DT
         W/Rwf+BdjRMtTvNjLUFKN4XZ2DIHfiYXBhymwEHhrMxiEOjxo6r4kb4c/O+zN+PtTkUe
         CsDive1cR0Tv11WPC+pKkPs6dXHi7ZfYfOh+IW6kPgFw2DfjvZcvBgPcY4gRNqELzr9E
         ntCQ==
X-Gm-Message-State: AOJu0YzxDc0AnniZbKvMnsE0XBybk3vSAue/5tXMEAPzw0jbnoTtUyas
	40cNN6m7enxDgnwWgfFc6ZaFSuSO7NSvHhn7QL5fha1BMfG4QpkJIttnWihYxGjZmT/LHmnwMjC
	t+PGXVwReGs+y5fePYDSK4tt8SaUUrto=
X-Gm-Gg: ATEYQzz3GJv3f07i0CoyVozxA2hUIk2khP4u2CJX9NpZcQHf4XDA0aEHq//8JwT+e1a
	o1XEBUsKKdCYFy+awngfZRdYTvz4hKFJVF0h6pphpmsHL6LU9OmmufIdVqnjGxApghxIvjF3cKQ
	rVbpXgNfKYUleusBHJQaWRiHIePn0utogHXpne2kcxQFHeZhsjKO2xRmp8WjJvQb9QolVJa9L8x
	vU2wD1byNT/6ifsZLGziYmw8v7/wBbZrQDIBpkk9GiiNUoZ1wXRspaSd2xRT3mRGoVJ977PYaJN
	R+REOJkXNE1YIXurcIbiWy50vEgcxw5Mc650SwQNO34R2pgJA/e1B5p1BP5A
X-Received: by 2002:a05:6000:18a7:b0:439:ddc0:4bef with SMTP id
 ffacd0b85a97d-43b9eaad03amr1170162f8f.8.1774582911568; Thu, 26 Mar 2026
 20:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-kmalloc_special-v1-0-269666afb1ea@meta.com> <20260325-kmalloc_special-v1-1-269666afb1ea@meta.com>
In-Reply-To: <20260325-kmalloc_special-v1-1-269666afb1ea@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 27 Mar 2026 04:41:15 +0100
X-Gm-Features: AQROBzDj1BWI_kZI-b7KkrbdfQiAxRLQxfaBACLXC6DKbpDxuKAwCqXs6YElTvM
Message-ID: <CAP01T74d63iXXxz6UhjLQWgC_FOvJTrUbfrREcf=+qkshbOoag@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Migrate bpf_task_work to kmalloc_nolock
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

nit: I think you need to target bpf-next in next respin, patch subject
is incorrect.

On Wed, 25 Mar 2026 at 22:12, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Replace bpf_mem_alloc/bpf_mem_free with
> kmalloc_nolock/kfree_rcu for bpf_task_work_ctx.
>
> Replace guard(rcu_tasks_trace)() with guard(rcu)() in
> bpf_task_work_irq(). The function only accesses ctx struct members
> (not map values), so tasks trace protection is not needed - regular
> RCU is sufficient since ctx is freed via kfree_rcu. The guard in
> bpf_task_work_callback() remains as tasks trace since it accesses map
> values from process context.
>

I think a comment in both places would be useful. Also, this bit can
(should?) probably be a separate patch preceding the conversion.

> Sleepable BPF programs (e.g. BPF_PROG_TYPE_SYSCALL) hold
> rcu_read_lock_trace but not regular rcu_read_lock. Since kfree_rcu
> waits for a regular RCU grace period, the ctx memory can be freed
> while a sleepable program is still running. Add explicit
> rcu_read_lock/unlock around the pointer read and refcount tryget in
> bpf_task_work_acquire_ctx to close this race window.
>
> For the lost-cmpxchg path the ctx was never published, so plain kfree
> is safe.
> ---
> [...]
>
> @@ -4296,13 +4292,27 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
>  {
>         struct bpf_task_work_ctx *ctx;
>
> +       /*
> +        * Sleepable BPF programs hold rcu_read_lock_trace but not
> +        * regular rcu_read_lock. Since kfree_rcu waits for regular
> +        * RCU GP, the ctx can be freed while we're between reading
> +        * the pointer and incrementing the refcount. Take regular
> +        * rcu_read_lock to prevent kfree_rcu from freeing the ctx
> +        * before we can tryget it.
> +        */
> +       rcu_read_lock();
>         ctx = bpf_task_work_fetch_ctx(tw, map);
> -       if (IS_ERR(ctx))
> +       if (IS_ERR(ctx)) {
> +               rcu_read_unlock();
>                 return ctx;
> +       }
>
>         /* try to get ref for task_work callback to hold */
> -       if (!bpf_task_work_ctx_tryget(ctx))
> +       if (!bpf_task_work_ctx_tryget(ctx)) {
> +               rcu_read_unlock();
>                 return ERR_PTR(-EBUSY);
> +       }
> +       rcu_read_unlock();

nit: This might look cleaner with explicit block {} and guard(rcu)() inside?

>
>         if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) != BPF_TW_STANDBY) {
>                 /* lost acquiring race or map_release_uref() stole it from us, put ref and bail */
>
> --
> 2.52.0
>
