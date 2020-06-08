Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32C0C433E0
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E7C2076C
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664190;
	bh=tHgLy2WBJHYxlwWYiAqfHC5kG4VoDvhBZLkmec1G7tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KB5IfVszpAi7m2L7bYtCfZ2/sbI8629mUUr2iv//+E3kHVR+Iv4zOD6vug1ydu4hc
	 +2G+RqWKB/mYwrp2DiIJ5azfSgqa0s+xdv+ImzrSjpFXDWwgS0xGayJrdh+mFrJUJG
	 deQIUPseJIe0JzmpYokdV8blGrJ6jmUoEU1ApPdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgFIA43 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgFHXJD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 19:09:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB17120897;
        Mon,  8 Jun 2020 23:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657742;
        bh=tHgLy2WBJHYxlwWYiAqfHC5kG4VoDvhBZLkmec1G7tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjeVo+bgkrSoq4ezmky1uef9fp4JAJpdj6tUG/z9TIXZucAycWCsB8CGzKqun9fFs
         hm1wVkCOQSOP6PXaEW1lTXdPMPtOTNo0C1muRCHJagbSHMbt6eIjVQzeKuLnAE9ca5
         Xxjh/2k2v5LWJR5Mqi05m1bequd4EFmaAXVk3Jxs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 131/274] selftests/bpf: Fix memory leak in extract_build_id()
Date:   Mon,  8 Jun 2020 19:03:44 -0400
Message-Id: <20200608230607.3361041-131-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit 9f56bb531a809ecaa7f0ddca61d2cf3adc1cb81a ]

getline() allocates string, which has to be freed.

Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BUILD_ID")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20200429012111.277390-7-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 86d0020c9eec..93970ec1c9e9 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -351,6 +351,7 @@ int extract_build_id(char *build_id, size_t size)
 		len = size;
 	memcpy(build_id, line, len);
 	build_id[len] = '\0';
+	free(line);
 	return 0;
 err:
 	fclose(fp);
-- 
2.25.1

