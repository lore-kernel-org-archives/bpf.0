Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CFC3655C4
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039666; cv=none; b=pjKY3Q/74wjO9mpCXSm6ax+ImNjS56ApdDY/vsYZhrJSW2cS4AwG9Yhnmpg9dZN9YrR+MtJ1TDulSPesUsLMm8CZ4t3jpRm+l4yOGSYAjX9hPl8MQw8HtY2BP3dpRUiRsjstQGTLIgNowv6ra4MlgH6qh96im5SdHELSYHkTUr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039666; c=relaxed/simple;
	bh=jDuxo9p45UG5l2j/omt8SDfeB1GEL54Q0bTA02JrhWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qv+815zMqjXcTgpC/Q+KTptdy9T2x5/BXgWghKPMp/0imwAxP3W+AL2yxjOE5X8cAK1fAbEaLF8Z40BtMN2o1ENteDAaQx7VzDHzgZ9AWBeLbGetLIafOg9UD6mtjZ0y/sBoisX7X+0O2WdDex6qLezrAXe7GQgfprAyojc1OBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SARwuP1d; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SARwuP1d"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so3793505ad.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039664; x=1790644464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C1F/Fg1DEnX/Jhwif3DI8WB35hab/X9a8zycCi8fVr4=;
        b=SARwuP1dGO4C4qpkKSfn8js43jcHUyfTSftkIJ67fnjDeczONtnaH0NRV8mH45oUJ3
         e49Kza85pgwpaaWvcFR3fGdclSiY2WfpAW8G9n6olT5GKq5mulp0hw3H9a2/j8KGPmq3
         WDQYEBOpELM4n8fc/ZiItczbjKosHEqOJu7uaFHtJlFkRUJ38yJoVyyyvOrrC9uzNvgz
         S2djLapyiNTytuvW/S8t08fyExE2kLbgh7wVp2aIhoNhs82guLyGgtjNJniNDj87Y3PH
         dLvizYIUmaK9+bWTcTP4IuWjbfVuxNVPIWLHkGd5Nt+XShKxkNAp8kwfPL2GpXlg/bcz
         QARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039664; x=1790644464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C1F/Fg1DEnX/Jhwif3DI8WB35hab/X9a8zycCi8fVr4=;
        b=sKg6iPpZjFz6fYrCOjmhrwmfxglKgE/AbSFW+rRcinyb2qIc93sVppadCjHXnFWRKB
         tKlnyjJeRoN90syjmK3wmowRX6sa4KhCTBaqomToAEiWO59pG0QaH4OQzJSD+hl3gQBH
         G7BgilsDDpnlMdyOBU4gczUmsFR6z2IN0Cehk5ldniOE0vTS41Ubwxs/8rxf4bb8Xddj
         /A7apaUbgyTwFHv8TH2vSVDmVmDm5i0/hRmaYpiSxhv6UbnatMzuIa63Sf00TxxEPoKl
         1g4kYRF1GBid38GJgpx1DzxCwhqXSLXqCx0tdWWhyZSnO4v0MC7yvIMSjUXrR2NSfF4o
         G0zw==
X-Gm-Message-State: AFuF++lGF7WLXE17bkEPNV2JA+CX5Gz4qO+GVfC71ym498Z6DLlKf66D
	CTmzhZYhYrLluesEKRjI2KcZsER2uJ4hRjXXXNHgIO17UAYKMBeIljyeDBAcyw==
