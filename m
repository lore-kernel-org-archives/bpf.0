Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79285908CA
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888319; cv=none; b=Z5VA3qvN5F24plXkf5SEQr2/MYU8oKnZcux2B6qX+7Vi+HGca+Qe84dBPlCj2wVu5xo/7pV9BN17S6E+4tkOTwowsmuJScDPeYd83xyL9IKrKQZ1koR5VUC9JRb70Jb1s18PJHBTcJu7HPQW5QXoDom7Kfet24ZbPFRXwtS2tJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888319; c=relaxed/simple;
	bh=5HislbrG9zqeYhMXAnmp++59CVxZGva5dMm5kX9UuTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qw9UCfiwyerpxCEEhJO1Z8s7wW7JarUMM+kQFNb23MZXhU3GJATnSaUxjeNy+tlKs0X7oihuutYWGwCL6sSXukZVd6vlK4L14P10ETZ3QwGaRtm2E5UvP8CrswMvWw35kduEaK4NIZ7d1aPDpPn9HNgCxhZHin/Dl04I26B5SvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVeXoOve; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVeXoOve"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f48c750afcso4166279a34.0
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788888316; x=1789493116; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8VrL1zTTssLjuwf81pcJpEregmZDpTmsKguYyrdAK7A=;
        b=QVeXoOve2lnoH6M47Z3R1jXblEWFT34GkNCe7139eR02WTPRuzR4PX2D8fJsSNRHcZ
         9D8+YFvYHOFEKSvaMgUbrjLaFXqD3N+nC3Si7/j6Xn2HYN387tt4RTDHq50MLHV4dRdZ
         FB1NsJ1Q6qb2KJX8kQyFMJbfmYPDIBsL8gjwl2hkjXVnZWO2Fb0E3ieKY+/l+WR5hHO7
         23sjdrhmE8T2NFlJp1Nu8Cv3CYFYcqPE0+E4RY3qyegIM5hWS1c9WmKEdm+dYDq4pmau
         tud6Fw87FxAyPM6bs3HCkDZnPVkPHFadRFvi6RSwvwUtuXuh4LaxSRJJdobhx77Sydo0
         lbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888316; x=1789493116;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8VrL1zTTssLjuwf81pcJpEregmZDpTmsKguYyrdAK7A=;
        b=avJjlFSM3kXxSlV4j4mbPlfqX3sRtPvRzGSwbxtFSUDFIlPcFHpl38wkgGeicBnB0s
         /6yNs8o+j3hUm7T8mUQL1S/KufzlzvlDzS6SB7oPD4wjS8SRYeT9DVrB5CzWfGbCHi7O
         nqc+9qBPWHq1AkjEMenpROCoMz9g9+C/tkagBorW3LUfnA6qxXpyMRGzt/L4yqAzLpY0
         Skr/sxtCAhCIp7JrWoFJBe5W7HEhpZ6b1c27xrU9O2cCsnZWG3OSDHEoN4dmDXw64pvL
         Pj0nRkb2KphemWiN8rRpBkGbnFNQI3Jfq/RtRSMVBud7wjTgT8GLa32RQRr/h5olno7t
         kWCA==
X-Gm-Message-State: AFuF++l11bckolaQunKqGCxDmNAB+eyF+2YJCMqL2KwpP6B7nAUO4YAM
	4wVYNSANNSdp1up9Ly6P2utdbd5t1WQKAEGt9RYGTsrzQgOTNH7VCQOh
X-Gm-Gg: AYBFou0hQ5Tj/UrEpEWrO7z8Mvobi1isnvmIfU8NCdaDdQUDEzoN/BdUzTGkc2uPeFZ
	BnDqRbsP235tNOOzTNrR8r0KsMllft6i/7H/IqUet8we0JKziv1LH7MfV6ToXCYB9586P3Nqkon
	6gcXW8Godk8JV7NC9WfsQTme/4VPNFBIUwSPwJiBsMENaJuek9bIguH42Srn3Wk7QQuH53kx9nm
	hiQKpGi4YhrJbKGM7SjH4ylTtwddqVr3zWqGiJb4Wj5Dj1rkff/yL1SYq9NhM+lHj+jM/0KiJoR
	ZiYOI5PVHTwGYILfiCSp2Bwe/zLwdZ5ZlSSMalko2pa09uguWaqw904hmkNqvSgsOX5NXz29ylZ
	FaSELa0TfR9URlEOjEn4RSDk+Gb60g6U+2w1/X7pNNxfPy2fNcWHUjZN4+1cqadIXeEOOSSYaa2
	RflreZ49FU0OkOhjW1Sa7CRv3BcIJ0FoXuueEvLNPO6ZPpqwZQvmeT6OQHZyiJ
