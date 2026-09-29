Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F33043DE
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641070; cv=none; b=TNSiq6gGh3z9E4H7jVGpH8PgHFAwgayulJ30WVAy7Uk6EI9EfQCOSA2yt+eVZsePOWqZHH9YN64apmWCQ6+CTPCQOv7ZKmiF9i55HiptHkQWmYmVeroEWod1dXMS+1zlkPs0ju03NVNoxgs+B6MbB6+ZDbubUMzn3yRY/JNPVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641070; c=relaxed/simple;
	bh=rbd2eY8ICzyq07VyiXt4HRU2+s27aE93bFU2PbDMX0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beAYgwx6X7i5DnEIXeKbO2Euvby7ypKwpKJaYGhY7nCPmru3vb2K7RSfAeBR4g4v4Ek6bI0Mttu28F4iaoQra394BPcXF0qc5UiZB/fKlLnM3Bi9u2HVNTQW4eWNyb4haZ38At8IqwXCaNc873mrzO/W+zgrKAoE8/KaDSmNze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A63B52DE076277; Mon, 28 Sep 2026 17:17:36 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 18/22] libbpf: Let the static linker carry .bpf_cleanup relocations
Date: Mon, 28 Sep 2026 17:17:36 -0700
Message-ID: <20260929001736.3255399-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929001601.3242665-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
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

Keying on the relocation type rather than the section name means any
non-executable section can reach the new arm, where an unconditional
refusal used to stand. That refusal was covering two things the arm now h=
as
to do itself: a target may be SHT_NOBITS, which extend_sec() leaves with =
no
raw_data, and r_offset is alignment-checked only where the section holds
instructions. The arm rejects both, and bounds the offset against the
section size before writing through it.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/linker.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index f3f71c452f00..7c4bc232d576 100644
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
@@ -2263,6 +2264,7 @@ static int linker_append_elf_relos(struct bpf_linke=
r *linker, struct src_obj *ob
 			if (ELF64_ST_TYPE(src_sym->st_info) =3D=3D STT_SECTION) {
 				struct src_sec *sec =3D &obj->secs[src_sym->st_shndx];
 				struct bpf_insn *insn;
+				__u32 *val;
=20
 				if (src_linked_sec->shdr->sh_flags & SHF_EXECINSTR) {
 					/* calls to the very first static function inside
@@ -2297,6 +2299,38 @@ static int linker_append_elf_relos(struct bpf_link=
er *linker, struct src_obj *ob
 					if (linker->swapped_endian)
 						off =3D bswap_64(off);
 					memcpy(ptr, &off, sizeof(off));
+				} else if (sym_type =3D=3D R_BPF_64_NODYLD32 ||
+					   sym_type =3D=3D R_BPF_64_ABS32) {
+					/*
+					 * A byte offset into a code section,
+					 * stored in place. LLVM spells this
+					 * relocation NODYLD32 and GNU as
+					 * spells it ABS32; being bytes, the
+					 * section's new start goes in as it
+					 * is, not scaled the way a call's
+					 * instruction index is above.
+					 *
+					 * r_offset is checked only for an
+					 * executable section, and SHT_NOBITS
+					 * has no raw_data, so bound it here --
+					 * subtracting, so it cannot wrap.
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

