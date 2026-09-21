Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4BA30E838
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958333; cv=none; b=A9Fxn1YMNKYWVyMUb3VGr7rSVe5vCWn0HCe8eKQPL+PCNqWcBUmvrheMOIuagAc1XVPzm1OEDRRL9XK5hs+UCyUptTKgbZiONQb+ePIajj+P05p4b1VDgBJh/IegaU7Ms8NjZldDusbVj+ZP5SWW55yfsZcWGL0TpmcNQiM1Uxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958333; c=relaxed/simple;
	bh=yhL8m3Fc4BysOupG2803VCdelEwskoeuOsm9B8IKGUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIwYEwCyk917bC76D4MZZcgZTElZ3ttR56Bem8kIkGdhxnI5VBdjbtL3NaA5iRuzVutATz6WnQRUoHukwzf8ttro0GheQp6yUGGi05fEb1xccVLZbCtMVdCw7vtlU/XilapXQba7CpyBwFd98xMdzgUVsonzTzXDjoTR7UePfAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giS6iuU5; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giS6iuU5"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so6493785e9.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789958330; x=1790563130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N5UpJfVGbjJ8uG3fAmTHCHIXn6gWtEUW4nqsTFPfoOc=;
        b=giS6iuU50K0sPO+cE5/czYCZaQYpivLJkD3jG2olPtmcfJk1at2sv6EXpXLbsDfdnZ
         eM+3KXYYl4Bm4ZcM4KWiMoG8cUw/eZScXwdNKLDUynZU/3xwUrsQJrAqta8++BYv1VSf
         s4P0CQ8UsPuUJ/YNv4QgePcgepDxZitGRQV8Ps7aDK82cVoA+NAc26UrE08l+IQqeHAc
         wg++9VQe9TYP1WDH40/uDykSlebka2dgOwPTCzH2GmabHZbTa6Ef++rqkIrprZdhXZqh
         566p+hw53ChsKetSP3sEcFnaZ0fFN06wRULIr+WThgeR6+rJ05HcDuvatThtFgE7Ack0
         Btjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958330; x=1790563130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N5UpJfVGbjJ8uG3fAmTHCHIXn6gWtEUW4nqsTFPfoOc=;
        b=ZJIar3DaBio8uTVTpnRtD1lVPFt6fFjuT0ozZaVvAZsd449nnwfUyH/abPeiBFzJ5y
         3enn559WbUx8T5Z3GwvUjd6aBhTFyXGsqvbHtQDZh+nlCH9qW6T3o+vNrCNqR0ALtSY7
         RtirPjZys+f9RZkTjdgi11mkyHec77oQONfKKoskKoMczMOUM9AF+lJyqC+usNSkK5Gm
         3mEqhhwEIUSYsoCbcT3t59y657JBzpu1g6WhQa6WwEl7R7fwi9KAvJfVWY1shRczPNyT
         MKgc2Z5zToH/hwTIxlx7axZcY0hztsR0vKQbAtgUG7Lf8AMwKyoMYiLMYUDj1X3BdpCD
         XNAw==
X-Gm-Message-State: AFuF++mYeRi/lhym5CzBU9S22ZXRNdaUB2V2YasAJayfHZGNd2Kx4hZA
	5AkV+iQe/SM/6dyTpmZZhlAB11PsjR1W9SwBctyLXH+6yQN6OErRUYgX5q/nHwio
