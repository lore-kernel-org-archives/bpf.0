Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8711B47B410
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062956; cv=none; b=mQCa+eKwEi+Zk1hlLdD4K19t/hY1Ww0qtA7tm/w52a3BDMn+juqTWBSWIW8Pj2CeNLirHb2bErnwmLX97O8XHxfsjsPDK6rnU1bbfHIxxcZ3mlknjVVRfC3CtYwOKVKJwrFgSuNj+xas4A8T5IUBusoiXUaf8jVefiGNPt+kep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062956; c=relaxed/simple;
	bh=M2tR9aC9kmQvQuWSxUEUwl0CGDjpKVaBKYee6gkeVUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNiviRrcFFiA8w+Dtc4XUP6DjDtiznL7ii3bFTH/j0gt5W7+ye6ng+dmEHDJd9iVvG6X9fXsxb61xMcyeJGQE3O9A+KRyK/SZI/ZvosfY5KubmOF68/yJpkfrbjmGzFoTOK2jGiylcUC/EMHacw/PODWvaQ24mlQCBNV3x0Ys3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AoBQuaw0; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AoBQuaw0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775062952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8QhmTGSa5Aa/fUb2FKnBR8mMCdn5SdQqaFfXWy8lso=;
	b=AoBQuaw0La5qD8I/XtviNTe0W6ZHTg58fxHfQYi5zqGRCIScZ9IHbg43IkuCk3Zhx/X8wg
	r1dQqTMQHZPaTN6u+XnVRDyYxargdNlQEDBN+e15v7x6PJzgwrtKgdQfafv3yRgCY63eXl
	CBXyVPWhA9vufIH7e8DbTafuXBiooKY=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: bpf@gcc.gnu.org,
	jose.marchesi@oracle.com,
	ast@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH 2/2] bpf, doc: Improve MOV* documentation ...
Date: Wed,  1 Apr 2026 10:01:15 -0700
Message-ID: <20260401170115.495836-3-vineet.gupta@linux.dev>
In-Reply-To: <20260401170115.495836-1-vineet.gupta@linux.dev>
References: <20260401170115.495836-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

 - Added some assembly (pseudo-C) snippets.

 - Rearrange: MOV content comes before MOVSX.

 - MOVSX content itself rearranged: canonical sign extension variant
   for {8,16,32}-> 64 moved ahead of the special variant which only
   sign extends to 32 and zeroes out the upper bits.

 - Remove the hyphen '-' in "sign-extension" to make grep hit all
   instances with one pattern.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 .../bpf/standardization/instruction-set.rst   | 33 +++++++++++++------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index fd688c5d3f04..ac61d3be7af2 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -414,25 +414,38 @@ etc. This specification requires that signed modulo MUST use truncated division
 
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
+  dst = src  (e.g. r1 = r2)
 
 ``{MOV, K, ALU64}`` means::
 
   dst = (s64)imm
 
-``{MOV, X, ALU}`` means::
+e.g. r1 = -4; r5 = 9282009
+
+``{MOV, X, ALU}`` has zero extension semantics (upper 32 bits are zeroed)::
 
   dst = (u32)src
 
+e.g. w5 = w9
+
+The ``MOVSX`` instruction does a move operation with sign extension.
+``{MOVSX, X, ALU64}`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
+operands into 64-bit operands.
+
+The ``{MOVSX, X, ALU}`` form has slightly different semantics: it
+:term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into
+32-bit operands, and zeroes the remaining upper 32 bits (similar to ``MOV``).
+
 ``{MOVSX, X, ALU}`` with 'offset' 8 means::
 
   dst = (u32)(s32)(s8)src
 
+Unlike other arithmetic instructions,
+``MOVSX`` is only defined for register source operands (``X``).
 
 The ``NEG`` instruction is only defined when the source bit is clear
 (``K``).
@@ -605,7 +618,7 @@ For load and store instructions (``LD``, ``LDX``, ``ST``, and ``STX``), the
     ABS            1      legacy BPF packet access (absolute)   `Legacy BPF Packet access instructions`_
     IND            2      legacy BPF packet access (indirect)   `Legacy BPF Packet access instructions`_
     MEM            3      regular load and store operations     `Regular load and store operations`_
-    MEMSX          4      sign-extension load operations        `Sign-extension load operations`_
+    MEMSX          4      sign extension load operations        `Sign extension load operations`_
     ATOMIC         6      atomic operations                     `Atomic operations`_
     =============  =====  ====================================  =============
 
@@ -649,10 +662,10 @@ instructions that transfer data between a register and memory.
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

