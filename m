Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3737AA61
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708991; cv=none; b=F/DytMDI8pbnAFxu5cUVxZvNzNXDnrN3gduQfy41G5Z+jafkYFyQoUbWX8etozucy7PDR3A/1/T9sOCGw+QK8YVppNbQxStnpS1M7JrZ8rgbeah3WdBx8JU5ScIit+IYoyO9rqwfXDvSrOOHRJcCqsuZR9JdI7I7VzoEqvVb5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708991; c=relaxed/simple;
	bh=mHNzE1T51qkhUVI4g48iA1QTp6yVEC3HtoM/5DpUnnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beagiFH8c70DbSAcfXbAnKwQHuF/ZQymiV3VFfrbTliLwD+vg9I7s6geZQWo3Xy+f06zYiLdAbyF2xJ8JmuqlPnnf8hRMETprEx5RlZQglvPEUclSQ7Af05vKjSgsB9p2YUnctnJWWGnZAIpys7ELBfVEX2ykRQDTVv9/2T1eRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6IDqbr8; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6IDqbr8"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cbb6d5f780so798223085a.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 03:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772708988; x=1773313788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KzLR1vZy5awtbVTbYAmh5k4tcwmsGYBCR79f1i9Vys=;
        b=D6IDqbr8nBQBI5ydYK2HQP9vdT9IPza7DoGeMiI7K7eM9kgpq5EHyIZWlSSos3A54E
         Krj7JRPHHiG51c8nyauBfW3gpBFI4r4PYa8dR8SCIfrBUpytRnamqkAzStINd6fR/buv
         JtVqMi1uVbqdl667cIyCV5ubQsWVCAkS3cLQz8k0BifJWY89Sam5ufTzYJ2DxcP0N5iV
         2VsWSFWvwBI6XCcukQGz1UD/BiVNmor3ujwY+0tESvL5rITxMYR5TNGGX5L7g8Pb2xFR
         9NX0NNq6HxyCoKGINi02X3G7snogPDdbQ4tMEobc+qcVOI0FVjZOiogU7PChKTj8WLYF
         O8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708988; x=1773313788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/KzLR1vZy5awtbVTbYAmh5k4tcwmsGYBCR79f1i9Vys=;
        b=GxMNAG3X41zNP7mmY9eLbkLb4YBbkDBiiD/tKyIyhT1PSGgoKNMbNmsni3A/G8uChh
         ccCJrUpXMQxBOBDBcNA9+Wjyd0G3Oj9JVIRC38vK78CbgBkCXjDBRtCmbFvByJ1yfvlg
         qg1p0qz0cs5kMpekIUMOzTe4gHK+YOGTaS/w0V3bqiafPmlW2IyOTsHUE3vDwH8V3TJ1
         OrYZy1Y+hW65Nq6AqlOaRNxguFpRYZ5gq0U8gr+Lcu4T6S6D+7DWzQMfIBay0sIxahFO
         5tKFaR6ZR6YR3IiKc1VvJLDQuzYq/Nj6oqeQMFM5NoreN92czOMzsJOZl+uuK40j99DS
         0Msw==
X-Gm-Message-State: AOJu0Yxam1gyIVE/gY+IK44r059GUQuVLYnv85Nnl1RwqqA16DB7cbp2
	f+c/1YySCgtJLV6i0qBtEYGg0fMuxVafQy6lxO2iRumD8M+P2/jOF2lh7S0FBQ==
X-Gm-Gg: ATEYQzzf8mURrHzimqroAGpw2ox5U8cEHyV8a/1h6g4zeyLJ69TCBasK6VYvVPrwI96
	VQkLy5/dsaIEv92J4FwSscCF7fK+3QNjI2UfhAnNBNGZiQxXasFf3AquwmOKDTxQm91M4vK/kjd
	ceJ3PjNwkTicwjYj+c77pxE0GFyMU666SaJ2DIO4lWAfbbuCgI6iuBXb/AZqMAJMsA1GTnoCrpq
	U2lW1WVvbnMq/VpNHpir+EkrTaE2KhQFKcAbJSnI7D3RGgh4SiyaHWKzVtX0Ny1jp4jcz63Mt7N
	p9jJzJjja7Xbej23K9zJtKMONfwpSw/LZFAeSfDqpCNs5UBos2mctp0g/z6NJ0kwGeOIOUOjYFI
	beAQyc25XXI4GSXdFEgpfbgUbE1lzS+1ArzW0mznMea3QthlokrZiNSy/cVCXbiKLJ8qisEltMz
	Npd35KGfT3L/5fK7N7+VPT/b9qGe7EY9heBE67D8nXW/VU+WaUiScLejM/bwA=
X-Received: by 2002:a05:622a:181f:b0:502:9e67:2099 with SMTP id d75a77b69052e-508db38dc41mr65416311cf.44.1772708988529;
        Thu, 05 Mar 2026 03:09:48 -0800 (PST)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744acfcdesm176006751cf.26.2026.03.05.03.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:09:48 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	arighi@nvidia.com,
	shung-hsi.yu@suse.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: test refining u32/s32 bounds when ranges cross min/max boundary
Date: Thu,  5 Mar 2026 03:09:29 -0800
Message-ID: <20260305110929.738140-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260305110929.738140-1-eddyz87@gmail.com>
References: <20260305110929.738140-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two test cases for signed/unsigned 32-bit bounds refinement
when s32 range crosses the sign boundary:
- s32 range [S32_MIN..1] overlapping with u32 range [3..U32_MAX],
  s32 range tail before sign boundary overlaps with u32 range.
- s32 range [-3..5] overlapping with u32 range [0..S32_MIN+3],
  s32 range head after the sign boundary overlaps with u32 range.

This covers both branches added in the __reg32_deduce_bounds().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 4588e5b55b41..0c2a62b16ec4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2000,4 +2000,41 @@ __naked void bounds_refinement_multiple_overlaps(void *ctx)
 	: __clobber_all);
 }
 
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void signed_unsigned_intersection32_case1(void *ctx)
+{
+	asm volatile("									\
+	call %[bpf_get_prandom_u32];							\
+	w0 &= 0xffffffff;								\
+	if w0 < 0x3 goto 1f;		/* on fall-through u32 range [3..U32_MAX]  */	\
+	if w0 s> 0x1 goto 1f;		/* on fall-through s32 range [S32_MIN..1]  */	\
+	if w0 s< 0x0 goto 1f;		/* range can be narrowed to  [S32_MIN..-1] */	\
+	r10 = 0;			/* thus predicting the jump. */			\
+1:	exit;										\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void signed_unsigned_intersection32_case2(void *ctx)
+{
+	asm volatile("									\
+	call %[bpf_get_prandom_u32];							\
+	w0 &= 0xffffffff;								\
+	if w0 > 0x80000003 goto 1f;	/* on fall-through u32 range [0..S32_MIN+3] */	\
+	if w0 s< -3 goto 1f;		/* on fall-through s32 range [-3..S32_MAX] */	\
+	if w0 s> 5 goto 1f;		/* on fall-through s32 range [-3..5] */		\
+	if w0 <= 5 goto 1f;		/* range can be narrowed to  [0..5] */		\
+	r10 = 0;			/* thus predicting the jump */			\
+1:	exit;										\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.51.1

