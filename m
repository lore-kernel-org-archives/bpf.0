Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313247;
	b=jH6PMxSteXSXSe/HL+r6NEMzH3v2YldEAAAFyqTE5qShxT1b78cKeUPTzzCzD9RlL2+Z
	 uFHN4pu68jrG+kKPY3JWnwP275KPMq75hRkpNAexRJosNfwgmT+ova3FS++noL2vyX83h
	 LzbPisr+8DjoO8kkrnTFB34IgPEvjydapz2DcCcBIL1nQYsQazcZs+mbC1GrqEsd0MLRh
	 Z+QBgyf9vSpr2OVTp1yI0FbS5ps6iKff2NlMwYdRFMtyJbsJRwqAkfTXjmP4SvRz8M9BE
	 FfT6cHz7qHtdjjA+TEMyw69gW9Ce6DcCYHui4VONJ8ASLgg3ukg27gsLXejuqHLFZiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313247;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3FSwtRBuFT1wI2YBr6g4yxD+FPsorwH/spGYHPgBwCI=;
	b=yuB95Tsv+wmOLPQbI5uFyvfMcqexLLlnWSfdvHrO1+pfmkHBlsy03nEojlX+9Rbok2hw
	 rDCHPzqk4BZeM3h0w0j70vDh1QF1je+FYDZ6qC1uHdpJavj3efxiAj+gGIcDHAUSrHNKt
	 DMcUUDrsFuOLp1juCU/ZGn6rYCkvQUjCSUlIcvw+pI5aTq/OtXqg0wedjkwfmSlLNQXy5
	 /8sE3zgCtZSeAeds/mz8qX2x6o6PfsJhlg0W5WWY6xFDApY0vNLQiVoXEFYsKTRmPhHMg
	 wmsIm11+rsr30d/ytubkcbU1c52rW24LKdhMKW3SYT9nfkkRNC78Og9clX6zZ6Z1Kig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=Y+xAzoLF;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433860A2622
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C433860A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=Y+xAzoLF
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TLXDca2715473;
	Thu, 29 Oct 2026 22:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=3FSwtRBuFT1wI2YBr6g4yxD+FPsorwH/spGYHPgBwCI=; b=Y+xA
	zoLF239KeAZAf84iro0RKKn8aTnvznTe29STLgG6e36P8akXUFs3yOc8kZ/504PN
	/KViu1IgiuvLUbzxXMwrSLUZdGk3h4U0Qs/c5HVeasBPGxZ5EwFqTRk+UX18BZ9U
	5hV94e3WOPEL0yhg75y1DQBPEOPlHbcvRTx3NM+tre1TluiB5obhv4NkZXivqqHW
	DjASWpjG9nlutodrUKRT2sZlg7C+S1uqkBWkYmwIcaVW9zzsNAearsWasFs2hiS/
	N1emWLSzbaXcI8uAjCFHes6toDijYCcloTaS9Owhg6WOTpWCtlHN4A+cDCiDYPvY
	+aRIOweaxR4IJbL69Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hme5n85he-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 22:33:57 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 29 Oct 2026 22:33:56 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v9 7/7] selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
Date: Thu, 29 Oct 2026 18:33:48 -0400
Message-ID: <20261029223348.3730738-8-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
References: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
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
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-GUID: OwnbdflmY4-1YAsqzUAbcf2qDtXc3ouI
X-Authority-Analysis: v=2.4 cv=F4zC5ahN c=1 sm=1 tr=0 ts=6ae3c9d5 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=HN69xfemnYruWYkjLlkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX+t7hKAVYzGjc
 jpp3HD2D51HGNOAIVtgeBxsYe4ONacZEdltwJkFpM5RYcxMt3v5DdoK78lnqkQEjKkF8tLg4mBr
 VbU5IQsDAHd/tFor7baM7nSXKMR1lU6cfBv+y0EAZyQ7XFZ0OuIaeERpOuq0bjAP0eOzdJGTaun
 eexNL2Ih2dpW1TRF7pzhwZ3HHw7iQZZhEgI+06ddYqZQo8ALoJUroC0VIAAFrbJCxXZNGUS47kG
 LvsdnqPTNbaPquKzFoBdrUV7kDh7MSkiu3jGMY3JOZq7vTqR/WQKbrnyp2VS6kDjbOFGxFSmgGR
 Hezpe9go+gwjyFo70FscvF3IHiChm3B5yWSr9hnuG4k5gJ4x3ccHgpnQoZeFGvem1q/ez7S2ujf
 pjnCpJgavTxadsJBYPJgwXvFUT04OjOnox4xlOzLEwuh6F8AQS0BxZqAuM38nDjYssi7S+vAiR/
 Gi+jFI+3M3ZeOLXLHgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX1hkzwJH2B9I4
 2euW8CYtfvztu2bGy0x3b0gm92Z0fDaWTLjNUxU7SJKcPwmrTmzFaYKjFGoVd3jcCiHIzUuV3fs
 /CLnFS1TsD2kFlQbwt2+XWkUE+CpgV+5rKC2rGBL03RnTKX+ZDhP
X-Proofpoint-ORIG-GUID: OwnbdflmY4-1YAsqzUAbcf2qDtXc3ouI
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290088

