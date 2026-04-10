Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233CF346E46
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813374; cv=none; b=SQqMh2QbdYbESswfe37vHpBlvfp7kAmKybuXWedURr9Cp3teV7zO2dwLliPypYsPqHxBJo79cGnkPJvnITKbtWclJ3fA8YGAEOb62IV8vR7IlGxuCfV0+F8ZTj7ON1CRnGOwsm8F5kbafq3R/znH4ti0s95cQL1xzjl5T67U4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813374; c=relaxed/simple;
	bh=aiseS6TluHkxOT3dOKjkluKww20EbTchPRtuxMszWrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/+ed9w275Aq6INFi7638XgzVW72ZJiXcckHLdQcABdsgP504u7MgL+2afOwCx5HQq6CDIM8IG1QMFBt9N0khJ8RctcAwBjWqzSCz8uqtZEIbjCqf7l38FK9LS63zJsE0yHWD66IlDsd/wCCa3yHU8lfI8ljBF6bbfX4K+hErso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBz8gAJ5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBz8gAJ5"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so1329032a91.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775813372; x=1776418172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01lWhu9Os65kPPSj9s6xaaMOMSReVlNtGElPCZmQfUY=;
        b=EBz8gAJ5dGq0VxzZyS1CiUb2Cp4XFMZ169CTfNr3TTAiNlTU4Nmdv16TmSA7fLwZTr
         wcEQuuCP4rjCW2Fo2SuLgZgELLL7FfyOtwUFy7KVWQi+RG3uE9ijfD7MRrTh0fzXgR9u
         /MYY9KSEjcwXBaVlHrcbd3SNLIjMo+zzm9vZKFagjPgscLmV3vdGRzckqEBn3yS5m23w
         k9qL4Duu11pyp6Hp65xR1709XCJbdFafHaq9wJz8xQVyk4TH7K1pBAy4QC78Nx+S0YAa
         sSQEMMIi9GcPRQS425PjqU34draFQUsyvv6V9Vk3ZRx4z/W19Q2kHI117MsWWRGRB/T2
         vSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775813372; x=1776418172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01lWhu9Os65kPPSj9s6xaaMOMSReVlNtGElPCZmQfUY=;
        b=ac+r3BdpjyytM+IH9izfBAwJc9i8DGdsbT9vH6n1S+NrAFqv0dNI9/C/P7rTZEkrQ5
         UdmVpkulP4D1e0YujvRT6fYb0BTUDs0S4LWbDh0EK+5nqkT0MT88Ul5W+OpA1zRyRjAM
         QtXuQsrPQ1SgBqj6OIWVcZuk7OjWK34aZdE/pO6PeLMYDGQL/bRkrCpYLTQLDXT7ybOg
         21vEvEwAPG9RMEbgj4dl/g07UmMnqXS2UpdDX15QSpfjQw1BQmXoZQH76YKlFWUL013N
         R4C639H92pR4rnFqmPHeHYshGidppSJdLBWw3Qh46v4glvaFQ7hWXuBOgNB+X1EAHMP9
         sByQ==
X-Gm-Message-State: AOJu0YwaFEPbqO3NyMo0IVMgXk8z0yDTBGrm6Brtx1Au/AQP33wkMgXM
	MkqWWIZn7TilKawRb47wiHbdpCpONN1vg6c/6F8aH64Qw89AplPlqAm1CqJQb+Sc
X-Gm-Gg: AeBDieuVK4VQ0tvaUwIDYnne+vl9IArlIn4wwQIRyCtyePCauYNR1fnQcZhdBmxSj86
	DD0ymaanwvqP161Qx++B1rpBxMf4jyB1MI+kpx5vTrYEXE5rIBHhRZzcHyGInSIjkb3gpAZQ4Tz
	IJVDes7ffyxHaf1G0NHVzX/gBfQx8ClVVgHVeXt/z9yzdCrQghLsRokl8Xg7ijpY4c45shwUZwM
	h8oQmBNKXejygwjtdAS2nrcdlp6ydIx7y7zb2+6sV8WXotO06rseedS/LSqsPBE84Yt+Z6y2mvg
	JpBYvFinyoyL1b8tT5bT/pIeqz+TxK0AnrPOlF33AU9dyOy79oC35vZqvUP2D9O8MqUQmClbhWy
	ZbFM+oGMo7Wbe0YRtktmj4vaWPDS/VjNbdjf242YPb3eOBzalQUcTHiL24j1e6E0o95gtpfWU5Y
	sRHYG+d/02LAvM0p0/lxH4k5CI1ko1q5oJ9SvzTsKPtjdeAT4Xl1cULBFall1LBTuXzYY=
