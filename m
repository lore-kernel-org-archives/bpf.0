Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51640F73A
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768050; cv=pass; b=AcdfF8VwbkFaHZ2euGBBEVlZNOmb738NcC2c+K7lFYr8Xeurv65g/EhtX/0CHT5duwDAOcF7debubJFNw95te9kVotKL8hZQLyYiNGEkk9t75rt20B4sZTVPV2d2hPtYlz7p3KyozjuXSQ9I+xbUqO+AA45TdCuM0c6CkHHtE04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768050; c=relaxed/simple;
	bh=5kebS8pMZi+Qnu3Pne9n+Gcqlzlf9paHIC1+/HJAbOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOCNOq7bfihIGtIHsMKbSBTM5TJ8FTBKZNAZsAIuXLgqmUmqkOE2KFuPu0YApNjDmM2GaSbCUs6se0Wh0xgZyGY5y0jmSg//7khQALTsA4YJHHzyaYaSikUYmnSqxTbGVob+w5nE4O/KHBWlRoJR5DHfiirv+Ab2i1sEmfRjGsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tz5rfNOQ; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz5rfNOQ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c197eaaab00so563040166b.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 07:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785768047; cv=none;
        d=google.com; s=arc-20260327;
        b=IhQoD7sgSPSM7zVnj3+sxPy9jRtGEqFZrWQZxbCKXxDfQ4+JrfG17dCiwi0VHf5iWv
         KZprnKjFj6GNvJ19MpGKYRyqAYC6n2LuEHNDYiqbjVFI3O7GNGTRwHxsMqr22Wg1ogcq
         LuUOvwZIuH7QIDXBQvc3/LyGzEJC2t3kx5EzhDBuZAASghVTgT1KEKGtYu1ZeAhHozID
         jQub8NCUYjj8Zs8d9s5FY6uFj6L8nWzRtfxXNHQsUXKevYs61oFaed9RMAFJGX69fjwD
         1NmkfBSXYHVJQp/MmA73t2Y/NuFrU2QuqWKtZDv8YNGTHtDyqMzuyK4TYNpqOtdRFcf/
         XpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=43vcEMd1q8IU7lDqptyYtNca+YC1kL3gqmLuBjWx/68=;
        fh=W4zgvaciPvu+gyNBZoCQAqBlb+JTJZHKnm39esXowU8=;
        b=DuSUS6+8x1MHu6CfYnhqSueDpmDthe4oNlBjO1qM0rVJe/U8jzBw2F/XhAAuf/SfuI
         lPGml4WdIvEwZQPXC8oOyLRQKparbLo1rhEQ2MuTaR32edtkmWpIIS4T390iEUiu8Kn7
         jhmqLIUcogvy8O0bXUE6TSN4HLxqC+LdpZslhO23yi1ejGLe/f4ygMC8YYQ9cuQg6x1G
         7pifTM/y/ZHjCsfhJ1CW/i4hAPeoAcpm+4OFJ81Ahh4TLFZ62Auv82WPZu8Xjs3dd4l6
         ZvM4ctQlQmuN9kzgWx8e3kUgrgDV+Rgk9wAhGuax5etlvcWjKP/sFhPF3mscuVmhZZX2
         kzyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768047; x=1786372847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43vcEMd1q8IU7lDqptyYtNca+YC1kL3gqmLuBjWx/68=;
        b=Tz5rfNOQzchdtn/Ks/onHMHuRnDgH0pVeptuXyu6TmgTbyHH6p4hIis2w3G5urNRNZ
         fC6E6xRWZRqhV9Bi3M6TlcRLo+ysuiwcjN9Rb3pMUs0MlvPFPFOlxzuP8R31g8MnKFEi
         qDWXdxoklygg/KNPiNiKSHJacPtyzW2I6OAKw6ugRbe9mxLePzw5uTE6GMU97hqvWOtw
         KwWfb9SVUCCzui4n/MQWlgLeI3F62ZfIS/rmbS9Ug+GidBt5Ck8ji6BuSrp94Fzn0zd4
         RVIrjMjRW8582oV6xmLu5Mge6Tm0Ex2WcVKgI1rwCjCo2ZDnjYaY1Hf9g2ExOH9RlANX
         lPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768047; x=1786372847;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43vcEMd1q8IU7lDqptyYtNca+YC1kL3gqmLuBjWx/68=;
        b=TzY3ioSYNjZh+lx0g3T8xcIJa+1INRk9wYKe8U+NqSb5BOgbYBAlRTvq1OTUzAXL+2
         YcaKBrtxI88rPQY7bt+7Ve7AyXHjPR4S1T3CJlr+fgXZRahPDCb+LuT8/BbeYsAYVfna
         ntsz1A9wqw2Bc9e/4GjZlwy++xFY8z5BIQ5PXXXNzlK+auaLP8lyA8DUw4Gh4rNHGpKm
         YwfGrK2HyH6YDSksl5bIZ4M1bcqZuGlRlR481tM53bCNly/bYNz+kOIGt2DY0PteW/q9
         TT6Wkq2PDiDcXHn6jdOBufBvglUz6/zD9WlCM9esbz9VH3HsnbF3ro/DZGgXsh2bckeu
         pQaA==
X-Gm-Message-State: AOJu0YxnhNJjJSdiQTjWoSY5eJE1XxgETbezE4GPoneVIJIuiIEncJ5l
	YI82TuwUs5Q23iG96/BtaUVSpa74T99uBfvW0jKV7/vGkY/NrXO0CQowlCS7nd0jVKM2BcN2G4w
	6aAzLiPJRyJjqEaEzuynAX7Vegz8jovjtqcC857g=
