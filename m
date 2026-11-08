Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794106625;
	b=U/haoW7GtFS3R3yWuSvkZIRYjAW5gAmbA3Fd3psAjvv5nHZ66CUNrq+pL+CoztMDGHoz
	 5f/MKIu1KJnTNVkMs0hpcgX/ov5AFFD+BZdYCjeNj71OzsTDK6TtoWttMs0DS91zNJmg7
	 mmFizAo8TjOFQZXEkc/Qn/uc0CX6jsRcrOP2RRSQu5dBbuTcdpFEGq3YigcsYfYsx1SOK
	 8GJ5kG2C/MnEYA1InKbNdhhCx5rth8kEJF8qTEqM/8Yjt6IEuQt+CQ380eQneNUEgkasy
	 lr2eBMjHEK5KYdE1VPxsea5xfK7JI2YkewxuzYQNpMoiG6yehhJNXrswQCDUa/e5kVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794106625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Xm93MRL9UzeuApu+JGN8AFpYj50jQm3nhvRIye5xJDk=;
	b=ikbdme2bnZihf3bxpM+Q4CcHkqKSQbNK18szgNnFbDvtndtj92YtKhD7B5H9vz9bn/6R
	 Waie2pXB2RDCw1dbUMilOHnFw5XtQibqVtebXS1mu9w0yVJiFrTC78017w8dmElK6y2vu
	 5Cyo15X+MroZEPYggsRUYthOvCiJGdvkurPUlJMVWU9mWBxELKcltXwnyY4QeV67EnvGx
	 IYhZgEmZxoUdQdIIscGujDIUJ7IdELU6IpBB+6m5GUF10w7Zil/jwOM9XqIPm+v4JUrhy
	 AkwbUz0rZqh0++ypUtUi4pdlpzlQN7N57Q9EFyZ5eAbwVPtToR9Ef9DyG/pKmFsxElg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SWWZnmMK;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A3606D801
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 02:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E4A3606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SWWZnmMK
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-33e48934fa8so71296eec.0
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 18:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794106621; x=1794711421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xm93MRL9UzeuApu+JGN8AFpYj50jQm3nhvRIye5xJDk=;
        b=SWWZnmMKmDXbC+z5XL1lVTIIbcv8B7ETnjr6OmDayjkfIeN/o9faYXyLwM2hhzcyYv
         psNyd0o0qSVJwFWz4skGHsJAieT3j2pq5aX6YpY02JTo97c1RI+jWOKASygqeph3PnlO
         O12G2fdvCd/C3v4dIF5TtLAtasaXOF3pr+hhP95+EX22T94f5/layOL92qGYT4F4q0X+
         3a25IxDI0qpgbeaANRRpZphSZeO2ZKqOMmgDCLtStgenB87kyJpwUEh2c9Etn+rxFpQ/
         pEkNdvr+rrND0T8H+SqFEPiJjlZBT31s9QR2HeYbyBxc4Eaav2P/SSQtcPWZSHl6MNTK
         sc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794106621; x=1794711421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xm93MRL9UzeuApu+JGN8AFpYj50jQm3nhvRIye5xJDk=;
        b=2NRg7UZNnxe7RM8U0P+I6FWH9SU8V6atUlMjhiOM5N8ZdjxV5+j7WLP7c89fOqRofJ
         pEu1sDWBmHVfgWzwJg2yyMmSMB/gteK3shkg3Vojn5KZXzQocfbQEzzXNjduIqNMyrkQ
         VoxQtYYB9nf6Wm0z9stZ08b1G+EhvTsiySIB+i7LYW0CXgr71ly7tP5994rF5MJJDfbE
         vqT7ebG1LQudZuC9lwrGWfqqq7KdUf0c6XUD75n9mqzr0vhKUkXc0KubHqOxKrJOkoB3
         1rlvI2PKT5e8KD8XAvzbk9VoKKMEgA8METOFTRexo2av/iD3wgGMcBXsielOCGxTpOdq
         h7+Q==
X-Forwarded-Encrypted: i=1; AKwUvBz6NEtEDVqRNuSxafyl2zE/BLd5BShPQYfmDFQVHWxIzCg8YRLbI0DlZKQ7/0HCmmKzk2U=@vger.kernel.org
X-Gm-Message-State: APuU4Z84XS/DWRWwlNOA86lMk7N9GY3XJqYb7VzWMTmMY2lR9NEL89e/
	tJdYCr/uO5v78CgVp0+ayJzGkXmUyfGAttcU4dqpUW5uv6twbjYaBOMG
