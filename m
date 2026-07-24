Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEA38D688
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920098; cv=none; b=WnqFEI1fXKyBbQ+tltcHZdLJ8wDm6XCp/9k77kC0yhERHeHLZXe9X5srOURWneuYKmbWET6qZkU3ZmXo8JspDWGeDnJHY2rS7Sf/x7Sm63G5pZ8KIFqINQdqEPg8Ivo9p4QTzTuhl0RyHGIJmQNhymFTgjl/h3rylCJsyac02RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920098; c=relaxed/simple;
	bh=X9eHBl2EZdZgVLt5k5Hqxcab3iW/olWH/45RdcdzSKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkGP5JqpH28MFMOSyAzMMGFWqarBtRyeCUc2vJvRbXgWz8V3vmbcv6NTl62xgi5pgzmOJ5Dv0nIpD1dq+KU2Zv+tLAl4PtJtt5TlWJIyHEBBKb4NK6msA/71x4NlCE0hGcQ4sZJKBOvJRkmLOoi/9yduipxTtucCVDCpJrROjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSkonxc7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSkonxc7"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848643382fcso909253b3a.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920096; x=1785524896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UvV94sHfNmRr0bNGnz672CJGfC3M2QNvsXPmdKyP1uM=;
        b=hSkonxc7HiImhU2Y+yh2XLXqHtlKqoBpcK2Y2m6xsz4XoczTXGEtDgga6kCVkP0fBq
         3oTyP+Z0n35qXgFQ6vrqNL4u3Uc8VTIoklKmQVMJaNVkXn8j/7myzM7UrJv4iUdPXZz0
         ClJbkkReqBe/PN9vSC2F5qt8unSk8Am7bUvAGn5GpvhOHg2xN9o3+jX23RUykyGAvyv+
         I/ctUd5Jb2fpyX+SVfwI+uiDMR44FKFEmwPuqa+jk2npyR+t0HO6MikrY/Z5wqWoW/0k
         a2AhGwvnTZwDiqhcBw+3qAK3ta2/+wTEhTkjxTsW3SrZtvN0keWE+wS+MuybT0DtRgse
         Nr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920096; x=1785524896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UvV94sHfNmRr0bNGnz672CJGfC3M2QNvsXPmdKyP1uM=;
        b=ajtXK8ZsJzyIBoxCbZ2gNTdljYqaVm8mFxYWJWe0pZFgMkH0Vo0/hC0MOnOMaNvoOd
         ZpEHI7H95gAaomhQf4PcTxpaKC8/gepaEJoljOQVRUWCgDiOK04JdT2sE+cvNdaBEZ11
         5JUx2Gca+IOQNTccSQgQESjGlOHSE6D23ZxAFHlFO5jjgYvYB5s6+f0zDwayjhhGJZP1
         ya7KTF05wFtA/yLaAOvvO7b8h53kgBqaIxKB5aM/XEI1ZjZRJFdlodT4ew6mXmJ5C6ug
         cTOS7uOX4GsALQScA3WijC9QSGj5n78c6iCYW0X5XGISdDiITsDR5TXsfzlUA4iO/7TC
         QVDQ==
X-Gm-Message-State: AOJu0Ywi7HzJ+FcM4aLUokyPpIRhSoKfz3rVWmZh3+3VxAdfL/Op7n99
	nr0vHLVYifZwXNHaG9k+WUhV5MxRz5eW0IaIYbiAO5Rjc3K/McdVVQ8iSC51ow==
X-Gm-Gg: AR+sD132YFFxaoyvu9OJ+RLzpgeGVMYc3xJbUQEI1Wuzgs5YbpGIc5XHuiwPwpYzrGS
	jRbM8M7O5+oLeN3703x0r0BK9qLtdEHwAETP3H6QeJdl9nL9tqlIiYvHzDKxeaIZhs+J60lZHU1
	Ah59ikBLFYI17fahqpHO0PPAy4cF0bPuDm5C+y21q9t1I+ydUj8dySBJiPS3lL1hqSzGv+Q3n1n
	Nl3m9e9OSekDzoIrrzQSXtAHicxEcXpR4R8/OqNvTUh4MoWZQFCGFdnl1j5Ax6bs8+V6ZFjW4PV
	cRHJ2AbOPC8j22M1cqMJKZ+pMBv5iK/WMljUFN8U2/dOuz/Tju4kiuth/wO6tbXvlBYfpGm5Yup
	hvMf6EGiYg8w2ogfD+gj3riekUX4z8PQsPXUzwInji6wHW3oO1syC+DRO+bDsd0oOrdSX
X-Received: by 2002:a05:6a00:3913:b0:848:57f3:8f8f with SMTP id d2e1a72fcca58-84e2c204c5bmr9195660b3a.51.1784920096229;
        Fri, 24 Jul 2026 12:08:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e583sm315088b3a.57.2026.07.24.12.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:15 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 02/18] bpf: Unify const map ptr argument checking for helpers and kfuncs
