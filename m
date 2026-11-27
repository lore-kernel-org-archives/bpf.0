Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805029;
	b=XoADviBgPGZBQPCxmQkfPQITf8guFBWjaUmdwS0lzDHSW7NS1FDvDUL0Z2r0ED7fBago
	 min1rhx++IBDQdSmmsBvdKPHLx9mEbXHuqTr4Pkg2vsyOiZ65H7l0jD5WIHggKPmi5zOb
	 8jrM6zzhKWnGp8cIlmx62b0bp5uW/yhhh61FtERhT9P5elA58ZfWorOqa+k/T8kk6+ls3
	 aOmrmSwPHsggXg5m6S143E2X7+yql2u+mAtuv4sK/V4p62B6clJnxQoONsTwuhmRE6sPq
	 sVpBEshv13idakPry14jgk44rvuqNiMgN9e2VmMwGf67kqP5+6TyUkgax2Q3e1VcF/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805029;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PcGKCF9NQYxnfH1jE5CL3eZ1ksDoUJbHaXQr8LodNQ0=;
	b=fNFRIuGpNRVgroRkgjKF8ljz3W/DsOFV+Ovuhe9UMfvV/AoRie0QSMnL49hd4uT60GjA
	 5ZzqjA7GTgezFp/VGeek+CP90SwuBsOEgpelTZ7oKVjIevQJiENIQQFQXNYSSQNzcCGka
	 5lsAQFWJ4ZVRYUOGvfslmlZqYWfA0eJSwM+L1D3jXHdirn8ih3tzb9sXEg+idYA+XK3hU
	 R522jOpACBZJl5/1Sf88CkY5hG0EQ8sC2RbHFN4xGLcQGgN/QOzWdEnouRhUamkA4sY69
	 QZNal/NEUM+BTp8wFSRxtCwvpTScwsjrxDZ0GoMoRP+hYJUEfg8LUwHS1TaiG0V95/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.180
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25512606A31C
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 18:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25512606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 6821B59F378F7; Fri, 27 Nov 2026 10:43:34 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next] libbpf: Fix ALU relocation check for a local value with bit 31 set
Date: Fri, 27 Nov 2026 10:43:34 -0800
Message-ID: <20261127184334.860594-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit 776281652ddc ("libbpf: Permit 64bit relocation value"),
the local value of a relocation is a __u64, and libbpf checks it against
the imm of an ALU or ALU64 instruction with:

  if (res->validate && insn->imm !=3D orig_val)

The __s32 imm is sign-extended to 64 bits for the comparison, so it does
not match a zero-extended local value with bit 31 set, e.g., 0x80000000,
and the relocation fails with "unexpected insn". Before that commit, both
sides were compared as 32-bit values.

The values patched into an imm so far, field offsets and sizes, bit
shifts and type sizes, are below 2^31, so this did not show up. With
the llvm change [1], clang loads the value of an unsigned int enumerator
of a preserve_access_index enum with a 32-bit mov:

  enum U { M =3D 0x80000000 } __attribute__((preserve_access_index));

  unsigned long f3(void) { return M; }

is compiled to:

  f3:
    w0 =3D 0x80000000      /* CO-RE <enumval_value> enum U::M */
    exit

Without this patch, libbpf rejects the relocation of such a mov with
"unexpected insn", so a program built with the llvm change fails to
load. Compare the imm with the low 32 bits of the local value, which is
what the imm holds. Any local value accepted before is still accepted,
since its low 32 bits are the imm. What is newly accepted is a value
whose upper 32 bits are not the sign extension of bit 31, e.g., an
unsigned int value with bit 31 set.

  [1] https://github.com/llvm/llvm-project/pull/246702

Fixes: 776281652ddc ("libbpf: Permit 64bit relocation value")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/relo_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 58c782cc60e8..b54227faf670 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1067,7 +1067,7 @@ int bpf_core_patch_insn(const char *prog_name, stru=
ct bpf_insn *insn,
 			goto bad_insn;
 		if (res->poison)
 			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
-		if (res->validate && insn->imm !=3D orig_val) {
+		if (res->validate && insn->imm !=3D (__s32)orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: =
got %d, exp %llu -> %llu\n",
 				prog_name, relo_idx,
 				insn_idx, insn->imm, (unsigned long long)orig_val,
--=20
2.53.1-Meta

