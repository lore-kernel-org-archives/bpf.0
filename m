Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924F46D093
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090154; cv=none; b=HixoPIsQowUXfzSh1oqZAHj414ALK2ymPQ4d0kVgzjPgWxJHRBh6iU64i7MYiovVS3+SVNCDnPWT2A2j6uPMdDryXDRpSbb6886yx4wtuyJMbFHWZaccKDlVtRv3m9Og7gXw0F2yqg2+d4ZJAdWqwNKs0n58H0IHSbLMAHxXhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090154; c=relaxed/simple;
	bh=EYoHiPTKUAUEeHThSWDubzwR0Nw5/bXhCFY4N3x1vHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLgRT9oIctOf/GBs2MA6wGYmcmijhX3ZAHpPOLFM0XobytALr8fY1CU5ZyOOeU1kh6S3OI5GqZzwT0+98XpYecRE6mwuEZ4qY/vrfqDY6n+YViXPI5HbZgm3aoiVp3jqJ/16m4PdKM7Oce1qQxStlHKUsThpTfWUmrElMNr6YA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=k19nLA6U; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="k19nLA6U"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caced6038eso22169915ad.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 01:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1786090140; x=1786694940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mQ0hgonxmbXz9vgjiMXNf6rrIQjSJ3VZW00mopKs7hk=;
        b=k19nLA6UnKPaknqo3ujpjSsB2/uDLAS+nxZrMHZBti37EYplQVqinGOMxG+cu49Gth
         qTNKTXkJ2r/YwPZSSaAXqm4MYrcgtY55rUCRCZyW5o+Ml/BWY+GxC1nEWPGsdXJFD5sP
         6bY/jIopHe8UHXz18QKwxaUEa3b3tbwjnxoNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090140; x=1786694940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQ0hgonxmbXz9vgjiMXNf6rrIQjSJ3VZW00mopKs7hk=;
        b=HzZ7lq92nt/G+8d1/6qjHCR2HGsYi5kJZv/SjjbzW3MLcse6i8ZTzTeJmlxFabp+il
         G+833i0iaAEftYD88weuyJBOOq9CbpX1+CCeY4U9h8a0RBq5f/Dy8hvKP7bKT4Qjz5SJ
         9hx+FYouUehg6GONtVAqejfuxmmLQYUQcwgn4PEBdqS4TbF3PPYawjf5Acnw5kTZ1SMJ
         NgJBryaVMibkYmUtuj9d1ExqFuDqYeTIuA2RK2GoHuAEZLDLNkcZQkzFqM+7b8jj1KM1
         JDBuo1OKT77uOjOoVWdFvF6BF/CfcSqQ89sFptIVxy9hLotTCfbyoOQ9D0SayZr3XPwZ
         S4zA==
X-Gm-Message-State: AOJu0YyYVzpyHWtVN7CLz8okBb79ECyobd92jFzzJmsZxBKIAUfr6GPa
	F2ReSG9aS8faSBiCM5Rncg9fQPWVvbKpPUoY16tYBPA1CjNIeJ4tM+avRFJxG8Na2/T+7frDwtq
	1e/6FpYc/Bw==
X-Gm-Gg: AR+sD13AVmQJBYXDm1/ZPpDiKsRGmrhNaL0K3onIGEIyEHIbXYWymhyG8LAxAT+Y+b8
	MUNTDF6+ymnJqSw7ampX/+K0uLZZuw+yqzh0qTtz04B8A2KFxaZoYrJci55hO7MWI4242SGrQ3D
	3l3HtgFgX3LfodCp4svdfQRfQZ+x+x16dQpeFy19CcbO1HOTcs/5LU3Eg75tkhrsEUjUL2RmngO
	GBUKQXa9pjJUERWOekvxZoTRgcN1xBeNBaZob/Ia9nLskf3TQ1+2406qqtxVtk2b7XeczwBAj0O
	itpEK669P93ezV7jvI0COOlzpOxh0i/h2J2xpcGOnsGOf+ICpzravqPArr6/Kt83JGKhDhK6unG
	ZNzHPSz3EklZ6d7K/L2+th3n7NGCQFaOZIvQ/QW5ONq+auQhu8Wf681GlwlYuVBdE7hdfr82X6w
	tcBw/lgUW2IKKpbHo5TQyYYqcyhl48CMTOOyly3cjhv8mae5bIkslssG4eRHg=
X-Received: by 2002:a17:902:e846:b0:2ca:53f7:3c69 with SMTP id d9443c01a7336-2d0f1c0df16mr147644425ad.9.1786090139420;
        Fri, 07 Aug 2026 01:08:59 -0700 (PDT)
