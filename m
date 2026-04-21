Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E08279334
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791987; cv=none; b=qVMQte9fZxy8akKzgDKT3G8HP2Nw6iRI4NKRlY1Sz3xP6HpegfnHnfaU+g0M6zbUCGLSBJKkxBF40vyFmnHTNcMRQaY387WwG73ojwASAY+EUdV2k1GPqs19eR28x1r3EP2bSBjwrF6YutAp948SRrsgVUoOsHdcHS8CWOYlqsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791987; c=relaxed/simple;
	bh=CKh3A3ERdXZKbq5RyiFgao6qwj3XsokL8qaJgk4SLR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdZkPZXMp3HfKge295hHMl8ryzYxBc7SkzSmnr3j3RCGeqPEwFLcTtyjBywQYBR7eqrsmMTw0f3Yo7/ZHl8curvdUe4MFM0eX1vyYCa4pkMNUuMSeaN1ywsRKoZozJegUldSf6HtXGpNUP9M3AfTKdTTzHkO5hOHf51TX8X1XnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 38B0444B27930; Tue, 21 Apr 2026 10:19:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next 1/9] bpf: Remove unused parameter from check_map_kptr_access()
Date: Tue, 21 Apr 2026 10:19:32 -0700
Message-ID: <20260421171932.3508283-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421171927.3507554-1-yonghong.song@linux.dev>
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The parameter 'regno' in check_map_kptr_access() is unused. Remove it.

Acked-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 185210b73385..a768359b22cb 100644
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

