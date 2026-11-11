Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401861;
	b=hNkNqy3WynP1DFV81I3AUlyoj7afr6YyJzKxmahpIOTgAIsh3F4czwfQkbKKG28/m9MC
	 Hja+0JH+uI1opULXGqKn8Qx/qbHiAN9g+pWWBgo0NxVeIoHLAyGABlGd8s+iZqHCRevKF
	 kkcw/XWmEVYRwkOHOQ98EHxt2N9hH4bQUhR6fKgky+ZiPMwEwU9muxhEps7sKcEt8t1wr
	 EUTr8hhKEwg+G0pGmY7Ao4uYxxvcUWk5si3c0evVbL896dz9yBFysNA8gTVai1IN/yv3X
	 0L3VIIEpKjm4XtNY8tuJko3qdR8Pi8xef6M5xDswg6NUd/mxG5f/gmMBjA1T2CQquXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=G/g1CJMCB7s8821gVN3VxeUHP70qjRJnzVbg7kV8ynM=;
	b=uNnW10MSKnkoMkNUf9kYNYTxTMXg3O/07XVIAbZ9godxn6R1d/FTxKjkEa0AgeVdCoLS
	 lAcd97ZYgoKkSFFOkXpUjI320xdf17xu1KbSue6Ggjx3ROvAnsaSfC+H+HjsjujogVGrF
	 vPkKH+MhJMX4gcbszqTWeWAOB9EVbhB1fdRP8NyaoIDf3rvYnYTTfra4yeD5dZ80Z88W6
	 EAKBiH2+Enjy+Q2Us7wsRKmeW7Ccno/SBVyV9M8emUQs3zUnF/2iYT+zHDGzrTJl+MpFC
	 FG91MXx1LibnjH6KnMIacBcu2aDndL0Tppzl+cNBbDHKHk9Z/J54wMtRmf1/IKRxo0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x3NveExV;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89033606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89033606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x3NveExV
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b886ebe069so10204305e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401860; x=1795006660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/g1CJMCB7s8821gVN3VxeUHP70qjRJnzVbg7kV8ynM=;
        b=x3NveExVvLvbOn5YwKVtkTibf4XYiz11SxrMMniKz8K/EEfAhnO1N0g25nDYpSzRo8
         EU51n3htuIklP+ztzSzkPTXJEj2vek+9AZP0hSfl+p2qeSBTHHnUG8Mln2jUuNixtb3C
         Qp5lqlKJxtOFcYnvymhCnHn5YvR/h5hmF4Ln4WrOWzO5hw3pFThXZeAORZIbd4jupGkw
         WNM4YgziPIqkHlSU0AhtKcXFNRk3w8HrbQKdUDME6/4wwtw8T91jxzN4yK86B7J3oUK8
         QNvAykPA25T4RLmGFGtPUUSaZPeONtGyka5ZqLNd9PehDvwVt9hyC++k33uNQIrFCpET
         ZGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401860; x=1795006660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G/g1CJMCB7s8821gVN3VxeUHP70qjRJnzVbg7kV8ynM=;
        b=TzFP4A4WxXXuDD7jeV5ef617Ey6oj03xyBrybg178KKgHIvBGnSviaKKY4o4Vdvy0E
         39XbEaTjUx10Fj/dXIyUtgsYQ+CEzyrqRRDpbPIdLLQAx0tzMcPNWWSJWDCT5Tsq++Ej
         1HoIL36h06H3qX2/B7PHVBRMczhsJOJ1VBOW1fVTvXzFUg46jsnU7sBw+lhaxYW5ZxYH
         CozeJYzWThBd1nMbF6U/+50dGedEKULXE7py9hvSlgssAXhdaBeE4KFnE0W0ppDhptzV
         hw0pcJCin2btsN/XcfQd6B3D9XVQ2qNzQlKG8EIbRNJ72D+VQ67gomscM7fDxNhb4zhY
         rcmw==
X-Gm-Message-State: APuU4Z8WVQo5NuG583lxD6IHkK7Coz3BM9iGyRmO8AELtmbHC5DoBAcZ
	iPYe1IdDqUDQ7J2n8iFi6umQB5uJN3Asj+3EJhU24qPqpIbLDfS1T4uclR1uSx3PXGU=
