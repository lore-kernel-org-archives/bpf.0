Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560046;
	b=T+0tMh1gQMhEELk8iN+O77/N9Fs+Ij9xRGOLXgw6CotHEOsRNS/kM0+L3TqvLpffB5pw
	 XapWv3wz6THFmArLQwdpLTafE3SGLjUY273psqpipFCsdLLF9pWiCyO/941lpiPBjxDmd
	 JywstKKOTjhOj6B0ApWjmmEiZxrNQh6SUxE75TWP+xOH1SFOeUcEfQ1qQxOHi8g+M2tK1
	 tFyYmgdadwNakp5RLsbmuZEzxFM6pYjfpugEWvxfWK6XOr2504rE2Xg10H9lvehlWSzna
	 8t3EaO235qJujwsisj73ll8M9Et2xrsu4awMDmerprc5g8V/3XzblIR82rUcUA/W5LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hdLZGGor63NFsd4FY/8+ryE17FhK4fXkO+4VAc8+Izg=;
	b=cGGGSK8nZvPYbG/P4Ha9Sw8KsF9Vq17pQHu03rZ9DeSfXoRpTh8h/718eNgrHUCPAH16
	 iWam/k3ZS7QOk1CAilhHMNFsTCrKSAExcvpLp47/Xc9mCHgtToLVU6Ml5P5bXhcjcYD2t
	 v5GL8Vd1pag1q5Wxs0hPWGVvG145u5DINjA6HWS4APp7JqEkkSAUzhlyNNI4bBYblWCZW
	 cvBdOZ1JtcDX6xvh06CZGTJxIIPEA9c6Hwz4ekqNslbUlvwsAtl2At+87P1EzrOhMpkXl
	 kc+MBGscJ2/AQBtmgoESzZ5Vvz8/mdbwJPexZmxJFq+w0kVOTloXlqkEc2rw7ti4wEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OHxAoPZy;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4DF606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D4DF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OHxAoPZy
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1416296a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560045; x=1794164845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hdLZGGor63NFsd4FY/8+ryE17FhK4fXkO+4VAc8+Izg=;
        b=OHxAoPZygoncbWFdK5r8Y2H2kCw6rCHtvzoW/oVHEskdY9iBpk6drCovzaO5ZJjbUH
         17d3YpoXQBeaLPOzxUVuNbxl5P7HqmBdIP6EItYDqmsxFbSsVSBki9p2/48sxYuYJ8NZ
         i4QDCUH9Q0CF0zV74sgWno9zZC8TCkhs3e+NJWVc6m8cNubBd9JnB01Ychhxmmo0aNzj
         9yLpCRcb55S/He34ZE+aDX7VweiGiUM/BMIjOi4TAu4dMbNpDd5+nggmgaa0mbzIzM/R
         KiQg6U78PfkIsgE9IdNlwhiEyfelId0kIYnQhP40X/P1f+D7THkq6dCFQYUJE39rO0PC
         hzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560045; x=1794164845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hdLZGGor63NFsd4FY/8+ryE17FhK4fXkO+4VAc8+Izg=;
        b=pcNmqBxLvL4F27IpqK5OOP8BBmyDiYxkTG61wvhVYhlxwKvYFf1yWpajuvGAW4OkEe
         Jpusc3ezl3+HJGxJTrOrJOH4BCi5G8tVyClVtf6Ipu3a7JvUd86Z8osfdkGWvNuoFKmz
         ITxIuERY1pksCSOblFlnK0rbajn8rH9enMJAzdBpaetB7FlEDCWl/gKYDq2cqJCU54+2
         iw45/aLVTYppm2H4d45ea0Wn4SYUmcdDS7s6aA59q9f59WE0ouDcmUI49nGxh8itKz/K
         rZm826iHMUaXFDxbhWY3LYsGmjq3MW1Ty82Lq6bjS+m/qhNXnH2gwPzGyZitlm7FzUzm
         isMQ==
