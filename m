Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAE346AF9;
	Thu, 29 Jan 2026 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706380; cv=none; b=kqsYbr99/KB4EZrw98ImQWyzKbYjpOETvgbln6+tGuzuMKp+uiio0zGYvUuQpaiU5C34vtAIlFYNUZiFzLxu30C7MsJVKuWMsH7dHKnx2AGMH0h+6z9wsH9tnQmsYr6Hg0n+1UapzCUOpoj81pZjLAPNqF859BynBuSjHd3RHSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706380; c=relaxed/simple;
	bh=N4n7EneCMOI+oV6Pq4xv/tDKMSCu8BVYllhdzfsTKcM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=irO0XYL9Z4Fn2mG96OIwisO4yq1+XsCTCBaXCyJPBYAP2wV4J4JlrOEeK8wYP75VR+uQy25eh6iXsCgtDrcNe32JnTVIfvoZy2jN+nYwQNe6CEX1Dc8tTpeN9ucM2ReAHFm5B/NEhw4SOgQaqzEgUYrcVf+WOIOdEbwFjz2PF70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcOy61pI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcOy61pI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E54C4CEF7;
	Thu, 29 Jan 2026 17:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769706379;
	bh=N4n7EneCMOI+oV6Pq4xv/tDKMSCu8BVYllhdzfsTKcM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QcOy61pI/xRBlw8Te4U+jOMIW/Dj0snOE3o/jF2QXAVxr1UtKmRDcPNdNfrcEnzfc
	 IzjLGR+E6HZxvx+tLEwerogafiqrVe7q5wcYxlF3cK1kFUnFMKfpmKFYhayp2+SoDQ
	 AaSfUDQG0yc0KAovLG5xDruwAGLnBSSKnF2AJiCve3Q/th3s+PW3XlDRM0tiUjPAlq
	 taSYsc/u2o5lBDsBvXn5peKYJ58GY0Ert4NgIxecJuuokIeMNJ3Kxw5p68SMvUMbAl
	 /KXjoqDgwXvTZGyTZkUteQ41UX4bOd0J4ohSQXvxGe/DU0SLm6C1rZI1x8cgf3uw6s
	 +1a9BGRFOntxQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Florian Weimer
 <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Yury Norov
 <yury.norov@gmail.com>, bpf <bpf@vger.kernel.org>,
 sched-ext@lists.linux.dev, Kernel Team <kernel-team@meta.com>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Puranjay Mohan <puranjay@kernel.org>,
 Tejun Heo <tj@kernel.org>
Subject: Re: [patch V5 00/20] sched: Rewrite MM CID management
In-Reply-To: <6a77996f-5b08-4db6-8631-031ce3e52145@linux.dev>
References: <20251119171016.815482037@linutronix.de>
 <2b7463d7-0f58-4e34-9775-6e2115cfb971@linux.dev> <877bt29cgv.ffs@tglx>
 <bdfea828-4585-40e8-8835-247c6a8a76b0@linux.ibm.com> <87y0lh96xo.ffs@tglx>
 <87jyx1ml3h.ffs@tglx> <70335ad4-59b6-45fd-8a76-bd91d9658810@linux.dev>
 <6a77996f-5b08-4db6-8631-031ce3e52145@linux.dev>
Date: Thu, 29 Jan 2026 18:06:15 +0100
Message-ID: <87h5s4mjqw.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 28 2026 at 15:08, Ihor Solodrai wrote:
> On 1/28/26 2:33 PM, Ihor Solodrai wrote:
>> [...]
>> 
>> We have a steady stream of jobs running, so if it's not a one-off it's
>> likely to happen again. I'll share if we get anything.
>
> Here is another one, with backtraces of other CPUs:
>
> [   59.133925] CPU: 2 UID: 0 PID: 127 Comm: test_progs Tainted: G           OE       6.19.0-rc5-gbe9790cb9e63-dirty #1 PREEMPT(full)
> [   59.133935] RIP: 0010:queued_spin_lock_slowpath+0x3a9/0xac0
> [   59.133985]  do_raw_spin_lock+0x1d9/0x270
> [   59.134001]  task_rq_lock+0xcf/0x3c0
> [   59.134007]  mm_cid_fixup_task_to_cpu+0xb0/0x460
> [   59.134025]  sched_mm_cid_fork+0x6da/0xc20

