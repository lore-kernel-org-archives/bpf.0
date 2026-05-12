Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A023BCEE
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550446; cv=pass; b=ciP/UnxIpGNEdsU6D4yk2/84AZMU2Lcv1FGSs9bxPekt+RbV9RMxNF0oKdUr5Fe1XreVQj3UNfkZotTy9WmcDkw5TaTHXzjQYnfE9UamAPiYBKxcLGO45+hWoFw/C39dX2eYXfnkYUgNujeh40T31ypAuoImUX8k3+IVik7/6kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550446; c=relaxed/simple;
	bh=mFt92ofFDbwAC8EJ3kykHIJ/05AZydy2HsAIgWaa1+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MF1/33n0DrWzXe9kUaJwABRhfTvaWaOlDiV1Sy/BhS0UkCCkJB5PEKHjtO3ww+P5qkR4JAuhuKQgJQi0Tq0NopSr94JSB6oCZCOnzBIIlCYHmPzq7x4MU5IfWlH2rE40yEcilrnwpxuteow6+NoYDpvqI37GRmb1Z3pCIRu2Reg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb9o2xj/; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb9o2xj/"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43fe62837baso2542152f8f.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 18:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778550443; cv=none;
        d=google.com; s=arc-20240605;
        b=TkFk+5SMPKjjagMQSQpNVffTM1YZAv1ESuZix4/90X1nvkaHDbGfj8SblD1BS1reCu
         2BJsB5bQkokEQnqUsQdlFt7C3h1ezbgi2zYk8bMeOLG//9XQ4hW5X/waw/vyCdksUceR
         +xAC1SOEN/EMINrxy/yLKa2J11J6nxtx3ALu4tDqcq53MUQSg4d9Bzq0ETbf1zG90wFe
         +NYclNJ/NV39Vz8XqoUitiIbDZxyag2yQS+SGsEFZtbqnNGrXMn+04dAWK+jWCG44YNP
         m4NpJPJsOg8JZJLwB8LVTs/c2hvZ6G4iuUsMegySZl+upMda26VEsKdci3zwZ/GDBIkV
         GSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=un0iP/nox0BXovMp0KiT5LCQ2CB0LlZftLKctJu7a7A=;
        fh=KMwPgj+xW3NMBYvnQ/G7fMSLTrKG98/LLGvcBZ+YbAw=;
        b=ghtgGwBujl5t4ICEXkjTnBUHcHe16U6JycMuPLoL3i00Nq7z+A7C+FeMn1jxuQVKH9
         tEv8e1DFgEaawENULSgsMYlS3QgVJqoI5XpJcAK3s4Z5K3DYKYPYPXKE3UtDcJsHrnxh
         p4UChucU+u4KjoRFlExUwY7ViFiaFFVjn32arXtr/KVIhRFOQv/Vk1Nc2gUo+yMUrjrB
         sEXdaKlItOTyLNsciZb2sAV1nf9yySoRuPXDHfz+tF6Vp832VhPgvUD0bTZU+lJ7Zi+8
         v+uyeKB+qA+lkD00iSMpcVy00DDItKjA3Ze5Znxczd23S52fL3wgYprqugRJeqtW7F8l
         L//Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778550443; x=1779155243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=un0iP/nox0BXovMp0KiT5LCQ2CB0LlZftLKctJu7a7A=;
        b=Xb9o2xj/3HdBuh8uCtTjO2D2JQFE5Pj63aDputFUDvgI7eQ13Cwh5Bs+S8s8/qgojf
         zcgICVVggpXbY1Z7YizmGd3lWK/bh5OM9o6W72h9rr8lgMFuK/1JW1IC+IVeC21Rcx9x
         whXiUWd+3JRLL0R/Of9YYE5LWtmJ8d13MKOphXJrQ7eoGbsg2A8zRB50FKz+GSXHGUIK
         2ZNKL3NkvwH/2y03yYT+6+DsA+2bnUSncQiFF8C1H7hok/mwnuesK4K1hx+gaRuNWIPD
         bx3R5ajBcUAxwOTx6B54+2zpPVeMSJpuBD1WN3EOiilEpCh+uIiUqt5oP2WmqrONgOeo
         qWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778550443; x=1779155243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un0iP/nox0BXovMp0KiT5LCQ2CB0LlZftLKctJu7a7A=;
        b=q3A7gXnZeHye4uHkCQVIWIgMtrJJuQTFnkpgNH+4/F5ut922UtaKBUVe8KeBBsbSiJ
         6ERxtZWY7n0ugGPzE8xr3E3ZOi2JoPduFcLYdwgtHXSc8AHl4bHsfOXrt8UAkLWCvBcl
         0dlE0QFMbuBFXFetx904sT8sNl/omBaZHIWYuPJxDbxB9bTSwhumLcNp4G4KhZ0GSkPg
         zZW67XIubLKKMLqnLHTmaOE6gbcbJrP30WAfTt3Uf0FVj3ngkRxrU1D4KtCZBlEB3yze
         /azyoh8+3kFyTh7vkUNMRGt4QOGRyzw1MLk3/SwmjRGMkmhcu9nJfcPmm48OzEvWiP6G
         Pt4w==
