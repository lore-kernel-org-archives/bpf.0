Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98E315D33
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945707; cv=pass; b=p08zP5bSjsyK9TwMFzk0f+KSlhilEL0HVaExxQ7rny5idEuRw/kz/ao/DNzlR56aQEsSUf77wNzcTk3UhX6MmDu32jMNFGgNAr2SywvFMWwmV7fJLh6v6xaGrFaG1m0FDQunfh3ACA35dNGvDefil+9KMoA0/DnzWKknqwZpYRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945707; c=relaxed/simple;
	bh=lIL6wyNmsCEUAIKBKJz5uFkgb+/oSYC05jSsCIlQJu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXJ3AyB6RoGa0QoFbzNz1SQtpN27vwKcNc/A39pVaiahLKwRJA+UDJPgXnMUeFWiocujuH9WP4GAVVFY6I5Xe8aHWSOdmI0IlEDWGL3kDQcY33xjMQosNW97DRMDosMS62Qtatv/8pOBIj1ZcWFnRSTco1kX95DmRdNkcgNMPLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUbqhwbz; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUbqhwbz"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439fe4985efso976259f8f.3
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 11:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773945704; cv=none;
        d=google.com; s=arc-20240605;
        b=LtPtZu2sAQcybKQ0xACkS+wvqxyaJ1AYSavsuuH6EstCdr9YNWKJcFf/jHRxrKQT1/
         qFxWvOPUqhdZxxjcnjoJrDZsOH0/Y5tG7DRcRx2FRvkDYqio0gAbHudn6qtNlenwJXVi
         kQU38MgPuIQRjjnnFAOf5ePV85nQqxWO95aiMno5Xmm14N0/wmJfSJNzPbw7E6KOIuU/
         9bJh+onlKzUZPj10AJHfbijDqvPfSmZbDPpc9xMmXtwwPn672t7jn3EoXlfrTiVXPZOl
         VsEJDjUI3qDphaVwm6AYliBF60AD9ytMtg+9VMQeVSt+UydyK62+Ro1Td76S0ZfPEBxH
         pqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lIL6wyNmsCEUAIKBKJz5uFkgb+/oSYC05jSsCIlQJu4=;
        fh=LnKN3psBtdrs4jHJ5gKruDUKZ6kwbPaEgzp8iWFOcgM=;
        b=MS7qPOkZPvPlheGcOBHyrxuL/1UJcD7sCHpdV5OlL0PCIGU/uRwe8GC65Ts8WFoTem
         trikMLzB6APbqyuF6qiAaKN7piTkT4PWXKbleL4b/qK3hfxi9/TJRYX7hld2v7HwoZbR
         NoODcDbg7jVsu5v9ZWSIybQH6cuNnfMJ+YgsKexMTqYQhEYuyZaiwwcJ+UjMVpZI9FP8
         ufWhClAxWJcTcngeRvHoMK8IMXOgEB877sdlFYZBsQcICo72WEk6dbmnhLp9hBhEjrL3
         qgyOj7Cqk9sDcsJJFU7HHJsP/twMT03gV9hgubUGY4DiRdoprcnWNvGIfJrPMwalbZsU
         Y2uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945704; x=1774550504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lIL6wyNmsCEUAIKBKJz5uFkgb+/oSYC05jSsCIlQJu4=;
        b=YUbqhwbzw/Ievyb5gIm9jJhdBVPIfF5LEau2+8eWfR6x4pwQxYvLYtEsmpwiAXVLlX
         oGwcfJCCDbdaA+2XXI3bKYl7xir2xZIurHunVSpsjzCWqgFlW23e53dZe06gV+HVFa9F
         IVKKQ6wqe+oibqW+LMT7v3MlVMR0wCKtuSSnYxZ6e9gRFWOj19lOWKl1SUuKZyI2ZVB2
         mu6RS3uuEJS5GAnAVb1eE4XrUZ9PNIAOMvicS2ls9pNvo1Z/txx3nB3JWAdiIjHkRJbm
         7rzV2P0MGMJSFJJmb+OtrKbsgh+zFeBxxldVBQ9ygz1Zcgv/BHfefQZ94tOSUjCBID4G
         pmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945704; x=1774550504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIL6wyNmsCEUAIKBKJz5uFkgb+/oSYC05jSsCIlQJu4=;
        b=kxTfLtv/lWmDYE8wRr+iM1UCkyZWIMoAI8rqfUOZ2NxsuDSbxte55nWb5Jp5Fb/qGr
         mJxuU+j3QwHN6GMkRr9Kmg3H4tfvWa+EcdHVGDOJL8gdk+EffJPNQlU+g/ViHRN7wT15
         NpIJpVHj6d7EzUItNEflNuVKEKIJXCtkZu8RHfeJ/r4Zzcns+xmrYb6WI1epIYprOtiv
         P70f9wrUAtVNQ8EbtsPe2vd+sqcFZLltUrjyfsmk/d8zrKnEA+42lxdWbNw87rLQNsKe
         sNdDOBMu179Bkr8ImZtNJk2q8E2gGLOYyr4XgtsbL5da/E2PNSccvl1wsyMqM4TfjZzo
         Cakw==
