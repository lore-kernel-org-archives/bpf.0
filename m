Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B797B3FA
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592734; cv=none; b=tJxZz/jLuoHuqDnmFMQ/Iq9wpThcV3ZC30gU7RCayDRHlFkVpCTydQFn2ca2oT7/hz3Deh7VEdgEk/pLLvzRCcLoMsdANthWA6coKunweeoEXz2SS6zSWICBBDAcucORvH6+1Xj3R3cfElb97Q3yhZJOmDuNqZxZpQsFrNopKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592734; c=relaxed/simple;
	bh=MxAP1Mj+92zhg+N4eBULQMbyQMO4cUeudjXhJFMAEm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7Cpb+GJs7tPones4yDa4jLtZ3K1KyZZia2qDc241ERbdqWRm0KKI/PgACEqKakeObpJH7lqw1RX99jSt8QDBh/bO2gX+ST8fj9yceu6xEskhvri4pBabiaIlWgtb7dQd/tGWyy6wLlGmc5NCcFgZHsqSIVKyGp2CUxqCv3Jmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8Ad3FCk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8Ad3FCk"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so852613066b.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592730; x=1710197530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac39i9sTIpkqIzsBXHyyh1hd2HLA5BkCt5GBSAjk6Yo=;
        b=g8Ad3FCkR7kShM0zUuG3qavleX8wj3n9ynEK/aTqs2adj5csn1qRNAMJbLCCcvthAb
         PKZuQqyrU1DilEd0ApXZW9iFO+1KcawvoD6LOvni4+UkwbVCnI+6yRUM1GwU7YqIFkci
         fD2WzlyupC3z9KCf/Mjn+LB7Uwnf6LLzv3a0B5nqPwp+MA3RmkbrhHBxM1O1FPI3zmLd
         Qo8sCRvueH+pbPU6UZRnOJtqGakwLMsMhFsOvCSzLdFJRD3PA822GG1pz0lIHq9pj7eu
         wRfDOgPaJ91FYR3BL9/PVlZLKSQ5qDJVZaK9HcXPKtOSYzkPUJ7XzQPpxoIbYa76Gj+9
         +YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592730; x=1710197530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac39i9sTIpkqIzsBXHyyh1hd2HLA5BkCt5GBSAjk6Yo=;
        b=GY6Bf7mPblkE/UKSA/NQ4XaX+qI+6uJ7fWoxtFVlL0IJEYu2ucIyaK5Sg0kgUkghp2
         z/o08m412onnAl07sDIlIO+2LeSPrlaIL9lSKtSZ1T70InpqdMLKvxkMu2CeHhyP5g+A
         oURDxL6Yot6QoAXq2XxsSDVqXIk9YFx7vD20Zzigs9F6L/AOo18yYB8N6KAEiBgigiCJ
         IK+2VOOSu36GXtRVHMGZEbBxnps3Kwgn3houPsyrx3YRRSNjUOaMMaqXd91Ny60XvC3N
         Fd0GxA0nefBQ/Pp5D4v2zD/40/mR4gU2RCq78E8xRwKtbeoWEp28+4EubBLFQzG6p46i
         9PlA==
X-Gm-Message-State: AOJu0Yxtt1p2zcURmtmcsYt14g3MU1G0/+vkBMKwLeZ6UouXMMLIpuBl
	ZrO7XgAgCFzGZ+vPz+KvuXEdX9KB/32x9rEbNwCQt7F2vuJ/czbfAAxAMpuc
X-Google-Smtp-Source: AGHT+IHixalHglIlXXQ2Lavebv7pP2ccRXU+8qIRYmVQYEcPC21hXjTIIyscOmgnpHW1dEoXtcZn9g==
X-Received: by 2002:a17:906:ff53:b0:a43:5bc6:17f3 with SMTP id zo19-20020a170906ff5300b00a435bc617f3mr7589876ejb.6.1709592730507;
        Mon, 04 Mar 2024 14:52:10 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:10 -0800 (PST)
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
Subject: [PATCH bpf-next v3 03/15] libbpf: honor autocreate flag for struct_ops maps
Date: Tue,  5 Mar 2024 00:51:44 +0200
Message-ID: <20240304225156.24765-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304225156.24765-1-eddyz87@gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip load steps for struct_ops maps not marked for automatic creation.
This should allow to load bpf object in situations like below:

    SEC("struct_ops/foo") int BPF_PROG(foo) { ... }
    SEC("struct_ops/bar") int BPF_PROG(bar) { ... }

    struct test_ops___v1 {
    	int (*foo)(void);
    };

    struct test_ops___v2 {
    	int (*foo)(void);
    	int (*does_not_exist)(void);
    };

    SEC(".struct_ops.link")
    struct test_ops___v1 map_for_old = {
    	.test_1 = (void *)foo
    };

    SEC(".struct_ops.link")
    struct test_ops___v2 map_for_new = {
    	.test_1 = (void *)foo,
    	.does_not_exist = (void *)bar
    };

Suppose program is loaded on old kernel that does not have definition
for 'does_not_exist' struct_ops member. After this commit it would be
possible to load such object file after the following tweaks:

    bpf_program__set_autoload(skel->progs.bar, false);
    bpf_map__set_autocreate(skel->maps.map_for_new, false);

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2c0cb72bc7a4..25c452c20d7d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1209,7 +1209,7 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 	for (i = 0; i < obj->nr_maps; i++) {
 		map = &obj->maps[i];
 
-		if (!bpf_map__is_struct_ops(map))
+		if (!bpf_map__is_struct_ops(map) || !map->autocreate)
 			continue;
 
 		err = bpf_map__init_kern_struct_ops(map);
@@ -8136,7 +8136,7 @@ static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
 	int i;
 
 	for (i = 0; i < obj->nr_maps; i++)
-		if (bpf_map__is_struct_ops(&obj->maps[i]))
+		if (bpf_map__is_struct_ops(&obj->maps[i]) && obj->maps[i].autocreate)
 			bpf_map_prepare_vdata(&obj->maps[i]);
 
 	return 0;
-- 
2.43.0

