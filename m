Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D06C61DA4
	for <bpf@archiver.kernel.org>; Thu,  9 Mar 2023 17:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCIRcw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCIRcw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 12:32:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68520F92DC;
        Thu,  9 Mar 2023 09:32:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0553161CAB;
        Thu,  9 Mar 2023 17:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A2BC433EF;
        Thu,  9 Mar 2023 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678383170;
        bh=a/8trp5y5xTcgDooQ6fCXrz4iuKv2oufmH/jQJ+fQKA=;
        h=From:To:Cc:Subject:Date:From;
        b=arA1wsol3Vihv5VvDVVhkwSnJowV4ABQFHWxwtrsMamXhew6dxjf/47PDOTuBtHCx
         bf6J/JmUFA/+0vIOJ3JyQLnTn9t8ICZlj1UxNAWKcpDQchSOW75l97l6sc7VdTg0jT
         AHC0ylaySorNI5yZ2SbwKyT34C6TXyUOAirDLgPJeWE83oOXuIcSWeDAJCzxTzXmFO
         d8xHpPYEpgDiy3UOaqVYI2qvXNkpo1FGsB5mv144cJGQex/7G/vAiYxnKMvLrZp4Tm
         N/+WBk5+Fn1fWQNWyiVqLAYix0lQZJCiimP6yLHofv5MdL9VusoSnLpA9cnTBSAYQv
         Ni1Cx94P+MsWQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        lorenzo.bianconi@redhat.com, daniel@iogearbox.net
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: use ifname instead of ifindex in XDP
Date:   Thu,  9 Mar 2023 18:32:39 +0100
Message-Id: <cover.1678382940.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use interface name instead of interface index in XDP compliance test tool logs.
Improve XDP compliance test tool error messages.

Changes since v1:
- split previous patch in two logically separated patches

Lorenzo Bianconi (2):
  selftests/bpf: use ifname instead of ifindex in XDP compliance test
    tool
  selftests/bpf: improve error logs in XDP compliance test tool

 tools/testing/selftests/bpf/xdp_features.c | 67 ++++++++++++++--------
 1 file changed, 43 insertions(+), 24 deletions(-)

-- 
2.39.2

