Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A9399007
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845488; cv=none; b=RjemQox9bO2XALmcNtBGXNCNeC9yu2p+AtB9M9zc+do2ASWBlj9N0gjrX2r1n2Bro9D/JrbBtR8UZ/zUaY7WeobKoAU9z+F/G0608UKxksNa16nHv0PQA+P3gUuZrJ0aJxWDi8iaH5WlduBQTdhMh+V+cJh8d6hLn4DlMdIXUxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845488; c=relaxed/simple;
	bh=e3PmPz8cw7JyX+k3++IZD3FvhqtEO8JHFb47fHWCz8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMqEUOXj9KEV6l5L4B3g0U3JCHiourEvbrHyb6z7kxUXl0qkYXcqSQVtGoWUfnOG4Onshr1khuzrfa/xvzmWISoB9Su5OC/2lk1aS3KY6wPnuVvipu6HbFOcuAjPsqbkq5MkduVmfvHBqy7ob1c2fbIawLQl2Zbeq9e/kAwwVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2TD3kBA; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2TD3kBA"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46cbf263216so1094353f8f.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845485; x=1787450285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d940bnO/jeH74OIIhtKBZuQBibk85Vo9rNFZSBgg+2Q=;
        b=p2TD3kBAdDgk5f0M1bjajhPpKL5EUhqesy7p6Ph7MoU1DxOX2GG7g8WD6P7adS06vC
         PadhLHkXua6BaPPtmEA1ZWstEKBNNR1Pl6FG+3Z1UXqQR1x90DF6qAhnKFNcPAnwykgp
         OeTmG2TCQeHmyHqsS5Bxf8eGhi2G9a9eJW7a1DFuD/kmIx0DXN9NQPmoyWPor8SJMc28
         x9AfK/5xbCOiFnj5hwAetuqPUJPon6x3dMjHZVoHxPloQtg2u59a2BRz2M+PDOUhZqfC
         v7TQgC+g5iksOV41B520f2vDRqh0iNHzhPVhvUXuKACIXaLeEtu1dCIyYWrquQhAWRpC
         rI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845485; x=1787450285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d940bnO/jeH74OIIhtKBZuQBibk85Vo9rNFZSBgg+2Q=;
        b=jkJDvdGueeY2btGG006/L+4Q2JnBN4ClPrucFcIAGA4UWlKBqg9xK+uYcEpZLIlf1i
         fhrdsKhP4HlgBp+zrtOvOGj81D5AwX5Z0yCoR96W4kuODiv2xRx45+UsNldzNCg2Jr4K
         RtRfdyTfkVgB6M92wFyV/ujNAlWgG+zdqN/Z5hhhiVisn6ZEf19Am6Uzk4NuU25gK2NQ
         3hOSpAC0BZq/Zk9fnS4/T3OcCrUUqO8vn96rw5BXZAnmLDJn5CWqw+i/SEJNtSNIsmMX
         R5CI/Vv8DFXpMKBevkGfiRJJdiOJ9mp3S0Aw2LQwzkv5y4PZYAs8b2Grq/RBIkaA1VOF
         fdgg==
X-Gm-Message-State: AOJu0YxTrtP/EcXyJkAOq93zn8AQdZA9xFK0VUwEupNO2zoATUP4XBJq
	ucHTkNeqDnnX/D07VBjcE09YEkl6NbTKiz9Uwg10qQq8sl5m3Kzx6r9H0Emr3C5L
