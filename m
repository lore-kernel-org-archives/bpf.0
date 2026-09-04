Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3523CB565
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511415; cv=none; b=G8IcLiVdy2XDpb2o372dffrSE18wRXjlnCv1nRLvR3p7MjwafTGv/geIM2dL7eJd9dtXJuo/z71pb9TeCktfIpimuqmu94Ni4zSzqUwcW8o38MbQWmcCicqymKY2STpoGeg1EZNpbcSbh+L85oBid+mE5H7NspBnemoj/P2Zubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511415; c=relaxed/simple;
	bh=KZwM6a3VZxaj4sMHGYhUUpBrjNnVWCw2ZvQaE/7m//c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnQHTzOFrskbJRAHdvbsbq6P99hDTLeiJxNxDeC33Dm42UiZEar/arFYFdmlH0ddkcXVtpLiNUuZRZtJH8SdcZ3bueVHN6FsaxDHsQzP0p1pZ08/Voxle8ZSU5T5ixZRtz1bUhCrVIYCQCTfcogvp7utBgMYqMEBHBmfa9o1DbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTbT11Kc; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTbT11Kc"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b46dc430fso1689805e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511410; x=1789116210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z3WAr11vjblmaC/H/rSaD9688Zc+rMF5P2kN9YAP1h0=;
        b=WTbT11KczNCtO7Jt49nTxHNPjjP08cDeUw9qQlkmZkZ5xqn302roCO/OpQ//6+b5ni
         IX3lhJFdnWCZGhkpr4onSOojR78gI8xZTsDpCwzDU8xXYJMFSWuDU+dyqdk+26EQbKQb
         pSv184f3CdymU+v3pNJNIfjKqwdAT7nsv0Bdlb3aFTzLv0IIX4doTDhZURNCd2RuzWwG
         XwuCh6igmO/wNXbJYHjNuJiA4XDx1m6AD+Xc8bgSD1HduWnXCHsZYbpGyj1D1LZjYxyJ
         hMNeoEaqX1+YIBWzfbN6xYBlM23HKGQWBxw3k8Kx5S9VYy/dCqpyGIdAivVAU++VF45w
         k4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511410; x=1789116210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z3WAr11vjblmaC/H/rSaD9688Zc+rMF5P2kN9YAP1h0=;
        b=HokZr1Z7sAiG05ZbBci0KjlJnkufERDxJU1eg55P2dr9aQhywnsK+2kTEbXnl/G0ph
         wR/p3JE+mPGUqDNeJKrsq3SkuliNb6zQnwafwiCgGT9dr863uvNBrGbR84kkBLQwym5K
         E9lGRRpXEKug6e0tMIFQlrBt2ADavx8htI5d4S16Ks0tRCu/C6WGjSM30KJWZU4KbUHU
         1LpqC5EbKLT06MRNgUozyziItabJJI+1qdAua5hCEI49K+RuF5bJ+J0yV5F1lIRDD0ig
         KvwnbVwEwFJt7BvWSTzpvSZXLGv39wnkby0gyx74biP+LyRQOQiywCDB8/2eSP/t0Wwc
         kE6g==
X-Gm-Message-State: AFuF++nlNbKih//Wx3iui3k1N/uTZn7JJVjo/eFH6+3p4gosq9Q+0lpm
	WZA1b21k3UWaQOVzXmhWtj3nlD2Xr/2sl4uzZIhMX0YVtQWaLACJnwLhKsMZ51mu
X-Gm-Gg: AYBFou0QlBT7/gepshNaa382bHBl3zfMSIecnW84LnTsDFVqGcRaNZZwEnH8Bb50VK7
	QQ1snYx5sB8pyiVy654kGomqb3eQP3oh8D9CEyzTXCxtxv1UY48BK0HB58nP/rUSHPs5EyZHgS3
	UW7bHyxsu+ZYdovQmZSbp/RhYZT/PLLZGqYPziCy+WnwA1xIirHW4bHTTmEP6GRXnEd2RT4tGYY
	ZTDT54umqQYeeEzWldXQsdqmwM/HCylterFyLlrT579kBgPFv8t15KNSXyMCOmMKT+272OfkhUk
	OcXr+tAQfZj6d+8Y9lqbtdFf+BFDrn9buv6cosF3KZdk29nVgZM5lrYpkfao1ZlLWFixG8i2r5Q
	YSOGmBWLdd2CvnppcUzXe+O3dUJ9Z3vN/y/Nz+8REDW1BFUlx90VjTCRStHn4MLnAwuwHXXmq7j
	hROgsP7mw2Iw8rAovrEfEXzoBJBbOSDCjA2cIpjNmjyKke21571Tt22SLv62XmjSK0jVprMwLfF
	oh0ANcVa45+wI0hGnMcOxN/1542u+78r6hsuOsxKJpOMXW8W+VW3DthR4BEm0e09eNY+tmjmwmQ
	HlPlcAXIE0+xmvrIyzsuiReX730=
