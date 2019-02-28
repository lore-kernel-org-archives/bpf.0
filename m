Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A33C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 01:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A293320842
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 01:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RXJ56q1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfB1BCE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:02:04 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:35152 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfB1BCB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 20:02:01 -0500
Received: by mail-qt1-f201.google.com with SMTP id k1so17237409qta.2
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 17:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GuZPWy6tKfv+qc4ssOTNyZTvazgpJmmCrCN26zgkXoE=;
        b=RXJ56q1XtVjT1E0KfZcZwisA7hhL6DGX4yW3P7jj5qEEjg0FMzRSioixw+MCIy9GX4
         UTbEJIayUhwrU8IVC8dVU5M3pT7lYczYNhYDW61QDYQvaNs0FDa52ZHwSjXI6zsgetd8
         EklcW9TwFomZQUFsuj+/3NrLXik0KGZBBMa7zU3+M+16UAxcyHnvL2wQg79Qbkd6JCYd
         aAVMj5+e6Y59g8SruWaJo6tnCkaX3yfistnMcmcVGmHVZL3KuJtU3K9lzNJHuuirNc6t
         Jnzk0a+0ufCKHIW//2k83upy0ltpWBBMRcxUKKUIpYhAkFhTjiJIPMyTBFRQHZtRFaOp
         Yd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GuZPWy6tKfv+qc4ssOTNyZTvazgpJmmCrCN26zgkXoE=;
        b=b7JaffMxa0ZAP2TR9ixc56CxirPSxc7SOyZRicI4GkO01lUChiiO2Hth113dzmwOEl
         6RZcgc8GZVkOEidQHYgxpOj9fNXTYmbknrUO5TgOapGt/Ner/SgagCYJZJt9tNHcz2Ge
         aWj7Ott6TSuz5G+Fbo0qmTj1evHFxAVQBbhY7ToEpBkaweM7/S0Y9YM8QmgFMEltQvMk
         4GCFPM7xFRcXATsgrgy4gmtfh8HXmKAytgRN5VetJ7UJzkb5cIFM9Pe96LO8a3ZIpjK8
         HigFK7Hjz1IsmZ4bYZv7Q4CL7bSRPeJx1TGRNWpRV8IgVS8rtWaFicRy5X2R39Jp6uoW
         Uxlw==
X-Gm-Message-State: AHQUAuZRAqWJDhWEOPfj5MPuoA2/4Uo0CD5gwGOpMAPrnrwn3ug2YIPk
        +uZsxg46YDgt9u8fje3JmGUeg/g=
X-Google-Smtp-Source: AHgI3IZ9+TLl4TKIxSR3vr4pXqArhzpOHsfXZJEqdrSp1wRigxzO0pY1FPm0yFtar7sl7KNf9Y5pLys=
X-Received: by 2002:ac8:19ec:: with SMTP id s41mr2833401qtk.41.1551315719386;
 Wed, 27 Feb 2019 17:01:59 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:01:50 -0800
Message-Id: <20190228010156.82981-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH bpf-next 1/7] selftests: bpf: break up test_progs
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Recently we had linux-next bpf/bpf-next conflict when we added new
functionality to the test_progs.c at the same location. Let's split
test_progs.c the same way we recently split test_verifier.c.

