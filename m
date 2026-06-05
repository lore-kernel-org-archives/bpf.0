Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB24C9560
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659706; cv=none; b=NS2rC9W4P7kkbTjnJKCxOil5fkZtB62DL0flIBWhoRMo8qSG5/KJSK3o0kaGkIhoxrQ0SI14V9svErKaelaVvUq6aYgtkFdKOOi7xBjvbKRRnWg+6MgK6Y6Ly+Y0SZZuHL69rl/kydhzZK9taFw0YaAr4uBd/CFb4Gpk2E0lYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659706; c=relaxed/simple;
	bh=ga1aB17ntL79MOPRtpxzjO6aLV18ItfeLCRtlyiaiAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOVzeP6jD6hzDRdtbwDRhbFBdctWh+XzjlvMPTC2FtBqC9+Wf6jQyQY5tv3WktEhKdh5kjJwO9GA566utK13pThxN1ur2d9enfby8RJA2BJL1wVvfi+OSjysicJTEX6XJ4uM7QNDsjgBBbTStRT/b9dbdNqcjuXjcWePZ2XrvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qdg+p5fL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdg+p5fL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so12136775e9.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780659702; x=1781264502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vimfmm1FBkLbHULTqa6OxnSjhwN21YXtlrUewdCK/TA=;
        b=Qdg+p5fLPH/LS26c13S374ZaDUZyBsvfSwItJ711phrN1nqJOtwwGE3icHEaAJy6ck
         6sqqa9fa4Rtp83T5oW+56SpoR07DK/JJPOWBlcIu2IkEjFtkuNnQ6ejUQEgP0+COIPaq
         gouKc8YsdS+JjWxvKcgTsKyt5ywAu9anX3hxezRhHV3Ii6bBCEUJ9OfPMqNLTW8R/R/K
         dCVRPawkgaUUSSogifHPO8wYvCLEKSxdf8jdPLtMUx8K/InvAqgSvxAIE4nlCvopCRf1
         dGFvS8RSkLou4ktAsNM6tRSV92/uiR5IPCnfd0LvuCovXQnGxJW5GtVZzqApkiX4yffO
         Iwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780659702; x=1781264502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vimfmm1FBkLbHULTqa6OxnSjhwN21YXtlrUewdCK/TA=;
        b=oiQvKEXYVBkSQ5ZOfn9QyYoDZ6F7LIKM171sknvZ9TAE4uLONP5NuAbWHYbdKk6VuN
         IjY+2XKR9IXZzTH7SKvC7pO322uWgknnL5wBjicKFTK/bfKlKohcBblZkK4hgamIkdpa
         IroMk/PCeCmkRSXXft54eQzDX/3XDI8A2warDnvjQ6z5xatNcM4IcdGZeEQOIkpSeSq1
         d5cj5ElOk9NHBkYcCUU0IkTsQdQmekgjhjqcPA84YS4sbFncp/DsekxjVPbzc8UNc6tp
         ye5xiwVb87VryigLuYYJsfITui1l7kSdyfCeWanL4nHW+mq3X2xWhY4emadlTnQlzsp0
         KtqQ==
X-Gm-Message-State: AOJu0YyuiG3yEbDQh+7mrHXRaPND3Vn59NcGwnfiuoH0x9TYNI84a7Wx
	/KQufhIL5Px8/4pWf0ZxnhWluuEbTJAfuvoyTbqEPLqefW8wU/mU9yST
X-Gm-Gg: Acq92OGnY4OD61XXDMuwq3LjqsgeU2dx+B0cWMGvHSk5KMTkX+AaYtbxM1FfvyftfQD
	jrTWy3oDjCftn0LuSbR6JQYdjFT7DwYf5C/3bHs3STXgQhhKY0fVaW3q9hOOCrph2BIeoEvJ9NB
	yIpOGhI+e+C6IGTD+IB276ZyUbcQEIpGegiR87isAjLu8D0Dbn/PoWcBsZNYn8edH7ZWJCrsR3v
	r7/ZISNgEvwxZtA/BMgS3hTd3CTuFATqnKmk3b2RgpnqMidVivgX+kqCx1OSssYkN3JpLlmarHi
	sjDUUcvACiWqEpbJfPKAlgewumnRCMjIEsPyK1e2LtmDNNCBNDY2TOx8zVA7Sy6XkED+0mktXWa
	//2R5GnOmaHYSg7pZUCUmikFrrMTv6ct0pDoaBzrBZjn1KUoHtS9KcpgTF1bi+DM4gigqou8Ejc
	TGo03R/LZ/VyG5iT6gH3bpN6jW
X-Received: by 2002:a05:600c:4fc9:b0:490:c015:21 with SMTP id 5b1f17b1804b1-490c25f1634mr48746025e9.20.1780659701977;
        Fri, 05 Jun 2026 04:41:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b59f0sm170112485e9.2.2026.06.05.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:41:41 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 05 Jun 2026 04:41:25 -0700
Subject: [PATCH bpf-next v7 08/12] libbpf: Support resizable hashtable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rhash-v7-8-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
In-Reply-To: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780659689; l=1419;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=eiArZpQjhMU2X8BztxYH8ee3r0EFLa9BsZJ65DtQqCs=;
 b=aAF5EAUl7YBhZ08J+4Dofc2Fy+diAAndX+9f5smpRJ8PY6smNzCRHlEtuuy8RIOJHLovrnrtl
 Q8gJEUtuRYrDqRdNGsC48AWRAgKdavFzzEYK3BeBL/ewcG1SKcmbPbs
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

