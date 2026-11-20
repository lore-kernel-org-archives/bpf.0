Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160938;
	b=11tmqiuDn0FZLVMLxvQk9tOqphqIlTSO9fAvB47J9/dxVpaI9InTm9a0efA03Zoz2bPI
	 Mf39rlMOLV12n7Xc/lwbKeK43GuBGcB1f6u//PRw1TizTK1AT50RUFfQuhLgGvijz4FpG
	 Kf4VSp7+F+KoD2yDba0tDA+kIUNy/5RAY+XIcatnV6xJyFfPjc7NfQqIU8OD/YqXou0TS
	 iIb3hzdBWhwHTd0W0KoFWZLMhIg7cIdZwGk/UPTGHJqkF0Xzjcr6LPcwtRJXo0oqFSnJ1
	 p8WzmOpUrjrW0vKojicNuq+RABeGpbGJjpSY27WnHjzVJ8qhb3imHIMmTm+PoZbvUnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2o7XLLTNuOUE6dMMjbxx6J51la+/U620OIeL7rP+S54=;
	b=mnay9vDdt+5KrYuahb/RN1PJRtAiuMPXgRQvjAc/vk+Ener5uw2ASCO6u/njtXOditma
	 VTRBoCrK0NsM+WKAD8mApHXFhuo3+d6sGE/pb5P2A8LbtpbIOi9v47utUwNNHYeGabNVD
	 kul9vUiWpxXH7PRe7CnkknDk5ufXzQmRUmN1a2eI2BqTgF1aDAxrjlFlJeVScjyajKxD/
	 9U6rHeDfXP78lem+vXy+8L79tGyE5kupLEOtAElXZiBGfBqhmjn/JlWzei6NwSaJOpJYY
	 QvrYO6f5313HlsoSloS97FcEl9v5zPMh8s3DXyAmRRwqe4KOvLneedzyqF3dHRAf3Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f9A3QWHa;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD8606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12AD8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f9A3QWHa
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f0426a65e0so3491095ad.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160937; x=1795765737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2o7XLLTNuOUE6dMMjbxx6J51la+/U620OIeL7rP+S54=;
        b=f9A3QWHaJeh9RBCmvkgrLgq7GuLiD1sGwV1R5RpOQuNUu++0M4GemvGPAQeVmHbjdS
         cLz9drwQaX+NZa5u/PsMn029CwOyqqOkt8+VYHOnoMAEXHgwtOTFadGbNSoOrNKoDv0F
         8R2vtU9apXMUMGICvzUgGBaJvUU8381N1HpC9WGroFHGu4vRjG20lLwlaxKVwRHEEJrh
         MGt+6FmglAVgch2VcJdNiOl3AFTcdQgoMVBQR97luYz4GXkKuAlDnQVfwjDSqZEvx7tR
         wLeHcu5uWvi5QGKPIS/iS5MT6xST5AEraHH65rYhEFmdTzASzqq4LGtZSsEcRGyNb2+8
         4CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160937; x=1795765737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2o7XLLTNuOUE6dMMjbxx6J51la+/U620OIeL7rP+S54=;
        b=AxTpEGwMEdUam5ckm7Dm9+meF7ebmaARmHbB29cpFYMxmWlZtGW1vo+Glt0buiAmPL
         ICCs/7LNgMoZBbPtRwzhza3LbZsDmAIcKdK5JQbPkAV6O8+x+cpn4J6hvjyvxoDIoEMv
         oS2XAKJQGuNM5HO4MFkN9OQUaepk/7ikw4+jD85/GyiwDO83fl16Xufe3uOgq95LznEV
         ykbxQ0oChPTvU0C5jg6TuZNkygJl/UrLn2aPxdV2niD3nwNp9ciQGoiv/PNtM1xDZyy1
         yu1+QDiwWlUuwRCAp00a6ykB93fCcE8IDuVdmgDGOe0nTycK/mteyvEu4QgQ9rf/Y2kF
         932Q==
X-Gm-Message-State: APuU4Z/2wDtplt12a92hbHlaemzfa8qMvD0A1OARqdEGNXSDifYs917j
	rN1sHy43MCjarszxTXbpWXVU3Vu/CEcOw+6W9RRbgPm4Sz2KLejI9jsQZZgJ4Q==
