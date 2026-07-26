Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923937CD41
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109855; cv=none; b=mTDinU1y/xxyU4m9ymwnsiDP54cqpZoPi3VqEFnpH38IMX6+0TIxpkrIFXdLiEVfRNyN0JxaOTMX275h8y1n8tAPxGxXDXqrYOdzKbVkOHyQwHBsZdVwxOjAfIp6b8I7PrjKL+kszlpkjo7UFRzIJmDtLng44sSYy7gHnRxzONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109855; c=relaxed/simple;
	bh=LyC8j31Vi+fTW4KQb3HmSEitI5UcWaIS9BDj6CLHmvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0GQBzXqJc5Ww/H7BpdualGe+Tz8EPOmdrrbAdRHghVYS8yc2393jww56oASXwzTKuwKuKiOVlIEVxB1/dTbUPmdeQlE7mXP5bZnC9y8/welzyrJzGa9uYdqXb2cYDobobI3miH+BvOemrpWGO4cSymB67f2hiApBEShzoXPjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSiqJHAG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSiqJHAG"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8487214ad2bso2931102b3a.1
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 16:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785109853; x=1785714653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F23Y7Q3+H7JGubFYx+cIJJklTgSkDTgooqHxl9nm8b4=;
        b=dSiqJHAGFI6SFk02jguAnCob5GDdNisVEEeiWv5E2lDnl/LSg+5f3wFevXgl2/Lpnl
         YY1VNJbV8fdFNlnyaYXc1iHAkIgj4WesZkjCYgW/TSBYMgODZpzyO2oDkG0hdHDDSyLw
         97A9D357OXPyTfrvTrMgiePLztyO6GFKXMIFm1DXmktu4E8soOXrlslxhcMqO3Vd6OA4
         WFK3UKailHp3GODy+CENwHTDQrGqr6xi7jb29n1F1DCqo93y+mvnhismqoZ+bjCUCXri
         Ll1WMn5ONFfSpuyBrmavqU50ea2MdRWjANEusammuP636dX6CNghdlRGJ4HGxD+oRoRn
         vsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785109853; x=1785714653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F23Y7Q3+H7JGubFYx+cIJJklTgSkDTgooqHxl9nm8b4=;
        b=IR1NEIgUy6Z84L2FvWF5Q3rN4ErUV3jAKj9hmpoPcyeCKUv0rIZ4sLMdVsazqhdL06
         6slKQL3tJXXs4Tf+WYPIj04jsb2zGSyIk3fEe4tEvHb7sulchj1rUPIYz1VPblzKj9of
         nLe0Vd86QUsDuNvC9zKX3cQq9PYIOw+2M3H73fNnpFbgyxoHZ7c7HtSREEhkR+6OH524
         QTgMI92Tv52X2eWchISXStAmpylez2ZnqbvlV2OpGV+1DdWhEKXenMns0Z8b7a1tIEY6
         QlWf54pL05AaCVsCSk5RdmvONo7i/huwPoElfDHiJbt/EMyIbsFvOM+MNOTSenES4z81
         t/BQ==
X-Gm-Message-State: AOJu0YzAywqOwAaG1RPpeZg/FSnbVgVrJD+36md5PJGvPi0UxGL5VFIu
	lepzmD4ZLAkzh/gu/d7ccrHX5GsSYllBZG2CO1XfQsIs9EqOm+vvc7xNDOQjYG5j
X-Gm-Gg: AR+sD10TGQuZRp/iUk1TBR/oLkpsW6iHGrbaVMNSgr+XOjL/pLpBKrsOFgyHGLngxVe
	Jwr63CvfQhc5PcYkTpqPFUIwdF+1vqMlRlnBeCG0bfITAXK1+r86EKXsQ/yEEnSV8y96B/9Vr2c
	nBKeqMvFJ8U0oOjqEauRXn6GEEydSKEDIK5fqaeM1NzHj+8HwS/uqSQLTGax2LccV8PlkNFyEn/
	B+p9msCd4vEDgrHIk23G8vDD8QbXNugi9/3KEXE9yCj3xpNgZK9UYWsViGJsbvhCb0sHEt4z/M6
	2AMhmW73gygAbqo0qAcOw24+/22dPUdcDLd2jIcEHt4pkiW9/vxZEm2FLqEoqIy6agRJ+vSNPED
	1M7or44fiWeWYJDzSnt7uH/pLLUbRxI8qfR0yIEUdrqdbhyZqtg0cvQ6mFjrrSMp+0KhNCE9Crq
	hLulgTysOuQ2UoK5/2KRfCvy/wQtAwvg==
X-Received: by 2002:a05:6a00:1706:b0:848:77b2:20a with SMTP id d2e1a72fcca58-84e5956565amr5210701b3a.39.1785109853572;
        Sun, 26 Jul 2026 16:50:53 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e534694a7sm2216910b3a.59.2026.07.26.16.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 16:50:53 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	davem@davemloft.net,
	greg@kroah.com
Subject: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in refcount_acquire
Date: Sun, 26 Jul 2026 16:50:30 -0700
Message-ID: <20260726235030.1152542-3-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260726235030.1152542-1-dingning04@gmail.com>
References: <20260726235030.1152542-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After bpf_rcu_read_unlock(), a refcounted map kptr is marked
PTR_UNTRUSTED because it is no longer protected by RCU. The
refcounted-kptr argument check ignores PTR_UNTRUSTED and still allows
bpf_refcount_acquire() on that pointer.

However, if another thread removes the object and drops its last reference, the
stale address can later be reused for another refcounted object. A
CAP_BPF-only reproducer observed bpf_refcount_acquire() returning
non-NULL through such a stale pointer.

Reject PTR_UNTRUSTED refcounted-kptr arguments and add a regression
test.

Fixes: 7c50b1cb76ac ("bpf: Add bpf_refcount_acquire kfunc")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260726021304.97ED91F000E9@smtp.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 kernel/bpf/verifier.c                         |  5 ++++
 .../bpf/progs/refcounted_kptr_fail.c          | 27 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1e7343b625de..63b1d997fe80 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12414,6 +12414,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			meta->subprogno = reg->subprogno;
 			break;
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
+			if (reg->type & PTR_UNTRUSTED) {
+				verbose(env, "%s is an untrusted refcounted kptr\n",
+					reg_arg_name(env, argno));
+				return -EACCES;
+			}
 			if (!type_is_ptr_alloc_obj(reg->type)) {
 				verbose(env, "%s is neither owning or non-owning ref\n",
 					reg_arg_name(env, argno));
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index acd3e81a3916..80b92d7ec9ca 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -127,6 +127,33 @@ long refcount_acquire_rcu_map_kptr_unchecked_drop(void *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("is an untrusted refcounted kptr")
+long refcount_acquire_after_rcu_unlock(void *ctx)
+{
+	struct map_value_refcount_only *mapval;
+	struct node_refcount_only *n, *m;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
+	if (!mapval)
+		return 1;
+
+	bpf_rcu_read_lock();
+	n = mapval->node;
+	if (!n) {
+		bpf_rcu_read_unlock();
+		return 2;
+	}
+	bpf_rcu_read_unlock();
+
+	m = bpf_refcount_acquire(n);
+	if (m)
+		bpf_obj_drop(m);
+
+	return 0;
+}
+
 SEC("?tc")
 __failure __msg("Unreleased reference id=3 alloc_insn={{[0-9]+}}")
 long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
-- 
2.43.0

