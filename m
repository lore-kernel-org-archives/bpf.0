Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562282;
	b=2MRzgBEEv6MzjV2WSsaF8/pgmERk2E5OpDNWc7OrVBlTTRczDxZ8dBJi4D6N6an6vWXL
	 QOKlvYRohmWK2yrKFP2dmyfl957KzHcaRsQTdOlhzyMzeHKnDaIfeTFYF+LQHeconn9TD
	 ThHSXQd27WGaaiqNprf6B10XY9K8roh/pqDAu/GN2lvRazg/o8KglkPsQwNh+vBrCDL3g
	 F+UdlFqpPi+uTkt6BxxC7rzj7dls7yrLRKDteJOR9PDDC8ZpQwDxMgwCq5TW0W8/M8g2I
	 b0JVNUTqlQQfwc1GTmd1RdzA5j0F3C52vs/H+54eYIMCmSZq94C6hR46BpYUVXgb9wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n6JuWpF+eef2V525L5oCizLHk8iadx9qRsILopmNHm8=;
	b=XHcR7yH/Op6HUkgFjNrin+DJuP4yF9BydBooT5zcvvCz4Dof2Y+Zb/h5EhMpn0nM+TOR
	 k/n3rFKKX0WJMBe8LtZObZ8b6B734sS4bfe09U5pmVHxAkm2GyCxFQMoVxdO3OsifWYUv
	 y0jzEhPO0s6CM1V5SR7rolRv1RiTP8roUaFsQGHc9oW2HxVQRBjZ1PbtGrvRCx1rLQRG0
	 lPFSxbizHvLGPhcq3tJ79Shzz+ze1Xsvqf/6r4ss36AbyQ5PAGmdCO9wjPMbBY0YbIY+m
	 KZh4bVYXpi/Qe297FSC+R3AQ97A/0JbMt2HAgHnDRCmH8Iwm19Umt9HX5B7hSrwABLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JMfzN6r6;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2067606A32C
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2067606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JMfzN6r6
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1816723a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793562281; x=1794167081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n6JuWpF+eef2V525L5oCizLHk8iadx9qRsILopmNHm8=;
        b=JMfzN6r62tAPM45iQwOIp1BthxUrUWJaVIkoUWk3ykeDifSIkN2JBh1At4A8kMyO3K
         pjOt4MzNIt+mHsnQ0xoajiUApx0MFvsPC5nPp4SXnt3KHsONDglCjPED7N0XcRWjoyR+
         aHFKINocDldisxAg4byJp+qkByRH2mEY/+XRzjEzzEGNT8Lo6VGB9KpbK/3/0IjB386L
         UWh4lrL32PtUK3AjU/H7tqENxFH6iibw5UbIiAY1Vf/84GpbVDttAVs5lsvooUXJMFaX
         M9L4y7c6+7l+RVum0NFY6nniMYGdwKVdhzcj+VrHQKGrADFJvYIqgbJPSmWl2lULln6r
         MLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793562281; x=1794167081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6JuWpF+eef2V525L5oCizLHk8iadx9qRsILopmNHm8=;
        b=u97Z6zzSN7fejkpYJMpDqUqhIo6oQzFpscgjEySvfXirV7rQlsVBaRujPbLwmFxgQL
         7t2+uF7+gSl7D4Ia92zAnNI7cKUnve4ZhuwUnDlPz4wcArdVBOt2Kwk+GBShsDXvS25L
         ab+tGgGDE2CfH9H5p7LJya42oFziuCaiPn2oAqP+OXFuCC9qBHpeP3gEz2Gc1FniLdtu
         Ut4McoleDinEkyd+unwskRMsC24sjxsrWpTdjrHTNdGNkBYID9RjUDlj+Yv05bDCl9zO
         /wSyn8vHMN4aS/dCXUJb/fymij2JVboJOpxY2wZs1WYl/16bIruuJAD5efTMKk9/hYkg
         wH9A==
