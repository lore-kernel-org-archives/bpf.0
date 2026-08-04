Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A34582D3
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855482; cv=none; b=VrxHHqFZIUZwMZjyeZa++XawipRU/lKQTkpwPJh0/Qm2mjtemzXnpiqZtlUiAfoZS3wEUVdg+fyIs5UjIcAd2f2PPGQPtOewMbJH+xSMBMKnLiBk7WITu+KLRTv7+1qb6iuQdaWuNL9OKQtTh0zrmAF4bH9YovkNm8fJ2lw2o/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855482; c=relaxed/simple;
	bh=frkuDRtp6arMXEOmgEH6UbiFX8WJhvmp9EC7tAvQxwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkLkzy7K3sO8fVUTy/+vMh2f8LAOXri4HBrFb6tWGKqw2kxEb2XOFYuYjJ6QW/O/v4H0+ztXqWT5IfsqNnj3paKrOTCaqMIYTUKkLVE57KIUkCMAa0ohWbtBo95JczlP6PfcGz2n/vB/oGNZJ6pnzug0L3mcQ/+nxlMcfqEw+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRw7Hhfu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRw7Hhfu"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso46116605ad.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785855475; x=1786460275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fVZFIC1oimN2aw6dhVNccAoxU8BTosqq7mvCJ9o8nF0=;
        b=nRw7HhfuY0c+GItRdUpSKuJx1nzKS2vFAdOHvoZGojcEb6CnxsSF+LdjZlcyJHshQe
         9N89vUdRDFndU1xT78Egr04wQB5mi6pZGOeDMhg1xmakB+8A1dtdMZbWzFMXqgeWyxL9
         2CYoYitBpNFlkQwlqpddLgGWzPGWl3wtLHVrilGtUrHgN/W/LZ8NkCyfoLkSFFqNuhVl
         zUpXapA+B64Pl/WxRSd01CMKJ/YV2hoARmZvBDaVKLMEXEXSJrvGas4MxqKWfRAYqUPy
         MzFX6/AnyWBr0wI5oJ/NaCtL073kMkkaiKE61M8CWvhcgEpak7ZqGKL6ZPC2rOCpaQmT
         z1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855475; x=1786460275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fVZFIC1oimN2aw6dhVNccAoxU8BTosqq7mvCJ9o8nF0=;
        b=Pf+bb3N/DW8KWuV/ZLfYxtNiCP/NObtmWxWDzWeTWA4+kiVry+5R5SYp4Izme0LmPt
         3wYJXtknz/W2sCr0FeqcCEuJdPo7SI1YVEjpwMiezYjob2vzvmPsBXVSVQm8f8AdJFFX
         WctlFUIaL6cQS3+58DsOM7JTIHYMu6aeDnf3imdbRnPPTbET/WLl4OXrxuP0IPGB7u7U
         Yflm+K6GcS63VeuPG3Wqhj0BBSW/8OnXx/L8olhpdtuca5VgUdd87NjeHbgplAM10Yhw
         gMe+XrfC7f8NjXfOH5MGVa+c87mtyupCwU2DICMvufaYOSG+0w/5T75rTYv6nogWzy8V
         Ar1A==
X-Forwarded-Encrypted: i=1; AHgh+RpMcZ0/252v1Hp02oK65yDKzrR35iZeVDBvNdeIV6/2xabpGc6DHT1CD3srVH01SS5QYhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKAqGhV5a2WTwq1iF9X5Mp4fKz9C+LZUHs37l5B2mvhbuc+9EJ
	kovUvQpY3n2n1Qhi1bPqMtDp+oEF2pZLCS99/kMLL8asCcU9VsmmDctA
