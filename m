Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98BD34250D
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214421; cv=none; b=cdg4BIb9czHzJNOq9t7l6bvLuLWIsiTPoHUKC3For3ozLURLBcvkvtG+t+z37ub1ai75Nsd2b5EfYdV1/BlPY+VPIg1ye3BJAHieMVEYU8cn70qxjeMkAwfvwdrW1KtEgTD8eR9lkezeRgdT2pA7z8Xz/LJm7kxwjSBhEj3CJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214421; c=relaxed/simple;
	bh=Yy9nxMqDxlsi2eFEMJmHQMFtl2AvZuZ2+2rqjXag50s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVLYaV4BLhYABtAc2MQZjQ+N2jaoRYvVnCn+1wySX5js77zSadPMWquOHaNOQO+YrVL2oS2RH20SbnhHJDtxkHQtyV8CDGkAOCM6qHlN5GRMEQc4y8p+X/FqUBdDdUPO6bFDOjQf55aJpSYKEWrJ13MizZO22qAXzPD5aFsYmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqUxy2iv; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqUxy2iv"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c5361142fso3937196d50.0
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214413; x=1779819213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QecDNGP+w/3sDQd+DHV0ny1tRHbDSeV8L549ZYAjJFY=;
        b=IqUxy2ivVqWQlIh8U14l6Wt3IFO537beLmbTWFhp+Ju2t33nx1CxZ6fLVI/8leTcli
         VOqrmsvZfGnwtYTCBKPsV2NE0HLzkWdMxTucso4KtoDTVtZoiDLc6FeEXlky+UkT/meg
         VT5zEVSb6EMQvzK2AqW+YzmF6IJPxQQwG5QNgf1Ipx/wF+RptbGgz71P4w6lGSlb92SS
         SOf9tyT48lMSBZgSo6aiIOKENzx0zYnykf0s4EBvuF5xaW3wgN0Z32rab/T7gveYuZyV
         tEQJlh3GxhFQQ6SVcK7KfQXSQaHAQfjpGF79mz+c13+M6uCP9dvfhbWEQXgavze+kTuh
         3xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214413; x=1779819213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QecDNGP+w/3sDQd+DHV0ny1tRHbDSeV8L549ZYAjJFY=;
        b=sbiFbGmVTM3oqcPJhy/W0phd9ia7fI649LXqSMGsh7CvHxuyJZPapqe2kGZTIFUdpy
         wX0dG282WJ4iLoWXe1qCnzZae6To05aoI3lYQSJxVM701crzLHxgH7TNyRHfHTDCC/E9
         4UPTpjZ3lo4gNybYZGmHUKZgWmvl/qjmy+fnnLq0pFWJ4vkt+nf/1yH7U6sPXX6e4fx+
         gHBCXPVKIi3K+2MuGf6Xi3DPWFGnwy1pKOkwch41NXWs5A6Aylx95taehnBfgVMKeBCW
         o+JTJOHz0TMHJ6+jsleD51fN9iLfMfE53ATTOfhEW0qOqHGwjiytclBur6rk5ni/cxdy
         z+Iw==
X-Gm-Message-State: AOJu0YzXVTi/ndBhyFIN7oh0RWqKmt/c9QXk6PTCPuLaeYyx07QiP19a
	hVTndCapBO6LEC82Ya9LmEAE09/N/f9ZCQ1yAaXRouljvyv21KO24986fBwCCKSq
X-Gm-Gg: Acq92OHdwwlXp1Cv6N+wVqKumrk2nIeDkLwKbpsfqW7r7O71MsBe2tAc6A3pVEBQymc
	pUboV8u91YCg7o+Wz74uoVcHg6S+TZQr2/0uiB3mgD2rsNO+reLGNRMPl1isMNtqkf2/d+rc1Jq
	ca5CNeuIZ0Oop4wnSziccuOnNzT+WEXIfhRo0/CjIt7xkFcm+nfNwqQuNy08Dv54+QxE3UFnM8J
	qJLAKjKP9yGhBB7j89A4DK/RPNNiVqUNX4K0fwirDDw9KW+04Un/IQmnnirUCElmKypQ8GoiI9S
	SFOeljRqLsTyskgxwyVxfuT8Z6h1YT2zzv06+mOYJE9rMga3hAbeOP5CcXoSw5AKDoLV9HocXY5
	couAeK4vfjMe7/veLbvy51aLnNDbYF47viKQaZC2IDemPu7giovUQzQFRg3YiyzgdZaUjDG311/
	E3oFQG4Wh3FxSvH/SxwuOzQfCZNw==
X-Received: by 2002:a05:690e:4082:b0:65e:412e:681b with SMTP id 956f58d0204a3-65e412e68a9mr13850054d50.55.1779214412933;
        Tue, 19 May 2026 11:13:32 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:5::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d8e701fsm8211829d50.8.2026.05.19.11.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 11/14] selftests/bpf: Test creating dynptr from dynptr data and slice
Date: Tue, 19 May 2026 11:13:09 -0700
Message-ID: <20260519181314.2731658-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
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
index 40a14a5174a5..344fb2aa0813 100644
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
2.53.0-Meta

