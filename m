Return-Path: <SRS0=QYSm=4V=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1858C3F2D8
	for <bpf@archiver.kernel.org>; Wed,  4 Mar 2020 17:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2C8217F4
	for <bpf@archiver.kernel.org>; Wed,  4 Mar 2020 17:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="l6Wpe5nh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgCDRxS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:53:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728926AbgCDRxS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Mar 2020 12:53:18 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 024HfOxH010783
        for <bpf@vger.kernel.org>; Wed, 4 Mar 2020 09:53:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ULjG0Zs7Ohs+VUvwJPU9BJVTL6qHs9niwzIbtnwy8qA=;
 b=l6Wpe5nh3Cxe5AdBvS0c8uQoQvYnrSrsWTT0V3KuBI8jardd3KwAdZJB4TVbiU8Jy3JC
 H/xP0ApazpLDAKTCmxsxPufhayY4vHstjPxTVWTU86D0ntDucZ081LKFFopTKwJAy3pn
 5X3wp30vT2HJVlJapfs0rUs2oLIUsN+Mrhc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2yhv7vpcks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 09:53:16 -0800
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 09:53:15 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B3E4C37010C5; Wed,  4 Mar 2020 09:53:11 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf v2 2/2] selftests/bpf: add send_signal_sched_switch test
Date:   Wed, 4 Mar 2020 09:53:11 -0800
Message-ID: <20200304175311.2389987-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304175310.2389842-1-yhs@fb.com>
References: <20200304175310.2389842-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_07:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 spamscore=0 suspectscore=38
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040123
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added one test, send_signal_sched_switch, to test bpf_send_signal()
helper triggered by sched/sched_switch tracepoint. This test can be used
to verify kernel deadlocks fixed by the previous commit. The test itself
is heavily borrowed from Commit eac9153f2b58 ("bpf/stackmap: Fix deadlock
with rq_lock in bpf_get_stack()").

Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/prog_tests/send_signal_sched_switch.c | 89 +++++++++++++++++++
 .../bpf/progs/test_send_signal_kern.c         |  6 ++
 2 files changed, 95 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
new file mode 100644
index 000000000000..f5c9dbdeb173
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <pthread.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include "test_send_signal_kern.skel.h"
+
+static void sigusr1_handler(int signum)
+{
+}
+
+#define THREAD_COUNT 100
+
+static char *filename;
+
+static void *worker(void *p)
+{
+	int err, fd, i = 0;
+	u32 duration = 0;
+	char *pptr;
+	void *ptr;
+
+	fd = open(filename, O_RDONLY);
+	if (CHECK(fd < 0, "open", "open failed %s\n", strerror(errno)))
+		return NULL;
+
+	while (i < 100) {
+		struct timespec ts = {0, 1000 + rand() % 2000};
+
+		ptr = mmap(NULL, 4096 * 64, PROT_READ, MAP_PRIVATE, fd, 0);
+		err = errno;
+		usleep(1);
+		if (CHECK(ptr == MAP_FAILED, "mmap", "mmap failed: %s\n",
+			  strerror(err)))
+			break;
+
+		munmap(ptr, 4096 * 64);
+		usleep(1);
+		pptr = malloc(1);
+		usleep(1);
+		pptr[0] = 1;
+		usleep(1);
+		free(pptr);
+		usleep(1);
+		nanosleep(&ts, NULL);
+		i++;
+	}
+	close(fd);
+	return NULL;
+}
+
+void test_send_signal_sched_switch(void)
+{
+	struct test_send_signal_kern *skel;
+	pthread_t threads[THREAD_COUNT];
+	u32 duration = 0;
+	int i, err;
+
+	filename = "/bin/ls";
+	signal(SIGUSR1, sigusr1_handler);
+
+	skel = test_send_signal_kern__open_and_load();
+	if (CHECK(!skel, "skel_open_and_load", "skeleton open_and_load failed\n"))
+		return;
+
+	skel->bss->pid = getpid();
+	skel->bss->sig = SIGUSR1;
+
+	err = test_send_signal_kern__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed\n"))
+		goto destroy_skel;
+
+	for (i = 0; i < THREAD_COUNT; i++) {
+		err = pthread_create(threads + i, NULL, worker, NULL);
+		if (CHECK(err, "pthread_create", "Error creating thread, %s\n",
+			  strerror(errno)))
+			goto destroy_skel;
+	}
+
+	for (i = 0; i < THREAD_COUNT; i++)
+		pthread_join(threads[i], NULL);
+
+destroy_skel:
+	test_send_signal_kern__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
index 1acc91e87bfc..b4233d3efac2 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -31,6 +31,12 @@ int send_signal_tp(void *ctx)
 	return bpf_send_signal_test(ctx);
 }
 
+SEC("tracepoint/sched/sched_switch")
+int send_signal_tp_sched(void *ctx)
+{
+	return bpf_send_signal_test(ctx);
+}
+
 SEC("perf_event")
 int send_signal_perf(void *ctx)
 {
-- 
2.17.1

