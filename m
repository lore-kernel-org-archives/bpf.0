Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6783C4360F
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 20:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FD4208E4
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 20:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auUdJRYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfDAU5n (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:57:43 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:51220 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfDAU5m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 16:57:42 -0400
Received: by mail-yw1-f73.google.com with SMTP id s11so8292933ywa.18
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EYY+lpV/sDo5X+XeFY+pituZHL8dpFPnn41AT/Pu7vs=;
        b=auUdJRYPP3FWq5gefhzIqzLRkYmPfowMcp30zhPVMML9c33ezOIpfc38rtLr2ZONa3
         yOjmj3z4tKD92gNa6GEPxAfie8lFG79Jq6GnnAJtPEEWA802bds3vWiizHIYRgHB2jH9
         wilhLA4Bkz/z5D7vSeBkNPrWzLQSlzODlVFBhdaCUhz+U/GKonXuJRm2LGawuRVFFmjY
         OAEVR57cNxP+LaUIZ5WV5Et1/+lRhuir9MRywGnKCANPwo0XRJivf7baNT51Y4NYHdpq
         6rjCKySyrjssH9stDjvaPH17YyqpBgYlD4H3pCPS6gHOq0HmMc70nC4520IjF/VWF2ZD
         /v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EYY+lpV/sDo5X+XeFY+pituZHL8dpFPnn41AT/Pu7vs=;
        b=BplKIl3DBB7u9QTkUCDN8TivUp6mJ2faGXWKOjGu5ScMBwqFL6j7lWM7xvHyRRzfWx
         clGiKjKaSqy1F49myVfetNX1AqWajzFx3Ofm8/j2r47+xpSNFbngSCD/u8YaeTFCf7fP
         etmBV6F+w9Ag8BHfTzkmksOtP3LcPfesIli8A8D288w0JTSv81BH3KZt/PN+mTaP0T2D
         O8uqeaqogd/I4Zr56NWyDh4Jqcptr66wPHiOml/FeRN9bK0OdgzEhsXPDxHGS+DHGrzN
         p/YxOopyX3Csm8anIo2YY6n1MPjaBSG6JiBcXT2SPojR+4TUUg9X8oEFmK3NBg86apZm
         DW1w==
X-Gm-Message-State: APjAAAU0AniPHtbHifK/cBo8ruydQjrDxoed89cwicVUDNY4NpozXbA+
        zvO07+NkrEa85uGZwaQdF6OxfV0=
X-Google-Smtp-Source: APXvYqyiknNWUmlnZChKUPmbf1TznrYBDvaXaGZBYXJlTXju2unrYBdLi0Tjqzop/114fX9M0dFLtWk=
X-Received: by 2002:a5b:44e:: with SMTP id s14mr7247266ybp.100.1554152262055;
 Mon, 01 Apr 2019 13:57:42 -0700 (PDT)
Date:   Mon,  1 Apr 2019 13:57:31 -0700
In-Reply-To: <20190401205734.4400-1-sdf@google.com>
Message-Id: <20190401205734.4400-3-sdf@google.com>
Mime-Version: 1.0
References: <20190401205734.4400-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf 2/5] net/flow_dissector: pass flow_keys->n_proto to BPF programs
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

This is a preparation for the next commit that would prohibit access to
the most fields of __sk_buff from the BPF programs.

Instead of requiring BPF flow dissector programs to look into skb,
pass all input data in the flow_keys.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/core/flow_dissector.c                    | 1 +
 tools/testing/selftests/bpf/progs/bpf_flow.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index bb1a54747d64..9b84250039df 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -707,6 +707,7 @@ bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
 	/* Pass parameters to the BPF program */
 	memset(flow_keys, 0, sizeof(*flow_keys));
 	cb->qdisc_cb.flow_keys = flow_keys;
+	flow_keys->n_proto = skb->protocol;
 	flow_keys->nhoff = skb_network_offset(skb);
 	flow_keys->thoff = flow_keys->nhoff;
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
index f177c7a6a6c7..75b17cada539 100644
--- a/tools/testing/selftests/bpf/progs/bpf_flow.c
+++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
@@ -92,7 +92,6 @@ static __always_inline int parse_eth_proto(struct __sk_buff *skb, __be16 proto)
 {
 	struct bpf_flow_keys *keys = skb->flow_keys;
 
-	keys->n_proto = proto;
 	switch (proto) {
 	case bpf_htons(ETH_P_IP):
 		bpf_tail_call(skb, &jmp_table, IP);
@@ -119,7 +118,9 @@ static __always_inline int parse_eth_proto(struct __sk_buff *skb, __be16 proto)
 SEC("flow_dissector")
 int _dissect(struct __sk_buff *skb)
 {
-	return parse_eth_proto(skb, skb->protocol);
+	struct bpf_flow_keys *keys = skb->flow_keys;
+
+	return parse_eth_proto(skb, keys->n_proto);
 }
 
 /* Parses on IPPROTO_* */
@@ -358,6 +359,7 @@ PROG(VLAN)(struct __sk_buff *skb)
 	    vlan->h_vlan_encapsulated_proto == bpf_htons(ETH_P_8021Q))
 		return BPF_DROP;
 
+	keys->n_proto = vlan->h_vlan_encapsulated_proto;
 	return parse_eth_proto(skb, vlan->h_vlan_encapsulated_proto);
 }
 
-- 
2.21.0.392.gf8f6787159e-goog