Compared to Shrikanth's splat this is the reverse situation, i.e. fork()
reached the point where it needs to switch to per CPU mode and the fixup
function is stuck on a runqueue lock.

> [   59.134176] CPU: 3 UID: 0 PID: 67 Comm: kworker/3:1 Tainted: G           OE       6.19.0-rc5-gbe9790cb9e63-dirty #1 PREEMPT(full)
> [   59.134186] Workqueue: events drain_vmap_area_work
> [   59.134194] RIP: 0010:smp_call_function_many_cond+0x772/0xe60
> [   59.134250]  on_each_cpu_cond_mask+0x24/0x40
> [   59.134254]  flush_tlb_kernel_range+0x402/0x6b0

CPU3 is unrelated as it does not hold runqueue lock.

> [   59.134374] NMI backtrace for cpu 1
> [   59.134388] RIP: 0010:_find_first_zero_bit+0x50/0x90
> [   59.134423]  __schedule+0x3312/0x4390
> [   59.134430]  ? __pfx___schedule+0x10/0x10
> [   59.134434]  ? trace_rcu_watching+0x105/0x150
> [   59.134440]  schedule_idle+0x59/0x90

CPU1 holds runqueue lock and find_first_zero_bit() suggests that this
comes from mm_get_cid(), but w/o decoding the return address it's hard
to tell for sure.

> [   59.134474] NMI backtrace for cpu 0 skipped: idling at default_idle+0xf/0x20

CPU0 is idle and not involved at all.

So the situation is:

test_prog creates the 4th child, which exceeds the number of CPUs, so
it switches to per CPU mode.

At this point each task of test_prog has a CID associated. Let's
assume thread creation order assignment for simplicity.

   T0 (main thread)       CID0  runs fork()
   T1 (1st child)	  CID1
   T2 (2nd child)	  CID2
   T3 (3rd child)	  CID3
   T4 (4th child)         ---   is about to be forked and causes the
                                mode switch

T0 sets mm_cid::percpu = true
   transfers the CID from T0 to CPU2

   Starts the fixup which walks through the threads

During that T1 - T3 are free to schedule in and out before the fixup
caught up with them. Now I played through all possible permutations with
a python script and came up with the following snafu:

   T1 schedules in on CPU3 and observes percpu == true, so it transfers
      it's CID to CPU3

   T1 is migrated to CPU1 and schedule in observes percpu == true, but
      CPU1 does not have a CID associated and T1 transferred it's own to
      CPU3

      So it has to allocate one with CPU1 runqueue lock held, but the
      pool is empty, so it keeps looping.

Now T0 reaches T1 in the thread walk and tries to lock the corresponding
runqueue lock, which is held. ---> Livelock

So this side needs the same MM_CID_TRANSIT treatment as the other side,
which brings me back to the splat Shrikanth observed.

I used the same script to run through all possible permutations on that
side too, but nothing showed up there and the yesterday finding is
harmless because that only creates slightly inconsistent state as the
task is already marked CID inactive. But the CID has the MM_CID_TRANSIT
bit set, so the CID is dropped back into the pool when the exiting task
schedules out via preemption or the final schedule().

So I scratched my head some more and stared at the code with two things
in mind:

   1) It seems to be hard to reproduce
   2) It happened on a weakly ordered architecture

and indeed there is a opportunity to get this wrong:

The mode switch does:

    WRITE_ONCE(mm->mm_cid.transit, MM_CID_TRANSIT);
    WRITE_ONCE(mm->mm_cid.percpu, ....);
    
sched_in() does:

    if (!READ_ONCE(mm->mm_cid.percpu))
       ...
       cid |= READ_ONCE(mm->mm_cid.transit);

so it can observe percpu == false and transit == 0 even if the fixup
function has not yet completed. As a consequence the task will not drop
the CID when scheduling out before the fixup is completed, which means
the CID space can be exhausted and the next task scheduling in will loop
in mm_get_cid() and the fixup thread can livelock on the held runqueue
lock as above.

I'll send out a series to address all of that later this evening when
tests have completed and changelogs are polished.

Thanks,

        tglx
