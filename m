Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0123363C59
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207265; cv=pass; b=pidLtPvS5sdAQWAX1Qu5mKXBDGJVhHQMLuGCaYnM/hcC+fMLHB/fb/aADDJxscaspAWm7yxXuhkwlnFjt79QawEkn3DuzqSd5jhaIckmVhk2zwjlUaRLDAiqzj166kukOyES7zp0XLS/G9HJ3ALEMaJvmOoPQ47gtIagQitFkaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207265; c=relaxed/simple;
	bh=lIsDmZ53swgi62/lXyTRsvtF6ZbNbxx93c90ruKS3gs=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYgbhbCJU7jT2zDuu8D+KzGRmbtgkOfvGLl39B7ow35prLzT42MXVbhVZZZ1QHwx8xwTHIWlBHD145uNsy7O5Z6hS/mzclAdDi2I4MqwtCpsviXv03YsbtgJpdERIiSJimRSbYyVRVGq4d29aCp053jUmV7iv+0sBDD2F43Vc+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=L/Rioj0a; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="L/Rioj0a"
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 721D83FA8B
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 09:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782207260;
	bh=k/jZC0jxAqjvGzOmb9VX8r5AMgUUP3sAniVJUnbB+gc=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=L/Rioj0aQTXCV2YHcwsK9Av5v2oNc0vkUfDrKXxSAFA9mp198ZZW5vdNEl8BgRzl9
	 O/ylHHIsLRB6ph7jdEwlPuWz68atQewVf7Pzd4S6LraFXgQoB4dIuZD76/hwNdkgNJ
	 TLlXjbcGMpriNtILGzXPGZ26wE4M3pFueGrntCnihF6+Xv1zYXNj4xGw6tLTwH8GQF
	 z031DnTmdwa1hPsIBivZQTwP8Tj8E0R7LbfAc0U1Qa+FQEnxuvXFTX110HG6JmDTWi
	 YRqCrxTwec2v683ZxSJq7Iaz2LKFyNyzcNm37KUvV7XuKSUJ2IBekFt6fBtbqI+tys
	 xOG30fmYivv9obQw8Cxc13Jn/Od34moUVjv8XGTIZ30xOHaUJf3qOvWSkD87PYIf2m
	 zq7fWMszXSx1eSeaUx+7u9kjH4lZS9u87+mrX1jLrocYpi5g1J872H2bkIy4IdHmjV
	 /wAa3L/ITMO90wOQ2Ny39x8DVteZJ3ATT/p8UzzgemWAb+8Z9RryaMFEjshmxHZ9yq
	 Y+NHR0NaaHURymXzcLnO8kU6TeNNpLrKa29CHXmXXTza/Ke2UxWhxw1NWO9gtfNRpN
	 V4E+szcXUiVdX/nPB1/Ngi5W2HphJ3A9xg0KBW4zIOH0nlaXSV2BG4whxJ0dAB+xog
	 n9CKSSMOenIGGWhj2Q/DWkaI=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c0bcdf949d5so368155166b.2
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 02:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782207260; cv=none;
        d=google.com; s=arc-20240605;
        b=JcEBotrDLys21BXOqXiUBrPG7Yk1SUPPMvOL0RvB5BMR0TK3507jARpUKAvLWnquX0
         DCPC1ZF380CvAyQrCW/ZkP7HsqJ7LYgbbZeRtYLXrm/+Px3ndI59uFqkzyE0E9k9FBgc
         H2SIJjNRhA7jLCfdU+ROQyXbcuH4lhPZWfanOgpZy+gZKjfGtwpfAwyBH2u0TnpUlf8p
         iIYQbwc8gOOB3YqORZcOgSuqaqoWX0VPJ9xQHsIBfhcnoJgWEOuwKCmKenfBwcioX65R
         UHHtqei/IX243M7ZP3HeUpPSf57l29Ch9Xn7NR2xrdtqj+OSjAvsDR7rYKjH87hRFTD0
         1J8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version;
        bh=k/jZC0jxAqjvGzOmb9VX8r5AMgUUP3sAniVJUnbB+gc=;
        fh=N1vj5fvFS3TrHA/e69mRlT+rGKxpbjFGLN5Ib1DwYC4=;
        b=iQCVLpJmqVeFmQpf7ZwZ94bU5H/me64z5z8dMKrDC8IW+xVXbrDzc6DEeuFXquhVCA
         xbUHT8/kUiPEJbYhJTgUbqnDcZjJp5XoI5L43Y1CGYfuNPx6xaRV0r4yIRlIlRDtMHnB
         RBTeeE2cYlXwvDRS5xmHb/f2QSH7mpdABdm4J8Iwywz8s0/p3mYGB/ciBnzDap0xm+ja
         fiPE52cvmQ/3giENxT94xchhR0xcOHX1I/QmYysJXGClPAnv1QnIcGrcsnXXaDpRNJyu
         bz6s+Yu9CEiYwU59CHhiMZHvu5hG2O42HhJn3eLGBOuEktQY2DIn/AJznxiDggp4QZgX
         GEiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207260; x=1782812060;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/jZC0jxAqjvGzOmb9VX8r5AMgUUP3sAniVJUnbB+gc=;
        b=lT8EVUzISdD+S9pfkbhiIMZ83oKkNnJ2hdGb1ggccnkbC5mTZ9UIyUF+08L6K+54yt
         pGEwxxztjxbMpcPwFJWg3QSbWZssCOlsaZ0yHd9ZffU00NTOceRUEZQUSsn0SrpLDK0e
         mvlh5jKMWdHStZ3J27FrQ+eN66c6nM6pSBd6fnD6dudiHwfP+Nq948VZC91s30BHSLF+
         /oFJ4XdNPAnov8Y7uKZp09nNHkIJz7/anvHyQHFObdz1x2XHkcm7oqq1vGZ2a5vtJk08
         iaQCIOrD78SaGpaK+NXXpFuoF4vM9I4sRj6sKIb2OMcobqig9to4EmzlrM3ygmjt/qXb
         N8cw==
