Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76192BE7AB
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287802; cv=none; b=cme3kyj6GZOISHZjbleeNK88NKqJWwiBg7fmAZobUih+hjT98OOHcg1awbDj3PPA21+VsohkRxqbKkcFeHyowA2RRMolHQaC9f+cNJ2aj0HLNXHXT/lDrvj0IM5ILSHYJxx/o327eCH7FceP991G6j3yel9EKSEfJbJ9XYqMutk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287802; c=relaxed/simple;
	bh=RHAKs9OGxFYI3rNTfld3tJbh+rGAuDUFivZwqZSuFmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hCtnop9N6On1YjsgnUvcy6+3o5Gg4YVcxpmvrWsj2g6sqUxXLmwl7IY0FnIvXTqBhTdJJ+qTWcTR6EP7/F8op3igIr/CzeF5+beixtJGBzESwhLR7vkv27ufUQ/0xpiWHi7vUSu4bgXia0SvV/J4FSzz+CAjZpYzHv5TprAfpG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aZAy/V/U; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aZAy/V/U"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E61471A3642;
	Wed, 20 May 2026 14:36:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B180560019;
	Wed, 20 May 2026 14:36:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46FCB107EA209;
	Wed, 20 May 2026 16:36:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779287788; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=jdt8tHz+qF7hLZ7fl9e5TxL4zWnt+ACbt2uON1wGzgs=;
	b=aZAy/V/UkbKD6Yp/TQJFjz6OCBGwe8BZ//R6XLDu0D8QQTzN8ZNYFXBhzxP1TU2HjfPmyy
	vdsAMzRBDh5nH55471imk+dCLt8iC9cByHkBEnIkrtBnVi5afZcsSGafc4eBWukDof9T5y
	nYFUdDW7STP5uq/EwS7Ai1csEecGMJtIY7DspKsi2xltwRb4SWv6wIYAZxreEysso6Ypnq
	hobs7mnCA1mUXj+HDjDg2UbWXKqsnOtpozGYPDd616m7DoYhGlAC+deWghyeM+ho7NIuO2
	4yHa1XscLrggfleAt6QdidjUspjCZHw3XGWmC2VUdY+idR+kJb388zHKpoqacw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 20 May 2026 16:36:19 +0200
Subject: [PATCH bpf-next] bpf, docs: add LOAD_AQCUIRE and STORE_RELEASE
 instructions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-bpf-insn-doc-v1-1-74d7dada9bfc@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw6DMAwFr4LeupbSINLPVaouSDCtuzAopggJc
 XdCuxy9N7PCOAsb7tWKzLOYDFrgfKqQ3q2+mKQrDO98cI13FMeeRE2pGxJdmhDrcEtt7a8oypi
 5l+WXe+B4Ki8Tnv/FvvHDaTpq2LYdBIOXnnoAAAA=
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
 .../bpf/standardization/instruction-set.rst         | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 39c74611752b..4f10bcd03150 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -695,22 +695,24 @@ arithmetic operations in the 'imm' field to encode the atomic operation:
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
@@ -721,6 +723,11 @@ The ``CMPXCHG`` operation atomically compares the value addressed by
 value that was at ``dst + offset`` before the operation is zero-extended
 and loaded back to ``R0``.
 
+The ``LOAD_ACQ`` and ``STORE_REL`` operations implement lighter LOAD and
+STORE memory barriers than full barriers. The corresponding accesses must
+be aligned, but are allowed for any access size (8-bit up to 64-bit
+operations).
+
 64-bit immediate instructions
 -----------------------------
 

---
base-commit: ceeb3aa37bff895116944acf4347fcded0b7692d
change-id: 20260520-bpf-insn-doc-756b369ca328

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