Received: from desktop ([147.46.174.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccb0b2dsm5291425ad.3.2026.08.07.01.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:08:58 -0700 (PDT)
From: Kenneth Lee <kennethbwlee@snu.ac.kr>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	rhkrqnwk98@gmail.com
Subject: BUG: GSO segmentation BUG_ON caused by inconsistent skb fragment metadata
Date: Fri,  7 Aug 2026 17:08:23 +0900
Message-ID: <20260807080823.416802-1-kennethbwlee@snu.ac.kr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BUG_ON(len) assertion in skb_copy_and_csum_bits() was triggered
during GSO segmentation, resulting in an invalid-opcode oops at
net/core/skbuff.c:3688. This bug was reproduced in the following environment:

- Kernel source: Linux 7.2-rc4-102-g4539944e5151
- Commit: 4539944e515183668109bdf4d0c3d7d228383d88
- Architecture: x86_64
- Configuration: SMP, PREEMPT, HZ=250, TLS, TLS_DEVICE, BPF,
  BPF_SYSCALL, NET_SCHED, NET_CLS_BPF, NET_CLS_ACT, DEBUG_INFO,
  KALLSYMS, KASAN, KCOV enabled
- Runtime: QEMU/KVM, 2 CPUs, 4GB RAM

Diagnostic tracing indicates that a TCP transmit skb and its BPF redirect
clone can share the skb_shared_info. During GSO processing,
skb_split_no_header() updates the nr_frags in the shared metadata while
the cloned skb is being processed in skb_segment(). This causes nr_frags
to be inconsistent with the clone's data_len which is caught at the
assertion in skb_copy_and_csum_bits().

Below is the likely interleaving, based on diagnostic tracing:

1. TCP creates a large GSO skb 'A' (nr_frags=17, data_len=65536)
2. __tcp_transmit_skb() creates transmit clone 'B' from A
3. bpf_clone_redirect() creates redirect clone 'C' from B
   A, B, and C initially share skb_shared_info
4. bpf_clone_redirect() calls bpf_try_make_head_writable() on B
   B becomes private, while A and C retain the old shared metadata
5. The BPF program returns TC_ACT_SHOT for B, so B is dropped
   C remains queued for transmission
6. A enters tso_fragment() and skb_split_no_header(), updating the shared
   nr_frags while C remains queued
7. C is dequeued and reaches skb_segment(), which observes the
   inconsistent metadata (nr_frags=14, data_len=65536)

The relevant call paths are:

1. TCP transmit and BPF redirect path

   tcp_sendmsg()
     tcp_write_xmit()
       __tcp_transmit_skb()
         skb_clone(A) -> B
         __dev_queue_xmit(B)
           TCX egress BPF program
             bpf_clone_redirect(B)
               skb_clone(B) -> C
               bpf_try_make_head_writable(B)
               __bpf_redirect(C)
                 __dev_queue_xmit(C)
                   __qdisc_run()
                     sch_direct_xmit()

2. Shared skb_shared_info writer/reader paths

   Writer path for A:
     tcp_write_xmit()
       tso_fragment(A)
         skb_split(A, ...)
           skb_split_no_header(A, ...)
             skb_shinfo(A)->nr_frags = 0
             ...
             skb_shinfo(A)->nr_frags++

   Reader path for C:
     sch_direct_xmit()
       validate_xmit_skb()
         __skb_gso_segment()
           skb_mac_gso_segment()
             inet_gso_segment()
               tcp_gso_segment()
                 skb_segment(C)
                   skb_copy_and_csum_bits()
                     BUG_ON(len)

Found by custom fuzzer developed by Sechang Lim <rhkrqnwk98@gmail.com>

Thanks,
Kenneth Lee

Log:

[    1.917786] kernel BUG at net/core/skbuff.c:3688!
[    1.918021] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[    1.918293] CPU: 0 UID: 0 PID: 128 Comm: extra-init-bin Not tainted 7.2.0-rc4-00102-g4539944e5151 #3 PREEMPT(full)
[    1.918804] Hardware name: QEMU Ubuntu 26.04 PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[    1.919331] RIP: 0010:skb_copy_and_csum_bits+0x8e9/0x8f0
[    1.919614] Code: e8 1c 15 fa fe e9 ea f8 ff ff 44 89 f1 80 e1 07 38 c1 0f 8c fa f8 ff ff 4c 89 f7 e8 a1 14 fa fe e9 ed f8 ff ff e8 07 23 a7 fe <0f> 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[    1.920520] RSP: 0018:ffffc900000076a8 EFLAGS: 00010246
[    1.920789] RAX: ffffffff82c810b9 RBX: 000000000000d242 RCX: ffff888115f93780
[    1.921152] RDX: 0000000000000100 RSI: 000000000000d242 RDI: ffff888113c31608
[    1.921509] RBP: 0000000000002e00 R08: ffff88811725c13f R09: 1ffff11022e4b827
[    1.921849] R10: dffffc0000000000 R11: ffffed1022e4b828 R12: ffff888113c31508
[    1.922187] R13: ffff88811725c140 R14: 0000000000000000 R15: ffff888113c31502
[    1.922537] FS:  00007fa448c626c0(0000) GS:ffff88819488c000(0000) knlGS:0000000000000000
[    1.922921] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.923196] CR2: 00007fa459c86000 CR3: 0000000109ee0004 CR4: 0000000000770ef0
[    1.923568] PKRU: 55555554
[    1.923703] Call Trace:
[    1.923828]  <IRQ>
[    1.923934]  skb_segment+0x2471/0x3b30
[    1.924121]  tcp_gso_segment+0x324/0x1560
[    1.924319]  ? check_path+0x21/0x40
[    1.924500]  inet_gso_segment+0x4f5/0x11a0
[    1.924705]  ? __pfx_inet_gso_segment+0x10/0x10
[    1.924925]  skb_mac_gso_segment+0x2b7/0x4d0
[    1.925135]  ? skb_mac_gso_segment+0x143/0x4d0
[    1.925354]  ? __pfx_skb_mac_gso_segment+0x10/0x10
[    1.925594]  ? __pfx_netif_skb_features+0x10/0x10
[    1.925823]  __skb_gso_segment+0x301/0x490
[    1.926022]  validate_xmit_skb+0x8dc/0x1090
[    1.926224]  ? __asan_memset+0x22/0x50
[    1.926415]  ? netem_dequeue+0x10ad/0x1290
[    1.926620]  ? sch_direct_xmit+0xba/0x4a0
[    1.926816]  validate_xmit_skb_list+0x84/0x130
[    1.927034]  sch_direct_xmit+0xe5/0x4a0
[    1.927222]  ? __pfx_sch_direct_xmit+0x10/0x10
[    1.927448]  __qdisc_run+0x993/0x12a0
[    1.927668]  qdisc_run+0x169/0x2d0
[    1.927844]  ? net_tx_action+0x3c6/0x6b0
[    1.928036]  net_tx_action+0x500/0x6b0
[    1.928220]  handle_softirqs+0x22a/0x7f0
[    1.928421]  ? __irq_exit_rcu+0x72/0x130
[    1.928623]  __irq_exit_rcu+0x72/0x130
[    1.928818]  irq_exit_rcu+0x9/0x30
[    1.928997]  sysvec_apic_timer_interrupt+0x90/0xb0
[    1.929246]  </IRQ>

C reproducer;

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/if_eql.h>
#include <linux/if.h>
#include <linux/netlink.h>
#include <linux/pkt_sched.h>
#include <linux/rtnetlink.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdatomic.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <unistd.h>

#ifndef __NR_bpf
#if defined(__x86_64__)
#define __NR_bpf 321
#else
#error "__NR_bpf is not defined for this architecture"
#endif
#endif

#ifndef SOL_TLS
#define SOL_TLS 282
#endif

#ifndef TCP_ULP
#define TCP_ULP 31
#endif

#define TLS_TX 1
#define TLS_1_3_VERSION 0x0304
#define TLS_CIPHER_AES_GCM_128 51

#define BPF_PROG_LOAD 5
#define BPF_LINK_CREATE 28
#define BPF_PROG_TYPE_SCHED_CLS 3
#define BPF_TCX_EGRESS 47
#define BPF_FUNC_clone_redirect 13
#define TC_ACT_SHOT 2

#define BPF_ALU64 0x07
#define BPF_MOV 0xb0
#define BPF_K 0x00
#define BPF_JMP 0x05
#define BPF_CALL 0x80
#define BPF_EXIT 0x90

#define BPF_REG_0 0
#define BPF_REG_2 2
#define BPF_REG_3 3

#define CLONE_REDIRECT_IFINDEX 4
#define SYZ_BASE_ADDR 0x7f0000000000ULL
#define SYZ_MAP_SIZE 0x1000000
#define SYZ_ULP_OFF 0x0a00
#define SYZ_TLS_TX_OFF 0x0b00
#define SYZ_SEND_OFF 0x0e00
#define GSO_SEND_LEN 65536
#define SEND_WORKERS 16
#define DEFAULT_ROUND_USEC 1000000
#define DEFAULT_ATTACH_DELAY_USEC 1000
#define DEFAULT_NETEM_USEC 3000000
#define WG_WORKERS 4
#define WG_DEFAULT_TARGET "fd00::2"
#define WG_DEFAULT_PORT 9

static atomic_ulong *tls_iterations;
static atomic_ulong *wg_iterations;
static unsigned char *syz_mem;

struct tls_send_ctx {
	int tx;
	int rx;
	atomic_int *start;
	atomic_int *drain_stop;
	atomic_int done;
	long ret;
	int err;
	unsigned long drained;
};

struct wg_send_ctx {
	atomic_int *stop;
	const char *target;
	int port;
	int verbose;
};

static void report_result(const char *name, long ret);

struct bpf_insn {
	unsigned char code;
	unsigned char dst_reg : 4;
	unsigned char src_reg : 4;
	int16_t off;
	int32_t imm;
};

union bpf_attr_local {
	struct {
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

	struct {
		uint32_t prog_fd;
		union {
			uint32_t target_fd;
			uint32_t target_ifindex;
		};
		uint32_t attach_type;
		uint32_t flags;
	} link_create;

	unsigned char pad[256];
};

struct tls_crypto_info {
	uint16_t version;
	uint16_t cipher_type;
};

struct tls12_crypto_info_aes_gcm_128 {
	struct tls_crypto_info info;
	unsigned char iv[8];
	unsigned char key[16];
	unsigned char salt[4];
	unsigned char rec_seq[8];
};

static uint64_t ptr_to_u64(const void *ptr)
{
	return (uint64_t)(uintptr_t)ptr;
}

static int bpf_syscall(int cmd, union bpf_attr_local *attr, unsigned int size)
{
	return syscall(__NR_bpf, cmd, attr, size);
}

static struct bpf_insn bpf_mov64_imm(int dst, int imm)
{
	struct bpf_insn insn = {
		.code = BPF_ALU64 | BPF_MOV | BPF_K,
		.dst_reg = dst,
		.src_reg = 0,
		.off = 0,
		.imm = imm,
	};
	return insn;
}

static struct bpf_insn bpf_call(int helper)
{
	struct bpf_insn insn = {
		.code = BPF_JMP | BPF_CALL,
		.dst_reg = 0,
		.src_reg = 0,
		.off = 0,
		.imm = helper,
	};
	return insn;
}

static struct bpf_insn bpf_exit(void)
{
	struct bpf_insn insn = {
		.code = BPF_JMP | BPF_EXIT,
		.dst_reg = 0,
		.src_reg = 0,
		.off = 0,
		.imm = 0,
	};
	return insn;
}

static int make_tcp_pair(int family, int fds[2])
{
	struct sockaddr_storage ss;
	socklen_t len;
	int listener = -1;
	int client = -1;
	int server = -1;
	int one = 1;

	memset(&ss, 0, sizeof(ss));

	listener = socket(family, SOCK_STREAM, 0);
	if (listener < 0)
		goto fail;

	setsockopt(listener, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));

	if (family == AF_INET) {
		struct sockaddr_in *addr = (struct sockaddr_in *)&ss;

		addr->sin_family = AF_INET;
		addr->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
		addr->sin_port = 0;
		len = sizeof(*addr);
	} else {
		struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)&ss;

		addr6->sin6_family = AF_INET6;
		addr6->sin6_addr = in6addr_loopback;
		addr6->sin6_port = 0;
		len = sizeof(*addr6);
	}

	if (bind(listener, (struct sockaddr *)&ss, len) < 0)
		goto fail;
	if (listen(listener, 1) < 0)
		goto fail;
	if (getsockname(listener, (struct sockaddr *)&ss, &len) < 0)
		goto fail;

	client = socket(family, SOCK_STREAM, 0);
	if (client < 0)
		goto fail;
	if (connect(client, (struct sockaddr *)&ss, len) < 0)
		goto fail;

	server = accept(listener, NULL, NULL);
	if (server < 0)
		goto fail;

	close(listener);
	fds[0] = server;
	fds[1] = client;
	return 0;

fail:
	if (listener >= 0)
		close(listener);
	if (client >= 0)
		close(client);
	if (server >= 0)
		close(server);
	return -1;
}

