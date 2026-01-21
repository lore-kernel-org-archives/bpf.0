Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBED242D72
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955212; cv=pass; b=LNSHd8lKwmslBHT/MGgpoq+0f77mjuGrpfoxvEdfZY2cobXvMkumt24sqNVZ7g0LcmS/UCycgeDy2U7vS/Q8WCN2e5jCIHVv+DsFuhaLg1G79zTnfTiv7q9RyrH9jXAm7F2bt8set3C1AnMCsEJUyTenjzjGADf+hCF0vBd6+bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955212; c=relaxed/simple;
	bh=pv0ybaRps2wBGWX/4WIUYkTezS+wQMaxJkCXj09qjyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIcfm8tKRaOwOM5h5BFHXJDXFVryUe5n7FJzXuAhEL7iEvvkWxx4JEFyQXnZ38ub6grbWv84H3jJdVoL59dBVvUo1y44q2bstCYnYq/LZ14ainfye1n8aYX8dFKK/iEYysCq4fwpSPG/TL6GUbg3P0jDSyNHuWZmbHbIVTUt00c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCwW3cMj; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCwW3cMj"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-352c5bd2769so861642a91.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 16:26:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768955210; cv=none;
        d=google.com; s=arc-20240605;
        b=B+GzpghQkS21rs6lKcHEvSWIHh+1GSvMoRhGEo3+lJx8GsNCOM/VeDbzjNCff7h9g0
         ONTrfd3e86oZ7DMc3P10YhCCvXbBUCIIDdFahWLJDiTxyuBQyQ84nhESFjHhllnZ8Rn2
         Ptu1HzAvwi3ku0Cs152VheDRoe/6ZqS8QUOk7JE44wLExIifFjqxFvnRvBpblVjIpxJN
         +fIMSxmJFoLBZoiXyJGYCe2gJRzBaa97rfYy0JcThc8GuNzjqboSgnUnhn/rllwKYOM8
         rqi9sVf8sJ8xCtJC5d3yDKS4pgpS/8RM4D3hE5vuAFg4lvf1+4xG9ch53WV/oMuEvDKj
         kUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pBflnXWyST4+WHO+kZ9EQrU5IvnjHc6cQ67a71V2Xto=;
        fh=be3ZzmqAIbRlSghzgFcEfYPfCYPMzDKw5fMGW4LljfE=;
        b=LCEH1ye38KOAXxQl+bnkXGHX+zzvLQ7nxUWOjYk1ffVMc1/T+ORFz1GRuqoCPPgra4
         T797+B1h0RHD1xMb1os4HZwIcY+p2Qd7xtAIOzBU9zREP0MGew9gCFl/a8MfJ6r+1Mfy
         1HmpDhitgtmzJ6UXVEgi6feWNxszFmTnI2HqSkBYbPvIfFmILSI1Z9oS43kHusIKzs+K
         OkwxZF9Uhln3xDrupAooZopuuOv+C05sNAVAjDS9+1ybzQiRsCp9FqjI/Huiq86BCJGb
         cmrRJznU6lU+GXQHMNoRsVD2YKN6wzelOUyhr+YLC/UEpCOga/dgIsMx0UOO+bzMKeC6
         3ZSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768955210; x=1769560010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBflnXWyST4+WHO+kZ9EQrU5IvnjHc6cQ67a71V2Xto=;
        b=UCwW3cMj9dmlkKtBO3TTgkvINvqakHv/uKnmybkTVf4RlIcg7e1M01prBjvXKuk5fz
         3nFdf8hQeu+c8Th7lLDUkJGIISBATyw9PQOAx0PiQ5QYhUVAlb5e30zXcDxdSXVhad4P
         zCFwzhS+J0K5xH3LttMEopKvgO/7BzTkma4d2pup0oPY1JBV7YGjPol1x4Kxgc26k1Ds
         2SoEWt0bOQ7EEUaR08VoHF08f3RoKJnSZhq7nVyd47+ZGSmUG2UFsuLBq06M1xYeQpEA
         sv6cNUVbmd3gUS62fTn8vNA9bJOzWeNO77ZCTwlP6EiRwegDuGr49JNT7lIpX83XcXlL
         +hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768955210; x=1769560010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBflnXWyST4+WHO+kZ9EQrU5IvnjHc6cQ67a71V2Xto=;
        b=P4Vj/AafkoKn9HIghGlDFQgzALSe0kbEUR26F/+ygOhS+KTB9FR4EP30xvcaW3CSRD
         613tuBXk4p5+2noWZuhUxfIlZS1WoiGEH+hy9JF7S6jvmSFtJaOStajke6ExCFv3N2a4
         f3GyZv45GnrC2UR1ZN3obY0y/WWDj2HT57z8JfOR6jscrtzPhBg02OerH8G454vNiaT2
         fiOtkq0aiN+T4rh3F/6Q7BD1kaujw9E7k+vuRX1Q28UM2VgO/y5FIkvXO/AMg68usNt4
         tHHYOj82j3Dmqyf8bwo7AHT4tYS1Y8i/xieGFLm9H7TzGKlK7MxDhl0yy2qG60YTnFP+
         n5gQ==
