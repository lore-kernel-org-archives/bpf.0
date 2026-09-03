Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C11F1513
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472086; cv=none; b=giSGMZllVd4F5Ho5Ycql0VpfE81AUZ/A/ZXeJZhU+jq/mS8JbZhHeSGHcx9+rcacY/5lIYTwswwejlnZEdOMpxXvwXKT4ZLp4kTcQkP0RN1tXJnqC7V/GP7On8aA6Bs/UBjrImae0aCGte43AvhJ3dPoWt5KpxbZOjbbe8UD6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472086; c=relaxed/simple;
	bh=F2i949FJZSKou/mNaBIUEFQxHUHpZR/dd7ecc4GoFAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7LwO5LwjkFS7Kg5nnj6rWWxm2sy898+REf+cKFao4VAzB0ZV7JMbZGCLUwqeiVUBUOd8LAgypiWNuZVgudaggA+RS4pXdzAomFwE4omMZnDKi5M3nakuwoRLXj9lnjdJFZCXWQbbFrqDdzcz0u2CkA1YCbV0nx2EqcSLI0ZSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9XdfHj8; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9XdfHj8"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so995435e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472082; x=1789076882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LK8T+LCX7ZLBFnEjg95sZWGcLy5dD4faOZGa52yv0Xk=;
        b=f9XdfHj8YNkZTTLwekHmmOMvaMQxAxYRG36jojHVvx7oO9uAFzjQv0/gCByZWwwunF
         gza2xRgsqTKKrD/p/PB+m98rburvDLC9N5Lil18dj3KX5RNvpKhZzEe02EffbWlyulvq
         UdYFaVSmpSivRdHvkpSL0Zo4dZOy/pCDw7qpHKtd6/2kN7Wrqmdhm6IaFuo469fumiXF
         neoRHt6CgQlGOZtSCYpHzyjqGFBTRPWwnmfWzgo8Dt+gBR5NhyAHCeSbiuGSIOrgsT0W
         842sJOCXiXSh/0oFK7l4AZKd1nThk8OFnMYKvpPZFFORh51oDr8DDSuiIPW0JOW6E90U
         Lr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472082; x=1789076882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LK8T+LCX7ZLBFnEjg95sZWGcLy5dD4faOZGa52yv0Xk=;
        b=Re+HIJK7HWcnpurygI/+XKew54nji74Ru2bHuAi20aB8OKYoxsw+0kZwwbA3nQFDdl
         rPQQDIrgxfYI0kdIzQsz2F2SDA+qO4HiraTYiO64gryIwYQEVVXv4GjoZgG+9NI94SrX
         FDSrZagVQ7HQC0CkuxHWcyCFj2hgTRWbVY7q99gcgBTY9z6Ayd/ohhdPqHPAERkWC5j3
         VzoHcHa4U2zBve2WdRMlPjNu2mlo8ZH/jY/CkGlTvAZHYgQB5/c2Bz2It00Vmk+Vj+O/
         UGnmy6EiSCORUBgRuUQcMjLAqnB0JiU/cupRKWRZo3l1gaJsAIOebd98+V6y3joY3kAo
         em8g==
X-Gm-Message-State: AFuF++mCe+99gjqmtBQa1NEeh2zk9DntjweVg0KOsfZtAsmQvasPa4b9
	d8IGyRRs4JGFM0EkHn0S/fZuSkZV/g8mXqf41sOkwaqi7U5q/wQSlK7BTiCkCX+6