X-Gm-Gg: AR+sD13rJDfxpNGsHLRvuWuSiFEta/DwVZ3X7H623SjOSFqkiZTePFdvlwJIgLTkIR0
	hBb52C6I1yBebMnI5yG0kuP1u3gg8oe9AxhbN6w/TfzO+ZvKYTt0I/baFuzmxT9yFYc/Zvf5wjT
	TOueCFVmx54twDV32mO6ZSpAwMVZqEVQSf+NUp5fsBGWUmOgJ0NyWNdDrWlcQHjAu05qVi8FAvh
	RVAHSyyvi1Tuo7LuIdnUtUeFYh987zdzHD/FBIj2udHzamuJCVejQcOr/0yLAjePjJVLA19bHfz
	CYGnxj0xK40T6dDyx0abJfhSULLhTIVuatILJiBesS7I3VvvmZWM5hzZGr4+z1sNOHL5M+izrZn
	0HRruAGChAWJRLZmajjevcfVvBGBC0GCXulGMG3Rz6mJ9x3AvalKEjrIkfNCFJX7BMIe/fh8LNT
	3TKW7vcXTlMgslKx++8lSctstYSenJ7+0PZiCOMsDfMAhjvjTGp45KAak=
X-Received: by 2002:a17:902:f611:b0:2ca:ddbd:a19b with SMTP id d9443c01a7336-2d0523bd401mr148438995ad.28.1785855474861;
        Tue, 04 Aug 2026 07:57:54 -0700 (PDT)
Received: from omen-arch ([211.58.239.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9fdd250sm9251435ad.21.2026.08.04.07.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 07:57:54 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>
Subject: [BUG?] bpf/tcx: bpf_clone_redirect() can sustain self-cloning transmit loops
Date: Tue,  4 Aug 2026 23:57:47 +0900
Message-ID: <20260804145747.354896-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We found that a TCX sched_cls BPF program using bpf_clone_redirect() can
repeatedly re-enter a virtual-device transmit path and trigger RCU stall
reports under sustained traffic.

bpf_clone_redirect() clones and redirects the skb from inside the helper,
before the current BPF program invocation returns. If the cloned skb
reaches a TCX hook that runs the same or another bpf_clone_redirect()
program, the datapath can re-enter itself repeatedly.

The BPF program can still return TCX_PASS. The recursion is caused by the
helper's immediate transmit side effect, not a TCX_REDIRECT return action.

We have separate reduced cases with ingress-only and ingress+egress TCX
attachments, but the common part is the helper-driven loopback transmit.

---
bpf_clone_redirect(skb, lo_ifindex, 0);
return TCX_PASS;
---

With flags == 0, bpf_clone_redirect() redirects the cloned skb to the
egress transmit path:

---
bpf_clone_redirect()
  skb_clone()
  bpf_try_make_head_writable(original skb)
  __bpf_redirect(clone, lo, 0)
    __bpf_tx_skb()
      dev_queue_xmit(clone)
        __dev_queue_xmit()
          rcu_read_lock_bh()
          sch_handle_egress()
            tcx_run()
              BPF program on lo
                bpf_clone_redirect(...)
          rcu_read_unlock_bh()
---

The included C reproducer is a standalone stress case for the same
loopback TCX/BPF shape. The exact reduced syzkaller cases use different
TCX attachment combinations; those can be provided separately if useful.

After sustained traffic, the system reported RCU stalls:

---
[  110.598444] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  110.598935] rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-0): P68/1:b..l
[  110.599529] rcu: 	(detected by 0, t=6502 jiffies, g=32705, q=438535 ncpus=1)
[  110.599977] task:kmemleak        state:R  running task     stack:0     pid:68    tgid:68    ppid:2      task_flags:0x208040 flags:0x00080000
[  110.600914] Call Trace:
[  110.601087]  <TASK>
[  110.601239]  __schedule+0xe19/0x3940
[  110.603902]  preempt_schedule_common+0x44/0xd0
[  110.604530]  preempt_schedule_thunk+0x16/0x40
[  110.604820]  _raw_spin_unlock_irq+0x44/0x50
[  110.605096]  kmemleak_scan+0x141/0x1070
[  110.605684]  kmemleak_scan_thread+0x6e/0xb9
[  110.606063]  kthread+0x384/0x4a0
[  110.606776]  ret_from_fork+0x3e0/0x870
[  110.608342]  ret_from_fork_asm+0x1a/0x30
[  110.608702]  </TASK>
[  110.609109] rcu: rcu_preempt kthread starved for 1984 jiffies! g32705 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
[  110.609980] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[  110.610545] rcu: RCU grace-period kthread stack dump:
[  110.610864] task:rcu_preempt     state:R  running task     stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00080000
[  110.612020] Call Trace:
[  110.612195]  <TASK>
[  110.612405]  __schedule+0xe19/0x3940
...
[  110.626961]  </TASK>
[  110.627112] rcu: Stack dump where RCU GP kthread last ran:
...
[  110.634555]  <IRQ>
[  110.635866]  bpf_has_frame_pointer+0x42/0x290
[  110.637076]  unwind_next_frame+0x2a0/0x1ed0
[  110.642242]  arch_stack_walk+0xba/0x120
[  110.643071]  stack_trace_save+0x8e/0xc0
[  110.645003]  kasan_save_stack+0x2f/0x50
[  110.656111]  kasan_record_aux_stack+0x9b/0xd0
[  110.656714]  __call_rcu_common.constprop.0+0xb7/0xe80
[  110.658475]  kmem_cache_free+0x3b4/0x6a0
[  110.658735]  kfree_skbmem+0x182/0x210
[  110.659290]  sk_skb_reason_drop+0x15f/0x570
[  110.660129]  packet_rcv+0x174/0x1640
[  110.660673]  dev_queue_xmit_nit+0x673/0x9c0
[  110.660956]  dev_hard_start_xmit+0x9f/0x790
[  110.661854]  __dev_queue_xmit+0x140e/0x3d70
[  110.666568]  __bpf_redirect+0x880/0xde0
[  110.667420]  bpf_clone_redirect+0x350/0x5c0
[  110.668011]  bpf_prog_05a7bf74a04af34c+0x27/0x30
[  110.668325]  __dev_queue_xmit+0x2bb2/0x3d70
[  110.673046]  __bpf_redirect+0x880/0xde0
[  110.674202]  bpf_clone_redirect+0x350/0x5c0
...(repeated bpf_clone_redirect)
[  110.704300]  bpf_prog_05a7bf74a04af34c+0x27/0x30
[  110.704611]  __dev_queue_xmit+0x2bb2/0x3d70
[  110.710549]  __bpf_redirect+0x880/0xde0
[  110.711839]  bpf_clone_redirect+0x350/0x5c0
[  110.713199]  bpf_prog_05a7bf74a04af34c+0x27/0x30
[  110.713638]  __netif_receive_skb_core.constprop.0+0x26d3/0x3440
[  110.718047]  __netif_receive_skb_one_core+0xca/0x260
[  110.719889]  __netif_receive_skb+0x54/0x1a0
[  110.720750]  process_backlog+0x34f/0x1380
[  110.721306]  __napi_poll+0xba/0x620
[  110.722173]  net_rx_action+0x550/0xe70
[  110.723891]  handle_softirqs+0x1dc/0x940
[  110.725670]  do_softirq+0xac/0xe0
[  110.725899]  </IRQ>
---

