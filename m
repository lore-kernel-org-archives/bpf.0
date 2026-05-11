Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE0637F8A8
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530246; cv=pass; b=etX6qDZ0LPS7MT4xpSWzn44lzZkYBww3Lr95LS8JazFh71sJn3sa5oykSZj/ZrJdU3gPceamNJFjwcy8xaVFUhcelsmMeETczQZCFiTdZ8Fln12g+119rX1NjnnsClXxeVnLkIjWNNTiEPV501tv3THZHgTfa2/aLOJOdBqjDD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530246; c=relaxed/simple;
	bh=O3q+sWm+2qH8YKJrtBOMduCqmSL8cmGP3auMa2HveU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaaY0yAWkIWpik2kVxSF+j7pOrxHoZdLMjntVd95DA6pCPOW/blc/Su4lTQf/KIsZ1W66xIAjzE7JuYO0gZmq2ZhLhICMZ6fX6/9Qz6E/l0x3SX3utDhPdlK7oAxGFFVxMSLt0XUe+V21TPOD8tdcTUB5U4+1TH45LVFZ8GRE6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaYJfJk1; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaYJfJk1"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48d146705b4so58643095e9.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 13:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778530244; cv=none;
        d=google.com; s=arc-20240605;
        b=CIynLnnPmuWHo6BbGDgp7IIbvGi6CizJB8i70Vy6kd76StvBEVFu5H69zuLb0OBbTQ
         hovT4cuAc6KEtcB/dqElIi2MJ5DbFcTQpTIDZmLZ76OT6MNY9orYPpA1mdbELoU1n7iM
         7KRPamqdjgiu3ybSTpInRHtNUXB5ChkzvzNfm7RzFHj+Lny92fG58m/LT4LNTIaFGSRw
         D9bgfmchP5Mo7U5HAGzRgBPgFnqfhFGYaFMpUNMfpUIs5UhzVcAbNte8Yw0qXsFvRbh9
         3M4kCMicjHK+cCcDUQf7JKsTVLfCh48Qdth6tpOO+B6OonvvLWY9n1tDZk3anoyj4l3g
         28Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZeAu1KBS/N3eyE3IFqT3qbkaYSHyiTjllPRUlF208lo=;
        fh=4cuIEC5me0lVe4CGyzNeIdGBFfU6BYlEZ3mXMO1T+Qo=;
        b=XZtl9Ne6RS+PaVOkjQ0/n+GAhwLcSoaH58UGAYGoqbOts8PaBHdJOklrMiJxqPDuOn
         CTZ5HjgYXGLS0GbWUW5HImKvbKOPHgwZxMuZVQJiScgRYL5ypj0UKjqyAHl/ZbFyf3LE
         YHVHjuSeoHA1EEIefcxNBSWkMFHbq8Kr4sDYoVOeU/bFV4v2xy9JiPyF7MFpFrI14QMF
         YajLHf7sL7u6owL1yblz8+dHSWLk+GN2LQWxS1KdJezFbbyYiAq4fAq7iB0Rv2As3gBr
         QNPDPe+KFw85JSzmPNcTZ55d41XPtSlhJ7XVldjZk24jid9H6VZsCHKHuXWK5h1U2+dv
         5I7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778530244; x=1779135044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeAu1KBS/N3eyE3IFqT3qbkaYSHyiTjllPRUlF208lo=;
        b=GaYJfJk162G8sPD7NGrMwRN6ubN7wCYzoSnELqcAIeoaHmNsEr9DhN4KUKcHJvs81+
         dE+4UQdzKUvhDzNuRthLuPwBiALLGAAUZkbdveGWST9kICQAhVMescqrXthFCFvggDSg
         V4bslcnauj9OBukCdSveAAbMvg2Ddx1jtqV1nGrFBwvKfDDcjKuF0mCCDnaPyW2mPHEB
         N/i10GP+FGzQso76Fl2F8fc64YHUbsLdRedN6Qnl4czjBHDQgiLQfsQdTVXF575gZi01
         6DO/wlSsnsiRpEN20VQgir3xYZf24QMVcSYM2r/0gfOk6O3GLXBOWx6OcCBPuav03Z1o
         mWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778530244; x=1779135044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeAu1KBS/N3eyE3IFqT3qbkaYSHyiTjllPRUlF208lo=;
        b=AJBGeg8a3hKRyalewT6vR4rECRcJUTCM1lsvNld9AlXcwhnypOOWzQODCokY8sV9dH
         cHweHUfh5Jq4lWyjPhErALpCQXrWSVQ8iV35woLfE/1gWwIdxinYCpXS4WFLnwIxT4WV
         5OIUKal8YuOt+m0+7GiHKGCz8Rw2llF8DLpsU+H00L996/dIzHIR16nSOHbEDaz9cxWr
         pMdR+sfqHEKqEvlntjCZq2nyfrYx3svGt/TF7j1TckHol/PqWzuD6qTYnU9He8ugMX8t
         aeWmmiSU3N0mn4VYApyNIIwZNVD+DG2iKzDZpm/l4JcwUxMqHqop2/oi1pzh0qABuUUV
         NOvw==
X-Forwarded-Encrypted: i=1; AFNElJ9VCVuGUt6oDOFSEDu1nb2oL8uWgGO1eF6ygL+RSowm3yZZs2LVwkKDl6F267YxsvzbCM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnypaXs4V8T0rNClK7RrgQZ673ul+CmPl98c9UiOUtVJQqIp/
	AtfL3RmHEJXBfNuRl4mgqoI6v7DgFZktfs6P7+1Ae/Ey/wOcEdki62lu6HSRGKyCaDLtFoAi6Qz
	peOCyEU8B3G00Gr/Rzg7T7kmYVFVYmUPW7Mm4
