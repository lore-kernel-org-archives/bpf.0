Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135738E8CE
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242731; cv=none; b=GfOVzEbhObUsvr338a9IYdH6/osbekyLvlgLvUWS3B+Q6lIwn5dvHL3PVGBqP1GAW6n44Nw2Ao6Dyd8GDOSjGQe3eN48Vrptv9R++umKQ6x3grnECXw8b75f4eIfxohQ/kcC7JvHcJfaA8KpN8ZbAaXdJc+r2JXCJ3eKmhK3PiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242731; c=relaxed/simple;
	bh=pQsVXLmRZh9Lh1Oa+cBtftnUx8eNdU6Iquz79yERt5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tB93ut+YQ197IOp5LqfXWDl0rcV9S98GZ0Heit0RhZ+Oq2jF4PNqyRAKxnWzodykd/TFSFA0+dOjqu7g2JOmlLLGTVtHSVSyV2CHTrOziIDX8o3ijGLAGbbE3UMmC8G22+ck/bMJyKKUFCGw/XOsM7r1mOy2WVDASUZV4P1rKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7A55D2A58A0B1B; Sat, 12 Sep 2026 12:52:01 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 01/15] bpf: Read a kfunc's __sz argument only when it is in a register
Date: Sat, 12 Sep 2026 12:52:01 -0700
Message-ID: <20260912195201.982215-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912195156.980886-1-yonghong.song@linux.dev>
References: <20260912195156.980886-1-yonghong.song@linux.dev>
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
index 617a277c3558..0c6a404167ca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13641,13 +13641,14 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_ver=
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
2.53.0-Meta

