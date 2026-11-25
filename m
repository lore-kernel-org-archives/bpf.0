Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587374;
	b=SvBsPUjvc7qrHopJNsEBpCyzT6Tt6rWtOnsIrWCvIM+YAsUEsZCmf3nhrnIP2emGs5kR
	 Ul0BLpY/3OehqX5GsXA03ygJumV+YpyLyJnPVA/An6S2zsYpueXY52+W9FRiUgFZONgFx
	 U9NoQMsSibscdweyAbVNjLRuVPn8Vsbn5QFF/02aBCziEAK2w7lMXV+zfF2wlV6OoX9MM
	 5oZWVS8ylUQ9ofKTQ7KwgEzN+liBBBYqpAok3aAticmmkGb42usDLKQgRoeEMtbYWnF1B
	 GqrZksiqvElTrtE2yAUoi8NP37ySGjmNHC6e5SwCLKS1Twny8m+Xf8vFkRzBaKvTayw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+3YNbw7npHYIz6vJpu6w5t/t1EQu1XAkIQnaB2DVcXE=;
	b=0NBYezSoydEeuTBzGAJfST2SF7zhWf2pbYqfm6sTNqXIh76XDEqheD7uwnnO+e7L3+O9
	 89ENSiDF7DEIuTLv3EfMibOJZUIF+owFbgtj5guENUn8D4D1V3rqUt9thnw3VxLWjYDLt
	 13Dt38tBQ6ZARMeT116kTDn4pKLWSBaJ/sW98ei44P08yLKt/wadm3qUuUJlETrmGeith
	 cRy2oYBHogKssP/E01mYFpjt/CTAXqynMHa01dlzOJcjdgS/ZoYN0rYikkcSHoBjI64Mf
	 C45iWSlHSEW3J3FTYVcs2Tlp92EI7vEpvogFc6PngS3QxcsQIsOHBa0ChZXc4X+3WCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iLdYEq6j;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114B760A263D
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 114B760A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iLdYEq6j
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386c3309469so1559987eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587373; x=1796192173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3YNbw7npHYIz6vJpu6w5t/t1EQu1XAkIQnaB2DVcXE=;
        b=iLdYEq6jPFG1k6lRURVTYgkpU0tn2xfKdgxbC9QNFC6g3K7bQcnhf9FCdYqi9Xo5uo
         SBN5Gv4/P2cgIp08qAw8QZoMsboROqKfZkGHPwrTxb0h0vSuGg6jqfV7Pdsi5ps2gvAH
         OdOhZYiJQTNxO6ZwFaUem9SrQ3LA7rcXlYT8RxQANhUprqB2xFBi/FVwPlL4f59N8akj
         B398DOc9rQ7NbwrKpH2N76vv0eAPJUQve1bVdW9SfzaT6L7W8lPsXM/WaRPCqvSfTtUy
         Gbw8nVhHeASvK7e1vBllLSDnJplJRmM16lY1l5+ob+71ZDXfeVq7x0A0bpDEjTwFslrT
         ATvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587373; x=1796192173;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+3YNbw7npHYIz6vJpu6w5t/t1EQu1XAkIQnaB2DVcXE=;
        b=ehtfoEH0UapSpYIFuYW/rMWPSPXMarBX2o6ZIaz3ifYWSY8K/jDsQdsfKjgvlBPPG1
         R+VjQqfb+ScPuBpuUw0BiDkWE5VgEj/5gFiSl9OQYaHPHQOdTPwfzNr1l9Jv0/iNfFoL
         jWbFNuxZ7yRKhCXfG9aCY2VNeolQh4ffvFDFAqrSmAhllkpbjeRzWkSPa03+aQS1qWwJ
         1GIUL+ZjYNTdolhulFsujE2Hn++HrBuewwfNqGWdaKyYI1VFP6q5iVwG0qbdkXCU3Nv5
         0GE996FgE2dbVPVXWWQOjo0b2cwq8BnRIAT5s/GiCm34imHoCnWP6cXa3J+G2UZv82Lx
         oS3Q==
X-Forwarded-Encrypted: i=1; AL+hErGpUi9VWtqCe9Ygw/tyZP3Wc7H5aNjYMxzId+I7sgEQFbkyBcKDOkmloq/x3VIyXEJYrs8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+N1B4B9bfHOdRRl8UhaiSbPqEfY3+JfQa1LZ2DKMI/Jy0sbIoE
	N9vnP78+1EghuHHz5/gPBkQO0Vk0CYoaQym81w0JmuKOhITLVPp7jMYfCYcKEI0/Knj+jTOH3AA
	cUU6Y5gfD0w==
X-Received: from dybou2.prod.google.com ([2002:a05:7300:e5c2:b0:384:c70c:3c65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d809:20b0:386:b070:6f1c
 with SMTP id 5a478bee46e88-386b0707151mr8742111eec.21.1795587372849; Tue, 24
 Nov 2026 22:16:12 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:01 -0800
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
Message-ID: <20261125061523.1540234-9-irogers@google.com>
Subject: [RFC PATCH v2 08/30] vmlinux.lds.h: Allow architectures to emit
 custom RO_DATA sections
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

Add an optional ARCH_RODATA_SECTIONS hook inside RO_DATA() so
architectures using runtime .eh_frame / .eh_frame_hdr kernel unwinding
can place unwind tables inside write-protected RO_DATA without leaving
them in unmapped rodata/data gap pages.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/asm-generic/vmlinux.lds.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3eb732942d69..1bde7a2a19d0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -472,6 +472,10 @@
 #endif
 #endif
 
+#ifndef ARCH_RODATA_SECTIONS
+#define ARCH_RODATA_SECTIONS
+#endif
+
 /*
  * Read only Data
  */
@@ -554,6 +558,7 @@
 	RO_EXCEPTION_TABLE						\
 	NOTES								\
 	BTF								\
+	ARCH_RODATA_SECTIONS						\
 									\
 	. = ALIGN((align));						\
 	__end_rodata = .;
-- 
2.56.1.831.g720f3f5937-goog

