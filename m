Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D593A5E77
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809427; cv=none; b=s0jBIK7+xKrRIz8Vz5H9LGsb1deVXKVHy8QXObN5iM/HhyquDUGkUMHlngiqni8ttpBUYdbruWxISdEQtbsu2Iq+vs34u3SvDEDEyi9oUCFB5tiqlVlYIatcB8GOkKK6hCxacMcTTIqahTI6BtBC/cBztYdH87CPv6vQDy0ZZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809427; c=relaxed/simple;
	bh=RJIEnh+ncrKhS9Zfj9AKVCBCjGPA6hfvAlQUo5fkHmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IH0/gYopwAhULAQ7gSP3eXkrd1yBEA71bFsA3s2mGR9XyWo7HuF71YpzYlUBFME3YYLxvvIGS1/RAp75TiEIxmfXGRk1sxbn6rRWASaaMZeIJ778DUmuCgdSV/z2l5mF0wysm5Q/7SBMIG+P/eOjjJKVGS/bO/0YifK44hGygCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POmhLuc9; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POmhLuc9"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1749465a12.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809425; x=1777414225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmpRMKFXGig/q+WEycTJ71DgP7kfhR+H5PanaAOVwv8=;
        b=POmhLuc9StBAQrjWl0TKuvisfcTXJKQz810snpuSMWT1/oWGHIhsOpzpK62KKicRVW
         MZ91OI9ZVJ1IuUqL1S/3l3FAxgUF38PkcMnQQbGlp1lueqyS8NnM8/yMVzyiI1NCBpue
         BfYlybuhDWNDDIzfspDo00V99AlFb7QTatu+6zWOn93JOIMrS929e1InHwITuzXGO59+
         RlbtkjS7k3qbggcQVxNRDk6xRSMCfLMOLUw6yl9k0sxwLJAGNWEZUls0yBO+x9vLRZBq
         JvovMXNhUYfkwRpdfUsvbqXb3Q3jssrUfArUFBM+XeIN2JRmJjw/wvwyLfUJ+jAQ5dvt
         6m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809425; x=1777414225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NmpRMKFXGig/q+WEycTJ71DgP7kfhR+H5PanaAOVwv8=;
        b=nwD/B3BjmvwPf24tn5xXRZaP0NLx9iKGYpzSsK0kKR4w7qZf1j2sPBdS+38yhMZlIR
         IlBXKPTjjWCOZ2fi2+6wZu0iA56QQNF8Z6oJj7iqzAVS53kPYWdriqauJFQSWVsLDVaz
         j9QDUgtd2adsZfz9dqUphQrqj9Wz3njSXZ4gHPLXe4u6WfT3DKpIjfZNs6nbosUAe7ot
         +D2OeLuZaOBTnNRlNefiC+PXJz+OQE+D48PNNjx6M1b/77zsaajW2OmSerlsk9nivVLp
         xMjwPHomnC3tuyhlsvre57J0NKonRs4H8YJ9AE8SkuUMYGTCUfz2RoumsDgxtuX5ltXa
         KeHA==
X-Gm-Message-State: AOJu0YwqzuiVwvr0MsvrfLI9HFIC3HdmzW83ac3Hc+GAlCcmGeqzE80a
	XW875kN9h7VQA208BZ2A0HUF6cGZ59lcq8knDa6/3Dtxy2Vx7Vwwxmz+HnbBDA==
X-Gm-Gg: AeBDievzqLPmoynUM9tBl3HD/XqwfL/8D6vr4EDVw9Kyxox6/ZqGXyx9ffjBVJOx8WN
	f3E5rDOlRkUGHniL8EzrZmRvXg0mg14109yQImmjRY16ZqsrLYHEGUpFRflPqbkz49VGvziquZe
	bCuJexzPB5X1Ffv51dUlFSHqcej05GJmSCzm4f0WGE4Sq8rnWITPBjvgYBi5GyLyENEd/SOCdpk
	ojyw3a4D0NACV6LmQm1AftWKvbOQYfAkn/Fp6j50Fdttxur20RO8vaOs6iUwFhwNCMlDj92d7tf
	SNcx/j8KKDNkOgh5/5hGGCAJX0HITwdZosiOPyqTR/jQ4bKazFz2D0NEgjufDuR0o2tkWTjZGDd
	h3VHg0pxz2uIkchNuu+8hZK3xijrS06k9f48l1H7Ql1pohATq5FvylBEUGvTNjCGT+Cmd23NjoE
	W3FRzmDtqLP1prTgGVpJtP+gI=
X-Received: by 2002:a05:6a00:91d6:b0:82f:9985:d4a1 with SMTP id d2e1a72fcca58-82f9985d570mr15232404b3a.24.1776809424952;
        Tue, 21 Apr 2026 15:10:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981d00sm14541222b3a.5.2026.04.21.15.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 6/9] selftests/bpf: Test creating dynptr from dynptr data and slice
Date: Tue, 21 Apr 2026 15:10:13 -0700
Message-ID: <20260421221016.2967924-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
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
index b5fbc9b5c484..43beb70f50ee 100644
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
 __failure __msg("cannot overwrite referenced dynptr") __log_level(2)
 int dynptr_pruning_overwrite(struct __sk_buff *ctx)
-- 
2.52.0

