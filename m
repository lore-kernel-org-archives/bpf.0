Return-Path: <SRS0=dkA9=CC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AECC433E1
	for <bpf@archiver.kernel.org>; Mon, 24 Aug 2020 16:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE4922DBF
	for <bpf@archiver.kernel.org>; Mon, 24 Aug 2020 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598287077;
	bh=elLIwk+vXIz3X/dNZdhcxZlWgo/Xj0p8DfSj9gycQNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xpo+djJEGyXOyRvFpw/T2fGTpowdbF2hXpHH1tGz2sSL2NOFtyL3JbKzm1Mn9yZMY
	 6gUFcJbGzP1Tg6Gmo40jyOalfniAvRMBpgxDMyntOW4eJee6tNvz3DguGvOUb4Bqgz
	 MOGZArqc81vVjYHNWXxmyo0IB/zJAoarG9y63qBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgHXQhr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgHXQgx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 12:36:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0AA522B49;
        Mon, 24 Aug 2020 16:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286988;
        bh=elLIwk+vXIz3X/dNZdhcxZlWgo/Xj0p8DfSj9gycQNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yCWE7NgoqdSuzd+hE9k0yfjNDrsSkvYlqJaZpwuWXOralpziX4+Pw3xzIfTfZMLPV
         KILJ1ucjxj+ikjztHMvVGhftJJpqICCqcopL7Sbk1bUxNlxgM7Rb+C1qxXAxHa376Q
         OTDoCVxuuOBCNdJXfsUveCayvZrNtc4Zsl0rkumE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 61/63] bpf: selftests: global_funcs: Check err_str before strstr
Date:   Mon, 24 Aug 2020 12:35:01 -0400
Message-Id: <20200824163504.605538-61-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163504.605538-1-sashal@kernel.org>
References: <20200824163504.605538-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>

[ Upstream commit c210773d6c6f595f5922d56b7391fe343bc7310e ]

The error path in libbpf.c:load_program() has calls to pr_warn()
which ends up for global_funcs tests to
test_global_funcs.c:libbpf_debug_print().

For the tests with no struct test_def::err_str initialized with a
string, it causes call of strstr() with NULL as the second argument
and it segfaults.

Fix it by calling strstr() only for non-NULL err_str.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20200820115843.39454-1-yauheni.kaliuta@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/test_global_funcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index 25b068591e9a4..193002b14d7f6 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -19,7 +19,7 @@ static int libbpf_debug_print(enum libbpf_print_level level,
 	log_buf = va_arg(args, char *);
 	if (!log_buf)
 		goto out;
-	if (strstr(log_buf, err_str) == 0)
+	if (err_str && strstr(log_buf, err_str) == 0)
 		found = true;
 out:
 	printf(format, log_buf);
-- 
2.25.1

