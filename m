Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F118C433DF
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC3820774
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663697;
	bh=eJJmdAzWi5I3ihv1Az8v+6SrdP9aQn6Z/DKHTk4Vsyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rp1wfxmwwHIPVdVceFgto9ZaIvAlPnjwVa8OpUxT8+bdo56VTslz8JJRPDnQticn2
	 q/A9da5xilEG+DjSDi8Cmabz/5CpPIx/DIw6QWTIEU/Dg6KjERd/K4jWVAUyE2uGhE
	 oPdeKKFq9bJgtCWyAWmtwlL0CSEXNR+4BP9qXfRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgFIAsP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbgFHXLD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43FF720890;
        Mon,  8 Jun 2020 23:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657863;
        bh=eJJmdAzWi5I3ihv1Az8v+6SrdP9aQn6Z/DKHTk4Vsyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvU07pGgwsLQDmlFmqQKd+eTpsdHG2OvBieg51fWRpOxT9UpgH7oE91Jruw+PZvf9
         q28oSO+scZ0xYjPdouUtiy0LHgOoqyeKgB0xCQp1udzFy/wOkllqsTabL0kQAHLYGo
         g7lR7n39LEMm39jqed77FxDjTic5yIWSHSyYft7Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 225/274] selftests/bpf: CONFIG_IPV6_SEG6_BPF required for test_seg6_loop.o
Date:   Mon,  8 Jun 2020 19:05:18 -0400
Message-Id: <20200608230607.3361041-225-sashal@kernel.org>
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

From: Alan Maguire <alan.maguire@oracle.com>

[ Upstream commit 3c8e8cf4b18b3a7034fab4c4504fc4b54e4b6195 ]

test_seg6_loop.o uses the helper bpf_lwt_seg6_adjust_srh();
it will not be present if CONFIG_IPV6_SEG6_BPF is not specified.

Fixes: b061017f8b4d ("selftests/bpf: add realistic loop tests")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/1590147389-26482-2-git-send-email-alan.maguire@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 60e3ae5d4e48..48e058552eb7 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -25,6 +25,7 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_IPV6_TUNNEL=y
 CONFIG_IPV6_GRE=y
+CONFIG_IPV6_SEG6_BPF=y
 CONFIG_NET_FOU=m
 CONFIG_NET_FOU_IP_TUNNELS=y
 CONFIG_IPV6_FOU=m
-- 
2.25.1

