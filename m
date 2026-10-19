Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67F4F4043
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416134; cv=none; b=cQR3Oj9Vj7X4zfnv8/5Tepg9g3ofwn4VT/WRk6yVWnytJaCbN3mxBZR6OU0oCPV8CbljvctLKzc6B3EFzpzlRLv+GBYocDgjnMvcklZqtP9uHw1BvIkAA9HOBPOq39o5N2NLoWumv1z9sy2x1zUvRdogEFDLuEWJr4ZM0qy+UjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416134; c=relaxed/simple;
	bh=WMXyLowLeYKVG8ksT+LTyPI0sS0+EaXWTiW0Dy6ed8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1MvYLjJ6IyYX4hqhls3SjtJIjbUUURMwFpJWWm7PigfPQoASROjPHvOErDyWUBa5DRMeNwRScEFrhhw59fRjAIkK6XwftsoCPDGYJUF5EeMuQ+n5F08u8hplI5Cbmqi0NXjjgzM+eEA56kKFNcuwk+dd5TP4kCspY8veQBiQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uvkoo8iz; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uvkoo8iz"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-82890dea412so868232a34.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416131; x=1793020931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFxP4gbbIRIm6tZ44rYJ9lmzvmU+NVSqmf5eJuI4s2Q=;
        b=Uvkoo8izPBCuBarfhDzUytFJHmtVaEiykl8WAvC9Styrs29ERPQeFIFdSKocjG4nIl
         hlO03uJFNjkfAMrygvZRsfkqWau83AcQy4x75VT7UIG/396B/jO+lxS1VcyRgttjorXJ
         9MMUD+nvIMVWjyRl5NbZYx/z7mFfpl4NAkq7FB5HpVZPOa6xFLEZqE14M3SnNDdzRp60
         M26G/Fbxw7wfiIDPv43AUGHNpGX4RFR8MDzRZsdmCir8BveqW+CH+Qg+XzkThDMJGWjm
         LwrOQ+ZFl5GSzP+Ml6Xm3V8LsQxBFae9MdiD3AhdtyDWvTlYoOzdqq/1VKdX3ISHJfoI
         e4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416131; x=1793020931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rFxP4gbbIRIm6tZ44rYJ9lmzvmU+NVSqmf5eJuI4s2Q=;
        b=LuCN0tzASFk60PZHmZObR0XJWmou7uZ8FRCzANRAyLO2Pi9MDxiGIxzGv0SHTCCg8a
         gNpFfq5r/D7VW0uElCFUfIQpzDS7BDrd/yJFuF85IOFMpPEGf2cFlW/iRjZpERlvveQn
         5UJNzgKrUZswdol7YXgziKo2JhzeYoFvTXHjxZbhw0mJWPCmOE3x/Mekiab07rL9O0XD
         gpFOVtYLIPGDoTYJg1hB52TOPUPvdREwkn0bHPIqWj8tHjUAsxgYtwRWBUZpWizMiLBu
         REYSWstQX9dcnUkzQzU6uEH0BaYOYEcF7SqmW/DjTmGpQ3xoHzPoJti3LQvjE9oN7zxU
         WPqw==
X-Gm-Message-State: AFq9FYLN9bl5h4pTOsLnQkVgmb1rSn+QMQ4ihzVQL/Y7mO+Nnv2iN0z4
	DXcGs2nmlWVyQ60+gw4ZXzLX4OK5kHQpFB0EA4EazNhXm5bSliXrsxSkT40M1QZNcdI=
