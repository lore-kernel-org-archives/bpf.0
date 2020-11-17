Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4A9C63798
	for <bpf@archiver.kernel.org>; Tue, 17 Nov 2020 13:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62AA2225B
	for <bpf@archiver.kernel.org>; Tue, 17 Nov 2020 13:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG9dmclk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgKQM46 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 17 Nov 2020 07:56:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgKQM46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 07:56:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B422225E;
        Tue, 17 Nov 2020 12:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605617817;
        bh=zb0Ime6XI530MGXlEJNwNAMm6EzzeWNku9TaSwKyjMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BG9dmclkYQ4HTTzhANzK7vm0QpTNS4/bOrP9JHnLuwD31E4+merD7sxgDPRmcaIje
         MDB+XFit18iB9taf/wsSKkJDBBMdBVdjr3ikTR7Meb+KcensRjr5kvGehfBRZk+1g0
         fdyAKmzgq08dBHqdQwkEcIHL3IlSvhh7vyWdJrQQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.9 02/21] tools, bpftool: Avoid array index warnings.
Date:   Tue, 17 Nov 2020 07:56:33 -0500
Message-Id: <20201117125652.599614-2-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201117125652.599614-1-sashal@kernel.org>
References: <20201117125652.599614-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Ian Rogers <irogers@google.com>

[ Upstream commit 1e6f5dcc1b9ec9068f5d38331cec38b35498edf5 ]

The bpf_caps array is shorter without CAP_BPF, avoid out of bounds reads
if this isn't defined. Working around this avoids -Wno-array-bounds with
clang.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Tobias Klauser <tklauser@distanz.ch>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20201027233646.3434896-1-irogers@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/feature.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index a43a6f10b564c..359960a8f1def 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -843,9 +843,14 @@ static int handle_perms(void)
 		else
 			p_err("missing %s%s%s%s%s%s%s%srequired for full feature probing; run as root or use 'unprivileged'",
 			      capability_msg(bpf_caps, 0),
+#ifdef CAP_BPF
 			      capability_msg(bpf_caps, 1),
 			      capability_msg(bpf_caps, 2),
-			      capability_msg(bpf_caps, 3));
+			      capability_msg(bpf_caps, 3)
+#else
+				"", "", "", "", "", ""
+#endif /* CAP_BPF */
+				);
 		goto exit_free;
 	}
 
-- 
2.27.0