X-Forwarded-Encrypted: i=1; AFNElJ+EkhcOFEDd4yrd8oi4MNcaR4hq+Ufix1Tqb1fybVzxLvwshAsjeHznBWQtqx1hToVHzQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfvr3XidC1YX7svv7rErESM0ZoIBt5EpJa26NXGJ+SvW1OHYGA
	uiHWkpqEaRM12+zrTf8jeUmXFxD/OsI6rA8m4dZobehS4lE1GWTJ6rWwWHpykZ+j900ALvcjztu
	F5xiTa31AzkxyczuSdb5hA2oFKerc6dAAvpJCKrgDSOIrQQkeskYqdlD2DaJauUW+x+trWKHk7H
	72CQNirqMx2jRAfbZn7CfWu5/yrVHIvDWHguRhE3dW8/Sx
X-Gm-Gg: AfdE7cltjrQc8SvNrCNr9txq+foO8y/R8yQNyuAIjy14Ip4ghSTk+cIpzxnRijZbWff
	OHzU7Q4K9bDlQM+GmKnqD01KOmKn7/Ta7ZCpzr2HAShMx/VdCLFXvxfgX0V3Bl17iFWfKynbHqX
	mYgpMQPm7bul3KqyiFg+Op56lq5WoWsWf7Ldln4CiRCekD+2BHIUd8joz4Ojpg2+xbww==
X-Received: by 2002:a17:906:ef06:b0:c0f:c475:6bd6 with SMTP id a640c23a62f3a-c108db17c0cmr92554966b.13.1782207259726;
        Tue, 23 Jun 2026 02:34:19 -0700 (PDT)
X-Received: by 2002:a17:906:ef06:b0:c0f:c475:6bd6 with SMTP id
 a640c23a62f3a-c108db17c0cmr92552666b.13.1782207259313; Tue, 23 Jun 2026
 02:34:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 05:34:18 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 05:34:18 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ajlW4oSzEqav6gxc@MacBook-0RXW5>
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
 <CAJM55Z-hiNDuu5UwoBe7m0wq+_WJrRY0cwopALUgpG+r3ixj8g@mail.gmail.com>
 <ajQPAk_ALP-84obp@MacBook-0RXW5> <CAJM55Z_15U7GssTOims1=J34CYSj=8CDE_di1kJYs5hE3=J53w@mail.gmail.com>
 <ajlW4oSzEqav6gxc@MacBook-0RXW5>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Tue, 23 Jun 2026 05:34:18 -0400
X-Gm-Features: AVVi8CdojB9okAozVltix1WQqZPQNDUlWinUTJkCeQ22W9Cw9M6UJGdyZafHpRM
Message-ID: <CAJM55Z_7N40ARWGoZg04p-NnAy-w10v4=Em-e4Bx4+oNYMGBLg@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start process_srcu()
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org, 
	neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com, 
	rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrea Righi <arighi@nvidia.com>, 
	Zqiang <qiang.zhang@linux.dev>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, Sarah Emery <sarah.emery@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Boqun Feng (2026-06-22 17:38:10)
