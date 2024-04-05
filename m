Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748FA16FF4C
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332378; cv=none; b=VXZVVIlm/qvcW3VeZZDyLinHKctCIRzyIFYK9guS80RN//DZUVc4uI6DI1E1tqveGk2sPuGLhuDItyOT6uOSp/9hth6YXhTNygmWmoj1yvAybUl2PyLEKmuMWlp1obJ5x4ki+vWbB/ceNGzSPL/JPC8NWIgFO5t3azxUbCB6Rrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332378; c=relaxed/simple;
	bh=HHJwWIAbG7vxTBASZ2fIwJ7mtAJjOkwmdSdSuWy4YOE=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=tlwmhb/zAOUyJRU4bKf6rjBkB7vbmPYR6H3Xz5O70YACQmKRSAJFtdlT8tgDY6k+iRc3oBEP+eihvccuAr0iFWUbYYiax0j3LW4sKx0gvojpFSdMmHcticmWwphvLLcAL5hvUTIavCUNph6/fcjcyYUbTOp1UuhiIPDiSqYPm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=zST1fKFc; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=bHKpKyS1 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mUmRIdER reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="zST1fKFc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="bHKpKyS1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mUmRIdER"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id F0CB6C16942F
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712332375; bh=HHJwWIAbG7vxTBASZ2fIwJ7mtAJjOkwmdSdSuWy4YOE=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zST1fKFchYBWF/KdcRr2rRDElCDwKX9ZEDp/3GvsBuvL86LPH350NKCfDbmVsRH2G
	 awx30oPUCyi6xnigp6lpEI+u7gWKgT0ft5XNIUD3IrdYcfKKedVA6/4Hbj9oJQBrgZ
	 1E9rTUH5OFBFvbcBQO6wyvTTUY3s4seWBUe4tFUs=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id BE732C169401;
 Fri,  5 Apr 2024 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1712332375; bh=HHJwWIAbG7vxTBASZ2fIwJ7mtAJjOkwmdSdSuWy4YOE=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=bHKpKyS1aBgmkWBcBMdUTSgye57lm9ZsSv9KprELWcnBAjyxZITDwruVWjd9LQk6A
 pW3LkRFn+At9FZsq6MxsTdph/Q1chWEhVEHCIxrLBQt5qfNjlcE3RbpgOk85sXxOu0
 3F9fEdZXqpBibjADo0ZDh4toZC3heQhBRhDTvAgU=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2684BC169401
 for <bpf@ietfa.amsl.com>; Fri,  5 Apr 2024 08:52:54 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2GND67e3phpm for <bpf@ietfa.amsl.com>;
 Fri,  5 Apr 2024 08:52:50 -0700 (PDT)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 55A23C1654F3
 for <bpf@ietf.org>; Fri,  5 Apr 2024 08:52:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e2178b2cf2so21113815ad.0
 for <bpf@ietf.org>; Fri, 05 Apr 2024 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1712332369; x=1712937169; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jY4DB6Tl38BcsowRx3d0Ak3cd2CvCvVL/qOushzzJ5o=;
 b=mUmRIdERXWyK3mEOqWOF2yfCTTg84Ka1vOcNJcg/7wJFnjKhyeL24wGXXTez3Ds+YU
 x0rEkrwyEvAVQJIi0CfrgfN3XJw7E5EaLj1QpGmSBXXyWc4qYpUCropuw583Rie0Tv6a
 /qEURC2CV9O8s8lDk2T+uLsdJ78E/pFstWLEOQZ5xtXwtvYIoL2eb50ta6UZI64/Mwzy
 HsyDXoOhpbwdVzOnibvMbNzlkZ9IGPw/gDmYyhjCGnTPZ37nnFbA4gXCIbwFXYG8SVDC
 pl0ASyYab4Q7yQPltd+TA497EYRvlV4gY0BFrXcZC+nY14+zkXyIAcMmmxx0FphrOX7J
 QDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712332369; x=1712937169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jY4DB6Tl38BcsowRx3d0Ak3cd2CvCvVL/qOushzzJ5o=;
 b=Rk0UAn5ayJfa2cl2AP/FoQ2pZ/Twr2q5MfUvpK5h5UCg7ryWR79yponA9sdvZGuvux
 35iwxCECsNDeJyJff4Q22Pi5eBWXydZJRZ9lrSe/z9x2kzlIfbSXZOUPI03jV7D20/do
 mVT2b0tQIbQDdvjCM05uIUk6vIM8RcQ1RX1inqptk4oo8Vm1cltObyP3ZUZEsg9mSkjd
 MgO2T7wjtBHsUPdCIpzKHabNI+VWYRLJ0ATnjBN5Yd3GjTBD4cwrRENCCQKMnC+SYgmd
 K/fnun7kd3FiyFf4jqMNnFc1hwfZ8DC+WyS3Z40mduFuBxKVNruZdVZFhh8jxPriMxef
 pXMQ==
