Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E844370D7C
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790442145; cv=none; b=d+UAKcFNrVqoRb7n6vZpQTxRI8Xn6dDta+kJKhA434YidK/0EEZ04ileXLQ25NwT/vR7Fw6oz1YqOtc0uMYnUOc9vd6Gj+Ws9SAlv5ZD/Yeb8MJGz21L/KDExOd82w8sY2TYRGrFJqVajvLJpHM04VVmkWDAVuia3kAAOevXV+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790442145; c=relaxed/simple;
	bh=+x/e7On/IcWDXE0oI2pQ8TKUyVU5A/+3HVGVQQ8G0WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZkPqVgtPaUBK0D0W7mxtWAwrXgaFwIXcrLZrTvL+CO4IHf7dg0svP2hyhbkHptgq1M1ZKVG5yAYDAUHGi4Jpoo9KcofGwtg1r+SRubBA/4V8BSjJUK+k8WV7lv2IkpOD0Z1+mtwShkhOmUDc5jKkEfoHvVz2YU2OIpNKdPNtCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPReXgu7; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPReXgu7"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so1568973e87.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790442142; x=1791046942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P+ibszBeQS9COm7Q++M+dCutY245TQDZmqdayPA5Fwo=;
        b=HPReXgu7sEgbppxWMiaqGihYnjcGf//5XtyX/QJss2/sZ2QO8bguJ1uDoRrYGbd8Jd
         K8xZTeHlPc/vwtf4IampjNy+0LFk/BM1MzgfuqhRbYBNyAPHTK/TvqIkSUCppQVrBjSw
         CFVUtW1ZClBVTyclCnGHpNf5wAjAafNtsQN/NKSQyNAQv8rkd5tuB7Xdi7TFlcuJmAQK
         v3euY3NOrnogPK+qsTQYjbWsSrINuqed5xKl89yDY0dpeLosjeQ4dWbAGjJTc1Z32gGc
         7EXv8NoeN6sVEuj2yyDQKCK8sWCQJDbmVeFgxKQed9Iu43BkDSym87S4L1OE8BSRxhV7
         UsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790442142; x=1791046942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P+ibszBeQS9COm7Q++M+dCutY245TQDZmqdayPA5Fwo=;
        b=HRuqU89M6dexaNubKPq9yHmtYCumD/ax7GGQF2TFqxvc7WdSSRGHtkb4hSmrMpUyie
         ER1aYLO+Nb9OjWKkOlLW6qTnf35C/VVOGdnAuhVK9OO1sBb1DjTSjV98a9yLf/TBQQhs
         4sP1L94UDKjBdGRh2iB4cXmU7rnZsBH26jvAI817W9/1JToAs4j+OWIz+zdvoQ87mmeS
         IMcgKO7A9ZMVIBDrRb6XTD/SsirhD+x07Vfqh/aCiZ1WZzcQza5DNb+6vB6I9gHjWLqo
         g7QRF5WGxyODn+bFOk6TUIrp0nhZqBI14lXD6clRPtBp8A+5xF4PfKsgt7CBO6QlYGfJ
         JZhQ==
X-Gm-Message-State: AFuF++nYXt9rEU5TYnaor55L2o7J0iTgnTMcYZYqiCbP1dEqJz3yggix
	b12oKsEuXoR6BnI4DXeuY3QlH2RnSAvyYeobeaelsAr3wC/ovNqI2fZA3KjvkefvQHQ=
X-Gm-Gg: AYBFou0zvjr8pnQPATh0AomIbTYmxowFPw1oy45cr40b+PcSh+x58eoBwEaBFmnklw8
	VmmG075aW5jprnEkX5xQt4JwhLoABR2G5G0qps8iE5Qeldg7dKKcOr0XB0T27q+lRPbueG1nfw4
	5R0icdHc9lhkR/vOaSWunzhKKwjIyu2AELNugsAjEt9i3RQiuFAaMJQlcFNqpx8uodbtslSKWuy
	0Dr7omaep7OtGDKxIuFeH0sDnT/4xZlD7cNCOJs+9eTlLWx3Bf0IkUDtZuHlyk1ee5hj01ZhfU4
	3cWxmFDjXa59/wfQPmU7k32IrhMTj6ybRZh3kckkRq7l+J2rSLF2TQkLg7ZL+eHIcUcf/xZoLN+
	ALmFO8SDA9NeuZj6kQ7mQzZE8FJS3yIz3tx3Ib1JBIiWbO94nzzbvHBHrM6IeV/AdScDMR1PJDu
	V9pgocza3ZJgIcNW8fUz/GbMX37CWDM0tO13nCF+h0WAnrfogLDgLuMfPfXtO3BrvRVKDYHZ+hA
	Zdp8Uz41N2Ccrdf
X-Received: by 2002:ac2:4c54:0:b0:5b8:c147:f383 with SMTP id 2adb3069b0e04-5b8df202dc1mr2836022e87.53.1790442141536;
        Sat, 26 Sep 2026 10:02:21 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.117])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e6b078d2sm1317178e87.63.2026.09.26.10.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:02:21 -0700 (PDT)
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
	hi@tychen.cc,
	Maxim Skokov <skokovmaksimevg@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Check that bpftool map dump fails for socket storage
Date: Sat, 26 Sep 2026 20:01:27 +0300
Message-ID: <20260926170149.541352-3-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260926170149.541352-1-skokovmaksimevg@gmail.com>
References: <20260926170149.541352-1-skokovmaksimevg@gmail.com>
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
error object with -j, no elements and no count on stdout in plain mode,
and the reason on stderr.

Assisted-by: LLM
Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
---
 .../bpf/prog_tests/bpftool_map_dump.c         | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
new file mode 100644
index 000000000000..2c488f83006e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/socket.h>
+#include <unistd.h>
+#include <bpf/btf.h>
+#include <test_progs.h>
+#include "bpftool_helpers.h"
+
+#define PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_sk_storage"
+#define JSON_ERROR	"{\"error\":\"can't dump sk_storage map"
+
+/* A socket storage map with a single element, keyed on a socket we own. */
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
+void test_bpftool_map_dump(void)
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
+	ASSERT_NULL(strstr(output, "Found"), "plain dump prints no count");
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
-- 
2.47.3

