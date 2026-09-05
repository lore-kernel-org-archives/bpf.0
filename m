Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8826AF4
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645706; cv=none; b=ZAIn9TPvThrO8gODVB5dkjjD/ZR/sK+rdncDxYGm7j2qDTiQQHIXgckU5B9n3Oaq9xJy+zGZPJOcobufI/gapfSBqQkfkvpo/cfR5ci5ZR/ha4FgOPMYjllHwV/iE6PgxqP5c31b6kJHq6WpipDvH8wVEHtC9BIrS+4A7Suddok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645706; c=relaxed/simple;
	bh=z2NAR3IcpHdJDUQXl7KHkUN0A0XmDnCAtzkfzb7bQdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaBoZmLyyGdwb5Z4PYSpfGmrAcoZ2VqgU+3DDfTo8Kydo6QAt+xR6XP1aaisrg+8sokQawaMXqy9BZEbQ4mTVbDuY/APsG9LKANU8e6VcqeHFLjrfsV07YfaGv8KvK9BCol2spY7Ej7UCxoqlOEQOKuMTfDh3s8eoiIVUtsVgxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdzC8p9X; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdzC8p9X"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6b5737bb2so2951092a34.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645704; x=1789250504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7a257CcSbHDuqAbigAekQENiAZz6ppGDv73O8UsjVyk=;
        b=sdzC8p9XhXUfFe+ggSGysjMkfKOIVbGWULtZ/F5+Ng1fT6U/TYmH81WAMX95ioLwJC
         AeUQKE6E3ed9eDslpNa5fYtR67qB0Wf+PcyzOjf5jqdqa++SXG8Sdy9znOBnA1CLhRA2
         rZeZSpi93lLdlNSWN9Z2VnDhpLRp4v8h4od1yv6bbknOogudl9WWzW9ynPGQ1DpRcnPG
         8gCIdTEPQXKqwnwg+X3en4D37rH3WEFYuI9mHuKzBZS7W6cS1y/KXjGot3Kx6BQZQ+2l
         S2HY8rCRnv1Hsvi4zgiHJcg++vcJCHxNl8lpjfWIe1JXKC2Ad/CnMvXp7GzgR6RzNKZK
         +tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645704; x=1789250504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7a257CcSbHDuqAbigAekQENiAZz6ppGDv73O8UsjVyk=;
        b=HLBfLq5yk0voxX1hgSQN+vQ74vN0MbNQ8hSaPsh3jwbjLxRGi9P1MJ0NkPlOfqQ2U9
         6pC11EfA9Y8kZBhbvWT7xn9ZKnvsd0KU/mDFVwZUtnLTx8Gsi8qoolXveUrW1gEE69Cg
         GRt2C9WTF5tSs6kZ3y/BtbxB+iciASsLjZRp7JI6efsTztNTKVpM4OpKW3wVV2FB+23B
         Sm+TChEgn4LxrGhg47N3IzmrDo1p84lwDwDi63xojVz6a2mXUIynBAY/7PqL7Aa6r7uU
         h4vOyJzIjJVZOhi03HLORjlw2reChVmvmFngG4AlrZDL2clZxjJdVaOuBil8qi7jFj5y
         wLjQ==
X-Gm-Message-State: AFuF++moBoExLTY8Gw7shtEOBWiuoeuqOFgLONn6ACVKrzEUUXF1z3Fz
	bPXcatiY+AhZLUGhqodzRyMTAytZN3slGWNBjXKy7NIZNt3ZQY1BtC8uUHKSVQ==
X-Gm-Gg: AYBFou0eXz4ZSkkAkUWgcYx358Y/UojJcVm8sZpIEa8V13M8zE+RcxNgDIYR84p6X21
	fDZ+xZ01VicjIe8ONevZMHx4TDX6O4bgQ8TbaJPDkVx2ktEC35gro2/WLRQWYAKxuIZguypgWZs
	izWLgobpeU6XkhbB7NaR8JmwOhCDjad0j/OvQSiNPlzYCu7Tclws+jFLTRidYdHOHUr0db4rMHb
	PqRW2lbZk/BjD+UP5St+QxOC8dfTh10q++HSkf5tH8WFDZjriDFjIGLByCbeabhPJFe0nNPcVna
	0aCdz3pSY0d+66bxqIgfx+jvf8IwRvAeXO+zejatXNaJKuEkxDSI184a6zGVtixUEc1z9Z4US07
	QM3U066ymYoRSuYaVEil4F56lyyzNdGBws0j2Aoo7ogsbduZIVmIaPn1CofrAUSpnivUNjN6Mvl
	0ErHhVcAteL0nw6JETUicyHHnMjpCq82G9KcaOWrVRYUSXUPV+0AU=
X-Received: by 2002:a05:6830:82bb:b0:7d7:d524:bc88 with SMTP id 46e09a7af769-7fa1f420061mr10849231a34.10.1788645703698;
        Sat, 05 Sep 2026 15:01:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fa888f614dsm6025531a34.15.2026.09.05.15.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:43 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 16/22] bpf: Drop redundant BTF pointer helper write rejection
Date: Sat,  5 Sep 2026 15:01:11 -0700
Message-ID: <20260905220117.922028-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
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
argument. btf_struct_access() therefore checks the effective access
direction in every case.

Drop the early rejection and keep check_reg_type() limited to register
admission.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1f5f975c73a7..09a51d67ab7e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8469,16 +8469,8 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
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
-- 
2.52.0