X-Gm-Message-State: AOJu0YxgC0WBNFnHeV7Ll4Qf185zs6rJxdSLVgH4wfVSDdqVqOq6k+GM
 REeqy1kYauT9UTssKBv9NCcUx2WFzQ+7WI6nBDGP+gyz6Vg8uWzj
X-Google-Smtp-Source: AGHT+IGAr+ytNdXHcCw0xIyQXqmJHCeDF83mcFZxG/0mJhcsrN6mVbxJUR0TG/XIrQqF4XsX1jcB0A==
X-Received: by 2002:a17:902:dac9:b0:1e3:cfc5:589c with SMTP id
 q9-20020a170902dac900b001e3cfc5589cmr560081plx.28.1712332369278; 
 Fri, 05 Apr 2024 08:52:49 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 b16-20020a170902d51000b001e2a761bfddsm1717145plg.268.2024.04.05.08.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 08:52:48 -0700 (PDT)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Fri,  5 Apr 2024 08:52:45 -0700
Message-ID: <20240405155245.3618-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/KeggnZttOEWr1jmfgo5byzmKJHU>
Subject: [Bpf] [PATCH bpf-next] bpf,
 docs: Editorial nits in instruction-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Message-ID: <20240405155245.tdslE_Lhqquxry5RHEsFNEOLtXLqtMsO0Os-CMG-BQg@z>

This patch addresses a number of editorial nits including
spelling, punctuation, grammar, and wording consistency issues
in instruction-set.rst.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 47 ++++++++++---------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index a5ab00ac0..8d0781f0b 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -43,7 +43,7 @@ a type's signedness (`S`) and bit width (`N`), respectively.
   ===== =========
 
 For example, `u32` is a type whose valid values are all the 32-bit unsigned
-numbers and `s16` is a types whose valid values are all the 16-bit signed
+numbers and `s16` is a type whose valid values are all the 16-bit signed
 numbers.
 
 Functions
@@ -108,7 +108,7 @@ conformance group means it must support all instructions in that conformance
 group.
 
 The use of named conformance groups enables interoperability between a runtime
-that executes instructions, and tools as such compilers that generate
+that executes instructions, and tools such as compilers that generate
 instructions for the runtime.  Thus, capability discovery in terms of
 conformance groups might be done manually by users or automatically by tools.
 
@@ -181,10 +181,13 @@ A basic instruction is encoded as follows::
     (`64-bit immediate instructions`_ reuse this field for other purposes)
 
   **dst_reg**
-    destination register number (0-10)
+    destination register number (0-10), unless otherwise specified
+    (future instructions might reuse this field for other purposes)
 
 **offset**
-  signed integer offset used with pointer arithmetic
+  signed integer offset used with pointer arithmetic, except where
+  otherwise specified (some arithmetic instructions reuse this field
+  for other purposes)
 
 **imm**
   signed integer immediate value
@@ -228,10 +231,12 @@ This is depicted in the following figure::
   operation to perform, encoded as explained above
 
 **regs**
-  The source and destination register numbers, encoded as explained above
+  The source and destination register numbers (unless otherwise
+  specified), encoded as explained above
 
 **offset**
-  signed integer offset used with pointer arithmetic
+  signed integer offset used with pointer arithmetic, unless
+  otherwise specified
 
 **imm**
   signed integer immediate value
@@ -342,8 +347,8 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
 
   dst = dst ^ imm
 
