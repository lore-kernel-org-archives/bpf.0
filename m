Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF026B77D;
	Wed, 28 Jan 2026 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639094; cv=none; b=QiqwgU1vdt54aXEgRkU4G/42hdb3BNP3Huyhm0yXMDUsaMN4JNh2zFjd7kLgDBzikgGKP3ZSbMCKd4LwpmNrfK5j13aHHbdN5lw3Umzz7Lf1UQYheX49sMkMWas09hW/ek//Y1fqA34GZ+Lqge3an3fJDsd3bx3CB3YuVq9Axv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639094; c=relaxed/simple;
	bh=c+XKRO+gGrMtBjuS12k/iR4p/hIlFt0mtK46g9rhORE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aJLQs8PBzuiUbCjWl/A04L37WXvaK0UpAke0f07yc6kAaIgkfL5ivL0m9bfsMDxD9GBW+JED68s6slrkchQ7WYstHI5CIWjQqgCPdIbBPhTg5II89mxSbAW6VrL8B9of9cp1LiHDTitgUzu6WEXOJwp22TRlj3Nk8f3jvqR6RfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYWcKiAE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYWcKiAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2B7C4CEF1;
	Wed, 28 Jan 2026 22:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769639094;
	bh=c+XKRO+gGrMtBjuS12k/iR4p/hIlFt0mtK46g9rhORE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NYWcKiAEqAzCy5o24EsuT6heJKvZ2Km8ANm9oXxLEbAl2fI1q5W7t0UCjvfgeaQs1
	 MD1aplzQ1k/2FOhshvcvRId/twTM0FigHwR0wm32bUr/u02YX1MsxSSDV/QvBRcqI6
	 1CVG+P7GqBJa9W+H64WhKXALS6nsdvVck3tmVY98C1Pg0kz3XhYeOfLmT3aQ5ybJW0
	 r/R4us3PDRp9u2u5a0Xe0chpbRzqjkd3mroFJFQ35PV9BTnWcJbOJc4cAIzUC9twxk
	 fJ0ez9gJE1FVFX+BDX4s6ZdP1LOROZqMo64zMLtnqoJo4W9GHCxztrDtBo0uaEc00m
	 19Md/ESAXKsPA==
From: Thomas Gleixner <tglx@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, LKML
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
In-Reply-To: <87y0lh96xo.ffs@tglx>
References: <20251119171016.815482037@linutronix.de>
 <2b7463d7-0f58-4e34-9775-6e2115cfb971@linux.dev> <877bt29cgv.ffs@tglx>
 <bdfea828-4585-40e8-8835-247c6a8a76b0@linux.ibm.com> <87y0lh96xo.ffs@tglx>
Date: Wed, 28 Jan 2026 23:24:50 +0100
Message-ID: <87jyx1ml3h.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 28 2026 at 14:56, Thomas Gleixner wrote:
> On Wed, Jan 28 2026 at 18:28, Shrikanth Hegde wrote:
>> On 1/28/26 5:27 PM, Thomas Gleixner wrote:
>>   watchdog: CPU 23 self-detected hard LOCKUP @ mm_get_cid+0xe8/0x188
>>   watchdog: CPU 23 TB:1434903268401795, last heartbeat TB:1434897252302837 (11750ms ago)
>>   NIP [c0000000001b7134] mm_get_cid+0xe8/0x188
>>   LR [c0000000001b7154] mm_get_cid+0x108/0x188
>>   Call Trace:
>>   [c000000004c37db0] [c000000001145d84] cpuidle_enter_state+0xf8/0x6a4 (unreliable)
>>   [c000000004c37e00] [c0000000001b95ac] mm_cid_switch_to+0x3c4/0x52c
>>   [c000000004c37e60] [c000000001147264] __schedule+0x47c/0x700
>
> So if the above spins in mm_get_cid() then the below is just a consequence.
>
>>   watchdog: CPU 11 self-detected hard LOCKUP @ plpar_hcall_norets_notrace+0x18/0x2c
>>   watchdog: CPU 11 TB:1434903340004919, last heartbeat TB:1434897249749892 (11895ms ago)
>>   NIP [c0000000000f84fc] plpar_hcall_norets_notrace+0x18/0x2c
>>   LR [c000000001152588] queued_spin_lock_slowpath+0xd88/0x15d0
>>   Call Trace:
>>   [c00000056b69fb10] [c00000056b69fba0] 0xc00000056b69fba0 (unreliable)
>>   [c00000056b69fc30] [c000000001153ce0] _raw_spin_lock+0x80/0xa0
>>   [c00000056b69fc50] [c0000000001b9a34] raw_spin_rq_lock_nested+0x3c/0xf8
>>   [c00000056b69fc80] [c0000000001b9bb8] mm_cid_fixup_cpus_to_tasks+0xc8/0x28c
>>   [c00000056b69fd00] [c0000000001bff34] sched_mm_cid_exit+0x108/0x22c
>>   [c00000056b69fd40] [c000000000167b08] do_exit+0xf4/0x5d0
>>   [c00000056b69fdf0] [c00000000016800c] make_task_dead+0x0/0x178
>>   [c00000056b69fe10] [c0000000000316c8] system_call_exception+0x128/0x390
>>   [c00000056b69fe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
>
>> I am wondering if it this loop in mm_get_cid, which may not be getting a cid
>> for a long time? Is that possible?
>
> It shouldn't be possible by design, but it seems there is a corner case
> lurking somewhere which hasn't been covered. Let me stare at the logic
> in the transition functions once more. That's where CPU11 comes from:
>
>>   [c00000056b69fc80] [c0000000001b9bb8] mm_cid_fixup_cpus_to_tasks+0xc8/0x28c
>
> The exiting it initiated a transition back from per CPU to per task mode
> and that seems to make things unhappy for mysterious reasons.

I stared at it for a while and found the below stupidity. But when I
actually sat down after a while away from the keyboard and tried to
write a concise changelog explaining the root cause I failed to come up
with a coherent explanation why this would prevent the above scenario,
which hints at a situation of MMCID exhaustion.

@Ihor: Is the BPF CI fallout reproducible? If so, can you please provide
       it?

Thanks,

        tglx
---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10664,8 +10664,14 @@ void sched_mm_cid_exit(struct task_struc
 			scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
 				if (!__sched_mm_cid_exit(t))
 					return;
-				/* Mode change required. Transfer currents CID */
-				mm_cid_transit_to_task(current, this_cpu_ptr(mm->mm_cid.pcpu));
+				/*
+				 * Mode change. The task has the CID unset
+				 * already. The CPU CID is still valid and
+				 * does not have MM_CID_TRANSIT set as the
+				 * mode change has just taken effect under
+				 * mm::mm_cid::lock. Drop it.
+				 */
+				mm_drop_cid_on_cpu(mm, this_cpu_ptr(mm->mm_cid.pcpu));
 			}
 			mm_cid_fixup_cpus_to_tasks(mm);
 			return;
