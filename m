Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533183;
	b=weKApC0sKotNURtJzlDxu2kWoUUvuuii2xgNaJB7Gu855p0aWspV5+93tYnBIfYcmwpR
	 rF9EBrOcaXtal4/zkGTq2oZbaD1w7CBiqKcFe2CkAdG82ls8us9rYNBip3Ebgf15e6QCp
	 ia9/ExBOSGYMYUcFoWOxcaoNXf1Yah1NSj6y4W4bkjKh/NW9RRDet8KEiWwlqnpDQKjqc
	 1dmMxZzkt+hC2TxFmWO62rg4pzVxDJAhh85y3WEgRKQa/slT0OhYs34rpsOUqdCFmBMUu
	 F//SsrBDhAHiMeSNX/DT0VSQwPaB9Ue3eAIc0VBgDLWKZBFxLxXq9YqG/StW/Xj2B7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bxfHWkkO3nvxyaQCZVAlCuVZFf2yV4v6dH4CBU9Lclk=;
	b=hXdovU0LI5lMJgP+7sNa9cZRYiPc1C8LSAOuvt2DugdJalgQVIA7K4a/wrhkpGcesp3i
	 6V5BIUzMvqzv4+mx+2pJ7R7E6iLOW15z0LoDJUiPqtB354rq0OObLoy/s1c/MausFehS0
	 KlKIG0DHvnc65wuNlV2a+kmXQIuoCTpnSZgloSmSx1j7JBehVTTEf59GNqAVDn8DWNGvk
	 TdgtR/hxKEXQaWMZRKiKjGk4UwjXmzYezIUt2m+vtssK6JtfuybWFEIUSy0KFR592ASFn
	 LR0Tb5AGFA6ZffJFbI93FIoZ8D1gw9hpYZdqPcGAChPRWxk/SUezmAyzd71Jlov51OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=GWP0tpkz;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07C606A33C
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E07C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=GWP0tpkz
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so36284295e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 07:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795533181; x=1796137981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bxfHWkkO3nvxyaQCZVAlCuVZFf2yV4v6dH4CBU9Lclk=;
        b=GWP0tpkzfhpxD7juj58vRe+R9am9qiGRL76oXsfgW4wWCvOS3MBZBJ81MN8NWGOXc7
         KESusgv+Ir2B8ksirJeBtTPVOtzC5XX5gtFjsFds5ilBa+fUtHo96U0qyTPzG/E0UYjs
         B1x2UFAYU9QMhkptLAriRIvp1xnNMnYNpJsXD3YzB74YlzIkZIbT9TnPzKHh4HNmDsk2
         UocVtxpZJUqho6rva367a0nSqkiFULr5ZDt5bM/D4mS6DVQArYYLHS+5Es5y5d8QwHEs
         nunWuMm66AP5ypR333hGZtqxukMdTHk1h0+IuJqWiOyyRC4cBSR+lcbeGmVIAo5yesFB
         8nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795533181; x=1796137981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bxfHWkkO3nvxyaQCZVAlCuVZFf2yV4v6dH4CBU9Lclk=;
        b=G9FxO9rDEAWTX3gJvF8ZtULaRGbbTN/Jjge7ex3/zzd0GM+qHuMIxPOJWtzUlsd/Gt
         kx3/dMSQIYRLucDJNoHl+M8x2VcUau+IyiVyPUv1o7SLhVBI5xkf47n2UTVcD5EfLjn0
         9t/y4uPjByoUhbry+Rb61+mp8V4sXAiFLanUyGJ4B+jnOYiLQ/r1pgqh2NBEyOM7Gns7
         6ysvMVe63MbyuH2s2krR0+4RkPkBWqy4Bvtl3ByxSXp/3D8IyRZJBh6EceqpELBj4Zb4
         kvBCjjb7f4QwmcYdnzvpOyJr05AMwF+dmB/9L4GF8VAb3LZA2mTJRl7sACZESqyYzFzr
         LAVQ==
X-Gm-Message-State: APuU4Z8pjSkdSm3WsqzZAbpSyRYayJa2Sux6ZbSBfKVMFb8i+TyOwWOk
	npbdnW0EIvsYrmx6RWJ5YOSP9/wLCOAaapb8chXMcur904jJ7uIKSkSTNgBuqxTEfKCw1L5xBb/
	HtawdXbXHYg==