X-Received: by 2002:a17:902:e74f:b0:2b2:6df1:10d4 with SMTP id d9443c01a7336-2b2d5a31060mr26033095ad.27.1775813372223;
        Fri, 10 Apr 2026 02:29:32 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08b9esm23015335ad.41.2026.04.10.02.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 02:29:31 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 03/13] bpf: Add spis_*() helpers for 4-byte stack slot bitmasks
Date: Fri, 10 Apr 2026 02:29:07 -0700
Message-ID: <20260410-patch-set-v3-3-1f5826dc0ef2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
References: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add helper functions for manipulating u64[2] bitmasks that represent
4-byte stack slot liveness. The 512-byte BPF stack is divided into
128 4-byte slots, requiring 128 bits (two u64s) to track.

These will be used by the static stack liveness analysis in the
next commit.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 67 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cec6054d6333..f34e7a074a20 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -224,6 +224,73 @@ enum bpf_stack_slot_type {
 
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
 
+/* 4-byte stack slot granularity for liveness analysis */
+#define BPF_HALF_REG_SIZE	4
+#define STACK_SLOTS		(MAX_BPF_STACK / BPF_HALF_REG_SIZE)	/* 128 */
+
+typedef struct {
+	u64 v[2];
+} spis_t;
+
+#define SPIS_ZERO	((spis_t){})
+#define SPIS_ALL	((spis_t){{ U64_MAX, U64_MAX }})
+
+static inline bool spis_is_zero(spis_t s)
+{
+	return s.v[0] == 0 && s.v[1] == 0;
+}
+
+static inline bool spis_equal(spis_t a, spis_t b)
+{
+	return a.v[0] == b.v[0] && a.v[1] == b.v[1];
+}
+
+static inline spis_t spis_or(spis_t a, spis_t b)
+{
+	return (spis_t){{ a.v[0] | b.v[0], a.v[1] | b.v[1] }};
+}
+
+static inline spis_t spis_and(spis_t a, spis_t b)
+{
+	return (spis_t){{ a.v[0] & b.v[0], a.v[1] & b.v[1] }};
+}
+
+static inline spis_t spis_xor(spis_t a, spis_t b)
+{
+	return (spis_t){{ a.v[0] ^ b.v[0], a.v[1] ^ b.v[1] }};
+}
+
+static inline spis_t spis_not(spis_t s)
+{
+	return (spis_t){{ ~s.v[0], ~s.v[1] }};
+}
+
+static inline bool spis_test_bit(spis_t s, u32 slot)
+{
+	return s.v[slot / 64] & BIT_ULL(slot % 64);
+}
+
+static inline void spis_or_range(spis_t *mask, u32 lo, u32 hi)
+{
+	u32 w;
+
+	for (w = lo; w <= hi && w < STACK_SLOTS; w++)
+		mask->v[w / 64] |= BIT_ULL(w % 64);
+}
+
+static inline spis_t spis_one_bit(u32 slot)
+{
+	if (slot < 64)
+		return (spis_t){{ BIT_ULL(slot), 0 }};
+	else
+		return (spis_t){{ 0, BIT_ULL(slot - 64) }};
+}
+
+static inline spis_t spis_single_slot(u32 spi)
+{
+	return spis_or(spis_one_bit(spi * 2), spis_one_bit(spi * 2 + 1));
+}
+
 #define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
 			  (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
 			  (1 << BPF_REG_5))

-- 
2.53.0
