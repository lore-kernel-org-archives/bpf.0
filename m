Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E2263C7F
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 03:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915285; cv=none; b=L9sR49gfkIb1BpWF5Momn4L+hVGwl56Q/3wmeAij5IxZoynnae/tSJvkyQIcOrvrwqCSfI1yzgsQ+HxgimLoOvi8scF51IYSR/KwwP3Dlt4GvVx0zh6fzZLfcnXYgRGoMMVa2cN0CVI4Yw/qr4F8ttnXv52L/7cLjrBg0yyf/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915285; c=relaxed/simple;
	bh=ohRR90Z7czEtjyDDx87srrDBVCleMg3d9DJq5eu6vWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dpffb4lEUsFYjNLDaugeGElnHsa+0ZYjdrFbm1Z86ywTJq7bQ8w4Mf8RlfpHn2GArhRm9ThGQBE1Z/7cm0XR8Usx9Wy0ElveeQusaVsMmSbt76z7dgoeegwBI0/6gJKgFb0UTj+Ou6Ku12qvRrItbdWh/c88vxpAUgRYooFOEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D5D6A45844AC0; Wed, 22 Apr 2026 20:34:30 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3 1/9] bpf: Remove unused parameter from check_map_kptr_access()
Date: Wed, 22 Apr 2026 20:34:30 -0700
Message-ID: <20260423033430.2537615-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423033425.2536883-1-yonghong.song@linux.dev>
References: <20260423033425.2536883-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The parameter 'regno' in check_map_kptr_access() is unused. Remove it.

Acked-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5b4806fdb648..6118743d87e6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4710,7 +4710,7 @@ static int mark_uptr_ld_reg(struct bpf_verifier_env=
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
@@ -6357,7 +6357,7 @@ static int check_mem_access(struct bpf_verifier_env=
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

