Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022956;
	b=BHorgHgfDtzWmNPTsk5ooJKIoX/jv6VD9M+ubZN95PdiATzQ2POnKlxxG1Na1RkusxEC
	 Vn8KU7YtPOUMLLc6fvELSFZQ7J/ZAuXYt1UtY3jZXim2tiYmnab2Qhuq35jXdQZM+Dxvd
	 PRk+gOFRWWorq1qFf3P9xT6oZ/A/AU/BFi1yumbuxLMLTTEQz/VJHM38G/XJ8zLJ2KqG5
	 Qut27xAPiW6YCsCLTqdyo0n31kF3lZwsMt1HTz7ctfHqmn1PYvPL24Y9Hw1kVZzw27lu8
	 igpAFyEjvMa45VjdqKzs6EHt1c+twkZlg3XuL9c/0TYZcC98WgG94pgCrBSGstpa3NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ejgg5dk6kBoLHasQOXXF+Ig5p0SCWEyfxGJ6HN8wKSM=;
	b=Ks1QgkVe8/rNAyV3CS0HKju5rHotvJ37dznCT7dEcvMb4X7SZBziU7+CUfmCvFAbdf2e
	 2SIGCoYFp/GZ/g7ml+A0kDc9KN7+nBjR1X0LCNwtTewL2UqNaFTapoNXYbosX2UN49yYl
	 Shi3/s0bxLyBNsZB/nJZHBt2fNsQBemQyLiC1VZQhd31y7X9XROu+ANAvuRX1dTRNwr0P
	 EUZC07S//SAGOrI/obwhL+8SNBeypPQ8HParSO/RdNhPyBi2JZoE2M34JXRSEd72vn2Hd
	 GWeHUl6w9DC3ByTaUkX2EdOeq/FXuDyBA7RyeDDPaTFszIG2zFdNpbicBmTpblBC9dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dFm/4TdA";
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51543606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51543606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dFm/4TdA
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb681de50eso508709a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022955; x=1794627755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ejgg5dk6kBoLHasQOXXF+Ig5p0SCWEyfxGJ6HN8wKSM=;
        b=dFm/4TdAOi4ALwEwfMFug2kqMrMVmnD7zyivE1fMVdyN8qT9gRSmeTWaoze+FIqWmG
         uWNHdM5YNsR+wL5YUmBETZhGP4D+smrNxFZ32S+UzPypTzU8mu7YFEe+MBdvFuerpJyI
         oxGr2BvpXwSXySKChBYllsxP9qUWjCLdzw/0EZaRJlK9AyINfEqvx3+p60Tbwj8+BQr2
         bvA+UPx3hVNJYTSsLe9UqWFKeKadslB0lUybf+pYM7eAD5N19z4z+q7+VcXj+g2qdNn4
         oByilzmMxBdFQjWfYHFfh+B0ad8RXB0X1PWQIpXVood1TEvnxK9aHWrysts4djNbntJ6
         KHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022955; x=1794627755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ejgg5dk6kBoLHasQOXXF+Ig5p0SCWEyfxGJ6HN8wKSM=;
        b=Yc0aBI0Sfr5vBQedcyPWGp3x0MR0I68MMCdDdFj8TSrcR1akqRR42JcngG3Sxs+Ef2
         ce82WLRbnZs3V8I+qxTxbrf+zM6aXhGtJ4AEhyGrSAJVYhNuK6OePGVixlhjyso/IJc+
         znZMHV+xs/AoASNeBGP0bP0X7Ckov7eRi4yHp9fGg+TUoy/4wmIcAlAnCHjPHuosGMRc
         89gBa396C1hrpXpZ4jIn1bF8uVNb6BpjWszDRaKBGudMzmlnxfm3P1adZnfDHz3FRf3L
         CyPuKhodQ8vEjt1ayv09s6EcGwwJaphx8YfuRXxSzOoQLIJLxHSrFY+jsq/NEdzgSeoL
         Ygkg==
X-Gm-Message-State: APuU4Z/M1vnAsi9jwZ5SIZ6fCVPKAgKEQLjlZlXjqOvLmldgEE/1LjVK
	X9A5xadY1/EjdGWMkR02waM1EPgSiorOdXR5fvV7J2QbGXNlSr+85axHUMXu/g==
