Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DCE3914F5
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768345; cv=none; b=dwyzSHpXGcQF7s9HhrVb27P0MKjpuXxLARAueT9QI3tSTdQxMqIGMdNxpI7YcXT7HeD6pEvPwaXR/4T3TAy2ikBvru3WbVHGWFG6mCqAbA0BYMmQbzm02TfzuA977/01Qe10pqKFh/fVEJSnGHO7HW3Zzqgt1ncAaqBxsud/Ats=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768345; c=relaxed/simple;
	bh=GPTQDZRWxtBtzN/l0L2pVL+KD5ipLVj0z0k+PDtvstQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3TbJ+HLhCA38mS0kHW8fJ3T2dZ2WHzr4ojdwywozZh55hXl6MiUh+OTJo1N5yd/87TI0Yeb5mow35dp0Nl81X0jJaN1EeNAX66IEXOaffJWLhWdWE0A35WGGdoFP2hVrHXGF9cQFeoyH4+Jh+qAPg/wil/Q6NzclU8nEfF4IBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ugKNXiPx; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ugKNXiPx"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QHokXH013959;
	Wed, 26 Aug 2026 18:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=mJyLUBkNYVaCsyXIHAoEQkJn0OCi5wZbc8vNTcPr6rM=; b=ugKN
	XiPxbci9RllB22bOjP58XU002ESeksuWiuiNm+Cp0JeUaF2MCZtby/iphvuOdGIH
	z/pQnZrWGbG5EdXqgU9mKWea9a8L9dXalTiIk1Pp53KXuG6q0g7VNNzKbbA6a29j
	cHOKVurxssvtOXZEK8ZUrIPRO+1xNHiWO/P0bbR6K/BFlyZhytUfaCvVwKynmeh0
	pSTQfC+DxpoUdKnRzdfFUIgaEvMxSt9ROJPFn2PzF5LJmZ5QxZn0wwVMAMt0liI6
	fhlVLmuw/caWxbmKgKvxJD3+9M5HpbH4flBlrtiMVd8veT8Hs6z7iQHqHICI+5sr
	mZzGBdfAlmndz7jmTw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ga4wcr6e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 18:18:30 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 26 Aug 2026 18:18:28 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v2 2/5] libbpf: BPF programs dynamic loading and attaching
Date: Wed, 26 Aug 2026 14:18:22 -0400
Message-ID: <20260826181825.1826541-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH016.crowdstrike.sys (10.100.11.68) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfX2OhWfwzDnOsk
 aP5WLgFjES+bowWBQSgTeRrCpHJfa3SCFKDLlHzOEHw2JqBqYaSCp3/rrjr+nncghumj7uWqV1o
 fAcvTtsi1PLYcKOrHw8z7NDuLLUkyxIAJVTu68t/0OItthxMkMzfB0cXvNnaQ2vvVIxi8QAIJ0C
 tGDeClw2sRo7R7+lXyGYbbYUc/bsW49q1w4BL9ttmg40Jk3L0JrmZl16mgriv8y2gRt+eme69CV
 AFk0/2fSd1vvSUj+NTEyqJuKbGpQmIhh6vq1XaMApYezigz5BMSV13qEvHbpFNCUvXZaUcZUsSA
 xanTI7q0VO5nJSltz4Cs65beG+gWnOP37u8GR7Bzb7sEeJxKOdxcCXCGpjpK6rmjXu0nbj2cEP7
 lf13YramRYyd/WGcupdhcbUIUYWZ/WZRgfccx0PCfECtlflD7OUbfxoNAiV40VJiurJQrqCqJq5
 3LpDshSYRh/FNyIq5sQ==
X-Authority-Analysis: v=2.4 cv=SbfHsPRu c=1 sm=1 tr=0 ts=6a8f2df6 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8
 a=NyzyoFC22tPhR07OuX4A:9
X-Proofpoint-ORIG-GUID: oEAmbGIBFW2_C7WZkJ4YAdshm5L7HIXd
X-Proofpoint-GUID: oEAmbGIBFW2_C7WZkJ4YAdshm5L7HIXd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfX8DSmwbO7UwQm
 s/rwi5GyxA1eH4hWEtIV54clki2pR4b/V7STJZXvES4irT8AVGt7zlgYJFXzZbz8Lr2OT9uuE8b
 7gotdC+84ZYu8kTHot6Mf7MkyKHdOYZyjRMXXIJ+jSYAdx33g0Y3
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11887
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260153

From: Slava Imameev <slava.imameev@crowdstrike.com>

BPF programs designated as dynamically loaded can be loaded and
attached independently after the initial bpf_object loading and
attaching.

These programs can also be reloaded and reattached multiple times,
enabling more flexible management of a resident BPF program set.

