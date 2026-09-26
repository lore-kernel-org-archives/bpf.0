Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90F21767D
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398855; cv=none; b=luDe07CduA0XRvxXGs35Fh9qLwXbiri5s6PT++NhHApe/DI20Kd83gqzkZs3FooRrCuvy9K2WHH6zFw+Z8AlaOlkKxDKcK5O27wifO3/42LEjkjMyFmQshoOcDdB0EnWp5jIURwn+GZFJ5ZwzwHuq3cdmBDM8pEhM6lLksp8XmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398855; c=relaxed/simple;
	bh=NlpZYod+Hl7MrGMTeoG9oK1zvIKV3i1xN/RJhp7BwAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzGorqD1xnn3zJA1N554s+B7pw+R9ME53lNapEd/L4No0yjJ/xGH1LSlIqFXaxVKyS5msj4Z7uAwu5fFkqPOeU331O6hF1PHTH+lqxgEde4AIt4cS3BmU8PxrenGBfvfk9mV6NNW0nXiojPOHShvmofLFZ3LBINKy3aYW9dkWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 776182D45901C4; Fri, 25 Sep 2026 22:00:52 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 09/21] bpf: Refuse a private stack for a program with an exception cleanup table
Date: Fri, 25 Sep 2026 22:00:52 -0700
Message-ID: <20260926050052.2216947-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926050006.2213110-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An unwind resumes a frame at its landing pad rather than at the instructi=
on
after the call. On x86-64 that skips the pop which restores r9, where a
private stack keeps its frame pointer -- the JIT brackets every call in
push_r9/pop_r9 and the pad is reached before the pop runs. The pad would
then address its frame through a stale pointer. Refused on every
architecture rather than just that one.

Force NO_PRIV_STACK in check_max_stack_depth(), where the choice is made.
The subprograms below are then checked against MAX_BPF_STACK together
rather than one at a time, so this can turn a program that would have
loaded with a private stack into one that is too deep.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cc1ed776da15..677bab92f624 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5751,6 +5751,19 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 		}
 	}
=20
+	/*
+	 * An unwind resumes a frame at its landing pad rather than at the
+	 * instruction after the call, and on x86-64 that skips the pop which
+	 * restores r9 -- where a private stack keeps its frame pointer. The
+	 * pad would address its frame through a stale one. Refused on every
+	 * arch rather than just that one. The subprograms
+	 * below are then checked against MAX_BPF_STACK together rather than
+	 * one at a time, so this can turn a program that would have loaded
+	 * with a private stack into one that is too deep.
+	 */
+	if (env->cleanup_info_cnt)
+		priv_stack_mode =3D NO_PRIV_STACK;
+
 	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
 		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
=20
--=20
2.53.0-Meta

