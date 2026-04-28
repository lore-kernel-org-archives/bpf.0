Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993B2F3C18
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383790; cv=none; b=CXB/qTsTIvwCBFdJYBjdp73BNQX/DzIKkgbQiUidi4i0HrfXfgniNY5jj4dpO0lWve3ph36E/tftgOu1efiWfn1Ns4o26VrYYr/NFxNvelxwsKQCAXXLbQh3jBvQ1+2vWFMw5ZKqlHQ1k0rb0CPt2RahelNfQXghlDksjnMr3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383790; c=relaxed/simple;
	bh=RfT7EEpmCXRJ3IliDMiRImP0WISHJLRp6V4ccKLJL54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p+cl8sAPfrLHev9ow/SP7b2D67RSYZUsnDplMGELLuN2BikQQJQ8KLuvGmC1myh7PH4YpcWjFghAyyQHsmPoaL3jxgDNRioB/htbKFT2p2WEx8xvoMaRdpOtOEmbNze1Qt3GH5gapX/N6P62eBFmodrh6haaAI6nFXj+Dg2Lezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cZwmipZ8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cZwmipZ8"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SA3Re01329423
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 06:43:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=1phEBcqVLgE7RU3K7a
	s86/X0212KKVUW0fSnLGrz3ic=; b=cZwmipZ8tJijVdDxoY1ZMcN4b7skCsAYFv
	NgoDgXw04WUc1WG2vJz3BcetP+XYK326OCeoR+Da2LEs2dmlNYSVwdUfJPUg+Bgo
	/E2ZMowIYUlVR+Ijt9P9D6vXM2SZvu9fzfwG9NyT4v3czs/5rE/meowPFnEkfqWi
	F7ZJzLi3/NH7faSoJXpySNN2xxCUV7NpJUVmCkGy6BDv6yHLPH3QL8Wan81DcPar
	7i7rX9WSX1qgOp95pxqB+kfxfIGRNiUOC2OLurAQkZfmL04wvvI3e40eEwuq4u+s
	ayK3YDn/V3cZoWUW0daVQ5mYmc5ytCyoIFRQ5xuFQr2nqaRvKvgw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dshmw3ukc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 06:43:08 -0700 (PDT)
Received: from twshared6963.04.snb3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 28 Apr 2026 13:43:07 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id A0DF867B8BA2A; Tue, 28 Apr 2026 06:42:54 -0700 (PDT)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <memxor@gmail.com>, Emil Tsalapatis <etsal@meta.com>,
        Ihor Solodrai
	<ihor.solodrai@linux.dev>
Subject: [PATCH bpf-next] selftests/bpf: Rename libarena malloc/free methods
Date: Tue, 28 Apr 2026 06:42:52 -0700
Message-ID: <20260428134252.2783519-1-etsal@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FdQHAp+6 c=1 sm=1 tr=0 ts=69f0b96c cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=CWErhr8FAAAA:8 a=VabnemYjAAAA:8
 a=Z-hnEZ9kjhzc6VEBKFgA:9 a=I-g_0vLIplkVOQ0FYkeP:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: EcCpyqovjOaMfd6L-axMjDrNbUmUNhpG
X-Proofpoint-GUID: EcCpyqovjOaMfd6L-axMjDrNbUmUNhpG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEyOSBTYWx0ZWRfX8EXafI+SvjW+
 paj/Xl+0I0AO7Syx6GL81tiOR5p49QWYO3Cn8gVVH5R64sjQQVNqsfeNU4SLL9XC7yyu3nlesQd
 1bAxfW5n94SVzvIU7dWp+NoFsQ5/339yfWYqZpK4X/YXM2UKacFFEv82PNG0lQ4z/XH8lWaeDB+
 vF6fhjqt7SCRIwdC50c0yiVq3ildIYwAMi+HwVJMSPNjtq2VMT9ITN6MZEF3y4C07gHeQBAVwZD
 GmARAOZjow2gfC8A1ceGnmp54LTpg173sZXlHb2PHCBSN0B9IJ/xD4TwmRqZXgZr8xFnJCwWt9m
 FwkkoP1fYQ73eM4D/mfR5ehd/mVcPRXqKwX0OdqU3y+2WXwrb9+o6cXqNtAlox0oC/nTS3wCgCT
 rbToKckCF4QHNTptUtU/VqOwqyrAxKCCwmOsBzy1816afh5uMATcpPvMW38MGKqLlXsdvrpXRhA
 ZdMxul6LyZZmNhGTtjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01

From: Emil Tsalapatis <emil@etsalapatis.com>

The s390 architecture uses the token "free" for an enum, conflicting
with the malloc/free definitions. Rename the calls to arena_malloc and
arena_free instead to prevent collisions.

Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Emil Tsalapatis <etsal@meta.com>
Fixes: 7c8d208d816d0504aa916138ae097d9cb4ed4e56 ("Introduce arena library=
 and runtime)
---
 tools/testing/selftests/bpf/libarena/Makefile               | 2 --
 .../selftests/bpf/libarena/include/libarena/common.h        | 6 +++---
 tools/testing/selftests/bpf/libarena/src/common.bpf.c       | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testin=
g/selftests/bpf/libarena/Makefile
index 3c695f9c0054..5e2ab514805e 100644
--- a/tools/testing/selftests/bpf/libarena/Makefile
+++ b/tools/testing/selftests/bpf/libarena/Makefile
@@ -51,8 +51,6 @@ ASAN_FLAGS +=3D -mllvm -asan-destructor-kind=3Dnone
 override BPF_CFLAGS +=3D -DENABLE_ATOMICS_TESTS
 override BPF_CFLAGS +=3D -O2 -g
 override BPF_CFLAGS +=3D -Wno-incompatible-pointer-types-discards-qualif=
iers
-# Required to define our own arena-based free()
-override BPF_CFLAGS +=3D -Wno-incompatible-library-redeclaration
 # Required for suppressing harmless vmlinux.h-related warnings.
 override BPF_CFLAGS +=3D -Wno-missing-declarations
 override BPF_CFLAGS +=3D $(INCLUDES)
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common=
.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
index e54cb7b869bd..ca1a6c1d6477 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
@@ -48,9 +48,9 @@ extern volatile u64 asan_violated;
=20
 int arena_fls(__u64 word);
=20
-u64 malloc_internal(size_t size);
-#define malloc(size) ((void __arena *)malloc_internal((size)))
-void free(void __arena *ptr);
+u64 arena_malloc_internal(size_t size);
+#define arena_malloc(size) ((void __arena *)arena_malloc_internal((size)=
))
+void arena_free(void __arena *ptr);
=20
 /*
  * The verifier associates arenas with programs by checking LD.IMM
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/common.bpf.c
index e5da1e37e83e..544bf9e1cb38 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -38,12 +38,12 @@ __weak int arena_buddy_reset(void)
 	return buddy_init(&buddy);
 }
=20
-__weak u64 malloc_internal(size_t size)
+__weak u64 arena_malloc_internal(size_t size)
 {
 	return buddy_alloc_internal(&buddy, size);
 }
=20
-__weak void free(void __arg_arena __arena *ptr)
+__weak void arena_free(void __arg_arena __arena *ptr)
 {
 	buddy_free_internal(&buddy, (u64)ptr);
 }
--=20
2.52.0