X-Gm-Gg: AYBFou3P9EAHzy/Efisq6PZQC+LNZVCvUZQLVENTvpTlMWKxUMkGjdEPVmITLnTq2N/
	yfI/LLDoiJO+3Oo9h340iQjrOe0FfGpnFgCjo6E/weCJF+CfEBn9eg74GFwKNiexaTHdP4WLUwP
	z4JOXs7FakDIp923f50VpXaGw2G0v7UfIQKm/wvAtQW4Fq43u8f+HtoFswKIRpzf/0aWCgrQElG
	G6JPe0F7E0mdRb5288y5cA4WuKlHPJakSDtocwaH5cc3i3yNwy9l/Evthlfo/b5+cohoS1WguiX
	qYMk/TuCaZjmi/zT7fens/N82N2RPE1XdXA+sLjlNfCam+aSWkrL/lVC/V2oPcwjv75MlGcfQOA
	NvlhmeWLdNH2PfEWmArfhvQamUHe1l7GF6eT+1ZVCmRnQxwUw9YPxIQOvm3h94GlizT6hPTe95I
	fbUPb3uQi4mRhe4UwGoqq/8faeOggRAuy1gayYv/i475DzpwZBYOzn6Et4NWiYDI/VhpjKS4m2B
	aLSxwCYRTewnxVnw8x/Jk2aUGgFfbY+yAz+JuOfBNkOi7Sdlwi+B+Kn3sTUAqwlbZOo2QK0RIL4
	amHXy7QYI6VwmkCqxSCTsUdrMMuzBNY9qxv9D2sU9pZYrldx
X-Received: by 2002:a05:600c:6296:b0:49e:63cd:31fb with SMTP id 5b1f17b1804b1-49fc5714bdamr128976785e9.9.1789958330305;
        Sun, 20 Sep 2026 19:38:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f7b9bsm191795905e9.5.2026.09.20.19.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:38:49 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 03/11] bpf: Check __uninit kfunc output buffers as write-only
Date: Mon, 21 Sep 2026 04:38:27 +0200
Message-ID: <20260921023843.411943-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921023843.411943-1-memxor@gmail.com>
References: <20260921023843.411943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2946; i=memxor@gmail.com; h=from:subject; bh=yhL8m3Fc4BysOupG2803VCdelEwskoeuOsm9B8IKGUk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvD9E168/mY6r8dDMkJKz6Sk2KroLH3d3f3581+bNxLr yulL9DqKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwER2v2NkaD0U6ccm5tYT+CvU eOGR5g3Tl06Iv/trVaegtqn3n4s/VjAy7I1gNFpe3CT3UZDBY1W60K8LC/dbnMrey7KxM8+6fNs fHgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Generic kfunc memory arguments are checked for both read and write access,
including __uninit outputs. An output pointing into a write-only map value
is therefore rejected, and a stack output must already hold readable
contents even though the kfunc only writes it.

Mark generic buffers in generated kfunc prototypes with MEM_WRITE, and keep
MEM_UNINIT when a struct pointer resolves to generic memory. Check __uninit
buffers as write-only while ordinary kfunc buffers retain read/write
access. Helper access selection is unchanged. Definite initialization of
stack outputs after the call is addressed separately.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 67c1abfde922..de40785d6a7b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9190,7 +9190,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 			break;
 
 		access_type = arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ;
-		if (meta->btf)
+		/* Ordinary kfunc buffers are input/output; __uninit buffers are outputs. */
+		if (meta->btf && !(arg_type & MEM_UNINIT))
 			access_type = BPF_READ | BPF_WRITE;
 
 		err = check_mem_reg(env, reg, argno, arg_size, access_type, meta, &known_memory);
@@ -9238,7 +9239,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 			break;
 
 		access_type = fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ;
-		if (meta->btf)
+		if (meta->btf && !(fn->arg_type[arg - 1] & MEM_UNINIT))
 			access_type = BPF_READ | BPF_WRITE;
 
 		zero_size_allowed = meta->btf || base_type(arg_type) == ARG_MEM_SIZE_OR_ZERO;
@@ -12457,7 +12458,8 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 			PTR_ERR(resolve_ret));
 		return -EINVAL;
 	}
-	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | (*arg_type & PTR_MAYBE_NULL);
+	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
+		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
 
 	return 0;
 }
@@ -12970,7 +12972,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
-		arg_type = ARG_PTR_TO_MEM;
+		arg_type = ARG_PTR_TO_MEM | MEM_WRITE;
 	} else if (btf_type_is_struct(ref_t))
 		/* A pointer to a struct without a size argument is classified as ARG_PTR_TO_BTF_ID */
 		arg_type = ARG_PTR_TO_BTF_ID;
@@ -12995,7 +12997,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			return -EINVAL;
 		}
 		proto->arg_size[arg] = type_size;
-		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
+		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
 	}
 
 	if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
-- 
2.53.0

