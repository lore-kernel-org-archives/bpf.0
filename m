Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984027;
	b=wdPtXOT49pbxC4AhOL+C5/5T693nScb390wyIF02w43iQCsy7/GUgi83c4Tzu5LGnWza
	 +fBwjsYCEbOC62GDnmK5V05GLvyegDq6wLtX3P2hmfO71ppcEnKUZ64vrY5F7nTnYwtgP
	 5PcpBH+USs1mezEWf9nPIwjSJHKtiryv5cBjHwCvYDtN2ZIGT5QqP4hCRMEphKgPG+amW
	 kfPKN5RJHIaCqiBbQKi8nhbj/h5yIALhuikxRpuCPrBaNP89A/fY1EQqm1rPo3asRuJI9
	 a5BOoQOpMV1YfOYYmbF0Im0jvg+NHRY7SxcTbK4HP+M4aPaxJKJqF2snuG/TJlAE12A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SMI6anIJkk1KF7063TeZhbZndUi2b7iJar0c3O1AeM4=;
	b=PlbMzqZuMxyuaXHUicCWhsnnK5TBmbi7IYv2yr7GMuV1NI1I9gMpWPEMIhLyreDIjm2s
	 Dy4TPWYqNsYb3O1Q2zs/vwg6KfCgDFXycHQ8TETaXDHw1wDKaJGgTJcA7un9crBiMbCHP
	 35CF9RmZfR+hkLY+FIaGs6T9ypzaJuWz36h4cA7nsuLpytG90w+gSe5HZD/x/tmVrgMuJ
	 3I/fenJ94b/redmshiTRnNZIMoJ3aWY7vlkpoYuy+vPX6xZahAZGASY67554xY60vSdRV
	 hsLNby7BO2njQi0jYAuE1ekWlHkqFLg5cLLncXKgTAAdqaE5FKhOWKNECZNY4XCT+hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SLCTda6Y;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAFD606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CAFD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SLCTda6Y
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a264b6a06bso948564b3a.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984026; x=1793588826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMI6anIJkk1KF7063TeZhbZndUi2b7iJar0c3O1AeM4=;
        b=SLCTda6Yv7j5VybWVfqCOK1yZddAhEWhkmcTafLUmMx1T8iT94VeUQzY+HzTqpmJn9
         xnDLTKzJD98tJmijBmqXnbQBu4gzDTd3h8HUCKYeDJHmbCeZY8NIyZEeSitxBC5pgeCU
         oWJ+ALGa+VtCQ4j6MSPjr/VMZ7a9S+Z/TJm3O3KNyPGcckKEuy9uXXDwU6FSCp7apK2w
         NSz7MfpiPXMF2mlswv3CRjRLMS2urevmJJp4x2m5yvthrp1nl0w24Z5j9TQuxQUaosTA
         9k/k8g0MEjEW6mxVTtoRFEhqGfnvjjQcl9lswG5WpGqAtC+GO4mzxFtGCsWgwzBw10yn
         0nBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984026; x=1793588826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SMI6anIJkk1KF7063TeZhbZndUi2b7iJar0c3O1AeM4=;
        b=DNowYGQXuXT6q48L1gr0aiqb1wcYYlZGDu2R5TbACcdHiXjnGrzd3wso8swrMk1kUD
         JFFPBN1fvzqfbeTu38DLWblKFpps2tF2+KqjBHmTkEp8myqCokJU2yegOurLAfK1nzFE
         7wYd1oTboRuVu8putTZK2Iac5FDBJ0m5aQ3/dN4lazeGYOMlpQhyfhlwTDc3Tjrrfo75
         7d+56/Iy2XijgdBugSz8mdJPcYrCSUR3lx3VgNKqQJzHXQimID1FKcrOTzPlHYWQdL0r
         zPtbaK+nvMmwgseMDDh2IL/8YLkD9EjFv6AT+whLH1rEDLPUs0lDyNAFUdWjSZv4Tdqx
         FdfQ==
X-Gm-Message-State: AFq9FYJEmv0eLNHfmXegN8LBsjMKXpzcJs+Rkqz7FW/SvCz+a26U/QdU
	a+U1MgrQeMbdodSy210HUued/MAmvxlNYu2tq/MnBd8fRj3x70aQGRD235+6Pw==
