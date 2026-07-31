Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90187257844
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 04:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785471818; cv=pass; b=nkuXSKyNyxIosxQawzJ6wTvXx0AMSB3EwUB3m4DMXJsrXCwzePiXf5ergw2Y7LOSwN7TP2FYaWuvwKaYOlQZv3KbpZTBHOXdggxvQQa0pUqKEelBw7BHUNXepW/reR9DshYIu8ad2RfHAkuz9Qie65TlNYIuR2Sd7Jhw2I1gXvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785471818; c=relaxed/simple;
	bh=d8XVobV4f1c+aHxqrgj49foH+hRs5Yx/Yh9s/mtmIyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGgTzt5WNYw/PjqtvMSYkM803vnYprYlepptrUXS6AnSXTpflh1K+A2QYGTQy2alcZTfV90vwcuRRFjeDN7xf5YDbt31Mbs2VSliWeMRVorksoCBDdr6FTEGkUfLJlMM1rc1bhf8VIg4xkJpyk9h++NjFZ2QerRz4nhPuJNFVCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=YImVmLMv; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="YImVmLMv"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b021916bd3so388488e87.3
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 21:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785471815; cv=none;
        d=google.com; s=arc-20260327;
        b=cyjCTIz3k8eA2wQwmiq2lZpLRUJxk4faVU05Qxp8M9o0JNthMOMTKkqRdVXJfXm4kv
         2qahH+8sJ88V/qrmtgUVDnzJ9eTRQF6aNEuZlxTuogsvfnXBUULPOLmbvJrvKDRxZ/sI
         3CTHp5BvLfamiX7SPup0dzWS3/l5O8LkOPHJwWhtfuJ6VcCc9HA9MwJ+6l1SY9Pviozo
         emN2nTwUD6SmbDKOVf2GhRdzjKOTtObiI/KgsrjeR4MgqWnrGsltGHz8oY93jN5SybEk
         LkSiY0JEQasOJo2krNZF2LkOGue0cyOiueFTEtyDLbaXtEwbHqUznBOU8QuCXQGjGPF6
         1oAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YEF63KKv4BGb0adjwnJYNRW696B86fut4j/pm9Gf2gc=;
        fh=H4OZuWlEUK0zO/MQZZqJ/cGZOFiVwKIfYw8NE9lp+Ig=;
        b=beBgZtUFEoNut0M64p6b5OBVm1y52Ypgqwt2XuuedQIShMnquDNCRJGCL7v7uDIHRF
         of3F/qkmuKpnBo2rN9Lf5fsw4cdTNua3UvtsaHTAvkUf5SgFOH2odSV7tJ32/DeKn3QA
         9r4Wj5KSdh5Daf4qM9ZSAMCHGUMuiPH6T1SOvxtNqmCGsipBCjY3MYMTrweocteLay0i
         IWuV7bart7ubUqFUf4KviVmtMJcFCg2VSd0WaHJQbTNOi4RpmxbqzVQNYy/mwPl42GMK
         LNgwXiwisfHqvJGwxJtSR8rq2OpT0sDZRa+L7OHMqu6ahwItdh++5XmxYnkk85bpu9V6
         cf/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785471815; x=1786076615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YEF63KKv4BGb0adjwnJYNRW696B86fut4j/pm9Gf2gc=;
        b=YImVmLMvhzf8z9HA4URgiD+Nx4xZqKHR+zrEhV4Zf5Mm8ffKOHtkAzqUHBbQH57IJd
         MycN30ft+LQ7S9LKVU9j/h1pG8SnxO9VH6tgdwWy4wkg4DPO5EIrneriVIPrZMiPEYvQ
         oAv8PmusLPc0uvJIGvY70aOMKlfCKDdIRVeJh0XnXE1gHuPfoKNnZMZmcOzLLd+sL7oB
         lzJ+2rCJtbtT5u159ODBvhsXAE53Xdt0eo7oQ8Fo6hXrc/6BnkiWrohIS0hrnehUcoJ4
         mMh9sK+TJ/wupV9hta2dT7CIfZGuBlkdxQow9LHdJpt9f9NXmo6j1Fb6VNkHzH2uJStG
         QfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785471815; x=1786076615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YEF63KKv4BGb0adjwnJYNRW696B86fut4j/pm9Gf2gc=;
        b=U/nqiJGRFochbSRQhkVi0QHgO9I4twCZ18PCCBTeatJdJEL62x3Lo/XDYFJBgq0v11
         1zRW+MUFsgb08UfGK3PiPwVOHrG8hqh6cB33woq7CMvJMy9vvCW/O3x132NMPws66Hxn
         WSPMVdstvGTYHHmNv4xhNvctIsI6oETsRxLVwJQluyuEnBrZYvbX8EduGikNMYjrliOI
         uLGlDW0Qk8PUAffIeZUNsy83cGiQF6zbyYNbz7njEl5BaO+H7cL1JJyrBWcupUSDb7bM
         tPxsdRKWLnM30vpQfZdLuU8wYOu+DmuIs5lL8fu2LnzVxSR81riNSA4dxU01M6IgsExn
         lrxQ==
