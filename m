Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017258;
	b=HvNrjrNWG/lgZ1NRbXiIeQFzc5BoAjPsIxNzVRF/I8mzoKPfYCa8fcpFEnM/8ZT2pBRO
	 TCFiZwdyxnQ9+ram0xYUl8+rPv0qh6HDVXy52oUlx5Nu6SxERCaqHXOTPwMSw5ydmSMA6
	 AXIhlF9Swq/83ZRCHqKvAtImMHybf9FWgaVFIE+Z/QuiRKanIARU1MKSokXUulsfaOMnZ
	 RZxNV9BNI4lWrkeMo0TpHlhS3v45TFBTbrfDuUyl2amhGvL3e1EYXzAUFgX102z0ryeUN
	 wwjaPTpbBZpShGS/Q9K1jt2GW+9xfLPSK6g8xMKmbnXLGCwk7rpPdEGmxHvPK402aBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jgk8DixY24E26V4XJB1u3Oe+xB4rWD8lAtM07IEQQco=;
	b=KF8Y96ye83cAnEjzv3HVMGXiCzXyAIzwqet3haF7db9z4QxDuME0x5FV3j7J80xXS8hz
	 FOqO77D2Tl9wZ4r1yjPiByPlT62voiQmcij69/tFQrKEzlGMWcRwCQgv4TwKH27KPVCgr
	 DPSeP7mMpjJC9RzwifkiTA10A48KAcNyN3xOGCFIaesgsJlWKZFcMRgPOIa4vwQsCTLHU
	 1ZL1utQos9LuGIMx7cSrw4LmfwjOca67VTsCZgHygVuebOXCuQhXHjbhaTelq4Uq2FKl7
	 Lf2vr88jVovEcNTyb91ts7L0CWRlP6bodB5hs6jbi1Axe7b+FDJu21Kw0tdDod7BYUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iqIjkgrr;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8776606A33B
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 02:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8776606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iqIjkgrr
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36fe5944e9aso958518eec.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 18:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017257; x=1794622057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jgk8DixY24E26V4XJB1u3Oe+xB4rWD8lAtM07IEQQco=;
        b=iqIjkgrrIeWYnDYr6CJUEONr/hXa3PS/Mw0hCaaNnIWr87/JSAZx3db1FnB1TQ/2F5
         ExH3Rchs3aN3OYdQAkl2H7uHyw3/hOllezc+eGHnVnuUpA/9+HAP6oSbsy1HQrdqLvJi
         j9a2V2iW0n2ygHpRO/mbvySvssF3maTHFv+whBSPgsXrwamFb568fMBuhWRZC+M0z8vN
         2TrbG4HSmjAeWGWAeIP0baYf2ZtapC9XQHQNbQAfkq5DD8WfW9Qwi9+UWTpMRxW9sWxA
         mta6IYCx2w+S94kU0CHOEXyXXWovSEWEji8Bd0J2BRKapg2IAcqp5s3B/U6flLbTNwWI
         fkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017257; x=1794622057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jgk8DixY24E26V4XJB1u3Oe+xB4rWD8lAtM07IEQQco=;
        b=lgzw6FbmJUNySXFcSxrcnI8qmbEervgi8Zgg6qkE8UCohR+5+NtDZyRG9h91hkKDOm
         E6nJOz0xf1isdSNqKvVVnOGnOIdaEIaWIw0gMMfw4vc9GWWuXIA5RL/shGuZVNGAAo0O
         ZYnIHYy76cetiVPFlXNdnzdfJBcC95b4usxiQC5xa9jIgGIX8e+75aX79XuLEOLrLB8Q
         jMu0mXIrIIdqv9xIgipXcLfImTq+r7A6RbHotVXbDXlVoXkk33YCVMP0CQLWt+V3fGEF
         arTsmm9lyU3MRk6TpZkUOT+51FiYmWqAOl9GFihUvAcwk6o6AGRr0Pi9HLxgk6NFtoZo
         nydg==
