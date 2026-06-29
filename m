Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B4D346E40
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730047; cv=pass; b=NjrFTQZz3gJY/saTgvmz6ElOFHoF5091+cwe18uKDNSobT5/KTskM0ESLfL6c2riyG3wDlHNW12xOqSUvPit+Q327oKbA5xUO7OF7UNTnO8MsSNptw7CxZ9PFdIGyN7DvDK7MQNjp2EUh7H72eNqb5nPg5H0VUcBlRvNJEPhMi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730047; c=relaxed/simple;
	bh=gWfU6/OyCo2rP1ZHR0B3aygjC+wA0mTDxemW9AISS04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPPiHY8c5IMkOj25KT94323SjMIQhMUmf/YSXN9ZwNFO5vfPCegFS2JthYfhpgfdZtwvwzLQ28XYTO3GPQ0frnCk/v010q8N7xuUlXATjlPMetWrk/zcfM2Dvj0SX61ZQovJpWuwwca7YsSsMBcFPaxnTXpj1yZlvW9vqs4Yuuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=oyI/H26l; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="oyI/H26l"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8478fe07f65so214676b3a.0
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 03:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782730045; cv=none;
        d=google.com; s=arc-20260327;
        b=ZaqB3UMDMc4+aJ+1bbLUjsx7+B+//oJlw5/RT3sd/8dmQOEh+xJCbMmPNcf+DBZDYl
         zZg7uPkTLa3larHyeyyNeKYBn5Ymu7kFdz+miSeJSitQgxY7c869js64xQVu/CD5jwMD
         TDyhn6bkPHlEFIQjIVmHXhvcok2sH79UoeQ9NFI4i8oEw2F2Wg32XeQ9IX7fNnfQFlKi
         YCXhjHEMnk1zHH7ZeCszltkzE5XaiByq1vxtey7Jnjh2DOWOG0Q9hItAgVj2G5cakWns
         GVrXT3fL5HqihXVhMY9g4Sdz8vB8qelte90UOhTF9qXSJmNHQP8QsjDkPgZi7EFMJMz8
         A3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2D/+tKmqEVHdrXuSNJqyqQwhydaMlOMVeSo45A3y9ak=;
        fh=kfK/ZDn371IfVhNfFLJiij7JjciI2ByNq/HOOouDDzI=;
        b=cPf1044Fr26T1ApiuHKQKpRq7juu0K8bWYy7mwHWHJ9+ijAAemI44DlvPBzp/H3SD/
         QNo41tl7+FuiaaIlWpNS8rg/3G9ktaoVhdk4tjP2wuNftoQmzanvyfjqzeKVZuui1yXk
         q1tX6v3Ldc3w4j56qSfN3hAjwW6cqaUkSPVCP0PghEG3O5EPa1BC0kBe5e02Rq8ElFoK
         U2ReZTSZYl6zZmV+p+EqIfOTmI2gxu4TDfZ5n5WTDn/Zha6TbHdbcmLBzcgibFmM+pyT
         QUXmeVLL3HuazK3eDymjOOFPtJ0lwMv59Uv9dLpE5pFoNZ+eK0FfBkneaUsAfrk5GrB3
         Acfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782730045; x=1783334845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D/+tKmqEVHdrXuSNJqyqQwhydaMlOMVeSo45A3y9ak=;
        b=oyI/H26lFj6+qhCKhcQPKAz2JKRRE2BIwmqYDhZR58GxiuPo3OYsSLPEInYwX1uAV8
         QhMD3sd1UjSVoyyB0xCYz2gVMqbym+a6TcaYQMeklDKuQA7z5a711ABRYqA7JJFuEEFE
         gBv/+uBfY67xhSWAv8AvDxuFlHahv1KV/z4+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782730045; x=1783334845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2D/+tKmqEVHdrXuSNJqyqQwhydaMlOMVeSo45A3y9ak=;
        b=BTlci1mgtjwCqsvBjEPs1qpoP3ELTEeiTTMCiWjtjw+OEbUUY9FpLOZ8thVNPBQhL0
         joVD0UZnDyz33ys3V0gsVO2iWn+OpXCuiDAj8nGtC9XGxZEG1twm92LqvBwdlrt2AL80
         j88JiHbn+lINfYU3I2dhmYFIKzrlWxsR1EfFs3BAGQIuCDgOH42XS9D9U17EUmAvz8Tk
         TLmgmVs8mo9nsDUPk/9vTPsItJwwAZkvBAr3mzWrbw7MhTlKlIiG9j6NFS8+a9rS6hp6
         uykbXADh7ZIAn9p0ukm0Maghxs8uvhVBTK8D4hIMtlkQiOUJhwL3kneJAHX4LVOJ7EHx
         nr+w==
X-Forwarded-Encrypted: i=1; AHgh+RoG97NNWMs2qFkWtNRSBsz/8mVcszXjzIvqQ4HHxXzRqUtS7PqDPsRF601r7HwCodknRvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9MPXzN4MqOclCmYz7AXasTVpVYgZEFL0rlvdXyHDkTq8B5u4
	YwF5VsLrvoIvtWAsczlyNTPvCvCk29u8P5NhQ4zVqSWpyncGoxKaD5RVcUzQR/8r9vnH891KOyH
	V2le7kwUnTeGYSXOtLCU1BoR2uyoXezriRxHz8lXK
