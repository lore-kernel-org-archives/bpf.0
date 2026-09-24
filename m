Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFCB3EB80E
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269617; cv=none; b=F51GVbzbMLH7ro7cqYCz3AGomVGueII92TU3LD5MVFuZsApi1OGqW+XZzBgSCNHeUZOQTeYnvLXCyuQDsoAQhjTeO8Qe4IPBVAny+XSTDj/9n2tqeJhZYHToGAsTQ0vB4jh6bAZHfsacXJOjLApfdmheic3/v6TSDt+npWZjkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269617; c=relaxed/simple;
	bh=+j8tjysSebyQiEKsSaaHGJKB861gN0qzOSXYqdtBPi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbX85jMoERzbh1bAheK5NVSNgHYGYs0eSjfsdB3YRUupIFuJG9lM6gFb3/y+6HrCbBjuFxwQkisbyVCP7QCiZIMnfVqECou2RyXwSxw7lA0S52RpBUWhNpXUISSEUY9ORezNs935kU3f2QLsk+int5wwuHHWEEJmLNGbdxHe39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=plsM9Ftf; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plsM9Ftf"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so332695e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269614; x=1790874414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EoiU00rV+S0xqnX0Qa+m79O1j8hVwxZkiSNaqTY6Z/A=;
        b=plsM9FtfK+61wV4CgpDBoZxZ+QwtVl2iwk/uFffZzgYIJLgWqZ1oLgwIud7lq2DTzl
         tFZLTHdFvIvUcFZ5zjqfg6EPK3KGtRY8eGJwCtsCACees4M76/rW2p97mSZ5uMV++8+a
         8rKciG3zp4tNEne8LhMS1u/6OXXkobRhW4UxN1HEWyDEH6H1fLu/6u2/oShP/gXqNt+V
         Jwjh/iOPNoXYKtKuSD7Qj0HwSPPWWu/wXUoRxAh3KTrM8JjO6JuFcESKbQjj8I76Xv7r
         eeKiwvs6Y47hfK8Iq/hc/M1tRGwxVVRkom860uRT8QxmMCGfgCiqZcJ+oHyDBdVrQesu
         h76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269614; x=1790874414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EoiU00rV+S0xqnX0Qa+m79O1j8hVwxZkiSNaqTY6Z/A=;
        b=pDOGraCVPxAbvXAKriUltIPuQz/dDPeyCBdJWeLTIyTZclgMbGZg+MFxkFqW0ReqT3
         rBlrdjbOBdc8dd0TNlmyrPxuyM8me7M3NoMpglnC4MqaLTnC6UXZs+kRRfxTYrcdrLmL
         2yynAK1XtcULh8e5dTagZWwzLoS4g5Dy+IJ6wmEsJtOtHD3AbQbzDcEW7Q1I6gqCYEiI
         HoJ5IvEqOfE6liwaoE5Aljo4Ov/iHT5WLlJy3q8DjQfgOnuuPjnl9AhIfXFMzM44EBEG
         v+vNnuJDJPzV11PigCgaKkmW8qf4E/AXcby0vLBzM6sPmb2nF70Um4eMfIoci2b5oQCp
         NL3Q==
X-Gm-Message-State: AFuF++mIwgytPoqkqtlPWvmC/tg1PSJCa6c4lnZrhA+hF671GhupNRx7
	i2uV55m79lGJrD1FgYlz1YZp1sYsFmWHZimEBxbE8FqbnAOnNOAQz1kyl8lWk3mo
X-Gm-Gg: AYBFou1StK2+wLVjL+yN9fKwNJ1CAS3KAg6YKUkKrBx8i1hCM8wVyDTcHPJRd8UoHb0
	rMy+jcblYguRHKjqj3DCGJI0uxEZN3+zvjhM3Es5xu8CbOo+lAH//ev3aGmhfQofIFRrqX3l3WM
	zyQDCteMS5NQWhDcT4vu07Vw88nKWsW2Nvtp42hYi6xQ3+6iVc+W/7ajgH7HMmQzHcPmyd1BvoU
	pjDtG+NB2dRlSXI3AyowEB7Ions707loRBMQw1nGolVF8Nl9IlE6I4pE8f4es9SghDxO5GZVyCT
	KT5y6L7t3rkqRrnCzRmiORWw3QJfJi+Sz2IcHOa2/APahBCssbwGyJTwfUWDs8qVFlLpVBy7Tn5
	PHqAT11uBKo13ilLR0OUBQB86/rO98Ywx86sctPZsy/T8KnH08kaKnaXgQEPkPyY38U6V0wri0c
	ZOZ70g/1W5iRV77C2hIZSOjN7ySM0n4dFkiFKXIJZHGYZ9SLAqPRiL3zT8bfs2rNjkcRYwhDR1n
	o3CE/TNLsdYb8N8ZY8F6t6lqkb0GGnNgDELfuCfEer51ngJKWQgs1XG1Jz55CvarS0RXb9gVzMU
	8mTgOPqfTbUkchRsKFrh7mhhhE+CNA3cpC2xpg==
X-Received: by 2002:a05:600c:4e08:b0:499:8b13:3a98 with SMTP id 5b1f17b1804b1-49fe66c9f6fmr57468625e9.4.1790269613746;
        Thu, 24 Sep 2026 10:06:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c5c41asm119956405e9.4.2026.09.24.10.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:06:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 3/7] bpf: Drop dead spill diagnostic condition
Date: Thu, 24 Sep 2026 19:06:37 +0200
Message-ID: <20260924170646.2366016-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924170646.2366016-1-memxor@gmail.com>
References: <20260924170646.2366016-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=memxor@gmail.com; h=from:subject; bh=+j8tjysSebyQiEKsSaaHGJKB861gN0qzOSXYqdtBPi4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtrRHFd6MNlOSlLFt/4/enj2gdzblr9/pXc+LeYX67ry tYbRnmxHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIHgFGhhOhartXPV8gP0Ps D1vfbZ6iO60FsbMvB2XIe36MXH5/qi0jw6Ke7/vkIvSupKkd+Hg7V3Vtl29s663159je3XQ9t1D qEiMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

diag_record_mod() suppresses lineage-preserving register writes when the
diagnostic snapshot is unchanged. This is reachable for ALU operations that
do not change the represented type or bounds, avoiding a redundant history
event while retaining the register's earlier lineage.

The condition appears to extend this suppression to spill events, but
diag_mod_keeps_lineage() only accepts register writes. The spill producer also
supplies a stack target and an explicit origin, so a spill can never satisfy
the conjunction.

Restrict the condition to writes to reflect the filter's actual contract and
avoid suggesting that it applies to spills.

Link: https://lore.kernel.org/bpf/48e6f021b89562f68850fe21ef8c78719819b04cf9c4e4f50bc791937d37ace8@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 5ecfa86ed49f..496d24064532 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1567,8 +1567,7 @@ static void diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 	} else if (diag_mod_insn_origin(env, insn_idx, &target, &event.mod.origin)) {
 		event.mod.origin_valid = true;
 	}
-	if (old_reg && new_reg &&
-	    (reason == BPF_DIAG_MOD_WRITE || reason == BPF_DIAG_MOD_SPILL) &&
+	if (old_reg && new_reg && reason == BPF_DIAG_MOD_WRITE &&
 	    !memcmp(&event.mod.old, &event.mod.new, sizeof(event.mod.old)) &&
 	    !event.mod.origin_valid &&
 	    diag_mod_keeps_lineage(env, &event))
-- 
2.53.0

