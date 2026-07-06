Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046440A95A
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358382; cv=none; b=AA4rIw9ycOsxx8wESbk7w2zVIVof92joN/zg3W3UEuCNJ9r/qNHAHjsdG/HvVq4fjG9Mh4eVwC31FaKKhwItIKDzRZfInoLo60O4OYMC7uhuzG5NxBxJo3dSS9zqw9DSJOY6hiFuFSGj65+9Ewd158WCnnQXlJQYbVCWh93GWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358382; c=relaxed/simple;
	bh=MPxEh0/3wooywxlth/LtHamyqmWIegcg6qFouIkhZo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mktXFn5P/TKHdRl1z71JGvCwsr65ySZpnH4eppZ+CcllOYaz+ItXO3FDIydDX7FfYF/lfNzhLZrQK7gnLz7LsMM8kYBIuLFgqAubgVQKqDLJGCnjhbMSkuV3mcKWbQv2UA1Ju7fARywqV8yTe/ggIUygLvDI7WLSPnbzWyaHtAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pv4bSNzE; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pv4bSNzE"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43cce8288c7so1411327fac.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358380; x=1783963180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQWIBdtgCcOi2hQRn9XvaotUq6iAQz/8mFPmCGlz/9w=;
        b=pv4bSNzEWEHSsvpaL6uk+NXLexsOcMbMHT0NrpNX78GHYC2HIz1a1Flh7dOs8tdPA9
         gkUJIJv2K/gsGY+uwI6Z9sCUplqJ9imffG3S1s4vBOv7Xp+cri7gll92RBGDI0Yd84vR
         ida0VlThaBwsezfXldPRt2XCp8qeCQ0nVJ6ZVnid6FS35wobHVRa2DmZJc1dKHofRAtp
         cLbQnSIYUtLRtHuGHBOnQvktZBpLio1iUXjUW+AHYtnuJVule2AQk6EHQzi3xwrFaepc
         YrM7C36k/OBci0jEPICcw66b5PPJ0BsqT9i73eyh0yuhbSQAZVO5+/52CqdtuiXx+xBv
         7e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358380; x=1783963180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AQWIBdtgCcOi2hQRn9XvaotUq6iAQz/8mFPmCGlz/9w=;
        b=X8smgUrh95S6cIEwpJ/NBXzoNGsYApXVLRd8efRU36bMc+M7H6nynv1hbFJPZvoc7D
         40HnFnvMgJAclFMda7uEr7dirYSU/n9bIb0ORXDgb+DLZjOwHvU5vcmKvEpaRHZtalti
         kEaawE1HIAssKHtf16Vh+a8UyTX0hfbATNTimtc+3ACwHcKqj2Pm3WYxUyU5ZfqLzaS4
         QAjEmIXdblJS7On1wdwq+083UQIuhnWNhXnW+d+BQD5t710W2qTFN+8QhO8Bnh+cSpoz
         RzOY7WmY8cf3/EQdk9LNm13BMnHRpYSFb63+efqDVKYNg2ROIVCKosiNoZJ10dsJP/qU
         xEAw==
X-Gm-Message-State: AOJu0Yy+f/JgHcXVPjEm6T2asCC1hg+kUujX1CctBMrZemX4G6xE4dFq
	05Ad8QfG/b9KEPY2dPMYg/hJZ+gN0xnKelXo4DPynqUlcvH1ZfpRqPFhACdKwQ==
X-Gm-Gg: AfdE7cmwOMK3qdG//znSkEf72PEVQm6TfADQ2W3PRT+gLTfAkdOfH/GMt+8+/ZO2a3M
	ScnP/BMONyaV/Fz3C82xerO703Y66H2y1lrA6GwUNDjrGHixEQ50RJ8kJYpcLLvE4Fz5/PPxt13
	A/Qcepvt20SLZVgcD/WYggYlAkJ+1gtZj5zAxMQkZLsGaKF741dk5VSZAGS1wK4uBprAXTFEDcw
	YBTGTZawo2YpnYDHEskYRGo9vjxS1V3Lb5mc64XFhqTb1CclRPDiGEz/Soxl3vjb2l/G4+DwfPw
	XBPpKWNnS/nKZlM4AszvksuN6GSzVM1wjbmYu+CeoWlTOq1WC5Ryz0CPHDJHhZAgvlMVARsdcAk
	pJMRHD0X0nPDVaBebjOzU9AeQIiA71GHzo1xZgG4bORxwXhn/hSNILnROak2LbDyVDoiECoI4MF
	kFA2M=
