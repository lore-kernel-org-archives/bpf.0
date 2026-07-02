Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23527A47F;
	Thu,  2 Jul 2026 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980796; cv=none; b=oNP0fCrT47qWtKYl3S59xBj0c7q4/sv2n+zI+dGkfDysPxMmQsecqQNpZl89HW3ACQ57hCg0GlD11Y7XZ8d+zRkgN7mJjqgMEqP0e0kd2mipGR8XiWqrfFCy+FLougRmpqXY0mZcQmjZRW0I3aq8f+eJL/kWwcS739HOaK36SDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980796; c=relaxed/simple;
	bh=Q2GpEH2X2aDsVJd2QBgwWSCP//9EvHao/aIsiWG4RBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PTJ0bwLHxjZw3pjivJZFwt65ohtorlwHG0Ccp9L05UD2TxjmZpO3ccEBBRP+Z6n+Kb58nVf2/mvmpiWimpwMdyggVYwRTiz8l0D+YL+8BOAbKT2NttVPVxtovvMYy6pcsWTG93SJ5I7jrGVrq7lJSWmzwpWOKgLV++QUZkTeEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ID4Bc5Z/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LksgL9A7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ID4Bc5Z/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LksgL9A7"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782980792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L4hkRJykr+eab8Dvtf4lhJ8zi/LQtBLjciGJU8kYhK4=;
	b=ID4Bc5Z/2kZkZq+LKAkjibOQWT+EMu+Swc71Gui0/mrliEJAzLSTfkd+RL4OB3AWdHPT9H
	3LUmeQiROCbMEg5b+35IOxftA8rAKAQvwmu/0SbVHpW7NgZ9PEDSbOfkZLeCv3ZFlQBCXM
	i+rrA6bMWHBz3qanIHdJ0XPJepBvqHi0gfuaVp0vc6E228VjPlHTX+5sxb5580xsCQlV9g
	EYUCh98ruWK9eiPXzDSDY3kekS9/ACBMS/ZBB19TjOcbCR6Dl+rUKBHGuF/QtLme4wdx7J
	lyuH5b2BEz5UZqCw9MJ3kKraK/t7qWgjrmvFcy80qPPhdwj75gzaU/Fq4+pR4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782980792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L4hkRJykr+eab8Dvtf4lhJ8zi/LQtBLjciGJU8kYhK4=;
	b=LksgL9A7fgudwKwlbpT1/JoosBH/W0dYP3meqI2dYbC1/dFgrhNUgs3fbuwQ2KrIi52hCV
	9A6MlgArx6kcfVCQ==
Date: Thu, 02 Jul 2026 10:26:30 +0200
Subject: [PATCH] tools/resolve_btfids: Include libsubcmd headers directly
 from source tree
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-libsubcmd-spam-v1-1-300ec142a62f@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0Nj3ZzMpOLSpOTcFN3igsRcXcM0U6M0gxSDZFNzSyWgpoKi1LTMCrC
 B0bG1tQDPaN5cYAAAAA==
X-Change-ID: 20260213-libsubcmd-spam-1f52f0d0c579
To: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782980791; l=2152;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Q2GpEH2X2aDsVJd2QBgwWSCP//9EvHao/aIsiWG4RBk=;
 b=0IKmozQzZwy0KsEWciAu+b6HsLs1d8wdr/vGnp2kLdoyzJd24mI5SK1hc/3qmR359H1y2zK2k
 L/lUEdKFiBAAvPHXjuHJPCTbY/6TZ3qRrS5uj/K3vAlIYHRPmiE19/s
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently each build with resolve_btfids enabled unnecessarily prints
the line 'INSTALL libsubcmd_headers' from libsubcmd.

Use the libcmd headers from source tree instead, without installation.

The same was done for objtool in commit ac999926774a ("objtool: Include
libsubcmd headers directly from source tree"), albeit for a different
reason.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Rebase on v7.2-rc1.
- Change the resolve_btfids rules instead of the libsubcmd ones
- Link to v1: https://lore.kernel.org/lkml/20260303-libsubcmd-spam-v1-1-d0749e3c7998@linutronix.de/
---
 tools/bpf/resolve_btfids/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 7672208f65e4..bb0463b380af 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -40,7 +40,6 @@ LIBBPF_DESTDIR := $(LIBBPF_OUT)
 LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
 
 SUBCMD_DESTDIR := $(SUBCMD_OUT)
-SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
 
 BINARY     := $(OUTPUT)/resolve_btfids
 BINARY_IN  := $(BINARY)-in.o
@@ -56,7 +55,7 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
 $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
 	$(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
 		    DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
-		    $(abspath $@) install_headers
+		    $(abspath $@)
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
@@ -77,7 +76,7 @@ HOSTCFLAGS_resolve_btfids += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
-          -I$(SUBCMD_INCLUDE) \
+          -I$(srctree)/tools/lib \
           $(LIBELF_FLAGS) \
           -Wall -Werror
 

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260213-libsubcmd-spam-1f52f0d0c579

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

