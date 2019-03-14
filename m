Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87209C4360F
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E3420854
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eK3B/e6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfCNLko (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:40:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47017 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfCNLkm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 07:40:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id 33so5466914wrb.13
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2019 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l38CRy65r1uSCEOoq1AH+x1Uw96Avkuq2GN/tw6Kz6o=;
        b=eK3B/e6dGDlxUEXufzt0dqN+n7wBclw9LzFpBIsAwJofh2CayLLhZ7RryPge+kuctO
         m44L7yx9HWCh81ZTUU/Eybo+FRkLVu5nhYSn+N1ZIgI7fPklcIkRQbexNMpnbYiXzB7o
         9Adbm2qNOZgoH5xrcEC3BsYkUDdLhWBHbr0bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l38CRy65r1uSCEOoq1AH+x1Uw96Avkuq2GN/tw6Kz6o=;
        b=WnNuT+a6x8V2yIosKnYvq6AqZSP0LDRVjR/t7PsXfNIi+gHSMj4eBBYo67cCqyAla5
         kPHTY3oxMAFDtvQ2vPFs8ilHmTbR1WwAPlmPqADb96jQ6ngSDIhSB+f2VCBFPu2Vx0Xn
         iA9q3yHNPIObVr6Z3WhpfJBqjUrwqaBlHMhrQw4kDaT9je/MzjK1qGYwAuAHQfk++2kG
         K/6KLCLIKGdM8/RDm8v3991cop2hzwnUiWPJMfzJHy1LQhTMNfQWY1ux1TFVE0GscZwb
         SHXm4pe9tnupjePuiJaI2bj2/pQXoS9M5R+4dN3EDN1CrmJcnWttLavOiUuIYElRHmIl
         oU0g==
X-Gm-Message-State: APjAAAXBj6OvwC5K43JIHBgU6Dv9+9MVBm3tcV7+3YONVaL+JiQYEKFP
        C2gf0Lry54rlOxV7ss/4l15l6A==
X-Google-Smtp-Source: APXvYqwOnwayz9TOm0w+bQwCyG9FoMr0qsFVCy5JYoI+JZunxUY/qGtNJX6MkfrOqNjFkdgkrdN1SA==
X-Received: by 2002:adf:90af:: with SMTP id i44mr30687311wri.222.1552563640959;
        Thu, 14 Mar 2019 04:40:40 -0700 (PDT)
Received: from antares.lan (5.8.9.5.4.5.2.4.f.f.6.d.4.1.5.8.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:8514:d6ff:4254:5985])
        by smtp.gmail.com with ESMTPSA id a9sm1804017wmb.30.2019.03.14.04.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:40:40 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, theojulienne@github.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 5/8] tools: update include/uapi/linux/bpf.h
Date:   Thu, 14 Mar 2019 11:39:51 +0000
Message-Id: <20190314113954.10210-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190314113954.10210-1-lmb@cloudflare.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190314113954.10210-1-lmb@cloudflare.com>
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

