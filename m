Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7782836E
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550184; cv=none; b=otpKSSmwf67Cl2Yj8IYWIDoB2GOhIHwKno9TEEyx7puG36BLvLUfb/q3QPe1IzrILPu1U2nbdMiY2kyqSgYWTCamX4TUk6ovrZHiIQJ2I7mOQUtQqclTm/UGCCu+feHa2OGn37bwY/a07RTMrREE/oHDYbaWYmLYS20V1dhzjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550184; c=relaxed/simple;
	bh=9aPZxZ9GEDO3mZHBLEvJfdZ1DWN/G3/i+bf1/vWS4y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnPcvbeqzPDISRkWLFWC2zhMqmlIe06neBkd/cRSvWnhx7pW9mRdc3nDGBlCvlo45K2K1HVWfT53gv2PXFckSgb6Md+9CU6bWdhsRgC8E/qFMoWDY/M3oe3SJaRhuYHKTIw9FOvIGYjz4xOn99ukqjV9aPPTNkqlJIwBmWRKASo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqFT1XU1; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqFT1XU1"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bf14e33f5bso44465357b3.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 18:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778550182; x=1779154982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gitPRycwEgLL+VEnb9jptgeXMbXBNy650cSINvraLmE=;
        b=HqFT1XU12pqdljMg8Q+E+dYrWZ+oBnBdeHu0OfeYj7n1aXDF3cnInNlD/bTY3iYIkt
         TVDYXkCNU8Zrmb6oXChOHh6TMKTzvJUoS3iMDkepMEP5pMr86yg5jXwwFrIVsAsHqsZA
         +tE9M1QW82+cKKHyh9usnyH7hFtmHZ5JA1H/+AHSmBoWykpmH1m5oTWjespaxbb3oRq4
         R1LmZO3gIHjW1BxqEDRRfavLohLuDqCoWkGhYRAo+ITSkT3/u1aPkS7I+eFpfTrLpfPH
         qrlNmU7GGaZqWYU4+oR+N8PsABkz8BTPKRo8qy7XeqwLFwixvet7IMsAd9ujWFqe8KXq
         cu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778550182; x=1779154982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gitPRycwEgLL+VEnb9jptgeXMbXBNy650cSINvraLmE=;
        b=pmOPrH77oePFua3lI/wYYphey4OLdvwKIS2LWhBH+z4VO/vhn0iE78IrzT7oZB7+G0
         GLG6E8ZFEkVcHHRA8ss+DEMTuPvayBRQAciuoNv+qJ6ghVfmkdScTfWt+TFmDpTzqwAH
         +q4OYj9LnUjSE1q5UUJoULEk6XO5eFkSYdgN1r5QjxwrhKEi3lLc1AwZIXrwf3eSFyn+
         krayIwZIutDO+SVXrpRU8eJfMWlKWyVpCVes3Uh3zp5MkJqLqsNh37+mqv1JUxfNmuJ9
         xl4tkFZyzU6huRq1c7nTlrGg6xdHPpfYDq4PWUnHkv5KjEh3VGrNEqkZLxHC1LwqANQj
         8z7g==
X-Forwarded-Encrypted: i=1; AFNElJ/T71iEoWTmxJpwjSUPjxFWisogzccLhxxlYTuzjOUBSluDvUH7SZOKQMcrqSLCxjEwdTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3JtECk3gJFDJbfKfPI66zoDLxVNvHdYa5YN4b8bFsgnVlwa9
	9dG98rgghY0J5ZijNnkhe3kPM/qwGOC3O5nWEkzJVDX0e4BN3m/uQ9k3
X-Gm-Gg: Acq92OEwfWbMdaDQta4pp7VBXboBSZiqDltc1MMRcZGEA3Sa80/IFyF795uW2nH6W3v
	FjoZiEX7NxzaR0yFg0Jqh+FymGUFaYFqZd233SpdKdxsv19UMRX7FzC/G6xCSvUf+o1U0VMQGok
	CPz9Stw1J3gBEzjjAEH8EUA0/yWVcFBnM3KFcecKctFf2JiID8zM3xl5uZK3AhUscNZvYBOP9GY
	DVXBsIRYKENaKRVp7WH8ET2UWvJyG/WBwlhytMiKFKm8ZCeFp+U8fbkyuB6gQrwK8AqYTJpHaZA
	r9hm9cGmrswjnjEmO5lCFRaAQHeCfS3jWpvwy78FLCEKmgIiORNXTD+d8MCrxg+ry1Tq5HflXC+
	+akm2U4qiWi2EDfzRWHTEWGck/Jdd2S0ea5lWsz78rlijCcPwJRWsKzmVwVUjW4I7z++jMh7zos
	M1xiT5yj/X+QqaFxq3V1/iZA4mlNFPtYESpFrb7JJKkdfXWb74jnZl2UuXpA==
X-Received: by 2002:a05:690c:6e83:b0:79e:8299:7505 with SMTP id 00721157ae682-7bfb71f574emr158086697b3.6.1778550181848;
        Mon, 11 May 2026 18:43:01 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6d1b:2c6f:d117:7f3e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6683836asm160951577b3.25.2026.05.11.18.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:43:01 -0700 (PDT)