X-Forwarded-Encrypted: i=1; AJvYcCWgUrdAWzH+7/8bvGvWmExWh2eU0yBfuXO23MnQvHEAzDAm9NjCV6tYB1fO2LEy87diCXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxklcnd1Buiog8C8zSf7uhurxQxAvqmsV5e3mPCwBOUzUUH+bj
	L1lKsn/MdXrjI/yFKAoWc/y0JayF3OSUaYsWMXUCTec005ixQxd4Vva2L2KlOolkfgUIUemd35/
	bGCkSXvFfxujsA30A0JdzW0HwVIeeNns=
X-Gm-Gg: ATEYQzx8ciR1lzeIgOycjQ/9bJ0gIaYb1/IE1zL5JquG6zkbrAs1S2EhzVCEZgJ5f92
	7ZmE0QWk8xqPr5A7sfyRGQq/MLJx/6ykSTL63foQj3V2tK6yENwb06ZxjPOKkKjzKwn6Azm9Oco
	0rclOIWVq+zKrxN/avoC7YxIrUQ9uYnXCG3rJguDugvTn3Iv31XlELdOkEwAAF5jf+U/Y1E+QdZ
	GfPEMiNwE0EM0oDu3BigIdi7byTa/3FYstYH75Bwz3oo37Vgq4hYwlUMu6J2kd9s3WKegn9lcyU
	ko7EcX8DGZMBBozD6FJWsK9Q/b4o1Fv3RgSgDkVVj5PG3OwOYfUOXuS8A4GH9zEjaP2jz90=
X-Received: by 2002:a05:6000:1866:b0:43b:4e32:c28d with SMTP id
 ffacd0b85a97d-43b6423b7a5mr729552f8f.20.1773945704220; Thu, 19 Mar 2026
 11:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <absfZGD3en9TUA1U@tardis.local> <absj6rZbyLZY8PPz@tardis.local>
 <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com> <abs026TUV9oAg_Xy@tardis.local>
 <abtMhd_LVp3uL_pA@tardis.local> <20260319090315.Ec_eXAg4@linutronix.de>
 <abwkD0mOdAbD9ENJ@tardis.local> <20260319163350.c7WuYOM9@linutronix.de>
 <abwo0I_mu94t5Ews@tardis.local> <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
 <abwyGtG7hDpd8vBN@tardis.local>
In-Reply-To: <abwyGtG7hDpd8vBN@tardis.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 19 Mar 2026 19:41:06 +0100
X-Gm-Features: AaiRm51wYjrno40DhisCEIPYAvBDF-RQgKLPA-BvUi9SP1iqK7avBv6nbf7d0RM
Message-ID: <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace + PREEMPT_RT
To: Boqun Feng <boqun@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com, 
	boqun.feng@gmail.com, rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Mar 2026 at 18:27, Boqun Feng <boqun@kernel.org> wrote:
