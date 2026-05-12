Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9C246783
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 01:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550954; cv=none; b=SYQH9F8bQjq1d2I5aKZsTr+YgrhdaiYw76Mna8Z070TJ5cJ9sL75sF9Bk7D7x0DXBjUG/DT+c7C/IYS+qPG8ULbfC1IsX//U7Lr3VcUW9dXJd9S4fuWpNBW749+u/a0b376mt8TDpl7igy+Rk2RDFKkcI0+VpCvu7KaVWygGQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550954; c=relaxed/simple;
	bh=kwSpYYziqv4SEdevEEg/7aVLhcBkhUr7Z6Db89ZolOM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=fh9MbOp/Dm4evRwZ9uFbDTJfS63P+rBXYSz7inWrmtvHG4g7ZzlEkw0vIEJivY8x/DoS8UuqdOe6cY7tBBr1FVMQtghihD3J2guuo9iDzd90AgPg7FhTgTIebeSjmjSVT0Y4/Kc2J0ZBgEObGWFV04gPKjjlUEBCZh0rHRufWCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvdVKMf9; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvdVKMf9"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-479d593a0c3so4270229b6e.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 18:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778550952; x=1779155752; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAbwVAetbYyNoBOuPWIRYSYHV3st/5jwsKb4EPllJSI=;
        b=CvdVKMf9ZaSImB88xkPv6E4H4hL9FfLLRBbQkZaxbz7KiWLBnE1DXM5W7mENFJrCQP
         0G5ytxEYyu/zOGTrDw4vd2T6D5X6cJ0Bp5pbnbcbUpr69lTYox2oBe8CPk7DO1x8lKwb
         CdSW87GIlGP/ro9x2KptAPSjPrjN25xa0a7p1fhNaiV/9PS0TRckqmZQf5mGhNcNLeCh
         +7nuJvjSSbd804Dv+euPIP8RAAV7TrNhSilVopgerkutxGs2XSWm85eZ3FMXwyDZrjLG
         HJJcGQH9KM38A1EykDkIpPUbEAlHJJV3AVJBoe5wT9NQON+sFanaFYKS6w4tgUpyFrv/
         6i/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778550952; x=1779155752;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YAbwVAetbYyNoBOuPWIRYSYHV3st/5jwsKb4EPllJSI=;
        b=iv9h18BKXHUTls2od90VvjZdx40JefiAN7FYe/vjYbHc06J1Zq26JfDSyBmXFLOUWb
         jMP2t87fJgYIyvS8ONMu4T+3ojI6/2jnUa7GrP8BTPJNyK1B+sDdlMsYjVefxR41kqmK
         vJQ+V+U1pEcgGFNvZZdY2ZEHF/BRs+Jx7ZkoZ+KUZNOKuwo4y+aNB5JkBA3rjnl5TTTq
         kRYiNiR6ceLqgEuVtj0Qn7Ajxdgt6ueTaGQRI0tSKW1hOguX3jvf0iMcr6jIZJGd3t4I
         r0kLj4ZjKlLLBnJ/i4sn20h6+e2UXiPVY+rKxy+PDkt7TNwoaKIYIvoKKmt2WgQoc407
         z/RQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Kkd+Nu7JiTGDlhFsGxwZp+/Y3g6iuo6cI8VIqTGSarjrkCpg8n1PLbSVY8w7j719M8EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/zORzwRCqJFvIbuUCHKvKIL3Ux8QVNbWG/ojVQ7y+eRFSXSq
	dwL8RffmUbiyaAfDRZ9Gw9PUhhr9D/Bm3n6Fd4v8qR8epa6SCZbSoGF2Hcn0Wg==
