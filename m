Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AE1D63E4
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597269; cv=none; b=q/uLZwRllE3CKND1SM/Qr+SALri+5UGEkg2px2RRpHrq5SqpexxPQQuJ0o6O6njHWGTykYkWTwbev+2vmvEXZ0d6f2SSCpxuwFPoSUqEZCrBZu2iFUUQnhr6sUV8Hzwe6a/V2Cjl4E2sfgYahK/sdMvZLVDfd7eSWLARzh5lbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597269; c=relaxed/simple;
	bh=qVjOby338UmtHbqEcl4WbrSmJ2MQiye8BC2iVLLeQAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZxPAVquGO/yMwXi3vZuWLnL9FdMtHwBEJon/NzKe+M5GUnM8ciPlEqv5WBiusBsiCQMNHB0Xnn31/HJC5x5IpPaTBCF9hoYXpILLYXzZptJpIOovJth6lYA7piJZpd1iPCOF/4arVAu6Hu6053p5c8NrZ+OrrwKVmFnaan4nSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFShwZLw; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFShwZLw"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484373a2e82so677120f8f.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 01:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788597265; x=1789202065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9gVrbQ66GgQ+TVck8WGmqWU9s24cfkxi+NlN/N9n0g=;
        b=qFShwZLwSPUXMq+yKB8nPmtgyQtG2xGmHgIpb/HCxYaQISaUetWpefQ5n/fQ8T8IKj
         qJrAyR/zAMxyqhMEPXk/V5pCDjmwAVgAzipubBxHodzNgOM+BeyDBAQMLeScUhbA3NDy
         AN0V7h1jl1b+ELlxJEIHDECemYG0tbVohed1Ci7YbR3MQVam4aH0gRKy8w6EGzALcm+p
         awAaId4vjof+9NmD9O3yRIkTI/cCkVZF0tkjZdJLPu5neiIHBPBUPthe+vHZ4A2qUtPO
         ka2YTU0A7g+9D6koINAfK2yWt/yw+c9ZXnfl4/j+2Kdkw4Shp/h7V0BQla6PAMT3PyXM
         ZKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788597265; x=1789202065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E9gVrbQ66GgQ+TVck8WGmqWU9s24cfkxi+NlN/N9n0g=;
        b=FI+skF4mJx1MercMq6aYK2xZ/WxF3OlLhDEV6wkcWcWd1rdT2lGD93liW7V5Criyx8
         MKkLWe0+2bZkB8j/n/TK6wGpmg3Ylfx1HyigBTDkdBamapnfi2jpMq9NEOaoAxoeCnQv
         YFhJKMLxWc0YDUVIDzy4IT8CS5uAzJ9mAwRF/54EZ8Psst6UWzs9KgN+N2JQKLXo8lBV
         xj5mKC3RWtJvSLrtaObgV8P/r3U5noFrXJjwbIi9Z9G5sEwR4PyLMLb60MVvVxZYZq1+
         IF5VoPdKv8mM3WTmk6wqEW50mxQc8P7PgPMeSR6mP+sW5dHKi7kQv0MtckaQWSjQZGEe
         z7tw==
X-Gm-Message-State: AFuF++mE0jW69lkPUxoKh2FYBQuWOmqG0CJoNpSFgp5SwRgv3+Tnr1uZ
	oE1fZUbSaGN685ko8X/gjfBMJwbHUqPRUWq93ifmD5BiFANhEarJQQTPFLjUi3B2
