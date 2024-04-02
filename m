Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA4439AD5
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043123; cv=none; b=FrVGI2EF9k9ujAoOekW9NJYKgVIPU/Q9BkgTl0YvEO4VMNfmCBV12tddUDIHewucmVXcDoWRqX14By3d4pTQXzvT6MaIlGybgPrCa//G0tgx06Z+vY6YJ272dSBXZ4VG3T5lhbkdZvwzRFrvFoyVJRhs2hv3lHlVVpeNlU4kTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043123; c=relaxed/simple;
	bh=/CmFOwrlZF+cGT1r0cMMORbDyFeq0jqfg8UrPphHpsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M3b/LoLfp4WDuLppxi0m5oiSzpMXrVOMNaD6mqQauh6DhAJgwqDLpvpbjSJeEAscMtRYhYDypF3qN3dtx9oPkMtTcf157fbVV0nrgpMYKDmISpOyiTiRTyR7IxKcNqkBbuA5P0aRfQ6UXxjsJ6krTxytOavFikaIifDteF9UWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=YG9PBUq0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="YG9PBUq0"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so5748103a12.3
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1712043120; x=1712647920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0SzXjx7OfKItsEjQOnsugKGI3FT6QNJs2/+rXuO+NOk=;
        b=YG9PBUq0fmWAtotyjTD2BwlXLgcqRxtSi14XFrzrMYpaGXfiux4Os0iKXeIH0g6ErJ
         ciRdkFVnQyKwpt40auLCLOEW8XkHIOxH4/EJyS/2yT7B5j3YIIcz7lqlNlN+46Jaem/x
         fe1LiAhyTB+vsqTNN9o4ZoURGT3flqMH0VTgjkFQgp73SAo/pxfqBa7e040wZF4RPdaC
         zK2fJyVoedsOUtBH+chHzEjgcY7lXcKxSRLBoZ97tOwiYuVtOUaS/zusG+R2PFrn4JpL
         GItLEfAPqBDSPzUsAZynH8KSrlS5TSVMsTWx+3720J9V8jkNJ+bhaE5dXUpvBsZMUJPP
         zX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712043120; x=1712647920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SzXjx7OfKItsEjQOnsugKGI3FT6QNJs2/+rXuO+NOk=;
        b=MKg/O+2WVzq77M+vamCvXKaHuKpRrJrrC/Zl74vRmPJmRTtdk6gRoYJBOn6/K+/ciS
         dSNWr4HaxX1utdy2SqJhoJkLIX5LCmGi0f8uXGjUaBreHpboIPtnv2xOWj2e+2A/aWbf
         GVwl9ztP91XtUpW4qRYzj7INKBJUskyTiYIsaGpcXwU+HpypPVRSi2Kgpn2eTWyrrbfs
         6Nmv5/43jIHs7B5d39prBRJ++Z4XGeOHV8uor1H4rJp/lOVr/gj9doIoUKoEoT9IVVJi
         URtB+jUNKb1eiDSrbeSV5Y7ATjZSTj9eM7TXFU5pcoDcJRpw+o8DrWDJkaEXc3TzrrQy
         eQRw==
X-Forwarded-Encrypted: i=1; AJvYcCVpr5WOPtzzzxaOKktVWEEKtIr6f8QvbcHOwZMzWqCfLH6RsAWq9iQLzbs6VlJlzzJYUh6tqwMNuwhAG/zA2Fx/WNM+
X-Gm-Message-State: AOJu0YyeopTMWTyqJOUnDImoLXax332r4ToX0WmCuyZ616isx5eCuLis
	j1IPFtpDpFcJfILzQxt7f4+BCLk0GQF1ka2JEQ9UMVdvx2AJyuTLHkQmZ/wYUqA=
X-Google-Smtp-Source: AGHT+IEjxm4Cu51Zs4M0/vOcZN1r3BqlRr5RCYDQuB+nCnu3ch5oErGuXmcBRsAfV2MMmTjJBygHRw==
X-Received: by 2002:a50:9546:0:b0:56b:6ec6:af2f with SMTP id v6-20020a509546000000b0056b6ec6af2fmr7165864eda.6.1712043120294;
        Tue, 02 Apr 2024 00:32:00 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id q14-20020a056402248e00b0056c5515c183sm6099352eda.13.2024.04.02.00.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:31:59 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v3 bpf-next] bpf: add a verbose message if map limit is reached
Date: Tue,  2 Apr 2024 07:33:47 +0000
Message-Id: <20240402073347.195920-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When more than 64 maps are used by a program and its subprograms the
verifier returns -E2BIG. Add a verbose message which highlights the
source of the error and also print the actual limit.

v1 -> v2:
  * make the message more clear (Alexey)
v2 -> v3:
  * fixed grammar (Anton)

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edb650667f44..559526191ae7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18348,6 +18348,8 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			}
 
 			if (env->used_map_cnt >= MAX_USED_MAPS) {
+				verbose(env, "The total number of maps per program has reached the limit of %u\n",
+					MAX_USED_MAPS);
 				fdput(f);
 				return -E2BIG;
 			}
-- 
2.34.1

