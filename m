Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD2A37E5DD;
	Fri,  7 Aug 2026 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120187; cv=none; b=bGI/0RrmHSW5acuY7LvqFEL7MOtrZZMnhRC/NKrEvhE9XIs8dxj1nE4HQ/V/wTqvMdX4qPmtUm2r5aV/rXeL2aOCcfa8dM61XYpAd4FwmH3vcoLlhwkm6oswTw9ZGTL8s2JKIUal0tbmonxN6zpDtWunwXmWGStrHUy7L4LLa3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120187; c=relaxed/simple;
	bh=SlI/gSaFFrXCl/9rloncqRxakJUO6vHni85fWRDt+WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVB9ntNPeSUzkHC0IT89xFhx550aJsc86HkllGlrKdR5ZYNGeo9u+aQDgJwUWnkBS7lo1qBYoczfelcuZxvXzsKcHnkYpCK42s6DJ0vYqvTkYgX+E+1jSz2w8cjVRA7d1ImzhaOWDVnk6DXpwYPRqDbH7zhDpJk6Jf5fs+3RXUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=v8k0yg/S; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="v8k0yg/S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zhBDyENIGSwZtQI1mO040SeQxcBm4D5J8P9tXaVMOZ8=; b=v8k0yg/S9xgrZnqDl1XJV9HBGK
	Z7aGiqoART4XAKAqdjg1PC9v+rTvg+Yr2n3k3NPl/7WbiiHrTJvgRobQdJX2m7WKgJRzlYQ/cg4XO
	oAX673RWxfA+LdthIaZ1HRNYHhSQAfsBa2M+AhVsjD3rk/fK1PWmJIU9dkkux/CmH21OdOjSqivGt
	aIT03iIwFH9iZt1Pq+cF1OL6zBzNYGUxPCWMA3RIDK+1I0kPXog3yqfgnALIUwZdu48k6wdcnmL6t
	WhGSlH/65DJ3QyZVOwf0bAv90OjbFoveKx9ZCMN6BTDbOmYT7eEY5gDKOOV6N824FtTeJnc7YFVpP
	PLXsBIcg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wsNRd-000YhX-27;
	Fri, 07 Aug 2026 16:29:17 +0000
Date: Fri, 7 Aug 2026 09:29:12 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com, 
	Vladimir Murzin <vladimir.murzin@arm.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
Message-ID: <anYHjvJ1_4dDjuzw@gmail.com>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3>
 <anXqMsJ14r3BAbMG@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anXqMsJ14r3BAbMG@gmail.com>
X-Debian-User: leitao

On Fri, Aug 07, 2026 at 07:58:21AM -0700, Breno Leitao wrote:
> Meanwhile, I will try to ftrace the writes to PMR and regs->pmr to get
> a better grasp of the states machine we are in (probably on Monday).

It seems LLM found a very easy to reproduce this:

	bash-5.1# dmesg

	bash-5.1#  cd /sys/kernel/tracing
	echo 'r:pmr vfs_read bad=+0($retval):u64' >> kprobe_events
	echo 1 > events/kprobes/pmr/enable

	bash-5.1# dmesg
	[   54.997498] ------------[ cut here ]------------
	[   54.997506] WARNING: ./arch/arm64/include/asm/irqflags.h:63 at arm64_exit_to_kernel_mode+0xc0/0xc8, CPU#1: bash/185
	[   54.997530] Modules linked in:
	[   54.997535] CPU: 1 UID: 0 PID: 185 Comm: bash Not tainted 7.2.0-rc6-next-20260806upstream #15 PREEMPT(full)
	[   54.997538] Hardware name: linux,dummy-virt (DT)
	[   54.997540] pstate: 234003c5 (nzCv DAIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
	[   54.997542] pc : arm64_exit_to_kernel_mode+0xc0/0xc8
	[   54.997544] lr : el1_abort+0x5c/0x80
	[   54.997547] sp : ffff800088ba35f0
	[   54.997548] pmr: 000000f0
	[   54.997550] x29: ffff800088ba35f0 x28: ffff0000c3cd0000 x27: 0000000000000000
	[   54.997554] x26: ffff0000c3f277d0 x25: 0000000000000030 x24: 0000000000000001
	[   54.997557] x23: 00000000834003c5 x22: 0000000000000000 x21: 0000000000000001
	[   54.997566] x20: ffff800088ba3650 x19: 0000000000000000 x18: 0000000000000000
	[   54.997569] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
	[   54.997572] x14: 0000000040000000 x13: ffff800086b171f8 x12: fff080007fe00000
	[   54.997576] x11: 0000000000000001 x10: aaaaaaaaaaaaaaab x9 : 000000000000001f
	[   54.997579] x8 : 00000000000000d0 x7 : 0000000000000000 x6 : ffff0000c0adf02c
	[   54.997582] x5 : ffff0000c0adf034 x4 : ffff800081408b08 x3 : 000000000000000c
	[   54.997585] x2 : 00000000000002fe x1 : 0000000000000000 x0 : ffff800088ba3650
	[   54.997589] Call trace:
	[   54.997590]  arm64_exit_to_kernel_mode+0xc0/0xc8 (P)
	[   54.997593]  el1_abort+0x5c/0x80
	[   54.997595]  el1h_64_sync_handler+0x50/0x100
	[   54.997597]  el1h_64_sync+0x80/0x88
	[   54.997601]  __arch_copy_from_user+0x220/0x240 (P)
	[   54.997604]  process_fetch_insn+0x450/0x8b0
	[   54.997608]  kretprobe_trace_func+0x1b0/0x298
	[   54.997611]  kretprobe_dispatcher+0x5c/0x88
	[   54.997613]  __kretprobe_trampoline_handler+0xc4/0x168
	[   54.997617]  kretprobe_brk_handler+0x40/0x68
	[   54.997620]  call_el1_break_hook+0x74/0xa0
	[   54.997623]  do_el1_brk64+0x30/0x60
	[   54.997624]  el1_brk64+0x2c/0x48
	[   54.997626]  el1h_64_sync_handler+0x80/0x100
	[   54.997628]  el1h_64_sync+0x80/0x88
	[   54.997630]  ksys_read+0x80/0x100 (P)
	[   54.997634]  __arm64_sys_read+0x28/0x40
	[   54.997636]  invoke_syscall+0x54/0xf0
	[   54.997640]  do_el0_svc+0x7c/0xb8
	[   54.997642]  el0_svc+0x60/0x188
	[   54.997644]  el0t_64_sync_handler+0x84/0x130
	[   54.997645]  el0t_64_sync+0x1ac/0x1b0
	[   54.997647] ---[ end trace 0000000000000000 ]---

