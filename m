Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8E7ECAAA1
	for <bpf@archiver.kernel.org>; Tue,  6 Sep 2022 23:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIFXtJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 6 Sep 2022 19:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIFXtI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 19:49:08 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4530491D11
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 16:49:07 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 15-20020a62170f000000b0053e304ef6c0so1596990pfx.6
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 16:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=WXnjmdIZb8SItePycRIoqj321JtXN7AVWGBtHTjKeOI=;
        b=GtnudzK0hHis+uedoR2eU3INqSIm4CJyqWHSu4QpPoX1uOgZamVmEOVJZRPmd+JPd3
         GoRE8JMwjU4JLhh3KFk/87EgsKbYzsSZ1ApOfm/pM8F9sTe2yJfOmGR0mslQqDr9f0Nu
         ElTItpizZ28+/bjno2CB8fbZqD0HrmrpAs5yQeSgqb1VJYiuBDtmn0+QRpiARAUynb9+
         X0FPRzb+JXRVvG5nczy2+V/BKTCExf037Z4TvBa+K+fIF742jrjqtDGG19EPD2dxpzM3
         eqhN1Dr4gp1ai/UqROyseZJsnrXmxD+0Wftl2uVAR6OqbQnqxT4wdyJTR1TqBaJGg79g
         FsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=WXnjmdIZb8SItePycRIoqj321JtXN7AVWGBtHTjKeOI=;
        b=dTyo7AHeFxiblksmNzfTthE138Kxacf1BVmG8e5+Pi7Ea+RJMNqGIKWKK/9NayT62C
         QYe3fDTXAgOvKoLzNFktmNHPgHaCh0mS5IzMrqQCo/3OMS7iomO1OkIyuW6E36sLhaEu
         dDqOis6cfN431Rj1VJllhFdr+9gYNq8q/oon9Xs2OwYPbDj28DOMIB8QEewgBHGCLNIC
         l7OJeQovb2Ry53nq8BYHka0tzvD2vtHB8DvTJ46sPiS65xpx8vX1p/WOgoL7/ZAWsMXV
         3ZEaNUz+pWfz27iBAPWCRLI/C98kspNgdhb3RIrVKFKdhP/YOMCehTQTFrn+uTTsfFnX
         S8WA==
X-Gm-Message-State: ACgBeo2uS6QTAVGEWQmGplSuFg5aeWOwM13C+oQp8CGvKjSbZ8o9Kh0Q
        k/GMAO6MiE7VBV9xIh1uxAt3z8Cl4AKpXf7wX6FhvdmmQXQtYf9ZcftCTS2LqQh6vkqC7lWFn6b
        cAMhWdl4n1C15mDKpPJlE3+4jPxJdQIcRV0z2qiR7zv+GiFStP1lX4Fd0k+n8eqw=
X-Google-Smtp-Source: AA6agR4lCSgB+5xbLX4dig1rty4y4Rhpu/iAeDxuEdRTSoYrxVYe0Tx3u21bWmQlkYb+/U9GQ8wRi8cludwaIA==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:902:f60e:b0:176:73e1:3683 with SMTP
 id n14-20020a170902f60e00b0017673e13683mr929367plg.27.1662508146690; Tue, 06
 Sep 2022 16:49:06 -0700 (PDT)
Date:   Tue,  6 Sep 2022 23:48:47 +0000
In-Reply-To: <cover.1662507638.git.zhuyifei@google.com>
Mime-Version: 1.0
References: <cover.1662507638.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <9b4fc9a27bd52f771b657b4c4090fc8d61f3a6b5.1662507638.git.zhuyifei@google.com>
Subject: [PATCH v2 bpf-next 2/3] selftests/bpf: Deduplicate write_sysctl() to test_progs.c
From:   YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This helper is needed in multiple tests. Instead of copying it over
and over, better to deduplicate this helper to test_progs.c.

test_progs.c is chosen over testing_helpers.c because of this helper's
use of CHECK / ASSERT_*, and the CHECK was modified to use ASSERT_*
so it does not rely on a duration variable.

Suggested-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../bpf/prog_tests/btf_skc_cls_ingress.c      | 20 -------------------
 .../bpf/prog_tests/tcp_hdr_options.c          | 20 -------------------
 tools/testing/selftests/bpf/test_progs.c      | 17 ++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  1 +
 4 files changed, 18 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
index 664ffc0364f4f..7a277035c275b 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
@@ -22,26 +22,6 @@ static __u32 duration;
 
 #define PROG_PIN_FILE "/sys/fs/bpf/btf_skc_cls_ingress"
 
-static int write_sysctl(const char *sysctl, const char *value)
-{
-	int fd, err, len;
-
-	fd = open(sysctl, O_WRONLY);
-	if (CHECK(fd == -1, "open sysctl", "open(%s): %s (%d)\n",
-		  sysctl, strerror(errno), errno))
-		return -1;
-
-	len = strlen(value);
-	err = write(fd, value, len);
-	close(fd);
-	if (CHECK(err != len, "write sysctl",
-		  "write(%s, %s, %d): err:%d %s (%d)\n",
-		  sysctl, value, len, err, strerror(errno), errno))
-		return -1;
-
-	return 0;
-}
-
 static int prepare_netns(void)
 {
 	if (CHECK(unshare(CLONE_NEWNET), "create netns",
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 1fa7720799674..f24436d33cd6f 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -54,26 +54,6 @@ static int create_netns(void)
 	return 0;
 }
 
-static int write_sysctl(const char *sysctl, const char *value)
-{
-	int fd, err, len;
-
-	fd = open(sysctl, O_WRONLY);
-	if (CHECK(fd == -1, "open sysctl", "open(%s): %s (%d)\n",
-		  sysctl, strerror(errno), errno))
-		return -1;
-
-	len = strlen(value);
-	err = write(fd, value, len);
-	close(fd);
-	if (CHECK(err != len, "write sysctl",
-		  "write(%s, %s): err:%d %s (%d)\n",
-		  sysctl, value, err, strerror(errno), errno))
-		return -1;
-
-	return 0;
-}
-
 static void print_hdr_stg(const struct hdr_stg *hdr_stg, const char *prefix)
 {
 	fprintf(stderr, "%s{active:%u, resend_syn:%u, syncookie:%u, fastopen:%u}\n",
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 3561c97701f24..0e9a47f978908 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -943,6 +943,23 @@ int trigger_module_test_write(int write_sz)
 	return 0;
 }
 
+int write_sysctl(const char *sysctl, const char *value)
+{
+	int fd, err, len;
+
+	fd = open(sysctl, O_WRONLY);
+	if (!ASSERT_NEQ(fd, -1, "open sysctl"))
+		return -1;
+
+	len = strlen(value);
+	err = write(fd, value, len);
+	close(fd);
+	if (!ASSERT_EQ(err, len, "write sysctl"))
+		return -1;
+
+	return 0;
+}
+
 #define MAX_BACKTRACE_SZ 128
 void crash_handler(int signum)
 {
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 5fe1365c2bb1e..b090996daee5c 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -384,6 +384,7 @@ int extract_build_id(char *build_id, size_t size);
 int kern_sync_rcu(void);
 int trigger_module_test_read(int read_sz);
 int trigger_module_test_write(int write_sz);
+int write_sysctl(const char *sysctl, const char *value);
 
 #ifdef __x86_64__
 #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
-- 
2.37.2.789.g6183377224-goog

