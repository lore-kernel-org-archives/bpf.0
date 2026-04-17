Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44563A16B4
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448151; cv=none; b=WuEB82z00OTn3Hlqh7qLuaDr7kO054oeNA5xCJrFqj8x0apcdHIDQZbqhIznPR9jjbplHuOvR3q11mU6Hdwao0Aa1YqBXjECAPqW9wkXycUz73r4F7NZXjzpqBlQrG0pXtdJiHOFkQOJU7s9Whal77gyzMKmqd0ZL/omEYPx4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448151; c=relaxed/simple;
	bh=o3SkpCZp2IYyOv/Ch4F0MD/wO+LSvMUhY5h0puJbO2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjYIhXxSClotH4Y3mGr5TPVgseO/nrxZe3VqIhX98S1L7PpYFF5Q+LTGgUt2xqCdE6WLL7Uycs+n9N4f6SguZ7McP7c/f1Oc/88cvVG8mhTwctPs9DVhCKALGVkTg+dF2VQk82yedCrt58ABP8XBQbb0S3Mo0GciheeZVxDmdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sp3pjX96; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp3pjX96"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f2766905fso446334b3a.3
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776448142; x=1777052942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TA/MNIel6VK9u9WqtfYVsZvbCaFEmcRqjySnlQxqgQ=;
        b=Sp3pjX96rVIKSALyS/3AcOQ27rwFIXdvvusMYuHAHpa2llMWx69A884nFHLFfeqEea
         t87U+8aGAMGxRKmjTmSOn0kM5YUC91SI1GJb0Wk+GyVyAXOHbCStMeWhhdp/dWxMvLru
         gkk+aHuu5eYVBqw+N7H7sUi0PdiMoJI2OIaeUxql6/fKEnnvLxBuGXsYwdIqCRKOwYnX
         XLor+QVqhkrFt3MlXhcgbNlwEWArlDzrIyZ638dg7uBAkBLrhCawUlXXX4fmeNwLXtY2
         IPbZu0fY6Vcs5Z/MFXTTPTNXIplLgOGfhiy8C65mlXeGPQT9mgdhZhhpEIPGBnj/njzs
         Gxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776448142; x=1777052942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TA/MNIel6VK9u9WqtfYVsZvbCaFEmcRqjySnlQxqgQ=;
        b=ErvFtG19BbhQceUdYvrKvecWKG8J7IjNAMzOc2VQ5viDQpaY2GwyYg+il58GauqXmr
         1AAjZl0t1togK2XsALSlonKYuYTtGZ7OVA475U65s8uZPlQh6QVfuRQWThiqboba6bjR
         TnPlCf6PFWd8Q+CWMKdXTzyE+j7A4fR75u/3qXWxqDi3Sa9YsJjUt468CsZGXZMmY1ya
         u4BDnkDkTUATrKOR0VFKgKw9NqQwP5XxfA6K+PQR4FAgIZDD6O+/AzMz3rdNJ7bz+Sfw
         yc4VS27YocTVx5ITJStRiz+qWxnYLwCb2mKfZj/9Gmo/MdGPnycz4Tmle03PM3BFlxMf
         OwyQ==
X-Gm-Message-State: AOJu0YyvmbRlKoQRw+3ExnC3TS0yQAb/Zpl8n5rgu5dN4nphMuVT+xIG
	eywWh97rWKa8yXtV9pRK3mV0Cyzc/XnxnATFdalmJ0+Hq2sGDk/CbNcg02wCtA==
X-Gm-Gg: AeBDieugotnBR1JVb4CuD7ZqR88e497nRKXxE6z+lv/hvFTYgSB9HwSzE9CmZ90UESm
	5NAIHWp/kOAlBhpnsfdsCQXHYGrH1ch2TafVRPelPO1HFq8aMaquBL58MYcEdLyyLWY2tpg4fie
	LKhqkYQMSCsUoSeeucYU/Ew4GtwIhl3rP7u3eVoHYdFxwTNgpJGF0ToIrrAuewWf2giVDT3X/fc
	V0sm/az2gw7Hh9BxlHIxT4HBaeiPa7v9eOcKj7jkHdijSIRQuwnDwUIQGzRHN1srSDQmxUAluxT
	MMyeOCQ9QBfOFsmfIGq/db0aT5Yn1xxlaSxR/rqpSH9xf8slHJEXLSBdwaBOYNNxB/Fy8oQ1Yl4
	4JVN8ls75FMvgA4k+/Ri8xbK9/by1t+BOS7KoPTKOqYH3UrAPkw+v2qbRWtS3+PgcQIqedEvRqN
	BqkhUfh542pMOb6Vvms+EvLosS
X-Received: by 2002:a05:6a00:a15:b0:829:8942:2ca4 with SMTP id d2e1a72fcca58-82f8c838f04mr4206842b3a.19.1776448141736;
        Fri, 17 Apr 2026 10:49:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec06cbfsm3229727b3a.58.2026.04.17.10.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 10:49:01 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/1] bpf: Dissociate struct_ops program with map if map_update fails
Date: Fri, 17 Apr 2026 10:49:00 -0700
Message-ID: <20260417174900.2895486-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when bpf_struct_ops_map_update_elem() fails, the programs'
st_ops_assoc will remain set. They may become dangling pointers if the
map is freed later, but they will never be dereferenced since the
struct_ops attachment did not succeed. However, if one of the programs
is subsequently attached as part of another struct_ops map, its
st_ops_assoc will be poisoned even though its old st_ops_assoc was stale
from a failed attachment.

Fix the spurious poisoned st_ops_assoc by dissociating struct_ops
programs with a map if the attachment fails. Move
bpf_prog_assoc_struct_ops() to after *plink++ to make sure
bpf_prog_disassoc_struct_ops() will not miss a program when iterating
st_map->links.

Note that, dissociating a program from a map requires some attention as
it must not reset a poisoned st_ops_assoc or a st_ops_assoc pointing to
another map. The former is already guarded in
bpf_prog_disassoc_struct_ops(). The latter also will not happen since
st_ops_assoc of programs in st_map->links are set by
bpf_prog_assoc_struct_ops(), which can only be poisoned or pointing to
the current map.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 05b366b821c3..521cb9d7e8c7 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -811,9 +811,6 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			goto reset_unlock;
 		}
 
-		/* Poison pointer on error instead of return for backward compatibility */
-		bpf_prog_assoc_struct_ops(prog, &st_map->map);
-
 		link = kzalloc_obj(*link, GFP_USER);
 		if (!link) {
 			bpf_prog_put(prog);
@@ -824,6 +821,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			      &bpf_struct_ops_link_lops, prog, prog->expected_attach_type);
 		*plink++ = &link->link;
 
+		/* Poison pointer on error instead of return for backward compatibility */
+		bpf_prog_assoc_struct_ops(prog, &st_map->map);
+
 		ksym = kzalloc_obj(*ksym, GFP_USER);
 		if (!ksym) {
 			err = -ENOMEM;
@@ -906,6 +906,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 reset_unlock:
 	bpf_struct_ops_map_free_ksyms(st_map);
 	bpf_struct_ops_map_free_image(st_map);
+	bpf_struct_ops_map_dissoc_progs(st_map);
 	bpf_struct_ops_map_put_progs(st_map);
 	memset(uvalue, 0, map->value_size);
 	memset(kvalue, 0, map->value_size);
-- 
2.52.0

