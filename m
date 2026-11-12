Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480995;
	b=pu7SowzH0PRnhtz3ikLUSJd/W+bAQvJutpsK+Ck4b5MOTbb3bBoj+rofjm68PzHRT1sX
	 cODuAnKaZ2wOfQmI/WZh04OH8y4gVf7bnujK75OOqiMj+DTpOP6iZRoaPljgrWEngfasN
	 tWT/OXvFlzvlMTh8YFz7nxs8qQYXneUQ6/KWhBzQkqLZYfZO1nezX0NF5UjQ5PZ+lb6W+
	 LDgADMODIYusQPKplz4fmonNWff3ILwU6oEPdO/LUHop4ahRxxCV7cgCbtDZppVO4Eljd
	 HHUQTgphO3Zt0dJ03iTUy17s0UbF6QrG74/W2D53fLt8qbqAcLciHw0t5o3O5lheV8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jtGHs2eqhkMRzNqa6Gcv6/y7Ijx8kqUTG8HewUTMQTc=;
	b=nN82HLXyibWV4YwQKxI5Fnj5S6V6fgHnE+InLQwpK5+zmVHhh+PJCrLbyOCpuBefbzuH
	 OdXlmh/8on9MjUg+GMD3XeJFvPa+fhZtjFyHRQvPnU45STrmWmGHAoN5Bzyk0LpA+vELG
	 Pw6Ehd0ijEDGjIVxt8yhLEl4khBcapW23p8sHgKmUjUeycIcuR5Y/EFAIfPtU4MEobq2f
	 EiJEYpHgDEZ14vT13kNirRv1KJ5VOT/rWI1xOSQRYJ21ptoy6Ufx2bs4CFMsORvehU1hf
	 HxDSjVSa8m4RAijo4DSsPUoKeL7o3jsxexssQVyxIgUf5DT6rsOoTOOGh+mSe1SYinw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrkXU1T+;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91845606A33F
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91845606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrkXU1T+
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e97ddaf3c4so19200755ad.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 02:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794480995; x=1795085795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jtGHs2eqhkMRzNqa6Gcv6/y7Ijx8kqUTG8HewUTMQTc=;
        b=jrkXU1T+YrLuTQfCjAmR7IxcQeKyuXOPWSQgLpSmcaKR/ycd/j7ErZn2Q9V/OePG6M
         mw0k1g0N/JiJZD07zxm3VaoVtoPwBASHFEOjObAcHSoTfmS19wLeCvIiY5wm92sCDER9
         HhJaCH72PUwGrZ1gfY1m5z4oNsgGE84915pxmwW7yazaKyktie7US8qdBONlXyw9b/Yv
         YLtaUp58Md8tfZlYy2Iai7WVKDpSYuiSx3MnUqAhxlStT/X+DO3LhesPnYDIpqgx4cB1
         wehn6EfRpgZKi5YdQEfNtPQ3qT90lTorr/O9gEOpvTvtwwuu6LzohbAUBu4tKnBByHLP
         uyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480995; x=1795085795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jtGHs2eqhkMRzNqa6Gcv6/y7Ijx8kqUTG8HewUTMQTc=;
        b=OyWC/UD+0zEtGnxf+ika4xYwFVxM8v3KhzHH7+0YChfW3M8f1cgFQqwwFoPB3nVKON
         VXIF02Q9ZfgtYscaR/2pRIga9PyVOYs8TMzEITh1Gpkx97UOQLCO1L5AXCSMVFF9cf/w
         Vnc12vrqwmIft3i0qdVCjGHW37HPgdFthERpKCx2X6MOwWiR5ZIfDyGXEPrrhp/8P3UT
         7Sk+LZ1NQzrOCwm+U9TVKJoox5AbtGo2jFP5IGLqcADDJzJbYNDnuWILAem556AsMiNf
         3ok5A5EPtQu4RfPuUeWQhvfaJkgkaOj8yGJp+K0pqjMX+PEZ43UXGjnj3i99vijRjfbt
         SWpg==
X-Gm-Message-State: APuU4Z/3++XIAFMO2zsS0Iwt56setjLdGzlPTrDVDdnRm/Pg6rH5i385
	YHBgJYs/gRqUF/FRDpRG6rVQGKZJoaXrOfuKiPvfn/UCrSj6wnSeBEeXgBe+wWEaCdPFTQ==
