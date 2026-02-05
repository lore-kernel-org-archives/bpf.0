Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043332BF58
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323233; cv=none; b=V9bcC8aFBvW19GD5/nUiZNp0/2x58ND09zH/yfQz8wGHSU9tC6BuvMQUI2NV+YklxYqLY/CIX1YoAtHZBl9O9eiTZaRFwSUsN7Wh0qChzwy2w2uDe5pPdEs049i2/0om7jjBZXljpj/g9puf7u7mj/u+UD7o7ulqpe3/L22QE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323233; c=relaxed/simple;
	bh=XWbhKf0ncDKg0b0U7lER88Be6yIlVGvF8r8LzVeVviM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ChK1E7YnZmxI4wK5WC1GFkWPsIYZNApcpbEdkZJStRudhQW6JQ/Lhn1HtCciaeJQv4jYSLx+zhIEcAtyoHT+dNWnREZb8HdgXCBO7iT8BnBqCF0e/3kkPMMq8pd5g/RnczJ9JnVzp/gY3kiR8ximOG2Wj/u4lhz250gPqg44qE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VisVfEev; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VisVfEev"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so86915e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323231; x=1770928031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTuTz/wFIn2njU00cURT3kPAwouZdr6Y7joEBoM3kZk=;
        b=VisVfEevL75hqevxD3KfRKhWIDE9bRJ7+ViOchZexNtLribKTWRrRAhltMEHcBixr5
         v2FGbSqX6vxAiwSwakaHQ8jyvKJYijr0l1DUujV19qj1NqtfopcNrBqILYvjkrJ7Vhgh
         1jygiJp3Jq9rZhRdL/CfKkF5W4ymoyRukMAxtQtJicvvLdfYC4ZWVzxoXNw6gQTVZ9zV
         F1l/cZAQv7u+8zIC5HLPIGd4WvBTWdcU96AGQibRFRyuHKHDUKEvtmT3BTDXA8RsDAMl
         mCIYZ3aZisOlncU4FDaKVVBt+/efmVkIhi2HJp+ChMr4ZFZqxkZwn0PfGv8AcUX5BjhP
         6h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323231; x=1770928031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nTuTz/wFIn2njU00cURT3kPAwouZdr6Y7joEBoM3kZk=;
        b=TJU1FGoQ8G/gxnu3VAUfGLcsH1fOkTcq5sSObC7zK/t9BmISSxYnVZJCwtsxoAa9c7
         WQGSKTgfXQnTE1akKOfSZetoLaN6EK2HLUqk/C4wz0+jK1El8QE7c2EhsPLODdQajl0s
         eqx8QUujvcPuoudmSSTDrivNW44fvevGRIcA9FtIoqbbGYPww0dJic+yQcoYyuWArmMT
         U2OJZlnz/1JdRsE8mj6GDh0kwQslznP5BzHwg5S9lmbOLibhoDkBTzENlTwps+h9EGTH
         AefpOBDQXmc/4F0TYIJ2yRR56fIpk77R0DudaGA8xPK/0iO1s9y73wjtqfwOJKs+9x2V
         HNUQ==
X-Gm-Message-State: AOJu0YzDVgOtNCUkVX3CCU9X3jSsej2ZeZgXg61L/SuBpTXYRWVcvn4L
	o7JptyFQYemvNy27k235hFxPpoMSTpWt0JQfzEiz0Fo5oJ1u+g6bZ9eR
X-Gm-Gg: AZuq6aIHLenulAgBDYnSa6bHYnrtwJNiaV7NAMMAh0/ubS3AMf60e88ni2gbpKixW0d
	AfGo0ynNg6pojggwPjA4eQBrRTktUm1nC3F5m+tOmghfm7d41x4E8ibsTKZqsdEqOizt6j945Hv
	HNKAnJePkfxHJ7bRZpWS6rrxCqjt7ky6n1LjpTv9Mt5yAxhmc9vQ2vDak4j/YDOQfYY2HeU9BGj
	83TNl5odf1KCDgm0g42k2nRaeEAoOarbmppCnJZVSPUpsIXn8w+p2D98RBnTs6n1+UC7SsrjVLM
	+tIEIfC9QE+4eWabwqeR1DegRbrB3ysM9FSGdmti/Kx5H+o2SglHqe8E+2nnUjueGdW60MK1gP6
	24gn61FJYlS5xQNkqNqO91b4fMa3X8p5GHOxa91cFsNldMsjsgHJXql0gv+2MBaNqZA1EanY=
X-Received: by 2002:a05:600c:3b03:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-483201e3b8cmr9236895e9.15.1770323231312;
        Thu, 05 Feb 2026 12:27:11 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206b8ebbsm6853505e9.1.2026.02.05.12.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:10 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Feb 2026 20:24:35 +0000
Subject: [PATCH RFC bpf-next 05/12] libbpf: Support resizable hashtable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rhash-v1-5-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323224; l=1321;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=F3tlYum9uruDa4yLS2qQWQEmY9cBsVGLDMnbRuivyP0=;
 b=YHLhsHK/tYChGBHdq9PDzsIefB3NVvNBFJPLcnosri7Om7/dFHUg97wJf5tEtX6tc32KQC3NV
 Ftt3oFCc+KyBpIsFbtj7ijAYrTz4WjISzfn+7F9lpCEk+jRCbrqGt1E
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c        | 1 +
 tools/lib/bpf/libbpf_probes.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce44462414e99a958260e940148e818..7651c80a72cbc30cc42c0c3f4b5dea1427b810be 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -192,6 +192,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
 	[BPF_MAP_TYPE_ARENA]			= "arena",
 	[BPF_MAP_TYPE_INSN_ARRAY]		= "insn_array",
+	[BPF_MAP_TYPE_RHASH]			= "rhash",
 };
 
 static const char * const prog_type_name[] = {
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index bccf4bb747e1d97b7d0408c9f97528b88c73281b..995b3883889dfea8dd77daacdac49828743f87ed 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -299,6 +299,9 @@ static int probe_map_create(enum bpf_map_type map_type)
 		value_size	= sizeof(__u64);
 		opts.map_flags	= BPF_F_NO_PREALLOC;
 		break;
+	case BPF_MAP_TYPE_RHASH:
+		opts.map_flags	= BPF_F_NO_PREALLOC;
+		break;
 	case BPF_MAP_TYPE_CGROUP_STORAGE:
 	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		key_size	= sizeof(struct bpf_cgroup_storage_key);

-- 
2.53.0

