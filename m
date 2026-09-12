Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8180633ADB9
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789257555; cv=pass; b=Z7/FIyj3lsTNMMDIk2St2DnBK3wtZ8DtZOqkI0UOUaCbhmyiiAC6UNo6b0rol8cbtYM+htNBRlX+MXAdW3LI5aMaTq2oZAmTfRYrnoPX3no1Fdn3ae2wBeZXa9IbzplA0LtvuuDl1GUc3oAt7VfjYVvHzZwBrVpCJVHfcmTJwhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789257555; c=relaxed/simple;
	bh=dt+UOPr8bzn5MsHDJfwrcRsGr6ZoVZ8m7l97MMZFyLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5jENxwjlR6YgU+OsICipFd7YsiJSLgi3E05vqu4DABmofAyQKhITGKL979JMaOcg2RKWNzPxpbypQvR8FxCnTZQvkXuLAwPTXndVJA/fQIz2g3Mslkg3QI8+0DoFKM99Tar0CL8qo8J0PZS33VPDuiIHmvnkNpCH7oKw5wxjSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlQwZYyE; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlQwZYyE"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso21142805ad.3
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 16:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789257554; cv=none;
        d=google.com; s=arc-20260327;
        b=ecRHvPIq4YSQbXdmDmb+ERKF8qOqXNoC5LNP5lRu4VnCGXHYCxPrx6WeysjQUIdfY1
         Am+Mqz5eteWh87CD6V1CyXvKGsHlo25RyW2Oeu8LhfY+lzxv9yx6eUPcyb/neRNctShN
         rNcIcCkAYzXSOwpZ8yzb6NXN8ZtsE0UXZC/ChSBWy9Ag72wxUKTdSihASC94p+3hnUbC
         gO/3Vn26eHw8fmBUi2MRNbNsQDTZxxlXTd0MOKZP1L5PnUvPli1lbAgJRE5f4qw8QkJS
         fPYWStmER/MQ6enhSnta8EOWmAeyDJNvKc3Xtb1+JFwfdg7YP/ZrcOOVcqEKC3PG4NQM
         9Fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5whm1ZGtSD6d9UTQoSVGX4pAamqW3MhbLVJJEUPVUGg=;
        fh=sTz7D7mMeVEr3T1r2pyIZwo0G+Yk+9apc/ViHPBRxdA=;
        b=YLOtRmm4RIps3ia0ymqHrr7ww2B3YWjtSTnxDDT0PEUX6XuPgR07bZiHfsqiucunLV
         PdveUnKh9/2SKVaZbYvll7qxE2SXNWbLNq3cqVF86+dov7LWcpXqRTjdwng0bDapgZuS
         RioWvsBxS3ZAlVj6EnUwjBXHMWTUp3+illJFKmtgNcJIrV63ns1b+hgcxswfcb7cVY8c
         n54tpEPetbjF0lS87FFpwis/diLc2SjPf4NnvpODxqwQElSIfwNdNu1QVLZqiWMBr8cq
         Twh5hFW9y3c7B6LthDbTHyqw/yLPjYQ10o2UqkShJFe0PCtI+IYwIvqXwdg643Mo4ZQm
         71tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789257554; x=1789862354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5whm1ZGtSD6d9UTQoSVGX4pAamqW3MhbLVJJEUPVUGg=;
        b=IlQwZYyE/8yZzLZtyPkuaMtWb6HkEiD6XnatVU8c83PI8R9DX8iLQUoHnZsBbe6djx
         E1k07ys8/Z3jFjiHc/K4EK6Cn1mxl5op8ZFLFT7B2tLSktYtwjrbc8aDt7tCPfys6OgM
         /SYBleTCd/zLzgBnTDSiZ3WaJpZpVqwNXXqsy5gl3z78KNTvfeWI6yI/3lzgkzrmPVxx
         mFGv2FslrofS90KLOHrV6jobrBCBfKwa3KQpRAi5LPtzlQ6bN9jz5m4/B8MXjHcwdSKg
         uE+5gY30FI2BTWO0/iQyy4u07F3d1fOWih8iAnVdmhqtO26vfLegZUHnj4BgYg2vJuvp
         +7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789257554; x=1789862354;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5whm1ZGtSD6d9UTQoSVGX4pAamqW3MhbLVJJEUPVUGg=;
        b=MEbYYjrRFYv+uyVdr42J4PD5wXPUm90AhS/espLw8sbfPToziEEKwR8sNhyHgxlo0v
         d8b0wzgJvGSOCZKINQUApNp1FlMqo9xfUKSTwGsGXY6DyFWObT6meqnh7DLLvE3UH1WI
         6eUEQom7jXFibVp/w5sboicrc8w5mz4B6MONHEOz/XMue3xVfkSzw0i0D1X6qJUxxP1t
         QEN8tkCCd+pojhbafJ62P6l/+j6G+tZyxvbKWW+PnVmJf27gZkF2FEWmFNUi8YQwSyft
         VbFyY8GPkStXAt3pUelTl/facsuONarO2dDVTRLbMStsYR3C/gBK14frT0o9feG8UALW
         wJ0g==
