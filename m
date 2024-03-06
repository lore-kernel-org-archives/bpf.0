Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854E605B1
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721947; cv=none; b=OIoMP/4sRgdDUDUaDwVElFn+esTd9nmBOjgxeKkT6hCuUcCAeoBv4y4lVQXk+THCJLKTUVyYAQek9CnQhTY7KCSqgrTEmardKkQLatTkwocVjtBPHJkXzrYEbuBHcxTUIsz8C3JytdE2mAiYZtrlwLZn544qS2dNMWRFnJl9tPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721947; c=relaxed/simple;
	bh=2kOHAempn5pz0xL9loA2uYivlISfYuYhenGFOFmFKJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wppxism63XIhCkwlUgRf/74CPhbUG0OOm/zv93eknsJMr7tkxgoVMcD0gns+GOZwqoeG8YyzRB6D1IGPwFU9tZhPrq0GBec59BGbuuS8jJzyKlGak89hM42cv5c2qKsDYFXlFVHX+mYleeABZYnASuNAx6X3fqxB0idD3hzVSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye9DxsAr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye9DxsAr"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a45bb2a9c20so57566566b.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721944; x=1710326744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu+CRpIdKn1mMAIY+aQXp2RuVcGDqVY0wuARmCwSDS0=;
        b=Ye9DxsArGP2Kw2OnStNGvhFVuwlTUbUxXAsUqtW+7DP6GpbzqCNBAsoAWf5MpRVs8E
         +czxPilRae7BBhMzYExpGQhfceCWmFUWiFSG+aI5Aevlg1wIv5uqZ0SkYEd5zhdk0RT6
         qfa84GqNAHNbwGRxlIWNDxFTWOMutlmd4ClUINzJO04ZJzgksNb7HeuEAAZe15h/dcUU
         6eQnFvFn7AgN2HGtTsebh8CuCUypQSAOx/gIqn3tAc7p6iVycLDBa334x6tsSsgGUxdB
         eTEc1yO6VOAZfUpgOKmoEm5WMPsX4Fzmk8UFcxxJ/13XJMcyoipyYT+IVKv9tG9px+BY
         TsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721944; x=1710326744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu+CRpIdKn1mMAIY+aQXp2RuVcGDqVY0wuARmCwSDS0=;
        b=oSj3rOq1mFO2EaiSZYHH+vtHjRQe/Sin6lr7pgAGoorQXV8GrfrQ19Xg8TPT6xI2Rn
         oKiOsleO4woCnkrdf6WjToObh9L0qiAkhPGvpy/lX4PlouT3/voE/AzjzUHvt/TooJ/1
         fZc80cKvPxqhvUwK9ehyb5a3KRwlCn9Eg9n3gD9vDx08xYvVR5J/vMAwvxYSHNrAivRm
         YDotj1bj20uj9goiVTsqD+Kd2OcFYDZVfujdwMuBzb/vjT0Qhm+sfpkF3Y3nZaEDE6lf
         tzyXUVXdmh5qC3wcQyCCc5m9vgb8dpLdzUmPqp+DaJTCw0XTkRLdFkK32KDbNPR60jvT
         yIbw==
X-Gm-Message-State: AOJu0YysjSQWHmxwJdi+aD6iQB+OSYGClKqhfVH3N1h43KbsPIozsSK/
	2MzbQOVv4EPk/UMo5rgCBJpizfNIqLZ1bMgIzI8RibXiBOarvAJ8Y5ppME3U
X-Google-Smtp-Source: AGHT+IH9pdEIHrBcVfoZgfDbY6TvkAcZm8rSCsCyQA/WyCYZOMlnGsEqVcakt/qzilA2g+jhH1xtdw==
X-Received: by 2002:a17:906:cf88:b0:a45:373:d0a with SMTP id um8-20020a170906cf8800b00a4503730d0amr7913679ejb.32.1709721943623;
        Wed, 06 Mar 2024 02:45:43 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:43 -0800 (PST)
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
Subject: [PATCH bpf-next v4 03/15] libbpf: honor autocreate flag for struct_ops maps
Date: Wed,  6 Mar 2024 12:45:17 +0200
Message-ID: <20240306104529.6453-4-eddyz87@gmail.com>
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
 tools/lib/bpf/libbpf.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2c0cb72bc7a4..1fb9a4f237b4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1212,6 +1212,9 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 		if (!bpf_map__is_struct_ops(map))
 			continue;
 
+		if (!map->autocreate)
+			continue;
+
 		err = bpf_map__init_kern_struct_ops(map);
 		if (err)
 			return err;
@@ -8133,11 +8136,20 @@ static void bpf_map_prepare_vdata(const struct bpf_map *map)
 
 static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
 {
+	struct bpf_map *map;
 	int i;
 
-	for (i = 0; i < obj->nr_maps; i++)
-		if (bpf_map__is_struct_ops(&obj->maps[i]))
-			bpf_map_prepare_vdata(&obj->maps[i]);
+	for (i = 0; i < obj->nr_maps; i++) {
+		map = &obj->maps[i];
+
+		if (!bpf_map__is_struct_ops(map))
+			continue;
+
+		if (!map->autocreate)
+			continue;
+
+		bpf_map_prepare_vdata(map);
+	}
 
 	return 0;
 }
-- 
2.43.0

