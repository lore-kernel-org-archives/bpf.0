Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4CC367F2E
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097720; cv=none; b=SfmV0Ilr4oiKTdAS+yIaYFTSpRZTi3l+sElgPlj1qppQA7fPdOydwQcJxvg4MbPW4nB+s78JsapuBp4+Ii2+TvKvVTfy4gQKXknOSzoM2kQ9sU7Q3lZ5kj1XbRr8c1lju7sFJYl0Lbf4z/MNEILbe7OLHwZMzcTZbo3xLV4CRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097720; c=relaxed/simple;
	bh=0x+oh3Ad52Sca3x6orHPD7J2rPFUFn5nFDbBCxsnnw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXPlc3rWG8m0HbB+T6KbTM+iAs/AcwRQHFiXEmN9H8wjjymKE8AUs9gaPtOJreUC9DPLvgqVr+GROp8lERQe5FLv+gU6TxzXErpecC23D/jJrrNH3dczsOHTFFlYc9vVYFciSVvFfxPC1sN2tuPE/Du8D+8hzf67GeyxDkCLVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WCuao1UG; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WCuao1UG"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M9UKQ82028054
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=pGnoOQk5MkjKtkWRhajo/fRI5rleZGZY30mPvWA2kIE=; b=WCuao1UGU18k
	i0XZROX/offYwyE9jNiWNfMupjgJqtYb5MAzlsZbsKQ00209pHFzREMurynph+jA
	t4Td0x1wdn/2+OhH15BEhaHjVPvV4BvxHL9+BlA3ajLIZgLCAd78vU/uZfxiLht4
	xauDPDLEUgE5+shFUrv3jUmDaOXadmgVtSfwjyf8R/1OL0rZ9pC3OISvar/Kh4h5
	PXefKy2VfFvDnDP7v910REQNzBfsG7+f3AzVgkCYo9reVTWV4s3ze5fphmB3gzkG
	MeBLfKcHVyXR8HBer43E/gtvGonpnTY5ubTzMwxt16saSsLD9QIXHtdO9K79zHUa
	ENuVw7q6Rg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4buhas2g0b-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:55 -0800 (PST)
Received: from twshared41309.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:51 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 4A2C210A69E97; Thu, 22 Jan 2026 08:01:43 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 03/13] selftests: bpf: Move bpf_arena_spin_lock.h to the top level
Date: Thu, 22 Jan 2026 08:01:21 -0800
Message-ID: <20260122160131.2238331-4-etsal@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122160131.2238331-1-etsal@meta.com>
References: <20260122160131.2238331-1-etsal@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nwLvXHrYc42aNlJUQgNN26B0Uxf1kmLz
X-Authority-Analysis: v=2.4 cv=c6qmgB9l c=1 sm=1 tr=0 ts=697249f3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8
 a=2MaxJ8NccyqPj9YSM1wA:9 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-GUID: nwLvXHrYc42aNlJUQgNN26B0Uxf1kmLz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfX6gOXrUZJJx88
 eKg8t7AOTainoKu4N4S1ZC2dWohhkXHodZMZ8vXggsgXSyGVSFY4pSYMBy/LN2decAg5i2XR//2
 IBZ2IiTi3/Zmhgas+Hs935TAKNst4O73QZnVjF2crnF/L/FUs4N67hFf9tznA5sNmebhhBHHmWD
 f2xScyRBzLAKXlEQP7qGKzYmfIEjdTExsqaGD1kZl8GX5OBuWlV/CtAjcTbXWM57HMeQH7FAI7M
 t77pt9NGJXaJ/8FWkGoJ6GeRtLPnAqmDvhRKDoDI71Storo4noKGERsUinVeYqrjOjhubO+g81L
 MnXbX/JIAq7CPtWz8kms5w1engpb9PL3kMsWWYXdsWGiJWqySk3GQUrRoGAcYLuFYC50BcLCpQ4
 QDyyCONjRcpLNBAZxW8NoHZ+wF7aa4MMc4p5m64mvxPulnGrQ0O2hh0uHazyjAjGlwZn/9EEcw3
 IEPAks6wNp3LETmpFig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

The bpf_arena_spin_lock.h header is useful for all programs and not
just the selftests. Move it to the top level of the BPF selftests
to make it more readily accessible.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/{progs =3D> }/bpf_arena_spin_lock.h | 4 ++--
 tools/testing/selftests/bpf/progs/arena_spin_lock.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename tools/testing/selftests/bpf/{progs =3D> }/bpf_arena_spin_lock.h (=
99%)

diff --git a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h b/to=
ols/testing/selftests/bpf/bpf_arena_spin_lock.h
similarity index 99%
rename from tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
rename to tools/testing/selftests/bpf/bpf_arena_spin_lock.h
index f90531cf3ee5..680c9e6cb35d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
@@ -107,7 +107,7 @@ struct arena_qnode {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
=20
-struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
+struct arena_qnode __weak __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NO=
DES];
=20
 static inline u32 encode_tail(int cpu, int idx)
 {
@@ -240,7 +240,7 @@ static __always_inline int arena_spin_trylock(arena_s=
pinlock_t __arena *lock)
 	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VA=
L));
 }
=20
-__noinline
+__noinline __weak
 int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock,=
 u32 val)
 {
 	struct arena_mcs_spinlock __arena *prev, *next, *node0, *node;
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/=
testing/selftests/bpf/progs/arena_spin_lock.c
index 086b57a426cf..6c04e7707644 100644
--- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -4,7 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
-#include "bpf_arena_spin_lock.h"
+#include "../bpf_arena_spin_lock.h"
=20
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
--=20
2.47.3

