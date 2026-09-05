Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA523BBFA2
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591631; cv=none; b=eccOrzLQMu3x08ngJDv9w6B5ylG0weDDoL5enkPrCNiHUsUF7XXmTkQ0m5oASG0qsZXRx3CVnBaGP71dvixltJIMXxYZJi9oL6mUsxVUxC4UHAw4BgjEN013U0MaV8e5t7VI5wOlKwzUz4jTZDoz8LKStcrEmHSSGGjbRtoNSkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591631; c=relaxed/simple;
	bh=yXo+ocbaU1mZ+3A0KGSyqwcN3Mkz92lDF/oF7smubEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSPKa5Ax6uiM7sOEcQaEw9JrgXhtIIP/G+o5YuekFcWbdIDZJqcjMBudSWJszERMpndw3ijkZhGY311dNLjc1eUlLUMWNjPJ9JXMYWQnim4yHfs6i0ZK4VTD4JIU/NVyhQW9fBLsYuArO6Iyy9HB35tEnwa+AOyzBQhxpa0ojF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8L0Plhi; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8L0Plhi"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48431ba6e38so61854f8f.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 00:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591617; x=1789196417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fG+8MFfXGhPK74KyDNWdTwGZoDEnaJ1TfevqvpcLCCo=;
        b=q8L0PlhieQe+v4EkTTXAM8Pe6F8Bk1HKlElSLCGkGiTFtXUvV3rv1qCvG5PM4/Sja6
         vZHZI534RckaViK9XPNykhr0wbc59hYRTj7Y3LQGUJcb2UpBsULHgRg1PNgBTO1q1CTe
         J0YU2DZBjRvTnIbXjGveKlBDHnyITYo1IRV82GITJCNSTFgKIAD778RrsbHI4n6KKswi
         6sG+IXRcZGYWXjnJ+QPV34bnuPBVBqJlUkYnDRXO/gGTNWDUPVCkpE1hOWWioEwk63ld
         DhpGqkBhoHnP+G9kELu4lyIQIdoTBeXKDS3Qoz6ayJVLX73qmuO9W+K0qdMQr36M/Zph
         YQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591617; x=1789196417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fG+8MFfXGhPK74KyDNWdTwGZoDEnaJ1TfevqvpcLCCo=;
        b=tGqOaF7D9zftJJCxo3vlRjvA00qeu0J4Zit2Wqv/B4K7zHeP2v/7YtH05k8sbMVy3R
         2qE6EGzvsXdZkzXm1hGiPN9tBnFWiglu4DWvvezBLKt4XrLbXsxr8fdlsqR1FLVgbXcU
         B0yFtyRWHDJLZHdOagy4FWFSILnWjBo58Ix7L6lJnQHroooF2vAKNst/e+KxAgb5KDrj
         aWSO0omsOFd0/e5eci3jwdEyGvO5A44mIZrKQfB62T5kmJw7i1b+qRycV2lRGXj0fgV+
         yMdFRwlqMerL5EcofpVsE1EuRke+8iBwndIJP0LhP2p+R8jHLXeF8ogqfk6K3ugGCmiD
         QLUQ==
X-Gm-Message-State: AFuF++n9+MTGhF+FFASqEj+SZccLYosHhdS17awqoKwcWYZT1Uq8Za49
	yfZ72tCybANullapPO8iy05HmGETpUGU0dRnfDXm6IO5Gtp34t96XyrOBts/mwvy
X-Gm-Gg: AYBFou1z0jybCmbNVJF0hx5rYml+fr0Og3iTCjUbcSWKKSF7s7w58DfWwesvya89stL
	Kp4DqDXfvDMTEwGfTaHVF59D3lGbH7/+YQyFDFjI250yyX6VnnmW4bRJmc9+Xa62jX7xLtse8Lt
	B+ymL+RmOGa7L+/wmHbsxYzxhN+NSTs1AxKGkF+KL2ZmIs7U3KX/u0zlqg7g5PrrZnqYFMSeDTh
	Eru6S56bVKdO5ifRdGoSL2ze6xLPvd0ndvhkWQ0icE67eyLf90qs6yyKdBGLdbmksq/WFAmyYnI
	YjkTOGalXU9WiO1k/1MN4Em0ih4Vd172DF461PXdgi7J1ar2iIoPMDhx9rOejiuVjor4NMZhppL
	cA+IC48A7Ln5/jKWeLx+IBsM6i4xS3eBCLdOxIcky4xzAecATmsjXeSdOXUnObBRFWd29jzgvm5
	Ypnc5mjSwb/p+d/rwciWtL8DBMhMt/Fa5yHButtAgZiaiLSXcL5rZoerrSiQ7Yi8Jxs8+OwLtKG
	zAEG5Ho++cuZBC/hAHq11Z4Ndabn9TUjsitfVI8wPWxCZWlOwTmDmAeo+ucVOjZKLvG+8zOdUNe
	7BvAYnWZf2a4tV/AP2U0EQb+jsE=
