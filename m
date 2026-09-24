Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF61DED42
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219503; cv=none; b=jdcwhjL/QZpsrs1XxECdUPmkejqKRb2FMPMfOp7bHX8fBo/Ce57wqJrvxOyeLY1violg1SrQBjwEn9wGwtPuwgBZWxe68hRjMI3NxTwWAsQub733uPU/2cUM3izuhqpkM2bOimRrQH2OdZOfpADqKVeE1WmENIaF5p+pESdOAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219503; c=relaxed/simple;
	bh=jDuxo9p45UG5l2j/omt8SDfeB1GEL54Q0bTA02JrhWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6XDbu0AvcROzDjk1nQnqEkK1s8DYgqPi5/jMKfYe+ttm6uKGuUc43hPjUWfnjkxzySFOnDt2isjNdi/mbwVMA91Rfmqnwz1hMDeyHsc9K+oEZS774vAw1hAPSBj+AYnJWwZQSub+4Boeh1FmgREH4xHMRF7Imgpks+L/13Fbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKNc0PRv; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKNc0PRv"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso1290364a91.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219502; x=1790824302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C1F/Fg1DEnX/Jhwif3DI8WB35hab/X9a8zycCi8fVr4=;
        b=kKNc0PRvh9Crjcf9Wu94oH5lYgwWiT+TM/PwU0aYQ92DgQRPvIZiH5+tZc5YFsz+EZ
         7OyA9m0TvOb8xEvJbhWZe04tLM1xYAyzRTt2eIPec/zAQMGls9bQGY+D+ZcGebhF9k2I
         hp5y+HxNWZG1T7RFbueGrHXsKLXsksvfE6an/50xE4gLfOjVQ+bMD11uhTsT44EKmTlf
         eIzPz8p4LlA26tXcmCfsbCZXzggXmAUfADOO48URXCTpA2pG9C995P476EVG9Xe15+63
         vBEHEM3DxYSYeXEiutVOLtGz1xg/d9LzLOfZGWWPnR4x2b34dZJlVB4V+RpPZ5Ge0gB7
         EWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219502; x=1790824302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C1F/Fg1DEnX/Jhwif3DI8WB35hab/X9a8zycCi8fVr4=;
        b=TGi9d7yJHMR2qNFpFaFMCVxo0yZGHpxg/iBxIGedi11IERkJM6nYW/brOLHbfaETzx
         haaVAxXRobmAx/50gwevp0IZsEEhb1/PHx1N6esuc0Eo5zvL3YcfcCQvdK0e22jg2HLc
         +IMlvXq5sV3Dubz+jU1akIi+A8byrn//GQ0Aze84m4Fw2KKtBNQAgEn6QhvOQGDi/5MW
         /K7wOZbBpM+auqbMCJpORDz6pEuBZnbV6b1XYrl2kDnMAPjmcQvZMEN0t5fJofG/Jx7m
         nDfABXpSECymVx6Fvh+FBqJer2mYDboCvnlPg2MP0oyJQ6fdzcTBNWx7S1K0fxd7d6aN
         uRsA==
X-Gm-Message-State: AFuF++mi2JvMXrR64vvUgl1Cfwx8PGAM/ZK1tkPliMLHEoePcDoxBiYE
	VL2HXK36WHbTmAcpb4KAn0CvMhMqUUBZB1h2zQICP6KeR7As4k+OvgFRjnF91w==
X-Gm-Gg: AYBFou0DdqcVDWWFCi81RPf+5FijJUK4pV/DewmXdDLGb7P8nAb40SoAlH2s6hm4qzp
	EsUt51erFBlGpep+iLAllntePvtZpUEn/CtO3zdkQrBD6MBKjpdamYxsQ3g9PKWKm51e0m9RS3P
	L6khA4VslLfnNM35onlTsAWs1Tu7MHQybL2zmODnzUDsPrs0Mhw6tgvZ/iozTWZIkp7HbUatEq1
	zZ7EJnYQpWMtHOmsLMe2A9pC4Qb+3dZKnVzgxH8UnxTeeuESnWO3ZYcu59hpZz45E1zxDpadhcc
	C2YtR3AHXIK2macPJqwTXBrHw98e6dBm52qWpFwYuCSS8MBsnkPZksGhK3B4WNHiXbcy4wnsjrX
	EBBle+N34Yb1IGagGr8SsFqCAhr4MPybrwPYG8ZaOR+3QvjavWeNuQyK9QF76xAzjikKehgn4Nh
	Ow6+vGXbAqdKlm5qekCYlekTGhVmj78PCYjcVoPdnmuhtD/CzRdTzU64TbQl/5QQBTnStL0TFIp
	KT95R3i2bcChxQm5b4yHBiEyB7TsfR62cq3KbI0gjgsjcUgiZaFlyYNMN5tTsd5OcnJkXpIbpQz
	Efe3uGGTl2cN2tcbSzQKx288lsnDFLgFjOCt+B/X7DCtz+Vi+DjKDQ==
X-Received: by 2002:a17:90b:2751:b0:39e:5c8a:33b0 with SMTP id 98e67ed59e1d1-3a098fe8b26mr818929a91.33.1790219501649;
        Wed, 23 Sep 2026 20:11:41 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972b11d4sm2120866a91.4.2026.09.23.20.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:11:41 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 17/17] bpf, docs: Document callx instruction
Date: Thu, 24 Sep 2026 03:10:42 +0000
Message-ID: <20260924031042.1690890-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
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