X-Received: by 2002:a05:6870:9590:b0:43b:9b9e:dc28 with SMTP id 586e51a60fabf-451064f99a9mr888782fac.23.1783358379299;
        Mon, 06 Jul 2026 10:19:39 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb13e15esm11667837fac.3.2026.07.06.10.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:38 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 08/15] bpf: Add a few bpf_cgroup_array_* helper functions
Date: Mon,  6 Jul 2026 10:19:10 -0700
Message-ID: <20260706171918.317102-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

In the upcoming patch, the array can store a struct_ops map.
The array could have a cfi_stubs acting as a dummy instead of
the dummy_bpf_prog. The array logic will need to skip the cfi_stubs
also in order to support storing struct_ops map in the array.

bpf_cgroup_array_length(), bpf_cgroup_array_copy_to_user(), and
bpf_cgroup_array_delete_safe_at() are added as a preparation work
to allow skipping the cfi_stubs in the upcoming patch. This patch
only skips the dummy_bpf_prog which is the same as the existing behavior.
The current bpf_prog_array_*() callers are changed to call the new
bpf_cgroup_array_*(). This is a no-op change.

Unlike bpf_prog_array_copy_to_user(), bpf_cgroup_array_copy_to_user()
does not need a temporary buffer. The cgroup caller already holds
cgroup_mutex and dereferences the effective array with
rcu_dereference_protected(), so it does not copy to userspace
from an RCU read-side critical section. Details in commit 0911287ce32b.

Another addition is the bpf_cgroup_array_free(). This prepares
the array to have a different rcu gp for the struct_ops use case,
for example, a struct_ops could have mix of sleepable ops and
non-sleepable ops. In this patch, bpf_cgroup_array_free() only
goes through the regular rcu gp. This is a no-op change also.

bpf_prog_dummy() is also added to return the global dummy_bpf_prog.

bpf_cgroup_array_dummy() is added to decide the sentinel based on atype.
It now always returns bpf_prog_dummy(). In the upcoming patch,
it can return a cfi_stubs if the atype belongs to a struct_ops.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/cgroup.c | 79 +++++++++++++++++++++++++++++++++++++++------
 kernel/bpf/core.c   |  5 +++
 3 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 047ffc029666..e371a4733135 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2561,6 +2561,7 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *include_prog,
 			u64 bpf_cookie,
 			struct bpf_prog_array **new_array);
+struct bpf_prog *bpf_prog_dummy(void);
 
 struct bpf_run_ctx {};
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 7abbe12e108f..081d81de1816 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -319,6 +319,67 @@ static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
 	link->cgroup = NULL;
 }
 