X-Gm-Gg: AZFdTZf4HeZmrn3BGrQr4sdm785cbIpiOfOoYr2K0Tzze/FK6DCcCpBcEUgLDKeu3EF
	rfRZrIodFPa+Ncx7jtGG08OW5nxTRObw9yxXqatm7zqxHlSZ1hwVI5EhS1wSCSuVPTB8uIBkRNZ
	mx4tsNCJmhVRPOCvdbIVof+MZcH0AW4YDTsRP33gfeuicyeOORWnhp3ymct2qTx1jkpLMPFxoVS
	BtSJjryynd8ZcwygGIWLj19WwDuEsT/1sJlCdJLdjBsI8MDUL+oL5wyl4BO+zEc2uQoLCT0kUVm
	qDEOSIFj8nWsDYYm4Z8nEQ5NT55sjf+5drLOdbzZddCDEnekjNiUydgAQ3qfFZDfkBltF2Tl7oP
	y0yKgfIZXCvZsB9p6fwQ5tBRCs0XXIycXv4irtFDV3CZnZXu92dnmPs5xbetK5gPod5lWvwaWz/
	aU+fEVK5WwjlX/J5VKgtiPOv4f7WJa/IqJANAZCY+8HLCoAhjTH7ztk++SHcIt5343ATC7cp+R9
	sv10lOKa8Fp47rqudqe72k4vfkkYf9JOszffh3QkD+rhN79iu78HVqM4yDo0BRzijXQTOzyybWz
	IpWWeZkB4Dtbp3wwOhasR6TDpceJIH0EO8wMDLzmIUVkH9W1uXo=
X-Received: by 2002:a05:600c:c4a2:b0:4a3:59c9:a744 with SMTP id 5b1f17b1804b1-4bb88807d87mr316098875e9.7.1795533180883;
        Tue, 24 Nov 2026 07:13:00 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6c61e53asm29763135f8f.59.2026.11.24.07.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:13:00 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH RFC bpf-next 2/4] bpf: preserve owned socket assignments on ingress redirects
Date: Tue, 24 Nov 2026 17:12:42 +0200
Message-ID: <20261124151244.1423343-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124151244.1423343-1-razor@blackwall.org>
References: <20261124151244.1423343-1-razor@blackwall.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ingress assignments can borrow an RCU-protected listener, directly or
through a syncookie request. Redirects can queue the skb beyond that
protection. Peer redirects also cross into another network namespace.

Keep an assignment on a redirect from TC ingress to ingress in the same
namespace when the skb already owns a full socket reference. Acquire a
reference for a borrowed full socket before queuing it and use
sock_pfree_ref to release that reference. If the reference cannot be
acquired or the socket is a request socket, orphan the assignment.

Orphan assignments on peer and egress redirects.

Fixes: 7ae215d23c12 ("bpf: Don't refcount LISTEN sockets in sk_assign()")
Fixes: 9aa1206e8f48 ("bpf: Add redirect_peer helper")
Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/core/filter.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 53c042b267ab..3206b40887c5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2546,6 +2546,41 @@ static struct net_device *skb_get_peer_dev(struct net_device *dev)
 	return NULL;
 }
 
+#if IS_ENABLED(CONFIG_INET)
+static void skb_redirect_prefetched_sk(struct sk_buff *skb,
+				       const struct net_device *dev, u32 flags)
+{
+	struct sock *sk;
+
+	if (!skb_sk_is_prefetched(skb))
+		return;
+
+	sk = skb->sk;
+	/*
+	 * tc ingress redirects to ingress in the same namespace keep a
+	 * prefetched socket if the skb owns a reference or can acquire one.
+	 * Other redirects and request sockets lose the assignment.
+	 */
+	if (!skb_at_tc_ingress(skb) || flags != BPF_F_INGRESS ||
+	    !net_eq(sock_net(sk), dev_net(dev)) || !sk_fullsock(sk))
+		goto orphan;
+	if (skb->destructor == sock_pfree_ref || sk_is_refcounted(sk))
+		return;
+	if (refcount_inc_not_zero_acquire(&sk->sk_refcnt)) {
+		skb->destructor = sock_pfree_ref;
+		return;
+	}
+
+orphan:
+	skb_orphan(skb);
+}
+#else
+static inline void skb_redirect_prefetched_sk(struct sk_buff *skb,
+					      const struct net_device *dev, u32 flags)
+{
+}
+#endif
+
 int skb_do_redirect(struct sk_buff *skb)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
@@ -2558,6 +2593,8 @@ int skb_do_redirect(struct sk_buff *skb)
 	ri->flags = 0;
 	if (unlikely(!dev))
 		goto out_drop;
+
+	skb_redirect_prefetched_sk(skb, dev, flags);
 	if (flags & BPF_F_PEER) {
 		dev = skb_get_peer_dev(dev);
 		if (unlikely(!dev ||
-- 
2.47.3