X-Gm-Gg: Acq92OH88jWcv8aX5CKURokCeATCTp7fzCgusq6QLi3S9wgsHODdKzuY9uR556q2iPt
	2qFjD262N1iSVYiQWcgCrIhjWagEEwak9ELgseH96cESdfiKV+XAm487yisDkTGviaKjoc5L9bj
	6oG68ddbpP2eHoGDdsP3agLRYFv52vZrpPq1YiXg3657vcTHNaca4rwvSg+RB2yy8sbvz5fF1IW
	MxWW7H9o/YvgtNei5Ia19Kf2AKifZB1BdQOSLFutU7bB0LWaJbv/i095oz73BgcNgxyfljzoidj
	HghmpYn4pose0uOVSXuWIhrQMfI0BDBexJ5KqWpyFwScV6D8eyqrzR1PvfSrmnw+hSz75ToDLCE
	WpbgbHNyKRiTLdAE3uqi8XNUPp+dTE0wHxe03IeyhuEZPrmKZG4xbRqzqnVWVVPx8B1wMn2rwgL
	q2/YqKZzGfSs4PygN0Eu6NdAJlCHctkdlqm3r/SH7DCc4JGiFTblQ96mX7GUlj45qwwFtTkBN2p
	76WWrnwlRrilAK9sQjaZrNHJts=
X-Received: by 2002:a05:6808:c40c:b0:47c:34fd:d3be with SMTP id 5614622812f47-48293d8a5bbmr1270270b6e.25.1778550951603;
        Mon, 11 May 2026 18:55:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367be1173sm7993935a34.3.2026.05.11.18.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 18:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 18:55:50 -0700
Message-Id: <DIGBOYWXZ95S.3GAGVQGUJNQD4@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Justin Suess"
 <utilityemal77@gmail.com>
Cc: <sashiko@lists.linux.dev>, "bpf" <bpf@vger.kernel.org>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from
 NMI
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
 <20260507234520.646C4C2BCB2@smtp.kernel.org> <agCXEJKJh-JGMhjG@zenbox>
 <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>
 <agEnc0aYMhuIeDlq@zenbox> <DIFYUK5DKGAT.189D9YYSQFCUZ@gmail.com>
 <agH_0MEw4b0pB11-@suesslenovo> <DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com>
 <CAP01T75942V+wKJD0yhs8yb7U5vj+y9s6efJ+UdpTMfzP31CWg@mail.gmail.com>
 <agKBE4Ci4_LmJ1Dc@zenbox>
 <CAP01T76i3S93kvXnQvK+NU1ee82s+ka2jQfmf-yL86r9AS2tuQ@mail.gmail.com>
In-Reply-To: <CAP01T76i3S93kvXnQvK+NU1ee82s+ka2jQfmf-yL86r9AS2tuQ@mail.gmail.com>

On Mon May 11, 2026 at 6:46 PM PDT, Kumar Kartikeya Dwivedi wrote:
> On Tue, 12 May 2026 at 03:43, Justin Suess <utilityemal77@gmail.com> wrot=
e:
>>
>> On Mon, May 11, 2026 at 10:10:07PM +0200, Kumar Kartikeya Dwivedi wrote:
>> > On Mon, 11 May 2026 at 19:29, Alexei Starovoitov
>> > <alexei.starovoitov@gmail.com> wrote:
>> > >
>> > > On Mon May 11, 2026 at 9:38 AM PDT, Justin Suess wrote:
>> > > >   [   21.604660] Call Trace:
>> > > >   [   21.604662]  <TASK>
>> > > >   [   21.604663]  dump_stack_lvl+0x5d/0x80
>> > > >   [   21.604666]  print_usage_bug.part.0+0x22b/0x2c0
>> > > >   [   21.604669]  lock_acquire+0x295/0x2e0
>> > > >   [   21.604671]  ? terminate_walk+0x33/0x160
>> > > >   [   21.604674]  ? __call_rcu_common.constprop.0+0x309/0x730
>> > > >   [   21.604679]  _raw_spin_lock+0x30/0x40
>> > > >   [   21.604680]  ? __call_rcu_common.constprop.0+0x309/0x730
>> > > >   [   21.604682]  __call_rcu_common.constprop.0+0x309/0x730
>> > > >   [   21.604686]  bpf_obj_free_fields+0x118/0x250
>> > > >   [   21.604691]  free_htab_elem+0x85/0xd0
>> > > >   [   21.604694]  htab_map_delete_elem+0x168/0x230
>> > > >   [   21.604698]  bpf_prog_f6a7136050cb5431_clear_task_kptrs_from_=
nmi+0xeb/0x144
>> > > >   [   21.604700]  bpf_trace_run3+0x126/0x430
>> > >
>> > > that's better.
>> > > Looks like we moved bpf_obj_free_fields() into htab_mem_dtor(),
>> > > but left check_and_free_fields() in free_htab_elem().
>> > >
>> > > I think the fix is to remove check_and_free_fields() from ma path in=
 free_htab_elem()
