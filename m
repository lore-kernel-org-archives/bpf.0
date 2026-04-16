Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E28326A1A4
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362942; cv=none; b=odsN9gF3/Ssy4PXzs/Is9zChWbpkvAjddm+W76ppju3kHsys+Gyj01yA24S6PwIdjaP8ab0cIb1BSV/D112id0kaDjaGqCbMa63j4a16NpjIApQvhqUpCEHLnvHumFWWP635wIRJx4CNRvEZfcWZMoEo0dNWawc5Aacp8ei7M7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362942; c=relaxed/simple;
	bh=sJq75fkDjxo2t8GM5e/p0suOF6ixsMIICbfxVA7sRq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sod0sKCFozqmO7eZFyYpKUmu4ZtBLs10PDDorJCKeqWXm5iX7MREhmWrPf+juglosK1a/8rjPyyvmVUOGAheTmYVKpXd5urLSBqDprBpduRAsjB+6NOSKhBCbuZB6PRhfYedIuVTGSOMAGYxYwtyoLOsnAX9flufGbaI6cwpNlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR78A/uL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR78A/uL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ad135063so80271595e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776362940; x=1776967740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRWPv3aeN+Ix8tjyFAKhnEa22VUt6v2TV4jFNcBlz0o=;
        b=gR78A/uLK0Gir3BFDN+hBtVnhHE2RpLjPTu4n3TIeecJTCgbWznVVeG+zgMQhY4IkN
         KsqUiEWUh2RrTJCuD3tjsPJGxRTjVG8hri2AnL4sLlQ9Serc0zf2kR60hFHvzbMUto3o
         GryikMqWrM0vnRYfM9khG4UG4k/xkDmnWIF7xWZoz4rygs1L4fvdx1lxR1ubo9dCNQSJ
         eDEGv+S6gwOWxe+VpPiwxbN3FxCd9E4MqFFaYeL7J+//4+Qpo/eyvzfNt6ZuG0cRu/q8
         HhY5a+Wk5V35JYNiVd606ySWmV/EIDc4D0+ocqMKLVajvE/Q8nRW4Pc3DIh0oil+LXY7
         Knjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776362940; x=1776967740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PRWPv3aeN+Ix8tjyFAKhnEa22VUt6v2TV4jFNcBlz0o=;
        b=B9ms0WMogI3ZYZMDavmNp9u+xOZG9rrEQ0w3Nly+v5yq1fGMD13RpoGAGS+lVQDu7I
         gyfq9BykszVGzz/Qzc5pRTHRPKCgFNVgOCLlonjZ323Cg86RLE3hOOU6lu58a74IyYUi
         si3QwklYUv7Tl2Bc5NeL4fP+mf5E53ScRWYT9O8eJ4fOnZGY5dFaFXoWq2QQnjygXZV0
         fAEdsgkzk7AaS93wKqrCYz9RXxdvUCeyGkUSR1psjkn23e2vsj5VAyEhVyILrGGnH0a6
         qgPlgBHFPBkIi4N/X9uTZNa2L62xFImI9WDftrizOrRqOQSe9qJJqGwQYwqoMSK716Xw
         gIug==
X-Gm-Message-State: AOJu0YyNqYgSu6HnmkYZ9hQpuKbCx09SreMq9ZYPImZ2kYG1xfkPVULh
	UMJhW51sy2iywEpzDAW+e2WO/h/pbRNGeIBTZRCRgzgM45OcnHHtZSf1
X-Gm-Gg: AeBDiete+VU2sLAUnO6bRU850evvFmedlX/Tt7OuJ243ipTxOYvV/dXkKKnjTfravu2
	9flZ8WMr1J9Mld3XiBw85C7p7OLv72NQMqVTJwA77aMkpbEsSlExuejlGv/Cz7KxHITV/ivp2aL
	Ck8nLL7KU65l2iI+GCdGR+E9pCugoNtRpfiIB29yAQb4DCCvDllUbsiMhViPy6uGLjU7J2TB9Pt
	vICSURTmkCVwVpNp8/MmRylu/xYFklV4KN95KsL0FciFh1cW0jHDLKQVkuU23Av2hotYfZGqusG
	JxDsrzqmD7BaRU6m1jyOtWTuK64Q5QMKqQELyh+fw5mHWu2dpvr5kbwFzA7Ve3AcdwWTKWtrfh+
	VBzmD0u6h5O6qTMZmd6N2gJP4zD3497LAOhIMjpssa0sKmSWosq1Ato/aqj12ftDteMNEhXD/gE
	eejJDsdDHQ1M/LuINKLs2idBRB
X-Received: by 2002:a05:600c:c09a:b0:486:fe39:28b7 with SMTP id 5b1f17b1804b1-488fb2603ecmr162875e9.9.1776362939624;
        Thu, 16 Apr 2026 11:08:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:44::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5827e83sm74931385e9.15.2026.04.16.11.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:08:59 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 16 Apr 2026 11:08:07 -0700
Subject: [PATCH bpf-next 1/2] bpf: Fix NULL deref in map_kptr_match_type
 for scalar regs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-kptr_crash-v1-1-5589356584b4@meta.com>
References: <20260416-kptr_crash-v1-0-5589356584b4@meta.com>
In-Reply-To: <20260416-kptr_crash-v1-0-5589356584b4@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Hiker Cl <clhiker365@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776362936; l=1501;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=dNMEFbcAFc1jyeVIcl84GfcvhAUrW45ajQLRIf7093M=;
 b=whJHaqejrA9BZI9BFRq+VOBpp+dFUWAaDnEywYp36EkYv7YSc/h1F5g3kVhd7Zg7WSMiDP2w2
 Ck3/bk21TB2Aspf0NK1+3w5OUCz+KDDwLo0huXv3JF3GuW4nv2RM5xv
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Commit ab6c637ad027 ("bpf: Fix a bpf_kptr_xchg() issue with local
kptr") refactored map_kptr_match_type() to branch on btf_is_kernel()
before checking base_type(). A scalar register stored into a kptr
slot has no btf, so the btf_is_kernel(reg->btf) call dereferences
NULL.

Move the base_type() != PTR_TO_BTF_ID guard before any reg->btf
access.

Fixes: ab6c637ad027 ("bpf: Fix a bpf_kptr_xchg() issue with local kptr")
Reported-by: Hiker Cl <clhiker365@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221372
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e4980128151..a4f3f367988c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4544,6 +4544,9 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	int perm_flags;
 	const char *reg_name = "";
 
+	if (base_type(reg->type) != PTR_TO_BTF_ID)
+		goto bad_type;
+
 	if (btf_is_kernel(reg->btf)) {
 		perm_flags = PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
 
@@ -4556,7 +4559,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 			perm_flags |= MEM_PERCPU;
 	}
 
-	if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
+	if (type_flag(reg->type) & ~perm_flags)
 		goto bad_type;
 
 	/* We need to verify reg->type and reg->btf, before accessing reg->btf */

-- 
2.52.0

