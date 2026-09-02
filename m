Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE5340912B
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340292; cv=none; b=FzQfjroh5ZrMPgESdH7fH+Pygz0C0aK4uEfYZdsHcQhaS5/fhPSKAPE2qcYiHPl9fwNpsKBmq3I7LIr+BnpWc3KxEJOxpi8OWXRLJ29KG3EBRudUlxFbBkCJHEm4MrrO78NhpkcNSApCvf1cDMkdq6udi3fU20vOCWisZBVdZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340292; c=relaxed/simple;
	bh=TwD3ciNN2onW/ClKrqvIv5DgpyaXo+eUizIpw5s4WEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fT8c/IREWfRMnub0WYPjNvuBseSl0ORZjfRQxSIFpWLaYiNPt68KN3NAQMTQ5rocP0poM/p7gTEuaIuvraaz6UAfWXFUm4FbSIc0a1aZQW1zxDQ1nexLSaJOkMrzd0pq/fuIp+Wa77gRSeT+IxGP33mhCilwvs6FW2utqlqzZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLYaSJsV; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLYaSJsV"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so666427a12.2
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788340290; x=1788945090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LVMmah0vPgs6s4ge0RwtzmeRFF+Q41S+y1Nz1FY1ID0=;
        b=aLYaSJsVwoYAiPg8enckTHbr7YgG+F/GFYXGD6Y8oOYj6yLGIsgLRM414FyFCRNtd8
         vKmQAoY5ljVk6Ao0cuJrEVj8wWT6Ki3bT8O4TlZ/nsDXx3i6ponV8H6DTzGO6S5Q/5Ca
         71rR1NOfYgZOF8xFcV/Tih/1C42yaUjPeb9yKld0ypwQboHaapzBuz5JqHFtd94w6P4e
         7PrPL5IBcBHC8DbRGhDdtX7ieM6pzsqtF89z6wAm9XkxawAo0At0/O/yw7mFfb9me+1I
         WE/NSHabgav+D8VWbKnliNoXfUpBOcUba1/tN/YTIVaJY0IHMcj9cdBMelRjeci7v3Ej
         fPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788340290; x=1788945090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LVMmah0vPgs6s4ge0RwtzmeRFF+Q41S+y1Nz1FY1ID0=;
        b=GO+Wmm5671avejYJMMpUV1dmNr41SukbSx9WL6wMFsway7/QhhQAZZl+TpkAx7uC2O
         SrWtQ+cUYy2wMDQrjeBfsLfrXfTobJkoGOMdx7ocvZ+BOHz3i8V1KYXjvudY7lFI0sJR
         +v87kvDMhVaUvBBsCOgXClNVE4cp5E8iIUsesRk3Mnm1RVcSxY+pf8BcnYDSYSl8eXRI
         Wv4Khm6ss5Jm53v6mHP6mtMns9O/P/6UUN6zY1QtiM/ZlnvtfxPO3ngk638jDKU8oI8J
         MWbwnjM5xDm8xSg67K8ekTq+3KX0l3+LCsP80ooa+Io13uf8S4BCHgC2abB3BdOLy3vn
         MpIA==
X-Gm-Message-State: AFuF++kGF79UX016bMElvM1fUDx/V5nrUU9xT/u39/VuckkKXxPCDm+u
	ezC40xjMUiqrepP3ehH3P1srTVwy5Cg/+6aoO+gKspXFxUfq1IR8MIqKmuKVb7wj
X-Gm-Gg: AYBFou3gWNNndZIpLRmksFFnSD1n4cATO3sTMh5dKhVFEKQuSnHfwpuAD5iNeD5Vdni
	9pqFeoIc1FoigUdbr1Iol6X8s2v6gFmxVNm9C+qhyCzcwZkaNgsfb8VHL0IZkLfd4AXS6nPRbap
	7Paxp8bjBRfdZzntqgIw47JhMTsaB8MhRWNkyJaiT5MizIwF5ZS8t2v/t+Wf7eICNpEtGSJCLjV
	aXTO1HHSOYgQdNeeTBX7cSr1qmJ2FtwZ2r4iqKU9QMF4zkJaNTS2lkNXLAvVzpOuc0hmIWYJ16O
	q2cRe6lGvzshCZBi0+FVobKe/kwXQuChy47yuK/sZeqSV6SlBBqPgRi0nhdDlLijgx0sK3WFO/K
	KbxmD4OCOR3JvbUJx5PK25a9fydyJwRnOQOpQmPUwUowSOy5qUsiZcMdU3CV00bsV0FryvpoPqK
	fXamizKUOtd7hI/6WnrYfVl8rE7x9hmD50Qqqx5U5jr9IvJ4Z/RObq51+q/7mWF0S4ZJaPruUBJ
	UMxSlocSjiJ8Dkyh/vV1253HiEWvYGj5pS79mVHY0SLuaEoWpk=
X-Received: by 2002:a17:90b:3842:b0:398:e46e:ade3 with SMTP id 98e67ed59e1d1-39aee22248fmr4568173a91.23.1788340289374;
        Wed, 02 Sep 2026 02:11:29 -0700 (PDT)
