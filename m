Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598F3947BF;
	Fri, 10 Apr 2026 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775805825; cv=none; b=DDoV7TOmpF5ENFOM3i+aqQ65Ps0KkDkv6eWqY43fnlGg22SzHijUYI9Y7ZPRgZjFsHNQyoh6hBofnd3/2XCcIVOw5YP5q3ySAGoKu6DQysTdF4ZZukSwZIMuY9dF67em4oMdDI9Y9ZhDLlWv3/9VU2KqwjGQ+xoN7XblLKysGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775805825; c=relaxed/simple;
	bh=F02GTmyztwoQ2fvjIqxcS45Bug7ucY8ZsUcfJPTKadI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJwrmm0MxNcBqMNjumdTwYVVLd8UKf4h6nufbqil31TGvxfIuxM77CDgc6tkKdKoiFOG+hJdGRhWsNxuT6GkRVCb/CV4nY2spXUJ9dCzrkb/vALC9pW83YPwsGzBL3qHOgonKnGPm1Wva3fhWMbqU0KWNUNKc0Lbya+IiV967lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=PC2LSNY7; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PC2LSNY7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=PLfQbY8MxoAnWjqY9Nv2A9W1ulwoa5iAJ9LbkGQ8Tec=; b=PC2LSNY7PLXkx5b5tQHDldQuqI
	spNbib5ujzj5A1la9UmUxNCQ68kyNBw6rc7zfpthSnfpzX4Fa/JtPlsMfBnOw3cITn1+6HScjWdgD
	+1Wq/aD5a9opTntuCKb0T/ARPHGB7IUlSNNaqVxlfLqI8rECLYweMmBMSDUv9ggfywujAS4zK15gt
	1z2oQPrDdFq47f8KRmQC8NtHO2w+fCFl5659iLzjqBMt/qOkDoJrZInrowr/PcsyymsjE4x6Bc/z6
	Wn1wgjiql3ZGSI1+ppfpKqLLv/yPwaI7C4wZQEZp/Uf9J+71nobkcQdV+TvmiWhNa0P6e8uAnnfKb
	vC7Hsn7Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wB6DI-000Jx9-18;
	Fri, 10 Apr 2026 09:23:36 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	dw@davidwei.uk,
	pabeni@redhat.com,
	razor@blackwall.org
Subject: [PATCH net-next] netkit: Don't emit scrub attribute for single device mode
Date: Fri, 10 Apr 2026 09:23:34 +0200
Message-ID: <20260410072334.548232-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27966/Thu Apr  9 08:24:43 2026)

When userspace reads a single mode netkit device via RTM_GETLINK,
it receives IFLA_NETKIT_SCRUB=NETKIT_SCRUB_DEFAULT attribute from
netkit_fill_info(). If that attribute is echoed back to recreate
the device, the seen_scrub presence check in netkit_new_link()
causes creation to fail with -EOPNOTSUPP. Since it has no meaning
for single devices at this point, just don't dump it.

Fixes: 481038960538 ("netkit: Add single device mode for netkit")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 drivers/net/netkit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5619209329d5..7b56a7ad7a49 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -1214,7 +1214,8 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		return -EMSGSIZE;
 	if (nla_put_u32(skb, IFLA_NETKIT_MODE, nk->mode))
 		return -EMSGSIZE;
-	if (nla_put_u32(skb, IFLA_NETKIT_SCRUB, nk->scrub))
+	if (nk->pair == NETKIT_DEVICE_PAIR &&
+	    nla_put_u32(skb, IFLA_NETKIT_SCRUB, nk->scrub))
 		return -EMSGSIZE;
 	if (nla_put_u16(skb, IFLA_NETKIT_HEADROOM, dev->needed_headroom))
 		return -EMSGSIZE;
-- 
2.43.0