>> > > and fallback to bpf_mem_alloc at map create time when map has kptrs
>> > > with dtors. Even when BPF_F_NO_PREALLOC is not specified.
>> > >
>> > > Kumar,
>> > >
>> > > thoughts?
>> > >
>> > >
>> >
>> > Yeah, removing it from the path that helpers can invoke seems simpler.
>> > Remember though, this splat is just for hashtab, we have similar
>> > bpf_obj_free_fields() in array map on update. I think fundamentally
>> > the main issue here is that we logically free special fields when a
>> > map value is freed or deleted. When updating array maps we logically
>> > 'free' and then 'update' the same map value together. For hashtab, it
>> > happens on update/delete.
>> >
>> > We could relax this behavior to avoid eagerly freeing these special
>> > fields on update or deletion. The only worry is how this would impact
>> > programs that have come to rely on the existing behavior. There are
>> > patterns where people expect kptr to be NULL on some new map value,
>> > which causes programs to return errors when that expectation is not
>> > met. Just doing the skip when irqs_disabled() doesn't save us from the
>> > surprise side-effect. We need to decide upon this first before
>> > discussing the shape of the solution.
>> >
>> > This is the theoretical concern; In practice, I think most people who
>> > depend on such behavior use kptr in local storage maps (in
>> > schedulers). So it probably won't be a problem in practice, even
>> > though we can't judge this ahead of time. Also, we eagerly reuse map
>> > values when using memalloc, so the guarantees are already pretty weak
>> > I guess.
>> >
>> > So, if we are not going to go through a grace period (like local
>> > storage) and free back to kernel allocator before reuse, we should
>> > relax field freeing behavior. At best, we should cancel work for
>> > timer, wq, task_work, and task_work, leaving other items as-is. E.g.
>> > BPF_UPTR is used in task storage which I think is accessible to
>> > tracing programs, I am not sure how safe unpin_user_page() is when
>> > called from random reentrant contexts. We might have more cases in the
>> > future, we cannot guarantee we can handle everything in NMIs
>> > universally.
>> >
>> > So the best course of action seems to be relaxing
>> > bpf_obj_free_fields() to bpf_obj_cancel_fields() that just does cancel
>> > on async work (timer, wq, task_work) for delete / update and let other
>> > fields be as-is. We likely need to do bpf_obj_free_fields()
>> > additionally before prealloc_destroy() now, but that should be simple.
>> > Whether or not to use bpf_ma when kptrs are used in prealloc map is a
>> > separate change.
>> >
>> > This should hopefully resolve the issue, unless I missed other cases.
>> This does sound good, so you'd set the bpf_obj_free_fields up in the
>> htab allocator dtor for the final free and rely on the allocators
>> existing nmi deferral?
>
> It is already set, except for prealloc maps. But we can call it before
> destroying the pcpu freelist etc.

htab_map_free->htab_free_prealloced_fields does bpf_obj_free_fields already=
.
So scratch my suggestion to force bpf_mem_alloc on preallocated hash maps.

>>
>> The missing piece is whether to handle this differently in NMI or just
>> always do it with the deferral. Also the prealloc question needs
>> answering.
>
> There is no deferral here. I'm saying that we just cancel for timer,
> wq, task work, and leave other fields as is. So we don't have active
> work pending for async items.
>
> So as long as the item keeps getting recycled in the allocator, we
> don't free these fields. Once the memalloc is destroyed, the dtor runs
> in a known safe context where we can assume bpf_obj_free_fields won't
> deadlock or run into any problems.

So the plan is to do
if (in_nmi()) && case BPF_KPTR* | BPF_LIST_HEAD | BPF_RB_ROOT
just ignore it?
And no other changes anywhere at all?

That would be too good to be true :)
