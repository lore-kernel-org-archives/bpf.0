Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB983C1F5B
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366147; cv=pass; b=DLLKPnnXOCF5NGVuhjWo8dbIeUfXWtNfsA+ImarMtoSqJzJDc1WJM5xVipojCEcU+G/7tyQhLEB9te3kTC5Pbo2syG8FPUCEIjVBYx1qYRWO0B2hWH1hL83WPPUV0Dsmi2FFp9TjHN35FDo4VF/lzbY1Bb47WcJ8f1+t6sISsj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366147; c=relaxed/simple;
	bh=N5Gsz6tNICsJOfdntkPkZdZjEdKtMimVkLRRn3KYv18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6UDS76vcTRS9LGqc9zeLia5uye1xNGS8Y5bEUuTwh/UKwcJ9tZ/4KODAVBj5EhGyexvcVdVtT48GUObUoO4erD1E65Hla8MyHxxaUfyeiQMaYfFsEojf6ENn1RCVpMVXMDR1EOWnupP5A9f5yst+bcYSPNMnaUnK/xP3BfRW1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRPUJtQj; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRPUJtQj"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so2191168a12.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 05:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786366142; cv=none;
        d=google.com; s=arc-20260327;
        b=MBoLHtYzRY1frYKPsarhXnUlVnAjWcT2xZBBc2nGkUOAWC8vo1Ve1LasZo2p3XmaMp
         1/jalhUw8k4rexXm9UgMD1ZP4gg+j9aqVZWekiF57Pg5rTlcfSa4Fvvd7c1P3WNTFDUJ
         GRYy3Kfg9Il4uGUQXPiA0R4xvC/Cy7TPeTv6DJiI+zFlTuvW62RHrtb6AIr5JTL3TnfL
         wTc3qzVp/5gXMdq94Co3J++YvzGkYhsjxgiA3Ryzzka+JGJ6HAYKAyKDjhnxDDc9QGZ9
         IxXCnjopeRa4xQgjRDhM3SAOIPDSljTromDs0Fne9pj4FGe8w7/R/1gKNlsyhm4fk8D1
         SlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YFK0DpUmt1yzhhCt2rvujUuVSNjfSYNwcT83/Jpc5KM=;
        fh=W4zgvaciPvu+gyNBZoCQAqBlb+JTJZHKnm39esXowU8=;
        b=mPIJLkoBGfrxQ+fynFCt502o4vMvQ3Lkmg4HBo2Q9I4jnghNyxe5nuM5L1g9hOD8wF
         YCXS5LUSN7PsMovGN7xvVr2du5cBRd1nKRvIj2BVb5DuCzszUKQ1b2pV7/xRq/nQ7XL0
         DZ2YQ0rRLyjSNUkFvn9oAv8q31hZDdiaYZK4IfVWJ7MfzX0h2kBKGET1tViijG8usQWY
         QaQHZZrycsHTq+ji4/g66eQe+EBCzT5IUn6aCupdY7t7waHxKWlysiGtximxg9Vly+yS
         HT5SfFqAIIuCwfWwIN871J5iWbyGG6sBqI1040NAgMS+KrIXwLLAoECErRJT0/nnLxcu
         4SuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786366142; x=1786970942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YFK0DpUmt1yzhhCt2rvujUuVSNjfSYNwcT83/Jpc5KM=;
        b=oRPUJtQj0VKgwpbu8k3sJRuhtOQcMa2BwKKIz3dwSGpjbWV45V6gkG5I9rN5aSHlyF
         xU7XjdNC+aMxO5Q6LcNiEnCMlF3y7ldOTQCkMBDnloVddwGOPD5c9HGhUyA9BpHcusXC
         WnMEzbnF3CpNop8SP8eMe4ZD7JD8Uf9DXeXo0frKxpep4ZXY1m03YA5oOwyOY7yR/VWW
         RYzg9VMaJNZCXC9ZvPGR/lEq1bOG5WahcckL7pZg7YRsRwrDEVNfNautWxBxnjD2M5C1
         OTQTPDhHZLWbiywQderJp6F0FiT+KOpf7Q4n2Cjm2oeg3AdaQWWLTjoa7hdqu5OQLtXO
         sF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366142; x=1786970942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFK0DpUmt1yzhhCt2rvujUuVSNjfSYNwcT83/Jpc5KM=;
        b=lZ0+oTHycEfHioWXa7cOdtUf7v9A3DaGJn5+t/D0Q3CY88mmiQLszIKHF5R+o5Eery
         Ms/yJt2UaQX+OWe2Yi3HMSAwg1fi1tMEcO6V9NZq+YxH16QGRJyZlizw1CNBJ4hQQb4X
         C/uCAghATsRVUIWIsQVF1PzBB8GtZP1GBoNUN2uGgLeVO9QHbim4TJ+HrRtEz11PXbDE
         LjJ+cLn9DotKBFhdN71gZ9FMJ1IkhNi6SHFXxdtE7fiZ5ZD5hqDwkCKa2mIvXv+6gHSS
         4TJDkona9VRboM1ZVAHWritOrKg8A9j+7pkIx8zDsKtrENMilxpZjJVfDAANC/N9HUqy
         NvBA==
X-Gm-Message-State: AOJu0YxqKZYy98GAY52r66HSwTK36/PQ3dw4svPdItssRg2kTXvVFRe2
	3OXQzgEEZxk4ReFynXM0kQxUBO7MfuZCYVNzvaSTzzng2TVjtRRTRl5NsO1Aw2Q2rVPVmCSJ7FL
	ijmzqYOJ4EkNt89Yev4kFd7/PBhe2vUI=
