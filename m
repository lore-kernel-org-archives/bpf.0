Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655916;
	b=AwKUB/LmumYblvhMGdCJ6d4fybiC7IOBNwotCJEiUygTb+gsPrZgPGi88bDYrSHu9TX8
	 7zWdsCXpHScuYu/XAdC+H+9YW36u1RZ594A/CMv98SosQJLkUVbNZ9Pdr0v9xytve64AK
	 Ajm/8fbJ/2jYmJOIhua4vO0Zd4hHygPZpaWXAEFqO9PRlInS9W/Ail6G+nUmte6mL1ROY
	 dBhkU52aE2ua+MpEHL7BFTtyslhIpfzg3bJOYhck78ohLqZ1LabldFwNt8RQGmhU0SUkz
	 sz/B3yw6/LAjJk9M1WOv3QdIuSRvgiFdDKHMywYh2x4DA/PBxyNyPrc0uovdO3XrIDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=e9QupjioPz5jmuw4QB1bwofY1LQtoFeM5H2RCzVGzzs=;
	b=hCxSgTjvsNKRV6AAy7g93ZIvmuflpGEK0v7MohnECILWZwoa8Yp4XsAPpB7l67Aj54u/
	 X7DO8KzIh81JWK9iCKJE3pOXE0LDj0ouobQ6sVgGyE30ME12rd/SQE3NMoA5z0ACd3Hwz
	 eeBsqgRbksMQ3dlkQIiwQlRCtvIFnyGMZcpcG94/l+RST129ZB6AYQ/fgOMFJ7XSlJHZP
	 QGibmZM/cMk2uWX4FmjAjSXFjzpnu7O15G2JRhBwqoN6rR3QgubnlxMaTHJmvs11mAcdX
	 UhWmMPOBRH8X4XW44NUSgXCGteawxqVZpmxuyPw+dxyVWUoAOhC9BAukVEwqOsfa2tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=MOmCpHLf;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD9606A31A
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 07:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94DD9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=MOmCpHLf
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535a54bed9so2263530eec.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792655915; x=1793260715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9QupjioPz5jmuw4QB1bwofY1LQtoFeM5H2RCzVGzzs=;
        b=MOmCpHLfRrRxszlWMesw7LXP73FvKUuNJxjueJUh2GP5Lgp7c5W8XzEplOmlpKpIA/
         /qlAYztRwYP3FRv2mx89p65O2EvkFDvJCJLvjG2G7YbY1hEUnEsV+UDK9ZAL8bPFZsQT
         Eua8a0evDCZik0BxnMzYAWL42v2cbNMKQgSLGsFhgbKvORaq+hhSHPK+HZZ2kOqWSaEr
         Xgn2tQI2xGP7HvdvmmcJNxkyZYuIJZPKB4fw1kplAfWVj6RgWwVdRHkyWCye0vDJJNks
         FrG/CdvprlxFfY56PCXF2KT477CJ4EmMIc/Ky+4OEzA60dDj5Gz5DJi7v7tnPE8Q3hB5
         Ckbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792655915; x=1793260715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e9QupjioPz5jmuw4QB1bwofY1LQtoFeM5H2RCzVGzzs=;
        b=w1xGnPykezAhAdM21s+CJWTyh5s2cdwRZhdex4H+dG/5cyFxrC5ydF+9caf3eaukiA
         EjwTW0bF1aQQPuNLOxtOX/4h3gPzVmw9lIr5zhsvS6KU0dsxSGyCRSww0fwZ9RIhRjXC
         VSXpfjsD5bMAWBDw2qjSCMmntF2fyeFt3k693ZaNsrVEMbUquZrrDkBr7LErD7TSuEZ+
         7X5ftgdu9ZKF+JkzdjJctJnz4fnHaocbmfssaCUZgz49dgWB6Th8zHDipqgVsJk55G9g
         npVs2oHs1+E7OasHy7KS5qPNVpd1C+eP01mufBLHoVjskf52nqPucLwN4OadNloOIkPy
         llmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzCB0MYEHCuIDNvg+hPotq6Ye9NKI10ma9bkTlG/illdIeVq7ZbcV98mld9y8cPTSWMrE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKm1Qev6PMRmBXNy5x97jmgqv5ZFqT/Y+2jPl2lTbF3upaunjqp
	+JJg8A5YfKur+XsCCXKW9hVmvHbe9c1w9or3L3amkjuBOV0OTcAt8A4l1EOs8yz+/B3qZzwJRpm
	qQTFs+FO3
