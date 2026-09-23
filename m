Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969103FE367
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139627; cv=none; b=ZRTI3G6shG93oCw76txIBYB88FcTd60FJajqgDrEX6fxRLp1M5hUnC4H96pW+1MhZJmhSUNdf+4yLiI5eo6FctUy9ux3JlZgBTc2RpxEtqVGgwIe38bjkCxS9oLkHhDVxNNSyvBipLi5gAdvlduZQAkLmmOQA+hQAv9J1pyaqJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139627; c=relaxed/simple;
	bh=R6eCQn67WbXkssOzZhm+u//tGSoEcc+f2wMngxNJ3+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTEJ5FUOsOGJKlkmiGuwwPxvZ9l9auo7+FtzWQzKsRhKepbNxBjB9UmyESso1ZoNrQ43dYkNUJaV/G6DYUNVGcqXwVOo6nM0qm5U6lN9iZ2XDmprnMy5tn+5kfDI2HclnPLlNkSE4a4SnC99Z6c/6jjbpkH6Q+HaG+YO2nO8GLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id F22BD2C8DADBF2; Tue, 22 Sep 2026 22:00:18 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 18/21] libbpf: Let the static linker carry .bpf_cleanup relocations
Date: Tue, 22 Sep 2026 22:00:18 -0700
Message-ID: <20260923050018.2426756-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An object that carries a compiler-emitted exception cleanup table cannot =
be
linked today. The table's fields are byte offsets into a code section,
materialised by a 32-bit relocation against that section's symbol with th=
e
offset itself as the implicit addend, and the linker rejects both halves =
of
that: the relocation type is not in the list it accepts, and a relocation
against an STT_SECTION symbol from a non-executable section is an outrigh=
t
error.

Both spellings of that relocation have to be taken. LLVM emits
R_BPF_64_NODYLD32 for a .long against a section symbol; GNU as emits
R_BPF_64_ABS32, which is what bpf_reloc_type_lookup() maps BFD_RELOC_32 t=
o.
They describe the same value, and the selftests are built with both
compilers.

Taking them is keyed on the relocation type rather than on the section
name, so any non-executable section could reach the new arm, and what it
replaces is an unconditional refusal. Check what the refusal used to make
unnecessary: a relocated section may be SHT_NOBITS, which extend_sec()
leaves with no raw_data, and r_offset is checked for alignment only where
the section holds instructions. Refuse those rather than write through
them.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/linker.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 78f92c39290a..95f2a5243eda 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1036,7 +1036,8 @@ static int linker_sanity_check_elf_relos(struct src=
_obj *obj, struct src_sec *se
 		size_t sym_type =3D ELF64_R_TYPE(relo->r_info);
=20
 		if (sym_type !=3D R_BPF_64_64 && sym_type !=3D R_BPF_64_32 &&
-		    sym_type !=3D R_BPF_64_ABS64 && sym_type !=3D R_BPF_64_ABS32) {
+		    sym_type !=3D R_BPF_64_ABS64 && sym_type !=3D R_BPF_64_ABS32 &&
+		    sym_type !=3D R_BPF_64_NODYLD32) {
 			pr_warn("ELF relo #%d in section #%zu has unexpected type %zu in %s\n=
",
 				i, sec->sec_idx, sym_type, obj->filename);
 			return -EINVAL;
@@ -2258,6 +2259,7 @@ static int linker_append_elf_relos(struct bpf_linke=
r *linker, struct src_obj *ob
 			if (ELF64_ST_TYPE(src_sym->st_info) =3D=3D STT_SECTION) {
 				struct src_sec *sec =3D &obj->secs[src_sym->st_shndx];
 				struct bpf_insn *insn;
+				__u32 *val;
=20
 				if (src_linked_sec->shdr->sh_flags & SHF_EXECINSTR) {
 					/* calls to the very first static function inside
@@ -2274,6 +2276,40 @@ static int linker_append_elf_relos(struct bpf_link=
er *linker, struct src_obj *ob
 						insn->imm +=3D sec->dst_off / sizeof(struct bpf_insn);
 					else
 						insn->imm +=3D sec->dst_off;
+				} else if (sym_type =3D=3D R_BPF_64_NODYLD32 ||
+					   sym_type =3D=3D R_BPF_64_ABS32) {
+					/*
+					 * Two spellings of the one thing: LLVM
+					 * emits NODYLD32 for a .long against a
+					 * section symbol, GNU as emits ABS32
+					 * (bpf_reloc_type_lookup() maps
+					 * BFD_RELOC_32 to it), and the value
+					 * they describe is the same.
+					 */
+
+					/*
+					 * Only an executable section has its
+					 * r_offset checked, and even there only
+					 * for alignment; SHT_NOBITS has no
+					 * raw_data at all. Bound it here,
+					 * subtracting so it cannot wrap.
+					 */
+					if (!dst_linked_sec->raw_data ||
+					    dst_linked_sec->sec_sz < (int)sizeof(*val) ||
+					    dst_rel->r_offset % sizeof(*val) ||
+					    dst_rel->r_offset >
+					    (size_t)dst_linked_sec->sec_sz - sizeof(*val)) {
+						pr_warn("ELF relo #%d in section #%zu points outside the data of s=
ection '%s' in %s\n",
+							j, src_sec->sec_idx,
+							dst_linked_sec->sec_name,
+							obj->filename);
+						return -EINVAL;
+					}
+					val =3D dst_linked_sec->raw_data + dst_rel->r_offset;
+					if (linker->swapped_endian)
+						*val =3D bswap_32(bswap_32(*val) + sec->dst_off);
+					else
+						*val +=3D sec->dst_off;
 				} else {
 					pr_warn("relocation against STT_SECTION in non-exec section is not =
supported!\n");
 					return -EINVAL;
--=20
2.53.0-Meta

