Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B02BC10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 22:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352622183E
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 22:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSkGNb3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbfDXWQR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:16:17 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35317 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbfDXWQQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 18:16:16 -0400
Received: by mail-it1-f196.google.com with SMTP id w15so9001260itc.0;
        Wed, 24 Apr 2019 15:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/X2+gPGJ9ZFZD59k8pGKNq0xZhU2+CJbfDZcIB99FqI=;
        b=qSkGNb3SWdl0DC49BmnIJsi/vcK1gzQ5pcpaHYuE1Y0quojKIQm/ormdP+uB7uffTp
         1noG66Tn47UA+0FONK8EBSTf/WCincE//kOU+P01mBaw2DqRPnPrBXXgPELbQuP7GZxO
         aRlVO29rKlvYLMUXmWOF+B+bLfK5BFuAk5Tcf1Hlx2od5nmRUP2Ye/iC/7i2VG+/m8gL
         DTJX3KBFgZMezOMWBBHKAF/HdpsQLqPvwmHWDhBRiIfbBDNhrDK1gkBhogd5WM0XtIIc
         dxZR1oQW24bKjwNbBuyptd6cI8952XVB+WCNwoswBHjnY3BVuC+pLtiYRLNHEC5hf6v5
         A9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=/X2+gPGJ9ZFZD59k8pGKNq0xZhU2+CJbfDZcIB99FqI=;
        b=gv2yj9FlljxyC8vLsQgII42ETqW5NLj0ySPe3V5WFizARYSqktGStB5Z+YbBbqxEXX
         8wcTjoGGPGFGwJuVCD/5DlMsOgRcggn1CBwcAt8n86OYvOaJYVWUck7VGWvt9RPR0zPt
         6+cNVeZqjfT0ooMm+P8oqC9x925E9CbN+wdXXET22D96J2HO27KAQQ6gSOCe2damrKAz
         UZ84ctIOfAnz4SNL6QDPzeeS7hxGL6f4h9W8rveQgooyurIX2x88HO+6WSBH3xs/PWn2
         xFBBruTNTJQGEhdYDXMxjlH9xb2YvYhrWMN2fPloxGBrUJZ0ZikmlLhYfJXxGEe437P9
         1ntw==
X-Gm-Message-State: APjAAAWKve9UIMpBXlCEILqswiIM9yJ8l9CZgTEJMFc8/PkvaAprwe9H
        Mg/Ib+FAy/yYtn34awkGVt/DvOOkADY=
X-Google-Smtp-Source: APXvYqwYuv2Hq0DUHaFVWpggIjic672hgGx8fsRnnFqkrab3KHJlmy1tuyXnU39gGDpVTKjpmH0cCQ==
X-Received: by 2002:a05:660c:38a:: with SMTP id x10mr1266461itj.12.1556144175679;
        Wed, 24 Apr 2019 15:16:15 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id n17sm10250048itn.31.2019.04.24.15.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:16:15 -0700 (PDT)
Subject: [bpf-next PATCH] bpf: sockmap, test tool support to skip cgroup arg
From:   John Fastabend <john.fastabend@gmail.com>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Wed, 24 Apr 2019 15:16:05 -0700
Message-ID: <155614416551.29379.12486744636513956469.stgit@john-XPS-13-9360>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Its handy to not have to setup a cgroup environment when running
test_sockmap with user specified options. This patch setups a cgroup
environment, similar to how it is done with the auto test suite, when
the user does not provide a cgroup arg.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/test_sockmap.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 3845144e2c91..11dfb1f10e15 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1734,6 +1734,7 @@ int main(int argc, char **argv)
 	int opt, longindex, err, cg_fd = 0;
 	char *bpf_file = BPF_SOCKMAP_FILENAME;
 	int test = PING_PONG;
+	bool cleanup = true;
 
 	if (argc < 2)
 		return test_suite(-1);
@@ -1773,6 +1774,7 @@ int main(int argc, char **argv)
 					cg_fd, optarg);
 				return cg_fd;
 			}
+			cleanup = false;
 			break;
 		case 'r':
 			rate = atoi(optarg);
@@ -1818,9 +1820,23 @@ int main(int argc, char **argv)
 		return test_suite(cg_fd);
 
 	if (!cg_fd) {
-		fprintf(stderr, "%s requires cgroup option: --cgroup <path>\n",
-			argv[0]);
-		return -1;
+		if (setup_cgroup_environment()) {
+			fprintf(stderr, "ERROR: cgroup env failed\n");
+			return -EINVAL;
+		}
+
+		cg_fd = create_and_get_cgroup(CG_PATH);
+		if (cg_fd < 0) {
+			fprintf(stderr,
+				"ERROR: (%i) open cg path failed: %s\n",
+				cg_fd, optarg);
+			return cg_fd;
+		}
+
+		if (join_cgroup(CG_PATH)) {
+			fprintf(stderr, "ERROR: failed to join cgroup\n");
+			return -EINVAL;
+		}
 	}
 
 	err = populate_progs(bpf_file);
@@ -1839,6 +1855,8 @@ int main(int argc, char **argv)
 	options.rate = rate;
 
 	err = run_options(&options, cg_fd, test);
+	if (cleanup)
+		cleanup_cgroup_environment();
 	close(cg_fd);
 	return err;
 }

