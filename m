Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560099;
	b=vs7O0vkTKwcMwduXTgrPNQAglH1MLuijqRJxi3dcj9SAk3lwo7bieYmXR25XEFd9DwM8
	 tSG+j78Qqa1AfehGaF87+jUFzt55xJvD1Gqibq6KAmoI/+O/kQwCeft+YuYjRF6ZJn6CK
	 pkc+jGwPP0tzbn3p0x9h3f4Fr0lMWk8f6H8FSIlcpMdOqLpXe6KSxWKHk9gus00MP3U1x
	 0rnLUP6eLdcpWyR6UQNNwIcNt+J/TxOEMe6DVTBUpFNlTZ8EA316JlZUTpwyxHyP261tI
	 acp/3W+v2l0J1D5nhFxcvUQfRfUdCCXibUkzZaa7ivSvvpIBEojHYKoO4BC7gZL+QqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gb8r2/lCmQ8I8eDeF+hFlEYTai+zb7Es+79DuXDNsho=;
	b=NoX2ozUOGJeruYk7ZD2ZmdSOsQXkzjn2UT6Bd/JVp9N0nWDKtnpxWDtmeYqWyB1zBHzW
	 gr2VYdi72Nkkx49uqszap6jmHgJFO2upIpJQJxIoXa7HFY2YN2KltPPRQ3Ny6lG75riWX
	 wYf7+Sc+Do2Yf2BzbGiYwM8m1Yvcem/ye4y2/RZU61emXSKlPoOImDt0r4WoHPwMRUbK1
	 aHXfz688wNnFKzrvyeotI/tY+oQlYiuL/Ylwmj4s8RYmPHwdfn9OejBoWdbFlsNdtvTYp
	 XjtivJ2ifaKcUUCp0TAqx48VVMl+ffkKGLz9y89uiq9DfoRXNKGpnp+l5K//t11zAaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fXvPxlUb;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF025606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF025606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fXvPxlUb
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1003293a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560098; x=1794164898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gb8r2/lCmQ8I8eDeF+hFlEYTai+zb7Es+79DuXDNsho=;
        b=fXvPxlUbz+VUhqd2t1+gElQR+/KJi/a6MOscajOg4oUkvPPSvbih7nBHW2+eOt1k9s
         FROYs3yv96ypqIFRMmLGDYEbtCs5wvt3AYP48iCGXQOHv/2KMtTVFbcYGleciNWxb9Yp
         enC3hRvhTeK5v4p0ZNlKovbA1Vw0IZZaBdb7z+SSyfXndU1jtBQZF+jgV7J5iBW6Un6n
         z9wbmiYUnmgVf4Vliqb1YdcHKhOfN+tya/BBGx662AX1yS5WiXOX2l4zGbvqnv1+ciJV
         GggOKJuh63qkg7vQFHfMihPrvWvi696SqwdymMgZw/hzim8F80fdw4pCOa5oDM24sj6t
         RhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560098; x=1794164898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gb8r2/lCmQ8I8eDeF+hFlEYTai+zb7Es+79DuXDNsho=;
        b=fpR+TSIOtIzUwMRbmacW5mHjQL12VKP+ELZEuE5V4av173pbexcC/7bmKYYkxwcicV
         7bPCHA8jPCI/8ww+dh/1C/eFY3HT2CnmFxLiGBI9u3106siYkIQOjC3FcrGli1ZXjbRj
         5R5J+mRjX11jxHITXGj9Jk/SpYz7/9YQ2AtdNhuiXGlgX0e0g7TV1m5MGJ/dbhHKvwMB
         UQ+c4dZtR/qJAEm1r1vvhPEmEht2+8TstVGnNDBpkdepeMowBKDyna9Pq56Hi1dT6pjC
         /JhtqmzxjgT5HfSdctw9FOB3VaCnjNBD99FdwUNh0F3TskvNpN1P8hRu8tlZz3mmfLeD
         JH2w==
X-Gm-Message-State: APuU4Z9cvrwobZtffF0fDofrf0fRR7jTP68zo+qX0olCMpQGkbEwxuTM
	jCtDjouhJiSIhcFc6wJL3FkrELKSUStfmFPaDRNBZfNfBPmZbcE7VZsylRtZCg==
