Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A53BB67F
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591630; cv=none; b=oo/lAaM18ePXQWt8zVryimftjKq6Z1H0NNWSbScwKCrelxiGx6Fygp10rg0h5GC/XFkrbbtBAdzsb/lE9WFs5hJE4kSsT3cOCFvrgg71LWTzZLo1UnUfxkJS+2fiL3CejDI6oGSySQYVs9TnmzHpE6C1zGRUUoJ124RDOau4mBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591630; c=relaxed/simple;
	bh=qVjOby338UmtHbqEcl4WbrSmJ2MQiye8BC2iVLLeQAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYroxG9vXDwzHG8N2NIrB4w4MgHsjfsGHCy9vtLvD26zZT7/04OuQhPTeJSA8wfEeW2DMjLclQzwM9BLzbOu/bUBfxnz3ZgpSkMzq4oNQKuuI/gr2+w691/aEIqkl7c8U1H8yImkrMGSBcR3j5OjJFWt+J12MqyTru9FHXpnCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRXa3puI; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRXa3puI"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-48437cc1b11so464660f8f.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591611; x=1789196411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9gVrbQ66GgQ+TVck8WGmqWU9s24cfkxi+NlN/N9n0g=;
        b=oRXa3puILFF0uRygtmMWKWKLbaNmREZACN75S75Qi7gJODuXJiCyXdI/RHtCaaEwfS
         jI7LfLRrKg2FSxKqBHAI4Wm+NFxcoK4PQryv5LwXC/jksIZhTuPe+xlRajyBCHJkPjY0
         WJ/gYiBm8bXzOIhcGbOJMGpIbcsXKsZrChTcu2/42fA9y0Yh0tVeZooe02GQ34aza/pY
         ByJ7ZuvNe2uhEeAeltl1utZkKm+ZPTwxuomcQ1NlPywywr3plnpEvUOGmHsmQUgWLkZG
         qiTQWEb6NX2uIxWbZdClttb2ggcjkT5Pn1Ne/YR9juc2Vyqw87MG/ShXtx6a7BnQwS34
         Sx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591611; x=1789196411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E9gVrbQ66GgQ+TVck8WGmqWU9s24cfkxi+NlN/N9n0g=;
        b=Qa3OEYNw8PDegCuKgwVrD9OWYJLQkp5Ndad1LHUo005r1CbboiXbViRp8rKCdDupB/
         wMCCmLGgA3mdvb3fuLpMhyMN552oMqd3A8jEP9ok80OXQy/PXviE3F1roHKuN9E2jV9h
         3VOY75zRvXN6xau8x+udObS1dx1qVq64c87A0EVZuPpzrh6C9KAJxxDkqzESK0Y/IdXm
         WDA6CQMPOZXlNuHIsdU/P+66tydwJKU+L5b1lPATwSiGe6sd8130fDV6ioo6ekjn/yoY
         wwPh4smYFPGaOrNCu2cp4cPGFYUGzkQQPKtanBlgSRIYyJbdwfa/nozk68zvcdkH3wr9
         aadg==
X-Gm-Message-State: AFuF++kfijernGyf10Pt9GZfkStKTg0xhzdQwUwsfZiu/onYm3ajEk/5
	sWRprVasv1JlR/Xoi5SW9/NWv8pEbl9V00I8UgWBZHRLsU1CDwPIDDpWCIBbPzYZ
X-Gm-Gg: AYBFou3hqIBCwFIBY7vktayAhH8FrbMgYD+v995wHuEz4M/Ts9sbYgAktjwh0HUD8AW
	eXrSb44He8ufQTFDNaNpwc9qQy2h878u+Fn5MCVAfbySc6icwv9QozseSTFUqP7KCjKjKDq3/Yg
	lmKzuUwJHjjTr6lHdQIzXtFT8aTykl0llrQvgo2TPrZGSBC7z5c+2A/2U+45e5so0vGhVf1p4bX
	30MHtdKY2IF2ReVT6la8rnswVKx2AMecBIra/pptULCAoswydQKCO1POwyRheucoMIXVVYxUwvC
	MFu8iLohEAMz7a1gU/unyv7MpQAglqdmSv5p6Lbc8x83DD9y5SRTlLwNchkDXaaZd7EDpL8Vk7E
	X2hVBLOfz12+jPPvkZy3s40+acdN7XfSY2c8JqcKxGp3d2LTSSsIgLQoTD6YOswXs2FHdIOZD+D
	6wNQ9EOCjPLmlX7Q9VOaUI1o1ZON+25kWdGT8Tbt3YDSPjGE1VBAGhZg4j2ficAETYtaGT0EJK7
	cF71BVVysSL/dj0wCZC5xUm3xC8GwHlEw15o5EHBo/IlieJIOq3wt6/yFoxZb0qyZkRXsNVv0MQ
	IsxFcYix0uNhWL0cCygQrNLnbPc=
X-Received: by 2002:a05:600c:190d:b0:49d:72d:9ba3 with SMTP id 5b1f17b1804b1-49d072d9bccmr4006015e9.14.1788591610584;
        Sat, 05 Sep 2026 00:00:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cc7sm128962285e9.4.2026.09.05.00.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 00:00:10 -0700 (PDT)
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
Subject: [PATCH bpf v1 4/8] selftests/bpf: Test packet pointer class displacement pruning
Date: Sat,  5 Sep 2026 08:59:55 +0200
Message-ID: <20260905070003.3193366-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905070003.3193366-1-memxor@gmail.com>
References: <20260905070003.3193366-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2219; i=memxor@gmail.com; h=from:subject; bh=qVjOby338UmtHbqEcl4WbrSmJ2MQiye8BC2iVLLeQAk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv23mXvixcsO9bh/b6OSf3bPy6DfYyiXE0Lj/HF29e1f X7M22feUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIloxzMyzDCy4Qncx/CwftdR PYkg1lzm8q1bSmef1FrX6WYR09++k+F/8bvJFXfPuyw1/vDXwpNruUav7Cpl3bj7f7Y+5Sy6dMC YHQA=
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

