Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794023183;
	b=YPgApwqck5iLD3LCY4WGpSq3fuchZV+dS8DvXghJR7D+LnxAdXeY/1o48WF0NElAlJXC
	 wK2235TDets4sAB3NOB9uaIN8WVDZdxYJAy+moByF7ZnT/I5WU0ddTjyPxL3wEANtWdgb
	 y+Ka/WipzIoUp2oWeomT/JoqmhYLjouleTDRRHlAQL1WEC5QhiISSVXW7WmoEc4Q/gAVl
	 9ZCY+YCPWWpi4tzi5LFtVh2KN1T59aVbY+pAqNJyzGR/KyAl9YMZbH+cYapcerxV9zZEG
	 4zxEpkAOjyPI7RmKH7YtO8urcd6/amYQICt+iyboKMkoT8nfL3vyfMI9u2w+afE3z0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794023183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=fqz4qN+BLKAsTg3hFdIueZvqPQrOf/Q5VzzyopjCcFA=;
	b=LEB9ACEtdPjHGeKsPXcJxc0BwENJuqsunc1kldbnNaDWv2Lfh6qN6758YQRJdcEX4Ai/
	 yfLL+VOiAtrMfAMOiQ+QdYL6xB1/qTwfH1bIeFq8dVcQ/ZhumJBQ3p2NsVWOfRqrx/uDS
	 Dh4n0TRn6O7Onqeh78MQAbBXvHSaAY2y0peaSBMAxi6gnFSXSw/uLA5r5TVIlYd+zygKA
	 UWFbtJO+esWAWL3M1vG1iELz2a2NRwJXvIIoJyERLB0lLlFLwdfyybCYS1fth6wo9s0or
	 3qmqGiDvPPGWzWhQ/T2GNQSxWhX4Zax8NEIaI7uGRKIZ9DASK2U5x2vpL5dM+F3xigQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wvWndcBQ;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE662606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE662606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wvWndcBQ
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1089787a91.3
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794023182; x=1794627982; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fqz4qN+BLKAsTg3hFdIueZvqPQrOf/Q5VzzyopjCcFA=;
        b=wvWndcBQ1TgGm4c5X7adPMbmtQszekxX63DaFxEE9f5Frdl/3y2XSIYQneLBLOd3pL
         T81jpOtY7fwKh76/x1jvnFwDTBMiWkK5v3XO3vepfvoOvHcoh96lyc7Z5nMRwfb/bgR1
         oYffdyzikpN1U7+kcfxuWAYJztMekLz4NbRSNZM8Kt7gxoSLJGgbMT0VAzccqMSB0OKy
         AXMewEeWfPgmANG1pYUlTMZzrJpGqRnTJS7HI5nMZebnkv7TytgnsCOq9MmBEPfrr/Vm
         eLH34heLkA2B9I0kA0WypRpxi1sYnpMEK8F5a/JLNeYgXvc4RKLQnwMgAhFUjPXhjh3r
         o2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794023182; x=1794627982;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqz4qN+BLKAsTg3hFdIueZvqPQrOf/Q5VzzyopjCcFA=;
        b=QKacdurFuEAYQYyRQRnQrML7WXWWAq4UCnBNi0Iw9jWbVb89EvuNTU4D1DYGU1p491
         ewY0Y/MBAe0harutfJRs1LJRCt0hNPS22GgwfM0+L64LuLiIEFC/0u2cvE6U2U+OwReY
         nCwLDcYzanaxpmHClXWbs1Od8Hcc5Cdo9ZuhY8pzJIkZC90pXT22ET9pXHXl9B59xoqZ
         HhvptiqgYInKM8ecPrhalNbhkkPAarlpTQs489VGXHBcpD7XkMtccOHhyFopJXKlGE7r
         ACGJxqWwHg+DqYylV5ZL6yYV/MK+vOBujjnSjbuTIUd2rFSKquBMGXAEd8Lr5h0y0jRm
         vSaA==
X-Forwarded-Encrypted: i=1; AL+hErGpmCb9Jyfq3H7ImnbZyE8OeH7hvWjIlCvxi8EJZYFnZbmudxUB/BOgmr58URVt37rV1kw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gCL4BXNmUX7bcg3ajrsRZkmJxRcdyTZZgPD+f3mxkdy/1tbgV
	TvCiCr6MyUUWJOB3Pp+EMoww9keu3CSR+2SwZ0fLjEuWD09L75JOrX3v
