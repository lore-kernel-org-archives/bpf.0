Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7301E5B9A
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551810; cv=none; b=E5xsckyo8qysxOxFJxklNIGLDiF7aWZiQTlW8HiLzdpdqwdTlyWxqz6mXc1RBEmA7C8xl5t8caA+TVhVehMVQ3M5KPJKTNX7iuT7xM1AzLLjt7VbFsri+cT4G/zknhwhnHTxtKaUYmtsy9R6YcpR+DcA7rnbsUawgLF0QmTXdXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551810; c=relaxed/simple;
	bh=UBhn1vwUk4WxqGcZnaK53kTgzYUb9Kb115VU9CY0MKQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Xr+qWHiXlonIdUg8ywwjSJG6WMOlVgQ9jJqPRiB/6LYkYUYZVoVpEVXTPGpZG8A7NQC/6e4uVr6u5LXxCZOM9hFpA3CDI96EllN1O8xgGopRe9eEXgBV4mT9dzW/fzw24zIKlFUqkMx/zXHtBaigkVseN/DEWGp0ld8AsfYXdAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT4NnhTs; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT4NnhTs"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7de4e6c5a30so5465937a34.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 19:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778551807; x=1779156607; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLM1QLN4XrHoS3pMLkMNSND5wUkA9TnChdpIRxhmBd8=;
        b=TT4NnhTsMglafzqIg346Uj80KVS0eYmw8ofjYi6hO2I+7W3iGvFq1R4PhhCg9/zYNp
         2J6yaNX3Mm2zkTlCWMAbbv5qKNll6+fFzDwLQsUm7wBRY1frZYSjrwQwgYMM5BuRBcSg
         RHa4soxXTC84ozvQ7tLfCy9UFSeV9oIkkd/v3KiPivZn+jJc5XGjnqmzTG6LzzWTlhkR
         gNiuA4eKkDti68I0GqGTuMsdislmFjalkG+YmpNZPg/K5k8WHMQB/sihhsGdh56/YKjF
         g43QNPaKyKhkBO09CTSnp96z54O9RjdvDpetUOdKdaRqr6l5q22j7BHWG5qQ9Xi3bid3
         RFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551807; x=1779156607;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLM1QLN4XrHoS3pMLkMNSND5wUkA9TnChdpIRxhmBd8=;
        b=DtmdjnwZtbYd/vsazfBx6404aNtlOCsRV7RFEc46KDWW4Uppoun4uwTDdJef4uRHoJ
         /e7MD5vb7ABN1Am7lW9ydF/ts0NYUqKcE3T/hmmiZ7krzEuTbPQf7Z3aC2owNW9AAzZ8
         VQi7oYZP+bIUhqAJHqEu67TAYCmU9ob9YJw8eaW3jMqFF1Uvo7xhR9R2EYMawlOUQjuV
         vBLeX9JYufN/Dsa4+tWxQMfmn7aYU+/EQWyIJrixwVy6BZYvnG0emJUSYOmF0k/1JwpN
         1GFNnYerX7lT4XpLyCs1beIYVrEEEbNScfYdj5v+mmvs737j0+wvk7JsaMrGI6TlO8i1
         wSVw==
X-Forwarded-Encrypted: i=1; AFNElJ/5OfIiRBXpCrWsxtzmqpUQEeV+1UKNhuXKrItRonu25njevQ+MVFrF/D9OI88Oc9QV6Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykQUlML1eaQaH17WgChMq+i6/HQwSmm0VncZYnGuTsCywCBGXS
	H2Dsnuej3PDvruBT9wsRU5Y2c/EMJ5BRA8cLK8WPLZF6orZ7MfBWQMvy
X-Gm-Gg: Acq92OG1lXOpseivBdGI7RUtzsZmug7m19hAZstV3fOax7N3pZWdQkJYFxkjKIWAyXo
	zekryXtg7qc/iJDhc1MyVuK+bX8j6jwaVmBHEHt48nS3vHmDt2WxFfi/YeZRpNMGRrgDGNVrpEt
	AItR0wqfBNMXbjQIqjEqOT+4+Yrw2mhLVYEA1OZXSxdwi89rIyE/idN32PmxMpLpiHSMhbiP2vH
	TifEXLe1/0vQkPBVj5lNKCA+kq/c15XwU0PIFTNx/rvcuZT9P0SsEhOy2Kfird6qwXjxIlE697n
	4gnhyIjDbVzOKvBBmTA82Mf08wU5xQEQbw46PT8aM6IWHDxaB7ImhA4k96F1k5w/d6YTubWHluC
	jOlwSq1WBmssx7XPNz2DbJkUCSLs639jKogjvXBzpPQl0v1ii1emb0QM7vwcVpDRSGKFBnn9J/5
	g9UfOdmgQcTMK5p6IC0hk4uUgd9vLTHbS83LKWGuDdEFzrRN9tiqsXTO+mKOf/GTPzbAtAsrKHs
	MYH6g/PiYt0cqua
