Return-Path: <SRS0=tWTW=7Q=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5630BC433E1
	for <bpf@archiver.kernel.org>; Wed,  3 Jun 2020 08:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A042077D
	for <bpf@archiver.kernel.org>; Wed,  3 Jun 2020 08:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="AsfRgRAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgFCIMB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgFCIMA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jun 2020 04:12:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C285EC05BD43
        for <bpf@vger.kernel.org>; Wed,  3 Jun 2020 01:11:58 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so1150820eje.13
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2020 01:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxW2WKbu5+yJ2UGLVOyAkV6S1g7Xw1rS2dpKIEl2moA=;
        b=AsfRgRAM3v4V/Iq7E5u55S0caQmYzDGH2eudDD7JZu/9r3hTveIkdfX4SRf0N3piVc
         rRgkc+7/cW75LsvRZBBqTc0kHOm+vr2SbsNgVFAlqWtH9i1iLEu9CGIvfkiV8kFVT4Jk
         6wlpAzIBhfyLe+9pKt34mGO+4rIIGjoxFM5fEHKuW4DzS7OLo/k4DzyCoUbQ3Kul/Yp+
         O7T3X8tFYsl66mMQwKQY8sOAdkSbY4jdDMkOCW36wAgNtfMSgzXOgqQ2DF1JCB4F9EPa
         YuNeSimZbtLW+C9DGIZiAYx6ilvd614hJEvKaGmgjTev5TnP+1OCmXkpVLvN8mr3b0pg
         xwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxW2WKbu5+yJ2UGLVOyAkV6S1g7Xw1rS2dpKIEl2moA=;
        b=IvxjQTju6T9FRp07fWGqEGRG/4lxImS0nSFNWcvZpNT8tCDFcG8GHNTxjFq/ghS7tI
         Osp9WE0OfDGG8Kkdjgcy1UrXOSaD7lBJ2QhurHcWopuC34Tk7b0mM1jvic6Jny0ljLfo
         keDrvh2kywQRATf6i8htaWMoPaeUbA3K3EXdaMLdefu07oO/JvfSF7nxlZ/Fcc/PP+Cu
         fiHaajN19EmFPjvCjx62GmyFhLNjLr5o1+5Y4hCfPoEGPBp10gqIyfND4G6wv96IPEGs
         OUMeO8NJCfjtHRydaOnFj8LlM13JgGCCXsYl5Zu2vKhh5zXgJtIK1XHNb7CvTl05torg
         CMAg==
X-Gm-Message-State: AOAM530r0CSkWCy09cdGNKEC78os+LDzBmtyfiDx7eVD/jx5n7BbkAm5
        vjAB403Az9Z/c36G1ndV6dC5qQ==
X-Google-Smtp-Source: ABdhPJwiF29+IoyaIV667de4V6PVVZ7iRMBJhgklglZoPuUXGivSxyDjUznTXiIfOw/u4qUW5+braA==
X-Received: by 2002:a17:906:d111:: with SMTP id b17mr17295858ejz.267.1591171917420;
        Wed, 03 Jun 2020 01:11:57 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id r16sm748803edv.95.2020.06.03.01.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 01:11:56 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     netdev@vger.kernel.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Ferenc Fejes <fejes@inf.elte.hu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: fix unused-var without NETDEVICES
Date:   Wed,  3 Jun 2020 10:11:23 +0200
Message-Id: <20200603081124.1627600-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A recent commit added new variables only used if CONFIG_NETDEVICES is
set. A simple fix is to only declare these variables if the same
condition is valid.

Other solutions could be to move the code related to SO_BINDTODEVICE
option from _bpf_setsockopt() function to a dedicated one or only
declare these variables in the related "case" section.

Fixes: 70c58997c1e8 ("bpf: Allow SO_BINDTODEVICE opt in bpf_setsockopt")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    This fix currently applies on net-next and bpf-next only. Except that
    net-next is now closed and -net will get commits from net-next after
    Linus' pull.
    
    I hope it is fine to have picked [PATCH bpf] and not bpf-next (or net).

 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index d01a244b5087..ee08c6fcee1a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4286,9 +4286,11 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
 static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen, u32 flags)
 {
+#ifdef CONFIG_NETDEVICES
 	char devname[IFNAMSIZ];
 	struct net *net;
 	int ifindex;
+#endif
 	int ret = 0;
 	int val;
 
-- 
2.25.1

