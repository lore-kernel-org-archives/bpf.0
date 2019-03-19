Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A61EC10F03
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8CB217F9
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yqy3cxkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCSWUI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:08 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:40419 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfCSWUH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 18:20:07 -0400
Received: by mail-io1-f73.google.com with SMTP id e72so221032iof.7
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1vvC+4yB/9px9Z4pL9ov1KByJAvWQBmz/fblWWwJLE4=;
        b=Yqy3cxkSMYDAOJrTji0+iqLsWLFk+uvL0DYi2TTtXNZV9vI0B5hLdGWyuUyaq6jtWK
         k/WmVH+citO28CRvOPUXSqEHU07q2Vo0NUr2kVwiY3Hl7ysS01qCJc0pmEXrYtoiJkjc
         Te20qd6tyFpNn05OzIZt3SOwB5hyw4cX2w8oNagw5iJM9OxUsKUcwvzvEC24SUPrs29l
         zWBoHQQQly3PD4aZXqPt22byc9obv0//L73U2ON6XV48a1KoboQvq34P3FO0mq4N1LKJ
         RKKZHR2mL7JI9xAEVYhIffIhVY6Dz0NlRv1yU1KyScsRfabSuFn/pu3SdS6HI5XXc9s8
         9mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1vvC+4yB/9px9Z4pL9ov1KByJAvWQBmz/fblWWwJLE4=;
        b=W4+tKo5D52+GHQOgchPZFJwaEWuboDtoI9SC4aVjvmIKohwNFpuo/anAoxDZ3XeGk9
         Yji5ZMt+zZRXnvfkEgXXa5yQo9vqzLeTO8fbiqNErApey7QKWrYpSdZy/Z00sbeHgGHO
         UDwtFNmHmjJ+sXcH4OCbXUVZiBAaiQr+DZRK3tdibqsvyATQzBSLFRNH0jcmO4v3tw4w
         wo++9tA5MK06d781OR5nB1v1WGq0lgp4zil4hCu75Wpce+oD81aKIEBIgdmoaUxztkXJ
         t7dsnaU1/NYWDmcLwR29VitYchA0JowbcEs52HLea0kBkR9t8Qy67K8/KPwjmS3YaggW
         Rk9g==
X-Gm-Message-State: APjAAAWokMf0OcbttkSw/G3QksrHNgeEvofzEy/PT+Va7WxNy0VDWfjj
        iZ1DgkDutHymhMg3U7Y+gVJStTE=
X-Google-Smtp-Source: APXvYqzt7jT3wjyvUc8GSsuVkcLrlTaB1kIShq08VOGAw4Bd+LYkH7WSg7dRSThZeQJ+kbAVdvr9NTk=
X-Received: by 2002:a24:5c5:: with SMTP id 188mr3012475itl.3.1553034006660;
 Tue, 19 Mar 2019 15:20:06 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:19:44 -0700
In-Reply-To: <20190319221948.170441-1-sdf@google.com>
Message-Id: <20190319221948.170441-6-sdf@google.com>
Mime-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [RFC bpf-next v2 5/9] flow_dissector: allow access only to a subset
 of __sk_buff fields
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
* len
* protocol
* vlan_present
* vlan_tci
* vlan_proto
* cb

This is required for the eth_get_headlen case where we construct
temporary skb which might not have full/consistent state to let flow
dissector programs access all the fields (which are irrelevant in for
flow dissector program type).

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/core/filter.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 647c63a7b25b..5f413567ce8a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6632,11 +6632,14 @@ static bool flow_dissector_is_valid_access(int off, int size,
 	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 		info->reg_type = PTR_TO_FLOW_KEYS;
 		break;
-	case bpf_ctx_range(struct __sk_buff, tc_classid):
-	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
-	case bpf_ctx_range(struct __sk_buff, tstamp):
-	case bpf_ctx_range(struct __sk_buff, wire_len):
+	case bpf_ctx_range(struct __sk_buff, len):
+	case bpf_ctx_range(struct __sk_buff, protocol):
+	case bpf_ctx_range(struct __sk_buff, vlan_present):
+	case bpf_ctx_range(struct __sk_buff, vlan_tci):
+	case bpf_ctx_range(struct __sk_buff, vlan_proto):
+	case bpf_ctx_range_till(struct __sk_buff, cb[0], cb[4]):
+		break;
+	default:
 		return false;
 	}
 
-- 
2.21.0.225.g810b269d1ac-goog

