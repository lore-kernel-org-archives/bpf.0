Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D2A257827
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781565712; cv=none; b=cpztDQMoAW3B+TLenY1h51WFc1+PvDD2YrY2ZIW8Y2jHe3CbP7wmrsjQDPEcl8E2Xu88gXPMNqG4wfhl2nLnjWIFCz9n1WSoeNn/19qBNAg7jBv6oadb3O3nPhacM2FVt/DPXdycUc6cUb1hDOY8VFlDGqC//u33PLdQMqEAdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781565712; c=relaxed/simple;
	bh=+bKP6RNU3Lnhj+rdcITSOzQWYmJ2s6yMJ9InXzg3GJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWtaZXhE8Gcb45iUpN/Br8hwDRZd3C8GspVsxocp9vW8j3FAYSXdoqiOyJVHyl4BD7gRmunRA6JsnA99AjPoF7sb+BBu5bHu9YsRvEI+FkKYvx9P1KJWxhNk9LP4shn9Y1zNxPtxApyehLLnZUwBN8UPJknB6U+k3EBXj82943U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiHuSdEg; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiHuSdEg"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6cee520ccso2668340a34.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781565710; x=1782170510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fy5hRbHFiNdXG0PzaLsKXyxOkKyeJ6SKuWdrQQj/R0E=;
        b=HiHuSdEg/lEgyLF7S5g9eHenc3TH8367HorbKF8dtskOJJMU8yhGOJ5+tsFtS2NhjT
         rM00OnyfXFZCH4PMBHaZr/lxSiVDE9iQ528hgQ8nflg70xrDxt9E0XyY52W22nq+HrV3
         PdKRM+FRBBsUAPEAUVX0gjoiKxoEaTRxLzQPMtnX3VYHnmaatTAZdbmuXvG1DAiZdLrf
         HRIMrIIcUtcatDbOpFzrZf4xO87xcXlMZqSXYVI6gN7ggQxzZdg1td8XmbLTaJS9ih1i
         JB1EtqH8f2AILpnzevqkUPwmWwz97UC8S/LM3Q9SSAyH28v22tpoA5TYofiOvJCD0sug
         M1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781565710; x=1782170510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy5hRbHFiNdXG0PzaLsKXyxOkKyeJ6SKuWdrQQj/R0E=;
        b=GPMi3E5eRugI07g97Ralac6p9AIJzgt/wbBgW+gYjDuT3RGotH2lIbImTcoNCI+mbT
         cmnLr8yUlopuhMZLtOLATAoRsQ88LrkOhsxy9RzIZwHP70PL8jmai6+7XnobWnmeQX34
         mdI3CFMiTP3VOF86IjtE2cJCJNYvPNrnT7jkEAywp4wtJFhrukumZBhByJDJ9JfX6wxO
         4mdSSESO7GyEuPFx5KqDFwdygI5wJt+9uDDx15CCDOpOGZQPSwvwI/6lLNmmTLofuiDj
         KfXf1UmrbDvi106onDxovdrUK2Dn6YAY2fIAfQg03+2CT8WB7j8s4iRlnzwblPPL569z
         styg==
X-Gm-Message-State: AOJu0YzYZVk/pPuLgcrBTojA8QjoIe1RC8btKT/obNxPg0pxRChbWtlL
	gGr0gP8UFf47K3VP7cOtiXN40SfskAAfcUgKS58QOJA4RU+gEpTC8T2My+pu6z+7
X-Gm-Gg: Acq92OFQy1yMJPQNtC4ek457glG5HEybiF3Z66E9hLGpBNUtfOJ712xZogTCtk1Ra3P
	xLaHOx+/76Q/RRyMWpkJJ4sLpNjZGWtAouBlDdncVPc+rG6ri8xymIRXM49cylTdv3nCRe1Gvbe
	TMNJ1tNDFPu0O0uTZ0dU8g2IFT3Jox8U8gDxYplu5b+53jMcxQnkksdy8Nz5FY+BngXAw10RYQz
	FzD5OqjoDa1cf8GHJdVrU6C50tfXfZ0yn1hbCqWCWU934+elLVrhRFJhJgBQ13uf//FRK6iJRH5
	hcaWSvc5C9/EnkSWoHq/bVnslTDV49mE+p1vYh23SVeVu/x+deaVEsxKoQyadqmSrPy5kgFCpMq
	qKcsP4LjoIJaOI7qwZ2gR+TsRGOL6/tVxzbUkqqiTaN6aZZFLKbEbxgCVXvJW1as6M3+A7DU6X1
	QrAS3D7rYA6zYdNrk1cpObmd5RcyMQW2cp8Cnb35HgOs5lhKKeKoiicfxuazTCLt99SSdfP905c
	whR7St5yM+DbnzNsgeZPRu7pKjnvNmjcEZidquqYdZ83RPlTOY=
X-Received: by 2002:a05:6830:3591:b0:7dc:d7e5:8d43 with SMTP id 46e09a7af769-7e8fc80b251mr1087385a34.2.1781565710314;
        Mon, 15 Jun 2026 16:21:50 -0700 (PDT)
Received: from MacBookPro.lan ([2600:6c4e:600:3c6:100c:91d9:c41d:6cb7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5bc0e1sm5184642a34.12.2026.06.15.16.21.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jun 2026 16:21:49 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next] bpf: Emit verbose message when prog-specific btf_struct_access rejects a write
Date: Mon, 15 Jun 2026 16:21:46 -0700
Message-ID: <20260615232146.5491-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When BPF_WRITE goes through a PTR_TO_BTF_ID register, check_ptr_to_btf_access()
delegates to env->ops->btf_struct_access(). Most implementations
(bpf_scx_btf_struct_access, tc_cls_act_btf_struct_access, etc.) return
-EACCES for disallowed fields without logging anything, so the verifier
rejects the program with an empty message. For example a scx program doing

  1: R1=trusted_ptr_task_struct()
  ...
  4: (7b) *(u64 *)(r1 +0) = r2
  verification time 83 usec
  the program is rejected

leaves the user guessing which field is off-limits.
Emit verbose message.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf281..030505c8f3e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5786,6 +5786,10 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 			return -EFAULT;
 		}
 		ret = env->ops->btf_struct_access(&env->log, reg, off, size);
+		if (ret < 0)
+			verbose(env,
+				"%s cannot write into ptr_%s at off=%d size=%d\n",
+				reg_arg_name(env, argno), tname, off, size);
 	} else {
 		/* Writes are permitted with default btf_struct_access for
 		 * program allocated objects (which always have id > 0),
-- 
2.53.0-Meta