X-Gm-Message-State: AOJu0YyiatdxIgL0I45U0nzldOvCh4OmuVqwSYWD6YhdgCy3Kyen7tOC
	yMooRn1kk9FcyPToCC29KZSRiXGhUIOWJrUyeUznvE+lA45wNzYBn+xE0WbVq6zXj45vC71cJ9f
	UgVce2uuyLmmDZCESo1N23uRGSJX++KQ=
X-Gm-Gg: AZuq6aJZF7nP0ZWB14UbAOJdl9RUCx8l6tEItLu51fUhwBEcs22rGxX+72Fw2wny7QL
	d2d9qcXv9edAyhV9Q8NVJe5WeVborAteBs/06RsSksvKNwAXnHmZyK0ojKJJCb9MGD2mi7mjlyh
	cHK5DAz8vnzFxHNqbPHVIMl91Y+EcyAzak7OPwvStr9n4H2+ah1SDaZSfUDjnEt+mPmLOH83aPF
	vZV2WBd7lG5FXIVScnpYr1ouUAF2TUU82QwF5GEAqs0mbu4VgT8SbQC9QIdv4mdbD1oH2do7CI8
	qdzfKTiNR8I=
X-Received: by 2002:a17:90b:4b10:b0:34c:f8e6:5ec1 with SMTP id
 98e67ed59e1d1-352c40de54amr3137918a91.35.1768955209716; Tue, 20 Jan 2026
 16:26:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
 <20260120-timer_nolock-v6-5-670ffdd787b4@meta.com> <CAEf4Bza1r4db3srwPYymSDC=ynhbZ-vsVJKshy8wGfnRhKkCmQ@mail.gmail.com>
 <2ef459bf-6a7a-4249-b400-aab75f03f44a@gmail.com>