X-Gm-Gg: AYBFou0ZKgbGv3/XhezrEl1xKTANYOziDPbNo9IS/nZfM6TPfLSzl/poOfkCdW5+oHx
	42TRO/UOA9oG796Hk2O7gQppY6cTAoql8cl1UFK0OxE0dPOzCahkuef78gDhO+yPIWfio6lus5n
	DG35m0XJzA9Ep8RtNgGVRvPvBTMUl1bmfzuctwynYux7y6wxsL0fjaLcok8ELSxarYhgkfWaOd0
	gq7ZQILkD0KH45faJl0e2WhoKmgnnQzVCUYHBtjHWw7FV0Bav8cQ/qzPegGqdCAhljnOxiW7sJr
	5qVclejk+LBAncKhzPSRe+aLZD4XzP9R/CNNFa75RBKvXwmfYMpWgSvlCo/CFQjum/XhUKJgYk/
	aEDTLQCuQeSrZTQ8dv0+Q6VOoE9U3/gjYcRD92vIMdJ7l2YlFhsotWXCsZj5WfHWMljAisNwBqf
	qfn7y54parpup9sl5gyuu0rl5QhU5ILNN2uhJFykaCel6agfA9QaoiSSszt6DvKc7WgTnUT6WTr
	7wouga9A6NzhfdOvEekuaw/T3eXQ6kMGeQo2vl/Imk9hDznnp1A72CDOmfMmwD95V+nojfNl2GV
	1uXRFrSmueoFKvrNPtKfbRKJDeg=
X-Received: by 2002:a05:600c:8b29:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cf824743cmr15464375e9.9.1788472082527;
        Thu, 03 Sep 2026 14:48:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm125010055e9.9.2026.09.03.14.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:48:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/8] selftests/bpf: Check rbtree callback restrictions in subprogs
Date: Thu,  3 Sep 2026 23:47:48 +0200
Message-ID: <20260903214758.2727663-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903214758.2727663-1-memxor@gmail.com>
References: <20260903214758.2727663-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2646; i=memxor@gmail.com; h=from:subject; bh=F2i949FJZSKou/mNaBIUEFQxHUHpZR/dd7ecc4GoFAk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvma5bs9OfLVukcU3p1e/usy2yH99zzC1MICVzrE9b+7 b2be8u3jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzk51tGhvf74p/IF/5Lsrkq E/Vc5OJC9dALPxvcvEyONBQaxjefM2L4X7ZHcJrnq6OlHFw7llZvelPEu2nD4/xeI53kC89jWpb GMgAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a verifier failure case where an rbtree comparator enters two nested
static subprograms and the innermost subprogram unlocks and relocks the
tree. Restoring the lock keeps the surrounding callback state balanced,
so the test specifically exercises whether the callback restriction follows
the nested calls.

Also add a load-only positive control whose comparator calls a harmless
static subprogram. This preserves the intended support for verified static
subprogram calls while holding the tree lock.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/rbtree_fail.c | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index 803419a47c62..4504608196ab 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -272,6 +272,47 @@ static bool less__bad_res_spin_unlock(struct bpf_rb_node *a, const struct bpf_rb
 	return false;
 }
 
+static __noinline void rbtree_cb_unlock_relock(void)
+{
+	bpf_spin_unlock(&glock);
+	bpf_spin_lock(&glock);
+}
+
+static __noinline void rbtree_cb_nested_unlock(void)
+{
+	rbtree_cb_unlock_relock();
+	asm volatile ("");
+}
+
+static bool less__bad_subprog_unlock(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a = container_of(a, struct node_data, node);
+	node_b = container_of(b, struct node_data, node);
+	rbtree_cb_nested_unlock();
+
+	return node_a->key < node_b->key;
+}
+
+static __noinline void rbtree_cb_noop(void)
+{
+	asm volatile ("");
+}
+
+static bool less__subprog_allowed(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a = container_of(a, struct node_data, node);
+	node_b = container_of(b, struct node_data, node);
+	rbtree_cb_noop();
+
+	return node_a->key < node_b->key;
+}
+
 static __always_inline
 long add_with_cb(bool (cb)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
 {
@@ -330,4 +371,18 @@ long rbtree_api_add_bad_cb_res_spin_unlock(void *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("can't spin_{lock,unlock} in rbtree cb")
+long rbtree_api_add_bad_cb_subprog_unlock(void *ctx)
+{
+	return add_with_cb(less__bad_subprog_unlock);
+}
+
+SEC("?tc")
+__success
+long rbtree_api_add_cb_subprog_allowed(void *ctx)
+{
+	return add_with_cb(less__subprog_allowed);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

