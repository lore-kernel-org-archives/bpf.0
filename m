Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E4347C6
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380253; cv=none; b=Mqbw4v2481882uaxyGLJVfdFu7nm4vQwtsXa4FL+U2U5E0eDAUrSUiMfVMk90W83G/n+mpPKJaT9fRH9Ll/hRgD+ehnhRXp03vU+iPRJSqjTct6WJ6lhhKzSyLJk0wme+2FZHwoH4d8ekHf+zhGC14Q7OF1EniTllWLMDh78bag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380253; c=relaxed/simple;
	bh=mdzm7Zkoi49BnoASY8pI27qt4uEUNHVwF0Sm2VD9FwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl+8jqYv2qOrWDsbTz4P/u1Olra0tSxSS/v3hORsJlJcPUV7hmOBCcbg/Ymu/S1Sgerlkb5pxlrLoRg3A8wMUTXtk0Y8/9bPButETRq+IfI09quNaLbTR0rd8zPG8wMvSEtB3Zbuwu0Poxcf/WaoysYut9Xg9AhSE/dOjlu9TFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8j2oR3T; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8j2oR3T"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4f3f1adebb0so741543b6e.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380250; x=1792985050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3yBMLXPGZdZcdw09sBqHdpuwnUdHEe8lob+82mIOoMA=;
        b=q8j2oR3T9MKGPgLB22yKE4ZlorM7zpTh9rwr8s9ZG8+J1f6iDuIpMXCltAMtR2q32d
         oaSe6ISzgZ8a4NqR2+1oJ3Lxvac8vXjXmipxsSxo0Par8iX2XyJmF8VxWGsnR8q9roVU
         F/Biq16VmtOYyBWjSLxupSOoFglTg5bdMfEbsfqRd7qaPPsbQxYKFMLkP8XovWXRiPnO
         boCO8lA5wFqI0iM+dzDGwTgHIZ+rMcfMID/T5O3CwRUDq2c+ZTyYz8z4RvlxGuC/O/+A
         GwEkGTIBhJO/4lyy3sfHs2/XpvqAZ5HlazXGhhm5f5uHHczgVKCpNdMfQe18gHomyw2l
         qmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380250; x=1792985050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3yBMLXPGZdZcdw09sBqHdpuwnUdHEe8lob+82mIOoMA=;
        b=qwKugnZBCRXG2krkxGKFQBSRpf6LiZ0Ph1oIBi6qPlPx1IUWrq1OjuHBStfuZJ79A8
         OVNqjJ/N7elWAqmI+v4lMmg/I6iQx0+pIaufpfjRbf1fun8fHelmY8LHlG3ekmDgEV9T
         G3lSu6qgz6ZkPv7LtpM6N2QcHKeyeVUH6gxyM3w9ZBIsPGbJCRoImKbi73/mKdttqAcM
         qwxa9L/OUGk0X+f3ghuHVmeUgHuX2wXilMNKLWr/l2FwcqnX519EUQ/+4Ig/lPyH1qjX
         mda/oi16WjyIdWeqlHGQ0xrctI4XMxlzbadcOrSSRocO7fgXH+Qq8ATqwJvQTeEfukwK
         eNug==
X-Gm-Message-State: AFq9FYJ2lDCynYD7CYr85uKqn+OlEbLE+NsRBuHrVDN6r4cPX2goNyYO
	XRyfVza1sRu0IW0nofSOwfrEPsLZGjKTXcxTscmxLXMEhTPE7LbQoh0+CUeFmmsk3ls=
X-Gm-Gg: AYBFou3bBOd0XvnPiT74xsOtqM6UcgF2o6pqM90BYVFO2su5QQIGcanJsk1aNbkHuLq
	ENwBcl9T2UllD+Z7t91EaOuA3lhnv12jSnZwD13YujeF2Mbr4ftxdyqJaGkx0EneQ6xlNSJHEi4
	a0zB/Og9CBJhljQ/hKZGJ/WnPd2zQ+SW1RXzbq68emBfB7QeWTVPUtJsEM8aOIshC7LeY417whe
	oJvQ30S+U+FGbRZG91zrFmssUNtv/PiRt0FsGfyld6Mz6BZyxieo4OM2wh1fvBUanNuMXbO6yx1
	Fz2kJ00ZrHzzTU3IyMvzdJOyou+DCcU27ieFA+d6GD+VnVJXnEcWMy/Xw9bgVzsMRxbNcWBIlFo
	n8BHkp+cl45+vuVTvmJVCbnuUgaivKvjrRBWyALWjKKreA2fu6C3j6N5HdQF68Q/Hhmb1KStRKB
	m1vinyEr1n9ahpmQRG0Ov028PMscHDT5eoEg8znPaoAJzlokUEa1JbZ1jCToASgx1r7whfWLbrF
	c9ScfN6BblwT1SrKrH0TkMtqBv6RdAm+03p4GMNeTj0wT7AinmkUGUYAMdgWzbPMVG2xfT6Xx6H
	iKWe3Q==
X-Received: by 2002:a05:6808:e7c3:20b0:53f:3c0e:c74b with SMTP id 5614622812f47-53f3c0ee60fmr2876936b6e.9.1792380250469;
        Sun, 18 Oct 2026 20:24:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-54481784097sm1893121b6e.3.2026.10.18.20.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:24:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 01/16] bpf: Check exclusive maps once the program digest is final
Date: Mon, 19 Oct 2026 05:23:41 +0200
Message-ID: <20261019032401.2302823-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4373; h=from:subject; bh=mdzm7Zkoi49BnoASY8pI27qt4uEUNHVwF0Sm2VD9FwU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqr84HrcyH8neO8h/Y2dR6jT1sQe65T0nqlzt2/pcV8vid xL+9o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOZaMTIMNucIexyv9XvyKApizIL7w screuS05Ir/X7cddfBU7HyCgz/TLJ1nMRPbP33qP/sxiaVQ28FhN0Zuf5cKqnv+tCrfGY2MwA=
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
 kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5958425e9a2a..14dacc5d202f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20775,12 +20775,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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
@@ -20878,6 +20872,29 @@ static int bpf_map_claim(struct bpf_verifier_env *env, struct bpf_map *map)
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
 static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 {
 	int i, err;
@@ -21332,7 +21349,7 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 	 * 'struct bpf_map *' into a register instead of user map_fd.
 	 * These pointers will be used later by verifier to validate map access.
 	 */
-	return 0;
+	return check_excl_maps(env);
 }
 
 /* that many pointers to functions are recognized in the maps of a program at most */
@@ -23564,11 +23581,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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