static int setup_tls_ctx(struct tls_send_ctx *ctx, int verbose)
{
	int fds[2] = {-1, -1};
	struct timeval tv = {
		.tv_sec = 0,
		.tv_usec = 20000,
	};
	long ret;

	memset(ctx, 0, sizeof(*ctx));
	ctx->tx = -1;
	ctx->rx = -1;

	if (make_tcp_pair(AF_INET, fds) < 0) {
		if (verbose)
			perror("make_tcp_pair(AF_INET)");
		return -1;
	}

	ctx->tx = fds[0];
	ctx->rx = fds[1];
	setsockopt(ctx->tx, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(tv));

	ret = setsockopt(ctx->tx, IPPROTO_TCP, TCP_ULP, syz_mem + SYZ_ULP_OFF, 3);
	if (verbose)
		report_result("setsockopt(TCP_ULP)", ret);
	ret = setsockopt(ctx->tx, SOL_TLS, TLS_TX, syz_mem + SYZ_TLS_TX_OFF, 0x28);
	if (verbose)
		report_result("setsockopt(TLS_TX)", ret);

	return 0;
}

static void close_tls_ctx(struct tls_send_ctx *ctx)
{
	if (ctx->tx >= 0) {
		shutdown(ctx->tx, SHUT_RDWR);
		close(ctx->tx);
		ctx->tx = -1;
	}
	if (ctx->rx >= 0) {
		shutdown(ctx->rx, SHUT_RDWR);
		close(ctx->rx);
		ctx->rx = -1;
	}
}