X-Gm-Gg: AZFdTZdONPBBUEc5Gqp05DXLCYrmOHeOu9b5YEgDBH8XQChG6sDoorSkad4+AzEtdD7
	CCWKb5+Lni8TlhsMX4to1QkP1Dd6ZJ3Z/KE5J9C5Ri5GSVWKvzqHLuh8CK+CXGFCBMlEknDiJJ6
	aUc/nqT3fV1xU6bYnCoBth4XF5SdMXzic582DsNfCG09Qh3ELq+2VsPUGCs5TcpBwTYzqGzfuxY
	R1Row6YOzt1X4F4XQwhzbhvMOHmq+Tb7EywxjsGW5tPlqz2xFeiq7YvcoRQlNzcjEfVeDmaLClP
	PFR/S7+UiMzn8XQc+EK+fvMrBC1+7/LXpPFtPkymuK3Nml+p8c0j4hdSo6ZQm+rQERP/0hR3TyW
	MRCzlYIY2Rp815ISIT13z9HdDowzGZW/ybLPS+vF3/Al4FvPuFEX6jdLvpc6gyal5KOFbZ4DFtE
	WGDG5UMAz8cPNWj7xspVk7CW5C5WiPDCpxF+ZsiZ0e2GpXo9oJxbYXVsTL1+KDSVPgBycFh1/dj
	RnjfQ63XKadWOUjrWgsIkmOeogS/VaJo/DNZaQzMipFA0LP2CP9XiwGP1hpLZkSq4up22oKCqV/
	3fkkxKQP7RNmvx53I/f7HHTxyilCEQVsEawedOutzTM+u4nnECfj+yJ2wqRX1WnErKRP3cR4D/I
	fgR4WzXRrS2Msyerm3yX6EkVTsjQ451ZmU/0KwI7Rz9wkrVUt94/O/+t6a9DzyZwRfzc1gbDHfw
	==
X-Received: by 2002:a17:902:7790:b0:2f0:2e6d:f2f7 with SMTP id d9443c01a7336-2f03f1d85d6mr16720875ad.17.1795160937098;
        Thu, 19 Nov 2026 23:48:57 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1f42sm10570145ad.25.2026.11.19.23.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:48:56 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 45/49] selftests/bpf: Adjust tests that get another verdict or may_goto
Date: Fri, 20 Nov 2026 07:42:17 +0000
Message-ID: <20261120074430.2704488-46-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Programs that were rejected and load now:
- Unprivileged 'ptr += reg' gets a barrier or one mask for the joined
  range. The tests check the xlated insns.
- conditional_assignment_on_second_iteration: the read is unproven in
  pass 0. A later pass peels the trips, and no trip gets to the read.
- from_stack_in_small_chunks, partial_fill_from_cleaned_pointer_spill:
  a load of a part of a spilled pointer. They load with CAP_PERFMON and
  are rejected without it, as before.
- to_leak_tainted_dst_reg: a far pointer is no error. It loads with
  CAP_PERFMON and is rejected without it, as before.
- test_get_stack_rawtp: the buffer is not two times larger any more.
- New: callback_full_frame, an arena stack entry with a full frame.
- Four programs are safe. Each gets an unsafe twin:

  pointer_minus_index              p + 63 - i, i is 0..63
  callee_writes_memory_of_caller   tests x <= 63, stores x / 2
  callee_writes_through_alias      the same through a second pointer
  pkt_add_negative                 data + 20 + (-4..4), 54 bytes checked

Programs that load as before and get may_goto: the loop has no trip
count, and no error asks to peel it.

  do { r8 += 1; r7 <<= 1; } while (r7 != 0x400);

One program is rejected now. clang makes one call of bpf_obj_drop()
for two types in local_kptr_stash.c:

  if (...) r8 = plain_local;      no special field
  else     r8 = node_data;        a kptr
  r1 = r8
  call bpf_obj_drop

