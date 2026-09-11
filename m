Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F43848641C
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164286; cv=none; b=FVSQN2TwjlG5mK8psuJC8OrmfbduwWw/VN3mkuuWVU8C/ziGm29NPT79PY9aTX4YffZU9xYg6W5VGcPiY8km6gFiPdMmOKFTG4HDgsvpqOS3ALJ1fm1a71WRPOuFXJUDh0SwAe5sYgltb6Zr3y6+GCE/XM10ZjQc9/h+89e9q6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164286; c=relaxed/simple;
	bh=LfFGf2D5VwDKRKB/ORtwD4Hl7RNgEcOXbbUkBv3GGDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5dNmglDh/5uYO4QrT6I/00qgQkC9UbhYgXBe82drD5km1WURNrdUtW16pJmzcRZsOxLtDzq0AZkeRPLZdF7ShSut3j1SRwQM0XJrRt6MODK5PqiALZqhdegWyzi5p2YFMgJt6fuckoXQi5fJ66cpBNsg1nUfI2/lF+Hp7eTJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9/TYRNm; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9/TYRNm"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-80032c08611so207271a34.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164280; x=1789769080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Yed5ThLivKhsvSG/KCfTtA7XX8/ZI3EKGaY8KwOJQY=;
        b=M9/TYRNmk1kzUbPa3wB4i5vp0eQl9Af6gLhkpBkXHCpRb4A8L7uq5IWoE8D9zcS5JL
         UT7HT6sDjVAcx0LD6tKDIdtTyyBedgVmt/KE/Hgsc1stNrSHxAHoyMUCsBoNpys+Pr6w
         vDJNwFYHvRJZZlhKdYwCHom6Pa8zuYTTZT4JYFuRUI6jitPv66ugZ4ZnnWnPbhW24Av8
         cZjHCGP+gMAp5fr9ftlsmjqrv3exmDWorAFAYPPddsYDIjm8huHXS3Z3+uy5qaKhtOXj
         ATGjCsfXvW8yXTvQWJ6I1Gv3mzPi3IbrPVYUPJcf5zV3s3htmvktPzBxgZJod4B4oCIj
         dwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164280; x=1789769080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Yed5ThLivKhsvSG/KCfTtA7XX8/ZI3EKGaY8KwOJQY=;
        b=TNqoQJaWuARPtCt2UOcgumIShG18KP2nrYrWaUBqd0cN29t9G3zHoYPOz2FgywdEVv
         g/maHQkwZiBPwki0dOvZPRjaDgMAPxPzreFcOzfkFWkjsiXIL0A7l0BKiF4x6oTEu0Do
         vd1bD8J63visOEqITrY/vadZ1RvdXujnWllI7Qf8JiTAIeFyjIQ27gV5NM4ud6yy/Z/u
         WKiWgI11GwMFj3sjlTdXMncEsPoOAXKZxCCZvy+v8dO96yzkS9Hxhsv151IvdPY0rmCC
         G8wdFMNdj4NOsVlcpNFFWVyjXfpemqShf5zqIDSoTsdUhMqL2rSrh5bJjgiKDsvGM9qe
         AT8w==
X-Gm-Message-State: AFuF++m1O1VyQNLlSDZdYZN38CFpJ3OCvjWgj9OcjQNkvL6uA+o9WaMy
	KHhoo9z0MNXGSVGftYfsyNIPEMYrjHrwTGURIteDOyxEiebwk7jk25jEOA5Y5g==
X-Gm-Gg: AYBFou1SO0MNc08lNKoIGhn9h3uafxM06da39N1a4q70vd3crJRmuDhNfg70Rl/OZWc
	LrNnWTCJpfxXMHQxlkQaevKweyara0WQvCqhIvrzcot8nukNlwU2QBwacwj5e6Y/5srMq5OzK+N
	q62WxuBxl7FBH2M7Vcle/Ik5rO4e2cuRT/u9S77nBvj6A33Pti9BS/wvGghRpcAJCOhUYZb1jY1
	hQ4PQHS6w59cXAx7uY8ehWZgEQFJYgndTCHA16y6TXNdYoaYSJ0HPJT7YLItvYIPH447kubPO8f
	TH7M2aQIqW2zZSD+oVbippM4z4JFaucGKZrCWdcaDHyN5iRAH2n82jo7HBpPFWlwTvduzfMIryF
	Wen05uFGXDaogOeb75A/VgvyMQiay8EpRBKEiVBjH3HTtwnE0vLLiJEQdw8HMW8XRJA0ULYZ7Ih
	6GQDkGuxYaqzbQhvhitiuSmBPHo/eYTTC5jYfVix3ROwuLJTOvciqGUnJDk4V8
X-Received: by 2002:a05:6820:1c88:b0:6b1:b375:481 with SMTP id 006d021491bc7-6c0b5df59aemr7370755eaf.0.1789164280104;
        Fri, 11 Sep 2026 15:04:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df8bd0278sm2884928fac.7.2026.09.11.15.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:39 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 16/23] bpf: Drop redundant BTF pointer helper write rejection
Date: Fri, 11 Sep 2026 15:04:08 -0700
Message-ID: <20260911220415.1396439-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_reg_type() rejects a trusted PTR_TO_BTF_ID admitted by
mem_types unless the argument carries MEM_RDONLY. This duplicates
argument-specific memory access validation and is too conservative for
map keys and input map values, whose read direction is not represented
by MEM_RDONLY.

Since commit fa75b7c85b0d ("bpf: Enforce write checks for BTF pointer
helper access"), check_helper_mem_access() forwards the requested access
type to check_ptr_to_btf_access(). Map keys always request read access.
Map values request write access only when tagged with MEM_WRITE.
ARG_PTR_TO_MEM prototypes must carry either MEM_RDONLY or MEM_WRITE,
and size arguments use the direction of their associated memory
argument. check_ptr_to_btf_access() therefore checks the effective access
direction in every case.

Drop the early rejection and keep check_reg_type() limited to register
admission.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                                  | 10 +---------
 tools/testing/selftests/bpf/progs/task_kfunc_failure.c |  2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 541467f9101f..eb825fc3ce0d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8515,16 +8515,8 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	if (base_type(reg->type) != PTR_TO_BTF_ID)
 		return 0;
 
-	if (compatible == &mem_types) {
-		if (!(arg_type & MEM_RDONLY)) {
-			verbose(env,
-				"%s() may write into memory pointed by %s type=%s\n",
-				meta->func_name,
-				reg_arg_name(env, argno), reg_type_str(env, reg->type));
-			return -EACCES;
-		}
+	if (compatible == &mem_types)
 		return 0;
-	}
 
 	switch ((int)reg->type) {
 	case PTR_TO_BTF_ID:
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index f96b0c13ed1a..9979766d4d74 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -333,7 +333,7 @@ int BPF_PROG(task_access_comm2, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("write into memory")
+__failure __msg("only read is supported")
 int BPF_PROG(task_access_comm3, struct task_struct *task, u64 clone_flags)
 {
 	bpf_probe_read_kernel(task->comm, 16, task->comm);
-- 
2.52.0

