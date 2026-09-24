Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F14AA02B
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266098; cv=none; b=DJ7LsMRgHfxPvD3Uf7kuypm0exIE/pBFmvMTs6BLcE8dmK4dC4npDag6waHPCaLpZ+I/JD2dHf55Lm771zdMHpajtdCG4l/wzI1xMvNI4oCaZ8HXBBg7nbXeeX0bWoPs36zlj7L1v3owcibVQKgjL8koIJhogPdGVGokMyVFTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266098; c=relaxed/simple;
	bh=suH0PgmQAXJi4LDV2AjeW8fVjLOcWMDeGLpNuEQJlkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecCx+Z2hnrgGS5/5xzFBbCJ8wcUuNOcm3wzkytEz9bWcQfvtmvGNNaXdvtAONGaXF97dVKFG0eIDiKyC0fpmraciBje9QLaqL64Q3HQ7UQxQqKD5Co1B94+87iQ7/aCOhBxgpWTRXuTHv4Tr6N4aUSfURUMaUFndyUNCegZB9QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6Fk3hBy; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6Fk3hBy"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c1b8d7b5so2128895e87.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266095; x=1790870895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPE2YfikAlPbMH22TxLuuTd1aiRFp/hIpk9z8ifigMo=;
        b=Z6Fk3hByGUKyH7oKbRW5352IRumFElYzKtMGGJJBC6CkpZ8+0i6K2jM9k1iBcUdXWW
         ue8+BidDHOV48eujulKR1YRka36dH+xFXH38XwA81dTPP9n6//FMqyaswx8Wbl+Im8+K
         2AkicKqsdID/o8Q3oa7UypCNNv8oWJJDpE7MJY/3QE5QpwSY8XzolQt664ijNbqCHgpt
         ZDcrFzTiqF5H2rOzAwftfYMcYXLaKI7wMLlEgt8XMhFNkOQW8+FcFL9VC7MnIg1rxCR+
         yxWByDDG0XZIVKS02EUKFX4lXSxC3g61/RSXYM1zpgmeqdbSoDQIIZrSlnbPg+JOSz9E
         50Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266095; x=1790870895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qPE2YfikAlPbMH22TxLuuTd1aiRFp/hIpk9z8ifigMo=;
        b=zH1cyAgvzKD5fxBtx0FGb7nLKpo/iZmP4hauQGPytMCkdWj8TC0ZzESgIjFGVW8xsm
         0mGyU2CI21LIZWtDnRBQZcFduPcSOf5WAMPQ8k6NucICIgA6IVAMh7x/51pjXTtBK7ML
         RoHCl82fFf1Wg30ecq9lVqCGukJXMed0YoOSLcZtgJyKG/DQAWYay43iILcO6wITQ4f0
         tqqHKd69ul2uv47qv4KdLDGjc2fbb0VAB+kpauzYOIbowBMDZzODHSBnNZIHulYecgNr
         KW9TwjrRUpxZRuo6qJv9Iz4RcKEx3M6ZycC4gvKNK4T6iVJjnD/6Q/oVhzdw5UItTvu2
         EQow==
X-Gm-Message-State: AFuF++meFUJz5Q/Jx7zySHqgLyUnBDu+XreslXzRyhGhlHctzeCkLvJ2
	yxpckNf//aFYWxzDvD0CLPHEQhPDBf9wZvmwr4bN856PIzfIXHUa96RqIYqB8N953/k=
X-Gm-Gg: AYBFou3H46uuE7z+Q1vZXmFelGVla/IcLd9+HYIyycBQ/KJrjO0XPZoI4+whozwRWfn
	zdaP6i1cRZ5Aq8mUMeQMpy9Ea7hX0zc8v4gr106bHQpHIn0o9sz0niHu/r0KDTa21V3WkczUdwT
	eXAMKUjFCNd7jEhwpRpyr4LeAfeWFtOipMg/pktm2V6/GEaoIuZm74xmqoueReAPYIia7kCzJyf
	I+mgfIWi/ThW4eqZeQKg9yPKqNyS7pL3f2UY3yuMsXst1vi2clJwGy1BFAvLZ/lIB+INZ+AcYXX
	egHd1XLG2/O4Uiyj7RZDS270L01GDv7t/ujirruPust45kFCHBdprTTu6otFSGGA9wCsrA/rRoG
	jlJHG47540GzPwfk8uEGKdFOhfQUkvgwjYV2HX7C2ZJfLM5c1JsLQrgIyme8No50Uy4NijfbqkZ
	4NMecyFXvjLp1FlHTcP7VssoI9JoYVgpYKj96D+dhnzNsz0sVMg3O+7U44pJv4gXgBJd9W6bQwg
	xtMBR8uUBJzccc=
X-Received: by 2002:a05:6512:61ce:20b0:5b8:9eed:8963 with SMTP id 2adb3069b0e04-5b8df0742dbmr870502e87.20.1790266094511;
        Thu, 24 Sep 2026 09:08:14 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.93])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d8552fd4sm1563292e87.2.2026.09.24.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:08:14 -0700 (PDT)
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
	kuba@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Maxim Skokov <skokovmaksimevg@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Check that bpftool reports a map it can't dump
Date: Thu, 24 Sep 2026 19:07:20 +0300
Message-ID: <20260924160732.485650-3-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924160732.485650-1-skokovmaksimevg@gmail.com>
References: <20260924160732.485650-1-skokovmaksimevg@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Socket storage can't be iterated from user space, so "bpftool map dump"
used to print an empty map and exit with an error status, without saying
why. Create a BPF_MAP_TYPE_SK_STORAGE map, attach storage to a socket,
pin it, and check that both JSON and plain dumps fail with a message.

Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
Assisted-by: LLM
---
 .../bpf/prog_tests/bpftool_map_dump.c         | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
new file mode 100644
index 0000000000..56283e3f1e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/socket.h>
+#include <unistd.h>
+#include <bpf/btf.h>
+#include <test_progs.h>
+#include "bpftool_helpers.h"
+
+#define PIN_PATH	"/sys/fs/bpf/test_bpftool_map_dump_sk_storage"
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
+	char output[1024];
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
+	/* Socket storage can not be iterated, so the dump must fail loudly
+	 * rather than print an empty map that holds an element.
+	 */
+	ret = get_bpftool_command_output("-j map dump pinned " PIN_PATH,
+					 output, sizeof(output));
+	ASSERT_NEQ(ret, 0, "json dump fails");
+	ASSERT_HAS_SUBSTR(output, "\"error\":", "json dump reports an error");
+
+	ret = get_bpftool_command_output("map dump pinned " PIN_PATH " 2>&1",
+					 output, sizeof(output));
+	ASSERT_NEQ(ret, 0, "plain dump fails");
+	ASSERT_HAS_SUBSTR(output, "does not support iteration",
+			  "plain dump explains why");
+
+	unlink(PIN_PATH);
+out:
+	if (sk_fd >= 0)
+		close(sk_fd);
+	close(map_fd);
+}
-- 
2.47.3

