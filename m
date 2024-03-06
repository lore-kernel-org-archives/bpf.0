Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4F60887
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721956; cv=none; b=tcnB1yPvCGydQAICoVHPosKTwwJ9ed1YdtrX6y1YFkUI0qCNJP/1mF0myTSfLIk+6oyRO9Laq5BgKkjEU67EIotSmeTcNcmG97/u3vfIWAmzCBAvHvbqfdJOlNNqtk/Sr6pSLZJbokMXi+aC5mVNFt/guqj9yxPHwqESLLLp+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721956; c=relaxed/simple;
	bh=vFK0/Gi72ctLPZvfLiE2fSIeO440e+Xuwy2HI5yPo8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epub1AO9kXpYht6ZXBXl6Rzar3CTr7NdjW9IzKnLGGV9kO4Q1C4TTNOdTry8mPArlG7nrJWV8NHRjfZy9Gr1CibpBzOObOmRP6RSr7MjhShdjnGorC7wBUMs5ShPhtuu75ZCXHD/0F3EeIPQUAvM0D8+vPHyb0j82bEM09nNM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8bFMbZZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8bFMbZZ"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512e39226efso6733878e87.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721952; x=1710326752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B38VbkNQ9IyC3AD4wqb11aaztk716mYb2bs5TwzwrxE=;
        b=S8bFMbZZosu2uxQNWxtuHH6+VtVPZmj0E9gBao3Pis86JsYiRbcVrJim3mBB3ihTqR
         0C4ZyG+C3CZbbbYs7RTh87gE5sO/Pe4eE4mOtVGJ6yiyflj4agZJtpqUpopoPAU/MsM1
         7FHuWYcFczS6bz0XN+DnCidOLXSF6s3rid0PmqjGhEL1GjtBuSi/Zu5z0VBPRxN86d66
         eBypni31IjE32NevCjy5hGc1tqPtIzEdbGh3rMHco50x7Vjyin34koOuf8II+fgLEPLC
         DNgr5F+88RBuZmemHXa6j5dlqaCVV4tAyc63cdFtMiCv4v8w2jaPbkPYLwKAOXKIulqL
         97ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721952; x=1710326752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B38VbkNQ9IyC3AD4wqb11aaztk716mYb2bs5TwzwrxE=;
        b=Z+wSlMwxR+eF9slprG4BsaTDMG4b+Q39OzlQzCV2hu3tuiztKtAhFnz7FAQKlUIJEU
         4RxJBwnwJvxDJpNifkBIwSy3i03v47PUysnAZZYhmVaWgSm5gnG4R9tQB96/pqG0R3ck
         mNSZ0K92mdUmojSycOQIQqc+3rznU1Of5/iTEBAwhTwDDQZXjyZaVdROUmA4AVITwIzD
         o6TimnJ8AVN9LjjzePB1pRcwa+annCSgcNA6DjrJJcDqOwxLIhRdW02ykXs2NM+Izmc8
         YpB0s6uijqeTdZ0XclVCu2K0KjAzGQB1uueWzWhsyfHcifLDqeii1+mMXlo65zRhvUyQ
         7BNQ==
X-Gm-Message-State: AOJu0Yx594uQk/ZHJxD9tIoOHzPnRCnapP05MBj3KHPVQ3em3G035tY7
	gHdZmkHDcgE7ReMrh1kX2gE8FVexlsSuGPfzwW/qC239LrjjBylbHBP6B6yf
X-Google-Smtp-Source: AGHT+IG/iEuBETYtx5pURvmIh2Nu+K9p5/gjXGX1DeBwPvcYQ8eGot+SSbP6cu+N3wVfp61egnoXoQ==
X-Received: by 2002:ac2:554b:0:b0:513:2858:6a67 with SMTP id l11-20020ac2554b000000b0051328586a67mr2487625lfk.63.1709721952555;
        Wed, 06 Mar 2024 02:45:52 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:52 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 11/15] libbpf: struct_ops in SEC("?.struct_ops") / SEC("?.struct_ops.link")
Date: Wed,  6 Mar 2024 12:45:25 +0200
Message-ID: <20240306104529.6453-12-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306104529.6453-1-eddyz87@gmail.com>
References: <20240306104529.6453-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow using two new section names for struct_ops maps:
- SEC("?.struct_ops")
- SEC("?.struct_ops.link")

To specify maps that have bpf_map->autocreate == false after open.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cff72de42bf4..ec0f508b853d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1322,6 +1322,15 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 			return -ENOMEM;
 		map->btf_value_type_id = type_id;
 
+		/* Follow same convention as for programs autoload:
+		 * SEC("?.struct_ops") means map is not created by default.
+		 */
+		if (sec_name[0] == '?') {
+			map->autocreate = false;
+			/* from now on forget there was ? in section name */
+			sec_name++;
+		}
+
 		map->def.type = BPF_MAP_TYPE_STRUCT_OPS;
 		map->def.key_size = sizeof(int);
 		map->def.value_size = type->size;
@@ -3685,7 +3694,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
 			} else if (strcmp(name, STRUCT_OPS_SEC) == 0 ||
-				   strcmp(name, STRUCT_OPS_LINK_SEC) == 0) {
+				   strcmp(name, STRUCT_OPS_LINK_SEC) == 0 ||
+				   strcmp(name, "?" STRUCT_OPS_SEC) == 0 ||
+				   strcmp(name, "?" STRUCT_OPS_LINK_SEC) == 0) {
 				sec_desc->sec_type = SEC_ST_OPS;
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
@@ -3705,6 +3716,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
 			    strcmp(name, ".rel" STRUCT_OPS_SEC) &&
 			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
+			    strcmp(name, ".rel?" STRUCT_OPS_SEC) &&
+			    strcmp(name, ".rel?" STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel" MAPS_ELF_SEC)) {
 				pr_info("elf: skipping relo section(%d) %s for section(%d) %s\n",
 					idx, name, targ_sec_idx,
-- 
2.43.0

