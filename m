Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C12FC433E0
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD51207ED
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664174;
	bh=7qRrtypSSmzWLdDkp9783c/owwEwmGd/9SP07NiOk2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WnHRaD6pik+5M9Ow1848dp3BJS4u0JgJ5ks639hcaCWuzXj02JmWk5k6N7EN4cf5G
	 g7/3V4NrMmXkjjnhXskJbcIcNvT3oAWJAeyaZRyBoBmP1q8Yqj6XzzfZ0up6sgNcXj
	 TtOo3TWxM+F/YNSjzktJMLNgKUamqS8FnU7C5RsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgFIA4G (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbgFHXJI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 19:09:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D81F208C9;
        Mon,  8 Jun 2020 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657748;
        bh=7qRrtypSSmzWLdDkp9783c/owwEwmGd/9SP07NiOk2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPOGdBSXEHTJ9BjQyX7JAFlmdStNtE5CcFM/TDR0O77+gY9WGx6XW2W5FUIZMc+1Q
         H8SG7qjhA0L8Wnp3gQMk5YPjGbJfC9XX7VsBqKo7/2x7FWwPY3/G8Md/g8Ygi5hT8F
         o8IloG+sZrYZ1sXXNAt1yf8YYXeaL7kzynH/QAHU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 135/274] selftests/bpf: Add runqslower binary to .gitignore
Date:   Mon,  8 Jun 2020 19:03:48 -0400
Message-Id: <20200608230607.3361041-135-sashal@kernel.org>
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

[ Upstream commit e4e8f4d047fdcf7ac7d944e266e85d8041f16cd6 ]

With recent changes, runqslower is being copied into selftests/bpf root
directory. So add it into .gitignore.

Fixes: b26d1e2b6028 ("selftests/bpf: Copy runqslower to OUTPUT directory")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Cc: Veronika Kabatova <vkabatov@redhat.com>
Link: https://lore.kernel.org/bpf/20200429012111.277390-12-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index c30079c86998..35a577ca0226 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -39,4 +39,4 @@ test_cpp
 /no_alu32
 /bpf_gcc
 /tools
-
+/runqslower
-- 
2.25.1

