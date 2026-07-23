Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A93BD651
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789134; cv=none; b=PknEPsWsUg7jUjdLfQOle9K9l56uvWLsFQWwJmZYLGDS+8EuGgK56q5Pj5ZQh7GpTEGLl7a5FvIB3fwZyXaMnr0q1+7iyWykQ8lPaHch/5mfYXdHfQljSSJZ4a8LVjK60eEwbM9SicBnXoiaBl9gjWQAV4g92Yc6b07koAIoSX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789134; c=relaxed/simple;
	bh=hM2ye876jHxcYYTdgX45DUjwSYB3dqP/HHYgFSjaLBs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g82w5zaxDQdv4dAT/g+YBe5gzZHAf8G/eDXjFqeJYxkGlIFwwzH5Ibrg7cuxCxDJ9dKJMnBWSxdQWHz8v8SvZZk0aNrL82JTmFLRwryyyjRQd3d8+1mdVW+yWEYLewq1zSNTVMSpWrwzXJAjptfCZ2CVcHoroFBbWTs06cluDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com; spf=none smtp.mailfrom=digiscrypt.com; dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b=nmP3THkF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="nmP3THkF"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e041ea211so284538a91.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 23:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1784789133; x=1785393933; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8h8wxX9My5FFa4pVNfI8fegY1oj60NaDd93kVkNB51g=;
        b=nmP3THkFSnPi3B0691pI02Podv5gtewTx025YvWCMYT2A+5+xcE20OysCSYLy4qvKo
         9ajwdCZjD3QHSxAEkCK9OMPztdQ8YguWUFH3VU00twsfJooQ0NTeIzkVbH/mFcuj2XWN
         krlM4f7OKDRrsfmWWRGF6ZPXZWY5jEPujLpnWKv4VOIASmQedcZJYTKBLKweUUFiTadQ
         I8Eeq8g8Zz0R172R/0XJ/NDv3DD2cttbbQd1nIxo0EUw83lHo46esAu2tes57gdbDEw1
         K2Tn6GDANSKCCazfnSTFHJFRjCpO3ddxoMnSqbSDQZrqcLdWc+mZJ1kWptsBgkyfUFP8
         q5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784789133; x=1785393933;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8h8wxX9My5FFa4pVNfI8fegY1oj60NaDd93kVkNB51g=;
        b=lXKj+qLmT/7hD2V8tA/OcPhuDkGrG6xeXTg2pAzJ8fpP2hT/U7Aa0xUXYMnt7evPMS
         XgtUQkaK0GyLzoY4gfa3R2XdHq5MtQyHGbaZkNPMNIL9knCpQVJrf+1gqLhFcUJ4mDQ7
         zJKBs/0stQG6qsYHsaCTeoKn9MskjbT+n46ymO77Cz3DaB29CJT8TZ5J2JgbAmt1UbNy
         ILN7eOwLnW0gzlBUNudytW4G5rvVj9ivLyR/BZtu2+1GX0zjJEq20MlYADe3FZ+M0WS8
         ug/F17aRihiavcOgUNs/DhrYKGl8+7boLRC4faLTFQsfF3xCFsBfU0RmEwHmCq4r1e8W
         +AjA==
X-Gm-Message-State: AOJu0YwN+3OqCuSmnbfNFHOq/vaHJY1tdiYtxSCMJdjyvEgDfXj6mswi
	Ku3MS2o3LpuTKAGAQz/fjp+AItBS5zhN+AsO4iRClkcbG4dYlNG5l40MSGlsNGl1T405PgDhzui
	TnYXrgizW
