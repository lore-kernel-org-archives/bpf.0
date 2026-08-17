Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63DF3B47E1
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994188; cv=none; b=TUfOoaE3hYQ0rXTBHF9uohCXB5skB8ITa4a+qiWxW4nOwxk8mmvQMSopp775w3S7/oPImGqsC/ucoMdSP3QZ/HlPbD5XTgmGFXZXUHKvjQWHZSkDM1CCHmqKZ08M241fuiOdoKpM54K90ididQs8gbkYnlcipFTg8WmHS4otR3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994188; c=relaxed/simple;
	bh=5sjwHyYrgKP60/LNaGb+tWJTERUScuGlVUlMJOl6F/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G652eVDh8MQqwd31vCNjucvkRLg3uJj3cMtT+Y//cb70r+iJ3BOE9teqJmIF1KlrWv4o0ycsTHSMqmryT0UMQSsmSpT3DfCMH8qPnDmrNv/f+eqF39IFK+rPG/s+fbQRVjovZDSpTjyVII3m6iT8GSusm27zlnBPtNOqBKtwnQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ahH4tfLf; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ahH4tfLf"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca80d708489so190320a12.1
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1786994186; x=1787598986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mntJMVTCODMYHKAAawqYSwlnevGlujVGEwxkTLey9zM=;
        b=ahH4tfLfQZYxsyV0OzlWUJxpNWKLht7/1AEzVGz7Sx2K0D1yxQuvphhedaGc5SLas1
         +XIomjrVqPXIOvE2j/+9Lj+uBQBgKfz25PfQmx9zcT/N8afGyKZVkTkmiADyf/I2HkzA
         wf/cZd1Nhfu2b1ZqjapBugQ7CRoHgIAyaHe3Y/l9OHKoWPvqVNnPu7qfwiQP+DXQiDEw
         K6wBPpgh878L+NrOpGvDVgB9HjanIwx3RePTq8gEyV85ZJQ3oi29I0xauNpj3kmg5Ike
         N2VpFvonklEz6siO948e4PC3HCtMmCPrQaVGaNiscsD5xvcHa0oK0vc1StLHJqdqamTf
         H4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994186; x=1787598986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mntJMVTCODMYHKAAawqYSwlnevGlujVGEwxkTLey9zM=;
        b=NhEp5enEZ/COYyBEVXpt9HLbwyPtfbKrUY3oQg0Qzu2mkWzHpvnyl65RVhEsaGYPvg
         e1prpGmxFArJiDADShJm6FfktAu+MhFQFGimzLuAiCi4l45mgyrjSdHAW1/4SIUi4QJb
         WgxjXc615SM3/ojg30WPqxGVpYFtxsedhYrivd5Bx2gSSNW3aQikN3cgb3GEXUffLiCt
         EncZESpBewv2qIpf6XEpASdiOYfAgvR0s2KNPQQDT+RgxZApG5qoYzVJ4pc8vLAVYgt3
         /Psqj7VaGbikhqVmpGjTvOxs0wI0tdV63xTjeXdJSVcbu2bcrK6W/7C6kjV6ljHfBupx
         Tg+g==
X-Gm-Message-State: AOJu0YxN3+OrxmFD8xaJ46Dzs4C1IqerKPy5iIWTJnqBkOym/DSnlbTE
	2Wg4N7AH1kCtAXQhAbUdeaEPJES3RBYyR9MZtHjhHG0ra+FPKD9nh0exJH09E2ngrn0oNW5k/wH
	hnQIxu54=
X-Gm-Gg: AR+sD13g6gkcHLiT7QU++7vrKxeHo1cUTgbZ/zXgEcWvAdJKzNj9R11aEChkaf9I7/B
	nPAQRvFMW7OtU3i9q6UZGrRH807bpzohSPy6n4jC8uLH3Fj95+gAEPsZhxfrgFlUp3TUVrg4qBt
	TzSL/PuS7iZF1kutd6peyZTV1BsJsDuz4+cIuppUXaEgVXIi3w9iYpMdEps3T2LWMH5qpLdlwSr
	besR8IQy0S4GkV4eoQaQLCj2xVsCIOwldFblt3k9OfpT+pfAJveenIffTpRpBrPZEdHUKyNcuW4
	VN8MBAPCa9r3HISPRp2oQa8JqLmjYOqKDqFfDXe4sO0UhQco15ayqb0dMvzBII8Rqr2FBalakjE
	jMCCDy4fkM8QzfHqWpjDGNfXMrw2tlvLiiaO0aIummq7FUZszLO7tTVFyRnR3/PQotI2x4U/t20
	dPDeeQaxjrc+ThyHt17pkGwe5ntKlyGGz7R3okw2g16AOQKnNgz0thNwcvuK0Pfsa7M5VAtZxHy
	8gElk/S/rTaT0x7hJBT5do=