X-Forwarded-Encrypted: i=1; AKwUvBxUCe8MkUCufYaoWFQEsLkceeANECo9gh44We4W/wPe69z1boGSSZFFEdtBjnR7sGNc5NU=@vger.kernel.org
X-Gm-Message-State: APuU4Z861sMx64zBpUR0JAjHE1adf6sXH3EEnSTe28paPQG3i5kdKpqd
	oo9CU2zJt/wAV6qEOvLtodwsNF7WVJjlWfgHGSqMpBcBIXQLa847DP0d
X-Gm-Gg: AYBFou32OZ6N103pNcgy54ofzPXwk0gzzOT6oYzTRWfpbLDAx98UQZKplSA4N1UjFxB
	l6aXYaZVGbl2oSykGUvrhNjJfJb4uHlQIcM5RyAf4dYXHZ4NfqZzh7AGKrQB7BXXVt5S9r09d63
	tgongvLiI8plnfTqwKEGK4Tg9YFckJZa7bbCQFmhckiJP6T9OsfClsbuTcEaojG69F3bGXQY8o4
	vPLPJj4GuQYChCU/mzMaJD7C4sZAY8y2DLpllJ+8nvzpfy2EC9DBm+Axzo4YW+Cm4VXJAjb3VkB
	84VC3y5qL7Dqp0FUOoMtsOiqABfXWHw7JeaTIi2rsv2x1U3xhwEIX9pFcTwVF3giNePSqxqn1a7
	flTuPcdtUgDuj+/ZEib7Ka/X356HZ3ng7R60PW4EytGrp/nqzy9f2F891hdbRKiUBWpiUWDtk1J
	ZlXxv1P8n5B01bemUJ5duFQe/KNf6IYT3HJmuEwWzVH0x0FwT1xy5hGmcULfPKYiMveUPPuF9fG
	kRsjsUFB4bq6hDdC3jvXtxxYc0fCKizsR8gETUGs7ViqEpqUe6EsOZWLfkPqYgH7LJh0GqAuUqn
	ePmu5/1cf+cTxUKo7dEWqmM81ARwmmKuPbnwDyLif1dFDywpWfISUDTdqwqelbYreS86ayqeffd
	BkBmx7ulLZGu3xEIFe+J16Qhq4c5tP3UkyzIUzw==
X-Received: by 2002:a05:7022:f107:b0:1a9:c9fe:12c7 with SMTP id a92af1059eb24-1b25d305915mr4978473c88.9.1794017256653;
        Fri, 06 Nov 2026 18:07:36 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e485ce2sm9338497c88.7.2026.11.06.18.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:07:36 -0800 (PST)
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
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Cover enum signedness in data dumps and map fields
Date: Sat,  7 Nov 2026 02:07:25 +0000
Message-ID: <20261107020725.36675-4-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107020725.36675-1-dennylin0707@gmail.com>
References: <20261107020725.36675-1-dennylin0707@gmail.com>
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

Exercise unsigned enum values with their high bit set and signed
controls through libbpf's data dumper. Include ordinary enums stored in
eight bytes and check that wider data cannot match an enumerator only
through its low 32 bits.

Extend bpftool_map_dump with BTF-backed array maps and check both JSON
and plain output. Cover narrow unsigned names, signed and unsigned
numeric output, wider ordinary enums and unmatched ENUM64 values.
Initialize map data at its actual width so the stored bytes match the
value width on big-endian hosts.

Also use an open-only arena skeleton to check an enum-backed map_extra
value with bit 31 set. The object is not loaded into the kernel, so the
test needs neither arena support nor mmap.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v4:
- Remove legacy-name and ambiguous narrow-alias cases, following the
  decision to rely on kflag.
