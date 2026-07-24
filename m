Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F11F38D3EE
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920097; cv=none; b=odEG2be6QwOwY5kSAZmHOLZXSCYXaeEaX4k+WA8sEUnRXQ8Fa5EElyCgEtulSQCj0A/Xz41HKB3zg9oSbvY+s8KcLEAjFyLh3K66ZMgHnKEF3d1nvLqQWn0DuoJJZEi03B3OXBx5xECbJ9nKdlkYxNgVSZRf67Tr2xAIFJ33J9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920097; c=relaxed/simple;
	bh=Vza8QrPNtPQHRcBjh30dJlgG80VV02BZUO4pvHUqlUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYNZNUKsD/ZIULe4eYYv9gdCHAV1DWd+cB3pAyQg0kDTTImbsDMr/2q6uABYgdWVZWt/RvlK7ZLYnyNU2XPjeuZGxMGPXoyB5MzBQzZz+vPOUG/un+ISveDZgA0cxe0T6KphAWsAyF4oO3LKk/T+EPAofIXv0Oqi49xoKdataPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUoB+Erz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUoB+Erz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceab75934dso10218425ad.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920095; x=1785524895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vv028n+m3gPhclylokuSI7IFB34Ic8AnTu0RjmcnGvk=;
        b=ZUoB+ErzI7Qt0yAIN4hSZvjicZFNrWPBOw5BXuBCoX4iJ7PXAb6bhqWWhQR6mGfSt5
         uiM0i1WyLVBHhhiktA3010r2932GDm8mECNxR+2wQ/0OkYKXWIpTTcoV0NA0rAtG3gKK
         NqejGl2fwFxP5azY/sRHZLXQ1U+A9UjiKW7quRwN4rfKU+7jCjR2Hdnd7wV3xbxT41Tw
         qWKI01BRzqRXnPRkmOYjWf3/jF8jpqohbfyqZX2fazFOUFzUQnb6ZAAhUxFa0n0gj8kN
         iGDIw+i5lSXt4Y7onzZk4N9dav5MLuGz0xejgrzZaU8w6nsrE/PC+5RoDfJ1Q7xC65OS
         o1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920095; x=1785524895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vv028n+m3gPhclylokuSI7IFB34Ic8AnTu0RjmcnGvk=;
        b=AW/Q+GYAgkj0MpYnFDVT+ujfopJKMcnt3bIo9ff7VVfQU7l/jiIDo7tEYJ1mqyvudW
         8G+BYzTmvbRWx8w9bCcYYou0hPGeKfpXCFCGAS0jSzxLqVmfCqw0TksvTgI5Hwavxj7w
         I4lJojHSgxdzE6aWWOi83It/Ur7ow+kXZjWWQ8eK6iVDnoud0uBlzpsS0mQAdqbxPn03
         gzR+9PPCOqjL+yabi6fwlZekWsAEExV3DKow69CnfBrKIKiAknuUWBA7rmRmjHUdtK5G
         IlwnoCwquyamstjZw53+rt8K6lg446Sr8actQwrDxV0YINP7vMbmW8XSOAWts+xcbnrx
         aiuQ==
X-Gm-Message-State: AOJu0YwIyf40uQf+96yoHiaJ8ZgikfE+kFQfGOYFeZ/vlqEcyI8gNC70
	52n6jNludanGok9/yy4CPznNlT4tBCHgp4dGjySHgaDl4MiX5mZLrt5/8QTAJw==
X-Gm-Gg: AR+sD12+L9tL3130QT/EWUNmBll9qPFBkTeRCh/W7MjxmX4QwNxAsHsHzw4AcsxN7GO
	WbCkPUYJvikrVw0jvg2i3pLpWJV/X+88qKghFSrS1vwWo8MHL5t7ZV5swu6qB783Bfps//Cs0vm
	Yap06O3NUtNGaumkmoe91Xxb2tnMeWaURopbvWWwacN1e/uqR2XLLDqRs76EWgGcXc9MPKvmthS
	+209fv+7YiyUrV/oUjj7RBzIN7YYuQe+cRMUU6J5zIghK2IagUxcpeWm28Q2JGVtKeFr0Dcv/OG
	T5wkBBAF7un14TZ5Q7EIiuk+drrgVLsnjfh3tUxA9TTcSLl0r1zbW6kgii6PKOraX63SR/fjEO7
	2q6Z2ugxt9Tws6VTZ/B79i7uf2D49leOQwdwcexznc4pBurnBKLOFn63JonUVaX/VO7zO89hPiW
	EWSrA=
X-Received: by 2002:a17:902:cec4:b0:2cf:7bfe:6043 with SMTP id d9443c01a7336-2cfa71ddb85mr93928755ad.19.1784920095313;
        Fri, 24 Jul 2026 12:08:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e6252sm56711755ad.52.2026.07.24.12.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:15 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 01/18] bpf: Drop process_timer_func wrappers
Date: Fri, 24 Jul 2026 12:07:55 -0700
Message-ID: <20260724190813.1458271-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724190813.1458271-1-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop process_timer_{helper,kfunc}() since bpf_call_arg_meta is now
shared by helper and kfunc. Call process_timer_func() directly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52be0a118cce..e8c76abbf76a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7224,18 +7224,6 @@ static int process_timer_func(struct bpf_verifier_env *env, struct bpf_reg_state
 	return check_map_field_pointer(env, reg, argno, BPF_TIMER, map);
 }
 
-static int process_timer_helper(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
-				struct bpf_call_arg_meta *meta)
-{
-	return process_timer_func(env, reg, argno, &meta->map);
-}
-
-static int process_timer_kfunc(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
-			       struct bpf_call_arg_meta *meta)
-{
-	return process_timer_func(env, reg, argno, &meta->map);
-}
-
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
@@ -8466,7 +8454,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_PTR_TO_TIMER:
-		err = process_timer_helper(env, reg, argno, meta);
+		err = process_timer_func(env, reg, argno, &meta->map);
 		if (err)
 			return err;
 		break;
@@ -12514,7 +12502,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			ret = process_timer_kfunc(env, reg, argno, meta);
+			ret = process_timer_func(env, reg, argno, &meta->map);
 			if (ret < 0)
 				return ret;
 			break;
-- 
2.52.0

