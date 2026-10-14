Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F06AD4
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959093; cv=none; b=VjizuwTMfA6WQjv4bXEj7BhRPCwuLQSH0kYfDUs5X00/ysuVUXLq+TtWRXz6u36+OCKsiVRk3dFKi6MDYvy82Yybl0grJxgevSEMji6VnByfpbsPOVA8auKg4Kjj8VBCrKYKNj86VgMBzR6/sZmAfD2lZ/IkAQVbXRxGPQTPFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959093; c=relaxed/simple;
	bh=6M2X33BxbD9hd2lq8egqnXqvoqQ8qP5zvkkr3DbP5v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEV7A0TtLFT8pHPCVdzMsVqw+Ac3r0RoJ9/W2nUyVokYRYBWCigTq6byDG6c6edvg0vZxbpnYyIPsTH2c9lSZf6ztdEbSheqZjRQ0iObMl4SZHX2tuoRTWpCzWCqC4Sd4VxkJga+IwrfT6dCQnXzQ2zefRYiLvOOefCS5mJDApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7FL6zNx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7FL6zNx"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so25288a91.2
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959092; x=1792563892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gjI5tQrqx4e9HFlKGcx9/y7HJq2pwX9ri3/KBkLonxE=;
        b=E7FL6zNxAvxBmbmJiV/uBOntPzF/YjKKN/GUT60GvkPUfiWRfWP7qLkyRwplE1o36I
         voE1wKrmNOwRiUZevMIXuQs5RSQOg7/X7tgtkaQ534sFKUen3+nDp0puBBWqA0FjfaIR
         KcKRNeVl/rNyyzTrFl65pqd2d7ySDHawmPl4gNhV1mH/GChQNG0CAZdiTehK8QYUsONu
         PkU1dtckMig24lSzBJDGJseOuur/xaMOC2Q2uZzfPMwqBTAEYGdV5StKgpLYbh4SCHoJ
         wHQ3N/wVjbiJcgoP4E8zbofKDf/Rv02ELy1+nff6Mgx4MnBZS3m2xBLFMO6t1FUIOEZB
         5/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959092; x=1792563892;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gjI5tQrqx4e9HFlKGcx9/y7HJq2pwX9ri3/KBkLonxE=;
        b=gqqYFXYm06nroZp20qvOJm4CUvxCniXeas7L60VCAnI3vikHXwQj2i3D+nSG1pZv/f
         62ucEd/XAibDAk9iBo12VZ+FPyV6+DpMAhKfhCnEYTaWf53QU+JPJIr2fYVp+8l764ar
         4nhnr05n8tNBgmdKXH0jWJ3Y92jy/u49L4JFJ4dVPLKJE41JS/pWLlKRvU+MXcE33dJk
         TzKO7rr7Q5HJeb6jvbrUBSb4wz+fJr9f0K9YaDYgVRnhptfjv5GSNFqTfh/U43NOLo45
         W3Ani1VzSnJZxcBQWYkJsgg0Ju+QROqyKrVkVm082TonbQqPyXpzJ8gfQEP9IRwbKxcS
         VZJg==
X-Gm-Message-State: AFq9FYJVzaMcqjuMYdPuAoz+qnTHi/RcmN/mtYHcBV9Sr11rYuQ5mT8Y
	e3zi8ACc30MBBGMRsMmnOHSnfHnV6pctrsd6B9wWKYR237HCGc2ZIsHITVqaWA==
X-Gm-Gg: AYBFou3J6IdrOwfpxHwUolB6/XtI9Fw8zFTXM9iezqE10lg+ScRR6Cft1Fa1fWVjESX
	hVmeaMvdkSDNVDVTyUMySZOe/k1DarAWQ01K56ycUvxtxhOK+cDJiHKR5ZxFSS/jd151tlMBuf8
	gCPRmbCAWQ54DWteAhcXU064LCcSYXUJFNKjXeM0XoWEBS2xj7g6HcYDZwEjQDWntIjJkRHPXgo
	wOk1EgBXRN7unuoZ+dFZSXXlObAuWgV9a/wP2DwfH6fCIEZk9xIsIg3SXZjWcWjfyLc7we253Pr
	8bryhgidYftvQJMs0xmjWTBk9wphDBn9CFRf4TNiUsHfY/abuiAeSJL7aV+jGuEOYsIVPOWRfuu
	S9J3mFaK1RXUwK1nfqWO+9pqR92jyt1d7tY/7qnAvjvqStLpEpVpLoylqkdk4yGuGFqps7YgDsl
	l9ramac+LELadHTuQKm/4pgsva2u3Q6f08Z7YrzcJ6vBISIeJq8LVlq5k/y6pEPqMlFuQ5brSc9
	+Y77veeZMlNph0=
X-Received: by 2002:a17:90a:51a7:b0:3ab:3e1c:3c34 with SMTP id 98e67ed59e1d1-3ab3e1c3dc8mr9666079a91.51.1791959092033;
        Tue, 13 Oct 2026 23:24:52 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e41126sm6614238a12.23.2026.10.13.23.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:24:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/7] bpf: more precise stack liveness effects for global func params
Date: Tue, 13 Oct 2026 23:24:36 -0700
Message-ID: <20261013-scev-minimal-v3-followups-v2-1-6d9d61965486@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
References: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The following types can be returned by the btf_prepare_func_args():
- ARG_PTR_TO_CTX
- ARG_PTR_TO_BTF_ID (+ flags)
- ARG_PTR_TO_MEM (+ flags)
- ARG_PTR_TO_ARENA
- ARG_PTR_TO_DYNPTR
- ARG_SCALAR

Of these, valid programs can pass frame pointer only as
ARG_PTR_TO_{MEM,BTF_ID,DYNPTR}. Additionally, pointer arithmetic
allows the following trick:

  0: (bf) r1 = r10
  1: (07) r1 += -8
  2: (1f) r1 -= r10
  3: (85) call pc+1 // r1=fp0 ?
  4: (95) exit

This commit changes bpf_global_subprog_stack_access_bytes() to handle
ARG_SCALAR and ARG_PTR_TO_DYNPTR, thus addressing the full set of
possible returned values.

Fixes: 8212c1c2986d ("bpf: Derive global subprog stack liveness from BTF signatures")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2f190abe3448..e477ef4465d5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14871,7 +14871,7 @@ bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_i
 
 	switch (base_type(sub->args[arg].arg_type)) {
 	case ARG_UNUSED:	/* Not an argument slot. */
-	case ARG_ANYTHING:	/* A scalar, the callee can't dereference it. */
+	case ARG_SCALAR:	/* A scalar, the callee can't dereference it. */
 		return (struct arg_access_info) {};
 	case ARG_PTR_TO_BTF_ID:
 		/*
@@ -14887,6 +14887,10 @@ bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_i
 			info.must_write = true;
 		}
 		return info;
+	case ARG_PTR_TO_DYNPTR:
+		/* The callee may adjust the view, but cannot reinitialize the dynptr. */
+		info.size = BPF_DYNPTR_SIZE;
+		return info;
 	default:
 		return info;
 	}

-- 
2.53.0
