Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B536B052
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953859; cv=none; b=dOa100AQG2d6z9pBjc6YGcmhDiclbUXi5BM2Yn1+us43jd6CMwPz3vtF/T0zs/OKnJVGuaJiiuqpfGAJjLppdB0aah3M7qdgvZOQmunCLLkFMBI7wLf+GQbKAmEWrt6KemuzmNCPAuV5cza7AtTnG8BZXDD34BDu6lEE64fhONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953859; c=relaxed/simple;
	bh=ARKyRlfUgn/kW3ONhkGUBvHdblqp1A4u+GRB/lEYdkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mj3Cs64905LhG80uKioOBtNJR3C4yZ/+qwtyiHfDr4c/ibjgDqnBzDlIeffE8uGfC4uYe+zsIm3hkZCC1nq1TW5RDWBD48wHeP2M9KCsG7lYmV/iAZMfJgoE96IejDz9vS8BPR4y0gdhaT5cTj4/jxwai/U3C1y08Uk5dAlQM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=HeSQE9AP; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="HeSQE9AP"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OFvQvX2132816;
	Tue, 24 Feb 2026 17:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=/U1/ryNfSBysQUVCnO3grFbZBSCDxI4R9CGCukunzYY=; b=HeSQ
	E9AP6dQ0p1Unwrg8Y/8vGGPMoABzpVzFvw745WMDXl6DIeMxOgG4dWRAqp8SrQDr
	UJdTh4+BhNljtNvCjO/cFh60MBvFmaDQ2A+VvQziN8Ixod49mdDrmzsapVpQhZmV
	mQEqRsfYxpvXhk6i31FBJ9jfhRzzYP+l/7GcwwQR6DvKhoHRMOZWlYVn3SenfAOr
	jWzDCYzmpCD2GHwEpVKVOKOZcBdWsdvc6b38Z5JDdRrNRjN9kEAhhlQvEOYQlOO2
	pnig/pFv9GLhsnbqkOyqGnktlo+SZGx6T0YcBDOJA1ncDL1bVwvKqnGkob/5JCxO
	n1+zmyNcb02vGutREQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cfqgwb5w9-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 17:23:48 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 17:23:42 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next v2 1/2] libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
Date: Tue, 24 Feb 2026 12:23:39 -0500
Message-ID: <20260224172340.1704618-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224172340.1704618-1-andrey.grodzovsky@crowdstrike.com>
References: <20260224172340.1704618-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH005.crowdstrike.sys (10.100.11.69) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=b5y/I9Gx c=1 sm=1 tr=0 ts=699ddea5 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8
 a=Fe7mKs0QxSB6RzOEAn4A:9
X-Proofpoint-ORIG-GUID: VUm4TC_zPzgxY2iqbWl9ipV_RGlTV59A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE0NSBTYWx0ZWRfXzKTkKI6Tx4dl
 aWhPVdpckH3RI84zzAHhstdOpoYI9KFad8zXFktdfvbT+3xAL7Jyiu2ebF67jYQx5NUKf2t3w2r
 S7B2os3cRQzKFxDpW38K3ZK7JnHPDGdSAFd0xpYhWT06jxK1k4ZYVKdD/YRe9KfG5LHdTYjbNvL
 XmO/kZHRoKchbQsIxcBUc+vN7LDNw7mwRpX0Eow4Bz5qO6kCVK6XzvVLofLH2qu0ahtO63eeTZB
 heIxGke/LfeeDoIBwhLCTFaEatxOsecwdWxatjzVTf3R1Hloeb1BCJ/7vBpkSpqEKgALVlKHKBj
 H7VTf4AnJq/MjXK1CvDyuAiVLp53Aqm0JH1btJCi0EqlcoA6j2E8UwkyiiuGcu0IIaCWvg1bHOT
 q/qGqys/IMXoTmbbyz0FVt9R/iDSBBVggEUdxW9VgXJhYYz+B1j48RMq6k/TXuQFS+9tPVYAXcQ
 yPQ8r569pefaL1e8TsA==
X-Proofpoint-GUID: VUm4TC_zPzgxY2iqbWl9ipV_RGlTV59A
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11711
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240145

When attaching a kprobe to a function that has duplicate symbols in
kallsyms (e.g. same name in vmlinux and a module), the kernel returns
EADDRNOTAVAIL (or EINVAL via the legacy path). Detect this and retry
by resolving the vmlinux address through kallsyms, skipping module
symbols, and using the absolute address for probe creation.

