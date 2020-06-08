Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF4BC433E0
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DA1206C3
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663109;
	bh=X7FpV+JC98CvjiH85Qi4hqa20p22Tnz7RmdeG4ZzTk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GxfgKyz9lzgDXU1MAbEy9hQ8Vp/gNeQhwuBWdpJKhiOYTT5sfaH/+J1o0Lg7EOINg
	 TpA7+Jb90t24LKxCMWSHLrVdMRyzYPq0U0iGBiWvnVyvt/HPNfwnYxYYaJl0C+ELVr
	 Nkv7r8KESQjYQucKraT1P8exAZ4tor3upxfjpYls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgFIAh7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729520AbgFHXNe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15C1C21508;
        Mon,  8 Jun 2020 23:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658014;
        bh=X7FpV+JC98CvjiH85Qi4hqa20p22Tnz7RmdeG4ZzTk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brrh6MaN1SdjZ2qD9RdMS0e+NQ7k91InovUL1ntk0OlZIxahNmBA/0F6FxCGLvrYu
         8TEAn4Akjp2r5w0ebCdYoiMT5xSXrGyki+hbBEzqr45Fs2oRL2mEbCJldchNlOLAGi
         aMzQzOS5P/ZpQnBysyN2ULdmQ3Mt3hprzoRNXHh4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 068/606] bpf: Fix sk_psock refcnt leak when receiving message
Date:   Mon,  8 Jun 2020 19:03:13 -0400
Message-Id: <20200608231211.3363633-68-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

commit 18f02ad19e2c2a1d9e1d55a4e1c0cbf51419151c upstream.

tcp_bpf_recvmsg() invokes sk_psock_get(), which returns a reference of
the specified sk_psock object to "psock" with increased refcnt.

When tcp_bpf_recvmsg() returns, local variable "psock" becomes invalid,
so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in several exception handling paths
of tcp_bpf_recvmsg(). When those error scenarios occur such as "flags"
includes MSG_ERRQUEUE, the function forgets to decrease the refcnt
increased by sk_psock_get(), causing a refcnt leak.

Fix this issue by calling sk_psock_put() or pulling up the error queue
read handling when those error scenarios occur.

Fixes: e7a5f1f1cd000 ("bpf/sockmap: Read psock ingress_msg before sk_receive_queue")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/1587872115-42805-1-git-send-email-xiyuyang19@fudan.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_bpf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 19bd10e6ab83..69b025408390 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -121,14 +121,17 @@ int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	struct sk_psock *psock;
 	int copied, ret;
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return inet_recv_error(sk, msg, len, addr_len);
+
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
 		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
-	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len, addr_len);
 	if (!skb_queue_empty(&sk->sk_receive_queue) &&
-	    sk_psock_queue_empty(psock))
+	    sk_psock_queue_empty(psock)) {
+		sk_psock_put(sk, psock);
 		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
+	}
 	lock_sock(sk);
 msg_bytes_ready:
 	copied = __tcp_bpf_recvmsg(sk, psock, msg, len, flags);
-- 
2.25.1

