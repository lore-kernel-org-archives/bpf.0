Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA438330A
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552020; cv=pass; b=N2JTAKHyiUhHVb/YT1jEI6Nj4mPBtZoGJV6lwOzP54AEWrM2nXZpDl8G854cNdGp2oeD+6wiFsWbVWWZwrE+J/+Xw8Dv8Fjlsckn1E7kZRfpv5b4xkBKYpMu2q8j/OaRSSuXqp+8yn2IJvYytfuN6ztJYA9x9QYEt5Dvyh8ezm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552020; c=relaxed/simple;
	bh=P4+Zr1GIkEfutwCczqL5o+kD/OEMgVRPert8Uyv35a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3GUGHNvafClnlQuNsh21EW2Zi2yvRTubWPgmVZqMF4s8CvGfifXFKtHhoV5nlanD/LmFXbq73j4fpWVUy99jJNESmNuroj0H0aEPm2uRdRmSPM6kWn6lH2hsG1T9Uh9X2Ju6yHyRHgC8YcNiRbI3F4W06ks0KjKD9BBANZ0/kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVm2LF0N; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVm2LF0N"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so83797635e9.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 19:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778552017; cv=none;
        d=google.com; s=arc-20240605;
        b=ZODO32NYGcp6o2s9gPEFOE0kJD63+9Hn75vVUJ3aveDEqVaXRRvHUqaHQTx4DhkhiT
         RyOX4BK2vhqTY/tUKZaTC449Wsi1g0TlhOwexnXqX5rjS7HOag+MbqERBbty4K7SooQ9
         mMRM/yYmuLrmNG5ykdccfIhs273iwoX8u2kHSk99RQTPNpwxxQFobiCsrmtdm8zUG5OA
         IurOf4xQEPvYxT03yFnK1sDOO/PJHEtfNEbbzVOKCtozBfvxi+XrVQfF0LrcZkNKRDpp
         0PCzk9ptuY5e37XfKPiwnjBWFqExXtiXIued7hXyOeiOpDwZDCsVDaXrsiMt6VvBIDHd
         FOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yvmEPWhcfTWxDEchg5ZkewS+3/xfIv7Hmhbhu8n+gyc=;
        fh=1f154Pq1bRjSarC3cBpKspETrWMXhIWMKsacke2lVUg=;
        b=CGtYyuBnctew9hQctoKQ1Dyh8u07Jc078/UEzJDmpJGsIyJ0cl2Wj2BiH4n+ny9G6x
         5kJ50yXhr03TeEs4DXt9cMZ9tYP8xfhUvB4YrEREeL6icua1I9MijASrVRFLbXy+vNWk
         hgdB4GLfEdpAB87YWg993aDr8RUCNKdv3LJBgFhsCBrKze2cHDAl4Kn/Af0qAQOc7oyD
         VFkLX9oud8Q4x/Vbph/5ZZVBnkN1Rs4PbW1PwQzq9YKin1O0JlduSvbA8V5KJqXwDvK1
         /spAa5wuHGTDyKMygzzUYi5hCti/5UQpdK/ro+9rRqXhiMTEUTg589+Q68BQ90tPmBTW
         TQDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778552017; x=1779156817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yvmEPWhcfTWxDEchg5ZkewS+3/xfIv7Hmhbhu8n+gyc=;
        b=iVm2LF0NA0Acj1K0sx353K2pnNsRkzIG3VjDuE7G9T7JCmIGWUn+BDHZvbajOiQJN4
         Uz9/i+pdDJNsBMdX15/UvyA9IHq0EqrU+iqMbg9gDbydUk62mSTqYSPs7gP25psef532
         7sluW0a3LUIh9LkJT0m815bi5wnsty2VD09Ad9DzZRTYP+j7kgWIXq0wuijsZLmYXlu3
         7/YPKn/UIzQMR0Z/pfdhJDEFMpJRWwjTqhxniZRHOVN4SW3PhquRTWpGP8M26AcWy3Yu
         joxpceybexrHvyVYBI8W1PqshoYc6axPdvxtc6Yu6l3G2rSnYTEOwTcKRDTVBql3XfNF
         jIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778552017; x=1779156817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvmEPWhcfTWxDEchg5ZkewS+3/xfIv7Hmhbhu8n+gyc=;
        b=ClSt1XSScK34Bqxc/QIvGt/mOAQV8MWV2Np64XPoTVrJA+YyiDsF2kegE34HXJ53pL
         UsjLMlV1O4PR/FsV3w1nzrS0KxbPP1YeLH3cxFEADHFnes/6/+Rpb0hfJEYrWMBrBoNQ
         8walbT7ehqJtycTrlj1ToJq+2V6e3d9xcPwX/sXQNcg5j7+CPQ+1pT7ZcaMZdxpnLdHR
         IBV6DP7jmoB/Y/wrxfnovbagwYUXRrtYxmBI+af8Nulintbt5v4JcEBRIpTViCQYGLM6
         eyHEzzj7xTrcEDVWqZbHF9S/irPaZ9YXcSiZugK+5PXb9zkryoFqgInOd5E2u7bPtQYM
         a0jw==