static void try_set_if_up(int fd, int ifindex)
{
	struct ifreq ifr;

	memset(&ifr, 0, sizeof(ifr));
	ifr.ifr_ifindex = ifindex;
	if (ioctl(fd, SIOCGIFNAME, &ifr) < 0) {
		fprintf(stderr, "SIOCGIFNAME(%d): %s\n", ifindex, strerror(errno));
		return;
	}

	if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0) {
		fprintf(stderr, "SIOCGIFFLAGS(%s): %s\n", ifr.ifr_name,
			strerror(errno));
		return;
	}

	ifr.ifr_flags |= IFF_UP | IFF_RUNNING;
	if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0)
		fprintf(stderr, "SIOCSIFFLAGS(%s): %s\n", ifr.ifr_name,
			strerror(errno));
}

static void try_set_txqlen(int fd, const char *ifname, int qlen)
{
	struct ifreq ifr;
	size_t len;

	memset(&ifr, 0, sizeof(ifr));
	len = strnlen(ifname, IFNAMSIZ - 1);
	memcpy(ifr.ifr_name, ifname, len);
	ifr.ifr_qlen = qlen;
	if (ioctl(fd, SIOCSIFTXQLEN, &ifr) < 0)
		fprintf(stderr, "SIOCSIFTXQLEN(%s): %s\n", ifname,
			strerror(errno));
}

static int addattr_l(struct nlmsghdr *n, size_t maxlen, int type,
		     const void *data, size_t alen)
{
	size_t len = RTA_LENGTH(alen);
	struct rtattr *rta;

	if (NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len) > maxlen)
		return -1;

	rta = (struct rtattr *)((char *)n + NLMSG_ALIGN(n->nlmsg_len));
	rta->rta_type = type;
	rta->rta_len = len;
	memcpy(RTA_DATA(rta), data, alen);
	n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len);
	return 0;
}

