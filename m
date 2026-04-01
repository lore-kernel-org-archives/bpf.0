Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE444D039
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053408; cv=none; b=KA274h7ObcsZs2zitEHUKA/mQBPJw7ZP052wQ6S4b+nH0kw7p2ilNb2Hh/WqGSbV7rpPcacQ8OmT/5o6GBhvOKPY2x5EZ0XEEnW3m7iPz2kElDLgtrh5V5ZLsiHx/KRK6Hukz7CY/qIYzPkdgSrfyOXVvlEBpAvRcxbWSn5oYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053408; c=relaxed/simple;
	bh=ca2Wr9V7uK14IzyAzmMnqgVCc+EPpyevM11ZPy+vbQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXwOPOaSO7ccGeo8N6wdjPC6EoW6+FdsDSgkCfVX64WhCJMU91qGL47zOqtYL8KZviVRi29qj+Oc+j+8tUBSXzVK7lAIdhNgVlWrNCOxuUu7wkXdlSA9Bqwy9o8BKalkueLih4EUWMNc9Kjlm6oHC+iPcdpI11LR3oF8ENE3AC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jbr9md0W; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jbr9md0W"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82cd98be655so1384083b3a.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775053407; x=1775658207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFlTacB1AL4dCznCKDtvfHc+np8LRoVwaEr57VKCew0=;
        b=Jbr9md0WZJEUrxrt6t9a2Eo4v7mUSgefPd/+9fgGo/3btPm2+JDjQFbgaZwIqqNFPU
         jUkXMDsYk5lT3WY28o/BKKVPruw6QcO078VEGm3TZnqLnWwGDroKfy74QqZZuVbl/HSi
         9eecClbXoWoNLVEosEKVhMxfKi3idb/XmfIS6gQRDgBqtwI0bqfr9wt1Hd9NkYjxTuS+
         LCnfHPGppCS0nNhthDEJgWM148EQ8XXhHApCZvvlR6RPDhXigHobf9nC2nmj+/mT27jO
         rIU4LVySktrYZ38XseEL0fQK1WJtFhRykaqvOacc8laqvJ3UTOuiJgFKGjxlQ7fkpoMc
         1vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053407; x=1775658207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFlTacB1AL4dCznCKDtvfHc+np8LRoVwaEr57VKCew0=;
        b=gvZZ8EyuuzVQvy4Mc2ABBdb7DTB53azG/6G/vjZZwaUxancPamDE8vdiT4xYSpfHqZ
         3bYMrpcRg27sCtGFJJS5FCOVYTtRyR5LBE+tz+H9pFp1mDkzEdTcypOLWhstQsBBzxT9
         N8i2v279ukx7v8Q56uyhSpw5OFzm+AWHT8LQnjuMGTINPtMvIhkxlIuaG5S2l0t26nmK
         ld9/aq4VeYJystRHrbOFonadq2rsm74HYDL7kXBoWSx3mp4nITR+ojAQwf40r0H0pLot
         Op2cMCm4t0AuIiMk3BB+4/i8RFRkNTPW3LwGtiC0GN6zaZf0Z1jjX3XJ9udWKStG4QOT
         xV0A==
X-Forwarded-Encrypted: i=1; AJvYcCVtpzGh6OcUsGFOKfe7olrW4bgpwZaGP2mn6ItRCLlqTUhGgl3ZV7KwVgowbfqZQqzZ6WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNf2RgycCp6C+gahkVKxhlN13BuWGXUulNRKWUr+8Eez/TRgD2
	1vkFH9AXHMpgm8v/HQJ1cyDlLqPmt6DffP+lEwtGl9BE0xUQ5fJ1gKrL
