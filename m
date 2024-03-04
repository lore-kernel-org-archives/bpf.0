Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D827C6C1
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592741; cv=none; b=WJTRSXefJKF28bGXmWtOurJWXSn3FxfTMOApI8958a7Z+HET+ee5+szDNQYcE4I1HJhpzxWkRXxdi851pyziFUZOr0U4y9vXvT9qlkRWCQNKsLaY+kgU2j3125KIHawpez2qubbMQ+odK2ulULsoVKygCLoFh8iYkehYgYKJ34o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592741; c=relaxed/simple;
	bh=SGugltStRBDh4geB+tZ1Vw+QYKK4QDoGnF8wuYwyOEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQOu6i5AAWtRl9am53CuOBp4Hfhpuro8MftMHM08MY6FSgAduEexskJI6hozr7SoXLpVHuCqOxQWHYioyz0eQKSjjAKmG0pmDSfC7Y1gEy3w1EBVAxzNP49nJ5fwoc/htb3HVHG5UYV2hmlBoPinPHszTbZOJDReU8hC3mJ7i4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNFdK9A5; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNFdK9A5"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51321e71673so5756226e87.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592737; x=1710197537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkFfnJ1OxT0gF8JvrEemyPjOclRJZyg7/H5lWqthZZo=;
        b=JNFdK9A5UpS4ErOqtGA3f8kuAPZ5lG6rEOHWvcn02gH0nJKWefCwaXjELj/VAnO0VK
         paxUb/F4dFrE8hu2TwV5GrXI6Vcwdy1+rfSAg66RH4JdUabDqwohRlS39LTcTIP5VeQ2
         /2FzlpMyLr9TWyj0BJYjnHsEaSghGvW1XllzenqZehOUt28eWPJurVHtqkY5MoGj8sNi
         4emVWUimO9gVtB8Ie9LmYjrxCOlzI0cFyVj5HtJoJgjhWryOi9kgnuHt3PJ6PwAikgVw
         H4UNK36jBWmCuNDLQrXPAFQQfPWz6ay42f28NYyE8KAjYeffo4P7n2PxeGm/2QQvfUhE
         FuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592737; x=1710197537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkFfnJ1OxT0gF8JvrEemyPjOclRJZyg7/H5lWqthZZo=;
        b=PUqlC9Gi4L0iI/MxAbO06hOYHz4e88gK08JW4M+i/bYOfnvXvJKDLD/6Fmi3KF9r9e
         sC301zBs0ly9caVJvsCnhLVaWQqkdWHTFhwiaGRV/VRCGjlGeNpPk17myAd+A7eNJzeV
         ZoFcobG9N8BBM4FLZLxxXu2yhH3uDlDDzLoz7xnMa8aXh3Z5VDZ74SuCps3fHRWZDyIr
         Sl8/Ur35PhdWGbgef2HuGJPtLAEX6zayOWxrIQFAWwB0to4tDqVHQPKjm7G8ydrFv/ZN
         1GMuap6lCq96VL0lLB4wS2nlm7S2zxJYYsptaaXwmoAGP5b6yltLXFfGz1Y+YzrCm4Jn
         svgg==
X-Gm-Message-State: AOJu0YwZHpWEU5S90MeXlOvf404TvwBfAY5IQTKvYG9Peo0tDo2j8EWu
	qzEw0WEUqF4gftIF7LGtzynPAX5fFbUtvqXXneSYP05dMwaG7ZOtgy1Z2fAQ
X-Google-Smtp-Source: AGHT+IE/EjKOdT/bvWfuKjL59ESKOY6NCGpI4hzrHYs+p+pO0+/T1ivRjHSE6bgrdsXp5GBWFYhiUg==
X-Received: by 2002:a05:6512:2037:b0:513:4fc7:2dbd with SMTP id s23-20020a056512203700b005134fc72dbdmr92420lfs.60.1709592737402;
        Mon, 04 Mar 2024 14:52:17 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:16 -0800 (PST)
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
Subject: [PATCH bpf-next v3 08/15] libbpf: sync progs autoload with maps autocreate for struct_ops maps
Date: Tue,  5 Mar 2024 00:51:49 +0200
Message-ID: <20240304225156.24765-9-eddyz87@gmail.com>
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

Automatically select which struct_ops programs to load depending on
which struct_ops maps are selected for automatic creation.
E.g. for the BPF code below:

    SEC("struct_ops/test_1") int BPF_PROG(foo) { ... }
    SEC("struct_ops/test_2") int BPF_PROG(bar) { ... }

    SEC(".struct_ops.link")
    struct test_ops___v1 A = {
        .foo = (void *)foo
    };

    SEC(".struct_ops.link")
    struct test_ops___v2 B = {
        .foo = (void *)foo,
        .bar = (void *)bar,
    };

And the following libbpf API calls:

    bpf_map__set_autocreate(skel->maps.A, true);
    bpf_map__set_autocreate(skel->maps.B, false);

The autoload would be enabled for program 'foo' and disabled for
program 'bar'.

During load, for each struct_ops program P, referenced from some
struct_ops map M:
- set P.autoload = true if M.autocreate is true for some M;
- set P.autoload = false if M.autocreate is false for all M;
- don't change P.autoload, if P is not referenced from any map.

Do this after bpf_object__init_kern_struct_ops_maps()
to make sure that shadow vars assignment is done.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 25c452c20d7d..ce39ae34fec0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1031,6 +1031,53 @@ static bool is_valid_st_ops_program(struct bpf_object *obj,
 	return false;
 }
 
+/* For each struct_ops program P, referenced from some struct_ops map M,
+ * enable P.autoload if there are Ms for which M.autocreate is true,
+ * disable P.autoload if for all Ms M.autocreate is false.
+ * Don't change P.autoload for programs that are not referenced from any maps.
+ */
+static int bpf_object__adjust_struct_ops_autoload(struct bpf_object *obj)
+{
+	struct bpf_program *prog;
+	struct bpf_map *map;
+	int i, j, k, vlen;
+	struct {
+		__u8 any_map_autocreate:1;
+		__u8 used_in_struct_ops_map:1;
+	} *refs;
+
+	refs = calloc(obj->nr_programs, sizeof(refs[0]));
+	if (!refs)
+		return -ENOMEM;
+
+	for (i = 0; i < obj->nr_maps; i++) {
+		map = &obj->maps[i];
+		if (!bpf_map__is_struct_ops(map))
+			continue;
+
+		vlen = btf_vlen(map->st_ops->type);
+		for (j = 0; j < vlen; ++j) {
+			prog = map->st_ops->progs[j];
+			if (!prog)
+				continue;
+
+			k = prog - obj->programs;
+			if (k < 0 || k > obj->nr_programs)
+				continue;
+
+			refs[k].used_in_struct_ops_map = true;
+			refs[k].any_map_autocreate |= map->autocreate;
+		}
+	}
+
+	for (i = 0; i < obj->nr_programs; ++i)
+		if (refs[i].used_in_struct_ops_map)
+			obj->programs[i].autoload = refs[i].any_map_autocreate;
+
+	free(refs);
+	return 0;
+}
+
 /* Init the map's fields that depend on kern_btf */
 static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 {
@@ -8163,6 +8210,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
 	err = err ? : bpf_object__sanitize_maps(obj);
 	err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
+	err = err ? : bpf_object__adjust_struct_ops_autoload(obj);
 	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : target_btf_path);
 	err = err ? : bpf_object__sanitize_and_load_btf(obj);
 	err = err ? : bpf_object__create_maps(obj);
-- 
2.43.0

