Return-Path: <SRS0=7rOB=3P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9100EC35240
	for <bpf@archiver.kernel.org>; Sun, 26 Jan 2020 03:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8AE20720
	for <bpf@archiver.kernel.org>; Sun, 26 Jan 2020 03:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS4MRpLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAZD7M (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 25 Jan 2020 22:59:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35975 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgAZD7M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jan 2020 22:59:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so3358580pgc.3;
        Sat, 25 Jan 2020 19:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6TXpbeniErc4UMUnyatTTUFEnvq7YkVTlHMLj1lO8iY=;
        b=ZS4MRpLWtDrLwQJo/8K+MbsPZm1XH0xvLr67jLRgKG4uIRPDwWLe7hQxdin3rOUYlu
         BfOJ+CU5BJ1flQuGQ7+m4gMf6Zr/oNEooHC1di8uQvDG8F6zLv1fILJGD+48fXnMLDaP
         BuuYxzIvJqiRZuz64RP5h7gCRhLkBYeJ6ma6BhOKo4NBCkFNUB/x3J8/PRT1uGyBR3S2
         Nc5yRaD7Wm+GfbckE9t2AAgdfXMxMdWElV/eanqN+kwwHKmf3XNsghYb8rJU3ikGCRPc
         xvDk+9tW9R0dT93Paps6L7qNrJUOlJRJkP8AF66KS/d2bSLyjUPViQMyiuFcdG//8/VA
         0H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6TXpbeniErc4UMUnyatTTUFEnvq7YkVTlHMLj1lO8iY=;
        b=NxhdKiThVCU/m79lzBLOLNIeqgj/KcKWgzUj469Una23u0rCOV2qhSOCXpRZzDt/7g
         L+BtMba857VcYEPr15K9z+QmFBJE78WJDL6fSf4fBLZ855w21QI+yJTtYz7wryUl73uV
         l7qT77ZOdKKtGLDIPtVs2qYRIm6j5PeoS7duELRq8CfSWknNI/+JC8P1HVrEg5uV9RAO
         UZydLM2c345MWQyD726pWk8F5MEKErZtephXigCrRtjGPBuW3OHUUjvkqRdfIRQUD6sW
         sgY9+CyUAtcwzw7kaP2aVirhwYka9DdDzW/Z9ZjIhrZoOZVTY7gfK4gqUVWXXB32uCo1
         zxdA==
X-Gm-Message-State: APjAAAUnXMRgkLOpCJgiEHwihXQ8QzXcXhNBGNDDUbn13eZ4ybVluY+1
        gl2DIJRTM3vXcaqhBlpt+muALqhk
X-Google-Smtp-Source: APXvYqyHDB67SeIuWWpuL0LKhhd1PK+Msy6pJ9sCPkQzvVA0IMeS2kvuAFwGrlJdOPttqmzEsHXjJA==
X-Received: by 2002:aa7:9808:: with SMTP id e8mr10686937pfl.32.1580011151760;
        Sat, 25 Jan 2020 19:59:11 -0800 (PST)
Received: from localhost.localdomain ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id 64sm11078650pfd.48.2020.01.25.19.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jan 2020 19:59:11 -0800 (PST)
From:   John Fastabend <john.fastabend@gmail.com>
To:     bpf@vger.kernel.org
Cc:     bjorn.topel@intel.com, songliubraving@fb.com,
        john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        toke@redhat.com, maciej.fijalkowski@intel.com,
        netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] XDP flush cleanups
Date:   Sat, 25 Jan 2020 19:58:50 -0800
Message-Id: <1580011133-17784-1-git-send-email-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A couple updates to cleanup some of the XDP comments and rcu usage.

It would be best if patch 1/3 goes into current bpf-next with the
associated patch in the fixes tag so we don't have out of sync
comments in the code. Just noting because its close to time to close
{bpf|net}-next branches.

John Fastabend (3):
  bpf: xdp, update devmap comments to reflect napi/rcu usage
  bpf: xdp, virtio_net use access ptr macro for xdp enable check
  bpf: xdp, remove no longer required rcu_read_{un}lock()

 drivers/net/veth.c       |  6 +++++-
 drivers/net/virtio_net.c |  2 +-
 kernel/bpf/devmap.c      | 26 ++++++++++++++------------
 3 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.7.4

