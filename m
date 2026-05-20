Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1303806C6
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314993; cv=none; b=R2tO4K48kb0uTSp30axqEGcE0ete884UOVmlY0Sp2RQvpa3GjMobLbu9DnhJo10hLM0Kz1JBS7jfrIAOHNpdmdErE1PYfTifv709Its2+HlUwx7bEZIVAUDzrqt1y+IerZGTRc8IdNucP7wOL9L6Yfu4CepkhS0uUD4WngCms0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314993; c=relaxed/simple;
	bh=sESrtnEkiukd957DKW4R4u+5NVgNWu0Rox+HVle5NOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GdGeElKdmYZ3vGuIYZ+hfLBEekZ/+v390eoLkq3crI67HBbXSxIRx0ewm43pL/Vyek/KwHz9QTL3sFsZumwgTglbhKYc2H0wsqwIe+GzUHVzIPzL9Z9xx0dwFiTCPJmzzVsjhTeas4HEP8oLkHwD6fJpBSA65R6v9In1YiJ+eWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JY/2N9wD; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JY/2N9wD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BFBBBC2C649;
	Wed, 20 May 2026 22:10:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C1E7C60019;
	Wed, 20 May 2026 22:09:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76A47107EA218;
	Thu, 21 May 2026 00:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779314987; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=k2dpDAzX+92g0x+C7pCYldq5Fu4ePZOO/ElZAdhgYyk=;
	b=JY/2N9wDK5+hiyRFaCppsT37VKYC9Nb9y01lTE4KuA22D047rlTEUb13AOGEQBmw5shxad
	bkBRv1IIsJu521Nf/g5NSdRhNGYSiuqFIAoBPSKuvBespd5kKDCdFOQKU2Xe8OgbH9ZIc5
	9zRB/XY9AYfzVdtXlWeYze5anzwAHpE6wdJSiCvF3ubWxOS6A5S1c8FXeN0t8ZQPe+fAlU
	cHtJnkmvtBkFAXHPnni3F4ayWnS8oYf2GDI2gRtza2xRT+t/Aqwr9qKQpGssrS9EP1iDDM
	i81ksRtKCdl/doxaT1whcP7dxFN0SmVTLDOjLQHNdvLalfptovkYBDiGRYz/kw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 21 May 2026 00:09:11 +0200
Subject: [PATCH bpf-next v2] bpf, docs: add LOAD_ACQUIRE and STORE_RELEASE
 instructions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-bpf-insn-doc-v2-1-8c43c037d599@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NzQ6CMBCEX4Xs2TVQBMST72E49GeRNdqStjYYw
 rsLePU4mW++mSGQZwpwyWbwlDiws2sQhwz0IO2dkM2aQeSiziuRoxp7ZBssGqexqWpV1q2WpTj
 DOhk99TztuhtspKUpQvdrwls9SMfNtrEDh+j8Z39Oxb74f5IKLLA5mcZII1vV66tyLj7ZHrV7Q
 bcsyxcx6oKexgAAAA==
X-Change-ID: 20260520-bpf-insn-doc-756b369ca328
To: David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 bpf@ietf.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Commit 880442305a39 ("bpf: Introduce load-acquire and store-release
instructions") instroduced the LOAD_ACQUIRE and STORE_RELEASE atomic
instructions modifiers. Those are currently not described in the
documentation, despite being used in the verifier and the various JIT
compilers supporting them.

Add the missing entries in the instruction set documentation.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- fix commit message typo
- clarify zero-extension and registers meaning for LOAD_ACQ
- clarify insn encoding for LOAD_ACQ and STORE_REL
- Link to v1: https://patch.msgid.link/20260520-bpf-insn-doc-v1-1-74d7dada9bfc@bootlin.com

To: David Vernet <void@manifault.com>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: ebpf@linuxfoundation.org
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: bpf@vger.kernel.org
Cc: bpf@ietf.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../bpf/standardization/instruction-set.rst        | 27 +++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 39c74611752b..e8b33374bd09 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -668,7 +668,8 @@ that use the ``ATOMIC`` mode modifier as follows:
   part of the "atomic32" conformance group.
 * ``{ATOMIC, DW, STX}`` for 64-bit operations, which are
   part of the "atomic64" conformance group.
-* 8-bit and 16-bit wide atomic operations are not supported.
+* ``{ATOMIC, H, STX}`` (only for LOAD_ACQ/STORE_REL)
+* ``{ATOMIC, B, STX}`` (only for LOAD_ACQ/STORE_REL)
 
 The 'imm' field is used to encode the actual atomic operation.
 Simple atomic operation use a subset of the values defined to encode
@@ -695,22 +696,24 @@ arithmetic operations in the 'imm' field to encode the atomic operation:
   *(u64 *)(dst + offset) += src
 
 In addition to the simple atomic operations, there also is a modifier and
-two complex atomic operations:
+four complex atomic operations:
 
 .. table:: Complex atomic operations
 
   ===========  ================  ===========================
   imm          value             description
   ===========  ================  ===========================
-  FETCH        0x01              modifier: return old value
-  XCHG         0xe0 | FETCH      atomic exchange
-  CMPXCHG      0xf0 | FETCH      atomic compare and exchange
+  FETCH        0x0001            modifier: return old value
+  XCHG         0x00e0 | FETCH    atomic exchange
+  CMPXCHG      0x00f0 | FETCH    atomic compare and exchange
+  LOAD_ACQ     0x0100            atomic load with barrier
+  STORE_REL    0x0110            atomic store with barrier
   ===========  ================  ===========================
 
 The ``FETCH`` modifier is optional for simple atomic operations, and
-always set for the complex atomic operations.  If the ``FETCH`` flag
-is set, then the operation also overwrites ``src`` with the value that
-was in memory before it was modified.
+always set for the ``XCHG`` and ``CMPXCHG`` complex atomic operations.  If
+the ``FETCH`` flag is set, then the operation also overwrites ``src`` with
+the value that was in memory before it was modified.
 
 The ``XCHG`` operation atomically exchanges ``src`` with the value
 addressed by ``dst + offset``.
@@ -721,6 +724,14 @@ The ``CMPXCHG`` operation atomically compares the value addressed by
 value that was at ``dst + offset`` before the operation is zero-extended
 and loaded back to ``R0``.
 
+The ``LOAD_ACQ`` and ``STORE_REL`` operations allow using lighter load and
+store memory barriers rather than full barriers. The corresponding accesses
+must be aligned, but are allowed for any access size (8-bit up to 64-bit
+operations), with 8-bit and 16-bit ``LOAD_ACQ`` loaded values being
+zero-extended. As atomics are encoded as stores, the meaning of dst and src
+are different for ``LOAD_ACQ``, effectively using src as memory based
+pointer and dst as destination register for the fetched value.
+
 64-bit immediate instructions
 -----------------------------
 

---
base-commit: ceeb3aa37bff895116944acf4347fcded0b7692d
change-id: 20260520-bpf-insn-doc-756b369ca328

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

