Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B909825C80E
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809813; cv=none; b=oFjf5GHEKStYpdn9SdjBpiVvPM4TJnNaHzlC1PVjHjnrRMLmKjew4oe92+osxdgi3L+ANTzP7u0BVnOqo8bgwRwWqEZKoYg5gXcb/KL8rdZXrSJ3s3HCNMCI1ue58pdJBQF6lvb8Rrk5Nd0KwCVfmZLzgdq5wOlSOKY96py6VfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809813; c=relaxed/simple;
	bh=mxpgrKhu3R23iKYdIz69mtmqwkXqQKXCqxVotpUas9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdCJ3AaqUgZKb6ynFZoR+OocX/k4QJQQXi4Rpk3optoQxz4dk2+63WbmG80ivD2uR3/my+KHeHyJJ22PBmkzBqWi1ZjlKVqN5wVkn5VVX2aMFJAKw2sGgcCRl1Lb/r0preQ9DHLEXfDG8dCW/19c1mGaRDt/6wit9Q10d8hqsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 27195BBC9CCE9; Thu, 14 May 2026 18:49:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/2] bpf: Validate outgoing stack args when btf_prepare_func_args fails
Date: Thu, 14 May 2026 18:49:58 -0700
Message-ID: <20260515014958.1186132-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

btf_prepare_func_args() sets sub->arg_cnt before validating arg types.
If validation fails (e.g. unsupported pointer type in a static subprog),
check_outgoing_stack_args() is skipped because btf_check_func_arg_match()
returns early. For static subprogs, check_func_call() ignores non-EFAULT
errors and proceeds with the call.

This causes the callee to read stack arg slots that the caller never
stored or not initialized, potentially dereferencing NULL caller->stack_a=
rg_regs
or getting no-initialized value.

To fix the issue, when btf_prepare_func_args() fails and the subprog expe=
cts
stack args, call check_outgoing_stack_args() to verify the caller initial=
ized
the slots. Return -EFAULT on failure so the error is not ignored.

Fixes: 3ab5bd317ee2 ("bpf: Set sub->arg_cnt earlier in btf_prepare_func_a=
rgs()")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Changelogs:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260514184827.1619863-1-yonghong.s=
ong@linux.dev/
    - Remove Reported-by (Sashiko) and add Fixes tag.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 76a07f09ab64..8dd79b735a69 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9118,11 +9118,17 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
 	struct bpf_func_state *caller =3D cur_func(env);
 	struct bpf_verifier_log *log =3D &env->log;
 	u32 i;
-	int ret;
+	int ret, err;
=20
 	ret =3D btf_prepare_func_args(env, subprog);
-	if (ret)
+	if (ret) {
+		if (bpf_in_stack_arg_cnt(sub) > 0) {
+			err =3D check_outgoing_stack_args(env, caller, sub->arg_cnt);
+			if (err)
+				return err;
+		}
 		return ret;
+	}
=20
 	ret =3D check_outgoing_stack_args(env, caller, sub->arg_cnt);
 	if (ret)
--=20
2.53.0-Meta