X-Gm-Gg: AfdE7cnBwDrwtZg5eSG2MPuga6YGq0YmtE0MGOGsTdVh62fWx03+fDoSCR6CgvoGu9H
	Jy+5EMSeQ/NGl1GA+sZUxJj29h3c/C8P4gmo5BdAcKLgKvTPPjH5wPXOgAxMEFk53/O/PGnQ5KA
	GM26nyLOXcZ2olKFAspKyD/yUTqQFCNSvwHqhGaSnofF6X+HzAAOAcjpFIIchiolG/mPGIg/Nd1
	r3hjPkfemHYUgmNokU9pLdNcbsC1PEdm6UaleT4+1sFsEnU3MRQkgT3r9c2xTsL0ERWIYjsjA==
X-Received: by 2002:a05:6a00:4b4f:b0:847:1d73:f753 with SMTP id
 d2e1a72fcca58-8471d740f0emr3744079b3a.45.1782730045309; Mon, 29 Jun 2026
 03:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626165156.169012-1-jhs@mojatatu.com> <20260626165156.169012-2-jhs@mojatatu.com>
 <20260629102917.Ag2Vd7LR@linutronix.de>
In-Reply-To: <20260629102917.Ag2Vd7LR@linutronix.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 29 Jun 2026 06:47:14 -0400
X-Gm-Features: AVVi8CdCMJDxSkLILcgjDrSjOxQDi_5ubUK40tv1YNxcJz-LIUxKvJgWZ1t15wA
Message-ID: <CAM0EoMkh50LPeZ6sy8uA6APen1zTRBRYjcH_b521q=5YhitLKg@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	toke@toke.dk, jiri@resnulli.us, clrkwllms@kernel.org, rostedt@goodmis.org, 
	kuniyu@google.com, sdf.kernel@gmail.com, skhawaja@google.com, 
	liuhangbin@gmail.com, krikku@gmail.com, mkarsten@uwaterloo.ca, 
	victor@mojatatu.com, ast@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, daniel@iogearbox.net, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 -

On Mon, Jun 29, 2026 at 6:29=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-06-26 12:51:54 [-0400], Jamal Hadi Salim wrote:
> > The bpf_net_context used by sch_handle_egress() is stack-allocated and =
torn
> > down in that function returned. By the time tcf_qevent_handle() runs
> > current->bpf_net_context is NULL.
> >
> > When a filter attached to a qevent block (e.g. RED's early_drop or mark
> > qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
> > tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf he=
lper
> > bpf_net_ctx_get_ri(). That helper unconditionally dereferences
> > current->bpf_net_context resulting in a NULL pointer dereference.
> >
> > Note: The same holds for actions that invoke BPF redirect helpers
> > (e.g. act_bpf running a program that calls bpf_redirect()) during qeven=
t
> > classification itself. And as a matter of fact the same assumption is
> > made in the code outside of tc.
> >
> > Fix:
> > Move the bpf_net_context lifecycle out of sch_handle_egress() into
> > __dev_queue_xmit(), so that it spans both the egress TC fast path and t=
he
> > qdisc enqueue. The setup is placed outside the egress_needed_key static
> > branch because qevents are independent of clsact/NF egress hooks and
> > that key may stay disabled when only a qevent-bearing qdisc is
> > configured. Unfortunately this adds a small unconditional penalty to th=
e
> > code path _per packet_ only guarded by CONFIG_NET_XGRESS (two writes an=
d
> > one read for bpf_net_ctx_set, plus one write for bpf_net_ctx_clear).
>
> I fail to understand this but you and sashiko have an understanding...
> If there is TC_ACT_REDIRECT returned by tc_run(), then the skb is NULL
> and as such uppon return from sch_handle_egress() the control flow goes
> to the out label.
> As a fix you move the bpf_net_ctx assigned to before CONFIG_NET_EGRESS
> and clear it on exit. What do I miss here?
>

There are 2 separate filters.
IIUC, you are thinking of the first one which is the clsact egress
classifier (which runs in sch_handle_egress())  - its redirect would
indeed return NULL and skip qdisc enqueue.
The second one is the qevent redirect whch happens in
tcf_qevent_handle() during qdisc enqueue (block 10 in the reproducer).


> > This keeps all bpf_net_context management in net/core/dev.c i.e the
> > existing boundary between tc core and BPF without requiring any net/sch=
ed/
> > code to know about BPF plumbing.
> >
> > Reproducer (see the accompanying tdc test):
> >
> >   tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB =
\
> >       avpkt 1000 burst 100 qevent early_drop block 10
> >   tc qdisc add dev eth0 clsact
> >   tc filter add block 10 pref 1 bpf obj redirect.o
>
> stupid question: how do I get this redirect.o? Just a simply thing to
> reproduce this=E2=80=A6
>

It's just pseudo code for a bpf prog that redirects (so you can create
probably a few liner bpf prog).
Take a look at patch 3 which uses a prebuilt action-ebpf binary with
the action-redirect section (added by patch 3 to action.c).
If it's still not clear, I can craft one and send it to you.

cheers,
jamal

> >   tc filter add dev eth0 egress protocol ip prio 1 matchall \
> >       action gact pass
> >
> >   traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle() an=
d,
> >   on a redirect verdict, a NULL deref in skb_do_redirect().
>
> Sebastian
