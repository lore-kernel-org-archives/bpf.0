Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61848165E
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077652; cv=none; b=kPbY7LWklQ4fhfbUnzLEw8CBWE4gZqKSFudVD8SmutkNQXb3Djqq3/XJLUBqdhh3VeCVjw1R2YYxwJ1qLV8fwnu5b1LI9ASAJaJUHsrkCtAupt4X9YN+91jaQnt8d0OorwUiinGqoCdG16V7NAXAPS0Cz/TnWesP0aAGOg8ae1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077652; c=relaxed/simple;
	bh=p3fZL6NnpnyzCRu2Ry7ME0q8OWFksxB5L7EkIVk5Joc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lU+QHNJhByn3rcYDrQ3y8XYg9YBN2oDAMF29T7zst5daaQI84r55vEpQTQUzTxKyUAz+0JfZzlR0ik/GedaqaZg2vXsyszaHOrf53icCZVoyhX87ZDGArKGT09mUV7NCUXeH+m8W8wxj1fdbHNTffrq6hEMZsGoVRL4m77nsHH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUx6JCdQ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUx6JCdQ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b98482b253so35826986d6.1
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077647; x=1778682447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGgd1BZuy22L7mS4HRnMmTNXaKG8bUWk6PNbl6sz2X8=;
        b=mUx6JCdQmR+9mLkWC1/Dn3G+5wk1Frklwur4qwiFC/XegoMRyw2UcAL7Uit4J8l5IB
         RRrWjAE86lTGwuYk3diRJzFGgAS7XvXtoEpDmiCP7h69JJFca1b+UjLcNKPwSDZEJXRf
         gEUSDbI7osPxQVuef2t0ymjcJVnfXHKXQ/p0p8+tH+F3JasemVT/s8C21UgFh6D2h/Kl
         rjdbS53bK2XOQkvir1NJCMWIHMBfCGLoGlH4QvJKP38vgkuq/J/Ks3zeAxA/GFowNdQc
         ZZ0K9EjM/faDDtRGEqydxIVNb8SbWKetBkAtg2fZwgq0QyngbGn3VGNibu2cc839Q0ci
         er8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077647; x=1778682447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGgd1BZuy22L7mS4HRnMmTNXaKG8bUWk6PNbl6sz2X8=;
        b=sa8KXjL0DzwVM2May89KDlLId/+2ZuZxKM8RvL3NmLDzfTQiWbFIX3DBjk1rhLI1el
         IcEZZ47Toyk1wWt6rEwFGHef7Xs65ktAJB3zAabNo1nLU6JIv14iI2UNp/sqbJTNEdox
         LuSOf1U+6zzfy+y8uVGoTyjbvhfnJ+pMrcclGA7GdpWoWXv+JsKrc0fftlcpcg2hLvZu
         j6Pe0yyYQI02ETT/WZiPPVB3XkqYdTzKl+ONGyP0a5liVVmzJ3PoMexdZuOY3HXfklkk
         R5ibh6feeAByubDXQfp7AhTOsLgQorx/FBALo8dIx7OrUEzN/mfuWSM0g3l0fCbZpyAa
         G7CQ==
X-Gm-Message-State: AOJu0YyvoVmyob0eraJVYZKEWIxIWDb4xDV5hKbHtYOylT5HfkIFdafG
	DCRwceZxmdMZ7Jns9yp/xI3MmJ0ETNIsVUSIVWVI29rJ7pXFFU5/EoahzIreCTM0
X-Gm-Gg: AeBDiesYzYgITwLeQTJTBbxLgR8pXnhuuWqkW31AJDzu/F9OHllCzDSO2ZPWyTApUOw
	Lb4EC0UtJ8NWwWxRp8MFpYZIwR5CPYJJhRZd50xzLCQ8N/ojEhLi5GRCz5fQu+di/WaVQ4lcOEa
	YzUt/f4/34KRH4y+VOrZnF03VqYGcksHQtbc86gcjmr8ACAJSlWjj8SGXbwvYupFSG3oLtm1vLS
	wThbaAcHMCYfVUE4ItYCNMOosFYwSLn2UeK5tUpWI7Lpzuq5KSl85JYsJ0kOUVi17xpcBzOY1PD
	hyIQ1r8SevMQo9bFhas7+cHjJcqbaTpxE0fRmszb7uPO7Qm5Fhr6YEGavRd+U2emsQsyp89FawU
	IUvUxHejxX8X0HmN9VF5EPCnfthoTNkzThWnkTat+KFbg/5U48nXu1loHmJfVM4yHIFxFKc33EV
	zhEwFqI6jgXs2L7BlygfMsqDbu
X-Received: by 2002:a05:6214:5544:b0:8b0:2017:958e with SMTP id 6a1803df08f44-8bc42a704b5mr51679576d6.13.1778077646900;
        Wed, 06 May 2026 07:27:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538a293dbsm208737176d6.2.2026.05.06.07.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:26 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 09/12] selftests/bpf: Test creating dynptr from dynptr data and slice
Date: Wed,  6 May 2026 07:27:05 -0700
Message-ID: <20260506142709.2298255-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260506142709.2298255-1-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier currently does not allow creating dynptr from dynptr data
or slice. Add a selftest to test this explicitly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 60324d68b349..31962233bea1 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -705,6 +705,48 @@ int dynptr_from_mem_invalid_api(void *ctx)
 	return 0;
 }
 
+/* Cannot create dynptr from dynptr data */
+SEC("?raw_tp")
+__failure __msg("Unsupported reg type mem for bpf_dynptr_from_mem data")
+int dynptr_from_dynptr_data(void *ctx)
+{
+	struct bpf_dynptr ptr, ptr2;
+	__u8 *data;
+
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+
+	data = bpf_dynptr_data(&ptr, 0, sizeof(__u32));
+	if (!data)
+		return 0;
+
+	/* this should fail */
+	bpf_dynptr_from_mem(data, sizeof(__u32), 0, &ptr2);
+
+	return 0;
+}
+
+/* Cannot create dynptr from dynptr slice */
+SEC("?tc")
+__failure __msg("Unsupported reg type mem for bpf_dynptr_from_mem data")
+int dynptr_from_dynptr_slice(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr, ptr2;
+	struct ethhdr *hdr;
+	char buffer[sizeof(*hdr)] = {};
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice_rdwr(&ptr, 0, buffer, sizeof(buffer));
+	if (!hdr)
+		return SK_DROP;
+
+	/* this should fail */
+	bpf_dynptr_from_mem(hdr, sizeof(*hdr), 0, &ptr2);
+
+	return SK_PASS;
+}
+
 SEC("?tc")
 __failure __msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.") __log_level(2)
 int dynptr_pruning_overwrite(struct __sk_buff *ctx)
-- 
2.52.0