X-Gm-Gg: AR+sD114NGppNL0L4g17iLedFmsQxSb4DJrPIJC56g89aYNMv7cz14h+KxAimvTJzLF
	tA42pa/mWW5pTOwJm7M0cl/oJ5nunjGaQtzANLIBe19oQwX42LszgiBJHN9GwdOpiqVI65RhS0z
	Z3qDrIjQKUD8vmojTNrO9J9XguTWqX6UnAsAvX8Y0tcIgPdAcd4SBl33rvgzfq3kv+iVLawt7Ad
	vKTv8Qb2dKQQ0IBpqiJEHjYHfR96T7q9WOUgiCe1rjLVpJGvZCAmoW+FLQbgR4s22fd7xMG+NP2
	UgoCRw9pVKd7HmkCbgmZnkXOtgpPGk45XppyKZvgLxwMA6pcbzQC4oeIlIYALJ6R0+HbWi8=
X-Received: by 2002:a17:906:7186:b0:c1c:2aa5:322b with SMTP id
 a640c23a62f3a-c1fe8168601mr589342466b.2.1785768046472; Mon, 03 Aug 2026
 07:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803134839.2103051-1-puranjay@kernel.org> <20260803135329.2327280-2-puranjay@kernel.org>
 <20260803143505.2E3D21F00A3A@smtp.kernel.org>
In-Reply-To: <20260803143505.2E3D21F00A3A@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 3 Aug 2026 15:40:32 +0100
X-Gm-Features: AUfX_myg5FkRhhwJrWlROWqtotno0-Pomq3l_iqF2gTN_FLgC2KCpZALE0D3KSY
Message-ID: <CANk7y0g+Yf0Vy0jZCoD6NicDXdJ=wo4WpmiBLo3MPqKaNUXO-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] rcu: Make Tiny call_rcu() safe to call from any context
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 3:35=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Relocating `debug_rcu_head_queue()` into `rcu_do_enqueue()` bypa=
sses double-free detection for deferred callbacks, silently corrupting the =
lockless list and inducing a permanent hard livelock during `rcu_defer_drai=
n()`.
> - [Medium] Invalid `WARN_ON_ONCE` in `call_rcu()` falsely flags safe NMI =
executions due to a flawed concurrency assumption.
> --
>
> --- Patch [2]: [PATCH v2 2/6] rcu: Make Tiny call_rcu() safe to call from=
 any context ---
> commit 866e1596ae5a7314657b9b0164dfabf922016c70
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> rcu: Make Tiny call_rcu() safe to call from any context
>
> Give Tiny call_rcu() the same treatment as Tree RCU.  When interrupts are
> disabled and the scheduler is up, stage the callback on a lockless list
> that an irq_work re-issues later.  One global list and irq_work suffice
> since Tiny RCU is uniprocessor, and there is no CPU-offline drain.
>
> > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > index dccccd6be9411..5736b964d8ee1 100644
> > --- a/kernel/rcu/tiny.c
> > +++ b/kernel/rcu/tiny.c
>
> [ ... ]
>
> > @@ -42,8 +44,86 @@ static struct rcu_ctrlblk rcu_ctrlblk =3D {
>
> [ ... ]
>
> > +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +     /* A re-entrant call_rcu() during the drain would livelock it; dr=
op it. */
> > +     if (rcu_defer_draining && !in_nmi()) {
> > +             WARN_ONCE(1, "call_rcu() re-entered during callback drain=
; leaking callback\n");
> > +             return;
> > +     }
> > +     head->func =3D func;
> > +     if (llist_add((struct llist_node *)head, &rcu_defer_list))
>
> [Severity: High]
> Does moving the debug_rcu_head_queue() check into rcu_do_enqueue() bypass
> double-free detection for deferred callbacks?
>
> If a double-free occurs, llist_add() will be called twice on the same nod=
e here,
> corrupting the lockless list by creating a circular link (head->next =3D =
head).
>
> When the irq_work executes rcu_defer_drain(), won't the llist_for_each_sa=
fe()
> iteration infinitely hang on the circular list before the delayed debug c=
heck
> can prevent the livelock?
>
> > +             irq_work_queue(&rcu_defer_iw);
> > +}
>
> [ ... ]
>
> > @@ -157,29 +237,15 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
> >   */
> >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  {
> > -     static atomic_t doublefrees;
> > -     unsigned long flags;
>
> [ ... ]
>
> > +     if (should_rcu_defer()) {
> > +             call_rcu_defer(head, func);
> >               return;
> >       }
> >
> > -     head->func =3D func;
> > -     head->next =3D NULL;
> > -
> > -     local_irq_save(flags);
> > -     *rcu_ctrlblk.curtail =3D head;
> > -     rcu_ctrlblk.curtail =3D &head->next;
> > -     local_irq_restore(flags);
> > +     /* An NMI reaching here entered with irqs enabled, so the enqueue=
 can race. */
> > +     WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
>
> [Severity: Medium]
> Is this concurrency assumption backwards?
>
> If an NMI interrupted a context where IRQs were enabled, that interrupted
> context could not have been in the middle of rcu_do_enqueue() because
> rcu_do_enqueue() disables IRQs via local_irq_save().
>
> Since it's impossible for the NMI to race with rcu_do_enqueue() in this
> scenario, will this falsely trigger kernel warnings during safe NMI
> executions?

This code assumes that irqs_disabled() returns true in NMI handlers,
so the execution should not reach this warning in NMI handlers.
