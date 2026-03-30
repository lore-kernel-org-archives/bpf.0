Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9F3E4C9C
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909707; cv=none; b=YHjFK0k13/aQU77ePhkG/fOMwjKhzc+MSbhqbzJguk/peVr/XEcsYU1uXCHbECZxQ/9p/Pq3sSZcSFuXCdceuSnSxJUE4KcnfUf6gsGi0xLWq6ahk+eUc2++/JCwND+dUyha7UVMbQJ+3VD4jnEvCd2I76HMtHi/2kfMu7thwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909707; c=relaxed/simple;
	bh=xRFzeXb8OcThR7/nUbRNk1bpe2n2BQWkLMUCWVdk3/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3JgU7VTEbii7LgoaxK4kG6n7/RgGfgoQAY3CctRAdrpUmXPnjC9HpdF6b92Q2naOFRS96OdGRToUrCKucVp6NgRRlojuVAQdHGaWSMK4WhhelrSvsb8Wjuj4I9KOSc418JVBRKs2bHbsUx0VDcyHHQwptkLDY2p2ImV0PgUei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flydKomy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flydKomy"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b9d3ebed5so3605423f8f.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909697; x=1775514497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlTvjl0jnMyKfBpiVdyA5AX+1qeYZqK9Ubxjau7FmRQ=;
        b=flydKomyIKbZxrTPxacyUGWvO1vBZ/DTcvtgCIDJ1LeykbN95CwuwY24ck5gJrX1Ak
         uoYL/na89Bj9VEtUn0I7HQyDhkkTolzMJ/NXAG07bbE31N0xxvVXPR5eSjYKsRF4Ob+A
         0fib0LF5fKR1bhg+QV/dZO2JQsvgz3WQEKWYWsAAoKF6Gx1gP4s3JNYniuWNx8YCF21j
         Mir+Rgg935aY+0YIeXbcS9Cg3bWWev2rW5OSN1aywlxjwFEaAjQiXwu60bUKlWpXfSJr
         zMPF0q4NIZZKnxWz4w9sKkU0k8IsniH9T6rGeGJArqXKpTRq/G6jK63gNdlezHxHQkQ4
         I0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909697; x=1775514497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GlTvjl0jnMyKfBpiVdyA5AX+1qeYZqK9Ubxjau7FmRQ=;
        b=Uyw4ImWdfYZh4/kzRNVFq/Q9pIPu1KHTYEWPtUiWKmhkHeVhhQvH1aKYTJ5zvAFzK2
         jPG6ddY3NhY67TjOYTWDOAq8rm8MfhX8+YPIcppo0bfQS7OpcwgQSqd4a5jKA1xRHcn9
         y+ymko9a/OPZmUiqfHfVX62/POOJmQmgvaSC8gxmxd7iZVwH/zejzj+1PbuYOIQjzvdD
         JyvV09TKPOA7uHrrbP6smzurtBlpjoHTJhjMOm2SFQpXv4ReXM1iYRQDTV0w0tToqatT
         nczwjUAD/f3QYvlk3Q5Os5yqCS0Em+7ZTecfSVPoyxM3+IVaRvHDXpx+j1JRB0jYp8eO
         6tPg==
X-Gm-Message-State: AOJu0YyOl12MQ3cvoah6U1VJvnyKsjhRVncfRUxDMJsB9I4xmoHHBtUq
	v/o/p/4HMlni0EAx2XSDiq5VZKNTxqWB2/mby1/0L6cj/W6Z0TLgpKtU
X-Gm-Gg: ATEYQzywnuY6WU7/5yp74J18Hz2tUJv1rntJmZ+GpBj6D+FUXR1h84ZsBncuBo6NQTz
	okD0IKrS3V4YTKzeZeHOk+ppKEArUG2alDobigyT197/kb0gpB6dCCS6q+EQZzCCp8BajsN1Kq7
	iRiF7gfPJQM4qjZDRWXw1BLlF72MmFYdnBh2PZF7Hbads873UiZyJRyura+f9ckxH6P6gybLgtm
	COGNHPX5WMA9AYTEx36IuxofUG4Zt1o30Z7v/A1Ka/PAxSxIWPbNr1Aw+fJAfswXsiXoiInFs6B
	TLP5B5j/kVHrBealQY7j7yI+gbfRvXjtBFoDNAPD8acZmitz7OnF9U/bhK/Su59ehmkZNVMDd8b
	CJZjyKvkXBVe+Jtjv5AmUharXpQ0o9X/ScztD/J60zd63eB5hHqSuqm1tWNSVOdN8VeLj1Ihnij
	El5zSBnPYhWm98DzvsxfnwGilA
X-Received: by 2002:a5d:5f85:0:b0:43b:4ec7:f90b with SMTP id ffacd0b85a97d-43b9ea9b2cbmr23631349f8f.27.1774909697412;
        Mon, 30 Mar 2026 15:28:17 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f87esm21109094f8f.22.2026.03.30.15.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:28:17 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 30 Mar 2026 15:27:57 -0700
Subject: [PATCH bpf-next v2 2/2] bpf: Migrate dynptr file to kmalloc_nolock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-kmalloc_special-v2-2-c90403f92ff0@meta.com>
References: <20260330-kmalloc_special-v2-0-c90403f92ff0@meta.com>
In-Reply-To: <20260330-kmalloc_special-v2-0-c90403f92ff0@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774909692; l=1260;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=dis0Qq1Yzn9VxVcYVHcHfEAxMzIU10KId9Ri0KaElM4=;
 b=8xSpR5pxtPXEewoaH2X+wWvNEP/aLoMrtWgFLhfdti+mw/cEAciYv7KHiAt3rURMdjQlvbSM0
 ZGYcRPotvnJCf3ipru6cPGIy04Rd8M9/6rawq6v1+XYvpQJKrY5Xfol
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Replace bpf_mem_alloc/bpf_mem_free with kmalloc_nolock/kfree_nolock for
bpf_dynptr_file_impl, continuing the migration away from bpf_mem_alloc
now that kmalloc can be used from NMI context.

freader_cleanup() runs before kfree_nolock() while the dynptr still
holds exclusive access, so plain kfree_nolock() is safe — no concurrent
readers can access the object.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4c3011ef631f..7bb8b1339e2f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4435,7 +4435,7 @@ static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep,
 		return -EINVAL;
 	}
 
-	state = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_dynptr_file_impl));
+	state = kmalloc_nolock(sizeof(*state), 0, NUMA_NO_NODE);
 	if (!state) {
 		bpf_dynptr_set_null(ptr);
 		return -ENOMEM;
@@ -4467,7 +4467,7 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 		return 0;
 
 	freader_cleanup(&df->freader);
-	bpf_mem_free(&bpf_global_ma, df);
+	kfree_nolock(df);
 	bpf_dynptr_set_null(ptr);
 	return 0;
 }

-- 
2.52.0

