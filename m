Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D821AAE17;
	Tue,  4 Aug 2026 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883748; cv=none; b=Hhvbi5hnnYSW7PfaOuogWXL04QhJTORoOyNvyabfoSIO5BrBm+hot64mNcg+ZiacrpuovOU27YZHPsa+U+16+HqRt6Blxf1ODxHkJ02lGxgoJZP2qiQAHRdsmLT6moda3QIXWJqsJLfTdtKqMdCgirqUe2gn86Y8hecIRFAjNis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883748; c=relaxed/simple;
	bh=K/r4j8r3y8S4NMTphRD8Mr+GQQHrUjR6cK6Hpazql+w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GQPHDGqSI/tgPtKf4EgGThqQyC7SdMZazQCmWwXF40FfAn8IbODwAEFwuaFTALVtkAIgo6hsE/fhu5jhYmKIqT9x4IRWYYGyOQXNb01k4qCqF6YldrFG99JrOvXJIxbzFrj89w9OvlvS3kl0tidWLN7gcGaCc+fYkoeZhigiz+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=FJCJZPC4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dFdER3rm; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="FJCJZPC4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dFdER3rm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BCCD7A00D7;
	Tue,  4 Aug 2026 18:49:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 18:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1785883745; x=1785970145; bh=qIzMw+om4+YSLCepOaZuxPhmXqcq/sTVF+U
	2bfjx44s=; b=FJCJZPC4tTdZZgy/C0h4GR7T6qCcdMiOoUsAzAFG9adxDGQ2wFH
	Th8X+COcsN0kYwr6aKY/qGzdrJh1X10xZCTwB1Qom96s0WHzRTar0j9nJdn0a6rb
	vLLNI/IKLJfCFm7IYkhaWLrRe4f5bbMLXDezxJBVupNHlV9TkehwHhY1K2Lw6+XW
	fl59qea1vAfFWGQJuYludNjTBLjGvWpe+hUREi+ceR1loGwPQx8SuUlFY3i10uK+
	Lku8sBq4yQFyeiKVJBsD4AaSL2OVL+stVMZkyIX8CxJv2dvYp0JJyeLM2F9LC2G9
	adoyuz1bvbKJbexFUOmqcEwnazS+cBNlKAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785883745; x=
	1785970145; bh=qIzMw+om4+YSLCepOaZuxPhmXqcq/sTVF+U2bfjx44s=; b=d
	FdER3rmk6vIA1AtNQpOhjEToyLUDCntPgnEUZZ2IutGqEDrwOZXfFsCja0yNzm4Q
	2/InzDrQC638J7SvnZ2UMfzPR2Hq2ryAKziaADFFqEdeXZFBi6uBhH/d99ymT0yA
	zrxDvMIY0ABKaKGTIl9JBenb/fRClxdg237Z2FQ8lRyfoTQOlDaGq/G+w6U8Xd/l
	NGWmCxkbFTThFbXKwlsEjHZrjH5SU3HgcQx3z6hrHpntyH1CIiSgboAALl376pBa
	VX1eeX5x3mcDmZUTqS5U9OxVQmiEKLe/hR3zLs/KM3KxMU4hIwzlQXFOmCjB5Y5i
	rminuIgZM2y7v4up+LLYg==
X-ME-Sender: <xms:YGxyanrEjYp-7KlaQC5JLrB9qL5BRgEpDtpNBI0zXd7G4vSEvIALiQ>
    <xme:YGxyaiELx2Q5GpqNznLnfLqHRDyF6eTqWAlcNLfziGIzcpghUivV9gtn7LDi8vYw6
    alTZ-7vQwsZcWJc1-KYYaZBk6d7KtfWHa95bbHLoEYCdoSE3n4>
X-ME-Received: <xmr:YGxyapqm6XH_zwLNQxb3zTRtlA2lniOUhlQxTwzo9fcvQtuV8zZBXL7i3s0GPbkz1Js5pyxFyXKxI9NvjmWmcUz--bxkMqA>
X-ME-Proxy-Cause: dmFkZTFn83mOMi3RJ7QFSIW+tVuoWCm3JpeFz+t+h8EG5mwKOvw6A6WwhcIU5FtbDam5x1
    Ml5Uh1mm4UxFVo9IhgLjb0sUXgUWZVHDcU/ghgdgjpnGALhHT4LRdpo4hvA83/1i1aDdw2
    6ZBsRpaIsMAOEMmyC+qbw3Zi+uqjizW43MXezhltshWqNN9p9QRfjYnVGf2yDXfXmG+G0l
    TdaXayKFZg9i9WeteASY9IIKQK8yglunlYj5SQdtI7gEMINn7XTl13K8nVficv0g6QqpQu
    JzFTrKgJcJTASyBbCGE/MfMt/zoh35U+oGEXpB3lPkvNMWW/nHzN/uejISqcNUQZXrq9Dk
    +Y/UgA1zrA1U2RZDePa49pylqs412ee8iNAIy4I1g5JpDRcs1JK7qwAtLjmoTjfXwZqgks
    2VQctY6x+P7LJ02xXQ40OamkslYA742JcHw/a45gGGfRHvIJTdcjGL5xRMIhfiiCyzM/aA
    CeMvtgCGg32zzfgZn3hgGFToFPvQ16ER853c9z+HcyjKDFjZSscPAwt4qeDXbOSw0+fn7+
    Yz/7m6V8raWrhUOrv3oYpvaE0y5IF2d+Ti6QtRpz5/mDXa8COPdrLteBvsQ09YztbEl+P+
    YezuDFlQr6q3vxlx/dP6IR4H7niotW0UCjCLDswuh3zKjw7VkPsiAfUrnNeg
