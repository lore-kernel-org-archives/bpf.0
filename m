Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713333FA5F3
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060289; cv=none; b=VK+fpZRpcthGe4nb3zj+EqJIzkDBJXV/90pmW8g3JptUrv558FlhOs4IhrcbNPKKUY6RxebOpRw7FbQ7HaJFO+X8PMLwebMAh0GEJWgi2VHfgXNF9DhkP75RlNJhf6bGMmz5T20yn6Elf53JRTsI1LOAroubz7ccmmMiX/ApZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060289; c=relaxed/simple;
	bh=rmaQy+10MJwBCQ8bQ2r/5wgqZIrXjj0EKYHgv53pAgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAcmhfS92vgnKmYTsF9NYnaHlSSa362eOVP6QD3/Pse2Kwy7CzO0J8CtVuHCrhT8BsBfFn24YE7aNg1IhXF8fNRPpkD3+uD9+qo53ckr1WwzzyU1LX2SecrZdRIlZSiUYPqBMU1eLhkiPyOmSTz73qSJxGAdr9dNdgJid+EOb3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se9ZJ+y8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se9ZJ+y8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0046078so74601805e9.1
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060274; x=1777665074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMTr/NGaliTXEhmLqY5zsZR5nb1KKANWwLofmdP4wUo=;
        b=Se9ZJ+y8QL+OUsuNFqdZs/BZJs3TVi/r4Xt77eBW0ip134ynpDHPALSaL7Xrj0HMBE
         h/mIghO4vhXbyQIhkAbZ7Kcakl5Djl8Qu7EiLyeGMyo1ls0bShxj3P2cTNr88yvAMlFL
         rPIgPalGEk6BcmOsA3JCGTvdSi90VQTOJ6yvcMwXXo50u7gBze7Dju/X5uYzS2zXHMh/
         8R0Jl6YnX6OUatWekAlvtpxzYs5+a4z58pkhzwBTMvhaWfBD+/u2+6KVr5d+OupThPLc
         AE9TzPH5kJt/yGtZg20UiMoZUYfva3eqGJj+hxCN88dOT3AIxg3eDWVCVIirIpbWEwbs
         Rktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060274; x=1777665074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fMTr/NGaliTXEhmLqY5zsZR5nb1KKANWwLofmdP4wUo=;
        b=EwEZrNnhUCQ9sj7ZYam/soOZzMQSziDAJegPH4Jpd0OY0NIoU/DJPm5WNMAqVqI8yY
         LhJXznWl28I6/4ZwZNi13qCdaHbQhosjmBUU5EOhLMPKTqgQUex6ogFUYH0jER5laswH
         SSQ+0sPXapYOA7UNpaQx6iE0nntoAndZX8mBR2TQj1YcU84IRiG71PVvVz+a5RoAoQkw
         Sa8RfwvQaAaG684umKWwTQFTh22cAqd/E9UmjFuCwpg2/FU10E/3Or3QuC1XaHcxOW2E
         9eHaw/BA0t4jTFkCTcRx7SM+fkjJUVHIB09CjPFkcA2oXzbS2pcxPVnnrusIGyfGTYpT
         eyZQ==
X-Gm-Message-State: AOJu0Yx2juRLLmLRPyj82R70gbLquEaJy8GjwDgzSZ0oa5o7KrVkr4KV
	jtqBssn2Uq8KEaUFTy4ln6S3yGHLUbq7/b6ItKZ6gQQKoO6Um3W853tM
X-Gm-Gg: AeBDievrJwAKxblA1ErqzpEdDjRt8Lxnh7XkHEUQ5oZHrb4j5gV2mSdaZcaeyOyy1zu
	fAVz+vxHGMSIscOCCx5/c9mLmsJx+g69aX8Mmv+/ZWr5+q2ahbPXedckFuV9Nx2IdOeZo6BlGG8
	gGLuGryPny74lUoCw1r/X7zIYmTUPVzXzEzm5tu1zagbclPaoI4LMKAQJH4RrDru0vGTOCVb3jG
	RFd7Y/jFe2Kx47dZeWObMi9IcVSmLwEyDtlOoGnnitayBd56LJQb9ubbbddUnnh0vdQKbkvr+Fq
	/z+QZxyjzR6L8vFJtKZkzufY5C6H/VU0AEgBldRgJhu2EetgDg1s0RokgnMWxUhz8PxZftIMir/
	HOBPCrhGdW+ykopnC2z+VCRgqO++xL+6u04f/+A3VXBeUe9RD6KGhuxLaVSftImI/E3yJsaIJi2
	vj0WF6zb00ApbKu381YYsJDP45
X-Received: by 2002:a05:600c:1f94:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-4891c2d2213mr336476375e9.5.1777060274199;
        Fri, 24 Apr 2026 12:51:14 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10777csm688716135e9.8.2026.04.24.12.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:51:13 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 24 Apr 2026 12:50:48 -0700
Subject: [PATCH bpf-next v3 06/10] libbpf: Support resizable hashtable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-rhash-v3-6-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
In-Reply-To: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777060253; l=1414;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=yQetShQhNgsojC6nDckqJCqcq22GlvGv8ocTN1w3B6A=;
 b=NUgpd4VKl9g22+tDOEunNo47CE95mCg/N8MzDiMNAQ7LOjVmF7rZxuIakLBO4T6XA47JSB7P0
 tms8iTbWR/zCEAWyPcNO80RG451hu0IObN3YGTgxktYCNgyRGI9QUKS
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add BPF_MAP_TYPE_RHASH to libbpf's map type name table and feature
probing so that libbpf-based tools can create and identify resizable
hash maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/libbpf.c        | 1 +
 tools/lib/bpf/libbpf_probes.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 83aae7a39d36..b8dd0c09841a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -192,6 +192,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
 	[BPF_MAP_TYPE_ARENA]			= "arena",
 	[BPF_MAP_TYPE_INSN_ARRAY]		= "insn_array",
+	[BPF_MAP_TYPE_RHASH]			= "rhash",
 };
 
 static const char * const prog_type_name[] = {
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index b70d9637ecf5..e40819465ddc 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -309,6 +309,9 @@ static int probe_map_create(enum bpf_map_type map_type)
 		value_size	= sizeof(__u64);
 		opts.map_flags	= BPF_F_NO_PREALLOC;
 		break;
+	case BPF_MAP_TYPE_RHASH:
+		opts.map_flags	= BPF_F_NO_PREALLOC;
+		break;
 	case BPF_MAP_TYPE_CGROUP_STORAGE:
 	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		key_size	= sizeof(struct bpf_cgroup_storage_key);

-- 
2.52.0