X-Forwarded-Encrypted: i=1; AFNElJ8MzFDQ8RBlZx43SeJebS2PQ9Go40iK8jL9RyDAZmBcnWtFRz0jNwIFLGPp+9e/b2Y0UjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD9Pq1zstXf4IkIndK0pBLD0yacM7mYaJVfR8W7s8+zYTQujUE
	uj3zkgSAwJZisO36SOTOU684PK72IDr5QXz1q7vR4tO1tjD1Cp3tWVZweM1P4s7fwquto+D9CK3
	ljLsKaYsS0CY+J8C3FkJ9GeBoHGisj+k=
X-Gm-Gg: Acq92OF5RXCawNlO9/4DtAMW3dhHELYwYcfWmKo4Qja8ebaVYjsd3JKox13QWxPKBTl
	2pfNSRAnNxAm0+NbECxel2JTtg8S5nk+/cJ7c5ElnAe4aO9tTn+lEZLcvbe3bYg8R56wcuQmre7
	95Y9wBNhPHj8kC6D+q4uicLJHEp/81ikSR7ImCSR/e5qy12It8T3eip4bXrqfQBzWCD/LS7dRwZ
	vAGQY4UV5AgvdlR8UWu3M3R6fKtdWdgso1hf/lBB+hsG3j0/uJSgSJ/8AuJ4wBKbaebSmfF0Pu+
	xCRgUW0wqZy5oZoVYWtrL4cAf22pyAJpbtHMlzrj9GJGJen/G8OkZ4Gw6wWWz9ouhKMpTw3h3C5
	iJ9aeCzqX+PANRxhQuazUY6uMQdBC2jLitn+I9CKbiIr9ZtOrOPFfZHbs
X-Received: by 2002:a05:6000:2483:b0:451:2157:6291 with SMTP id
 ffacd0b85a97d-45b14adc11bmr833840f8f.41.1778550443320; Mon, 11 May 2026
 18:47:23 -0700 (PDT)
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
 <CAP01T75942V+wKJD0yhs8yb7U5vj+y9s6efJ+UdpTMfzP31CWg@mail.gmail.com> <agKBE4Ci4_LmJ1Dc@zenbox>
