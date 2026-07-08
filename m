Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474953AE19B
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479506; cv=none; b=BWsUQaZATuVXHimIuZyv56UrsgQqZ7Q6X01OsvVKcXdiNDpbv7yDp4aQIC5oi9GeN5kz7RUIwg2VCZe42T8Jmcyl9R1WGSwKyPoAruhqc1Fwv+ipPNX9lq8skhTwBOExLM2DzqHVylHmHCTvGkeu5TA1CuHgzZnIG6Qq/kvbgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479506; c=relaxed/simple;
	bh=s5FTQdbOnM7OXuG5ACRl496Z55u8vQXvSfGirL8UMqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YT8YsY/iHFk7WQx8mckq6RhBYEzHL0gymZbbntb2IWDsuymfd2Q8NoY7BKBBVvI04DbYDrK9n4t057+Si6gIce5sFM+Sb1gLf6kzObNMCKTyWvpQMyYsu/JC7a0TWgMBYkGtjsU5nTo2u44k4vnOy2ddbXwujd0g64qTrHaCunA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0FNx5Kn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0FNx5Kn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc84e77e78so1924825ad.2
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 19:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479505; x=1784084305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gu0Oj5H+ScjgHzDAloVQBDSsZh3OVcVLQKoErfepCiE=;
        b=L0FNx5KnKYTSrWIQ16mvH5yeson68xFFn3PUA0Tw+i+wgw+CYH9idSzd7RkHispmeJ
         mgxNlWfdQR8NeIqzUlw4wYwr+cskZA4s93+eBcVRAnv/U87JBhyTemPGucW0e4or2U4o
         PL19AJapj34AaSyWA/uiMfwhmscdlNCoBSjv2KrV/Bo39LUrhBTktcUtPz4ktJwwusm/
         TU+Hf9VO5oZ6FOMd55caS54Xe7CUVt6iJeVeeHqxjak4mRaBqv1UA9sM1R7Y9UCq6zuY
         5jVycxd9mmonIfopusPXagL6ESFQ2eukjoBwapWy5IpzaSt/R5C7La5YqeqwfEe+59if
         Pp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479505; x=1784084305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu0Oj5H+ScjgHzDAloVQBDSsZh3OVcVLQKoErfepCiE=;
        b=NRQAoIDyO3LtARZklyZ7cs66s7q3TK+hUgT0p1i+5amaZ3pKY+wwMgjSDJo+R8YOfF
         WDIjLX9xjdai3Ays4PKIcnoLlgZG6s+qWdLCSH7QKVDVuiJY3jQ6AQpgPpxLxEaL/ej0
         nKg858QQiZNqj5I1MEn+gzCw+MuIk7pmOt7vzgxIkhZxHDiQJowlRbcTqTFMFpTVTgQ2
         Dbccen0MCg3D80MmOZGINEwLghoPqyV8XJrk39VQ2AdiGmwmLvf66tDuQr7/W4KMyOJP
         Kpp4yCKNYmxhqa25hqDGgB5VUMt39edv/U06ligRyQsNqx5aoXjMF603KhbAbI6mboCp
         b72w==
X-Forwarded-Encrypted: i=1; AHgh+RpBdg79uhwJfT6hToquzta8ySkNdjWzgc/7dORa9Dmyi7aBfVPw2i97Zhk5tm0kStxtqO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3nRPaW/2+MTVVrun99uYhhG4K2toTX9www81E4oYALKalbupS
	rBHPkbPHA5f9clfzs1nn7W1VH+3Y6md8KzgFj29qrKbuA7R3GeA7gPvV