X-Gm-Gg: AYBFou3rGfO/hyDc0G+BPg/O6nv7l98WAOdGK9G/C6HP6GgxMiEvbILhMzteAsz9ZQ7
	oBI7WWD5/eNkqyATR2mtjegBk33ofPGgweIuV3Q1GZKpj4xS3z0vuafYaM1F7Oku5WHz5yBJ/ie
	j96uJLXQvBGy8U5GSo2w3uBe9DQaexsE61iRRJGHOKdbZvAA6eTjoeR4GApnBIBtQ6rEAxotoN7
	CflthTY/QxM0ZwmcnrDqjn+ah9ftww9p6AnPIgsxlPvt42NQQnw6MC5Akiu5/DgSFKt9hi6ObPD
	d9zNAXeEeiq/UPd5E/HdrR82/FUpxpXcd9++asFKbRYXivypVYDTE6vykHo9JS7cGZ7R1Pf/nSU
	J+YkeepZsrG+U8Pbb4wWqlw2cRSkcqEs2J2aCLP7AXlRE+3bNfmv+MluAHlJkKGmIyx04SHpVsV
	qIatcakAYxlpHWiJzrkQEW4Fus7554C76m3zbBX45ocHBdy756mSD1Rw4buuT1LKqCHWkgNzVJE
	T0SeC5ON1BPCdrIojOKxzZ7bTNhn2Ji57W8xvoxOwK6WFPs6BOFWC01Vi4+DL6pBUXsYRKUhhtg
	9w0s33DRmRaFipW+bvHUD8X+cZW9pKP6HXqZo8KnQLiITJMzEyPDLOz0oZZNLpQXwRfAlaWkg5A
	069ICOKVj3xj8Ewnc2rO268QL
X-Received: by 2002:a05:6a00:189e:b0:87a:3144:8c4c with SMTP id d2e1a72fcca58-8a369c1f69emr4037160b3a.59.1792984025976;
        Sun, 25 Oct 2026 20:07:05 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36c4e8616sm880450b3a.56.2026.10.25.20.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:07:05 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 75/81] selftests/bpf: Adjust tests to the order of verification and to the log
Date: Mon, 26 Oct 2026 02:59:36 +0000
Message-ID: <20261026025943.404450-76-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The verifier followed one path of a prog to the exit, and it took the fall
through of each conditional jump first. Then it went back to the last jump
and followed the other branch. Now the verifier goes through the basic
blocks in reverse post order: it verifies a block after the blocks that
jump to it. The target of a conditional jump comes before the fall through.

                            before    now
  2: if r0 & r0 goto 5
  3: r0 = 0                 first     second
  4: exit
  5: r0 = 1                 second    first
  6: exit

No verdict of an existing test changes. But the verifier finds the other
error first in a prog that has errors on two paths. The log has the same
states in a different sequence. Each test gets one of these changes:
 - Remove the error that the test is not about.
 - Expect the other message or the new sequence.
 - Swap the two branches to keep the old sequence.

The format of the log changes too:
 - A state has only live registers. "0: R1=ctx() R10=fp0" becomes
   "0: R10=fp0".
 - The log has no mark_precise lines.
 - The statistics line has "limit 0", and it counts at least one state.

Add tests of maybe_fork_scalars() to verifier_bounds.c. When a register is
-1 or 0, this function splits the state in two before an 'and' or an 'or'
with a constant. The verifier continues with -1 and verifies a copy of the
state with 0 later.

At some insns the verifier keeps the states that arrive, and it drops a new
state that a kept state covers. [-1, 0] covers 0. Thus the copy must not go
back to such an insn. These insns are the insn where two paths meet, a loop
head, the first insn of a subprog and the insn after a call. The tests put
the 'and' or the 'or' at each of them. Only the copy makes an access out of
bounds, and the verifier must reject the prog.

One more prog has many forks in one basic block. The number of states must
not multiply.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/log_buf.c        |   4 +-
 .../selftests/bpf/prog_tests/log_fixup.c      |   6 +-
 .../selftests/bpf/prog_tests/reg_bounds.c     |   5 +-
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c |   4 +-
 .../selftests/bpf/progs/cpumask_failure.c     |   2 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |  16 +-
 .../selftests/bpf/progs/timer_failure.c       |   9 +-
 .../selftests/bpf/progs/verifier_align.c      |  10 +-
 .../selftests/bpf/progs/verifier_and.c        |   4 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 589 +++++++++++++++++-
 .../bpf/progs/verifier_helper_value_access.c  |   8 +-
 .../bpf/progs/verifier_subprog_insn_stats.c   |  16 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |  23 +-
 .../bpf/progs/verifier_unpriv_perf.c          |   4 +-
 14 files changed, 640 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/testing/selftests/bpf/prog_tests/log_buf.c
index d6f14a232002..4f821fdc4a02 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
@@ -125,7 +125,7 @@ static void obj_load_log_buf(void)
 	ASSERT_OK_PTR(strstr(libbpf_log_buf, "libbpf: prog 'bad_prog': -- BEGIN PROG LOAD LOG --"),
 		      "libbpf_log_correct");
 	ASSERT_STREQ(obj_log_buf, "", "obj_log__empty");
-	ASSERT_STREQ(good_log_buf, "processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n",
+	ASSERT_STREQ(good_log_buf, "processed 4 insns (limit 0) max_states_per_insn 1 total_states 1 peak_states 1 mark_read 0\n",
 		     "good_log_ok");
 	ASSERT_STREQ(bad_log_buf, "", "bad_log_empty");
 
@@ -179,7 +179,7 @@ static void bpf_prog_load_log_buf(void)
 	opts.log_level = 2;
 	fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "good_prog", "GPL",
 			   good_prog_insns, good_prog_insn_cnt, &opts);
