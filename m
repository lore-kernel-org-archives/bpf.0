Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647BDC4360F
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312B8218B0
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="JqfF359v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfB0XbO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:31:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46033 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbfB0XbN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 18:31:13 -0500
Received: by mail-qk1-f194.google.com with SMTP id v139so10970232qkb.12
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 15:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqKbId797bI7TH6lf2Cv2ChdSR49MOADR2ozK2f5nMM=;
        b=JqfF359vrjRbmdknD3QgapIFSNAk8mSHxmRQk0swg/plVdtEF6xdoewP0MdsIFSLND
         IAkJpmnrD6hviOcNbgWMsaPIvAfmSzJcycVmqb1sPTmQKwcs6Mj8xThnjdYkqbep5O/h
         +nbqRHtOHBElm7AutpZ0JMbrQE7FUiwl765k2dSD2ncvOiEKjT4ma0qUJ49GxN62xcHh
         0YxALxW7XN/le+Vk3P28zQN7UIkYRcdIYsrJyTIuVywvEZAcn2gt/iJyWObOlyDxa00J
         ZYCC4iUhMOk3kXC4yN9H9e1mu6OHt6KhgXmTkZUZqWgUNzZKJZMCBT4FJPDzlPAK+6JG
         337g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqKbId797bI7TH6lf2Cv2ChdSR49MOADR2ozK2f5nMM=;
        b=DMytP1erwUTgCUb9T7y+hpOphIdIwl2pb1tU5mmfVClMygLO7ACEIQHGw2kSnadXRU
         f88ju5zA8GJlvwtDNKNQQpItDewWMip0JgujHyoPx5ZxcMbbaqH0+Q1mDqaA6hq58Cxe
         /cnC5EQTEO2smO6t4xxPKWyWzxO7t+vOqxYipuTK3QwENdVFuVf1TAscH/Os2xOTgu55
         2FbdhDpEQ9EoKFVrGPakT9nI84yiYBnG0RjDDAtiuoZVnJfxDXcQI/T/unRY0cqdwttN
         pTcjgi39/DZrll32keicGyBPSA/69TdgUuUIT41taGkK7khq7ciCcgQ2ekSZH77UOXYi
         2rQw==
X-Gm-Message-State: APjAAAVX44lOcUfcroePu9oWzHj8/rYDmbOfAWzi5SEI3NKFCS5w3Ju3
        gyoAyFk/oe5NLb7skfd0Clpo8g==
X-Google-Smtp-Source: AHgI3Iax54qI9JVOUyhK1ME+Ybe4m1jrHqWiQo5577Jjen4DoJZlXQwyJMbB9sLBjGQdHRX/eMlDHA==
X-Received: by 2002:a05:620a:136d:: with SMTP id d13mr4380795qkl.256.1551310271696;
        Wed, 27 Feb 2019 15:31:11 -0800 (PST)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z28sm11509741qth.85.2019.02.27.15.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 15:31:11 -0800 (PST)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next 4/5] samples: bpf: use libbpf where easy
Date:   Wed, 27 Feb 2019 15:30:45 -0800
Message-Id: <20190227233046.11718-5-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190227233046.11718-1-jakub.kicinski@netronome.com>
References: <20190227233046.11718-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some samples don't really need the magic of bpf_load,
switch them to libbpf.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
---
 samples/bpf/Makefile       |  6 +++---
 samples/bpf/fds_example.c  |  9 ++++++---
 samples/bpf/sockex1_user.c | 22 ++++++++++++----------
 samples/bpf/sockex2_user.c | 20 +++++++++++---------
 4 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4dd98100678e..0c62ac39c697 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -59,9 +59,9 @@ LIBBPF = $(TOOLS_PATH)/lib/bpf/libbpf.a
 CGROUP_HELPERS := ../../tools/testing/selftests/bpf/cgroup_helpers.o
 TRACE_HELPERS := ../../tools/testing/selftests/bpf/trace_helpers.o
 
-fds_example-objs := bpf_load.o fds_example.o
-sockex1-objs := bpf_load.o sockex1_user.o
-sockex2-objs := bpf_load.o sockex2_user.o
+fds_example-objs := fds_example.o
+sockex1-objs := sockex1_user.o
+sockex2-objs := sockex2_user.o
 sockex3-objs := bpf_load.o sockex3_user.o
 tracex1-objs := bpf_load.o tracex1_user.o
 tracex2-objs := bpf_load.o tracex2_user.o
diff --git a/samples/bpf/fds_example.c b/samples/bpf/fds_example.c
index 9854854f05d1..36f1f18aae3c 100644
--- a/samples/bpf/fds_example.c
+++ b/samples/bpf/fds_example.c
@@ -14,8 +14,8 @@
 
 #include <bpf/bpf.h>
 
+#include "bpf/libbpf.h"
 #include "bpf_insn.h"
-#include "bpf_load.h"
 #include "sock_example.h"
 
 #define BPF_F_PIN	(1 << 0)
@@ -57,10 +57,13 @@ static int bpf_prog_create(const char *object)
 		BPF_EXIT_INSN(),
 	};
 	size_t insns_cnt = sizeof(insns) / sizeof(struct bpf_insn);
