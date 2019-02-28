Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAF9C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843482085A
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gFn42wyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfB1XYs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:24:48 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50170 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfB1XYr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 18:24:47 -0500
Received: by mail-pf1-f201.google.com with SMTP id y66so17294060pfg.16
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FUG1vM5DMcYWODBLLXLJu17d9Qu04MNKFtnd7smkjuw=;
        b=gFn42wyJGkatztrkF40wjaoAf9aSKX4FcpyZU1lDeRgeWVEBPrDU/DfH3jYfSWSt9A
         wISOUybbSxygn/VfpkhA17gviH5Q83NaSC7qdYMBf9Ust9aOpw/EpJIEIqmjY95uAI8z
         o4T1iHw5iHOppDfSTPYxK7867oxZ7+FhHfPdhIdBXMQxCLgJl9cTh0WQR3IL3kFc5fy1
         52Ur2/QCt+7Pz3zBG0ppg1cANcI0p68VqwLPvck1zBcWTNdEMV9MHQaTfnCEvBKRCZOg
         pibQn9epHfRK9QokwHGLNuu8uo0qoenysjaGb5V1oWCTh8BCdxi8BPgp/qtzOwTK2WoX
         hINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FUG1vM5DMcYWODBLLXLJu17d9Qu04MNKFtnd7smkjuw=;
        b=YqnVKFMu7NPX3c74Nx13Yfg3w0FAS6XHLWxTTbz5L7ee/sA6Y7zEh/jrhfvhOjoNSr
         lCBvoKfbQfRiWOZSyjtFlOzTF/8ePJ5lgxt2wa2fq45rV+9zXIqWA/m+BUjxNl8BoUMY
         1zu0lvlTjeXAt+prUdDFTFgXf03W/crNs0mwGKo6odQmx15HdjcP0OXgQ5i/YpVjLqPM
         vUmmfHEJqoRYmecg/B8nSUoot0p/dLsVXn7Lh4GupJM8Y43PpI0Cs3/X9Z68UevYbbqY
         1SmpyjMGvoPD9Zw1BbL1ci3fZHwdqQM41XuR5iMoN6zhqn6MCud1VKi/4HBBRJ2v06G/
         yyoA==
X-Gm-Message-State: AHQUAuaptcuYQZxkLRLqfEkE2NjTP2bzQwqwI6zbIHQCP+EhEQug356a
        /RMLKdgdr3F4KikWv99WxoGcSQA=
X-Google-Smtp-Source: APXvYqxnvoxcwj6lBnvlFnDLsBOKCoD9CRBRAhepZ0kZ5L98PPXZEe2v1g0ZCFoRHBqXWeHdNOqnhLQ=
X-Received: by 2002:a62:b50f:: with SMTP id y15mr975731pfe.131.1551396286720;
 Thu, 28 Feb 2019 15:24:46 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:24:34 -0800
In-Reply-To: <20190228232440.28668-1-sdf@google.com>
Message-Id: <20190228232440.28668-2-sdf@google.com>
Mime-Version: 1.0
References: <20190228232440.28668-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH bpf-next v2 1/7] selftests: bpf: break up test_progs - preparations
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new prog_tests directory where tests are supposed to land.
Each prog_tests/<filename>.c is expected to have a global function
with signature 'void test_<filename>(void)'. Makefile automatically
generates prog_tests/tests.h file with entry for each prog_tests file:

	#ifdef DECLARE
	extern void test_<filename>(void);
	...
	#endif

	#ifdef CALL
	test_<filename>();
	...
	#endif

prog_tests/tests.h is included in test_progs.c in two places with
appropriate defines. This scheme allows us to move each function with
a separate patch without breaking anything.

Compared to the recent verifier split, each separate file here is
a compilation unit and test_progs.[ch] is now used as a place to put
some common routines that might be used by multiple tests.

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