X-Gm-Gg: AR+sD12Pr9hNmQBxkXHbVRgDnntk1wXgxrDRzS2h5d3xZ/Ywb24HSvwi4jDeiyCtq4K
	myNa0mSOpac1NWm+MtD4HzH+B0Qcry/MLHsEqPvm/g6JgyhXzwCAP70ZQSimng7JlThEcURccYQ
	D4Rxf0a8qK0ZoKyOEan0dr2DEQzXojU/YiHzo8cDWzANYbngDyxbIDVwSgB9oQuTTu4TX6SVwJs
	r4iuJD7PU1jkjpxEAUeYKBIGhwWwAJKMX4yVR4pp0jhqfhMAFkRpW3bn6TypxzDhljw+ktMMnX5
	yXwDm7q31TU8FlQG63Dxz2Y4W99Zf38S+zdRBc5olf8ZMbFLWbyaRYITwSVKLNxDi0IeW2/s82W
	Qd6MUFr6sd7N81DWgRN7K18Mfy5Hl2tUHtZ0o1dpAvm/LF87podZQl7ojvRrH3X6zziOx/Sc4BA
	Gizrth0uTT8EgXzayZ4iF8TF4ypHFQX8J1p4UrkkIXAAJHYZDxqFJz1B9SdumzjnoYYwIhuIt7D
	7S6PQRapKF8HhX8r+10JhZqbaA725CKXqw1eQRf/lW2kX+wvekvPAux
X-Received: by 2002:a05:6a20:c784:b0:3c3:ac9c:9a66 with SMTP id adf61e73a8af0-3c44b25089bmr1873132637.69.1784789132800;
        Wed, 22 Jul 2026 23:45:32 -0700 (PDT)
Received: from 169.254.72.157 (ec2-13-202-78-74.ap-south-1.compute.amazonaws.com. [13.202.78.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147d47960dsm15541821eec.0.2026.07.22.23.45.31
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:45:32 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: bpf@vger.kernel.org
Subject: [PATCH] libbpf: bounds-check struct_ops member offset before writing
 shadow pointer
Date: Thu, 23 Jul 2026 12:15:30 +0530
Message-ID: <178478913040.2.14225985431891987705@digiscrypt.com>
X-CodeOps-Marker: 407f3d847a2049fa8cffab530e3cbc06
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

bpf_object__collect_st_ops_relos() replaces each function pointer in a
struct_ops value with a pointer to the corresponding struct bpf_program
in the map's shadow data:

	*((struct bpf_program **)(st_ops->data + moff)) = prog;

st_ops->data is allocated with malloc(type->size), so it is exactly
map->def.value_size bytes long, and moff is the byte offset of the
member being relocated. The only bound placed on moff comes from
find_struct_ops_map_by_offset():

	offset - map->sec_offset < map->def.value_size

so moff can be as large as value_size - 1. The store above is
sizeof(struct bpf_program *) bytes wide, and nothing checks that
moff + sizeof(struct bpf_program *) stays within value_size.

libbpf's BTF sanity check does not validate that a struct member's
offset plus its size fits within the struct's declared size (see
btf_validate_type()), and this relocation runs at bpf_object__open()
time, before the kernel validates the struct_ops type. A crafted object
with a struct_ops struct whose declared size is small (e.g. 1) but which
contains a function-pointer member near the end of (or beyond) that size
therefore makes libbpf write up to sizeof(void *) - 1 bytes past the heap
allocation - a controlled heap out-of-bounds write reachable purely from
opening an untrusted object file.

Reject such relocations by requiring the whole pointer store to fit
within the map value.

Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1368752aa1..1aa2a1d098 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10529,6 +10529,17 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 			return -EINVAL;
 		}
 
+		/* the shadow pointer stored below is sizeof(struct bpf_program *)
+		 * bytes wide, so the whole write must fit within st_ops->data,
+		 * which is only map->def.value_size bytes long. A malformed BTF
+		 * can place a member near the end of the value and overflow it.
+		 */
+		if (moff + sizeof(struct bpf_program *) > map->def.value_size) {
+			pr_warn("struct_ops reloc %s: member %s at moff %u overflows map value size %u\n",
+				map->name, name, moff, map->def.value_size);
+			return -EINVAL;
+		}
+
 		prog = find_prog_by_sec_insn(obj, shdr_idx, insn_idx);
 		if (!prog) {
 			pr_warn("struct_ops reloc %s: cannot find prog at shdr_idx %u to relocate func ptr %s\n",
-- 
2.52.0