X-Gm-Message-State: APuU4Z+r8x452c2E9GSFNlogIHMiF1VkLhr/ZVYljsh63iCMJZrCUyJ5
	4yQ3KvbcQm4MhQn79mTMu1MzMH/jT38WV3jqlOxKO4L8d3cloVgfDsNOk82lmQ==
X-Gm-Gg: AYBFou1JFu7/7litnonPc2sUhCWmvOoSJaZUlInGvTI2/dT+gqkIqcAEKJvu4VcIjBX
	3A8SQDfw8JWsJbICfXD6Osv/Rzi7dAg4uRssV+N65G0HmExL458UzyK3IMtj2Ql14BpMZYIQ8Vk
	SOuyWM3dbecR25QSIgXae4nQ5M216z4RX0Sf6ZgetWgsQTDe6lSAeoPqGfQnTA0V1ZESliLRvKy
	zLwUmu+8TyCeIB0nWFARIRU+/jb+QWI+sZeCU5BHGCvbCtAGPnezEmEgHcyLeOPi08rGNGd4aGN
	lhLWdPE+nByzl41Xcm4pR1bW95edn2mx7CVJzC1xGLbyonYsvh+z/scZL1R3ciVTo1Dh5eMNwtu
	nc/RnoUq0Jcp/u7XdwXx+Iu6j73DZqvpnbba0CzksWmAgi/abku057v16RAkKs2NiVaIkHorfyg
	WRxqKjVuTnw6wPQtCoeJISMPTLISv1pX3qfIvC8RYrl4dFe00VU14jWGde8GuFT2AjIlO8IN7ER
	7YlTTeGXNxvYC15PVpLskhsDxhEgD58hogi6KYGJLozaoRKd7BHOOGjkWLjnVsI9DbrmuWAhLp0
	pdm/JqWqy/UABeq0i/oNLYOFXpg1W9iW4Nt5D4MMB3Kcz22XduettXciP+WgEIasHjeOy9oWdhs
	8RAgRArS7gEYx9Of1wizKU7aRzjR6ca6ALrjeIW2HIKR7nUHaUuBRCQvT44NWPGlRU5shtvF5fg
	==
X-Received: by 2002:a17:90b:1c92:b0:3ac:7749:2f0 with SMTP id 98e67ed59e1d1-3ae89819f91mr6345591a91.44.1793560045337;
        Sun, 01 Nov 2026 11:07:25 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb0981c5desm2111318a12.27.2026.11.01.11.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:07:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 18/27] bpf: Limit the SRH length in bpf_lwt_seg6_adjust_srh()
Date: Sun,  1 Nov 2026 19:05:26 +0000
Message-ID: <20261101190535.1454146-19-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

bpf_lwt_seg6_adjust_srh() lets an End.BPF prog change the size of the TLVs
in the SRH. The helper keeps the SRH length in srh_state->hdrlen, in bytes
and without the first 8 bytes. Later seg6_bpf_has_valid_srh() writes it to
srh->hdrlen, an 8-bit field in units of 8 bytes. But srh_state->hdrlen has
no upper limit, and the cast to u8 can truncate it. After that,
seg6_validate_srh() gets the SRH length from srh->hdrlen, and thus it can
accept the SRH. Then srh->hdrlen is too small, and a parser reads TLVs as
the subsequent header.

Return -EFAULT when the new srh_state->hdrlen is larger than 2040, the
largest length that srh->hdrlen can hold. To replace a TLV in the largest
SRH, a prog can no longer add bytes first. It must remove bytes first.

Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index a69f6817e273..acd1e89351d6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7179,6 +7179,9 @@ BPF_CALL_3(bpf_lwt_seg6_adjust_srh, struct sk_buff *, skb, u32, offset,
 		return -EFAULT;
 	if (unlikely(len < 0 && (void *)((char *)ptr - len) > srh_end))
 		return -EFAULT;
+	/* The length field of the SRH has 8 bits, in units of 8 bytes. */
+	if (unlikely(len > (U8_MAX << 3) - srh_state->hdrlen))
+		return -EFAULT;
 
 	if (len > 0) {
 		ret = skb_cow_head(skb, len);
-- 
2.55.0