Date: Mon, 11 May 2026 21:43:00 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	sashiko@lists.linux.dev, bpf <bpf@vger.kernel.org>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
Message-ID: <agKBE4Ci4_LmJ1Dc@zenbox>
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
 <20260507234520.646C4C2BCB2@smtp.kernel.org>
 <agCXEJKJh-JGMhjG@zenbox>
 <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>
 <agEnc0aYMhuIeDlq@zenbox>
 <DIFYUK5DKGAT.189D9YYSQFCUZ@gmail.com>
 <agH_0MEw4b0pB11-@suesslenovo>
 <DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com>
 <CAP01T75942V+wKJD0yhs8yb7U5vj+y9s6efJ+UdpTMfzP31CWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T75942V+wKJD0yhs8yb7U5vj+y9s6efJ+UdpTMfzP31CWg@mail.gmail.com>

On Mon, May 11, 2026 at 10:10:07PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon, 11 May 2026 at 19:29, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon May 11, 2026 at 9:38 AM PDT, Justin Suess wrote:
> > >   [   21.604660] Call Trace:
> > >   [   21.604662]  <TASK>
> > >   [   21.604663]  dump_stack_lvl+0x5d/0x80
> > >   [   21.604666]  print_usage_bug.part.0+0x22b/0x2c0
> > >   [   21.604669]  lock_acquire+0x295/0x2e0
> > >   [   21.604671]  ? terminate_walk+0x33/0x160
> > >   [   21.604674]  ? __call_rcu_common.constprop.0+0x309/0x730
> > >   [   21.604679]  _raw_spin_lock+0x30/0x40
> > >   [   21.604680]  ? __call_rcu_common.constprop.0+0x309/0x730
> > >   [   21.604682]  __call_rcu_common.constprop.0+0x309/0x730
> > >   [   21.604686]  bpf_obj_free_fields+0x118/0x250
> > >   [   21.604691]  free_htab_elem+0x85/0xd0
> > >   [   21.604694]  htab_map_delete_elem+0x168/0x230
> > >   [   21.604698]  bpf_prog_f6a7136050cb5431_clear_task_kptrs_from_nmi+0xeb/0x144
> > >   [   21.604700]  bpf_trace_run3+0x126/0x430
> >
> > that's better.
> > Looks like we moved bpf_obj_free_fields() into htab_mem_dtor(),
> > but left check_and_free_fields() in free_htab_elem().
> >
> > I think the fix is to remove check_and_free_fields() from ma path in free_htab_elem()
> > and fallback to bpf_mem_alloc at map create time when map has kptrs
> > with dtors. Even when BPF_F_NO_PREALLOC is not specified.
> >
> > Kumar,
> >
> > thoughts?
> >
> >
> 
> Yeah, removing it from the path that helpers can invoke seems simpler.
> Remember though, this splat is just for hashtab, we have similar
> bpf_obj_free_fields() in array map on update. I think fundamentally
> the main issue here is that we logically free special fields when a
> map value is freed or deleted. When updating array maps we logically
> 'free' and then 'update' the same map value together. For hashtab, it
> happens on update/delete.
> 
> We could relax this behavior to avoid eagerly freeing these special
> fields on update or deletion. The only worry is how this would impact
> programs that have come to rely on the existing behavior. There are
> patterns where people expect kptr to be NULL on some new map value,
> which causes programs to return errors when that expectation is not
> met. Just doing the skip when irqs_disabled() doesn't save us from the
> surprise side-effect. We need to decide upon this first before
> discussing the shape of the solution.
> 
> This is the theoretical concern; In practice, I think most people who
> depend on such behavior use kptr in local storage maps (in
> schedulers). So it probably won't be a problem in practice, even
> though we can't judge this ahead of time. Also, we eagerly reuse map
> values when using memalloc, so the guarantees are already pretty weak
> I guess.
> 
> So, if we are not going to go through a grace period (like local
> storage) and free back to kernel allocator before reuse, we should
> relax field freeing behavior. At best, we should cancel work for
> timer, wq, task_work, and task_work, leaving other items as-is. E.g.
> BPF_UPTR is used in task storage which I think is accessible to
> tracing programs, I am not sure how safe unpin_user_page() is when
> called from random reentrant contexts. We might have more cases in the
> future, we cannot guarantee we can handle everything in NMIs
> universally.
> 
> So the best course of action seems to be relaxing
> bpf_obj_free_fields() to bpf_obj_cancel_fields() that just does cancel
> on async work (timer, wq, task_work) for delete / update and let other
> fields be as-is. We likely need to do bpf_obj_free_fields()
> additionally before prealloc_destroy() now, but that should be simple.
> Whether or not to use bpf_ma when kptrs are used in prealloc map is a
> separate change.
> 
> This should hopefully resolve the issue, unless I missed other cases.
This does sound good, so you'd set the bpf_obj_free_fields up in the
htab allocator dtor for the final free and rely on the allocators
existing nmi deferral?

The missing piece is whether to handle this differently in NMI or just
always do it with the deferral. Also the prealloc question needs
answering.

This fix would preserve the xchg inlining and allow for failure with
ENOMEM on exhaustion and not need weird locking or atomic counting.

Appreciate the time from both of you learned a lot more than I wanted to
about NMI than I bargained for writing this. There's probably more weird
NMI cases. FWIW there are zero tp_btf/nmi_handler progs anywhere I can
find on the internet so this is a weird edge case.

Since I brought this issue up I'll finish it out and send patches next
week.

Even if generic file kptr isn't possible hopefully this can stop sashiko
from complaining about every new kptr dtor getting introduced being unsafe in NMI :)
