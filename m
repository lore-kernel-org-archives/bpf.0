Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2B4EDCB4
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675571; cv=none; b=lRwFmH4wNKZ6CuBKMM/MjVcsMcQ+WF7AERj60DlztqlHpaISXbviav3+kqqGHNsX+vc1fbfBm4Qnw7SxSR9m0rwtpv2Ze34MScx3vSf5WDhUzX+SrraWMXftkSygSv066aFtH71wO4Q3hKY8r5Uq2Kr4X5mzY/WTyOyCcbMScl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675571; c=relaxed/simple;
	bh=tjzXEgfla2TbBHWfMTdmELcpqbJjO7ndk2xjVxpfUKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZ9qzkG2ohMY141R536na0hi+LuptDKQPIOO/kEBh3yXvEuTKXEYEPxoV2JqZ8KbiPVdlHncRYr7qs+lBJsYYycD5F4tlqign1tLB9myiOjIuDOgmZ3B2fvzD028GGaYCEXegNmFt/Hdp//F9gL9rMl28mj8ym5SaM0CCcs/b2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kq0ZDDG7; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq0ZDDG7"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-80a7469f5e9so825076a34.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675563; x=1790280363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPbbEKsYdxHiKwPbbIAYoqawJhHZx1fdYna78HcY9Ow=;
        b=Kq0ZDDG73qnuvs2uAH1Zq4ZH01rCLi1jNO5E8iSGtQR9AM8YCbwtakGgyrHluyi5jH
         9swoXqFwZpEcRJ3DmBMT9TXMAbMz8Zq00bgEe+ckAtPpE46Vi0txxbTTSD980sWnu3cA
         PoJ79/07e7eb4SnF3sdotk5w+HHNl+cIOqpUiWOQV6JNHKeLGbZ0MC527paSDuRs36Pl
         EVEcD4/MWXJc6XpOjWyyGGVP66ROAYUVPKPU5v5JMkd12Xp3Bb1+wkq7ScaoorSPunEG
         tMEdLDSkEc8EDIevUjMVE10Lwxh9pDnY2JlHjgCq7LZqTaXrP1VAI85MfvF8TLf5jmb0
         LLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675563; x=1790280363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IPbbEKsYdxHiKwPbbIAYoqawJhHZx1fdYna78HcY9Ow=;
        b=sAWBcPIiE64yjejOG753w54e+8jhxWJzbkl1ZStFZUjl/FW3Bh+xcct4IHDo9q5NRz
         8tJi09yUMGamRqHISBbsxl+mIZqIHamJAX8dP1D2orkXElbo/iwrFE77zjInZcfW0F7M
         tEZgJRY1YOb1IKtbAP5Bnn2SfW1LKMcWzJFaY3aNwndkum1JwCOUy47vbE/5ICFWzBuS
         V8c3HnErmSNlQpl+bxm1TAfiY1vixg9PmydtDdEOaTOl5Lj+Pk2+yuOQe0cRWamRQqFl
         s9FS91prx9qYiFnFzXdlEvanE8xGjk7YWm8Z7tFQMrqkkZdowkQPrZg7lsWQ1g88HQLa
         8eRQ==
X-Gm-Message-State: AFuF++k5xZVq0jRy2m7LjR4/j9Q+sAAw6ijrwbF6rj3rF9QBUum9WRVq
	EtNtCt7MoGI6ve5S52d0PUpQkjh2UXa3zM+7Aah6EzHIEw26NzJ/2jdcsfdLSw==
X-Gm-Gg: AYBFou1zqmxAuo0pXlU4ojKQNA7i8nI1yLKjJuciMhA+tcXOOa83nOqwRDZxKwSpkS1
	Mh0s5GCMIr7OBx16YH6obuhhe8oR05NUrK2gAGlIOHiUNFrqIf1rG3l5wXXRZyAVkSNDUB0gxdl
	AoUKPxaZZSKqs05HEAQ1bNRSFkqwXbvZ5/7/AjnGURLTNSnkdOi73fIrjtOplEzCnu7PYwzgfsO
	Eo02oKHtrVW1R9mTtYOyv5X2qPLWBzSZYBv7ZEtm7GggQKv61j9MdHvYAvRbZbYuIDZf+RJEO5b
	oDQCInZE+ZY31pz1meC2KGaDUMNsd7Twh++ys5lTRMVRmgIRW04Dk0WRVZ9ouw5yD1y2UjHwbUv
	8Yifqc+g/fnRg5Vf/QpWVBuGVbwAZloPW4xPGB6uQrGbteFx1vqZTj8CLHU+SBN9wTY4iRF9bNe
	wPAJSIO1VnY/OTpi2ZL+BbUS/8wvot4yeq+8w9tuz6dH0EfdGKojE35BB/L6yO3w==