X-Gm-Gg: AR+sD12ETAt2buf6x1PhiOt9KjXA/4rvWarChoJdLnEnAJ4Wp1yFbnoVbBseyiiosj9
	kH0sGicjpYfMgndrWzY5Ek/igaciibCKEcTuY+R6gwQFuVteHryu6Yg8Oed6I0wMcr9KIEuJGAj
	MAdD3W/1cX/YTTuoAyAMvzaSPF9ZRo3mr0DEJOSi6I1USdbZA32SM0BUh17ncGtQvt149YZOXco
	FLE3dJjd2lxRX8vPidz+Huv3QmfBgSbP01qy7YUGnt4IpgMnOiD0QfR2gEuYCRFwsEXwEQjxBe/
	LySQI2iQm0YL6otgJRtgZCJ25Sdo1xtOuSXZ4CO0oxDxk/K93GyWOsnk6xzg
X-Received: by 2002:a17:907:ea8c:b0:c20:34dd:5ee3 with SMTP id
 a640c23a62f3a-c2039cad20dmr2174576166b.17.1786366141625; Mon, 10 Aug 2026
 05:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810122758.183765-1-puranjay@kernel.org> <20260810122758.183765-2-puranjay@kernel.org>
 <20260810124351.390741F000E9@smtp.kernel.org>
In-Reply-To: <20260810124351.390741F000E9@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 10 Aug 2026 13:48:47 +0100
X-Gm-Features: AUfX_my8sqCbiksSZhYl4zC9UNaWzsIB-eOG0kAP6PhpMFw0Lde39sGEMEU6ImI
Message-ID: <CANk7y0jbA7XDzNtKUFsYU4gcVZ+TRJUntc+tzmL6CKgFtpqaCA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any context
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:43=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Deferred callbacks bypass `debug_rcu_head_queue()` check, causin=
g immediate list corruption on double `call_rcu()` and defeating `CONFIG_DE=
BUG_OBJECTS_RCU_HEAD`.
> --
>
> --- Patch [1]: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any =
context ---
> commit 5205f0afe602a3f93ee865a26d94981f93553b7d
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> rcu: Make call_rcu() safe to call from any context
>
> This patch defers call_rcu() via a per-CPU llist and irq_work when called
> with interrupts disabled. This avoids deadlocks or list corruption if
> call_rcu() is invoked from NMI or instrumentation.
>
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 96848fc1f02b8..ff9a2395c9e8e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
>
> [ ... ]
>
> > -static void
> > -__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool laz=
y_in)
> > +/*
> > + * Also called by __rcu_defer_drain() to re-issue a deferred callback,=
 so it
> > + * must not re-check the deferral condition.  Either caller may have i=
nterrupts
> > + * already disabled, and a drain of a remote CPU re-issues onto the dr=
aining
> > + * CPU.
> > + */
> > +static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func,=
 bool lazy_in)
> >  {
> >       static atomic_t doublefrees;
> >       unsigned long flags;
> >       bool lazy;
> >       struct rcu_data *rdp;
> >
> > -     /* Misaligned rcu_head! */
> > -     WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> > -
> > -     /* Avoid NULL dereference if callback is NULL. */
> > -     if (WARN_ON_ONCE(!func))
> > -             return;
> > -
> >       if (debug_rcu_head_queue(head)) {
>
> [ ... ]
>
> > +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +     struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
> > +
> > +     /*
> > +      * Instrumentation on the enqueue path can re-enter here from ins=
ide the
> > +      * drain.  Re-queuing would livelock it, so drop the callback; an=
 NMI
> > +      * cannot loop, so let it through.
> > +      */
> > +     if (READ_ONCE(rdp->defer_draining) && !in_nmi()) {
> > +             WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
> > +                       "call_rcu() re-entered during callback drain; l=
eaking callback\n");
> > +             return;
> > +     }
> > +     head->func =3D func;
> > +     if (llist_add((struct llist_node *)head, &rdp->defer_head))
> > +             irq_work_queue(&rdp->defer_work);
> > +}
>
> [ ... ]
>
> > +static void
> > +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool laz=
y_in)
> > +{
> > +     /* Misaligned rcu_head! */
> > +     WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> > +
> > +     /* Avoid NULL dereference if callback is NULL. */
> > +     if (WARN_ON_ONCE(!func))
> > +             return;
> > +
> > +     /* Record the caller: the irq_work's stack says nothing about it.=
 */
> > +     kasan_record_aux_stack(head);
> > +
> > +     if (should_rcu_defer()) {
> > +             call_rcu_defer(head, func);
>
> [Severity: High]
> Does this bypass the debug check for double call_rcu(), potentially corru=
pting
> the callback list?
>
> By moving debug_rcu_head_queue() from __call_rcu_common() into rcu_do_enq=
ueue(),
> deferred callbacks are added to the defer_head list before being validate=
d.
>
> If a double call_rcu() occurs, llist_add() in call_rcu_defer() will overw=
rite
> head->next. If the callback was already in a normal cblist, its next poin=
ter is
> overwritten with defer_head->first, immediately splitting the cblist and
> splicing it into the deferred list.
>
> Could we check debug_rcu_head_queue() here before deferring, so that
> CONFIG_DEBUG_OBJECTS_RCU_HEAD can safely catch the bug without list corru=
ption?

No we can't debug_rcu_head_queue() can't be done from NMI and doubling
calling call_rcu() from NMI or interrupts disabled will result in
leaking some callbacks but it will not cause a deadlock (validated in
testing using a kernel module that does multiple call_rcu() from NMI).