X-Gm-Gg: AYBFou2fP8ulx2NqYbnTPQO98QCkYqnCsFgFXh9kGWXiP4tufq6mDa9L7YzdvP3QsiT
	iR9p+ECf2y6WGjQ/VJh9D0uGvWdj2+PvA+MXlb6gV3+d0Hv02UW5kn2eGM43OuU9PY6b3UtIyea
	+o+fsV636KLsJhypZxaDxSOdWlaPErrljtwaSfs9pJhGfopkL1h0PwiDCZSfaauYC2BXTYhGXrH
	bReN0tizJGeUVr3fnVYXRfVsSHiBZKdABGYXeLQkVRewpWHSMv8U9uAebevZeWBgIrB84thAdFH
	FJUDAydkcYbgRryTVlYdaamCqt9g/gnxabCNVc5DWkxwmS17l33BFdc5nIu7QtsgDZeSApAQpu2
	+b4FXq6X+c7xORLww15CyCRgUsUj37yNjYqlvoGdHXxULQ0VcD/hUbHdaRG1OgrZIouWMT35enH
	VwH4sfaPlwZCiTlNCgWk8gq9krQlVv3k35MdC0Ul0J0XMIbtwRkDZXApBoTuEi0OEogO+TENRRI
	dKbR6FiPndNmQaLtugE/Qe4Y/7o6jLvth+VxqCkAKhgEgZvefIZ3p0XGs4xilxyda4j7i1bY35w
	gAfZyT2B9kU/9UcmHU0w7uQ5DnMq2Uzy9rsa273BIzvtwt+L/Ho1Pw==
X-Received: by 2002:a17:902:fdab:b0:2df:34c0:7304 with SMTP id d9443c01a7336-2df59ae486emr12716725ad.41.1790039664288;
        Mon, 21 Sep 2026 18:14:24 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d0480c4sm907055ad.60.2026.09.21.18.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:14:23 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 17/17] bpf, docs: Document callx instruction
Date: Tue, 22 Sep 2026 01:13:23 +0000
Message-ID: <20260922011323.1298619-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Document callx: what it does, where the callee address comes from and
what is not supported.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/clang-notes.rst |  7 +++++--
 Documentation/bpf/linux-notes.rst | 31 +++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/Documentation/bpf/clang-notes.rst b/Documentation/bpf/clang-notes.rst
index 2c872a1ee08e..3ccc7b09d19e 100644
--- a/Documentation/bpf/clang-notes.rst
+++ b/Documentation/bpf/clang-notes.rst
@@ -23,8 +23,11 @@ For CPU versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU`` support
 Jump instructions
 =================
 
-If ``-O0`` is used, Clang will generate the ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d)
-instruction, which is not supported by the Linux kernel verifier.
+Clang generates the ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d) instruction for calls
+through a function pointer. The Linux kernel verifier accepts it only when it
+can prove that the register holds the address of a static BPF function, see
+Documentation/bpf/linux-notes.rst. If ``-O0`` is used, Clang will generate this
+instruction for helper calls as well, which is not supported.
 
 Atomic operations
 =================
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 00d2693de025..6c036b54a29f 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -15,10 +15,33 @@ Byte swap instructions
 Jump instructions
 =================
 
-``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function
-integer would be read from a specified register, is not currently supported
-by the verifier.  Any programs with this instruction will fail to load
-until such support is added.
+``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), ``callx dst``, performs an indirect
+call of a BPF function whose address is held in the ``dst`` register. The
+``src``, ``offset`` and ``imm`` fields are reserved and must be zero.
+
+The address of a BPF function gets into a register in one of two ways:
+
+* it is loaded by a 64-bit immediate instruction with ``src`` =
+  ``BPF_PSEUDO_FUNC``;
+* it is read, with a 64-bit load, from a frozen read-only array map, that no
+  other program uses, that holds its read-only data: tables of functions,
+  structures of operations, vtables, where pointers to functions may be mixed
+  with other data. In the map a pointer to a function is the offset in bytes
+  of its first instruction in the program, and that is how the verifier
+  recognizes it. It is replaced with the address of the function when
+  the program is loaded. The program reads it from there, which requires
+  ``CAP_PERFMON``.
+
+In both cases only static functions can be referenced. Therefore all functions
+that can be called indirectly are known to the verifier before it starts to
+analyze the program, and ``callx`` is verified as a direct call of every
+function that ``dst`` may point to at that instruction. The same rules apply:
+the calls can not be recursive, and the depth of the call chain and its
+combined stack size are limited.
+
+Calling helper or kernel functions through a register, indirect calls of global
+functions, and tail calls in functions that are called via ``callx`` are not
+supported. ``callx`` requires the BPF JIT.
 
 Maps
 ====
-- 
2.55.0