We also observed a broader variant where the clone target was another
virtual device, and the loop went through tunnel/qdisc transmit before
reaching TCX again.

The existing recursion checks detect deep nested transmit and drop packets:

  * __bpf_tx_skb() checks dev_xmit_recursion() before dev_queue_xmit()
  * __dev_queue_xmit() also detects noqueue/virtual-device recursion and
    drops with SKB_DROP_REASON_RECURSION_LIMIT

However, those checks only drop the current nested skb; they do not stop
sustained self-cloning when new packets keep entering the same TCX path.

Is this considered acceptable for privileged TCX programs, or should TCX/BPF
redirect handling prevent sustained self-cloning into the same
virtual-device transmit path after the recursion limit is hit?

This was found by our custom fuzzer developed by
Sechang Lim <rhkrqnwk98@gmail.com>.

See the included reproducer and logs below for more details.

Thanks,
Junseo Lim

---
kernel: 7.2.0-rc4
branch: bpf/master
commit: 0ce37745d4bfbc493f718169c3974898ffec8ee7

---
// SPDX-License-Identifier: GPL-2.0
// The C repro only managed to reproduce stall warning.
// Starvation log was only reproduced by the syz repro.
// gcc -O2 -static repro.c -o repro
#define _GNU_SOURCE

#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdint.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