X-Gm-Gg: AYBFou0VhgA70p/u8Mv+ejF+E//yObqNaQYe5lQyBnNpz3SnwZdrZSD2Yn6BzzMW+Sr
	7x1EzyxnsO6O3lblCGWLoBPgzUYQ/4NTr/5YnRLbZQKqvIn21TOsFBSlkHEWFARH6JkXJPS3yYd
	WBg/y0e6FInwXjG62qu2UDyCvyVS3urjoOXv1vfAEOywJiZqlFAS6ze9EOwAE/k1wma0CiRQ7Va
	oO01t4fVMPfwup/2htOitEEYvllwJ5HEW4S4wvLyoNsCv8cREh/5sFlTntc+I48t0VHKVl2KTZG
	J8khGL0rp4BMiyU3HoEHL/tgkOZm454pYxKLosVKvRmUC7+MQvxSLxdWvCeY8iTPs/ojtvdUyEu
	BNdgEKZgj+xFUqy2XSZDoPo5ZRM40WxZM4V35lh1ZYsVXQNE5IuyGDdPkknT6rthi2AehG4Wq8o
	V8tQXxPq46TmbmLBbLcL79c7dntUigeNhDfuLBQLr+xbkt949qG+jyiL2EIeQKTLdon9wlcA2hR
	u1BefJEyDy07+goYO5aGhysuXXsgbFpmHTel0asLjBl7o+T6ajIUdXNc9m4TrEMVE805FCrMjZp
	uA3O5Mo2b5npTZ4YVkonlvJDRl88uhta3B0O63dyYgPj5kgCMtp16KPdZLS7Nun1jgg3j5W3gXP
	ANZIZQDzKD2VcJUA9xgkOTak5GWWbaTPee8RflZPef5iVv8oyW85CkwlHmHZyXI1g66ZylWU4pZ
	s=
X-Received: by 2002:a17:90b:1f86:b0:3ab:ab5a:ef06 with SMTP id 98e67ed59e1d1-3b0db6d42ddmr4817724a91.12.1794022955258;
        Fri, 06 Nov 2026 19:42:35 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7e3dsm1594755a91.11.2026.11.06.19.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:42:34 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 45/46] selftests/bpf: Test pointers that become numbers and subprogs that return void
Date: Sat,  7 Nov 2026 03:37:53 +0000
Message-ID: <20261107033758.1547725-46-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

Three patches let an insn pass that was refused. The prog is rejected where
it uses the result for more than it is.

"bpf: Allow tail calls and LD_ABS in subprogs that return void":
verifier_tailcall.c, verifier_ld_ind.c. A subprog that returns void has
a tail call: it loads. Its caller counts on the 1 that the subprog leaves
in r0 when the tail call is not taken: rejected, r0 is what the other prog
returns. The same for LD_ABS, which returns 0 when it fails. A subprog that
returns a pointer is refused with the message of check_btf_func().

"bpf: A part of a pointer that is spilled is a number":
verifier_spill_fill.c. 4 bytes of ctx are spilled and filled: a number with
CAP_PERFMON, 'invalid size of register spill' without. Both halves are
spilled and filled as one: the value is that of ctx, a load through it is
rejected. ctx is spilled, then 4 bytes of ctx are stored over the spill:
the slot has the same bytes as before and is not a spilled pointer any
more.

"bpf: 32-bit add to a pointer and pointer op pointer make a number":
verifier_value_illegal_alu.c. 'w0 += 1' on a pointer to a map value loads
with CAP_PERFMON and is refused without. 'r1 = r10; r1 |= r10' has the
value of r10: a store through it is rejected.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_ld_ind.c     | 15 ++++
 .../selftests/bpf/progs/verifier_spill_fill.c | 47 +++++++++++++
 .../selftests/bpf/progs/verifier_tailcall.c   | 69 +++++++++++++++++++
 .../bpf/progs/verifier_value_illegal_alu.c    | 38 ++++++++++
 4 files changed, 169 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ld_ind.c b/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
index b31a5e558409..0071dc466668 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
@@ -319,6 +319,21 @@ __naked void ld_abs_void_subprog(void)
 	::: __clobber_all);
 }
 