> On Sat, Jun 20, 2026 at 05:25:25AM -0400, Emil Renner Berthing wrote:
> > Quoting Boqun Feng (2026-06-18 17:30:10)
> > > On Thu, Jun 18, 2026 at 08:11:36AM -0500, Emil Renner Berthing wrote:
> > > > Quoting Boqun Feng (2026-03-20 23:29:16)
> > > > > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > > > > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> > > > > happen basically everywhere (including where a scheduler lock is held),
> > > > > call_srcu() now needs to avoid acquiring scheduler lock because
> > > > > otherwise it could cause deadlock [1]. Fix this by following what the
> > > > > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > > > > the work to start process_srcu().
> > > > >
> > > > > [boqun: Apply Joel's feedback]
> > > > > [boqun: Apply Andrea's test feedback]
> > > > >
> > > > > Reported-by: Andrea Righi <arighi@nvidia.com>
> > > > > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > > > > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > > > > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> > > > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > > > > Tested-by: Andrea Righi <arighi@nvidia.com>
> > > > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > > >
> > > > Thanks for the patch, which is now upstream as
> > > > 7c405fb3279b ("rcu: Use an intermediate irq_work to start process_srcu()")
> > > >
> > > > Unfortunately it seems to halt booting on the Allwinner D1 single-core RISC-V
> > > > SoC both on the 7.0 and 7.1 kernels:
> > > >
> > >
> > > By "single-core", is it only one CPU in that system?
> > >
> > > > https://esmil.dk/d1-7.0.txt
> > > > https://esmil.dk/d1-7.1.txt
> > > >
> >
> > Yes, the SoC only has one CPU core capable of running Linux at least.
> >
> > > From the callstack,
> > >
> > > [  243.002818] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [  243.010681] task:kworker/0:0     state:D stack:0     pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00000000
> > > [  243.021858] Workqueue: device_link_wq device_link_release_fn
> > > [  243.027587] Call Trace:
> > > [  243.030079] [<ffffffff80745b66>] __schedule+0x232/0x530
> > > [  243.035365] [<ffffffff80745e82>] schedule+0x1e/0x94
> > > [  243.040298] [<ffffffff8074aa7a>] schedule_timeout+0x6e/0xa8
> > > [  243.045929] [<ffffffff8004d6a0>] wakeup_preempt+0x8c/0x98
> > > [  243.051380] [<ffffffff80746aee>] wait_for_completion+0x3a/0xb0
> > > [  243.057267] [<ffffffff80087226>] __synchronize_srcu.part.0+0x4e/0x60
> > > [  243.063712] [<ffffffff80084414>] rcu_tasks_get_gp_data+0xc/0x10
> > > [  243.069699] [<ffffffff80490898>] device_link_release_fn+0x14/0x80
> > > [  243.075850] [<ffffffff8003dbd0>] process_one_work+0xf8/0x1c8
> > > [  243.081583] [<ffffffff8003e282>] worker_thread+0x11a/0x254
> > > [  243.087127] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
> > > [  243.092755] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
> > > [  243.098381] [<ffffffff8004499e>] kthread+0xbe/0xe4
> > > [  243.103231] [<ffffffff8001349e>] ret_from_fork_kernel+0x6/0xd0
> > > [  243.109127] [<ffffffff800517a8>] schedule_tail+0x8/0xac
> > > [  243.114410] [<ffffffff800448dc>] kthreads_online_cpu+0x0/0x4
> > > [  243.120121] [<ffffffff8074be0a>] ret_from_fork_kernel_asm+0x12/0x18
> > >
> > > I will guess for some reasons the irq_work was missed or the IPI never
> > > happened. Is it possible for you to enable trace points ipi_send_cpu and
> > > ipi_entry to get more information?
> >
> > I have to admit I've not used tracepoints before, but it seems like only
> > ipi_send_cpu and ipi_send_cpumask is available on RISC-V.
> > I've now added trace_event=ipi:* and tp_printk to the command line, and this
>
> Thank you! Yeah, this is what I meant ;-)
>
> > is what I get:
> > https://esmil.dk/d1-7.0-2.txt
> >
>
>
> [    0.071132] rcu:     Max phase no-delay instances is 1000.
> [    0.077837] ipi_send_cpu: cpu=0 callsite=irq_work_queue+0x22/0x4c callback=srcu_irq_work+0x0/0x58
>
> Is this the last line you can see from your (serial?) console, or we are
> missing a few more lines? Maybe it'll should the same hung task
> messages?

Yes, sorry for not being clear about that. This is the exact same binary booted
without the two extra command line parametrs:
https://esmil.dk/d1-7.0-3.txt

But with the two parameters added the board reboots before getting to the hung
task messages. The bootloader enables the watchdog, so I think what happens is
that the kernel halts earlier with the tracepoints enabled, and doesn't get to
load the watchdog driver to keep the machine from rebooting.

The same happens with just trace_event=ipi:* added, just without the last
message above.

>
> The ipi_send_cpu message means RCU was able to send an IPI, now if there
> is no ipi_handler between the send and the hung task, that would mean
> the IPI was missed.
>
> Regards,
> Boqun
>
> > Let me know if there is something I'm missing or something else I can do to help
> > find the bug.
> >
> > /Emil
