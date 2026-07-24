Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986D175A87
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920102; cv=none; b=fwmBPcRfsr5buSknDc0n0wUIlo5PTSTYYEQJ/t+R2KRqVib4iMu8UF6oudych030R3FuHzVRUrngicPGIzoJGnWm+6nYWPoYhgBFknXelm5gocZwGg57llTGCu17UhZyM+wY+1W4OOiVYt9P0iZhT4DUUX33aDr/HoOmob6fh9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920102; c=relaxed/simple;
	bh=NbZnfgDzMNmO2nWhwJF3sjD1KXg0ECrVFH4ZrVCB+Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdLBVRG8q4d6WN2OJN4p/FlvWC/DjQAT9L838rdhTzBFiR7xXRIDsbkV51v2jAm0jvLNfExp8icYWuMIUgOT/IbYPoajHtWW647RpQMaP3L5mNJweKJzHxiJ/Pjr8kSLZ5evd0nlcO0SjmnBMxPE3+UY5WXbf+j04TiEn3qYZwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LloFacTT; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LloFacTT"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so725969b3a.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920101; x=1785524901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ek6PLIWcZVqbz46udAmV5Oeoo++n54CK8ZkK4NLHeFw=;
        b=LloFacTThFshzHN0J/CunjHClNcnDa44FJhydYcfSVzvQIF7KAAShOFSKKse3TpFP+
         1R6vracYRGr7eCEcrcxfp+7fqClD4ESZeFVKbqsR92dzBcMP1b18pJPFyIo41L3CKOWx
         A9CLVghA+095QQK7gnfWNAXwBMoUUXS0OhxdJppfFoQnVjPkIuitGJaZoFLgMFcSC+ct
         PIszukLdD1EhUdMgNBDwv1ew7XRtRVAQCbDZ7GRVq/0pcUkwR5fK0bR88+zkGdwMDS8k
         e4VoPVmedHos6oGF5wAzykpZ12d9OkDm4rsG9GJu6XRf7fL9x7Hg4PXhFUyuaEyDQgfA
         KlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920101; x=1785524901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ek6PLIWcZVqbz46udAmV5Oeoo++n54CK8ZkK4NLHeFw=;
        b=BVU+zv3C0OhbUda9XXG95pWX0XcATQPt2Lae64wBlBYIqmR4yJpOMDYk+U2KGQiHQ4
         +QZburxEgUzcp5FU8NlRnCtLNqQ7vEQgEHn1eI8JavVS8ccxhmkTTcHZruoSJNaO8GmE
         d2xlMrtvQfK3oes/TUe0DX/+hf0WdlvVdYJ6tJ30zf2ipefHKF63/Jv/avDYcyEDlSWC
         XfQpYbqCajCReYY9Z9yf98Bswf/qOI0X37KJR1GxYU4MOLTZeERLeSllH8gpzHAO9JTL
         2ah/DklV3hwEp6dh20ITejp1BNOf7LhM/AmNo5N8OaJ9zYwcC3pBNXX1TqYi45B/yLte
         pyng==
X-Gm-Message-State: AOJu0YxmFyIsDNcFCWOTHxOuyQBOJ9AjtIdvCwHER/RhEVmn2RUbhq5k
	vVJAeh6jsG/5M/KN+8ah8iktQa7rk1vl5mw+/gIoz3Fqnxvx3yf0XnaclNYvzQ==
X-Gm-Gg: AR+sD12iST38IFj8KPytWcClR8J4C2o3wxFRncQ3W813vDLTP23cG1FXwCJQLeK2iP3
	2ssbWIkud+lQfUhPzSiPwBIJ4TJNjaMxKJ2moBQQLG5EbBsCy+mLXor+84Hw5MqqYmEMdNuwjGU
	4zqJdPdqgohrHLvhMvkgnKk9hmMDCZ0syrPnOzAVyghYmCZ9+Hzx2s5M3oLVEWYDiCdnLTld0H/
	DVXb0rynXkJZ3S8EaZQgNUy/uiYK7lquJx14TrSADV3xR8a1E1DjPzNpxsdKh77nQEBEwSDSBos
	CB4X0cPGD+5/HCVG8s5cDGuyrDXPhJbADOWp7zNUMhpz+s3i30h/zqQ2DfOqWPvjEHQoX4uVy6Q
	5iUfTI0lm4lrYXX9UgZDk1J0zoWYflLwHdA3RqYKpwzthveK4/9roCEC1+sBDQGbmV88=