In-Reply-To: <2ef459bf-6a7a-4249-b400-aab75f03f44a@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jan 2026 16:26:36 -0800
X-Gm-Features: AZwV_QiHwiq9SMZL5oSNmCjoyxo5DymLnAixYWwWT9bQrd7rIBuXVroew8Ju1m4
Message-ID: <CAEf4BzaLpAZ3K4=h=K_0HJnVkqabmDDQzjDYFvdzurmtWc_dvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 05/10] bpf: Enable bpf timer and workqueue use
 in NMI
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 1:17=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 1/20/26 18:31, Andrii Nakryiko wrote:
> > On Tue, Jan 20, 2026 at 7:59=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Refactor bpf timer and workqueue helpers to allow calling them from NM=
I
> >> context by making all operations lock-free and deferring NMI-unsafe
> >> work to irq_work.
> >>
> >> Previously, bpf_timer_start(), and bpf_wq_start()
> >> could not be called from NMI context because they acquired
> >> bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
> >> patch removes these limitations.
> >>
> >> Key changes:
> >>   * Remove bpf_spin_lock from struct bpf_async_kern.
> >>   * Initialize/Destroy via setting/unsetting bpf_async_cb pointer
> >>     atomically.
> >>   * Add per-bpf_async_cb irq_work to defer NMI-unsafe
> >>     operations (hrtimer_start, hrtimer_try_to_cancel, schedule_work) f=
rom
> >>     NMI to softirq context.
> >>   * Use the lock-free seqcount_latch_t to pass operation
> >>     commands (start/cancel/free) and parameters
> >>     from NMI-safe callers to the irq_work handler.
> >>   * Add reference counting to bpf_async_cb to ensure the object stays
> >>     alive until all scheduled irq_work completes.
> >>   * Move bpf_prog_put() to RCU callback to handle races between
> >>     set_callback() and cancel_and_free().
> >>   * Modify cancel_and_free() path:
> >>     * Detach bpf_async_cb.
> >>     * Signal destruction to irq_work side via setting last_seq to
> >>       BPF_ASYNC_DESTROY.
> >>     * On receiving BPF_ASYNC_DESTROY, cancel timer/wq.
> >>   * Free bpf_async_cb on refcnt reaching 0, wait for both rcu and rcu
> >>     task trace grace periods before freeing the bpf_async_cb. Removed
> >>     unnecessary rcu locks, as kfunc/helper allways assumes rcu or rcu
> >>     task trace lock.
> >>
> >> This enables BPF programs attached to NMI-context hooks (perf
> >> events) to use timers and workqueues for deferred processing.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   kernel/bpf/helpers.c | 423 +++++++++++++++++++++++++++++------------=
----------
> >>   1 file changed, 240 insertions(+), 183 deletions(-)
> > I think we'll need another revision, but all the things I pointed out
> > below do not change the logic in any big way, so it would be great for
> > people that were following along but waited for the overall
> > implementation to stabilize to actually check the implementation now.
> > I think it's basically ready, hopefully the next revision will land,
> > so let's do another round of thorough reviews.
> >
> >

[...]

