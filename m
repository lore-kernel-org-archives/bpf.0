Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93AA3A383C
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029555; cv=none; b=qcHFSDx/IpgvCapoLTGy1V1jUGJbQeZfKCvH/7zL23AYDB+S0V52ImrhwZM+FKn1qeTpPEeRYiJeKGhRAxHfMripIoqBstjAEjRFtbgiziUKxgnm44oTQpJNo9eeA4djJSpK7BwmROgW/CK9eZPUs02u+bSQveuYOQGO3FbFEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029555; c=relaxed/simple;
	bh=lMFtTDGTCvVhvql6dY4AgQZ41cktbOHo6Cm5jpHgpeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPIZ7LkUnfiBtjdGAFl9YJRRvKNLcdtx4lH7jtGfxj27oFoQbhQuz83oBwJ9GBjsf9QXTPii37uo4GEvTEC5t950ccbpDU8r0LnZ72FfnprfMzwJpP2uZt4W1IxXlG5A2FCFlwiOr83k9p8PsnorNxwMVUrnVFwl6MFuVKVMHHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=sHuKzStH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="sHuKzStH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ceb096e675so29867935ad.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786029552; x=1786634352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HZHAiU7n90MzvUYuXvR9xtuxpe05p3NVzrsRdq55ods=;
        b=sHuKzStHCy2L3I+QuGj0JFwHAxrdROXcme49jsRWOlEb673MzOogFW3Vqd43/mXpxa
         FHKFaw0l+G2T95nHy90M9Go8dQge429VrRs6Apf4WBGYCCsULPxsmnwtiRFQGy/X8z8q
         mQ7PvKBCCTtNTuEki4WShZzKi2u7HlZQTtV6XQX1RSupRtoK+dZmvRW1QJ3jSx2hfon/
         y5oDOcmmIBYLbOpfshPpD3HEkbIpWifmJk2gMgOS51apMh09ncVcr0anrEDt6SqLxIbR
         el4xgpiw+bnrrhq6yn1UBwfD/dflWaT1eFiopb/D+bIYT8C+vAysuDzbGpEq90YOmqfM
         a4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786029552; x=1786634352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HZHAiU7n90MzvUYuXvR9xtuxpe05p3NVzrsRdq55ods=;
        b=MR97vvfwycA1T7NgxoJ/RMENVvccjEczt+heEa1EqZ2RjhfuUp217B0Bi8onSBPSU7
         x/CDpJmy5Hk5/18RLX4wrZQS1jVV6m7rBP7/unvYEvEaaG7Xm4KJZu4T2+Xkh1QNlzlI
         FijnOqrchFxFEd/wdOrd6TJZqjhRGXB9kgUmA9Pu7bmBFOihqXwYqBjZU31M1amx77eP
         Spfd8BtC2qQxi0dCZQPnliTg8aru/LKv1+XcRpHAYUO20ydFrDIRjww8co9EXwmkdi65
         zhUEOSSr9khBz3pze8dq06y50ib1SmGQrw34h1PD4whYpjrJh2DBwO9rXS6hqc6u1Jc0
         qoug==
X-Forwarded-Encrypted: i=1; AHgh+RqmEt2fSreVGxRKbzrF2FLZP4qsaoqq+WwoUxFsMr6eRkrs12AZe6uQ9mkoxw1PpX9DSNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztMkICNDlN7XQzUR9kHGfiqaqoCKybClsVZ7kVghwXuNU55LAI
	xNU5KI3t30slwVVj8YrjSlR1R7PQtTJ3AxJbTbAq81brJi5YddZTvNnpIHM3DY/7VF+S
