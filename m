Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A5218592
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781460312; cv=none; b=s1AT41OF+Akx6c4Mnwsky3z1+6krq5bALl4jo+JI9WzETX37vJEw/x9tb+mnEIjaKEbpcsf5P6nWR4Nw43x3YUcvEDr0rXnfqkk8djKDq0X+IRxc4jvjKs7IfdPPYpZNXIbbZa40YyFL4eycb9wliiq6ZlTv6hmBSwb6XiCsMiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781460312; c=relaxed/simple;
	bh=JW8FVJjTWsEThSF8JuDPEQLVO8P4vvAGBguPLz2MzXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7VwEZTN/d7KwlMnu1VxM704eLE2egwtzG8L4Z+n87Rd/7uoi6ny3GDNxGvRsOFrDgWH473YeoNAkBmax1RfBSz1Jj0kE94Khc2/Zsrn7tEo4HCFySl1maGeXoMZ3ZdxtwczxKsdaKrnyIKJDOuw2RN+V/Q9ZiipOvDghtMBjpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fl4uK8Bs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl4uK8Bs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b64c8311so26644695e9.3
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781460309; x=1782065109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODX1HfUpj996EHRxNq42AhNa5RpVxfOswnO9waGWRWU=;
        b=Fl4uK8BsJaZJVqgss5hjKhcnd5Y12cSDM9HyD7qTiBSnX8H8JuXzMKvycKW/iwWPGz
         6en+ISzeURkRnKGV98nxK0GfZlc/Lxz+x8ISsNvO5OYSVwkw3PkmwD9UQPVV/SLJskzI
         VtUSrXSCYvHohqidwpH3wmlVulFlt5d0/Tf3NbrqHGgkFFdluXk3ifKlgl3crzW4oIQ4
         6MHFGyoEe8KrCml7MmQRy1OEabM7/HjQVFcsks5o5RJ0j9o14EzMHaLY1L+40qCrcEQX
         ZtrLSlDYwBqtUNRqbZyPGwwyx0i1k5ZpZoUJrzSdfUywYCKhvTqSq9dGsIklXpIYhrQQ
         +r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781460309; x=1782065109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODX1HfUpj996EHRxNq42AhNa5RpVxfOswnO9waGWRWU=;
        b=ki/DIbsXYKHpfW1gskiroaPltV8xeFKt12Ye5yQ2hKhoMMiM7gxXREUOR6fMRGkRu5
         Ym0nAr716ltmBbouS8cedFG6SCsgZXgPjyRtOK1aazrmdk90u5ILiwxk9avyjfdclRDw
         6UtbHk2tu4udLzzsx9yY+mtF3w6z0d8cACI0/9+GOoFnID1N/h0dME+yZz4jXRE94+Ya
         rc51d2NzfC0XCPYa9uLhbMCbNyIGEqdUlBt6jYwCQGgUzAg7/pTDRPkpylQdWouTk36I
         /Y8QgAmAp9Z8U0rylI1VprOaCSTyilgrxGZYkN+rVjSWJALUpKzGeYvb/ceIOUNxfv9x
         TDhA==
X-Gm-Message-State: AOJu0Yx/gkXAR05dybLAFRmPjdFi1NDLCTMAreAk97KOUhe7T+BmjML0
	7ObhNjAARcTHC0gzaBTwonuUW0u4Pc74D3EY4UTMnl8wd4hzl8mqakIT31NT8lHu0pw=
