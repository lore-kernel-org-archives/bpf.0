Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065317;
	b=NYgTDd/w3sDQNfzkEnxF9NjtmaOMl8MJtNPtHS5JK0Cp80DMWMag3LXDXskQMC0eUAXY
	 nux46D7/Pe2DtEumT5IYNNHXZvPG+4TCb9lQKhPL2MvCglenWMGZqVcdL1O/xISBV7Qa/
	 7M8MHPbSZtf0adskJyFdST44NCQuJVZVJQceAZHTjwZvrQH1k8ftod5427GFHjcJZV4Lw
	 mu+VbkmuovrV5MGqtPYUQ3h1cPl2cyfuc759D9RMLA7i3T8clq88Njj6tVub24MqnmzKk
	 CaLgD/O8Y8a+GMuZoLMWxqbZq5Eu0Sg1Ha+PYFeMo1eldB7YVOCeePZtvnNleVwaUDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065317;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ib0MWprGn+ifCOGjBrcNsaa6h4t85ymtvTsqJWMi+uE=;
	b=PPOSawGqPaCKA4X+mCdSAe+B1dnDrpd/yu6WS2lrQtUYw8HpZ0S6RmM5SEmw8WuCkbFc
	 BNUOInKAbWGJ/8sXpHe75fdLBSg6ESvStVu+B2fi/AD7Xc3DE1DdGe5OoPmOIetoae5st
	 qcfJNkWpzwAb34l2m7UfZ3+dNmPFS7rJ85ehxxK6bNESU84h3bxgidah87WbjvBRxA8Ug
	 f5m893nC2SrrT4ZWdbMYJUtjAywto7PE7x3Jc6/0NwCoWllL3qV9SiAMIx3ObMsnNRkeU
	 qV1LadsOjQwXs6HtzrH5WN4WZxVNVDvEh8eEm8b/BF0dlDL4lmXZ1zlAMsOVGYmcSJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.180
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA20606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA20606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 310E259083C25; Wed, 18 Nov 2026 21:15:04 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Take unsigned enum values as unsigned int for GCC
Date: Wed, 18 Nov 2026 21:15:04 -0800
Message-ID: <20261119051504.1904004-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261119051443.1902163-1-yonghong.song@linux.dev>
References: <20261119051443.1902163-1-yonghong.song@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

GCC's __builtin_preserve_enum_value() returns int, so storing the
value of enum named_uint_enum into a long field sign-extends it. With
the previous patch, the program built by GCC loads, but uint_val1 reads
back as 0xffffffff80000001 while the test expects 0x80000001. Convert
the result to unsigned int for GCC to get the enumerator value. Clang
still stores the 64-bit relocated value, so its upper 32 bits keep
being checked.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/test_core_reloc_enumval.c     | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c =
b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
index 964297b9bab5..dc15caf8c151 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
@@ -49,6 +49,13 @@ struct core_reloc_enumval_output {
 	long uint_val2;
 };
=20
+#ifdef __clang__
+#define UINT_ENUM_VALUE(v) bpf_core_enum_value(enum named_uint_enum, v)
+#else
+/* GCC's __builtin_preserve_enum_value() returns int */
+#define UINT_ENUM_VALUE(v) (unsigned int)bpf_core_enum_value(enum named_=
uint_enum, v)
+#endif
+
 SEC("raw_tracepoint/sys_enter")
 int test_core_enumval(void *ctx)
 {
@@ -75,9 +82,9 @@ int test_core_enumval(void *ctx)
=20
 	/* enum named_uint_enum is optional */
 	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL1))
-		out->uint_val1 =3D bpf_core_enum_value(enum named_uint_enum, UINT_ENUM=
_VAL1);
+		out->uint_val1 =3D UINT_ENUM_VALUE(UINT_ENUM_VAL1);
 	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL2))
-		out->uint_val2 =3D bpf_core_enum_value(enum named_uint_enum, UINT_ENUM=
_VAL2);
+		out->uint_val2 =3D UINT_ENUM_VALUE(UINT_ENUM_VAL2);
 #else
 	data.skip =3D true;
 #endif
--=20
2.53.1-Meta

