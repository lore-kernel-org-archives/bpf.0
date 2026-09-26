Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8006E63CB
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790380967; cv=none; b=lP4aPfrCVJWTAwLmdretnNiw7jvhiWDzEe4wbdvo/8Co+c9OjUcuoCi80WzIzl6RnxdkLCQbqQxiZ0wEmfnUQtMh6oVVitUSDOHlOcIUpKLr6TlUlj0t5QHzrdKTS3L1z9okOf54X9lKFkbv+OZyFtKWYNMPLLQ24GkhOnDCt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790380967; c=relaxed/simple;
	bh=Xe9S8MArdk9/B0OlQdl/4syv/2WTHrV1Yx/uVe9hD9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIAU4BqdMsnHlnJHLhHegqsFrqVDxC00TMXbxRcJtIKBHCURaL3INJpIADU139/Ty97FDWXAT+7jzzJCyC0cOkDJrjJWw04lGBNRG2ebAmX+1wmaO1bCIha830mFG3287D1KR0SUwwsn+KTnTKLjVsfTmcJDRnbDM8kOE/pIjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9Lkbhpk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9Lkbhpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F631F000FF;
	Sat, 26 Sep 2026 00:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790380966;
	bh=VcYkj+I++4bYtwmEzQCA/gV2GZ/IX4k4jo4eaMozTqk=;
	h=From:To:Cc:Subject:Date;
	b=C9LkbhpkhbrumiCRtJ9Krjjphnl14DAm+zfXgrP3PeWz/b3OnIXWk9/A5ox54/RLt
	 /PpXAGmXPUj7yNjpCViVgKdBSr56iP/6QvRXCdIYry34w6xOJe6ldNe7Zdk3zeLeaW
	 7NA5IIt2zUKyLkIwmMm9DgIFR4C7Kygxhbaznc+Di0akwqOrnKVarKHHXWSdeAREF5
	 eLbBT2DhbORy481D0l6a9jVbnl7l4PTMnT7ZZrc7TK9/ofFrTmJ9khBo179hqkHniw
	 KXblSRh+XlwHMj3IPOSHxzT1D7ivQwpn7tchJ526+Am0A0mVcqE0upPorwJMalO5+y
	 dfiXp7PYEZScQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 1/2] libbpf: Fix static linking of externs placed in allocated sections
Date: Fri, 25 Sep 2026 17:02:42 -0700
Message-ID: <20260926000243.2830819-1-andrii@kernel.org>
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
section's index and offset instead of staying SHN_UNDEF with a zero
value. For ephemeral sections both are 0, so this only shows up for
allocated sections, where the extern turns into a size-zero NOTYPE
definition. Linking the output again then fails with "conflicting
non-weak symbol" against a strong definition of that variable, or,
against a weak one, keeps the bogus symbol and resolves every
reference to offset 0 of the section. And if the section of the
object with the extern doesn't start at offset 0 of the output
section, the output symbol fails linker_sanity_check_elf_symtab() on
the next link with "invalid extern symbol" before any of that.

When the extern is resolved by a later object in the same link, the
DATASEC entry appended for the extern keeps its placeholder offset,
as linker_append_btf() only updates the size of an existing entry.
The ELF symbol and the BTF secinfo then disagree and skeleton
generation fails with:

  Error: Something is wrong for .addr_space.1's variable #1: need offset 0, already at 8.

Keep unresolved externs SHN_UNDEF with a zero value in the output
symbol table, and once an extern is resolved take the offset of its
DATASEC entry from the ELF symbol, which already accounts for weak
vs. strong resolution.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/linker.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 53f64a1a1f25..f3f71c452f00 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2159,8 +2159,13 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 	dst_sym->st_name = name_off;
 	dst_sym->st_info = sym->st_info;
 	dst_sym->st_other = sym->st_other;
-	dst_sym->st_shndx = dst_sec ? dst_sec->sec_idx : sym->st_shndx;
-	dst_sym->st_value = (src_sec ? src_sec->dst_off : 0) + sym->st_value;
+	if (sym_is_extern) {
+		dst_sym->st_shndx = SHN_UNDEF;
+		dst_sym->st_value = 0;
+	} else {
+		dst_sym->st_shndx = dst_sec ? dst_sec->sec_idx : sym->st_shndx;
+		dst_sym->st_value = (src_sec ? src_sec->dst_off : 0) + sym->st_value;
+	}
 	dst_sym->st_size = sym->st_size;
 
 	obj->sym_map[src_sym_idx] = dst_sym_idx;
@@ -2592,6 +2597,10 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
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

