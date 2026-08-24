Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF42D0C82
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582999; cv=none; b=pu7HytN5SSzhIo1trPUmqor/934j3TQYnJOBRJVpbjohZIrsxpH0F8zfqW4WDHGgtxVo7k6VDEdVHuGDDLV8oThK65HdpCDgsOPBBFg53WrcU4wOt0Y4YkJDfn8ND4w8SbodaxhuMEECLgewHk0i/4KlFa93q1UgM9aVskzlo7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582999; c=relaxed/simple;
	bh=aV0klniMvKgnkCHy057kM3WBJl5pOIdxArZ3e6Te7DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vAA8YVnq/osaflGcdhxCp9f0d2MzGjBGYW7nSsMQ5KWZLDpzqCHbxYvlDwNKgQdBKwGMMkYWOSIScGr/COKVAHICbfqVuKu2+51uKRgjs8HQOnA+OweDrli/RpyXWSnwMVp/1cYlAh8bLaE9uMe4XHE62xJrKJfeCfRpWPkRPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9C3CA263E89C5F; Mon, 24 Aug 2026 07:49:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Record each half of a paired return value in verifier diagnostics
Date: Mon, 24 Aug 2026 07:49:43 -0700
Message-ID: <20260824144943.991316-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A subprogram returning more than 8 bytes comes back in the R0:R2 register
pair, and prepare_func_exit() copies both registers into the caller. The
diagnostic modification scope around that copy names only R0, so the writ=
e
into R2 is never recorded.

Fix it by opening a diagnostic modification scope for each return registe=
r.
This way, both return registers are recorded.

Fixes: 0630ad00d96d ("bpf: Add verifier support for 16-byte returns in R0=
: R2")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e036ae20bf6b..9aa29c367008 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10403,10 +10403,14 @@ static int prepare_func_exit(struct bpf_verifie=
r_env *env, int *insn_idx)
 		 * return to the caller whatever the callee had in the
 		 * return register(s)
 		 */
-		bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], r0, BPF_DIAG_MOD_WRI=
TE);
-		for (i =3D 0; i < nregs; i++)
-			caller->regs[ret_regs[i]] =3D callee->regs[ret_regs[i]];
-		bpf_diag_mod_end(env);
+		for (i =3D 0; i < nregs; i++) {
+			u32 regno =3D ret_regs[i];
+
+			bpf_diag_mod_begin(env, &caller->regs[regno], &callee->regs[regno],
+					   BPF_DIAG_MOD_WRITE);
+			caller->regs[regno] =3D callee->regs[regno];
+			bpf_diag_mod_end(env);
+		}
 	}
=20
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to call=
site,
--=20
2.53.0-Meta

