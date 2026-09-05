Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A12D2487
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645695; cv=none; b=tegzYpJO9alFaNvUdNSWAAmHOg+Y7dzMobi/w2DYvqTlXiDIRhQlex6uJf9RbxbBcGVvb88xug0ZCk/LjprxoGLbb4qgeGk1k8KUHNTfoaTrnkPtGJzSVX5F4VlPJq+g4uh/ZWdOlTE5fwC3Od89DUDDmW9+0KpS+1RSKZuuHwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645695; c=relaxed/simple;
	bh=tBV5UGL47tPha9R1YZP9lYTBgBE/8GYyQsRzcCSfHyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rO3MAX3bPFZAShG+tk4fYb4Fw53Q8dXw3DT9go3ga+98zA+ksNCtWHAtwbbSNd1YZRkdALHJRVjkSSWEFQ278NSgl0DjR/1dQJvDlQ92tz5N10To3AgQslYW7MkVA/aYZSzSyxQ8zMp0ASpNEiULj/Mt/+3Ry2JHqBzeU69VHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xav8Uw5p; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xav8Uw5p"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6aa9606ddadso1716562eaf.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645693; x=1789250493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhfve7DSFBV41cbcxRKWxVEu2g3A9iQc/b0ZDts2N2I=;
        b=Xav8Uw5p/gUg9d/JaMAVmxRI+ZYjBv4EWHJlMq+Z5K1WbZik4S0vlCG4weEQtVm3ay
         p4gX4+uXSsdNmVrG5bN4+PmflpM9oKrwXtBmUwEfCePjWZZf6mGIPLE02vYgHrpoQY8i
         kioQ7aTTzeOJNAFvxtaaMxG3DofzeOlo99Fhr7uP/nbF+87ptm5hkd6rGZfEKuijdCZE
         r9nYQOg/tRR9tD+/JqDMkJu3YE+LqJSEQmbYpqrKmYyHPelAJrlC1Ig0lv5NqK20krdv
         +UlR1xGjAhuPK4nHJ7X71dnSomucxgp8+TpbZzQ10anNfAlGlgeZctkL1E/utV0kSzDo
         3eVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645693; x=1789250493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xhfve7DSFBV41cbcxRKWxVEu2g3A9iQc/b0ZDts2N2I=;
        b=FkU74i0BGcwkVQaIFkmZWLd+J9ZacTcmEUk1rf3tXU+gCa1Y5WJVKI+OFPrjKvg8DN
         Go7/OD3aBMD0F5+jG6cCNtR0xQii1DuaX7MSGl9mPkiZdPP942Jz+EKdZjgqyyFM0Lpi
         s4vZMywE1DNa5Fede2PbbSAlNJLlbLarnuYZvwHmrb85iRrbgvt1f4xldq3Xs+3J4MIA
         lfazJdd6n/Av8Z6pwm2Jtc6b74vaoLxXWUGEwx5veYQT6QwR2v+M8hP+a4HsUBGnf3Eg
         +CsVKZAx2iOtbH5Y4bGYKdMctAO14jKdFngUKIwRZZW6cnrzBSoSyZizWgB8JbULeixm
         FOyQ==
X-Gm-Message-State: AFuF++lO8BSCVCXQ3dqAkiDb4y3nILVa3a0YItMDUn1eS2E7syMgppp6
	mnBljJkXp1tmI72J65cCLK1YsSeQ0iYTbVpVinAcpDIFRpPDu+u2gguPa+EJTA==
X-Gm-Gg: AYBFou2C8mKF2FUdFvYlY74NFPXgt9crQUVVr6BlVYYkIqPp7H/pEBxXRHKgqodCdVq
	3q7eilVz6MakHbD31x+Z5f/lYIP2BaGD316ARM3v20qbWdrQ/EeLi4Gmy28gUNm/f3mPXQxlu3n
	mrPq/HJR3fKossN23JU/MBX1QkaAtskSqXf1EQBiMZCdBEwHeQhYwBmHknOrPanz5TKCOfAvLVn
	bZXlZ/iJN0OpoHTVlOghvCec6R4oAbUsHjyLvlD4q5LBlxK8MgZn3su2Us8E89Bo6GbsY83j+Ge
	6ehTUogHZYlpLTdTCrvFmeDJBXVRBprdBYirOr0JfiXMYriKkM2dodRWnNROqgbZDQrIYUj+l1D
	U5g7BWsuB2DShnnJmYkZKumz9avbimXnSVtXviyI9yLVIEiv7L7Tky7e63Clt8iZYJKUh+byC/S
	7iew9PKfM6iIaksZBOJCQ6jscoyGtNamjSyDPEe8NiDFM5kqQcgD4=
X-Received: by 2002:a05:6820:99a:b0:6b1:3cb7:f535 with SMTP id 006d021491bc7-6b6f757c0a4mr10094594eaf.0.1788645692883;
        Sat, 05 Sep 2026 15:01:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b7691588f4sm6326256eaf.13.2026.09.05.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:32 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 09/22] bpf: Set OBJ_RELEASE when generating kfunc argument types
Date: Sat,  5 Sep 2026 15:01:04 -0700
Message-ID: <20260905220117.922028-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_kfunc_args() ORs OBJ_RELEASE into arg_type on every verification
of every argument of every call, from a comparison against
meta->release_regno. Neither side of that comparison depends on the
call site. bpf_fetch_kfunc_arg_meta() sets release_regno to BPF_REG_1
when the kfunc is KF_RELEASE and leaves it zero otherwise, and regno
is derived from the argument index, so the test is true exactly for
argument 0 of a KF_RELEASE kfunc.

Set the flag in get_kfunc_arg_type() instead, where the rest
of the classification is built, and drop the comparison. The release
handling in check_func_proto() is helper-only, so an OBJ_RELEASE in a
generated kfunc prototype does not feed back into meta->release_regno.

meta->release_regno itself stays: it is still what tells the referenced
PTR_TO_BTF_ID check and release_reg() which register to act on.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7416f1e16aa9..7662293ac7d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12214,6 +12214,13 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	if (is_kfunc_arg_nullable(meta->btf, &args[arg]))
 		arg_type |= PTR_MAYBE_NULL;
 
+	/*
+	 * Only the first argument of a KF_RELEASE kfunc releases anything, and
+	 * bpf_fetch_kfunc_arg_meta() only ever records BPF_REG_1 for it.
+	 */
+	if (is_kfunc_release(meta) && arg == 0)
+		arg_type |= OBJ_RELEASE;
+
 	return arg_type;
 }
 
@@ -12896,8 +12903,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 		}
 
-		if (regno == meta->release_regno)
-			arg_type |= OBJ_RELEASE;
 		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
 		if (ret < 0)
 			return ret;
-- 
2.52.0

