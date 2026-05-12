Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE019CC14
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551457; cv=pass; b=cxVkNumP5CX4ClVXkt3TNcXn4RsFlpk21VT69xbgui3/kys7raUT5222Ws78GIQFiIZLk/9x9QOh5ZnVun1KVj1/5yCB/k6MXBZ5evgX81SLLBN3W5Hnbc1N4Ytuu2xPEHusR26TzzL4b2e61QlHHhK59GvR/rOb5VLtZPM3tRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551457; c=relaxed/simple;
	bh=4NeX8+MH64UDuXf7smQyeQqhDeRmzD4GgNcM+hszQsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sdv1nAhwvPPKKTzlzSzkN6u2CVfrU8CUb6WXYKli1/7eXd+mA2TqwBPtwJzWUCbRTz9cMUM+MlO0PTA2dDJ2HN9oeV/9AEcEdISaCivZz5PkSb8fUz3veZZcrPp4TzuUHbNxx91wq7lXXi6jf4qNZDK8FZkFdQr8oorAIwGBzJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC5Cva8h; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC5Cva8h"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so83725545e9.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 19:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778551454; cv=none;
        d=google.com; s=arc-20240605;
        b=N0xNDhuoR4uc5L6zKM0WS7N7XrSSEk/xg98LJC3qIGGVRhlFc4mbs76/olhbfDCVbt
         uxRBThNZO6M5JT8m0FfNhDmmeArUff0vobHC4k5fsuev7r0wF7TVqiU+0q+6loG67LhM
         AUIgB2ugAM1H+DynReZ6AuM5+RjGtOw5P5m2egtOEn2PMKO5Oqelr9z0wJLByCiygJs/
         ZnDpKumY1koZZzX6CqW6HLQR9QjFWrGr8/2pgsLMieb7lzKb9mUqmApZqms6yiWANBeS
         wmftM3ZwpTG9PqAS09mph5BW84FQtfxCqf/zKXDoS8CJbM7AfHLRpxEkUk4VNHSwDenW
         dalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pi6UeXeeuhJXPitUPDrY3aHYuocNazWLnSV3iwa36yE=;
        fh=+7lMUt9LvkLzcTI3njwb4uQsPG/NndzQOmKF39UlJZw=;
        b=ZQGFD8AmKMOHbYNrejT5LH9fOJ0wacXL1g6FjUQBULXJqzzdzwX2+fkgkht1SNCgIA
         60wqnNCA8sZQSzzDNyOE8fBGnHPTmoJ8yN9rRrao8FxDhS8ILAssYqzqSXau9jT6ML0K
         362inV+MAcSmbf5XmCMpeG3bPQyDvWG9qQpMPz6g7FdRDHVfcFOfKCLufh2lfN60zL3J
         5ufYZ0LVMnL+nwB6JeKnmwiETwMDiW07uN3ahNbIetdOmXOEOWicsP2KfQDvil6DfBwd
         nEmWvZYb8vr/1pZgbpTpUh+xG8mkRJhIHvov1+pvkCFzLdWz9a5cNE7wBm27/t9IGZbC
         oUCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778551454; x=1779156254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pi6UeXeeuhJXPitUPDrY3aHYuocNazWLnSV3iwa36yE=;
        b=XC5Cva8hlfxwtynYjy+SehYA+BPr5luUpjvHKxz408RcmGjt5Zorm+WicZEUyx1rss
         YSdIjNd8U11f4mpik3TxNdLQ0NDWrTujedx487vxHtXIdYpcmicObltxZNrj2FzFWdz3
         j5emMXygKhv7NFeqQuehBQ98d1y+QP+H4hwuoGsB/zqu5625PugLcTQWgStvhzem8JYr
         +vrlEZS/RkabbZBUyoPHIm2ekfeIW3sxX66/uV4qNTQJJevc50BgDUWO/ak2wRouEW1S
         xARuSVOfKGG2Hh1OcEbamiYrqKI+EYI6NseDQkc1lNrSp5UO1N6xksCeKO+tqRkvIZnf
         S6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551454; x=1779156254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pi6UeXeeuhJXPitUPDrY3aHYuocNazWLnSV3iwa36yE=;
        b=VWS7QqNN6PsKC2emziWrbtvkLubPSS8icjZ43yzX1zMhU6YeSFD7V1g/BuuTVmYTGO
         7Hho616KdoiAAqV4sSTICcVY3ImzglZ/lBqNz7yjWEkRIRkP0XTXZqhTx3hRk5m/9VON
         wUAlKaVtFsl5hM/RML7/lrzGWHdtnPJ00rU+blQp6IX9OwaXVTfZ5aP8pjfweuObofsR
         IDEbzpUnnIErx19HxjC6xUIKWhC8Z1oCkbLNMcMoBl/bcSSHvEchlBzlg/fEE49+YvK8
         c2bkU88xE9JPiPgHG7SU3dOqkHfqR/oW281opDmtOgJBwPIwktQ65EXUFbFVGtLjuGvA
         Y5bw==
