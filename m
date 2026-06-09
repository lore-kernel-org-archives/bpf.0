Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCA39B951;
	Tue,  9 Jun 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000931; cv=none; b=j6fgkqMAaFK81sxaggTT6BOyJ06Jz2LXuM2KTDfROCrSPTz+1jqM1EVHHDZ80eAC5BXDhjJODwVz9qoEm0o0QwgtgR0aTFGkbyR/6UZZ/FHo7rDym+/6y9jthZwtIIsr7srwYqMxmn19MoYPWCSBU5xUdfCeUybaKjhCn5IZGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000931; c=relaxed/simple;
	bh=w4PWeuBYj4wxQby1ZMH3GSR47GKQB1COFC/gplyT08s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qxl3a+2aSHJKSTgm6SVDg0rYHMH9FwMfU/qH9FgT0XcegKhr0HCheVuvUlw5f+bXu1yaAGeWbFlf98hJa4U0C+eP6DEtCRztFNVQob90M1wz/jBoZ69IS3Pv3r6ii3NvXzyBoAYtrWzNv3NhgtL87bYJtdCMrfTnt+IYk+I3hg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=A3evNwfb; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="A3evNwfb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=PHAMLKJ1/W/s/nX7MRHe/uHU68qoKve74uEu8UyVAkA=; b=A3evNwfbbuy678DxxWwHyDxGYX
	y52KsDeILomfSdPXmAn12A50+IJfizWQvc+ElJZQSn6VV5kpii+0bXiq7y343QX/ZPiYMcSi5aWjK
	5U+mn/uITFOQvKkvKaEIlQ/YXrUzDF49TRBB8DfExY2AscwoUbC+n8hjphMvB51DnWSgzL3pNZoan
	+WZj5PDxGLv80MsI+k3CaRJ6GVRisRnhxZX27grV3QsIo3zmk/cJvATf2JDJ0yDvHYVDETDTwLVeI
	81/4kgw8r8qROeqF0P1Ph7+ITlQ82P/vCVit+7rLxeG+NVjlNZxlyyz1euE85L9eR1qVSkL/ud1mF
	RNWip4HQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWthF-008Kne-39;
	Tue, 09 Jun 2026 10:28:39 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v4 0/7] bootconfig: embed kernel.* cmdline at build time
Date: Tue, 09 Jun 2026 03:28:27 -0700
Message-Id: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMvqJ2oC/3XP0WrDIBTG8VeRc91TTk3Umqu9xxhFo6aOoUNT2
 Sh595K2sI2RywMfvz/nCtWX6CsM7ArFt1hjTjCwfsdgPJs0eYwOBgacuCRBR7Q5z2NOIU6nS41
 pOs05f1Qcg1HGaCeNMLBj8Fl8iF93+PXtcdeLfffjvGrr4hzrnMv3vdwO6+4Z4Wor0g5IaKUma
 Y7SKydenLfRpH0uE6yVxn8cSWLT4UjoOtJB9L0VQf1zut/O5tOtQ8LeOUdKG5Ja/nGWZbkBKSg
 U0F8BAAA=
X-Change-ID: 20260508-bootconfig_using_tools-cfa7aa9d6a5a
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5041; i=leitao@debian.org;
 h=from:subject:message-id; bh=w4PWeuBYj4wxQby1ZMH3GSR47GKQB1COFC/gplyT08s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJ+rQNxc9GgQAuMjG9Z/44QBCxzQ0D5IZ+zRmf
 dkCldagA12JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaifq0AAKCRA1o5Of/Hh3
 barsEACNTSAau75IJgAutvrfe8NQaGBktFKeR+DjKp8MwQOgbHVTGw6hnZjb0STdaL6E+yyrdWW
 is2RGmfwhNB+KaafpVHPPT0mdfu+yl/a8FM9iWtpJNZCWwfkf9WglLYnVMlk4r3VOzpc9qGf6Zh
 RJ0Sxc6gFftttklXCCLn4QwHKiMyQfEwuUfyqT81FL6RpsVBlk7/SVW6fW52kmDfgnr6U0jlqsU
 iR2+j9VWogJmej7s6E60iRPKFKNtNxqvt6/j5IK2yjX3y/utDwy5SpNvOqElrdqbIGSJwu3bdoN
 DCvb13zyCIg9qdzWlArUxVGlKIWTnB8VVvjaeVotIM7ePJdrsNUnXKcCghwc5sZA+k3y07CPJNR
 jFXQwAfinCZxl/kO8XLz9IxxdTEZ8CviHU7a8j+Kq14cPxgB60nhDSf8dmqdwR8CaIG1PVZ9/Dq
 lkEc6FY1XhW3LNsIFT30TrANv2ZZPiqez0GXvcUBdTbQsOCquvJn/jWHLS64PKwO3RJNUS9e9q1
 7xU3LLltNg6EWD6W3TUdZcfEVjfrL8Nu7EGjpM/jD2EYs5a2sCX8pJ3XkT94mN8Ur6F1zjpJh9a
 Yeevi8C8UxbdiG/O/TeRSuK9vBJhcUXwSevAKk/vLy7tDDu2DUtEljy3C7Mtn/aVVeYh1e7RcEX
 Ex6vHLvACSHXp0w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The userspace pieces (xbc_snprint_cmdline() in lib/, tools/bootconfig -C)
