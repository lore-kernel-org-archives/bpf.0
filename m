Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04D3AFD06
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776386; cv=none; b=d067hqrB1IxxGg8+B3FZbCTciQEvNTpv/V7JlQMmguBhqy2M7VdttqNiGy1UAXUmEksT+Syuxvamf1toOolsjoE2Czsk6q2NHLZMmi3rNlpiBKR94WbZ0v2GWrjZAnnwa6qwrIOT7LEEU0ShDQTjOQypMXrEA2iOlvwOXZ5mMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776386; c=relaxed/simple;
	bh=fbcM4yHOEyXcDdj3zQtGhJ3b8EFdcjensA6jinMqGfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cja4SCHobkTTGHFE4/Si3TUpmsx58vqd+1+c1yTlv5arv6NW1pXCbFq06fmp61I5gIwoP54LxXNYfuaBICrsRj3JGdCuHf8gc46mpzCiDohVwLjs5G3I0C7sohshGcD91l5bcQQHYCziGvT0syhqVOnOeWEiGgiYorz3wCxrwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYMhIuXe; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYMhIuXe"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fcb9d4b33so718045f8f.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786776376; x=1787381176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HumWKxa/vqCxcrBTfK32Z7eV6GDzgWU5UCE8AjC82YM=;
        b=kYMhIuXeCZph3wqZCYtz74vt9/Q0nEW+uPGtoCmJ6FetIZK6NkXLLGHLKN0sdTGiYc
         mIO9Kgvh5c0Y2KCRIUCsRZsEnJQY5SrCdVOKnX6tEIJ3mvzepS0/acd5zJf95OHEuZDW
         ZK74ZiuQXwQKWWCq/MNuS9ae6dlYzFgQdRT5Pe8d1i1uYYuY6r3s5k2bX+mJmX32KjpW
         Ycn0ErT1Ad8SvTkcaLKyagxaxETO5/9BnY8zuuvQrXson0Hz0DmSZ1zCTpIg2SKVTB7u
         fCoa4jrfWP6FJgYH6vaoJctpBd6ShOiLldY3DTDhkdqWMY11cuqkuSkTHJwTNZLJAahF
         FX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776376; x=1787381176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HumWKxa/vqCxcrBTfK32Z7eV6GDzgWU5UCE8AjC82YM=;
        b=eDsprPkYO5/YwsBTxS0PimpslR7VO5QEIBqfibQB04EnHaejbwFp5gHwO95EQw4WFM
         mAnlss3roeU4hsIW8p+DEFqqULaH52X2s0+Ax1MqLA7MDmFQ/5r5YTQJMswLliTxJ6nE
         5Z07KDA6pXG68WJ54X+L4mi1rM5FRGEyIU4hErfAsAjjBAU5ka/lY+SRs+AHB8v0uclT
         OoBjytEntq75SagPAvhsgssgu2H3uV3nPxdqdD15hhSQ6cNHcUy2La4WxV70RA+Q+Y5x
         YH9tWRj6pw0gIrJzDz15sQM2N4Vv+JamvSjZ6mX9FtwztLwVdjKnyjef/3xDJMWYkMX2
         PSIw==
X-Gm-Message-State: AOJu0YwjQr0psTTCKOyCWF3BiMwtgjmcsCcgHTXXHH7zRjZHcbzfzsX9
	2vZL43jI/f2OKWht1aP+QDbNvjJciJTnG3/bX6gwgwPiTLItPhnsiuDz2C7Fq0GC