X-Gm-Gg: AYBFou2dJol/+nSRC3Ut4kbGt9fnxB2+f+XtS6xtZceEPse0UVepcTF2W222WMSxRbN
	4NoKGiUCI5rZq+y1lYCDbvCxvTrcM5/44rhS+FU2wLo3AYvWKDZYvnaLLt9RYpyD5Rr5FqxE1uW
	9dA4ZRtxPQqMtxX9VhJKBtbseDxmFsaqY4KyFhHAnNDvsqnStmP3sr7tM8IfOAA0Ie5tKOdTIWy
	v1jj5UAsh7w4XjDji6Cc9IlH6/XDafIAa3PO8b7Uauz36g5yk1d5DF0wDKa9eu8kBK87dHoR+YK
	xeWExh6IoUivDN4u7qbctJoGkTbQ/ZBNST+w4yU0UDyJPJgThKpD0XgWzIOM4d588/ZDQFqUA6D
	D41GFdpJn1Aw+Q9TCX3sPoyh2rRkpHeuxJQQbSGCtVfBdyuv/DkR0jLnluMqbI9TtUmLj7ENKUU
	ZDciOjw29VcU2KoS1b/yxyyZO6IftoGBUGyP1a0f6BqetcHtuQn70f5hSb3Kz38Owhl+agQoAtk
	TCtHOFDJ+EL4+JCdkq4WQIjwZt7EavANy+T/5s0+ZvszNpmA+Zde5dH61hbIyeqFiT0j6Y=
X-Received: by 2002:a05:693c:42d9:b0:367:e68b:c047 with SMTP id 5a478bee46e88-367e68bc08cmr5101290eec.40.1792655914708;
        Thu, 22 Oct 2026 00:58:34 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367417a2fadsm13580451eec.21.2026.10.22.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:58:34 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] xsk: validate consumer ring producer index
Date: Thu, 22 Oct 2026 15:58:18 +0800
Message-ID: <d2b51708a3ada3b12b986224ee8340ca7ef5b3be.1792654486.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792654486.git.zhilinz@nebusec.ai>
References: <cover.1792654486.git.zhilinz@nebusec.ai>
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

__xskq_cons_peek() trusts the userspace-controlled producer index without
checking that the producer-consumer distance fits in the ring. In
__xp_alloc(), an invalid fill descriptor is consumed one at a time until
the cached producer is reached. A one-entry ring with an invalid address
and a forged producer index can therefore keep the kernel in this loop
for billions of iterations in receive context.

Treat producer values beyond the ring capacity as an empty queue. This
bounds the consumer to the userspace-provided ring size and prevents the
long loop.

Fixes: c5ed924b54c8 ("xsk: Simplify the consumer ring access functions")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/13760
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/xdp/xsk_queue.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1bc42c8902f4b..315b656534749 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -344,6 +344,9 @@ static inline void __xskq_cons_peek(struct xsk_queue *q)
 {
 	/* Refresh the local pointer */
 	q->cached_prod = smp_load_acquire(&q->ring->producer);  /* C, matches B */
+	/* A malformed producer must not make us consume beyond the ring. */
+	if (q->cached_prod - q->cached_cons > q->nentries)
+		q->cached_prod = q->cached_cons;
 }
 
 static inline void xskq_cons_get_entries(struct xsk_queue *q)