X-Received: by 2002:a05:600c:871b:b0:49b:4eb6:6ffd with SMTP id 5b1f17b1804b1-49cf82cbac2mr95336745e9.5.1788591617221;
        Sat, 05 Sep 2026 00:00:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5941cb4sm114854285e9.4.2026.09.05.00.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 00:00:16 -0700 (PDT)
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
Subject: [PATCH bpf v1 8/8] selftests/bpf: Check callback map value lock identity
Date: Sat,  5 Sep 2026 08:59:59 +0200
Message-ID: <20260905070003.3193366-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905070003.3193366-1-memxor@gmail.com>
References: <20260905070003.3193366-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4200; i=memxor@gmail.com; h=from:subject; bh=yXo+ocbaU1mZ+3A0KGSyqwcN3Mkz92lDF/oF7smubEo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv23uVJjzeJ/5hXEeq27s+3xebZXn+F1Dh5YnL5mdfPt HvqxBnVUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIncU2FkuPPoT7b3X7X3C9/O k3/CsDhkUuqVtVt+TTinvJW7s2rHPW5Ghk+rHoT4TnuRsS0h5d7CuQH/XP5vmzG710uJ1YMnSej ZbHYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a verifier test which retains a map value from an outer callback and
then acquires a lock through an inner callback value before attempting to
release the outer value's lock. Both values can denote different elements,
so the verifier must reject the mismatched unlock.

Keep a nested same-element lock/unlock program as a positive control. This
ensures assigning fresh identities to callback map values does not reject
balanced locking through one callback argument.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_callback_lock.c        | 73 +++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callback_lock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 64ac49ad67e6..5c572dd725e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -25,6 +25,7 @@
 #include "verifier_btf_ctx_access.skel.h"
 #include "verifier_btf_unreliable_prog.skel.h"
 #include "verifier_call_large_imm.skel.h"
+#include "verifier_callback_lock.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
 #include "verifier_cgroup_skb.skel.h"
@@ -188,6 +189,7 @@ void test_verifier_bswap(void)                { RUN(verifier_bswap); }
 void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
 void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
 void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
+void test_verifier_callback_lock(void)        { RUN(verifier_callback_lock); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_callback_lock.c b/tools/testing/selftests/bpf/progs/verifier_callback_lock.c
new file mode 100644
index 000000000000..ee09dd66f467
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_callback_lock.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct bpf_map;
+
+struct lock_value {
+	struct bpf_spin_lock lock;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, struct lock_value);
+} lock_map SEC(".maps");
+
+struct callback_ctx {
+	struct lock_value *value;
+};
+
+static long lock_different_value(struct bpf_map *map, int *key,
+				 struct lock_value *value, struct callback_ctx *ctx)
+{
+	bpf_spin_lock(&value->lock);
+	bpf_spin_unlock(&ctx->value->lock);
+	return 0;
+}
+
+static long nest_lock_different_value(struct bpf_map *map, int *key,
+				      struct lock_value *value, void *data)
+{
+	struct callback_ctx ctx = { .value = value };
+
+	bpf_for_each_map_elem(&lock_map, lock_different_value, &ctx, 0);
+	return 0;
+}
+
+SEC("?tc")
+__description("callback map value has a distinct lock identity")
+__failure __msg("bpf_spin_unlock of different lock")
+int callback_value_lock_identity(void *ctx)
+{
+	bpf_for_each_map_elem(&lock_map, nest_lock_different_value, NULL, 0);
+	return 0;
+}
+
+static long lock_same_value(struct bpf_map *map, int *key,
+			    struct lock_value *value, void *data)
+{
+	bpf_spin_lock(&value->lock);
+	bpf_spin_unlock(&value->lock);
+	return 0;
+}
+
+static long nest_lock_same_value(struct bpf_map *map, int *key,
+				 struct lock_value *value, void *data)
+{
+	bpf_for_each_map_elem(&lock_map, lock_same_value, NULL, 0);
+	return 0;
+}
+
+SEC("?tc")
+__description("nested callback can lock its own map value")
+__success
+int callback_value_lock_identity_same(void *ctx)
+{
+	bpf_for_each_map_elem(&lock_map, nest_lock_same_value, NULL, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