X-Gm-Gg: Acq92OH+NVvC+90FOPhrKEobguA9Kgl0G1sAVY53BUX0RFocgjS2EQVc4vWdsdZaV7M
	CWY9R2uNHiFTWopKRbVY9JZNq0YgWnZsFz5veSybzyadY2SkQKFpeZwMv22L0g1+ApfGkjOrexW
	Rt+jfhjDnRQxTd3tcNNMbSjgELyjqtqG6U/y01FvASuuMqZqewu6JN+NDse+sp+E9OiLSUrWXOr
	q5IIIcDuYLsFvN3VKXlq98/6cXFHZcOfPH3OjT7uQRZvPxpgDCVDZXRxkazYWXw5vYiLPB7Dr6p
	hGMBG3xl5qsgw11mQTMWZOUxEpWflOVEf2ycjHyWsgpq26MWO6GqNY4AtPk26ywOSX3cxxxEixb
	Urs4KEdadbd7CSagAtuTberpJ5OSB6HB/NA2NYdUobSJHMU5bU4L41z5sd9GcYQpnmyLKyFktj6
	yD78o3/TFhmY7VFMrU3p+k6WY/B/j0mkiQZ3FDNpWzZ23NIe/CosPAWm5TxAs+T0dF/Dmx3FQ0G
	bzX
X-Received: by 2002:a05:600c:3b16:b0:491:e3be:1363 with SMTP id 5b1f17b1804b1-491e3be13b3mr127467695e9.0.1781460309301;
        Sun, 14 Jun 2026 11:05:09 -0700 (PDT)
Received: from ds-pc.. (host86-147-161-204.range86-147.btcentralplus.com. [86.147.161.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49220345528sm205543945e9.8.2026.06.14.11.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 11:05:08 -0700 (PDT)
From: Dhiraj Shah <find.dhiraj@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org
Subject: [PATCH v2] selftests/bpf: Add arena direct-value boundary test
Date: Sun, 14 Jun 2026 19:04:40 +0100
Message-ID: <20260614180440.1073941-1-find.dhiraj@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614163352.1060813-1-find.dhiraj@gmail.com>
References: <20260614163352.1060813-1-find.dhiraj@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add coverage for direct map value access against BPF_MAP_TYPE_ARENA.
For a one-page arena, an offset of PAGE_SIZE - 1 is valid, while
PAGE_SIZE is one byte past the end of the mapping and must be rejected.

Skip the test when arena maps are not supported by the target
architecture.

This covers the off-by-one case in arena direct-value range checking.

Signed-off-by: Dhiraj Shah <find.dhiraj@gmail.com>
---
Changes in v2:
- Skip the test when BPF_MAP_TYPE_ARENA is unsupported.

 .../bpf/prog_tests/arena_direct_value.c       | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_direct_value.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c b/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
new file mode 100644
index 000000000000..d58790a66cc8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <linux/filter.h>
+#include <sys/mman.h>
+#include <sys/user.h>
+#ifndef PAGE_SIZE
+#include <unistd.h>
+#define PAGE_SIZE getpagesize()
+#endif
+
+static int create_arena(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_flags = BPF_F_MMAPABLE,
+	);
+
+	return bpf_map_create(BPF_MAP_TYPE_ARENA, "arena", 0, 0, 1, &opts);
+}
+
+static int load_direct_value_prog(int map_fd, int off)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_VALUE(BPF_REG_1, map_fd, off),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+
+	return bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
+			     insns, ARRAY_SIZE(insns), NULL);
+}
+
+static void test_direct_value_boundary(void)
+{
+	void *area = MAP_FAILED;
+	int map_fd, prog_fd;
+
+	map_fd = create_arena();
+	if (map_fd < 0 && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
+	if (!ASSERT_OK_FD(map_fd, "create_arena"))
+		return;
+
+	area = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
+	if (!ASSERT_NEQ(area, MAP_FAILED, "arena_mmap"))
+		goto out;
+
+	prog_fd = load_direct_value_prog(map_fd, PAGE_SIZE - 1);
+	if (ASSERT_OK_FD(prog_fd, "last_valid_byte"))
+		close(prog_fd);
+
+	prog_fd = load_direct_value_prog(map_fd, PAGE_SIZE);
+	if (!ASSERT_LT(prog_fd, 0, "one_past_end"))
+		close(prog_fd);
+
+out:
+	if (area != MAP_FAILED)
+		munmap(area, PAGE_SIZE);
+	close(map_fd);
+}
+
+void test_arena_direct_value(void)
+{
+	if (test__start_subtest("direct_value_boundary"))
+		test_direct_value_boundary();
+}
-- 
2.43.0