A key motivation for this feature is to reduce load times for
utilities that include hundreds of BPF programs. When the selection
of a resident BPF program set cannot be determined at the time of
bpf_object loading and attaching, all BPF programs would otherwise
need to be marked as autoload, leading to unnecessary overhead.
This patch addresses that inefficiency.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c   | 144 ++++++++++++++++++++++++++++++++++++---
 tools/lib/bpf/libbpf.h   |   4 ++
 tools/lib/bpf/libbpf.map |   2 +
 3 files changed, 141 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 821d854d43a9..c3fe1de43210 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -725,6 +725,7 @@ struct bpf_object {
 
 	bool has_subcalls;
 	bool has_rodata;
+	bool has_dynload_progs;
 
 	struct bpf_gen *gen_loader;
 
@@ -8056,7 +8057,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 			log_buf = prog->log_buf;
 			log_buf_size = prog->log_size;
 			own_log_buf = false;
-		} else if (obj->log_buf) {
+		} else if (obj->log_buf && prog->load_type != BPF_PROG_LOAD_TYPE_DYNAMIC) {
 			log_buf = obj->log_buf;
 			log_buf_size = obj->log_size;
 			own_log_buf = false;
@@ -8403,6 +8404,7 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 			pr_debug("prog '%s': skipped auto-loading\n", prog->name);
 			continue;
 		}
+
 		prog->log_level |= log_level;
 
 		if (obj->gen_loader)
@@ -9076,15 +9078,22 @@ static void bpf_object_cleanup_btf(struct bpf_object *obj)
 	obj->btf_modules_loaded = false;
 	zfree(&obj->btf_modules);
 
-	/* clean up vmlinux BTF */
-	btf__free(obj->btf_vmlinux);
-	obj->btf_vmlinux = NULL;
+	/* The btf_vmlinux data is needed for dynamically loaded programs,
+	 * so defer freeing it in that case to the end of the object lifetime.
+	 */
+	if (!obj->has_dynload_progs) {
+		btf__free(obj->btf_vmlinux);
+		obj->btf_vmlinux = NULL;
+	}
 }
 
 static void bpf_object_post_load_cleanup(struct bpf_object *obj)
 {
-	/* clean up fd_array */
-	zfree(&obj->fd_array);
+	/* The fd array is needed for dynamically loaded programs,
+	 * so defer freeing it in that case to the end of the object lifetime.
+	 */
+	if (!obj->has_dynload_progs || !obj->fd_array_cnt)
+		zfree(&obj->fd_array);
 
 	/* clean up BTF */
 	bpf_object_cleanup_btf(obj);
@@ -9678,6 +9687,8 @@ void bpf_object__close(struct bpf_object *obj)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
 
+	zfree(&obj->fd_array);
+
 	free(obj);
 }
 
@@ -9805,8 +9816,16 @@ bool bpf_program__autoload(const struct bpf_program *prog)
 
 int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
 {
-	return bpf_program__set_load_type(prog,
-		autoload ? BPF_PROG_LOAD_TYPE_AUTO : BPF_PROG_LOAD_TYPE_DISABLED);
+	enum bpf_prog_load_type type = prog->load_type;
+
+	if (autoload)
+		type = BPF_PROG_LOAD_TYPE_AUTO;
+	else if (prog->load_type == BPF_PROG_LOAD_TYPE_AUTO)
+		type = BPF_PROG_LOAD_TYPE_DISABLED;
+	else
+		return 0; /* Otherwise, keep the current load type. */
+
+	return bpf_program__set_load_type(prog, type);
 }
 
 bool bpf_program__autoattach(const struct bpf_program *prog)
@@ -15220,12 +15239,73 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s);
 }
 
