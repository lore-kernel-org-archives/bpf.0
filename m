Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1747C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 19:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768B4206A3
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 19:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGNaPzli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfBWTHO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 23 Feb 2019 14:07:14 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42106 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfBWTHN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Feb 2019 14:07:13 -0500
Received: by mail-pf1-f201.google.com with SMTP id p9so4471665pfn.9
        for <bpf@vger.kernel.org>; Sat, 23 Feb 2019 11:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tpMoXfEShFjaioesuDxP+LD9xmvC7EP/PPC2O+OQ6uU=;
        b=vGNaPzliswA0k73HPkX1cv/19ZanDe61CNkMIHKYnuleDcw7sNzaEiUCgdghL1WWD0
         UKJIlAHcufbHCMs9EvxVimpEPkZWRRAs5Iy3M0Q4Th3h7BSftNlUx5etXrqwVRAxrY43
         OU9hzbRaeIw1LW+w7nJz2GEehXwJ9X6h2J5Pgyv84+l/tz4pD9fQzMkBP5mU2CnqcK8r
         Q6EksRY9zpEj6No9zAVfOLsPLscQVYPHR353dPlejeOvKwD8Ki9CVc4fIxbZRDQ7Qh+Z
         dn5+i7znzePxMKiepJzgQ3/LixoPxF6I8ZiCj94Fiiy1LsD2CJAGsKzdfGUYmjYpyZfA
         kmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tpMoXfEShFjaioesuDxP+LD9xmvC7EP/PPC2O+OQ6uU=;
        b=KlitiFdeZ677aOkqmJjJlNFdMXLEx8fwwebzTJ1o6qmdqozNdmBnlbMS7osSR2JwS5
         pOaYV809W/sBn46B/JRLVd448fSINXS6SNsro6hz6q2xaUIQLOIDqo/rZXpw5gwmO+Ns
         8bmfZlC+NDHta27dD0vBmfUx8HjYDRtrbI71cANw2uvzRpY3/8zyqZx+YkjpfAPcuD0C
         pVxZUZ1bThY3VAz32GzBflnHOsJIss1pi2hjU54SOY/NtQh3yLyKBaO8NDuZm2giWN2/
         adcI5YcUndrJ95vZWIMl8Q08kml5RZZYB30fhAVVJCtxewg2+gMn159xAtvWstXVoVuY
         KGPQ==
X-Gm-Message-State: AHQUAube+66EDQsbl8940fH7NSwVF559LziXvJvzU9B8Ij6uRpAB7BCX
        WIM6cH+oNjqwMSKtmHc8Sl9bceg5alAwjg==
X-Google-Smtp-Source: AHgI3IYby9VJraSFO60SGeXqy0rvzUy06jiPMhJBx2x38S15WV1OvYskPiCz3waeUlFnsArnqGVJXE0t75/wDg==
X-Received: by 2002:a62:1f12:: with SMTP id f18mr3849735pff.49.1550948833005;
 Sat, 23 Feb 2019 11:07:13 -0800 (PST)
Date:   Sat, 23 Feb 2019 11:07:09 -0800
Message-Id: <20190223190709.61558-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH bpf] bpf: properly check TCP_CONGESTION optlen
From:   Eric Dumazet <edumazet@google.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Lawrence Brakmo <brakmo@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If caller of bpf_setsockopt() is silly passing a negative optlen
bad things happen.

Fixes: 91b5b21c7c16 ("bpf: Add support for changing congestion control")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lawrence Brakmo <brakmo@fb.com>
---
 net/core/filter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index f7d0004fc16096eb42ece3a6acf645540ee2326b..6a5d89464168f2f35f43986c1dbc0446c9390a3c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4194,8 +4194,9 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 			char name[TCP_CA_NAME_MAX];
 			bool reinit = bpf_sock->op > BPF_SOCK_OPS_NEEDS_ECN;
 
-			strncpy(name, optval, min_t(long, optlen,
-						    TCP_CA_NAME_MAX-1));
+			if (optlen < 0)
+				return -EINVAL;
+			strncpy(name, optval, min(optlen, TCP_CA_NAME_MAX - 1));
 			name[TCP_CA_NAME_MAX-1] = 0;
 			ret = tcp_set_congestion_control(sk, name, false,
 							 reinit);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