X-Forwarded-Encrypted: i=1; AKwUvBwO+kQVMUdpXpUA/LasrO5Nv2mwDx2mdvY6uOgiH1jzUpPh5BogG6qmEeJLE7zhz4Lgq7M=@vger.kernel.org
X-Gm-Message-State: AFuF++lsd6JZU7REAUGDFsPWqZRqz97SZOsVzv0asZ0DYyCbL4iLZCeL
	oCLh/rFHNLo5R6vDqXvhF2QOCmywPMDR87UD/jG3nS50R7M5NePpQbbG+qORDbkwb7e1/23zgBp
	D0l9e2nso4oLxf3+v4aGy04FdFE10JhQ=
X-Gm-Gg: AYBFou14RX5n5sSwLBFctFuxTMBXloolRk0yHpLpM9zKBS7AyrY9mjpP3m+I56O3IIQ
	OADmpnfX/QU4pJpmOM8BlTPhTzxFh2ub/w3bd/tX0PGdyILg+fAJyZB9hiJK+rO8Yb1/+SahT4Z
	5jarbJnUY0cViKk31CZvSaeeWPPw1OCIbdy+JGcLiBJNatw87WtPXv4yD1P6KdJjVgDWGapPHSR
	Yz4ZjPKEvK/t+VEor/RwcBqkLQQLcpQ7Mvok2G6qOBL5pTnlxJmehgSTb7iUWz+iWlkYDcNG+hH
	ilxr6gjyay0GASokbuHswjIu4jfwWE1SwnJ3whp3kB3niH06afDavtxMMXfqVxARuBsXK9NZpwX
	W0i03sMbpKRL54RfMnD3IypU0CpfJl0Z79Ka88fQ=
X-Received: by 2002:a17:903:1ac6:b0:2db:331b:e187 with SMTP id
 d9443c01a7336-2dd2a1e0a15mr200200855ad.8.1789257553733; Sat, 12 Sep 2026
 16:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
 <20260911-b4-rcu-tasks-preempt-qs-v2-8-eaaa61ed2da4@toxicpanda.com>
 <DLD0OHX8C4ME.VNR49VC2UYH4@gmail.com> <14cb8a91-497d-49f5-aa20-c6cb8b9a27fc@paulmck-laptop>
 <DLDICNLENSRI.2R6EJ0ZFJE45T@gmail.com> <8c51a669-eb6b-455b-a829-b537da5209f8@paulmck-laptop>
 <DLDLDGTSBHA0.32TYNBSKKPFXH@gmail.com> <8fbfb3fc-cf5d-4dfb-b144-bc021faa13ff@paulmck-laptop>
In-Reply-To: <8fbfb3fc-cf5d-4dfb-b144-bc021faa13ff@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 12 Sep 2026 16:59:02 -0700
X-Gm-Features: AcwNN1V04v_YLyVyvshDjEX_boeHQmR-dgrTXGEZk0Tlq9YUUBiA7_5E2kzlt5Y
Message-ID: <CAADnVQLQs-+-cu2R3QrHppcxOQt9m7Hi+grr4fOnw8m73kQn0Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 08/15] bpf, x86: Maintain Tasks RCU trampoline
 nesting in the BPF trampoline
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, X86 ML <x86@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Andy Lutomirski <luto@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	rcu@vger.kernel.org, linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 3:28=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Sat, Sep 12, 2026 at 12:40:55PM -0700, Alexei Starovoitov wrote:
> > On Sat Sep 12, 2026 at 11:03 AM PDT, Paul E. McKenney wrote:
> > >
> > > In the old kernels, yes, we have current->trc_reader_nesting++.
> > > In the newer kernels, Tasks Trace RCU is instead implemented in terms
> > > of SRCU-fast, which instead increments per-CPU counters.  Which among
> > > other thins is a bit faster and does not need to hook into the schedu=
ler.
> >
> > old kernels? I'm confused.
> > rcu_read_lock_trace() in bpf-next is doing t->trc_reader_nesting++
> > and then calls __srcu_read_lock_fast().
> >
> > Are you talking about some RCU branch that you target for next merge wi=
ndow?
>
> No, I was thinking of rcu_read_lock_tasks_trace(), forgetting that
> rcu_read_lock_trace() is still used.  (For good reason, just be clear.)
> Your comments are quite correct for rcu_read_lock_trace().
>
> Hmmm...  Josep's using t->trc_reader_nesting would break for
> partially overlapping RCU Tasks and rcu_read_lock_trace() readers.
>
> But yes, your #5 makes sense:  Deprecate RCU Tasks, upgrade RCU Tasks
> Trace to check for preemption from within trampolines, and move RCU
> Tasks users over to the rcu_read_lock_trace() variant of RCU Tasks Trace.
> (Or am I still missing your point?)

Pretty much. This way bpf trampoline stays as-is. No extra overhead there.
rcu tasks users (faultable tracepoints and what else ? )
switch to rcu_read_lock_trace().
The only difference for faultable tracepoints is
extra t->trc_reader_nesting++.

I have studied the rest of the patches in the series,
so this proposal can be completely off the mark.
