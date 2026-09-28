Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB12FFDFC
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790554550; cv=none; b=P3gi5dFwxrtmUQM+9bjIIpLcm+554qUb1D9/HdIBjAL47gk+LKswNU8goxvCWmNcRSClwMyC3PoI56rS7t+fOsnyHexk+q/OuXbjvON/CXWz5ldC7q/GHukUKufIvf2hEWGdR8mSHkDL7EXzzQi90JjlWs3DjFb52CbHG7w0C5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790554550; c=relaxed/simple;
	bh=RUB8RCJZi4+RIvvzdlJKvb07glNORaBdfkx4SwrdYWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4uI4Z/7KWDJU8Ka0Wazls2oMRHvpt9+ZhqVF0hrrXnIZI67hMNJ3Gr/77gvOtf+3PD0yaH0F9q2a5CT2LTA+2lGk+J0hoAKv8FTrmn3EMrBT99YBzxHd+HWTi0z3L0JKluSfi6Yus3TPcSVxtygKpHeWMBPXyb3h+MS/H9WaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy7yt24v; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy7yt24v"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7dc4so2884003a12.3
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 17:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790554542; x=1791159342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZMySgRNvVIU+FJ9l96Xdac3PNNn0DHXgu2rt2rVOIU=;
        b=Uy7yt24vq58ZsbpjZ+hIZYiYwIY3cxvCpWExs5sNlFAXzg0js7UOtdXbohfqgxOrYj
         t3CFJYEWLgwxzAKGsH9eRSedTdPFCdBxyTJ+nC4d22IsETxHJcdn/i0UJXjiPfkIkV2i
         XZHMYTnHQhRu+aPzcV1F8gpleYx/CYSdmq0YkEU3u7zkur+rT5105SX8wfyB91VYSAv7
         oYXKLixz7EJkd/U1wDc7BEGU3Pw7RS+/yi4xTVsCQhifajHHwYw87ehOIAdcrno9Jiv0
         6ffij1h8u6fxE5iFZzneDuW8OJSQ2MKtQqFtQK5wkDj5YfMrJ/DrFKtD5FU9btHc9rPD
         CAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790554542; x=1791159342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bZMySgRNvVIU+FJ9l96Xdac3PNNn0DHXgu2rt2rVOIU=;
        b=U8gqG2pQ3QmJXtOaPyOMyarT1RKUBVfr8dXtQxdY/wea6Lz3UnmspBzcM1aeqio19X
         qu8L+qLDmSMqaeoSx41RXRdMbvxLeiTfV+Yg7ATEfHyESye9BP1TIgY+T2ugdj9I9A0C
         UGFpEPXx9faM/ixMtitAn4zqt4aus2dT7+NdMgW45oL2YQlPhNhCX2Q5p8zR5kn0b/Y1
         BzuRXr4t3cbPH7MIDmyWzA6O7wDqdB4f835B8r8hiyhcS5YGAkfv9KGpYxkHc/DunmN/
         Za3db0GUbMgPI4bKAgE8mw5A95KEQiSN/8NxtVeUz5R81wqi5fFwqWQ0mPQO6Kl+4zSD
         dyNw==
X-Gm-Message-State: AFq9FYKENu6gBjNvLc6abL/9cPECv23AxngvV9YwDSQROvzcR6/0LABf
	GupyKNwGOEkn2VhEOY3Amr1MR7exVP75RvhuqUztV8z+4G6Lw3X8Zf0xITs3D0B25zk=
X-Gm-Gg: AYBFou0FW2kSZMxp1Ocy3t0Luzq8tNv8c4lxR1WFZRR0w+1KGzM10brPomptrYLcqgF
	wTww+d1EjBMrvQ8y7p4MofORt85FDjgum11ijpvrDNd/N6lzUyylwQpi3PNniKVYhsQJebv5Zkv
	pfuHONPMsgRxlCSckxnEouoyvkQjtJ3a2j35Udy+W+jUj8brTAmo9r/nj9138BY9QR+/3bRQ3uv
	i0RMEIADQHLxwTogXt473v7sfWbeOx6fTvpNZw7Iw0p+JAdi+Y0Gp5bSHRi7fwRdd9o1FX2kegn
	Af/zJkmyXdA/NeR+S2W8VkP7FiK7ZN+2E/y7StL4RWUgtxy7uVmrS5M21JdEz7Md9ZoeUZETFiY
	mgpWJPBpom2VUw072wMSf92hIz5BWlfU2ZSeIQ8Jak1vmmTbZP45R3x+02loQXvNRKZCqC8SzWw
	P+q0L7UoXZ05zT+HE/m3mgbnMvZjdDbhtpfGn57egK+5/cXx82flXzF/jVnrQrGrSeSQt8rNTQ6
	v30fSFujjFfSe8=
X-Received: by 2002:a05:6402:1d4d:b0:6aa:734b:1a33 with SMTP id 4fb4d7f45d1cf-6aac90a25d0mr9564123a12.45.1790554541943;
        Sun, 27 Sep 2026 17:15:41 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ab5be57b13sm1933955a12.33.2026.09.27.17.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 17:15:40 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kuba@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Test bpftool map dump on maps that can't be iterated
Date: Mon, 28 Sep 2026 03:15:08 +0300
Message-ID: <20260928001513.7072-3-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928001513.7072-1-skokovmaksimevg@gmail.com>
References: <20260928001513.7072-1-skokovmaksimevg@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Socket storage can't be iterated from user space. Create a
BPF_MAP_TYPE_SK_STORAGE map, attach storage to a socket, pin it, and
check that "bpftool map dump" fails with nothing but an error: a JSON
error object with -j, no elements on stdout in plain mode, and the
reason on stderr.

