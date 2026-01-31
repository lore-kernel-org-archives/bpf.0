Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E43321434
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824481; cv=pass; b=DqIFHxHnjbAuP/Ssid69yUZUbLFeAfT9qDX26eYtk7z/pKeXlaHvS4pkC9t56Wpq+NW1sIYtGvZbhQ0PvWBWzcfKdoayG3+N/nycQsxRNfziPPffBIHcpTQYb35kKKi2ivPjnQiUaE5DVqtlenlQ03cRa+klvgrMnM8DER7TVrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824481; c=relaxed/simple;
	bh=CToBfN1INiHb3aZLgLyOCrYryDy9zH5xAomlvSri3sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R19l61p0A2Co/MviJ9fcTYw+5RrAQqaxmujUDFq+8eOTR711txTzM+oZD4DpgPipAL5LH+mb9mT4y+8Qmuc6F9xhpDvWw6rzbCdokSEEWEJs1c9QXbm5ys9bk8n4l+kVpFUFnyja3FHZhSPG88wQdLqPOwYd+n4mYPpyAGoF6GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky6uE6uE; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky6uE6uE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so22740865e9.0
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 17:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769824478; cv=none;
        d=google.com; s=arc-20240605;
        b=SQ83xbeNjUlqUKG2iHYZBYzcZcypxvQYPFgpWO+A29x1TX4e4wGPYO+vHlX+3AfuRx
         XjSK4s9n4tPD6aDRIs7Xp+kDPuQASw17xe/gPYajWsT4U1baPhMzcfQ29OXUmW4BMxse
         eKyfTYcH+h/k3xE8E5CcDDQSNeyQuDwrg3z6gxcgUeMg0rCqMj6T1tXTU+fue5GtEE5f
         cRRh+cJ4h7/WTb46Ur/+OhtSU/4SFEEcNOSHRyBCZpZtAZrjx2HWukRjU5reG3dT69uL
         8z/Yxxcp44ssCf9DQo1oJap3u8Nf5JmsP7cJiOdUIT2U2qrAPMj/sT1bU5P7JKZLwK5C
         ZPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pTxceWyuSVQuHlDsSTPfd0ACqnwUu0LXG66RiH5Ludg=;
        fh=TzSAIb1w2/n4h0G9BiHbyZh2QLswfvF+tqKBknGHXJs=;
        b=cYsHGtfRnRHWgu2EbXhMMMB4423lGm9f/sKYlyXVssD7svDUlOFG+KFMIde0Xla2lS
         4YqWYmTT3EtHBW148LrfotdhkIizurWpZJk3AJNhk0ECTCAsRPQgUZQXI84zjawGKUt/
         v3ov1Xms5s6Y/37s3oSED7c0zgDj0gG55DnAcoE1P9Zb67zOqwVP1Zt+vpdaLURdmIK3
         KByotW2tCQP246GwZXBi+BKBty+Q1W0EjidTkSmj4QwyY9UytguW9veiQwZcnqlDVQv7
         sykZQil6Hc61JoEM+hy2P2HWhkWpuvM+M27zh0xXtn89QQS92I29EJzNYP3OturytqCF
         LRQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769824478; x=1770429278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTxceWyuSVQuHlDsSTPfd0ACqnwUu0LXG66RiH5Ludg=;
        b=Ky6uE6uEViStfv2KxzIcaF/r3fmBT3yUG98K20dqIdmSE0B71GxJjsyZvZbN3z0v+2
         xqkWN7z0yDQo1X0vPNLxbgEE2fzIkzvG/CrC5sEtE4CYWboki8F0r0gZ5GJv4mUy2TXZ
         xKvgxeFl49zUhNCzfYCjvc86erCWSP2f62q5WQx5nc2RbuW7JRsMnYbsEJ+05mdvRCDi
         d8rzbzsyo44/GaLsDEmctsqOKX5NxtIxXhzmMfxGSRzwwD3suvcixZzPiatMbqflTqfz
         hkqeHVY+ZQ+RDeMDSht/baAGFxZ7Nq8iicwMpgqCrLcvBD8W1lWxsxsfw2iy60GDiMLi
         IdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769824478; x=1770429278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTxceWyuSVQuHlDsSTPfd0ACqnwUu0LXG66RiH5Ludg=;
        b=FTWjkIAVGyMy4uNewpaTv8iys/qppk35wgJVphNsmrZMimeEFAmHA4y9XNXVs25LIa
         JUda8klMnvAuhh5rKZhS90j6T2cxFr644S3bc5Jmu27tfPg8iAaKjmPgyMOOyMjuacTx
         YE7HRphQ2VWSAZcl7XhyqFsHWrEUhRn/Ap/CtC9OyQy8rIInPCQPUNvqEfQ4RscsmDdJ
         +6De8m4yUQ4EA9vJsflpWdkdnZqMC2ACY94jowvtA3SNYdO0NCzJN7mn235wUQIc5078
         y7Qqlt3OuVnn45EPICjLwV9kvRFML7/wYmQbS/bEHln5t8qpDSqRDkyxnc3iHpPM/si6
         foiQ==
