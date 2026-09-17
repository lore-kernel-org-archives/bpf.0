Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CFE4BA9FB
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687964; cv=none; b=QiBqzEq3szHylsPpQeb2ygq4D14TsDtip3c5SzFoF5u8np7i6b1k/iYcxxw1qNeqY7XXfrQq471BixgKtCbjttN27031l8IWHT9APgGdqP7p6R0x3VykMbVJvxPGOM2a78xTi/+cMD3uHtxxo3Ht6Ien7N/MetanwlsoUcsgvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687964; c=relaxed/simple;
	bh=J6DLyFJwVFLZc4nxdNn2lz7nxCbemOUYpTK/01sXfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khn7WVIqrqNkYzATDx3keHCQGbPxCYk2VK0XsuMguogLH+5h++3/rKgcKGvMFidfMeSLeUxjuNmXvCSrFAtd1qSx2cXmQ1DXF98DTazEjvxwS8cjK1HrlZK85C1vcoXVRuC5YePTb7Y9oMHAhXJLdCnfP8EEK2ew/lmic7R9Di4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozl4VulT; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozl4VulT"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso599625e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687960; x=1790292760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3kpIJNizqxB2qWInAAS+MYGZhpffsKBqS99TtmYKIpY=;
        b=ozl4VulTWD1oZJOb/WdlHyxgtGoGxb3CQkpgEzzvkZWxwCaOmCeK+N0zleLrh6z+hX
         E2/1DuM6Fe/uvUutW8aAKqwi7zgqeQLTfXF63fNYD5RUudQ1e1IujbRuqPxisTIzW24c
         kB1qgTMOWOVtXKLAFypOOuQmdtnHEPPUv8mLByL6f0X2GBFvYGoY5BjY+7YcTz9bG6D6
         8Au5BqHet3XighjYse/+loaBLg0vFXDf7Ru8aeoxiy7mtS77hkgLPo4HuNKPxdQE2nhN
         mrmAYpeiCHywloI3sxS8NRrwLAgCQnzvs0eqX1X9GUXf2/HyNEWxTS8noJH81RHXf0bZ
         GmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687960; x=1790292760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3kpIJNizqxB2qWInAAS+MYGZhpffsKBqS99TtmYKIpY=;
        b=PzDDWrFCg1tPkNH6A5GWuA/6QWCdjY5fDw1MgCtXZvy4UdgPihCUOacU4HbKN8X+yb
         w8G93q+Y+ZykKjQtF5C/UeOOolen1RZY5aXdp9rNmm/nzJpRkhWBfrmWRmmSdgFt7ISX
         +PQKUJ9FMmEFtmYfasHF8B3dqDu09Tvk0Cx2rLP8oidsIPb/F257yd0yfyGp1gycGPmV
         fe+narkhJXWLI0DX8SzHNsWlUlXZii+5bVPkVoTcuuAZ/dREwIgq0xvV06v6SELch324
         +riDBSH5g1WQs2CoHX2dXCCsoRE2B7kg/jUyTgpZaG4hQN69bW+n2r2rvx65ynatbNFV
         1s8g==
X-Gm-Message-State: AFuF++l4WafMCx6QBKR7I+RlXTOevw+sh0Ol+B9FXr4pOlXJ4FWGYYxg
	0vxePuzzIfNw+HZzb0wtX6E0P2c2CUrF9QUPTE0LHXx6aNdFGO3HlG6GOE7ryzb8
X-Gm-Gg: AYBFou3zVJ6qh6Kf3vixG/5m5WenG4eB7TA2mPmj3NqCvxyCnXDMU7e1F8E3XTs9RUr
	YIhRtduS2J+rQK3KNdKSJj66s+yrYQ/jHAth0UUwoNoLHEaARDZXRHWh0VGhKKbhiGl7nBHVLlx
	IMZkBNZwzpj/ljLSDaHCeWFVRJCYLtjsQAFb4h667g0iZ/v4AsMot+JfFCi9aZTkfbnmUDwBGD4
	3/XSZhk/d744iVo4GwfMKFE95SZuQgtHSRw6RpOlwmG3zwNzcFl1eJWQq9jx1SwKK+PJy8ltw2E
	ludoQ+JESiQFoTehxy6sh4o+6Pcdqx4z7MbUnNLKkocTLTVPwB3Pn5UoAACeGigXYKuew1x6Jt1
	e/sAphYGXBkz4g0tY2sMuxPEhLXD12v3c2x/TynnPFb2N8iblxjdr3xUw68DyMFiqHJUI+xazan
	NcXv2rAVYalo0Grp3kvmEvSKiwHuZYuXx0aI9F8bUdO2XeB+uSUX0eon+WY/zzp+NbK4VeB+WHd
	j9s6cWLGyGq4HYH+dDmXAs00yqvLALYNUPFyW/5pVNGP1dA+O9aSQDbVr7R3VBGm3pQKLemWyXf
	j+X4NjD17Bn6vaSpdm6nTv8q/nykQgzF1edBeA==
X-Received: by 2002:a05:600c:6206:b0:49c:fff9:f684 with SMTP id 5b1f17b1804b1-49fc5735339mr5129725e9.21.1789687959847;
        Thu, 17 Sep 2026 16:32:39 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7ce03e7sm1336625e9.3.2026.09.17.16.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:39 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v7 10/10] libbpf: Reject truncated ldimm64 CO-RE relocations
Date: Fri, 18 Sep 2026 01:32:18 +0200
Message-ID: <20260917233222.2542500-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917233222.2542500-1-memxor@gmail.com>
References: <20260917233222.2542500-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=memxor@gmail.com; h=from:subject; bh=J6DLyFJwVFLZc4nxdNn2lz7nxCbemOUYpTK/01sXfDQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtNRbadwpTHfzQiP3/V1pXe+MV3QcqzB9vPu/NZ3P+5t deWoWxJRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACaScZbhrxxXStUU3qb90ZMt Giel7rXVf5Oy93Shn9HaP7NsbA++V2Bk2MI+Q2WLwdkdn2Uikrbd43+odffz4tdTpucduFD0vcy qhA8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

CO-RE relocation of an ldimm64 instruction operates on two instruction
slots. A malformed BPF ELF can end a function after the first slot and
attach a CO-RE relocation to it. libbpf allocates the instruction array
according to the function symbol size, so the shared relocation code would
then access beyond the allocation.

Reject a terminal ldimm64 in libbpf's relocation loop, where the program
length is available, before resolving or applying the relocation. Both
resolved and unresolved relocations validate the absent second slot, and
unresolved relocation poisoning would additionally write past the array.

The in-kernel caller is protected by the verifier's early instruction-stream
check before it applies CO-RE relocations.

Fixes: eacaaed784e2 ("libbpf: Implement enum value-based CO-RE relocations")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/20260914140852.03DA21F0089B@smtp.kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee..bfa64ae6c94d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6206,6 +6206,13 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 				return -EINVAL;
 			insn = &prog->insns[insn_idx];
 
+			if (is_ldimm64_insn(insn) && (size_t)insn_idx + 1 >= prog->insns_cnt) {
+				pr_warn("prog '%s': relo #%d: insn #%d (LDIMM64) is truncated\n",
+					prog->name, i, insn_idx);
+				err = -EINVAL;
+				goto out;
+			}
+
 			err = record_relo_core(prog, rec, insn_idx);
 			if (err) {
 				pr_warn("prog '%s': relo #%d: failed to record relocation: %s\n",
-- 
2.53.0