X-Gm-Gg: AYBFou25VX1hLkqAKS0wLnUkjDKah0miDqOKEZK53U6BChhld3ERcUNvFGFVgPzJq7b
	zqbZwTDOeVMbInHt19lw9zzGCVRD8jjKOgB3xpSu/0Er+0DMzLDDpNsaXIzBiz9+VDWw4vXa7Fb
	r9PaH1OMJV+0HpqMcQGEt3ceYKwG0H6rND75+u2MZm3rWYmCGCccfcJqD6LaS3UC4nahJUTHwHZ
	1W3vLlzfNq7Nm+Dw258Lph9L+oGzdLuxhxyzI7HrNmSaxpr/z8GnGJcEq2B/0/bZ7DhLnvIl7hx
	bxT/VhKIt0ueLcsYM5wz/CWMp2iJbRdvh1+ACKS4vaxCvRBCLyQEr8uugfzE1cuZlQ63VTUp/xh
	E20CZXAn/1DdbT0y98Ids9GzN0+8F1IAJSC3BHng0gmoVDunww+C31u0h3eSLcn0iDFuodo6X3K
	CT+0k5zPmvUi+fUMW9LNfuQ4JwZx7Bf8Y1TeHysGA2s00USe5fqZdn+W5kwWcIoxgob/ScQM2jG
	rw+BMw6ZLj3wOoRXIyh5yecIxPjC+TcViunlLRxefMHjZKFCk7ukRo9X6SU1oeM2JX7gFiLS/RJ
	qAJNfUYFDKgNMoCWY51deFXSUUUTzLcJbllvvr9DYcEEqTMWQ32DybTri8hxUfs6MGRLPsIQW23
	W0AP9CRXQf8aLFkVa9M+goUEULZjjt8g9qRYeXMP3mP08m0JEKAFbaKvvaOIv3xSDZHtlkll45g
	==
X-Received: by 2002:a17:90a:e7d2:b0:3a7:f4d:b23d with SMTP id 98e67ed59e1d1-3ae8984dde2mr7201486a91.52.1793560098382;
        Sun, 01 Nov 2026 11:08:18 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm11126419a91.9.2026.11.01.11.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:08:18 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 27/27] bpf: Check the offset in bpf_skb_generic_{push,pop}()
Date: Sun,  1 Nov 2026 19:05:35 +0000
Message-ID: <20261101190535.1454146-28-alexei.starovoitov@gmail.com>
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

To make room for len bytes at offset off, bpf_skb_generic_push() moves the
first off bytes and clears len bytes after them. It assumes that the first
off bytes are in the linear part. But in bpf_skb_adjust_room() off can be
the end of the IP header, and this header can be in a frag. Then the
function reads and writes after skb->tail, and can damage skb_shared_info.

bpf_skb_generic_pop() checks off + len, but this u32 sum can wrap to a
small value. bpf_skb_adjust_room() and bpf_skb_change_proto() calculate off
from skb_mac_header_len(). This length is a very large u32 when
network_header < mac_header. Then the check can pass, and memmove() reads
and writes far outside the skb.

Return -ENOMEM from both functions, like the present check, when
off > skb->len. Thus the sum cannot wrap. In bpf_skb_generic_push() also
pull the first off bytes into the linear part. Now bpf_skb_adjust_room()
fails when a prog grows an skb that ends before off. network_header stays
wrong.

Fixes: 6578171a7ff0 ("bpf: add bpf_skb_change_proto helper")
Fixes: 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 21fcdc7cd950..9245009d9f1e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3369,6 +3369,10 @@ static const struct bpf_func_proto bpf_skb_vlan_pop_proto = {
 
 static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
 {
+	/* The bytes in front of @off are moved with skb->data. */
+	if (unlikely(off > skb->len || !pskb_may_pull(skb, off)))
+		return -ENOMEM;
+
 	/* Caller already did skb_cow() with meta_len+len as headroom,
 	 * so no need to do it here.
 	 */
@@ -3389,9 +3393,10 @@ static int bpf_skb_generic_pop(struct sk_buff *skb, u32 off, u32 len)
 	void *old_data;
 
 	/* skb_ensure_writable() is not needed here, as we're
-	 * already working on an uncloned skb.
+	 * already working on an uncloned skb. The first test
+	 * keeps off + len from wrapping.
 	 */
-	if (unlikely(!pskb_may_pull(skb, off + len)))
+	if (unlikely(off > skb->len || !pskb_may_pull(skb, off + len)))
 		return -ENOMEM;
 
 	old_data = skb->data;
-- 
2.55.0

