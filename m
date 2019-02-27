Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DACC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C585A2133D
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 19:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kW6LlX+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfB0TPP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:15:15 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:37224 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbfB0TPP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 14:15:15 -0500
Received: by mail-qt1-f202.google.com with SMTP id f24so16345788qte.4
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 11:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BlWqrg7hvp9JpB8xhtf78jZnHeI1DA694/rnAFXzlYE=;
        b=kW6LlX+Tsrn/gnW1gK5QK6jh7qcn/UBedncgHsSLyT35zwDhmcrQOm3+H4rgw3VAPQ
         8iqArx7jikH/NH67FpPtP7dX/MyXAQBu82nAdn4FENbHQItubuEwcAkQzbLSkplJDvQb
         J7YNYL0vSqJg1K98KUi1sRD6Cn/Na7be8cq/eFKdJB5lw7Xu+hkKGNroBCscpCQZDC3t
         nHhKjeTDTOXvx98GAoirnpN/drngo/9o7TQmuDH68NimiugY/7V4DO57kQ5ajYT/w2V3
         gi5p0Vt/RLgsr+vjveBg7Kfzy16I3ALhgu4B3E8rGhHZU7vNVXtGw8OTfeIUBgtL9lbg
         w/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BlWqrg7hvp9JpB8xhtf78jZnHeI1DA694/rnAFXzlYE=;
        b=HU4VwoyUn6p2Tqf7+wc3dAoTv2O6hVcpe9j1Cx9q7tOcOP3pFE/kV38l9qUm4MwiAY
         NiE/IUHl80GRF3oT94F2k9QxGXpycqJRqhfFwoY6tds+4NehxtItx0F2W30kdNCV1UXO
         S+AY7ytKQqaTePNd9F6dirWdw37DaqjlPimwMWRntDsoAfw2DOsaGTjbHhQVAT5HKpVF
         br7W8kkS9khZK9wCG0iS9ARIk0nokBxTT9ihzi87qIubw4S0QakCkmrUlKoMugpMnIxW
         PC7jrBOqV7/y8AUu9+d2wM60x0y2z+yHShiUUVtVkdZWgm47REfJz0/4a5s6//McWkyC
         HKuQ==
X-Gm-Message-State: APjAAAVFNFrvE0HKpxuUtTNlBaqXBhXbI6+XTMYzuRgROWhiUKicFZzh
        AlFwRTpp0UdKLeiAabMfs4rnioU=
X-Google-Smtp-Source: APXvYqzsWxZM+hcpmt07LmOydScaJNnPIwLKyPJ1ZttrOWJt0HAhjELVo/E97Hu8F+z1RFHdP90kl9U=
X-Received: by 2002:a0c:d486:: with SMTP id u6mr1710667qvh.56.1551294914222;
 Wed, 27 Feb 2019 11:15:14 -0800 (PST)
Date:   Wed, 27 Feb 2019 11:15:11 -0800
Message-Id: <20190227191511.80859-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH bpf-next] selftests/bpf: use __bpf_constant_htons in
 test_prog.c for flow dissector
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Older GCC (<4.8) isn't smart enough to optimize !__builtin_constant_p()
branch in bpf_htons.

I recently fixed it for pkt_v4 and pkt_v6 in commit a0517a0f7ef23
("selftests/bpf: use __bpf_constant_htons in test_prog.c"), but later
added another bunch of bpf_htons in commit bf0f0fd939451 ("selftests/bpf:
add simple BPF_PROG_TEST_RUN examples for flow dissector").

Fixes: bf0f0fd939451 ("selftests/bpf: add simple BPF_PROG_TEST_RUN examples for flow dissector")

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_progs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index c59d2e015d16..87cde42559f7 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1954,7 +1954,7 @@ static struct bpf_flow_keys pkt_v4_flow_keys = {
 	.thoff = sizeof(struct iphdr),
 	.addr_proto = ETH_P_IP,
 	.ip_proto = IPPROTO_TCP,
-	.n_proto = bpf_htons(ETH_P_IP),
+	.n_proto = __bpf_constant_htons(ETH_P_IP),
 };
 
 static struct bpf_flow_keys pkt_v6_flow_keys = {
@@ -1962,7 +1962,7 @@ static struct bpf_flow_keys pkt_v6_flow_keys = {
 	.thoff = sizeof(struct ipv6hdr),
 	.addr_proto = ETH_P_IPV6,
 	.ip_proto = IPPROTO_TCP,
-	.n_proto = bpf_htons(ETH_P_IPV6),
+	.n_proto = __bpf_constant_htons(ETH_P_IPV6),
 };
 
 static void test_flow_dissector(void)
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