X-Forwarded-Encrypted: i=1; AFNElJ/UJLwLzfymh5QiZN5SFCVUMPeIY+WcCyuVtVLwROxGmg7HI+HVXlaLBV8TbYcqrCeqwS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDpYn5Mavr00nSfEOX47RII5rZRRTLpsmsBdFmz78TrPu7WRy
	/bihwXIXHujfUTJCEL2pYK5/5vy24EnspiAqwKJYxFap/PwHOssr/2AooDvS9lyflIPZbVqtAyU
	w5HmAZPszgXKnMGUsktzloQNUD+IELn3675eD
X-Gm-Gg: Acq92OFDifpJM/sQQmDWDudxJ7A/DRgghnhstOHiooZzeMGAxhiAu8ZqpmL/ut61Lj1
	Ji7nr40/VOeOpgD72sRGbgMowBwzGq02QIOfIyIfhCJD+EcN9xsTijJpB0nwonQSVwvOk9JNv4+
	l6aB6B9a8a8lwk4WZDSsKX05af8MQJAcWMNxH0SZa/HpSlU1B3YyQjUoOWBFyDxiMTiD1wS4yMB
	cn6kpQDlIeBFjGIIfCY2xeU+m2YI0JFLq3ZGLbLMjBVP9P0vPpV2RLH4Dq+yKk4QAmeN7KrPWiH
	Yqt8GR/M3imDiiwrIACSI6HBPscVHxDthHPjuiBJ1T3WdWHpwhvEQeLVbzO1CdeRvNapcKSuj+J
	Uyn1NcWTvz6hlZtNNHcGmQo7nshhHVpxX9Tk51tZ1014C5uV4+WGkJozf
X-Received: by 2002:a05:600c:8b08:b0:48a:5501:7995 with SMTP id
 5b1f17b1804b1-48e51f32ca9mr449429875e9.18.1778552017165; Mon, 11 May 2026
 19:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
 <20260507234520.646C4C2BCB2@smtp.kernel.org> <agCXEJKJh-JGMhjG@zenbox>
 <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>
 <agEnc0aYMhuIeDlq@zenbox> <DIFYUK5DKGAT.189D9YYSQFCUZ@gmail.com>
 <agH_0MEw4b0pB11-@suesslenovo> <DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com>
 <CAP01T75942V+wKJD0yhs8yb7U5vj+y9s6efJ+UdpTMfzP31CWg@mail.gmail.com>
 <agKBE4Ci4_LmJ1Dc@zenbox> <CAP01T76i3S93kvXnQvK+NU1ee82s+ka2jQfmf-yL86r9AS2tuQ@mail.gmail.com>
 <DIGBOYWXZ95S.3GAGVQGUJNQD4@gmail.com> <CAP01T75y1CuPQ9af9SgYqY=c+3q7ZXTKJJu=znAE3HtEEBMwOw@mail.gmail.com>
 <DIGBZVSAOXGC.VA20SWFV4R74@gmail.com>
