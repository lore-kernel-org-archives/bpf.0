Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.148.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806334;
	b=tnZIj6BjZa8tQOsSJFiUYUcjJDVbpbeLZNd2fMHXVKJ2WiP1t+8st6ZltF0O67WAto4D
	 ezHB1OBBqYyCzkdqfVIUxKhrYXrYVC7naoaZo5hMbaCebXAciR3JqnBcCykaCv3z9rLVl
	 Jp4rgd4b45P0mbaPvcJ0z5hE7kie7F/ANMBus606ayF3PD5UdTJo1n8BUdelbKajxmLoZ
	 S9Ptt+YjxJM2Jv+d7q99hT2bdwtwnWUnWiwrE5tOibnec1UszXDMV4YkEaabWo737WkUV
	 PApTuhUWIwK9b7yZ9z7m8yzT0694licDInbh70ANKyttA+6rJiRe55zjwRltkWG1t9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806334;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vMB5CCN8oc1w7viRNLOL5JTv0ynjjVzVcENGNFkEU6M=;
	b=2WwkT54XsNfXa46JilbDszcCwRxmBrD8TV8DtmhQeTEvraYcrhTwwsv/zjKJZBWNyz1Z
	 k/rJD91ePqS8yCYlok2hsgtBqpOcrcYM/IetY2eTaMSfSznxIvikhLUZ8rCanMkvOncFD
	 YMU2Gx9LQGOG9g40IM6DlXJOSZYRsv9S052RnpPgOh/hatM8jN2Sz7e9k3/tCj2XuznJZ
	 +uIu7Jwdyh4sk6IVu8PSjsUkr9d52VswUbokbbF+ffW8oKOLfqS8TO6RSDmb4qktDWPtP
	 KxJY9ROvMcMsyTdp0HtgVsaFdh47gb9MWVKQwNRNvtKEFaenqTPBA4lldI4GsjNA3Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=HNmeM2fL;
	arc=none smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804F606A31F
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 01:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0804F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=HNmeM2fL
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NJPZkp2990918;
	Sat, 24 Oct 2026 01:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=vMB5CCN8oc1w7viRNLOL5JTv0ynjjVzVcENGNFkEU6M=; b=HNme
	M2fLeQD1xwyGVDPlbbcjyEU6Lyfsfy0vRkfO+LDjlEAFHrJZwjn1thNne/WAEbWD
	6T/MQVLt6ORpncrpHrc31qwesh/4LaChc6IwX09BYN5YgUQ2X74h+h9wZPKBkWML
	hrBdrRmXSbKx3FNU511SMMt/T7mCN11KH68+GoyfimTZxzW2SkFKsnmAlE6+kzUA
	hwLa9GhbsfPodxrIqkV4N3klKGgLRptt9h7R8pDUPwbHnAfWhH/eK8A+8Mim0k1C
	Y6NFDWeR9jtA8XYukCKdJTE+5W7EaBVE/UTjXP/KEA5C/yrRnaIDaWDiZDtdRm4F
	DSxS2M5wghQVRuDBlw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hg1teux9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Oct 2026 01:45:19 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Sat, 24 Oct 2026 01:45:18 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v8 2/7] libbpf: BPF program load strategy enum
Date: Fri, 23 Oct 2026 21:45:09 -0400
Message-ID: <20261024014514.2959514-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com>
References: <20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com>
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
X-ClientProxiedBy: 04WPEXCH007.crowdstrike.sys (10.100.11.74) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Authority-Analysis: v=2.4 cv=HaiB3SE8 c=1 sm=1 tr=0 ts=6adc0db0 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=pl6vuDidAAAA:8
 a=9FqMP2l-1xbnh21W5mUA:9
X-Proofpoint-GUID: pBZo_W8AbTSl8cCsZXit4DMCYFuL-NU2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfX0IZ5t/ufNbNd
 IVHTHpp99zDHEYjSJGbF0aGYsF1GetHRWZwdwm9zeixncwck2YnO/y/1wLCplgUpbU5B+xTG/1X
 MknV+nNXflQbpAAHN/gnq2Tp5TPl8CRio+nNG7nr7TDg9mg5MDPmAyP+MoqbSRpYxjIHIlIUWrk
 ru0mog2/cVJH3LXv2MTp63ru7Bu632EpsGXOAenkBwyqXpjwaq9+Ednwrad5cPkbzrvhW1CcwTI
 FpoSzfGWekCAY+X51rqQPVWpzN1t5C47m2YW/c9By8S20j61L2qxztGl3c1qU6zqTgLQqCl39zL
 9KCrPKMYhvM847sMbXU2zcNF3FET6wN2VSv9XE3nYF1iHwgCvpODL9XFJt127q8il23qixKDc8d
 xkLGi4rSIx73dMb6PE4N8Uw5+Q53ZF+aZjQRkRRAMh14svh2yzoX5eSvJNPTzfLhlJhUX1bWzgk
 x44gM4lUvJj+DpGYUVA==
