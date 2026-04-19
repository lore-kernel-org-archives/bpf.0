Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB79253B42
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616410; cv=none; b=p1NaE6wZenX5lPtwVUg89f1e0wqQrTZEKnxHSiGAan23H+Ucf7OurQtQ/FU3+dCfAPElfBUn5jCIpa43ENlAL9FX0a1YnI8CK94qm7ZESEggy5LUNDY1OVB/dI747hWrezakrli3Gc4TV8BzJzmUlF2XWpcNQ9tlvN0hXFvdlDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616410; c=relaxed/simple;
	bh=YDjCvPVVnRyWJYf/8B3OQdypQ3laVxkir80SDpgKH0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Unsv6CBR8RB3Agbsgy9jQDEL4ug93FsZ4L+/MDe+/YpX6cBNoOGLk2UTrSdYPAixARYNRL/kV2h9sbP8rM/qtofr3hGOtoOJQAfR00pumLBAgj9gJsAZti0vfFWvFrW0CcjVHU0VdEODqkfrEggpvrMD4Cs/VHpK7w1WpalUH1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8DE3542DD4D36; Sun, 19 Apr 2026 09:33:21 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 01/17] bpf: Remove unused parameter from check_map_kptr_access()
Date: Sun, 19 Apr 2026 09:33:21 -0700
Message-ID: <20260419163321.732300-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260419163316.731019-1-yonghong.song@linux.dev>
References: <20260419163316.731019-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The parameter 'regno' in check_map_kptr_access() is unused. Remove it.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69d75515ed3f..0f9da0f6220b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4719,7 +4719,7 @@ static int mark_uptr_ld_reg(struct bpf_verifier_env=
 *env, u32 regno,
 	return 0;
 }
=20
-static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno=
,
+static int check_map_kptr_access(struct bpf_verifier_env *env,
 				 int value_regno, int insn_idx,
 				 struct btf_field *kptr_field)
 {
@@ -6366,7 +6366,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 			kptr_field =3D btf_record_find(reg->map_ptr->record,
 						     off + reg->var_off.value, BPF_KPTR | BPF_UPTR);
 		if (kptr_field) {
-			err =3D check_map_kptr_access(env, regno, value_regno, insn_idx, kptr=
_field);
+			err =3D check_map_kptr_access(env, value_regno, insn_idx, kptr_field)=
;
 		} else if (t =3D=3D BPF_READ && value_regno >=3D 0) {
 			struct bpf_map *map =3D reg->map_ptr;
=20
--=20
2.52.0