X-Gm-Gg: AR+sD12P3G7eZhlBmzV1q3O5ql0WQWBZjZKG1n+P0JamuzxcLfk/F7rvcRyUUJXIQQw
	wB3dXo7Qan/Zl8ZnuyBb+KcQOW18NX+aOYp779cr/w5sJwpt9ZzMZab1fOwbWmVdibvXGWsP4aH
	dSQ0KiS5hcoRwPSz+L6YJtm6l2U7XSx1tbhrW+BH4aI6pTdi7nktmFNymuZeBl1SW+/E/Tskheg
	KLoDrKLePPxRHMSTHMDmReM2bqJiuxQMq3yaB4A3N20dZspLjQ2Vcr0Xs3f6i/SSiqdanGXaO9Q
	BOFh24OJigF37CAMTu7gZEJc1H4ErjvLvL/SR5MIDPzXT9XdJLblM5LqrihJw8H8juO17Tj1eMC
	VPaIIZFYAz8zmO+rZ58AS703J4Trl3+bY47aFVdsintW2vEsYlHHq/MNEoe1xDEFZ8M0LLnvGYz
	HnoiQx7CO+Z1f9Ox83CUsJtfx3/4J2s1MMX1zGZNyObF2dEAkocvnf1vPDX35j3iqnKQyG0SfPD
	1gURzcv+IqEqt4=
X-Received: by 2002:a17:903:46cc:b0:2ca:d172:7228 with SMTP id d9443c01a7336-2d0ca7fad2bmr204351875ad.11.1786029552042;
        Thu, 06 Aug 2026 08:19:12 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa493118sm33680785ad.46.2026.08.06.08.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:19:10 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	kafai@fb.com,
	joe@wand.net.nz,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 1/1] ip: orphan prefetched skbs before multicast forwarding
Date: Thu,  6 Aug 2026 23:18:56 +0800
Message-ID: <f968f497251dedbd1263c322a7c4e3e1a727161d.1786023177.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv4 and IPv6 input preserve an skb->sk association installed by
bpf_sk_assign() so that local delivery can use the selected socket under
RCU. IPv6 can also get such an association from udp_v6_early_demux(),
which runs in ip6_rcv_finish_core(), after ip6_rcv_core().

The reproduced UDPv6 packet has a multicast IP destination but a unicast
destination MAC address. It is therefore classified as PACKET_HOST and
passes the UDP early-demux check.

When the multicast packet is not locally deliverable, IPv6 hands the
original skb to ip6_mr_input(). IPv4's ip_mr_input() similarly keeps the
original skb when local delivery is not needed. Either path can put the
skb on an unresolved multicast route queue or forward it after the
receive-side RCU section ends.

After the prefetched socket is destroyed, a later skb free invokes
sock_pfree() and dereferences the stale skb->sk. Orphan the skb before
each non-local multicast forwarding path. Local delivery retains the
original skb; the existing skb_clone() calls provide multicast forwarding
with a socket-free clone.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early demux")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
- Cover the IPv4 multicast forwarding path.
- Correct the IPv6 early-demux ordering and document the unicast-MAC
  PACKET_HOST condition used by the reproducer.
- Add the BPF socket-assignment and UDP early-demux Fixes tags.
- v1 Link: https://lore.kernel.org/all/02db4590d0161e31a789dcdfa8d1be1a3212ec2e.1785724784.git.zhilinz@nebusec.ai/

 net/ipv4/ipmr.c      | 3 +++
 net/ipv6/ip6_input.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1d9a4ac14fcef..e5f2b1c6150d2 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2213,6 +2213,9 @@ int ip_mr_input(struct sk_buff *skb)
 	if (IPCB(skb)->flags & IPSKB_FORWARDED)
 		goto dont_forward;
 
+	if (!local)
+		skb_orphan(skb);
+
 	mrt = ipmr_rt_fib_lookup(net, skb);
 	if (IS_ERR(mrt)) {
 		kfree_skb(skb);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 8972863c93ee5..d332ec60f9150 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -622,6 +622,7 @@ int ip6_mc_input(struct sk_buff *skb)
 		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
 		} else {
+			skb_orphan(skb);
 			skb2 = skb;
 			skb = NULL;
 		}
-- 
2.43.0
