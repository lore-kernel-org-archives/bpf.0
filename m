Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C304DD6CA
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621714; cv=none; b=TUrbeyzEbnNoJX2wJu255Plt4/IaicekH1ev7CkrHoEmJP+HNhWzch97UGutZURDaHor7UiblcR4LOgSGc8yqxnlkymqN1fuzx2aOPMWugNmh/ltCy+e8Yo/IRDQwXDKpsODr+sh0xIvqlYBejpXKsNq3eZ/Uu9ffhPbeLzVzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621714; c=relaxed/simple;
	bh=R43vv5vbg8i6gM40o2wowFIyum1MtvK8mM1w2/l+nBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aq8DCiLH2wbwFk6H25uTQrAsri9q5OD6S9CG4GKirIlLELDP4HGDgWG1YhdveYunLAmsskAz1TqqweL+LTJimUwFQ++FsxubOhHjIbVC1on3gaSRLS0ZyjpU/c/qNELgH6Tz6FjR5W8YKtLWDO9GMrdspG+dFlHgSQRpengbELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZIjtqU5; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZIjtqU5"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9697a691b5fso40354241.3
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 11:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783621707; x=1784226507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NhibrNQPXo2WlkRwD8NEGe5eAjcpAJncxaDkhAvZ4Uo=;
        b=JZIjtqU5xu3zMycmMuRB/vrTlzn/foo+gZsQZGXEC6/5Qfsk4UosN0FdxIYUJ6000G
         0LYzzbA4i4gzVys+HfUM6N+/5fFeQJNZZOH64ng1EB2Bc7U3flL6dKl/gZaGZ5ylUQZT
         6MsnzpUDIb/01oFGUhpJ6Ywz/GVJNezEPZJwgXb2QIK4ZAwWe8SpCGE+yEtIKvofZ6i8
         Hg+0TndAd2SHSE+ZaKk19cArALnuvuaUBBHbLt5oC4KFXH+TeoDhCYjhblNRg+qRyhhq
         S1nKvp3H8vvduevtY33iSiAI0pq2NbJOsQ3zUcK13aC5/4p1XoUogzdyyP9m8bFlku1U
         D5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621707; x=1784226507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NhibrNQPXo2WlkRwD8NEGe5eAjcpAJncxaDkhAvZ4Uo=;
        b=JLJipPnd4Y7t/XOOOqx//f2o7Zu38195OO7knbvdP2H6S3MjEpXDxWf32Q+K6rEoXS
         YiU/9pVSp8LX23jhglnfy+NpZgDbmwn1OJXGIcgoefnA+czVWdStyI6A3/ijl/4KbUX3
         n8R0gyTll0l91wKAuzrRp0Clw7XboOETV2pT2D/NYdBepxeQjcEku6pf8HyX+Jh87+HO
         kw+A2Bnjc6E4zEIaRhFhjqNxQ5PXqNDW1ZkaXn1L66jqj+2RB5c0PDEreD+nZpDtaDi+
         ecbpRJdO72oqG4lNceF5OL7sVLGGNgT9q0WFAGqzhH6HIc8NBtT1SS4Q/PjpiJ9G2k9l
         BaSA==
X-Forwarded-Encrypted: i=1; AHgh+RqkgdH/rVUUSko5XT+UCRvErvSYH7W404wjRfZLhKo+17XvbjLLQwg7b6K0TastWth0pwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQkitMhlU1hhfllmwZvvVCpYsyFPsDwq+2DRCg6bw4C5RQS6a
	hpTKeR4x3hNLqXVVvYgaL+GTo0mlrqCYQPa79/YMahJSk5ETp9oFWmus
X-Gm-Gg: AfdE7ckNp9XbOZfSGOsGZqKPX1bysL0fsCaWQkvTpKOm4IgNH1Ufn0UfBWSgWc5Bn5i
	TfxHWKFxqAVjNxa6UByRviuGXzCCC/9ELrDLFgcp10PoMFVqApSJfcSJdHJo1dakrPAGBeXi/0t
	Kgat5Hr6MZ3/t5zL9BNNXPnPWfO2lOQFQdVkE/SvX6zHE+2AzyMA/69/1EyJ0OpSWtBNCMxEdvt
	PD0+6FP7q5CSDOw8aM6kIV0mpfWKvqd6lZVI7lRkmOfC0aucdyFZ/+7tL8ycbfH8xgmvBcWYIMm
	bacpT3iZsyE70ujcDx60x2xqbwrxUUdDkjSRG7YQ9I2pxDlConhcYEu8AiRG13ILK3wjZLTP2vU
	pBMBLxM6YtXozt9Deebk/Wape4XyngBBI8pwQZzLvurdNay0d6Fuc9HE5q65Q7N4UCoP1kXuOa2
	hK0viL//RvCW0zFgWEaCg=
