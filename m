Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B2B12F585
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776571480; cv=none; b=Du85Zjy7su0y7xrJUaFgdX261zqfVyWCyvvs9vDUSMXXzJBPqWR5C+oBQ7sDiuC51wb4LzyaytcH8ZT+aVkywocs3g7he+A0ziIHIBIvPQ3X6ydvBJuOrqoLWiJFvHyoBSpTryPT/J8uQ/KsiSndWFskh7ZsnTAQB3Ew8sCSjGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776571480; c=relaxed/simple;
	bh=u9M8XJ+TuJc+FvvsgLZJVLKmaQWgnQjZ4K3dES/btwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ya+dR3AUMSqnuumvfccJvF9YmF64n01KVxVfSUaGHF0MoB5nBSHRoI10Apl5uWUFS9P13qIgPU0s7bOACu5gZI315U5fsLtakbN1S6iV+fF7OZWHRrAiju1Fn5t6fJSI19YYz8fSKoNzNZqXqk0QO/3OYzxv9b106MIpOha/Yx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4gWllS/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4gWllS/"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so2308928a91.0
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 21:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776571478; x=1777176278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/atA6Y4AEYftjpIDt7SezrAfNPMwZ6QVT88PjQLPRM=;
        b=c4gWllS/SBMP/+lKRScE+ysI/lfM5vcMeEPs0cJUGQ+8hiGhTbdVOziv06EHuORdaS
         QQKA+y/m3CkPYp/OIqqXWv03sVkHGU6Mp+k8LftF8MVe77k9F7cULdvplrnEDG3u7gvw
         QiGAUVRLOj6o7AHJEOWu/VAU4p0EPr9Vii+yF/77tx1KZlUo58wGoKk2Ij3gxtIE5FJr
         thwwyoXPFph1jEzWj1d559s/ZZY4iFfs4cXMp4kczU+R4vhGyQESU1lxsoNHmE/jBlUn
         cWgURNUbnlXRDb4SKmHwGhik+wozZDhoXTdkw7LWQ7KsxCAfanzhxcgKSxxHNKClilmi
         kzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776571478; x=1777176278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/atA6Y4AEYftjpIDt7SezrAfNPMwZ6QVT88PjQLPRM=;
        b=qhJTS6mZi7gFqq+h+NdHBlAoeVltK9JfprfAdmnnoSFoGYXWZntMZqOzFEitPh+reb
         JSFPFxxnsrrTPCv6Fz/Lia6HPmg/p9JYQwITI9f2sROC6PFT5WvylPudd55/rHzSF7jP
         yc8GAFItuwrhP3r/5uyHcbx90bJqLxf/kLAs2S588Q0CcCBi4OlzXTtFPXyOp4aLXhM2
         9XtTRNZ6aNC1J0LcmT/Tmzbn8umn6K6A4PaDvjb+Ah5eZHs+Awx2v0+PkbxAB4AVfvVm
         yhw/oRgtJeA10S1l9ReX/EKQnl14KBsTea6gYlypg7DSjdFXkTOawiKtLSpL3i4RZeJI
         dqeA==
X-Gm-Message-State: AOJu0YzsS2Q047KACXnxrWqzMqfbKNXFWgKyEex48ZSkexgQwTJ3akCA
	RA+v3KWmr9HbFTGmsAutPa4LYGe7efOubV96+6TUPdUlCsMSyUHjQ+Fue2eM1EiO
X-Gm-Gg: AeBDievP6IgOnBuZ4xhOsax3mUyfjc6H8lH1xWDhd8R4Yb7sscv/uQd29mdNMx2D2/W
	qj8VJZn5VREx0CsRggWIOryTaVcLgsF5818ckHudr9EP/ltVMBO0p3gRZz96V/DEyiURV/YuDaU
	3WYBddZyhfdC5dD0OjYT6B/Y/y4H1iDkRAfW2Nk256/a20W2mwcrt8evHJEpL29jYL11nzrc9Q1
	Awxi4YRedpHxvW/wGAsVsfmV5yXETYMwo4pkOri9FbwQKBgdizJLvJTSczZg4WcJi6O4wZx0Uij
	FMUVM0D5s1nZSc305q1EppSngMt8j3/ACjtLPyQRVt9iYpynTHiQtJjsDYsSrGTC4A9worzuLnQ
	svkdj2IDVFSJ7LJDvoQi8PS1Qvf1xMGrkOv836wMso17+ZrOH49GBfLXMz2MabBOHhqUVuqj6p2
	He69S90zvrGh5t2H91jaDLxs2TMJDMfp+wLjE=
X-Received: by 2002:a17:902:cec8:b0:2b0:5b4e:370c with SMTP id d9443c01a7336-2b5f9f8b3ccmr96681785ad.32.1776571478177;
        Sat, 18 Apr 2026 21:04:38 -0700 (PDT)
Received: from fedora ([2401:4900:8838:1107:4b02:340c:af49:3bdc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa30134sm64212825ad.30.2026.04.18.21.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 21:04:37 -0700 (PDT)
From: Avinash Pal <avinashpal441@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] bpf: verifier: fix NULL deref in map_kptr_match_type() for scalar regs
Date: Sun, 19 Apr 2026 09:34:26 +0530
Message-ID: <20260419040426.9672-1-avinashpal441@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A NULL pointer dereference occurs in map_kptr_match_type() when a BPF
program attempts to store a scalar value (non-pointer register) into a
map slot annotated as a kptr (kernel pointer).

Call chain:
  check_store_reg()
    -> check_mem_access()
       -> check_map_kptr_access()
          -> map_kptr_match_type()
             -> btf_is_kernel(reg->btf)   <-- NULL deref

For scalar registers reg->btf is NULL. map_kptr_match_type() passes
this directly to btf_is_kernel(), which performs a container_of()-based
offset access and triggers a general protection fault:

  KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
  RIP: 0010:btf_is_kernel+0x2a/0x50

Fix: add an early NULL guard on reg->btf at the top of
map_kptr_match_type(). If reg->btf is NULL, emit a verifier log message
and return -EACCES so the program is rejected cleanly instead of
crashing the kernel.

Reproducer: store a scalar into a kptr-annotated BPF_MAP_TYPE_LRU_HASH
slot via a kprobe program — verifier crashes during bpf_prog_load().

Reported-by: Le Chen <le.chen@bugzilla.kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221372
Signed-off-by: Avinash Pal <avinashpal441@gmail.com>
---
 kernel/bpf/verifier.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69d75515ed..15b8f71074 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4545,6 +4545,18 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 			       struct btf_field *kptr_field,
 			       struct bpf_reg_state *reg, u32 regno)
 {
+	/*
+	 * If the source register has no BTF type (e.g. it is a scalar),
+	 * it cannot possibly match a kptr slot. Reject early to avoid
+	 * passing a NULL reg->btf to btf_is_kernel(), which would cause
+	 * a NULL pointer dereference inside that function.
+	 */
+	if (!reg->btf) {
+		verbose(env, "R%d is not a pointer, cannot store into kptr slot\n",
+			regno);
+		return -EACCES;
+	}
+
 	const char *targ_name = btf_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id);
 	int perm_flags;
 	const char *reg_name = "";
-- 
2.53.0