I follow the same patten we did in commit 2dfb40121ee8 ("selftests: bpf:
prepare for break up of verifier tests") for verifier: create
scaffolding to support dedicated files and slowly move the tests into
separate files.

Compared to the verifier split, each separate file here is
a compilation unit.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/Makefile          | 27 +++++-
 .../selftests/bpf/prog_tests/.gitignore       |  1 +
 tools/testing/selftests/bpf/test_progs.c      | 92 +++----------------
 tools/testing/selftests/bpf/test_progs.h      | 81 ++++++++++++++++
 4 files changed, 122 insertions(+), 79 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/.gitignore
 create mode 100644 tools/testing/selftests/bpf/test_progs.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ccffaa0a0787..518cd587cd63 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -165,7 +165,11 @@ $(ALU32_BUILD_DIR)/urandom_read: $(OUTPUT)/urandom_read
 $(ALU32_BUILD_DIR)/test_progs_32: test_progs.c $(ALU32_BUILD_DIR) \
 						$(ALU32_BUILD_DIR)/urandom_read
 	$(CC) $(CFLAGS) -o $(ALU32_BUILD_DIR)/test_progs_32 $< \
-		trace_helpers.c $(OUTPUT)/libbpf.a $(LDLIBS)
+		trace_helpers.c prog_tests/*.c $(OUTPUT)/libbpf.a $(LDLIBS)
+
+$(ALU32_BUILD_DIR)/test_progs_32: $(PROG_TESTS_H)
+$(ALU32_BUILD_DIR)/test_progs_32: CFLAGS += -I$(OUTPUT)
+$(ALU32_BUILD_DIR)/test_progs_32: prog_tests/*.c
 
 $(ALU32_BUILD_DIR)/%.o: progs/%.c $(ALU32_BUILD_DIR) \
 					$(ALU32_BUILD_DIR)/test_progs_32
@@ -196,6 +200,25 @@ ifeq ($(DWARF2BTF),y)
 	$(BTF_PAHOLE) -J $@
 endif
 
+PROG_TESTS_H := $(OUTPUT)/prog_tests/tests.h
+$(OUTPUT)/test_progs: $(PROG_TESTS_H)
+$(OUTPUT)/test_progs: CFLAGS += -I$(OUTPUT)
+$(OUTPUT)/test_progs: prog_tests/*.c
+
+PROG_TESTS_FILES := $(wildcard prog_tests/*.c)
+$(PROG_TESTS_H): $(PROG_TESTS_FILES)
+	$(shell ( cd prog_tests/
+		  echo '/* Generated header, do not edit */'; \
+		  echo '#ifdef DECLARE'; \
+		  ls *.c 2> /dev/null | \
+			sed -e 's@\([^\.]*\)\.c@extern void test_\1(void);@'; \
+		  echo '#endif'; \
+		  echo '#ifdef CALL'; \
+		  ls *.c 2> /dev/null | \
+			sed -e 's@\([^\.]*\)\.c@test_\1();@'; \
+		  echo '#endif' \
+		 ) > $(PROG_TESTS_H))
+
 VERIFIER_TESTS_H := $(OUTPUT)/verifier/tests.h
 $(OUTPUT)/test_verifier: $(VERIFIER_TESTS_H)
 $(OUTPUT)/test_verifier: CFLAGS += -I$(OUTPUT)
