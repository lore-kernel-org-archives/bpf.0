Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CB7384228
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 02:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305419; cv=none; b=qm/+h4QuZep9498psUj6g5jt5tj29G7Lv/z48Z2PzkNbnRRsTIBP4pR6lTQfqS0m5ui94SBxYD/+yiwiiROvpmMtp8vAX/2PSQVj9p8gGJnBlDABnLVtbdHEat2k/+n+XycT9iKlo6V/QqSaW1LiwGcsPrR/EtqbD4vqenr4Cvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305419; c=relaxed/simple;
	bh=cU02yNkwV1YzGPMRD4x++mPfJxsTNb9WTrGJT+hzgos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGE5k2cbQ5jXzxtRTlgEdw9/YvP+2M5an67mC9UiFnI2AEPztz/FZJ31G78lxM9Sx5IEO5BeQ1H0PgcsDEk9zbNTNiJH7PmQ6czstN211L9+J3ntg3zdFIDesIgaMLNJG7kqpUXPqRMCywMYzYkkIxPoPBOUctNEmBWdg3sZWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Blzzx/E0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Blzzx/E0"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so2667099a12.2
        for <bpf@vger.kernel.org>; Sun, 05 Jul 2026 19:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783305410; x=1783910210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BvHO/cnlokceDY89ApagHJNnWoYZbTLjHr/S4wwAwbI=;
        b=Blzzx/E0h2c+iu58tGcRz+ILmkpXeinxb2U5tYG+ge3sDgfjQH+brL7XwDFc4C62sS
         0M1duZKFTjtgtNVFNYsKJaWo28SGtqz4CunXx9cIExbtSIsBh7BBhylceQDxty5sp+Mg
         g5VwV5EyExtMt3i3N5Lvz0kOMu5ntYL7nimivN+t5KUs2CyWknCbf14/DigRyOfn2TyM
         xglfIfqZBc+vOjaNVDAlxu6TGpzYMrkBiGgR46iQK4g7MpaoO7dK4m8OnqmGLsxmQ9bi
         M1Dt0VOmGEDUiSGcQqBhO+X2XE29h+KgUiTCZ6UDHWXgxEg28kjHNylgYQ8eoP1zcD/q
         Mz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783305410; x=1783910210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BvHO/cnlokceDY89ApagHJNnWoYZbTLjHr/S4wwAwbI=;
        b=iEsohXAgDRZOmxepw9HxSOWUt+Ia8hsgrCjBSHRMgt3pE8XbWORZk5FxK4UsMCL1id
         /eSoNNcAblGE6mpHS8NDAEZETUkUBoR/s9xsvWVsf3qrTebdqr6Xj+chDf/Lo6iupA9W
         2C3ftqTxj1znr3ZDo7HkgfOCOOJFICi6faOy43bmuv3POFGhAV2drWHEaOz01yV7TQa3
         lJ+6yZCVoj6RrJaDrWk3uDV7JCCtT2ZH86WCsvRkwBPBk73FL6iiX4ywSVcfxIKMPGjZ
         VoncGHQcowCveIMHoz6ftekdYBca4n6IftSaq1dv3Eb5u4Ld8biV6s/QFpmLtpT7xFFt
         3V8g==
X-Forwarded-Encrypted: i=1; AHgh+RpNxBWJ5JEnyrlG19DXsaM38w1/89oKdl/2Z6dv8fJoKNeRNQQG2jRPsvwAejmfccMgu8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4091NvJAsnC82qnysTHP99NmLI0Sl9i6pCG0n/K4Sk8mzmABu
	OTEE937pD0GwK6KwDMytZcf16v7Oc+BBXg5dCFDuV82e0rFa5tG06plp
X-Gm-Gg: AfdE7clR+xHa0ZNMhZ/riHb1cFT9Z8Wp9Thy0t0hv/clf1A39AEmX3Dmd/Yq7raZuxi
	IYEDVma6lw2yr9TbhXpe3a2UGeg4GM6YBjZaaw/wMyMV0XhNfD/ObH1Oq7M1ZgXAHbT07sSQhFv
	OFbpvNdklpyAmJBHPrYYMkat4FMiPSYJQayZjg74ZXhGQJqvv0OAHL1YkJsP3RV8RW6GN2WXi0f
	1xhtfVV2GJhmaHximHBCFmLAZvC8W10V4+ZZbKQCoy8JtI54qazBGFw2l7enxI6kDKjFQM8AFjY
	oUxnZnq+UW3+R5kvNxCpLTKoOTPyXDjVNEo4PtYR0QeFBq0fp3HUW2mRklktfep74Ry/xlqJdEt
	iPO4YQZm8HLsihFashiNoL93vp8fSdfvNZ+nFceLFbcL08sjCUZcGm+Ka8+SLQf9GNG9vXmgJcY
	bZFgs8GI2s5w==
X-Received: by 2002:a05:6a20:7350:b0:3bf:d354:134f with SMTP id adf61e73a8af0-3c03e4c1caamr9090776637.44.1783305410197;
        Sun, 05 Jul 2026 19:36:50 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e920d7ffasm5125558a12.22.2026.07.05.19.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 19:36:49 -0700 (PDT)
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
Subject: [PATCH v2] libbpf: Limit bitfield dump reads to checked bytes
Date: Mon,  6 Jul 2026 10:36:32 +0800
Message-ID: <20260706023632.625353-1-lgs201920130244@gmail.com>
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
v2:
  - Do not check the full backing type size, as it rejects valid packed
    bitfields.
  - Limit the value-building loops to the checked byte range instead.
  - Preserve the non-bitfield path used for unaligned enum values.

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