In-Reply-To: <agKBE4Ci4_LmJ1Dc@zenbox>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 12 May 2026 03:46:47 +0200
X-Gm-Features: AVHnY4LK2w3gCkV7Ol2pg6asG_4E6xJevb-hMpBHMd-CD5fc-bV1lEo2ez45e-s
Message-ID: <CAP01T76i3S93kvXnQvK+NU1ee82s+ka2jQfmf-yL86r9AS2tuQ@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, sashiko@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 03:43, Justin Suess <utilityemal77@gmail.com> wrote:
>
> On Mon, May 11, 2026 at 10:10:07PM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 11 May 2026 at 19:29, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon May 11, 2026 at 9:38 AM PDT, Justin Suess wrote:
> > > >   [   21.604660] Call Trace:
> > > >   [   21.604662]  <TASK>
> > > >   [   21.604663]  dump_stack_lvl+0x5d/0x80
> > > >   [   21.604666]  print_usage_bug.part.0+0x22b/0x2c0
> > > >   [   21.604669]  lock_acquire+0x295/0x2e0
> > > >   [   21.604671]  ? terminate_walk+0x33/0x160
> > > >   [   21.604674]  ? __call_rcu_common.constprop.0+0x309/0x730
> > > >   [   21.604679]  _raw_spin_lock+0x30/0x40
> > > >   [   21.604680]  ? __call_rcu_common.constprop.0+0x309/0x730
> > > >   [   21.604682]  __call_rcu_common.constprop.0+0x309/0x730
> > > >   [   21.604686]  bpf_obj_free_fields+0x118/0x250
> > > >   [   21.604691]  free_htab_elem+0x85/0xd0
> > > >   [   21.604694]  htab_map_delete_elem+0x168/0x230
> > > >   [   21.604698]  bpf_prog_f6a7136050cb5431_clear_task_kptrs_from_nmi+0xeb/0x144
> > > >   [   21.604700]  bpf_trace_run3+0x126/0x430
> > >
> > > that's better.
> > > Looks like we moved bpf_obj_free_fields() into htab_mem_dtor(),
> > > but left check_and_free_fields() in free_htab_elem().
> > >
> > > I think the fix is to remove check_and_free_fields() from ma path in free_htab_elem()
> > > and fallback to bpf_mem_alloc at map create time when map has kptrs
> > > with dtors. Even when BPF_F_NO_PREALLOC is not specified.
> > >
> > > Kumar,
> > >
> > > thoughts?
> > >
> > >
> >
> > Yeah, removing it from the path that helpers can invoke seems simpler.
> > Remember though, this splat is just for hashtab, we have similar
> > bpf_obj_free_fields() in array map on update. I think fundamentally
> > the main issue here is that we logically free special fields when a
> > map value is freed or deleted. When updating array maps we logically
> > 'free' and then 'update' the same map value together. For hashtab, it
> > happens on update/delete.
> >
> > We could relax this behavior to avoid eagerly freeing these special
> > fields on update or deletion. The only worry is how this would impact
> > programs that have come to rely on the existing behavior. There are
> > patterns where people expect kptr to be NULL on some new map value,
> > which causes programs to return errors when that expectation is not
> > met. Just doing the skip when irqs_disabled() doesn't save us from the
> > surprise side-effect. We need to decide upon this first before
> > discussing the shape of the solution.
> >
> > This is the theoretical concern; In practice, I think most people who
> > depend on such behavior use kptr in local storage maps (in
> > schedulers). So it probably won't be a problem in practice, even
> > though we can't judge this ahead of time. Also, we eagerly reuse map
> > values when using memalloc, so the guarantees are already pretty weak
> > I guess.
> >
> > So, if we are not going to go through a grace period (like local
> > storage) and free back to kernel allocator before reuse, we should
> > relax field freeing behavior. At best, we should cancel work for
> > timer, wq, task_work, and task_work, leaving other items as-is. E.g.
> > BPF_UPTR is used in task storage which I think is accessible to
> > tracing programs, I am not sure how safe unpin_user_page() is when
> > called from random reentrant contexts. We might have more cases in the
> > future, we cannot guarantee we can handle everything in NMIs
> > universally.
> >
> > So the best course of action seems to be relaxing
> > bpf_obj_free_fields() to bpf_obj_cancel_fields() that just does cancel
> > on async work (timer, wq, task_work) for delete / update and let other
> > fields be as-is. We likely need to do bpf_obj_free_fields()
> > additionally before prealloc_destroy() now, but that should be simple.
> > Whether or not to use bpf_ma when kptrs are used in prealloc map is a
> > separate change.
> >
> > This should hopefully resolve the issue, unless I missed other cases.
> This does sound good, so you'd set the bpf_obj_free_fields up in the
> htab allocator dtor for the final free and rely on the allocators
> existing nmi deferral?

It is already set, except for prealloc maps. But we can call it before
destroying the pcpu freelist etc.

>
> The missing piece is whether to handle this differently in NMI or just
> always do it with the deferral. Also the prealloc question needs
> answering.

There is no deferral here. I'm saying that we just cancel for timer,
wq, task work, and leave other fields as is. So we don't have active
work pending for async items.

So as long as the item keeps getting recycled in the allocator, we
don't free these fields. Once the memalloc is destroyed, the dtor runs
in a known safe context where we can assume bpf_obj_free_fields won't
deadlock or run into any problems.

>
> [...]
