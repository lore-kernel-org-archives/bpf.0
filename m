Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867253D5645
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661065; cv=none; b=uV5BQL/X0DgWRs/YqTGWvxQfCVCcLkTWtBpMtjoL0zYqIHEIyIu5/snJ5zOP+UHiagCDq76yyCMJRVnhOKxkOyQsqanpu3kl0aTRV7FG7EmqXgJwAyYbr9J72BxHAtn3aIOsacprsG1VqnTbdqpjbxKH+GMEhdAlsHh8WZroDJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661065; c=relaxed/simple;
	bh=jVeUIW99Igy/p/KFRFzdmaAct1JVIJly/ksTPHi4LZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndf73UjF51QvhE2aN8NYcghXNO6BsvjkCz59s2WCSCtZgerkfQUvTnM3UjOj+EpH0lkaLAsF4RgZ7iii0WdamrZxIPEaN0nVpET24pafNpvzjq0PlaLkPyG7xXURwfr5T3xY4GxCssSgx4NsWkc3u+ZS1CLBd8SYxGOHtZWeDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSXwbgCL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSXwbgCL"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso57987775e9.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661062; x=1776265862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S392HLEPJOv9IMyT+KEK6GGqjrxmhxlZVmCfVc/vbqs=;
        b=sSXwbgCLllY45VH0XdiEvM3WiPmFVqY3ZzcA0ikqZVKF7HwxumXEDL1vZqUh5Eeyjy
         f+L6qJmzop8aUfpdNdkYYNq6vUpLuAAGJyWWnRVGDMQ0DG+zdSmDhc6yTs49bDKVFXlq
         17eiKGu5dXKU2+O1yKpCkzuGVJBPQIo0vJdsUNb9CVPFoehlG4fOk2DvIrRBI2oizCYV
         MZumTXceHMkq9wQIsO9PscmfePUcnZv1PfaWGwwPClIkevlqBweou7RIWIFm69Fgq2bz
         /S2B4jGHMaM0HZQyFLSa2cjy+P8qg6Fww6CGnP+ypaWCXCNNXOB7wcF8GK0RR3soAlOM
         bmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661062; x=1776265862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S392HLEPJOv9IMyT+KEK6GGqjrxmhxlZVmCfVc/vbqs=;
        b=ESoRNlCf9qrk5cH0MrApnkHBp76vXHc/JBM4iiCepqAN1ZOMNUGuixhoaM3T7/N8SK
         YUjvqrNnFBb7QJCGJ2tneSgfsh+ToZ6y5oMN6uGcTO6S4SuirHui/bl9lIMnpePj+8VX
         W5mm/kgnjhxEbu+SQm3wxB7n50SrOfNSKaEYupzsIYHUKvqHvUxrCTPS99NKJBeBFB/n
         0XYJ27RvYWBpwH4R8uhDndHCfnSnlAmV2sSI04HXWc5fDvKhgrYvxJnvTYbv7UnY6nSQ
         D7ejusGI+rt8G0O3ljwCvfCU0wUyJ4RhhjCNGVfZPUKlfTyFcfv/qCQ4Xl4z62GTRRO5
         MHrA==
X-Gm-Message-State: AOJu0YyccG9KJpuQzKXEnqba/zP6wFZj9jJ+ijAv3bXbuo1KSslWJ5p2
	oNrEm8Tq9aOa5a8ZyG9X4oUZDX7ApYVYbH1t7g83vdB5rB3LRazlcpeq
X-Gm-Gg: AeBDieskn+XWKwkeMI8P1n2kNYq3gd5BkjMi1RqxmqxtK2lj07FZbD7JGiU5KccZFrZ
	1RAdQsTluQVNXPxwYo6bV5P++pImcxHv8IMy+XvBfr1zQzpfqCd2216fw0ts6n4pbQ8ISCaFVAA
	5adfWv6tJPZhgHB5mGeK8u3GcpLcMWY6XKIog/19qolFvQKPfRG6GjcfCTKTXFqoALOkr32FPEl
	w7FoHUtqPQYM/sFBD2WJItcZFjBNehR1pJjvxVbYjlGmVHBxSNUR/Odx5PCoNiQ+O/ZKB998U1F
	9oVKpu/z/G2hTqaVKujy6t57z36g2oiV8SuH3mg+rQEfBeXs4+V9MzYSqAZ3uNODIRK2+jTvotJ
	RsbwwEWb6NggJRrbtlVT80jxix98uFTiU2Z29UgwaB+B6Drbp0T0DyTQ5vZY3QExlx23AUArbam
	xFRBZp8JttI/JY
X-Received: by 2002:a05:600c:4753:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-4889976eb60mr298577945e9.13.1775661061818;
        Wed, 08 Apr 2026 08:11:01 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5dc5fefsm29141835e9.7.2026.04.08.08.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:11:01 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:22 -0700
Subject: [PATCH RFC bpf-next v2 17/18] bpftool: Add rhash map documentation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-17-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=1670;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=9CW+u8GuHAO4T7H6bbuAiElswjxMan5R/c8DMjzH+Kc=;
 b=7IcueRZPiGJYcgVG9Adse0Nj7CYjqog1d0XJ5/UTAwWZGhxqHa6HTYI0muQrmYDW6GU9XP0Kl
 fBK0qQNuO4wCr088CCJy+NPpNIWASNIVLQEd8eL8+PtE2+0FpfOI7s5
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Make bpftool documentation aware of the resizable hash map.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
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