- Add an open-only skeleton test for the map_extra parser.
- Remove four unrelated libbpf numeric-fallback cases.

 .../bpf/prog_tests/bpftool_map_dump.c         | 162 ++++++++++++++++++
 .../selftests/bpf/prog_tests/btf_dump.c       |  77 +++++++++
 .../selftests/bpf/prog_tests/map_extra.c      |  19 ++
 .../selftests/bpf/progs/test_map_extra.c      |  12 ++
 4 files changed, 270 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_extra.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_extra.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
index 187b3f784307..8002c24d02de 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
@@ -7,6 +7,7 @@
 
 #define PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_sk_storage"
 #define QUEUE_PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_queue"
+#define ENUM_PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_enum"
 #define JSON_ERROR	"{\"error\":\"can't dump sk_storage map"
 
 /* An empty socket storage map with an int value. */
@@ -124,10 +125,171 @@ static void test_queue(void)
 	close(map_fd);
 }
 
+enum enum_dump_kind {
+	DUMP_ENUM_UNSIGNED,
+	DUMP_ENUM_SIGNED,
+	DUMP_ENUM64_UNSIGNED,
+	DUMP_ENUM64_SIGNED,
+};
+
+struct enum_dump_test {
+	const char *name;
+	enum enum_dump_kind kind;
+	__u32 size;
+	__u64 value;
+	const char *expected;
+};
+
+static const struct enum_dump_test enum_dump_tests[] = {
+	{ "enum_u8_name", DUMP_ENUM_UNSIGNED, 1, 0xff, "\"MAX\"" },
+	{ "enum_u8_unknown", DUMP_ENUM_UNSIGNED, 1, (__u64)-22, "234" },
+	{ "enum_u16_name", DUMP_ENUM_UNSIGNED, 2, 0xffff, "\"MAX\"" },
+	{ "enum_u16_unknown", DUMP_ENUM_UNSIGNED, 2, (__u64)-22, "65514" },
+	{ "enum_u32_high", DUMP_ENUM_UNSIGNED, 4, 0x80000000, "\"HIGH\"" },
+	{ "enum_u32_max", DUMP_ENUM_UNSIGNED, 4, 0xffffffff, "\"MAX\"" },
+	{ "enum_u32_unknown", DUMP_ENUM_UNSIGNED, 4, (__u64)-22, "4294967274" },
+	{ "enum_s8_name", DUMP_ENUM_SIGNED, 1, (__u64)-1, "\"NEG\"" },
+	{ "enum_s8_unknown", DUMP_ENUM_SIGNED, 1, (__u64)-22, "-22" },
+	{ "enum_s16_name", DUMP_ENUM_SIGNED, 2, (__u64)-1, "\"NEG\"" },
+	{ "enum_s32_name", DUMP_ENUM_SIGNED, 4, (__u64)-1, "\"NEG\"" },
+	{ "enum_s32_unknown", DUMP_ENUM_SIGNED, 4, (__u64)-22, "-22" },
+	{ "enum_wide_name", DUMP_ENUM_UNSIGNED, 8, 0xffffffff, "\"MAX\"" },
+	{ "enum_wide_unknown", DUMP_ENUM_UNSIGNED, 8, 0x1ffffffffULL, "8589934591" },
+	{ "enum64_unsigned", DUMP_ENUM64_UNSIGNED, 8, (1ULL << 63) | 1,
+	  "9223372036854775809" },
+	{ "enum64_signed", DUMP_ENUM64_SIGNED, 8, (__u64)-22, "-22" },
+};
+
+static int add_enum_dump_values(struct btf *btf, const struct enum_dump_test *test)
+{
+	__u64 max = test->size == 1 ? 0xff : test->size == 2 ? 0xffff : 0xffffffff;
+	int err;
+
+	switch (test->kind) {
+	case DUMP_ENUM_UNSIGNED:
+		err = btf__add_enum_value(btf, "HIGH", (max >> 1) + 1);
+		return err ?: btf__add_enum_value(btf, "MAX", max);
+	case DUMP_ENUM_SIGNED:
+		return btf__add_enum_value(btf, "NEG", -1);
+	case DUMP_ENUM64_UNSIGNED:
+		err = btf__add_enum64_value(btf, "HIGH", 1ULL << 63);
+		return err ?: btf__add_enum64_value(btf, "LOW", 1);
+	case DUMP_ENUM64_SIGNED:
+		return btf__add_enum64_value(btf, "NEG", (__u64)-1);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int create_enum_dump_map(const struct enum_dump_test *test)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	bool enum64 = test->kind == DUMP_ENUM64_UNSIGNED ||
+		      test->kind == DUMP_ENUM64_SIGNED;
+	struct btf *btf;
+	int key_id, value_id, fd = -1;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf__new_empty"))
+		return -1;
+
+	key_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	if (!ASSERT_GT(key_id, 0, "btf__add_int"))
+		goto out;
+	if (enum64)
+		value_id = btf__add_enum64(btf, "enum_value", test->size,
+					   test->kind == DUMP_ENUM64_SIGNED);
+	else
+		value_id = btf__add_enum(btf, "enum_value", test->size);
+	if (!ASSERT_GT(value_id, 0, "add enum"))
+		goto out;
+	if (!ASSERT_OK(add_enum_dump_values(btf, test), "add enum values"))
+		goto out;
+	if (!ASSERT_OK(btf__load_into_kernel(btf), "btf__load_into_kernel"))
+		goto out;
+
+	opts.btf_fd = btf__fd(btf);
+	opts.btf_key_type_id = key_id;
+	opts.btf_value_type_id = value_id;
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "enum_dump", sizeof(__u32),
+			    test->size, 1, &opts);
+	ASSERT_OK_FD(fd, "bpf_map_create");
+out:
+	btf__free(btf);
+	return fd;
+}
+
+static void test_enum_dump(const struct enum_dump_test *test)
+{
+	union {
+		__u8 val8;
+		__u16 val16;
+		__u32 val32;
+		__u64 val64;
+	} value;
+	char output[1024] = {}, expected[128];
+	__u32 key = 0;
+	int map_fd, ret;
+
+	/* Store the value at its native width, including on big-endian hosts. */
+	switch (test->size) {
+	case 1:
+		value.val8 = (__u8)test->value;
+		break;
+	case 2:
+		value.val16 = (__u16)test->value;
+		break;
+	case 4:
+		value.val32 = (__u32)test->value;
+		break;
+	case 8:
+		value.val64 = test->value;
+		break;
+	default:
+		PRINT_FAIL("unexpected enum size %u (expected 1, 2, 4 or 8)\n", test->size);
+		return;
+	}
+
+	map_fd = create_enum_dump_map(test);
+	if (map_fd < 0)
+		return;
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &value, BPF_ANY),
+		       "update enum value"))
+		goto out;
+	if (!ASSERT_OK(bpf_obj_pin(map_fd, ENUM_PIN_PATH), "pin enum map"))
+		goto out;
+
+	ret = get_bpftool_command_output("-j map dump pinned " ENUM_PIN_PATH,
+					 output, sizeof(output));
+	if (!ASSERT_OK(ret, "json enum dump"))
+		goto out;
+	snprintf(expected, sizeof(expected), "\"formatted\":{\"key\":0,\"value\":%s}",
+		 test->expected);
+	ASSERT_HAS_SUBSTR(output, expected, "json enum value");
+
+	memset(output, 0, sizeof(output));
+	ret = get_bpftool_command_output("map dump pinned " ENUM_PIN_PATH,
+					 output, sizeof(output));
+	if (!ASSERT_OK(ret, "plain enum dump"))
+		goto out;
+	snprintf(expected, sizeof(expected), "\"value\": %s\n", test->expected);
+	ASSERT_HAS_SUBSTR(output, expected, "plain enum value");
+out:
+	unlink(ENUM_PIN_PATH);
+	close(map_fd);
+}
+
 void test_bpftool_map_dump(void)
 {
+	size_t i;
+
 	if (test__start_subtest("sk_storage"))
 		test_sk_storage();
 	if (test__start_subtest("queue"))
 		test_queue();
+
+	for (i = 0; i < ARRAY_SIZE(enum_dump_tests); i++) {
+		if (test__start_subtest(enum_dump_tests[i].name))
+			test_enum_dump(&enum_dump_tests[i]);
+	}
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index bfa74db17987..b2af060fe5b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -977,6 +977,80 @@ static void test_btf_dump_enum_data(struct btf *btf, struct btf_dump *d,
 				sizeof(enum bpf_cmd) - 1, "", BPF_MAP_CREATE);
 }
 
