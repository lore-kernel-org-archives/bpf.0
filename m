Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6668F3D565E
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661054; cv=none; b=naZNn6sPpplSZEfKvXTNWNXY9v4JAANSs1s40jz4ZBA2Xs4zVJYQ385rB0biDj2B2Dgtk6Y6dNCytkIixsEgt9pCYNbAB29HGyhu090hqRep8Su4FHEKSJw+fRlt04A9SXuYvllLnkD542eGmwj3dnC/CiNGcI6yBJYTpaXECxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661054; c=relaxed/simple;
	bh=dpjaXzL+Nako/JVufrvaILX7WHbVa3LBfW347W9Lb2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OfRDQLst1hKtWEIM+MwcNAFwfbjUTgmFKmaJRiT0aE/AQ+eAwhPh05T+8Qm4+epklBMn8TiLjGSUTgtNAZPqJbgbEbenJPA7u/5VMzYU7KmYspTjwfTgTJyWOYDMpzG8tmw3JzDyT8q9/32lIKokOU1hyeT2Sr72SkmJTUq+lYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rd9A14m+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rd9A14m+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso54289085e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661052; x=1776265852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XirjAStUibnNwjfCWbl7AjHybS8s0TCAv2y44iQMVwo=;
        b=rd9A14m+oor4v7p7iyCqL9U6WsL/uaQe4/ds2f1ZHu7e8ry3wOpo41qZvJ9bpzhocC
         rfPUTOlG1+hH4G2BE/Rsjghea5JXVhCYgw5C9FtUMXx2sDNKSSd6kZorC4iDwDBCcN5b
         i9dGwJBOmyOmvwPSqgXF0iSdc+7dMqfBXEHj4mCM89Hz0diX6qwUUVBBbF0FCons0Rtp
         YCsRv8yLil0yCbyTW6ZsL2Iq9+Sm/w+c/z0AYTY3HDvZZXjbA7QQn0FfFqz0KW2nEeLC
         uaMIRA8lFVqPp58fQh0eJeryQIhRjL6V2k0LTfy5O3u+4FFkZvLSGymljp2xAoa5dhFp
         VKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661052; x=1776265852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XirjAStUibnNwjfCWbl7AjHybS8s0TCAv2y44iQMVwo=;
        b=oIe/pMHW2woL86E09oO0o6u5fwlS0Xw2d4XaV0JEK74WVeZfeEl/Nu38D4yyfky+3Z
         DzuOpJHq5P7bNZEihwuFKj+xqod8KHuyNf8VT9jk06pcOjvdjKf/x9oW2ernG1fbOL1t
         2aOn4If+NCNYhVx7t6nE9kFTiBGmaOVN9YnoXJ5/kp62U+3q/sR+VsPUu3G9P2R4mQGp
         yVnBFsgFQmKELwOoWNixcJ5QljEmIlW3waaUY2HnGk09UCB+kBOcpDksqo/jz6Pa9GZi
         zw6m8fRMhPwQUlms7Du74IOXI+FL4vCAKOsPOUUOjDlKld4rsmYn+tWhZyozAOjpkqH6
         xpiw==
X-Gm-Message-State: AOJu0YwGvZMBhxjSeTnUw7nJ2OFesSNlYfU241EM1NlDzl5sWBO8KmlS
	Os0E8aYveHs4nS5m/CqLxOepGyJGCwrbQbDvcw/DlQcSyo0mx6ZjXC/r
X-Gm-Gg: AeBDievkk1D+YMZTIR1NOQaon0HMdGH4h97SBJWHI/7pjYOlRPQKQ9tOr/O3rrtGtcq
	kkaMOVxLkWLtHmLv6UdoJGM2ifc8SkATI6ZYxi2QD1wREQU1jDPVA9KSOV/uIJOeV/RnRZWDGOv
	j8zrHByJn8AUV+R70wfRGPvEwNjP4j40RaBg+YjRfECdAz/uYDAYfFYNbDToWmAyNdLr77RSSc4
	N59okc3S4iYQay3E6XQcAWkUznfD+2aVqLuk7q+OQloGu5ME67CtrtP89MyGV+uG9r/H7TVhanV
	xX5g6OxUkgRIxMx95h+ND1UdIgXuYOHr5t6LqfbgnkPHFW5AEo4yTv5uADEwO7pIEkCJniRp8WR
	sd0zDqMX0lcT+wPYOK5NF2/jWv/ux5x/KyWsjwC055o/shdQqOEDjlLmXTxN3F3H61C9d/DN8mq
	IlBaSpP09dpJe2ZA==
X-Received: by 2002:a05:600c:c083:b0:487:243f:dc3e with SMTP id 5b1f17b1804b1-488ccf3e9abmr1330125e9.6.1775661051752;
        Wed, 08 Apr 2026 08:10:51 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:47::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a706062sm582060765e9.9.2026.04.08.08.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:51 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:16 -0700
Subject: [PATCH RFC bpf-next v2 11/18] libbpf: Support resizable hashtable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-11-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=1361;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=b4fPlLMOw7EOPbTaDC7p4wARUlP86soWCFoXOum5vxE=;
 b=GVhC3JAOj3cSV74US6bB2qDy78nJV1kzMqsTD9zRAMQJux/dr+op7/cAZ8VsEks2E+pH+54tt
 mTGtrP+G7RmAdBvdHwFYvdZjPPyQge6Sz0y2whCJAP7oKar/sR1ESKn
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add BPF_MAP_TYPE_RHASH to libbpf's map type name table and feature
probing so that libbpf-based tools can create and identify resizable
hash maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c        | 1 +
 tools/lib/bpf/libbpf_probes.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9ea41f40dc82..a0324e5b6085 100644
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

