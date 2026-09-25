Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9811DA0E1
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790316590; cv=none; b=JLJQS/zkAVHbRJwm1wCJUcPojjpvr4fzekb0plCZb8nTaMUe5XwAHZtwLOG3bKApC2P9Jib6ryxF7iUV9fepozX9F/vCDVMjhf+t+h2CYo9ngjsEQyRZr8jIhtBjzS1raEjBqESwdy+bERiJkg6m1vp5c2DezldFehDjD5bDwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790316590; c=relaxed/simple;
	bh=QGD6VWVhnW5s6DyBpRYmvWUP7OUnHWe8wYcchFOW/Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VA1NhG1Ey4I/2MK4ihsL69KBVERIhK5cVXSyTklfjYxyKSS9aMexxAt/hJKXqZAyR8idArek8p4jg7Qla08fVh6ojUmHfqFMde1U/oKxFe5O3lZOvf/AkpfKexYyR2z6TCh5gqD0XSsYf4knVYj46of2kHAJMqN5f01USyxc/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1sZssWo; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1sZssWo"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-485850cf4deso254812f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790316587; x=1790921387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dGlHww5KB3I1t9chq+gbYINQ5QN6RnZUKXdTU4XjwBc=;
        b=O1sZssWoho4vp2ZPGdKeO3QEv1t9599umDdmaKWt7Nv6YejyTauuNy1VptCQKBcjx6
         6aHq8KgL3nxWpl14KMMofbg//ukDbnkoFlZdBMjNedi63B5SMxbmrt66AkjAydCKjolT
         LMs7qx6g4tpN7VYPY2+bUWs0Gg8thyDhPybXXin/mxfAyU/39mJVctQHl2DJkjwTRnLu
         aYkqN0NNqrJpcgDREVF7qpl/kl8VNZOgY5MA4Nb5W99PHLz1SveVSfsDryHLp9x4mR9J
         LIYWxAhdy29omOCJNGUolyWkgbdS7K28ygvgpFlHGkREwiMMb5P1jImZ6tUp6zJQ6KB5
         Ksjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790316587; x=1790921387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dGlHww5KB3I1t9chq+gbYINQ5QN6RnZUKXdTU4XjwBc=;
        b=bbyIUD4zgCvYX2JPtaY9JLSaEDKJYJ4geAddYuAC9oNhJLQmu9bVvOFozSkKi5pqqB
         mWko4tes8uHX9ns1PpLZ1713MA9bOmHp7fVgs5WLY4OQNhJCXq6hZ6hudgv0L10hIQdp
         wIsWKWSRUKBM7+1fS7xfdErD8OWG8b/GdJpzX97nvq+U6MMktk6PmhKq3S9EfTgVhS/r
         vgsIHO8GsB/iGEerggPopO0b67C/HUC89zWzGA2z+wLdETaUgVjL1u82PqebZ97wIu4Z
         TiRNe98Jvm0G2XuFG471qO14uRkPsk08j42Egxc2t1mmiBExJsGKP9dUF0Vp/xiCyLza
         cRng==
X-Gm-Message-State: AFuF++kkVJUlt6c5zkArocfayWfdwYSlREHcjJG6SOQbAxJoh1086pxm
	zXvLYhYrqQSGtpdbfQD+6qWh4ReF7iiVmFzoeI04PUqgwJIPwIXD4+RPdAK8g+NRqX0=
X-Gm-Gg: AYBFou0wowz4HQeiqzxxuS9RFrCg60+5I6Skobp0ysnNlSUD7qtw2RNb+Brb5myYyRm
	GUhy868URBH8HkZ8SrnSFeILEPWaf7yQQEkQhQdEic/s43HzHS+V1Zl3AiRzQz2eIkl6QJatcVO
	YSLeCfZSdqjTewlCFCFsZnT+nZBUzuGo0q8QCuKOZV1KTJ56hGsiKHGjUpHb5s7OAW0+7UDucJV
	tLU61BtZOw4dtJeLOppIDtJ6nMrxJPYrR1od6h3ZB3tb/lTSAPgqmUIifX9xQusgIpGaoT294mt
	lir3f/70m8XtEto+KKD8SZIqct1wXVfrUnSxXxWzP5hbmXKrvYwl9ojkyRgNTHYQc/iK6la5DnC
	S7N2uni03cac5A26txtvp8Ih4M3xliPgyZFf3i49WA3ouqbBwnJLV8N4IFes8hdu2ieGFkKh+S0
	ABliMbN8IkIEBfF9PCfE2WwmhXPnhdy5W1wg2DZQTGtdqjEg2llAtQbbCds9DIuVxrdKc5+cUtU
	e9SPg8CMDhl5iuyj+1HP9g07CO3bv/Ur/z/kePhaDbUtYiFlOd89d/HVeROINMDF0ynenvizUI9
	a4Tia/HcU8VQJIoeJH5/HTaYkvAv60pnhGk3oA==
X-Received: by 2002:a05:600c:1f83:b0:49d:99:1d98 with SMTP id 5b1f17b1804b1-49fe7b62aa7mr71691505e9.9.1790316586857;
        Thu, 24 Sep 2026 23:09:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef60da94sm28811915e9.4.2026.09.24.23.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:09:46 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: Check callx operand before requiring JIT support
Date: Fri, 25 Sep 2026 08:09:44 +0200
Message-ID: <20260925060945.1993547-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=memxor@gmail.com; h=from:subject; bh=uKhNwEPfu71T9ULLlbBFLsdPluUrmkZ/LhRnS3V2c0A=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWsb/5JfIa9Djmmm5DZMk9dSOxcguslpfYz/Xb09Oocu8 JncXNnbUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlc+cnIsIJboyXy6t0/kUfP bEyq9zzcUXNggm/pircOkR37/6480MPI8Dx5p4WAoqXQ1mNGSxd6sZ5W8nd5GjS5uu7ro6AwqX3 JzAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

check_func_callx() requires a JIT with callx support before it looks at
the register operand. On an architecture whose JIT doesn't support callx,
or when the JIT is disabled, every callx is thus rejected with "JIT
doesn't support callx" or "JIT is required to use callx", including one
whose operand is invalid. The "invalid call insn1" test_verifier test
expects "R0 !read_ok" for callx of an uninitialized register and fails
on s390x:

  #79/u invalid call insn1 FAIL
  Unexpected error message!
          EXP: R0 !read_ok
          RES: JIT doesn't support callx

Validate the operand first and require the JIT only for a callx that is
otherwise valid. An invalid callx is then rejected with the same message
on every architecture. This fixes various errors when running selftests
on JITs where callx is unsupported for now.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c495dc9070de..76172c1e55d5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11211,10 +11211,6 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	const char *reason;
 	int err, subprog;

-	err = require_callx_jit(env);
-	if (err)
-		return err;
-
 	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
 	if (err)
 		return err;
@@ -11240,6 +11236,11 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err)
 		return err;

+	/* the callx is valid, but only a JIT can execute it */
+	err = require_callx_jit(env);
+	if (err)
+		return err;
+
 	/* PTR_TO_FUNC is a pointer to a static subprog */
 	subprog = reg->subprogno;
 	err = btf_check_subprog_call(env, subprog, caller->regs);
--
2.53.0