In-Reply-To: <DIGBZVSAOXGC.VA20SWFV4R74@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 12 May 2026 04:13:00 +0200
X-Gm-Features: AVHnY4K9JXZZiEZVpzNn98npD_32lbPWj41MQ2Ugi4yey-pKI9TCGJcYBQxGMlc
Message-ID: <CAP01T772FHr6q3oD+AyUigdiPhVPdShP5qUyU2qCZrTGU1HZyQ@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Justin Suess <utilityemal77@gmail.com>, sashiko@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 04:10, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon May 11, 2026 at 7:03 PM PDT, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 12 May 2026 at 03:55, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Mon May 11, 2026 at 6:46 PM PDT, Kumar Kartikeya Dwivedi wrote:
> >> > On Tue, 12 May 2026 at 03:43, Justin Suess <utilityemal77@gmail.com> wrote:
> >> >>
> >> >> On Mon, May 11, 2026 at 10:10:07PM +0200, Kumar Kartikeya Dwivedi wrote:
> >> >> > On Mon, 11 May 2026 at 19:29, Alexei Starovoitov
> >> >> > <alexei.starovoitov@gmail.com> wrote:
> >> >> > >
> >> >> > > On Mon May 11, 2026 at 9:38 AM PDT, Justin Suess wrote:
> >> >> > > >   [   21.604660] Call Trace:
> >> >> > > >   [   21.604662]  <TASK>
> >> >> > > >   [   21.604663]  dump_stack_lvl+0x5d/0x80
> >> >> > > >   [   21.604666]  print_usage_bug.part.0+0x22b/0x2c0
> >> >> > > >   [   21.604669]  lock_acquire+0x295/0x2e0
> >> >> > > >   [   21.604671]  ? terminate_walk+0x33/0x160
> >> >> > > >   [   21.604674]  ? __call_rcu_common.constprop.0+0x309/0x730
> >> >> > > >   [   21.604679]  _raw_spin_lock+0x30/0x40
> >> >> > > >   [   21.604680]  ? __call_rcu_common.constprop.0+0x309/0x730
> >> >> > > >   [   21.604682]  __call_rcu_common.constprop.0+0x309/0x730
> >> >> > > >   [   21.604686]  bpf_obj_free_fields+0x118/0x250
> >> >> > > >   [   21.604691]  free_htab_elem+0x85/0xd0
> >> >> > > >   [   21.604694]  htab_map_delete_elem+0x168/0x230
> >> >> > > >   [   21.604698]  bpf_prog_f6a7136050cb5431_clear_task_kptrs_from_nmi+0xeb/0x144
> >> >> > > >   [   21.604700]  bpf_trace_run3+0x126/0x430
> >> >> > >
> >> >> > > that's better.
> >> >> > > Looks like we moved bpf_obj_free_fields() into htab_mem_dtor(),
> >> >> > > but left check_and_free_fields() in free_htab_elem().
> >> >> > >
> >> >> > > I think the fix is to remove check_and_free_fields() from ma path in free_htab_elem()
> >> >> > > and fallback to bpf_mem_alloc at map create time when map has kptrs
> >> >> > > with dtors. Even when BPF_F_NO_PREALLOC is not specified.
> >> >> > >
> >> >> > > Kumar,
> >> >> > >
> >> >> > > thoughts?
> >> >> > >
> >> >> > >
> >> >> >
> >> >> > Yeah, removing it from the path that helpers can invoke seems simpler.
> >> >> > Remember though, this splat is just for hashtab, we have similar
> >> >> > bpf_obj_free_fields() in array map on update. I think fundamentally
> >> >> > the main issue here is that we logically free special fields when a
> >> >> > map value is freed or deleted. When updating array maps we logically
> >> >> > 'free' and then 'update' the same map value together. For hashtab, it
> >> >> > happens on update/delete.
> >> >> >
> >> >> > We could relax this behavior to avoid eagerly freeing these special
> >> >> > fields on update or deletion. The only worry is how this would impact
> >> >> > programs that have come to rely on the existing behavior. There are
> >> >> > patterns where people expect kptr to be NULL on some new map value,
> >> >> > which causes programs to return errors when that expectation is not
> >> >> > met. Just doing the skip when irqs_disabled() doesn't save us from the
> >> >> > surprise side-effect. We need to decide upon this first before
> >> >> > discussing the shape of the solution.
> >> >> >
> >> >> > This is the theoretical concern; In practice, I think most people who
> >> >> > depend on such behavior use kptr in local storage maps (in
> >> >> > schedulers). So it probably won't be a problem in practice, even
> >> >> > though we can't judge this ahead of time. Also, we eagerly reuse map
> >> >> > values when using memalloc, so the guarantees are already pretty weak
> >> >> > I guess.
> >> >> >
> >> >> > So, if we are not going to go through a grace period (like local
> >> >> > storage) and free back to kernel allocator before reuse, we should
> >> >> > relax field freeing behavior. At best, we should cancel work for
> >> >> > timer, wq, task_work, and task_work, leaving other items as-is. E.g.
> >> >> > BPF_UPTR is used in task storage which I think is accessible to
> >> >> > tracing programs, I am not sure how safe unpin_user_page() is when
> >> >> > called from random reentrant contexts. We might have more cases in the
> >> >> > future, we cannot guarantee we can handle everything in NMIs
> >> >> > universally.
> >> >> >
> >> >> > So the best course of action seems to be relaxing
> >> >> > bpf_obj_free_fields() to bpf_obj_cancel_fields() that just does cancel
> >> >> > on async work (timer, wq, task_work) for delete / update and let other
> >> >> > fields be as-is. We likely need to do bpf_obj_free_fields()
> >> >> > additionally before prealloc_destroy() now, but that should be simple.
> >> >> > Whether or not to use bpf_ma when kptrs are used in prealloc map is a
> >> >> > separate change.
> >> >> >
> >> >> > This should hopefully resolve the issue, unless I missed other cases.
> >> >> This does sound good, so you'd set the bpf_obj_free_fields up in the
> >> >> htab allocator dtor for the final free and rely on the allocators
> >> >> existing nmi deferral?
> >> >
> >> > It is already set, except for prealloc maps. But we can call it before
> >> > destroying the pcpu freelist etc.
> >>
> >> htab_map_free->htab_free_prealloced_fields does bpf_obj_free_fields already.
> >> So scratch my suggestion to force bpf_mem_alloc on preallocated hash maps.
> >>
> >> >>
> >> >> The missing piece is whether to handle this differently in NMI or just
> >> >> always do it with the deferral. Also the prealloc question needs
> >> >> answering.
> >> >
> >> > There is no deferral here. I'm saying that we just cancel for timer,
> >> > wq, task work, and leave other fields as is. So we don't have active
> >> > work pending for async items.
> >> >
> >> > So as long as the item keeps getting recycled in the allocator, we
> >> > don't free these fields. Once the memalloc is destroyed, the dtor runs
> >> > in a known safe context where we can assume bpf_obj_free_fields won't
> >> > deadlock or run into any problems.
> >>
> >> So the plan is to do
> >> if (in_nmi()) && case BPF_KPTR* | BPF_LIST_HEAD | BPF_RB_ROOT
> >> just ignore it?
> >> And no other changes anywhere at all?
> >>
> >> That would be too good to be true :)
> >
> > I don't know whether in_nmi() would be sufficient, we likely need
> > irqs_disabled()?
>
> fair irqs_disabled() is safer.
>
> > At that point, why not always ignore it, since
> > freeing the fields is dependent on where you're running. I would still
> > cancel async fields, since they're already any-context safe.
>
> you mean never touch case BPF_KPTR* | BPF_LIST_HEAD | BPF_RB_ROOT
> regardless of running context and rely on final cleanup?
> That's an idea to consider, but I suspect some rbtree, link list
> tests will fail.

Yeah, but we should see which ones do, some of them were written with
expectation to test kernel clean up on map value delete / update etc.,
those don't count as much. Unless this change triggers a real example
in tests, it will likely go unnoticed (famous last words).
