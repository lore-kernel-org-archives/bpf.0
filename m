Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD33C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 22:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB5B2084D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 22:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="alFmC1ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDKWxT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:53:19 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:35024 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDKWxT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 18:53:19 -0400
Received: by mail-yb1-f202.google.com with SMTP id k188so5513413yba.2
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 15:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=89cLoKzdA+Opv4mmJFcFHfwcAuc2qXLh/tLsHRqWMno=;
        b=alFmC1ikaeyTbzHN1bqKX8ll5Vfgn7bGiPoN0n+9dMxJ0fvaOrWs/+otpdQInh8tao
         UQ3PXsYSvdq2fJ9iOuW/l8+kcyk90Zlpew9INQsglIpTw6di9OgosUdLA6lTtBWi6V0q
         KRIvdVafd9z0BjIIzwIg+G8igtevHasvB4cWyi4zodPTzkYALX270FJJh2rlxfPvamut
         FQKSLPiz0YV5iouaFapgDzU+mZvjb3bRiOaCfQQhmnElo3B7Cd2m6hPWFdTzGPntpnwz
         6Gu3TqLbGqhtHVuNjeHUbJNL4tfY3H2jsEPrXhX1EnF4LnC6Jg7fHQCzFviQX4vcaEav
         F+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=89cLoKzdA+Opv4mmJFcFHfwcAuc2qXLh/tLsHRqWMno=;
        b=H0BOiT2yblYd63+xnJsh8Pi6xu27dGYTBk7woBytREVNxJqyDIxmZIvIMA/YSbnjgq
         cRJ58JD1z/aIb2msjCsPjOBVAR5wtorJULSBRw/d4IBj1Da26+6MmbGP4/2wjPmTeyN4
         IWP56lNP42mAnMqq13uoXo0E5UwWws0I2cFaxYQxL8rRRhV9WhvYL0YnCOes9rCLa3vu
         awxNMDIuzKcJ0YHY4bMNBkBQZq7lMRXhCRzOTyloSmTFSWmJYK6ctbybSBnHA+1CFrml
         cTkn6HPXOCodLWc0/hHb+yLgqENGrXWgI3pIOctbR2Hp+3EdoYUMg3K4DmF/j+uXt084
         fgYQ==
X-Gm-Message-State: APjAAAXZI9MXf6+KnduGNFtmtjpZUf1xxzO7xOG1Sk51n8p6gHrizeMA
        8T+dKnBYGA8KofC1DvpwQHeWqrk=
X-Google-Smtp-Source: APXvYqyIB2kmK4axauSXt9gS2jmbeAPtMNRuTb7tiIfWudzFMxc6sFoqBkPAgxoMr+hrJL8Gj742AHw=
X-Received: by 2002:a25:dc43:: with SMTP id y64mr3653100ybe.11.1555023198817;
 Thu, 11 Apr 2019 15:53:18 -0700 (PDT)
Date:   Thu, 11 Apr 2019 15:53:16 -0700
Message-Id: <20190411225316.125106-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next] selftests/bpf: bring back (void *) cast to
 set_ipv4_csum in test_tc_tunnel
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It was removed in commit 166b5a7f2ca3 ("selftests_bpf: extend
test_tc_tunnel for UDP encap") without any explanation.

Otherwise I see:
progs/test_tc_tunnel.c:160:17: warning: taking address of packed member 'ip' of class or structure
      'v4hdr' may result in an unaligned pointer value [-Waddress-of-packed-member]
        set_ipv4_csum(&h_outer.ip);
                       ^~~~~~~~~~
1 warning generated.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Fixes: 166b5a7f2ca3 ("selftests_bpf: extend test_tc_tunnel for UDP encap")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index bcb00d737e95..ab56a6a72b7a 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -157,7 +157,7 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
 				       bpf_ntohs(h_outer.ip.tot_len));
 	h_outer.ip.protocol = encap_proto;
 
-	set_ipv4_csum(&h_outer.ip);
+	set_ipv4_csum((void *)&h_outer.ip);
 
 	/* store new outer network header */
 	if (bpf_skb_store_bytes(skb, ETH_HLEN, &h_outer, olen,
-- 
2.21.0.392.gf8f6787159e-goog

