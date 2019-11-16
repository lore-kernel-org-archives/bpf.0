Return-Path: <SRS0=JBMC=ZI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED25C432C3
	for <bpf@archiver.kernel.org>; Sat, 16 Nov 2019 16:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7E721479
	for <bpf@archiver.kernel.org>; Sat, 16 Nov 2019 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921357;
	bh=Y18yuxI31zdXm3BrZcwrM5f7T94WmOvlXVgoXwJyH2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Msc03/7FGr7ZImBXidwd+C9u084pPNt/VSjUnbe8m3mmvcwaL0jHX39IWNXHiqSM
	 VtTxZxtcgVwT+Ksw9N2DIZe+EBkfYUvRMxCgJL2nq3fASwMRioBBkLRwLi2egE1qeM
	 jKqlir4cdbxLGI3Wx+zLpkv+u2djvkeG+v+pJx+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfKPPnQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:43:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbfKPPnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Nov 2019 10:43:15 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 155632072D;
        Sat, 16 Nov 2019 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918994;
        bh=Y18yuxI31zdXm3BrZcwrM5f7T94WmOvlXVgoXwJyH2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYqYso9iRWZrqG6STem5pJY/5XE9L7FTV7NofiepVXHgFNFcAnHndKCj5cpi+jtPQ
         j3jFE3VzlaYeqZJ0CLewmzP1/LTTXuIqDdACbnxICgVInXNklRA2BYC4w7Nx1BZwMX
         DvUVh03oHIb9UDA2C7u1r+hVyPbSh6dTHNB9alik=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 097/237] tools: bpftool: fix completion for "bpftool map update"
Date:   Sat, 16 Nov 2019 10:38:52 -0500
Message-Id: <20191116154113.7417-97-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Quentin Monnet <quentin.monnet@netronome.com>

[ Upstream commit fe8ecccc10b3adc071de05ca7af728ca1a4ac9aa ]

When trying to complete "bpftool map update" commands, the call to
printf would print an error message that would show on the command line
if no map is found to complete the command line.

Fix it by making sure we have map ids to complete the line with, before
we try to print something.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/bash-completion/bpftool | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 598066c401912..c2b6b2176f3b7 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -143,7 +143,7 @@ _bpftool_map_update_map_type()
     local type
     type=$(bpftool -jp map show $keyword $ref | \
         command sed -n 's/.*"type": "\(.*\)",$/\1/p')
-    printf $type
+    [[ -n $type ]] && printf $type
 }
 
 _bpftool_map_update_get_id()
-- 
2.20.1

