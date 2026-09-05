Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435519D065
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566784; cv=none; b=pHH8VN4EzWaG7hSLd5Fm5pBD12dyU8YcWWpVFxR/NHGkVJY5aXPjDf/eyky0dVshmhXzILqb6Kz0DZZG5GwtUvTCmjF/AJhBRrDtpfGSdtuc6Gfg0YGQRQr/T2BekhNSFgVCg6iaiNKaiq+pczUIcvM4VeNRfhaU6pDhT8Sgnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566784; c=relaxed/simple;
	bh=TQvFAiNDbRLhqegQkZTRL4zpMX09eaPmxrPNiD8NWYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alRamFFlHCXxjaYvKwKfCkYh/Ciuy8wuIzNvQ/ETNYiaRzmH581/LRgmDEhtpl6Gt+Movzpay5L6Upoq8ztdjGrdVSDO/YEqcDWXWRxYY8sX0gBYi8xqT1aSbC2d+573/O9CPnO5ccuf4hKaK8EslaVTY0gtEjYMJOgwG46VO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnmUXOYM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnmUXOYM"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso1541490a91.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566782; x=1789171582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KcGrMWRMLiZJXtH2wbK/f7li1yYaS97lm+E4E0lTIT4=;
        b=TnmUXOYMS5tcvh4WrOgg/PAlRDZIZ5WfWfWUqInMXtkzPUMmz7WnhMRyH0pQFAACGd
         +LzaE65QWQuYKzRMaU2S6N6RmoH6lCvqaI/H4ycpqgXRhbXI1tgecsQSgKdfhamgfHY2
         z6xb1G/MwouqHt5jQq88vJu41oCMEb4Kw36lPysHQzWLHv9Lsn0c0ANNGwyz7hbq9bM9
         0hhOBtQ5xcS9RlvUjv40VOPETVjQ534ThvAulop+pjBBgnb5blWG9ybChBFORYE39RyG
         JNpMB2I/CUVp+jBiroMdJ2sgcy0LJk80eOLCK5zfOm2b8wOcaRUpVzQYnQ7bh/O89O5z
         uP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566782; x=1789171582;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KcGrMWRMLiZJXtH2wbK/f7li1yYaS97lm+E4E0lTIT4=;
        b=tEEJRY+pvw6X0DGTjXm435eax+CA9g3VlsR+t5nUtkqXKyIBpk3iGykMmRMai1yiiN
         B3OXFJIhH63DxdfjNow8WnvlbZpGkV1L0hs2scvKy2tMqKQDtTUPK5EEvhVQ3txUz3OO
         gQG2Ops0cLzji0a8iMv0PaDcC2JtA64/32sTxt9BEAC9p94EjSF6t1yWKHATV/710T1H
         cTtGATmQQSjBN8s2RfX7UyyygSAT3ZElxe2/tepBmXbnEAqF26iK7HGm6c3u055oQ2ho
         fO8ZGCsrTY8niQbZfkb5WlY0VnZhNpIbQVXfwvhF/ERUqn+K5AcRTOJrD8a6KuQBEIXV
         T4Og==
X-Gm-Message-State: AFuF++lg9ImijifY8ysovFgh+PcTBrt+eqAQkJnx0o9+d9Iqjpae+6bQ
	tV969Q6As6YegYL3O5Le9Vhd25aRyfPxkFiHBk2ZcBvp7T3C0EQt6lE5B4cfGTZvW+Q=
X-Gm-Gg: AYBFou13UC8BtwTiivtYL6U/KgQEmPvoMaUT5DCQp0H9RREUv8lweqlKeB7tCq8DMxW
	nCfifcPcSoBi5DmVc7dfOI6Rh3zcj4p5at52Cet9OZTdLTk4bH0fJLXFBoJa55cWVq8wpn8wbE+
	ybmt/YCOo2swKOmHpIkjbZ/rA//uzM8UAIzYd5G+4Z/ZSRUkqtQHe4eGUzisVwTxOqkWTuwc+tm
	+rmFoJF8LsHIGf3yadT0KeBUupjOv/4jUuOk7R70e7TemDyvagL7grprLRAAuf2MPMSV251yz1b
	m1kJEOILXHn0Wn4sM2CmYdxsBcciK8xTa5sqT9mNi2QjvPwEI0FLsOMgoJlTNe7tLN6XgBBePdi
	2+6UZVXClhUYxWLikucZw4ynGysLeyEl3twYby96EBcjCtPt3eA/ZrmfWb9FDoH+QS96ug0Mevh
	IKtHp6hRToD0cKEui6rUo1lqeJrz0el2jeZc3x+bz6I5oa2fWwFb66mcXbX42x/rNDsHxGw0aZq
	PRaA8dEeKuRKsQP92usOCa9b7qohRDdcYyiLwJ8DcGCwQ==
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id 98e67ed59e1d1-39b2624f0f4mr13530914a91.23.1788566782597;
        Fri, 04 Sep 2026 17:06:22 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:4f3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm42277eec.8.2026.09.04.17.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:06:21 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 05/10] bpf: mark a NULL kfunc argument precise
Date: Fri,  4 Sep 2026 17:05:56 -0700
Message-ID: <20260904-register-is-null-precise-fixes-v1-5-0f5a360ff15d@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

check_kfunc_arg() allows bpf_register_is_null() for nullable arguments
w/o marking the underlying scalar register precise. Hence a checkpoint
created on such a path would prune against arbitrary scalar value.

Fixes: 3bda08b63670 ("bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b758f2822754..2b3d08097806 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12716,8 +12716,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (reg_is_referenced(env, reg))
 			update_ref_obj(&meta->ref_obj, reg);
 
-		if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))
+		if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type)) {
+			ret = mark_arg_precision(env, argno);
+			if (ret)
+				return ret;
 			continue;
+		}
 
 		if (is_kfunc_arg_map(btf, &args[i])) {
 			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];

-- 
2.55.0