static void try_set_root_qdisc(int ifindex, const char *kind)
{
	char reqbuf[NLMSG_SPACE(sizeof(struct tcmsg)) + 256];
	struct sockaddr_nl nladdr = {
		.nl_family = AF_NETLINK,
	};
	struct nlmsghdr *nlh = (struct nlmsghdr *)reqbuf;
	struct tcmsg *tcm;
	int fd;

	memset(reqbuf, 0, sizeof(reqbuf));
	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (fd < 0) {
		fprintf(stderr, "netlink route socket: %s\n", strerror(errno));
		return;
	}

	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(*tcm));
	nlh->nlmsg_type = RTM_NEWQDISC;
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE |
			   NLM_F_REPLACE;
	tcm = NLMSG_DATA(nlh);
	tcm->tcm_family = AF_UNSPEC;
	tcm->tcm_ifindex = ifindex;
	tcm->tcm_parent = TC_H_ROOT;
	tcm->tcm_handle = 0;

	addattr_l(nlh, sizeof(reqbuf), TCA_KIND, kind, strlen(kind) + 1);

	if (sendto(fd, nlh, nlh->nlmsg_len, 0, (struct sockaddr *)&nladdr,
		   sizeof(nladdr)) < 0) {
		fprintf(stderr, "RTM_NEWQDISC(%s): %s\n", kind, strerror(errno));
		close(fd);
		return;
	}

	ssize_t n = recv(fd, reqbuf, sizeof(reqbuf), 0);
	if (n < 0)
		fprintf(stderr, "RTM_NEWQDISC(%s) ack: %s\n", kind,
			strerror(errno));
	else {
		struct nlmsghdr *ack = (struct nlmsghdr *)reqbuf;

		if (ack->nlmsg_type == NLMSG_ERROR) {
			struct nlmsgerr *err = NLMSG_DATA(ack);

			if (err->error)
				fprintf(stderr, "RTM_NEWQDISC(%s): %s\n", kind,
					strerror(-err->error));
			else
				fprintf(stderr, "RTM_NEWQDISC(%s on ifindex %d): 0\n",
					kind, ifindex);
		}
	}
	close(fd);
}

static void try_set_netem_delay(int ifindex, unsigned int delay_usec)
{
	char reqbuf[NLMSG_SPACE(sizeof(struct tcmsg)) + 256];
	struct sockaddr_nl nladdr = {
		.nl_family = AF_NETLINK,
	};
	struct tc_netem_qopt qopt = {
		.latency = delay_usec,
		.limit = 65535,
	};
	struct nlmsghdr *nlh = (struct nlmsghdr *)reqbuf;
	struct tcmsg *tcm;
	int fd;

	memset(reqbuf, 0, sizeof(reqbuf));
	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (fd < 0) {
		fprintf(stderr, "netlink route socket: %s\n", strerror(errno));
		return;
	}

	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(*tcm));
	nlh->nlmsg_type = RTM_NEWQDISC;
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE |
			   NLM_F_REPLACE;
	tcm = NLMSG_DATA(nlh);
	tcm->tcm_family = AF_UNSPEC;
	tcm->tcm_ifindex = ifindex;
	tcm->tcm_parent = TC_H_ROOT;
	tcm->tcm_handle = 0;

	addattr_l(nlh, sizeof(reqbuf), TCA_KIND, "netem", sizeof("netem"));
	addattr_l(nlh, sizeof(reqbuf), TCA_OPTIONS, &qopt, sizeof(qopt));

	if (sendto(fd, nlh, nlh->nlmsg_len, 0, (struct sockaddr *)&nladdr,
		   sizeof(nladdr)) < 0) {
		fprintf(stderr, "RTM_NEWQDISC(netem delay %uus): %s\n",
			delay_usec, strerror(errno));
		close(fd);
		return;
	}

	ssize_t n = recv(fd, reqbuf, sizeof(reqbuf), 0);
	if (n < 0)
		fprintf(stderr, "RTM_NEWQDISC(netem delay %uus) ack: %s\n",
			delay_usec, strerror(errno));
	else {
		struct nlmsghdr *ack = (struct nlmsghdr *)reqbuf;

		if (ack->nlmsg_type == NLMSG_ERROR) {
			struct nlmsgerr *err = NLMSG_DATA(ack);

			if (err->error)
				fprintf(stderr, "RTM_NEWQDISC(netem delay %uus): %s\n",
					delay_usec, strerror(-err->error));
			else
				fprintf(stderr, "RTM_NEWQDISC(netem delay %uus on ifindex %d): 0\n",
					delay_usec, ifindex);
		}
	}
	close(fd);
}

static void try_eql_enslave(int fd, const char *master, const char *slave)
{
	struct slaving_request req;
	struct ifreq ifr;
	size_t len;

	memset(&req, 0, sizeof(req));
	memset(&ifr, 0, sizeof(ifr));

	len = strnlen(slave, sizeof(req.slave_name) - 1);
	memcpy(req.slave_name, slave, len);
	req.priority = EQL_DEFAULT_SLAVE_PRIORITY;
	len = strnlen(master, IFNAMSIZ - 1);
	memcpy(ifr.ifr_name, master, len);
	ifr.ifr_data = (void *)&req;

	if (ioctl(fd, EQL_ENSLAVE, &ifr) < 0)
		fprintf(stderr, "EQL_ENSLAVE(%s <- %s): %s\n", master, slave,
			strerror(errno));
	else
		fprintf(stderr, "EQL_ENSLAVE(%s <- %s): 0\n", master, slave);
}

