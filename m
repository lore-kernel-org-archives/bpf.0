Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261E3ACA6E
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711838; cv=none; b=F8JgsA9VY7C/XO+21Oke9Hp+wzpr5b2+ob41dKt9cc46zqxt0HVSx255Th8ERCAzCJLRd5eTAkPJpKZ6ctRMOE9IgGdHR3l8yCKWn0fKc/H8t+T9o4028j4ZjCDDKhzL7cRicMrY/D7N++aBeDj7r9IdCmO99GmGIqPKuhUkdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711838; c=relaxed/simple;
	bh=MGnJYZ/GvqucQQodRvkdGWuIE46isfMrvhQisy0B14Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gssZKlMZXX/3VL2mELAsYYqlM/e8P+dsH7jKa7uDx2XmEViXJS2m/J0197vZ0Cik99uRtgnE8IUg+SYbB4YOFBViBX09hornG55c+u8pxF0+BtfR6Xarp+WOfy5NF/zF/SzxfQfY63JnILgThZ32ZYJxI2mtY9MaPA680vJ2TOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLLQKOeD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLLQKOeD"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso65547665e9.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711835; x=1779316635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9IEJRWhGXUd5wfptWkX+Y5DkYi/zOG+ZFCPXPI3eAM=;
        b=tLLQKOeDu7PZ6gHVdhzzpWtEwTWqj4uskuXls+yP3Ir6HU0XhKG8r/Sw0VzmGKlOHB
         /AMjBKZ06rKUNXmlIGSULZaio5f+AKUQNiiFG88EueXCfXQC3kJGPQBfz+vcQZ+1lvdZ
         NqDPbvvSoVtJEQFknSJJZO6lE1DKFD6LP2Nft2oMyS58HtXaih9dLekr84y6Dwexe5j8
         XVm7HUs0l8UcfEUBvCSaXvhZZFJO3y9b2tHnHNf6qXfWRsoqhptOcDR1z3ucureoogWe
         KUulPKhvKmc2TOi3FX5E+b6XW4MbHmSHBmuC8yTJ8coghJ6PEs64w+UcHVKC+LMXfYTF
         +0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711835; x=1779316635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l9IEJRWhGXUd5wfptWkX+Y5DkYi/zOG+ZFCPXPI3eAM=;
        b=mUbtHQhTieidKqNnZC2jjwoDHv57bo1HqCPG8s7fEen9mvgTxzpM5jmeWJrvevnZpO
         NmX2dhq+zkUNW5T0vJoOcPM8ZL/8CC0rgJXyeWYpqc/YgBUcIne1opA6exClZe2KdSxL
         9ZLcJ2rJW89f/d99zYPgwr/U1j2rB/tQ+NcbfBn4phmv1OOK3Z0E9SkSmf2PfuxZ8OyC
         eH72BxfQXbQgyPPUWXAeDGquXOJpOULEM54scn6BmP94wHrpHuWkB9TdpbNLUaqSXZ2u
         FETjBchwtnn68mt315pRQQR2iHNXNl+CAG2FxuKIleBAkAh92pteQo+M0XcfdEddQKc/
         3nJA==
X-Gm-Message-State: AOJu0YxC278Z9CJWrtZQpK7q3XshKjIcqDMviAmV5bFap6TlR5/AoQmA
	V5JXD17ZC/Z81wid1m2XXfdaJ4gct6JGUNcJ4GdlbI3EkFpoN9FzJ66v
X-Gm-Gg: Acq92OFJ51O989abC5Y0T+tfZ47lNmxB6WAcoda8dqwrAoPuid4ImbDAWoWF1Hu0YY7
	YpDD21OWHIbhNSY41DSerMjCT4eoT7huV2/eBEZ/2SbRuN3zyf0rvYPEjjFa/F9c9f25JuqCJ/O
	osZo+CMRykZvLMzxF3NO1sY2sUWzhNYWv66e2qtaJEeylLV2Z9k1RWT82/NVUCOGfO8RT5H9CWQ
	tfc/yDKy3amNrIBS48oTA9tQBZS+9udGHnIfqe4WXHI8SWZIR3aqhC/ZwXC8GCZtRm1XqTM3EuD
	97MOXfi2Wg5HOgqs30T5w7+GVOwTIkwMvOYzo9Qpq0f9qsaGagJEBHn7QHbn+X9XW106ysul2x4
	vZPGtUCDLOeQcIXzKqvkE2Rv9RkYwUqGqgnAdZmirGoBOml9H9YNTS0as4ok8HyF75ylOip3yeF
	a8SdykphYu5D4g
X-Received: by 2002:a05:600c:4509:b0:48d:c0a:3813 with SMTP id 5b1f17b1804b1-48fce9b2e5dmr68986135e9.3.1778711834786;
        Wed, 13 May 2026 15:37:14 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb2c811fsm5720625e9.11.2026.05.13.15.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:37:14 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 13 May 2026 15:36:13 -0700
Subject: [PATCH bpf-next v4 10/11] bpftool: Add rhash map documentation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-rhash-v4-10-dd3d541ccb0b@meta.com>
References: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
In-Reply-To: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778711817; l=1728;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=LPUl325KXGW0z58tRRgqUDpIjVZq/nr1dAQYcVgI3V8=;
 b=/YEkoGkgRsxDVAn3OPip9SZyFT2oE9p8XZsww4YNCSAre/COCayXUIIOvPpIHXngcM7mX/nVK
 yXQUoM/OtjmCO8mJxgOziIYSkkl+ATWkuTZc06fLUoA91YHoNh9hZOo
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