#ifndef MAP_FIXED_NOREPLACE
#define MAP_FIXED_NOREPLACE 0x100000
#endif

#define AF_INET 2
#define SOCK_STREAM 1
#define SIOCGIFINDEX 0x8933

#define BPF_PROG_LOAD 5
#define BPF_LINK_CREATE 28

#define BPF_PROG_TYPE_SCHED_CLS 3
#define BPF_TCX_INGRESS 0x2e
#define BPF_TCX_EGRESS 0x2f

#define BPF_FUNC_clone_redirect 13

#define BPF_ALU64 0x07
#define BPF_K 0x00
#define BPF_JMP 0x05
#define BPF_MOV 0xb0
#define BPF_CALL 0x80
#define BPF_EXIT 0x90

#define BPF_REG_0 0
#define BPF_REG_2 2
#define BPF_REG_3 3

#define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM) \
	((struct bpf_insn){                        \
		.code = (uint8_t)(CODE),               \
		.dst_reg = (DST),                      \
		.src_reg = (SRC),                      \
		.off = (OFF),                          \
		.imm = (int32_t)(IMM),                 \
	})

#define BPF_MOV64_IMM(DST, IMM) \
	BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_K, DST, 0, 0, IMM)

#define BPF_EMIT_CALL(FUNC) \
	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, FUNC)

#define BPF_EXIT_INSN() \
	BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, 0, 0, 0)

struct bpf_insn
{
	uint8_t code;
#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
	uint8_t dst_reg : 4;
	uint8_t src_reg : 4;
#else
	uint8_t src_reg : 4;
	uint8_t dst_reg : 4;
#endif
	int16_t off;
	int32_t imm;
};

union bpf_attr_local
{
	struct
	{
		uint32_t prog_type;
		uint32_t insn_cnt;
		uint64_t insns;
		uint64_t license;
		uint32_t log_level;
		uint32_t log_size;
		uint64_t log_buf;
		uint32_t kern_version;
		uint32_t prog_flags;
		char prog_name[16];
		uint32_t prog_ifindex;
		uint32_t expected_attach_type;
	} prog_load;
	struct
	{
		uint32_t prog_fd;
		uint32_t target_ifindex;
		uint32_t attach_type;
		uint32_t flags;
	} link_create;
	uint8_t pad[256];
};

struct sockaddr_in_local
{
	uint16_t sin_family;
	uint16_t sin_port;
	uint32_t sin_addr;
	uint8_t sin_zero[8];
};

struct ifreq_local
{
	char ifr_name[16];
	union
	{
		int32_t ifr_ifindex;
	} ifr_ifru;
};

static uint64_t ptr_to_u64(const void *ptr)
{
	return (uint64_t)(uintptr_t)ptr;
}

static long sys_bpf(uint32_t cmd, union bpf_attr_local *attr, uint32_t size)
{
	return syscall(__NR_bpf, cmd, attr, size);
}

static void close_fd(int *fd)
{
	if (*fd >= 0)
	{
		syscall(SYS_close, *fd);
		*fd = -1;
	}
}

static void bump_rlimits(void)
{
	struct rlimit rlim;

	rlim.rlim_cur = RLIM_INFINITY;
	rlim.rlim_max = RLIM_INFINITY;

	syscall(SYS_setrlimit, RLIMIT_MEMLOCK, &rlim);
	syscall(SYS_setrlimit, RLIMIT_NOFILE, &rlim);
}

static void prepare_syz_user_mapping(void)
{
	void *addr = (void *)0x7f0000000000ULL;
	void *ret;
	char *p;

	ret = (void *)syscall(SYS_mmap, addr, 0x200000,
						  PROT_READ | PROT_WRITE,
						  MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE,
						  -1, 0);
	if (ret == MAP_FAILED)
	{
		ret = (void *)syscall(SYS_mmap, addr, 0x200000,
							  PROT_READ | PROT_WRITE,
							  MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
							  -1, 0);
	}

	if (ret != MAP_FAILED)
	{
		p = (char *)0x7f0000000800ULL;
		p[0] = 0x01;
		p[1] = 0x00;
	}
}