X-Received: by 2002:a05:6830:388c:b0:7e6:dc7a:f459 with SMTP id 46e09a7af769-7fa1fc6530fmr19089435a34.11.1788888316230;
        Tue, 08 Sep 2026 10:25:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f7aef680sm15437188a34.26.2026.09.08.10.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:25:15 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 08 Sep 2026 10:25:05 -0700
Subject: [PATCH bpf-next] libbpf: defer arena map size check to load time
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-libbpf_arena_thing-v1-1-0092c0e0d91b@meta.com>
X-B4-Tracking: v=1; b=H4sIAPBEoGoC/x3MYQqDMAwG0KuE77eFTjfRXmWItDPRwMhKK0MQ7
 z7YO8A7UbkoVwQ6UfirVT+GQLeG8Nqirex0QSC0vu396Af31pSyzLGwxXnf1Fbnl76L4/CQu3R
 oCLmw6PFPn0hZnPGxY7quH5TNePVuAAAA
X-Change-ID: 20260908-libbpf_arena_thing-0d63a985f4f3
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788888314; l=3290;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=7jOsj6WlaiJ/fu82kQke8J0q6eK6tN/jZHIWxGXyB68=;
 b=sOpboHpr/+mv9fDiZxtL+rHmywtteRYbn1+cLgYSoOuunzVlFfl7QJjirjtiUZEcZkHiMl9gE
 bjbZrhTFl6mD5bCPQ/fBqhvJCJ9poF8eNOc99SSNAfxuAFWPnLlzTYg
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

init_arena_map_data() used the build-host page size while it opened an
object. This could reject skeleton generation when the build host and
target use different page sizes.

Validate the size during load, before libbpf calculates the arena data
offset. This uses the running kernel page size and rejects an
undersized map before relocation.

This problem manifested when cross compiling BPF selftests for
arm64 (64K page) on x86 (4K page). In this setup skeleton generation
fails.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c036e8a91ed8..413b8b305194 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3018,20 +3018,8 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 }
 
 static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
-			       const char *sec_name, int sec_idx,
 			       void *data, size_t data_sz)
 {
-	const long page_sz = sysconf(_SC_PAGE_SIZE);
-	const size_t data_alloc_sz = roundup(data_sz, page_sz);
-	size_t mmap_sz;
-
-	mmap_sz = bpf_map_mmap_sz(map);
-	if (data_alloc_sz > mmap_sz) {
-		pr_warn("elf: sec '%s': declared ARENA map size (%zu) is too small to hold global __arena variables of size %zu\n",
-			sec_name, mmap_sz, data_sz);
-		return -E2BIG;
-	}
-
 	obj->arena_data = malloc(data_sz);
 	if (!obj->arena_data)
 		return -ENOMEM;
@@ -3107,8 +3095,7 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 		obj->arena_map_idx = i;
 
 		if (obj->efile.arena_data) {
-			err = init_arena_map_data(obj, map, ARENA_SEC, obj->efile.arena_data_shndx,
-						  obj->efile.arena_data->d_buf,
+			err = init_arena_map_data(obj, map, obj->efile.arena_data->d_buf,
 						  obj->efile.arena_data->d_size);
 			if (err)
 				return err;
@@ -7489,12 +7476,20 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		bpf_object__sort_relos(obj);
 	}
 
-	/* place globals at the end of the arena (if supported) */
-	if (obj->arena_map_idx >= 0 && kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF)) {
+	if (obj->arena_map_idx >= 0) {
 		struct bpf_map *arena_map = &obj->maps[obj->arena_map_idx];
+		size_t data_sz = roundup(obj->arena_data_sz, sysconf(_SC_PAGE_SIZE));
+		size_t mmap_sz = bpf_map_mmap_sz(arena_map);
+
+		if (obj->arena_data && data_sz > mmap_sz) {
+			pr_warn("map '%s': declared ARENA map size (%zu) is too small to hold global __arena variables of size %zu\n",
+				arena_map->name, mmap_sz, obj->arena_data_sz);
+			return -E2BIG;
+		}
 
-		obj->arena_data_off = bpf_map_mmap_sz(arena_map) -
-				      roundup(obj->arena_data_sz, sysconf(_SC_PAGE_SIZE));
+		/* place globals at the end of the arena (if supported) */
+		if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
+			obj->arena_data_off = mmap_sz - data_sz;
 	}
 
 	/* Before relocating calls pre-process relocations and mark

---
base-commit: 3fa3128887a4df6057c543aae7c5c7fd2ed41f12
change-id: 20260908-libbpf_arena_thing-0d63a985f4f3

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