+static void test_btf_dump_enum_values(void)
+{
+	LIBBPF_OPTS(btf_dump_type_data_opts, opts,
+		    .compact = true,
+		    .skip_names = true);
+	struct {
+		const char *name;
+		__u32 size;
+		__s64 enum_value;
+		union {
+			__u8 u8;
+			__u16 u16;
+			__u32 u32;
+			__u64 u64;
+		} data;
+		const char *expected;
+	} cases[] = {
+		{ "unsigned_byte", 1, 0xff, { .u8 = 0xff }, "VALUE" },
+		{ "unsigned_short", 2, 0xffff, { .u16 = 0xffff }, "VALUE" },
+		{ "unsigned_high", 4, 0x80000000LL,
+		  { .u32 = 0x80000000U }, "VALUE" },
+		{ "unsigned_max", 4, 0xffffffffLL,
+		  { .u32 = 0xffffffffU }, "VALUE" },
+		{ "signed_value", 4, -1, { .u32 = (__u32)-1 }, "VALUE" },
+		{ "unsigned_wide", 8, 0xffffffffLL,
+		  { .u64 = 0xffffffffULL }, "VALUE" },
+		/*
+		 * Wider data must not match an enumerator through its low 32 bits.
+		 * Check numeric output without requiring an exact value.
+		 */
+		{ "wide_unknown", 8, 0xffffffffLL,
+		  { .u64 = 0x1ffffffffULL }, NULL },
+	};
+	struct btf_dump *d;
+	struct btf *btf;
+	int ids[ARRAY_SIZE(cases)];
+	char str[STRSIZE];
+	int err, i;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "new_empty"))
+		return;
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		ids[i] = btf__add_enum(btf, cases[i].name, cases[i].size);
+		if (!ASSERT_GT(ids[i], 0, "add_enum"))
+			goto free_btf;
+		err = btf__add_enum_value(btf, "VALUE", cases[i].enum_value);
+		if (!ASSERT_OK(err, "add_enum_value"))
+			goto free_btf;
+	}
+
+	d = btf_dump__new(btf, btf_dump_snprintf, str, NULL);
+	if (!ASSERT_OK_PTR(d, "btf_dump__new"))
+		goto free_btf;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		str[0] = '\0';
+		err = btf_dump__dump_type_data(d, ids[i], &cases[i].data,
+					       cases[i].size, &opts);
+		ASSERT_EQ(err, cases[i].size, cases[i].name);
+		if (cases[i].expected) {
+			ASSERT_STREQ(str, cases[i].expected, cases[i].name);
+		} else {
+			ASSERT_NEQ(str[0], '\0', cases[i].name);
+			ASSERT_EQ(strspn(str, "0123456789"), strlen(str),
+				  cases[i].name);
+		}
+	}
+
+	btf_dump__free(d);
+free_btf:
+	btf__free(btf);
+}
+
 static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
 				      char *str)
 {
@@ -1421,6 +1495,9 @@ void test_btf_dump() {
 	if (test__start_subtest("btf_dump: type_tags"))
 		test_btf_dump_type_tags();
 
+	if (test__start_subtest("btf_dump: enum_values"))
+		test_btf_dump_enum_values();
+
 	btf = libbpf_find_kernel_btf();
 	if (!ASSERT_OK_PTR(btf, "no kernel BTF found"))
 		return;
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

