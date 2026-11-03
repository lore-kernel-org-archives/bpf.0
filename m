Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729928;
	b=E7XGarFhV36eoXH/d9fq84XjIerCEq1o39HF1YoNRPwwsVJbyJNhKgEWWEtWdcaz9gR9
	 PLfNXbzlWO2N/AjpfEa2+ecE4IeD6hZj5Z9XZtmO3o4ZrniWLG/wgGzoH09oYMCB/xy9m
	 8SUY4x5/2qlXl2xjL+f9ReqTlQQXOHlPhpkFSWr5nYZI+0ONJFwFpMbmznQiUEOY6eHbX
	 JLx83/K3EbXw0ODMLl/ZfhDnfFaIQLlhM0un04lVXx7yOYhTa58Ohl/OaKY6JYJskNFSi
	 nH5MTG4bGGpm/cZAkrKDlrro2Lh1MmIRgmcVszgG1QRsWW5PGZyYEuxKTfniFSgXHLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729928;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WItPlN+JjeoLtSULsBkuhR1DzTRWWzJEF2rYsNOP08o=;
	b=bWjQwudPqmXpD55A026RXcBuApVQZ2e6GcSH/l8Fzm5xbiqI2ie6g4g5aiRdzdKU54C8
	 +FH7Q9oj8Y5xwESHAo4XQJOi4O07pyZZsakHJuMjAzj3ohNZb7tUeaWbtSV7KfIfkS+9m
	 ucgpOH3IXOyZU68dM+UEZYICpjdB5EGgrSQia+NPdM3HoxAgCnFKIVxaHBhbJDYu1kCt4
	 BiGQ3+Xw27E6/O3ThhcLX+kyLtkW7KTQKap0Pb7yxHcm5HmZ/Sw5bJKdeXMgGR7hqxH3p
	 HUlbKv7tje5zoAJFX+vGQEHVCMFTdLNSQRnaxhVX2XwoRrq8PK8Gbc8aiuHWoss+shw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=htS9Ycuo;
	arc=none smtp.remote-ip=91.218.175.168
