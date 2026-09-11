Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854F497B7C
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164293; cv=none; b=dzmTjAJ1aiV72hkebf8uieuyuBKa7UNYqBixsD9y/USIHWJGPYi/FGLx9mEA4xV9V1Cag2IiDleRs00nSVOBU3jDDMyotJh5e8BeaTaTmQqvJDqajjrcY0r3aQX0cBK3EkvJ+qNBNf4G6ClaiJ3S1PFi4mgoh+3s39WWJNgdZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164293; c=relaxed/simple;
	bh=Iooy0QvhVaJeAM54vbAazQ5KnqmTsAP4NwvbjXe8T7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjRxpJgWb7JAF6bYE1kNDHKKS8rUoxrxCHSBBQmROh/P0Ek8mKY8fipdLgYEl7LjAYsxZT8PZCoZEbpJ5slHqxhEBkh65y/rSSkOzqiOBlbLI8k3yrbZQxIThaX1e/EQ2qUKXPVYxdhrsK7xcdiVd3JsLqGdtTvfTbdl/PUlYgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D95tH12B; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D95tH12B"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f4e596e393so1666355a34.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164289; x=1789769089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ZkPkkBlDAQzEF0r7s0qJU0RGn6IMeky+qYbo+xqpZA=;
        b=D95tH12BOVVhk+LtW+DIcgnXz7q/8S219kFHkMsSTtZb7H/+LYFO5ungdzNJahTsX8
         5OE3c/AecjlB9AtJgpXd/StwU1XLVpiuXqEf+Jj/j0vs4r/pIsHG1sJWwDjYRUPN0/ky
         HsTHf4f3jH+mWxnk9AS1RBSbIbvF1d6JFKoBd5O8tpQZ/ByPXrxjtG6ohI/rOnpQDZ+B
         byL5Zk30q0c1VhhLgC94C42GBgWzDyskPi+mySkzzKHyrX3ka8mvsf0KznQAMDvDo+of
         RI1MipXjkybuQHARM/9Xuxzl8iASMVMW4gc+5x2PuFe8aZc4rs4riC4o2JQCMO8uDFUi
         i5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164289; x=1789769089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ZkPkkBlDAQzEF0r7s0qJU0RGn6IMeky+qYbo+xqpZA=;
        b=qga+Jo+Gm/Cnci0qOTvT969Dia9b1tihfKfYRN4P6MOMC4jAh0+4QOx90nDDR1ohkf
         f4ML4gg4lzcseBpc2M0dqMOoujRyQ4SrrrqYPFi22Gsb6k9uBmu4u4K6+fCCTtWvKd1O
         qx/MBIP/eIpWA1rLH0FA0GJQYgpvH5DoaiiNifK9Vf9a4jYWqfFxDbbOaVNQ9nZiEqFE
         4+tJST8RLSgV3KUxGHtHsU83pjznODyjD26wu2vyDTt2vPUCcBXLKvzer7mPQP3oKnDC
         IcUMV/CFyB0x1Jq8GtLIC/yLC7IktHGVnrzZKzgNVPaXlB7feXTFbhdW+5UoLU5xiBhx
         p0eQ==
X-Gm-Message-State: AFuF++n1ysuTxevbrlEI/dn2M2XNIPoqY4SaGJHZpt0vvJsf5EHHRU0z
	GhSPVxC416IQi304qbd1sA1Y3x9r92aSLSJH44aCmvn8gtXcWcGtUEOnkkDARg==
X-Gm-Gg: AYBFou0znB0G/8x4g7B7iegCA+j1Kn+kV6DDDunIQkQxhhK0JdhWu2MfURYeH8yP+07
	qSxEeNH2h54JMvq1H/dy9f6SMyfcbzAT2Z0NdGbFHi5gWysen5vPz3mXZpqYhWMz0AvCVys5aEj
	p6F3y8VCx96+GNXghDwLtMuJaD0+fEuuELZ4PqhYga+5oMhpLhT24g1fesxXYK+SWdhX4+ySVhR
	Q0m/pCT4bHrbOKuEy6qXo28Va9rZ7veQulJajh5aWdHv06FMJWD2r/dHamveEF+cWQJvOVjn9Er
	lnlnXUakbL2k0Eo5FfT10l9W0SXPnon1HvC40q2akRKoKdT8dQdDqOknxiVr3fXycN++oPrvxGt
	e17WLwV5oTQX1WOqOGn5KlwRPXj+c015dwweH+pJdZGq8GAp7YRkBl3Fp8f0gk+0NXxeFy4rc3M
	vFYt1Q5/wvAxgjjNZNaCWQSnuxT0fCHKdZsg1Kl5vZA64WPCta1hto2wPqMVl0inBua8s8/BEb
X-Received: by 2002:a05:6830:67fb:b0:7fa:ac4f:7a3 with SMTP id 46e09a7af769-80401986b9fmr5761313a34.31.1789164289062;
        Fri, 11 Sep 2026 15:04:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60feba1sm4375559a34.13.2026.09.11.15.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:48 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 22/23] selftests/bpf: Test nullable per-CPU kptr identity after exchange
Date: Fri, 11 Sep 2026 15:04:14 -0700
Message-ID: <20260911220415.1396439-23-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass two unchecked bpf_percpu_obj_new() results to bpf_kptr_xchg()
inside an RCU critical section. The exchanges consume ownership and
leave nullable RCU-protected aliases.

Checking the first alias must not make the second non-NULL. Verify that
bpf_this_cpu_ptr() still rejects the unchecked second alias.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/percpu_alloc_fail.c   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
index 3701f4ea58c7..57615b0f0c25 100644
--- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
@@ -24,6 +24,7 @@ struct val_600b_t {
 struct elem {
 	long sum;
 	struct val_t __percpu_kptr *pc;
+	struct val_t __percpu_kptr *pc2;
 };
 
 struct {
@@ -46,6 +47,8 @@ struct {
 
 struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
 void bpf_task_release(struct task_struct *p) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
 
 long ret;
 
@@ -123,6 +126,38 @@ int BPF_PROG(test_array_map_3)
 	return 0;
 }
 
+SEC("?fentry.s/bpf_fentry_test1")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
+int BPF_PROG(reject_nullable_percpu_xchg_alias)
+{
+	struct val_t __percpu_kptr *p1, *p2, *old;
+	struct val_t *v;
+	struct elem *e;
+	int index = 0;
+
+	e = bpf_map_lookup_elem(&array, &index);
+	if (!e)
+		return 0;
+
+	p1 = bpf_percpu_obj_new(struct val_t);
+	p2 = bpf_percpu_obj_new(struct val_t);
+
+	bpf_rcu_read_lock();
+	old = bpf_kptr_xchg(&e->pc, p1);
+	if (old)
+		bpf_percpu_obj_drop(old);
+	old = bpf_kptr_xchg(&e->pc2, p2);
+	if (old)
+		bpf_percpu_obj_drop(old);
+
+	if (p1) {
+		v = bpf_this_cpu_ptr(p2);
+		v->b = 1;
+	}
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
 SEC("?fentry.s/bpf_fentry_test1")
 __failure __msg("R1 expected for bpf_percpu_obj_drop()")
 int BPF_PROG(test_array_map_4)
-- 
2.52.0