static void make_nonblock(int fd)
{
	long flags;

	flags = syscall(SYS_fcntl, fd, F_GETFL, 0);
	if (flags >= 0)
		syscall(SYS_fcntl, fd, F_SETFL, flags | O_NONBLOCK);
}

static int socket_pair_ipv4_stream(int sv[2])
{
	struct sockaddr_in_local addr;
	unsigned int len = sizeof(addr);
	int one = 1;
	int lfd = -1;
	int cfd = -1;
	int afd = -1;

	sv[0] = -1;
	sv[1] = -1;

	lfd = (int)syscall(SYS_socket, AF_INET, SOCK_STREAM, 0);
	if (lfd < 0)
		goto fail;

	syscall(SYS_setsockopt, lfd, 1, 2, &one, sizeof(one));

	cfd = (int)syscall(SYS_socket, AF_INET, SOCK_STREAM, 0);
	if (cfd < 0)
		goto fail;

	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr = 0x0100007f;

	if (syscall(SYS_bind, lfd, &addr, sizeof(addr)) < 0)
		goto fail;

	if (syscall(SYS_getsockname, lfd, &addr, &len) < 0)
		goto fail;

	if (syscall(SYS_listen, lfd, 1) < 0)
		goto fail;

	syscall(SYS_connect, cfd, &addr, len);

	afd = (int)syscall(SYS_accept, lfd, 0, 0);
	if (afd < 0)
		goto fail;

	syscall(SYS_close, lfd);

	make_nonblock(afd);
	make_nonblock(cfd);

	sv[0] = afd;
	sv[1] = cfd;
	return 0;

fail:
	close_fd(&lfd);
	close_fd(&cfd);
	close_fd(&afd);
	return -1;
}

static int lo_ifindex_from_fd(int fd)
{
	struct ifreq_local ifr;

	memset(&ifr, 0, sizeof(ifr));
	ifr.ifr_name[0] = 'l';
	ifr.ifr_name[1] = 'o';

	if (syscall(SYS_ioctl, fd, SIOCGIFINDEX, &ifr) < 0)
		return 1;

	if (ifr.ifr_ifru.ifr_ifindex <= 0)
		return 1;

	return ifr.ifr_ifru.ifr_ifindex;
}

static int load_sched_clone_redirect_prog(int lo_ifindex)
{
	const char license[] = "GPL";
	char log_buf[65536];

	struct bpf_insn insns[] = {
		BPF_MOV64_IMM(BPF_REG_2, lo_ifindex),
		BPF_MOV64_IMM(BPF_REG_3, 0),
		BPF_EMIT_CALL(BPF_FUNC_clone_redirect),
		BPF_MOV64_IMM(BPF_REG_0, 0),
		BPF_EXIT_INSN(),
	};

	union bpf_attr_local attr;
	long fd;

	memset(&attr, 0, sizeof(attr));
	memset(log_buf, 0, sizeof(log_buf));

	attr.prog_load.prog_type = BPF_PROG_TYPE_SCHED_CLS;
	attr.prog_load.insn_cnt = sizeof(insns) / sizeof(insns[0]);
	attr.prog_load.insns = ptr_to_u64(insns);
	attr.prog_load.license = ptr_to_u64(license);
	attr.prog_load.log_level = 1;
	attr.prog_load.log_size = sizeof(log_buf);
	attr.prog_load.log_buf = ptr_to_u64(log_buf);

	fd = sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
	return (int)fd;
}

static int link_create_tcx(int prog_fd, int ifindex, uint32_t attach_type)
{
	union bpf_attr_local attr;
	long fd;

	memset(&attr, 0, sizeof(attr));
	attr.link_create.prog_fd = (uint32_t)prog_fd;
	attr.link_create.target_ifindex = (uint32_t)ifindex;
	attr.link_create.attach_type = attach_type;
	attr.link_create.flags = 0;

	fd = sys_bpf(BPF_LINK_CREATE, &attr, 0x10);
	return (int)fd;
}

