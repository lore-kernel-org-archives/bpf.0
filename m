Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7E303A37
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376395; cv=none; b=ljc8+pTmy7NMzzAv/ySoPylq7CxNsOmCM/zWPAO7cui0GYyRgAtcWHF6Sh8ZGvq9UAwT+YibdkC4aznkN0K4cQOEl9f943ou/jpoUrMFCVuMoIc/9fFyJntGz36pdqUqMYw1iqri6tuKqN9kx/egquMTegruSTn5pQsD+PBMetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376395; c=relaxed/simple;
	bh=DOoPfTSAsvffI/bKLNqlvurWEAHlGPNC4xrFIR9/qH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjWPsY6T9D6HIUzFs8jNQxNuNkdq4PUr9aRdDv6Df19YRbQK7kZcjawUWzQqjN04bsW6KhVZnyPuAVsZNQpxG497j7mcF/xnwKxUOcnEnAJ+acNvF/1Yxe5Za0yuA8tkkDmWhEG0jjpPwqp8O4yB3FhwfovYNPcNIVmmomoyBMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd42fAkt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd42fAkt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E468D1F000FF;
	Fri, 25 Sep 2026 22:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790376394;
	bh=G7c0t5xusQjIcnKrVOTL6wUTOYl+Y177NdzKuo58ESA=;
	h=From:To:Cc:Subject:Date;
	b=Fd42fAkth+8KndOYHnj80b+FZO4pcEWBAawDsM828jLaVnGlLjjKTKyB9hH3m9iwY
	 XyfyLGo7QmHjUJl5dezRLVZaAt2wTZqVTyYX2piyucaM+EYwxUPgdXcRX/xNiwJOUW
	 m8LaY3JHaaOqgoWviVHdqeSWulfMm9vCmJcMTdyneFPZIBwQ6vSdGRSC84px+xR9nR
	 f8caauWVzcGFQc34Hu4xXHWHTat4S4fqQlegThc1uAdt4e8H2YLzSQkb7695akzmYt
	 ivgUr6jJiQgE3i24ARb+58n8/XAnuVKRrdTvRkYG09CpSxz8P45KPX457c+MKt3YkF
	 n+rVJ8v/lkwGA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] libbpf: Fix static linking of externs placed in allocated sections
Date: Fri, 25 Sep 2026 15:46:30 -0700
Message-ID: <20260925224631.1490488-1-andrii@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang puts an extern variable that ends up with a section, an extern
map in .maps or an arena global in .addr_space.<N>, into the BTF
DATASEC of that section, next to the object's own definitions and
with offset 0. Unlike .kconfig and .ksyms, that section is a real
allocated ELF section whenever the same object also defines a
variable in it. The static linker handles such externs incorrectly in
two ways.

The output symbol of an unresolved extern gets the destination
section's index instead of staying SHN_UNDEF. For ephemeral sections
sec_idx is 0, so this only shows up for allocated sections, where the
extern turns into a size-zero NOTYPE definition. Linking the output
again then fails with "conflicting non-weak symbol" against a strong
definition of that variable, or, against a weak one, keeps the bogus
symbol and resolves every reference to offset 0 of the section.

When the extern is resolved by a later object in the same link, the
DATASEC entry appended for the extern keeps its placeholder offset,
as linker_append_btf() only updates the size of an existing entry.
The ELF symbol and the BTF secinfo then disagree and skeleton
generation fails with:

  Error: Something is wrong for .addr_space.1's variable #1: need offset 0, already at 8.

Keep unresolved externs SHN_UNDEF in the output symbol table, and
once an extern is resolved take the offset of its DATASEC entry from
the ELF symbol, which already accounts for weak vs. strong resolution.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/linker.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 53f64a1a1f25..0eaf98b093f0 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2159,7 +2159,10 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 	dst_sym->st_name = name_off;
 	dst_sym->st_info = sym->st_info;
 	dst_sym->st_other = sym->st_other;
-	dst_sym->st_shndx = dst_sec ? dst_sec->sec_idx : sym->st_shndx;
+	if (sym_is_extern)
+		dst_sym->st_shndx = SHN_UNDEF;
+	else
+		dst_sym->st_shndx = dst_sec ? dst_sec->sec_idx : sym->st_shndx;
 	dst_sym->st_value = (src_sec ? src_sec->dst_off : 0) + sym->st_value;
 	dst_sym->st_size = sym->st_size;
 
@@ -2592,6 +2595,10 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
 					continue;
 
 				dst_var = &dst_sec->sec_vars[glob_sym->var_idx];
+				if (!glob_sym->is_extern) {
+					Elf64_Sym *sym = get_sym_by_idx(linker, glob_sym->sym_idx);
+					dst_var->offset = sym->st_value;
+				}
 				/* Because underlying BTF type might have
 				 * changed, so might its size have changed, so
 				 * re-calculate and update it in sec_var.
-- 
2.53.0-Meta

