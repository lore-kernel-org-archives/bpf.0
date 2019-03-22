Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F3AC43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43DC21874
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryLukK2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfCVT7K (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:59:10 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:55321 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfCVT7J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 15:59:09 -0400
Received: by mail-vk1-f202.google.com with SMTP id h131so1239218vke.22
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dvSFwX/cwTHRxA/HGGtK6nnCPtwgKpV/trwkfNlFVyQ=;
        b=ryLukK2tFSWTS7CigBR714CUpNUMrblcn/zmr784wnCxbYE5HlVsfR79CQzgxefrgm
         g2ohMw/ELbxAA0SlaMML8kke4Hmz88GuMZeQ3Tm1PnrlZ56TKdmCdeUUERAgTQsIWuMP
         H4Mye2yM6x+0Zy4eyLV9YWt1U5WaJFjV27LMbGHtJprpIlF0cz4v5SjYQLzP9yHeGzLA
         nyO3lE2MecEj6vtqdDapE3UUppwS/4glG/1w6Nna4z4h+wJ2BVBbti/Ds8krO5cKD3os
         9Ne4VijjRhqq1+MmisLNSSH6nvSsSdXjCDOX9mlo5MLYqIElzIlKpf/O9UhkHeRJG3rZ
         uUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dvSFwX/cwTHRxA/HGGtK6nnCPtwgKpV/trwkfNlFVyQ=;
        b=SWXwguqzk8Rd1Ifc9yUlS5Bxwg9HxUcVO1n9q5swnHBwpRbiXJoNj6q4WzF/agDZ4b
         zcVohmKp2HnCBIdm2kazQFmGHU7s+rP68S7rOEmp8zd+4NZ0mlioALBATjUB177+Z6ZH
         5fqMONVmJBv8VSmnEWLWfds9NZDSA+3q+O+wKCOwspF1E1hnIw7bUXz81srrovDDPILa
         8pF8CEGbM1V25D+XgtAJRePJR04bMoOirN/J9f1Z4dweMF/bchvqXECgO7bc+Jby0vng
         BUdbsqY9y7zm/JK3CDNU8Q+pu4/2nRJsj3gtdmHN5qsUX029AtZB+I/a2qQ9eMvy2fYa
         42jg==
X-Gm-Message-State: APjAAAWpjy335kTdGQ0YGlURVu6xjKJNX44XObbFkyhu02XtlSW+EUJp
        IqNZsfUoWBYObA4j9ZLnML/viDA=
X-Google-Smtp-Source: APXvYqxSZhoOgr6Wtay6fTPzOWH6Q69yMg4NTnZEokDaF8i3d+nWTVdEjsLTAWQMkqDgL+ClG/AEZho=
X-Received: by 2002:a67:f790:: with SMTP id j16mr7135940vso.232.1553284748746;
 Fri, 22 Mar 2019 12:59:08 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:58:56 -0700
In-Reply-To: <20190322195903.162516-1-sdf@google.com>
Message-Id: <20190322195903.162516-2-sdf@google.com>
Mime-Version: 1.0
References: <20190322195903.162516-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC bpf-next v3 1/8] flow_dissector: allow access only to a subset
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
* protocol
* vlan_present
* vlan_tci
* vlan_proto

This is required for the eth_get_headlen case where we have only a
chunk of data to dissect (i.e. trying to read the other skb fields
doesn't make sense).

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/core/filter.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 647c63a7b25b..62a7a2f50200 100644
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
@@ -6632,11 +6626,12 @@ static bool flow_dissector_is_valid_access(int off, int size,
 	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 		info->reg_type = PTR_TO_FLOW_KEYS;
 		break;
-	case bpf_ctx_range(struct __sk_buff, tc_classid):
-	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
-	case bpf_ctx_range(struct __sk_buff, tstamp):
-	case bpf_ctx_range(struct __sk_buff, wire_len):
+	case bpf_ctx_range(struct __sk_buff, protocol):
+	case bpf_ctx_range(struct __sk_buff, vlan_present):
+	case bpf_ctx_range(struct __sk_buff, vlan_tci):
+	case bpf_ctx_range(struct __sk_buff, vlan_proto):
+		break;
+	default:
 		return false;
 	}
 
-- 
2.21.0.392.gf8f6787159e-goog

