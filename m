Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB2356A38
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957775; cv=none; b=YwAS+2Eo6nqqxfm+ZpD9S0m1gFDbnajEHztuLg9RvCbDeM9LHcBPin6JwtQgXaief+Su6hYGs5yLwHuo5M9CFirXHWOXdsyScORTsNsYo0aWjSgvnK5Ncssj7a1jNFdXa/jQGLwXfjniH0rkXAeuoqziRKLrhSbz8iE2Hz0gal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957775; c=relaxed/simple;
	bh=Bf1xmYjqJ8SdwR+CCOQ6uRJG0s5afKXCCxg+zEa4OpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utKO62ePFtFmpm7Qg3/wsxy5E+jei5F+aoSqhDPt/s2uSujkkl0QidmX+qUZj3DW9nMT+xJ447rFy9do4GEb0WTbmHTTL9s8im+hjaAET6Dyc9wguPMUuwlcvcZiav3KIGg3l3D11to9/YGxeUrTryAF5HT9bbYqxR6p9LzNeMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdGBRRmU; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdGBRRmU"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a74765703so65540507b3.3
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776957773; x=1777562573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iC/q/c4ewjnO7jHTKGoswmb6N8BeQvzgkrWVTeoOhpA=;
        b=NdGBRRmUBVjP4SfQ2hi+99hliDAcpWqcSiMFP4nt94j2VKHNporSWaWDnv/QKY2gcI
         2t3gbCUPRHFM+tjJfpwLvrD2VIJR0oIONwV5tOUAUd3n9rgECwrW8/4qwssYVaHqBH4c
         bbAWOAMKWk6aPp7sNaY9cgeXHauSfIXJer2HVbkx6fHN+MeihrOvQ853yCRvWrbFScPe
         lhpjZMaJKmXlZCW5F0vIS60EK3x+Fd2mPE97K1Fvn6rtuQHg25f9Zx/8lXPD85XAjsZz
         9Yy+6DmgCn0/vVlRW1pZ0s5wXembAY9UmtU8Ga/smQThOea/8pmWGr2z7CpaxDtrC2Hq
         VWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957773; x=1777562573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iC/q/c4ewjnO7jHTKGoswmb6N8BeQvzgkrWVTeoOhpA=;
        b=IfoFmbiGxgVS5mmxWRLy0pra83Gf0wZsgA6ZBhHMT9n80+vohgxh/exsGAcv7TwlcV
         BhbowJazUOqz9RJkDmF7d+ZJAmEiIj1S/Ex0wgp/K9VMbBESMwOnmoeKaOcCXpahKsiL
         89PAcUU8bqF6SaBIa6kR+2HBBbGHqfquB2tuLZ7BmUI9ZRGepOikryO7wTpoZwL2LK2B
         V3lEe6LR3yy5O4rJ9E2L1JviHGwxR8NUNe1kULnygYWiELb53DZn/IjlYkBQ2Z27Zmpz
         e1hA3AXVb6QHnqz0kyPBU+kyvY7mJDaDrlf4uuoA7Rrn0vjPqCDJm63QstOlAejyfNHH
         ousw==
X-Forwarded-Encrypted: i=1; AFNElJ/j8A4kNSD0A/Ek+0ttBy7H+QhAmCe9t2s37qXv/oo6wKXoBuT8PLJVwtH7+RDHeHyRbo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kBB7F/fuloKkWNB9Al/pgiezro+HsmLR+8k0ShDu5RqQlOdn
	o/mSxtW4U6aUCUb9jv+ylF+9qLeMLS6t3OHjP8SUuVGKB0NGiavfDJcK
X-Gm-Gg: AeBDieuIGQ9/AQKFr85G3xY4GH010qPzT7vamV+GDpUzWJoc/61SJ5aqSw46vcRJdth
	9Gzs7jGcEMDhD9LzVULjUsAy+SV/+5Mf2D9ZYbMrzPhXn+rQThVfXf3XJ9ospo/iK25dwOeBKNW
	N+ep5wcNTM+Ikt+CJf2/wjMRAEBquR/lqsCI/8G20U3Q9gySFO1Qt+I2IiqfJHhGnG62rjotfyk
	357OgvtDD01vnN9MDMq+rjU9JiJ3oYYvKVM1fqgfuqAxtBfwFDT5F7QrPqROqtwZdu+bf78BuOu
	6zLMgzIkYqqbOcKLlN9Ru4L9b+DW/xk1F/XU43iZLO6EKY06P/cOWJQKIbEhoWUiZwgtuqiM9pD
	rmbbHb+NlZ7WW4Kr1+cIUwhLrab8kx5AEIkSmgkJkfPYf1udMeVBJOfU+Llqe06mZQA+5xp4eit
	ibNUg2Jlz33IujY7QqtYvXQX4dYJdgSVnpuXa9pUXlOjyx6MLd3wB9y3du9uwSyd1jnL1dU4i13
	aXvnG8y9xE=
X-Received: by 2002:a05:690c:e3c8:b0:79e:62cf:8254 with SMTP id 00721157ae682-7b9eceb113cmr286496657b3.8.1776957772853;
        Thu, 23 Apr 2026 08:22:52 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:b41c:424e:7501:d0c7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89b88bsm84293957b3.9.2026.04.23.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:22:52 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	mic@digikod.net,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Implement dtor for struct file BTF ID
Date: Thu, 23 Apr 2026 11:22:38 -0400
Message-ID: <20260423152239.4140627-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423152239.4140627-1-utilityemal77@gmail.com>
References: <20260423152239.4140627-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a destructor for struct file allowing it to be stored in a map
as a referenced kptr.

This dtor is analogous to bpf_put_file, and calls fput to release the
reference.

Acked-by: Song Liu <song@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Changes in v2:
  - None

 kernel/bpf/helpers.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index baa12b24bb64..4739e2bf0f31 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -20,6 +20,7 @@
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
 #include <linux/security.h>
+#include <linux/fs.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
@@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void *p)
 }
 CFI_NOSEAL(bpf_task_release_dtor);
 
+__bpf_kfunc void bpf_file_release_dtor(void *file)
+{
+	fput((struct file *)file);
+}
+
+CFI_NOSEAL(bpf_file_release_dtor);
+
 #ifdef CONFIG_CGROUPS
 /**
  * bpf_cgroup_acquire - Acquire a reference to a cgroup. A cgroup acquired by
@@ -4763,6 +4771,8 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release_dtor)
+BTF_ID(struct, file)
+BTF_ID(func, bpf_file_release_dtor)
 #ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
 BTF_ID(func, bpf_cgroup_release_dtor)
@@ -4874,11 +4884,15 @@ static int __init kfunc_init(void)
 			.btf_id       = generic_dtor_ids[0],
 			.kfunc_btf_id = generic_dtor_ids[1]
 		},
-#ifdef CONFIG_CGROUPS
 		{
 			.btf_id       = generic_dtor_ids[2],
 			.kfunc_btf_id = generic_dtor_ids[3]
 		},
+#ifdef CONFIG_CGROUPS
+		{
+			.btf_id       = generic_dtor_ids[4],
+			.kfunc_btf_id = generic_dtor_ids[5]
+		},
 #endif
 	};
 
-- 
2.53.0

