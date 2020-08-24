Return-Path: <SRS0=dkA9=CC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13203C433E4
	for <bpf@archiver.kernel.org>; Mon, 24 Aug 2020 17:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74D02074D
	for <bpf@archiver.kernel.org>; Mon, 24 Aug 2020 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598290021;
	bh=D4wbElo+7hz1YSqoVSQSjLQRgc+PCehuAlFXAJencUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t32z2AjV29ZMQxPqezHQd590DwrfrYdI1OO1Yqd3oiMUkH4Qwf/kHTX/1zBRZ3ikJ
	 XqJ2ig4kWHf2MQHULCR7hWtV6njlBJEXI8qql0mPKv7C1WtlQmzuE7+ESY0hn+qoAM
	 HeBcY3SoHg//WfkRj92WggrgIjo2nEJNLIDPlaqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgHXR06 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbgHXQfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 12:35:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3605520578;
        Mon, 24 Aug 2020 16:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286937;
        bh=D4wbElo+7hz1YSqoVSQSjLQRgc+PCehuAlFXAJencUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzKl6pFC/pHcQm8qWntUTElDsY3u8OWJoxGJtG4yNM4+ZnRxrgwt/J20ZcLhcM3eq
         eWzSccRG2WMDJHAXuMXGiFIQK5RLDFABnmWft5wyq4PoKRlby7K4LRKQM+eq2r9gAO
         2hP/eag/Zas73nT7fsU9rxND45pBNWx+XZHP75DI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 24/63] libbpf: Prevent overriding errno when logging errors
Date:   Mon, 24 Aug 2020 12:34:24 -0400
Message-Id: <20200824163504.605538-24-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163504.605538-1-sashal@kernel.org>
References: <20200824163504.605538-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 23ab656be263813acc3c20623757d3cd1496d9e1 ]

Turns out there were a few more instances where libbpf didn't save the
errno before writing an error message, causing errno to be overridden by
the printf() return and the error disappearing if logging is enabled.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200813142905.160381-1-toke@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 11e4725b8b1c0..e8e88c1ab69de 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3319,10 +3319,11 @@ bpf_object__probe_global_data(struct bpf_object *obj)
 
 	map = bpf_create_map_xattr(&map_attr);
 	if (map < 0) {
-		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+		ret = -errno;
+		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
 		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
-			__func__, cp, errno);
-		return -errno;
+			__func__, cp, -ret);
+		return ret;
 	}
 
 	insns[0].imm = map;
@@ -5775,9 +5776,10 @@ int bpf_program__pin_instance(struct bpf_program *prog, const char *path,
 	}
 
 	if (bpf_obj_pin(prog->instances.fds[instance], path)) {
-		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+		err = -errno;
+		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
 		pr_warn("failed to pin program: %s\n", cp);
-		return -errno;
+		return err;
 	}
 	pr_debug("pinned program '%s'\n", path);
 
-- 
2.25.1

