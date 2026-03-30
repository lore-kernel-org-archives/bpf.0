Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18E3ACA48
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774912294; cv=pass; b=Ob+k7XgW5gPlQzvoBx+r5bXIY3urSa4AKOu+bityP3nFDrQw6X2fWBtBwYQWiBXEd/H2Y9/UpqvOakQBZWfLowZx3bcrhk+FIElXhwW2ldO7iyo5Ac567JpMR8uVZOyP8Symuea8LWdVIygTEjDamRl/ySfJmpaqppq1kUlA4N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774912294; c=relaxed/simple;
	bh=Xlk69CbHq7YXfHffHNFKidhgJBIIGMAGYgQ8lHbIm7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0xAy7S9D9iclOr+OS7gms0AnAmmuEfxM7Ae/5J9L6e18S1dpw+0Fawoe1mIdQBUGnGdkSVsWuKsEpTqxoZRHEEBH4gKW20P1D+y8Fis9isOqsVAEJafx4z8guYN9w5oA8E3rjtGSci3rw42Y0BW4tyeefUnyLSWcY3pM+jnHGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHzQ+okt; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHzQ+okt"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so2513428b3a.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774912292; cv=none;
        d=google.com; s=arc-20240605;
        b=c3YcYLVVIvkmG/RFAwPiKlrLLBULZ9kY0Qx7fEEFTNDv1rgIhfdW+gktQLQcxNXaNK
         v2v1PPGPtf7SNyI03i+ESY25/h/0veJvk8gEjIWV9BvxhnWm7VcvS/FJFebQ1lxjh09A
         D8ZcU6+90F3anLCoKnTH/C4F+9v6DENsO5PKs0vNyxiFqyMz7BN+oItRRFwSUbl5QRxK
         5VwVoyDw1FgyMEcECn16VRMqeKu4sCJ1Dxo0mUfNM28MudF39n+x23wDsz1OxAxcYAK/
         vmwNhelslMuFviEbxw+oExP7+NEUQbB9iW4bC5VOpgssO+KfbcsImXP//JqSYzx18qiL
         r8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JH8r4uwZ2SOvWsJRS31tC8HqPJT2Sk+9LUu/tf8BBEw=;
        fh=Qz+h7taVC6bsMvRXky5UtUpe9Gr3bfAExt/9lbBnEZ0=;
        b=fFx1Sl1IBUIKuO9QH9GKR1//uMtb/UhjdSFUuWRj+FQ68GXD7D/BuPepHuiGEU4hkX
         zs7jTCYPUM6Pc+xQ15kxfgukOgqqAsBy6WNAPKBahavneSChcAdeWXnjEO+iZYndaleh
         CM4HGM4q8FEIBEbwyOOwePCAZ/xVVAW8JC7AUcGdg2tGZHszkqldFYrdomRmSnr1LbVx
         e+kzVL+JAq/jWy1UiNQxGgemxGD5oJ0KZsY4kFuAufKr5TMu1qXZxhKkxH9GgU7qE+5v
         Wzx2gvpd150i7WetwzgPyxegYXyNxQpfsqSmid1x7Daq50Z3xEHyCRFtTnjTCsyDxaHY
         XzEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774912292; x=1775517092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH8r4uwZ2SOvWsJRS31tC8HqPJT2Sk+9LUu/tf8BBEw=;
        b=AHzQ+oktEsBffv9FL+Mg3LxirK4YPZ3AACKj0ESBm24CfMa/46VewBU+6S0gdij79z
         lGKrAAKi7njGngUNwiX11FogmjWkddhIwVgz5r8t/dY8F65BHDKb1gfsLr/ooI3VtZQO
         6C4eXflR7V1VUcCAxSUgvX0wb5Hi0Ji/3CArDGUx91WKHTS3qu+S22FkVdGCHz+2nKwS
         LlssWUc2lQUzw/EpzGMk5Whtb6FR5VNT7rnv1w7O4qScdWoHwEW3jznUMjc45D+DtbXS
         B0hAAsYuGnbkT0SEcv+wvGtgQSJw/F/DfJ8MZP0hHOW30mi/J/q7gCHkzYFCN1eWqYlI
         IQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774912292; x=1775517092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JH8r4uwZ2SOvWsJRS31tC8HqPJT2Sk+9LUu/tf8BBEw=;
        b=nYmNdq4NfEiOpx9nZqQ1ugWNq660cXExEtcQpAQKMt0GFvEh2J6QjMLQeHCS5Y40FW
         RkbKX4q4nmi/drAM/6QK60ZoHvyAXIJXvUClBpN5zXffqszr+MBdw0noSLcQd/ewbi6f
         YTE4ttIXb9WSvaIC9FbYKVSSZhn0ih8sGxlGwt0VQIHMBUmf/FfTeJwjuiFserCzguue
         +RlVa5BGzv7Uu28Zss5182RBEBhKOSrY5hf+iJDFUq1Yz3ccaJvo9cG3XWlyIGANHudx
         I+9tunz7i18OzDlRBCWC7eGW0YLCMauaePdXZjR3s1T32du8NQimYxb5JqmclptokbEa
         Lb0w==
