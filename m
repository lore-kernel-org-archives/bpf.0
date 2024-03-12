Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC84140E30
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268372; cv=none; b=R8Hc9pvqtY1YbN7GEOkoyQG0TvwqG6qiWTaGNSsmHil+GgURwWEAhm/I4xbNSd4tkSErrAdg9Q5ebOvfsEGwSBkYwjfUB4v0vbBo4fbjMfd8DmtZaFnIOIUeKJ1odiiTgZuPKyUkS8C2KvInnKepytp+4khfavy8Cjdl6HenCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268372; c=relaxed/simple;
	bh=Kn/FAiS0u2/qbKrNgQfdLin5EQuxq4os8Dsa6bIylvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+JWR5BFAIIS1cWStd11HMJIB5j7HxfXw6R9POgYZV168/Su0osZBJOqYuuaw2u46WmtxxYZnYFmA8sC59J6mOdyKfFhpONGUIoyl6KRYYPLQ0StiMDNlSBUL6P+4ORNk2nGtXWRkbz01+L24bZBVxmc8SDJ0tMsQxZSJ4oV7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtxjZYcu; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtxjZYcu"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so166862276.2
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710268370; x=1710873170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yl7lpHmoNgTrnH9+ChQKLUy/ErIjqrjXS0hb8PyJWk=;
        b=LtxjZYcu7MAB2kpT/NLkOcJm9acOiicK/2kWx1VP/MZ9d0qSATXGEziL6QXiEpK8Fc
         RQMyubWuqs31g1BhCB+nVhR9aT+VTd+gWcVSDPhGVptgAUfwRuvqZAW6bLPVvnsHf1ay
         h8QUdjBQFbSbFmM+3QF32mISMkLsLnlrai62MYwTuKjzUAcxjBWBx2boGN8Ju54AW/d+
         NNtVn5nuyRkGGs/qYcSClqjsGgO+QYw/OlJqMeXjzIqcZQOuB1v9b9W7OW5BxLi48BpK
         Atz4tr/9PXIRbM489tiBVamvuA0jz1DyBQHbRXli5JN0HgonUPm+2hUhMAPMq8uGLekK
         Dk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710268370; x=1710873170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yl7lpHmoNgTrnH9+ChQKLUy/ErIjqrjXS0hb8PyJWk=;
        b=E+40iS8aul6baVzeWm3P/udK4Dw+xkz9fPEZPHbhsV1j1BhleAtoCPKayL5tAU46pk
         TV0yZ+jyFdpOLQvg4TiQdsKL673viU7Wtv0lfInwznAPuzfFidNHBGZOfwDu+qRaljpn
         pEvS+jFGSwOgtTbnkZJelCU4xGpbcGvZ8g0XgjxRVPIvdsWfNJwlw/PXXbWTJwc3dLpB
         hpDjL7t892gExyFkgF155RGu+i7XH+JGfdkm2Ce1UVJGTN2zsDT2DxcFCO4sTvO9Cw4y
         bKunhct6EOqImpUnQ/FTVloLhyxvVgf1VJxyLSt5LRKPjTts1eFSvce3tPOs4S7rv8wm
         ML0Q==
X-Gm-Message-State: AOJu0YzEjJfS61yxazaNJf7F30h9Wkm4d+zjCS0xNG83/LV9Ji2c9Sz7
	khXgRXvrdXTD81Fle+jl4anrV5g2qbIzxxChLz9C19eML5aA/z+AkAjmK7E/
X-Google-Smtp-Source: AGHT+IGDD2gYWhdgu70Bwo6lS9D+xTKTLT8pgk3hlU1aR3WPg4DKbNtsCAZgVa/TYwe2wdharJOdTg==
X-Received: by 2002:a5b:202:0:b0:dc7:497e:cddf with SMTP id z2-20020a5b0202000000b00dc7497ecddfmr254950ybl.33.1710268369754;
        Tue, 12 Mar 2024 11:32:49 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b4ae:c2f4:b38f:1540])
        by smtp.gmail.com with ESMTPSA id v185-20020a252fc2000000b00dc9c5991ecdsm1868444ybv.50.2024.03.12.11.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 11:32:49 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/2] libbpf: Skip zeroed or null fields if not found in the kernel type.
Date: Tue, 12 Mar 2024 11:32:44 -0700
Message-Id: <20240312183245.341141-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312183245.341141-1-thinker.li@gmail.com>
References: <20240312183245.341141-1-thinker.li@gmail.com>
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
 tools/lib/bpf/libbpf.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index efab29b8935b..715879796046 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1131,11 +1131,33 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		__u32 kern_member_idx;
 		const char *mname;
 
+		mtype = skip_mods_and_typedefs(btf, member->type, &mtype_id);
 		mname = btf__name_by_offset(btf, member->name_off);
+		moff = member->offset / 8;
+		mdata = data + moff;
+		msize = btf__resolve_size(btf, mtype_id);
+		if (msize < 0) {
+			pr_warn("struct_ops init_kern %s: fails to resolve the size of member %s\n",
+				map->name, mname);
+			return msize;
+		}
+
 		kern_member = find_member_by_name(kern_btf, kern_type, mname);
 		if (!kern_member) {
 			pr_warn("struct_ops init_kern %s: Cannot find member %s in kernel BTF\n",
 				map->name, mname);
+
+			/* Skip all zeros or null fields if they are not
+			 * presented in the kernel BTF.
+			 */
+			if (btf_is_ptr(mtype)) {
+				if (!st_ops->progs[i])
+					continue;
+			} else {
+				if (libbpf_is_mem_zeroed(mdata, msize))
+					continue;
+			}
+
 			return -ENOTSUP;
 		}
 
@@ -1147,13 +1169,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			return -ENOTSUP;
 		}
 
-		moff = member->offset / 8;
 		kern_moff = kern_member->offset / 8;
-
-		mdata = data + moff;
 		kern_mdata = kern_data + kern_moff;
-
-		mtype = skip_mods_and_typedefs(btf, member->type, &mtype_id);
 		kern_mtype = skip_mods_and_typedefs(kern_btf, kern_member->type,
 						    &kern_mtype_id);
 		if (BTF_INFO_KIND(mtype->info) !=
@@ -1230,9 +1247,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
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