X-Proofpoint-ORIG-GUID: pBZo_W8AbTSl8cCsZXit4DMCYFuL-NU2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfXzflSq0sh3wYO
 izg3T3YIMPBtoSPaRkGlTuLiD9fUiO60UzAMh/64+bXg851PjiSDzGlRIbB5ALZm2mxU28s65Yt
 EhHH4Hi3RzrSCghQxaVWtuCrINruGNpQf9Y6SYLe8d30l0iPaUmc
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11944
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240006

From: Slava Imameev <slava.imameev@crowdstrike.com>

This commit is in preparation for the next commit that introduces
manual program loading. Currently, the bpf_program structure defines
the autoload behavior using a boolean field. This field is now
replaced with an enum, allowing new BPF program loading strategies
to be introduced by extending the enum value range.
New getter and setter API is also declared for this enum handling.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c   | 53 +++++++++++++++++++++++++---------------
 tools/lib/bpf/libbpf.h   | 33 +++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  3 +++
 3 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6bb5887090cd..e4cdbc2f467d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -494,7 +494,7 @@ struct bpf_program {
 	struct bpf_object *obj;
 
 	int fd;
-	bool autoload;
+	enum bpf_prog_load_strategy load_strategy;
 	bool autoattach;
 	bool sym_global;
 	/* the program or a function that it calls has callx */
@@ -957,11 +957,11 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
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
@@ -1248,7 +1248,8 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 			}
 		}
 		if (use_cnt)
-			prog->autoload = should_load;
+			prog->load_strategy = should_load ? BPF_PROG_LOAD_STRATEGY_AUTO
+				: BPF_PROG_LOAD_STRATEGY_DISABLED;
 	}
 
 	return 0;
@@ -1339,7 +1340,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 				 * then bpf_object_adjust_struct_ops_autoload() will update its
 				 * autoload accordingly.
 				 */
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 				st_ops->progs[i] = NULL;
 			}
 
@@ -1377,7 +1378,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			 * if user replaced it with another program or NULL
 			 */
 			if (st_ops->progs[i] && st_ops->progs[i] != prog)
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 
 			/* Update the value from the shadow type */
 			st_ops->progs[i] = prog;
@@ -3812,7 +3813,7 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 	}
 
 	bpf_object__for_each_program(prog, obj) {
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 		if (prog_needs_vmlinux_btf(prog))
 			return true;
@@ -6501,7 +6502,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 			/* no need to apply CO-RE relocation if the program is
 			 * not going to be loaded
 			 */
-			if (!prog->autoload)
+			if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 				continue;
 
 			/* adjust insn_idx from section frame of reference to the local
@@ -8172,7 +8173,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		 */
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 
 		err = bpf_object__relocate_calls(obj, prog);
@@ -8208,7 +8209,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 
 		/* Process data relos for main programs */
@@ -9300,8 +9301,8 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
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
@@ -10093,7 +10094,8 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			    prog_has_callx(&obj->programs[i]))
 				text_has_callx = true;
 		for (i = 0; i < obj->nr_programs; i++)
-			if (obj->programs[i].autoload && !prog_is_subprog(obj, &obj->programs[i]) &&
+			if (obj->programs[i].load_strategy != BPF_PROG_LOAD_STRATEGY_DISABLED &&
+			    !prog_is_subprog(obj, &obj->programs[i]) &&
 			    (text_has_callx || prog_has_callx(&obj->programs[i])))
 				nr_progs++;
 		bpf_gen__init(obj->gen_loader, obj->log_level | extra_log_level,
@@ -10777,16 +10779,13 @@ const char *bpf_program__section_name(const struct bpf_program *prog)
 
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
@@ -16175,7 +16174,7 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		struct bpf_program *prog = *prog_skel->prog;
 		struct bpf_link **link = prog_skel->link;
 
-		if (!prog->autoload || !prog->autoattach)
+		if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_AUTO || !prog->autoattach)
 			continue;
 
 		/* auto-attaching not supported for this program */
@@ -16285,3 +16284,17 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s->progs);
 	free(s);
 }
+
+int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_strategy strategy)
+{
+	if (prog->obj->state >= OBJ_PREPARED)
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
index 03f794f4adb0..a91e43cbba20 100644
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
+ * Can only be called before the enclosing bpf_object is prepared.
+ *
+ * @param prog BPF program to update
+ * @param strategy new load strategy for the program
+ * @return 0 on success; negative error code if the object was already prepared
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
index eeba4072a5da..c06fc6b68efd 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -475,4 +475,7 @@ LIBBPF_1.8.0 {
 } LIBBPF_1.7.0;
 
 LIBBPF_1.9.0 {
+	global:
+		bpf_program__load_strategy;
+		bpf_program__set_load_strategy;
 } LIBBPF_1.8.0;
-- 
2.34.1