X-Gm-Gg: AYBFou2qwxLkt6Lr55E4uRt9I6AgVC0UgVhiC3GMy4DwXOaERSlnXIO6x2z8yOU+Itt
	p0cHdUX4ZMYreqPoyDWm2zYzDt94WCrz9RmH0dVORR/vRerMQJ4WKu/ob0hN0ENeXS8SbyJ0H85
	aAXOG9HPUtjsOC3se7ZjqUHJUcfHsIVwOMc24/7KclyKy1RU2hvmo1/gbA8jERkgmKnk/9/7nwc
	gyyuKufYEjf6K+WQVK2NbWnShQ9dfqdRfmVq77O7tr1yJp/UE1Ga/nQ7or6o7KKVYUWHqHk+gJ/
	KKW7Sweu8gih6o0yju6M8pLru7zAXKlCxP1P46E0HhpkksjaN3cCTa0ibiNqrxCouUgEjHG9Lqq
	d9WH7oyrf7ITOANUYm3h9N3qKgPTZbIeSFWVedAY8bIGZ9lXgnnga+yIJ4rLrizAg2Mno6EQvLy
	Lmx57sVNDeG2q5Tr3VrTa8uJZHCJEL6A9SKT8fH0N4Psdgq/BwmuxaqdkRSCagBe1SLBVNS5xoS
	apqecwbb05wER4VuwJj93xg5n8sYWfGi+kllB49M4mmt+2OTo/mA3oRkajakCvsu3yDgi+/DV7r
	fY9+mg==
X-Received: by 2002:a05:6808:1917:b0:53a:e153:e8e6 with SMTP id 5614622812f47-53cd3bd3ff0mr5675359b6e.59.1792416131053;
        Mon, 19 Oct 2026 06:22:11 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388288ad5bsm7501197b6e.2.2026.10.19.06.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:09 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 01/16] bpf: Check exclusive maps once the program digest is final
Date: Mon, 19 Oct 2026 15:21:43 +0200
Message-ID: <20261019132203.3034698-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6708; h=from:subject; bh=WMXyLowLeYKVG8ksT+LTyPI0sS0+EaXWTiW0Dy6ed8g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxJGDjxnNZ//nWbH/2WrD6ZGOrh9i9/4rEfvHekOzS+Yt +/X5HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjI/xeMDO/StASbZmVzec/eJTOxXs dp4kzRBgbullP8+3jK1U4GyjIyPHwubzN/Kt+LwyvkNv5/91tLxOf0/iV8nDEtN8/lLLhfxAoA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

An exclusive map is bound to the digest of its program, which the
verifier compared against prog->digest in check_map_prog_compatibility()
as the map was added to the program. For a map an insn refers to that
happens in check_and_resolve_insns(), after the digest is computed at
the top of that function. For a map bound through a continuous fd_array
it happens in process_fd_array(), which runs earlier, so for an unsigned
program the comparison saw a zeroed digest and the load failed with
-EACCES, "program's hash doesn't match map's excl_prog_hash", for the
very program the map is exclusive to.

Computing the digest earlier would not do: it has to cover the insns as
the kernel verifies and runs them, after the CO-RE relocations it
applies, or a loader could submit the insns of the exclusive program
together with relocations that change them and pass the check with a
different program. Leave the digest where it is and move the comparison
instead: check every used map against the digest at the end of
check_and_resolve_insns(), whether an insn referred to it or the array
bound it.

The claims a program makes on its maps move behind the check as well:
bpf_map_claim(), which records the program as the user of the map for
resolve_func_ptrs(), and the takeover of an insn array by
bpf_insn_array_init(). Both ran as the map was added, so a program that
is not the owner of an exclusive map could have flipped the owner's
single-user state to shared, which a failed load does not undo, or held
the owner's insn array while it was being verified. Now they run once
every map has passed the check, and a rejected program leaves the maps
as it found them. Nothing consults a claim before resolve_func_ptrs()
and the fixup passes, which run later.

The early digest of a signed program goes with the early comparison.
Commit b707068e0ed9 ("bpf: Verify signed loader metadata at load time")
computed it only so that the maps of a signed loader passed the check in
process_fd_array(); the signature itself is verified over the submitted
insns and the frozen maps by bpf_prog_verify_signature(), which does not
read the digest. The maps of a signed program are now checked against
the digest of the final insns like everyone else's, which covers the
relocations the kernel applies and the signature does not; a loader
program carries none.

