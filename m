Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEC33C1097
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180142; cv=none; b=lHaLAYZm6hL7mDywopz46kuHq2M99rTrrW8YLZRVoP9XhkXY+mIzFRWGhDXsrfMuxugRbnDvT6DOjbvNZjyhI76DXV4SlnngnYJ7kC0DhMQRc9UrBPPuuU+3Tzy+eh9Jxb5iwrVD/lZ+NGrKS70JLB2TaoEblr0ReT9hfdzfeyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180142; c=relaxed/simple;
	bh=oXXyib5NnNxqviHwEBhtytIp1Gadgc3QopfLYoZUZFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUKQ475ASoBSyeR1mZB++UROyThxTeJMVLhNSkmt/LaDoBHV5z3TPzuz9xbfR6qJmSkJzA9SByRZkqDzaeXPMAzQ50xNzkJ0IBeR5QtdkVHcsw9m1Zol4DEMBjG5jEJExlq8SU8I99nkzrUJpudUTaFXean52IzH08m7V8daedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKqghDEr; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKqghDEr"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a75f960be4so1438671fa.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792180132; x=1792784932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pD1QX2E0kEsZPc5QQVNEY3ZUzg/K1NBBqppLffbGTq4=;
        b=EKqghDErcPhFKw7A+N+tjklez3tG20WgMnc8tKiumAzur/Pp0G5orWdsiDEUkIim8l
         V8HsCpOlN3ET5HPasM1EvoGNPzqIHruVEufcTRdbFQaAbqVWcoNT5AoZjwfCbA+9D0Gu
         iy+GjSNdDN1T+Yp5DlvEXUd1OA2PCnspe2ngWqSOJ1bhqOCUjOhvobZrV5vZ/kM+HgDk
         cBZj4qBQ/xegZl3uNxSIHnp2myF/wVgtjpCeg3c0puuc/5wNgQ50UpDMKUJu48pHNE/2
         hXKb0TE67wLlTYQcaMmom2/4HG1gb1LQwrXE9/PUAOwzmBjKisn+z/KDk5aAt0J6da7U
         H5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792180132; x=1792784932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pD1QX2E0kEsZPc5QQVNEY3ZUzg/K1NBBqppLffbGTq4=;
        b=lEZHh2o5vn1SwOPU3Wy+O3ybSJBXLVK4p0BdAFzQLgyqS2l7c7LNiKKrlf67eR3HYt
         K+QZ8y+Qs7nPJmnTf3KoOoGMkn/H9jeEaetqMLWEFfZTPLZAqhQIxreAwGbQrWjKI1M2
         OY6/uzXLJigTFpA5B4Jb8zwPry7y8rAjmXVpl973YrQSfwQQ0LUUJvGHDk01WQPfSF4v
         fzbnpGrg4atbotIAXLWwTun3rAwqIY+Dq5DDLWDskDe2+25T3kQ+ZPWMa7Y+FXKrRaXE
         AVwPRSTfzqLevHmFLlu5Q4yrGPymTvzuBNhv3vBhwbkKDg1lZln3aVZ6GHv3Hdt2x1S9
         iSZQ==
X-Gm-Message-State: AFq9FYJzbb80IYHA83g/BEAo4scdvVqQLi/Gr+SDhTM+nZKmf0P0EWN8
	lQ2/Olh9e49Wpyr9xUOWjJypYqUunHB5OjVQ/xmnauuACIVYowF+N6RAOfp2xSr4sWs=
X-Gm-Gg: AYBFou0GK+zh1ihY9iHEwPnEq86zBZEnouN65SIH7yVnS1qQpjALMrxWIF1T5y6v7ik
	9EkgzBtyXrKSq8g+1ZtnzYi9kLc2qfecArnuDqwAfWe6UcWNF6hu5vReELUPRRrfk883VpL5Ev9
	WMi3Vnr6ZdQIv67kZhShPZuHdvTrtvN5I620toAZ98xic1oO1OnT3mgiuQcFZRF1x/Pez6wQ9om
	h8tjlHznAhNzVUbPclgoKPg4iAYp19m/aF6HScDddFu5GPmC2MBa7XAsQ+YZSUxpG/AwTdThc6Q
	UqSkuzE8a6ypBN1qYcrOpTHdx9apx8jwClB3PlEEGUnyJFJBt3Pe6Vt8W9pM7q71DUzG3zjgpWF
	ClMoEdiw3R1kiiieF9AoymhvzgKpklbxgzW//BGrVZWIKfiTM42wgKM8YIfq6IrfUlzMlEyfzVR
	KC3zZDuX6/WFqNJ+L0WbQsPK97sSYb9lkM32MsKop/oF0uH/Xa+4QN+mo3fOCMedJKD1v9+8hkE
	1FeAGygS8ogKwGfxyJgAw90h5DjncfsjMRI0mwQo9VwAaQBV8jAWfu44cDB+20=
X-Received: by 2002:a05:651c:b11:b0:3a9:a1ed:634a with SMTP id 38308e7fff4ca-3ab292f05b5mr1702941fa.21.1792180132336;
        Fri, 16 Oct 2026 12:48:52 -0700 (PDT)
Received: from localhost.localdomain (95-24-167-79.broadband.corbina.ru. [95.24.167.79])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab2a4691f2sm1179411fa.19.2026.10.16.12.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:48:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Test bpftool map dump on maps that can't be iterated
Date: Fri, 16 Oct 2026 22:47:58 +0300
Message-ID: <20261016194825.230433-4-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016194825.230433-1-skokovmaksimevg@gmail.com>
References: <20261016194825.230433-1-skokovmaksimevg@gmail.com>
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
 .../bpf/prog_tests/bpftool_map_dump.c         | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
new file mode 100644
index 0000000000000..187b3f7843079
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
@@ -0,0 +1,133 @@
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
+	ASSERT_HAS_SUBSTR(output,
+			  "can't dump sk_storage map: Operation not supported",
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