X-Received: by 2002:a05:600c:348a:b0:49c:fa20:cc03 with SMTP id 5b1f17b1804b1-49cfa20ccedmr22032725e9.26.1788511409710;
        Fri, 04 Sep 2026 01:43:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm139645425e9.4.2026.09.04.01.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:43:29 -0700 (PDT)
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
Subject: [PATCH bpf v2 2/8] selftests/bpf: Reject non-percpu values in percpu kptr fields
Date: Fri,  4 Sep 2026 10:43:15 +0200
Message-ID: <20260904084325.52250-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904084325.52250-1-memxor@gmail.com>
References: <20260904084325.52250-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2612; i=memxor@gmail.com; h=from:subject; bh=KZwM6a3VZxaj4sMHGYhUUpBrjNnVWCw2ZvQaE/7m//c=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtWy8T3xUGlrzIlWsMfPpJcPi/v6cSSQ2V3ROuO50wSm v5ku9jvjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkThIjwwKOS/6f0tKnHWpc suaREeexyROtjyyXPyYYf8386aYn/FUM/4O2XXgs/oFtqpkL8xf+up/3D95We/+06vjbHQ1BLuw 5ovwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add verifier coverage for the two ways a non-percpu pointer can be stored
in a __percpu_kptr field: a program-BTF local allocation returned by
bpf_obj_new(), and a referenced kernel-BTF task_struct pointer.

Without the verifier fix, both programs are unexpectedly accepted and the
negative tests fail. Requiring MEM_PERCPU makes both programs fail
verification with the expected invalid-kptr diagnostic.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/percpu_alloc_fail.c   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
index 08379c3b6a03..3701f4ea58c7 100644
--- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
@@ -33,6 +33,20 @@ struct {
 	__type(value, struct elem);
 } array SEC(".maps");
 
+struct kernel_percpu_elem {
+	struct task_struct __percpu_kptr *task;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct kernel_percpu_elem);
+} kernel_percpu_array SEC(".maps");
+
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
 long ret;
 
 SEC("?fentry/bpf_fentry_test1")
@@ -137,6 +151,51 @@ int BPF_PROG(test_array_map_5)
 	return 0;
 }
 
+SEC("?syscall")
+__failure __msg("invalid kptr access, R2 type=trusted_ptr_ expected=ptr_task_struct")
+int reject_kernel_ptr_into_percpu_kptr(void *ctx)
+{
+	struct kernel_percpu_elem *e;
+	struct task_struct *p, *old;
+	int index = 0;
+
+	e = bpf_map_lookup_elem(&kernel_percpu_array, &index);
+	if (!e)
+		return 0;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 0;
+
+	old = bpf_kptr_xchg(&e->task, p);
+	if (old)
+		bpf_task_release(old);
+	return 0;
+}
+
+SEC("?fentry.s/bpf_fentry_test1")
+__failure __msg("invalid kptr access, R2 type=ptr_ expected=ptr_val_t")
+int BPF_PROG(reject_plain_alloc_into_percpu_kptr)
+{
+	struct val_t __percpu_kptr *old;
+	struct val_t *p;
+	struct elem *e;
+	int index = 0;
+
+	e = bpf_map_lookup_elem(&array, &index);
+	if (!e)
+		return 0;
+
+	p = bpf_obj_new(struct val_t);
+	if (!p)
+		return 0;
+
+	old = bpf_kptr_xchg(&e->pc, p);
+	if (old)
+		bpf_percpu_obj_drop(old);
+	return 0;
+}
+
 SEC("?fentry.s/bpf_fentry_test1")
 __failure __msg("bpf_percpu_obj_new type ID argument must be of a struct of scalars")
 int BPF_PROG(test_array_map_6)
-- 
2.53.0