X-Gm-Message-State: AOJu0YxVJTpKSOA6PODDUdYMNE5BanfShKh5uM3n9KxnNjBVI2jTRbC3
	xCRcN+XAaIitWsgTvXGLBpbDAdwQgDQbTLxAJekn0tb4ytJ+bZonq1yrRl96vSuI0RWrq0y5hHi
	cEXrb/1rYKvErFv2/SVvq4K9nW4ErO+I=
X-Gm-Gg: ATEYQzzHUiNCVV0SbiNZSBRqOnvyH9FBrp1yRAXHfqqghfey5bp8X7rOJ8ZJbw4IM9Y
	7MH+9p7rlEPr7YFNE8exSHZOIJRLBmM+Cz7zv/Jd0xSH8Tikbo49UTkn/zimQXBbYoGR30IBKm2
	8szygY72TuECzXftP8OBdnp38Ixcbj2/uGGUAO8NzrcsOcayO+L8AwvFAHCmxuX2gN2Z9km81rq
	31/iid11k+cvvB28tqwMyeOYiqbsFpi5dAAzW8dxFNaLAEb6nDN374f+3TijOb4CLGtB78IPLe9
	EqqXnkVDhgSWJpmJQJrluwY=
X-Received: by 2002:a05:6a20:72a6:b0:398:7866:e8e8 with SMTP id
 adf61e73a8af0-39c87abf804mr15352165637.31.1774912291737; Mon, 30 Mar 2026
 16:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330143102.1265391-1-memxor@gmail.com> <20260330143102.1265391-2-memxor@gmail.com>
 <CAEf4BzYXB9vLRey9zRU-h23NB_Mf-Uc0MznrTrByZDpsSZJ0EQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYXB9vLRey9zRU-h23NB_Mf-Uc0MznrTrByZDpsSZJ0EQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 16:11:19 -0700
