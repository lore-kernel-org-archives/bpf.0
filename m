Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224B3F2106;
	Wed, 17 Jun 2026 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695441; cv=none; b=AmaFudpBO2l22xseNhLErYhcupjaqh9g3q4s7zGNUfg3oc5HKDDxXRnoOItnibnhqfE+hOYwDHS0KBH6hqEuq/SEy9GUehcsKvCUGdzQnyedhsuPsSZChYlzLG1chxq+rSFf1srbkZpHahl7MpcoqJDL+N74+q/+Zdxdh8qzQuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695441; c=relaxed/simple;
	bh=uXyFD3U8y/edjIOA6R0qWiwoiGa4ygcAQX+KfqQEqms=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I2ppF495ewiB9ehTnbcKFoC2g9QTvSe3HfsHTy/y5LI32Sa5f9Hl1+VIuHCTXQQr1H78aVEq5hXRWkGaBi3OgeCiBbw3thOeZkWJNm9PNVMpBITmP+vQYn/jLFLiUTJnn/W3LuY9GQj3NYgayheqFUyfi7yuArhaW4ASCY5RVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Bh/z6HDL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Bh/z6HDL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=gvtrjCP2WCAfDmfudQjzRpC6aeP8ChDRvrB0/Jx6nIw=; b=Bh/z6HDLkSjUcRwBMSJdrDibRB
	sZk73KQ2/1knKwNBrltT8HicE40E0x+02r10VWcG9L2eCICOhtY1HWM30nrMyhng0SFUxNJImmr2w
	xYfezpKxHNWbSuo2PkWAjTjdRK8Q6IAPDZcRrqJ5cC/dR9cJTZqpYZqf+s9It7Rj1JwB2SfXRvDeZ
	nES5DSMPhtFgRnUDsnJp69S8TiyF2m1AHMk49tuwZlQ65kq1pMK8ERczon3vJeFrRtIZRtko0BA4U
	AW8Z3ItyzHJVXDFqR9AXMJBqB6w9gfMOF9PByYkURb+feZxGo30B/7LkG6ufp9WzUiTJ9EwPr6ldl
	HH1LEJ2Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZoMy-00Ea9i-1i;
	Wed, 17 Jun 2026 11:23:46 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v5 0/7] bootconfig: embed kernel.* cmdline at build time
Date: Wed, 17 Jun 2026 04:23:32 -0700
Message-Id: <20260617-bootconfig_using_tools-v5-0-fd589a9cc5e3@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALWDMmoC/3XPS2rDMBCA4asYrTNlomfkVe9RStDTUSlSkRyRE
 Hz34rTQlODlwPD9MzfSQk2hkXG4kRp6aqlkMg5iNxB3MnkKkDwZB0KRShR4AFvK7EqOaTqeW8r
 TcS7ls4GLRhmjvTTCkN1AvmqI6XKH395/5na2H8HNq7ZunFKbS73ey32/7v1GqNqK9D0gWKlRm
 oMMyotXH2wy+aXUiayVTv8ciWLToYDgGeooOLciqieHPTqbT3cGCNx7j0oblFo+OfzR0ZsOBwT
 FHJcsIjP6/z3LsnwDlKiCRacBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5450; i=leitao@debian.org;
 h=from:subject:message-id; bh=uXyFD3U8y/edjIOA6R0qWiwoiGa4ygcAQX+KfqQEqms=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqMoO7zVhflpycvAJ7SGWr0Vn71YcGgMqItSemk
 mOg+Sw7z82JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajKDuwAKCRA1o5Of/Hh3
 baBVEACTufbQagvdbzUSMD/OPPVRtQft/6zw/TJBzDiwqdAX8BEUhl61UZ/aOty4hyO7b8ud0qc
 Z9opS1L91Sa0jz+xoD5ziDoOGW8+g0CyvoPyiOqcYyAayoWnKi2TBJqi8TzWDQFQ5UR6MBQ1bI9
 2fEUzpYl62Gc5OmKBuFMLR16O4g7qIQD6iEfskCjLwzv8EKz37Myd9i4ocdMMLJk1MvanrYJNj9
 IgnoU6qzz5FZ3cB1csyu1MgmeD10a7gmU89hJgLX3TEqfG3qjW2BhP9bOMTBgdfkq4QD1ZGdYRW
 PX6WtK4XQ9zzpv9PQXdPVMBbkJm8IkgV9PJgiVunLwrFE5JPyFro5UEQ5POGEMz2+gh6uWv7iBz
 hizOSDk2xxQD7joAh6uG2CklrYyZInTzvCOFtWsVfcmr7CaXDBn9xZeWmr/MDYL1xshF+wGpkwx
 nYwPRASHXBNmFJyCNaoMiwocCfNawx2/o3Ce9vcjLezldI7mR5xMJkKMIleX+rihLN/CkBhT9RJ
 IgSDd3GzKEEkfADfqjLQLsac5aoTpGdJ6bXRp8ry48UBLm8JyrD++bM9lqpw0WOBdft1GZbXd8H
 ayI0r3aUS06WB59yoO+t0cy0pBAqPE5IWXqMPU1MQCpfCSqI21gVKSOlsS6Z3N6pZJBR0sZx79x
 /Jb7QCoQkAxiFMQ==
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
Changes in v5:
- Patch 3 (Kconfig): drop the redundant "depends on BOOT_CONFIG_EMBED"
  from BOOT_CONFIG_EMBED_CMDLINE; Julian Braha.
- Patch 6 (Documentation): spell out how the embedded cmdline interacts
  with the bootloader cmdline, an initrd bootconfig, and the embedded
  bootconfig 
- Link to v4: https://lore.kernel.org/r/20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org

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

 Documentation/admin-guide/bootconfig.rst |  81 ++++++++++++++++++++++
 MAINTAINERS                              |   1 +
 Makefile                                 |  28 +++++++-
 arch/x86/Kconfig                         |   1 +
 arch/x86/kernel/setup.c                  |  27 ++++++++
 include/linux/bootconfig.h               |   9 +++
 init/Kconfig                             |  35 ++++++++++
 init/main.c                              |  25 ++++++-
 lib/Makefile                             |  16 +++++
 lib/bootconfig.c                         | 112 +++++++++++++++++++++++++++++--
 lib/embedded-cmdline.S                   |  16 +++++
 tools/bootconfig/Makefile                |   4 +-
 12 files changed, 342 insertions(+), 13 deletions(-)
---
base-commit: a87737435cfa134f9cdcc696ba3080759d04cf72
change-id: 20260508-bootconfig_using_tools-cfa7aa9d6a5a

Best regards,
-- 
Breno Leitao <leitao@debian.org>