>
> On Thu, Mar 19, 2026 at 05:59:40PM +0100, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 19 Mar 2026 at 17:48, Boqun Feng <boqun@kernel.org> wrote:
> > >
> > > On Thu, Mar 19, 2026 at 05:33:50PM +0100, Sebastian Andrzej Siewior wrote:
> > > > On 2026-03-19 09:27:59 [-0700], Boqun Feng wrote:
> > > > > On Thu, Mar 19, 2026 at 10:03:15AM +0100, Sebastian Andrzej Siewior wrote:
> > > > > > Please just use the queue_delayed_work() with a delay >0.
> > > > > >
> > > > >
> > > > > That doesn't work since queue_delayed_work() with a positive delay will
> > > > > still acquire timer base lock, and we can have BPF instrument with timer
> > > > > base lock held i.e. calling call_srcu() with timer base lock.
> > > > >
> > > > > irq_work on the other hand doesn't use any locking.
> > > >
> > > > Could we please restrict BPF somehow so it does roam free? It is
> > > > absolutely awful to have irq_work() in call_srcu() just because it
> > > > might acquire locks.
> > > >
> > >
> > > I agree it's not RCU's fault ;-)
> > >
> > > I guess it'll be difficult to restrict BPF, however maybe BPF can call
> > > call_srcu() in irq_work instead? Or a more systematic defer mechanism
> > > that allows BPF to defer any lock holding functions to a different
> > > context. (We have a similar issue that BPF cannot call kfree_rcu() in
> > > some cases IIRC).
> > >
> > > But we need to fix this in v7.0, so this short-term fix is still needed.
> > >
> >
> > I don't think this is an option, even longer term. We already do it
> > when it's incorrect to invoke call_rcu() or any other API in a
> > specific context (e.g., NMI, where we punt it using irq_work).
> > However, the case reported in this thread is different. It was an
> > existing user which worked fine before but got broken now. We were
> > using call_rcu_tasks_trace() just fine in scx callbacks where rq->lock
> > is held before, so the conversion underneath to call_srcu() should
> > continue to remain transparent in this respect.
> >
>
> I'm not sure that's a real argument here, kernel doesn't have a stable
> internal API, which allows developers to refactor the code into a saner
> way. There are currently multiple issues that suggest we may need a
> defer mechanism for BPF core, and if it makes the code more easier to
> reason about then why not? Think about it like a process that we learn
> about all the defer patterns that BPF currently needs and wrap them in a
> nice and maintainable way.

This is all right in theory, but I don't understand how your
theoretical deferral mechanism for BPF will help here in the case
we're discussing, or is even appealing.

How do we decide when to defer? Will we annotate all locks that can be
held by RCU internals to be able to check if they are held (on the
current cpu, which is non-trivial except by maintaining a held lock
table, testing the locked bit is too conservative), and then deferring
the call_srcu() from the caller in BPF? What if you gain new locks? It
doesn't seem practical to me. Plus it pushes the burden of detection
and deferral to the caller, making everything more complicated and
error-prone.

Also, any unconditional deferral in the caller for APIs that can "hold
locks" to avoid all this is not without its cost.

The implementation of RCU knows and can stay in sync with those
conditions for when deferral is needed, and hide all that complexity
from the caller. The cost should definitely be paid by the caller if
we would break the API's broad contract, e.g., by trying to invoke it
in NMI which it is not supposed to run in yet, in that case we already
handle things using irq_work. Anything more complicated than that is
hard to scale. All of this may also change in the future where we
support call_rcu_nolock() to make it work everywhere, and only defer
when we detect reentrancy (in the same or different context).



>
> Regards,
> Boqun
>
> > > Regars,
> > > Boqun
> > >
> > > > > Regards,
> > > > > Boqun
> > > > >
> > > > Sebastian
