Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92043B635F
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617211; cv=none; b=tWDUY9cv6O85uRMggv8Z0AnO1IYMqPv9IR+ePf0NI5auvLxWDXQhQ6kptKVC0uttxp0unjniTCMZKSbGyd/BMn9rXOpf5ZoSITqsr7MePe9pHkmI9PUVuO/uYJQpHrpRUKF0ihX5+yNqtHOyPP0+FLr5AuWzme4H17raBJB85Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617211; c=relaxed/simple;
	bh=YXn45MXkjDbF9n1ZY4tDYwScnZPbD7x1IZUSNwLQ4WA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=u8eqz8ilRsdW+Vk6VcyvG8BnlQhz5S28/vt02Vu/301CrW3syKMY5L2OaeuWsLRDODF+lSGtT0QjAOiJqBTgwuIIUtHCLqAPz27Fs+eW2DScTMLIJsENn+4rNDFSGWx7rGZbOfgXyY9WBQmXZ/tR9y/vaNN/4vO3LvquCgUf9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=A3HUKsBx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="A3HUKsBx"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-83ef1d17904so965542b3a.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1778617209; x=1779222009; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAFGgbTELxk73RYZSyRalEBCbXfQmPGO8ZMYEvQWShA=;
        b=A3HUKsBxURkA2XL57QJZ23CT5VqRwfEZ2UNHOsXRMrcLDs3pfucT+v32TdNM3zMGMz
         PTQUovFSHhj47D/+7j4IbiqFyozhBPyVyMtgfpvc5uCv7knbPjetznOAbk/rq/jyi04r
         8EhmKMTVgCeo9EjpcVwVJr0e1mZZzMdlc4hjNcN6sbNm65mcwgNrULNHMCML3FB6p/W8
         LGdwJkK2Zlu4k63HgcDG0svzXbn8ecBehbLcVzvDKPe6JAuOXKLhnSQUaWyqAGvktrNC
         xle6r52QY+jp10jS8nL16pz2d4qr8SfwCSY15HmkdEV62J+Vo0SNtRE1yLcmcB6dU8hy
         nfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617209; x=1779222009;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAFGgbTELxk73RYZSyRalEBCbXfQmPGO8ZMYEvQWShA=;
        b=dhgEuCY/CkmwCtmxtFLb0HmzGz6Jf7A6ek7mntbgApV4g88eacK3Kd5NAxhQPP/AdJ
         lD2o5UI7ARU/0HQokO3eGNR7aRkl1wxg4AUKP8J10/y1tXnFO95vwOluScXfbs/6JY5u
         0qoO+2aCcLUpQz+0qjkCmgXW65QSs/n+NeKxw/Ur1INUSTOKnxYmDYMrvNQuFKjbCMUh
         aQy2ntYFSu4jr0wxl7z6IZifjM2zoL9vEBNGdvDC2aUoTYq7j0ZJ6iRHBxc1ig9hprbu
         xxypFZlK2x3b7iE/8/m77jaxxHWgFcdzFmo6f0y52+YW9ULhZ0EdVEVDXe3qs9jlXoNG
         mcDA==
X-Forwarded-Encrypted: i=1; AFNElJ+PqnfK63Jy4BefGPvT1YHSWtVZCmqRj5ckKPZOeFPuKlnBWXaQ9Z3GrasssC6WmImfDNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfnCPFvxbDHFDUbjOZnthm90fA9VOnyqsqBgqkLZ1CtHAMe45d
	PMjfiREamFa51deJNdZPF2R4cATRhqgHm5QuV12M3qWftUll+jpTSeyP0wtAq9gfurc=
X-Gm-Gg: Acq92OF4+buBxi41+UD162XYkhhOj2kMlGUaAZQb0bLL2Zn7P8KuO3a1zhANCPXlGjN
	uylmamOIBmQ+CdblHMMhrj4aU57l1efOk+zdyhlRimG06Y6JXvQ/zuKRNj03Jk7oY2zfJtI4jtE
	xSV0fpel9tHn4huB6bjM/iNpOdKEq74nvxFpGMrgToV9wT9FnY4mBD68YU+mHGP2i4u1amVkGdz
	4FjEKYNCoOFh3PFjzDxPyYqJEcol3/F1V+5+Umej9N/AiMw1LMzkca/+33BeVTa/sV2vJ1f6JtY
	88CFf75vJbQHFuFXEwb3rI+tkI3GRsDV5ld3P1BaPgTdVOO5X8IY3tpwUnpnXg1tFe3xM9LTHnr
	7GSReKOVYBCX9iTct0D+hN2kyU6mFxc0q37kpKFM+jLBqGE+M+2M62MY0b28Rq0rpgh/KdTEja/
	Vg/1lWeUYyEfAUFMLir5AYbjby
