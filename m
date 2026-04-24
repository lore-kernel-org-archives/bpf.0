Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C23FA5EF
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060289; cv=none; b=f9V2ffgDrIfwjSmv2aql3fezydnpPQ4q+WsctB9pNTWiVA80gs2jqN6PZzmlMZErYWn84gahN6IBlB2pchT8cyt+iNMJBicBUwGGaxc9Plz0I2D+loUIG/0acFCp5ru8gdgLFbDcIou6VIp5U2xVJYqy9M7rje3lsvdXFBsQhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060289; c=relaxed/simple;
	bh=wu202epcC4T4PGfhKGzlzstj7JgCavqk6qc2oYq/nFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYeqzhi2g1UVoPEiFvFMz09yvSbwZripdMeKLm/eZHs1pZVgirnMQsl90PNi5b0Ro0QPz7LBLO1Xfe98nu1BLRSFKMX4CToXeAuFvtl4fslPkmnpEYjnh9YS3TwfCo9RtC49acZ5tK1+pWXDfRHXjtJMvm0SRWrqHnXAHV2DdEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQRJQv5M; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQRJQv5M"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so134745015e9.2
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060278; x=1777665078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALHB6AC4e7o5pgMc6T0J9k1ZYnzRvIBK+xRc6rBziRU=;
        b=cQRJQv5MfPxpJCIo2BJhKFad4PNVl5KV2OCFHMDtI+JiLUpGnr8R1VIBCqWjkCOK5k
         BjRH9LUiuKo4reD4fwxQ4g+TE0dI0a6wf5YfzznqwL/C1zQs0efUQ31cR3adboTYKcNN
         W4K5qZWFwLPb0KiRqYh+ydFBaHoW5m2tSA/rc5hnKLB97hqdRT+MyUknqqNUnYm+BZgO
         GG0WhwZzuHqW1E+cwWwmv6ptU3p04OqL1oVoYU4/t8X32MEDApgc4ExMLudgkNz7o21l
         t6M0jQa8g4I+3P1kKY2xidLyEfNtpqvuF4eRWLcXiWYXFSRULP6lpzcuTmX9m21k3kDl
         HLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060278; x=1777665078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ALHB6AC4e7o5pgMc6T0J9k1ZYnzRvIBK+xRc6rBziRU=;
        b=s7oQI2V71UcDFdliq6kbO7rfzrJoykRdNrTmaNQm5XLC+1T0SkFhxmgxPtY3bPX98i
         TkIOg/B3vWR1i7fP27uQqd0hgb9r8gm50wthU7kjg2fissbMpm0+qJ/0Vat15Hew/B27
         9CwLCYLNiEYSOrjNkKE0meIjRG0Hqu/QNPeTFxcrDjfMDlgk3w+BL2XmfKJ2943AuoRe
         r8cPocw7G6HVduJajSdrlXIO4CspL//JfFzfR+UN2SWB1eeX3oMztwJGOeyNqx5zlN1W
         BnWOkRxeDlKcQ/iU3zK99h90wCYFsb0liyvCene9wajnSTkDf9HkApXh87HR3IE+kW+B
         53DQ==
X-Gm-Message-State: AOJu0Yzmf6lF+jHFQGULP7VkVVzAV63zY3OnAbQiXvrsjvlu63bMgKVJ
	R/H4znaN/6ZLvINhQgLbPNbkS20qbQhF/XTpXcAXP91bxoh8dr6/iIYR
X-Gm-Gg: AeBDietMKCm3C/7rBXYSz4KoNXcPmEKKHzfcENMxO7J7rGjr2QniSllXle/5imS6oT/
	G5YmC3sDJzKI3rJ3m1tLYVP4FSoRn4kfARpyYtVrKjIYP6FJB5tRxL+om59HpYWODWYr376Inom
	I7Fvbmut7DjZiPclumS3H1rRDzpVfFum0M+l5rtTH9uxiAKxqq1bPOyynfhYx6ujH4V+CXLNElC
	uVpwskcrwN/YmxxLH+Xb7gIj1p296hg/AdXW/jsNAJ9Y+jYLChnKrB/K2ApXC6cH0We9mT7C0Sq
	N+sfCrQIARdzBqgxcdkaTfv2M57Wg7JeokieQR2rPqcxM/eSR6yot0JMlnWKabN3VljpKmvbQ68
	Aw3mS9Xmwx8SlJN1qO/9Iw8gk3pZNDxUn5yAsTsDKs5oMGWctJbFrSh2lqyKriSPXHR/UHHLn9o
	MXHIQECl3LxArB/WiDtjmpCTF2
X-Received: by 2002:a05:600c:4e4f:b0:488:a2ac:a34c with SMTP id 5b1f17b1804b1-488fb7433ddmr462447905e9.12.1777060278101;
        Fri, 24 Apr 2026 12:51:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:47::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a174sm67835217f8f.18.2026.04.24.12.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:51:17 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 24 Apr 2026 12:50:51 -0700
Subject: [PATCH bpf-next v3 09/10] bpftool: Add rhash map documentation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-rhash-v3-9-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
In-Reply-To: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777060253; l=1723;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=t+BqmrQ9oT//EIy8sgfl7bViGuhYfjV9FfhxifpZDvI=;
 b=/Gzk/M6Gf4+/AsJAq8ja658yWhkSMBBSLf0FcldToc5rMCyPrLfB4wyUUD04geEmZ1cup1x+Z
 YLLldtfwB9XC/ShbNCxtgPc3ed2EMAA25DlaipvNYftubBIqm0gYg1V
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
2.52.0

