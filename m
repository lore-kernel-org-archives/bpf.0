Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAE23FC41
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775312018; cv=none; b=OXjFU1V1yE3yzJZjl51fmNGBYf8XUTJt/4vg2KRhs8PvNjaRiaG8h5GaETFwv/pZGh7f8WK/4HaKqgqSAHinRmNgYTrlTkZTK9ww1SbfZcfxWF47cLpHhrhC52rHZ9F/0YrTjX2eoJyl8kjH8fM/g87DN+Lpt6N0B9KPc7FvYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775312018; c=relaxed/simple;
	bh=beSBLp4pVzm9zV/gEQeoS8Q+yJUqGNehKph2ZlDY3Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDMkJjI6lf+aHrT71PBUd4K3pg2+5/gK87r/Qge0UsWVyo4ahEh+M5pvY9xaxpS2NH+ujhs2LewZJ9DJ5/io8Q6J6aB9VJUQzap/mv96f8nQ/CHtrguG+5lAOpncDAfwOEZT6qDgmOakhkkyQ8sEMG0frxpkaYgBi6sr/Nk9oR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ajl+zU43; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ajl+zU43"
Message-ID: <e1cbc3c0-4c76-4f6d-ac60-a4ccd42e9b72@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775312012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IewsDWwDxBpfscxn3XxWXadYMIZcx1APl5V9Ksqc32Y=;
	b=Ajl+zU43tKA6FmObOQghHTeh+92/XP1GA+BHg0RbP/qPoPfht+obMh5BhSaO9GK3cb/ixy
	QKFAs92NyjRS0WaYDvFOC+sIzd4c9Ev2TlKVQg4gnnTHwDb7pBjrFhQ58Zz4+Q0+HoBnzR
	1n92OzX8yvR7zxD1xa5n9bx9makHasQ=
Date: Sat, 4 Apr 2026 22:13:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BPF sock_ops macro expansion flaw leads to out-of-bounds read
To: Quan Sun <2022090917019@std.uestc.edu.cn>, daniel@iogearbox.net,
 bpf@vger.kernel.org
Cc: M202472210@hust.edu.cn, dddddd@hust.edu.cn, dzm91@hust.edu.cn,
 hust-os-kernel-patches@googlegroups.com