X-Gm-Gg: AYBFou2OwODMcuJ191l0wxnFFTptQT9bwMnJGUUWU/tfvbxh8D1klyAQVBKxwoMmz9l
	gpEr1B9rMsdIY7uqc7mDN07MsweyfWINBLS3VKs0ECNkKcY1GZy88czCPzqswQf+ZLGOPOsYEUw
	GuUFRWTta1sEV/wevziOFn09otEgz72Rn69nfB3TpWnO/tMKhOhzjTCH9RbiEWShAYAHCwSralv
	hDThoTZMh1PcUr2TlPLfL9Bo6ysVht9+sTksp7TXhmdCR+Vee7301s4QqraMym9GMoocaguQ/jO
	6xd2uoOKVP9tDSydGhyja9Pt/Qrw80oJataRC0faIX+PohKzeN/1sffoQvE/9wvLeQuHTYXNX7U
	nzGTMucysPxNg4gbYXch7NQUUizfx7LMxOXSS0J4CAQqDoCWxDJtb/y3mobCoqfYr0R+CVKBaOF
	fDdvR96merNh/N5uBGUKW2kGfETN/nWddvcCn9vXz5OOUqRYd4ymK8NYDN/D6HxqmAReYKNQYMc
	DbleWB6R5nennyPZSUEML5JEeuaO57JPgyYtExXX+11junzAYIm3nW2H9P2MwkUJ/syLMS/ljNc
	l5lYKv/vQuOfZ3rgq362zNq/1pQXltU3zFJ88CYKgE/U16zIAjfy8LE/lC/rb72OiN6MJ6f8lay
	802TUOs1Q7O+PNDBM6Q62tQDrcwVFOr+ncmdVgw==
X-Received: by 2002:a05:7022:28b:10b0:1b0:430d:d81c with SMTP id a92af1059eb24-1b39feab6a4mr592842c88.25.1794106621327;
        Sat, 07 Nov 2026 18:57:01 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3773ea50asm2241202c88.23.2026.11.07.18.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:57:01 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ast@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	qmo@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Cover enum signedness in data dumps and map fields
Date: Sun,  8 Nov 2026 02:56:32 +0000
Message-ID: <20261108025632.10799-4-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108025632.10799-1-dennylin0707@gmail.com>
References: <20261108025632.10799-1-dennylin0707@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check unsigned and signed enumerator names in libbpf's existing enum
data test. Create a new dumper after adding the test types, as the data
dumper does not resize its per-type state for newly added types.

Extend bpftool_map_dump with one BTF-backed array map containing four
enum fields. A single JSON dump checks unsigned and signed names and
unsigned numeric output for ordinary enums and ENUM64. Plain output
uses the same enum dumper and does not need another invocation.

Also use an open-only arena skeleton to check an enum-backed map_extra
value with bit 31 set. The object is not loaded into the kernel, so the
test needs neither arena support nor mmap.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 .../bpf/prog_tests/bpftool_map_dump.c         | 76 +++++++++++++++++++
 .../selftests/bpf/prog_tests/btf_dump.c       | 20 +++++
 .../selftests/bpf/prog_tests/map_extra.c      | 19 +++++
 .../selftests/bpf/progs/test_map_extra.c      | 12 +++
 4 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_extra.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_extra.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
index 187b3f784307..a9584c83023c 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
@@ -7,6 +7,7 @@
 
 #define PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_sk_storage"
 #define QUEUE_PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_queue"
+#define ENUM_PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_enum"
 #define JSON_ERROR	"{\"error\":\"can't dump sk_storage map"
 
 /* An empty socket storage map with an int value. */
@@ -124,10 +125,85 @@ static void test_queue(void)
 	close(map_fd);
 }
 