+static int bpf_program__set_dynamicload(struct bpf_program *prog)
+{
+	struct bpf_object *obj;
+	const char *attach_name;
+
+	obj = prog->obj;
+	if (!obj)
+		return libbpf_err(-EINVAL);
+
+	/* Dynamically-loaded programs are not supported for gen_loader.
+	 * This is because bpf_object_load_prog is not called for
+	 * dynamicload programs, so dynamicload programs are not visible
+	 * to gen_loader. For this reason, prevent calling
+	 * bpf_program__set_dynamicload when gen_loader was used to
+	 * generate a BPF object loader.
+	 * A gen_loader implementation is being called for autoloaded
+	 * programs and defines its own model for loading BPF programs.
+	 * To pass a BPF program to gen_loader, set the program's load type
+	 * to LD_AUTOLOAD.
+	 */
+	if (obj->gen_loader)
+		return libbpf_err(-ENOTSUP);
+
+	if (prog_is_subprog(obj, prog))
+		return libbpf_err(-EINVAL);
+
+	attach_name = strchr(prog->sec_name, '/');
+	if (!attach_name || strchr(attach_name, ':')) {
+		/* Only reject programs that require BTF-based attach target
+		 * resolution (indicated by the SEC_ATTACH_BTF flag). Such
+		 * programs need the section name parsed for the attach target
+		 * function name (after '/') and optionally the module name
+		 * (before ':') for libbpf_find_attach_btf_id.
+		 *
+		 * Programs like SEC("classifier"), SEC("socket"), etc. do
+		 * not require BTF attach resolution and can safely use
+		 * dynamic loading despite having no '/' in their section
+		 * name. The BTF guard in libbpf_prepare_prog_load (checking
+		 * SEC_ATTACH_BTF) is the authoritative check; this is an
+		 * early-reject for programs that would fail there.
+		 */
+		long flags = prog->sec_def ?
+			(long)prog->sec_def->cookie : SEC_ATTACH_BTF;
+		if ((flags & SEC_ATTACH_BTF) && !prog->attach_btf_id)
+			return libbpf_err(-EINVAL);
+	}
+
+	obj->has_dynload_progs = true;
+	prog->load_type = BPF_PROG_LOAD_TYPE_DYNAMIC;
+	prog->autoattach = false;
+
+	return 0;
+}
+
 int bpf_program__set_load_type(struct bpf_program *prog, enum bpf_prog_load_type type)
 {
 	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EINVAL);
 
-	prog->load_type = type;
+	switch (type) {
+	case BPF_PROG_LOAD_TYPE_DYNAMIC:
+		return bpf_program__set_dynamicload(prog);
+	default:
+		prog->load_type = type;
+		break;
+	}
+
 	return 0;
 }
 
@@ -15233,3 +15313,49 @@ enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog)
 {
 	return prog->load_type;
 }
+
+/*
+ * This function must be called after bpf_object__load_progs.
+ * Dynamically-loaded program data is initialized on object load.
+ * Post-load initialization is not supported.
+ */
+int
+bpf_program__load_dynamically(struct bpf_program *prog, int extra_log_level)
+{
+	int err;
+	struct bpf_object *obj;
+
+	obj = prog->obj;
+	if (!obj || obj->state < OBJ_LOADED)
+		return libbpf_err(-EINVAL);
+
+	if (prog_is_subprog(obj, prog) || prog->load_type != BPF_PROG_LOAD_TYPE_DYNAMIC)
+		return libbpf_err(-EINVAL);
+
+	prog->log_level |= extra_log_level;
+
+	err = bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
+				   obj->license, obj->kern_version, &prog->fd);
+	if (err) {
+		pr_warn("prog '%s': failed to dynamically load: %d\n", prog->name, err);
+		prog->log_level &= ~extra_log_level;
+		return err;
+	}
+
+	prog->log_level &= ~extra_log_level;
+	return 0;
+}
+
+int bpf_program__unload_dynamically(struct bpf_program *prog)
+{
+	int err;
+
+	if (!prog || prog->load_type != BPF_PROG_LOAD_TYPE_DYNAMIC)
+		return libbpf_err(-EINVAL);
+
+	/* Close the file descriptor but retain the program's data to
+	 * support reloading the program if it is required again.
+	 */
+	err = zclose(prog->fd);
+	return err ? libbpf_err(-errno) : 0;
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 700634664e32..54d755861289 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -2083,15 +2083,19 @@ LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_pro
  *
  * - BPF_PROG_LOAD_TYPE_DISABLED: the program is not loaded.
  * - BPF_PROG_LOAD_TYPE_AUTO: the program is autoloaded when the bpf_object is loaded.
+ * - BPF_PROG_LOAD_TYPE_DYNAMIC: the program is loaded and attached dynamically.
  */
 enum bpf_prog_load_type {
 	BPF_PROG_LOAD_TYPE_DISABLED = 0,
 	BPF_PROG_LOAD_TYPE_AUTO,
+	BPF_PROG_LOAD_TYPE_DYNAMIC,
 };
 
 LIBBPF_API int bpf_program__set_load_type(struct bpf_program *prog,
 					  enum bpf_prog_load_type loadtype);
 LIBBPF_API enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog);
+LIBBPF_API int bpf_program__load_dynamically(struct bpf_program *prog, int extra_log_level);
+LIBBPF_API int bpf_program__unload_dynamically(struct bpf_program *prog);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 4d63dac8c3b7..a0389c58efe9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -464,4 +464,6 @@ LIBBPF_1.8.0 {
 		btf__new_empty_opts;
 		bpf_program__load_type;
 		bpf_program__set_load_type;
+		bpf_program__load_dynamically;
+		bpf_program__unload_dynamically;
 } LIBBPF_1.7.0;
-- 
2.34.1

