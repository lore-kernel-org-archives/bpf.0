Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A5386C07
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485553; cv=none; b=nbp1jiVkUbYa9yJJnBmNaJDpzKvo0MfTiSPG105A7x4k0Iakg2y6hnHge+bbEViFXeHJ19AVG8PHEA2xq0ZOcCg8Ber8748syEX5PymW2RUV0J9cUyZuTRcoq3CxVxUvd/SlpUglLeaicnhx5a3AF6k/J0ewpnMcoZtVxsAx13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485553; c=relaxed/simple;
	bh=+osjPDpbnZxbwWXAK717lARiiTgbIMi8KNN0gK8dI8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzO2STe0ZHolDxv7vaq6tbcvB6I4P2Nbwg6w7ohwyLvZrxG8estQI3OkdvgU6kCYcOS9d/W2bLjSd5XTyYEc9jk+Q346usYjiimpXj2INDcEufYlcYnTMsWtmR1JnAAPvBf16hmbvQKIXyalXNNn05ihjZyp8eXqfMb8MQaOi28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=EX76FoU/; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="EX76FoU/"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622Jevt03806860;
	Mon, 2 Mar 2026 21:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=WmhyUGAq3qk91V7SBHi4CZa5dNAZQAuyXeJkXWMEYMM=; b=EX76
	FoU/tlA6xfGmTdV6oegHpqO2uXHQXVpM/7hhzn0uqPP40mJ0Th6UgnCiGmZZ6ZGy
	BTpB2pnFrW9Ukpb2B6JlKH22wzcYXakj2jerL2yYx5Tt76xIA8QDNvaCvNyqRPF7
	DU2hwNYitusw8pv6C+y0uvgwByqKVn18YkyUpJTvk4SVqIcN71ZAXtXMgPKxp8He
	lYcBk95YsX+ZuVe6KRPdPDk20Tt+MKWLO+x9PoE5OT8FQMaHTsgQwq7kFHiN5ex1
	9hozmYmMPUliZ2Uc1C/dNOct9zpAM7OzHNhsF7FJ1nRGz4z3UVUYF0h+kpmFGwoW
	EI/kg2O5NHEZM06tug==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cmbkwe9q0-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 21:05:36 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 21:05:33 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v4 1/2] libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
Date: Mon, 2 Mar 2026 16:05:31 -0500
Message-ID: <20260302210532.381083-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302210532.381083-1-andrey.grodzovsky@crowdstrike.com>
References: <20260302210532.381083-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2MCBTYWx0ZWRfXz+AweSCRuAUH
 nUvtT6salNLekEGnZVs5MNlpccubXH5uwWbOtIL8t2W36FP4wx3cRADaeZHZNbvSk6s9n4ZsQD6
 TShCIY0AddgegVlZyZj9IFTilakbRKKOhHCtdhM2MT8ffy2vK6oG2A0xyLbQfovavFe8C+ccHVQ
 CY50K+vcRcDDPsSpNiJGKd6hOxCtDijOPQVS2nupG5BsCfKJrlv8OrsD2UBAKgzymF38UGSDGtB
 mKjXXKZhVXLwOWS2Z7qsbJcsUzJRS9jrJnXPt3XDjfWsDBgdyPVtnpIT8GLAwhRyvvGymcIuBh1
 DSVQbd72uHo6fYjBdnz68N5hznDjhdz0TCOxTQlRpQdAt5ows/HeSaxSFikcNIg3DY3sBCjBNAR
 1SXDMmmbMfU+E0cweksIhp5kLS4l3jq+WrtkuVrSqgRBjgVvKiXfIU3JbsT6EdC7KQpshy6DSn9
 w5yxXsi/9FOHYWCAzkA==
X-Authority-Analysis: v=2.4 cv=M4RA6iws c=1 sm=1 tr=0 ts=69a5fba0 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=pl6vuDidAAAA:8
 a=mMzsp5G70WcS6UcmVugA:9
X-Proofpoint-GUID: cCLEz6WF5HoKbih7SuT-fB8t8rFQgjGH
X-Proofpoint-ORIG-GUID: cCLEz6WF5HoKbih7SuT-fB8t8rFQgjGH
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020160

When a kernel module exports a symbol with the same name as an existing
vmlinux symbol, kprobe attachment via bpf_program__attach_kprobe_opts()
fails with EADDRNOTAVAIL (perf_event_open path) or EINVAL (legacy
tracefs path).

Implement a fallback mechanism that, on such failures, resolves the
vmlinux address through /proc/kallsyms - filtering out module symbols -
and retries probe attachment using the absolute address, bypassing
kernel symbol name validation.

Changes:
- Restructure libbpf_kallsyms_parse() to accept a bool skip_if_module
  parameter that filters module symbols before invoking the callback.
- Add find_kaddr_cb() callback and find_kaddr_ctx struct to resolve
  vmlinux text symbol addresses from /proc/kallsyms.
- Detect duplicate symbol errors (-EADDRNOTAVAIL for perf_event_open,
  -EINVAL for legacy tracefs) and retry with resolved KADDR.
- Fix NULL pointer in gen_probe_legacy_event_name() when using absolute
  address by passing func_name instead of optional_func_name.
- Fix NULL pointer in pr_warn() calls within
  perf_event_kprobe_open_legacy() by using ternary fallback.
- Fix memory leak of legacy_probe buffer on retry path.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 155 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 137 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..e725e3c98ee2 100644
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
@@ -11651,6 +11681,44 @@ int probe_kern_syscall_wrapper(int token_fd)
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
+		/*
+		 * If we already have an address, we've encountered a
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
@@ -11663,6 +11731,8 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	size_t offset;
 	bool retprobe, legacy;
 	int pfd, err;
+	const char *optional_func_name = func_name;
+	struct find_kaddr_ctx kaddr_ctx = { .kaddr = 0 };
 
 	if (!OPTS_VALID(opts, bpf_kprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
@@ -11693,9 +11763,10 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
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
@@ -11707,7 +11778,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 		if (!legacy_probe)
 			return libbpf_err_ptr(-ENOMEM);
 
-		pfd = perf_event_kprobe_open_legacy(legacy_probe, retprobe, func_name,
+		pfd = perf_event_kprobe_open_legacy(legacy_probe, retprobe, optional_func_name,
 						    offset, -1 /* pid */);
 	}
 	if (pfd < 0) {
@@ -11716,6 +11787,54 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
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
+			 * Drop the function symbol and add the resolved
+			 * KADDR to the offset.
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
+			err = -ENOENT;
+		}
+
 		goto err_out;
 	}
 	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
@@ -11931,7 +12050,7 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 	data.syms = syms;
 	data.res = res;
 	data.cnt = cnt;
-	libbpf_kallsyms_parse(avail_kallsyms_cb, &data);
+	libbpf_kallsyms_parse(avail_kallsyms_cb, &data, false);
 
 	if (res->cnt == 0)
 		err = -ENOENT;
-- 
2.34.1