X-Forwarded-Encrypted: i=1; AKwUvBxnPDMg5uCGyVXKI95Q+65fGpPNy8tl40fa65iCeh2MawmC+MSdrAhxI93FJ4iSfohvYzI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TnRPwKKOAcJPZiQp8mnlx+lRil+iNptmtiiOlpoten23j4NgG
	jSFuLS6gsvMpvALduLPvL65fugEtudOhQoPMP6Bje6s9YOBahQ2e+UQU
X-Gm-Gg: AYBFou0T2HGlmtPOvXLa4ANWgxuQvEyJzrzv7KJi8l2WKhByxrI5YGTBEwQ9NY1gjTp
	TB9PNFgOFqJWITkJzcAVlJ8X9kFnmJetJnghIiFiiFJtsJxQHco6pANN6mC8bgSO0TgNv9uBN1t
	ds6NiqBE/UG1is77KkGuEdoXbKCmqOfDpXhvdM8Wf9xi9uUCFiVcK0h4SIEkwBa0G4H7nx/Fbb2
	XQLsySy7vSUXvZbcXxh9Z3kXkiVXGCykSVJr2k6GM8X89UK5EzCQUMExFfRgxjP8+MS+NQUOvak
	2dX3YDXoDm4y+fsUcXfAhn9EjN5Y4wlu6pR03qA4BQDGjWenz7fh5f5ggYsnuYLnvauiYU7TYZw
	WC7MDoyD7lVi3lDDeV8T80W6OCwwQPJ7kgUGk84r5W3TUHZTD2mcIA0E65Ux++dJqCOx7pzODzg
	rALw3LxunhOe1DswrA5iCZGO4+6qUXwNHpOkP0xFZQZIM6hZKn10rPb6PELZlf8s5YSWxT4e2e7
	wYzT7gRFWvOx1UhoQu4c+ouwxntajRGeGXyMfOVNmExRQWimzi4EQCWkGWaEBFHrLEllJVPOzAm
	bNgyCuxUOtBT6bYnGfEnDTn3AKpxwe6PfsnpLeJhTHfqjDPsWGeX5M1rhckBzFYoRxIx5YY4Qv9
	mcbdExOl8KGPfDlbaG6Dq6Z5IgC8DI4/IVD2Vrj5SKKgqoK1C6N2kEMA00l5F5aZP/og7skyIUb
	A=
X-Received: by 2002:a17:90b:2641:b0:3ac:8446:c1b5 with SMTP id 98e67ed59e1d1-3ae8974b804mr6376412a91.31.1793562280788;
        Sun, 01 Nov 2026 11:44:40 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae881c5624sm5824167a91.4.2026.11.01.11.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:44:40 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dongchenchen2@huawei.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net
Subject: [PATCH net] net: reject a negative TCP header offset in qdisc_pkt_len_segs_init()
Date: Sun,  1 Nov 2026 19:44:33 +0000
Message-ID: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

qdisc_pkt_len_segs_init() stores skb_transport_offset(), or the inner
offset, in the unsigned hdr_len. A header in front of skb->data gives a
negative offset. For an offset a little below zero, pskb_may_pull() gets a
small length and succeeds. Then a 64-bit kernel reads the TCP header far
after the skb and can crash. Further below zero pskb_may_pull() fails.

Commit 28a57fb2c5df ("net: iptunnel: fix stale transport header during
tunnel decapsulation") fixed one source of such offsets. Other code that
removes bytes from the front of a packet can leave the same stale header.

Return SKB_DROP_REASON_SKB_BAD_GSO for a negative offset in the TCP branch.
SKB_GSO_UDP_L4 and the other GSO types read no header and still get a wrong
qdisc_pkt_len(). On a 64-bit kernel only packets that cause the read after
the skb today get a new result. Then __dev_queue_xmit() drops them and
returns -EINVAL, but sch_handle_ingress() ignores the result. Their content
can be valid. Thus the code that leaves the header stale needs its own fix.

Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3ac700d37e59..ccf4b02e08de 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4320,7 +4320,9 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
 		const struct tcphdr *th;
 
-		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
+		/* A header in front of skb->data gives a negative offset. */
+		if ((int)hdr_len < 0 ||
+		    !pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
 			return SKB_DROP_REASON_SKB_BAD_GSO;
 
 		th = (const struct tcphdr *)(skb->data + hdr_len);
-- 
2.55.0

