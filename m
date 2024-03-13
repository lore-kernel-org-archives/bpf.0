Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17434535CE
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366108; cv=none; b=s2byxLW8ARXiEHnFL9NibfZ5a+f11DO1FEb0RVFsT40hzHPJlzMdmSxqe56AALlNK+J425GLu/2bR849Zvdo2FI61etYpbOZhYdxk+gHYv4WDn/phJarxrrQfWS4SEK3q3/BO1+GD5MxDPhrFEIK/PjdOnHSXiP/gs73NGUKdfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366108; c=relaxed/simple;
	bh=ply/EUFX0DFTlzOppoUbXuC3+JIXUMN5r0124S4PX4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFozlBixFYZF8SG5Iivini7jhu4xgE3paIFKPs8MBuISqByErc0xIZTu59sXOXnokCtADZ0yF3qsuQ8JRYsHbW3Dbnn9OgXcUWn1meVRYfjbM13kSAvid0skNvT6RWXj3lGDW7K4GIJGOV7ExLcpX5ot2Gxa1Sj2dyvUjbyaJQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wnk4k8od; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wnk4k8od"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60a3c48e70fso3924197b3.1
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710366104; x=1710970904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FypRBUzW9FGcNeJePiI1aw1hm8U6O5hdRlDxrGWkok=;
        b=Wnk4k8odYTsTJ4CEMckFxB4BH+pUEv1w1BC9udfHK27O9shpYLHKfG81ltS/EAGV5d
         lb5+8frQQ1IZTuWMDBKe8k7tScOkiuo5/VwS9EJjNP4vDDNPCa/pkx5QbEhmBnid5s5j
         bKYDNHY6NuQYFq4N3XZNd3AjiIeQr2gNnR7OLKSmoWbFC22LlMIBE/RkDZzgzVRN4IdH
         /ml10dF1d8KT276e9m64eB+3vTT1N7ZAGOR9twVr3XZrbeoLhYMq17vf8TBiKuGX78Mm
         d856YRjXmXfEVUyBaBBhaK/1KD2FL+9pV5JRDQ/0/heBzmsDVzaEsfq6ikMNEfDvD9dE
         Pumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366104; x=1710970904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FypRBUzW9FGcNeJePiI1aw1hm8U6O5hdRlDxrGWkok=;
        b=Vlr7E6BTYNL+kmucnaTVuBnFEHEM5ORaSHD06+9yUGHoScicwJ+lfVoj+PKW8FUEyD
         t7nyxEi4cbt1p/PeESroJF+hnFBdyaZq1NfLSsBVppeTYqZpRw5M+yRKvwLn2D21wjpB
         CazwyEPXw5NlZE+HnBN9H8KSp58R5EgpooZDqr8IWz4W0xsWyb2zI9mPl6sFjvz8d0lL
         lTkp6jyTg3flkpLWozGFDlCdSZWVKxyM1XhJPJ8FPReLtfI1OLQ5nWgYFH71XwExAKI9
         nAzWeOSqJ/lW9B+Ur45JDE8KHPMsBFl1GimZw1EYxBLwSoDP/6uXwEcwHWYjvaILhmmp
         Bxsw==
X-Gm-Message-State: AOJu0YxHFH3B34EdWT0OpQz+WHfRihtvEb2WcHrQEE5E6vBm/GnlJZXR
	kdKjs+NJCYx0dnh3+ecQ4Ch83W2dNsrFAuPSIP5NGc/o1DyhrmSDbSvEFOC9
X-Google-Smtp-Source: AGHT+IF5Pp2IrWB1CKijVPgK7Mde+EtvAo9iKNBh+Q4OW9UBsOMi+3buU6HIcfZ/OQEmMJM/pNug9Q==
X-Received: by 2002:a81:4f82:0:b0:60a:2fd0:8c21 with SMTP id d124-20020a814f82000000b0060a2fd08c21mr3965982ywb.6.1710366104599;
        Wed, 13 Mar 2024 14:41:44 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:30fd:440:22c1:8047])
        by smtp.gmail.com with ESMTPSA id y74-20020a0dd64d000000b00607b3038a7dsm2678950ywd.9.2024.03.13.14.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:41:44 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 1/3] libbpf: Skip zeroed or null fields if not found in the kernel type.
Date: Wed, 13 Mar 2024 14:41:37 -0700
Message-Id: <20240313214139.685112-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313214139.685112-1-thinker.li@gmail.com>
References: <20240313214139.685112-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept additional fields of a struct_ops type with all zero values even if
these fields are not in the corresponding type in the kernel. This provides
a way to be backward compatible. User space programs can use the same map
on a machine running an old kernel by clearing fields that do not exist in
the kernel.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/libbpf.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index efab29b8935b..d0ba6eb605f8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1132,8 +1132,26 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		const char *mname;
 
 		mname = btf__name_by_offset(btf, member->name_off);
+		moff = member->offset / 8;
+		mdata = data + moff;
+		msize = btf__resolve_size(btf, member->type);
+		if (msize < 0) {
+			pr_warn("struct_ops init_kern %s: failed to resolve the size of member %s\n",
+				map->name, mname);
+			return msize;
+		}
+
 		kern_member = find_member_by_name(kern_btf, kern_type, mname);
 		if (!kern_member) {
+			/* Skip all zeros or null fields if they are not
+			 * presented in the kernel BTF.
+			 */
+			if (libbpf_is_mem_zeroed(mdata, msize)) {
+				pr_info("struct_ops %s: member %s not found in kernel, skipping it as it's set to zero\n",
+					map->name, mname);
+				continue;
+			}
+
 			pr_warn("struct_ops init_kern %s: Cannot find member %s in kernel BTF\n",
 				map->name, mname);
 			return -ENOTSUP;
@@ -1147,10 +1165,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			return -ENOTSUP;
 		}
 
-		moff = member->offset / 8;
 		kern_moff = kern_member->offset / 8;
-
-		mdata = data + moff;
 		kern_mdata = kern_data + kern_moff;
 
 		mtype = skip_mods_and_typedefs(btf, member->type, &mtype_id);
@@ -1230,9 +1245,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			continue;
 		}
 
-		msize = btf__resolve_size(btf, mtype_id);
 		kern_msize = btf__resolve_size(kern_btf, kern_mtype_id);
-		if (msize < 0 || kern_msize < 0 || msize != kern_msize) {
+		if (kern_msize < 0 || msize != kern_msize) {
 			pr_warn("struct_ops init_kern %s: Error in size of member %s: %zd != %zd(kernel)\n",
 				map->name, mname, (ssize_t)msize,
 				(ssize_t)kern_msize);
-- 
2.34.1

