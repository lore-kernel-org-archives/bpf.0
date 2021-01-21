Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0D9C433E6
	for <bpf@archiver.kernel.org>; Thu, 21 Jan 2021 13:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D4723A01
	for <bpf@archiver.kernel.org>; Thu, 21 Jan 2021 13:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbhAUNQM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Jan 2021 08:16:12 -0500
Received: from m12-16.163.com ([220.181.12.16]:46562 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731713AbhAUNPN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 08:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lkb1q
        Vmo7U5P0SiEDkgTa5XtLyFBC6cAE0sJIZKORts=; b=e9bop/+4punTXPQSZbyPD
        pi4bqmkwouovsCujztsJRD1tD0nakKaK/oit0R8Eg4SIkudTgTdL4j0NBoSha8mg
        sSEAqgXN5ArifuPGlX3iaVfZga+rPd3nye/ImFsvlUGeqY1DFmLB4MjFwEnOJh9l
        o0akEbz/i/UyBXUX2h0RCs=
Received: from yangjunlin.ccdomain.com (unknown [119.137.55.77])
        by smtp12 (Coremail) with SMTP id EMCowADX74+icglg1sTIYA--.35003S2;
        Thu, 21 Jan 2021 20:25:08 +0800 (CST)
From:   angkery <angkery@163.com>
To:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     bpf@vger.kernel.org, Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH bpf-next] selftest/bpf: fix typo
Date:   Thu, 21 Jan 2021 20:23:09 +0800
Message-Id: <20210121122309.1501-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADX74+icglg1sTIYA--.35003S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1DJw4fKw43Ww1kJF43Jrb_yoWfuwbEva
        1xtr1vvFWkAFs5tr1UC3Z8WFW8GayUWrZrArnrtry3XryjqF4DJF4v9r1fZayrW3yftaya
        gF4kt393tw43KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeA-BtUUUUU==
X-Originating-IP: [119.137.55.77]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/xtbCBhQhI13I0eWg3gAAsP
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

Change 'exeeds' to 'exceeds'.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
v1: resend this patch with Cc

 tools/testing/selftests/bpf/prog_tests/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 8ae97e2..ea008d0 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -914,7 +914,7 @@ struct btf_raw_test {
 	.err_str = "Member exceeds struct_size",
 },
 
-/* Test member exeeds the size of struct
+/* Test member exceeds the size of struct
  *
  * struct A {
  *     int m;
@@ -948,7 +948,7 @@ struct btf_raw_test {
 	.err_str = "Member exceeds struct_size",
 },
 
-/* Test member exeeds the size of struct
+/* Test member exceeds the size of struct
  *
  * struct A {
  *     int m;
-- 
1.9.1


