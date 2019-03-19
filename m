Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C7DC10F03
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BB82133D
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="sev0FJy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfCSKVe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:21:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34808 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfCSKVe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 06:21:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id o10so16327008wmc.1
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l38CRy65r1uSCEOoq1AH+x1Uw96Avkuq2GN/tw6Kz6o=;
        b=sev0FJy4pF3+GWAbACirda1tjCoJwv9d9euYszaxFPjjtACmMP1J+6t6cUNJqYD7gz
         sCVUSoelwx91n52IZ0uButxFixUE2BpdJE5Y0sudAsxZ3i1glokjq/k+meU5H6eIVI2j
         /N0GUJ3mdG6hRaRpB8lWDuvfaIh/eg4tyTHo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l38CRy65r1uSCEOoq1AH+x1Uw96Avkuq2GN/tw6Kz6o=;
        b=iaVod1XRBMAEHZCPpx60cnKLP9awzu1HDgfHoAwsbaqU+3yjA1r0V9KABKdSgEIu/j
         CLFs7ZX+l6EjU88T2qZkI9t0dlb4hME7UtqR/NS7AIgO7qUO5xOfA37175ZGm4N71YEf
         ElGQYtlNAO6MoQFIMqVD2xae/T8ZEDTBrRyOEcmWrfC0UF8UhcWKn2nxbCAn0xsY/Vdh
         qdIVd/T7jyLgLhVYA8HnYCVZlWFplfrnHYTv5dtodwhNauve6mDEHkfccnRcTONSKhMt
         Iw+YUX44FB522qAOda4aXy88wDfDfw5uFJJf4bFMb0OLCFbGY5c9e454YNkLPexXhoON
         ccAA==
X-Gm-Message-State: APjAAAVIs24SqBCVRF8zryUJ9PXYjBWnfzd0cir2Hi+ZHjGcpbRgYgPV
        7ySkFfhTzJTUNbWjZT/5I4dulaIf5uz5KnUl
X-Google-Smtp-Source: APXvYqwpquUyQWo2nDYxjNtW/H+urpQxBNdLc3SPFXd525jbLHl2IUfsa0H4tgd7Md67+y7ymP2OpQ==
X-Received: by 2002:a1c:9d8f:: with SMTP id g137mr2970555wme.26.1552990892186;
        Tue, 19 Mar 2019 03:21:32 -0700 (PDT)
Received: from localhost.localdomain ([217.138.62.245])
        by smtp.gmail.com with ESMTPSA id q2sm27895781wrd.46.2019.03.19.03.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:21:31 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 5/8] tools: update include/uapi/linux/bpf.h
Date:   Tue, 19 Mar 2019 10:21:00 +0000
Message-Id: <20190319102103.7380-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190319102103.7380-1-lmb@cloudflare.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190319102103.7380-1-lmb@cloudflare.com>
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
index 983b25cb608d..587d7a3295bf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2374,6 +2374,38 @@ union bpf_attr {
  *	Return
  *		A **struct bpf_sock** pointer on success, or NULL in
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
@@ -2474,7 +2506,9 @@ union bpf_attr {
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

