Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C4350D44;
	Wed, 28 Jan 2026 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605164; cv=none; b=UG++Y61k1Z7v2/v6/39+2QijzkSbexS6S/ikrozDbJ03L6zaeEVa21MnP4VjIZVTy+ZBSDXF0zZLjdS+w4wus/aQ+7c3fmOSpMexV3bp79DW+8p/VsO80Psl9StWmSaAofWKNJ0ml9O/909uIAwNqnzih1UMLWIJ6SwLhj5dN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605164; c=relaxed/simple;
	bh=Cg2HYnETzh1iDd9/Q6DpiwfP5gVe39kO+1rIn3/8HuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8GMvjKs0V3h+b3HcT79QajpQst44ny3/pR5hNoql1ZgNZNnBuH4x4rquElmpCoXxpofxsimuLL/GnbKRqvRYbizGvFGls9LB4JKOzw/4SNRQGKgMd05TsAqy6IhTPeTwTUuY59+HNikabcAFt2Fs/cIITzh2Rhz3aHxBDlFV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZVV8XBTj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZVV8XBTj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60S8JTLw015740;
	Wed, 28 Jan 2026 12:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ulXCHv
	ySv1fgDAg1+CAeePqRPrkV9A1mnE1QTLpexeA=; b=ZVV8XBTj/9wWDnqFSQ/ram
	cTk4K1wurBRx6ybq28d2x3sskD3wvwj9l2/Zj2uqV2QLPJUt+TQcZoayHec+jzjd
	3pypX+aRwxzzySrYOnRRpaaFR1rUwbHo4faeORhsg1zpxU0tlIOTNcTasqnn7hCv
	oxOI59qtcEh5boQIPCLSVf22SDqZ61rbnzuXfIjNDbPUMAwJe5eDrMBr0SMFKcwY
	RE/YrPaqvIuhRDzENfCTNSn7fo9udkIqs8BxoRk2/qlXaOLCbL3to7TqLtPokamb
	eEnuhMG1bDTsQBGoWmnnXbtKpmECeilDsmBGvDtV826e9lxiakJm6pAPwSCQ6rLQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmsa91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 12:58:34 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60SCwXWv002560;
	Wed, 28 Jan 2026 12:58:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmsa8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 12:58:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60SBMQM9006711;
	Wed, 28 Jan 2026 12:58:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sydfsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 12:58:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60SCwVOe40239610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 12:58:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00F1420043;
	Wed, 28 Jan 2026 12:58:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBE2D2004B;
	Wed, 28 Jan 2026 12:58:24 +0000 (GMT)
Received: from [9.87.144.4] (unknown [9.87.144.4])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Jan 2026 12:58:24 +0000 (GMT)
Message-ID: <bdfea828-4585-40e8-8835-247c6a8a76b0@linux.ibm.com>
Date: Wed, 28 Jan 2026 18:28:23 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V5 00/20] sched: Rewrite MM CID management
To: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
        Yury Norov <yury.norov@gmail.com>, bpf <bpf@vger.kernel.org>,
        sched-ext@lists.linux.dev, Kernel Team <kernel-team@meta.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Puranjay Mohan
 <puranjay@kernel.org>, Tejun Heo <tj@kernel.org>
References: <20251119171016.815482037@linutronix.de>
 <2b7463d7-0f58-4e34-9775-6e2115cfb971@linux.dev> <877bt29cgv.ffs@tglx>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <877bt29cgv.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=697a07fa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=5AEkyd_M30QB2NY0R_IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dblyhcgNSNe2-rim6YI8Ary4NhCkUdvK