X-Gm-Gg: ATEYQzzJRPQn/OwYLcbQx64uRCtriqcrWZuto5d9chg3xGJarcA73KFQ24OWK2UDzwC
	4JnlKi57wpkkhfthNE60odrPm14cqt5vvdmGJlnqPIBWuyqlcvLIz1LSddWhGwh27t8NM5ceUFj
	bUfWvghhmTdlEwGrnmPfP4LJJdEGCIxRpig0mgJzzMO2XkgspzbGvaGRE7PZNSQMmvjPTQIpxkk
	PsNqnGIUcIMmwvSGArVEKOs/TWxSJPoO1Ljp3GdopoTX6MC4dfP9rxjAzConsqbWv84zLqldcXW
	zlN3HZo/jXS55HPPzmavA/u9MQKPym/2OxrDN9NS661L59WNigmE9IpyzkikQ/ex/ubD9b2R3KY
	2UGFzrxlLWznKrC9uUqhNUXKoiHkS3rhvhG7A2PlgqQ/RC5jv5KaE5zxstErRKJCSWyV1Gq9YIr
	wKHzVsgsGpFk+THi4evbCFAT9hsgK3PuFn1Qk=
X-Received: by 2002:a05:6a00:2355:b0:82c:9c43:926c with SMTP id d2e1a72fcca58-82ce8af194amr4351369b3a.55.1775053406560;
        Wed, 01 Apr 2026 07:23:26 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b27313sm103580b3a.5.2026.04.01.07.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:23:25 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH v2] bpf: reject direct access to nullable PTR_TO_BUF pointers
Date: Wed,  1 Apr 2026 22:23:16 +0800
Message-ID: <20260401142316.2452-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_mem_access() matches PTR_TO_BUF via base_type() which strips
PTR_MAYBE_NULL, allowing direct dereference without a null check.

Map iterator ctx->key and ctx->value are PTR_TO_BUF | PTR_MAYBE_NULL.
On stop callbacks these are NULL, causing a kernel NULL dereference.

Add a type_may_be_null() guard to the PTR_TO_BUF branch, matching the
existing PTR_TO_BTF_ID pattern.

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:bpf_prog_5f0e2be830ac3243_null_deref_iter+0x10/0x25
  Call Trace:
   bpf_iter_run_prog+0x1c2/0x2e0
   __bpf_hash_map_seq_show+0x120/0x180
   bpf_seq_read+0x29c/0x530
   vfs_read+0x179/0x930
   ksys_read+0xef/0x1c0
   do_syscall_64+0xe0/0x1290
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  Kernel panic - not syncing: Fatal exception

Fixes: 20b2aff4bc15 ("bpf: Introduce MEM_RDONLY flag")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
Changes in v2:
  - Add selftest

Link: https://lore.kernel.org/all/20260331172720.29938-1-tpluszz77@gmail.com/
---
 kernel/bpf/verifier.c                         |  3 +-
 .../selftests/bpf/progs/iter_buf_null_fail.c  | 49 +++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/iter_buf_null_fail.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 937c9adf1b3d..17850836943b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7905,7 +7905,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (reg->type == CONST_PTR_TO_MAP) {
 		err = check_ptr_to_map_access(env, regs, regno, off, size, t,
 					      value_regno);
-	} else if (base_type(reg->type) == PTR_TO_BUF) {
+	} else if (base_type(reg->type) == PTR_TO_BUF &&
+		   !type_may_be_null(reg->type)) {
 		bool rdonly_mem = type_is_rdonly_mem(reg->type);
 		u32 *max_access;
 
diff --git a/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c b/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c
new file mode 100644
index 000000000000..997389f01ed3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Qi Tang */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} hashmap SEC(".maps");
+
+/*
+ * Verify that the verifier rejects direct access to nullable PTR_TO_BUF
+ * (ctx->key) without a null check.  On the iterator stop callback,
+ * ctx->key is NULL, so unconditional access would be a NULL deref.
+ */
+SEC("iter/bpf_map_elem")
+__failure __msg("invalid mem access")
+int iter_buf_null_deref(struct bpf_iter__bpf_map_elem *ctx)
+{
+	/* ctx->key is PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY.
+	 * Direct access without null check must be rejected.
+	 */
+	volatile __u32 v = *(__u32 *)ctx->key;
+
+	return 0;
+}
+
+/*
+ * Verify that access after a null check is still accepted.
+ */
+SEC("iter/bpf_map_elem")
+__success
+int iter_buf_null_check_ok(struct bpf_iter__bpf_map_elem *ctx)
+{
+	__u32 *key = ctx->key;
+
+	if (!key)
+		return 0;
+
+	volatile __u32 v = *key;
+
+	return 0;
+}
-- 
2.43.0

