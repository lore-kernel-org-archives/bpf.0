Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017EA388878
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535319; cv=none; b=awDpIaWKDG1MVKhcuw78IYmdTWzEuLK1Ls3eFltYJUWLcx9TawTh+Bq4cWdZl7W4kL2Opjst6Tu2VfHgA2pAdHQ7JKp/G7SjW5A7MtBAwh00sjf6HlFmrJ1fGnFYk/MNeXVwliXUsXioz7+Jm0i1b5rJWCqKN8HKw/pLjWVhMko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535319; c=relaxed/simple;
	bh=lcQNPYTsumozJUsj0iUIOLSW3dNbINPXQ42kzsKHFhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpnlcolTp+HqY7HjpEzWuuQDcabEYR0P0tnATxLWucJrCjaSwMuDtFM3kNbWvMaLi5akxEkIykbPTY7fxrt9a7xC5huzng2J2nQGusDygT5N+tqlKk+Dwk60UCZw6WFPlUdgp8vkizh0zPDhC48wpNGwY584tHvYt6EgIS5h3IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=M89exlUK; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="M89exlUK"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2d747f0135fso5117695ad.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535316; x=1790140116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pZufkxNInN1GDdoz+ei/fNQlm8x79g0qE/4kB3l+tkI=;
        b=M89exlUK07LseesesaCRse02lZTT5f7o7mcbJ2y0h4iqxdqms9E13KRispo2M0OAPZ
         5Ke8/Jr9PZeeyp2p84Ot8pUTwAktpLLqfuUkTyLIRn5kmPns+V7YV5ByR3nkO3ty0hat
         yekQ+2WqqOcdgG5LpDumBwJIFvLr5UcAAJ0BIT1S9mfDGgc5Ht/QpD1WNbXs3DmEsqFf
         SYJD2su3m1Gbhku/D6gNbMoShpyc7v/qZaBvBefA0G7bPInmNCeqAK+J1ErcZPa3XuaN
         f9M0YWrWEcj4+ZaPe2wDRYHRrn0vOv+avH4WY4x1QZZp/pZguTQyAdExMxUiVcNCSOsK
         8cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535316; x=1790140116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pZufkxNInN1GDdoz+ei/fNQlm8x79g0qE/4kB3l+tkI=;
        b=aLD11CXgH3968VaXfDTdHmSiYnbIGgmwyShXYh5muvpcIzyBdEYmmcrl450V+7VE42
         RHmS4fIg/RGnDzA9RRrwXvAcIKp5aCaFX9sV4Wst2EwPdkHou6u+zSGaEnOj475P7RnF
         VGQ7RpDEwElqD/wvWjphoTbg8ZScaS2Ylyh+wdWc1TAcQi6IjQQTuF5x8B5LAJRbQrZ7
         EG0d8YDciGZnva591xx3K6OSzP6bAbdfP/xcxl3JW6wl2nAm2iSea3TL/GxvJqnX0C8r
         TvHb3Vspq/+vuIERQcxsifi89KK0D9Cy/GAodhqSSd6NZw0QE1tqPFytZL+BvtGW++yw
         aDDg==
X-Gm-Message-State: AFuF++n4Xvy9YXO0F3bVaZu8c61gQ//5zD5nPc2+8oiWZJAysETifzbu
	1+RDkKEcD7rkBV3q5pBBgtDyXQ6cZ5kTuVtXZSNQVFz/o8HsUtlWSl64e86G+HTK4DCXG5UibPh
	W/rIolPM=
X-Gm-Gg: AYBFou28UT5mbwtFKa9CsbJyHN4pxPT3SrgMIuUgAR7TElZ9lZY51jAJC4fF9blmJyG
	v+wG5cBpQIrEAx9sqsReclRT0Gfp8NsJhq44NhloZdd8AevDH9iKwMkl118AZ4hxEM2KjAG6GPE
	0Y1DK7yAbTM48zFI8W9l3ZeDc673567bAiYVTgc4BLVnMNKELfoDuF7KhTyRpWoiqOyY9Y44OGA
	7CrQbjjmJSBSivQyK5j6Sr1EQLjTo6PlEfFzR3v818L3ahErMTsde0px4Xx73KZZO0B8hWI05/O
	4uYBrEfNN6f5ve8pNOvfGqDYD/3i1O+GwdDUar1Z8u7KNubutAQDhIUb7R2ncU0gXM/Ii3ejUBB
	mrJvLmhiiqXCOL20/Dfa7n78YERrsq4MgvOX/P07hX9YTOiG/19tTYtFoPzInNDiIaiJDP2s7yr
	Gn/2FcVQa4GqqnFA1SyX2LPDQZPaexPiJXGj9mq0MBpk6krpTEbQuWviOxvivYLPqCO2AcH0vlp
	fI1+MTK3BA12w7pScvyLIRsR5Unh0jd7m2HSA==
X-Received: by 2002:a17:90b:3c91:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-39e1e259f98mr3061577a91.1.1789535316139;
        Tue, 15 Sep 2026 22:08:36 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:35 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <nicholas@carlini.com>
Subject: [PATCH bpf 01/11] bpf: Fix bounds check for skb-backed dynptrs
Date: Wed, 16 Sep 2026 05:08:19 +0000
Message-ID: <20260916050830.8774-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb_pointer_if_linear() function checks whether a
memory region of length len starting at offset off into
the skb is in the linear area, and returns a pointer to
the region if so. The check currently subtracts between
skb_headlen and offset of the check, and since skb_headlen
is unsigned the subtraction can underflow. This causes the
bounds check to spuriously pass and generate an arbitrary
pointer of the form *(skb->data + off).

The only user of this helper is currently skb-backed BPF
dynptr code. Returning the wrong pointer leads to the
dynptr erroneously being backed with invalid memory.

Ensure the subtraction cannot underflow, and fail the check if
it would. Use u64 arithmetic to also prevent overflow when
calculating (skb_headlen(skb) - off) since off is unsigned.

Fixes: 6f5a630d7c57 ("bpf, net: Introduce skb_pointer_if_linear().")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---

While the code for this is in skbuff.h, the only consumer is
BPF-related, as is the selftest that validates it in the next
patch. So I think it makes sense to route through BPF. If there
are any objections I will split the patch off and resend to net.

 include/linux/skbuff.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 421f6fc45..d0c1463db 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4372,7 +4372,8 @@ skb_header_pointer_careful(const struct sk_buff *skb, int offset,
 static inline void * __must_check
 skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
 {
-	if (likely(skb_headlen(skb) - offset >= len))
+	if (likely((u64)offset <= skb_headlen(skb) && 
+			(u64)len <= skb_headlen(skb) - (u64)offset))
 		return skb->data + offset;
 	return NULL;
 }
-- 
2.54.0