+struct enums {
+	__u8 u8_name;
+	__s8 s8_name;
+	__u32 u32_num;
+	__u64 u64_num;
+};
+
+/* An array map. Its value is struct enums with an enum behind every member. */
+static int create_enum_map(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	struct btf *btf;
+	int fd = -1;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf__new_empty"))
+		return -1;
+
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);	/* [1] */
+	btf__add_enum(btf, "u8", 1);			/* [2] */
+	btf__add_enum_value(btf, "U8_MAX", 0xff);
+	btf__add_enum(btf, "s8", 1);			/* [3] */
+	btf__add_enum_value(btf, "S8_NEG", -1);
+	btf__add_enum(btf, "u32", 4);			/* [4] */
+	btf__add_enum_value(btf, "U32_ONE", 1);
+	btf__add_enum64(btf, "u64", 8, false);		/* [5] */
+	btf__add_enum64_value(btf, "U64_ONE", 1);
+	btf__add_struct(btf, "enums", sizeof(struct enums)); /* [6] */
+	btf__add_field(btf, "u8_name", 2, 0, 0);
+	btf__add_field(btf, "s8_name", 3, 8, 0);
+	btf__add_field(btf, "u32_num", 4, 32, 0);
+	btf__add_field(btf, "u64_num", 5, 64, 0);
+	if (!ASSERT_OK(btf__load_into_kernel(btf), "btf__load_into_kernel"))
+		goto out;
+
+	opts.btf_fd = btf__fd(btf);
+	opts.btf_key_type_id = 1;
+	opts.btf_value_type_id = 6;
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "enums", sizeof(int),
+			    sizeof(struct enums), 1, &opts);
+	ASSERT_OK_FD(fd, "bpf_map_create");
+out:
+	btf__free(btf);
+	return fd;
+}
+
+static void test_enum(void)
+{
+	struct enums value = { 0xff, -1, (__u32)-22, (1ULL << 63) | 1 };
+	char output[1024] = {};
+	int map_fd, key = 0, ret;
+
+	map_fd = create_enum_map();
+	if (map_fd < 0)
+		return;
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &value, BPF_ANY),
+		       "update map"))
+		goto out;
+	if (!ASSERT_OK(bpf_obj_pin(map_fd, ENUM_PIN_PATH), "pin map"))
+		goto out;
+
+	ret = get_bpftool_command_output("-j map dump pinned " ENUM_PIN_PATH,
+					 output, sizeof(output));
+	ASSERT_OK(ret, "json dump");
+	ASSERT_HAS_SUBSTR(output,
+			  "{\"u8_name\":\"U8_MAX\",\"s8_name\":\"S8_NEG\","
+			  "\"u32_num\":4294967274,\"u64_num\":9223372036854775809}",
+			  "enum values");
+out:
+	unlink(ENUM_PIN_PATH);
+	close(map_fd);
+}
+
 void test_bpftool_map_dump(void)
 {
 	if (test__start_subtest("sk_storage"))
 		test_sk_storage();
 	if (test__start_subtest("queue"))
 		test_queue();
+	if (test__start_subtest("enum"))
+		test_enum();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index bfa74db17987..b5c90f729339 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -944,6 +944,9 @@ static void test_btf_dump_typedef_data(struct btf *btf, struct btf_dump *d,
 static void test_btf_dump_enum_data(struct btf *btf, struct btf_dump *d,
 				    char *str)
 {
+	__u32 high = 0x80000000;
+	__s32 neg = -1;
+
 	/* enum where enum value does (and does not) exist */
 	TEST_BTF_DUMP_DATA_C(btf, d, "enum", str, enum bpf_cmd, BTF_F_COMPACT,
 			     BPF_MAP_CREATE);
@@ -975,6 +978,23 @@ static void test_btf_dump_enum_data(struct btf *btf, struct btf_dump *d,
 
 	TEST_BTF_DUMP_DATA_OVER(btf, d, "enum", str, enum bpf_cmd,
 				sizeof(enum bpf_cmd) - 1, "", BPF_MAP_CREATE);
+
+	/* enumerators with bit 31 set in unsigned and in signed enum */
+	ASSERT_GT(btf__add_enum(btf, "test_enum_u32", 4), 0, "add unsigned enum");
+	ASSERT_OK(btf__add_enum_value(btf, "TEST_ENUM_HIGH", 0x80000000),
+		  "add TEST_ENUM_HIGH");
+	ASSERT_GT(btf__add_enum(btf, "test_enum_s32", 4), 0, "add signed enum");
+	ASSERT_OK(btf__add_enum_value(btf, "TEST_ENUM_NEG", -1), "add TEST_ENUM_NEG");
+
+	/* btf_dump__dump_type_data() doesn't resize 'd' for the new types */
+	d = btf_dump__new(btf, btf_dump_snprintf, str, NULL);
+	if (!ASSERT_OK_PTR(d, "btf_dump__new"))
+		return;
+	ASSERT_OK(btf_dump_data(btf, d, "test_enum_u32", NULL, 0, &high, 4, str,
+				"(enum test_enum_u32)TEST_ENUM_HIGH"), "dump unsigned enum");
+	ASSERT_OK(btf_dump_data(btf, d, "test_enum_s32", NULL, 0, &neg, 4, str,
+				"(enum test_enum_s32)TEST_ENUM_NEG"), "dump signed enum");
+	btf_dump__free(d);
 }
 
 static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
diff --git a/tools/testing/selftests/bpf/prog_tests/map_extra.c b/tools/testing/selftests/bpf/prog_tests/map_extra.c
new file mode 100644
index 000000000000..cbb1881ba693
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_extra.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "test_map_extra.skel.h"
+
+void test_map_extra(void)
+{
+	struct test_map_extra *skel;
+
+	if (!test__start_subtest("enum32_high"))
+		return;
+
+	skel = test_map_extra__open();
+	if (!ASSERT_OK_PTR(skel, "test_map_extra__open"))
+		return;
+
+	ASSERT_EQ(bpf_map__map_extra(skel->maps.arena), 0x80000000ULL,
+		  "map_extra");
+	test_map_extra__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_map_extra.c b/tools/testing/selftests/bpf/progs/test_map_extra.c
new file mode 100644
index 000000000000..b6aa2341c115
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_map_extra.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+	__ulong(map_extra, 0x80000000U);
+} arena SEC(".maps");
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.43.0