already landed; this series wires the rendered cmdline into the kernel.

Motivation: today the embedded bootconfig is parsed at runtime, after
parse_early_param() has already run, so early_param() handlers can't
see embedded values. Folding the kernel.* subtree into the cmdline at
build time gives a CONFIG_CMDLINE-equivalent for embedded-bootconfig
users without forcing them to maintain two cmdline sources.

Behaviorally, the "kernel" subtree is rendered to a flat string at
build time and stashed in .init.rodata. setup_arch() prepends it to
boot_command_line before parse_early_param() runs. Overflow is a soft
error: the helper logs and leaves boot_command_line untouched rather
than panicking, so an oversized embedded bconf cannot brick a boot.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v4:
- Patch 3 (build pipeline): clear CROSS_COMPILE= in the kernel-side
  tools/bootconfig sub-make. Without it, an LLVM=1 cross build
  inherits CROSS_COMPILE and tools/scripts/Makefile.include injects
  --target=/--sysroot= into the host clang, producing a target
  binary that fails to exec.
- Patch 3 (build pipeline): place embedded-cmdline.S in its own
  .init.rodata.embed_cmdline subsection ("a") so ld.lld does not
  see a section-type mismatch against lib/bootconfig-data.S's
  writable .init.rodata ("aw"). The linker's *(.init.rodata
  .init.rodata.*) glob still folds it into the init image.
- Patch 6 (x86/setup): also accept the bootconfig=<anything> form
  via cmdline_find_option(), matching the runtime parse_args() loop.
  Without it, bootconfig=0/=off would skip the early prepend but
  still trigger the late runtime apply -- a split-brain state.
- New patch 7: document CONFIG_BOOT_CONFIG_EMBED_CMDLINE in
  Documentation/admin-guide/bootconfig.rst (semantics, opt-in,
  precedence, overflow behavior, example).
- Link to v3: https://lore.kernel.org/r/20260608-bootconfig_using_tools-v3-0-4ddd079a0696@debian.org

Changes in v3:
- Patch 3: Move HOSTCC override to the kernel-side rule; tool keeps
  $(CC) for standalone/cross builds.
- Patch 6: Drop the false fail-safe wording; document the
  BOOT_CONFIG_FORCE=y default interaction.
- Link to v2:
  https://lore.kernel.org/r/20260605-bootconfig_using_tools-v2-0-d309f544b5f7@debian.org

Changes in v2 (addressing review of v1):
- Split out a standalone fix for the NULL-pointer arithmetic in
  xbc_snprint_cmdline() so the build-time render cannot trip host
  UBSan/FORTIFY_SOURCE.
- Rework the leaf-root handling: instead of returning early, skip @root
  inside the loop so a root carrying both a value and subkeys
  (kernel = x together with kernel.foo = bar) still renders its
  descendant keys.
- Build tools/bootconfig with $(HOSTCC) so cross-compiled (ARCH=...)
  builds render the cmdline on the build host instead of failing with
  "Exec format error".
- Mark the embedded cmdline section read-only (drop the "w" flag from
  .init.rodata).
- Add a make-clean hook so tools/bootconfig artifacts are removed by
  make clean.
- Gate the x86 prepend on "bootconfig" being present on the command
  line (or CONFIG_BOOT_CONFIG_FORCE), matching the init.* opt-in
  semantics documented in bootconfig.rst and preserving fail-safe
  recovery: dropping "bootconfig" from the bootloader cmdline now also
  disables the embedded kernel.* keys.
- Link to v1: https://patch.msgid.link/20260527-bootconfig_using_tools-v1-0-b6906a86e7d5@debian.org

---
Breno Leitao (7):
      bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()
      bootconfig: render descendant keys when xbc_snprint_cmdline() root has a value
      bootconfig: render embedded bootconfig as a kernel cmdline at build time
      bootconfig: clean build-time tools/bootconfig from make clean
      bootconfig: add xbc_prepend_embedded_cmdline() helper
      Documentation: bootconfig: document build-time cmdline rendering
      x86/setup: prepend embedded bootconfig cmdline before parse_early_param

 Documentation/admin-guide/bootconfig.rst |  46 +++++++++++++
 MAINTAINERS                              |   1 +
 Makefile                                 |  28 +++++++-
 arch/x86/Kconfig                         |   1 +
 arch/x86/kernel/setup.c                  |  27 ++++++++
 include/linux/bootconfig.h               |   9 +++
 init/Kconfig                             |  36 ++++++++++
 init/main.c                              |  25 ++++++-
 lib/Makefile                             |  16 +++++
 lib/bootconfig.c                         | 112 +++++++++++++++++++++++++++++--
 lib/embedded-cmdline.S                   |  16 +++++
 tools/bootconfig/Makefile                |   4 +-
 12 files changed, 308 insertions(+), 13 deletions(-)
---
base-commit: a87737435cfa134f9cdcc696ba3080759d04cf72
change-id: 20260508-bootconfig_using_tools-cfa7aa9d6a5a

Best regards,
-- 
Breno Leitao <leitao@debian.org>