X-Received: by 2002:a05:6830:82c3:b0:80c:88c9:7dc5 with SMTP id 46e09a7af769-80de125a209mr255727a34.13.1789675562563;
        Thu, 17 Sep 2026 13:06:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c46199e7csm3492293a34.7.2026.09.17.13.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:06:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 08/15] bpf: Add a few bpf_cgroup_array_* helper functions
Date: Thu, 17 Sep 2026 13:05:34 -0700
Message-ID: <20260917200542.3689605-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917200542.3689605-1-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/cgroup.c | 80 ++++++++++++++++++++++++++++++++++++++++-----
 kernel/bpf/core.c   |  5 +++
 3 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 90ab467d25a2..b56e2a5ca548 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2598,6 +2598,7 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *include_prog,
 			u64 bpf_cookie,
 			struct bpf_prog_array **new_array);
+struct bpf_prog *bpf_prog_dummy(void);
 
 struct bpf_run_ctx {};
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 0ce58764caae..0c8f6f6be049 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -319,6 +319,68 @@ static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
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
+	for (item = array->items; item->prog; item++) {
+		if (item->prog != bpf_cgroup_array_dummy(atype))
+			cnt++;
+	}
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
@@ -356,7 +418,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 		old_array = rcu_dereference_protected(
 				cgrp->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
-		bpf_prog_array_free(old_array);
+		bpf_cgroup_array_free(old_array);
 	}
 
 	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
@@ -530,7 +592,7 @@ static void activate_effective_progs(struct cgroup *cgrp,
 	/* free prog array after grace period, since __cgroup_bpf_run_*()
 	 * might be still walking the array
 	 */
-	bpf_prog_array_free(old_array);
+	bpf_cgroup_array_free(old_array);
 }
 
 /**
@@ -570,7 +632,7 @@ static int cgroup_bpf_inherit(struct cgroup *cgrp)
 	return 0;
 cleanup:
 	for (i = 0; i < NR; i++)
-		bpf_prog_array_free(arrays[i]);
+		bpf_cgroup_array_free(arrays[i]);
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_put(p);
@@ -625,7 +687,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 
 		if (percpu_ref_is_zero(&desc->bpf.refcnt)) {
 			if (unlikely(desc->bpf.inactive)) {
-				bpf_prog_array_free(desc->bpf.inactive);
+				bpf_cgroup_array_free(desc->bpf.inactive);
 				desc->bpf.inactive = NULL;
 			}
 			continue;
@@ -644,7 +706,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 	css_for_each_descendant_pre(css, &cgrp->self) {
 		struct cgroup *desc = container_of(css, struct cgroup, self);
 
-		bpf_prog_array_free(desc->bpf.inactive);
+		bpf_cgroup_array_free(desc->bpf.inactive);
 		desc->bpf.inactive = NULL;
 	}
 
@@ -1191,7 +1253,7 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog_list *pl,
 				lockdep_is_held(&cgroup_mutex));
 
 		/* Remove the program from the array */
-		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
+		WARN_ONCE(bpf_cgroup_array_delete_safe_at(progs, pos, atype),
 			  "Failed to purge a prog from array at index %d", pos);
 	}
 }
@@ -1321,7 +1383,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		if (effective_query) {
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
-			total_cnt += bpf_prog_array_length(effective);
+			total_cnt += bpf_cgroup_array_length(effective, atype);
 		} else {
 			total_cnt += prog_list_length(&cgrp->bpf.progs[atype], NULL);
 		}
@@ -1351,8 +1413,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
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
index 4e208cc94752..227211166dcc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2784,6 +2784,11 @@ void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
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