X-Gm-Gg: AYBFou0RiRWD+gxbdkkqi+7Y8e7O3Tr/5HdEyrrtO0ohB9D7KwB06uYBfFw/xVZg2M8
	YIWZTXu2txGg2+UHdtrYI3dhUrtPIZ6djSNWx27xpfHm2087ZiGgtHRSkFYC3d/MxxyFD5qdHBM
	dbDH72uX5xXDa1NAyJQ9vn9ohPNJbanLBh5vy569kpalZVPwdcoFrfGVBCkjVKIxOj/eOY4mrSZ
	esdWdsMHalc/VdTcf+2cAXDlFAisqL2p0G/K3Zt4GlwPn5eZZZHoYdU7s5KyWWpj9r8nhYfXEky
	pql+oHHK6YrAdDhDidZsjFqwd2wx2LWS68hWBNpiQHQJe+ReOQ/leGYUbs3SUka8ajsYI9pLsU9
	IOE38HwKHZwUfrklt5zP5uAgdYI3hVLjRI5bCjMpSA3sf+3WZ6uVf7PHlWEVSqXVH99USLI6qGD
	Tu5HdWuRKQXf33BfsogDvSnVIxf3NwT2tn+oyXshINOQBt68GOgFxm0TjFN9PzJBJ46lAK6awwE
	9ujAvz4El11tkDd/dVlYZIGXDD2Pkcs5DjdlnkDsV/bY88I//xw6mwwkJzeYPPVu0n7Vfqyxfdk
	LJYwxzngwYvUXrC5WIYNVySz0Js=
X-Received: by 2002:a05:6000:29c9:b0:484:3314:eff6 with SMTP id ffacd0b85a97d-4858709b390mr18071313f8f.28.1788597264843;
        Sat, 05 Sep 2026 01:34:24 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859162f354sm3632797f8f.20.2026.09.05.01.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 01:34:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 3/7] selftests/bpf: Test packet pointer class displacement pruning
Date: Sat,  5 Sep 2026 10:34:11 +0200
Message-ID: <20260905083418.3723623-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905083418.3723623-1-memxor@gmail.com>
References: <20260905083418.3723623-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2219; i=memxor@gmail.com; h=from:subject; bh=qVjOby338UmtHbqEcl4WbrSmJ2MQiye8BC2iVLLeQAk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2pfz3xQuWHevwfl/HpP7tH5fBPkZRrqaFx/ji7evaP j/m7TPvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQOrmX4w1m0v5GlYnONvU5h /8Ere5jjV7Wd2bKO/c6L/2LcvLuOL2FkuPL8atuBQt0LE7z/+DKYXFrWtutqs9R/8VUVTeHi4ua 7uQE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add two paths whose packet pointer ranges are individually compatible at
a join but whose members have different relative displacements. The first
path proves an eight-byte access through one member. On the second path,
the same guard only proves that the access starts before data_end.

An affected verifier prunes the second path and accepts the program. With
packet pointer class displacement preserved, it explores that path and
rejects the out-of-bounds access.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../progs/verifier_xdp_direct_packet_access.c | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
index 0b86d95a4133..692a8468f3d7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
@@ -5,6 +5,50 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
+SEC("xdp")
+__description("XDP pkt regsafe preserves packet pointer class displacement")
+__failure __msg("R2 min value is outside of the allowed memory range")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_regsafe_class_displacement(void)
+{
+	asm volatile ("\
+	r8 = *(u32 *)(r1 + %[xdp_md_data_end]);\
+	r9 = *(u32 *)(r1 + %[xdp_md_data]);\
+	r6 = r9;\
+	r6 += 8;\
+	if r6 > r8 goto l_exit_%=;\
+	r0 = *(u64 *)(r9 + 0);\
+	r4 = r0;\
+	r4 &= 15;\
+	r7 = r0;\
+	r7 >>= 63;\
+	if r7 != 0 goto l_path_b_%=;\
+	r2 = r9;\
+	r2 += r4;\
+	r3 = r2;\
+	r3 += 4;\
+	goto l_join_%=;\
+l_path_b_%=: \
+	r4 &= 3;\
+	r4 += 8;\
+	r2 = r9;\
+	r2 += r4;\
+	r3 = r2;\
+	r3 -= 4;\
+l_join_%=: \
+	r5 = r3;\
+	r5 += 4;\
+	if r5 > r8 goto l_exit_%=;\
+	r0 = *(u64 *)(r2 + 0);\
+l_exit_%=: \
+	r0 = 0;\
+	exit;\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
 SEC("xdp")
 __description("XDP pkt read, pkt_end mangling, bad access 1")
 __failure __msg("R3 pointer arithmetic on pkt_end")
-- 
2.53.0

