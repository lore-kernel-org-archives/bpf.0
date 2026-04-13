Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53F35BDDC
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106983; cv=none; b=X0rn2nt4YDipCsMbPSEx6j/oVGKf/7yjY2nAM4n17CBoA29QYo5MfVw8dNE43GAS2BYc1HQ18vWxp7xWxH3049nvkbf9PdePpVa7ki3TKTdgiRIdFffnPuuqP1dk7xOIp9/bQwms7VxNMSDm7hD03Xr/dytU4b/UxV430POWbl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106983; c=relaxed/simple;
	bh=3H8vD11IX7KZqyfN6H09ZHFT+Xe8BH17Ev9HoyvdB5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uU7EMHrc2/Vtu876iZndfGou+ezT0eJizLwIZkXSPfHnsgED9FWTbwj8V7kS3WQ5Y1yAi6u0hvPklA+lCtXud5xMMakm+ZEpiRg4BogWoXQZE6koPvvvTFevpJDIbUTD3ZuWhDpCdqxVNMUnOa01ItZXN0KuE+5TCQJOvHyZzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsGy9z8c; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsGy9z8c"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f206f2b54so858114b3a.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776106981; x=1776711781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atDvfZ5kF80vti1eITSyPMZO8y4WUdaD3lKF20+5h6g=;
        b=GsGy9z8c1KQjqv0Ir47cEambhLlRubdk9Ttf6ATKwd5WxI7BWQGCLAaEldF7VxIG65
         EoZO+sf0tQFTpGhZog/Fkc89NnEGxiv/UvXvhUh51ZaqYpdvowQ13wNLVOJYExzAnWi2
         W3B8jKW3n9nr88iKLix+2/M9ww/PhMi3Ykwv2fI+6j/VjTE3ReQeT/P853lhKQ2uKqWl
         L/WfTy5XmyUXrHJCmZkVGV1Uxn5wzmjtzL2ooYhGtNmYHeNCEG+UzGGZhQbhy3HGBINT
         brrZZdnnddKyTeLvkZYCEentuyCaAUQBmwwJZdSRiw01hXcKyFg+u2J5R5OxFjNsJ1T2
         KdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776106981; x=1776711781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=atDvfZ5kF80vti1eITSyPMZO8y4WUdaD3lKF20+5h6g=;
        b=owFqHYp74t8A6h8A3b255XasgKEURx6qMOGOmW+NxFZ5ihmpsaJ66orkz9Fjd16yja
         Kfxm6qM8bQsi4nUAR/whqHkHdCZ4EBPsCAiA2SUXk1RmCwRRRswzZuC+WjePCbGaw0w7
         63FK2e+gyZez/cbWgffVOrx0Qw1yV6zRpfUdqjUZl8MswYEXEsRLGuiB48YiT5Oc5GrO
         Fe0MxBbxfuep56lXfdK0C4tR3WULDQI/Uc1gzPS7kLbsAbv1NBRdHSH1UpUnrck/AhI0
         mitSKG+EqkCiZZff1nYZ3AD87b2t1TjoINeArf+X3Dqdi3pLAXkSAQqjxjyoY8v1dDLa
         gTzg==
X-Gm-Message-State: AOJu0YwOvSNxt9Z9F/iu0/UxNpO5c9zQ+z6q72gHXEI4etKMC8ajzqzu
	AyzzcUBfYvRnLBxqRrTU3+ZjZILfWhi4sb6KBt1fk0r8bqkXk/l5f++wxsNidQ==
X-Gm-Gg: AeBDiesB59Feu/6GeFw70s3SWjJAeTKg/W5br4C9PyKnrBtrSnPaqAZLmmbJ7CIV8xS
	MCc7U1NVKpQ8MRI8mcTHYHdj/MpSAd2K2sXX7D4xPu5kyoioMlE8AiWfnJBArJ/Qj7Kx07rhpKa
	kfxI21o1hB+7ptfQLovKhzOtowDZ3rKjuMZ7zYitAOBz/WkebN6xJhWLbdpkSgSTBJgg9e1z6VR
	ybDsqJnSz3zNNrmgD27KgFLsnG/IAaWRj+VlyUJgN5VwJ3BaoQar5cDDiEWz1O0rBclL3U+OQVl
	MP1IY/qCpQ8L5vQWbOi8tmd7R3nOeqvfq+aYI8MuWpvlxsGlOW4WhPhvppDaZAfZdq82i8Av+ob
	z3+dOLTKQNOd/EGWI7zM54Enwm+/A74TUfeC3XNs/+IGUR1j8OiGKuhT7B6GXMMR/uVRMPCJUji
	X/O6c6Qn0w0LJK