Received: from mta0.migadu.com (out-168.mta0.migadu.com [91.218.175.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E6606A32F
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F1E6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=htS9Ycuo
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=idrx1+pSwX5dehPW1uaeLDFB1jBSGVoEDx979cdcMgg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793729925; v=1; x=1794334725;
 b=htS9YcuoEF1+d4dff4xW+K4BUxPSvItTHHJ19FIGu3WNgFHIgunv6F8k+Hpgmu6ZONGnIkb+
 IVCa9/jVF7rUjoJHQeuCLggXvRc0q8vgPOuRidvNhs6TaumVoZ507wxg8gpX61+EJkbcVnCfsDY
 fsIrtwIpgBFsHlCr+iqZ/3ms=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 827926e958662169;
	Tue, 03 Nov 2026 18:18:45 +0000
X-Mizu-Trace-ID: 827926e958662169
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
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
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jose.marchesi@oracle.com,
	david.faust@oss.qualcomm.com,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v4 3/8] selftests/bpf: make arena_base() opaque to GCC's -Warray-bounds
Date: Tue,  3 Nov 2026 10:18:11 -0800
Message-ID: <20261103181816.254686-4-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103181816.254686-1-vineet.gupta@linux.dev>
References: <20261103181816.254686-1-vineet.gupta@linux.dev>
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

arena_base() casts the map definition to the kernel's struct bpf_arena
and reads user_vm_start out of it. In the object file that definition
is only the 32-byte BTF placeholder the loader rewrites, so the access
is past the end of the object which GCC correctly complaints about and
due to -Werror leads to build failure:

  libarena/include/bpf_arena_common.h:52:69: error: array subscript 'struct bpf_arena[0]' is partly outside array bounds of 'struct <anonymous>[1]' [-Werror=array-bounds=]
     52 | #define arena_base(map) ((void __arena *)((struct bpf_arena *)(map))->user_vm_start)
  progs/arena_race.c:58:30: note: in expansion of macro 'arena_base'

progs/stream.c already solved this for its own open-coded copy of the
access, with barrier_var(), for both the compilers. Do the same in
arena_base() itself so all such uses are fixed.

No test changes verdict; this only lets the objects build.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3 -> v4: was 4/8. barrier_var() for both compilers rather than
behind #ifdef __clang__, and stream.c's five open-coded copies of the
access fold back into the macro. (Alexei)

 .../bpf/libarena/include/bpf_arena_common.h   | 11 +++-
 tools/testing/selftests/bpf/progs/stream.c    | 56 +++----------------
 2 files changed, 18 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
index 82aafe879fae..0eba52961405 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
@@ -49,7 +49,16 @@ void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cn
 int bpf_arena_reserve_pages(void *map, void __arena *addr, __u32 page_cnt) __ksym __weak;
 void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;
 
-#define arena_base(map) ((void __arena *)((struct bpf_arena *)(map))->user_vm_start)
+/*
+ * The map definition is smaller than struct bpf_arena.
+ * barrier_var() hides that from -Warray-bounds of GCC.
+ */
+#define arena_base(map)							\
+	({								\
+		struct bpf_arena *___arena = (void *)(map);		\
+		barrier_var(___arena);					\
+		(void __arena *)___arena->user_vm_start;		\
+	})
 
 #else /* when compiled as user space code */
 
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 1ae015c4e6b4..b4d88d0e01ad 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -178,16 +178,8 @@ __stderr("Call trace:\n"
 "|[ \t]+[^\n]+\n)*}}")
 int stream_arena_write_fault(void *ctx)
 {
-	struct bpf_arena *ptr = (void *)&arena;
-	u64 user_vm_start;
+	u64 user_vm_start = (u64)arena_base(&arena);
 
-	/* Prevent GCC bounds warning: casting &arena to struct bpf_arena *
-	 * triggers bounds checking since the map definition is smaller than struct
-	 * bpf_arena. barrier_var() makes the pointer opaque to GCC, preventing the
-	 * bounds analysis
-	 */
-	barrier_var(ptr);
-	user_vm_start = ptr->user_vm_start;
 	fault_addr = user_vm_start + 0x7fff;
 	bpf_addr_space_cast(user_vm_start, 0, 1);
 	asm volatile (
@@ -212,16 +204,8 @@ __stderr("Call trace:\n"
 "|[ \t]+[^\n]+\n)*}}")
 int stream_arena_read_fault(void *ctx)
 {
-	struct bpf_arena *ptr = (void *)&arena;
-	u64 user_vm_start;
+	u64 user_vm_start = (u64)arena_base(&arena);
 
-	/* Prevent GCC bounds warning: casting &arena to struct bpf_arena *
-	 * triggers bounds checking since the map definition is smaller than struct
-	 * bpf_arena. barrier_var() makes the pointer opaque to GCC, preventing the
-	 * bounds analysis
-	 */
-	barrier_var(ptr);
-	user_vm_start = ptr->user_vm_start;
 	fault_addr = user_vm_start + 0x7fff;
 	bpf_addr_space_cast(user_vm_start, 0, 1);
 	asm volatile (
@@ -252,17 +236,9 @@ int stream_arena_load_acquire_fault(void *ctx)
 		.off	 = 0x7fff,
 		.imm	 = 0x100,	/* BPF_LOAD_ACQ */
 	};
-	struct bpf_arena *ptr = (void *)&arena;
-	u64 user_vm_start, val;
+	u64 user_vm_start = (u64)arena_base(&arena);
+	u64 val;
 
-	/*
-	 * Prevent GCC bounds warning: casting &arena to struct bpf_arena *
-	 * triggers bounds checking since the map definition is smaller than
-	 * struct bpf_arena. barrier_var() makes the pointer opaque to GCC,
-	 * preventing the bounds analysis.
-	 */
-	barrier_var(ptr);
-	user_vm_start = ptr->user_vm_start;
 	fault_addr = user_vm_start + 0x7fff;
 	bpf_addr_space_cast(user_vm_start, 0, 1);
 	asm volatile (
@@ -296,17 +272,9 @@ int stream_arena_xchg_fault(void *ctx)
 		.off	 = 0x7fff,
 		.imm	 = 0xe1,	/* BPF_XCHG */
 	};
-	struct bpf_arena *ptr = (void *)&arena;
-	u64 user_vm_start, val;
+	u64 user_vm_start = (u64)arena_base(&arena);
+	u64 val;
 
-	/*
-	 * Prevent GCC bounds warning: casting &arena to struct bpf_arena *
-	 * triggers bounds checking since the map definition is smaller than
-	 * struct bpf_arena. barrier_var() makes the pointer opaque to GCC,
-	 * preventing the bounds analysis.
-	 */
-	barrier_var(ptr);
-	user_vm_start = ptr->user_vm_start;
 	fault_addr = user_vm_start + 0x7fff;
 	bpf_addr_space_cast(user_vm_start, 0, 1);
 	/*
@@ -346,17 +314,9 @@ int stream_arena_cmpxchg_fault(void *ctx)
 		.off	 = 0x7fff,
 		.imm	 = 0xf1,	/* BPF_CMPXCHG */
 	};
-	struct bpf_arena *ptr = (void *)&arena;
-	u64 user_vm_start, val;
+	u64 user_vm_start = (u64)arena_base(&arena);
+	u64 val;
 
-	/*
-	 * Prevent GCC bounds warning: casting &arena to struct bpf_arena *
-	 * triggers bounds checking since the map definition is smaller than
-	 * struct bpf_arena. barrier_var() makes the pointer opaque to GCC,
-	 * preventing the bounds analysis.
-	 */
-	barrier_var(ptr);
-	user_vm_start = ptr->user_vm_start;
 	fault_addr = user_vm_start + 0x7fff;
 	bpf_addr_space_cast(user_vm_start, 0, 1);
 	/*
-- 
2.53.0-Meta

