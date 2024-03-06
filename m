Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBE605D9
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721953; cv=none; b=OoL3d+lJUz9NRhmseooXmHm+viyNGUZR8FV0BbOqJ0k5V7piPT543yb2ZKSoq5BZYfnw3prnIUUtGX4dvGYBYrWrGPwiu12TybV+STRasl8tR5/phb3LeO46N3V8fXDaWg7k4mSmm9hyJCfW+OOi7XwB8msW04Ij/+1q0Oz9uDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721953; c=relaxed/simple;
	bh=A1SfXuTio4KSbs6b4XtpubbI6FmW0LNaFpy56FN93KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9UiiAzmbmO7xB0hK+oBpHeZm8kP58YP+6UIumILedoYJSIVI5mMqJ7o6ohMcSxwaufuGReOpfUWwmKxkwEq8mJlZ+26boMVg7YyAZQAQ5W6IvJNCsqOZoAWGXYYRjXLIXdoMY1aBvfSThIbY2B0hmITkCJ+4wY0lgbXL/tbfhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKzzdPAr; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKzzdPAr"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51323dfce59so5943889e87.3
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721949; x=1710326749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47GfzjYGZTHpEJubLYjHLgWE8gjKnQhjDWwL4r9PGc0=;
        b=mKzzdPAr8HDkmJztw7fqqYubL105X1+pofXn3qot97pW6Ddb56OnKKVwZXlMhvH5Fw
         hvlpG2R99eu3Ac7iLi08poEeoykoyALX9CmtOAoPo0l469aD4k/ErGcfD8EdlwFtpWWf
         R/TNgbWhYPu79x4oHUJGGWWvkr5a5PGm9D0PXbHtr3cXbbYhAlBSRWTcKzJXpobttz88
         0TVhnLdUslZfVDvDrEW0UhTcH1wJLqM1pQUZwy85D3XlR9UBBBOjXRWGnbYTOCiuHpBD
         K1jnE4Xt6dV7yOd7y1Ek8kDUhwGucxm/irxKyaDKd14ZGoC+WKEB8d1XuZs0X7XQ78GV
         dbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721949; x=1710326749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47GfzjYGZTHpEJubLYjHLgWE8gjKnQhjDWwL4r9PGc0=;
        b=aBZIudOeGxovUO4TdUHAOR0qi0wdXc2xm4nFvXcwLZZGNVNcWEHp7EYB0q/31rJhU4
         +6PGFCGqSnkdEOi9QlZU1D/XM2NYwHWScmj3w1U6EueW3/Oo2fq2+LnuAm/EVkRxpAd8
         LGhnYV7ki5LhGFaLNPo0NrCSSyzihHX22VR7bX5amj62r/OiG/FvFP8LH1goCGNrnpRG
         AAyh8NAola4LNmDp238KT+15aMRnI7SOcMYT7aN3AxgdA5oKSR5IAtsNCCF8bh4KdeOf
         W9cGG5wEm0iOP+mhw4i4IeQ7vOrKHlywFHLRqobwX4mL/9O7yBbAEdb64/C7TENKCfcJ
         jkPQ==
X-Gm-Message-State: AOJu0YxcbIhnD4DmFsTCRzDwSx65gjFzCav2GDakZepvJgVdSbXcXleP
	eQMoVCOTx2VF38VtIwgxRqE/vxYp6cJKQ+8CHzX06zI+SZ3Nbv3lKIPzzArC
X-Google-Smtp-Source: AGHT+IFvQ1RgzhQnroD+d9sge1EwhqofShFH5ovqG0lzGmJplxojemZqs35aYiK9K0AAVzJhIYek3Q==
X-Received: by 2002:a05:6512:312f:b0:513:58c7:371f with SMTP id p15-20020a056512312f00b0051358c7371fmr1932446lfd.65.1709721949211;
        Wed, 06 Mar 2024 02:45:49 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:48 -0800 (PST)
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
Subject: [PATCH bpf-next v4 08/15] libbpf: sync progs autoload with maps autocreate for struct_ops maps
Date: Wed,  6 Mar 2024 12:45:22 +0200
Message-ID: <20240306104529.6453-9-eddyz87@gmail.com>
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
 tools/lib/bpf/libbpf.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1fb9a4f237b4..595c287d84ef 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1031,6 +1031,48 @@ static bool is_valid_st_ops_program(struct bpf_object *obj,
 	return false;
 }
 
+/* For each struct_ops program P, referenced from some struct_ops map M,
+ * enable P.autoload if there are Ms for which M.autocreate is true,
+ * disable P.autoload if for all Ms M.autocreate is false.
+ * Don't change P.autoload for programs that are not referenced from any maps.
+ */
+static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
+{
+	struct bpf_program *prog, *slot_prog;
+	struct bpf_map *map;
+	int i, j, k, vlen;
+
+	for (i = 0; i < obj->nr_programs; ++i) {
+		int should_load = false;
+		int use_cnt = 0;
+
+		prog = &obj->programs[i];
+		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+			continue;
+
+		for (j = 0; j < obj->nr_maps; ++j) {
+			map = &obj->maps[j];
+			if (!bpf_map__is_struct_ops(map))
+				continue;
+
+			vlen = btf_vlen(map->st_ops->type);
+			for (k = 0; k < vlen; ++k) {
+				slot_prog = map->st_ops->progs[k];
+				if (prog != slot_prog)
+					continue;
+
+				use_cnt++;
+				if (map->autocreate)
+					should_load = true;
+			}
+		}
+		if (use_cnt)
+			prog->autoload = should_load;
+	}
+
+	return 0;
+}
+
 /* Init the map's fields that depend on kern_btf */
 static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 {
@@ -8175,6 +8217,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
 	err = err ? : bpf_object__sanitize_maps(obj);
 	err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
+	err = err ? : bpf_object_adjust_struct_ops_autoload(obj);
 	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : target_btf_path);
 	err = err ? : bpf_object__sanitize_and_load_btf(obj);
 	err = err ? : bpf_object__create_maps(obj);
-- 
2.43.0