X-Gm-Message-State: AOJu0YxpavtGZ3H6mQXzjFRLTYLtcNSzetKVwK8VvHT+y0BUgbveppwa
	RazTC6FBnFX9zwqGZDlSazzhHx/SZjjHVUwhQs9NXmbC2lRk31laiINd/6Wwes3yB2rXtpu9A2s
	RdmLgAVlTwFJ6vrBrAA3/GXHIQZvoS7U=
X-Gm-Gg: AZuq6aLepDj7N+0Whi5U6sTAvXlTBYT9olTFblwmZ26eVQsRTTBAgyJEpWKYb8+xf6W
	JpPK8FmY5X/ehGyMjjPQmU03/B4+mfBqmGgJtMwYxC8qpWs15B+bVVhalaXe3d85RIkXs693H6/
	bDZA4jys8lh4JQoMohGeGyjjcI/oKBLmrk8tMVpfIqJ0MpwkeP1l52olcvsqM+/j159CYkVF53E
	fMvmlK1ign8+MFZw/t6UVZWUNnOiYjUFTMoIWAmucD8oy9e5cPWtpufUpNuIKFasNVu0KRRzzdd
	a3b8Ux3U/LTQpuBikdArFoPicm/D2KnML70TOB+v4davp/kGZu01stRGsTCAah8XdxYSzzgzkKz
	rE0Xy5uKV+vpKaA==
X-Received: by 2002:a05:600c:64cd:b0:46e:2815:8568 with SMTP id
 5b1f17b1804b1-482db476c24mr64609955e9.10.1769824477643; Fri, 30 Jan 2026
 17:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com> <20260127-timer_nolock-v8-1-5a29a9571059@meta.com>
In-Reply-To: <20260127-timer_nolock-v8-1-5a29a9571059@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 30 Jan 2026 17:54:26 -0800
X-Gm-Features: AZwV_QjwBUC1Cg4bwUFiZH6d4JX5raSVgjzLH3h5psQKV6y6yLcRSId9_sOSxfY
Message-ID: <CAADnVQJO8_X9wrLTpaGT8cX2KBwLj=xS3jj+d5Ut8JbUgKPBOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/8] bpf: Enable bpf timer and workqueue use
 in NMI
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 11:31=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
> +static int bpf_async_schedule_op(struct bpf_async_cb *cb, enum bpf_async=
_op op,
> +                                u64 nsec, u32 timer_mode)
> +{
> +       /* Acquire active writer */
> +       if (atomic_cmpxchg_acquire(&cb->writer, 0, 1))
> +               return -EBUSY;
> +
> +       write_seqcount_latch_begin(&cb->latch);
> +       cb->cmd[0].nsec =3D nsec;
> +       cb->cmd[0].mode =3D timer_mode;
> +       cb->cmd[0].op =3D op;
> +       write_seqcount_latch(&cb->latch);
> +       cb->cmd[1].nsec =3D nsec;
> +       cb->cmd[1].mode =3D timer_mode;
> +       cb->cmd[1].op =3D op;
> +       write_seqcount_latch_end(&cb->latch);
> +
> +       atomic_set_release(&cb->writer, 0);
> +
> +       if (!in_nmi())
> +               return bpf_async_process(cb);
> +
> +       /* NMI path: defer to irq_work with refcount protection */
> +       if (!refcount_inc_not_zero(&cb->refcnt))
> +               return -EBUSY;
> +
> +       if (!irq_work_queue(&cb->worker))
> +               bpf_async_refcount_put(cb);
> +
> +       return 0;
> +}


We've been discussing it in private. Here is the race
that prevented this patchset from landing:

  CPU 1 (bpf_timer_start)                    CPU 2 (map_delete_elem)
  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80                  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80
  bpf_async_schedule_op()
    writes cmd[] =3D START
    !in_nmi() -> bpf_async_process()
      bpf_async_read_op() reads START
      bpf_async_process_op()
        // about to call hrtimer_start()
                                             __bpf_async_cancel_and_free()
                                               xchg(&async->cb, NULL)
                                               atomic64_set(last_seq, DESTR=
OY)
                                               bpf_async_process()
                                                 bpf_async_read_op() -> CAN=
CEL
                                                 hrtimer_try_to_cancel() //=
 NOP!
                                               bpf_async_refcount_put()
                                                 refcnt -> 0
                                                 call_rcu_tasks_trace()
        hrtimer_start() // TIMER STARTED!
    return

  ... RCU tasks trace grace period ...
  memory freed

  TIMER FIRES -> UAF!