static int load_clone_redirect_prog(int redirect_ifindex, int action)
{
	static const char license[] = "GPL";
	char log_buf[65536];
	union bpf_attr_local attr;
	struct bpf_insn insns[5];
	int insn_cnt = 0;

	insns[insn_cnt++] = bpf_mov64_imm(BPF_REG_2, redirect_ifindex);
	insns[insn_cnt++] = bpf_mov64_imm(BPF_REG_3, 0);
	insns[insn_cnt++] = bpf_call(BPF_FUNC_clone_redirect);
	if (action >= 0)
		insns[insn_cnt++] = bpf_mov64_imm(BPF_REG_0, action);
	insns[insn_cnt++] = bpf_exit();

	memset(log_buf, 0, sizeof(log_buf));
	memset(&attr, 0, sizeof(attr));
	attr.prog_load.prog_type = BPF_PROG_TYPE_SCHED_CLS;
	attr.prog_load.insn_cnt = insn_cnt;
	attr.prog_load.insns = ptr_to_u64(insns);
	attr.prog_load.license = ptr_to_u64(license);
	attr.prog_load.log_level = 1;
	attr.prog_load.log_size = sizeof(log_buf);
	attr.prog_load.log_buf = ptr_to_u64(log_buf);
	memcpy(attr.prog_load.prog_name, "clone_redir", sizeof("clone_redir"));

	int fd = bpf_syscall(BPF_PROG_LOAD, &attr, sizeof(attr));
	if (fd < 0 && log_buf[0])
		fprintf(stderr, "BPF verifier log:\n%s\n", log_buf);
	return fd;
}

static int link_tcx(int prog_fd, int ifindex)
{
	union bpf_attr_local attr;

	memset(&attr, 0, sizeof(attr));
	attr.link_create.prog_fd = prog_fd;
	attr.link_create.target_ifindex = ifindex;
	attr.link_create.attach_type = BPF_TCX_EGRESS;
	attr.link_create.flags = 0;

	return bpf_syscall(BPF_LINK_CREATE, &attr, 16);
}

static int ifindex_exists(int fd, int ifindex, char *name, size_t name_len)
{
	struct ifreq ifr;

	memset(&ifr, 0, sizeof(ifr));
	ifr.ifr_ifindex = ifindex;
	if (ioctl(fd, SIOCGIFNAME, &ifr) < 0)
		return 0;

	if (name && name_len) {
		size_t len;

		ifr.ifr_name[IFNAMSIZ - 1] = '\0';
		len = strnlen(ifr.ifr_name, IFNAMSIZ);
		if (len >= name_len)
			len = name_len - 1;
		memcpy(name, ifr.ifr_name, len);
		name[len] = '\0';
	}
	return 1;
}

static int setup_syz_memory(void)
{
	struct tls12_crypto_info_aes_gcm_128 crypto = {
		.info = {
			.version = TLS_1_3_VERSION,
			.cipher_type = TLS_CIPHER_AES_GCM_128,
		},
		.iv = {0x72, 0x7e, 0x34, 0x59, 0x9b, 0xe4, 0x9a, 0x9b},
		.key = {
			0x03, 0x01, 0xc0, 0xe8, 0xf2, 0x0f, 0xd4, 0x52,
			0xeb, 0x25, 0xe7, 0x40, 0xaa, 0x32, 0xd8, 0xfc,
		},
		.salt = {0x15, 0xaa, 0xcb, 0x34},
		.rec_seq = {0x14, 0x7d, 0xc4, 0x10, 0x0f, 0x67, 0x77, 0x7f},
	};
	void *addr;
	int flags = MAP_PRIVATE | MAP_ANONYMOUS;

#ifdef MAP_FIXED_NOREPLACE
	flags |= MAP_FIXED_NOREPLACE;
#else
	flags |= MAP_FIXED;
#endif

	addr = mmap((void *)SYZ_BASE_ADDR, SYZ_MAP_SIZE,
		    PROT_READ | PROT_WRITE, flags, -1, 0);
	if (addr == MAP_FAILED) {
		perror("mmap syz executor region");
		return -1;
	}

	syz_mem = addr;
	memcpy(syz_mem + SYZ_ULP_OFF, "tls", 3);
	memcpy(syz_mem + SYZ_TLS_TX_OFF, &crypto, sizeof(crypto));
	memset(syz_mem + SYZ_SEND_OFF, 0x41, SYZ_MAP_SIZE - SYZ_SEND_OFF);

	tls_iterations = mmap(NULL, sizeof(*tls_iterations),
			      PROT_READ | PROT_WRITE,
			      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
	if (tls_iterations == MAP_FAILED) {
		perror("mmap shared stats");
		return -1;
	}
	atomic_init(tls_iterations, 0);
	wg_iterations = mmap(NULL, sizeof(*wg_iterations),
			     PROT_READ | PROT_WRITE,
			     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
	if (wg_iterations == MAP_FAILED) {
		perror("mmap shared wg stats");
		return -1;
	}
	atomic_init(wg_iterations, 0);
	return 0;
}

static void report_result(const char *name, long ret)
{
	if (ret < 0)
		fprintf(stderr, "%s: %s\n", name, strerror(errno));
	else
		fprintf(stderr, "%s: %ld\n", name, ret);
}

static void *huge_send_worker(void *arg)
{
	struct tls_send_ctx *ctx = arg;

	while (ctx->start && !atomic_load(ctx->start))
		sched_yield();

	ctx->ret = sendto(ctx->tx, syz_mem + SYZ_SEND_OFF, (size_t)-307,
			  MSG_NOSIGNAL, NULL, 0);
	ctx->err = errno;
	atomic_store(&ctx->done, 1);
	atomic_fetch_add(tls_iterations, 1);
	return NULL;
}

static void *drain_worker(void *arg)
{
	struct tls_send_ctx *ctx = arg;
	char buf[32768];

	while (ctx->start && !atomic_load(ctx->start))
		sched_yield();

	while (!atomic_load(ctx->drain_stop)) {
		ssize_t n = recv(ctx->rx, buf, sizeof(buf), MSG_DONTWAIT);

		if (n > 0) {
			ctx->drained += n;
			continue;
		}
		if (n < 0 && errno != EAGAIN && errno != EWOULDBLOCK)
			break;
		sched_yield();
	}

	return NULL;
}

static int get_outq(int fd)
{
	int outq = -1;

	if (ioctl(fd, TIOCOUTQ, &outq) < 0)
		return -1;
	return outq;
}

static void *wg_send_worker(void *arg)
{
	struct wg_send_ctx *ctx = arg;
	struct sockaddr_in6 dst;
	char buf[65536];
	int fd;

	memset(buf, 0x42, sizeof(buf));
	memset(&dst, 0, sizeof(dst));
	dst.sin6_family = AF_INET6;
	dst.sin6_port = htons(ctx->port);
	if (inet_pton(AF_INET6, ctx->target, &dst.sin6_addr) != 1)
		return NULL;

	fd = socket(AF_INET6, SOCK_STREAM | SOCK_NONBLOCK, 0);
	if (fd < 0)
		return NULL;

	if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, "wg0", 4) < 0) {
		if (ctx->verbose)
			fprintf(stderr, "SO_BINDTODEVICE(wg0): %s\n",
				strerror(errno));
		close(fd);
		return NULL;
	}

	connect(fd, (struct sockaddr *)&dst, sizeof(dst));
	for (int i = 0; i < 1000 && !atomic_load(ctx->stop); i++) {
		ssize_t n = send(fd, buf, sizeof(buf), MSG_DONTWAIT | MSG_NOSIGNAL);

		if (n > 0) {
			atomic_fetch_add(wg_iterations, 1);
			continue;
		}
		if (errno == EINPROGRESS || errno == EALREADY ||
		    errno == EAGAIN || errno == EWOULDBLOCK) {
			sched_yield();
			continue;
		}
		if (ctx->verbose)
			fprintf(stderr, "wg0 send/connect path: %s\n",
				strerror(errno));
		break;
	}

	close(fd);
	return NULL;
}

