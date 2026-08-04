Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFAA4C77B3
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875763; cv=none; b=USEvpJl9QBVluk64YXiD85Fs4f3vVTPvlN4YTaorwQDXKulkhQat4QuSRHwiEfnjTc0d4Cbq77uE1yKkgpM3lZftLl2NlXkJ5Dgd9EaW+Gupgrs2xjBVyW5jKhtKuCFaW0QoZDQ5s0EYlrK9/rChonvizzcB/hg/85jmAmC1WR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875763; c=relaxed/simple;
	bh=9WKRbLie67WIjf0MJbqRIOo4x5/fwdtpb48x6V4tkUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owi0hxnZhrwz1K/qOfCvYr8VUdWfvRvmqXgltg8LK87sdOkWmKBZIPx+imob2okdEv8hTn0/RSiat3FLh6FXSPzbqWDgu5yr9dbKdf/SavmW8FCMlEkntLLNdfcVscYleIgcB0N4d4PvbLLzLHXm3Gz73Ta2+1Fqx5R1C2+0Xw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 60C0421FBFEE99; Tue,  4 Aug 2026 13:35:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 06/13] bpf: Reject callbacks returning more than 8 bytes
Date: Tue,  4 Aug 2026 13:35:53 -0700
Message-ID: <20260804203553.1873415-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804203522.1869244-1-yonghong.song@linux.dev>
References: <20260804203522.1869244-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A callback handed to a helper or a kfunc (bpf_loop(),
bpf_timer_set_callback(), bpf_for_each_map_elem(), ...) is invoked
through bpf_callback_t, and an exception callback is invoked by
bpf_throw() through

  u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);

Both prototypes yield a single u64 in R0, and neither caller has any
notion of a second return register, so a callback returning a value in
the R0:R2 pair would have the upper half of its return value silently
dropped.

Reject both at load time:

 - check_ld_imm(): a callback is materialized as PTR_TO_FUNC by an
   ld_imm64 pointing at its subprogram, so the subprogram's return
   convention can be checked where the callback pointer is created,
   before it ever reaches a helper or kfunc argument.

 - do_check_common(): an exception callback is not referenced by a
   PTR_TO_FUNC, it is named by a BTF decl_tag and verified on its own,
   so check it as its frame is set up, next to the existing "cannot
   return void" and single-argument checks.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 282aee7fc44c..5584178a0e1c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16426,6 +16426,11 @@ static int check_ld_imm(struct bpf_verifier_env =
*env, struct bpf_insn *insn)
 			verbose(env, "callback function not static\n");
 			return -EINVAL;
 		}
+		if (bpf_ret_reg_pair(env, subprogno)) {
+			verbose(env,
+				"callback function with >8-byte return value is not supported\n");
+			return -EINVAL;
+		}
=20
 		dst_reg->type =3D PTR_TO_FUNC;
 		dst_reg->subprogno =3D subprogno;
@@ -18650,6 +18655,12 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
 				ret =3D -EINVAL;
 				goto out;
 			}
+			if (bpf_ret_reg_pair(env, subprog)) {
+				verbose(env,
+					"exception cb cannot return value larger than 8 bytes\n");
+				ret =3D -EINVAL;
+				goto out;
+			}
=20
 			/* Also ensure the callback only has a single scalar argument. */
 			if (sub->arg_cnt !=3D 1 || sub->args[0].arg_type !=3D ARG_ANYTHING) {
--=20
2.53.0-Meta