X-Received: by 2002:a05:6a00:2308:b0:847:c014:864e with SMTP id d2e1a72fcca58-84e2b8d9bbfmr9633490b3a.30.1784920100906;
        Fri, 24 Jul 2026 12:08:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533cf5d2sm321618b3a.32.2026.07.24.12.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:20 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 06/18] selftests/bpf: Add tests for helper and kfunc mem+size arguments
Date: Fri, 24 Jul 2026 12:08:00 -0700
Message-ID: <20260724190813.1458271-7-ameryhung@gmail.com>
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

Make sure the return of map-of-maps lookup cannot be passed to nullable
memory buffer argument for helper and kfunc.

- mapofmaps_value_as_kfunc_mem_buf: an un-narrowed (possibly-NULL)
  map-of-maps value must not be usable as bpf_dynptr_slice()'s __nullable
  buffer. mark_ptr_not_null_reg() converts such a value to
  CONST_PTR_TO_MAP; without it check_map_access() would let the program
  read the inner map descriptor as raw bytes.

- mapofmaps_value_as_helper_mem_buf: the same map-of-maps value passed to
  a nullable helper mem argument (bpf_csum_diff()) must be rejected too,
  guarding that helper and kfunc arguments are checked the same way.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_mem_size_reg.c         | 60 +++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index be97f6887f0e..a81faa709dd5 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -67,6 +67,7 @@
 #include "verifier_masking.skel.h"
 #include "verifier_may_goto_1.skel.h"
 #include "verifier_may_goto_2.skel.h"
+#include "verifier_mem_size_reg.skel.h"
 #include "verifier_meta_access.skel.h"
 #include "verifier_movsx.skel.h"
 #include "verifier_mtu.skel.h"
@@ -221,6 +222,7 @@ void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_may_goto_1(void)           { RUN(verifier_may_goto_1); }
 void test_verifier_may_goto_2(void)           { RUN(verifier_may_goto_2); }
+void test_verifier_mem_size_reg(void)         { RUN(verifier_mem_size_reg); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_mul(void)                  { RUN(verifier_mul); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
new file mode 100644
index 000000000000..c8eee1350027
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct inner_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} inner_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__array(values, struct inner_map);
+} outer_map SEC(".maps") = {
+	.values = { [0] = &inner_map },
+};
+
+/* An un-narrowed map-of-maps value must be rejected as a __nullable kfunc mem buffer */
+SEC("?tc")
+__failure __msg("type=map_ptr expected=fp")
+int mapofmaps_value_as_kfunc_mem_buf(struct __sk_buff *skb)
+{
+	struct bpf_dynptr dptr;
+	__u32 key = 0;
+	void *inner;
+	char *p;
+
+	inner = bpf_map_lookup_elem(&outer_map, &key);
+	/* intentionally NOT NULL-checked: reg stays PTR_TO_MAP_VALUE_OR_NULL */
+
+	bpf_dynptr_from_skb(skb, 0, &dptr);
+	/* pass the un-narrowed map-of-maps value as the scratch buffer */
+	p = bpf_dynptr_slice(&dptr, 0, inner, 4);
+	if (p)
+		return p[0];
+	return 0;
+}
+
+/* An un-narrowed map-of-maps value must be rejected as a PTR_MAYBE_NULL helper mem buffer */
+SEC("?tc")
+__failure __msg("type=map_ptr expected=fp")
+int mapofmaps_value_as_helper_mem_buf(struct __sk_buff *skb)
+{
+	__u32 key = 0;
+	void *inner;
+
+	inner = bpf_map_lookup_elem(&outer_map, &key);
+	/* intentionally NOT NULL-checked: reg stays PTR_TO_MAP_VALUE_OR_NULL */
+
+	/* @from is a nullable read-only mem+size arg; outer value_size is 4 */
+	return bpf_csum_diff(inner, 4, NULL, 0, 0) + skb->len;
+}
-- 
2.52.0