X-Received: by 2002:a05:6a00:1810:b0:838:4952:1109 with SMTP id d2e1a72fcca58-83f03e8c6fbmr238007b3a.3.1778617208964;
        Tue, 12 May 2026 13:20:08 -0700 (PDT)
Received: from localhost ([2605:8d80:5c41:3a03:a42f:82d3:5b99:68bf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83ce94a0e93sm13709732b3a.37.2026.05.12.13.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 16:20:07 -0400
Message-Id: <DIGZ6H0UY24G.18SRE0QFZXPIT@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>,
 <mattbobrowski@google.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [RESEND PATCH bpf-next 2/2] selftests/bpf: libarena: Add
 Lev-Chase queue data structure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260511214100.9487-3-emil@etsalapatis.com>
 <c4601c9bc4a124aaaa0c981923fb415af769be9d59ab9a9acf5505426ebbc130@mail.kernel.org>
In-Reply-To: <c4601c9bc4a124aaaa0c981923fb415af769be9d59ab9a9acf5505426ebbc130@mail.kernel.org>

On Mon May 11, 2026 at 6:12 PM EDT, bot+bpf-ci wrote:
>> The data structure exposes three main calls. two of them are available t=
o
>> the thread owning the queue and one available to all threads in the prog=
ram:
>>
>> lvqueue_owner_push(): Push an item to the top of the lvqueue.
>> lvqueue_owner_pop(): Pop an item from the top of the lvqueue.
>> lvqueue_steal(): Steal a thread from the bottom of the lvqueue from
>> any thread.
>
> The API names in the commit message don't match the actual functions.
> Looking at tools/testing/selftests/bpf/libarena/include/libarena/lvqueue.=
h:
>
>     int lvq_owner_push(lv_queue_t *lvq, u64 val);
>     int lvq_owner_pop(lv_queue_t *lvq, u64 *val);
>     int lvq_steal(lv_queue_t *lvq, u64 *val);
>
> The functions use 'lvq_' prefix, not 'lvqueue_'.
>
> Also, the commit message describes push/pop as operating on the 'top' and
> steal as operating on the 'bottom', while the code follows the standard
> Chase-Lev convention where the owner operates at 'bottom' and stealers at
> 'top'. In lvq_owner_push():
>
>     b =3D smp_load_acquire(&lvq->bottom);
>     ...
>     lv_arr_put(lvq->cur, b, val);
>     smp_store_release(&lvq->bottom, b + 1);
>
> And in lvq_steal():
>
>     t =3D smp_load_acquire(&lvq->top);
>     ...
>     if (cmpxchg(&lvq->top, t, t + 1) !=3D t)
>
> Could the commit message use the correct API names and clarify the
> terminology to match the variable names in the code?

Ack, will clean up.

>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c b/to=
ols/testing/selftests/bpf/libarena/src/lvqueue.bpf.c
>> new file mode 100644
>> index 000000000000..b93c4f9d1c92
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c
>> @@ -0,0 +1,241 @@
>
> [ ... ]
>
>> +static inline
>> +int lvq_order_init(lv_queue_t *lvq __arg_arena, int order)
>> +{
>> +	lv_arr_t *arr =3D &lvq->arr[order];
>> +
>> +	if (unlikely(!lvq))
>> +		return -EINVAL;
>> +
>> +	if (order >=3D LV_ARR_ORDERS)
>> +		return -E2BIG;
>
> The pointer 'arr' is computed from '&lvq->arr[order]' before both the NUL=
L
> check and the bounds check. Although this pointer is never dereferenced o=
n
> the failure paths, forming a pointer more than one past the end of an arr=
ay
> is undefined behavior per C17 6.5.6p8.
>
> This can occur when lvq_owner_push() calls lvq_order_init(lvq, arr->order=
 + 1)
> with arr->order + 1 =3D=3D LV_ARR_ORDERS.
>
> Since this function is marked '__arg_arena' and invoked by BPF programs, =
the
> verifier may reject the out-of-bounds pointer arithmetic. Should the 'arr=
'
> assignment be moved after both checks?
>

Will move the pointer calculation to its proper place, thought the bit
about verifier failures is completely extrapolated - this is an arena,
of course we can do any pointer arithmetic we like.

> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/256994=
61713

