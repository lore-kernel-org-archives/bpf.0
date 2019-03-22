Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEDFC43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E75218FC
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="blRQOR3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfCVByi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:54:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37178 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbfCVByh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 21:54:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so389621pfr.4
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2019 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ylkdlqTJWnikCO7Ke236nMilAbYr6lheluM7Go4pbQ=;
        b=blRQOR3jGR3RyDou3K5r5g47ggM5ey4gPedLIhFmaeOWgDS62/S/k6+LAU4yKu+scj
         C+OtjYGRv12EuvBnuiDSnavChvI8SLhqpBkpA+yQqVA1P/du4A0fpFxIjTcE/1+lFSyH
         mU7EETqCz5fz4GT8IpI3gckjoHbH9A2Am5VuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ylkdlqTJWnikCO7Ke236nMilAbYr6lheluM7Go4pbQ=;
        b=RxRN3Rhhu/+zTbXZiqdGXHTYDdnRtZLk9CxPhEDpIBn4Dt/NZ+1IXY5Z5hkVdbIYeu
         iz5wrlJraDqymUZK0P7tjPDXxZj4aLhhN/TxFv5eiWrhxPkhPNl0MTmajAk3rq1VAGn4
         d7bewXbR6IiOO0wFjKmdDhN2jKGCTjYoPjLYE5qc6FkPheprv78ZpL4RWv7CcWsN1Ztc
         WGxsi2vl7YyOB2zuMZUo5HUtl1fcvzZUC1qkCKhKGRb4gSYZU4XPPIqcPgBMaQdBWMSc
         VX+pl2HGszWg1nwf+bS2hxtByHpbyAxVSD9Nd0Mo/Gmgu/nryKGOkAQI7pyF8LjyecE/
         Qh3A==
X-Gm-Message-State: APjAAAUUtgxDqxl1i4HNl3e1mJRZjA1Ou/OoTO+rgPZj7W4yoiSUvnQf
        dBgPZPx0g1oSJ2J9/Tesb31MSA==
X-Google-Smtp-Source: APXvYqx6qhargPKzG+w0NErP50Oi1Hy5ZCZQJDrLjmZHGtTq+4wuzpIr2dpAf3uZ5U49x2Vlxutd9w==
X-Received: by 2002:a62:70c9:: with SMTP id l192mr6576552pfc.207.1553219676571;
        Thu, 21 Mar 2019 18:54:36 -0700 (PDT)
Received: from localhost.localdomain ([157.120.241.186])
        by smtp.gmail.com with ESMTPSA id i10sm7161799pgs.26.2019.03.21.18.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:54:35 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 5/8] tools: update include/uapi/linux/bpf.h
Date:   Fri, 22 Mar 2019 09:54:03 +0800
Message-Id: <20190322015406.26453-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190322015406.26453-1-lmb@cloudflare.com>
References: <20190319102103.7380-1-lmb@cloudflare.com>
 <20190322015406.26453-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pull definitions for bpf_skc_lookup_tcp and bpf_sk_check_syncookie.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/include/uapi/linux/bpf.h | 36 +++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 929c8e537a14..3c04410137d9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2431,6 +2431,38 @@ union bpf_attr {
  *	Return
  *		A **struct bpf_sock** pointer on success, or **NULL** in
  *		case of failure.
+ *
+ * struct bpf_sock *bpf_skc_lookup_tcp(void *ctx, struct bpf_sock_tuple *tuple, u32 tuple_size, u64 netns, u64 flags)
+ *	Description
+ *		Look for TCP socket matching *tuple*, optionally in a child
+ *		network namespace *netns*. The return value must be checked,
+ *		and if non-**NULL**, released via **bpf_sk_release**\ ().
+ *
+ *		This function is identical to bpf_sk_lookup_tcp, except that it
+ *		also returns timewait or request sockets. Use bpf_sk_fullsock
+ *		or bpf_tcp_socket to access the full structure.
+ *
+ *		This helper is available only if the kernel was compiled with
+ *		**CONFIG_NET** configuration option.
+ *	Return
+ *		Pointer to **struct bpf_sock**, or **NULL** in case of failure.
+ *		For sockets with reuseport option, the **struct bpf_sock**
+ *		result is from **reuse->socks**\ [] using the hash of the tuple.
+ *
+ * int bpf_tcp_check_syncookie(struct bpf_sock *sk, void *iph, u32 iph_len, struct tcphdr *th, u32 th_len)
+ * 	Description
+ * 		Check whether iph and th contain a valid SYN cookie ACK for
+ * 		the listening socket in sk.
+ *
+ * 		iph points to the start of the IPv4 or IPv6 header, while
+ * 		iph_len contains sizeof(struct iphdr) or sizeof(struct ip6hdr).
+ *
+ * 		th points to the start of the TCP header, while th_len contains
+ * 		sizeof(struct tcphdr).
+ *
+ * 	Return
+ * 		0 if iph and th are a valid SYN cookie ACK, or a negative error
+ * 		otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2531,7 +2563,9 @@ union bpf_attr {
 	FN(sk_fullsock),		\
 	FN(tcp_sock),			\
 	FN(skb_ecn_set_ce),		\
-	FN(get_listener_sock),
+	FN(get_listener_sock),		\
+	FN(skc_lookup_tcp),		\
+	FN(tcp_check_syncookie),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
-- 
2.19.1

