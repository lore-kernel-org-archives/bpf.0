Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09423EEAF8
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963875; cv=none; b=UICBl9PUl+xwuM+VGR15wsPw27OHis2b1ojHkjepo8Ih4z0l5c3DFvZvLfFtrY8sXONipR/Ysd2ZYnPasuc+iSRCyeosRrv8XUp7oHeodq9sjiZSULbRyw9a1zlJl1oAtv+kRFFz4T0xc45BNO/2MXGyUjim7ocWQnC/ziNL/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963875; c=relaxed/simple;
	bh=NH20ZJpKoTrg8UJemkOS5AA8s96bTCkUNX9uv+T03Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWPmBB1tX5XsiU7x1k+XWvFTHTeBRT7r1kPbbNvUviU54PJBGvh59wD+Y9agNSqflO16W93vq3QqZcWDoRc9UkjyDtt0+eHVAo7k/Gjsi/EqhxgNPQiwmJIOG8aC//ASR4S69Ma8GLawCoPD5uqz4+plYdpEx+792PqtxtwEx3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeYsb4LQ; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeYsb4LQ"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47f7f93b3d4so264687f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963872; x=1786568672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4rkrEjq3OMed+y/7L1zjj+TPY8dOudKQL2OKaaNLqdg=;
        b=QeYsb4LQF/A2EHU/JQElYgtImHpK6VFnQCD+dPGCaMgWB0GJVQk1A4wUoyfm48Kcib
         mtknN3opeZNPv2PQ9eMxip2+WOyvB6TT2sAijbkYWywuF35Zyr1xYu6t4l4lOfi7QSv7
         vrPKnK7V82E3DUUqgqp3WSPvexuQXRr/NH33x9C3xksUIxjCuYvrHMJl2CzvyA/CqgtU
         LDDc9NjSxD54nG64t5J3br8Zaa9LDhFCscG7M4VyKHiPRQgsrdsNQx4bh7EUW9Jr7BPL
         Nf9Dbkf3cfHPhlnUya2oO5LjaFCrwgXFpiDu1irYhHochEGsXIi/cT8AaOWI4Rg6InME
         /Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963872; x=1786568672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4rkrEjq3OMed+y/7L1zjj+TPY8dOudKQL2OKaaNLqdg=;
        b=opvzGC6v5q4afiK1ZduwXDTF+fdavraXXfxQFtBTIX/uGdQlXdN6fEEctk4F0sijel
         RaglOE+S+3tQp411JvF4r6NIMR2UW0UYZZ9TaKFCHYk1igs1sqCly62E3Pe37wAutwic
         aPPEeG2iao7IF7Adgmqi0xCz1QE2MSUcknx6bYDvzFDgpzh3Hh2+QEJ2R8XhvKIjLif5
         iohhB2BNru+Q/UvYoB+qi0TVswiu8TnRvLbhERwZ2+Cw2mV4kNx6QrzYs9Gl9WIfe5Xi
         OPsXKD4h9T5dnR/eNDCgYZkvFSHJe7sSHlB2+Cym1O21R4ZxiTmVopViluIEXPdT0P9c
         q+EQ==
X-Gm-Message-State: AOJu0Ywkk61sJP9hGpIP7s2SgMjv5nAoFqGw11z5cyGjUsmrX0ZDE2U9
	iIP1HR4y+2KcsGA7BJTbY7+7eI7CIaiKGJEOS7X7NkBoHpot+2l3SyEhkgd73lvY
X-Gm-Gg: AR+sD13/fZyaCgfrAfut1dDSansRlOv9J24wedfGh5RLJHv6tJPc1gHhBU+DeNiHdJw
	BGg51+wzSqQdHmKKgLmIodJeKAEksjCxFoU3DhFf7VI5lFkawnDdLC1UmrSZmbhDeRaTBo5YwU7
	fPuulAR9yxop9KKXvj2z0SaEC6tkevYHE4GwerShqcWoL3m0zNcj/aEqNg+6MbZ2sedPMWFh2/5
	NMkNXYaCs02ntA1e+3Ir/D391w9N2cmU/VKS5u+GYUdn0pVqQDo6Vu4fxBC9IBj/BWZA51B2Ng5
	sn5avTBhg/Jp/fVamMJV3SKh/i6pKkg0twxktkRHgM7oZnwJrcwNVPiPxpMvCAyLd1kQJhnxiRX
	e24A01Monhp7XCpL3sdnS7s3DRSm1sQXw8KoSY3U4klU2Hqay6ugDA5VEyCZvxR4Ym5+kO9F+q+
	Gjex6RGIeyB6X0xXyn/R3ztwhQmNywCWUr55a3RSJHB+I81KnwQNivo/GHvrwi9+PoZ4a2/K/Yv
	8Y1hHrkHBcoFeXvyRgxnKNMjJWMc/35mKRTHoovhreClhQipOeKnowYfAQ0og7k0w7TvirThTRH
	NrWsa23+eS+H9kJf2RnHE6k7J3s=
X-Received: by 2002:a05:6000:604:b0:47f:7526:598 with SMTP id ffacd0b85a97d-47fec5037eamr15481794f8f.12.1785963871947;
        Wed, 05 Aug 2026 14:04:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b1809csm257837f8f.18.2026.08.05.14.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 03/13] bpf: Collect kfuncs after resolving program resources
Date: Wed,  5 Aug 2026 23:04:14 +0200
Message-ID: <20260805210427.3218326-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2163; i=memxor@gmail.com; h=from:subject; bh=NH20ZJpKoTrg8UJemkOS5AA8s96bTCkUNX9uv+T03Us=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40WS+91WeG9keuT9R26l4gmG31RMLUbuz0luCLuoor HrK9E66o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABMxUmRkWLN2+a5LUYFiXb9u LxLeaaYhqMDV53WhdM/Fw2d83s/kVGNkmDZfLdxN5bHu/ge1mvrBp3YuXPvOtDLQIf0tu0o83yQ lLgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The kfunc descriptors include argument prototypes generated while calls are
collected. Some argument classifications need program auxiliary state derived
from referenced maps, such as the arena associated with the program.

This avoids a footgun in get_kfunc_arg_type() checks where we do
validation on whether program has prog->aux->arena and it hasn't been
resolved yet.

check_and_resolve_insns() records used maps and populates that state. It must
remain after bpf_check_btf_info(), which applies kernel-side CO-RE relocations,
so that instruction validation and the program tag observe the relocated
instruction stream.

Move only add_kfuncs() after instruction and resource resolution. Subprogram
discovery and validation remain before the full BTF phase because that phase
needs the complete subprogram layout. Add a short comment describing the
resource resolution phase at the call site.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 24b163c2bd63..b62e77949542 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20344,11 +20344,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	/* Collect the kfunc descriptors used during verification. */
-	ret = add_kfuncs(env);
-	if (ret < 0)
-		goto skip_full_check;
-
 	ret = check_subprogs(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -20358,10 +20353,16 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/* Validate instructions and resolve the program's referenced resources. */
 	ret = check_and_resolve_insns(env);
 	if (ret < 0)
 		goto skip_full_check;
 
+	/* Build kfunc prototypes after resolving program resources. */
+	ret = add_kfuncs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	if (bpf_prog_is_offloaded(env->prog->aux)) {
 		ret = bpf_prog_offload_verifier_prep(env->prog);
 		if (ret)
-- 
2.53.0