static int run_round(int prog_fd, int ifindex, int verbose, int round_usec,
		     const char *wg_target, int wg_port)
{
	struct tls_send_ctx ctx[SEND_WORKERS];
	pthread_t threads[SEND_WORKERS];
	pthread_t drains[SEND_WORKERS];
	pthread_t wg_threads[WG_WORKERS];
	struct wg_send_ctx wg_ctx[WG_WORKERS];
	atomic_int start = 0;
	atomic_int drain_stop = 0;
	atomic_int wg_stop = 0;
	int link_fd;
	int created = 0;
	int drain_created = 0;
	int wg_created = 0;

	for (int i = 0; i < SEND_WORKERS; i++) {
		if (setup_tls_ctx(&ctx[i], verbose) < 0)
			break;
		ctx[i].start = &start;
		ctx[i].drain_stop = &drain_stop;
		if (pthread_create(&threads[i], NULL, huge_send_worker, &ctx[i])) {
			close_tls_ctx(&ctx[i]);
			break;
		}
		created++;
	}

	if (!created)
		return -1;

	atomic_store(&start, 1);
	usleep(DEFAULT_ATTACH_DELAY_USEC);

	link_fd = link_tcx(prog_fd, ifindex);
	if (link_fd < 0) {
		perror("bpf(BPF_LINK_CREATE TCX)");
		for (int i = 0; i < created; i++) {
			shutdown(ctx[i].tx, SHUT_RDWR);
			shutdown(ctx[i].rx, SHUT_RDWR);
			pthread_join(threads[i], NULL);
			close_tls_ctx(&ctx[i]);
		}
		return -1;
	}

	if (verbose)
		fprintf(stderr, "attached link fd %d\n", link_fd);

	for (int i = 0; i < WG_WORKERS; i++) {
		wg_ctx[i].stop = &wg_stop;
		wg_ctx[i].target = wg_target;
		wg_ctx[i].port = wg_port;
		wg_ctx[i].verbose = verbose && i == 0;
		if (pthread_create(&wg_threads[i], NULL, wg_send_worker, &wg_ctx[i]))
			break;
		wg_created++;
	}

	for (int i = 0; i < created; i++) {
		if (pthread_create(&drains[i], NULL, drain_worker, &ctx[i]))
			break;
		drain_created++;
	}

	usleep(round_usec);
	atomic_store(&drain_stop, 1);
	atomic_store(&wg_stop, 1);

	for (int i = 0; i < created; i++) {
		if (verbose)
			fprintf(stderr, "sender outq before shutdown: %d, drained: %lu\n",
				get_outq(ctx[i].tx), ctx[i].drained);
		shutdown(ctx[i].tx, SHUT_RDWR);
		shutdown(ctx[i].rx, SHUT_RDWR);
	}

	for (int i = 0; i < created; i++) {
		pthread_join(threads[i], NULL);
		if (verbose) {
			errno = ctx[i].err;
			report_result("sendto(huge length)", ctx[i].ret);
			fprintf(stderr, "sender outq after send: %d\n",
				get_outq(ctx[i].tx));
		}
	}
	for (int i = 0; i < drain_created; i++)
		pthread_join(drains[i], NULL);
	for (int i = 0; i < wg_created; i++)
		pthread_join(wg_threads[i], NULL);

	for (int i = 0; i < created; i++)
		close_tls_ctx(&ctx[i]);

	close(link_fd);
	return created;
}

