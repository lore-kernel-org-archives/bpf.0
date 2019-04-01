Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C31C43381
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 20:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9040A208E4
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 20:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMQCLgQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDAU5s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:57:48 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:46051 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfDAU5r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 16:57:47 -0400
Received: by mail-io1-f74.google.com with SMTP id r21so9096266iod.12
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vNIYa8Lob8GaCf02abW7dYTE9zt9QRXGalzndleWpZA=;
        b=EMQCLgQDuQTAzGxVEy19Fng5ugj3v7m37tmEY6bvRSt9o83AbNiERl4vKuNs3eUh4M
         mie5mXt4/l/t+mTl9rm0N2271oh+8thQkKlsNtSt//RdRrdTPPOdHqfdOFcYfOmO/Et9
         eGBaxMuUZMMj/0RuqHfjstTl4k+riFBaXN5UE/xjpUBwuX38ryL3u6dUFuq7n2DO2+qv
         196GPlOc6JvaF5SQOT+wUp9kvZWcUjhg+fSze//9ZPMoB6lb72ZTGIPMyaTiE8kYuk2k
         cd7JYfczEzYSwtFna/ofOw54FFNEojOXlG8IG16q4DNz8mzJExqMaWm/eJ41q/TC7w4n
         dICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vNIYa8Lob8GaCf02abW7dYTE9zt9QRXGalzndleWpZA=;
        b=KMp9QlwnDFh+Hu59K6i84pHhRUEznOzJUuVwMiErkFPYANZYyjk9GG8gr5fom7i5lV
         UWCtpz10qBKV1i1w2P7uOUnulslmpAaLWokscCg6EguQfEzOzZpGl3uEKVH3iXKcva4/
         X79OaekW/YGnbekGEliHl7Hwmys57lJ1dMaGImqt5XF/SQ3tNszbZ4otT1n8oJOACyBg
         v0WTb45hxRKSkgq8BHOcObkh0Kd/Sy8+n2Uk9ywz57zjqkRO+fIJO86L1Y1UP69+fEkp
         dqn0TNCNgv/getPsEbck0WedqyOH039KXFtNK1CRO7ltiwPhVtGYecGv7iIxkpEKTOOz
         QKyQ==
X-Gm-Message-State: APjAAAVvkcsytDDgAKFOJxHSCVE0Lo5eYYYhPeVDjz1K45k9+cpZhhJG
        oRkCW76HHv1E55JL+izBFlGnnpA=
X-Google-Smtp-Source: APXvYqwFTeO6Cqilra7ujGMHast//X8d5iHsRbhdDVJn+wzOKGpSotypRN7vxhibxq97hoqkFPZsWBg=
X-Received: by 2002:a24:764b:: with SMTP id z72mr7401300itb.22.1554152266677;
 Mon, 01 Apr 2019 13:57:46 -0700 (PDT)
Date:   Mon,  1 Apr 2019 13:57:33 -0700
In-Reply-To: <20190401205734.4400-1-sdf@google.com>
Message-Id: <20190401205734.4400-5-sdf@google.com>
Mime-Version: 1.0
References: <20190401205734.4400-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf 4/5] flow_dissector: allow access only to a subset of
 __sk_buff fields
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use whitelist instead of a blacklist and allow only a small set of
fields that might be relevant in the context of flow dissector:
  * data
  * data_end
  * flow_keys

This is required for the eth_get_headlen case where we have only a
chunk of data to dissect (i.e. trying to read the other skb fields
doesn't make sense).

Note, that it is a breaking API change! However, we've provided
flow_keys->n_proto as a substitute for skb->protocol; and there is
no need to manually handle skb->vlan_present. So even if we
break somebody, the migration is trivial. Unfortunately, we can't
support eth_get_headlen use-case without those breaking changes.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/core/filter.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 647c63a7b25b..fc92ebc4e200 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6613,14 +6613,8 @@ static bool flow_dissector_is_valid_access(int off, int size,
 					   const struct bpf_prog *prog,
 					   struct bpf_insn_access_aux *info)
 {
-	if (type == BPF_WRITE) {
-		switch (off) {
-		case bpf_ctx_range_till(struct __sk_buff, cb[0], cb[4]):
-			break;
-		default:
-			return false;
-		}
-	}
+	if (type == BPF_WRITE)
+		return false;
 
 	switch (off) {
 	case bpf_ctx_range(struct __sk_buff, data):
@@ -6632,11 +6626,7 @@ static bool flow_dissector_is_valid_access(int off, int size,
 	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 		info->reg_type = PTR_TO_FLOW_KEYS;
 		break;
-	case bpf_ctx_range(struct __sk_buff, tc_classid):
-	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
-	case bpf_ctx_range(struct __sk_buff, tstamp):
-	case bpf_ctx_range(struct __sk_buff, wire_len):
+	default:
 		return false;
 	}
 
-- 
2.21.0.392.gf8f6787159e-goog

