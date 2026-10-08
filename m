Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E6B3BC68A
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445901; cv=none; b=ZkXtAP6OeVg9EAj25PedfLxy6gtrVEaSB0T/QC1FRga5QE/pHx81GqZWPjjQIOw52d3q/MEIBXOmkPKuHu/qgl4OOx/NokzxBEcFXy6E3/uhsGNGDJLNNQZqoSlkLmIzZiOUNWx7z/oDOwIrNg21szC76ex/DUh1cJKG+xlhKDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445901; c=relaxed/simple;
	bh=0EMkPMqhQ9vW3b5bMAfVrp396HFmClCeaLlCG5vompY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elDl+iFiWBg9y2o7EXDbBCKz8jhA2TbIQDmxyhG7zCc5KiygZcyRmVYmz+rWHNQ/ECRfs0BFj1TdsUqjHnvcAUShja8wOmjldkDg65bUn4CRPss5zW8B2Y4V1C16yiUJHKVOkKeld41mu7mKhDi/XDtG1p4MdALSsWWNtMhwToo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E33132FDA0C8A8; Thu,  8 Oct 2026 00:51:36 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v9 19/23] libbpf: Let the static linker carry .bpf_cleanup relocations
Date: Thu,  8 Oct 2026 00:51:36 -0700
Message-ID: <20261008075136.3008537-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008074959.2993751-1-yonghong.song@linux.dev>
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Each field of a .bpf_cleanup record is a byte offset into a code
section: a 32-bit relocation against that section's symbol, with the
offset as the implicit addend. The linker refuses it: it does not know
LLVM's R_BPF_64_NODYLD32, and from a non-executable section it takes a
relocation against a section symbol only as a 64-bit pointer to code.

Take it in both spellings, R_BPF_64_NODYLD32 from LLVM and
R_BPF_64_ABS32 from GNU as, adding the code section's new start to the
stored byte offset. Since any non-executable section can now reach that
path, it checks itself what the old refusal covered: that the target has
data, and that r_offset is aligned and in bounds.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/linker.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index f3f71c452f00..c607f51e3cb4 100644
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
@@ -2297,6 +2299,39 @@ static int linker_append_elf_relos(struct bpf_link=
er *linker, struct src_obj *ob
 					if (linker->swapped_endian)
 						off =3D bswap_64(off);
 					memcpy(ptr, &off, sizeof(off));
+				} else if ((sym_type =3D=3D R_BPF_64_NODYLD32 ||
+					    sym_type =3D=3D R_BPF_64_ABS32) &&
+					   (sec->shdr->sh_flags & SHF_EXECINSTR)) {
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

