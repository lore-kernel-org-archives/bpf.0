Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7240A93D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206192; cv=none; b=bXu1x+Aeho+JQKa/dDVZt7hT5C5I1QMz63enUSDEUEB4YpvOk//SARTJeKp95zZfp5g9MRm9/9Y+NrsBCZS29weHYjFnPQSPhvrruV7c63q9CzyvfEmKnNkB0GB7k/GK8E+YJ5VsQ1CIaVxn2+4eQI0hJhroAThS3cuAXEWqdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206192; c=relaxed/simple;
	bh=1zvF9t1o1mJDlPCGeCtOTXYJUJvNn8Y/hhpW3fS6IKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPGhlFL3iqkv3S4CSvCk9w8SVs6HkqtduPcmLlxH6JmcfcogEVMpZJMyxtJDAsnK9lfLcRefBGQDv6j/xjegoFG+nJVEg1iPmIbTXlIbO7cpk0DvWeNOtqHWUyXdr9wiFMDM+aZJ0VG1MBVMFQVAZz1e2s6v3YyAb+NuzBkQc1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=g3FFtvi5; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="g3FFtvi5"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NKKqQw1558467;
	Wed, 23 Sep 2026 23:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=BN7/HiprDJLBzQ1s3U82PRRtz758pgJfFMtQ1md6AL0=; b=g3FF
	tvi5fkBTUF47ZaA4V2KExK+hxe1OO5t0wopOq45suPWtK0u4IOBSJHnxahbbGHy0
	PbaoGgWa/QwPOVChd6FubNRcXw1gkjjr9Y+OZnuNjKrQL6EjRjCTcy0WuXSifnXu
	yMxnDbvdHXt2KMTAc1oHLyxbLh3kgCj6IQCXbXN/UHXLdBBEoATql0euv9oaYqnz
	x5mrW5p7pkq5GGuEHnyOsturjd6MrNg4NXql7yS1K5UnoIq/zH4eY8FwVQ7CskBw
	u9S4RdBf6qo2sYTM9QQuY0iJv45OtXC4oNe4AhpbJ+7uwUSGF9wYL+aNcTv0mYom
	isQFXYhE5HHJVyaxZg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4gvnqq0h2w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 23:29:42 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:29:40 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v5 1/8] libbpf: BPF program load strategy enum
Date: Wed, 23 Sep 2026 19:29:32 -0400
Message-ID: <20260923232939.1886328-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfXxtUiQ7N9B4fw
 NZ4BzChJpHbqeOVUsvFe9N5bg/yvszapTzDPugMNE/82oubKEaQt3QbL5vhfSzVIk4zZylmf+uK
 HbyintSjWqCegDJhUm2h0bDPBeVks3r2r24qLvOxFPSE4xC2HarjVnGt0+gEMv0+yr/kN3Iofr+
 P38t7z5Hr6vZe8Wxr09LpLwHnfEI6XrBzoOjQVl7fmtIu9vMGvifA3GHqzPgwl95I0rwQgAyRpV
 6/J6O7LKfCDKPGCOudQ60U8C1BKLM4yja/tE7ZJ0/9p2/WJhK4NLiJXqfhbAWtoPDMR7JhMBLIG
 1irDYSPx10t6W19XIgmiqdxuse4A0frXFXwvRbMdiIRXbOodDsW4NA/iR5Rm7sqf/bNo1LZKp1p
 JtsISiIqSx17GDbhDjmeH7WsMW7+EbA++7rAoKcBLLc73wrCsvqXToUKGbk51DAFZoV827N5A4e
 Vux7JRGG3uyaduOni5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX3prkSRe+FtlN
 Waf01hzudPxxo35OZ5RD0U6d5jQTMu6hGWBcf6mExmbwhaASk/fghrvte1fFCTbNOHwXvzSX6EE
 vSaaaA+xuT/VMWH9NU+xBr3TusGkQADtaDF3sOp8WYWEgZWp8G/W
X-Authority-Analysis: v=2.4 cv=Is2L47/g c=1 sm=1 tr=0 ts=6ab460e6 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=pl6vuDidAAAA:8
 a=2A3Asy7NaOYSI4mtEPsA:9
X-Proofpoint-GUID: n1UWbB5GBseLG-0xo1TSAfTHJE2pHLCo
X-Proofpoint-ORIG-GUID: n1UWbB5GBseLG-0xo1TSAfTHJE2pHLCo
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230095

From: Slava Imameev <slava.imameev@crowdstrike.com>

Replacing the boolean field with an enum simplifies the addition
of new load strategies. Currently, the bpf_program structure defines
the autoload behavior using a boolean field. This field is now
replaced with an enum, allowing new BPF program loading strategies
to be introduced by extending the enum value range.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c   | 50 +++++++++++++++++++++++++---------------
 tools/lib/bpf/libbpf.h   | 33 ++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 66 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cd1ea1bb53cb..a3085847cb97 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -494,7 +494,7 @@ struct bpf_program {
 	struct bpf_object *obj;
 
 	int fd;
-	bool autoload;
+	enum bpf_prog_load_strategy load_strategy;
 	bool autoattach;
 	bool sym_global;
 	bool mark_btf_static;
@@ -874,11 +874,11 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	 * autoload set to false.
 	 */
 	if (sec_name[0] == '?') {
-		prog->autoload = false;
+		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 		/* from now on forget there was ? in section name */
 		sec_name++;
 	} else {
-		prog->autoload = true;
+		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_AUTO;
 	}
 
 	prog->autoattach = true;
@@ -1165,7 +1165,8 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 			}
 		}
 		if (use_cnt)
