Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E691257844
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699716; cv=none; b=PDSVogHWX+rBvdzQm3hWOBlDidlO7DDBoZFNvWu4OePz4tZCbkzulTBwPs77sotEWnSRCfCoUdjDNya8E4EQP9IulTIDv44lWruCo+Wx+7NxWqE2fwRDiNY/YTKROCEIcb+e21cXyCXM2YVXWvN75noVd1wldlSuTCLsEesrDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699716; c=relaxed/simple;
	bh=xX1sxQFD1SqzIVKzGjRRUC+6p3+OKJ/cGxe6suGrDqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghoVi1AKggxm/Pz30h85rgqlnHx/iZMfol4PelPT+S0XKeA8u0s+OveWXX8sgqNSpIsGNd/XJHXdMIkodB/TsPghiRi+A2jCnkM4GWTs/7SZf5wB2I2/6uhTlg2uoG0kp+4qipiDLXyMgTcYcA/x2LdZbEmV9sp3N4IgeWz+Jdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWmd6XLO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWmd6XLO"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-88c72646f03so371162b3a.2
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699715; x=1792304515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nahT5CLrDO5hPJ0izJX2ttwIl/1WPg0hEIGWUEdBgwc=;
        b=lWmd6XLOYnfZ638rs8XwUbxICPedyIzUzsWaUXwzkBgM+nNppFlOyva9kISnSr9X/8
         2Fe3QHNytOAVkjSycgOSyNJyUo1nuC2PwTzc5rtsxxJxybEci20QtD+95D4fNFsXxa5o
         f3OXBpmqgT3GvLNCLNtxPasVVUsKXQ+gsxujf6jMq2J6qrpkEpN7PdPLyWs5+2XJvqHx
         SdJ93ZDdXV+Ky8sXsolYUGcTu6AfwrvIZmGmBTturLBhwNujO3ZnC4MWK4UCpPYj6OF0
         PW2FYF/+mj7+fzP97ZAn7fUffFtkIqNdwm1vuVIn08HuW2UgHNkjIBYWURO6cLP619kj
         pZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699715; x=1792304515;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nahT5CLrDO5hPJ0izJX2ttwIl/1WPg0hEIGWUEdBgwc=;
        b=UY7p+4D+okeNigXgmb32hoH3uflsoiLcAU3Hq3p680NsD9gTWHQ8SNG9V6r0pdiXLe
         fK14hYbnPBAyiSBZSX1YRVzNKMfiHuIN91AHzwCGnJyc3zOsA44PMuI/hEBzlNqcu1J+
         dwqIqQ37w75hJpYEGPtTBNzQNcRr0zN0W740MqGiaYWzz2j4FSd3WUEuNfwM64sQsq3R
         wVcmIFvW8iMoD36SWGArSPT/7SjNdFLE918IrVDZHYMS17wxu8Kvh8xUImTbUC4x3DFH
         ot4qHyQBbNMGVO7Z7cW8dBer+Lqm1Q8VUXMQSfaYKbU2S03TxIyQzsM8ttQelDjCc1xZ
         YdBg==
X-Gm-Message-State: AFq9FYJyBuNZOjC26Yax4BWgx5bkzqG0jQNMMkqInz9yOkt3YRoYhW/c
	w5GAzRRiUSXQlBMb9OK4MNoZBig0AB7FWHJhXQt+PIJLxKtAnRzvOOkFO8bM1Q==
X-Gm-Gg: AYBFou03Y1hUEQDZZ9n+URmqUIZDTAaSSPciGjWXk0yo/oJFwg9Fq1NoBiGCN+s7oMy
	WnuzD8JxFrEGQr6LnjtbY0VyILhZAlvkoNKyWr/eF9kHw04U4SCy62LXlBgpexxR9XVXEycuOQH
	np/AjTYK9BTicnwmlSArs5AlB3xJZ36m5UdUSEqBg8RhvonmOJAFEXrnd6Ye/9uCHpc5ehQrq7I
	9elmFuqDejo1VbjSGuDYvh0iEfik0luxyg5PAsT/ffusHjPVZa/UZwI/cuHk7xSFHL6quIYJq80
	ed7rJmZVamST+TQNtzir4eKfTHgfwQ3tZ2vczgofV3K650rmIbPsLHuROvGZmluC/z3wlhTpIVi
	rbkA7FCb1pxKosOrehfTUpK4ibme/WWbD2Bg99SNoblFS9QUdngJ89TAMBI4jkftLIzrexpVvcC
	LbTkrdRN3moJklppGUYzuieO0nvc2r5FITewpkLNjBWsCZKYPu8B61YqgOf18PjMd7ef8LBUkDn
	9lSXGwfzM3KJHA=
X-Received: by 2002:a05:6a00:811:b0:883:54dc:7892 with SMTP id d2e1a72fcca58-897c86a3c91mr5814843b3a.52.1791699714706;
        Sat, 10 Oct 2026 23:21:54 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c31071absm2854341b3a.15.2026.10.10.23.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:21:54 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/9] bpf: more precise stack liveness effects for global func params
Date: Sat, 10 Oct 2026 23:21:36 -0700
Message-ID: <20261010-scev-minimal-v3-followups-v1-2-6000e95ef993@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
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
index fc1937b37dcf..5b6200083d05 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14883,7 +14883,7 @@ bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_i
 
 	switch (base_type(sub->args[arg].arg_type)) {
 	case ARG_UNUSED:	/* Not an argument slot. */
-	case ARG_ANYTHING:	/* A scalar, the callee can't dereference it. */
+	case ARG_SCALAR:	/* A scalar, the callee can't dereference it. */
 		return (struct arg_access_info) {};
 	case ARG_PTR_TO_BTF_ID:
 		/*
@@ -14899,6 +14899,10 @@ bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_i
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