Declare bpf_obj_drop() with nomerge, as struct_ops_refcounted.c does
for bpf_task_release().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/local_kptr_stash.c    |  3 +
 .../bpf/progs/test_get_stack_rawtp.c          | 20 +-----
 .../bpf/progs/verifier_arena_stack.c          | 55 ++++++++++++++++
 .../bpf/progs/verifier_bounds_deduction.c     | 14 ++--
 .../selftests/bpf/progs/verifier_budget.c     |  9 ++-
 .../bpf/progs/verifier_direct_packet_access.c | 34 ++++++++--
 .../selftests/bpf/progs/verifier_loop_walk.c  |  8 ++-
 .../selftests/bpf/progs/verifier_map_ptr.c    | 18 +++--
 .../selftests/bpf/progs/verifier_spill_fill.c | 18 ++---
 .../selftests/bpf/progs/verifier_trip_count.c | 26 +++++---
 .../selftests/bpf/progs/verifier_unpriv.c     |  3 +-
 .../bpf/progs/verifier_value_ptr_arith.c      | 66 +++++++++++++++----
 12 files changed, 201 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
index d736506a4c8..d86ae65abe6 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -8,6 +8,9 @@
 #include "../bpf_experimental.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
+/* Do not make one call for the drop of plain_local and the drop of node_data */
+__attribute__((nomerge)) extern void bpf_obj_drop(void *p) __weak __ksym;
+
 struct plain_local;
 
 struct node_data {
diff --git a/tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c b/tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c
index b6a6eb279e5..41714c2182f 100644
--- a/tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c
+++ b/tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c
@@ -29,29 +29,11 @@ struct {
 	__type(value, struct stack_trace_t);
 } stackdata_map SEC(".maps");
 
-/* Allocate per-cpu space twice the needed. For the code below
- *   usize = bpf_get_stack(ctx, raw_data, max_len, BPF_F_USER_STACK);
- *   if (usize < 0)
- *     return 0;
- *   ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
- *
- * If we have value_size = MAX_STACK_RAWTP * sizeof(__u64),
- * verifier will complain that access "raw_data + usize"
- * with size "max_len - usize" may be out of bound.
- * The maximum "raw_data + usize" is "raw_data + max_len"
- * and the maximum "max_len - usize" is "max_len", verifier
- * concludes that the maximum buffer access range is
- * "raw_data[0...max_len * 2 - 1]" and hence reject the program.
- *
- * Doubling the to-be-used max buffer size can fix this verifier
- * issue and avoid complicated C programming massaging.
- * This is an acceptable workaround since there is one entry here.
- */
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(max_entries, 1);
 	__type(key, __u32);
-	__type(value, __u64[2 * MAX_STACK_RAWTP]);
+	__type(value, __u64[MAX_STACK_RAWTP]);
 } rawdata_map SEC(".maps");
 
 SEC("raw_tracepoint/sys_enter")
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_stack.c b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
index b46e30a9c67..4feaebf0d72 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
@@ -737,6 +737,61 @@ __naked void callback(void)
 	: __clobber_all);
 }
 