X-Proofpoint-ORIG-GUID: GoY9ZqloEf9sSqqLQgleOc5jB3HuYKhu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEwNSBTYWx0ZWRfXxLIyPnq6oJ3h
 8mn7M4w8wBamqRy6Zy27Yo/LN4wlT2O5Sj8Jvq4tkj24zegLEzaCzLVVi++iCrq/kqkt08xhLyk
 JEYgscOP8CGi7iV7KhBKNxI36XZYAJXyft/3oEbpmuMO+Jye+TXsx24Y2ZsGRL5mzt+7ADMR9M8
 Mb2K0mvSa2YiQpJMf5xNQedoFJ9gGMiK+6QKyP0VK4gnYMHzPGsTfSSsoaYnKLQ2Dk2BM+wsKOD
 uMjP/UhQVGsyLYzNokRaYWrEI/lXMEPY8zA+auwyp7jEj0Zw/xl/no47oO/6kMQ22A1GTDgjCxD
 or+TUiNfqQaS0t5gQZzri3IHZ4XZDjqMwT0rhknBNg21FqAiwOLlXA1sC+c5L31L/Qpo+FX88uq
 h4uCOMnVZFsJ7NEi+si37GQrx+wAzD4by4em1XG7hRpBNWftTAAp8qzU47PnTX8U3spJtY6cEeH
 Sqwhd6uheiaqg5EfFjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601280105



On 1/28/26 5:27 PM, Thomas Gleixner wrote:
> On Tue, Jan 27 2026 at 16:01, Ihor Solodrai wrote:
>> BPF CI caught a deadlock on current bpf-next tip (35538dba51b4).
>> Job: https://github.com/kernel-patches/bpf/actions/runs/21417415035/job/61670254640
>>
>> It appears to be related to this series. Pasting a splat below.
> 
> The deadlock splat is completely unrelated as it is a consequence of the
> panic which is triggered by the watchdog:
> 
>> [   45.009755] watchdog: CPU2: Watchdog detected hard LOCKUP on cpu 2
> 
> ...
> 
>> [   46.053170]   lock(&nmi_desc[NMI_LOCAL].lock);
>> [   46.053172]   <Interrupt>
>> [   46.053173]     lock(&nmi_desc[NMI_LOCAL].lock);
> 
> ...
> 
>> Any ideas what might be going on?
> 
> Without a full backtrace of all CPUs it's hard to tell because it's
> unclear what is holding the runqueue lock of CPU2 long enough to trigger
> the hard lockup watchdog.
> 
> I'm pretty sure the CID changes are unrelated, that new code just happen
> to show up as the messenger which gets stuck on the lock forever.
> 
>> [   46.053209] CPU: 2 UID: 0 PID: 126 Comm: test_progs Tainted: G           OE       6.19.0-rc5-g748c6d52700a-dirty #1 PREEMPT(full)
>> [   46.053214] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>> [   46.053215] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [   46.053217] Call Trace:
>> [   46.053220]  <NMI>
>> [   46.053223]  dump_stack_lvl+0x5d/0x80
>> [   46.053227]  print_usage_bug.part.0+0x22b/0x2c0
>> [   46.053231]  lock_acquire+0x272/0x2b0
>> [   46.053235]  ? __register_nmi_handler+0x83/0x350
>> [   46.053240]  _raw_spin_lock_irqsave+0x39/0x60
>> [   46.053242]  ? __register_nmi_handler+0x83/0x350
>> [   46.053246]  __register_nmi_handler+0x83/0x350
>> [   46.053250]  native_stop_other_cpus+0x31c/0x460
>> [   46.053255]  ? __pfx_native_stop_other_cpus+0x10/0x10
>> [   46.053260]  vpanic+0x1c5/0x3f0
> 
> vpanic() really should disable lockdep here before taking that lock in
> NMI context. The resulting lockdep splat is not really useful.
> 
> Thanks.
> 
>          tglx

Hi Thomas, Peter.


I remember running into this panic, once. But it wasn't consistent and i
couldn't hit it again. And it had vcpu overcommit, and fair bit of steal time.


