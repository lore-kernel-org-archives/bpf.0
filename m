Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B64E3783
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621708; cv=none; b=RmOkOXReH9zs7KUg5ys7VJhvSPUrAJjli00nH7WA3NVhWrQuS7fUByqmpUuv+UUpFzzsKwLZ3JVERpC6KpD+dPa5mxTB0WXcUHlhnQWur2z5OuqDiGT1pxH+bEMbzblTaTQv+Uaqh+1rajtd2ooNRtiqnMVCzavfgfnS2DJ3T+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621708; c=relaxed/simple;
	bh=cm9Hkdl3WFkDJnA1AsTgeTscfG8x5kzG5lh/+WKqjVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3jFoYMwpnyZxtqVZyjydfXhg5T6OiuAszxrVTKezdqmFk7jiE7msKvEuqN5aMjBJ7Sz+zaI375sezPlI+3ghdApIqPtzqCrGwqMJyB/Ws9hg2Dxh/PBJZLSUN3TbI+GsfeedduP4xk8dQAXZvI1a8R50rdTv0k2vTTgN37wHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adDxuRa8; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adDxuRa8"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59d4aa96ef2so46260e0c.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783621703; x=1784226503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yNB4FibH3WaX2Q0O//EnQ4OgaudAbxCSfAgXrsx/kaU=;
        b=adDxuRa8B56V2HwpnOCiMtjiwrg1Tk6qA8UI97Vv5GQicV2Z7YHAEd6I/BcBeeBjlD
         9ddesQY2dHBsdtdXMS4DJygYKWerNd6/iZFgiegJ6QxE+CZO6QPmE1L4W6BCC/QurSKp
         RdaZ7WpG0+1tvBOmz6zSKTaauYTTQGsx1EuIPzxNG/QPcYe94qLPIwuk+Ep/cVmShkgF
         vQ14slevBWDUKQouOFPHSFsRnzObiB96zhVy/rOEOwVDdVURuqoGdo1WJi2G2dya2PkZ
         8Cxu8LDy5x2jExML8IhlN9/FHuRn8H1NEUm4tqu+iJtvBTzCq3FtRpgmglY5AdtZ5JdS
         bZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621703; x=1784226503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yNB4FibH3WaX2Q0O//EnQ4OgaudAbxCSfAgXrsx/kaU=;
        b=hooBwnPfg1pTCGM4te9SebKL/vDMsnVJuyji3FIQXy9W5/6KTSF/ArfSxZVab+q8Nm
         BlrE7AZi/ixIRnK+zdW/nasck7JOTNXpIxnpo+aXW0JI5Oyk7RftETfgch6Rfd4VQ7Fd
         Aba+UnjaO9Dfq0A50/eobTaBrFGvsLD9kjbOJcekyXY7xagYIzQrkXxktGzEQxpJmqu8
         jVs0MiwzDEZy1b1Drz1jJpCw80le2Fzn3MPCgSAWalFp6jdBPX03wYhXP7LXXOBp7kRg
         fvpxY7iDE7GNQue264bU4TQhl229hxe/ZS1qjZZ9swS+6IKjbBnl8fMuklP3vBu1xxb6
         ZD9g==
X-Forwarded-Encrypted: i=1; AHgh+RosBuWruTzeCXOn8jg20xnv6KIA2vKxe8QaJvJGcjoajs1sbtHnqEznjFZ365r7LdJa670=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPALbAMJrfY1geh+WmZVuLLfUdKaIUwKiiqJJLfXGU2Sc8X+2d
	pQttwT7DC9gOBL4NRxuLsRN9MJfj+hLAuKe3x9TFY6B0yJ7J/CiQgyAX
X-Gm-Gg: AfdE7ck6mjgHVNrShyUDvvtAduKSwEnEtp4P0HunuX72jHLhotBruGQqokR+HpzbjxA
	bHY7F1xEststEP2zQ3ldyzcJLabFnnN85tGJ4scvCa5CtIrptlIpWgjxqINUPbVzmlNvj6+VATF
	JxKhNON5QxZ31zGad03o5yROCwPlFZe6aUDIAgAYWOsDdWgD5XxVf91RU5EVWG7M5cy37vUQQNA
	P5QaOjTyBySYU+AY+vygbnhD6hggPmpcQ6PZ8teYlAVlNB1hNFrynnuV8CGE2Qd7vjn4fMlrAY8
	IrHN7BW3D1uhb18v/7ClIIO3BTcMLzTPsbf80byuGhvY3StvGgxgTzzynq5fxB9phplOnL4zfRA
	rEOEnRZ2wuIjKUiMZPU/FhNJv+9K/h3rMdFHVB/YSEBKlHPjtrhd3VSNI73MgLkIbV7lrjTwBCr
	ELZi2liQATrt/FxmMWJ7c=
X-Received: by 2002:a05:6102:50a1:b0:738:1ef6:51b9 with SMTP id ada2fe7eead31-744dfd068demr5800740137.5.1783621702549;
        Thu, 09 Jul 2026 11:28:22 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed258bb75sm3437743241.1.2026.07.09.11.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:28:22 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for bpf_cpumask_populate()
Date: Thu,  9 Jul 2026 14:27:59 -0400
Message-Id: <20260709182800.2037938-2-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709182800.2037938-1-main.kalliope@gmail.com>
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cpumask_populate() writes to its destination with bitmap_copy(), but
the destination is typed as struct cpumask *. That allows the verifier to
accept borrowed cpumask pointers returned by read-only kfuncs, such as
scx_bpf_get_online_cpumask(), as a writable destination.

Make the destination a struct bpf_cpumask * so populate follows the same
ownership rule as the other mutating cpumask kfuncs. Query kfuncs continue
to accept const struct cpumask * inputs.

Fixes: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 kernel/bpf/cpumask.c                     | 6 +++---
 tools/sched_ext/include/scx/compat.bpf.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index b8c805b4b06a..1336a4efa755 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -449,12 +449,12 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
  * @src__sz: Length of the BPF memory region in bytes.
  *
  * Return:
- * * 0 if the struct cpumask * instance was populated successfully.
+ * * 0 if the struct bpf_cpumask * instance was populated successfully.
  * * -EACCES if the memory region is too small to populate the cpumask.
  * * -EINVAL if the memory region is not aligned to the size of a long
  *   and the architecture does not support efficient unaligned accesses.
  */
-__bpf_kfunc int bpf_cpumask_populate(struct cpumask *cpumask, void *src, size_t src__sz)
+__bpf_kfunc int bpf_cpumask_populate(struct bpf_cpumask *cpumask, void *src, size_t src__sz)
 {
 	unsigned long source = (unsigned long)src;
 
@@ -467,7 +467,7 @@ __bpf_kfunc int bpf_cpumask_populate(struct cpumask *cpumask, void *src, size_t
 		!IS_ALIGNED(source, sizeof(long)))
 		return -EINVAL;
 
-	bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
+	bitmap_copy(cpumask_bits(&cpumask->cpumask), src, nr_cpu_ids);
 
 	return 0;
 }
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 87f15f296234..3f74d522f7e7 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -84,7 +84,7 @@ bool scx_bpf_dispatch_vtime_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, st
  *
  * Compat macro will be dropped on v6.19 release.
  */
-int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym __weak;
+int bpf_cpumask_populate(struct bpf_cpumask *dst, void *src, size_t src__sz) __ksym __weak;
 
 #define __COMPAT_bpf_cpumask_populate(cpumask, src, size__sz)		\
 	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
-- 
2.34.1

