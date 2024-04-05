Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA116FF4C
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332372; cv=none; b=bblOp3sH/He6aKMQvXuBMgX3PFGTgoiuAJs6amaw2N/uzjLxqV5JX85zoM4PhUfnP67jrZwkgYWwrTFkJmgrxCvm4hfbGE6iVLa7+VNhsgKWuymlTnW5z9m+zLmTkmNTGCqEYHQ4mfJLw5KYpg1Ac3mxOnentbj0gE7mQXsMYdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332372; c=relaxed/simple;
	bh=VWShO/fEBRbYQAgd0hnI7ckt1738Pc0A7lZmFmFKAf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ttRwvVgsVLHZFqVmhZp7QMmm/jkF3sXeD8PiCxr7y+vFw3VsIA778KNkwmhnP7tKjIsk/7Xi5/HR5MPDTU2vWJJx2IqAX3e68RFNnzLvUtX0HGLhHzAEmzKJO12qUpnUhN1DREB6r+D1KZ4MBqI7GTMcjB062hD/7daM8FZ6uvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dWyBrvl3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dWyBrvl3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e2b137d666so16135105ad.2
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1712332369; x=1712937169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jY4DB6Tl38BcsowRx3d0Ak3cd2CvCvVL/qOushzzJ5o=;
        b=dWyBrvl39H4VEMjz0D2AnZGWcn/f44JdW7bmeO06Bp003hkLL28ICCqYzx4VP03gXs
         /GjI4MKpFdsRQZEZr3xiGoin3s/39z4IASnraQV1nHt77sVj/dxhuplBgOhlp1OEVqng
         Odk4FW9rzOMUE0wo0lM2hfwd7GCiMPjXvVJ3lith4HHdTKklDnUio77436Oe4j/u2wfp
         suPfD23QJtqHoQa2I2zR3KmbxNJzjEuAlwDH5/eqFGqJ7PAvKN/vU4KYFwIGIe45HKQP
         6/db4HvZLXFUxc7A9iAsPAs1xpl+rOCb2BdhQFpyjJA5goUI0j2rVp2OAzZ5fDBAJseX
         Kx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712332369; x=1712937169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jY4DB6Tl38BcsowRx3d0Ak3cd2CvCvVL/qOushzzJ5o=;
        b=FO7mr0sC2mbG5rmry1OYBfg78892Y7VTvExEEfQd233PsIUWWZ1KSm8tgJPg7iD+sy
         atOsz7EnTw/FXQ1gYEr0O+1R6B9TGjDWYZ3sCQP1gX1vzmrmQb/K/D6fQpXO1p+X5cyh
         pILRoEb4o2DylpXTm0ALEx63Pfu6sAgXt2pmDzLy8LZJEBZE2r3fXx1uTqTla0fWoJ1T
         I+biGG7ZZk73abUsnVn4a3Fz+hniK07u7swCilGJuf5EtjkbmJvQGGBl/ZiEZ7q1eVgW
         XeKfXyNbTehbI/e7Y2Iz1Qa5zYSJy0jlysAIjvuS3or1ac7+E4G3Plz2kzTOIL3ivVaA
         EiTQ==
X-Gm-Message-State: AOJu0YwCvvrwTUHc85MzeKJHvPfa7Zrx//dkivZMiiI+gwpJfRJha4iP
	wYdKiigvL590q7Dm/8vUCZkbiN6jUGOefjG+4tPs1iqwBWACLRaGFV/U29ayIVU=
X-Google-Smtp-Source: AGHT+IGAr+ytNdXHcCw0xIyQXqmJHCeDF83mcFZxG/0mJhcsrN6mVbxJUR0TG/XIrQqF4XsX1jcB0A==
X-Received: by 2002:a17:902:dac9:b0:1e3:cfc5:589c with SMTP id q9-20020a170902dac900b001e3cfc5589cmr560081plx.28.1712332369278;
        Fri, 05 Apr 2024 08:52:49 -0700 (PDT)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b001e2a761bfddsm1717145plg.268.2024.04.05.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:52:48 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Editorial nits in instruction-set.rst
Date: Fri,  5 Apr 2024 08:52:45 -0700
Message-Id: <20240405155245.3618-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

