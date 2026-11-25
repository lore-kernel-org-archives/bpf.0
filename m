Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587384;
	b=bsxYrgv1Zagg4Q6noh81Q9IQ/m+5T25Lkhu8eGhaF5DOVn5KfTz3JoY6hj0C3vIZZIns
	 vW4GhgCXMGusATbfyMHEtfhDyEOK/oEQWLdEyN60wlr/j6K9ZJarYgCV9mkW2Z2Vm9Iig
	 eROT5fk6XSAArZ7ccco3VJf6ER8PLszFPf4GrlIyHqN+EYLsMcaEYj6/x+VGpPmSqxD5b
	 gqzGp8PJKKEJrubUMYNnuhSAa/G+E3Eskov3UC7alVW8WNzWYZud/rIioSqMIqA5zxEjH
	 VlQsTMBSs8iSoBNIBHEH0ctCv8msqUrFGZX7k7L9WOin2oQrs1yYM+wNWfq0kzlv5Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8IYxPCQoD7cmdiQr4ia+kH+yRcXKtjpnJvYpxZTFR9g=;
	b=dlymc3ao4glzWyS146WQMdiRo223FfnVpMhOwU31jN/T8A5nqarfshc8Btfu9vevJxlP
	 U6w7tBj9rMdN6IjECJ/+Qa8o9ODAtV69RLAcMq9dUj64xpQpqXAedXZ00IYevboWJbpJd
	 HM3af2fknz4RspxHC3KgP93I5f/HPJKZrEExDO+Eq4og+RaIJGQ9d+4QfMQLVjd3ZC29v
	 HjCUZC+JdykW5hhS8tnBoEmVmKzm5mp5x64HH8D4qCCmJmTgbG7Saahlt2CNWNu2itdi1
	 2LWMkwsu+hYItbgmnu7LFaBxx3hDVrRdvFJzGkGQM4a71aPKJkZdwz8gjeAiYWg4Rjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y2V8nA2f;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40CF60A6F6A
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F40CF60A6F6A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y2V8nA2f
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-386a0f79047so5633726eec.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587383; x=1796192183; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8IYxPCQoD7cmdiQr4ia+kH+yRcXKtjpnJvYpxZTFR9g=;
        b=Y2V8nA2ffutoi+r2jF8rX+fCyb/bIC2jJEz/osEvIZf7kV69rVMgrWq4qHlDTUTh96
         UxGNQqHnfG7PJMTr1DZqUUFvAGuVce0+GfD6J/0oq/XSeiJ2ZLfNx7KWsCFuO8pZOiZu
         dJDOfIoXt6snvKHnUqAwblWEZndvROGPo5Gz7B0KmjCGKFHXb1/tuZEcfojG9g4mHpMo
         DJnJtsJPBA8kfPrxpf7YEL7y55ge6yKjYSy5ikAS22rIIz+FEJVNz7c+W9+n9p0GUMTU
         2FEL6+kEqplNwPAgXRgfW/WTHL7VXZ4qoo+KmIgaA7vfOLbQBaCbf0bAwxVlOr4nsgRL
         5lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587383; x=1796192183;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8IYxPCQoD7cmdiQr4ia+kH+yRcXKtjpnJvYpxZTFR9g=;
        b=oR7yH9PuWJiaE+smUmdSynjvWUpyS+mD7a9DgMq/ss4lgx0EqqXp76noYa9I0zAnMv
         FfWH/prn8YjMfSf5snfv+lHlGUGWOJucPRESl5apiS/ySKn4rLV/LUcLbsNXFgqTR+VU
         lB8vNOZw3IoGVjDfAmq8EVAbhG4piUUrpRq9pYbAaZdHLkT7vu7e3mxCR+GeWf7JwXsO
         uiDM1oiNjdomI1iXfCgd8fHLGWXoeA8aSJ5HVkS56+sFCEdGkBAfEj44hmd/GFGe6Ner
         3dmiDx82x61vciIfxP8169G01B/k+AKTPCkegOdS01rjGD3shS8BqnWQoh9T8lKII0iY
         ZYsg==
X-Forwarded-Encrypted: i=1; AL+hErG2rslksRa4mwj/tRG3LQE17Q1WZQICHD0F0rvYo9XziubaEjo+qFZsoOEC8/Uwcvq5HGs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UBIEYC9Q5GSGE7vkyP2BHKTdtijcOFuJ0aeyDBNHk1FfkR5hj
	6Hbj5mPzK+pLaUFsNfH9J07PmYcQZeHdEUgUw/V1MVMDarjzoxLCMXv1qa1bRPv6GrRajOhdfge
	Qy3U1N/wWTA==
X-Received: from dycmb10-n1.prod.google.com ([2002:a05:693c:20ca:10b0:386:c377:5335])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e91e:b0:384:2780:8757
 with SMTP id 5a478bee46e88-38570a3e793mr19421900eec.22.1795587382798; Tue, 24
 Nov 2026 22:16:22 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:06 -0800
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
Message-ID: <20261125061523.1540234-14-irogers@google.com>
Subject: [RFC PATCH v2 13/30] lib/Kconfig.debug: Allow LATENCYTOP and
 fault-injection filter with DWARF CFI
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

Allow CONFIG_LATENCYTOP and CONFIG_FAULT_INJECTION_STACKTRACE_FILTER to
be enabled on architectures using CONFIG_UNWINDER_DWARF_CFI with
-fomit-frame-pointer (such as arm64 and riscv).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a..650ed105860d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1893,7 +1893,7 @@ config LATENCYTOP
 	depends on DEBUG_KERNEL
 	depends on STACKTRACE_SUPPORT
 	depends on PROC_FS
-	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
+	depends on FRAME_POINTER || UNWINDER_DWARF_CFI || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	select KALLSYMS
 	select KALLSYMS_ALL
 	select STACKTRACE
@@ -2188,7 +2188,7 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	depends on FAULT_INJECTION
 	depends on (FAULT_INJECTION_DEBUG_FS || FAULT_INJECTION_CONFIGFS) && STACKTRACE_SUPPORT
 	select STACKTRACE
-	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
+	depends on FRAME_POINTER || UNWINDER_DWARF_CFI || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
-- 
2.56.1.831.g720f3f5937-goog

