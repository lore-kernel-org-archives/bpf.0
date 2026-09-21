Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2DF4FC346
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024532; cv=none; b=XvI3wAB7T6c2dzfaYD/UCgJ/LnsitkaciTCpCrrKCxyDafO7r8voQX7A1C8k0LN9pSu17Yrr8eRvbzz7kbt+/29VypmzWCP9bSamS4JRWYAgEPOnW56k9hTQ1+Z7algQP294plJom8CCAbwW5Nr5gG+X/FiqAbV4emVQBbkYNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024532; c=relaxed/simple;
	bh=iarMN/JqHMbmZQyHNdWDjYVeerZxdk8Vj7LaP2cqgy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEhbONrH/CJvuAoT6R5EmSSJyDye58F6280AKi25LlJEhNV4XN4U+Vx+e5759sf9s2kzsGLdaSbS0y/wdhg7JPD0tzXjU+E5wqOye7iYkzSETO2kImskRy/DQfnbr1zU8JUJE8eT3Ssz9QP5WwL0d93N2qxsLLGAbV+48Jw+5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7A09C2C4497D7F; Mon, 21 Sep 2026 14:02:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 17/20] libbpf: Let the static linker carry .bpf_cleanup relocations
Date: Mon, 21 Sep 2026 14:02:00 -0700
Message-ID: <20260921210200.1723894-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921210033.1715000-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
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
 tools/lib/bpf/linker.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 78f92c39290a..1f512eff5895 100644
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
@@ -2274,6 +2276,38 @@ static int linker_append_elf_relos(struct bpf_link=
er *linker, struct src_obj *ob
 						insn->imm +=3D sec->dst_off / sizeof(struct bpf_insn);
 					else
 						insn->imm +=3D sec->dst_off;
+				} else if (sym_type =3D=3D R_BPF_64_NODYLD32 ||
+					   sym_type =3D=3D R_BPF_64_ABS32) {
+					/* Two spellings of the one thing: LLVM
+					 * emits NODYLD32 for a .long against a
+					 * section symbol, GNU as emits ABS32
+					 * (bpf_reloc_type_lookup() maps
+					 * BFD_RELOC_32 to it), and the value
+					 * they describe is the same.
+					 */
+
+					/* Only an executable section has its
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