X-Gm-Gg: AR+sD10af3wxqtzeCPjevkwqztAWjG7G6m9eXkL7Hlc/rMr6uCT83X7Og+WHrhTOEgO
	bah5UVRMdv7glS4oOCGSr18h/pRa+cvMn6qBJasUupC4XuABFjmlJqdPHsO0L7evbNgKWAcATzH
	vqGlGeTJHdR0c8TuMXVgLAztFBtfHJKddKYAzm6k40LaXfYZ+RKZagS3kfsZqNLFCyMkUhmKjQm
	0TaPiBWH2Ocn7v4OR5hu6UKw8WlXGQ0ZiDQg7GEuRRPedH4SwB90oc6W/Jn6uzly5NoPhiB9QzG
	3H+3I7cbmTirR/+ecMn/CPJ6Wz8fN285grulrwa8l9JD3psAJGs42hUHzrlzaKh7MFX1hkEVIkg
	VhnSjI6vMsw93bFwDqIXqXj0LOd47CjRe3vKkbgWsEvrKnAyGgVwuGd/nl2GFbbWAip6Ry068dC
	Ich/NSc/1NQyVoujVM+eNpW4VNE1qTzL8pYMN3JeECH9R4Ts9HBJHrRe6ewb57JZhrtAO2kw8C5
	QB3uHs20D3PEwlsLvfAJVPxbt8FHnn8S0WVvDl3Co4/1bkz3nLhqmAfvDEB6gkC5uHvom50iWlh
	0y0RhdKwL/k9EN4AJ1ZHXM5A0JU=
X-Received: by 2002:a5d:5f07:0:b0:481:4654:8599 with SMTP id ffacd0b85a97d-4816070d9bamr16835579f8f.10.1786776375596;
        Fri, 14 Aug 2026 23:46:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2005bcsm14187305f8f.6.2026.08.14.23.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:46:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 01/14] bpf: Add verifier diagnostics report helpers
Date: Sat, 15 Aug 2026 08:45:56 +0200
Message-ID: <20260815064612.378577-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815064612.378577-1-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3624; i=memxor@gmail.com; h=from:subject; bh=fbcM4yHOEyXcDdj3zQtGhJ3b8EFdcjensA6jinMqGfA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauBy3NvtuNEdf7NAvPSWZUUORg526+cV5c5Y+bqMksoY f1smRUdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmEgVOyPDtflbexZa5vx60RR7 +sk3mbubEjUtrfmE/2iGSVhqLbs5n+GfufYSDq7dD+d/bNw4w0NSmLHn57yCSjnF2SpazLMlrxx iAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add the initial diagnostics renderer for verifier reports and wire it into
the BPF build. The helper emits the common failure header through the
verifier log.

Later patches add prose wrapping, reusable report sections, and source and
instruction context for category-specific diagnostics.

Gate the helpers on normal verifier log output from the start, so
BPF_LOG_STATS-only loads do not collect or render diagnostics.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/Makefile      |  2 +-
 kernel/bpf/diagnostics.c | 47 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h | 14 ++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/diagnostics.c
 create mode 100644 kernel/bpf/diagnostics.h

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 4dc41bf5780c..90255d80e5be 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o cnum.o log.o token.o liveness.o const_fold.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o cnum.o log.o token.o liveness.o const_fold.o diagnostics.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
new file mode 100644
index 000000000000..e75753552a4d
--- /dev/null
+++ b/kernel/bpf/diagnostics.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+
+#include <linux/bpf_verifier.h>
+#include <linux/ctype.h>
+#include <linux/stdarg.h>
+
+#include "diagnostics.h"
+
+bool bpf_diag_enabled(const struct bpf_verifier_env *env)
+{
+	return env->log.level & BPF_LOG_LEVEL;
+}
+
+static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
+
+static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	va_start(args, fmt);
+	bpf_verifier_vlog(&env->log, fmt, args);
+	va_end(args);
+}
+
+static void bpf_diag_header(struct bpf_verifier_env *env, const char *category,
+			    const char *problem)
+{
+	char first;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	category = category ?: "Verifier Error";
+	problem = problem ?: "";
+
+	if (!problem[0]) {
+		diag_write(env, "\nVerification failed: %s\n", category);
+		return;
+	}
+
+	first = toupper(problem[0]);
+	diag_write(env, "\nVerification failed: %s: %c%s\n", category, first, problem + 1);
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
new file mode 100644
index 000000000000..f51aa39f0909
--- /dev/null
+++ b/kernel/bpf/diagnostics.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#ifndef __BPF_DIAGNOSTICS_H
+#define __BPF_DIAGNOSTICS_H
+
+#include <linux/compiler_attributes.h>
+#include <linux/types.h>
+
+struct bpf_verifier_env;
+
+bool bpf_diag_enabled(const struct bpf_verifier_env *env);
+
+#endif /* __BPF_DIAGNOSTICS_H */
-- 
2.53.0