+	char bpf_log_buf[BPF_LOG_BUF_SIZE];
+	struct bpf_object *obj;
+	int prog_fd;
 
 	if (object) {
-		assert(!load_bpf_file((char *)object));
-		return prog_fd[0];
+		assert(!bpf_prog_load(object, 0, &obj, &prog_fd));
+		return prog_fd;
 	} else {
 		return bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER,
 					insns, insns_cnt, "GPL", 0,
diff --git a/samples/bpf/sockex1_user.c b/samples/bpf/sockex1_user.c
index be8ba5686924..5e7c4be3e645 100644
--- a/samples/bpf/sockex1_user.c
+++ b/samples/bpf/sockex1_user.c
@@ -3,28 +3,30 @@
 #include <assert.h>
 #include <linux/bpf.h>
 #include <bpf/bpf.h>
-#include "bpf_load.h"
+#include "bpf/libbpf.h"
 #include "sock_example.h"
 #include <unistd.h>
 #include <arpa/inet.h>
 
 int main(int ac, char **argv)
 {
+	struct bpf_object *obj;
+	int map_fd, prog_fd;
 	char filename[256];
-	FILE *f;
 	int i, sock;
+	FILE *f;
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
 
-	if (load_bpf_file(filename)) {
-		printf("%s", bpf_log_buf);
+	if (bpf_prog_load(filename, 0, &obj, &prog_fd))
 		return 1;
-	}
+
+	map_fd = bpf_object__find_map_fd_by_name(obj, "my_map");
 
 	sock = open_raw_sock("lo");
 
-	assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, prog_fd,
-			  sizeof(prog_fd[0])) == 0);
+	assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, &prog_fd,
+			  sizeof(prog_fd)) == 0);
 
 	f = popen("ping -4 -c5 localhost", "r");
 	(void) f;
@@ -34,13 +36,13 @@ int main(int ac, char **argv)
 		int key;
 
 		key = IPPROTO_TCP;
-		assert(bpf_map_lookup_elem(map_fd[0], &key, &tcp_cnt) == 0);
+		assert(bpf_map_lookup_elem(map_fd, &key, &tcp_cnt) == 0);
 
 		key = IPPROTO_UDP;
-		assert(bpf_map_lookup_elem(map_fd[0], &key, &udp_cnt) == 0);
+		assert(bpf_map_lookup_elem(map_fd, &key, &udp_cnt) == 0);
 
 		key = IPPROTO_ICMP;
-		assert(bpf_map_lookup_elem(map_fd[0], &key, &icmp_cnt) == 0);
+		assert(bpf_map_lookup_elem(map_fd, &key, &icmp_cnt) == 0);
 
 		printf("TCP %lld UDP %lld ICMP %lld bytes\n",
 		       tcp_cnt, udp_cnt, icmp_cnt);
diff --git a/samples/bpf/sockex2_user.c b/samples/bpf/sockex2_user.c
index 125ee6efc913..e3611dbfce97 100644
--- a/samples/bpf/sockex2_user.c
+++ b/samples/bpf/sockex2_user.c
@@ -3,7 +3,7 @@
 #include <assert.h>
 #include <linux/bpf.h>
 #include <bpf/bpf.h>
-#include "bpf_load.h"
+#include "bpf/libbpf.h"
 #include "sock_example.h"
 #include <unistd.h>
 #include <arpa/inet.h>
@@ -17,22 +17,24 @@ struct pair {
 int main(int ac, char **argv)
 {
 	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
+	struct bpf_object *obj;
+	int map_fd, prog_fd;
 	char filename[256];
-	FILE *f;
 	int i, sock;
+	FILE *f;
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
 	setrlimit(RLIMIT_MEMLOCK, &r);
 
-	if (load_bpf_file(filename)) {
-		printf("%s", bpf_log_buf);
+	if (bpf_prog_load(filename, 0, &obj, &prog_fd))
 		return 1;
-	}
+
+	map_fd = bpf_object__find_map_fd_by_name(obj, "hash_map");
 
 	sock = open_raw_sock("lo");
 
-	assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, prog_fd,
-			  sizeof(prog_fd[0])) == 0);
+	assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, &prog_fd,
+			  sizeof(prog_fd)) == 0);
 
 	f = popen("ping -4 -c5 localhost", "r");
 	(void) f;
@@ -41,8 +43,8 @@ int main(int ac, char **argv)
 		int key = 0, next_key;
 		struct pair value;
 
-		while (bpf_map_get_next_key(map_fd[0], &key, &next_key) == 0) {
-			bpf_map_lookup_elem(map_fd[0], &next_key, &value);
+		while (bpf_map_get_next_key(map_fd, &key, &next_key) == 0) {
+			bpf_map_lookup_elem(map_fd, &next_key, &value);
 			printf("ip %s bytes %lld packets %lld\n",
 			       inet_ntoa((struct in_addr){htonl(next_key)}),
 			       value.bytes, value.packets);
-- 
2.19.2