+static __naked __noinline __used long add_index_cb(void)
+{
+	asm volatile (
+	"r3 = *(u64 *)(r2 + 0);"
+	"r3 += r1;"
+	"*(u64 *)(r2 + 0) = r3;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* takes a stack in arena, has all of its own frame in use, and bpf_loop() is inlined */
+static __naked __noinline __used long full_frame_cb(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[stx16];"	/* *(u64 *)(r12 - 16) = r1 */
+	"*(u64 *)(r10 - %[depth]) = r1;"
+	"r3 = r2;"
+	"r1 = 3;"
+	"r2 = add_index_cb ll;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_loop), __imm_const(depth, 2008),
+	  __imm_insn(adj, ADJ(16)),
+	  __imm_insn(stx16, STX(BPF_DW, -16, BPF_REG_1))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: the arguments of a callback need no room of their own")
+__success __retval(6)
+__xlated("*(u64 *)(r10 -16) = r2")
+__xlated("*(u64 *)(r10 -24) = r3")
+__naked void callback_full_frame(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = 2;"
+	"r2 = full_frame_cb ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_loop)
+	: __clobber_all);
+}
+
 /* has no frame: its first insn is the call, not r12 += N */
 static __naked __noinline __used long calls_loop_cb(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
index 14e10760606..63baf2fc61f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
@@ -21,8 +21,11 @@ l0_%=:	r0 -= r1;					\
 
 SEC("socket")
 __description("check deducing bounds from const, 2")
-__success __failure_unpriv
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__success __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("nospec")
+__xlated_unpriv("r1 -= r0")
+#endif
 __retval(1)
 __naked void deducing_bounds_from_const_2(void)
 {
@@ -53,8 +56,11 @@ l0_%=:	r0 -= r1;					\
 
 SEC("socket")
 __description("check deducing bounds from const, 4")
-__success __failure_unpriv
-__msg_unpriv("R6 has pointer with unsupported alu operation")
+__success __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("nospec")
+__xlated_unpriv("r6 -= r0")
+#endif
 __retval(0)
 __naked void deducing_bounds_from_const_4(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_budget.c b/tools/testing/selftests/bpf/progs/verifier_budget.c
index 890b316166c..1bef19db503 100644
--- a/tools/testing/selftests/bpf/progs/verifier_budget.c
+++ b/tools/testing/selftests/bpf/progs/verifier_budget.c
@@ -1874,14 +1874,17 @@ __naked void may_goto_stays_in_the_loop(void)
 	);
 }
 
-/* No state is within another one: the walk gets to the end of the loop, no may_goto */
+/* The loop has no trip count and no error asks for peeling: may_goto is added */
 SEC("socket")
 __description("budget: ten trips that differ")
 __success __retval(10) __log_level(2)
-__msg("processed 34 insns")
+__msg("processed {{[0-9][0-9]}} insns")
 __xlated("r8 += 1")
 __xlated("r7 <<= 1")
-__xlated("if r7 != 0x400 goto pc-3")
+__xlated("...")
+__xlated("if r13 == 0x0 goto")
+__xlated("...")
+__xlated("if r7 != 0x400 goto pc-{{[0-9]+}}")
 __naked void ten_trips_that_differ(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index 7c3dc9643eb..7c29ffed743 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -1060,16 +1060,36 @@ __naked void pkt_add_unknown_keeps_range(void)
 		     "r0 = *(u64*)(r2 + 8);");
 }
 
+#define PKT_ADD_NEGATIVE(off)						\
+	PKT_54_BYTES("if r4 > 8 goto l0_%=;"				\
+		     "r4 += -4;"					\
+		     "r2 += " #off ";"					\
+		     "r2 += r4;"					\
+		     "r0 = *(u8*)(r2 + 0);")
+
+/* The offset is 20 + (-4..4) = 16..24. 54 bytes are checked from the start of the packet. */
 SEC("tc")
 __description("direct packet access: checked pointer plus unknown that may be negative")
-__failure __msg("invalid access to packet, off=16 size=1, R2(id={{[0-9]+}},off=16,r=0)")
-__naked void pkt_add_negative_clears_range(void)
+__success __retval(0)
+__naked void pkt_add_negative(void)
 {
-	PKT_54_BYTES("if r4 > 8 goto l0_%=;"
-		     "r4 += -4;"
-		     "r2 += 20;"
-		     "r2 += r4;"
-		     "r0 = *(u8*)(r2 + 0);");
+	PKT_ADD_NEGATIVE(20);
+}
+
+SEC("tc")
+__description("direct packet access: the same before the packet")
+__failure __msg("R2 min value is negative")
+__naked void pkt_add_negative_below(void)
+{
+	PKT_ADD_NEGATIVE(3);
+}
+
+SEC("tc")
+__description("direct packet access: the same after what is checked")
+__failure __msg("invalid access to packet")
+__naked void pkt_add_negative_above(void)
+{
+	PKT_ADD_NEGATIVE(50);
 }
 
 /* The byte is in the packet, but a range that umax gets to is not kept */
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_walk.c b/tools/testing/selftests/bpf/progs/verifier_loop_walk.c
index 4baf4717591..cd834d776d8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_walk.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_walk.c
@@ -65,17 +65,19 @@ WALKS(walks_32, 11)
 
 /*
  *	for (i = 7; i >= 0; i--) { if (i >= n) continue; a[i] = 0; }
- * A compiler tests 'i >= n' in front of the loop too and jumps into the middle of it. Such a loop
- * has no count. It's walked to its end whichever way its jumps go: no may_goto is added.
+ * A compiler tests 'i >= n' before the loop too and jumps into the middle of it. Such a loop
+ * has no trip count, so may_goto is added.
  */
 SEC("socket")
 __description("walk: a loop with two entries")
 __success __retval(0)
 __arch_x86_64
 __arch_arm64
+__xlated("if r13 == 0x0 goto")
+__xlated("...")
 __xlated("w3 += -1")
 __xlated("if w3 s< 0x0 goto pc+2")
-__xlated("if w3 < w2 goto pc-6")
+__xlated("if w3 < w2 goto pc-{{[0-9]+}}")
 __xlated("goto pc-4")
 __xlated("exit")
 __naked void two_entries(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
index e0a65835c86..43fd9e26c76 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -142,8 +142,13 @@ __naked void ptr_read_ops_field_accepted(void)
 
 SEC("socket")
 __description("bpf_map_ptr: r = 0, map_ptr = map_ptr + r")
-__success __failure_unpriv
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__success __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("r2 += -8")
+__xlated_unpriv("...")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r1 += r0")
+#endif
 __retval(0)
 __naked void map_ptr_map_ptr_r(void)
 {
@@ -166,8 +171,13 @@ __naked void map_ptr_map_ptr_r(void)
 
 SEC("socket")
 __description("bpf_map_ptr: r = 0, r = r + map_ptr")
-__success __failure_unpriv
-__msg_unpriv("R0 has pointer with unsupported alu operation")
+__success __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("r2 += -8")
+__xlated_unpriv("...")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r1 += r0")
+#endif
 __retval(0)
 __naked void _0_r_r_map_ptr(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 958ee0d6419..a7b11630eb6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1208,14 +1208,14 @@ __naked void old_stack_misc_vs_cur_scalar(void)
 }
 
 /*
- * stacksafe(): the state with STACK_MISC is there, the state with a stack spill
- * of a non-scalar arrives. A program that may read uninitialized stack may
- * take a pointer for a number: the second state is within the first one.
+ * One state has STACK_MISC, the other one has a stack spill of a non-scalar.
+ * The slot is live, so the states stay apart.
  */
 SEC("socket")
 __success  __log_level(2)
 __msg("8: (79) r1 = *(u64 *)(r10 -8)         ; R1=scalar()")
-__msg("processed 10 insns")
+__msg("8: (79) r1 = *(u64 *)(r10 -8)         ; R1=ctx()")
+__msg("processed 12 insns")
 __naked void old_stack_misc_vs_cur_ctx_ptr(void)
 {
 	asm volatile(
@@ -1233,7 +1233,7 @@ __naked void old_stack_misc_vs_cur_ctx_ptr(void)
 	"*(u64*)(r10 - 8) = r0;"
 	"lock *(u64*)(r10 - 8) += r0;"
 "2:"
-	/* read fp-8, it's looked at once */
+	/* read fp-8 */
 	"r1 = *(u64*)(r10 - 8);"
 	"exit;"
 	:
@@ -1399,11 +1399,11 @@ __naked void var_off_write_over_scalar_spill(void)
 
 SEC("socket")
 __description("partial fill from cleaned pointer spill")
-__failure
+__success __caps_unpriv(CAP_BPF) __failure_unpriv
 __log_level(2)
-__msg("1: (05) goto pc+0")
-__msg("2: (61) r0 = *(u32 *)(r10 -4)")
-__msg("invalid size of register fill")
+__msg_unpriv("1: (05) goto pc+0")
+__msg_unpriv("2: (61) r0 = *(u32 *)(r10 -4)")
+__msg_unpriv("invalid size of register fill")
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void partial_fill_from_cleaned_pointer_spill(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_trip_count.c b/tools/testing/selftests/bpf/progs/verifier_trip_count.c
index c8e3ddbc530..69288309ef0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_trip_count.c
+++ b/tools/testing/selftests/bpf/progs/verifier_trip_count.c
@@ -2751,13 +2751,13 @@ __naked void uninit_slot_counter(void)
  *
  * R7 is always 10 at the real exit. Widening loses the correlation between
  * R6 and R7, leaving R7 in [5, 10] both at the loop header and after the loop.
- * The verifier therefore rejects the possible invalid stack read.
+ * Pass 0 does not prove the read. A later pass peels the trips and does not get to it.
  */
 SEC("xdp")
-__failure
+__success __retval(0)
 __log_level(2)
-__msg("2: {{.*}}R7=scalar(smin=umin=smin32=umin32=5,smax=umax=smax32=umax32=10,var_off=(0x0; 0xf))")
-__msg("7: R7=scalar(smin=umin=smin32=umin32=5,smax=umax=smax32=umax32=10,var_off=(0x0; 0xf))")
+__msg("2: {{.*}}R7=scalar(smin=umin=smin32=umin32=5,smax=umax=smax32=umax32=10,var_off=(0x0; 0xf)")
+__msg("7: R7=scalar(smin=umin=smin32=umin32=5,smax=umax=smax32=umax32=10,var_off=(0x0; 0xf)")
 __msg("invalid read from stack R10 off=0 size=8")
 __naked void conditional_assignment_on_second_iteration(void)
 {
@@ -3387,9 +3387,11 @@ LINKED(dividend_tested, VALID,
 LINKED(operand_is_overwritten, MAP_OOB,
 	"r9 = r7; r9 *= 8; call %[bpf_get_prandom_u32]; r7 = r0; r7 &= 255;"
 	"if r7 > 7 goto out_%=; r1 = r6; r1 += r9;")
-/* a pointer is evaluated below an add only */
-LINKED(pointer_minus_index, __failure,
+/* r7 is 0..63, so 63 - r7 is 0..63 */
+LINKED(pointer_minus_index, VALID,
 	"r1 = r6; r1 += 63; r1 -= r7; if r7 > 63 goto out_%=;" USE_R6)
+LINKED(pointer_minus_index_oob, __failure __msg("R1 min value is"),
+	"r1 = r6; r1 += 63; r1 -= r7; if r7 > 64 goto out_%=;" USE_R6)
 /* r3 is an address as a scalar. r6 + r7 * 2 has the offset [0, 14]: that is not the range of r3 */
 LINKED(offset_of_pointer_is_not_scalar, UNBOUND,
 	"r2 = r7; r2 *= 2; r5 = r6; r5 += r2; r3 = r5; r3 = le64 r3; if r7 > 7 goto out_%=;"
@@ -3418,14 +3420,17 @@ static __naked __noinline __used void name(void)				\
 	"if r3 <= 63 goto +2; r3 = 0; *(u64 *)(r1 + 0) = r3; r0 = 0; exit;"	\
 	::: __clobber_all);							\
 }
-#define CALL(callee)								\
-	"*(u64 *)(r10 - 16) = r8; r1 = r10; r1 += -16; r4 = r1; r2 = r8; r2 >>= 1;"	\
+#define CALL_R2(set_r2, callee)							\
+	"*(u64 *)(r10 - 16) = r8; r1 = r10; r1 += -16; r4 = r1;" set_r2		\
 	"call " #callee "; r2 = *(u64 *)(r10 - 16); r1 = r6; r1 += r2;"
+#define CALL(callee)	CALL_R2("r2 = r8; r2 >>= 1;", callee)
 
 CLAMP(clamp, "")
 LINKED(callee_tests_memory_of_caller, VALID, CALL(clamp))
 CLAMP(store_and_clamp, "*(u64 *)(r1 + 0) = r2;")
-LINKED(callee_writes_memory_of_caller, __failure, CALL(store_and_clamp))
+/* It tests r8 and stores r8 / 2. If r8 is 0..63 then r8 / 2 is 0..31. Else it stores 0. */
+LINKED(callee_writes_memory_of_caller, VALID, CALL(store_and_clamp))
+LINKED(callee_writes_memory_of_caller_oob, MAP_OOB, CALL_R2("r2 = r7;", store_and_clamp))
 /* a store defines the memory */
 CLAMP(store_and_test, "r3 = r2; *(u64 *)(r1 + 0) = r3;")
 LINKED(callee_tests_what_it_stored, VALID, CALL(store_and_test))
@@ -3434,7 +3439,8 @@ CLAMP(store_next_and_clamp, "*(u64 *)(r1 + 8) = r2;")
 LINKED(callee_writes_next_field, VALID, CALL(store_next_and_clamp))
 /* another address base can be another name of the memory */
 CLAMP(store_alias_and_clamp, "*(u64 *)(r4 + 0) = r2;")
-LINKED(callee_writes_through_alias, __failure, CALL(store_alias_and_clamp))
+LINKED(callee_writes_through_alias, VALID, CALL(store_alias_and_clamp))
+LINKED(callee_writes_through_alias_oob, MAP_OOB, CALL_R2("r2 = r7;", store_alias_and_clamp))
 static __naked __noinline __used void clamp_through_r0(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index 7b1f830e5e2..2d5a0263853 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -286,8 +286,7 @@ __naked void mangle_pointer_on_stack_2(void)
 
 SEC("socket")
 __description("unpriv: read pointer from stack in small chunks")
-__failure __msg("invalid size")
-__failure_unpriv
+__success __failure_unpriv __msg_unpriv("invalid size")
 __naked void from_stack_in_small_chunks(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index 5a3893151f6..3deafc3a9e0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -41,8 +41,16 @@ struct {
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs const")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
+/*
+ * r1 is 2 or 3, the values have 16 or 48 bytes. The paths are joined. The mask passes 0..3
+ * and makes 0 of all other numbers, so the read is in the value, also in speculation.
+ */
+#ifdef SPEC_V1
+__xlated_unpriv("w13 = 3")
+__xlated_unpriv("...")
+__xlated_unpriv("r13 &= r1")
+#endif
 __retval(1)
 __naked void value_ptr_unknown_vs_const(void)
 {
@@ -79,8 +87,16 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr const vs unknown")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
+/*
+ * r1 is 2 or 3, the values have 16 or 48 bytes. The paths are joined. The mask passes 0..3
+ * and makes 0 of all other numbers, so the read is in the value, also in speculation.
+ */
+#ifdef SPEC_V1
+__xlated_unpriv("w13 = 3")
+__xlated_unpriv("...")
+__xlated_unpriv("r13 &= r1")
+#endif
 __retval(1)
 __naked void value_ptr_const_vs_unknown(void)
 {
@@ -117,8 +133,16 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr const vs const (ne)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
+/*
+ * r1 is 3 or 5, the values have 16 or 48 bytes. The paths are joined. The mask passes 0..5
+ * and makes 0 of all other numbers, so the read is in the value, also in speculation.
+ */
+#ifdef SPEC_V1
+__xlated_unpriv("w13 = 5")
+__xlated_unpriv("...")
+__xlated_unpriv("r13 &= r1")
+#endif
 __retval(1)
 __naked void ptr_const_vs_const_ne(void)
 {
@@ -406,8 +430,17 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: mixing value pointer and scalar, 1")
-__success __failure_unpriv
-__msg_unpriv("R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root")
+__success __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("goto pc+2")
+__xlated_unpriv("...")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r2 += r3")
+__xlated_unpriv("...")
+__xlated_unpriv("exit")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r0 = *(u8 *)(r0 +0)")
+#endif
 __retval(0)
 __naked void value_pointer_and_scalar_1(void)
 {
@@ -460,8 +493,17 @@ l4_%=:	/* fake-dead code; targeted from branch A to	\
 
 SEC("socket")
 __description("map access: mixing value pointer and scalar, 2")
-__success __failure_unpriv
-__msg_unpriv("R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root")
+__success __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("goto pc+2")
+__xlated_unpriv("...")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r2 += r3")
+__xlated_unpriv("...")
+__xlated_unpriv("exit")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r0 = *(u8 *)(r0 +0)")
+#endif
 __retval(0)
 __naked void value_pointer_and_scalar_2(void)
 {
@@ -1420,8 +1462,8 @@ l0_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: trying to leak tainted dst reg")
-__failure __msg("math between map_value pointer and 4294967295 is not allowed")
-__failure_unpriv
+__success
+__failure_unpriv __msg_unpriv("R2 pointer arithmetic of map value goes out of range")
 __naked void to_leak_tainted_dst_reg(void)
 {
 	asm volatile ("					\
-- 
2.55.0