X-Received: by 2002:a17:90b:58c3:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-39563873a87mr76515a91.5.1786994186012;
        Mon, 17 Aug 2026 12:16:26 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b62696bsm5485597a91.2.2026.08.17.12.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:16:25 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 6/6] selftests/bpf: libarena: Optimize and make public arena_memset
Date: Mon, 17 Aug 2026 15:16:16 -0400
Message-ID: <20260817191616.11071-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817191616.11071-1-emil@etsalapatis.com>
References: <20260817191616.11071-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang currently provides no __builtin_{memset, memcpy, memcmp}
for its BPF backend. This is especially an issue for arena code
that is more likely to do these operations on buffers with user-provided
bounds. One example is the arena ASAN implementation that uses
memset to update the shadow bitmap. Arena ASAN actually already
has a naive implementation of this operation. Another user would
be a calloc() call that has to zero the memory it returns.

Introduce a more optimized version of the memset() operation for
arena memory and make it public to all libarena users. The operation
uses word-sized assignments to speed up the function for larger sizes.
We expose the function through common.h to allow for inlining from
the callers.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/libarena/Makefile |  1 +
 .../bpf/libarena/include/libarena/common.h    | 57 ++++++++++++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
index 6d62eda34920..91164d43bd61 100644
--- a/tools/testing/selftests/bpf/libarena/Makefile
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -60,6 +60,7 @@ override BPF_CFLAGS += -O2 -g
 override BPF_CFLAGS += -Wno-incompatible-pointer-types-discards-qualifiers
 # Required for suppressing harmless vmlinux.h-related warnings.
 override BPF_CFLAGS += -Wno-missing-declarations
+override BPF_CFLAGS += -fno-strict-aliasing
 override BPF_CFLAGS += $(INCLUDES)
 
 CFLAGS = -O2 -no-pie
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
index d32a51ff5e7f..a6220355a697 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
@@ -71,10 +71,63 @@ void arena_free(void __arena *ptr);
  */
 static inline int arena_memset(s8 __arena *dst, s8 val, size_t size)
 {
+	size_t headalign;
+	size_t tailalign;
+	u8 uval = (u8)val;
+	size_t val64;
 	size_t i;
 
-	for (i = zero; i < size && can_loop; i++)
-		dst[i] = val;
+	/*
+	 * Calculate how many bytes to the next word-aligned one.
+	 * We get this by truncating the 2s complement of the
+	 * pointer to the last 3 bits. Intuitively, since
+	 *
+	 * The N LSBs of dst and -dst add to 1 << N, which
+	 * is why dst + (-dst) = 0x0ULL through overflow. So the
+	 * last N = 3 bits of the negative are the number of
+	 * bytes to align dst on the last 3 bits.
+	 *
+	 */
+	headalign = -(u64)dst & (sizeof(u64) - 1);
+	if (!headalign || size < headalign)
+		goto ptraligned;
+
+	for (i = zero; i < headalign && can_loop; i++)
+		dst[i] = uval;
+
+	dst += headalign;
+	size -= headalign;
+
+ptraligned:
+
+	/*
+	 * Make a word with all bytes equal to the byte we are setting.
+	 * Since 1 byte -> 2 hex digits.
+	 *
+	 * Shifting the value by a 0 bytes is equal to multiplication by 0x01
+	 * Shifting by 1 bytes is equal to multiplication by 0x01 << 8,
+	 * ...
+	 * Shifting by 7 bytes is equal to multiplication by 0x01 << 56.
+	 *
+	 * End operation to replicate the byte into all the bytes of a word
+	 * is (since a | b = a + b when a & b == 0):
+	 *
+	 * val + val * (1UL << 8) + val * (1UL << 16) + .. + val * (1UL << 56)
+	 * = val * (1UL << 56 + 1UL << 48 + ... + 1UL << 0)
+	 * = val * (0x01UL << 56 | 0x01UL << 48 + ... + 1UL << 0)
+	 * = val * 0x0101 0101 0101 0101
+	 */
+	val64 = (u8)val * 0x0101010101010101ULL;
+
+	/* Pointer is now aligned, use word-aligned assignments. */
+	for (i = zero; i < size / sizeof(u64) && can_loop; i++)
+		((u64 __arena *)dst)[i] = val64;
+
+	/* Go back to byte-aligned for the tail. */
+	tailalign = size % sizeof(u64);
+	dst += size - tailalign;
+	for (i = zero; i < tailalign && can_loop; i++)
+		dst[i] = uval;
 
 	return 0;
 }
-- 
2.54.0

