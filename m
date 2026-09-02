Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4290E476CE5
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369259; cv=none; b=oP/udEsYpjZj8zo7j5qQYyNbuV7O60QtiNDNh4HPJ7AkIjdX089r2FK2ayPXZyeQKJuqPbBYgFIo+5YZW6cTfmED5+Z3ZP4PNTpKaKLnJZGvIobYeTM4skJPxj4BDpoL47x+7UuzP+cI4bx3i+Sb/aV/aReccDRg3zYNmxUt59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369259; c=relaxed/simple;
	bh=+OfN5/JT4pgAUO4bZ/FAnGD2WGjGb8p+mhVokfQB5Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzSgyshF+b8PzUNwqKAYayM9KmEnn5k0nZib2mX0N6vPXRZ5doAL3FYYl4/g5F0zKl9LCmd8UxkMUqmLEnaIRTelaKGCUoQk2YTw92M0HdWNX/wNlFjaAH7/x2osa4+oB3xr+qWlKgsr0fjrx6o/64M8+KDHMfUoO6WqV1E9Uu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXWx6v4l; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXWx6v4l"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-853e2610bb4so69364b3a.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788369257; x=1788974057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p2JTCtksdAlvf+/b7VZPB10MIgTgvt41Uu0H1zjlk1w=;
        b=nXWx6v4lSI6DaqcPsZfZfYsfyP/vKNpGl4uutIiJX9dl7Z8VA3FdGm0rQcRM+ihhGi
         /XF2pq13OG/YNUfDCGmIpCKJJ1YdPj/rh7Brj90zNW21i1GjIAYV61sBAyaz+3X7VAfz
         k+QVrviyATDVLegdZE66rYqSSyOv8AhdFmjxbUlQIijfAhi+C3tJTiiH4JTl9O6ihLRl
         wBJu9dIk1bt5eObN1LgVY4USEWnFhF1TAuCZ8IbZUSCpVj7j6iuZHH8LndNXOLgGtb4J
         h806tiKBK6ZqQn6L7RhE+gX1gFMK3AeoGxfHJzxrwIt1aDGWM22XDM/tUoEOKn94YOT0
         TaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369257; x=1788974057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2JTCtksdAlvf+/b7VZPB10MIgTgvt41Uu0H1zjlk1w=;
        b=gkhImJIpB0Yu2MQuGZo5lKFQxssuFGsJ7gH/oUWZOPQew0kyQiyf8SlHlF3lNCm8W+
         ePHnui8Vts08xOMo67gYg52aev+afsJClYojXO46dTroN4svO45Cd+KJfYgkyttEoPVi
         u5zpapJsGt8mwitL/36Ud+QN/lpjElgY5qMFFBa+XajC6Sqt/eHSQ9MufhjHTLtrGjHe
         FVQSmRi6ByJf8bTFny40HbuwhW53kLdrdUfezZdrAzDnzuHwfB+vSWNIzEu4+kPG25q/
         4dmIyLwkUX2xJygF6cnwb2rLlZa6LjlOCkLDdKmWEAznwWC5Ze44SBhaE/U4gqfZE8lB
         ZjSQ==
X-Gm-Message-State: AFuF++lBUE5iYXGbEOuMECM6ScnrcOijSCF2P3qo4X2mb35tMoNmhSpG
	EAK1NjZeh3uLnd8EZyIEi0sxprEO3TIDLC9jxPAGhBJi+NEMKm/9RCj2tvDFYA==
X-Gm-Gg: AYBFou3pMFlR+9yNt719qHQFOURtk2uqnpUhnOmav/Hi+fn9hN+pEN0I3/p/FVr4axb
	wNqnxqbuizRdbFJBcIM/hAoLltsFFFJ2iHrHj9VETnxFVJuJLhbUNY0srfR6uK2AQIyV0VhEbwr
	ga7/0Rc1c9LODa7NxTscuR5fRv9IN++v041pmQcyCD271UuO+xjDTGlL3hQSSHBO+ggFb42mo1B
	1YXySloQMJRZRqwjhC/Yc9O2DbhdAGWjjMfNOb/j/X7F5UbdgCG1NIDnzDmwYeGEzFGl0E371dT
	2tgqHhzBmEuXz7MgyRcDJnYCK/lSd6MNWWhFEZZYkwpeJCpILLaxnkSrhRLuBjJgNsCyojXVDhY
	LPx+J7en3aT6Y/FWdd+Q4bYLZCokGljFlez6sXTexL/errPtLAP6xVnqe5/4Ms0z/Xd3NWrTFSf
	z93C9JBIBNksnfFHchIL9cFImGhHNEMpXha9iBevaom71H3dqL1skqsT4NKn05VMUzXgfdVERzx
	Brdv1HTFlZWGhLvYnWLcCl4QvDu7bSAg3JY/mTGllrLwSkl4FymisZYa8s64RgNvKCtaDSM8+r/
	K9HLv6gUdpbR1dzGLH967kbayosXuQfJFk+oZ4uTe9eYf831pwBM764AaVAN7V3joB8NjTPx75E
	=
X-Received: by 2002:a17:90b:2b4c:b0:398:9bd3:d6d4 with SMTP id 98e67ed59e1d1-39b0865335dmr583600a91.14.1788369257327;
        Wed, 02 Sep 2026 10:14:17 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d0d7e8sm343070a91.16.2026.09.02.10.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:14:16 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/2] bpf: Allow terminal gotox instructions
Date: Wed,  2 Sep 2026 17:14:13 +0000
Message-ID: <20260902171414.96165-1-sidchintamaneni@gmail.com>
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

