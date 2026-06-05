Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7F3E5A0A
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674841; cv=none; b=HzXBwdF++Wgv5SxlXmAuioH+JgXQed9rhnGqNSiTZHUWccpb5jm3NQoe7/p+kxjH/Ld3HPXHCR0r3hBmF1ZQ1l8NZNqvStbJ9LeZauoJGlF/siLrT93+PHRn5tCSGdDYfPKRGpl69eh38kXFNriauK12l1cqmcMzjRFwMo/I0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674841; c=relaxed/simple;
	bh=EgYgMVfqv6njLLBjyrAbnScrviM62jNC88o3hzWGWuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQ9mg3smD+hN6EwOqRJE9d1yhgashBpRU6uy5iZf1cngg5/ZLEQiyNlBlSUC5FquywuWRYf9ExZ2Wb7a1bCmyLH+65Dwg2d19NuYSZNbxVfdBGXMd6wy8GXpt6x/4FQp3e0ceKKCMip+CiifuILBrd3tiWO2u3pFszaa60QlyoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gyJBNUXm; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gyJBNUXm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780674835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4OrGRrkkmGvIx1F20YwZyuqT7Zri8Jmo/WTZI/HFMg=;
	b=gyJBNUXmseUQEgeOMEyh0cqqJZwbbyG8qEFRawMRfQ97CXO4OR6htkAVCNSm8N96H9g81X
	2cRrZPZYE6BTyxJ+9UhOyMn6SHeug2Z94Z07odNxuPD9fqEq5IDDAQD+Lb8vEeWF0w11UO
	x3d+0Ug2T8qaSOfpHnuU88brIWatRm0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuyang Huang <yuyanghuang@google.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests to verify checking padding bytes for bpf_[map,prog]_info
Date: Fri,  5 Jun 2026 23:52:49 +0800
Message-ID: <20260605155249.20772-4-leon.hwang@linux.dev>
In-Reply-To: <20260605155249.20772-1-leon.hwang@linux.dev>
References: <20260605155249.20772-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add two tests to verify that the tail padding 4 bytes of struct
bpf_map_info and bpf_prog_info are checked in syscall.c using
bpf_check_uarg_tail_zero().

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/bpf_attr_size.c  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c b/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c
index 32159dc64da8..87842c4347a6 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c
@@ -62,8 +62,63 @@ static void test_query_size_boundaries(void)
 	cgroup_skb_direct_packet_access__destroy(skel);
 }
 
+static void test_map_info_tail_zero(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	struct bpf_map_info_fake {
+		__u8 info[offsetofend(struct bpf_map_info, hash_size)];
+		__u32 pad;
+	} info = {
+		.pad = 1,
+	};
+	int map_fd, err;
+	__u32 info_len;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(int), 1, 1, &map_opts);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		return;
+
+	info_len = sizeof(info);
+	err = bpf_obj_get_info_by_fd(map_fd, &info, &info_len);
+	ASSERT_EQ(err, -E2BIG, "bpf_obj_get_info_by_fd");
+
+	close(map_fd);
+}
+
+static void test_prog_info_tail_zero(void)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_prog_info_fake {
+		__u8 info[offsetofend(struct bpf_prog_info, attach_btf_id)];
+		__u32 pad;
+	} info = {
+		.pad = 1,
+	};
+	int prog_fd, err;
+	__u32 info_len;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "test_prog", "GPL", insns,
+				ARRAY_SIZE(insns), &prog_opts);
+	if (!ASSERT_GE(prog_fd, 0, "bpf_prog_load"))
+		return;
+
+	info_len = sizeof(info);
+	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	ASSERT_EQ(err, -E2BIG, "bpf_obj_get_info_by_fd");
+
+	close(prog_fd);
+}
+
 void test_bpf_attr_size(void)
 {
 	if (test__start_subtest("query_size_boundaries"))
 		test_query_size_boundaries();
+	if (test__start_subtest("map_info_tail_zero"))
+		test_map_info_tail_zero();
+	if (test__start_subtest("prog_info_tail_zero"))
+		test_prog_info_tail_zero();
 }
-- 
2.54.0

