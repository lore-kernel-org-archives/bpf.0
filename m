Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077E139185A
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647848; cv=none; b=GDLlzZbWgkZRR+/iTH2Y27xF20oAcfDsQfNFc6lB7DZTrEE1DrprdxjkaQrsoM51sMSY0vAOkTDzRxNpmlZy4Sx2jLA7nP8WmN97Vo7g1srPhKzuiQRIpzV8deFn42AbM/zRSDIRWPZKQLKkxpCcg8kiZA2kbYGXQMy5P7OCyHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647848; c=relaxed/simple;
	bh=OZuxyfKdq5ABvDF/PxTzsu/Mxagk+b0jaI1IKJRB7BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqhf/CBc/cKkCNYsBMGrCsLUU5XhsgoH4V7m4r5OYMY8FhB0eolgqtBP1IG8gGShfZ5xjPUZk1P77C1gAW6OJek2z57Hd5+VCwadat8ifhpPJNbjFzhkCsuSXgqdLDS/KFtBVDqHL22WC5VrRN8lID2GEH7sVfdRA91TtG0zico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DC808B1946A14; Tue, 12 May 2026 21:50:35 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 09/25] bpf: Use arg_is_fp() in has_fp_args()
Date: Tue, 12 May 2026 21:50:35 -0700
Message-ID: <20260513045035.2388671-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513044949.2382019-1-yonghong.song@linux.dev>
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace "frame !=3D ARG_NONE" with arg_is_fp() in has_fp_args().
The function's purpose is to check whether any argument is derived
from a frame pointer, which is exactly what arg_is_fp() tests
(frame >=3D 0 || frame =3D=3D ARG_IMPRECISE). Using the dedicated
predicate is clearer and more consistent with the rest of the file.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/liveness.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index c81337dfbfc7..13dc5ae44d2b 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1689,7 +1689,7 @@ static int compute_subprog_args(struct bpf_verifier=
_env *env,
 static bool has_fp_args(struct arg_track *args)
 {
 	for (int r =3D BPF_REG_1; r <=3D BPF_REG_5; r++)
-		if (args[r].frame !=3D ARG_NONE)
+		if (arg_is_fp(&args[r]))
 			return true;
 	return false;
 }
--=20
2.53.0-Meta

