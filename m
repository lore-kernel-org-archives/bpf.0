Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221333893D
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455410; cv=none; b=oeLV5IYHd8zmjf0kuSdLYpIaVpvv9+icqgYOEoyLkuN4UaH3/izjRKtMiMQ5tM698RhYfmG5mSrAvBD97LbpCKKg3R7VTf8qfrfwHEsO+xhTh4hO4V5iiyvrei+lSwyRJaD9P0RpI1pAEKtvkR8s9hDAf8fhAMOrpyrPHgbkqOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455410; c=relaxed/simple;
	bh=SyC7KScCkA3rBk0ZfYeeXE2Iw7JROTJzvuiQEO5ZToo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RD0vqyr42UTqHHbW5LoY8g4IjnJ9NsnOyju0BrbDT5Q6B6vXL+C3JhcZXD0KRWgaVKjZHqpnTuI7m0SSfuv3bUNxhxd9yP/Ev6o40ATO+LnFGcr6GJljH7pFu9oSEkbEPvO2Z/YTJr7lacl83i19afhFZvqu1go4bq84w7AFNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=VA30TZSV; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="VA30TZSV"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IKbMrv2984675;
	Wed, 18 Feb 2026 22:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=7Y8zmdqyDGaiAWBwXmVnLw5eV5o6+ZitYM14eusq37I=; b=VA30
	TZSVpMDfvV7KYDXyJRMNgCtpBAAYsARS0T/f/1GbVuAlVm/s+3kR+ua+VK6jcDt/
	PYgWOM4M3NaS5I1fDN9J2qG+X3ysm0OUna0k3wDAHTxbF9ED04w3+JFoiniEaB9b
	ouwyQFvAnaJNbS7tOB0EyRi9Jw72apI2idEPL+E/g16SvNW8DipRSYc5M/d8opCn
	sMzv/Tj+26NagtFxeH7IaOaNvy4LNm/xjZDxbY3WlDJ2AjA0cDd8JmRg5T86dww0
	aOqL+0Je1RXwLRt2Lzpnn1cJN7b0uCPiHhiRnmPfit0K2vGzTcjAqFC8WY6hh5rE
	XGCu/Fk0KsmZS2PKRw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cd06cd183-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 22:56:20 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 22:56:19 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 1/2] libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
Date: Wed, 18 Feb 2026 17:56:16 -0500
Message-ID: <20260218225617.354858-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218225617.354858-1-andrey.grodzovsky@crowdstrike.com>
References: <20260218225617.354858-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=UfxciaSN c=1 sm=1 tr=0 ts=69964394 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pl6vuDidAAAA:8
 a=Vx21f4KBCk6JLXOS7ToA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE5OCBTYWx0ZWRfXz7/nC7Wt7fIN
 wTb+rz72ak+bIfXl9yayMwDVCuWyde4CZHN6n/k2PlJFjeclDKTDwJ4vh7XF3pujt6VR9GKbJPW
 RLFiTpC1sFkf1ku7G3ak/Yr+xUroGbkMxRsmTl+oD+NToz1JkKoj0znXX3QlGFTZNQ/BN/74HrJ
 k3G1SvA+YUI1BpYT47f+uTZR2IfFLYATk+H5RGk2JFZ4T+E1twRskITl83NGiAItArheF+UGF7c
 UpHtHWwVOX9BfhWG4MlvtA7my4V04hGJwaGbRlRfgnTLtfXvBvl9oSQ8Uw9C2Wvmi+gH5GqKFUJ
 sLA3NMeNt/74SD4h44cVEiV2/DRVV37LusKxG8y9aQi6+B99fb0yRCR7MhZvr1Kfz6bTZFb5+VC
 AjDjbyLtwKctYVY3Pkt8E528ro8Cw9OPluZE8RycHS/9PgHXN2bWos9MNTxXiI3XI2p9lLaCwxW
 pbMgDpH/4Wnlj16l+AQ==
X-Proofpoint-GUID: u-v81ip1eCkKVw128jmEHvCRr12x0kae
X-Proofpoint-ORIG-GUID: u-v81ip1eCkKVw128jmEHvCRr12x0kae
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11705
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180198

Add fallback to handle EADDRNOTAVAIL by retrying with absolute
kernel addresses from kallsyms when symbol names are ambiguous.

When kprobe attachment fails with EADDRNOTAVAIL (or EINVAL in
legacy mode) and a symbol name was used, the kernel encountered
duplicate symbols in kallsyms. This patch:

- Adds module_name parameter to kallsyms_cb_t callback and
  parser to distinguish vmlinux from module symbols
- Implements find_kaddr_cb() to look up symbol addresses in
  kallsyms, rejecting ambiguous symbol names
- Modifies add_kprobe_event_legacy() to support absolute
  address format
- Implements retry logic in attach_kprobe_opts() that falls
  back to address-based attachment on failure
- Updates avail_kallsyms_cb() callback signature

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 150 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 133 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce4..684781d25859 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8449,11 +8449,12 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
 }
 
 typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
