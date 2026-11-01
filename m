Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793529164;
	b=0+BZEeofMOMKyhJK6rOD1G2CptS89ES0xaRe1ubWMbTlSTCtfW86R1EBFAdiUb4M4I6b
	 BzrtFldjcsOMheVvUJneuJOBLGcekpFxI/q5lWMdGxOsWQasAn4Xup1YSWi/vJTQGT3/0
	 u/QrgB02kZ5KTJBlEzSP03y+8hlwf2y7pOmNy4zd3MJyry/nq1sOcqwcTeNAKWZdI0oDq
	 6WXvC5lsyFAgfxdiKPnaPtyA/dZmHkwrGty917LrCYZrL6xni3E+rZ2HZJ5Xa5zkPzb6d
	 0o5rLDQPnGzkqWplwbttv6AUswicOFp/CChfRPgp4iq8e2+8a5mDOIIWfTRehMdyS/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793529164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1Byq8YmfqbLYhiz3dowQaOFAPPG/U2tTfcDuN6usBwY=;
	b=TQXA2ZGBG7jMIksg+4lJTxdY48l3ui19ey2ptvKgRAmRvLFLnVDR6imMVlPfSHmn4A3+
	 RlguoIuqBZanTZZMRRc9oykDUPJpULdz6RhIUi/GoHO8nK1zmDHt/ox1rO4J8+3Gtnl3m
	 eVsp8+KWxQRJu9MRpCpdgVteB28JUVz1RKxMJz4eW9KyNO0552SeWH6rI3fdEHYIZwXrw
	 294i+5sE3EvL3XzziJmR22Zl+0tgaxBv0KStW3qUziTPIxJCVY9OUIEvO6aRvCnI6Qvep
	 a/OhcLDr5bQTVlBum8MUcswo97Wkvb3gvmVy4cgrAybNrxtsFq+taxx1WGbrJcOXSwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J4tmbOHG;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B586606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 10:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B586606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J4tmbOHG
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso2149532eec.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 02:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793529163; x=1794133963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Byq8YmfqbLYhiz3dowQaOFAPPG/U2tTfcDuN6usBwY=;
        b=J4tmbOHGPdcEYe45Ies2VNmguxWKIE7Sld3dIcyLuhvVh/VZRdGpgfRFidlBfItYTz
         PtnWs6Fg5aWY8dExM48k4O3/mFBNMzWd4OeSdw57gVKoEjlxic36EwqOJIyjSTHn/1vs
         psF+c4P5/rwvAvoNQLa/PL368toMo0r41yT62zRW5Rya32Yh05k/ZmtqIz5InaByoyaI
         7jD6ZSWwc6EQwr0iTmm/ElDKM5tEGtSiSlthhBaazDeSMRF2KMovgs5Ty57bvn0CkePb
         MDTGhQLRMqce0Lv61mmApj7l3e92vScMCMRt19ucN4qHwW4DO9kcYZlZHtPBXsu5+v6a
         CylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793529163; x=1794133963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Byq8YmfqbLYhiz3dowQaOFAPPG/U2tTfcDuN6usBwY=;
        b=dMHvUjQp25hNzaqm8K1CWfENw1V/naOh9H30ftP5cYtFxOyQnQWZ/UBR232+shF1ZZ
         Gio3ZqTH19ZkJXY50PFeMdjB2oJ2u/O2xxLhm+fTQNyfUYAxNmpOhvO5ryuQjqaGI2mA
         V85cDYYu0ARJxRqQPQFKFLJFGwnVnAP0Z254DrIAIC/hm0nxGzR61nNqSrTzVHDqjQrU
         xR4Mz4Xz8QqgkLRgriIBqz2ssd/eGkZtDebj4GtOabt5s11EnmD5ZU1bqAnIPAba6JUT
         YuUPb+ELLgLIYizGOP7iPdsXWt+hX5KvIJd7014Y/RqV9eiBN+P+jyWs/HeQDDn29Gft
         7SWg==
X-Forwarded-Encrypted: i=1; AKwUvBygMGcHRGovQWeLRb1Mtbff4igFWY7JNiRbhOGcuqMyfIVMB/uPCQZq9ey8yJWkd1geCTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8r1BnKDUyt/A0oJw1ZrHxDhB9LI6w+5dOFQ6P6pSB/xND9Txfl
	j8a2eG9yOyiUmW31IdYsNj6LlLWIovKjWL3U/JZ/Cxwo7SkeWjDKFmG+
X-Gm-Gg: AYBFou1vGY4qloATTw3SWm8NER78L4mdTLlb0GfDTf9sn3E+Bzt9jITiE0w1RPH9Z+X
	ig5Bok2c60mt1CIMYAxSoqQSFobKd9R0L+jhxW2UyHjrHd2oy8WrAs64eXsoH8htiDAl1MvcyaT
	WmVjdMmPMZe/k0TB+41lCnFHwME17n4KqQyrwnzz9WO6AYX8bw18jqy/aDvWDw+g1hL+GeylNLZ
	YGTNObhKOOU9PX/S/+du8e8q/Q4pPaqmJAikh/KiFqZeDRqcHHQm5wIk7h26NtcBfN9OIzLS912
	Yg+olGycyZZrY5uhnajnM8pFsUYADH8MYU5UK/NS/7Flb5v+JtMYf269MbaZk+Pue1W1qjqB9sb
	lBHL4kb4Oib2n5eTxMOgr3nOQio6zQ4tF4Wlen0miTBSipJ00OHPNg43giq50wIH54Vhh9jhI5w
	nK24csEehrHtOqo9iO9ymOLWHewDbnQPGh28QEM545s0hwXv8WJ5wt72JNytfw0chSDd6k1E1Z4
	EjV4Ho+9W7QengS2RfQZz+6+EULNdYPGOOPjCgwa8Zw/I0WHRIIWKw9LVPtj/+JAOIpvD8noY9j
	pUAmQ1R25iT4K7gH8V1h0dKG09N/XCc8fAqxFDTNOHn8mhc2NwcHP+Nz
