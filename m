Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55FC3A962E
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854581; cv=none; b=pNJtjc6tl6epx9wXyeCVpqiwi9Qcls8aBdiy7UhLId0M7TZTX+d+uHFiCRHU71QKlXvAKFxmcb0KocvYWTnJLvAZZYy9H6DccDFafvudiC1DxZUMFhtdkuAb+RQYhqpCUKCsL/Cb9cTv9Lu1CxUbdPUzwZL5X4CPUlxfPCrdiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854581; c=relaxed/simple;
	bh=aiseS6TluHkxOT3dOKjkluKww20EbTchPRtuxMszWrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0MypGgcfGO/3c26yHRMkKmMFDgxhMNnf90EhVpc2O+iYt/Ic57sVay3gNAozRfX7aXlEtb3RwspKnpQKxz4aHgowIlcKMYsF13A2N8Jv1qCLS9skKNBExA60/0A+mu9L2LylALvUDWHNlgkRqXk5BQZR/MsObhMajvKungyILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3E46sMK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3E46sMK"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso1742591b3a.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854579; x=1776459379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01lWhu9Os65kPPSj9s6xaaMOMSReVlNtGElPCZmQfUY=;
        b=o3E46sMKqsU1KWH93CHP7OdRuwKLah34AjiGZ+FVMgr/85uHgCFLY5WcpYCz2JumBi
         rsgnasXKcDVQgCBHh9MuDxgmHRj6GNyPu9xNmkrq/VPzy2wbB0cDNWLNi2z1KDSrQZDF
         ssOWiHXCfxA6CSaGNGWDKINz6S/k9wqSPenxzXwqxsC4p2W4cZw7KB8wn5qQcpBBjmu4
         IZ4Ib2W+lQogPIxsHLCbUsLbB6r5fx88Qg80EHETGp8PHwtRPUblWQolt+jTtD7UkX6B
         rfMc8H2WSILWYbCRiyB+vKDkEFJ1tgYGKeriDJpDxT5uezwzDhN/+AZMFTVPQaHXb7RE
         U47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854579; x=1776459379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01lWhu9Os65kPPSj9s6xaaMOMSReVlNtGElPCZmQfUY=;
        b=Y5eoDSG8VTBCWxbiO8kcuF5Pp4EB8SvFSBpHCiS4Mlrnkaqzyah+iv5YHZM/f4dtvV
         MZWn9x4jtzWW2SXzQJlZd/un+Z9F6qnEA4IdURvlM1sXYqrttSvafNjnYXoDFDAmTAZ6
         ZkXG1PA6BmWftdtrukgcE0ccq4TpXFbervKuq2JlUhlShEfcR6wVKxDoqQb8CCPT/LAA
         ONAU6vwbaedGGhm4HQsXMKe9qfovWC01UUwBzWl+ytm4aLgTjffx/Dkj/V0+hlJiBMQS
         Lk5BxH8x50TmN7BQ97V9AKxNtIOaJ13tFgMB+ACZ5eWq9kPJwvYGVi9bModrUbdf90fP
         WVCQ==
X-Gm-Message-State: AOJu0YzLFkooaOiMse13u7ZoC/EK5kKBc8RWPb7VZDIZIpJeEK5c/laY
	0Us7fEZJrLgmHF4Xfghd2mRJAEm3aey1b+VqFy52wQbVT37ZqeI5GEL9JpMjn+OP
X-Gm-Gg: AeBDietz391psfqJDRdnF7vWuKW7vPfNng12fi8XZmFD0jMzaOAMJBTzdmlOnl/Znci
	xSfrJwFGtcWqiwMxbgQqmHvU6HX1rPrsHwVWxZ6RLUTJinLjkYhjHsH2iEFoNzuG3o15s0eaY7H
	WJZwik+eGJ6duRrZAuR3t0vnbRihN4kPEx6utTOoZnNC2xGHJmcEUGoCA956RRV270TJLKur1EE
	K7gqP/dFUqlgHWebbZrZoibhY07Boxv86sF0FFk4zD4q+mUb+HPwXPxCTcMATa6nSIIWkxoq3gO
	m80h8mahwQHnvhytOETNTtrA0lcW8KCpss2OmJBA2N/cUlFXk7sPVt3NX5RMVV2P0rG7+AjuvDK
	UjmYuNW9YjjF6Fc1UyhpXaPr+A++rASmyqWCIJY66wEQbIIVVdS4WieU7qViqA7X1KkDu7b4aTD
	uJJ+Eoj3PxhXLLx2TDQVe0ei7Ge0BffQywADihnIoTf40KR9sMKuBY9lC4FjHloLqf07A=
X-Received: by 2002:a05:6a00:35ce:b0:82c:6683:b866 with SMTP id d2e1a72fcca58-82f0c1d9b9fmr4937681b3a.4.1775854578816;
        Fri, 10 Apr 2026 13:56:18 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50a8f7sm3551648b3a.56.2026.04.10.13.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:56:18 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v4 03/14] bpf: Add spis_*() helpers for 4-byte stack slot bitmasks
Date: Fri, 10 Apr 2026 13:55:54 -0700
Message-ID: <20260410-patch-set-v4-3-5d4eecb343db@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
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