static void drain_socket(int fd)
{
	char buf[4096];

	for (;;)
	{
		long ret;

		ret = syscall(SYS_recvfrom, fd, buf, sizeof(buf), 0x40, 0, 0);
		if (ret <= 0)
			break;
	}
}

static void execute_one(void)
{
	int spair[2] = {-1, -1};
	int ioctl_fd = -1;
	int prog_fd = -1;
	int egress_link = -1;
	int ingress_link = -1;
	int ifindex;
	char send_buf[64] = {1};
	size_t send_len = sizeof(send_buf);
	int i;

	if (socket_pair_ipv4_stream(spair) < 0)
		goto out;

	ioctl_fd = (int)syscall(SYS_socket, AF_INET, SOCK_STREAM, 0);
	if (ioctl_fd < 0)
		goto out;

	ifindex = lo_ifindex_from_fd(ioctl_fd);

	prog_fd = load_sched_clone_redirect_prog(ifindex);
	if (prog_fd < 0)
		goto out;

	egress_link = link_create_tcx(prog_fd, ifindex, BPF_TCX_EGRESS);
	if (egress_link < 0)
		goto out;

	syscall(SYS_sendto, spair[1], send_buf, send_len, 0, 0, 0);

	ingress_link = link_create_tcx(prog_fd, ifindex, BPF_TCX_INGRESS);
	if (ingress_link < 0)
		goto out;

	for (i = 0; i < 4096; i++)
	{
		syscall(SYS_sendto, spair[1], send_buf, 2, 0, 0, 0);
		drain_socket(spair[0]);
	}

out:
	close_fd(&ingress_link);
	close_fd(&egress_link);
	close_fd(&prog_fd);
	close_fd(&ioctl_fd);
	close_fd(&spair[0]);
	close_fd(&spair[1]);
}

int main(void)
{
	signal(SIGPIPE, SIG_IGN);

	bump_rlimits();
	prepare_syz_user_mapping();

	for (;;)
		execute_one();

	return 0;
}
---
[   91.960799] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   91.961307] rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P76/1:b..l
[   91.961821] rcu: 	(detected by 1, t=6502 jiffies, g=949, q=1011738 ncpus=2)
[   91.962270] task:kmemleak        state:R  running task     stack:0     pid:76    tgid:76    ppid:2      task_flags:0x208040 flags:0x00080000
[   91.963118] Call Trace:
[   91.963286]  <TASK>
[   91.963436]  __schedule+0xe19/0x3940
[   91.963683]  ? srso_alias_return_thunk+0x5/0xfbef5
[   91.964005]  ? __pfx___schedule+0x10/0x10
[   91.964277]  ? srso_alias_return_thunk+0x5/0xfbef5
[   91.964588]  ? trace_hardirqs_on+0x18/0x1a0
[   91.964863]  ? srso_alias_return_thunk+0x5/0xfbef5
[   91.965210]  ? lockdep_hardirqs_on+0xda/0x170
[   91.965498]  ? srso_alias_return_thunk+0x5/0xfbef5
[   91.965811]  ? __pfx_kmemleak_scan_thread+0x10/0x10
[   91.966132]  preempt_schedule_common+0x44/0xd0
[   91.966425]  ? preempt_schedule_thunk+0x16/0x40
[   91.966722]  preempt_schedule_thunk+0x16/0x40
[   91.967013]  _raw_spin_unlock_irq+0x44/0x50
[   91.967287]  kmemleak_scan+0x141/0x1070
[   91.967554]  ? __pfx_kmemleak_scan_thread+0x10/0x10
[   91.967871]  kmemleak_scan_thread+0x6e/0xb9
[   91.968154]  kthread+0x384/0x4a0
[   91.968380]  ? __pfx_kthread+0x10/0x10
[   91.968639]  ret_from_fork+0x3e0/0x870
[   91.968900]  ? __pfx_ret_from_fork+0x10/0x10
[   91.969237]  ? srso_alias_return_thunk+0x5/0xfbef5
[   91.969548]  ? __switch_to+0x7cd/0x1090
[   91.969809]  ? __pfx_kthread+0x10/0x10
[   91.970070]  ret_from_fork_asm+0x1a/0x30
[   91.970344]  </TASK>
---