-	ASSERT_OK_PTR(strstr(log_buf, "0: R1=ctx() R10=fp0"), "good_log_2");
+	ASSERT_OK_PTR(strstr(log_buf, "0: R10=fp0"), "good_log_2");
 	ASSERT_GE(fd, 0, "good_fd2");
 	if (fd >= 0)
 		close(fd);
diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
index 90a98e23be61..89a7f5947081 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -41,7 +41,7 @@ static void bad_core_relo(size_t log_buf_size, enum trunc_type trunc_type)
 				  "struct task_struct___bad.fake_field (0:1 @ offset 4)\n",
 				  "log_buf_part2");
 		ASSERT_HAS_SUBSTR(log_buf,
-				  "max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n",
+				  "max_states_per_insn 1 total_states 1 peak_states 1 mark_read 0\n",
 				  "log_buf_end");
 		break;
 	case TRUNC_PARTIAL:
@@ -50,7 +50,7 @@ static void bad_core_relo(size_t log_buf_size, enum trunc_type trunc_type)
 				  "struct task_struct___bad.fake_field (0:1 @ offset 4)\n",
 				  "log_buf_part2");
 		/* we shouldn't get full end of BPF verifier log */
-		ASSERT_NULL(strstr(log_buf, "max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n"),
+		ASSERT_NULL(strstr(log_buf, "max_states_per_insn 1 total_states 1 peak_states 1 mark_read 0\n"),
 			    "log_buf_end");
 		break;
 	case TRUNC_FULL:
@@ -58,7 +58,7 @@ static void bad_core_relo(size_t log_buf_size, enum trunc_type trunc_type)
 		ASSERT_NULL(strstr(log_buf, "struct task_struct___bad.fake_field (0:1 @ offset 4)\n"),
 			    "log_buf_part2");
 		/* we shouldn't get full end of BPF verifier log */
-		ASSERT_NULL(strstr(log_buf, "max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n"),
+		ASSERT_NULL(strstr(log_buf, "max_states_per_insn 1 total_states 1 peak_states 1 mark_read 0\n"),
 			    "log_buf_end");
 		break;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 7f170a69d1d8..d9e136720b49 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -1276,7 +1276,7 @@ static int parse_range_cmp_log(const char *log_buf, struct case_spec spec,
 		{true_pos + 1,  7, "R7=", true2_reg},
 	};
 	char buf[32];
-	const char *p = log_buf, *q;
+	const char *p, *q;
 	int i, err;
 
 	for (i = 0; i < 4; i++) {
@@ -1291,8 +1291,9 @@ static int parse_range_cmp_log(const char *log_buf, struct case_spec spec,
 		 * Different verifier passes may print
 		 *   18: (bf) r0 = r6
 		 * as well, but never followed by ';'.
+		 * The branches are in the log in the order the verifier looked at them.
 		 */
-		q = p;
+		q = log_buf;
 		while ((q = strstr(q, buf)) != NULL) {
 			const char *s = q + strlen(buf);
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
index 2e23b8593af9..1d1684d2cf3b 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
@@ -26,8 +26,10 @@ int BPF_PROG(invalid_dynptr_cross_frame, struct sk_buff *skb, struct Qdisc *sch,
 	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
 
 	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
-	if (!hdr)
+	if (!hdr) {
+		bpf_kfree_skb(skb);
 		return NET_XMIT_DROP;
+	}
 
 	free_skb(skb);
 
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index c89c88db39d1..715218d32105 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -45,7 +45,7 @@ int BPF_PROG(test_alloc_no_release, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("NULL pointer passed to trusted R1")
+__failure __msg("R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_")
 int BPF_PROG(test_alloc_double_release, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *cpumask;
diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 23019023511a..6419e7ce1248 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -203,9 +203,9 @@ int mixed_mem_untrusted_btf_id_type(void *ctx)
 	 * returning 0.
 	 */
 	asm volatile (
-	"r7 = %[p];"
-	"if %[zero] != 0 goto +1;"
 	"r7 = %[q];"
+	"if %[zero] == 0 goto +1;"
+	"r7 = %[p];"
 	"r8 = *(u64 *)(r7 + 0);"
 	"%[v] = r8;"
 	: [v]"=r"(v)
@@ -247,9 +247,9 @@ int mixed_mem_btf_id_type(void *ctx)
 	 * gotten on its own.
 	 */
 	asm volatile (
-	"r7 = %[p];"
-	"if %[zero] != 0 goto +1;"
 	"r7 = %[q];"
+	"if %[zero] == 0 goto +1;"
+	"r7 = %[p];"
 	"r8 = *(u32 *)(r7 + 0);"
 	"%[v] = r8;"
 	: [v]"=r"(v)
@@ -289,9 +289,9 @@ int mixed_rdonly_mem_btf_id_type(void *ctx)
 	 * only its PTR_UNTRUSTED variant is.
 	 */
 	asm volatile (
-	"r7 = %[p];"
-	"if %[zero] != 0 goto +1;"
 	"r7 = %[q];"
+	"if %[zero] == 0 goto +1;"
+	"r7 = %[p];"
 	"r8 = *(u32 *)(r7 + 0);"
 	"%[v] = r8;"
 	: [v]"=r"(v)
@@ -324,9 +324,9 @@ int mixed_mem_mem_type(void *ctx)
 	 * hence without the BPF_PROBE_MEM rewrite the other path needs.
 	 */
 	asm volatile (
-	"r7 = %[q];"
-	"if %[zero] == 0 goto +1;"
 	"r7 = %[p];"
+	"if %[zero] != 0 goto +1;"
+	"r7 = %[q];"
 	"r8 = *(u64 *)(r7 + 0);"
 	"%[v] = r8;"
 	: [v]"=r"(v)
diff --git a/tools/testing/selftests/bpf/progs/timer_failure.c b/tools/testing/selftests/bpf/progs/timer_failure.c
index 0538269101ca..84ea861575fc 100644
--- a/tools/testing/selftests/bpf/progs/timer_failure.c
+++ b/tools/testing/selftests/bpf/progs/timer_failure.c
@@ -43,14 +43,7 @@ static unsigned long timer_cb_ret_bad()
 }
 
 SEC("fentry/bpf_fentry_test1")
-__log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __failure
-/* check that fallthrough code path marks r0 as precise */
-__msg("mark_precise: frame0: regs=r0 stack= before")
-__msg(": (85) call bpf_get_prandom_u32#7") /* anchor message */
-/* check that branch code path marks r0 as precise */
-__msg("mark_precise: frame0: regs=r0 stack= before ") __msg(": (85) call bpf_get_prandom_u32#7")
 __msg("should have been in [0, 0]")
 long BPF_PROG2(test_bad_ret, int, a)
 {
@@ -80,7 +73,7 @@ static int timer_cb_infinite_loop(void *map, int *key, struct elem *val)
 }
 
 SEC("fentry/bpf_fentry_test1")
-__failure __msg("infinite loop detected")
+__failure __msg("loop at insn {{[0-9]+}} never exits")
 long BPF_PROG2(test_infinite_loop_cb, int, a)
 {
 	struct bpf_timer *timer;
diff --git a/tools/testing/selftests/bpf/progs/verifier_align.c b/tools/testing/selftests/bpf/progs/verifier_align.c
index 0083ef8b8ba7..aecc5279dbaf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_align.c
+++ b/tools/testing/selftests/bpf/progs/verifier_align.c
@@ -13,7 +13,7 @@
 SEC("tc")
 __success __log_level(2)
 __flag(BPF_F_ANY_ALIGNMENT)
-__msg("0: R1=ctx() R10=fp0")
+__msg("0: R10=fp0")
 __msg("0: {{.*}} R3=2")
 __msg("1: {{.*}} R3=4")
 __msg("2: {{.*}} R3=8")
@@ -35,7 +35,7 @@ __naked void mov(void)
 SEC("tc")
 __success __log_level(2)
 __flag(BPF_F_ANY_ALIGNMENT)
-__msg("0: R1=ctx() R10=fp0")
+__msg("0: R10=fp0")
 __msg("0: {{.*}}R3=1")
 __msg("1: {{.*}}R3=2")
 __msg("2: {{.*}}R3=4")
@@ -69,7 +69,7 @@ __naked void shift(void)
 SEC("tc")
 __success __log_level(2)
 __flag(BPF_F_ANY_ALIGNMENT)
-__msg("0: R1=ctx() R10=fp0")
+__msg("0: R10=fp0")
 __msg("0: {{.*}}R3=4")
 __msg("1: {{.*}}R3=8")
 __msg("2: {{.*}}R3=10")
@@ -93,7 +93,7 @@ __naked void addsub(void)
 SEC("tc")
 __success __log_level(2)
 __flag(BPF_F_ANY_ALIGNMENT)
-__msg("0: R1=ctx() R10=fp0")
+__msg("0: R10=fp0")
 __msg("0: {{.*}}R3=7")
 __msg("1: {{.*}}R3=7")
 __msg("2: {{.*}}R3=14")
@@ -532,7 +532,7 @@ __msg("9: {{.*}} R6={{[^)]*}}var_off=(0x0; 0x3c)")
 /* Adding 14 makes R6 be (4n+2) */
 __msg("10: {{.*}} R6={{[^)]*}}var_off=(0x2; 0x7c)")
 /* Subtracting from packet pointer overflows ubounds */
-__msg("13: R5={{[^)]*}}var_off=(0xffffffffffffff82; 0x7c)")
+__msg("12: {{.*}} R5={{[^)]*}}var_off=(0xffffffffffffff82; 0x7c)")
 /* New unknown value in R7 is (4n), >= 76 */
 __msg("14: {{.*}} R7={{[^)]*}}var_off=(0x0; 0x7fc)")
 /* Adding it to packet pointer gives nice bounds again */
diff --git a/tools/testing/selftests/bpf/progs/verifier_and.c b/tools/testing/selftests/bpf/progs/verifier_and.c
index 2b4fdca162be..fb64ea9928f1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_and.c
+++ b/tools/testing/selftests/bpf/progs/verifier_and.c
@@ -38,9 +38,9 @@ __naked void invalid_and_of_negative_number(void)
 	r1 &= -4;					\
 	r1 <<= 2;					\
 	r0 += r1;					\
-l0_%=:	r1 = %[test_val_foo];				\
+	r1 = %[test_val_foo];				\
 	*(u64*)(r0 + 0) = r1;				\
-	exit;						\
+l0_%=:	exit;						\
 "	:
 	: __imm(bpf_map_lookup_elem),
 	  __imm_addr(map_hash_48b),
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index df8d5309657e..c999d6ae5fc8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1797,8 +1797,8 @@ l1_%=:	r0 = 1;				\
 
 SEC("socket")
 __description("jset on same register, scalar value unknown branch 1")
-__msg("3: (b7) r0 = 0 {{.*}} R0=0")
 __msg("5: (b7) r0 = 1 {{.*}} R0=1")
+__msg("3: (b7) r0 = 0 {{.*}} R0=0")
 __success __log_level(2)
 __naked void jset_on_same_register_3(void *ctx)
 {
@@ -1818,8 +1818,8 @@ l1_%=:	r0 = 1;				\
 
 SEC("socket")
 __description("jset on same register, scalar value unknown branch 2")
-__msg("4: (b7) r0 = 0 {{.*}} R0=0")
 __msg("6: (b7) r0 = 1 {{.*}} R0=1")
+__msg("4: (b7) r0 = 0 {{.*}} R0=0")
 __success __log_level(2)
 __naked void jset_on_same_register_4(void *ctx)
 {
@@ -1840,8 +1840,8 @@ l1_%=:	r0 = 1;				\
 
 SEC("socket")
 __description("jset on same register, scalar value unknown branch 3")
-__msg("4: (b7) r0 = 0 {{.*}} R0=0")
 __msg("6: (b7) r0 = 1 {{.*}} R0=1")
+__msg("4: (b7) r0 = 0 {{.*}} R0=0")
 __success __log_level(2)
 __naked void jset_on_same_register_5(void *ctx)
 {
@@ -2159,6 +2159,589 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+/*
+ * -1 and 0 meet at the insn that forks. The state with [-1, 0] is kept there. The
+ * pushed state is within it, so it's not there that it is pushed to.
+ */
+SEC("socket")
+__description("maybe_fork_scalars: AND where paths meet rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void and_scalar_fork_at_join_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	r6 = -1;					\
+	if r1 == 0 goto l1_%=;				\
+	r6 = 0;						\
+l1_%=:	r6 &= 8;					\
+	/* r6 is 8 (current) or 0 (pushed) */		\
+	r6 ^= 8;					\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: OR where paths meet rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void or_scalar_fork_at_join_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	r6 = -1;					\
+	if r1 == 0 goto l1_%=;				\
+	r6 = 0;						\
+l1_%=:	r6 |= 8;					\
+	/* r6 is -1 (current) or 8 (pushed) */		\
+	if r6 s< 0 goto l0_%=;				\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: 32-bit AND where paths meet rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void and32_scalar_fork_at_join_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	r6 = -1;					\
+	if r1 == 0 goto l1_%=;				\
+	r6 = 0;						\
+l1_%=:	w6 &= 8;					\
+	/* r6 is 8 (current) or 0 (pushed) */		\
+	r6 ^= 8;					\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: 32-bit OR where paths meet rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void or32_scalar_fork_at_join_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	r6 = -1;					\
+	if r1 == 0 goto l1_%=;				\
+	r6 = 0;						\
+l1_%=:	w6 |= 8;					\
+	/* r6 is 0xffffffff (current) or 8 (pushed) */	\
+	if w6 s< 0 goto l0_%=;				\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+/* Only the low half of r6 is in [-1, 0]. */
+SEC("socket")
+__description("maybe_fork_scalars: AND of a 32-bit range where paths meet rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void and_scalar32_fork_at_join_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	w6 = -1;					\
+	if r1 == 0 goto l1_%=;				\
+	r6 = 0;						\
+l1_%=:	r6 &= 8;					\
+	/* r6 is 8 (current) or 0 (pushed) */		\
+	r6 ^= 8;					\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: 32-bit AND of a 32-bit range where paths meet rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void and32_scalar32_fork_at_join_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	w6 = -1;					\
+	if r1 == 0 goto l1_%=;				\
+	r6 = 0;						\
+l1_%=:	w6 &= 8;					\
+	/* r6 is 8 (current) or 0 (pushed) */		\
+	r6 ^= 8;					\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: 32-bit OR of a 32-bit range where paths meet rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void or32_scalar32_fork_at_join_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	w6 = -1;					\
+	if r1 == 0 goto l1_%=;				\
+	r6 = 0;						\
+l1_%=:	w6 |= 8;					\
+	/* r6 is 0xffffffff (current) or 8 (pushed) */	\
+	if w6 s< 0 goto l0_%=;				\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+/* The high half is not known, and a 64-bit insn doesn't make it 0 in the pushed state. */
+SEC("socket")
+__description("maybe_fork_scalars: AND of a 32-bit range keeps the high half")
+__failure __msg("invalid access to map value")
+__naked void and_scalar32_fork_keeps_high_half(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r6 = *(u64*)(r9 + 0);				\
+	if w6 s> 0 goto l0_%=;				\
+	if w6 s< -1 goto l0_%=;				\
+	r1 = 0x800000008 ll;				\
+	if r6 s< 0 goto l1_%=;				\
+	r0 = 0;						\
+l1_%=:	r6 &= r1;					\
+	/* the low half is 8 (current) or 0 (pushed) */	\
+	if w6 != 0 goto l0_%=;				\
+	/* pushed path: r6 = 8 if bit 35 was set, OOB */\
+	r6 >>= 32;					\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: AND after paths meet rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void and_scalar_fork_after_join_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	r6 = -1;					\
+	if r1 == 0 goto l1_%=;				\
+	r6 = 0;						\
+l1_%=:	r1 = 0;						\
+	r6 &= 8;					\
+	/* r6 is 8 (current) or 0 (pushed) */		\
+	r6 ^= 8;					\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: AND where paths meet allows in-bounds")
+__success __retval(0)
+__log_level(2)
+__msg("r6 &= 4 {{.*}} R6=4")
+__msg("from 13 to 14: R6=0")
+__naked void and_scalar_fork_at_join_allows_inbounds(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	r6 = -1;					\
+	if r1 == 0 goto l1_%=;				\
+	r6 = 0;						\
+l1_%=:	r6 &= 4;					\
+	/* r6 is 4 (current) or 0 (pushed) */		\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+/*
+ * The insn that forks is the head of a loop whose iterations are looked at one by one,
+ * because of r8. The pushed state is in the iteration of the state that it comes from.
+ */
+SEC("socket")
+__description("maybe_fork_scalars: AND at the head of a loop rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void and_scalar_fork_at_loop_head_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r7 = 0;						\
+	r8 = 0;						\
+	r6 = *(u64*)(r9 + 0);				\
+	r6 s>>= 63;					\
+l1_%=:	r6 &= 4;					\
+	/* r6 is 4 (current) or 0 (pushed) */		\
+	r6 ^= 4;					\
+	r6 *= r8;					\
+	/* pushed path: r6 = 8 at last, OOB */		\
+	r1 = r9;					\
+	r1 += r6;					\
+	r0 = *(u8*)(r1 + 0);				\
+	r6 = *(u64*)(r9 + 0);				\
+	r6 s>>= 63;					\
+	r7 += 1;					\
+	r8 = r7;					\
+	if r7 < 3 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+/*
+ * The other insns that keep their states: the head of a loop that has one state for
+ * all iterations,
+ */
+SEC("socket")
+__description("maybe_fork_scalars: AND at the head of a long loop rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void and_scalar_fork_at_long_loop_head_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r7 = 0;						\
+	r6 = -1;					\
+l1_%=:	r6 &= 8;					\
+	/* r6 is 8 (current) or 0 (pushed) */		\
+	r6 ^= 8;					\
+	/* pushed path: r6 = 8, OOB for value_size=8 */	\
+	r1 = r9;					\
+	r1 += r6;					\
+	r0 = *(u8*)(r1 + 0);				\
+	r1 = *(u64*)(r9 + 0);				\
+	r6 = -1;					\
+	if r1 == 0 goto l2_%=;				\
+	r6 = 0;						\
+l2_%=:	r7 += 1;					\
+	if r7 < 100 goto l1_%=;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+static __naked __noinline __used
+unsigned long and_8(void)
+{
+	asm volatile ("					\
+	r1 &= 8;					\
+	r0 = r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* the first insn of a function, */
+SEC("socket")
+__description("maybe_fork_scalars: AND at the entry of a function rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void and_scalar_fork_at_func_entry_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	r1 s>>= 63;					\
+	call and_8;					\
+	/* r0 is 8 (current) or 0 (pushed) */		\
+	r0 ^= 8;					\
+	/* pushed path: r0 = 8, OOB for value_size=8 */	\
+	r9 += r0;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+static __naked __noinline __used
+unsigned long sign_of(void)
+{
+	asm volatile ("					\
+	r0 = r1;					\
+	r0 s>>= 63;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* and the insn that a function returns to. */
+SEC("socket")
+__description("maybe_fork_scalars: AND after a call rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void and_scalar_fork_after_call_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r1 = *(u64*)(r9 + 0);				\
+	call sign_of;					\
+	r0 &= 8;					\
+	/* r0 is 8 (current) or 0 (pushed) */		\
+	r0 ^= 8;					\
+	/* pushed path: r0 = 8, OOB for value_size=8 */	\
+	r9 += r0;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+static __naked __noinline __used
+unsigned long and_7_is_not_3(void)
+{
+	asm volatile ("					\
+	r1 &= 7;					\
+	if r1 != 3 goto +1;				\
+	r10 = 0;					\
+	if r2 == 0 goto l0_%=;				\
+	r6 = r2;					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r1 <<= 32;					\
+	r1 s>>= 63;					\
+	r2 = r6;					\
+	r2 += -1;					\
+	call and_7_is_not_3;				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * What a call of a recursive function brings to its entry is widened against the states that
+ * are there. The pushed state is not one of them: [-1, 0] would look like 0 that grew.
+ */
+SEC("socket")
+__description("maybe_fork_scalars: AND at the entry of a recursive function")
+__success
+__naked void and_scalar_fork_at_recursive_func_entry(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r1 <<= 32;					\
+	r1 s>>= 63;					\
+	r2 = 2;						\
+	call and_7_is_not_3;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+#define FORK						\
+	"r6 = *(u64*)(r9 + 0);"				\
+	"r6 s>>= 63;"					\
+	"r6 &= 4;"					\
+	"*(u64*)(r9 + 0) = r6;"
+#define FORK4 FORK FORK FORK FORK
+
+/*
+ * The pushed states of one block that don't differ in what is live are one state: 16 forks
+ * are not 2^16 states.
+ */
+SEC("socket")
+__description("maybe_fork_scalars: 16 forks in a block")
+__success __retval(0)
+__log_level(4)
+__msg("processed {{[0-9][0-9]?[0-9]?}} insns")
+__naked void and_scalar_16_forks_in_a_block(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[map_hash_8b] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto l0_%=;"
+	"r9 = r0;"
+	FORK4 FORK4 FORK4 FORK4
+"l0_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+#undef FORK4
+#undef FORK
+
 /*
  * Last jump can be detected as always taken because the intersection of R5 and
  * R7 32bit tnums produces a constant that isn't within R7's s32 bounds.
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
index c6603a118fdc..1b13d3a8dcfa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
@@ -717,12 +717,12 @@ __naked void bounds_check_using_bad_access_1(void)
 	*(u64*)(r2 + 0) = r1;				\
 	r1 = %[map_hash_48b] ll;			\
 	call %[bpf_map_lookup_elem];			\
-	if r0 == 0 goto l0_%=;				\
+	if r0 == 0 goto l1_%=;				\
 	r1 = r0;					\
 	r3 = *(u32*)(r0 + 0);				\
 	if r3 < 32 goto l1_%=;				\
 	r1 += r3;					\
-l0_%=:	r0 = 0;						\
+	r0 = 0;						\
 	*(u8*)(r1 + 0) = r0;				\
 	r0 = 0;						\
 	exit;						\
@@ -775,12 +775,12 @@ __naked void bounds_check_using_bad_access_2(void)
 	*(u64*)(r2 + 0) = r1;				\
 	r1 = %[map_hash_48b] ll;			\
 	call %[bpf_map_lookup_elem];			\
-	if r0 == 0 goto l0_%=;				\
+	if r0 == 0 goto l1_%=;				\
 	r1 = r0;					\
 	r3 = *(u32*)(r0 + 0);				\
 	if r3 <= 32 goto l1_%=;				\
 	r1 += r3;					\
-l0_%=:	r0 = 0;						\
+	r0 = 0;						\
 	*(u8*)(r1 + 0) = r0;				\
 	r0 = 0;						\
 	exit;						\
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
index 8f6082fdb5c8..e7636b86cc29 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
@@ -127,13 +127,13 @@ static __u64 stats_async_schedule(struct bpf_map *map, __u32 *key,
 SEC("?raw_tp")
 __success __log_level(4)
 /*
- * self: 9 + 7 + 2 = 18
- * totals: leaf 2, scheduler 7, main root 18
+ * self: 8 + 7 + 2 = 17
+ * totals: leaf 2, scheduler 7, main root 17
  */
-__msg("subprog 0 (stats_async_direct) main insns_self 9 insns_total 18 stack 0")
+__msg("subprog 0 (stats_async_direct) main insns_self 8 insns_total 17 stack 0")
 __msg("subprog {{[0-9]+}} (stats_async_schedule) static insns_self 7 insns_total 7 stack 0")
 __msg("subprog {{[0-9]+}} (stats_async_leaf) static insns_self 2 insns_total 2 stack 0")
-__msg("processed 18 insns")
+__msg("processed 17 insns")
 __naked int stats_async_direct(void)
 {
 	asm volatile (
@@ -194,14 +194,14 @@ static __u64 stats_async_nested_schedule(struct bpf_map *map, __u32 *key,
 SEC("?raw_tp")
 __success __log_level(4)
 /*
- * self: 9 + 7 + 7 + 2 = 25
- * totals: leaf 2, outer 7, scheduler 7, main root 25
+ * self: 8 + 7 + 7 + 2 = 24
+ * totals: leaf 2, outer 7, scheduler 7, main root 24
  */
-__msg("subprog 0 (stats_async_nested) main insns_self 9 insns_total 25 stack 0")
+__msg("subprog 0 (stats_async_nested) main insns_self 8 insns_total 24 stack 0")
 __msg("subprog {{[0-9]+}} (stats_async_nested_schedule) static insns_self 7 insns_total 7 stack 0")
 __msg("subprog {{[0-9]+}} (stats_async_outer) static insns_self 7 insns_total 7 stack 0")
 __msg("subprog {{[0-9]+}} (stats_async_nested_leaf) static insns_self 2 insns_total 2 stack 0")
-__msg("processed 25 insns")
+__msg("processed 24 insns")
 __naked int stats_async_nested(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index a54b5a58b945..eda7ac8e2145 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -394,8 +394,8 @@ __naked void fill_of_different_pointers_stx(void)
 	r2 = r10;					\
 	r2 += -16;					\
 	*(u64*)(r6 + 0) = r2;				\
-l0_%=:	if r1 != 0 goto l1_%=;				\
-	*(u64*)(r6 + 0) = r1;				\
+	goto l1_%=;					\
+l0_%=:	*(u64*)(r6 + 0) = r1;				\
 l1_%=:	r1 = *(u64*)(r6 + 0);				\
 	*(u32*)(r1 + %[__sk_buff_mark]) = r3;		\
 	r0 = 0;						\
@@ -420,8 +420,8 @@ __naked void fill_of_different_pointers_st(void)
 	r2 = r10;					\
 	r2 += -16;					\
 	*(u64*)(r6 + 0) = r2;				\
-l0_%=:	if r1 != 0 goto l1_%=;				\
-	*(u64*)(r6 + 0) = r1;				\
+	goto l1_%=;					\
+l0_%=:	*(u64*)(r6 + 0) = r1;				\
 l1_%=:	r1 = *(u64*)(r6 + 0);				\
 	.8byte %[st_mem];				\
 	r0 = 0;						\
@@ -435,7 +435,8 @@ l1_%=:	r1 = *(u64*)(r6 + 0);				\
 
 SEC("tc")
 __description("unpriv: spill/fill of different pointers stx - ctx and sock")
-__failure __msg("type=ctx expected=sock")
+/* bpf_sk_release(skb) is an error too: "type=ctx expected=sock". This one is found first. */
+__failure __msg("R1 invalid mem access 'sock_or_null'")
 __naked void pointers_stx_ctx_and_sock(void)
 {
 	asm volatile ("					\
@@ -449,10 +450,10 @@ __naked void pointers_stx_ctx_and_sock(void)
 	r6 += -8;					\
 	r1 = r8;					\
 	/* if (skb == NULL) *target = sock; */		\
-	if r1 == 0 goto l0_%=;				\
+	if r1 != 0 goto l0_%=;				\
 	*(u64*)(r6 + 0) = r2;				\
+	goto l1_%=;					\
 l0_%=:	/* else *target = skb; */			\
-	if r1 != 0 goto l1_%=;				\
 	*(u64*)(r6 + 0) = r1;				\
 l1_%=:	/* struct __sk_buff *skb = *target; */		\
 	r1 = *(u64*)(r6 + 0);				\
@@ -490,10 +491,10 @@ __naked void different_pointers_stx_leak_sock(void)
 	r6 += -8;					\
 	r1 = r8;					\
 	/* if (skb == NULL) *target = sock; */		\
-	if r1 == 0 goto l0_%=;				\
+	if r1 != 0 goto l0_%=;				\
 	*(u64*)(r6 + 0) = r2;				\
+	goto l1_%=;					\
 l0_%=:	/* else *target = skb; */			\
-	if r1 != 0 goto l1_%=;				\
 	*(u64*)(r6 + 0) = r1;				\
 l1_%=:	/* struct __sk_buff *skb = *target; */		\
 	r1 = *(u64*)(r6 + 0);				\
@@ -526,8 +527,8 @@ __naked void stx_sock_and_ctx_read(void)
 	/* if (skb) *target = skb */			\
 	if r1 == 0 goto l0_%=;				\
 	*(u64*)(r6 + 0) = r1;				\
+	goto l1_%=;					\
 l0_%=:	/* else *target = sock */			\
-	if r1 != 0 goto l1_%=;				\
 	*(u64*)(r6 + 0) = r2;				\
 l1_%=:	/* struct bpf_sock *sk = *target; */		\
 	r1 = *(u64*)(r6 + 0);				\
@@ -565,8 +566,8 @@ __naked void stx_sock_and_ctx_write(void)
 	/* if (skb) *target = skb */			\
 	if r1 == 0 goto l0_%=;				\
 	*(u64*)(r6 + 0) = r1;				\
+	goto l1_%=;					\
 l0_%=:	/* else *target = sock */			\
-	if r1 != 0 goto l1_%=;				\
 	*(u64*)(r6 + 0) = r2;				\
 l1_%=:	/* struct bpf_sock *sk = *target; */		\
 	r1 = *(u64*)(r6 + 0);				\
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c b/tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c
index 4d77407a0a79..5363093a4a5c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv_perf.c
@@ -17,8 +17,8 @@ __naked void fill_of_different_pointers_ldx(void)
 	r2 = r10;					\
 	r2 += %[__imm_0];				\
 	*(u64*)(r6 + 0) = r2;				\
-l0_%=:	if r1 != 0 goto l1_%=;				\
-	*(u64*)(r6 + 0) = r1;				\
+	goto l1_%=;					\
+l0_%=:	*(u64*)(r6 + 0) = r1;				\
 l1_%=:	r1 = *(u64*)(r6 + 0);				\
 	r1 = *(u64*)(r1 + %[sample_period]);		\
 	r0 = 0;						\
-- 
2.55.0