X-Forwarded-Encrypted: i=1; AHgh+RqaT3blz8gK4iifbH4GIQhj1aLqGODIX2ItZUOOw/qlpkGBHiekUKuengQSAT5xbd8sVSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyckQiOxVcyiYD0RiUywGD1CjIvcFv4OjtFtEKj+bmm8WwC6BK
	xQe+kVEzuzZoqTAZjy+tv8ZotDlvYekOTITRdfRTcOICV2FrKfzTiDElhwWhy4hxiZQcUqzkE/8
	5vhLcJzgsNMrLWOcankxVZFccRNMflSsX5XLD36aVN7A=
X-Gm-Gg: AR+sD13exc3AORkD3Cb5/64meExkBst/eRFLRsk+RBIljYnf2+nRWyuKwEO7wGxM5mI
	f1Ix4RzG+9Iw+LRJcVlypt4C5f194p+fB9aAXLmuNG49VOWOnjMwuSXIR3iuWxxkN5VGg7YAVHi
	PrdJ2VSRNdQBN74u6HbPd24CwsZ37OST3WgsNb+8B8PSLUqEhh3mcvp2hFiaA2dO/PWQz8lIOC4
	+UPLC3keweq1pgG0BacUHLSjBFthjBTZP0lP0FQPWiYE/DGmICbcBaoRgjNmoa4tF4Pqq3+rX0L
	7BOPyOw0/TKyXEc/hlUa9P51iihRICl93EfFpIKCRC8=
X-Received: by 2002:a05:6512:3b8b:b0:5b2:a75f:8a6 with SMTP id
 2adb3069b0e04-5b2e1fe41a6mr126120e87.29.1785471814675; Thu, 30 Jul 2026
 21:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730153832.11238-1-zihanx@nebusec.ai> <amvaYrq3bpuT5sqQ@devvm7509.cco0.facebook.com>