@@ -211,4 +234,4 @@ $(OUTPUT)/verifier/tests.h: $(VERIFIER_TEST_FILES)
 		 ) > $(VERIFIER_TESTS_H))
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(ALU32_BUILD_DIR) \
-	$(VERIFIER_TESTS_H)
+	$(VERIFIER_TESTS_H) $(PROG_TESTS_H)
diff --git a/tools/testing/selftests/bpf/prog_tests/.gitignore b/tools/testing/selftests/bpf/prog_tests/.gitignore
new file mode 100644
index 000000000000..45984a364647
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/.gitignore
@@ -0,0 +1 @@
+tests.h
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index c59d2e015d16..e49a1e20dc63 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -4,57 +4,12 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <assert.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <time.h>
-#include <signal.h>
-
-#include <linux/types.h>
-typedef __u16 __sum16;
-#include <arpa/inet.h>
-#include <linux/if_ether.h>
-#include <linux/if_packet.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <linux/tcp.h>
-#include <linux/filter.h>
-#include <linux/perf_event.h>
-#include <linux/unistd.h>
-
-#include <sys/ioctl.h>
-#include <sys/wait.h>
-#include <sys/types.h>
-#include <sys/time.h>
-#include <fcntl.h>
-#include <pthread.h>
-#include <linux/bpf.h>
-#include <linux/err.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "test_iptunnel_common.h"
-#include "bpf_util.h"
-#include "bpf_endian.h"
-#include "bpf_rlimit.h"
-#include "trace_helpers.h"
-#include "flow_dissector_load.h"
-
-static int error_cnt, pass_cnt;
-static bool jit_enabled;
-
-#define MAGIC_BYTES 123
-
-/* ipv4 test vector */
-static struct {
-	struct ethhdr eth;
-	struct iphdr iph;
-	struct tcphdr tcp;
-} __packed pkt_v4 = {
+#include "test_progs.h"
+
+int error_cnt, pass_cnt;
+bool jit_enabled;
+
+struct ipv4_packet pkt_v4 = {
 	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
 	.iph.ihl = 5,
 	.iph.protocol = IPPROTO_TCP,
@@ -63,12 +18,7 @@ static struct {
 	.tcp.doff = 5,
 };
 
-/* ipv6 test vector */
-static struct {
-	struct ethhdr eth;
-	struct ipv6hdr iph;
-	struct tcphdr tcp;
-} __packed pkt_v6 = {
+struct ipv6_packet pkt_v6 = {
 	.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
 	.iph.nexthdr = IPPROTO_TCP,
 	.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
@@ -76,26 +26,7 @@ static struct {
 	.tcp.doff = 5,
 };
 
-#define _CHECK(condition, tag, duration, format...) ({			\
-	int __ret = !!(condition);					\
-	if (__ret) {							\
-		error_cnt++;						\
-		printf("%s:FAIL:%s ", __func__, tag);			\
-		printf(format);						\
-	} else {							\
-		pass_cnt++;						\
-		printf("%s:PASS:%s %d nsec\n", __func__, tag, duration);\
-	}								\
-	__ret;								\
-})
-
-#define CHECK(condition, tag, format...) \
-	_CHECK(condition, tag, duration, format)
-#define CHECK_ATTR(condition, tag, format...) \
-	_CHECK(condition, tag, tattr.duration, format)
-
-static int bpf_find_map(const char *test, struct bpf_object *obj,
-			const char *name)
+int bpf_find_map(const char *test, struct bpf_object *obj, const char *name)
 {
 	struct bpf_map *map;
 
@@ -2150,12 +2081,19 @@ static void test_signal_pending(enum bpf_prog_type prog_type)
 	signal(SIGALRM, SIG_DFL);
 }
 
+#define DECLARE
+#include <prog_tests/tests.h>
+#undef DECLARE
+
 int main(void)
 {
 	srand(time(NULL));
 
 	jit_enabled = is_jit_enabled();
 
+#define CALL
+#include <prog_tests/tests.h>
+#undef CALL
 	test_pkt_access();
 	test_prog_run_xattr();
 	test_xdp();
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
new file mode 100644
index 000000000000..8b79ab3e3042
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <time.h>
+#include <signal.h>
+
+#include <linux/types.h>
+typedef __u16 __sum16;
+#include <arpa/inet.h>
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
+#include <linux/filter.h>
+#include <linux/perf_event.h>
+#include <linux/unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <linux/bpf.h>
+#include <linux/err.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "test_iptunnel_common.h"
+#include "bpf_util.h"
+#include "bpf_endian.h"
+#include "bpf_rlimit.h"
+#include "trace_helpers.h"
+#include "flow_dissector_load.h"
+
+extern int error_cnt, pass_cnt;
+extern bool jit_enabled;
+
+#define MAGIC_BYTES 123
+
+/* ipv4 test vector */
+struct ipv4_packet {
+	struct ethhdr eth;
+	struct iphdr iph;
+	struct tcphdr tcp;
+} __packed;
+extern struct ipv4_packet pkt_v4;
+
+/* ipv6 test vector */
+struct ipv6_packet {
+	struct ethhdr eth;
+	struct ipv6hdr iph;
+	struct tcphdr tcp;
+} __packed;
+extern struct ipv6_packet pkt_v6;
+
+#define _CHECK(condition, tag, duration, format...) ({			\
+	int __ret = !!(condition);					\
+	if (__ret) {							\
+		error_cnt++;						\
+		printf("%s:FAIL:%s ", __func__, tag);			\
+		printf(format);						\
+	} else {							\
+		pass_cnt++;						\
+		printf("%s:PASS:%s %d nsec\n", __func__, tag, duration);\
+	}								\
+	__ret;								\
+})
+
+#define CHECK(condition, tag, format...) \
+	_CHECK(condition, tag, duration, format)
+#define CHECK_ATTR(condition, tag, format...) \
+	_CHECK(condition, tag, tattr.duration, format)
+
+int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