Fixes: baefdbdf6812 ("bpf: Implement exclusive map creation")
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 85 ++++++++++++++++++++++++++++++-------------
 1 file changed, 59 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d13868846823..ca5301fe3f66 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20796,12 +20796,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 
-	if (map->excl_prog_sha &&
-	    memcmp(map->excl_prog_sha, prog->digest, SHA256_DIGEST_SIZE)) {
-		verbose(env, "program's hash doesn't match map's excl_prog_hash\n");
-		return -EACCES;
-	}
-
 	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
 	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
 		if (is_tracing_prog_type(prog_type)) {
@@ -20899,6 +20893,61 @@ static int bpf_map_claim(struct bpf_verifier_env *env, struct bpf_map *map)
 	}
 }
 
+/*
+ * An exclusive map is bound to the digest of its program. The digest covers
+ * the insns as they are verified, after the CO-RE relocations the kernel
+ * applies, so it exists only once check_and_resolve_insns() has computed it,
+ * and the maps are checked against it there, whether an insn referred to
+ * them or a continuous fd_array bound them before.
+ */
+static int check_excl_maps(struct bpf_verifier_env *env)
+{
+	int i;
+
+	for (i = 0; i < env->used_map_cnt; i++) {
+		struct bpf_map *map = env->used_maps[i];
+
+		if (map->excl_prog_sha &&
+		    memcmp(map->excl_prog_sha, env->prog->digest, SHA256_DIGEST_SIZE)) {
+			verbose(env, "program's hash doesn't match map's excl_prog_hash\n");
+			return -EACCES;
+		}
+	}
+	return 0;
+}
+
+/*
+ * The program may use every map it referred to, see check_excl_maps(). Only now
+ * does it leave a trace on them: it claims each as its user, see
+ * bpf_map_claim(), and takes over its insn arrays. A program rejected before
+ * this point, one that is not the owner of an exclusive map in particular,
+ * leaves the maps as it found them. Nothing consults a claim before
+ * resolve_func_ptrs() and the fixup passes, which run later.
+ */
+static int claim_used_maps(struct bpf_verifier_env *env)
+{
+	int i, err;
+
+	for (i = 0; i < env->used_map_cnt; i++) {
+		struct bpf_map *map = env->used_maps[i];
+
+		err = bpf_map_claim(env, map);
+		if (err)
+			return err;
+
+		if (map->map_type != BPF_MAP_TYPE_INSN_ARRAY)
+			continue;
+		err = bpf_insn_array_init(map, env->prog);
+		if (err) {
+			verbose(env, "Failed to properly initialize insn array\n");
+			return err;
+		}
+		env->insn_array_maps[env->insn_array_map_cnt++] = map;
+		env->prog->jit_required = true;
+	}
+	return 0;
+}
+
 static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 {
 	int i, err;
@@ -20936,20 +20985,6 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 
 	env->used_maps[env->used_map_cnt++] = map;
 
-	err = bpf_map_claim(env, map);
-	if (err)
-		return err;
-
-	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
-		err = bpf_insn_array_init(map, env->prog);
-		if (err) {
-			verbose(env, "Failed to properly initialize insn array\n");
-			return err;
-		}
-		env->insn_array_maps[env->insn_array_map_cnt++] = map;
-		env->prog->jit_required = true;
-	}
-
 	return env->used_map_cnt - 1;
 }
 
@@ -21353,7 +21388,10 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 	 * 'struct bpf_map *' into a register instead of user map_fd.
 	 * These pointers will be used later by verifier to validate map access.
 	 */
-	return 0;
+	err = check_excl_maps(env);
+	if (err)
+		return err;
+	return claim_used_maps(env);
 }
 
 /* that many pointers to functions are recognized in the maps of a program at most */
@@ -23619,11 +23657,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		ret = -EINVAL;
 		goto err_prep;
 	}
-	if (env->signature) {
-		ret = bpf_prog_calc_tag(env->prog);
-		if (ret < 0)
-			goto err_prep;
-	}
 
 	ret = process_fd_array(env, attr, uattr);
 	if (ret)
-- 
2.53.0-Meta

