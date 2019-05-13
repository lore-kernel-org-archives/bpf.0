Return-Path: <SRS0=YueQ=TN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD662C04AA7
	for <bpf@archiver.kernel.org>; Mon, 13 May 2019 18:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AAD2085A
	for <bpf@archiver.kernel.org>; Mon, 13 May 2019 18:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NA/FjXgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfEMSyJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 13 May 2019 14:54:09 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:54569 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfEMSyI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 14:54:08 -0400
Received: by mail-oi1-f201.google.com with SMTP id a196so4505573oii.21
        for <bpf@vger.kernel.org>; Mon, 13 May 2019 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ok8guVD0V5J+/Id0PgLrhseD+VuX/OMfP1RhhNrJ29o=;
        b=NA/FjXgZpugDr7WpeNL0OJpq9gkSaObz1KX4mj/B5eF2O7mbF15+evo1GGcOXHWVBY
         fS+oCwJp8BwTQttVADgHenSTtustg2XwnU3jsI6UrDPH3gK06kpX2/ZKH8dObqYq7XS0
         DDWKBq56fwlewTEVhsmDQfNmnfYPtJy4GX+4aXxauQB4WSq2aK7YpZHFIo6L4WslL/70
         xQ3pgpSwpedRx7fg1s5FYvmqtY5P0NJlPmzMOOKrHhGFcLmip90TMKQAQ9DBDZG3Egwa
         Tep6HLHwjkU9+opDGY99dHWRfNStdWEUcAcfOSArITqm08BmML7cVYQppZpfOfGZdxX5
         0Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ok8guVD0V5J+/Id0PgLrhseD+VuX/OMfP1RhhNrJ29o=;
        b=ZPKhSApLuQxJcjiB2gipfQs6MkYi1zNZjR2kmq2fyRRbMpkZQ+Ca+iLNWAUZtzTSpF
         X2aBojKqrGF5dQ19tC3Xgcdr7LX7KgCNVHhzTRMC2bw2ylySBQ322dZkbGbsLkDLmLF3
         Gnlmn7jNa79+ZcLz6HmQwCFGFiu+sBxrNiQxQNe/XDW9KOOxNjje9FH+i89ZZYJF3WES
         TQug39MvXtiZJJmOTbG6j3EPxS8fBRnXBAljP0wvpR3k9FHihZ9mNjDxUXQGXXdVXgKs
         n+/+PuoI+Pcmoyowin7ecQcA/H8BRxKsPKOu98TjPe4Is+/FdSToZgFi4Ke19rAaN2WC
         TzYg==
X-Gm-Message-State: APjAAAUOO3WuhgPIPFRLNa9jLRsnIt5O5TYcGK4hzi7L7qpweIDtRH4v
        ty5BfuHHBJltfNmcs24JvJt8QNs=
X-Google-Smtp-Source: APXvYqwY0tusSpb8Cczy3tk0s4Bzv9pouPUhh+cmkNpLDlF9KbKQOBLh+z6fB/amnmTQPQDepcBKYf8=
X-Received: by 2002:aca:f007:: with SMTP id o7mr404129oih.59.1557773647340;
 Mon, 13 May 2019 11:54:07 -0700 (PDT)
Date:   Mon, 13 May 2019 11:54:02 -0700
In-Reply-To: <20190513185402.220122-1-sdf@google.com>
Message-Id: <20190513185402.220122-2-sdf@google.com>
Mime-Version: 1.0
References: <20190513185402.220122-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH bpf 2/2] selftests/bpf: test L2 dissection in flow dissector
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        willemb@google.com, ppenkov@google.com,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure that everything that's coming from a pre-defined mac address
can be dropped.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/test_flow_dissector.sh      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_flow_dissector.sh b/tools/testing/selftests/bpf/test_flow_dissector.sh
index d23d4da66b83..1505d0a5fb32 100755
--- a/tools/testing/selftests/bpf/test_flow_dissector.sh
+++ b/tools/testing/selftests/bpf/test_flow_dissector.sh
@@ -112,4 +112,27 @@ tc filter add dev lo parent ffff: protocol ipv6 pref 1337 flower ip_proto \
 # Send 10 IPv6/UDP packets from port 10. Filter should not drop any.
 ./test_flow_dissector -i 6 -f 10
 
+tc filter del dev lo ingress pref 1337
+
+echo "Testing L2..."
+ip link set lo address 02:01:03:04:05:06
+
+# Drops all packets coming from forged localhost mac
+tc filter add dev lo parent ffff: protocol ip pref 1337 flower \
+	src_mac 02:01:03:04:05:06 action drop
+
+# Send packets from any port. Filter should drop all.
+./test_flow_dissector -i 4 -f 8 -F
+
+tc filter del dev lo ingress pref 1337
+
+# Drops all packets coming from "random" non-localhost mac
+tc filter add dev lo parent ffff: protocol ip pref 1337 flower \
+	src_mac 02:01:03:04:05:07 action drop
+
+# Send packets from any port. Filter should not drop any.
+./test_flow_dissector -i 4 -f 8
+
+tc filter del dev lo ingress pref 1337
+
 exit 0
-- 
2.21.0.1020.gf2820cf01a-goog

