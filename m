Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7643745C;
	Thu,  9 Jul 2026 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622612; cv=none; b=fnAOOFsB5uE1K8WvjGeZXnmqngBWe9RTAXMieIV8IVO6xQuWrpkcBJG0YOHPZUUqLcuhyEQqWLw9UwJIjBlzmXNp5TslzZlJV+2fH/7RO7MBLpTBqCaPOAR6rCnnBdsjtN9hL/kxWvQNudt4cfDhfquZCWfHKPmO0eIZ0nCBHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622612; c=relaxed/simple;
	bh=sGKvpf/QolsF8B3US3BSnAcyhFALmJV0Gbk8a2lp17s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YO1mr5S53pDRkSKeUgHMoBgzNWzNPqIIgNx3AhH0PsefyxlCkiDNmIc+I7swjOq756P0tSbsoNbYwUdmEL/zn/Dvrq+12fP67cm/idpt2JHJRsudP7MGxLqod51qB6QtYc7F6T885WvGam1N2x2RucIq3gReXnzactfHImTHHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AKawgpCg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AKawgpCg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 93C6EC2F4F1;
	Thu,  9 Jul 2026 18:43:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EDA7660340;
	Thu,  9 Jul 2026 18:43:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D88511BD1CE5;
	Thu,  9 Jul 2026 20:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783622604; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ECdrYG8dwHRiuDm3ZbmP7UJ+mDiYsTvFq8PM3WBfyoY=;
	b=AKawgpCgEk+Df6j++oOru7xDW23+JIAlGdyHfTneum87ziQRuF7HQ7QMGuAcanW6KrpJI5
	d88ofjfrG9tpP190XWn/JmIKz+VNuSbdBw2z3Ei471BMIY5y8lcUWyNZJECDDrzx4D6Yl9
	0AJdqYLeaR9rlf/ddhY7aKWLj5DNtz8DvdKeuXaiqLi4KbmP6ZHrt2IrB1waqJhn9HaETa
	uBaZ8H1obUg/r/gPDPYV+20z5IENaz0V9GhMpQHI4op2FDhFfY2/0psB96l6hVgM531zbN
	gBgIwO0OCnslFCJ16e5wtNSe/oQSCd7ufDIMhGRS9sxx/6c7e9/coTN4zhrQNQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 09 Jul 2026 20:42:59 +0200
Subject: [PATCH bpf-next] selftests/bpf: remove redundant config option
 from selftests fragments
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260709-testing-fragments-v1-1-65244b0650ff@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMzQrCQAwGX6Xk7ELaQ/15FfHQbr9dIxjLJpVC6
 bu76nEYZjYyFIHRpdmo4C0mL63QHhqK90EzgkyVqeOu5yOfg8NcNIdUhvyEugVmRLTg/jQx1W4
 uSLL+nlca5xQUq9Ptb2wZH4j+XdK+fwBHM9n0fwAAAA==
X-Change-ID: 20260709-testing-fragments-00ece1e068d0
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

CONFIG_IPV6_SEG6_LWTUNNEL is currently enabled in each arch-specific
config fragment for the BPF selftests. Commit 33a971d549d8
("selftests/bpf: Add LWT encap tests for skb metadata") has enabled this
config in the generic config as well, resulting in a small warning when
configuring a kernel for selftests:

 $ cat tools/testing/selftests/bpf/{config,config.vm,config.x86_64}>.config
 $ make olddefconfig
   HOSTCC  scripts/kconfig/conf.o
   HOSTCC  scripts/kconfig/confdata.o
   HOSTLD  scripts/kconfig/conf
 config:269:warning: override: reassigning to symbol IPV6_SEG6_LWTUNNEL
 #
 # configuration written to .config
 #

Now that IPV6_SEG6_LWTUNNEL is set in the general config fragment, drop
it from the arch-specific fragments.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/config.aarch64 | 1 -
 tools/testing/selftests/bpf/config.ppc64el | 1 -
 tools/testing/selftests/bpf/config.riscv64 | 1 -
 tools/testing/selftests/bpf/config.s390x   | 1 -
 tools/testing/selftests/bpf/config.x86_64  | 1 -
 5 files changed, 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
index 7efad36ceb26..fc85257701dc 100644
--- a/tools/testing/selftests/bpf/config.aarch64
+++ b/tools/testing/selftests/bpf/config.aarch64
@@ -71,7 +71,6 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPVLAN=y
 CONFIG_JUMP_LABEL=y
 CONFIG_KERNEL_UNCOMPRESSED=y
diff --git a/tools/testing/selftests/bpf/config.ppc64el b/tools/testing/selftests/bpf/config.ppc64el
index b53afb5e0b71..5685fa4ee82b 100644
--- a/tools/testing/selftests/bpf/config.ppc64el
+++ b/tools/testing/selftests/bpf/config.ppc64el
@@ -39,7 +39,6 @@ CONFIG_INET=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_JUMP_LABEL=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_KPROBES=y
diff --git a/tools/testing/selftests/bpf/config.riscv64 b/tools/testing/selftests/bpf/config.riscv64
index 7bee24a79a71..655cb05a7689 100644
--- a/tools/testing/selftests/bpf/config.riscv64
+++ b/tools/testing/selftests/bpf/config.riscv64
@@ -30,7 +30,6 @@ CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HUGETLBFS=y
 CONFIG_INET=y
-CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_MULTIPLE_TABLES=y
diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/selftests/bpf/config.s390x
index db61878148e4..755d1cfcd9e0 100644
--- a/tools/testing/selftests/bpf/config.s390x
+++ b/tools/testing/selftests/bpf/config.s390x
@@ -56,7 +56,6 @@ CONFIG_INET=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPVLAN=y
 CONFIG_JUMP_LABEL=y
 CONFIG_KERNEL_UNCOMPRESSED=y
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index 42ad817b00ae..523e0d29bbd4 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -114,7 +114,6 @@ CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IPV6_MIP6=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_IPV6_ROUTER_PREF=y
-CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPV6_SUBTREES=y
 CONFIG_IRQ_POLL=y
 CONFIG_JUMP_LABEL=y

---
base-commit: f42b070ac285f5ef306e60e65debb58ba519659a
change-id: 20260709-testing-fragments-00ece1e068d0

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