References: <6fe1243e-149b-4d3b-99c7-fcc9e2f75787@std.uestc.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <6fe1243e-149b-4d3b-99c7-fcc9e2f75787@std.uestc.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/4/26 8:07 PM, Quan Sun wrote:
> Our fuzzer tool discovered an out-of-bounds read vulnerability in the 
> Linux kernel's BPF subsystem related to `sock_ops`. The vulnerability 
> is caused by a flawed eBPF macro expansion in `net/core/filter.c`, 
> specifically targeting `SOCK_OPS_GET_SK()`, which fails to handle the 
> instruction properly when the destination register matches the source 
> register (`dst_reg == src_reg`).
>
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> ## Root Cause
>
> This vulnerability occurs in BPF programs of type `sock_ops` and 
> represents a logic flaw between BPF verifier static analysis and the 
> eBPF macro expansion.
>
> When reading the `sk` field of the context in eBPF assembly, if the 
> source and destination registers are the same (e.g., `r1 = *(u64 *)(r1 
> + offsetof(sk))`), the `SOCK_OPS_GET_SK()` macro in 
> `net/core/filter.c` is defective:
>
> 1. To safely handle potentially `NULL` or incomplete sockets at 
> runtime (like `request_sock` in the `TCP_NEW_SYN_RECV` state where 
> `is_fullsock == 0`), this macro generates a sequence of BPF instructions.
> 2. In normal cases where `dst_reg != src_reg`, the macro safely 
> evaluates `is_fullsock` directly into `dst_reg`. If `is_fullsock == 
> 0`, it branches out, implicitly leaving `dst_reg` as `0` (NULL).
> 3. However, when `dst_reg == src_reg`, the macro must save/restore a 
> temporary register (`BPF_REG_9`) to evaluate `is_fullsock`. It checks 
> if `is_fullsock == 0` and, if so, branches to the end to skip the `sk` 
> memory load.
> 4. Crucially, during this branch bypass, the macro completely fails to 
> clear the destination register (`dst_reg`). Instead of setting 
> `dst_reg = 0`, it leaves `dst_reg` unmodified.
>
> **As a result:**
> At runtime, when there is no valid full socket (`is_fullsock == 0`), 
> the register `R1` (`dst_reg`) continues to hold the original pointer 
> to the small context object `ctx` (a `struct bpf_sock_ops_kern` 
> allocated on the kernel stack).
>
> However, the BPF verifier static analysis assumes this read operation 
> correctly returns a `PTR_TO_SOCKET_OR_NULL`. Since `R1` retains a 
> non-zero stack address, it can bypass any subsequent `NULL` checks 
> required by the verifier (e.g., `if (r1 == 0)`).
>
> Subsequently, when this forged socket pointer (which actually points 
> to the `ctx` stack object) is passed to a legitimate BPF helper (such 
> as `bpf_skc_to_tcp6_sock()`), the kernel accesses fields using the 
> large `struct sock` offset layout. This drastically exceeds the bounds 
> of the small `ctx` structure on the stack, immediately triggering a 
> `KASAN: stack-out-of-bounds` kernel panic.
>
> ## Reproduction Steps
>
> 1. **Cgroup Setup**: Open a file descriptor to a cgroup hierarchy.
> 2. **BPF Program**: Load a `BPF_PROG_TYPE_SOCK_OPS` program. 
> Specifically, include an instruction to load `ctx->sk` where `dst_reg 
> = BPF_REG_1` and `src_reg = BPF_REG_1`, and then invoke the helper 
> `BPF_FUNC_skc_to_tcp6_sock`.
> 3. **Attach**: Attach the BPF program to the cgroup with 
> `BPF_CGROUP_SOCK_OPS`.
> 4. **Trigger**: Trigger a TCP state change (e.g., `TCP_NEW_SYN_RECV`) 
> by creating a socket, binding to localhost, listening, and connecting 
> to it. The execution of the program will cause the kernel to crash.
>
> ## KASAN Report
>
> ```text
> [   80.555285][    C0] 
> ==================================================================
> [   80.556255][    C0] BUG: KASAN: stack-out-of-bounds in 
> bpf_skc_to_tcp6_sock+0x15a/0x160
> [   80.557236][    C0] Read of size 2 at addr ffa000000000784c by task 
> poc/9850
> [   80.558093][    C0]
> [   80.558386][    C0] CPU: 0 UID: 0 PID: 9850 Comm: poc Not tainted 
> 7.0.0-rc5-g6f6c794d0ff0 #5 PREEMPT(ful
> [   80.558404][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 
> 1996), BIOS 1.15.0-1 04/01/2014
> [   80.558413][    C0] Call Trace:
> [   80.558418][    C0]  <IRQ>
> [   80.558424][    C0]  dump_stack_lvl+0x116/0x1b0
> [   80.558455][    C0]  print_report+0xca/0x5f0
> [   80.558485][    C0]  ? __virt_addr_valid+0x87/0x610
> [   80.558510][    C0]  ? bpf_skc_to_tcp6_sock+0x15a/0x160
> [   80.558523][    C0]  ? bpf_skc_to_tcp6_sock+0x15a/0x160
> [   80.558537][    C0]  kasan_report+0xca/0x100
> [   80.558567][    C0]  ? bpf_skc_to_tcp6_sock+0x15a/0x160
> [   80.558584][    C0]  bpf_skc_to_tcp6_sock+0x15a/0x160
> [   80.558599][    C0]  bpf_prog_fc4ad1a62862443c+0x3c/0x46
> [   80.558613][    C0] __cgroup_bpf_run_filter_sock_ops+0x2c3/0x990
> [   80.558639][    C0]  ? 
> __pfx___cgroup_bpf_run_filter_sock_ops+0x10/0x10
> [   80.558666][    C0]  tcp_openreq_init_rwin+0x67a/0x9a0
> [   80.558691][    C0]  ? __pfx_tcp_openreq_init_rwin+0x10/0x10
> [   80.558712][    C0]  ? lockdep_hardirqs_on+0x7c/0x110
> [   80.558742][    C0]  tcp_conn_request+0x12ae/0x2db0
> [   80.558767][    C0]  ? __pfx_tcp_conn_request+0x10/0x10
> [   80.558796][    C0]  ? tcp_v4_conn_request+0xcb/0x300
> [   80.558813][    C0]  tcp_v4_conn_request+0xcb/0x300
> [   80.558831][    C0]  tcp_rcv_state_process+0xb71/0x7140
> [   80.558852][    C0]  ? find_held_lock+0x2b/0x80
> [   80.558876][    C0]  ? __pfx_tcp_rcv_state_process+0x10/0x10
> [   80.558896][    C0]  ? sk_filter_trim_cap+0x12e/0xf50
> [   80.558919][    C0]  ? __pfx_tcp_inbound_hash+0x10/0x10
> [   80.558942][    C0]  ? __pfx_sk_filter_trim_cap+0x10/0x10
> [   80.558966][    C0]  ? tcp_v4_do_rcv+0x1ad/0xab0
> [   80.558984][    C0]  tcp_v4_do_rcv+0x1ad/0xab0
> [   80.559003][    C0]  tcp_v4_rcv+0x3abf/0x41f0
> [   80.559029][    C0]  ? __pfx_tcp_v4_rcv+0x10/0x10
> [   80.559050][    C0]  ? __pfx_raw_local_deliver+0x10/0x10
> [   80.559071][    C0]  ? __pfx_tcp_v4_rcv+0x10/0x10
> [   80.559090][    C0]  ip_protocol_deliver_rcu+0xbf/0x4d0
> [   80.559115][    C0]  ip_local_deliver_finish+0x3d3/0x720
> [   80.559136][    C0]  ? __pfx_ip_local_deliver+0x10/0x10
> [   80.559158][    C0]  ip_local_deliver+0x19f/0x200
> [   80.559178][    C0]  ? __pfx_ip_local_deliver+0x10/0x10
> [   80.559199][    C0]  ip_rcv+0x32c/0x3e0
> [   80.559219][    C0]  ? __pfx_ip_rcv+0x10/0x10
> [   80.559239][    C0]  __netif_receive_skb_one_core+0x19e/0x1f0
> [   80.559256][    C0]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
> [   80.559275][    C0]  ? process_backlog+0x335/0x1540
> [   80.559290][    C0]  ? process_backlog+0x335/0x1540
> [   80.559304][    C0]  __netif_receive_skb+0x22/0x160
> [   80.559318][    C0]  process_backlog+0x387/0x1540
> [   80.559335][    C0]  __napi_poll.constprop.0+0xb8/0x540
> [   80.559352][    C0]  net_rx_action+0x9b6/0xea0
> [   80.559371][    C0]  ? __pfx_net_rx_action+0x10/0x10
> [   80.559387][    C0]  ? kvm_sched_clock_read+0x16/0x30
> [   80.559408][    C0]  ? sched_clock+0x37/0x60
> [   80.559429][    C0]  ? sched_clock_cpu+0x6c/0x550
> [   80.559445][    C0]  ? __pfx_sched_clock_cpu+0x10/0x10
> [   80.559460][    C0]  ? __pfx_sched_clock_cpu+0x10/0x10
> [   80.559474][    C0]  ? __pfx_try_to_wake_up+0x10/0x10
> [   80.559502][    C0]  handle_softirqs+0x1d8/0x9b0
> [   80.559524][    C0]  ? __dev_queue_xmit+0x107a/0x43c0
> [   80.559538][    C0]  do_softirq+0xb1/0xe0
> [   80.559563][    C0]  </IRQ>
> [   80.559567][    C0]  <TASK>
> [   80.559572][    C0]  __local_bh_enable_ip+0x105/0x130
> [   80.559592][    C0]  ? __dev_queue_xmit+0x107a/0x43c0
> [   80.559605][    C0]  __dev_queue_xmit+0x108f/0x43c0
> [   80.559620][    C0]  ? __pfx_stack_trace_save+0x10/0x10
> [   80.559637][    C0]  ? check_path.constprop.0+0x24/0x50
> [   80.559661][    C0]  ? look_up_lock_class+0x56/0x130
> [   80.559684][    C0]  ? __pfx___dev_queue_xmit+0x10/0x10
> [   80.559701][    C0]  ? lockdep_unlock+0x5a/0xc0
> [   80.559722][    C0]  ? __lock_acquire+0x1387/0x2740
> [   80.559745][    C0]  ? __asan_memcpy+0x3d/0x60
> [   80.559764][    C0]  ? eth_header+0x122/0x200
> [   80.559786][    C0]  neigh_resolve_output+0x522/0x8f0
> [   80.559814][    C0]  ip_finish_output2+0x7c9/0x1f90
> [   80.559829][    C0]  ? ip_skb_dst_mtu+0x585/0xc60
> [   80.559853][    C0]  ? __pfx_ip_finish_output2+0x10/0x10
> [   80.559871][    C0]  __ip_finish_output+0x3b7/0x6c0
> [   80.559886][    C0]  ip_finish_output+0x3a/0x380
> [   80.559901][    C0]  ip_output+0x1e1/0x520
> [   80.559913][    C0]  ? __pfx_ip_output+0x10/0x10
> [   80.559927][    C0]  ip_local_out+0x1b9/0x200
> [   80.559941][    C0]  __ip_queue_xmit+0x87c/0x1e70
> [   80.559958][    C0]  ? __pfx_ip_queue_xmit+0x10/0x10
> [   80.559972][    C0]  __tcp_transmit_skb+0x32ac/0x4cd0
> [   80.559998][    C0]  ? __pfx___tcp_transmit_skb+0x10/0x10
> [   80.560019][    C0]  ? __cgroup_bpf_run_filter_sock_ops+0x38f/0x990
> [   80.560051][    C0]  tcp_connect+0x3a0c/0x5bc0
> [   80.560077][    C0]  ? tcp_fastopen_defer_connect+0xe0/0x470
> [   80.560092][    C0]  ? __pfx_tcp_connect+0x10/0x10
> [   80.560112][    C0]  ? __pfx_tcp_fastopen_defer_connect+0x10/0x10
> [   80.560133][    C0]  tcp_v4_connect+0x15ac/0x1b20
> [   80.560154][    C0]  ? __pfx_tcp_v4_connect+0x10/0x10
> [   80.560171][    C0]  ? __lock_acquire+0x47d/0x2740
> [   80.560189][    C0]  __inet_stream_connect+0x3c3/0x1000
> [   80.560211][    C0]  ? __pfx___inet_stream_connect+0x10/0x10
> [   80.560228][    C0]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [   80.560250][    C0]  ? __pfx_inet_stream_connect+0x10/0x10
> [   80.560267][    C0]  ? __local_bh_enable_ip+0xa9/0x130
> [   80.560290][    C0]  ? __pfx_inet_stream_connect+0x10/0x10
> [   80.560308][    C0]  inet_stream_connect+0x5c/0xb0
> [   80.560327][    C0]  __sys_connect_file+0x151/0x1b0
> [   80.560344][    C0]  __sys_connect+0x166/0x1a0
> [   80.560359][    C0]  ? __pfx___sys_connect+0x10/0x10
> [   80.560374][    C0]  ? fd_install+0x240/0x550
> [   80.560393][    C0]  ? __sys_socket+0xa4/0x260
> [   80.560418][    C0]  ? __pfx___sys_socket+0x10/0x10
> [   80.560442][    C0]  ? tomoyo_file_fcntl+0x71/0xc0
> [   80.560468][    C0]  __x64_sys_connect+0x77/0xc0
> [   80.560482][    C0]  ? lockdep_hardirqs_on+0x7c/0x110
> [   80.560506][    C0]  do_syscall_64+0x11b/0xf80
> [   80.560532][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   80.560553][    C0] RIP: 0033:0x7fddb2247770
> [   80.560566][    C0] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 
> 1f 84 00 00 00 00 00 0f 1f 44 00 00 4
> [   80.560583][    C0] RSP: 002b:00007fffcd9031c8 EFLAGS: 00000202 
> ORIG_RAX: 000000000000002a
> [   80.560599][    C0] RAX: ffffffffffffffda RBX: 00007fffcd913458 
> RCX: 00007fddb2247770
> [   80.560609][    C0] RDX: 0000000000000010 RSI: 00007fffcd9031d0 
> RDI: 0000000000000006
> [   80.560619][    C0] RBP: 00007fffcd913340 R08: 1999999999999999 
> R09: 0000000000000000
> [   80.560629][    C0] R10: 00007fddb2154a08 R11: 0000000000000202 
> R12: 0000000000000000
> [   80.560638][    C0] R13: 00007fffcd913468 R14: 000055ef6e4cadd8 
> R15: 00007fddb235e020
> [   80.560656][    C0]  </TASK>
> [   80.560661][    C0]
> [   80.638517][    C0] The buggy address belongs to a 0-page vmalloc 
> region starting at 0xffa0000000000000 0
> [   80.640154][    C0] The buggy address belongs to the physical page:
> [   80.640897][    C0] page: refcount:1 mapcount:0 
> mapping:0000000000000000 index:0x0 pfn:0x2b408
> [   80.642208][    C0] flags: 
> 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
> [   80.643133][    C0] raw: 00fff00000002000 ffd4000000ad0208 
> ffd4000000ad0208 0000000000000000
> [   80.644122][    C0] raw: 0000000000000000 0000000000000000 
> 00000001ffffffff 0000000000000000
> [   80.645106][    C0] page dumped because: kasan: bad access detected
> [   80.645961][    C0] page_owner info is not present (never set?)
> [   80.646663][    C0]
> [   80.646945][    C0] Memory state around the buggy address:
> [   80.647599][    C0]  ffa0000000007700: f3 f3 00 00 00 00 00 00 00 
> 00 00 00 00 00 00 00
> [   80.648526][    C0]  ffa0000000007780: 00 00 00 00 00 00 00 00 00 
> 00 00 00 00 00 00 00
> [   80.649532][    C0] >ffa0000000007800: 00 00 00 00 f1 f1 f1 f1 01 
> f2 04 f2 00 00 00 f2
> [   80.650661][ C0]                                               ^
> [   80.651521][    C0]  ffa0000000007880: f2 f2 f2 f2 00 00 00 f3 f3 
> f3 f3 f3 00 00 00 00
> [   80.652634][    C0]  ffa0000000007900: 00 00 00 00 00 00 00 00 00 
> 00 00 00 00 00 00 00
> [   80.653715][    C0] 
> ==================================================================
> [   80.654943][    C0] Kernel panic - not syncing: KASAN: 
> panic_on_warn set ...
> [   80.655901][    C0] CPU: 0 UID: 0 PID: 9850 Comm: poc Not tainted 
> 7.0.0-rc5-g6f6c794d0ff0 #5 PREEMPT(ful
> [   80.657244][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 
> 1996), BIOS 1.15.0-1 04/01/2014
> [   80.658462][    C0] Call Trace:
> [   80.658960][    C0]  <IRQ>
> [   80.659365][    C0]  dump_stack_lvl+0x3d/0x1b0
> [   80.660147][    C0]  vpanic+0x7f7/0xa80
> [   80.660775][    C0]  ? __pfx_vpanic+0x10/0x10
> [   80.661320][    C0]  ? irqentry_exit+0x1e9/0x740
> [   80.662072][    C0]  panic+0xc7/0xd0
> [   80.662520][    C0]  ? __pfx_panic+0x10/0x10
> [   80.663230][    C0]  ? bpf_skc_to_tcp6_sock+0x15a/0x160
> [   80.663879][    C0]  ? check_panic_on_warn+0x24/0xc0
> [   80.664515][    C0]  ? bpf_skc_to_tcp6_sock+0x15a/0x160
> [   80.665205][    C0]  check_panic_on_warn+0xb6/0xc0
> [   80.665809][    C0]  ? bpf_skc_to_tcp6_sock+0x15a/0x160
> [   80.666438][    C0]  end_report+0x142/0x190
> [   80.666972][    C0]  ? bpf_skc_to_tcp6_sock+0x15a/0x160
> [   80.667607][    C0]  kasan_report+0xd8/0x100
> [   80.668146][    C0]  ? bpf_skc_to_tcp6_sock+0x15a/0x160
> [   80.668788][    C0]  bpf_skc_to_tcp6_sock+0x15a/0x160
> [   80.669406][    C0]  bpf_prog_fc4ad1a62862443c+0x3c/0x46
> [   80.670057][    C0] __cgroup_bpf_run_filter_sock_ops+0x2c3/0x990
> [   80.670802][    C0]  ? 
> __pfx___cgroup_bpf_run_filter_sock_ops+0x10/0x10
> [   80.671605][    C0]  tcp_openreq_init_rwin+0x67a/0x9a0
> [   80.672244][    C0]  ? __pfx_tcp_openreq_init_rwin+0x10/0x10
> [   80.672940][    C0]  ? lockdep_hardirqs_on+0x7c/0x110
> [   80.673575][    C0]  tcp_conn_request+0x12ae/0x2db0
> [   80.674180][    C0]  ? __pfx_tcp_conn_request+0x10/0x10
> [   80.674831][    C0]  ? tcp_v4_conn_request+0xcb/0x300
> [   80.675445][    C0]  tcp_v4_conn_request+0xcb/0x300
> [   80.676048][    C0]  tcp_rcv_state_process+0xb71/0x7140
> [   80.676690][    C0]  ? find_held_lock+0x2b/0x80
> [   80.677256][    C0]  ? __pfx_tcp_rcv_state_process+0x10/0x10
> [   80.677948][    C0]  ? sk_filter_trim_cap+0x12e/0xf50
> [   80.678573][    C0]  ? __pfx_tcp_inbound_hash+0x10/0x10
> [   80.679212][    C0]  ? __pfx_sk_filter_trim_cap+0x10/0x10
> [   80.679877][    C0]  ? tcp_v4_do_rcv+0x1ad/0xab0
> [   80.680446][    C0]  tcp_v4_do_rcv+0x1ad/0xab0
> [   80.681002][    C0]  tcp_v4_rcv+0x3abf/0x41f0
> [   80.681557][    C0]  ? __pfx_tcp_v4_rcv+0x10/0x10
> [   80.682143][    C0]  ? __pfx_raw_local_deliver+0x10/0x10
> [   80.682794][    C0]  ? __pfx_tcp_v4_rcv+0x10/0x10
> [   80.683375][    C0]  ip_protocol_deliver_rcu+0xbf/0x4d0
> [   80.684018][    C0]  ip_local_deliver_finish+0x3d3/0x720
> [   80.684669][    C0]  ? __pfx_ip_local_deliver+0x10/0x10
> [   80.685307][    C0]  ip_local_deliver+0x19f/0x200
> [   80.685892][    C0]  ? __pfx_ip_local_deliver+0x10/0x10
> [   80.686531][    C0]  ip_rcv+0x32c/0x3e0
> [   80.687019][    C0]  ? __pfx_ip_rcv+0x10/0x10
> [   80.687568][    C0]  __netif_receive_skb_one_core+0x19e/0x1f0
> [   80.688264][    C0]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
> [   80.689020][    C0]  ? process_backlog+0x335/0x1540
> [   80.689619][    C0]  ? process_backlog+0x335/0x1540
> [   80.690213][    C0]  __netif_receive_skb+0x22/0x160
> [   80.690810][    C0]  process_backlog+0x387/0x1540
> [   80.691388][    C0]  __napi_poll.constprop.0+0xb8/0x540
> [   80.692026][    C0]  net_rx_action+0x9b6/0xea0
> [   80.692750][    C0]  ? __pfx_net_rx_action+0x10/0x10
> [   80.693609][    C0]  ? kvm_sched_clock_read+0x16/0x30
> [   80.694480][    C0]  ? sched_clock+0x37/0x60
> [   80.695245][    C0]  ? sched_clock_cpu+0x6c/0x550
> [   80.696065][    C0]  ? __pfx_sched_clock_cpu+0x10/0x10
> [   80.696952][    C0]  ? __pfx_sched_clock_cpu+0x10/0x10
> [   80.697830][    C0]  ? __pfx_try_to_wake_up+0x10/0x10
> [   80.698722][    C0]  handle_softirqs+0x1d8/0x9b0
> [   80.699529][    C0]  ? __dev_queue_xmit+0x107a/0x43c0
> [   80.700403][    C0]  do_softirq+0xb1/0xe0
> [   80.701111][    C0]  </IRQ>
> [   80.701606][    C0]  <TASK>
> [   80.702111][    C0]  __local_bh_enable_ip+0x105/0x130
> [   80.702984][    C0]  ? __dev_queue_xmit+0x107a/0x43c0
> [   80.703838][    C0]  __dev_queue_xmit+0x108f/0x43c0
> [   80.704678][    C0]  ? __pfx_stack_trace_save+0x10/0x10
> [   80.705564][    C0]  ? check_path.constprop.0+0x24/0x50
> [   80.706453][    C0]  ? look_up_lock_class+0x56/0x130
> [   80.707327][    C0]  ? __pfx___dev_queue_xmit+0x10/0x10
> [   80.708223][    C0]  ? lockdep_unlock+0x5a/0xc0
> [   80.709014][    C0]  ? __lock_acquire+0x1387/0x2740
> [   80.709858][    C0]  ? __asan_memcpy+0x3d/0x60
> [   80.710626][    C0]  ? eth_header+0x122/0x200
> [   80.711382][    C0]  neigh_resolve_output+0x522/0x8f0
> [   80.712259][    C0]  ip_finish_output2+0x7c9/0x1f90
> [   80.712896][    C0]  ? ip_skb_dst_mtu+0x585/0xc60
> [   80.713482][    C0]  ? __pfx_ip_finish_output2+0x10/0x10
> [   80.714131][    C0]  __ip_finish_output+0x3b7/0x6c0
> [   80.714736][    C0]  ip_finish_output+0x3a/0x380
> [   80.715312][    C0]  ip_output+0x1e1/0x520
> [   80.715818][    C0]  ? __pfx_ip_output+0x10/0x10
> [   80.716384][    C0]  ip_local_out+0x1b9/0x200
> [   80.716926][    C0]  __ip_queue_xmit+0x87c/0x1e70
> [   80.717499][    C0]  ? __pfx_ip_queue_xmit+0x10/0x10
> [   80.718107][    C0]  __tcp_transmit_skb+0x32ac/0x4cd0
> [   80.718738][    C0]  ? __pfx___tcp_transmit_skb+0x10/0x10
> [   80.719393][    C0]  ? __cgroup_bpf_run_filter_sock_ops+0x38f/0x990
> [   80.720164][    C0]  tcp_connect+0x3a0c/0x5bc0
> [   80.720727][    C0]  ? tcp_fastopen_defer_connect+0xe0/0x470
> [   80.721409][    C0]  ? __pfx_tcp_connect+0x10/0x10
> [   80.722003][    C0]  ? __pfx_tcp_fastopen_defer_connect+0x10/0x10
> [   80.722743][    C0]  tcp_v4_connect+0x15ac/0x1b20
> [   80.723324][    C0]  ? __pfx_tcp_v4_connect+0x10/0x10
> [   80.723941][    C0]  ? __lock_acquire+0x47d/0x2740
> [   80.724528][    C0]  __inet_stream_connect+0x3c3/0x1000
> [   80.725173][    C0]  ? __pfx___inet_stream_connect+0x10/0x10
> [   80.725867][    C0]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [   80.726504][    C0]  ? __pfx_inet_stream_connect+0x10/0x10
> [   80.727169][    C0]  ? __local_bh_enable_ip+0xa9/0x130
> [   80.727803][    C0]  ? __pfx_inet_stream_connect+0x10/0x10
> [   80.728462][    C0]  inet_stream_connect+0x5c/0xb0
> [   80.729053][    C0]  __sys_connect_file+0x151/0x1b0
> [   80.729656][    C0]  __sys_connect+0x166/0x1a0
> [   80.730208][    C0]  ? __pfx___sys_connect+0x10/0x10
> [   80.730824][    C0]  ? fd_install+0x240/0x550
> [   80.731368][    C0]  ? __sys_socket+0xa4/0x260
> [   80.731929][    C0]  ? __pfx___sys_socket+0x10/0x10
> [   80.732532][    C0]  ? tomoyo_file_fcntl+0x71/0xc0
> [   80.733142][    C0]  __x64_sys_connect+0x77/0xc0
> [   80.733717][    C0]  ? lockdep_hardirqs_on+0x7c/0x110
> [   80.734340][    C0]  do_syscall_64+0x11b/0xf80
> [   80.734902][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   80.735612][    C0] RIP: 0033:0x7fddb2247770
> [   80.736145][    C0] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 
> 1f 84 00 00 00 00 00 0f 1f 44 00 00 4
> [   80.738369][    C0] RSP: 002b:00007fffcd9031c8 EFLAGS: 00000202 
> ORIG_RAX: 000000000000002a
> [   80.739351][    C0] RAX: ffffffffffffffda RBX: 00007fffcd913458 
> RCX: 00007fddb2247770
> [   80.740277][    C0] RDX: 0000000000000010 RSI: 00007fffcd9031d0 
> RDI: 0000000000000006
> [   80.741203][    C0] RBP: 00007fffcd913340 R08: 1999999999999999 
> R09: 0000000000000000
> [   80.742132][    C0] R10: 00007fddb2154a08 R11: 0000000000000202 
> R12: 0000000000000000
> [   80.743373][    C0] R13: 00007fffcd913468 R14: 000055ef6e4cadd8 
> R15: 00007fddb235e020
> [   80.744741][    C0]  </TASK>
> [   80.745354][    C0] Kernel Offset: disabled
> [   80.746082][    C0] Rebooting in 86400 seconds..
> ```
>
>
Good catch !

https://lore.kernel.org/bpf/20260404141010.247536-1-jiayuan.chen@linux.dev/T/#t 

