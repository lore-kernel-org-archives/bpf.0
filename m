Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E55329E46;
	Fri, 17 Jul 2026 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253929; cv=none; b=EbxRGmlmeJwwT7j2MYuCSzTfJW0fZGyIFsCiwl8BDuqfFrmQQ34Lhub0pZCAuuze8/OaaQ/fesXrZT4hBJWD8fGsU+2v1VLQUpBA94P/sNgtnl9iEyDorq9P6gAjIQhWRxJE/ULDfi7g09Dy+61blJFgUNymaOLundmWexbwFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253929; c=relaxed/simple;
	bh=4HHXnFs15qYBxD3mB2j1xfwe+/ju7oZyKN3oPIs3UPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o1jMlvypJtX1L3ysPxCIf5dXUiXjmk0zhX1RIXJcJNJlHca15/3Z7kN77qp8Yr33WB6hAfj83rBuWgzHCaENc9jOSL0OhOuz485UL5uLuU+Bu7FgjXXkePIFyWRT+T5kUbVkIwXKuLU8pObFAT7WqzdmwQzSjlKzULmRsXa7lOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=iYf9ECku; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="iYf9ECku"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0czS6fGKnRAlpLNmhKUfszqeeJjdTdy4oh9/e2ZpkBY=; b=iYf9ECkuHtG0MyUyEiQrxD+b0E
	t443YXmnLYB6oIf39NNtGJvHs9HdbJVGgpaJLEQEg4aLLwnEA3yE7KkYly92QIWNB6IXg3VoZhqdp
	TqW7xmXWj6EHw0siJG1uVTle4b/tzHb1XSBLhkeIw8vQpEBMRKqIFft/sT4tdqMwzirYymoeKwcEn
	FD+KJjMWENUZYeZn46YkMgKSvoq8zDGhoEKKbcqEZbNl8wGPei3HDwflo3SwwyCVkP74ji3SUTIKg
	JmN13uFMlfoOL/+Qp0IcFWKFVfJ29RFgx+k7vjmbL1f8ay/Y3CP2CQnJNRTSrNGD9llHCofii3q/v
	pdtVTtMg==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wkXwV-000000007kZ-2LhO;
	Thu, 16 Jul 2026 22:04:47 -0400
Message-ID: <be9c5707e2d83090de28e4b0ce3bc43c67f423af.camel@surriel.com>
Subject: Re: [PATCH + QUESTION] bpf: use cond_resched_tasks_rcu_qs in 
 bpf_fd_array_map_clear() loop
From: Rik van Riel <riel@surriel.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@meta.com, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman	 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,  "Paul E. McKenney"	 <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra	 <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 16 Jul 2026 22:04:47 -0400
In-Reply-To: <20260715215314.44423f47@fangorn>
References: <20260715215314.44423f47@fangorn>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-15 at 21:53 -0400, Rik van Riel wrote:
> syzkaller creates a PROG_ARRAY with huge max_entries and triggers
> perf
> tracepoint open close in parallel. The hung task detector reports
> "INFO: task hung in perf_tp_event_init" with event_mutex held waiting
> for synchronize_rcu_tasks().
>=20
OK, this is more interesting than it looked at first,
and this patch does not look like the right approach,
but I'm also not sure what other approach would work :(

The actual error being thrown is a hung task:



The syzkaller kernel failure is a tragedy in 3 parts.

First, we have perf_event_open() waiting on the event_mutex:

   syz.7.35551 (pid 31354, state D): perf_event_open=C2=A0
  -> perf_tp_event_init
   -> perf_trace_init
    -> __mutex_lock
     -> blocked on event_mutex.


Second, we have perf_trace_destroy() indirectly
waiting in synchronize_rcu_tasks(), with the
event_mutex held.

    syz.5.35491 (state:I)  do_exit=C2=A0
  -> task_work_run=C2=A0
   -> __fput=C2=A0
    -> perf_release
     -> perf_event_release_kernel
      -> __free_event
       -> perf_trace_destroy
        -> perf_trace_event_close
         -> reg(TRACE_REG_PERF_CLOSE)
          -> perf_ftrace_event_register
           -> perf_ftrace_function_unregister
            -> unregister_ftrace_function=C2=A0
             -> ftrace_shutdown
              -> synchronize_rcu_tasks()   <-- BLOCKS HERE, forever,
holding event_mutex

Tasks RCU waits for every task to have gone through
a voluntary reschedule, before the grace period can
be advanced. A preemption does not count.


Third, we have a kworker looping for a very long time:
=C2=A0
  kworker/0:0 (pid 9, TASK_RUNNING, on CPU0): process_one_work
  -> prog_array_map_clear_deferred
   -> bpf_fd_array_map_clear
    -> __fd_array_map_delete_elem. Looping over a huge PROG_ARRAY
max_entries.

With CONFIG_PREEMPT_LAZY=3Dy this gets preempted,
but since involuntary preemptions do not count
for tasks RCU, that does nothnig to help
ftrace_shutdown() get unstuck.


How do we solve this?

Do we actually need to have cond_resched() points
quiesce the task RCU state when running with lazy
preempt, since those are points where we could
preempt voluntarily?

Do we need to prohibit calling synchronize_rcu_tasks()
while holding a mutex?

Do we need to do something else?

What is the best way forward here?

--=20
All Rights Reversed.
