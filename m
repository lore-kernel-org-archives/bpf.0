Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6D10F2
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788075088; cv=none; b=d3DQ8fofnQP/lADdUx6phvU7XmQeKnYEs2veWVcJQuYvKBMiL0YQZSJ87ThNHOmJp3Vb++Cy4k3ptAFJeUGMo5tKoKpa9PKwHaR/EQZ4+kQFRfnCljEjp6qSFr+YKL1DW/+7pNH25dRK6G7vyiggifKTglu74YL8pzy/VQFhpCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788075088; c=relaxed/simple;
	bh=KmAvwVd/YKF/pvyky3p5rtiGBEVXKiBRbkWtkfV6GZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1T8prDtpqKwVAgFpzGsTR/kCZ17J8ENFPEWdBqrlybGA9GVFg7gA49aVlTqXH5z9kQnTQ8mwGIcPvprTpI2Lm/fyesajv9Zz+PGDycvy1ID78ZuLp+4nE0a5LRDGZ07pTg6UxGXQFS/SqK87VhtBKzZS9Vfis8iY50DtXkhHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SL6DtdFJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL6DtdFJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d91518a63fso1285965ad.0
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 00:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788075086; x=1788679886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+djeb4iHolqgq+uyN+y7uAKpB7up1MJUl31TM40iiTI=;
        b=SL6DtdFJ+uraS+DKgEzuJ/OQa2lsEtdVoBdl3dQnRWsR/fEBSjjRNBBJmG3f6DJtZV
         LSJ4o+OweuDir5ZBIy7zODZYOncoLSVwDk9G0IWrgXbuRYHWqTL7YO/Lez3PnQB4IK1q
         50a3ylv6bHbYKyuLHIY25qDwHNrHhBqkBeyIRQcqL5+e40Sr7jduUj/ZJBHYcstVC2TF
         8GYaZoFFAiP9mbwX49EZTdfYtU6ndKiaRahhJTUyFLBc6pBf32vHVYPw4oqCXu4Nkq4o
         XFoYYhNhqBWD08shTYrvsLbbtS/a8BbnQOfjnLKLWED/XNovPVkzQRuz9J2GdsoEHH8t
         YlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788075086; x=1788679886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+djeb4iHolqgq+uyN+y7uAKpB7up1MJUl31TM40iiTI=;
        b=CqVuEtHSdE5VbQOOjmjsBKttC5ycyM1/dU5Eyok/JVPb5OTyWBqeVXCps8Bf879Ktf
         WPWkjqVqslu861fj65h6mNVpqipBSqTX5xbOOvOnsF9IPK7cBGROAGMq6My0R0ZPl26d
         aZEAbZUx+Kg4/5Y6hdd9dJhMAtJq3949GzPGKLN+ASkxL4cn3uS82gw7pvlrSVNHCUBi
         2KtG52vked3FzSJEcuhUzw86jtPfuuxZcqEjhetR9/XsA3ngZ+HhDP0/Hg+hg3AoDLgw
         SORvSt4CUuDCyGtddj31+yCUkyM8WxR/iCqUB7Y1SoIiQR2uezNz+ap7jO1O4OFk99Jk
         8Naw==
X-Gm-Message-State: AFuF++msVqGs7qepX1fNnEJZjyeG6zXK5AggoE5VZHthZxsOnstXtGEM
	822bnAD1NzAVrD9IBBQCtLTiWZ45g0y/TmO/N1ayDekwEHqhCue7Nfv0u8OBPuli
X-Gm-Gg: AYBFou3nTD8x2Gf7i911D5K8eXjrpe04UOF+mZcBNq8TIB/0Ap8QETMfMYSY5Uet4nK
	PgUVzYbQLYUNbBjGm3yu+EuIFS97eJZvLMAqVC3ARkgvqTBuXOhPBFzE2puuWfJL6jwRgSJWeT9
	5Glku3tnxKvKLsXqVDcrNjp2zb+kX2yWVHPrIiSWUhjg4Mp7NwoKC2H8ak3PtZFabatKV7GeHeJ
	tytrTn7AED9+4GHPIjI/ifsxklhwAAjxr5fjx7E0gG5aYLhrZojTi/X8M7JVV5uA+e5fHdJ+HrQ
	NhMexVQtF1ky/nHB5fObt2j0Mtloq8BGw6WL2PLw4u2aAz/f1105Mga7mzskr7zCGS/F14lmyrX
	B/oK/eU7z7YhIzhed0txc4xaqC5N+Noj8ipc9eT+HFivzhOeKokmaT2BNHLW/hjc4HbyNs1761G
	NfJCeTE+B31wK9CjpKIsGOe0P0w166SF1NzLWvik22HfVE4ZqE8BBgciZzN6baWFFnDcBGyW2HD
	yYekOu14z6a5TrMeT0rp2ip5t8EXYXug0Tf65sHED2gRvPbB5hPHy8uOB6jRrO2WK+BQBFWx2P9
	bTeKM7n9OKm7nnSb2DdaUv2tKRFj7YqW1tPzs1mvNUfzF96OZ4B9ZLvE/de/uEe3uNNdhbScT/0
	=
X-Received: by 2002:a17:90b:538e:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-396d0e20f00mr31196518a91.5.1788075086474;
        Sun, 30 Aug 2026 00:31:26 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc0c703sm10327082a91.9.2026.08.30.00.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 00:31:26 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	rachelmenge@gmail.com,
	hargar@microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v1 1/2] bpf: allow terminal gotox instructions
Date: Sun, 30 Aug 2026 07:31:24 +0000
Message-ID: <20260830073125.360934-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_subprogs() treats gotox as a direct jump and validates its reserved
zero offset. When gotox is the final instruction, this produces a
synthetic successor one instruction past the end of the subprogram and
rejects an otherwise valid program.

Skip direct-offset validation for gotox and accept it as a
non-fallthrough terminal instruction. Its actual targets remain validated
from the instruction-array jump table during CFG construction.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 kernel/bpf/verifier.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e036ae20bf6b..44195ec1445d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3087,6 +3087,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			subprog[cur_subprog].exit_idx = i;
 			goto next;
 		}
+		if (insn_is_gotox(&insn[i]))
+			goto next;
 		off = i + bpf_jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
@@ -3106,7 +3108,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			 */
 			if (code != (BPF_JMP | BPF_EXIT) &&
 			    code != (BPF_JMP32 | BPF_JA) &&
-			    code != (BPF_JMP | BPF_JA)) {
+			    code != (BPF_JMP | BPF_JA) &&
+			    !insn_is_gotox(&insn[i])) {
 				verbose(env, "last insn is not an exit or jmp\n");
 				bpf_diag_program_structure(
 					env, i, "subprogram can fall through",

base-commit: cd35e1b10182c42b4ae31ee49119463b17d8ba7f
-- 
2.43.0