+static void bpf_cgroup_array_free(struct bpf_prog_array *array)
+{
+	if (!array || array == &bpf_empty_prog_array)
+		return;
+	kfree_rcu(array, rcu);
+}
+
+static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type atype)
+{
+	return bpf_prog_dummy();
+}
+
+static int bpf_cgroup_array_length(struct bpf_prog_array *array,
+				   enum cgroup_bpf_attach_type atype)
+{
+	struct bpf_prog_array_item *item;
+	int cnt = 0;
+
+	for (item = array->items; item->prog; item++)
+		if (item->prog != bpf_cgroup_array_dummy(atype))
+			cnt++;
+
+	return cnt;
+}
+
+static int bpf_cgroup_array_copy_to_user(struct bpf_prog_array *array,
+					 __u32 __user *prog_ids, int cnt,
+					 enum cgroup_bpf_attach_type atype)
+{
+	struct bpf_prog_array_item *item;
+	int i = 0;
+	u32 id;
+
+	for (item = array->items; item->prog && i < cnt; item++) {
+		if (item->prog == bpf_cgroup_array_dummy(atype))
+			continue;
+		id = item->prog->aux->id;
+		if (copy_to_user(prog_ids + i, &id, sizeof(id)))
+			return -EFAULT;
+		i++;
+	}
+	return item->prog ? -ENOSPC : 0;
+}
+
+static int bpf_cgroup_array_delete_safe_at(struct bpf_prog_array *array,
+					   int index, enum cgroup_bpf_attach_type atype)
+{
+	struct bpf_prog_array_item *item;
+
+	for (item = array->items; item->prog; item++) {
+		if (item->prog == bpf_cgroup_array_dummy(atype))
+			continue;
+		if (!index) {
+			WRITE_ONCE(item->prog, bpf_cgroup_array_dummy(atype));
+			return 0;
+		}
+		index--;
+	}
+	return -ENOENT;
+}
+
 /**
  * cgroup_bpf_release() - put references of all bpf programs and
  *                        release all cgroup bpf data
@@ -356,7 +417,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 		old_array = rcu_dereference_protected(
 				cgrp->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
-		bpf_prog_array_free(old_array);
+		bpf_cgroup_array_free(old_array);
 	}
 
 	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
@@ -530,7 +591,7 @@ static void activate_effective_progs(struct cgroup *cgrp,
 	/* free prog array after grace period, since __cgroup_bpf_run_*()
 	 * might be still walking the array
 	 */
-	bpf_prog_array_free(old_array);
+	bpf_cgroup_array_free(old_array);
 }
 
 /**
@@ -570,7 +631,7 @@ static int cgroup_bpf_inherit(struct cgroup *cgrp)
 	return 0;
 cleanup:
 	for (i = 0; i < NR; i++)
-		bpf_prog_array_free(arrays[i]);
+		bpf_cgroup_array_free(arrays[i]);
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_put(p);
@@ -625,7 +686,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 
 		if (percpu_ref_is_zero(&desc->bpf.refcnt)) {
 			if (unlikely(desc->bpf.inactive)) {
-				bpf_prog_array_free(desc->bpf.inactive);
+				bpf_cgroup_array_free(desc->bpf.inactive);
 				desc->bpf.inactive = NULL;
 			}
 			continue;
@@ -644,7 +705,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 	css_for_each_descendant_pre(css, &cgrp->self) {
 		struct cgroup *desc = container_of(css, struct cgroup, self);
 
-		bpf_prog_array_free(desc->bpf.inactive);
+		bpf_cgroup_array_free(desc->bpf.inactive);
 		desc->bpf.inactive = NULL;
 	}
 
@@ -1166,7 +1227,7 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog_list *pl,
 				lockdep_is_held(&cgroup_mutex));
 
 		/* Remove the program from the array */
-		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
+		WARN_ONCE(bpf_cgroup_array_delete_safe_at(progs, pos, atype),
 			  "Failed to purge a prog from array at index %d", pos);
 	}
 }
@@ -1296,7 +1357,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		if (effective_query) {
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
-			total_cnt += bpf_prog_array_length(effective);
+			total_cnt += bpf_cgroup_array_length(effective, atype);
 		} else {
 			total_cnt += prog_list_length(&cgrp->bpf.progs[atype], NULL);
 		}
@@ -1326,8 +1387,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		if (effective_query) {
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
-			cnt = min_t(int, bpf_prog_array_length(effective), total_cnt);
-			ret = bpf_prog_array_copy_to_user(effective, prog_ids, cnt);
+			cnt = min_t(int, bpf_cgroup_array_length(effective, atype), total_cnt);
+			ret = bpf_cgroup_array_copy_to_user(effective, prog_ids, cnt, atype);
 		} else {
 			struct hlist_head *progs;
 			struct bpf_prog_list *pl;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 649cce41e13f..1837bb7bb4e9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2740,6 +2740,11 @@ void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
 	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
 }
 
+struct bpf_prog *bpf_prog_dummy(void)
+{
+	return &dummy_bpf_prog.prog;
+}
+
 int bpf_prog_array_length(struct bpf_prog_array *array)
 {
 	struct bpf_prog_array_item *item;
-- 
2.52.0

