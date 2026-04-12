Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A889475
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775970023; cv=none; b=IqBvaJS5BTshqTbmGl5f9lyZyHBnHAS7PJVwJz4nMnBXq8i1IrEEBPFBr35bXF2O+daF+wrFRkaAs08zN5vvWauh760mLOYeS4F36OUZEr7FFnt68tUyPB8dv9+YlczwZAUPyWOE4Hpia52dOTyq6j9pVU0hdf9Oo4ePzt9FJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775970023; c=relaxed/simple;
	bh=/VANlIrMcOdGBRhisNYMQo2n8w2kkMcYYCy39542QSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UINNCQxgELDx18HxaslTWHLvbPzLF1gdX8aieDK05ApvAY7Y0HWzHukXNPhVNbhJMdk5Bnoxss4YazCw3VfCXR1Gm1WgVape1+/vsbERbUw5chqs7IolBlE9Ty77+yn7Q9igyLs0Z/HrVbbFqj6sHRGMnunFdqMz5myrz3ij09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B9DF53B021C03; Sat, 11 Apr 2026 22:00:10 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 12/18] bpf: Reject stack arguments if tail call reachable
Date: Sat, 11 Apr 2026 22:00:10 -0700
Message-ID: <20260412050010.266625-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412045826.254200-1-yonghong.song@linux.dev>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tailcalls are been deprecated. So reject stack arguments
if tail call is in the way.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20fb53ead728..45987041bb2a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7175,6 +7175,11 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
 				verbose(env, "cannot tail call within exception cb\n");
 				return -EINVAL;
 			}
+			if (subprog[tmp].incoming_stack_arg_depth ||
+			    subprog[tmp].outgoing_stack_arg_depth) {
+				verbose(env, "tail_calls are not allowed in programs with stack args=
\n");
+				return -EINVAL;
+			}
 			subprog[tmp].tail_call_reachable =3D true;
 		}
 	if (subprog[0].tail_call_reachable)
--=20
2.52.0

