Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335644A71C;
	Wed, 29 Apr 2026 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501804; cv=none; b=YOf4UjePE6QjYMNbvaXTiHXMZ1vp9DHIZOiVlQkrgbQq/DfBr2z/cL3pgetvRVy4eVdnC3kQJjIHMqz8czqelbdk1nRA5Ehysl3oKX+2P8WHZ+2GQv/9s9TWNJXkMJxqbVextz4tCBCkFZ8aEvZso/rQcyxBTX61G8UeRSZiqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501804; c=relaxed/simple;
	bh=gxStN7puptl2OzPGmeQQ35YiwyxTD0P0ShvjvbKSLrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WU1tRuWels3b2rSVse5dXiXXZFD/rwuqwgMzcVRDqlBjnyiE4yWv5paySSH0SD0E2KRz/xuiPXmCeHyUyAqLzLifgUvaYxqMx8WG8PpmhJ/ozU1d42nf5wpwYXVCM+ahHPn+Khr28n5oEz/QwJlSRXXQ9xnsThhTl9/wwN88OQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLpYXsmx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLpYXsmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC30FC2BCC6;
	Wed, 29 Apr 2026 22:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777501804;
	bh=gxStN7puptl2OzPGmeQQ35YiwyxTD0P0ShvjvbKSLrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLpYXsmxV0qkE1BQ1wg2YpPmlkeKFEbx2OQP7jQGKkdQUpMSOEGqDgkB0xFq+p4JT
	 p/8JpM3/sfvumSC8tmprPFERme0zXnXegI3DW1BRza4mg/bgmqo767CL4WtC6lwWLR
	 XFQ/VVc/WgHJ4xYc61ZFMQpw++VXkFWzCGu2hTFLexiC1OtAnSn1ELdVJOamWlAZS0
	 voINbBSaPt+9W/Q2Pc8megvIi8P8o55gAp/OXWCrs3Q3intOx/M1ZHCA4zAaQ59NCp
	 m3AxVhcVytEHbkeCdGv9B0IGn5o3xb4War4oRE/cbdJjAL7Tlrsi+8qZF7wbpzjZhr
	 jsvysamL6G8Mg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	dhowells@redhat.com
Subject: [PATCH net 3/7] net: tls: fix page pin leak on sendpage_ok() failure
Date: Wed, 29 Apr 2026 15:29:40 -0700
Message-ID: <20260429222944.2139041-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429222944.2139041-1-kuba@kernel.org>
References: <20260429222944.2139041-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iov_iter_extract_pages() is called on a user-backed iterator, it
pins the extracted pages via pin_user_pages_fast(). If the subsequent
sendpage_ok() check fails, both tls_sw_sendmsg_splice() and
tls_push_data() (device offload path) call iov_iter_revert() to unwind
the iterator position, but iov_iter_revert() only adjusts the cursor -
it does not release the page pin taken by the extract.

Fixes: 45e5be844ab6 ("tls/sw: Convert tls_sw_sendpage() to use MSG_SPLICE_PAGES")
Fixes: 24763c9c0980 ("tls/device: Support MSG_SPLICE_PAGES")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: john.fastabend@gmail.com
CC: sd@queasysnail.net
CC: dhowells@redhat.com
---
 net/tls/tls_device.c | 2 ++
 net/tls/tls_sw.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 741aef09bfd3..6aae8d04f976 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -508,6 +508,8 @@ static int tls_push_data(struct sock *sk,
 			copy = rc;
 
 			if (WARN_ON_ONCE(!sendpage_ok(zc_pfrag.page))) {
+				if (iov_iter_extract_will_pin(iter))
+					unpin_user_page(zc_pfrag.page);
 				iov_iter_revert(iter, copy);
 				rc = -EIO;
 				goto handle_error;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 2590e855f6a5..906a1998c630 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1018,6 +1018,8 @@ static int tls_sw_sendmsg_splice(struct sock *sk, struct msghdr *msg,
 			return part ?: -EIO;
 
 		if (WARN_ON_ONCE(!sendpage_ok(page))) {
+			if (iov_iter_extract_will_pin(&msg->msg_iter))
+				unpin_user_page(page);
 			iov_iter_revert(&msg->msg_iter, part);
 			return -EIO;
 		}
-- 
2.54.0

