Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65E854B1DD;
	Thu, 15 Oct 2026 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078863; cv=none; b=HoiedgN9bxXX7h4zc4Sv8fPRIt0ns4BZg5IBQB74P3zEgqE8kKNmF1cRlbJOyeyV0dA0Wp21pvGLzEwwh96SKmBTh8nbkja5ic1reaPo3c3GH4bb06LdS5WNx6YUKfcEtBGiSWTUiaeHUWUdbLGyhhY2uj0e7GDRf72vjK4+1Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078863; c=relaxed/simple;
	bh=cFJPOkTuqHPfQg9XtI4ydcikIjJhpRmfBXS51VN89HE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7zqCVAz41ZjTgBsXNKW6egRXcjB2I91oDwoM4hD1W6fTxYoTW68b2tVS8YhE2yH+jJtaW+nePjJHI/TD1Q7GH59yNN1YjGiT6gDKqDBV0V0y0VGeIls93Pil0aTQ9TbTNTlUHfU12U2spmyD9U0csSIowgzifNde+DjiJ/KEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbtBene2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbtBene2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571CC1F000C4;
	Thu, 15 Oct 2026 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792078846;
	bh=ddZjtjOCh5jlTMGXe/i/6le28DxCfsrE+liYqQ3Dqgs=;
	h=From:To:Cc:Subject:Date;
	b=MbtBene2qfbMlfoweEAJtIgbeH2a7u6WX0U5uZaJfB8tnaTJREw0iGg7sNQ0KwEQH
	 qMN8U2VahNYDiNejGgexzLSNmc7XNeqs/3nbBbptKMa16FCo8JoCDRGIxuqWqgF/b9
	 yX5AZFfgv5urGbajMrUboGfxL88OuC+zfia+J7RbF0Cr9ycHDzLGpLNDIkNota7wBT
	 C5cw4UpRjvvtVmF9+d/BDcON5d7pQOF7gFaTxJ6yKofJ0Nci2Jd8X98M2h/caNx4wY
	 13qU1+P7vf3VK2hN91pmh4akUZSHBONpEv41wmLlsf1E6NeEugjz7JYq6hthbw09/9
	 3CDazGAjge/vg==
From: Sasha Levin <sashal@kernel.org>
To: Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] ARC: Strip libgcc debug information when generating BTF
Date: Thu, 15 Oct 2026 11:40:44 -0400
Message-ID: <20261015154044.4058618-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARC links against the compiler's libgcc archive. The ARC GNU 2023.03
toolchain ships this library with debug information, including complex
floating-point types in integer arithmetic helpers such as __udivdi3.
These types reach vmlinux even though the kernel does not use complex
floating-point arithmetic.

When floating-point BTF encoding is enabled, pahole rejects those types:

  Complex, interval and imaginary float types are not supported
  Error while encoding BTF.
  FAILED: load BTF from .tmp_vmlinux1.BTF.1: No such file or directory

KernelCI's upgrade to pahole 1.31 exposed this long-standing problem as
failed ARC builds. As of 1.32, pahole still rejects these types, and
older versions will stay in use, so the kernel build has to keep them
out of vmlinux. Commit f122668ddcce ("ARC: Add eBPF JIT support")
documented the same failure along with a workaround of disabling
floating-point BTF encoding, but that also discards supported
floating-point types from kernel BTF.

For CONFIG_DEBUG_INFO_BTF, generate a debug-stripped copy of the selected
libgcc archive in the output tree and link that copy. Preserve the archive
structure so that only needed helpers are linked, and use the normal
Kbuild objcopy rule to track input and command changes. The trade-off is
that vmlinux in BTF-enabled builds no longer carries DWARF for the libgcc
helpers. Debug information for kernel code, the installed toolchain and
non-BTF builds stay unchanged.

Reproduced and tested with ARC GCC 12.2.1 and pahole 1.31 and 1.32 using
an ARCv2 tinyconfig with BPF_SYSCALL and DWARF4/BTF enabled. Before and
after vmlinux.o files are identical after stripping debug information.

Fixes: db16c1fe92d7 ("bpf: Generate BTF_KIND_FLOAT when linking vmlinux")
Link: https://github.com/kernelci/kernelci-core/commit/e71b8c9f42253180596e734c18965a5aad80c8c5
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/Makefile     | 9 ++++++++-
 arch/arc/lib/Makefile | 8 ++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 868805ffcfeab..4ea705a331c7c 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -86,7 +86,14 @@ core-$(CONFIG_ARC_PLAT_TB10X)	+= arch/arc/plat-tb10x/
 core-$(CONFIG_ARC_PLAT_AXS10X)	+= arch/arc/plat-axs10x/
 core-$(CONFIG_ARC_SOC_HSDK)	+= arch/arc/plat-hsdk/
 
-libs-y		+= arch/arc/lib/ $(LIBGCC)
+libs-y		+= arch/arc/lib/
+
+ifdef CONFIG_DEBUG_INFO_BTF
+export LIBGCC := $(LIBGCC)
+libs-y		+= arch/arc/lib/libgcc.a
+else
+libs-y		+= $(LIBGCC)
+endif
 
 boot		:= arch/arc/boot
 
diff --git a/arch/arc/lib/Makefile b/arch/arc/lib/Makefile
index 30158ae69fd4a..2807ee24f27e6 100644
--- a/arch/arc/lib/Makefile
+++ b/arch/arc/lib/Makefile
@@ -13,3 +13,11 @@ lib-$(CONFIG_ISA_ARCV2)		+=memcpy-archs-unaligned.o
 else
 lib-$(CONFIG_ISA_ARCV2)		+=memcpy-archs.o
 endif
+
+# libgcc can contain complex floating-point debug types unsupported by BTF.
+# Strip only the debug information from a local copy of the selected archive.
+always-$(CONFIG_DEBUG_INFO_BTF) += libgcc.a
+OBJCOPYFLAGS_libgcc.a := --strip-debug
+
+$(obj)/libgcc.a: $(LIBGCC) FORCE
+	$(call if_changed,objcopy)
-- 
2.53.0

