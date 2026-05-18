Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32852D46CE
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116262; cv=none; b=poOfU5eqQElWZuFw1nNlmFBWPeWAB651s4vkyehdriKg9aRHULYZby0v05CoYj+fSXje7jjRZEtZbKvq9u1SNb51UoNxzz5bOYJQkHzarVEIxLkOQ/nlryhfSqM8/83W4qAWRl46yZ0civfQQhFpAqCGvNziHklgGNwacqNDugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116262; c=relaxed/simple;
	bh=MBjxKxbXAwK9VAwBTFxKQYBX2TTKUE3ckNh3M8lySQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iw2FmwEYJfC/JEx+iLbQNwD9cFDiAbGpb+rkDtjmh1OEtQxos9qkwkjFA49DYLhYqkw064n6DtLukU4/mbQYOpuOgnuLxrq//YtfAVuG3pKaJ3j3W8GidxaChRVkC9acp4GPgvFqqE3k8rqp9FIwf9S7XoYwcZgskqHSYBy3OQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=agOkZaUZ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="agOkZaUZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779116247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfHKvl493EpE5JNIeT3IZgK04LdQ681Vp919WD94XH0=;
	b=agOkZaUZGYP1r8wrsO9K2nCyYh/duMvwluGlrLTWipuARFqwSihB9YNbQNYSphr/7Qabax
	jU6rJOn2SXUwHIre5mjewtgWnM8dKsoZyDYIAvmGp6Fd1oSPx4kRisLrGwR48IEmmmLfBs
	SKkeF1PYbvrQP2RB/ppqulD9CTqRNhk=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 5/5] selftests/bpf: Add test to verify checking padding bytes for BPF syscall common attributes
Date: Mon, 18 May 2026 22:54:46 +0800
Message-ID: <20260518145446.6794-6-leon.hwang@linux.dev>
In-Reply-To: <20260518145446.6794-1-leon.hwang@linux.dev>
References: <20260518145446.6794-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a test to verify that the tailing padding 4 bytes are checked in
syscall.c::__sys_bpf() using bpf_check_uarg_tail_zero().

Without the fix, the test fails with:

 test_common_attr_padding:FAIL:syscall unexpected syscall: actual 4 >= expected 0
 #213/12  map_create_failure/common_attr_padding:FAIL

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/map_init.c       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_init.c b/tools/testing/selftests/bpf/prog_tests/map_init.c
index b0b902d5783d..c804c3ce9be9 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_init.c
@@ -353,6 +353,30 @@ static void test_excl_prog_hash_size_2(void)
 	test_map_create_array(&opts, msg);
 }
 
+static void test_common_attr_padding(void)
+{
+	struct bpf_common_attr_fake {
+		__u8 attrs[offsetofend(struct bpf_common_attr, log_true_size)];
+		__u32 pad;
+	} attr_common = {
+		.pad = 1,
+	};
+	union bpf_attr attr = {
+		.map_type    = BPF_MAP_TYPE_ARRAY,
+		.key_size    = 4,
+		.value_size  = 4,
+		.max_entries = 1,
+	};
+	int fd;
+
+	fd = syscall(__NR_bpf, BPF_MAP_CREATE | BPF_COMMON_ATTRS, &attr, sizeof(attr), &attr_common,
+		     sizeof(attr_common));
+	if (!ASSERT_LT(fd, 0, "syscall"))
+		close(fd);
+	else
+		ASSERT_EQ(errno, E2BIG, "errno");
+}
+
 void test_map_create_failure(void)
 {
 	if (test__start_subtest("invalid_vmlinux_value_type_id_struct_ops"))
@@ -377,4 +401,6 @@ void test_map_create_failure(void)
 		test_excl_prog_hash_size_1();
 	if (test__start_subtest("invalid_excl_prog_hash_size_2"))
 		test_excl_prog_hash_size_2();
+	if (test__start_subtest("common_attr_padding"))
+		test_common_attr_padding();
 }
-- 
2.54.0