Extend libbpf_kallsyms_parse() to support module name extraction and
add a skip_if_module flag so callers can filter module symbols at the
parse level without changing callback signatures.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 153 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 135 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..5907ab09c4dc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8460,9 +8460,11 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
 typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
 			     const char *sym_name, void *ctx);
 
-static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
+static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx,
+				bool skip_if_module)
 {
 	char sym_type, sym_name[500];
+	char module_name[128];
 	unsigned long long sym_addr;
 	int ret, err = 0;
 	FILE *f;
@@ -8475,21 +8477,39 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
 	}
 
 	while (true) {
-		ret = fscanf(f, "%llx %c %499s%*[^\n]\n",
-			     &sym_addr, &sym_type, sym_name);
-		if (ret == EOF && feof(f))
+		int n = 0;
+
+		/*
+		 * Format tries to match both vmlinux and module kallsyms
+		 * entries in one call. Module entries have the form:
+		 *   addr type name [module]
+		 * %n fires only if the closing ']' literal is matched.
+		 */
+		ret = fscanf(f, "%llx %c %499s [%127[^] \t\n\r\v\f]] %n",
+			     &sym_addr, &sym_type, sym_name, module_name, &n);
+
+		/* EOF or malformed line - handle after the loop */
+		if (ret != 3 && ret != 4)
 			break;
-		if (ret != 3) {
-			pr_warn("failed to read kallsyms entry: %d\n", ret);
-			err = -EINVAL;
+
+		/* ret == 4 && n == 0: scanset matched but ']' didn't */
+		if (ret == 4 && n == 0)
 			break;
-		}
+
+		if (ret == 4 && skip_if_module)
+			continue;
 
 		err = cb(sym_addr, sym_type, sym_name, ctx);
 		if (err)
 			break;
 	}
 
+	/* !err: don't overwrite callback errors with -EINVAL */
+	if (!feof(f) && !err) {
+		pr_warn("failed to read kallsyms entry: ret=%d\n", ret);
+		err = -EINVAL;
+	}
+
 	fclose(f);
 	return err;
 }
@@ -8529,7 +8549,7 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
 
 static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
 {
-	return libbpf_kallsyms_parse(kallsyms_cb, obj);
+	return libbpf_kallsyms_parse(kallsyms_cb, obj, false);
 }
 
 static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
@@ -11527,10 +11547,20 @@ static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
 static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
 				   const char *kfunc_name, size_t offset)
 {
-	return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s+0x%zx",
-			      retprobe ? 'r' : 'p',
-			      retprobe ? "kretprobes" : "kprobes",
-			      probe_name, kfunc_name, offset);
+	/* When kfunc_name is NULL, use absolute address format (0xADDR),
+	 * otherwise use symbol+offset format (SYMBOL+0xOFF)
+	 */
+	if (kfunc_name) {
+		return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s+0x%zx",
+				      retprobe ? 'r' : 'p',
+				      retprobe ? "kretprobes" : "kprobes",
+				      probe_name, kfunc_name, offset);
+	} else {
+		return append_to_file(tracefs_kprobe_events(), "%c:%s/%s 0x%zx",
+				      retprobe ? 'r' : 'p',
+				      retprobe ? "kretprobes" : "kprobes",
+				      probe_name, offset);
+	}
 }
 
 static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe)
@@ -11559,7 +11589,7 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
 	err = add_kprobe_event_legacy(probe_name, retprobe, kfunc_name, offset);
 	if (err < 0) {
 		pr_warn("failed to add legacy kprobe event for '%s+0x%zx': %s\n",
-			kfunc_name, offset,
+			kfunc_name ? kfunc_name : "(abs_addr)", offset,
 			errstr(err));
 		return err;
 	}
@@ -11567,7 +11597,7 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
 	if (type < 0) {
 		err = type;
 		pr_warn("failed to determine legacy kprobe event id for '%s+0x%zx': %s\n",
-			kfunc_name, offset,
+			kfunc_name ? kfunc_name : "(abs_addr)", offset,
 			errstr(err));
 		goto err_clean_legacy;
 	}
@@ -11651,6 +11681,43 @@ int probe_kern_syscall_wrapper(int token_fd)
 	}
 }
 