X-Gm-Gg: AYBFou0P2ltf4KgtIlWPi4Jo3s32/+irJXLf3hyDmCn8/mMHISW4LraJuTu6rCkO08O
	rakXTFYYMhy6KX2SdsJA/OpHNz1o2UgHhCTtQ5mnAxelahNcZ3T3vK3Oy+xbcKB6PvyHt5QDama
	FiDGuhm4dhUdly1oHKluE9oV8q+R+re7+4GpFVhCFWy9RR8OSH0z+NuYFP08s1qKuygvfXuGgDU
	4ze0LUyXkuJJNkTBuXzcDP6hUepg1Q6arnm4cD6Ngq130YWgDDquhInqs2isgIA5krKKaobSvEm
	pmIp3aXABiXPFT5ezOMDZE0Bbj2zLvgXZ2Z5MzqKQ1e0E1NUyTT8RY0VTtxMsaUoXQPUz+FTUJi
	8m9PKnY3QeyIr3JhC+a1AHcWsRcYqHkxr3FtkaTRZzqcS/zWQG2pwOJe20yE9dY0MPW49sUeG/9
	Q6MjOzVzLcwvHTito4JPvUAZ41oGUBa0YaMUBiH6IRJXi81fgIsBqb1FaB2Hw6q49rkmqOWTBep
	MOyiuBqEzO2j+EaE9IEmskqIMpGKWU7BVekN6DOOV/SRXA7xmOCQa2wNyXT2cqdK5WFgCWMJnor
	sHWAShdDTnAe1uls25hVvlVuJyRQEQzBQ3hwHx1rge8YNMstNu9NFSG9qXeLBebADW0IlOxjDyk
	f/NgRp+CQrOC6JJ1oWFSxYFXJMEYQ6FkRDW9CeoBJxVVAbb72VRvIbbwQv1TsKXzlG21i
X-Received: by 2002:a05:600c:6218:b0:4a2:1a:a116 with SMTP id 5b1f17b1804b1-4ba091a73f1mr44043595e9.0.1794401859904;
        Wed, 11 Nov 2026 04:57:39 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02242bd9sm131034835e9.15.2026.11.11.04.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:39 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 06/29] bpf: Keep last insn's aux data in add_hidden_subprog()
Date: Wed, 11 Nov 2026 13:57:04 +0100
Message-ID: <4e0c5d6d96b2e917ff52effe483ec90daf0e2ac0.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2318; i=memxor@gmail.com; h=from:subject:message-id; bh=SKZ+5mWHlPFKh3dSlLjrarKeClMVPFJDZXxLCt1RdIs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzFwrF12dizIKz3OWb346Y256aXrj52sc9y9Lsf+cz cpsLiHUUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIk8kGVk2O9/+0euqITzT8nZ 3olPNjkerXBMFrgkdfZ/6M4jh5cx7GT475mY3J4tPqd/IqvxTInVly1Ue1UOe3UvMLtyNHd/+kE jfgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

add_hidden_subprog() appends its instructions by patching the last
instruction of the program with a sequence that starts with a copy of
that instruction. Like every patch, this moves the aux data of the
patched instruction to the end of the new sequence. The aux data of the
original last instruction therefore ends up on the exit of the hidden
subprog, and the copy of the instruction, which stays in place, loses it.

Today only the JITs read the aux data of the last instruction after this
point, for indirect_target, which the patch leaves with the instruction.
But a noreturn call such as bpf_throw() can be the last instruction once
the code after it is removed, and later patches attach per-instruction
data to such calls.

Swap the two entries back after the patch, except for indirect_target.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/fixups.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index eb5a5bca5c8d..8597b443d561 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2280,8 +2280,10 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 {
 	struct bpf_subprog_info *info = env->subprog_info;
 	int err, cnt = env->subprog_cnt;
+	struct bpf_insn_aux_data *aux;
 	struct bpf_insn *last;
 	struct bpf_prog *prog;
+	bool indirect;
 
 	/* We only reserve one slot for hidden subprogs in subprog_info. */
 	if (env->hidden_subprog_cnt) {
@@ -2299,6 +2301,17 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 	if (err)
 		return err;
 	prog = env->prog;
+	/*
+	 * The patch starts with the original last insn, but the commit moved that
+	 * insn's aux data to the end of the patch: give it back to the insn. All
+	 * but indirect_target, which the commit left with the insn, since an
+	 * indirect jump to it lands there still, see patch_list_adj_aux().
+	 */
+	aux = &env->insn_aux_data[prog->len - len];
+	indirect = aux->indirect_target;
+	swap(aux[0], aux[len - 1]);
+	aux[0].indirect_target = indirect;
+	aux[len - 1].indirect_target = false;
 	info[cnt + 1].start = info[cnt].start;
 	info[cnt].start = prog->len - len + 1;
 	/* The patch ends with the exit. */
-- 
2.53.0