X-Gm-Features: AQROBzDTBAXnGK75ZHyy_WGGw_CRFRkuqSr-y43DD88nAaI2UjnYyCJfNAHY3E4
Message-ID: <CAEf4BzZSEsOyyPpAjU8DGoWxAW_pmXsDvLLUo82mjbT7e_7kaw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix grace period wait for tracepoint bpf_link
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 4:09=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 30, 2026 at 7:31=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Recently, tracepoints were switched from using disabled preemption
> > (which acts as RCU read section) to SRCU-fast when they are not
> > faultable. This means that to do a proper grace period wait for program=
s
> > running in such tracepoints, we must use SRCU's grace period wait.
> > This is only for non-faultable tracepoints, faultable ones continue
> > using RCU Tasks Trace.
> >
> > However, bpf_link_free() currently does call_rcu() for all cases when
> > the link is non-sleepable (hence, for tracepoints, non-faultable). Fix
> > this by doing a call_srcu() grace period wait.
> >
> > As far RCU Tasks Trace gp -> RCU gp chaining is concerned, it is deemed
> > unnecessary for tracepoint programs. The link and program are either
> > accessed under RCU Tasks Trace protection, or SRCU-fast protection now.
> >
> > The earlier logic of chaining both RCU Tasks Trace and RCU gp waits was
> > to generalize the logic, even if it conceded an extra RCU gp wait,
> > however that is unnecessary for tracepoints even before this change.
> > In practice no cost was paid since rcu_trace_implies_rcu_gp() was alway=
s
> > true. Hence we need not chaing any RCU gp after the SRCU gp.
> >
> > For instance, in the non-faultable raw tracepoint, the RCU read section
> > of the program in __bpf_trace_run() is enclosed in the SRCU gp, likewis=
e
> > for faultable raw tracepoint, the program is under the RCU Tasks Trace
> > protection. Hence, the outermost scope can be waited upon to ensure
> > correctness.
> >
> > Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRAC=
E_CALL() with SRCU-fast")
> > Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/tracepoint.h |  8 ++++++++
> >  kernel/bpf/syscall.c       | 26 ++++++++++++++++++++++++--
> >  2 files changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 22ca1c8b54f3..8227102a771f 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -113,6 +113,10 @@ void for_each_tracepoint_in_module(struct module *=
mod,
> >   */
> >  #ifdef CONFIG_TRACEPOINTS
> >  extern struct srcu_struct tracepoint_srcu;
> > +static inline struct srcu_struct *tracepoint_srcu_ptr(void)
> > +{
> > +       return &tracepoint_srcu;
> > +}
> >  static inline void tracepoint_synchronize_unregister(void)
> >  {
> >         synchronize_rcu_tasks_trace();
> > @@ -123,6 +127,10 @@ static inline bool tracepoint_is_faultable(struct =
tracepoint *tp)
> >         return tp->ext && tp->ext->faultable;
> >  }
> >  #else
> > +static inline struct srcu_struct *tracepoint_srcu_ptr(void)
> > +{
> > +       return NULL;
> > +}
> >  static inline void tracepoint_synchronize_unregister(void)
> >  { }
> >  static inline bool tracepoint_is_faultable(struct tracepoint *tp)
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 274039e36465..89fa8f00adfa 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3261,6 +3261,17 @@ static void bpf_link_defer_dealloc_rcu_gp(struct=
 rcu_head *rcu)
> >         bpf_link_dealloc(link);
> >  }
> >
> > +static bool bpf_link_is_tracepoint(struct bpf_link *link)
> > +{
> > +       /*
> > +        * Only these combinations support a tracepoint bpf_link.
> > +        * BPF_LINK_TYPE_TRACING raw_tp progs are hardcoded to use
> > +        * bpf_raw_tp_link_lops, see bpf_raw_tp_link_attach().
> > +        */
> > +       return link->type =3D=3D BPF_LINK_TYPE_RAW_TRACEPOINT ||
> > +              (link->type =3D=3D BPF_LINK_TYPE_TRACING && link->attach=
_type =3D=3D BPF_TRACE_RAW_TP);
> > +}
> > +
> >  static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
> >  {
> >         if (rcu_trace_implies_rcu_gp())
> > @@ -3279,16 +3290,27 @@ static void bpf_link_free(struct bpf_link *link=
)
> >         if (link->prog)
> >                 ops->release(link);
> >         if (ops->dealloc_deferred) {
> > -               /* Schedule BPF link deallocation, which will only then
> > +               struct srcu_struct *tp_srcu =3D tracepoint_srcu_ptr();
> > +
> > +               /*
> > +                * Schedule BPF link deallocation, which will only then
> >                  * trigger putting BPF program refcount.
> >                  * If underlying BPF program is sleepable or BPF link's=
 target
> >                  * attach hookpoint is sleepable or otherwise requires =
RCU GPs
> >                  * to ensure link and its underlying BPF program is not
> >                  * reachable anymore, we need to first wait for RCU tas=
ks
> > -                * trace sync, and then go through "classic" RCU grace =
period
> > +                * trace sync, and then go through "classic" RCU grace =
period.
> > +                *
> > +                * For tracepoint BPF links, we need to go through SRCU=
 grace
> > +                * period wait instead when non-faultable tracepoint is=
 used. We
> > +                * don't need to chain SRCU grace period waits, however=
, for the
> > +                * faultable case, since it exclusively uses RCU Tasks =
Trace.
> >                  */
> >                 if (link->sleepable || (link->prog && link->prog->sleep=
able))
> >                         call_rcu_tasks_trace(&link->rcu, bpf_link_defer=
_dealloc_mult_rcu_gp);
> > +               /* We need to do a SRCU grace period wait for tracepoin=
t-based BPF links. */
> > +               else if (bpf_link_is_tracepoint(link) && tp_srcu)
> > +                       call_srcu(tp_srcu, &link->rcu, bpf_link_defer_d=
ealloc_rcu_gp);
>
> It bothers me that we have a special rule here just for tracepoints
> (and non-sleepable ones only), and fetch that srcu_struct...  it feels
> like we are missing some more fundamental link-type-specific grace
> period callback that could be overridden by link ops. E.g., perhaps we
> should be having something like
>
>
> if (ops->call_rcu)
>     ops->call_rcu(link, bpf_link_defer_dealloc_rcu_gp);
> else
>     /* current sleepable or non-sleepable RCU stuff */
>
> and for non-sleepable rawtps we'll have link_ops->call_rcu set to
> something that would fetch that tracepoint_srcu_ptr() and call
> call_srcu().
>
> I don't think we need to solve this right now, but if we ever have
> second case where link's attach hook has some extra lifetime nuances
> like this, we should generalize this. For now:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

there is also that comment in bpf_link_ops next to dealloc_deferred,
see if it should be updated a bit?

>
>
> >                 else
> >                         call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu=
_gp);
> >         } else if (ops->dealloc) {
> > --
> > 2.52.0
> >