X-Received: by 2002:a05:6820:c3ca:b0:699:b131:d587 with SMTP id 006d021491bc7-699b131d797mr7676281eaf.11.1778551807444;
        Mon, 11 May 2026 19:10:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25956231sm6647252eaf.0.2026.05.11.19.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 19:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 19:10:05 -0700
Message-Id: <DIGBZVSAOXGC.VA20SWFV4R74@gmail.com>
Cc: "Justin Suess" <utilityemal77@gmail.com>, <sashiko@lists.linux.dev>,
 "bpf" <bpf@vger.kernel.org>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from
 NMI
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
 <20260507234520.646C4C2BCB2@smtp.kernel.org> <agCXEJKJh-JGMhjG@zenbox>
 <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>
 <agEnc0aYMhuIeDlq@zenbox> <DIFYUK5DKGAT.189D9YYSQFCUZ@gmail.com>
 <agH_0MEw4b0pB11-@suesslenovo> <DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com>
 <CAP01T75942V+wKJD0yhs8yb7U5vj+y9s6efJ+UdpTMfzP31CWg@mail.gmail.com>
 <agKBE4Ci4_LmJ1Dc@zenbox>
 <CAP01T76i3S93kvXnQvK+NU1ee82s+ka2jQfmf-yL86r9AS2tuQ@mail.gmail.com>
 <DIGBOYWXZ95S.3GAGVQGUJNQD4@gmail.com>
 <CAP01T75y1CuPQ9af9SgYqY=c+3q7ZXTKJJu=znAE3HtEEBMwOw@mail.gmail.com>
In-Reply-To: <CAP01T75y1CuPQ9af9SgYqY=c+3q7ZXTKJJu=znAE3HtEEBMwOw@mail.gmail.com>

On Mon May 11, 2026 at 7:03 PM PDT, Kumar Kartikeya Dwivedi wrote:
> On Tue, 12 May 2026 at 03:55, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Mon May 11, 2026 at 6:46 PM PDT, Kumar Kartikeya Dwivedi wrote:
>> > On Tue, 12 May 2026 at 03:43, Justin Suess <utilityemal77@gmail.com> w=
rote:
>> >>
>> >> On Mon, May 11, 2026 at 10:10:07PM +0200, Kumar Kartikeya Dwivedi wro=
te:
>> >> > On Mon, 11 May 2026 at 19:29, Alexei Starovoitov
>> >> > <alexei.starovoitov@gmail.com> wrote:
>> >> > >
>> >> > > On Mon May 11, 2026 at 9:38 AM PDT, Justin Suess wrote:
>> >> > > >   [   21.604660] Call Trace:
>> >> > > >   [   21.604662]  <TASK>
>> >> > > >   [   21.604663]  dump_stack_lvl+0x5d/0x80
>> >> > > >   [   21.604666]  print_usage_bug.part.0+0x22b/0x2c0
>> >> > > >   [   21.604669]  lock_acquire+0x295/0x2e0
>> >> > > >   [   21.604671]  ? terminate_walk+0x33/0x160
>> >> > > >   [   21.604674]  ? __call_rcu_common.constprop.0+0x309/0x730
>> >> > > >   [   21.604679]  _raw_spin_lock+0x30/0x40
>> >> > > >   [   21.604680]  ? __call_rcu_common.constprop.0+0x309/0x730
>> >> > > >   [   21.604682]  __call_rcu_common.constprop.0+0x309/0x730
>> >> > > >   [   21.604686]  bpf_obj_free_fields+0x118/0x250
>> >> > > >   [   21.604691]  free_htab_elem+0x85/0xd0
>> >> > > >   [   21.604694]  htab_map_delete_elem+0x168/0x230
>> >> > > >   [   21.604698]  bpf_prog_f6a7136050cb5431_clear_task_kptrs_fr=
om_nmi+0xeb/0x144
>> >> > > >   [   21.604700]  bpf_trace_run3+0x126/0x430
>> >> > >
>> >> > > that's better.
>> >> > > Looks like we moved bpf_obj_free_fields() into htab_mem_dtor(),
>> >> > > but left check_and_free_fields() in free_htab_elem().
>> >> > >
>> >> > > I think the fix is to remove check_and_free_fields() from ma path=
 in free_htab_elem()