X-Forwarded-Encrypted: i=1; AFNElJ/ScH6jOplRrMb1Xi3JATcVJkIeX5eprrLHThtAMgazPCuZXeyPoCVoXdARkaehK9BuCvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5uJz3m4GHtENPC/u9VeRdNfNA3puK2LNjntScYGjGhjfZ4+3o
	gBP9RqNk3tcoTop5X8q3Is5cofASDoxGsxsgg0q52G3ttE6MA0XtTedfcAfXZcsxoAgQcV4fzgr
	mggzocKI+L34bCFTuSquXWpRFvHBTlhxxtTBr
X-Gm-Gg: Acq92OH0XqxCysKAv8AaZ+UEKkGLYJHLCGc0HDhmyc1hbx/07DVfis9SAaNPoI8vRbI
	0Kjj3lwSNW9Gis3+wcDsYRtPQuT4ETP2j37DRiOfx7deBi/6Y/VQq1rHxTNAOrC/abt0l0DXEFy
	HNRZbK+U1m+tHpoybxpAQ+gTBUUf9Ekrx13rTztHYUBXzmFWWcaFbk6iOnXHq1QVeZ7q3X8roH4
	osX41iOlAe05kBN+pKQVSNcZo29n0IrLQ7Z4kGcVr8SQFPrx6YFg2xQ9d/WdsELRXYmYq00Emtk
	C5NC70BLmn5YDBr6zkjcVKdbERUwqJYKZ2V5gP9BpP8wJfCOyK95s6hdFYRvw1o/RDdMxmhBujS
	MAomaGpz3SzDdRzl6EHoIf11GMxeJmScaUPnq2AWA3b0SL0TC7N8haPhL
X-Received: by 2002:a05:600c:37c6:b0:48e:7f22:d90 with SMTP id
 5b1f17b1804b1-48e7f7de432mr126415115e9.4.1778551453688; Mon, 11 May 2026
 19:04:13 -0700 (PDT)
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
 <DIGBOYWXZ95S.3GAGVQGUJNQD4@gmail.com>