X-Gm-Gg: Acq92OFkipSZr8y0wKTgXATT9QH27/7xUdF6YAQmqmR6Q1H+EouBtCnE7EC2rtAc7WI
	MRMvC5pdpuIt7Z76/a6vYi8fQWqHC+HC0YZd1nW1E6LzpoRBB0adMoEhe7fT4wteOOEHBZ67E/w
	ghuPMGFEOo+7c/v3+6HX2XhVgfveRna2Vzrl1BQuLjBVuCeo5rep52sZkY+jPbNC90wr3liVIhU
	rKHCijYmvU8JPAbFnE7X+IDjqjmUSBPP9rY+zvUtfuyQEGJQZV4JsUEhfisP5g4RlIjCvtnIicx
	Y0j0FLBfVHkEozSP5mAIQKbiOqiZVM8T+/7uM1vus+CgdELLpkAa6hHpNDTZZJGvbRkC5yaT93s
	0+mNtsVyvltomabIsXU2BxIbG9GE3iIgIOl589JQQZ18PUlPc9L85qZsnMw==
X-Received: by 2002:a05:600c:4f8e:b0:48a:f18:ece4 with SMTP id
 5b1f17b1804b1-48e8fe7d245mr627405e9.24.1778530243488; Mon, 11 May 2026
 13:10:43 -0700 (PDT)
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
In-Reply-To: <DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 11 May 2026 22:10:07 +0200
X-Gm-Features: AVHnY4L-r9S0lVWrMl22FV0Sj1kUhVTnj6E46hXmJB-Pmw77jkoGnRhHec5qAa8
Message-ID: <CAP01T75942V+wKJD0yhs8yb7U5vj+y9s6efJ+UdpTMfzP31CWg@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Justin Suess <utilityemal77@gmail.com>, sashiko@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 19:29, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon May 11, 2026 at 9:38 AM PDT, Justin Suess wrote:
> >   [   21.604660] Call Trace:
> >   [   21.604662]  <TASK>
> >   [   21.604663]  dump_stack_lvl+0x5d/0x80
> >   [   21.604666]  print_usage_bug.part.0+0x22b/0x2c0
> >   [   21.604669]  lock_acquire+0x295/0x2e0
> >   [   21.604671]  ? terminate_walk+0x33/0x160
> >   [   21.604674]  ? __call_rcu_common.constprop.0+0x309/0x730
> >   [   21.604679]  _raw_spin_lock+0x30/0x40
> >   [   21.604680]  ? __call_rcu_common.constprop.0+0x309/0x730
> >   [   21.604682]  __call_rcu_common.constprop.0+0x309/0x730
> >   [   21.604686]  bpf_obj_free_fields+0x118/0x250
> >   [   21.604691]  free_htab_elem+0x85/0xd0
> >   [   21.604694]  htab_map_delete_elem+0x168/0x230
> >   [   21.604698]  bpf_prog_f6a7136050cb5431_clear_task_kptrs_from_nmi+0xeb/0x144
> >   [   21.604700]  bpf_trace_run3+0x126/0x430
>
> that's better.
> Looks like we moved bpf_obj_free_fields() into htab_mem_dtor(),
> but left check_and_free_fields() in free_htab_elem().
>
> I think the fix is to remove check_and_free_fields() from ma path in free_htab_elem()
> and fallback to bpf_mem_alloc at map create time when map has kptrs
> with dtors. Even when BPF_F_NO_PREALLOC is not specified.
>
> Kumar,
>
> thoughts?
>
>

Yeah, removing it from the path that helpers can invoke seems simpler.
Remember though, this splat is just for hashtab, we have similar
bpf_obj_free_fields() in array map on update. I think fundamentally
the main issue here is that we logically free special fields when a
map value is freed or deleted. When updating array maps we logically
'free' and then 'update' the same map value together. For hashtab, it
happens on update/delete.

We could relax this behavior to avoid eagerly freeing these special
fields on update or deletion. The only worry is how this would impact
programs that have come to rely on the existing behavior. There are
patterns where people expect kptr to be NULL on some new map value,
which causes programs to return errors when that expectation is not
met. Just doing the skip when irqs_disabled() doesn't save us from the
surprise side-effect. We need to decide upon this first before
discussing the shape of the solution.

This is the theoretical concern; In practice, I think most people who
depend on such behavior use kptr in local storage maps (in
schedulers). So it probably won't be a problem in practice, even
though we can't judge this ahead of time. Also, we eagerly reuse map
values when using memalloc, so the guarantees are already pretty weak
I guess.

So, if we are not going to go through a grace period (like local
storage) and free back to kernel allocator before reuse, we should
relax field freeing behavior. At best, we should cancel work for
timer, wq, task_work, and task_work, leaving other items as-is. E.g.
BPF_UPTR is used in task storage which I think is accessible to
tracing programs, I am not sure how safe unpin_user_page() is when
called from random reentrant contexts. We might have more cases in the
future, we cannot guarantee we can handle everything in NMIs
universally.

So the best course of action seems to be relaxing
bpf_obj_free_fields() to bpf_obj_cancel_fields() that just does cancel
on async work (timer, wq, task_work) for delete / update and let other
fields be as-is. We likely need to do bpf_obj_free_fields()
additionally before prealloc_destroy() now, but that should be simple.
Whether or not to use bpf_ma when kptrs are used in prealloc map is a
separate change.

This should hopefully resolve the issue, unless I missed other cases.