-Note that most instructions have instruction offset of 0. Only three instructions
-(``SDIV``, ``SMOD``, ``MOVSX``) have a non-zero offset.
+Note that most arithmetic instructions have 'offset' set to 0. Only three instructions
+(``SDIV``, ``SMOD``, ``MOVSX``) have a non-zero 'offset'.
 
 Division, multiplication, and modulo operations for ``ALU`` are part
 of the "divmul32" conformance group, and division, multiplication, and
@@ -370,10 +375,10 @@ etc. This specification requires that signed modulo use truncated division
    a % n = a - n * trunc(a / n)
 
 The ``MOVSX`` instruction does a move operation with sign extension.
-``{MOVSX, X, ALU}`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
-bit operands, and zeroes the remaining upper 32 bits.
+``{MOVSX, X, ALU}`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into
+32-bit operands, and zeroes the remaining upper 32 bits.
 ``{MOVSX, X, ALU64}`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
-operands into 64 bit operands.  Unlike other arithmetic instructions,
+operands into 64-bit operands.  Unlike other arithmetic instructions,
 ``MOVSX`` is only defined for register source operands (``X``).
 
 The ``NEG`` instruction is only defined when the source bit is clear
@@ -411,19 +416,19 @@ conformance group.
 
 Examples:
 
-``{END, TO_LE, ALU}`` with imm = 16/32/64 means::
+``{END, TO_LE, ALU}`` with 'imm' = 16/32/64 means::
 
   dst = htole16(dst)
   dst = htole32(dst)
   dst = htole64(dst)
 
-``{END, TO_BE, ALU}`` with imm = 16/32/64 means::
+``{END, TO_BE, ALU}`` with 'imm' = 16/32/64 means::
 
   dst = htobe16(dst)
   dst = htobe32(dst)
   dst = htobe64(dst)
 
-``{END, TO_LE, ALU64}`` with imm = 16/32/64 means::
+``{END, TO_LE, ALU64}`` with 'imm' = 16/32/64 means::
 
   dst = bswap16(dst)
   dst = bswap32(dst)
@@ -475,7 +480,7 @@ where 's>=' indicates a signed '>=' comparison.
 
   gotol +imm
 
-where 'imm' means the branch offset comes from insn 'imm' field.
+where 'imm' means the branch offset comes from the 'imm' field.
 
 Note that there are two flavors of ``JA`` instructions. The
 ``JMP`` class permits a 16-bit jump offset specified by the 'offset'
@@ -494,25 +499,25 @@ Helper functions are a concept whereby BPF programs can call into a
 set of function calls exposed by the underlying platform.
 
 Historically, each helper function was identified by an address
-encoded in the imm field.  The available helper functions may differ
+encoded in the 'imm' field.  The available helper functions may differ
 for each program type, but address values are unique across all program types.
 
 Platforms that support the BPF Type Format (BTF) support identifying
-a helper function by a BTF ID encoded in the imm field, where the BTF ID
+a helper function by a BTF ID encoded in the 'imm' field, where the BTF ID
 identifies the helper name and type.
 
 Program-local functions
 ~~~~~~~~~~~~~~~~~~~~~~~
 Program-local functions are functions exposed by the same BPF program as the
 caller, and are referenced by offset from the call instruction, similar to
-``JA``.  The offset is encoded in the imm field of the call instruction.
-A ``EXIT`` within the program-local function will return to the caller.
+``JA``.  The offset is encoded in the 'imm' field of the call instruction.
+An ``EXIT`` within the program-local function will return to the caller.
 
 Load and store instructions
 ===========================
 
 For load and store instructions (``LD``, ``LDX``, ``ST``, and ``STX``), the
-8-bit 'opcode' field is divided as::
+8-bit 'opcode' field is divided as follows::
 
   +-+-+-+-+-+-+-+-+
   |mode |sz |class|
@@ -580,7 +585,7 @@ instructions that transfer data between a register and memory.
 
   dst = *(signed size *) (src + offset)
 
-Where size is one of: ``B``, ``H``, or ``W``, and
+Where '<size>' is one of: ``B``, ``H``, or ``W``, and
 'signed size' is one of: s8, s16, or s32.
 
 Atomic operations
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf
