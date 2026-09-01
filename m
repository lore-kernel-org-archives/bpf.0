Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037942049F
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282110; cv=none; b=UFygZX+B57qkyN2p1+Cpqv7N5S3Lksv7sowL/aOnd3QFabgD5P9TnBdP1AOhgVDZW9w+wltANTCExhCLwEIOTc47vaDjpYLZ9pB7mQoERAZj9Rc+G0mGIKEaZKH9KviQFABt2xzCszbwv0ER1SquEfjdkZ7GmvIY8aPsYXFXO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282110; c=relaxed/simple;
	bh=+OfN5/JT4pgAUO4bZ/FAnGD2WGjGb8p+mhVokfQB5Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkX1FSw0uixu8dwW8tucFgcp+9pz/rPOpy5Zd/X2VIj6QqVY6tejSBs1ZqEHLJHPpwdTiuowMBbxQlqjK3jD9trdiRIjc4IIZN5ZRbR2aOmB6ABJWtTPXr83hu0l/3w7+05FMxLRW/msrrco3njNftfLOZM1GhzUFFl2PCu3Fkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjlD6g3i; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjlD6g3i"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so55343a91.1
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788282108; x=1788886908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p2JTCtksdAlvf+/b7VZPB10MIgTgvt41Uu0H1zjlk1w=;
        b=SjlD6g3iNXNNgIydLQN0YyepMM1MFwI2e4+To9hf9R8zCmDkh3SSkpyguVovIF0S64
         eZblj1O/vdSlDHgf6m5JKuxdg07IKauyuR+FCfkSkbWSrA/zfwvvVLETlnE2y/rrPZ7p
         mLBm50vVRjynj6cBUBPLCEWB8bNjbvl27CY4taDfQ8HRTg1oTiaXKQPyw9MA2zSPalAC
         46Y7gey+d6ZJbejC8qL118iTpF4+DBvQwGiiK9qoHKUEdYLNX/SQC3Cc4gb7C7od0bJl
         9cb1b959rT90uBSyYKq9YttUuaXRqncOXx+jnW/NB3zgQ6UQvLYBGeRKylLzCc1bBoj6
         28IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282108; x=1788886908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2JTCtksdAlvf+/b7VZPB10MIgTgvt41Uu0H1zjlk1w=;
        b=XwKFL/UfMoPN4i1WH2nQ4Quu7MldruG+fqC8Y7UT2x9GFb4lUcLdLQP7WuMMktujNz
         t4dbrO3BKE0oapQKsH832djzo4YWcqccx9Jth5wdnU/KZkfNSxe9LfoP9a2vf7WROkD5
         hjl16XtG2wUn/E2VO/CZI3PjDzmz3JIO+6Hmpfwat6PFNpWzKPgKxWO0ogt5/qhffuX5
         gJ1MPle2jeO62x/FkOIQjR7mhZqzyNWabm1R9f+DsOUw2ssitwlAVQiALDrzFgdc0Iw0
         PNQhpxUtwC4lNbXv4qnUa56CniZLV4Ov67aIdrZjBbmnvFnikiE6aNHxnQOXFu/xppZ0
         Y2Rg==
X-Gm-Message-State: AFuF++l1wVn8e0IA7W8IgzLkAOl/NdDLBcigchOMPAz46hHZm9RVWW8B
	ZRutByrFAmPNZeAOcxVWWbB7SEUYhPeu/bc0WpZP5z6NX5R7IWq2z1ASxwrP5f9v
X-Gm-Gg: AYBFou0ExL3Qvtz1+4V4OAeWzQNwzWyK8mg3Iwte3hP5bBA7TQTQ5Aerms/k2Q5TiLu
	+CwYQc+6MQ4WIoK5c6tIcCNjg9WpkfKDxW3IeuVi3cVBpg3a8B3b4blmviMZuG2yEAjIX129cs5
	KR7BL8m/GQY/slIiBXoeF1E28mJkbu4dbqyJIs8ZqzDZtTWaP67G0LUvDCqi4aNtsjZwTmtBL5U
	ijj4xmxCevOCPXEJSpj+Z67dv6F6W3MajX2u52UmpolCoMA9+JydhlnCsrOe6cm1JdzxjANTezA
	dikfOIvIOXp+G+UaSRi7HIvKES//9npcEB6HhygLTyILDC3F2PSiEa3F6suJN1ixJm7d89busjx
	7ZGkLw8askNkGJXjSDxB4QHo/s93yj2BN1E4qDX5anFd9+4GPQ2G2vVGxBIHE0Zva38mmcVt2jN
	0EWwjPMJkzVD8VdtsvczhmFXMULTnuO5YZ600NeL84QIhfRidpq6gUmskSx3HbwipDI7ij27A1S
	mPXlbjYZpZTRqZuotDxEh0hCzfp0DIXjuGskaYuEH0YxpDJKTu36qQnQ/EB1TdOzFYSReLGnQCD
	Jbrt6zTsOJYacs77SfNjNN9Ib++kQqbLeOyyrFQOmzQFRyKhWgg4u1HqxRe1wmBnmnWoQSTiirP
	mGWqSc11Uias=
X-Received: by 2002:a17:90b:2cc3:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39907e9d3fbmr15944862a91.20.1788282107626;
        Tue, 01 Sep 2026 10:01:47 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1b395sm7602073a91.1.2026.09.01.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:01:47 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
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
	Puranjay Mohan <puranjay@kernel.org>,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v3 1/2] bpf: Allow terminal gotox instructions
Date: Tue,  1 Sep 2026 17:01:43 +0000
Message-ID: <20260901170144.70453-1-sidchintamaneni@gmail.com>
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

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f585ceb2cd5..483473df7746 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3088,6 +3088,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			subprog[cur_subprog].exit_idx = i;
 			goto next;
 		}
+		if (insn_is_gotox(&insn[i]))
+			goto next;
 		off = i + bpf_jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
@@ -3107,7 +3109,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			 */
 			if (code != (BPF_JMP | BPF_EXIT) &&
 			    code != (BPF_JMP32 | BPF_JA) &&
-			    code != (BPF_JMP | BPF_JA)) {
+			    code != (BPF_JMP | BPF_JA) &&
+			    !insn_is_gotox(&insn[i])) {
 				verbose(env, "last insn is not an exit or jmp\n");
 				bpf_diag_program_structure(
 					env, i, "subprogram can fall through",

base-commit: d761934c9483ecde93fe99d8705282f716dfee50
-- 
2.43.0