>> >> > > and fallback to bpf_mem_alloc at map create time when map has kpt=
rs
>> >> > > with dtors. Even when BPF_F_NO_PREALLOC is not specified.
>> >> > >
>> >> > > Kumar,
>> >> > >
>> >> > > thoughts?
>> >> > >
>> >> > >
>> >> >
>> >> > Yeah, removing it from the path that helpers can invoke seems simpl=
er.
>> >> > Remember though, this splat is just for hashtab, we have similar
>> >> > bpf_obj_free_fields() in array map on update. I think fundamentally
>> >> > the main issue here is that we logically free special fields when a
>> >> > map value is freed or deleted. When updating array maps we logicall=
y
>> >> > 'free' and then 'update' the same map value together. For hashtab, =
it
>> >> > happens on update/delete.
>> >> >
>> >> > We could relax this behavior to avoid eagerly freeing these special
>> >> > fields on update or deletion. The only worry is how this would impa=
ct
>> >> > programs that have come to rely on the existing behavior. There are
>> >> > patterns where people expect kptr to be NULL on some new map value,
>> >> > which causes programs to return errors when that expectation is not
>> >> > met. Just doing the skip when irqs_disabled() doesn't save us from =
the
>> >> > surprise side-effect. We need to decide upon this first before
>> >> > discussing the shape of the solution.
>> >> >
>> >> > This is the theoretical concern; In practice, I think most people w=
ho
>> >> > depend on such behavior use kptr in local storage maps (in
>> >> > schedulers). So it probably won't be a problem in practice, even
>> >> > though we can't judge this ahead of time. Also, we eagerly reuse ma=
p
>> >> > values when using memalloc, so the guarantees are already pretty we=
ak
>> >> > I guess.
>> >> >
>> >> > So, if we are not going to go through a grace period (like local
>> >> > storage) and free back to kernel allocator before reuse, we should
>> >> > relax field freeing behavior. At best, we should cancel work for
>> >> > timer, wq, task_work, and task_work, leaving other items as-is. E.g=
.
>> >> > BPF_UPTR is used in task storage which I think is accessible to
>> >> > tracing programs, I am not sure how safe unpin_user_page() is when
>> >> > called from random reentrant contexts. We might have more cases in =
the
>> >> > future, we cannot guarantee we can handle everything in NMIs
>> >> > universally.
>> >> >
>> >> > So the best course of action seems to be relaxing
>> >> > bpf_obj_free_fields() to bpf_obj_cancel_fields() that just does can=
cel
>> >> > on async work (timer, wq, task_work) for delete / update and let ot=
her
>> >> > fields be as-is. We likely need to do bpf_obj_free_fields()
>> >> > additionally before prealloc_destroy() now, but that should be simp=
le.
>> >> > Whether or not to use bpf_ma when kptrs are used in prealloc map is=
 a
>> >> > separate change.
>> >> >
>> >> > This should hopefully resolve the issue, unless I missed other case=
s.
>> >> This does sound good, so you'd set the bpf_obj_free_fields up in the
>> >> htab allocator dtor for the final free and rely on the allocators
>> >> existing nmi deferral?
>> >
>> > It is already set, except for prealloc maps. But we can call it before
>> > destroying the pcpu freelist etc.
>>
>> htab_map_free->htab_free_prealloced_fields does bpf_obj_free_fields alre=
ady.
>> So scratch my suggestion to force bpf_mem_alloc on preallocated hash map=
s.
>>
>> >>
>> >> The missing piece is whether to handle this differently in NMI or jus=
t
>> >> always do it with the deferral. Also the prealloc question needs
>> >> answering.
>> >
>> > There is no deferral here. I'm saying that we just cancel for timer,
>> > wq, task work, and leave other fields as is. So we don't have active
>> > work pending for async items.
>> >
>> > So as long as the item keeps getting recycled in the allocator, we
>> > don't free these fields. Once the memalloc is destroyed, the dtor runs
>> > in a known safe context where we can assume bpf_obj_free_fields won't
>> > deadlock or run into any problems.
>>
>> So the plan is to do
>> if (in_nmi()) && case BPF_KPTR* | BPF_LIST_HEAD | BPF_RB_ROOT
>> just ignore it?
>> And no other changes anywhere at all?
>>
>> That would be too good to be true :)
>
> I don't know whether in_nmi() would be sufficient, we likely need
> irqs_disabled()?=20

fair irqs_disabled() is safer.

> At that point, why not always ignore it, since
> freeing the fields is dependent on where you're running. I would still
> cancel async fields, since they're already any-context safe.

you mean never touch case BPF_KPTR* | BPF_LIST_HEAD | BPF_RB_ROOT
regardless of running context and rely on final cleanup?
That's an idea to consider, but I suspect some rbtree, link list
tests will fail.
