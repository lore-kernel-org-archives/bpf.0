Return-Path: <SRS0=ay3l=U6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2DFC0650E
	for <bpf@archiver.kernel.org>; Mon,  1 Jul 2019 17:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58D420673
	for <bpf@archiver.kernel.org>; Mon,  1 Jul 2019 17:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEd08RMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfGARiu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:38:50 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55920 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfGARiu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 13:38:50 -0400
Received: by mail-pf1-f202.google.com with SMTP id i26so9179025pfo.22
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rqxRKWNEo1osvaBkv3/KPbZBsws5mfNzEZoyqO4E7N0=;
        b=uEd08RMuRZkIcdgl/k7/xWDXggSB7BIAEHoCC54LmnZryPZbzhb0qGfkQYyeEF9HwZ
         AMqishzIroKm5Q6ZnbjDIabRPPx8VE+JMMTWLGMz07nrO8urswHBugHWM3Av2/Kc0d+D
         M9/bVmFXXreaEKJe93mL8fUF+OaQcrCt508Zabl3UqWmQZbOJ5tgSZJLvqZFhPzlButD
         1Pp4NsOtM3SYwPEd3Qgx7ioQGJzBAEJ9iX9XZr6Dvr3xVf71k7+4WMk8yuylaVRTQDP8
         ErsSFS8WXPnWAy4r0G3HWfrcbSG52CuRhyx5fxEa9AoC7Fak0lTthHifpZpvLDYQ7eIF
         T8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rqxRKWNEo1osvaBkv3/KPbZBsws5mfNzEZoyqO4E7N0=;
        b=O4aOSK0/Yd5pjNTHX5ivRYAZiN5e6WKZvTsLt5st2NZd5ThylrUhfYajEh0fF1IxMI
         9fNZenEXn1yfWwAPdqZOSMSVRYw+Cy/hlSE7sxq2//jViQ0BXd7JNaYB7j9Ol7G/3laE
         tP5RQgHtVc4T7ncqhAjschHZd9tTD308CQlLzkA0DTv0GZiDILb7ByUKjYx/K4XJwBcE
         y0UZwU0Hj1X7h6U4b5vEE14HryPMKnr6H3tW660Cvx7oTlmJqETd6vS55M2momXvvDFE
         /96elW2OodbeSwBGyeYd5G1xOR64cp+94MWsEDWPukK5zMJFoCv0m4tZ0MdpeE23/+oC
         hv9Q==
X-Gm-Message-State: APjAAAXjqMRCiaUmzDefAttGGgdEsgUxdSOvUW0wJxRu1zZrVxDz+RDw
        UGDaLAk9glqwrxf5pDq3tCETIrA=
X-Google-Smtp-Source: APXvYqxqMd81L1DDmkwA3FYZGIcQqmw1s+00/5mYjsII7gtoJsELsfFIxiFV5KROBjQf3TfZe7iPhiw=
X-Received: by 2002:a65:5c0a:: with SMTP id u10mr26577468pgr.412.1562002729019;
 Mon, 01 Jul 2019 10:38:49 -0700 (PDT)
Date:   Mon,  1 Jul 2019 10:38:40 -0700
In-Reply-To: <20190701173841.32249-1-sdf@google.com>
Message-Id: <20190701173841.32249-3-sdf@google.com>
Mime-Version: 1.0
References: <20190701173841.32249-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v3 2/3] bpf: sync bpf.h to tools/
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync user_ip6 & msg_src_ip6 comments.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a396b516a2b2..c59dc921ce83 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3237,7 +3237,7 @@ struct bpf_sock_addr {
 	__u32 user_ip4;		/* Allows 1,2,4-byte read and 4-byte write.
 				 * Stored in network byte order.
 				 */
-	__u32 user_ip6[4];	/* Allows 1,2,4-byte read an 4-byte write.
+	__u32 user_ip6[4];	/* Allows 1,2,4-byte read and 4,8-byte write.
 				 * Stored in network byte order.
 				 */
 	__u32 user_port;	/* Allows 4-byte read and write.
@@ -3246,10 +3246,10 @@ struct bpf_sock_addr {
 	__u32 family;		/* Allows 4-byte read, but no write */
 	__u32 type;		/* Allows 4-byte read, but no write */
 	__u32 protocol;		/* Allows 4-byte read, but no write */
-	__u32 msg_src_ip4;	/* Allows 1,2,4-byte read an 4-byte write.
+	__u32 msg_src_ip4;	/* Allows 1,2,4-byte read and 4-byte write.
 				 * Stored in network byte order.
 				 */
-	__u32 msg_src_ip6[4];	/* Allows 1,2,4-byte read an 4-byte write.
+	__u32 msg_src_ip6[4];	/* Allows 1,2,4-byte read and 4,8-byte write.
 				 * Stored in network byte order.
 				 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
-- 
2.22.0.410.gd8fdbe21b5-goog