X-Received: by 2002:a05:7301:4246:b0:368:7c2d:a612 with SMTP id 5a478bee46e88-36a42345878mr10743000eec.10.1793529162515;
        Sun, 01 Nov 2026 02:32:42 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm25242506eec.6.2026.11.01.02.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:32:41 -0800 (PST)
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
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Cover enum signedness and legacy name matching
Date: Sun,  1 Nov 2026 10:32:21 +0000
Message-ID: <20261101103221.51534-4-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101103221.51534-1-dennylin0707@gmail.com>
References: <20261101103221.51534-1-dennylin0707@gmail.com>
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
eight bytes and legacy BTF with kflag clear so normalization does not
lose existing names or match only the low 32 bits of wider data.

Extend bpftool_map_dump with BTF-backed array maps and check both JSON
and plain output. Cover narrow unsigned names, signed and unsigned
numeric fallbacks, legacy enum names, both enumerator orders for
ambiguous narrow names, and unmatched ENUM64 values.

Build legacy enum records through the public BTF API and load them into
the kernel before invoking bpftool. Initialize map data at its actual
width so the tests also work on big-endian hosts.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 .../bpf/prog_tests/bpftool_map_dump.c         | 180 ++++++++++++++++++
 .../selftests/bpf/prog_tests/btf_dump.c       |  84 ++++++++
 2 files changed, 264 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
index 187b3f784307..926d0f324a5f 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
@@ -7,6 +7,7 @@
 
 #define PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_sk_storage"
 #define QUEUE_PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_queue"
+#define ENUM_PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_enum"
 #define JSON_ERROR	"{\"error\":\"can't dump sk_storage map"
 
 /* An empty socket storage map with an int value. */
@@ -124,10 +125,189 @@ static void test_queue(void)
 	close(map_fd);
 }
 
+enum enum_dump_kind {
+	DUMP_ENUM_UNSIGNED,
+	DUMP_ENUM_SIGNED,
+	DUMP_ENUM_LEGACY,
+	DUMP_ENUM_ALIAS_FIRST,
+	DUMP_ENUM_ALIAS_LAST,
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
+	{ "enum_legacy8", DUMP_ENUM_LEGACY, 1, (__u64)-1, "\"NEG\"" },
+	{ "enum_legacy16", DUMP_ENUM_LEGACY, 2, (__u64)-1, "\"NEG\"" },
+	{ "enum_legacy32", DUMP_ENUM_LEGACY, 4, (__u64)-1, "\"NEG\"" },
+	{ "enum_legacy_wide", DUMP_ENUM_LEGACY, 8, (__u64)-1, "\"NEG\"" },
+	{ "enum_alias_first", DUMP_ENUM_ALIAS_FIRST, 1, 0xff, "\"NEG\"" },
+	{ "enum_alias_last", DUMP_ENUM_ALIAS_LAST, 1, 0xff, "\"NEG\"" },
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
+	case DUMP_ENUM_LEGACY:
+		/* Model old BTF: raw signed -1, but no signedness kflag. */
+		return btf__add_enum_value(btf, "NEG", (__u32)-1);
+	case DUMP_ENUM_ALIAS_FIRST:
+		err = btf__add_enum_value(btf, "U255", 0xff);
+		return err ?: btf__add_enum_value(btf, "NEG", (__u32)-1);
+	case DUMP_ENUM_ALIAS_LAST:
+		err = btf__add_enum_value(btf, "NEG", (__u32)-1);
+		return err ?: btf__add_enum_value(btf, "U255", 0xff);
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
index dbef014f75ac..20a169095e9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -952,6 +952,87 @@ static void test_btf_dump_enum_data(struct btf *btf, struct btf_dump *d,
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
+		{ "signed_unknown", 4, -1, { .u32 = (__u32)-22 }, "-22" },
+		/* Old BTF stores negative enum values without setting kflag. */
+		{ "legacy_wide", 8, (__u32)-1, { .u64 = (__u64)-1 }, "VALUE" },
+		{ "unsigned_wide", 8, 0xffffffffLL,
+		  { .u64 = 0xffffffffULL }, "VALUE" },
+		/*
+		 * An unrelated 64-bit value must not match an ENUM32 by its
+		 * low 32 bits. Do not constrain the numeric fallback's width.
+		 */
+		{ "wide_unknown", 8, (__u32)-1,
+		  { .u64 = 0x1ffffffffULL }, NULL },
+		{ "unknown_byte", 1, (__u32)-1, { .u8 = (__u8)-22 }, "234" },
+		{ "unknown_short", 2, (__u32)-1, { .u16 = (__u16)-22 }, "65514" },
+		{ "unknown_word", 4, (__u32)-1,
+		  { .u32 = (__u32)-22 }, "4294967274" },
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
@@ -1396,6 +1477,9 @@ void test_btf_dump() {
 	if (test__start_subtest("btf_dump: type_tags"))
 		test_btf_dump_type_tags();
 
+	if (test__start_subtest("btf_dump: enum_values"))
+		test_btf_dump_enum_values();
+
 	btf = libbpf_find_kernel_btf();
 	if (!ASSERT_OK_PTR(btf, "no kernel BTF found"))
 		return;
-- 
2.43.0

