Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19049C4C2
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147669; cv=none; b=PYa9vD9S9tJnPgbDJSJObiQNUC+k1tfhmcA92X+NbfWL8G/eQAQ4k+fbhCA6yeTWoH3zzqNJ893BWsr5l0hvXYdIdWahBAjeX2TRxoL/cvpIHvz8IIgJaJ25rEPnBYRGZd5x0Wvo5LnJFL9l1C5DAo78zS7qGgPO4SQbLsBjBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147669; c=relaxed/simple;
	bh=rnZThFAGnmGU0UQlPMjaym4BCAvWP6M7XNsFuKOmtjA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+UWproX9bym2U7akq895fNW7LVSXOsAe69nesMGedQjXUUam2hsAFF5XrdvTevaTXjBw0nHp2It15DGWd99sklgAiYclNZFzUwA+jtir6Wz5sBck87XjcphwwWeXedzpDJE0YRG9WQf0IVUj0E1kQBERhnZb74pwoDiyqm3jKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Jbvg9AfN; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Jbvg9AfN"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-530d93a18ecso8983831cf.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789147667; x=1789752467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wpUPEQIS9yTOB1sr1PlCn6Mv7jz37PgyvzgihSoDlVQ=;
        b=Jbvg9AfNLYI4qikHoIzvbELyxNuZxN1QLABAbhccO04+YCQOauVECvdQRtiWu7ms4f
         zEdjlsAjjvu27Bc+YIpL0UBZuCciMFDerKQ3cTD2GRo7XmhfhbQHCRJ3KY07kqlDdEJM
         NGVo+RAnh3v1HM7f48xOk0qJ/4+TRV9UNruP5/4nulHaIMOH3ptGC7lCcQeL8XWuNh3W
         M1TBfrq0g7LXA2t4gXI6lpRk4TRUBSJ2W0vK72PoEh0QgnDPhybthijTMBPIuaqB4MVY
         kIJnexYit57zgSRHKsz/8qWo7XJR7EVsgSDW/4oXZTaOjsv7ISmGsPVpHUyrgPjDdCui
         kz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789147667; x=1789752467;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wpUPEQIS9yTOB1sr1PlCn6Mv7jz37PgyvzgihSoDlVQ=;
        b=cShRili634ruTQjprIPHQepjh+EP0B4iV6EIogUZC0ocR7/u8BTJ0H7vNboHPSEoxE
         m7XntRk5BPHkXSlPTOxEGy15a55wGHApIa4NQUvIhYQ5iJMT0sD3Frxu7kocXcG5QPnd
         phW9rLf7IZb+ZRXqMfxkcIOfuuikc4LHVBCJeMSkSFSv6ECnCSI3XZgF+JxOdUG8B2tn
         dEGcKmLIvHbFTSIUzCmA75msjGIyVxO4f+C11HpR0++64Gf4LWiZ8r8f3rT4bBzTy29H
         5P3JK7Gzcr2tUDyA9p/Ly7p8JYsSIc8o5+aMTerj1jTh6tCiWQt3xVsjs3XTlM3PT7Wv
         HyYA==
X-Forwarded-Encrypted: i=1; AKwUvBypKaqMHeq7VXVn4gi4ZpKSXVDtuxyWR1MXWVT6VBSJQXsd1Qc0amhAcdXYAvzjXnEkDIY=@vger.kernel.org
X-Gm-Message-State: AFuF++n4Y9UEAMW2b9TqSeU7v3L7LJoOkRsz3bn9mDRW4McShOkvUmpD
	FirqnhnVE3/E9/yL1eShKTu9tE5B77A6YQZL6esjkrTIMwDnF068RgA4SvwkWHC+GxYu8lsGEB4
	pZtE6