X-Received: by 2002:a05:6a00:4293:b0:82c:7eb1:4d61 with SMTP id d2e1a72fcca58-82f0c298d87mr14557102b3a.32.1776106981495;
        Mon, 13 Apr 2026 12:03:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f45e9c5c4sm3785603b3a.60.2026.04.13.12.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:03:01 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] selftests/bpf: Prevent allocating data larger than a page
Date: Mon, 13 Apr 2026 12:02:57 -0700
Message-ID: <20260413190259.358442-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413190259.358442-1-ameryhung@gmail.com>
References: <20260413190259.358442-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a bug in the task local data library that may allocate more than a
a page for tld_data_u. This may happen when users set a too large
TLD_DYN_DATA_SIZE, so check it when creating dynamic TLD fields and fix
the corresponding selftest.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/task_local_data.h |  3 ++-
 .../bpf/prog_tests/test_task_local_data.c      | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 1e5c67c78ffb..489f07045c9f 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -241,7 +241,8 @@ static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
 		 * TLD_DYN_DATA_SIZE is allocated for tld_create_key()
 		 */
 		if (dyn_data) {
-			if (off + TLD_ROUND_UP(size, 8) > tld_meta_p->size)
+			if (off + TLD_ROUND_UP(size, 8) > tld_meta_p->size ||
+			    tld_meta_p->size > TLD_PAGE_SIZE - sizeof(struct tld_data_u))
 				return (tld_key_t){-E2BIG};
 		} else {
 			if (off + TLD_ROUND_UP(size, 8) > TLD_PAGE_SIZE - sizeof(struct tld_data_u))
diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
index e219ff506b56..8b99b4880d24 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -3,8 +3,14 @@
 #include <bpf/btf.h>
 #include <test_progs.h>
 
+/*
+ * Only a page is pinned to kernel, so the maximum amount of dynamic data
+ * allowed is page_size - sizeof(struct tld_data_u) - static TLD fields.
+ */
+#define TLD_DYN_DATA_SIZE_MAX (getpagesize() - sizeof(struct tld_data_u) - 8)
+
 #define TLD_FREE_DATA_ON_THREAD_EXIT
-#define TLD_DYN_DATA_SIZE (getpagesize() - 8)
+#define TLD_DYN_DATA_SIZE TLD_DYN_DATA_SIZE_MAX
 #include "task_local_data.h"
 
 struct test_tld_struct {
@@ -147,11 +153,13 @@ static void test_task_local_data_basic(void)
 
 	/*
 	 * Shouldn't be able to store data exceed a page. Create a TLD just big
-	 * enough to exceed a page. TLDs already created are int value0, int
-	 * value1, and struct test_tld_struct value2.
+	 * enough to exceed a page. Data already contains struct tld_data_u,
+	 * value0 and value1 of int type, and value 2 of struct test_tld_struct.
 	 */
-	key = tld_create_key("value_not_exist",
-			     TLD_PAGE_SIZE - 2 * sizeof(int) - sizeof(struct test_tld_struct) + 1);
+	key = tld_create_key("value_not_exist", TLD_PAGE_SIZE + 1 -
+						sizeof(struct tld_data_u) -
+						TLD_ROUND_UP(sizeof(int), 8) * 2 -
+						TLD_ROUND_UP(sizeof(struct test_tld_struct), 8));
 	ASSERT_EQ(tld_key_err_or_zero(key), -E2BIG, "tld_create_key");
 
 	key = tld_create_key("value2", sizeof(struct test_tld_struct));
-- 
2.52.0