Date: Fri, 24 Jul 2026 12:07:56 -0700
Message-ID: <20260724190813.1458271-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724190813.1458271-1-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both the helper ARG_CONST_MAP_PTR and the kfunc KF_ARG_PTR_TO_MAP
recorded the map pointer in meta->map and, when a map was already
bound by a preceding timer/workqueue/task_work argument, rejected a
mismatching map.

Factor the logic into a single process_map_ptr_arg() used by both
paths. The bound-object name (timer, workqueue, or bpf_task_work) is
derived from the bound map's btf_record, and the register numbers in
the message are computed from the map argument position instead of
being hard-coded.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 97 ++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 53 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e8c76abbf76a..a3429610b426 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8274,6 +8274,44 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 
 static bool can_elide_value_nullness(const struct bpf_map *map);
 
+static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+			       argno_t argno, struct bpf_call_arg_meta *meta)
+{
+	/* Use map_uid (which is unique id of inner map) to reject:
+	 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
+	 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
+	 * if (inner_map1 && inner_map2) {
+	 *     timer = bpf_map_lookup_elem(inner_map1);
+	 *     if (timer)
+	 *         // mismatch would have been allowed
+	 *         bpf_timer_init(timer, inner_map2);
+	 * }
+	 *
+	 * Comparing map_ptr is enough to distinguish normal and outer maps.
+	 */
+	if (meta->map.ptr &&
+	    (meta->map.ptr != reg->map_ptr || meta->map.uid != reg->map_uid)) {
+		argno_t obj_argno = argno_from_reg(reg_from_argno(argno) - 1);
+		struct btf_record *rec = meta->map.ptr->record;
+		const char *obj_name = "workqueue";
+
+		if (rec->timer_off >= 0)
+			obj_name = "timer";
+		else if (rec->task_work_off >= 0)
+			obj_name = "bpf_task_work";
+
+		verbose(env, "%s pointer in %s map_uid=%d ",
+			obj_name, reg_arg_name(env, obj_argno), meta->map.uid);
+		verbose(env, "doesn't match map pointer in %s map_uid=%d\n",
+			reg_arg_name(env, argno), reg->map_uid);
+		return -EINVAL;
+	}
+
+	meta->map.ptr = reg->map_ptr;
+	meta->map.uid = reg->map_uid;
+	return 0;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn,
@@ -8349,29 +8387,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	switch (base_type(arg_type)) {
 	case ARG_CONST_MAP_PTR:
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
-		if (meta->map.ptr) {
-			/* Use map_uid (which is unique id of inner map) to reject:
-			 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
-			 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
-			 * if (inner_map1 && inner_map2) {
-			 *     timer = bpf_map_lookup_elem(inner_map1);
-			 *     if (timer)
-			 *         // mismatch would have been allowed
-			 *         bpf_timer_init(timer, inner_map2);
-			 * }
-			 *
-			 * Comparing map_ptr is enough to distinguish normal and outer maps.
-			 */
-			if (meta->map.ptr != reg->map_ptr ||
-			    meta->map.uid != reg->map_uid) {
-				verbose(env,
-					"timer pointer in R1 map_uid=%d doesn't match map pointer in R2 map_uid=%d\n",
-					meta->map.uid, reg->map_uid);
-				return -EINVAL;
-			}
-		}
-		meta->map.ptr = reg->map_ptr;
-		meta->map.uid = reg->map_uid;
+		err = process_map_ptr_arg(env, reg, argno, meta);
+		if (err)
+			return err;
 		break;
 	case ARG_PTR_TO_MAP_KEY:
 		/* bpf_map_xxx(..., map_ptr, ..., key) call:
@@ -12122,36 +12140,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (meta->map.ptr && (reg->map_ptr->record->wq_off >= 0 ||
-					      reg->map_ptr->record->task_work_off >= 0)) {
-				/* Use map_uid (which is unique id of inner map) to reject:
-				 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
-				 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
-				 * if (inner_map1 && inner_map2) {
-				 *     wq = bpf_map_lookup_elem(inner_map1);
-				 *     if (wq)
-				 *         // mismatch would have been allowed
-				 *         bpf_wq_init(wq, inner_map2);
-				 * }
-				 *
-				 * Comparing map_ptr is enough to distinguish normal and outer maps.
-				 */
-				if (meta->map.ptr != reg->map_ptr ||
-				    meta->map.uid != reg->map_uid) {
-					if (reg->map_ptr->record->task_work_off >= 0) {
-						verbose(env,
-							"bpf_task_work pointer in R2 map_uid=%d doesn't match map pointer in R3 map_uid=%d\n",
-							meta->map.uid, reg->map_uid);
-						return -EINVAL;
-					}
-					verbose(env,
-						"workqueue pointer in R1 map_uid=%d doesn't match map pointer in R2 map_uid=%d\n",
-						meta->map.uid, reg->map_uid);
-					return -EINVAL;
-				}
-			}
-			meta->map.ptr = reg->map_ptr;
-			meta->map.uid = reg->map_uid;
+			ret = process_map_ptr_arg(env, reg, argno, meta);
+			if (ret < 0)
+				return ret;
 			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
-- 
2.52.0

