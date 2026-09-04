Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E13F5BE4
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510821; cv=none; b=LXiM5R05eknMIispP7Ag7ikAifrXgt3TIgJx1jsJqNR4llh8oQTAv/bw5v9yDGEcM5RdeNeQ+szJXGp3conepd4oQA01bqP7nWtJiFOTnULt8E66ZQpC3JT3I9m8px6sZEvbwNgyrW7Gt20ormVpOy/Qpn4+oAKi5soe+n8xVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510821; c=relaxed/simple;
	bh=pA5zJRS43A2iUQhZFECl7Xvka1aAkjloEFb6W7FElAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHIAI1nYW2ZII3odk0qErp/pha5dRFGoUF/9KoP2WcyvnVJmgabYxHyViZQREOJf54M9YAnPMYWhAovPJKZfWvL5HacqKI1ksRTOeWS7PYRs21ZfNvnz4mVy3jsx3Z0o4V6dHzr7safvpms+cjLqcGje6vugvTyuRs92KDAniAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6bGu0Ra; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6bGu0Ra"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39b35105ba4so93687a91.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788510819; x=1789115619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OGptn61LHKtLuYEURKdgZbIn3ulAgNTAvxKj/ymLVYE=;
        b=a6bGu0RaBMd9Jtsmc+7+LjOhrhPnsw2dZ9oqrg7/kz8yDo/Hh5H4PDJD68Wka8LWje
         VLOWChxHRa5WtYPS9uKMoSL1z+1fn28Ui9luDwDu35zHhoBFCz3lb1VhOQoepTN1ilb1
         z2nyllpTqXfbiBDRKjFiwaqNjMJjO9494jq6gRJGOsKVyRqCpbnfNtGaBqpEsymCDk2j
         LjstHcKjwMJVWTJkVmxnM0chh73gOvgUgSPWG2MkfHvtkjvyJWOeo7D+rs6MJKv6WELP
         70BM9QOBLtgtmRpJ/jwo4LOWuFx2Kt0PnMQMlBceREWyn39QX6u11Ey2TSafhNF2xKk4
         Rzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510819; x=1789115619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OGptn61LHKtLuYEURKdgZbIn3ulAgNTAvxKj/ymLVYE=;
        b=RMnXDKx17KaQdIovmEyQiM0gHG2eY2P27N/kzEZGlLUlAsR4q7NMgresdfyWCaEQFS
         8RxfT+Q6+H7x/TQ9wpYw6o++u1bBNBGQ6gE+vVfz8iGltBZitS8SSK1I0wDIzm7J5/Jg
         rB2nWL1XFIXwxlZVjAUmbw2H+hd0vFfoBshPD5IXE1BpdyKBZTTaLfrEf5PQgdDl2qR+
         6Wetk2CCui+BK8Ul9niJDCw3KRsdW+Da/+pgOB4emS/j/k4Ujfyi6BvaBzToc3+y26Ny
         XkjnXeKP9+QTH2kZr/OHeSKAR7ldkExqObLLkOu+61hQovqFdDdd6ADAvSWh1TJ9aYCY
         CDCQ==
X-Gm-Message-State: AFuF++kIAj19z8OZ/B9I256s8NYUNyogMYrvH1o18We+r5Fq0kEXHaBH
	kB0oINPq31kzJZKAl3AQky3qrCaA068Y3CcyHfKTrY2cuYQbFjWMEq57z+FoLA==
X-Gm-Gg: AYBFou07gDTZW8irBUWBwKJfHaVnNwYcYb9UtFqOdJ5T/4m8RsfeJSzabAvR9BhZu/g
	8mASrThFqCvjeFpOL6cUFsi3pn+J4p/yvXcObB43VtHWSNX9eZNmGVCTdkNjMmU8JE040KK67kq
	9Fp3dSYj6YS+032kXUVNz05Ymg4353JGAkfKmYHIVXk1rTqT5TEStL33pR09nw3gBMYcBBqbEKf
	3hxLga3+GCHG7lrnZqNJ7kWyb5GS3I+9sSVZQi6sJuEb8TQWyuuXLiuqdQglSmrGeqtBpLuEzXB
	KUaVgJb7JqCbp7V4YBkDfkxw8FtLaOnwDtbWljPNGdg2m8ijEOcHR2luXMoKYkSM00UxstLN4Lp
	Bul2N3b8ShxMaEYb/0bn5zYS5OcM40PHBH+QuY81u+9vO6DFxRw92eaHp/IL43x0QSy+fWkU6GC
	dXmSAhk5mndri/w11IUa6+qE2Ba9wIRxP9f+w4AvbJXTKNycvtYZv/ofUaMOfY/20GYtuy13YNR
	CRLYNdFb3OGGL0dCDYCOMwnca75pOeW
X-Received: by 2002:a17:90b:5866:b0:398:e73e:5a13 with SMTP id 98e67ed59e1d1-39b2613272amr6777411a91.9.1788510819404;
        Fri, 04 Sep 2026 01:33:39 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm9628057a91.1.2026.09.04.01.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:33:39 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 1/8] bpf: don't infer non-NULL from a pointer with an unbounded offset
Date: Fri,  4 Sep 2026 01:33:18 -0700
Message-ID: <20260904083325.2083493-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reg_not_null() decides that a register holds a non-NULL value by
looking at its type alone. For pointer types that allow arithmetic the
type only guarantees a non-NULL base, in case of an unbound offset
the runtime offset value might still add up to NULL.
Consider the followng program:

  r6 = bpf_map_lookup_elem(map, &0);  /* present */
  if (r6 == 0) return 0;
  r7 = bpf_map_lookup_elem(map, &1);  /* absent, NULL at runtime */
  r8 = r7;
  r8 -= r6;     /* pointer - pointer: unknown scalar, -r6 */
  r8 <<= 1;
  r8 >>= 1;     /* any non-negative offset is accepted by */
                /* check_reg_sane_offset_ptr() */
  r6 += r8;     /* verifier: map value;    runtime: zero  */
  if (r7 != r6) return 0;
  *(u8 *)(r7 + 0);  /* r7 is inferred non-NULL, both are zero */

At runtime both registers are zero, the comparison is true and the
load faults with NULL pointer dereference.

Require the offset to be within +-BPF_MAX_VAR_OFF in reg_not_null().

Fixes: cac616db39c2 ("bpf: Verifier track null pointer branch_taken with JNE and JEQ")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e64035683795..e53619e2210e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -352,6 +352,13 @@ static bool reg_not_null(struct bpf_verifier_env *env, const struct bpf_reg_stat
 	if (type_may_be_null(type))
 		return false;
 
+	/*
+	 * The types below guarantee a non-NULL base, an unbounded offset can
+	 * still wrap base + offset to zero.
+	 */
+	if (reg_smin(reg) <= -BPF_MAX_VAR_OFF || reg_smax(reg) >= BPF_MAX_VAR_OFF)
+		return false;
+
 	type = base_type(type);
 	return type == PTR_TO_SOCKET ||
 		type == PTR_TO_TCP_SOCK ||
-- 
2.55.0

