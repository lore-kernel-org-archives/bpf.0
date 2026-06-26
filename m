Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA63E7BD0;
	Fri, 26 Jun 2026 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478254; cv=none; b=DjQiTAijxQphDxel0veDCbGMgzIaqC/7OnoFJS4X3s2QAT3kum4g9donbs3UeUKSbo3QqjKLHWwSd9l/ss+16c9jgR/7+32wHFls1/L/AcD45YG/v4QRhSqt16l7cWG53eWsHqNn+yydPwuJU1cE/O4BnmuPaTDRYPgSBTAWKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478254; c=relaxed/simple;
	bh=l0q6pe+4+ra9uG1KKIAZ9OpYCeyHSMm3311kZUBNrPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=StkFhoVMsujrH0/PkjyiUha5UeaclGySYmH8Vt7oc89NCcpnJgt7GO2BI3YZYd/OcQNc/AypN/oGnkAI/jevWIZ5r9i7t1KcPdmcpaOLAe25ecHDE0VLxkrJzlm88kTEDQjcoyO8cHtrpfOcKv38id5lvZ1whOIRxQY8TFw3h9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KBroBgt9; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KBroBgt9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=LtrxbqCWe0nH13XGNffqCXPM8E1ZDfOsjxy+podQdIg=; b=KBroBgt9NzDIEnh3Os+T3Z3v4l
	VAsbRKJWWoRzFMV9k7q4DqMgAmnRU5Gg8Ewa80bPwzvXkL0G4nHAi7ppHmpo2Rg6NnJNAsw+XuioB
	v+Y8wj36gdCoo2SYJcePA1Em2Kg4mFHSZnT8fqVLksX0mlAx3pEky8aXmqdXeUm+hyGRl/gsIiB+f
	8S4n741HRTv/fQ9usQ3F7MQV37yZ/isxpC8/zbuEGUrccxnktH3Mfz/1WWOIDm9v7YFkQd8sEqqTe
	SlAqcjugn7ZOSKUGDPUkrPeRMS82j3y+rGP0fRSoiOL3bHs1F1Pr8fXhMa8v8h8SKk1mclF5OtslN
	95L6/aOg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd61C-003ylj-1v;
	Fri, 26 Jun 2026 12:50:50 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 05:50:13 -0700
Subject: [PATCH v7 4/9] bootconfig: clean build-time tools/bootconfig from
 make clean
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-bootconfig_using_tools-v7-4-24ab72139c29@debian.org>
References: <20260626-bootconfig_using_tools-v7-0-24ab72139c29@debian.org>
In-Reply-To: <20260626-bootconfig_using_tools-v7-0-24ab72139c29@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, 
 Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 linux-doc@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, Nicolas Schier <n.schier@fritz.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2411; i=leitao@debian.org;
 h=from:subject:message-id; bh=l0q6pe+4+ra9uG1KKIAZ9OpYCeyHSMm3311kZUBNrPA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPnWLnEEh8Ztk1opTqoJeSoOLuXU1YXsPMqfZW
 DZ2+JROBPeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj51iwAKCRA1o5Of/Hh3
 baDREACb3pBwLdms3eiPHWydByX1VcYmp1m8LlpMq+uQfMPZO/3Sb9NeSZBLFNj3t8WxU6PIln8
 bwdAJcM8gK1Fe2srx4e+/Lzop52zIuq82uBGxpq3Qdk1eltslZ/eawUvvKP4OhBKjS5g+jUWRBV
 p6xZfCYVeyTkWLofZm5lY8Ah+Lc2RnkVISMO18+Q+/s1BhHDk4jTVLkpy2eO7tkG+mLjWR+vsbr
 qFmhrRMIqidFtZVAqt5bXubDPeR9XY/0iS9QEcyEWj52nAWn7vdhYPFL83ULcoo1ST417Y3VvSj
 0/MFMTUKE3HWpF8u5y1Sn5fRcoGKWJHqJxr/EXcrEB3ruem3PcU/2Kx4xOsOuiISY213P+AGiNY
 lnEfkcREuhHcGnX1IdN0vXYV5lbRXzbPYpPSD0eRGxLwljICijXWHBVFESSEYxR2UvO/XaKxgUg
 c7mzuBk2Xj0rayYkJ95xnS+D4fo4nIiHhuomJCpeJAOCuxUP/6D7xNApCAJz5dKyAcSvVzDGUTY
 anDrALkt3QaL3koKAx4wkv4mUgKAaiJln5diJScy4StdDgS9KMhfmq6IWIb8Q7eEeWmuiEXzqOG
 K9iYzV9uIswePrOe2adt/EG/OKAKrO/f+vVtw1Q1+9y1wOf8ugmrlpToe8OV/zMhkKzCL7h05nW
 9+Uc4AbIMJP1S6g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The previous patch builds tools/bootconfig during 'make prepare' to
render the embedded bootconfig cmdline, but nothing removes it on
'make clean', leaving the compiled tool and its objects behind.

Wire a bootconfig_clean hook into the top-level clean target so the
compiled tool and its objects are removed by make clean, matching the
prepare-wired tools/objtool and tools/bpf/resolve_btfids.

The hook runs tools/bootconfig's Makefile via $(MAKE), which the kernel
build invokes with -rR (MAKEFLAGS += -rR). -rR drops the built-in $(RM)
variable, so the existing "$(RM) -f ..." clean recipe would expand to a
bare "-f ..." and fail. Spell the recipe with a literal "rm -f" so it
keeps working both standalone and when invoked from Kbuild.

Reviewed-by: Nicolas Schier <n.schier@fritz.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Makefile                  | 11 ++++++++++-
 tools/bootconfig/Makefile |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5255aa35a2e51..20a2bcacde3b8 100644
--- a/Makefile
+++ b/Makefile
@@ -1587,6 +1587,15 @@ ifneq ($(wildcard $(objtool_O)),)
 	$(Q)$(MAKE) -sC $(abs_srctree)/tools/objtool O=$(objtool_O) srctree=$(abs_srctree) $(patsubst objtool_%,%,$@)
 endif
 
+PHONY += bootconfig_clean
+
+bootconfig_O = $(abspath $(objtree))/tools/bootconfig
+
+bootconfig_clean:
+ifneq ($(wildcard $(bootconfig_O)),)
+	$(Q)$(MAKE) -sC $(srctree)/tools/bootconfig O=$(bootconfig_O) clean
+endif
+
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
 	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
@@ -1757,7 +1766,7 @@ vmlinuxclean:
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/link-vmlinux.sh clean
 	$(Q)$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) clean)
 
-clean: archclean vmlinuxclean resolve_btfids_clean objtool_clean
+clean: archclean vmlinuxclean resolve_btfids_clean objtool_clean bootconfig_clean
 
 # mrproper - Delete all generated files, including .config
 #
diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
index 4e82fd9553cde..3cb8066d5141b 100644
--- a/tools/bootconfig/Makefile
+++ b/tools/bootconfig/Makefile
@@ -27,4 +27,4 @@ install: $(ALL_PROGRAMS)
 	install $(OUTPUT)bootconfig $(DESTDIR)$(bindir)
 
 clean:
-	$(RM) -f $(OUTPUT)*.o $(ALL_PROGRAMS)
+	rm -f $(OUTPUT)*.o $(ALL_PROGRAMS)

-- 
2.53.0-Meta