X-Gm-Gg: AfdE7ck06Fb167d7NHpbDplpoDuR35hF2Lab2NbKGZShB0p41Ak8Uv2N6CLI5kj1gKu
	DT7zEhpf82/il8XUqpZuWQJByYXtsJq11vYTq0NlCFv5Qi+hS3jRZA2bNlf+PerTlOubEIlWHK0
	n3CIGMAag52Xh3tuc94Fa9LQNiH9u5JLCADkjvTAO/sJa0JrKlyWk708yQSC9E5eOPAb5Ge8+MZ
	xwNZUVHbB/4jREmwCT+h+NbJ+sdaAmo9E+4t33bku7wL1eRhnAc6+xWz+2KKZ+0k/O0VRWJjCwR
	CIsZeh7T4+hH73XPlPktqQBNHSfEBvCMwpc/14f+DhcWSgKxDS5FD0yvqc9w0I4lGc5uqTU/ihE
	yq1Y+xCdZ37xCtdg4I6r8uMilCSePE58+HGPp++vpuIuQaina05PO+jk3Aig6lye4y/7+pCKOsn
	52+gMcsAOs8RlT
X-Received: by 2002:a17:903:15c8:b0:2c9:97a8:8c13 with SMTP id d9443c01a7336-2ccea582aedmr5730825ad.38.1783479504583;
        Tue, 07 Jul 2026 19:58:24 -0700 (PDT)
Received: from lgs.. ([152.32.188.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf8d80sm20568755ad.25.2026.07.07.19.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:58:23 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] libbpf: Limit bitfield dump reads to checked bytes
Date: Wed,  8 Jul 2026 10:58:07 +0800
Message-ID: <20260708025807.702010-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_dump_get_bitfield_value() bounds-checks the number of bytes covered
by the bitfield, but the value-building loops read the full backing type
size. For narrow bitfields this can read past the checked range.

Checking the full backing type size is too strict for packed bitfields.
For example, a packed structure can contain an 8-bit field backed by an
int type whose BTF size is 4, while the actual object bytes covering the
field are only 1 byte.

Keep the bounds check based on the bytes covered by the field, and make
the value-building loops consume the same checked byte range. Preserve
the full-size read for the non-bitfield path used by unaligned enum
values.

Fixes: 5714ca8cba5e ("libbpf: Fix OOB read in btf_dump_get_bitfield_value")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index cc1ba65bb6c5..5d185f7961ff 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1766,17 +1766,21 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
 	__u64 num = 0;
 	int i;
 
-	/* Calculate how many bytes cover the bitfield */
-	start_bit = bits_offset % 8;
-	nr_bytes = (start_bit + bit_sz + 7) / 8;
+	if (bit_sz) {
+		/* Calculate how many bytes cover the bitfield */
+		start_bit = bits_offset % 8;
+		nr_bytes = (start_bit + bit_sz + 7) / 8;
+	} else {
+		nr_bytes = t->size;
+	}
 
 	/* Bound check */
 	if (data + nr_bytes > d->typed_dump->data_end)
 		return -E2BIG;
 
 	/* Maximum supported bitfield size is 64 bits */
-	if (t->size > 8) {
-		pr_warn("unexpected bitfield size %d\n", t->size);
+	if (nr_bytes < 1 || nr_bytes > 8) {
+		pr_warn("unexpected bitfield size %d\n", nr_bytes);
 		return -EINVAL;
 	}
 
@@ -1784,13 +1788,13 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
 	 * stored in num, then we left/right shift num to eliminate irrelevant bits.
 	 */
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-	for (i = t->size - 1; i >= 0; i--)
+	for (i = nr_bytes - 1; i >= 0; i--)
 		num = num * 256 + bytes[i];
-	nr_copy_bits = bit_sz + bits_offset;
+	nr_copy_bits = bit_sz ? bit_sz + bits_offset : nr_bytes * 8;
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-	for (i = 0; i < t->size; i++)
+	for (i = 0; i < nr_bytes; i++)
 		num = num * 256 + bytes[i];
-	nr_copy_bits = t->size * 8 - bits_offset;
+	nr_copy_bits = nr_bytes * 8 - bits_offset;
 #else
 # error "Unrecognized __BYTE_ORDER__"
 #endif
-- 
2.43.0