In-Reply-To: <amvaYrq3bpuT5sqQ@devvm7509.cco0.facebook.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Fri, 31 Jul 2026 12:23:18 +0800
X-Gm-Features: AUfX_myoVJBFE4xAA7RCHkS5VXGuAzSaWkESMT-Rr-o36wq7xz9sbNUMDv0bnDU
Message-ID: <CAANe3eRzp3v=+LE+UOtpYpTEpQYvTp5gFRhjZVkx5jqSNuPk5Q@mail.gmail.com>
Subject: Re: [PATCH net v2 0/1] xsk: fix unaccounted ring allocations causing
 memory exhaustion
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 7:19=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 07/30, Zihan Xi wrote:
> > Hi Linux kernel maintainers,
> >
> > We found and validated a issue in net/xdp/xsk_queue.c. The bug is reach=
able by a
> > non-root user via user and net namespace.
> > We've tested it, and it should not affect any other functionality.
> >
> > We will provide detailed information about the bug
> > in this email, along with a PoC to trigger it.
> >
> > ---- details below ----
> >
> > Bug details:
> >
> > AF_XDP lets user space allocate RX, TX, UMEM fill and UMEM completion
> > rings with setsockopt() and mmap them into the process. The shared
> > xskq_create() helper allocates the ring backing memory, but unlike UMEM
> > registration it does not account those pages against RLIMIT_MEMLOCK /
> > user->locked_vm.
> >
> > As a result, a process with CAP_NET_RAW in a user and network namespace
> > can request very large rings and pin a large amount of kernel memory
> > before bind or any packet I/O. In our original report the resulting OOM
> > ended in a panic because that guest had panic_on_oom enabled. The panic
> > was only the environment-specific end result; the bug itself is the
> > missing resource boundary that lets ring allocations consume excessive
> > memory in the first place.
> >
> > The first version tried to bound these allocations with sysctl_optmem_m=
ax,
> > but that was the wrong resource model. We also evaluated a memcg-accoun=
ted
> > vmalloc path as suggested,
>
> [..]
>
> > but memcg attribution by itself did not impose
> > a default enforcement boundary in our validation setup.
>
> Can you expand on this? Maybe we don't pass some GFP_ACCOUNT flag or
> something?
>
> > AF_XDP already
> > uses RLIMIT_MEMLOCK / user->locked_vm to bound pinned UMEM pages, and t=
he
> > ring pages are likewise user-controlled, mmapable and long-lived. This
> > version therefore accounts AF_XDP ring allocations with the existing
> > mm_account_pinned_pages() helper and unaccounts them when the queue is
> > destroyed, so ring memory is constrained by the same default limit mode=
l
> > already used for AF_XDP UMEM pages.
>
> We get RLIMIT_MEMLOCK just because the users do mmap(), nothing af_xdp
> specific. Idk, manually doing accounting seems a bit wrong, memcg/kmem se=
ems
> like the way to go. (also, panic on oom also still seems wrong)

Hi Stanislav,

Thanks, this is helpful.

For the memcg experiment, it was not a case of missing GFP_ACCOUNT.

I changed the AF_XDP ring allocation path in xskq_create() to use an
accounted VM_USERMAP vmalloc path, and the local repro logs showed that
the allocation did in fact reach __vmalloc_node_range_noprof() with
GFP_KERNEL_ACCOUNT set.

The relevant serial log lines from the memcg-accounted prototype were:

    poc invoked oom-killer:
gfp_mask=3D0x402dc2(GFP_KERNEL_ACCOUNT|__GFP_HIGHMEM|__GFP_ZERO|__GFP_NOWAR=
N),
order=3D0, oom_score_adj=3D0
     __vmalloc_node_range_noprof+0x2f7/0x8e0
     ? xskq_create+0x23/0xf0
     xskq_create+0xb8/0xf0

and also:

    oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null),cpuset=3D/,mems=
_allowed=3D0

So what I was trying to describe was not that memcg accounting was
missing or broken. In the validation setup, the task was running without
an effective memcg limit, so adding GFP_KERNEL_ACCOUNT changed
attribution, but did not create an effective enforcement boundary there.
The ring allocation was still only constrained by global memory pressure
in that environment.

I agree with your point that panic_on_oom only affected the final
observable outcome. The panic itself was not the core issue; it just
made the memory exhaustion easier to observe.

I also understand your concern that charging these allocations to
RLIMIT_MEMLOCK / locked_vm is probably the wrong direction if the
intended ownership model for this memory is memcg/kmem rather than a
separate AF_XDP-side accounting model.

Given that, I will stop pursuing the RLIMIT_MEMLOCK approach for now
and re-evaluate whether there is a memcg-native way to address this, or
whether this is better treated as something that should be handled by
cgroup policy.

Thanks,
Zihan