static int run_child_rounds(int prog_fd, int ifindex, int rounds, int round_usec,
			    int verbose_child, const char *wg_target, int wg_port)
{
	for (int i = 0; i < rounds; i++) {
		if (run_round(prog_fd, ifindex, verbose_child && i == 0,
			      round_usec, wg_target, wg_port) < 0)
			return 1;
	}
	return 0;
}

int main(int argc, char **argv)
{
	struct rlimit rlim = {
		.rlim_cur = RLIM_INFINITY,
		.rlim_max = RLIM_INFINITY,
	};
	struct ifreq ifr;
	int tcp6[2] = {-1, -1};
	int ifindex = 0;
	int prog_fd = -1;
	int rounds = 10;
	int redirect_ifindex = CLONE_REDIRECT_IFINDEX;
	int bpf_action = TC_ACT_SHOT;
	int round_usec = DEFAULT_ROUND_USEC;
	int children = 1;
	const char *wg_target = WG_DEFAULT_TARGET;
	int wg_port = WG_DEFAULT_PORT;
	char redirect_name[IFNAMSIZ];

	if (argc > 1) {
		rounds = atoi(argv[1]);
		if (rounds <= 0)
			rounds = 10;
	}
	if (argc > 2) {
		redirect_ifindex = atoi(argv[2]);
		if (redirect_ifindex <= 0)
			redirect_ifindex = CLONE_REDIRECT_IFINDEX;
	}
	if (argc > 3)
		bpf_action = atoi(argv[3]);
	if (argc > 4) {
		round_usec = atoi(argv[4]);
		if (round_usec <= 0)
			round_usec = DEFAULT_ROUND_USEC;
	}
	if (argc > 5) {
		children = atoi(argv[5]);
		if (children <= 0)
			children = 1;
	}
	if (argc > 6)
		wg_target = argv[6];
	if (argc > 7) {
		wg_port = atoi(argv[7]);
		if (wg_port <= 0)
			wg_port = WG_DEFAULT_PORT;
	}

	setrlimit(RLIMIT_MEMLOCK, &rlim);
	signal(SIGPIPE, SIG_IGN);
	if (setup_syz_memory() < 0)
		return 1;
	fprintf(stderr, "mapped syz executor region at %p\n", syz_mem);

	fprintf(stderr, "creating TCP6 socket pair\n");
	if (make_tcp_pair(AF_INET6, tcp6) < 0) {
		perror("make_tcp_pair(AF_INET6)");
		return 1;
	}

	memset(&ifr, 0, sizeof(ifr));
	strncpy(ifr.ifr_name, "lo", IFNAMSIZ - 1);
	if (ioctl(tcp6[1], SIOCGIFINDEX, &ifr) < 0) {
		perror("ioctl(SIOCGIFINDEX lo)");
		return 1;
	}
	ifindex = ifr.ifr_ifindex;
	fprintf(stderr, "lo ifindex for TCX attach: %d\n", ifindex);
	fprintf(stderr, "clone_redirect target ifindex: %d\n", redirect_ifindex);
	fprintf(stderr, "BPF post-clone action: %d\n", bpf_action);
	if (ifindex_exists(tcp6[1], redirect_ifindex, redirect_name,
			   sizeof(redirect_name)))
		fprintf(stderr, "clone_redirect target device: %s\n", redirect_name);
	else
		fprintf(stderr, "clone_redirect target ifindex is not present\n");
	try_set_if_up(tcp6[1], ifindex);
	try_set_if_up(tcp6[1], redirect_ifindex);
	try_set_txqlen(tcp6[1], "lo", 1000);
	try_set_root_qdisc(ifindex, "pfifo_fast");
	if (ifindex_exists(tcp6[1], redirect_ifindex, redirect_name,
			   sizeof(redirect_name)))
		try_eql_enslave(tcp6[1], redirect_name, "lo");
	try_set_netem_delay(redirect_ifindex, DEFAULT_NETEM_USEC);

	fprintf(stderr, "loading sched_cls clone_redirect program\n");
	prog_fd = load_clone_redirect_prog(redirect_ifindex, bpf_action);
	if (prog_fd < 0) {
		perror("bpf(BPF_PROG_LOAD)");
		return 1;
	}

	fprintf(stderr, "running %d children, %d rounds each, %d TLS workers, %d WG workers, %dus hold\n",
		children, rounds, SEND_WORKERS, WG_WORKERS, round_usec);
	fprintf(stderr, "wg0 target: [%s]:%d\n", wg_target, wg_port);
	for (int i = 0; i < children; i++) {
		pid_t pid = fork();

		if (pid < 0) {
			perror("fork");
			return 1;
		}
		if (pid == 0) {
			int ret = run_child_rounds(prog_fd, ifindex, rounds,
						   round_usec, i == 0,
						   wg_target, wg_port);

			_exit(ret);
		}
	}

	for (int i = 0; i < children; i++) {
		int status;

		if (wait(&status) < 0) {
			perror("wait");
			return 1;
		}
		if (WIFSIGNALED(status))
			fprintf(stderr, "child died from signal %d\n",
				WTERMSIG(status));
		else if (WEXITSTATUS(status))
			fprintf(stderr, "child exited with status %d\n",
				WEXITSTATUS(status));
	}

	fprintf(stderr, "tls iterations: %lu\n", atomic_load(tls_iterations));
	fprintf(stderr, "wg iterations: %lu\n", atomic_load(wg_iterations));
	fprintf(stderr, "done\n");
	return 0;
}
