Return-Path: <SRS0=789D=TW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A90C282CE
	for <bpf@archiver.kernel.org>; Wed, 22 May 2019 13:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4988F20851
	for <bpf@archiver.kernel.org>; Wed, 22 May 2019 13:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsglvXHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfEVNiK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 May 2019 09:38:10 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:42011 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbfEVNiJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 09:38:09 -0400
Received: by mail-pf1-f179.google.com with SMTP id 13so1342704pfw.9;
        Wed, 22 May 2019 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nhcoPC4n6MoSmkf6Zkn+978F7nplOwQl5NwuKH4lcb8=;
        b=AsglvXHD0AuQRafRW2ZUKoph9OP9DitNxM9w8wKgw57gEZkLVLAcbvj2atkb3kz0Es
         r76uWRHIf2SG5sR8PG43ZLbozwnjSyaPZcuakhSGbKC6/U6AdR4GoNlyy5t6gbOOMRmR
         B6zEZ1Bpc/J+XU0sj6Cu3TCFn8JeSWwhn6PnSgDcVMbZI0EO3FKgRqtOjyjcCLSLFLmt
         grnTuViVCb+ZzaImTMDSXTmC3FFWtHrN88/OJSlfwVuGiltBm5J4yDkUZqMDRUhckf1L
         vFBsRDSpWKmVyfmO1+Cro9xG4pmXAw7uyQTTblpAS5j8k+oa8Ktx2WMDyaM7i3E1htFc
         6xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nhcoPC4n6MoSmkf6Zkn+978F7nplOwQl5NwuKH4lcb8=;
        b=MqPBsawiHh1fFc5dz/LmTZII9+VGENoBs98Qny214cledGS4haqANdvB8aIguIpS5Z
         a2qETgZgCFO3xITs3MENboaNKDn/jUd34TZbSo9qml6IxLOGf5b1nWQ4NjdZTgx/hHwK
         T3vWz0Oixaf+p04J1lemuBTQ/Zw5n+ef54gN4W8cXat4lcnc0vxHwdCO4Lf96BIEpH/l
         muPSw8UG9VlNCMlIRg0ZuShCey3LcbE7Fl14QrOn6+p12EESEd7UNKx7Z0lddd5VjTUh
         jurTSP+wK2P/z/IZprlgqUsYq4uza0Q+LO7CLJQd9fPvIUvKBwrvStiClRAYfOHjBsND
         FKqQ==
X-Gm-Message-State: APjAAAW9nzTQqYufYcHiXd9RTnuvUMyJT7hyrIZdRl+hXxnLT6dtS2SW
        T0y+y2rdlfiUow834US76tM=
X-Google-Smtp-Source: APXvYqzEwTJ70ISmrtCoQ6SFHS0Yqc05MPVPpeFGWORnxNPbwW6V4dRnfimpFwuldfHezGZ9XJqsUQ==
X-Received: by 2002:a63:1c4:: with SMTP id 187mr63130403pgb.317.1558532288998;
        Wed, 22 May 2019 06:38:08 -0700 (PDT)
Received: from btopel-mobl.ger.intel.com ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id o6sm53908997pfa.88.2019.05.22.06.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 06:38:08 -0700 (PDT)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        magnus.karlsson@intel.com, bjorn.topel@intel.com,
        bruce.richardson@intel.com, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] net: xdp: Two XSKMAP improvements
Date:   Wed, 22 May 2019 15:37:40 +0200
Message-Id: <20190522133742.7654-1-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series add two improvements for the XSKMAP, used by AF_XDP
sockets.

1. Automatic cleanup when an AF_XDP socket goes out of scope. Instead
   of manually cleaning out the "released" state socket from the map,
   this is done automatically. This mimics the SOCKMAP behavior; Each
   socket tracks which maps it resides in, and remove itself from
   those maps at relase.

2. The XSKMAP did not honor the BPF_EXIST/BPF_NOEXIST flag on insert,
   which this patch addresses.


Thanks,
Björn

v1->v2: Fixed deadlock and broken cleanup. (Daniel)

Björn Töpel (2):
  xsk: remove AF_XDP socket from map when the socket is released
  xsk: support BPF_EXIST and BPF_NOEXIST flags in XSKMAP

 include/net/xdp_sock.h |   3 ++
 kernel/bpf/xskmap.c    | 117 +++++++++++++++++++++++++++++++++++------
 net/xdp/xsk.c          |  25 +++++++++
 3 files changed, 130 insertions(+), 15 deletions(-)

-- 
2.20.1

