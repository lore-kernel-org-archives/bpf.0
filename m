Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA03F99F3;
	Tue,  9 Jun 2026 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000946; cv=none; b=QwNBN6/yNpZkYe/z8+4P+1EhGCZSBmLT7W1Q7XmFkYRT9NVf542l+GlwyPCbvt0g7Nkb+a406ZAidUfAYGtWOK30BuDhB2T6y3m4EbDjRiS/3JU7HVLuTt09xJOdar0hm9cx+SrhhdvaL9KvAd4aKTw96YYemS3N1W5XLJttb1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000946; c=relaxed/simple;
	bh=gy400XTK0b+OnXKZDeudw301Pv67Sy1MSNRqZDkS4Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwydYr2AeyvygQTVUe2Y2B90hbTWPoFvPcSEz1IjgVUg2oi4HYOQ9p5b0jbQ9r5ugN7hVr5mse8P8F6w3y45zA8yCdp9qqXvHHW9AalHE39585WB3hFAuBU39UCiQDr2PsyF1AWEHBLeS89hV4UwRwEOseiJ80O261gWDFfXh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=WDIRd4ei; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="WDIRd4ei"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=2aoR2Po0srxnkmqMwSUT1BBnqe/SKlhrI+Kx+UR+p9A=; b=WDIRd4eixcVrRlNVQMwoESv6Sx
	OgK3FrQDR6ixS8ei1VNdDRpu/BABaEl+GXANFZIExNwa85RN99+UPvqfYXhpafYc6TeFC1U9+Zh61
	aX8DCqnXFnAA4KDgwin0pv+sM1dDc43W1bwh08r9VPpjYyf4M6164OFpU7C2Yi6QsOu7fITcaqksF
	OQ2WKBD03B326/pm2tYoCpxZhX6ydMyPyQ2l2DD8jv2Rf2w60qaHQrlVFZpVhlivCiE60KIyd7b+L
	IZ0xV83YMNH98Y/k/ev+VXdiXBsUEJ0QeSxttZZzbpGgCESqJHTHlmAnJ/55JFPqtxrAUkwF8pBq1
	FRremriA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWtha-008Ku4-1R;
	Tue, 09 Jun 2026 10:28:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Jun 2026 03:28:31 -0700
Subject: [PATCH v4 4/7] bootconfig: clean build-time tools/bootconfig from
 make clean
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-bootconfig_using_tools-v4-4-73c463f03a97@debian.org>
References: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
In-Reply-To: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, 
 Nicolas Schier <nsc@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2499; i=leitao@debian.org;
 h=from:subject:message-id; bh=gy400XTK0b+OnXKZDeudw301Pv67Sy1MSNRqZDkS4Xo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJ+rRUEdiBw5MhxQj+U4cBpyHMrY+cjgOJ/Fdp
 h3wzcLXk5GJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaifq0QAKCRA1o5Of/Hh3
 bcDMD/9RIL7/ecs3FeADelUROoD7KHGl9Kl913vmaYwBtbeQ5sydJg+b8dux4Kq3UDFvr/JMvgc
 Hns8TkT3FSzbuvsHagZH4QFOcXYt6HL1Jx1QekkJA3ZoenxNY6BHGR2kKfV5vvWjSgBm8F3h5Vl
 KwABKsWNlOI6gh9dr3YYhw8lKnOT1oaKrtocLriFWrYhuz5dA9lJJFmByr9zISapPJbnDeuNPot
 USXl6JuvvzQWqRb5f1XflgFGZATjfKVJ7qna08CQlPTbObRRuyt4jBpqL/GpZFU33IKuEuDztEp
 WMS1kgVFf/arFSa/1SA0TNoCkQQQtAJICyhYG1+UsRAubEJqMjVGeG2HJksQeNL9kKNg8WOczAL
 N/Bp90KxLz6w4tf8f37NYXBi4pmOoJT670ZRj+IJQE7gXl7yYsZtBzQfRjk+77bZ+MGXO7pzlih
 s0cr+u25TjDSKVOvahmUyADZvtUIiwGaQo0Wy7sfsXDxKmkV9Gkg7ulA0qw99w2jAhxml3Zy2QN
 wTEYyknc0r8zfd6qexRh+/c+N7/bLsjlCuxLtqZVuBI4qwoNJtz3MLlWNVE2mkbX5YfUvGGRk/y
 l78xRLi8a32qWwRC3Sa4zXOhVkk9OYQAXYQz+fWBIH9g91jVy1mf0NO3nMgQ5zsCycxBRW6NyMF
 8se53puJBehJOeQ==
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

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Makefile                  | 13 ++++++++++++-
 tools/bootconfig/Makefile |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a7abb3f9a626..a6e13fa1c1dc 100644
--- a/Makefile
+++ b/Makefile
@@ -1586,6 +1586,17 @@ ifneq ($(wildcard $(objtool_O)),)
 	$(Q)$(MAKE) -sC $(abs_srctree)/tools/objtool O=$(objtool_O) srctree=$(abs_srctree) $(patsubst objtool_%,%,$@)
 endif
 
+PHONY += bootconfig_clean
+
+bootconfig_O = $(abspath $(objtree))/tools/bootconfig
+
+# tools/bootconfig is only built (via the prepare hook above) when
+# CONFIG_BOOT_CONFIG_EMBED_CMDLINE is set; skip its clean otherwise.
+bootconfig_clean:
+ifneq ($(wildcard $(bootconfig_O)),)
+	$(Q)$(MAKE) -sC $(srctree)/tools/bootconfig O=$(bootconfig_O) clean
+endif
+
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
 	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
@@ -1756,7 +1767,7 @@ vmlinuxclean:
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/link-vmlinux.sh clean
 	$(Q)$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) clean)
 
-clean: archclean vmlinuxclean resolve_btfids_clean objtool_clean
+clean: archclean vmlinuxclean resolve_btfids_clean objtool_clean bootconfig_clean
 
 # mrproper - Delete all generated files, including .config
 #
diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
index 4e82fd9553cd..3cb8066d5141 100644
--- a/tools/bootconfig/Makefile
+++ b/tools/bootconfig/Makefile
@@ -27,4 +27,4 @@ install: $(ALL_PROGRAMS)
 	install $(OUTPUT)bootconfig $(DESTDIR)$(bindir)
 
 clean:
-	$(RM) -f $(OUTPUT)*.o $(ALL_PROGRAMS)
+	rm -f $(OUTPUT)*.o $(ALL_PROGRAMS)

-- 
2.53.0-Meta

