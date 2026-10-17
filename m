Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257F3BED18
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205619; cv=none; b=uP/5ovoRObKgzW5LU6kzFyHGCujASC0aBVmb+/AJekuBdtEJ90mMtq9CUi5VPoyuxvBaB4LA+68CwY42CL823KqmL/ijm+pN/qhjXx9mDwZUQIsHJl9hhBFHh7xfjNEgCAyFcIWNqStU114h/rBBthnIfER8Wids6dVzzrEIuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205619; c=relaxed/simple;
	bh=8TGaxZNoUxqEkCsEuTsTTm+8nt1zAbm2l9CMDoaKB7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZ9PBXZ4QVOgC+oUZi8dB1K6ZyAWJ6EO4soJemi0nys12aDqOtALfoiocXiQ1G1gj5KLX4fvcPbj12jlhMbMEnb8x9wEljEtFJqVJmqDilA5qVy7JZfEMOinknqE7CUmpj7/RjLx89a8jgudSRrER0T/10qS6NHhWu2jwv6mHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D2C7F31B3B0163; Fri, 16 Oct 2026 19:53:18 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v12 21/25] libbpf: Let the static linker carry .bpf_cleanup relocations
Date: Fri, 16 Oct 2026 19:53:18 -0700
Message-ID: <20261017025318.1930949-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017025129.1914859-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
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
 tools/lib/bpf/linker.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index f3f71c452f00..911a649219a9 100644
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
@@ -2297,6 +2299,41 @@ static int linker_append_elf_relos(struct bpf_link=
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
+					 * The sanity check only checks the
+					 * alignment of r_offset, and only for
+					 * an executable section, and SHT_NOBITS
+					 * has no raw_data, so check both here,
+					 * bounding by subtraction so it cannot
+					 * wrap.
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

