Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C33C43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 07:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726D020811
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 07:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yeep/DWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfCHH62 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:58:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42711 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCHH60 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 02:58:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so13557715pfi.9;
        Thu, 07 Mar 2019 23:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GA4wc3+4SrvgUAYHL0nrbrWL7g5eP4USOD2ok/Kchy0=;
        b=Yeep/DWoSttSIkVAcpmRFv460ZLW5apSYqbw1e2+7WKaFYaHqwfcebfAosMHKEYfeb
         hOf7D12HYo2LhKEMfEKzeUATJ5Cwz7T1bItbHEF7++Dzjmf4idhn1bpfBHQ2izyr5FNQ
         I0nY+RANI5WlLbW39KyQ6eK5sQFUBCKkPXzYDsXo2bxeiecFfKfN3oC079jXRmRrKTi5
         T4u6PABcuhEEE5m+G1wnCyoodQqWUpDreGRSwT+97o9nPVAH6xEdfsk6MfwLYWYkT31O
         JK5IxIoqiN2venBHDMZNtMqVn06sU9hS9fYEen8oLXrrSTI4/AWEqhougc6IAWiK4Xb0
         oFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GA4wc3+4SrvgUAYHL0nrbrWL7g5eP4USOD2ok/Kchy0=;
        b=kX1zZUHKky4QQ/CmRtHDfYn4DgVMzR0HjSa/qu3F8x5HSnN7jeHBMHdNOjbdi+XcRI
         tgz5U3bZ2h3TTMCTJtcy9+RcW4jMEHzMsoWL31Aemgsw6mq0Wl3n6SPT1JoAcOW/6DPf
         itpVDNQXjqd/VUiMeVSxq+3yfCAS3rjp4NI2Wqxkqcxp4j3gz845ccH3lJeLWRRN3RoS
         CweHtImVms1RwRtDesRRB4Q3y+T0PMTnR99RZW5FP1/BcFa7cNwsukVC6dYeiFqCeF5C
         cGkbUo2I51I3UCIvTmuf2Wl3yuy4thmroZxs/NksZyYVMbDndJaVXVP77zDPjLMaVHbV
         Ot5w==
X-Gm-Message-State: APjAAAX0xCE4yVvJveTF18/lmPKhrGNOdtk4xKpSXoiLnl2Ybjjf+EeF
        qXzQIUHBXB0VKc8djj4nZls=
X-Google-Smtp-Source: APXvYqxdcd7oNcjEz9R04EXuX1Tsy2bvlgw41AuQA3z9wIUcVK4XQ3Wt2NDUY5oUiGTR3NzPd/h6Ew==
X-Received: by 2002:a63:e447:: with SMTP id i7mr15404089pgk.70.1552031905141;
        Thu, 07 Mar 2019 23:58:25 -0800 (PST)
Received: from btopel-mobl.ger.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id y14sm17066471pgs.47.2019.03.07.23.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 23:58:24 -0800 (PST)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
        bpf@vger.kernel.org
Subject: [PATCH bpf 0/2] xsk: fix non-existing flag/option behavior
Date:   Fri,  8 Mar 2019 08:57:25 +0100
Message-Id: <20190308075727.19358-1-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These two patches addresses the behavior of xsk_bind and Tx descriptor
validation, when non-existing flags are set.


Thanks,
Björn


Björn Töpel (2):
  xsk: fix to reject invalid flags in xsk_bind
  xsk: fix to reject invalid options in Tx descriptor

 net/xdp/xsk.c       | 5 ++++-
 net/xdp/xsk_queue.h | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.19.1

