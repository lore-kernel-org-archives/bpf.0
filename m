Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E98403EB1
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990479; cv=none; b=WijkGBIYTaaBcwQZ4TB6a7K2epXKxAF4ZkEJ3Sa9h69b+QQ4LygrtDUH8p5wEn8nvpTQDEpD+RbmiC4sAPGm8Ya3UQb+kC6GqkLdpqQleq2YeCW/H4HUFo2J+DaFaeFWDqooI4P+S6pp8K5JDhtzTZXn/7LfpZpmfvUAmSuShgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990479; c=relaxed/simple;
	bh=MGnJYZ/GvqucQQodRvkdGWuIE46isfMrvhQisy0B14Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GClBr99naD4buF27Irc01DI8N4NS/DCNEJjNNodtY8ZSyuAz3S1i2eGZo1f2zzc95IDBQR+CbAcNZKJiqQ16CHfMFytxTkXTNc6/yvfsWeDFVm0C6II6iT5m7CeIwawMfVN4wIFKeUf8rGAKwEqDkm8SADTXAZbnvG8r3AcYYLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pw8dAina; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pw8dAina"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48d146705b4so138248225e9.3
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779990471; x=1780595271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9IEJRWhGXUd5wfptWkX+Y5DkYi/zOG+ZFCPXPI3eAM=;
        b=pw8dAina8jpWdDWt2A0F/NsnTEGEwnRfbAIDYsjZ7pgoiYz9WtbTm3bd2tqIn4TBE2
         boFSiIRNXr3FSCifa0aAnhQq01STufxboOqYXqA6LNyHIVlC5Ehvkc2bNbgFVt7oYiLF
         51fI71k6NWgpbuZJ64x/SjRY8W0l7BE0LxNj7sl50cYXRXGHDaQZZJvwqPHIEZYGlCp2
         30+P18zvVyK/WFEbktkgjcOcp5rZ/7cUj42xIoOmwbMWt/w8ptme8Mvh7PK7ewEWXUEo
         ure3VuryeqDdvl3cjHe1i64Z1CD0/idkv0sCzgr5XENET2c24NeY38JmLAbAf1qtdFtS
         kRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990471; x=1780595271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l9IEJRWhGXUd5wfptWkX+Y5DkYi/zOG+ZFCPXPI3eAM=;
        b=k8GUpRZnJNxlDFSVm8sWV0MERNFU/zKGxxv3z+6R+RewkAmrPEt6V1fV6OVuIrIe75
         LqHABg7OligMHPXiEQhTHKUk2+oBL5qPPo5BdoTm1cECZ7oCQljPlGYPYDxp/YW0qytY
         HxQlUD4+cfE7SWlHM06MmDXnsaCTSAXmyoPNp9EY8ju0T5BBTBdxRI/gzLbJ29t/G267
         DADCJtlxGIPMJGn1CCEEHZnYzWC9Pcs/LA6qYvAk3C7NhkrMe70b03w+0HLWebcnSXBY
         PMHid1RrqUdJn6tCa9590zKX/kdhTbU21f33cSwpVwoDbM896vyJMiWI//nf8T4scNzV
         mgmw==
X-Gm-Message-State: AOJu0YyDgvbBOwAbjOndKrYXm3+OgAxERw4SYUqdPd7FLvtravcqg6jX
	5QhWMneoAunv3r04rqrVm6BX4uPVa6JavoR3PDxq9ygTIQHHLA4eSSoO
X-Gm-Gg: Acq92OGlwPc3a8OD5WiWgf8r5aTL866m8DIHrBvk4/wlkj4+nPpOQBuQHZ+1uWLdXrB
	fjNJSLAnrELXIQxe0Wrrz01zEwFsLCtiAnyZ4xQ+H+aPgZcMwMzNVhpLtrkZWBGADl5rkLYe7hj
	MSaTVvP9Zu72iU1PicCQPGbbiolduv89EVZJY5BvEl2xw9Kaz3mIe6lY0mhuoILLyPbc/BKOICk
	NFd7m/FSqolbhrfqEfc00ltV4R4Z0Id9GnwIe0+K1esflJ4wduFZndJJ3LK72Whjr8wYF7NzJ2p
	0MjcMnOxPBwpLJ7QF9p0uFV5X62V03pPaO3m+ZnC4sAspd7YH12hfWPmt8C/qk554qpABN1RnBT
	PK33HOZfOq55Od+uSbYvjZ1RkMBzwWSun33NbqHPG6n/V2c6oTGYLfteoVILxPXGb03xINhfmC+
	jwW6qivuMy9b4f/5CX3EmsgAz6
X-Received: by 2002:a05:600c:4e0c:b0:489:1a63:509c with SMTP id 5b1f17b1804b1-490422608cemr495536835e9.0.1779990471083;
        Thu, 28 May 2026 10:47:51 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092654befsm54062955e9.6.2026.05.28.10.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:47:50 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 28 May 2026 10:47:21 -0700
Subject: [PATCH bpf-next v5 10/11] bpftool: Add rhash map documentation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rhash-v5-10-7205191b6c57@meta.com>
References: <20260528-rhash-v5-0-7205191b6c57@meta.com>
In-Reply-To: <20260528-rhash-v5-0-7205191b6c57@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779990452; l=1728;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=LPUl325KXGW0z58tRRgqUDpIjVZq/nr1dAQYcVgI3V8=;
 b=+BZcpaJvO3ZKQe2oNoVXZQcuxKwtcS41AYl88fWtWNTpdWU4ZKA3KvTgFzktRQISVOTsTl0wz
 qkgE0T2hePSDbpqlp2iUlzBZlwiCrGNHyXvEC6Yc/HIyIDttlOlNTMq
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