X-ME-Proxy: <xmx:YGxyao2iWqQ2NyZO53wt9yfFfYaFkn0ckGqPfZgJ4zfigRvQebs8hA>
    <xmx:YGxyaqtcVYDI11QEQqz8vq8ABCEIfAUzVa4JPouOWGLd4MxFOmgBQg>
    <xmx:YGxyahEeByM4cU81lraspRvpGelZA3ZlhosE_jsEu5cavaupoWsc0A>
    <xmx:YGxyap34eCvnoer-rkuc9TuwKeaCF1z3ZpA2wNmPs3SoUJOJSjHk5g>
    <xmx:YWxyakxxMGhAzR-LCe3yZ6oQ3zbhRgAxZq2ImIQcNCoMdRstn9xf6Q9n>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 18:48:58 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Quanye Yang" <quanyemostima@gmail.com>
Cc: "Justin Suess" <utilityemal77@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Song Liu" <song@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>,
 "KP Singh" <kpsingh@kernel.org>, "Matt Bobrowski" <mattbobrowski@google.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "Emil Tsalapatis" <emil@etsalapatis.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com
Subject: Re: [PATCH] bpf: disable lockdep while running BPF on lock_release
In-reply-to:
 <CABcBDJuznu=BgDhevsD6PybX8+6fcaO1xyTcuGuv8F_+MfeZoQ@mail.gmail.com>
References:
 <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com>
  <anEuaSqiCVsQ6I4P@zenbox>
  <178583246611.3252194.4318729338489544399@noble.neil.brown.name>
  <CABcBDJuznu=BgDhevsD6PybX8+6fcaO1xyTcuGuv8F_+MfeZoQ@mail.gmail.com>
Date: Wed, 05 Aug 2026 08:48:56 +1000
Message-id: <178588373680.3252194.4414470901360919775@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 05 Aug 2026, Quanye Yang wrote:
> On Tue, Aug 4, 2026 at 4:34 PM NeilBrown <neilb@ownmail.net> wrote:
> > I know close enough to nothing about BPF or trace points...
> >
> > Can BPF programs ever block waiting for a lock that is held across a
> > tracepoint?
> I investigate this and I think the answer could splits in two:
> 
> Mutex (sleeping locks): no, this is prevented at verification time. A
> BPF program attached to a tracepoint is non-sleepable --
> can_be_sleepable() returns false for BPF_PROG_TYPE_TRACEPOINT, so the
> verifier rejects any sleeping helper; and at runtime it runs under
> rcu_read_lock() with cant_sleep(). It cannot block on a mutex held
> across the tracepoint.
> 
> Spinlock: yes, in principle. Spinlocks busy-wait rather than sleep, so
> the mutex protection does not apply. BPF programs do take spinlocks --
> each map lookup/update/delete takes the map's bucket lock, and
> bpf_spin_lock is a spinlock -- so a program attached to a tracepoint
> held across a spinlock can spin on another spinlock, and if those form a
> cycle (or are the same lock) it is a real deadlock.

Thanks - this is helpful.

> 
> That is exactly the hazard BPF already hardened its own locks against:
> the hashtab bucket lock and bpf_spin_lock detect recursive acquisition
> and return an error instead of deadlocking (rqspinlock, succeeding the
> map_locked approach in 20b6cc34ea74). The rhashtable bucket bitlock has
> no such protection -- which is the gap I think.

I don't think that detecting recursive acquisition is a scalable
solution.  You'll keep finding new locks that you need to enhance.

If I step back a bit, it looks like TP-BPF (BPF attached to tracepoints)
introduces a new execution context, similar to SOFTIRQ and HARDIRQ.
i.e.  it is something that can start running at almost any point and
blocks the currently running code until it completes.
I suspect it would be good to handle it in a similar way.

So I suggest adding a new
  LOCKDEP_STATE(TP_BPF)
to kernel/locking/lockdep_states.h, and teaching lockdep to understand
it.  Then it could help avoid all these problems.

An important part of this would be the ability to temporarily disable
TP_BPF much as we can disable interrupts.  What happens at present if
there is tracepoint that happens in BPF code, and a BPF handler is attached
to that.  Does it get called recursively?
Would there be a problem with disabling new TP_BPF handlers while TP_BPF
code is running?  Maybe this is already done?

Circling back the original patch to rhashtables that was proposed - had
you said that you needed to use rhashtables in a different context
similar to HARDIRQ or SOFTIRQ, then I think I would have had a different
response.  That is a well-specified problem with well-understood
solutions.

I would likely be OK with making is possible for lockdep to see locks
from different tables as different locks, because they need to be taken
in different lockdep contexts.

I would then see if the new lock_class_key could be declared in the
rhashtable_params struct.  This is already passed around everywhere, so
this would be much less intrusive.  We would have to use some cast to
get rid of the 'const' attribute when passing the lock_class_key to
lockdep, but I think that is justifiable.

NeilBrown


> 
> quanyeyang
> > If so, then attaching a BPF program to that trace point could
> > trivially cause a deadlock.
> > If not - then how is that ensured?
> >
> > Thanks,
> > NeilBrown
> 

