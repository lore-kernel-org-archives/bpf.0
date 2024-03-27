Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A60225DD
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507389; cv=none; b=hwHI0iMDERcAeNWWAfi0Xi/Ek6koJEnryLI1Dj4nMpoEKcgOm/mNQWZr09zJQWbzTvDqfg5HnJLv8H49O0PsJlZZd55iFWa2IhGAaqZP8y4zrZ9PYu70QBYwp8c7W8MBDL3uEi9mid8Ut/I26qVLIg3durUx5E0qB5/IZpG6usg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507389; c=relaxed/simple;
	bh=kwL+5F4cpa2V72ea0QovZb9CAtOgY3eoLII2smzTNic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/MXhvAd79Tno79uYxaHFKDrvU34j1eCe4K8DWqmJA8vn8ctqpqd8U98zSI6N10cDky3uoEwZf2Z5UOzIhH4xmehrv/IB0FTHPMyAgl3EAZXS3iVUNvRabNU4FqDt2JgQHwb5KVYAv7GOnVGIES5emu+sJ8YmDF9ze0/AT1DViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcHx0ePE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcHx0ePE"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6962a97752eso44745366d6.2
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 19:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711507386; x=1712112186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoMbPG2w7Q3Vm6/XYs3KVTZsIt5BJf+8VAvaD5RDzoM=;
        b=TcHx0ePEGIUmN3el23zbu9PGsBP+0fucOOzGiWL6SGFLwF1bxPomplnoHCwa4ThdTS
         g2WxBFn2cOW6C/vvUHaagrB6zykew+LLLtAuyx79FsOOvvx55E1OfWpK/ncnL2BQWKoZ
         3A9O7fvA2Kza0iXVkqcH/oPJeZDeF/2kLXBl1SDgoJm1446dlIim4HZDgj7c5uDHvdpV
         WgmbsuJKZT8bnQMKo4LzpSlWj6/6qHBBL56RTuapF1Zy5qBPYGFaLuL1vW1XiflBK3Ze
         jPHCRaxuwa5l0BNEgTHQBN7HTVV+UdUNDpMigl/q3mD3ZdjQrtsBuZVaMpD0wTMrNGP5
         lY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711507386; x=1712112186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoMbPG2w7Q3Vm6/XYs3KVTZsIt5BJf+8VAvaD5RDzoM=;
        b=OzowP/KdksVGF+Vl5WMd/9J21FaSeiRqjwbrpxhGqOqq0mx5zT5vuKYeeyVuF8E4+l
         7lFOdpAyaOV2zGBRwPdgy2WxmYLEkQFzjegW84Sde+sXRM17R3S9FSIB0/ztM1OHBhIq
         /nZtuTWISVspH2c7w8WgX0L86aBV95WTTYJDsjrhUw4yxucTKaw56fbYAO0QuGsrqH3+
         c9fHi6TGQ6HItYS51ZqcwWP/kGcS4ny6UMFL09UT3No4AouvrKDWR3ONL3K4K580lElX
         3Zm5h4qnG0JRRLvVBerBNoEJf1L+p9s/aBZaVLhA6Z2A9DKGxeXOabFzDcMtjdFyDfgW
         tRDg==
X-Gm-Message-State: AOJu0Yz7Kjg2zXr4q9422EOfsTiqxBBjSYV1IitsyOtX5/sBqWPTUKnb
	JrZSa5zNt9j1tSdFxeu8/MnnbGf0C8Fv2qt+6AG/jtvOxk6jzS1DWsH4LpEeAihBlA==
X-Google-Smtp-Source: AGHT+IE4ZSKYCFFbgm5tPnT01oNFm4fyoxIGOyucoze5SiFnF7QsW2W2y9d04bwc9cp+YpfzxHNDGg==
X-Received: by 2002:a05:6214:21cf:b0:690:bb1c:9dc4 with SMTP id d15-20020a05621421cf00b00690bb1c9dc4mr13751152qvh.28.1711507386445;
        Tue, 26 Mar 2024 19:43:06 -0700 (PDT)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:fb35:c49f:ff96:dfb0])
        by smtp.gmail.com with ESMTPSA id e2-20020a0cf742000000b006967565c827sm4742324qvo.141.2024.03.26.19.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:43:06 -0700 (PDT)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH V2 bpf 1/2] bpf: Check bloom filter map value size
Date: Tue, 26 Mar 2024 22:42:44 -0400
Message-Id: <20240327024245.318299-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240327024245.318299-1-andreimatei1@gmail.com>
References: <20240327024245.318299-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a missing check to bloom filter creating, rejecting
values above KMALLOC_MAX_SIZE. This brings the bloom map in line with
many other map types.

The lack of this protection can cause kernel crashes for value sizes
that overflow int's. Such a crash was caught by syzkaller. The next
patch adds more guard-rails at a lower level.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 kernel/bpf/bloom_filter.c                           | 13 +++++++++++++
 .../selftests/bpf/prog_tests/bloom_filter_map.c     |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index addf3dd57b59..35e1ddca74d2 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -80,6 +80,18 @@ static int bloom_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 	return -EOPNOTSUPP;
 }
 
+/* Called from syscall */
+static int bloom_map_alloc_check(union bpf_attr *attr)
+{
+	if (attr->value_size > KMALLOC_MAX_SIZE)
+		/* if value_size is bigger, the user space won't be able to
+		 * access the elements.
+		 */
+		return -E2BIG;
+
+	return 0;
+}
+
 static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 {
 	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
@@ -191,6 +203,7 @@ static u64 bloom_map_mem_usage(const struct bpf_map *map)
 BTF_ID_LIST_SINGLE(bpf_bloom_map_btf_ids, struct, bpf_bloom_filter)
 const struct bpf_map_ops bloom_filter_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = bloom_map_alloc_check,
 	.map_alloc = bloom_map_alloc,
 	.map_free = bloom_map_free,
 	.map_get_next_key = bloom_map_get_next_key,
diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
index 053f4d6da77a..cc184e4420f6 100644
--- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 
 #include <sys/syscall.h>
+#include <limits.h>
 #include <test_progs.h>
 #include "bloom_filter_map.skel.h"
 
@@ -21,6 +22,11 @@ static void test_fail_cases(void)
 	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid value size 0"))
 		close(fd);
 
+	/* Invalid value size: too big */
+	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, INT32_MAX, 100, NULL);
+	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid value too large"))
+		close(fd);
+
 	/* Invalid max entries size */
 	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 0, NULL);
 	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid max entries size"))
-- 
2.40.1

