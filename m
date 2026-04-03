Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE5D1FE47B
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775234462; cv=none; b=efhplu8Yznpg1ht3hwovFmOFXlhlovEJlvkfxRlhFwofMKrZacnc2Plearvdl5bE58EChZwlI5hwN7idlOFou+lp+Y3lHE3uQ7TVqJoeGHHZ3YTsooLzxnQQBxEjWO6D2cRHIhZyfWL/ea3jG11LITNUHuLFSYp1dgmsA+VvBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775234462; c=relaxed/simple;
	bh=tKw6oc0xivFntlWN6zaeAIw0rRLZZUYPjDoSqRwXrbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euLdsFZ/JHDavBeWb5zkcV/buw3Ae1d5FtQ9M1isRZ2LjvLF20XspjKib8nNDK+TIxAMsMKBpjX1iIFJ9eNin60eUOxUJtjREwL5QK7sCb3z95zWfr77bVEf4mSgZ2Ca6+fLe54ffjGr7g9Nm/ehE1XI/wE6YEjPZ8XuAkszV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q44rGojX; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q44rGojX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775234458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnIX/6+fJ7h1Gc5rzhC1zZpifeSHj4XUmq1X/gZ3+7g=;
	b=Q44rGojX4SAZDMbYHzNZdXY3f4q8aWRHkc2W8OWmZFYHCWT1ocb/ml0cMCQMFDDa5Nh/gT
	QvKZREYAwQD/FERaZpFEodgQDah29MZ7gwh95HLvwde0MflHkpdlJJAD3WaVod1PLlHkpe
	bRolUnuASYhkh5IW6RSm9MqSHZrA7pE=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: bpf@gcc.gnu.org,
	jose.marchesi@oracle.com,
	ast@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH v3 2/2] bpf, doc: Improve MOV/MOVSX documentation and add examples
Date: Fri,  3 Apr 2026 09:40:40 -0700
Message-ID: <20260403164040.73269-3-vineet.gupta@linux.dev>
In-Reply-To: <20260403164040.73269-1-vineet.gupta@linux.dev>
References: <20260403164040.73269-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

 - Add missing form {MOV, K, ALU}.

 - Add some assembly (pseudo-C) snippets.

 - Rearrange: MOV content comes before MOVSX.

 - MOVSX content itself rearranged: canonical sign extension variant
   for {8,16,32}-> 64 moved ahead of the special variant which only
   sign extends to 32 and zeroes out the upper bits.

 - Remove the hyphen '-' in "sign-extension" to make grep hit all
   instances with one pattern.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
Changes since v2:
 - Fixed RST markup for asm example "w5 = w9"
 - Added asm example "w5 = (s8)w9" for {MOVSX, X, ALU}
---
 .../bpf/standardization/instruction-set.rst   | 49 +++++++++++++++----
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 96181565906f..863a0cc22a75 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -414,25 +414,54 @@ etc. This specification requires that signed modulo MUST use truncated division
 
    a % n = a - n * trunc(a / n)
 
-The ``MOVSX`` instruction does a move operation with sign extension.
-``{MOVSX, X, ALU}`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into
-32-bit operands, and zeroes the remaining upper 32 bits.
-``{MOVSX, X, ALU64}`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
-operands into 64-bit operands.  Unlike other arithmetic instructions,
-``MOVSX`` is only defined for register source operands (``X``).
+For move operations, the ``MOV`` instruction has a few different forms.
+
+``{MOV, X, ALU64}`` means::
+
+  dst = src
+
+e.g. ``r1 = r2``
 
 ``{MOV, K, ALU64}`` means::
 
   dst = (s64)imm
 
-``{MOV, X, ALU}`` means::
+e.g. ``r1 = -4``
+     ``r5 = 9282009``
+
+``{MOV, K, ALU}`` means::
+
+  dst = (u32)imm
+
+e.g. ``w1 = -4``
+     ``w5 = 7302004``
+
+``{MOV, X, ALU}`` has zero extension semantics (upper 32 bits are zeroed)::
 
   dst = (u32)src
 
+e.g. ``w5 = w9``
+
+The ``MOVSX`` instruction does a move operation with sign extension and has
+a couple of forms.
+
+``{MOVSX, X, ALU64}`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
+operands into 64-bit operands.
+
+e.g. ``r1 = (s8)r2``
+
+The ``{MOVSX, X, ALU}`` form has slightly different semantics: it
+:term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into
+32-bit operands, and zeroes the remaining upper 32 bits (similar to ``MOV``).
+
 ``{MOVSX, X, ALU}`` with 'offset' 8 means::
 
   dst = (u32)(s32)(s8)src
 
+e.g. ``w5 = (s8)w9``
+
+Unlike other arithmetic instructions,
+``MOVSX`` is only defined for register source operands (``X``).
 
 The ``NEG`` instruction is only defined when the source bit is clear
 (``K``).
@@ -605,7 +634,7 @@ For load and store instructions (``LD``, ``LDX``, ``ST``, and ``STX``), the
     ABS            1      legacy BPF packet access (absolute)   `Legacy BPF Packet access instructions`_
     IND            2      legacy BPF packet access (indirect)   `Legacy BPF Packet access instructions`_
     MEM            3      regular load and store operations     `Regular load and store operations`_
-    MEMSX          4      sign-extension load operations        `Sign-extension load operations`_
+    MEMSX          4      sign extension load operations        `Sign extension load operations`_
     ATOMIC         6      atomic operations                     `Atomic operations`_
     =============  =====  ====================================  =============
 
@@ -649,10 +678,10 @@ instructions that transfer data between a register and memory.
 Where '<size>' is one of: ``B``, ``H``, ``W``, or ``DW``, and
 'unsigned size' is one of: u8, u16, u32, or u64.
 
-Sign-extension load operations
+Sign extension load operations
 ------------------------------
 
-The ``MEMSX`` mode modifier is used to encode :term:`sign-extension<Sign Extend>` load
+The ``MEMSX`` mode modifier is used to encode :term:`sign extension<Sign Extend>` load
 instructions that transfer data between a register and memory.
 
 ``{MEMSX, <size>, LDX}`` means::
-- 
2.53.0

