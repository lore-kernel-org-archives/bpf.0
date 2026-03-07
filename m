Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA550386C02
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865891; cv=none; b=tk2K8iKuWdnjVsiLd5iCPy5K2/kjTAZaw3SlgRA1KafdRC0VkCoYT2yABES6IObr+rqqbyEX2jRe6+LAW5gTg7/LTMQBwhHPpKkeCXxY9qyPp4Uzad/Q20+7RamR2KUuELj8abu5OT4YyvKOqmywkZ6krK8QSNG9t16mfigaDAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865891; c=relaxed/simple;
	bh=+lr2vlS6ETl2QkmquAVBxAjL9FC2dwcWWpltl/omZjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCM0skcvshrg8pywlZ8+1uPFgGClSgPk27cjjXiHjcOJnCLSe5hH8bnsghwOl/a6vJ7MBbkL2aofhPuhvEl6rHt3mybwAI0N0l/clF+ZQXoyFWfDE3N3dmIrEcKAIif3o1b195ZS4zJsIBDZqpRDdbn+mZSUizShFicqBByvB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4c8jrBP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4c8jrBP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae8979dbb2so4725475ad.3
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 22:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865890; x=1773470690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAvuWZcmmyV939xPdlaiE2LYkNV1C8x4Vf2BYdbK888=;
        b=X4c8jrBPZxBiVmD8cScK4r9cd0pR4FlAGStGR+iMiPWrzn25+4hgaeelW27MJ7XauC
         lAB6FVO/OqLrgcMIznET9V2shl+Xm5czY4Is7brBsHt0LWxd+KrZjJ4Lv9Mr/SyPVT0Z
         UM6QvAIPN1evO8UKqR83AvjzNbTiyLFC74s9uK1azthlk5xzs1VgC3Uf31itfXw3CL90
         o7FFqzlfQjIg+css98DGEr/sgtL8Pi7K7P2E2K6+Xx27/uGIumYnoOZPhw9oQ1PvZASt
         xFqMYyEW1VZS3jWBcWOhpaRql4LWBUh/cuou0F5Ax1VLb/GaVhVf3DnF9g0T6yHwbLov
         MkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865890; x=1773470690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MAvuWZcmmyV939xPdlaiE2LYkNV1C8x4Vf2BYdbK888=;
        b=c6dSgoRHkmZy7IbTQ4jxzQIQCfeBJHJP65+f55v7xW3CkMRtxKYEmr8FJEmfd9AJaZ
         k5UDaJ8Nyv/qXR66DGfU2GUGCF+/h2tH1wcnO1ntqkGv7IcTNn0lCtuPT6lZ/jxYOskV
         U7IF04n0vUNf+C2QSV6M6fRyk2Pool38vsVfQ99OG+D1vrMrvh0XFUbsbbJMtuWMrrdO
         17zer7/GV9euTo3p8K+5nLqrXpWNG8bVTBOn7UogoDMar91gs2U9rmJeAkerFcFumkC8
         sC30VPjUegMqc4FkcJTAQX4vX+y0g3CvcOla0tvSWargrkn6kgCax7P/tH2xJSly7la5
         FKxA==
X-Gm-Message-State: AOJu0Yy8vGykuWAMYPMBOpDYRuUUbGjKK5a2XaEsbNFLOJiDxoEVw9sb
	qVFPbif34gMFl0kjI8Eu+Oxtkh0rJAGW5hp7RbJHn+YO1LRf0A0wTJqGHmhMlg==
X-Gm-Gg: ATEYQzx6gPGzJby6yrxMkXnSpp+iOGE4XGHUV090Su+r+ju0oU0rB7w7ZfrvPIkoS6o
	xtQTbViOlrXxqEaG6ftjGs4HwFISsJdttCGXQG8ogHrj9RqcaquRfyi/ARyioyHDDmEfzlFyUyi
	dMTcKqmLcSaCQEIYX+VhElsMzXiIV9fsbcqPkg0VHupMPq2EXmqhVWTuAJR9S8mE9j5Tgrk/bB4
	XiSKJHhW8TPHX5MSRH+MC2CPl6oG7QVAL+Yd27EGicYEmXYduh5fL4Mytw5gkslERzTOExL+eZL
	AEcTpu7t+BNU6OM7F0Hy8OQ4lqEkyA1TDo2xogNRYMBR0nvdEDOYin3EzI731maZOYz1OiITAtB
	PzEgYO+g3yHaQTvvqetLwvWL6zAGQRCJF73gOZjnctcVeAV8M8ShSZsz0iu19Vo07JDdDPxLh8E
	Y4vovzvqzap2A+EQ==
X-Received: by 2002:a17:902:ef08:b0:2ae:5b64:12da with SMTP id d9443c01a7336-2ae82506badmr52343715ad.45.1772865889893;
        Fri, 06 Mar 2026 22:44:49 -0800 (PST)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8a67esm53870265ad.61.2026.03.06.22.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:49 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 08/11] selftests/bpf: Test creating dynptr from dynptr data and slice
Date: Fri,  6 Mar 2026 22:44:36 -0800
Message-ID: <20260307064439.3247440-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
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
index 631e37500ec6..6b162512b0c9 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -704,6 +704,48 @@ int dynptr_from_mem_invalid_api(void *ctx)
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
2.47.3