X-Received: by 2002:a05:6102:3e0f:b0:737:783d:1900 with SMTP id ada2fe7eead31-744dff69b8amr5156645137.9.1783621706907;
        Thu, 09 Jul 2026 11:28:26 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed258bb75sm3437743241.1.2026.07.09.11.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:28:26 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: test bpf_cpumask_populate() rejects a borrowed cpumask
Date: Thu,  9 Jul 2026 14:28:00 -0400
Message-Id: <20260709182800.2037938-3-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709182800.2037938-1-main.kalliope@gmail.com>
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cpumask_populate() now takes a struct bpf_cpumask *, so update the
kfunc declaration and drop the struct cpumask * casts in the existing
populate tests. Add test_populate_borrowed_destination, which passes a
borrowed task->cpus_ptr and asserts the verifier rejects it as a writable
destination.

Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 .../selftests/bpf/progs/cpumask_common.h      |  2 +-
 .../selftests/bpf/progs/cpumask_failure.c     | 23 +++++++++++++++++--
 .../selftests/bpf/progs/cpumask_success.c     |  6 ++---
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index 86085b79f5ca..8fe01308d210 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -61,7 +61,7 @@ u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym __weak;
 u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
 				   const struct cpumask *src2) __ksym __weak;
 u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym __weak;
-int bpf_cpumask_populate(struct cpumask *cpumask, void *src, size_t src__sz) __ksym __weak;
+int bpf_cpumask_populate(struct bpf_cpumask *cpumask, void *src, size_t src__sz) __ksym __weak;
 
 void bpf_rcu_read_lock(void) __ksym __weak;
 void bpf_rcu_read_unlock(void) __ksym __weak;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index 4c45346fe6f7..74b4cd4bcdbb 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -231,7 +231,7 @@ int BPF_PROG(test_populate_invalid_destination, struct task_struct *task, u64 cl
 	u64 bits;
 	int ret;
 
-	ret = bpf_cpumask_populate((struct cpumask *)invalid, &bits, sizeof(bits));
+	ret = bpf_cpumask_populate(invalid, &bits, sizeof(bits));
 	if (!ret)
 		err = 2;
 
@@ -252,7 +252,7 @@ int BPF_PROG(test_populate_invalid_source, struct task_struct *task, u64 clone_f
 		return 0;
 	}
 
-	ret = bpf_cpumask_populate((struct cpumask *)local, garbage, 8);
+	ret = bpf_cpumask_populate(local, garbage, 8);
 	if (!ret)
 		err = 2;
 
@@ -260,3 +260,22 @@ int BPF_PROG(test_populate_invalid_source, struct task_struct *task, u64 clone_f
 
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+__failure __msg("expected pointer to STRUCT bpf_cpumask but R1 has a pointer to STRUCT cpumask")
+int BPF_PROG(test_populate_borrowed_destination, struct task_struct *task, u64 clone_flags)
+{
+	u64 bits;
+	int ret;
+
+	/*
+	 * task->cpus_ptr is a borrowed, read-only struct cpumask *, not an
+	 * owned struct bpf_cpumask *. The verifier must reject it as a
+	 * writable destination for bpf_cpumask_populate().
+	 */
+	ret = bpf_cpumask_populate((struct bpf_cpumask *)task->cpus_ptr, &bits, sizeof(bits));
+	if (!ret)
+		err = 2;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 774706e7b058..36f77b9732d4 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -785,7 +785,7 @@ int BPF_PROG(test_populate_reject_small_mask, struct task_struct *task, u64 clon
 		return 0;
 
 	/* The kfunc should prevent this operation */
-	ret = bpf_cpumask_populate((struct cpumask *)local, &toofewbits, sizeof(toofewbits));
+	ret = bpf_cpumask_populate(local, &toofewbits, sizeof(toofewbits));
 	if (ret != -EACCES)
 		err = 2;
 
@@ -824,7 +824,7 @@ int BPF_PROG(test_populate_reject_unaligned, struct task_struct *task, u64 clone
 	/* Misalign the source array by a byte. */
 	src = &((char *)bits)[1];
 
-	ret = bpf_cpumask_populate((struct cpumask *)mask, src, CPUMASK_TEST_MASKLEN);
+	ret = bpf_cpumask_populate(mask, src, CPUMASK_TEST_MASKLEN);
 	if (ret != -EINVAL)
 		err = 2;
 
@@ -855,7 +855,7 @@ int BPF_PROG(test_populate, struct task_struct *task, u64 clone_flags)
 	}
 
 	/* Pass the entire bits array, the kfunc will only copy the valid bits. */
-	ret = bpf_cpumask_populate((struct cpumask *)mask, bits, CPUMASK_TEST_MASKLEN);
+	ret = bpf_cpumask_populate(mask, bits, CPUMASK_TEST_MASKLEN);
 	if (ret) {
 		err = 2;
 		goto out;
-- 
2.34.1

