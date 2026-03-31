Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A436E46F
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978050; cv=none; b=B4OjkNZzz9ejx8UlxaKbDafjJINE8naDZZJ03wUOHwHPfM87VDNcZZy37aIeGFyFw4hX2PvXapH62yvTcWLIhDVyoFinaFX2NnV9DpN5IQdDskvn86bJOTlgTya4Lu+vlZffXY76ZZHDVvGDeCtdKiqKZkZ1NR+UtkUu1gpSCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978050; c=relaxed/simple;
	bh=i9nRUXNZGydWAWCvSrFkwwvUZ7DNsXJiXi/GI0DxGgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdFSrJOTCABIYU/2LAgSk1rShyOcfX4A2su/Nd4hVGh/yjjYy+sJrQ+8jUPisroLJ1dYfpkJ8uwuneI/rm52B9p+dOUqA7EG+hk7vM7DBR9iU9PuiUzX9c8fsBOfZ+SPQB+DLcbskHLJ9gidICaqjcoDOYfi66SGSs2Y5b0NvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEh7KRT2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEh7KRT2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b24ddb2428so16050755ad.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774978048; x=1775582848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l9dq3lOfypgRTQt2LhXnddPOHGWLzEuWUCEkxb5+ceU=;
        b=KEh7KRT2yFoanzLgHqBcMawLKjTULYgWIDUCCLGlM/PYXqmwyzfgk6stS+d26yjyQr
         N1dY7dQ+KNETVCeTbTTA4MQkXgUcRz++2RfMVfn6l7kyCEB5gEIE8MejPj4HP+FDbUJn
         z2lOZBRJNdyZ/73v37emss+jp/5TFBTTtV92MB9DSezYYJ1VAaXL9Tzpc2JB0llKjsl6
         aKk7oXkscn0dMq5aFnk+VUlshT4wJ/RZdfKfubRY84b5S39qmkEO9NnEMlh1OUYGKV6h
         MMW2IYsuDfiIWrZfB4CdgpsEeMAfziFSWaWNlDbdvdIfz7pTRQCv0VriXm3pvajWdCUl
         7teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774978048; x=1775582848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9dq3lOfypgRTQt2LhXnddPOHGWLzEuWUCEkxb5+ceU=;
        b=HDNXYgGI5t5TT7n89teMyaN//IIQAhYHg4Roi3u7oFyOTLJbkNg0MAsWGyufpEcIVN
         GDBl2r7yIezyL6ftzEerXxpJhvhgE5YdoVE+/MnndO4MqKYZSH1Zj6qz7jCozJXf3Kfj
         mB0wsEhNBYL85UFIRhg+Z5eKiQaCz9Vanh6TtuswZjT2eCfP0Lq3CXRd+dsH9GbjfvIV
         jRJ6Gc2yWVkM7NrzyC9OaOoeWkD/hsq5ooGEXplDGytzqm6sXNY1qCdRHkCVbngEHhUv
         oL9dzH2I5KMlQdTzdpljLM+AcgEvi1w0Y0ZO2APYaUBgUAF6X5JrbmjkZofnE8tIpAIS
         3Aug==
X-Forwarded-Encrypted: i=1; AJvYcCWUub/BAVJH+k7/J4vYx1rmSw75OQ2ewovRjn/6ljKF040IHBtag4GFyK8ha0RE+Iwuxik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQgvhtp/riTB7pvW+vEaeYN2Qshzms2qV08ZEcIrbFKsEFVo1x
	Zx+slasZSsPtVFp6zx5JOmBdB7lozwMVoQ4rKBIcUfyVIYgaZSY0ssTO
X-Gm-Gg: ATEYQzzifRUpoe9BqNq1WB3wO59RtrAZ554+zKOBkB8TKoXmbzAnFHSTtH1K2jXylsj
	nVKebHXZPWs+qMsCCZkXqI+dVjaMJ3YlgPLNhmaqL6mYTaiJ7CwkZQ+FQXEu8IOusxjHHQTC6Le
	X2zF9fyBlX3Vfyu7JI8ZxXgi1h0AWZuHIgQYqC65cR8KBRFWJySyQwdKmBCF/+LkGT7RHwKnlb5
	3l+FQ/Vkaq10GEiprJI+msf+15zh+PN4bmOQ2laMVdet1LhN3nCDYmwnOp4yTW1Nh9OsHEb38Dm
	Q9fb9sUV4b0+XTyDS3rnHwToxJmcawrV04anlpohFgOhowMaSHlw+2bYBNQLs5Iw7Uos+nXtxBX
	ZGzdK1gea8EC6YAxdiFGoakjyZcJMms03ug+ifFgDEyNBm6gPoGZnfUVAm4k+u4ZfTJH6xqG+Cp
	fLWxFcXMGq3oVl9natZ3XXTXofwVqEViwShmQ=
X-Received: by 2002:a17:903:38d0:b0:2b0:70c8:ccea with SMTP id d9443c01a7336-2b269ad3395mr639335ad.13.1774978048349;
        Tue, 31 Mar 2026 10:27:28 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427663acsm118360655ad.46.2026.03.31.10.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:27:27 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH] bpf: reject direct access to nullable PTR_TO_BUF pointers
Date: Wed,  1 Apr 2026 01:27:19 +0800
Message-ID: <20260331172720.29938-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_mem_access() matches PTR_TO_BUF via base_type() which strips
PTR_MAYBE_NULL, allowing direct dereference without a null check.

Map iterator ctx->key and ctx->value are PTR_TO_BUF | PTR_MAYBE_NULL.
On stop callbacks these are NULL, causing a kernel NULL dereference.

Add a type_may_be_null() guard to the PTR_TO_BUF branch, matching the
existing PTR_TO_BTF_ID pattern.

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:bpf_prog_5f0e2be830ac3243_null_deref_iter+0x10/0x25
  Call Trace:
   bpf_iter_run_prog+0x1c2/0x2e0
   __bpf_hash_map_seq_show+0x120/0x180
   bpf_seq_read+0x29c/0x530
   vfs_read+0x179/0x930
   ksys_read+0xef/0x1c0
   do_syscall_64+0xe0/0x1290
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  Kernel panic - not syncing: Fatal exception

Fixes: 20b2aff4bc15 ("bpf: Introduce MEM_RDONLY flag")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 937c9adf1b3d..17850836943b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7905,7 +7905,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (reg->type == CONST_PTR_TO_MAP) {
 		err = check_ptr_to_map_access(env, regs, regno, off, size, t,
 					      value_regno);
-	} else if (base_type(reg->type) == PTR_TO_BUF) {
+	} else if (base_type(reg->type) == PTR_TO_BUF &&
+		   !type_may_be_null(reg->type)) {
 		bool rdonly_mem = type_is_rdonly_mem(reg->type);
 		u32 *max_access;
 
-- 
2.43.0

