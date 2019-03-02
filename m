Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC49C00319
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654712084D
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkgGsUV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfCBDm0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:42:26 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:33266 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfCBDm0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 22:42:26 -0500
Received: by mail-io1-f74.google.com with SMTP id e1so2658157iog.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 19:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NlZEWNKKrXOJWPwiZWs5V+Ng5P/U+WbqMLEcyEbrNq8=;
        b=GkgGsUV4zXnXObIKdjGbB6rhLXpXHtV6uCTkoAgWZKMT1TvV5/eeoix0s/Cwvjcl9x
         IEyfnQoL564rW6nX2kEUz9tMcbClCUte85qJyNXdaJ2CVAoDQT+BaLFqVuNYjSSVomi2
         Usrw5qxSDSgSaiN0spCCVogWWVhScxXmj4ZkIZcdgvNd//psEVu/yzihJPwhfTkUahyd
         yQFCUKEDsmYxeoEBczuSnq6jTaJ9JXIDVSH++SATyUc8dSAWWMiPe5DYVUqvqLQTsIhs
         lrmHfGzc9hlZqvmJUCVbfRHvNVOlKh3Iv6nEvRsawLdrhvCW6Nf8JxwxbDBHupCC9EAn
         jmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NlZEWNKKrXOJWPwiZWs5V+Ng5P/U+WbqMLEcyEbrNq8=;
        b=psgUiADLgNwY0Ag87bmpEoT6E9+91GiZBsio4H15Dam00vFljMWqMaHS2DDRdM4Pye
         fwIeh3rjWJPd0Mlnoo4GrcJWwjpw/aF5ztRl4HIVfLL0rC67BHruzAjUCJXoU9c4pYE4
         BGB7JigtcERlZ1PEFw7uYmiMLIkSTxdq9073INx+W3KJOFybl5q7a87GlUJrigaJn/KF
         tq2NifiNHLmdU8nxw1ZriauCzQdo5Q3/SI+ToEETEs2bGN+BqXX1bqV2MlWFUbTjj7Hu
         kqbJ1woRSg+WJSV8GkXjvdTkTVqoYaN4TCwEnwg9RsBsB7kYmSGyy+wEWFhELGWzwv7L
         8u/Q==
X-Gm-Message-State: AHQUAuZ4RoTihU5hkVmxNu9F/QCWelADdQ6b6lb/sCjIEeZzdiIk1fuH
        YLbX9Y+MSi1kb0wVVXL7myBfnDs=
X-Google-Smtp-Source: APXvYqy9fF68ggTgFURfLnUx2PVYputMyMnwZ1zvyDJueEOcNpqBrPDBPdJg79NiY6GohRXVZkOupT8=
X-Received: by 2002:a24:75d6:: with SMTP id y205mr5297591itc.36.1551498145191;
 Fri, 01 Mar 2019 19:42:25 -0800 (PST)
Date:   Fri,  1 Mar 2019 19:42:13 -0800
In-Reply-To: <20190302034219.99480-1-sdf@google.com>
Message-Id: <20190302034219.99480-2-sdf@google.com>
Mime-Version: 1.0
References: <20190302034219.99480-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH bpf-next v3 1/7] selftests: bpf: break up test_progs - preparations
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
 tools/testing/selftests/bpf/test_progs.c      | 87 +++----------------
 tools/testing/selftests/bpf/test_progs.h      | 80 +++++++++++++++++
 4 files changed, 119 insertions(+), 76 deletions(-)
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
index 87cde42559f7..e3f74fb617c1 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -4,57 +4,13 @@
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
+#include "test_progs.h"
 #include "bpf_rlimit.h"
-#include "trace_helpers.h"
-#include "flow_dissector_load.h"
 
-static int error_cnt, pass_cnt;
-static bool jit_enabled;
+int error_cnt, pass_cnt;
+bool jit_enabled;
 
-#define MAGIC_BYTES 123
-
-/* ipv4 test vector */
-static struct {
-	struct ethhdr eth;
-	struct iphdr iph;
-	struct tcphdr tcp;
-} __packed pkt_v4 = {
+struct ipv4_packet pkt_v4 = {
 	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
 	.iph.ihl = 5,
 	.iph.protocol = IPPROTO_TCP,
@@ -63,12 +19,7 @@ static struct {
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
@@ -76,26 +27,7 @@ static struct {
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
 
@@ -2150,12 +2082,19 @@ static void test_signal_pending(enum bpf_prog_type prog_type)
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
index 000000000000..658efa080fc0
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -0,0 +1,80 @@
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
2.21.0.352.gf09ad66450-goog