Socket storage always has BTF, so its plain dump goes through the BTF
writer and never prints an element count. Check that path with a queue
map created without BTF that holds one element: its plain dump must
fail without a "Found" line, which bpftool printed as "Found 0
elements" before, and give the reason on stderr.

Assisted-by: LLM
Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
---
 .../bpf/prog_tests/bpftool_map_dump.c         | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
new file mode 100644
index 0000000000000..e39a978e6cbd8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/socket.h>
+#include <unistd.h>
+#include <bpf/btf.h>
+#include <test_progs.h>
+#include "bpftool_helpers.h"
+
+#define PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_sk_storage"
+#define QUEUE_PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_queue"
+#define JSON_ERROR	"{\"error\":\"can't dump sk_storage map"
+
+/* An empty socket storage map with an int value. */
+static int create_sk_storage_map(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_flags = BPF_F_NO_PREALLOC);
+	struct btf *btf;
+	int int_id, fd = -1;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf__new_empty"))
+		return -1;
+
+	int_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	if (!ASSERT_GT(int_id, 0, "btf__add_int"))
+		goto out;
+	if (!ASSERT_OK(btf__load_into_kernel(btf), "btf__load_into_kernel"))
+		goto out;
+
+	opts.btf_fd = btf__fd(btf);
+	opts.btf_key_type_id = int_id;
+	opts.btf_value_type_id = int_id;
+	fd = bpf_map_create(BPF_MAP_TYPE_SK_STORAGE, "sk_storage", sizeof(int),
+			    sizeof(int), 0, &opts);
+	ASSERT_OK_FD(fd, "bpf_map_create");
+out:
+	btf__free(btf);
+	return fd;
+}
+
+static void test_sk_storage(void)
+{
+	int map_fd, sk_fd = -1, value = 42, ret;
+	char output[1024] = {};
+
+	map_fd = create_sk_storage_map();
+	if (map_fd < 0)
+		return;
+
+	sk_fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (!ASSERT_OK_FD(sk_fd, "socket"))
+		goto out;
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &sk_fd, &value, BPF_NOEXIST),
+		       "add socket storage"))
+		goto out;
+	if (!ASSERT_OK(bpf_obj_pin(map_fd, PIN_PATH), "pin map"))
+		goto out;
+
+	/*
+	 * Socket storage can't be iterated, so the dump must fail with an
+	 * error and nothing else, rather than print an empty map that holds
+	 * an element. The buffer is cleared before each run so that a run
+	 * that fails to start can't match stale or uninitialised output.
+	 */
+	ret = get_bpftool_command_output("-j map dump pinned " PIN_PATH,
+					 output, sizeof(output));
+	ASSERT_NEQ(ret, 0, "json dump fails");
+	ASSERT_STRNEQ(output, JSON_ERROR, strlen(JSON_ERROR),
+		      "json dump is only the error");
+
+	memset(output, 0, sizeof(output));
+	ret = get_bpftool_command_output("map dump pinned " PIN_PATH,
+					 output, sizeof(output));
+	ASSERT_NEQ(ret, 0, "plain dump fails");
+	ASSERT_NULL(strchr(output, '['), "plain dump prints no elements");
+
+	memset(output, 0, sizeof(output));
+	get_bpftool_command_output("map dump pinned " PIN_PATH " 2>&1 >/dev/null",
+				   output, sizeof(output));
+	ASSERT_HAS_SUBSTR(output, "can't dump sk_storage map",
+			  "plain dump explains why on stderr");
+
+out:
+	unlink(PIN_PATH);
+	if (sk_fd >= 0)
+		close(sk_fd);
+	close(map_fd);
+}
+
+/*
+ * A queue map has no BTF, so its plain dump prints an element count
+ * rather than JSON. A dump that ignored the error would print "Found 0
+ * elements" for a queue that holds one.
+ */
+static void test_queue(void)
+{
+	char output[1024] = {};
+	int map_fd, value = 42, ret;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, "queue", 0, sizeof(int), 1,
+				NULL);
+	if (!ASSERT_OK_FD(map_fd, "bpf_map_create"))
+		return;
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, NULL, &value, BPF_ANY),
+		       "push to queue"))
+		goto out;
+	if (!ASSERT_OK(bpf_obj_pin(map_fd, QUEUE_PIN_PATH), "pin map"))
+		goto out;
+
+	ret = get_bpftool_command_output("map dump pinned " QUEUE_PIN_PATH,
+					 output, sizeof(output));
+	ASSERT_NEQ(ret, 0, "plain dump fails");
+	ASSERT_NULL(strstr(output, "Found"), "plain dump prints no count");
+
+	memset(output, 0, sizeof(output));
+	get_bpftool_command_output("map dump pinned " QUEUE_PIN_PATH " 2>&1 >/dev/null",
+				   output, sizeof(output));
+	ASSERT_HAS_SUBSTR(output, "can't dump queue map",
+			  "plain dump explains why on stderr");
+
+out:
+	unlink(QUEUE_PIN_PATH);
+	close(map_fd);
+}
+
+void test_bpftool_map_dump(void)
+{
+	if (test__start_subtest("sk_storage"))
+		test_sk_storage();
+	if (test__start_subtest("queue"))
+		test_queue();
+}
-- 
2.47.3

