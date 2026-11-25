Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587418;
	b=u9lMA6CeHY2xsRI001f+iZVah3zWV0sk70C9oCv+RsbjPEiYeIhxYtJpcYx8tg3cYtSj
	 mokXKmLlA5BXLTT7o4dC6RNBawO9MNDa5lIpvWEi8OeAtTa7DEuMbC0dcI8fEJ2xtLCtD
	 oyG7IFk4R/Jk/swfhNdj8E+wkrJL54orHGBdPMM+HqZfgD65FKZdTzulTsVyXbcX0MXeX
	 NaO3OoIwy9hDqybm2Cl5epXqbxXYIAEM9mN3Dbhd68QcSG6GJ/oOn3tJ8EesJG6TkZ1bk
	 yv+GSKynfyQnoHhlWsjPEPoDyv4Wh7vuzojrL8ulhmvi1ce6KmbrE2zPpusk5LJ/WFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=B0szZcyaY7NP1HowgKnJWSVhbM1uN8jco8rE2rfxzUA=;
	b=t6tvdzufy+liWKOkO1/z7kixvTIml87dGipITnucWdtxPHZ0CS7CA0jCTNixmGS38Ooq
	 QX+lPhklTT6SkknzqWTfun2qmIqUv7po1KoxEY6AzmKbGjKavkdjvjhGkFAILQu6nQ9ZW
	 eqHhF10NiZCvPD1yK16KufO8vkHTY3ViTfo+i/khrP4csMfJt6g/jLpiVhGEK1auP5bL+
	 x1crqa9u5GUIKe5E+QhWsJmsuysU6T+9zxaw+4mTrEpNtD7sHOIdk01vAF+nWjN+HyvbO
	 2tpIM48j4pUQBbGSdZLKEd5whYaZ30Ir42mhV4mofFnSyhnCtK3BsTX0sZr3AY6s5rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LJpTIGT8;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C7607DD83
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C1C7607DD83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LJpTIGT8
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b7614e9762so3912110b3a.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587418; x=1796192218; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0szZcyaY7NP1HowgKnJWSVhbM1uN8jco8rE2rfxzUA=;
        b=LJpTIGT83cKcxQDhhMuek4OwdgkdQKkLxYONCLmTepeyOwwiDEqpA9PI3PrOY8XcnW
         qBDwpKFXtz0XIpAR5Dq9NgplU/l2p/ADVoH7Mm5ymwO7xGNy/SpVvRtOaXSdsLLi5G25
         i79iMt6EXqwRF1s3apdVBesej5O7itpdAfaK/CheRhK+FRwAZgRLX/ob6cSskRGhwqvV
         ZWWo8Me1Ubrs4vQJqXgefYbt/X8NmL0zrd4kz2ZMiZlml0oGdd/AuWxGQnVIhh1z+uZh
         pzdWsnNoz6uGgypKUUOT4Uf8kjKdew9+9OF4Nu8IUXmfkp/lVmFql3ye6f7qmIGe1LLq
         chkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587418; x=1796192218;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B0szZcyaY7NP1HowgKnJWSVhbM1uN8jco8rE2rfxzUA=;
        b=Tzy5DNff7bJGBlAEbatZ3ZAewEkayfDBmTTLtMEryDHh9Wbz/pxNtEjcsemGEI54TA
         cuBk/OAzCsrdJ1cA9c9kIxB6BfpbL/iT58eYxwGA/v6UcE5Bm8sV5t2LxGxUrUy6u+r/
         2SamDcgCM+WHZBAjVlbevW/tDuxKB23qPW2NAGweVFduo1oV0j/d63uTxF3J3Kf43tHT
         3IpTsZ38uq9lB6IHi1BFCuEWwnPjCe/8CPmuAfsSiWQT+1erEMIznFZ0t8aBbwx2IRaw
         j+3mz3Jn3wI7kNda6QjLgKbO9PUSkvgtRE2ZPog2rnD5z/4lSOVUzdVna8DiTxtmNXvf
         zn1w==
X-Forwarded-Encrypted: i=1; AL+hErEODOA9vyhsYX9A/VQ0B2f8jtHPuPWjpAJzLLvx8oVi7bL3bE66/JZUTnjjYyabNxFy5wU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/970rm37GQ/qoXPqdD97lRH/bqY730JjK5tym16yXotO0mx1AD
	eNlQPwvvs3VWKP2l8CFyCIc6/npm3By6dSp7QHzpeNWxg1zBurIc1YEcR6oThxrIdfkkamme2j/
	W6fYI2XGeLg==
X-Received: from pgin21-n1.prod.google.com ([2002:a05:6a02:8795:10b0:cdb:932c:948b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:8095:b0:3dd:85a8:cac8
 with SMTP id adf61e73a8af0-4014c949c92mr14160775637.31.1795587417428; Tue, 24
 Nov 2026 22:16:57 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:23 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-31-irogers@google.com>
Subject: [RFC PATCH v2 30/30] MAINTAINERS: Add DWARF CFI stack unwinding entry
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a MAINTAINERS entry for Minimal DWARF CFI stack unwinding covering
the core .eh_frame / .eh_frame_hdr bytecode interpreter and KUnit tests,
the user-space PT_GNU_EH_FRAME VMA unwinder, the x86-64 DWARF CFI kernel
unwinder, the build-time .eh_frame minifier and analyzer scripts, the
standalone tools/unwind/ CFI verifier, and the deferred user-space CFI
kselftest.

Also add arch/*/include/asm/unwind_user*.h to USERSPACE STACK UNWINDING
so architectural unwind_user headers on x86, arm64, riscv, and future
ports are routed to the user-space unwinding maintainers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44540a1eb2b8..0584279d745e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9496,6 +9496,21 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/usb/dvb-usb-v2/dvb_usb*
 F:	drivers/media/usb/dvb-usb-v2/usb_urb.c
 
+DWARF CFI STACK UNWINDING
+M:	Ian Rogers <irogers@google.com>
+L:	linux-trace-kernel@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	arch/x86/kernel/unwind_dwarf.c
+F:	include/linux/unwind_dwarf_cfi.h
+F:	kernel/unwind/dwarf_cfi*.c
+F:	kernel/unwind/user_cfi.c
+F:	scripts/eh_frame_min.py
+F:	scripts/min_eh_frame.c
+F:	tools/include/linux/unwind_dwarf_cfi.h
+F:	tools/testing/selftests/perf_events/unwind_user_cfi.c
+F:	tools/unwind/
+
 DYNAMIC DEBUG
 M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
@@ -29300,6 +29315,7 @@ USERSPACE STACK UNWINDING
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
+F:	arch/*/include/asm/unwind_user*.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
 
-- 
2.56.1.831.g720f3f5937-goog

