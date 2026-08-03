Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CF30E821
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734863; cv=none; b=E6Ce26bH6OMh3etGXDJZ09naCXLR90U9xbswm4cbxEKBSTjg+746TZptDtskOjtJkxaoi7taPWsIDIdLMIPlQxYqGnBisTfa+BD62BBt+o3bOUqLVcOuMujHBgiPWBN/bhUdoOswVVRW7zQ5cNRiXoglSKb0yCit2pH2DltdBE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734863; c=relaxed/simple;
	bh=jf34D3jeH++0m0AmUMcGFUSNs/utWgIb0J/XMY7ic+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bH8BALhCNasFYU9xE+CrTr7hOwpyJ6FvHmCadToR8wYdkPM6MHtyoiZESBEXFC1cXwsUzZy26xhCdWMBfEtYThCODMZQHo5ROcCjqc9fC2f7VNLMSoCMXFjoWYd7IqjFQ/58/2KOYXXExksXorwoSLl/pRVRSEvzBSmETGS/3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 73AC821A73763A; Sun,  2 Aug 2026 22:27:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Remove unused BTF_FMODEL_STRUCT_ARG
Date: Sun,  2 Aug 2026 22:27:26 -0700
Message-ID: <20260803052726.2821447-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 814cba835ef6 ("bpf, x86: Fix trampoline stack size for 128-bit
arguments") changed the x86 trampoline to compute the number of
registers from arg_size for every argument, which removed the last user
of BTF_FMODEL_STRUCT_ARG. No other architecture or verifier code looks
at the flag, so remove the macro and the code in __get_type_fmodel_flags(=
)
which sets it.

Keep BTF_FMODEL_SIGNED_ARG at BIT(1) rather than renumbering it to
BIT(0), so BIT(0) is available for a future flag.

No functional change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h | 3 ---
 kernel/bpf/btf.c    | 2 --
 2 files changed, 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 356884587ae1..73bacfc6444d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1207,9 +1207,6 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
=20
-/* The argument is a structure or a union. */
-#define BTF_FMODEL_STRUCT_ARG		BIT(0)
-
 /* The argument is signed. */
 #define BTF_FMODEL_SIGNED_ARG		BIT(1)
=20
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5e8ac45ce56a..42414633cf26 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7533,8 +7533,6 @@ static u8 __get_type_fmodel_flags(const struct btf_=
type *t)
 {
 	u8 flags =3D 0;
=20
-	if (btf_type_is_struct(t))
-		flags |=3D BTF_FMODEL_STRUCT_ARG;
 	if (btf_type_is_signed_int(t))
 		flags |=3D BTF_FMODEL_SIGNED_ARG;
=20
--=20
2.53.0-Meta

