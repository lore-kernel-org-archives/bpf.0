Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C5522EF6
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911427; cv=none; b=DYrzCzi8oqHX27Kidtw73rAAVYRuxXhDNvcFwEInKKIWUy60MSebgu59/I1OMJhh3KuaQDxE3hRX03B0zY2Vi+Q8BtMkkkmxChe8JOP3dr2otU8nmkzPm4ry7HXTTbyt7aSPiRWO7qsZBc4jz+kKvrNbKGiVxb/0vNTYpflCyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911427; c=relaxed/simple;
	bh=0OV49xSqDA9obU81wxSc+rVG3vdNtIJf6KKBq3fgOj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6/rJSA4ZgaUnshAYPi561Khh01F0fCByjaUGLkaOJJ7IRBHOEm5/3YsIMAXz1XFPQIiWuvVBTTJvPkSPuN3T5bkoPOhTFdcn7g1pehAld/9nny6zrKT4qm//G0NxGSxhHhsej2kRVo/RuB9YF+TgbBBFnLg5vHMgp7YI1pDq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9DAFC30FB5C5F8; Tue, 13 Oct 2026 10:10:24 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 08/11] bpf: Refuse a trampoline on an unreliable static function with stack args
Date: Tue, 13 Oct 2026 10:10:24 -0700
Message-ID: <20261013171024.2136303-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013170910.2126673-1-yonghong.song@linux.dev>
References: <20261013170910.2126673-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the BTF of a function in the target program is unreliable, the
model of the function given to its trampoline is MAX_BPF_FUNC_REG_ARGS
u64 arguments. The verifier takes a static function's stack arguments
from its BTF before it finds the BTF unreliable, though, so such a
function can still take more: one with six or more arguments, one of
them a plain pointer, for example. The trampoline saves and restores
five registers then. After an fentry program, the rest of the register
arguments, r9 on x86-64 and x5 to x7 on arm64, hold whatever
__bpf_prog_exit() left there, and for fexit the stack arguments are not
copied either, so the function goes on with garbage in arguments the
verifier checked, pointers included.

Refuse the attach when such a function has more argument slots in its
BTF than fit in registers. The main program is left alone: it takes only
its context, and the verifier gives it no stack arguments when its BTF
is unreliable.

Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c7af14a3f0e8..1f24806aeba3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22028,6 +22028,33 @@ static int flatten_bpf_func_model(struct bpf_ver=
ifier_log *log, const char *tnam
 	return 0;
 }
=20
+/*
+ * The verifier lets a static function use stack arguments counted from =
its
+ * BTF, even if that BTF turns out unreliable. A trampoline on the funct=
ion is
+ * then given only MAX_BPF_FUNC_REG_ARGS u64 arguments and would lose th=
e
+ * stack arguments, so such a function cannot be attached to.
+ */
+static int check_unreliable_func_args(struct bpf_verifier_log *log, stru=
ct btf *btf,
+				      const struct btf_type *func_proto, const char *tname)
+{
+	struct btf_func_model m;
+	u32 i, nslots =3D 0;
+
+	if (btf_distill_func_proto(NULL, btf, func_proto, tname, &m)) {
+		/* at least a slot for each argument */
+		nslots =3D btf_type_vlen(func_proto);
+	} else {
+		for (i =3D 0; i < m.nr_args; i++)
+			nslots +=3D btf_func_model_arg_slots(&m, i);
+	}
+	if (nslots <=3D MAX_BPF_FUNC_REG_ARGS)
+		return 0;
+
+	bpf_log(log, "Cannot attach to static function %s: unreliable BTF and s=
tack arguments\n",
+		tname);
+	return -EINVAL;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -22295,8 +22322,14 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
 		     prog->aux->saved_dst_attach_type !=3D tgt_prog->expected_attach_t=
ype))
 			return -EINVAL;
=20
-		if (tgt_prog && conservative)
+		if (tgt_prog && conservative) {
+			if (subprog > 0) {
+				ret =3D check_unreliable_func_args(log, btf, t, tname);
+				if (ret)
+					return ret;
+			}
 			t =3D NULL;
+		}
=20
 		ret =3D btf_distill_func_proto(log, btf, t, tname, &tgt_info->fmodel);
 		if (ret < 0)
--=20
2.53.0-Meta