+/* Context structure for finding vmlinux kernel symbol address */
+struct find_kaddr_ctx {
+	const char *func_name;
+	unsigned long long kaddr;
+};
+
+/* Callback to find vmlinux kernel text symbol address */
+static int find_kaddr_cb(unsigned long long sym_addr, char sym_type,
+			 const char *sym_name, void *ctx)
+{
+	struct find_kaddr_ctx *data = ctx;
+
+	/* Only match text section symbols ('T' or 't') */
+	if (toupper(sym_type) != 'T')
+		return 0;
+
+	/* Check if this is the symbol we're looking for */
+	if (strcmp(sym_name, data->func_name) == 0) {
+
+		/* If we already have an address, we've encountered a
+		 * duplicate symbol name. Reject such symbols to avoid
+		 * ambiguous resolution.
+		 */
+		if (data->kaddr && data->kaddr != sym_addr) {
+			pr_warn("kernel symbol '%s': resolution is ambiguous: 0x%llx or 0x%llx\n",
+			sym_name, data->kaddr, sym_addr);
+			return -EINVAL;
+		}
+
+		data->kaddr = sym_addr;
+		pr_debug("found kernel symbol %s at address 0x%llx\n",
+			 sym_name, data->kaddr);
+	}
+
+	return 0;
+}
+
 struct bpf_link *
 bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 				const char *func_name,
@@ -11663,6 +11730,8 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	size_t offset;
 	bool retprobe, legacy;
 	int pfd, err;
+	const char *optional_func_name = func_name;
+	struct find_kaddr_ctx kaddr_ctx = { .kaddr = 0 };
 
 	if (!OPTS_VALID(opts, bpf_kprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
@@ -11693,9 +11762,10 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 	}
 
+retry_create:
 	if (!legacy) {
 		pfd = perf_event_open_probe(false /* uprobe */, retprobe,
-					    func_name, offset,
+					    optional_func_name, offset,
 					    -1 /* pid */, 0 /* ref_ctr_off */);
 	} else {
 		char probe_name[MAX_EVENT_NAME_LEN];
@@ -11707,7 +11777,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 		if (!legacy_probe)
 			return libbpf_err_ptr(-ENOMEM);
 
-		pfd = perf_event_kprobe_open_legacy(legacy_probe, retprobe, func_name,
+		pfd = perf_event_kprobe_open_legacy(legacy_probe, retprobe, optional_func_name,
 						    offset, -1 /* pid */);
 	}
 	if (pfd < 0) {
@@ -11716,6 +11786,53 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 			prog->name, retprobe ? "kretprobe" : "kprobe",
 			func_name, offset,
 			errstr(err));
+
+		/*
+		 * If attachment fails with EADDRNOTAVAIL (or EINVAL in
+		 * legacy mode) and we used non-NULL func_name, try to
+		 * find function address in /proc/kallsyms and retry
+		 * using KADDR instead of ambiguous symbol. Legacy
+		 * tracefs API converts EADDRNOTAVAIL to EINVAL, so
+		 * we need to check for both.
+		 */
+		if ((err == -EADDRNOTAVAIL || (legacy && err == -EINVAL)) && optional_func_name) {
+			pr_debug("kallsyms lookup for %s\n",
+				 func_name);
+
+			kaddr_ctx.func_name = func_name;
+			kaddr_ctx.kaddr = 0;
+
+			/*
+			 * Drop the function symbol and override the
+			 * offset to be the desired function KADDR.
+			 * This avoids kallsyms validation for duplicate
+			 * symbols in the kernel. See attr.config2 in
+			 * perf_event_open_probe and kernel code in
+			 * perf_kprobe_init/create_local_trace_kprobe.
+			 */
+			optional_func_name = NULL;
+
+			err = libbpf_kallsyms_parse(find_kaddr_cb, &kaddr_ctx, true);
+			if (err) {
+				pr_warn("failed to get addr for %s\n",
+					func_name);
+				goto err_out;
+			}
+
+			if (kaddr_ctx.kaddr) {
+				pr_debug("retrying %s using kaddr 0x%llx\n",
+					 func_name, kaddr_ctx.kaddr);
+
+				offset += kaddr_ctx.kaddr;
+				free(legacy_probe);
+				legacy_probe = NULL;
+				goto retry_create;
+			}
+
+			pr_warn("symbol '%s' not found in vmlinux\n",
+				func_name);
+		}
+
 		goto err_out;
 	}
 	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
@@ -11931,7 +12048,7 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 	data.syms = syms;
 	data.res = res;
 	data.cnt = cnt;
-	libbpf_kallsyms_parse(avail_kallsyms_cb, &data);
+	libbpf_kallsyms_parse(avail_kallsyms_cb, &data, false);
 
 	if (res->cnt == 0)
 		err = -ENOENT;
-- 
2.34.1

