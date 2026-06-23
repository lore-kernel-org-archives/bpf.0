Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0689C302750;
	Tue, 23 Jun 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231419; cv=none; b=uVESqCYB3leChgamf8uVu4sfyyA95A9YC5b5ah0hBhSZ92iY2XCEMZQOebFv2vtObHcqigH2ymepFxwChdVKeLayYAduFyou2fWptv9dJ68bXGTUT1I7nlPAXNHgTsMNPAOErhv4jkFJ7HZ6+otlRv1CGbB65i5Txmqy2//D1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231419; c=relaxed/simple;
	bh=l0q6pe+4+ra9uG1KKIAZ9OpYCeyHSMm3311kZUBNrPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=niyofVfMi3RJIbvMSgiJ2H6nSEqtWo81B2SxXucJK1VQx6KlEssgFHXc+P0pp7+Y4OcOU6OmueLgRHtugBaBTwH4zlaLO9slInHM8fcge0KVs3zXZ9Y/h//b/esvaxN8JQSWfh4i8WXzOjS+gRAcFch/+z/nBA3zftWvIi9ZrKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pR0H2r0F; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pR0H2r0F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=LtrxbqCWe0nH13XGNffqCXPM8E1ZDfOsjxy+podQdIg=; b=pR0H2r0Fs5AuT6iULtHmhsfV2m
	R7uLaCphmyoZ6rvtJoszQ6zV7Mp9G/6X9kXpjwVtMMKlb3EhZ5Ryx5RP/L6loiVwYW1SAidbbki39
	43YRDOPyPKaGpYmQdydHzbzw3JaNsv4IntOIyocbQ54B5wkaaBdrp0YUYR36VFgAtyOlb4vg18l7J
	luaGxjKVH73gt7ybJr9cDZRfJrKSY+a4t39bocSW5jSkI7KUihma/JLeE3zZPmwQxSftGs6G1xhnf
	K5IdAC3yjW2o9/xOjau+/uHk87yrTJ8Gc/mxzFDL1qgx4tkVcPeijhjYjcr265nJeSGHtQtizH9E2
	zmyLI9pQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wc3nx-001m2h-0v;
	Tue, 23 Jun 2026 16:16:53 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 23 Jun 2026 09:15:31 -0700
Subject: [PATCH v6 4/8] bootconfig: clean build-time tools/bootconfig from
 make clean
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-bootconfig_using_tools-v6-4-640c2f587a3c@debian.org>
References: <20260623-bootconfig_using_tools-v6-0-640c2f587a3c@debian.org>
In-Reply-To: <20260623-bootconfig_using_tools-v6-0-640c2f587a3c@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqOrFXochySo6N4tCipl508QZOafI2q3lYl9Iy6
 FL3zKQb6cWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajqxVwAKCRA1o5Of/Hh3
 bVIzEACbgx0m53XyTPCfYDleCoUQILi7CkVEK2mPMJ80Mu8Hi4UQnTFk4eeocNGu7M3SSjkvflt
 WAmWWtuVWlJuTw4Fl9M/+4JCvqrfkpSgvvcbOV0N78EmE+IgFGCz0/92Pluwv5+cmCoQbUDD0Dd
 Ry5Hxm7LssrtoGnZOr2zOJ4QGDH0deEpgy5Go7xNmenPNd9kBtK9Ek7j9+x92El9+gPJi3pLfiC
 plVtuCnml8UF8oGj6aGlZY1N+GqnCpSMAeJ3CpepdMUhEfMZti+qVO7sGt97LbjzDPW0YNOhaAz
 a/5lZPD+Cg4rvEvdWQujcX/+vuTvlyzi60KFeMIdROJtvyxskm31XEIu6k5S7hZR7XoLGel7g0C
 wh8VmqU0eKvDAX7SFCuYPoxrr2ZkOlW2+BSfdbU5HYaWZSTP1XJraGT5d+dTAN7t9IP57lYg0t1
 sFgF5i/hrBvzPAM8gyIP8Myu7bJes4roz8l4/TqT0qjaGiJZ9LlQ456EP+iemWPTRdmkY+X7bmt
 1MvWP3bNbuX2ZBIp9hZlQkz7aukxOnRcD1BJHqZRoEP7wrDLpTkFn9h7udEfj0w58IPyLUvZqxK
 ss01d4nDhGafJHnJr9Uf+JFJjG0G7nHLRIw0eEsfH1YwZ5Xrt26aUazeIUr5GpYZH4loEzVj12L
 jcbxmyVunKT1R1g==
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