The trace was like below from different CPUs.
------------------------

  watchdog: CPU 23 self-detected hard LOCKUP @ mm_get_cid+0xe8/0x188
  watchdog: CPU 23 TB:1434903268401795, last heartbeat TB:1434897252302837 (11750ms ago)
  NIP [c0000000001b7134] mm_get_cid+0xe8/0x188
  LR [c0000000001b7154] mm_get_cid+0x108/0x188
  Call Trace:
  [c000000004c37db0] [c000000001145d84] cpuidle_enter_state+0xf8/0x6a4 (unreliable)
  [c000000004c37e00] [c0000000001b95ac] mm_cid_switch_to+0x3c4/0x52c
  [c000000004c37e60] [c000000001147264] __schedule+0x47c/0x700
  [c000000004c37ee0] [c000000001147a70] schedule_idle+0x3c/0x64
  [c000000004c37f10] [c0000000001f6d70] do_idle+0x160/0x1b0
  [c000000004c37f60] [c0000000001f7084] cpu_startup_entry+0x48/0x50
  [c000000004c37f90] [c00000000005f570] start_secondary+0x284/0x288
  [c000000004c37fe0] [c00000000000e158] start_secondary_prolog+0x10/0x14


  watchdog: CPU 11 self-detected hard LOCKUP @ plpar_hcall_norets_notrace+0x18/0x2c
  watchdog: CPU 11 TB:1434903340004919, last heartbeat TB:1434897249749892 (11895ms ago)
  NIP [c0000000000f84fc] plpar_hcall_norets_notrace+0x18/0x2c
  LR [c000000001152588] queued_spin_lock_slowpath+0xd88/0x15d0
  Call Trace:
  [c00000056b69fb10] [c00000056b69fba0] 0xc00000056b69fba0 (unreliable)
  [c00000056b69fc30] [c000000001153ce0] _raw_spin_lock+0x80/0xa0
  [c00000056b69fc50] [c0000000001b9a34] raw_spin_rq_lock_nested+0x3c/0xf8
  [c00000056b69fc80] [c0000000001b9bb8] mm_cid_fixup_cpus_to_tasks+0xc8/0x28c
  [c00000056b69fd00] [c0000000001bff34] sched_mm_cid_exit+0x108/0x22c
  [c00000056b69fd40] [c000000000167b08] do_exit+0xf4/0x5d0
  [c00000056b69fdf0] [c00000000016800c] make_task_dead+0x0/0x178
  [c00000056b69fe10] [c0000000000316c8] system_call_exception+0x128/0x390
  [c00000056b69fe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec


  watchdog: CPU 65 self-detected hard LOCKUP @ queued_spin_lock_slowpath+0x10ec/0x15d0
  watchdog: CPU 65 TB:1434905824977447, last heartbeat TB:1434899309522065 (12725ms ago)
  NIP [c0000000011528ec] queued_spin_lock_slowpath+0x10ec/0x15d0
  LR [c000000001152d0c] queued_spin_lock_slowpath+0x150c/0x15d0
  Call Trace:
  [c000000777e27a60] [0000000000000009] 0x9 (unreliable)
  [c000000777e27b80] [c000000001153ce0] _raw_spin_lock+0x80/0xa0
  [c000000777e27ba0] [c0000000001b9a34] raw_spin_rq_lock_nested+0x3c/0xf8
  [c000000777e27bd0] [c0000000001babb8] ___task_rq_lock+0x64/0x140
  [c000000777e27c20] [c0000000001c8294] wake_up_new_task+0x180/0x484
  [c000000777e27ca0] [c00000000015bea4] kernel_clone+0x120/0x5bc
  [c000000777e27d30] [c00000000015c4c0] __do_sys_clone+0x88/0xc8
  [c000000777e27e10] [c0000000000316c8] system_call_exception+0x128/0x390
  [c000000777e27e50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec




I am wondering if it this loop in mm_get_cid, which may not be getting a cid
for a long time? Is that possible?

static inline unsigned int mm_get_cid(struct mm_struct *mm)
{
         unsigned int cid = __mm_get_cid(mm, READ_ONCE(mm->mm_cid.max_cids));

         while (cid == MM_CID_UNSET) {
                 cpu_relax();
                 cid = __mm_get_cid(mm, num_possible_cpus());
         }
         return cid;
}