+SEC("socket")
+__description("ld_abs: void return subprog, early exit on ld_abs failure")
+__failure __msg("R9 !read_ok")
+__naked void ld_abs_void_subprog_early_exit(void)
+{
+	asm volatile (
+	"call ldabs_void_subprog;"
+	"if r0 != 0 goto l_exit_%=;"
+	"r0 = r9;"
+	"l_exit_%=:"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 __naked __noinline __used
 static void ldind_void_subprog(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 34c551f97e61..0baa8e06b8d1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -171,6 +171,53 @@ __naked void check_corrupted_spill_fill_msb(void)
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("32-bit spill of a pointer")
+__success __failure_unpriv __msg_unpriv("invalid size of register spill")
+__retval(0)
+__naked void spill_32bit_of_pointer(void)
+{
+	asm volatile ("					\
+	*(u32*)(r10 - 8) = r1;				\
+	r0 = *(u32*)(r10 - 8);				\
+	r0 -= r0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("32-bit spills of both halves of a pointer")
+__failure __msg("R0 invalid mem access 'scalar'")
+__failure_unpriv __msg_unpriv("invalid size of register spill")
+__naked void spill_32bit_of_pointer_twice(void)
+{
+	asm volatile ("					\
+	*(u32*)(r10 - 8) = r1;				\
+	r1 >>= 32;					\
+	*(u32*)(r10 - 4) = r1;				\
+	/* R0 has the value of R1(ctx). It's a number */\
+	r0 = *(u64*)(r10 - 8);				\
+	r0 = *(u32*)(r0 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("32-bit spill of a pointer over its 64-bit spill")
+__failure __msg("R0 invalid mem access 'scalar'")
+__failure_unpriv __msg_unpriv("attempt to corrupt spilled")
+__naked void spill_32bit_of_pointer_over_spill(void)
+{
+	asm volatile ("					\
+	*(u64*)(r10 - 8) = r1;				\
+	/* the same bytes. The spill of R1(ctx) is gone */\
+	*(u32*)(r10 - 8) = r1;				\
+	r0 = *(u64*)(r10 - 8);				\
+	r0 = *(u32*)(r0 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
 SEC("tc")
 __description("Spill and refill a u32 const scalar.  Offset to skb->data")
 __success __retval(0)
diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall.c b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
index 5ba41dca35ea..81be4ef8c321 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
@@ -50,6 +50,75 @@ static int subprog_tail_call(void)
 	: __clobber_all);
 }
 
+__used __naked
+static void void_subprog_tail_call(void)
+{
+	asm volatile ("			\
+	r2 = %[jmp_table] ll;		\
+	r3 = 0;				\
+	call %[bpf_tail_call];		\
+	r0 = 1;				\
+	exit;				\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(jmp_table)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("tail call in a subprog that returns void")
+__success
+__naked void tail_call_in_void_subprog(void)
+{
+	asm volatile ("			\
+	call void_subprog_tail_call;	\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+/* r0 is what the other program returns when the tail call is taken */
+SEC("tc")
+__description("tail call in a subprog that returns void, the caller counts on r0")
+__failure __msg("R9 !read_ok")
+__naked void tail_call_in_void_subprog_r0(void)
+{
+	asm volatile ("			\
+	call void_subprog_tail_call;	\
+	if r0 == 1 goto +1;		\
+	r0 = r9;			\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+__used __naked
+static void *ptr_subprog_tail_call(void)
+{
+	asm volatile ("			\
+	r2 = %[jmp_table] ll;		\
+	r3 = 0;				\
+	call %[bpf_tail_call];		\
+	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(jmp_table)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("tail call in a subprog that returns a pointer")
+__failure __msg("tail_call is only allowed in functions that return 'int' or 'void'")
+__naked void tail_call_in_ptr_subprog(void)
+{
+	asm volatile ("			\
+	call ptr_subprog_tail_call;	\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
 /* The exception callback has no ctx, so its tail call can only be dead code */
 __used __noinline
 int exception_cb_tail_call(__u64 cookie)
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
index 455f2399492b..2fcc0d08f9e7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -330,6 +330,44 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("32-bit add to a pointer")
+__success __retval(0)
+__failure_unpriv __msg_unpriv("R0 32-bit pointer arithmetic prohibited")
+__naked void ptr_add32(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	w0 += 1;					\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("or of two pointers")
+__failure __msg("R1 invalid mem access 'scalar'")
+__failure_unpriv __msg_unpriv("R1 pointer |= pointer prohibited")
+__naked void ptr_or_ptr(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 |= r10;					\
+	r0 = 0;						\
+	*(u64*)(r1 - 8) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
 SEC("flow_dissector")
 __description("flow_keys illegal alu op with variable offset")
 __failure __msg("R7 pointer arithmetic on flow_keys prohibited")
-- 
2.55.0