veristat used bpf_program__clone() to verify each program in
isolation. Replace it with BPF_PROG_LOAD_STRATEGY_MANUAL plus
bpf_program__load()/bpf_program__unload().
Unlike clone(), which skips binding RODATA maps to avoid mutating
shared object state, bpf_program__load() does bind them - but each
program is unloaded right after verification, dropping the binding
along with it.

Also, add relevant test case to struct_ops_arena tests.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 48 +++++++++++++++++--
 tools/testing/selftests/bpf/veristat.c        | 20 ++++----
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index e7580b9f0fc2..a8bd10bab5dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -192,9 +192,9 @@ static void arena_autobind(void)
 }
 
 /*
- * The same binding through bpf_object__prepare() and bpf_program__clone(), the
- * way veristat loads a program: the arena takes slot 0 of a continuous
- * fd_array, next to the module BTF of the kfunc the trigger calls.
+ * The same binding through bpf_object__prepare() and bpf_program__clone(),
+ * the arena takes slot 0 of a continuous fd_array, next to the module BTF
+ * of the kfunc the trigger calls.
  */
 static void arena_autobind_clone(void)
 {
@@ -225,6 +225,46 @@ static void arena_autobind_clone(void)
 	struct_ops_arena_autobind__destroy(skel);
 }
 
+/*
+ * The same binding through BPF_PROG_LOAD_STRATEGY_MANUAL: every program is
+ * loaded with bpf_program__load() after bpf_object__prepare() and unloaded
+ * again, the way veristat loads programs.
+ */
+static void arena_autobind_manual(void)
+{
+	struct struct_ops_arena_autobind *skel;
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	struct bpf_program *prog;
+	int err;
+
+	skel = struct_ops_arena_autobind__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena_autobind__open"))
+		return;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		err = bpf_program__set_load_strategy(prog, BPF_PROG_LOAD_STRATEGY_MANUAL);
+		if (!ASSERT_OK(err, "set_load_strategy"))
+			goto out;
+	}
+	err = bpf_object__prepare(skel->obj);
+	if (!ASSERT_OK(err, "prepare"))
+		goto out;
+	err = bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.arena), &info, &len);
+	if (!ASSERT_OK(err, "arena_info"))
+		goto out;
+	bpf_object__for_each_program(prog, skel->obj) {
+		err = bpf_program__load(prog);
+		if (!ASSERT_OK(err, bpf_program__name(prog)))
+			continue;
+		assert_prog_map(bpf_program__fd(prog), info.id, bpf_program__name(prog));
+		bpf_program__unload(prog);
+		ASSERT_LT(bpf_program__fd(prog), 0, "unloaded");
+	}
+out:
+	struct_ops_arena_autobind__destroy(skel);
+}
+
 /*
  * An arena exclusive to a program is bound to that program all the same: the
  * kernel checks an exclusive map against the digest of the final program, so
@@ -315,6 +355,8 @@ void serial_test_struct_ops_arena(void)
 		arena_autobind();
 	if (test__start_subtest("arena_autobind_clone"))
 		arena_autobind_clone();
+	if (test__start_subtest("arena_autobind_manual"))
+		arena_autobind_manual();
 	if (test__start_subtest("arena_autobind_excl"))
 		arena_autobind_excl();
 #else
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 9cfc9b4b41c1..0cd19b59037f 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1678,7 +1678,6 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	const char *base_filename = basename(strdupa(filename));
 	const char *prog_name = bpf_program__name(prog);
 	long mem_peak_a, mem_peak_b, mem_peak = -1;
-	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	char *buf;
 	int buf_sz, log_level;
 	struct verif_stats *stats;
@@ -1726,18 +1725,15 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	if (env.force_reg_invariants)
 		bpf_program__add_flags(prog, BPF_F_TEST_REG_INVARIANTS);
 
-	opts.log_buf = buf;
-	opts.log_size = buf_sz;
-	opts.log_level = log_level;
+	bpf_program__set_log_buf(prog, buf, buf_sz);
+	bpf_program__set_log_level(prog, log_level);
 
 	cgroup_err = reset_stat_cgroup();
 	mem_peak_a = cgroup_memory_peak();
-	fd = bpf_program__clone(prog, &opts);
-	if (fd < 0) {
-		err = fd;
-		if (env.verbose)
-			fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
-	}
+	err = bpf_program__load(prog);
+	fd = err == 0 ? bpf_program__fd(prog) : -1;
+	if (err && env.verbose)
+		fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
 	mem_peak_b = cgroup_memory_peak();
 	if (!cgroup_err && mem_peak_a >= 0 && mem_peak_b >= 0)
 		mem_peak = mem_peak_b - mem_peak_a;
@@ -1774,7 +1770,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	if (verif_log_buf != buf)
 		free(buf);
 	if (fd > 0)
-		close(fd);
+		bpf_program__unload(prog);
 	return 0;
 }
 
@@ -2297,7 +2293,7 @@ static int process_obj(const char *filename)
 	env.files_processed++;
 
 	bpf_object__for_each_program(prog, obj) {
-		bpf_program__set_autoload(prog, true);
+		bpf_program__set_load_strategy(prog, BPF_PROG_LOAD_STRATEGY_MANUAL);
 		prog_cnt++;
 	}
 
-- 
2.34.1