X-Gm-Gg: AR+sD10LejZSZxkzrO53/PXpIeGOb+v593gXALsOplSjOBpfk+aQm7cs916wTIL2TpJ
	kaCYRvnyc9uTvo3Ft1UI+xtODGq8GpBmkN5PQjTS8DmJqSA0Iu2VhDv8Qmmbv426QpMnqefSUx0
	kYILEPMD30Pu2hNQjBeyLKIscLqP8OVEs2Ghk/woQyCbj4KPmlqa3olgIAQkZ1Xa6437NyODO3a
	QZyW82xBrGYZBqEwO6apO8ZjnTa0/M0xHDZnbLrWZSVqJkvM9VTE1kGJ/KQ23Zn1TLgQWy2Tx6L
	IPB5z+Ov9OyZlkVtrnI3b0lMw9lhg3cb8Hgl9QI8JAxC8EgQ2tq03XhfDciHol0LprUFqIYqV0n
	96Elf0lt8R2RY2vd+bk5yNqdeb3+064tFH+vDfoJMbDvvVY0KSDOpcHI6f8EMCihFV8blzh+RPz
	yzpV3g8jeXmfJzAbFzaIufhNc8MqJz6T4bCF25XVRl2eLLb0z9UDYfxXCblEayAn+uDHzy5xMUm
	GrvDIMpkpFCYdAhvyBt+oIyjauZZAAvFvqtC30nhOQk+Md9x/YJJMiv2A3V6wmOZjdVQS8yAGQT
	XLcRALBvFn0RUTj6cTCyI8fmBwM=
X-Received: by 2002:a05:6000:1887:b0:474:18d9:8371 with SMTP id ffacd0b85a97d-4816076c903mr21956332f8f.28.1786845485590;
        Sat, 15 Aug 2026 18:58:05 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f219d3dsm21406023f8f.14.2026.08.15.18.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:58:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 13/14] bpf: Distinguish function references in policy diagnostics
Date: Sun, 16 Aug 2026 03:57:41 +0200
Message-ID: <20260816015746.2632990-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2238; i=memxor@gmail.com; h=from:subject; bh=e3PmPz8cw7JyX+k3++IZD3FvhqtEO8JHFb47fHWCz8E=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQuJridnM4p7o6E4dr8sL7rg37LZlvXgladKTw22Ps 3gS0/U6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJGvZxj+x0Z2tmtrTTEQXdKa FxJp/6Jsf3G1osGd2x0XQg2Z/MN3M/x3ePAn4mhsuZBmTafCHisHucNnu7UU7nWs/3uze0nVNF9 eAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

add_subprogs() rejects both BPF-to-BPF calls and BPF_PSEUDO_FUNC loads for
unprivileged programs. The latter loads a subprogram address for use as a
callback, but its Policy report currently describes it as a function call and
suggests avoiding calls that the program does not contain.

Select the operation and suggestion from the instruction kind. Preserve the
existing call wording for BPF_PSEUDO_CALL, and describe BPF_PSEUDO_FUNC as a
BPF function reference.

Link: https://lore.kernel.org/bpf/d02e6a6d3b2dc43a207b8ba836ce62497b250dede9252e7409c5212201c794b7@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d2f08c6612c6..bc7c1163ab1c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2912,6 +2912,7 @@ static int add_subprogs(struct bpf_verifier_env *env)
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	int i, ret, insn_cnt = env->prog->len, ex_cb_insn;
 	struct bpf_insn *insn = env->prog->insnsi;
+	const char *operation, *suggestion;
 
 	/* Add entry function. */
 	ret = add_subprog(env, 0);
@@ -2923,11 +2924,18 @@ static int add_subprogs(struct bpf_verifier_env *env)
 			continue;
 
 		if (!env->bpf_capable) {
+			if (bpf_pseudo_func(insn)) {
+				operation = "BPF function reference";
+				suggestion = "Load this program with the required capability, or avoid BPF function references in unprivileged programs.";
+			} else {
+				operation = "BPF-to-BPF function call";
+				suggestion = "Load this program with the required capability, or avoid BPF-to-BPF function calls in unprivileged programs.";
+			}
 			verbose(env, "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
 			bpf_diag_policy(
-				env, i, "BPF-to-BPF function call",
+				env, i, operation,
 				"loading or calling other BPF functions requires CAP_BPF or CAP_SYS_ADMIN",
-				"Load this program with the required capability, or avoid BPF-to-BPF function calls in unprivileged programs.");
+				suggestion);
 			return -EPERM;
 		}
 
-- 
2.53.0

