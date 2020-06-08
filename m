Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C16C433E0
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B648207FB
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662227;
	bh=SIl+6gDDlAgE5/oHLwCHDU0dl1CfSAmHwDjMoN+E624=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lYKomcRG5ZvZXpplZVzCv61l1bg4SFkIPUPpVG+1VMxmJAfm6wrhQFmm4brO6sKSc
	 wZdOY/7I4W3DuwcM4HoZ+4wM41t/Fm9BecdhkG+ihXCXL0P3Fqq1Hl9xtEIq9ciXEL
	 KWZoalgbF0LaDkl1Y1KF70CHdi5EFGKHANK5c4cY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgFHXRM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbgFHXRL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 19:17:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FE702085B;
        Mon,  8 Jun 2020 23:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658230;
        bh=SIl+6gDDlAgE5/oHLwCHDU0dl1CfSAmHwDjMoN+E624=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLthxuXYvCYJ7MI8sg9feveoDnJzzFyhGAh7aPcuA0SRknYTkEimPV3bmB5DkvjLu
         17Xd7yUTDyBttw0TAB21CVrWFfixwf/Z+nEdxTaBo+BtRFahxRCoRVp254D9zR7Ap6
         axi4IpzbCSr8FPvBqqGZUSsqcHy0I/pZI2DxOBJE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vadim Fedorenko <vfedorenko@novek.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 243/606] net/tls: fix encryption error checking
Date:   Mon,  8 Jun 2020 19:06:08 -0400
Message-Id: <20200608231211.3363633-243-sashal@kernel.org>
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

From: Vadim Fedorenko <vfedorenko@novek.ru>

commit a7bff11f6f9afa87c25711db8050c9b5324db0e2 upstream.

bpf_exec_tx_verdict() can return negative value for copied
variable. In that case this value will be pushed back to caller
and the real error code will be lost. Fix it using signed type and
checking for positive value.

Fixes: d10523d0b3d7 ("net/tls: free the record on encryption error")
Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Signed-off-by: Vadim Fedorenko <vfedorenko@novek.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index ffa3cbc5449d..34684b98c792 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -784,7 +784,7 @@ static int tls_push_record(struct sock *sk, int flags,
 
 static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 			       bool full_record, u8 record_type,
-			       size_t *copied, int flags)
+			       ssize_t *copied, int flags)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
@@ -920,7 +920,8 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	unsigned char record_type = TLS_RECORD_TYPE_DATA;
 	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
 	bool eor = !(msg->msg_flags & MSG_MORE);
-	size_t try_to_copy, copied = 0;
+	size_t try_to_copy;
+	ssize_t copied = 0;
 	struct sk_msg *msg_pl, *msg_en;
 	struct tls_rec *rec;
 	int required_size;
@@ -1129,7 +1130,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	release_sock(sk);
 	mutex_unlock(&tls_ctx->tx_lock);
-	return copied ? copied : ret;
+	return copied > 0 ? copied : ret;
 }
 
 static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
@@ -1143,7 +1144,7 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
 	struct sk_msg *msg_pl;
 	struct tls_rec *rec;
 	int num_async = 0;
-	size_t copied = 0;
+	ssize_t copied = 0;
 	bool full_record;
 	int record_room;
 	int ret = 0;
@@ -1245,7 +1246,7 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
 	}
 sendpage_end:
 	ret = sk_stream_error(sk, flags, ret);
-	return copied ? copied : ret;
+	return copied > 0 ? copied : ret;
 }
 
 int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
-- 
2.25.1