Received: from localhost.localdomain ([187.14.92.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae380d7casm4449444a91.10.2026.09.02.02.11.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Sep 2026 02:11:28 -0700 (PDT)
From: Mark Amirkan <markdamirkan@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mark Amirkan <markdamirkan@gmail.com>
Subject: [PATCH bpf-next] libbpf: Reject oversized unknown BTF type records
Date: Wed,  2 Sep 2026 02:11:26 -0700
Message-Id: <20260902091126.59281-1-markdamirkan@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_type_size_unknown() returns an int, but calculates the type record
size using unsigned operands.  With a 24-bit vlen, an unknown kind whose
vlen is 0xffffff and whose info and element sizes are both 252 has a
record size of 0xfc00000c.  Converting this value to int produces
-67108852.

btf_parse_type_sec() returns the negative value, and btf_new() encodes it
with ERR_PTR().  Since the value is outside the error-pointer range,
libbpf_ptr() does not recognize it as an error.  On a 64-bit system, a
129-byte raw BTF input makes btf__new() return 0xfffffffffc00000c while
libbpf_get_error() returns zero and errno remains zero.  Calling
btf__type_cnt() or btf__free() on the result crashes.  The same input
makes bpftool's "btf dump file" command terminate with SIGSEGV.

Calculate the record size as size_t and reject values above INT_MAX
before converting it to int.  Add a regression test for the maximum-vlen
unknown kind.

Fixes: cacd6729c092 ("libbpf: Adjust btf_vlen() to return a __u32")
Assisted-by: Symbolic
Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
---
Testing:
- normal builds of libbpf and bpftool, plus an ASan/UBSan libbpf build;
- the reproducer through btf__new() and bpftool;
- the added btf_kind test and the existing encoding/decoding subtests;
- identical bpftool output before and after the fix for all 60 BTF blobs
  under /sys/kernel/btf on the test system.

The complete BPF selftest suite was not run locally because clang was not
available.

This fixes code present in Linux v7.2; please consider it for stable.

 tools/lib/bpf/btf.c                           | 11 +++++-
 .../selftests/bpf/prog_tests/btf_kind.c       | 39 +++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index c783359977b46e521965c1af223515cfd8701b12..83a7f199f37dfdc2384107a45a8be5b98c4cd8f1 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -421,6 +421,7 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
 {
 	__u32 l_cnt = btf->hdr.layout_len / sizeof(struct btf_layout);
 	struct btf_layout *l = btf->layout;
+	size_t type_size;
 	__u32 vlen = btf_vlen(t);
 	__u32 kind = btf_kind(t);
 
@@ -448,7 +449,15 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
 		return -EINVAL;
 	}
 
-	return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
+	type_size = sizeof(struct btf_type) + l[kind].info_sz +
+		    (size_t)vlen * l[kind].elem_sz;
+	if (type_size > INT_MAX) {
+		pr_debug("BTF type size %zu for kind %u is too large\n",
+			 type_size, kind);
+		return -E2BIG;
+	}
+
+	return type_size;
 }
 
 static int btf_type_size(const struct btf *btf, const struct btf_type *t)
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
index f61afe6a79a51f86f22f62bd86c685b7db8b39d1..fc6a4db9993764536885a5c5f13980a4c3a6bd26 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_kind.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
@@ -217,10 +217,49 @@ void test_btf_kind_decoding(void)
 	btf__free(btf);
 }
 
+static void test_btf_kind_size_overflow(void)
+{
+	/* Max vlen and aligned u8 layout sizes produce type size 0xfc00000c. */
+	struct {
+		struct btf_header hdr;
+		struct btf_type type;
+		struct btf_layout layouts[NR_BTF_KINDS + 1];
+		char strs[1];
+	} __packed raw_btf = {
+		.hdr = {
+			.magic = BTF_MAGIC,
+			.version = BTF_VERSION,
+			.hdr_len = sizeof(struct btf_header),
+			.type_len = sizeof(struct btf_type),
+			.layout_off = sizeof(struct btf_type),
+			.layout_len = sizeof(struct btf_layout) * (NR_BTF_KINDS + 1),
+			.str_off = sizeof(struct btf_type) +
+				   sizeof(struct btf_layout) * (NR_BTF_KINDS + 1),
+			.str_len = 1,
+		},
+		.type.info = (NR_BTF_KINDS << 24) | BTF_MAX_VLEN,
+		.layouts[NR_BTF_KINDS] = {
+			.info_sz = 252,
+			.elem_sz = 252,
+		},
+	};
+	struct btf *btf;
+	int err;
+
+	errno = 0;
+	btf = btf__new(&raw_btf, sizeof(raw_btf));
+	err = libbpf_get_error(btf);
+	if (!ASSERT_EQ(err, -E2BIG, "size_overflow_err"))
+		return;
+	ASSERT_NULL(btf, "size_overflow_btf");
+}
+
 void test_btf_kind(void)
 {
 	if (test__start_subtest("btf_kind_encoding"))
 		test_btf_kind_encoding();
 	if (test__start_subtest("btf_kind_decoding"))
 		test_btf_kind_decoding();
+	if (test__start_subtest("btf_kind_size_overflow"))
+		test_btf_kind_size_overflow();
 }

base-commit: d761934c9483ecde93fe99d8705282f716dfee50
-- 
2.39.3 (Apple Git-146)