In-Reply-To: <DIGBOYWXZ95S.3GAGVQGUJNQD4@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 12 May 2026 04:03:36 +0200
X-Gm-Features: AVHnY4K1wmJEXjd98BpUWgRql-KtSFsNveosERGCnbAxSH6F9u3CD74J3am_-ak
Message-ID: <CAP01T75y1CuPQ9af9SgYqY=c+3q7ZXTKJJu=znAE3HtEEBMwOw@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Justin Suess <utilityemal77@gmail.com>, sashiko@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 03:55, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon May 11, 2026 at 6:46 PM PDT, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 12 May 2026 at 03:43, Justin Suess <utilityemal77@gmail.com> wrote:
> >>
> >> On Mon, May 11, 2026 at 10:10:07PM +0200, Kumar Kartikeya Dwivedi wrote:
> >> > On Mon, 11 May 2026 at 19:29, Alexei Starovoitov
> >> > <alexei.starovoitov@gmail.com> wrote:
> >> > >
> >> > > On Mon May 11, 2026 at 9:38 AM PDT, Justin Suess wrote:
> >> > > >   [   21.604660] Call Trace:
> >> > > >   [   21.604662]  <TASK>
> >> > > >   [   21.604663]  dump_stack_lvl+0x5d/0x80
> >> > > >   [   21.604666]  print_usage_bug.part.0+0x22b/0x2c0
> >> > > >   [   21.604669]  lock_acquire+0x295/0x2e0
> >> > > >   [   21.604671]  ? terminate_walk+0x33/0x160
> >> > > >   [   21.604674]  ? __call_rcu_common.constprop.0+0x309/0x730
> >> > > >   [   21.604679]  _raw_spin_lock+0x30/0x40
> >> > > >   [   21.604680]  ? __call_rcu_common.constprop.0+0x309/0x730
> >> > > >   [   21.604682]  __call_rcu_common.constprop.0+0x309/0x730
> >> > > >   [   21.604686]  bpf_obj_free_fields+0x118/0x250
> >> > > >   [   21.604691]  free_htab_elem+0x85/0xd0
> >> > > >   [   21.604694]  htab_map_delete_elem+0x168/0x230
> >> > > >   [   21.604698]  bpf_prog_f6a7136050cb5431_clear_task_kptrs_from_nmi+0xeb/0x144
> >> > > >   [   21.604700]  bpf_trace_run3+0x126/0x430
> >> > >
> >> > > that's better.
> >> > > Looks like we moved bpf_obj_free_fields() into htab_mem_dtor(),
> >> > > but left check_and_free_fields() in free_htab_elem().
> >> > >
> >> > > I think the fix is to remove check_and_free_fields() from ma path in free_htab_elem()
> >> > > and fallback to bpf_mem_alloc at map create time when map has kptrs
> >> > > with dtors. Even when BPF_F_NO_PREALLOC is not specified.
> >> > >
> >> > > Kumar,
> >> > >
> >> > > thoughts?
> >> > >
> >> > >
> >> >
> >> > Yeah, removing it from the path that helpers can invoke seems simpler.
> >> > Remember though, this splat is just for hashtab, we have similar
> >> > bpf_obj_free_fields() in array map on update. I think fundamentally
> >> > the main issue here is that we logically free special fields when a
> >> > map value is freed or deleted. When updating array maps we logically
> >> > 'free' and then 'update' the same map value together. For hashtab, it
> >> > happens on update/delete.
> >> >
> >> > We could relax this behavior to avoid eagerly freeing these special
> >> > fields on update or deletion. The only worry is how this would impact
> >> > programs that have come to rely on the existing behavior. There are
> >> > patterns where people expect kptr to be NULL on some new map value,
> >> > which causes programs to return errors when that expectation is not
> >> > met. Just doing the skip when irqs_disabled() doesn't save us from the
> >> > surprise side-effect. We need to decide upon this first before
> >> > discussing the shape of the solution.
> >> >
> >> > This is the theoretical concern; In practice, I think most people who
> >> > depend on such behavior use kptr in local storage maps (in
> >> > schedulers). So it probably won't be a problem in practice, even
> >> > though we can't judge this ahead of time. Also, we eagerly reuse map
> >> > values when using memalloc, so the guarantees are already pretty weak
> >> > I guess.
> >> >
> >> > So, if we are not going to go through a grace period (like local
> >> > storage) and free back to kernel allocator before reuse, we should
> >> > relax field freeing behavior. At best, we should cancel work for
> >> > timer, wq, task_work, and task_work, leaving other items as-is. E.g.
> >> > BPF_UPTR is used in task storage which I think is accessible to
> >> > tracing programs, I am not sure how safe unpin_user_page() is when
> >> > called from random reentrant contexts. We might have more cases in the
> >> > future, we cannot guarantee we can handle everything in NMIs
> >> > universally.
> >> >
> >> > So the best course of action seems to be relaxing
> >> > bpf_obj_free_fields() to bpf_obj_cancel_fields() that just does cancel
> >> > on async work (timer, wq, task_work) for delete / update and let other
> >> > fields be as-is. We likely need to do bpf_obj_free_fields()
> >> > additionally before prealloc_destroy() now, but that should be simple.
> >> > Whether or not to use bpf_ma when kptrs are used in prealloc map is a
> >> > separate change.
> >> >
> >> > This should hopefully resolve the issue, unless I missed other cases.
> >> This does sound good, so you'd set the bpf_obj_free_fields up in the
> >> htab allocator dtor for the final free and rely on the allocators
> >> existing nmi deferral?
> >
> > It is already set, except for prealloc maps. But we can call it before
> > destroying the pcpu freelist etc.
>
> htab_map_free->htab_free_prealloced_fields does bpf_obj_free_fields already.
> So scratch my suggestion to force bpf_mem_alloc on preallocated hash maps.
>
> >>
> >> The missing piece is whether to handle this differently in NMI or just
> >> always do it with the deferral. Also the prealloc question needs
> >> answering.
> >
> > There is no deferral here. I'm saying that we just cancel for timer,
> > wq, task work, and leave other fields as is. So we don't have active
> > work pending for async items.
> >
> > So as long as the item keeps getting recycled in the allocator, we
> > don't free these fields. Once the memalloc is destroyed, the dtor runs
> > in a known safe context where we can assume bpf_obj_free_fields won't
> > deadlock or run into any problems.
>
> So the plan is to do
> if (in_nmi()) && case BPF_KPTR* | BPF_LIST_HEAD | BPF_RB_ROOT
> just ignore it?
> And no other changes anywhere at all?
>
> That would be too good to be true :)

I don't know whether in_nmi() would be sufficient, we likely need
irqs_disabled()? At that point, why not always ignore it, since
freeing the fields is dependent on where you're running. I would still
cancel async fields, since they're already any-context safe.
