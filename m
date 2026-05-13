Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46883A5E7C
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711834; cv=none; b=b7lfaylTxfQMDn6RKOCrZ4KGyDUauyNc0tiCNhHfHdHS4UPmX6FieyMWktizWCkvWb8WcRMfVCrLgVk7X+BE4afOa/uyanWMD9H03SiU6SumJBeb7FZU8uLTEhSvJesBbCnU+NzlTzHZVgUi613gUe4tZ04QgR7f46X9Xs7JpaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711834; c=relaxed/simple;
	bh=ga1aB17ntL79MOPRtpxzjO6aLV18ItfeLCRtlyiaiAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGjg1X56niRc5Z14NDd+q4n8EIl2VeT0V9HfGD4XkiyDBMVply7y7TGWeTWVCDurCRBnKqpWjlWoj1KvLTRQVkfCcaCOMsURC6qauEjmc/AX4a953Z1lkhraxlXA3dL7slPbtQ8HDjET17nlrAxyzJTJ0J6hh1RimJNWNZfDMMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lu/3SV+s; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu/3SV+s"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso78000275e9.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711831; x=1779316631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vimfmm1FBkLbHULTqa6OxnSjhwN21YXtlrUewdCK/TA=;
        b=Lu/3SV+s9q/BIZT+4nCnZwDZfHV1xhh/YYC8UpSAMH5gu2ALVVyEU+tgUhXfJdweso
         UVX4UL9IE5M8SLHD0wwR5z3ZHPyjI2MFDGcrPo5Z332Ia1OxL2/9nlJ84eS1HX5sk93L
         zFedJmMg0ZdEyhSQ0qkgBXgOm2QlkFZHPkvkv+cVJHtz1YakA77MsmiOQ+jrDO9w5Lcg
         fioMvM5mfMj/JrhDTa2K3O+xeYWf59r8q+Qqto0VG3Y+WP8yIHzB2/02KO2tPoTQwWgi
         5IzgJVfQ/3RHbTbnMNhuFYOA36aK5T7SeqBGP7HdrZJadCJgHnGDhDTMyjn08JWhyXMn
         A8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711831; x=1779316631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vimfmm1FBkLbHULTqa6OxnSjhwN21YXtlrUewdCK/TA=;
        b=S1aXuuDdHy+P+X1ZjgEhYHww5G0ZTJBbd0pMy15oDZjele5WNen5ICuFMeBcK5H2ww
         T2OOi8pipbwYsEf/OLMUo5xoNXkhc7sYgKotVPuXBsZk+xqMIwL5oG3RiRY54cqgrXEk
         sV2Ujg4bkqI/VjNFxhuNxqZft/9GOwmCC8EtxJ8F4wtJfM8kgZHXtOmLYPJJiZbMOhRQ
         l49GafNam0eOyJOBlX3nH/HxNLXPB5R4plzVcbJ82idhRIGyTIGOq7Gw+c/0afjqhZMA
         xDrPm0xIuEiWiR/QGmJzzLcPsDl8HRy1x/gAd+J/xZZBRVpMMoputNyhK1p/et4wwzBT
         IPwA==
X-Gm-Message-State: AOJu0Yzg7hDgcmln7+vZCpDxlgb25nHxrDQej0DE4XtRCIIepMZAYjLz
	fWpWdr1oRuNwVJSdjpMZCtYyBXCTIrFuAkAHIUZ2ql9nI/nAM380tlRR
X-Gm-Gg: Acq92OHSRbe/jMVbgiOGCUSK1SOLRFmZUaIgBygDTobX6/6PZkyMzuhK8h+xTWbfmOO
	Yh28sAFPcpNVxEDFNz2A0u0jsI78z6806WPNxJ5SdqRnYmDGeFgOnHHrXYGnS0XhlXAbsxHOGvc
	Mb16Cznxo+grMPLIK4F9Kx21/o8R7VDMT7j7pjcjbFchiRCy+UmuVGIZ8f5KMz2+O+eAEHnEgNo
	+nYiHNv57NiIIRzkfumpwwdcw5YKGt2oAAGycLvnvv6DgGXv9dNqGoSdoLcWcL8Cck8Ti3e2A/6
	X/d4slg+Rk4CN+Ybqj/KEbFLeTHVy/rMJa3BM9sNa5b9S4HT/mlUbSO/54kyqY0oOwbK+z7PGtq
	U8ii7PSM5vB4O3WMMblsttNO7gNdBVmUKhhV7LMDZ+BAsNfTiFtQ3z7h3QKGl7DjC7b6/F2V4Lc
	MGg85LlbegDvgC
X-Received: by 2002:a05:600c:4e4d:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48fd6359652mr18451285e9.9.1778711830714;
        Wed, 13 May 2026 15:37:10 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb2716eesm4007105e9.5.2026.05.13.15.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:37:10 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 13 May 2026 15:36:10 -0700
Subject: [PATCH bpf-next v4 07/11] libbpf: Support resizable hashtable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-rhash-v4-7-dd3d541ccb0b@meta.com>
References: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
In-Reply-To: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778711817; l=1419;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=eiArZpQjhMU2X8BztxYH8ee3r0EFLa9BsZJ65DtQqCs=;
 b=UbAyU9vCZPuB8aMFmrZDVzp69YWzjUxodA26MfALxRTSMrOYqg/MYmRpEPfqMrj6b9mc74Kdz
 HegWp4aW+EDD86FdZhz/5Y+XNlDfn2rS9LwwNE5PH6OnSBChOka2QJw
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add BPF_MAP_TYPE_RHASH to libbpf's map type name table and feature
probing so that libbpf-based tools can create and identify resizable
hash maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/libbpf.c        | 1 +
 tools/lib/bpf/libbpf_probes.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ab2071fdd3e8..1354bcbc8b30 100644
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
index b70d9637ecf5..e40819465ddc 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -309,6 +309,9 @@ static int probe_map_create(enum bpf_map_type map_type)
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
2.53.0-Meta