X-Gm-Gg: AYBFou0a0dGoFBA+gmROtybo4Y5abCEPVXWMxTN0GyMv9138w4fdetiTu0yLekfHOpf
	GSc0fht10Ghd2BODFRi9QJT+Mn3MTcWuwJ3I7/LA0Kw5nSBcggQiSHA9qaCE65TU0lO49veQS/S
	aFDgK1kRJQrsnggobtvHx3aqvVQFjf/ApFot5WtpFK2WBSKkwv9P78SzwBZOxYr88YEOIkduXUt
	RVhWmbsUthqDKrzTOm109KJiIUwCiDE/+hheL3eOZBsL1NPa75974Q4DXvXNrD2ofmzfLUBjhlu
	7FfC4gnl1ste0B7kMAW0JnDkBaAJt8PQzjbNRsi+JhL3FBEPxPHGuaKj8BooAF9gIk4yLz7OeKh
	ZdMh8EBuCiCdH17GX9XDUtrDjESr7sQczDA6uHDU5ZhhlZ+rbMNvPRB2Piyg1k6hbK/s03q+nyX
	nQc7p/mtYCBxFRYWYhczEJMAEZEs6Q4SdNcsG3Wjh7a5IUBjVMfNJDOmvoomDWZpr8sweTRiHBv
	IX5i9UW/kbAjKmeqB+HsT9CRYi7piw6gMSARxTXO7jOUgHzp8tz9k9NqvoZ8gFNOksKPwJYyiOV
	sPzhRNk8ANDfsjjKNgIyrnA8UlBWFNy2zlIQ802/BbFv2r8=
X-Received: by 2002:a17:90b:1d0b:b0:3b0:8947:fad2 with SMTP id 98e67ed59e1d1-3b182fb2981mr5114945a91.53.1794480994840;
        Thu, 12 Nov 2026 02:56:34 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0fdbdsm4228959a91.10.2026.11.12.02.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:56:34 -0800 (PST)
From: Shihuang Liu <shlomojune6@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH] bpf: Reject offloaded maps as map-in-map inner maps
Date: Thu, 12 Nov 2026 18:56:20 +0800
Message-ID: <20261112105620.57520-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_map_update_elem() on an ARRAY_OF_MAPS or HASH_OF_MAPS map accepts
the fd of an offloaded map.  A program that then looks up the inner map
gets a pointer computed with the software map layout: with an ARRAY
template the write lands in struct bpf_offloaded_map.dev_priv, with a
HASH template __htab_map_lookup_elem() reads bpf_htab fields past the
320-byte offloaded map allocation (KASAN slab-out-of-bounds).  An
offloaded map used as inner_map_fd is accepted as well, and the first
inner lookup jumps to an invalid address because bpf_map_offload_ops
has no map_lookup_elem.

The root cause is that bpf_map_meta_equal() compares map_type,
key_size, value_size, map_flags and the btf record only, and
bpf_map_fd_get_ptr() relies on the template's map_meta_equal() without
comparing ops.  Offloaded maps share map_type (ARRAY/HASH) with the
software maps, but use bpf_map_offload_ops and a different object
layout, while the verifier and the JIT keep using the template's ops
and layout.

Reject offloaded maps in bpf_map_meta_alloc() so they cannot be an
inner-map template, and require inner_map_meta->ops == inner_map->ops
in bpf_map_fd_get_ptr().

Fixes: a38845729ea398 ("bpf: offload: add map offload infrastructure")
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 kernel/bpf/map_in_map.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 0fa3f2ac0f992f..5aa1f8249feb51 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -22,6 +22,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		return ERR_PTR(-EINVAL);
 	if (inner_map->excl_prog_sha)
 		return ERR_PTR(-ENOTSUPP);
+	if (bpf_map_is_offloaded(inner_map))
+		return ERR_PTR(-EOPNOTSUPP);
 	if (!inner_map->ops->map_meta_equal)
 		return ERR_PTR(-ENOTSUPP);
 
@@ -110,7 +112,8 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 		return ERR_PTR(-ENOTSUPP);
 
 	inner_map_meta = map->inner_map_meta;
-	if (inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map)) {
+	if (inner_map_meta->ops == inner_map->ops &&
+	    inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map)) {
 		bpf_map_inc(inner_map);
 		/* Its users are those of the outer maps from now on */
 		WRITE_ONCE(inner_map->was_inner_map, true);
-- 
2.43.0