-			prog->autoload = should_load;
+			prog->load_strategy = should_load ? BPF_PROG_LOAD_STRATEGY_AUTO
+				: BPF_PROG_LOAD_STRATEGY_DISABLED;
 	}
 
 	return 0;
@@ -1256,7 +1257,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 				 * then bpf_object_adjust_struct_ops_autoload() will update its
 				 * autoload accordingly.
 				 */
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 				st_ops->progs[i] = NULL;
 			}
 
@@ -1294,7 +1295,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			 * if user replaced it with another program or NULL
 			 */
 			if (st_ops->progs[i] && st_ops->progs[i] != prog)
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 
 			/* Update the value from the shadow type */
 			st_ops->progs[i] = prog;
@@ -3594,7 +3595,7 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 	}
 
 	bpf_object__for_each_program(prog, obj) {
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 		if (prog_needs_vmlinux_btf(prog))
 			return true;
@@ -6214,7 +6215,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 			/* no need to apply CO-RE relocation if the program is
 			 * not going to be loaded
 			 */
-			if (!prog->autoload)
+			if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 				continue;
 
 			/* adjust insn_idx from section frame of reference to the local
@@ -7558,7 +7559,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		 */
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 
 		err = bpf_object__relocate_calls(obj, prog);
@@ -7594,7 +7595,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 
 		/* Process data relos for main programs */
@@ -8433,8 +8434,8 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload) {
-			pr_debug("prog '%s': skipped loading\n", prog->name);
+		if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_AUTO) {
+			pr_debug("prog '%s': skipped auto-loading\n", prog->name);
 			continue;
 		}
 		prog->log_level |= log_level;
@@ -9877,16 +9878,13 @@ const char *bpf_program__section_name(const struct bpf_program *prog)
 
 bool bpf_program__autoload(const struct bpf_program *prog)
 {
-	return prog->autoload;
+	return prog->load_strategy == BPF_PROG_LOAD_STRATEGY_AUTO;
 }
 
 int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
 {
-	if (prog->obj->state >= OBJ_LOADED)
-		return libbpf_err(-EINVAL);
-
-	prog->autoload = autoload;
-	return 0;
+	return bpf_program__set_load_strategy(prog,
+		autoload ? BPF_PROG_LOAD_STRATEGY_AUTO : BPF_PROG_LOAD_STRATEGY_DISABLED);
 }
 
 bool bpf_program__autoattach(const struct bpf_program *prog)
@@ -15264,7 +15262,7 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		struct bpf_program *prog = *prog_skel->prog;
 		struct bpf_link **link = prog_skel->link;
 
-		if (!prog->autoload || !prog->autoattach)
+		if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_AUTO || !prog->autoattach)
 			continue;
 
 		/* auto-attaching not supported for this program */
@@ -15374,3 +15372,17 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s->progs);
 	free(s);
 }
+
+int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_strategy strategy)
+{
+	if (prog->obj->state >= OBJ_LOADED)
+		return libbpf_err(-EINVAL);
+
+	prog->load_strategy = strategy;
+	return 0;
+}
+
+enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program *prog)
+{
+	return prog->load_strategy;
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 03f794f4adb0..e7255bd4247f 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -2117,6 +2117,39 @@ LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
  */
 LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts *opts);
 
+/**
+ * The program load strategy:
+ *
+ * - BPF_PROG_LOAD_STRATEGY_DISABLED: the program is not loaded.
+ * - BPF_PROG_LOAD_STRATEGY_AUTO: the program is autoloaded when the bpf_object is loaded.
+ */
+enum bpf_prog_load_strategy {
+	BPF_PROG_LOAD_STRATEGY_DISABLED = 0,
+	BPF_PROG_LOAD_STRATEGY_AUTO,
+};
+
+/**
+ * @brief **bpf_program__set_load_strategy()** sets the load strategy of a
+ * BPF program, controlling whether and when it gets loaded into the kernel.
+ *
+ * Can only be called before the enclosing bpf_object is loaded.
+ *
+ * @param prog BPF program to update
+ * @param strategy new load strategy for the program
+ * @return 0 on success; negative error code if the object was already loaded
+ */
+LIBBPF_API int bpf_program__set_load_strategy(struct bpf_program *prog,
+					      enum bpf_prog_load_strategy strategy);
+
+/**
+ * @brief **bpf_program__load_strategy()** returns the current load strategy
+ * of a BPF program.
+ *
+ * @param prog BPF program to query
+ * @return current load strategy of the program
+ */
+LIBBPF_API enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program *prog);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7a84dd00ce95..03c3d2bd15bf 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -463,6 +463,8 @@ LIBBPF_1.8.0 {
 		bpf_program__attach_tracing_multi;
 		bpf_program__clear_flags;
 		bpf_program__clone;
+		bpf_program__load_strategy;
+		bpf_program__set_load_strategy;
 		btf__find_by_name_kind_own;
 		btf__new_empty_opts;
 } LIBBPF_1.7.0;
-- 
2.34.1