> > [...]
> >
> >> +static int bpf_async_read_op(struct bpf_async_cb *cb, enum bpf_async_=
op *op,
> >> +                            u64 *nsec, u32 *flags)
> >> +{
> >> +       u32 seq, idx;
> >> +       s64 last_seq;
> >> +
> >> +       while (true) {
> >> +               last_seq =3D atomic64_read_acquire(&cb->last_seq);
> >> +               if (last_seq > U32_MAX) /* Check if terminal seq num h=
as been set */
> > unlikely() seems to be warranted here to optimize (a little bit) a comm=
on case
> >
> >> +                       return bpf_async_handle_terminal_seq(cb, last_=
seq, op);
> > why this helper function, it's called once. It's actually a
> > distraction, IMO, that this logic is split out. Can you please inline
> > it here?
> It looked ugly inlined, I saw value in attaching word "terminal" to the
> functionality.
> I'll send inlined in the next version.

I don't know, BPF_ASYNC_DESTROY -> BPF_ASYNC_DESTROYED has the same
terminal viber :)

As for ugly, I don't know, let's see...

if (unlikely(last_seq >=3D BPF_ASYNC_DESTROY)) {
    u64 expected =3D BPF_ASYNC_DESTROY;

    if (!try_cmpxchg_release(&cb->last_seq, &expected, BPF_ASYNC_DESTROYED)=
)
        return -EBUSY;

    *op =3D BPF_ASYNC_CANCEL;
    return 0;
}


Looks fine to me, tbh.

And note, you don't need to check last_seq ahead of time, this is rare
event, no need to optimize with this speculative read check (unlike
the cancel_and_free one I mentioned in last reply, that one across
millions of map elements might add up to something)


> >
> >> +
> >> +               seq =3D raw_read_seqcount_latch(&cb->latch);
> >> +
> >> +               /* Return -EBUSY if current seq is consumed by another=
 reader */
> >> +               if (seq =3D=3D last_seq)
> >> +                       return -EBUSY;
> > I'd drop this check, below atomic64_try_cmpxchg() should handle this
> > unlikely situation anyways, no?
> I don't think cmpxchg handles this, if seq =3D=3D last_seq, cmpxchg still
> succeeds,
> it only fails if cb->last_seq !=3D last_seq.

doh, of course, what I've been thinking, sorry, stupid suggestion on my par=
t

> >
> >> +
> >> +               idx =3D seq & 1;
> >> +               *nsec =3D cb->cmd[idx].nsec;
> > [...]
> >
> >> -       ret =3D bpf_async_update_prog_callback(cb, callback_fn, prog);
> >> -out:
> >> -       __bpf_spin_unlock_irqrestore(&async->lock);
> >> -       return ret;
> >> +       cb =3D READ_ONCE(async->cb);
> >> +       if (!cb)
> >> +               return -EINVAL;
> >> +
> >> +       return bpf_async_update_prog_callback(cb, callback_fn, prog);
> > nit: if you end up with another revision, consider swapping callback
> > and prog arguments order, it doesn't make sense for callback (that
> > belongs to that prog) to be specified before the prog. Super minor,
> > but reads very backwards.
> >
> >>   }
> >>
> >>   BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, v=
oid *, callback_fn,
> > [...]
> >
> >> @@ -1536,79 +1617,75 @@ static const struct bpf_func_proto bpf_timer_c=
ancel_proto =3D {
> >>          .arg1_type      =3D ARG_PTR_TO_TIMER,
> >>   };
> >>
> >> -static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_as=
ync_kern *async)
> >> +static void __bpf_async_cancel_and_free(struct bpf_async_kern *async)
> >>   {
> >>          struct bpf_async_cb *cb;
> >>
> >> -       /* Performance optimization: read async->cb without lock first=
. */
> >> -       if (!READ_ONCE(async->cb))
> >> -               return NULL;
> >> -
> > I don't feel strongly about this, but I guess we could leave this
> > performance optimization in place without changing anything else, so
> > why not?

It's useful for reviewers and readers to see acknowledgement of
requests like this, as it's not always clear if this was missed or you
are just going to apply the suggestion in the next revision. So please
consider replying even if you agree.

> >
> >> -       __bpf_spin_lock_irqsave(&async->lock);
> >> -       /* re-read it under lock */
> >> -       cb =3D async->cb;
> >> +       cb =3D xchg(&async->cb, NULL);
> >>          if (!cb)
> >> -               goto out;
> >> -       bpf_async_update_prog_callback(cb, NULL, NULL);
> >> -       /* The subsequent bpf_timer_start/cancel() helpers won't be ab=
le to use
> >> -        * this timer, since it won't be initialized.
> >> -        */
> >> -       WRITE_ONCE(async->cb, NULL);
> >> -out:
> >> -       __bpf_spin_unlock_irqrestore(&async->lock);
> >> -       return cb;
> >> +               return;
> >> +
> >> +       atomic64_set(&cb->last_seq, BPF_ASYNC_DESTROY);
> >> +       /* Pass map's reference to irq_work callback */
> > I'd expand here, because it's subtle but important. Just to make it
> > very clear: we *attempt* to pass our initial map's reference to
> > irq_work callback, but if we fail to schedule it (meaning it is
> > already scheduled by someone else having their own ref), we have to
> > put that ref here.
> >
> > It's important to have a noticeable comment here because refcounting
> > here looks asymmetrical (and thus broken at first sight), but it's
> > actually not.
> >
> > But also, can't we do the same !in_nmi() optimization here as with
> > schedule_op above?
> >

same point as above (and few more below), I assume you agree, but it
would be nice to ack this to clarify (this is a general point for
email-based reviews)

> >> +       if (!irq_work_queue(&cb->worker))
> >> +               bpf_async_refcount_put(cb);
> >>   }
> >>

[...]
