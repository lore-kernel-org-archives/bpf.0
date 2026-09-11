Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45D4483A4
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141773; cv=none; b=NIkoPA34OpuSwxwE5/0km1Y52nOdmMOIACXcX7lCkXX/4U42+Q8lgQr8NzWoJSjkeEhkYHj6f9JZwMH7wifIvDa6ypBX/XQAnLJGpKEnqErzzfreDjrUuF2wk8lLvUgwX+E+CgcFuOSssMVCWMjdqNnNn4yxq6drNABbecF5/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141773; c=relaxed/simple;
	bh=jzbuXTm1SWI9vzuOpyQXIc9vaVPrbNdZMgORR0o9zeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eu/dFjvNvW4q36F81xCZkDGyMrsJC1CeL62SNN18L8OpieerdWW1q4tvqttA3b+UfvDOfwTMwvufn6mNO/OXHWSHqZT6yecOzTs7/4RKzKc7PBBHJKPEC6LOPnG9hh3qYkgXP1MgPkw7xIM2lH9BpoxpucRorWCkx4FLMnC2pds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5321A2A1842F70; Fri, 11 Sep 2026 08:49:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 01/15] bpf: Read a kfunc's __sz argument only when it is in a register
Date: Fri, 11 Sep 2026 08:49:19 -0700
Message-ID: <20260911154919.2004782-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911154914.2004336-1-yonghong.song@linux.dev>
References: <20260911154914.2004336-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit e0b7b91c72db ("bpf: Support stack arguments for kfunc calls")
supported stack arguments for kfunc's. In bpf_kfunc_stack_access_bytes(),
the size of a ptr + __sz pair is read from const_reg_vals[] at index
'BPF_REG_1 + arg + 1'. Past the fifth argument that index leaves the
argument registers and reaches 6 through 9, which are the callee saved
registers R6 through R9. The verifier does record constants for those,
so a __sz argument passed on the stack can take the value of an
unrelated register as its size.

Fix it by guard size_reg which has to be less than or equal to
MAX_BPF_FUNC_REG_ARGS.

Fixes: e0b7b91c72db ("bpf: Support stack arguments for kfunc calls")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e79750e2480..fed576b8f7fe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13771,13 +13771,14 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_ver=
ifier_env *env, struct bpf_insn *
 		goto out;
 	}
=20
-	/* ptr + __sz/__szk pair: size is in the next register */
+	/* ptr + __sz/__szk pair: the size follows the pointer */
 	if (arg + 1 < nargs &&
 	    (btf_param_match_suffix(btf, &args[arg + 1], "__sz") ||
 	     btf_param_match_suffix(btf, &args[arg + 1], "__szk"))) {
 		int size_reg =3D BPF_REG_1 + arg + 1;
=20
-		if (aux->const_reg_mask & BIT(size_reg)) {
+		if (size_reg <=3D MAX_BPF_FUNC_REG_ARGS &&
+		    (aux->const_reg_mask & BIT(size_reg))) {
 			size =3D (s64)aux->const_reg_vals[size_reg];
 			goto out;
 		}
--=20
2.52.0