-			     const char *sym_name, void *ctx);
+			     const char *sym_name, const char *module_name, void *ctx);
 
 static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
 {
 	char sym_type, sym_name[500];
+	char module_name[128];
 	unsigned long long sym_addr;
 	int ret, err = 0;
 	FILE *f;
@@ -8465,18 +8466,39 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
 		return err;
 	}
 
-	while (true) {
-		ret = fscanf(f, "%llx %c %499s%*[^\n]\n",
-			     &sym_addr, &sym_type, sym_name);
-		if (ret == EOF && feof(f))
+	while (!feof(f)) {
+		/* Position indicator - will be updated by %n if format fully matches */
+		int n = 0;
+		/*
+		 * The module name and symbol name are both without whitespace,
+		 * but we cannot use %s to capture, as it consumes the closing ']'
+		 * of the module format. Hence the %127[^] \t\n\r\v\f] which provides
+		 * the equivalent effect.
+		 */
+		ret = fscanf(f, "%llx %c %499s [%127[^] \t\n\r\v\f]] %n",
+			     &sym_addr, &sym_type, sym_name, module_name, &n);
+
+		if (ret == 4 && n > 0) {
+			/*
+			 * Module symbol: all 4 fields matched AND we reached %n.
+			 * n > 0 means we successfully parsed up to the closing ']'.
+			 */
+			err = cb(sym_addr, sym_type, sym_name, module_name, ctx);
+		} else if (ret == 3) {
+			/*
+			 * vmlinux symbol: 3 fields matched, next is matching failure against
+			 * '[', but we don't care as we got what we needed. Also note that the
+			 * trailing newline was consumed by the space after the symbol name.
+			 */
+			err = cb(sym_addr, sym_type, sym_name, NULL, ctx);
+		} else if (ret == EOF && feof(f)) {
 			break;
-		if (ret != 3) {
-			pr_warn("failed to read kallsyms entry: %d\n", ret);
+		} else {
+			pr_warn("failed to read kallsyms entry: ret=%d n=%d\n", ret, n);
 			err = -EINVAL;
 			break;
 		}
 
-		err = cb(sym_addr, sym_type, sym_name, ctx);
 		if (err)
 			break;
 	}
@@ -8486,7 +8508,7 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
 }
 
 static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
-		       const char *sym_name, void *ctx)
+		       const char *sym_name, const char *module_name, void *ctx)
 {
 	struct bpf_object *obj = ctx;
 	const struct btf_type *t;
@@ -11518,10 +11540,20 @@ static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
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
@@ -11642,6 +11674,47 @@ int probe_kern_syscall_wrapper(int token_fd)
 	}
 }
 
+/* Context structure for finding vmlinux kernel symbol address */
+struct find_kaddr_ctx {
+	const char *func_name;
+	unsigned long long kaddr;
+};
+
+/* Callback to find vmlinux kernel text symbol address, skipping module symbols */
+static int find_kaddr_cb(unsigned long long sym_addr, char sym_type,
+			 const char *sym_name, const char *module_name, void *ctx)
+{
+	struct find_kaddr_ctx *data = ctx;
+
+	/* Skip module symbols - we only want vmlinux symbols */
+	if (module_name != NULL)
+		return 0;
+
+	/* Only match text section symbols ('T' or 't') */
+	if (sym_type != 'T' && sym_type != 't')
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
@@ -11654,6 +11727,8 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	size_t offset;
 	bool retprobe, legacy;
 	int pfd, err;
+	const char *optional_func_name = func_name;
+	struct find_kaddr_ctx kaddr_ctx = { .kaddr = 0 };
 
 	if (!OPTS_VALID(opts, bpf_kprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
@@ -11684,21 +11759,22 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
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
 
 		gen_probe_legacy_event_name(probe_name, sizeof(probe_name),
-					    func_name, offset);
+					    optional_func_name, offset);
 
 		legacy_probe = strdup(probe_name);
 		if (!legacy_probe)
 			return libbpf_err_ptr(-ENOMEM);
 
-		pfd = perf_event_kprobe_open_legacy(legacy_probe, retprobe, func_name,
+		pfd = perf_event_kprobe_open_legacy(legacy_probe, retprobe, optional_func_name,
 						    offset, -1 /* pid */);
 	}
 	if (pfd < 0) {
@@ -11707,6 +11783,46 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
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
+			err = libbpf_kallsyms_parse(find_kaddr_cb, &kaddr_ctx);
+			if (err) {
+				pr_warn("failed to get addr for %s\n",
+					func_name);
+				goto err_out;
+			}
+
+			pr_debug("retrying %s using kaddr 0x%llx\n",
+				 func_name, kaddr_ctx.kaddr);
+
+			offset += kaddr_ctx.kaddr;
+			goto retry_create;
+		}
+
 		goto err_out;
 	}
 	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
@@ -11822,7 +11938,7 @@ static int avail_func_cmp(const void *a, const void *b)
 }
 
 static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
-			     const char *sym_name, void *ctx)
+			     const char *sym_name, const char *module_name, void *ctx)
 {
 	struct avail_kallsyms_data *data = ctx;
 	struct kprobe_multi_resolve *res = data->res;
-- 
2.34.1

