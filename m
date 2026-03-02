Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC1425CC6
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470161; cv=none; b=OkCALPsx5fFNsd13p5nnC11pSXC1klfIURohAcZRoqSlHwPv/ZzXeT6QEZD/OBn7oGCTsdqKz5SkDUQ6E3jNWCGVhgcLbpQuA/1LBegU6o01vUPL13rSkv8ypRyUZBsjytlvemKUINW3jvu+qxz5elHgtFi/bNEZTXBeaiboNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470161; c=relaxed/simple;
	bh=JcZOpFn1D0EH4g2Wxpe5oK0+Gl+/eJY3n/k69k91Nqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpcKvxsY80IKuq921A4moafZ7SUiJ1tQnfRvTyK2wV1SJQA5bT2bUzuTVp6UZfUsTfx7fMeZQgFx9S64PJFIcQSu0TjoAPwnG3poQdzA+aN0lBDvkRwMzako1VRCaKKYotAqdD5cyDGvj4vu9mGFjTayQId+5arnOAnRcvihOS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=rJ67D4+N; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="rJ67D4+N"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622E7mIv1677322;
	Mon, 2 Mar 2026 16:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=3bsuEgozBpg2IJLtGoEFv+04IzVq1IqOgQtyQx1STqs=; b=rJ67
	D4+NOKYHKwoyhaqFIzc+6h/tVoUR7mRDbOf+uJoRO/0VuDVHMotk9ozSFtg0raZz
	4+R6eAaw9PNZps0NyErfzkBkQvzA20oWAu6UDD/WOrOJ/I5SZyK0Fd5jhBq1N844
	tlivEc8J28lTwEqwHH1UQ9+7Mc7+n154YTYC/qD+Cgtvr6+GLiWT1VarvriTJ6gH
	MVEfmw47om7mQYK1qYlQrBTM/GfyYCnKtfVTJzhbgbv+gLQ0tYIwmcSxeNzPSOy/
	Ei7d7zA6ijCg4S3GD2/hCMzfIQj5JjdPkWuD4l2Oi6qC3Q/6e5vLUFiXydBKQ5iR
	zvn53c06isCiVFIxyg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cmb5uw755-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 16:48:50 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 16:48:48 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v3 1/2] libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
Date: Mon, 2 Mar 2026 11:48:45 -0500
Message-ID: <20260302164846.36713-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302164846.36713-1-andrey.grodzovsky@crowdstrike.com>
References: <20260302164846.36713-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-GUID: JISw5OcHk1kePOiVCLFjwXZTKBam-R4t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzOCBTYWx0ZWRfX7hmUFVQ5LtKf
 9Gm7cStE1Ks9fnUv++Oe2nKYn7AUMgsv6eoOZN/aQYFb0S4E5SpH+JNUU8iS1zuNm90t/QsnGYs
 yWduM/oR4egiE9DBidNqrXfkatjJPKzCXQ1CLyqsr+rTwWV7SKFq3zmzSNF0DgW4yDuI2Rzeeqo
 XXdYLi23hBYZ1ncHf59GZ5Z/TKfXo11jexvn0umdCQcD3qy4nn3H2eBbOwl6sXhgENvvufwJrI8
 nG1FSHp3LSiXB5tqsMMgB/6I5nZzX8oFZ7a+CXMWMvx0FnQ40I+hBOIFTloi+g7ULiQaGZODtR+
 lG+o9h2JmUK/IAQmjAgJQXkpw7aNhsWPOHozRCAGs92V67494lrcArEv9jZw/46tCUxkmAXgNMe
 BoYO5JCSdgAvRURa6vlEP1Fsoq2eH38618cV1oOh1BytuZzAHNvQU3UXPq+UvgHeuaj1P6UBoBP
 PxSUXs1tWvYAReymktA==
X-Authority-Analysis: v=2.4 cv=WN1yn3sR c=1 sm=1 tr=0 ts=69a5bf72 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8
 a=mMzsp5G70WcS6UcmVugA:9
X-Proofpoint-ORIG-GUID: JISw5OcHk1kePOiVCLFjwXZTKBam-R4t
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020138

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
 tools/lib/bpf/libbpf.c | 154 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 136 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..11833236b3b6 100644
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
@@ -11716,6 +11787,53 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
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
+		}
+
 		goto err_out;
 	}
 	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
@@ -11931,7 +12049,7 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 	data.syms = syms;
 	data.res = res;
 	data.cnt = cnt;
-	libbpf_kallsyms_parse(avail_kallsyms_cb, &data);
+	libbpf_kallsyms_parse(avail_kallsyms_cb, &data, false);
 
 	if (res->cnt == 0)
 		err = -ENOENT;
-- 
2.34.1