X-Gm-Gg: AYBFou30zPMlEfi76USCTd8Sz9cXCBcDh7q5jBXjQnyopuqpHMS4/MWVTwEqazpX1Rp
	yM1jwS993M3GHEKEuYo3T0FEP0q9o8cbRynWQMpJrBJRsHGfz6RJGS1TmtjnHYVldIw9UUU7Ln2
	zhIEFUR6gT7Q6FYJAWtK9Ri5aYSAvCo5+8rciMhhO6SIZp8bZW3G4LCJ/6pHcwFTQ6ce5ZKhdP4
	jZH5AJW89V0fO5Ydj2PcQgScDchLLKVFUkOOpWc9dQWacgX24A6bQb6u9xf8scE5zx/Ll6fmvBD
	eHx0iSqN5JmC8F0xGeHe/qp04YzdvLPFxuLK04spwDbLfWYX3UsCt2IQsOA023VZQqJ2Hy5tJuu
	LiB39JhDYOYvALpZWGr7+ImDGdrsvOsSqPqCFl81V9hzsCFc0aoJHPVtlBdKdpGMknNG2YSjddY
	ZYPPiGO6VSfnpn6oJLTJcck7iS+QmeRF2pyvfXDDwBefiF2or8UiPULMWMBE3ZJGYlt1OjOgWr6
	gy6VpDAsVQErm8/rkJEVe3m0eEwZgwDTrLTQyLwVc/ZVnXsi08Pte3hHlJLaUMRM2rZh4ZKzbSw
	xc3nD6Ig9WQ7Ct2AHSb03+Y5O4dQcroBIo+ArO6qNI9lR/j0Fq3DpqD6oWdQA6xjIjdnbnOeh0l
	14NHUQXEECeR7E2G4MMCVpueafLDKFzYlVg==
X-Received: by 2002:a17:90a:da8e:b0:3b0:94e6:4364 with SMTP id 98e67ed59e1d1-3b0db70b25bmr4358253a91.64.1794023182095;
        Fri, 06 Nov 2026 19:46:22 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70ab7620sm1090942a12.29.2026.11.06.19.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 19:46:21 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 03:46:21 +0000
Message-Id: <DMOO53QTDUQ4.2Z9UXMZEPX568@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hungyu Lin" <dennylin0707@gmail.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <qmo@kernel.org>, <daniel@iogearbox.net>,
 <yonghong.song@linux.dev>, <eddyz87@gmail.com>, <ihor.solodrai@linux.dev>,
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 0/3] Normalize enum values in libbpf and
 bpftool
In-Reply-To: <20261107020725.36675-1-dennylin0707@gmail.com>
References: <20261107020725.36675-1-dennylin0707@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 06, 2026 at 06:07 PM Hungyu Lin <dennylin0707@gmail.com> wrote:
>  .../bpf/prog_tests/bpftool_map_dump.c         | 162 ++++++++++++++++++
>  .../selftests/bpf/prog_tests/btf_dump.c       |  77 +++++++++
>  .../selftests/bpf/prog_tests/map_extra.c      |  19 ++
>  .../selftests/bpf/progs/test_map_extra.c      |  12 ++
>  8 files changed, 293 insertions(+), 10 deletions(-)

selftest are growing too fast.

16 subtests create 16 maps and run bpftool 32 times.
9 of the 16 pass without the fix.
Plain and json output come from the same btf_dumper_enum().
One map with a struct of four enums and one run of bpftool are enough.

The btf_dump.c part below is the test from my reply to the libbpf patch.

Keep patches 1 and 2. Keep the map_extra test.

Instead of the other two files of patch 3 (not even compile tested):

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
index 187b3f7..1c581db 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
@@ -7,6 +7,7 @@

 #define PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_sk_storage"
 #define QUEUE_PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_queue"
+#define ENUM_PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_enum"
 #define JSON_ERROR	"{\"error\":\"can't dump sk_storage map"

 /* An empty socket storage map with an int value. */
@@ -124,10 +125,85 @@ out:
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
+	btf__add_struct(btf, "enums", sizeof(struct enums));	/* [6] */
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
index bfa74db..f126fe3 100644
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
@@ -975,6 +978,22 @@ static void test_btf_dump_enum_data(struct btf *btf, struct btf_dump *d,

 	TEST_BTF_DUMP_DATA_OVER(btf, d, "enum", str, enum bpf_cmd,
 				sizeof(enum bpf_cmd) - 1, "", BPF_MAP_CREATE);
+
+	/* enumerators with bit 31 set in unsigned and in signed enum */
+	ASSERT_GT(btf__add_enum(btf, "test_enum_u32", 4), 0, "add unsigned enum");
+	ASSERT_OK(btf__add_enum_value(btf, "TEST_ENUM_HIGH", 0x80000000), "add TEST_ENUM_HIGH");
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

pw-bot: cr