X-Gm-Gg: AYBFou0yrgGd3fiqQX/ZCOrGoBCBFB9XI2wxwM82eqYwl3tEuNcI0P3FoEoRHH+Or5/
	tD/8XN0IVpYlu3fqx7956nf5lL8hbrBkw0Zh04VW/cd7v6jCcFb/n19lnMUM4UF/QnmxIB0xLXC
	15iZq98T8SiqccVJ0P2QC1JCoKVM3Mo4OURxH/p+FBc9AXo3qDKX/ku8soqTOxNEuZkMmjMzSUJ
	WZ0yXGvHhXfyjh1vyZuEPqgbhrNERzNnO/zKJmHxXDMpSaFfVF639rHJQGlNIHa/ztVtao4JeeS
	+2FvIUzbQ8jICsOBQO7cEQlDuR71H0+5s1QQRgC0qDBq7HN7/vmtF1Wl5Avzh0UhoncOLl2UD6U
	QUcpCdETismcHFjxlMtSgnm8V0GzCkE4pXzKWnzQkxFtU2Smh5j0IROZGV8XntvnGOkqrymJPg4
	L3yUi890yK5HbkvHkmwUDUELHxPzHNLRmE6iQLCKHfDX/zQWpw6POAue1GAA3/j0Esr29dFDjj3
	KioxmTVEDWtbehtSKn4UxcCcBoENe+y9c+b0sisxprgkulbAOXixOZ3
X-Received: by 2002:a05:622a:1309:b0:530:42e4:effc with SMTP id d75a77b69052e-530c87566f0mr75877761cf.41.1789147666875;
        Fri, 11 Sep 2026 10:27:46 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca30855csm24883061cf.1.2026.09.11.10.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:27:42 -0700 (PDT)
Date: Fri, 11 Sep 2026 17:27:24 +0000
Message-ID: <59aed05db0d993f69088fba21576792d.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RFC v2 04/15] kprobes: Let Tasks RCU recognise tasks preempted in an optprobe jump window
In-Reply-To: <20260911142626.ACAED1F000FF@smtp.kernel.org>
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com> <20260911-b4-rcu-tasks-preempt-qs-v2-4-eaaa61ed2da4@toxicpanda.com> <20260911142626.ACAED1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 14:26:26 +0000, sashiko-bot@kernel.org wrote:
> > +	for (i = 1; i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
> > +		if (get_kprobe((kprobe_opcode_t *)addr - i))
>
> [Severity: Medium]
> When kprobe_in_optimized_region() calls get_kprobe(), neither rcu_read_lock()
> nor kprobe_mutex is held (for example, when called from the Tasks RCU GP
> kthread).
>
> get_kprobe() iterates the hash list using:
>
>     hlist_for_each_entry_rcu(p, head, hlist,
>                              lockdep_is_held(&kprobe_mutex)) {
>
> Without explicitly acquiring rcu_read_lock() around get_kprobe(), lockdep
> will complain about suspicious RCU usage, because preempt_disable() (or
> running from a kthread) does not satisfy rcu_read_lock_held() on
> CONFIG_PREEMPT_RCU.

This is not right. The list iterator's check is not rcu_read_lock_held(),
it is

	RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(), ...)

and rcu_read_lock_any_held() ends in "return !preemptible();", so any
caller with preemption or interrupts disabled satisfies it regardless of
PREEMPT_RCU. That is also the actual RCU guarantee since the flavor
consolidation: synchronize_rcu() waits for preempt/irq-disabled regions
on PREEMPT_RCU kernels too, which is what the kprobe free paths rely on
here.

Every caller is in such a region. rcu_tasks_preempt_is_qs() runs from
rcu_note_context_switch() inside __schedule() after local_irq_disable();
the grace-period kthread only evaluates it from the task_call_func()
callback in 14/15, which runs under p->pi_lock taken with irqsave; and
the preempt == false callers (cond_resched_tasks_rcu_qs(),
rcu_softirq_qs()) short-circuit before rcu_tasks_preempt_is_qs() is
evaluated at all. Nothing calls this bare from kthread context.

I also checked it the boring way: PREEMPT_DYNAMIC=y (so PREEMPT_RCU=y),
PROVE_RCU, PROVE_LOCKING, booted preempt=lazy, registering and
unregistering optimized kprobes in a loop while a kthread spins and gets
irq-preempted, which is exactly the path that reaches get_kprobe() with
kprobe_optimizer_waiting set. No lockdep output.

For the tool: when flagging hlist_for_each_entry_rcu() callers, check
against rcu_read_lock_any_held() (the condition __list_check_rcu()
actually uses), not rcu_read_lock_held().

Thanks,

Josef
