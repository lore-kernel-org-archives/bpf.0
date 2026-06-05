Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6344D98E0
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659710; cv=none; b=N+P73voRjk3FPXIY+v5qm7QdJ+/YAh1ULBvbc6DLQR0SHV6uGguN3KwGLVSTrSMtFpGJ6Z6thMgj6ak2Yfxy6efZL9wq5CJrmyEmBtjtboMNPWA0WX9id5EpmnlISjuDUzfQx6tidELNqG3X8kBgBHDOKo/D2qSM5KxZKam+Il8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659710; c=relaxed/simple;
	bh=MGnJYZ/GvqucQQodRvkdGWuIE46isfMrvhQisy0B14Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eMb5JnC5op9k1/pszjy+Oxozo2a3fhZdhnA0VU65ISXTfrTV4ZSovOvgfasV75FXkCydcpYn/xAmCneOKmFN/6oEZC/rXp45yhwsscMndsmsjJceL4jShEb9MYKGpjmskiyToxu5gR1uh0f63Ngp0hLSJeO+uZwzSZ9IBp2gl5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBSN1WzJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBSN1WzJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so19399785e9.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 04:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780659706; x=1781264506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9IEJRWhGXUd5wfptWkX+Y5DkYi/zOG+ZFCPXPI3eAM=;
        b=XBSN1WzJRuFMb/3vPREkNkgxsJKfijzLm7Bf5IYzjtCgD7WBSdDucaNusRWH9bc0rL
         DeiATC63xwwoeWiVRUmW1+2/cujkVFAiZ1R4ryDJd1fz5fFyCm328bheSy4JtAvQKc9w
         Nmnx1fKGA7JDr+lYDEBTMngOL0n2vUmJPRKGlgEaE2mr8Neczy4nfj7bUaDVzn0vsrV+
         aBgwrtbcZJFo/NjDMdSiAKBN4YspSSDQg/3T+MeOxDo54US2ukRIJpugav5WytLZHzhU
         rTnwD5ov8q2PxJzXhWpAdgvxcX1h8wq3QMyR0GZPaKxJMV74/FHibIv0/bmpKkDsKDay
         o/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780659706; x=1781264506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l9IEJRWhGXUd5wfptWkX+Y5DkYi/zOG+ZFCPXPI3eAM=;
        b=DrJtnOngEO2Ogb9v/tdB2Zs86SLxoS2jl3MVmMstVoZsfGS1fMpXZAnfCzV3E0YS8Q
         xk8Fpf5SeRlmqqKk1U6mE1r7bUqxdFP4Jcr9FYiBcR7fQvMu9RQf7eM71W/7OJUO+WHR
         2b9RHArjl6+dyCbn3go2pzYp4OOBWgXYmA2bYtsLzQe6Xp0gmFFO6JD9v64uCCbP5+zl
         moUtMRolQfgXOqaX7musTy5OO6EYl91XDJQaf6AVsNAR5cgnrTSMVA9muDysh9epDxjP
         4zqj2lOyoGGeeghuXX6AoXkwoxjEXc+WyaIJrsB5piy5uvCy/XtzyFj3uV18B0mlEugQ
         wEYw==
X-Gm-Message-State: AOJu0YwTGKA+plIQYHAtMvj1JvdjHS0Pq2Zk49mPiHZFiVf0OdQmLS/X
	MccunT9jYHGOlW7jvZgAUGHBuSks5ZlJgYGvdOJizlLJJ31tLdYoSgea
X-Gm-Gg: Acq92OGW+edhVaZ4GRlzXtAO0MFLTV1k60yRPPSgkAQ1qTCN5lLFermwxtK0R1f1gdS
	FBVJf0olEhOOrEefXANIMevc0E6DEqH+I1eTMcxMvqa1h1mKrmlJqjcw9oXn/pWWAToIAs1tIWX
	g8McTS3CC9ssaNFqSGX8tfabALsWCOiQam/eGn0CeOungJPXkln0y1+6IH7ATESomhsS9XrbY9n
	1VBHwVQLxuaZ0Cz7LcoSpjdxu8A4xJIdZQXfUlR6+DAUw1uJMeyslwzs8trYGOSGQ4AoRoYI5xM
	gIkPUkmo+r8uSNQjtuj4u9CyUkRwF4gqSzlcVt+WZdWhIhxsZ89RkEy2LXW7vG6PC2W3h+4jF5o
	HQ0+mB6cOUYsw/9kRb7lMilgZSY33BAhKy5BtwJmRWvBE8Siqyb2StgTHzl27Os+Xj7cWaE5Kec
	2OBClJIXApAQwMMvRaIfxcIvY=
X-Received: by 2002:a05:600c:348b:b0:490:be78:1861 with SMTP id 5b1f17b1804b1-490c25af9bbmr48761285e9.4.1780659706037;
        Fri, 05 Jun 2026 04:41:46 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm53683225e9.1.2026.06.05.04.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:41:45 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 05 Jun 2026 04:41:28 -0700
Subject: [PATCH bpf-next v7 11/12] bpftool: Add rhash map documentation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rhash-v7-11-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
In-Reply-To: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780659689; l=1728;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=LPUl325KXGW0z58tRRgqUDpIjVZq/nr1dAQYcVgI3V8=;
 b=0kxWl/VSNhMFd3fxvug+mDM/BblK2nSvmNaaJFDhezr6yw0JHj9V6ZKFOZHe5QITkneKch1g2
 Bw363Z/18d1DfoUB7nqc+l1FVTrOuhL+DYbtGSEqaC6z1RkYGr8QFh3
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Make bpftool documentation aware of the resizable hash map.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
 tools/bpf/bpftool/map.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 1af3305ea2b2..5daf3de5c744 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -56,7 +56,7 @@ MAP COMMANDS
 |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
 |     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena**
-|     | **insn_array** }
+|     | **insn_array** | **rhash** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 7ebf7dbcfba4..71a45d96617e 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1478,7 +1478,7 @@ static int do_help(int argc, char **argv)
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
 		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena |\n"
-		"                 insn_array }\n"
+		"                 insn_array | rhash }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",

-- 
2.53.0-Meta

