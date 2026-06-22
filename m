Received: from cvsmtppost01.nmdf.navercorp.com (cvsmtppost01.nmdf.navercorp.com [114.111.35.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C652B36F91C
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114449; cv=none; b=M14JOqEqdJB2bTOZRqqUg1njyx5FO+i+c6p4pREOXOiVQI6p9kjE9H2U8Ic6Ut1tetx6ukS+0ubUcNO9HkCeJjwDNfTqOtRr7Rb5f0jLDu/tb3OR1u1EOJnfc8eJm9lHFkaeodifdF9iFnb8QAPhGH22+jC4tN9SwgrnMOw9ypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114449; c=relaxed/simple;
	bh=mjmw6ab1USiMlNDTYflqoideVRVwKJWagHj67KUCJOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dF/+6BY4O3ALg+L7qZzVAt700R4gVLNIT7EF2zrO4t5D+PrYqNhK+YcU5LtdCE5Qb2Es0dQVGSiSwUdL80gZxHmIVakZVYQQYd4CnUaEX4fIs5pO7qqi2EXKzAyOIiEIXQ7UNjpw6mtvVPL6+TcKDuic2qlYIQ84s0MdmRfDKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com; spf=pass smtp.mailfrom=navercorp.com; dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b=jvjm2ZSh; arc=none smtp.client-ip=114.111.35.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navercorp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b="jvjm2ZSh"
Received: from kr0m-real-2 ([10.111.46.243])
  by cvsmtppost01.nmdf.navercorp.com with ESMTP id F8twi8o0SEKKK5o8ydp8rw
  for <bpf@vger.kernel.org>;
  Mon, 22 Jun 2026 07:17:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=navercorp.com;
	s=s20171120; t=1782112624;
	bh=mjmw6ab1USiMlNDTYflqoideVRVwKJWagHj67KUCJOU=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=jvjm2ZShWQCDH3TjFtM7RW4FAf/jQxvdG6tbjYnSUazogojDJMK2PkW9dNun7ClbB
	 HemCbIek3JIpuIzrE8QdC0P7ijQ8jGmYyj7A5WLCcnAr3DshRXsmqZqE55rBTX80H1
	 VKY55+2yu8fFVYyky77AB2gAnPE78geQsOEDWn16H8bnOHeSf9SbX2kdSXnWw+Hojb
	 Pghe3E4bXKR+Ah8YHhPckzLrnWVkQjpFbS+E5n6fCigd15oTpdhYwBU7S2Ty8KqWC9
	 hdlPNq5EQCHFjuGDI4jEyXH00ZJnPBo29m0HRj4ddZ6Fh2YaQz85r2UewJ0l/4Q/cF
	 8mnk6vP8cGKkQ==
X-Session-ID: GZPCApOEQCemHW0dlH-qBQ
X-Works-Send-Opt: T9YwjAumKAumKAbZjAgmKqKXKoJYFHmwFBwYjHmm
X-Works-Smtp-Source: PwK/KAU/FqJZ+HmdKoUm+6E=
Received: from localhost.localdomain ([10.25.121.184])
  by cvnsmtp02.nmdf.navercorp.com with ESMTP id GZPCApOEQCemHW0dlH-qBQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Mon, 22 Jun 2026 07:17:04 -0000
From: Gyutae Bae <gyutae.opensource@navercorp.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minsu Jeon <minsu.jeon@navercorp.com>,
	Siwan Kim <siwan.kim@navercorp.com>,
	Jonghyeon Kim <jong-hyeon.kim@navercorp.com>,
	Gyutae Bae <gyutae.bae@navercorp.com>
Subject: [RFC bpf-next 3/3] selftests/bpf: test BPF_F_COMPARE compare-and-delete
Date: Mon, 22 Jun 2026 16:16:49 +0900
Message-Id: <20260622071649.31541-4-gyutae.opensource@navercorp.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260622071649.31541-1-gyutae.opensource@navercorp.com>
References: <20260622071649.31541-1-gyutae.opensource@navercorp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gyutae Bae <gyutae.bae@navercorp.com>

Add a test for compare-and-delete on a hash map. There is no libbpf
wrapper yet, so it issues the request through the raw bpf() syscall and
compares against a revision field stored in the value.

A matching expected value deletes the element, a stale one leaves it in
place and returns -EBUSY, and deleting an already-removed key returns
-ENOENT. A compare window that reaches past value_size is rejected with
-EINVAL, as are compare fields passed without BPF_F_COMPARE, so a dropped
flag cannot silently turn into an unconditional delete. Running the same
call on an array map, which has no compare-and-delete handler, returns
-EOPNOTSUPP.

Co-developed-by: Minsu Jeon <minsu.jeon@navercorp.com>
Signed-off-by: Minsu Jeon <minsu.jeon@navercorp.com>
Co-developed-by: Siwan Kim <siwan.kim@navercorp.com>
Signed-off-by: Siwan Kim <siwan.kim@navercorp.com>
Co-developed-by: Jonghyeon Kim <jong-hyeon.kim@navercorp.com>
Signed-off-by: Jonghyeon Kim <jong-hyeon.kim@navercorp.com>
Signed-off-by: Gyutae Bae <gyutae.bae@navercorp.com>
---
 .../selftests/bpf/prog_tests/map_cmp_delete.c | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_cmp_delete.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_cmp_delete.c b/tools/testing/selftests/bpf/prog_tests/map_cmp_delete.c
new file mode 100644
index 000000000000..6d6df13adcc4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_cmp_delete.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2026 NAVER Corp.
+ *
+ * Author: Gyutae Bae <gyutae.bae@navercorp.com>
+ */
+
+#include <test_progs.h>
+#include <sys/syscall.h>
+
+struct val {
+	__u64 revision;	/* synchronization field we compare on */
+	__u64 payload;
+};
+
+/* libbpf has no wrapper that passes the compare-and-delete fields, so
+ * issue bpf() directly. 'flags' is a parameter so tests can also
+ * exercise the no-BPF_F_COMPARE case.
+ */
+static int cmp_delete_flags(int fd, const void *key, const void *compare,
+			    __u32 off, __u32 size, __u64 flags)
+{
+	union bpf_attr attr;
+	int ret;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.map_fd = fd;
+	attr.key = (__u64)(unsigned long)key;
+	attr.flags = flags;
+	attr.compare = (__u64)(unsigned long)compare;
+	attr.compare_offset = off;
+	attr.compare_size = size;
+	ret = syscall(__NR_bpf, BPF_MAP_DELETE_ELEM, &attr, sizeof(attr));
+	return ret < 0 ? -errno : ret;
+}
+
+static int cmp_delete(int fd, const void *key, const void *compare,
+		      __u32 off, __u32 size)
+{
+	return cmp_delete_flags(fd, key, compare, off, size, BPF_F_COMPARE);
+}
+
+static int hash_map(void)
+{
+	return bpf_map_create(BPF_MAP_TYPE_HASH, "cmp_hash",
+			      sizeof(__u32), sizeof(struct val), 64, NULL);
+}
+
+static void test_contract(void)
+{
+	const __u32 off = offsetof(struct val, revision);
+	const __u32 sz = sizeof(((struct val *)0)->revision);
+	struct val v = { .revision = 10, .payload = 0xabc };
+	struct val snap = v;
+	__u32 k = 1;
+	int fd = hash_map();
+
+	if (!ASSERT_GE(fd, 0, "map_create"))
+		return;
+	ASSERT_OK(bpf_map_update_elem(fd, &k, &v, BPF_ANY), "insert");
+
+	/* mismatch -> -EBUSY, entry preserved */
+	snap.revision = 9;
+	ASSERT_EQ(cmp_delete(fd, &k, &snap, off, sz), -EBUSY, "mismatch_ebusy");
+	ASSERT_OK(bpf_map_lookup_elem(fd, &k, &v), "still_present");
+
+	/* compare fields set but BPF_F_COMPARE omitted -> -EINVAL, entry preserved
+	 * (a dropped flag must not silently become an unconditional delete)
+	 */
+	ASSERT_EQ(cmp_delete_flags(fd, &k, &snap, off, sz, 0), -EINVAL,
+		  "cmp_fields_no_flag_einval");
+	ASSERT_OK(bpf_map_lookup_elem(fd, &k, &v), "preserved_no_flag");
+
+	/* match -> 0, entry gone */
+	snap.revision = 10;
+	ASSERT_OK(cmp_delete(fd, &k, &snap, off, sz), "match_deletes");
+	ASSERT_EQ(bpf_map_lookup_elem(fd, &k, &v), -ENOENT, "gone");
+
+	/* absent -> -ENOENT */
+	ASSERT_EQ(cmp_delete(fd, &k, &snap, off, sz), -ENOENT, "absent_enoent");
+
+	/* bad window -> -EINVAL */
+	ASSERT_EQ(cmp_delete(fd, &k, &snap, 0, sizeof(struct val) + 8), -EINVAL,
+		  "oversize_einval");
+
+	/* unsupported map type (no map_delete_elem_cmp op) -> -EOPNOTSUPP */
+	{
+		int afd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "cmp_arr",
+					 sizeof(__u32), sizeof(struct val), 4, NULL);
+		__u32 ak = 0;
+
+		if (ASSERT_GE(afd, 0, "array_create")) {
+			ASSERT_EQ(cmp_delete(afd, &ak, &snap, off, sz),
+				  -EOPNOTSUPP, "array_eopnotsupp");
+			close(afd);
+		}
+	}
+	close(fd);
+}
+
+void test_map_cmp_delete(void)
+{
+	if (test__start_subtest("contract"))
+		test_contract();
+}
-- 
2.39.5 (Apple Git-154)

