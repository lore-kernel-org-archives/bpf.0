Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CA3E8C46
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539137; cv=none; b=OeHdqCJyT4PugXTyWhKYbJj+bID414mFUlsOcVkpLMl0Vqtv4HmePhCaApFn3tmCoxfK/K7C0B8WY9lnbMkfgSmuwGW055CZYY9QLOtHcvheZahROLUwsHsdxGHcPRtdQ65ORhfI/ySy0ufhpyqd7aegb/EoDJyHcUApsMysHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539137; c=relaxed/simple;
	bh=CLfvtEL42iEjrJYP0WgUwcGiJAc4ZHrV5jsS2ufZwCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mlR2Ng2QV86NfTuJZLzPMQYpdz56tpgyLgDY0z71YcGApnrrlh9oQ7MCFV8GPD91DayqJON5rMjDaC96HzgJN2YF74+8KxiNxrN04UYhI38NV4RnzhjQpLOpX+4DwKe14GGnGVGqB357LSQ7NxNGZRg4AvTt8JouM6o0bv3Vynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DREt9Zl7; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DREt9Zl7"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d6fbdc8772so23599425ad.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 23:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789539135; x=1790143935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1d3fUbkgkxrFqYfpJwkgf0WNdrED4XAWdTi2Qv+vUKA=;
        b=DREt9Zl7GromrJgmFLfoU1CO8YhF7/NgB8haoCqkiLgZBoIMO3ExAJme18ldtDsduj
         BeuoI4R8yDws5B7p0dWF0WcVbt2tmgHeOuXDa+JUz0OzsKnSe7mtHa/MlU9O2VBvTgf8
         08TJtUNqHhaaaBHN38CDVpJ+BPPNzjeoEeV1NGKy3uMHQCYk0ui3R9Ni6teYTlWCB88E
         8qiCnYdzgHtBudpEHkhfn/5Dxf6lehb17fXFf2w+yeLSzK3rdJsAFgr1an8wWWWdXRfG
         mlGOIFSiAXR1L8qR9Ru1dCpDjqJsL9zmMTa/hQAPQIhE+yVrO7DEM6U29vGGHEny+jex
         fbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539135; x=1790143935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1d3fUbkgkxrFqYfpJwkgf0WNdrED4XAWdTi2Qv+vUKA=;
        b=xC2kwvcfDtZLRt+996J8RegOG4sg5JYeAupeLz0EtNjUUfNj5mzE2HhtENwrJOO3Yy
         +X4DQ9slFx53M/sDhpp5rOzm4J0poueiXn6H9PPmsjfdMt0jA2bf6xIUfEDCNptUTkHj
         tsuZSd0lnYfk0BkRvAiS2RymiVKR/QP0tXRhkA6jECePP2jw8b+NALZsAQa2xgzuD+fv
         kO1tcBMlWc0afF11n/9n3Ohog8yQt6x5g485PM77yCQRMxRRnD8x5TMShTXo8N79E2rV
         p0jFSMHL9/edXJllyEWzHXN0CZqJ2leQOXFzV1QviBzao/rRuDu+Rwsu/9s0U3eCqcVK
         ozLQ==
X-Gm-Message-State: AFuF++mK3VipicYZpCt0+rYnFigzD3BWNoP66heZiWqSmHOeAJVGsq9X
	xOwtqfklDR8xnaku4TgSD5wCCoT4T5cWn1SmPEtPt/3CnFGOmgBm6V4isTc15lBkKIE//ztl82A
	=
X-Gm-Gg: AYBFou054BmrOKd9TZuws5n37+kwO2d/BtEK7VROFXBMaXSvBUQGkhO2LNr8WE2Q0Vp
	oDQ0UwGuLPGQSrS+aY24YNUg9svM/s6C0ayv51BLZJqpfZgZ+ht5KSee4mT5mKaFsrJcx7H034W
	MR9ZYIDOzwdnXZSLsCq4g+OPhPNLL2iteFFHAseG0uM0yeWVsSrbdml7AW7IMdJXp1LjgIuEp54
	9U6AwN9JEznoyvQoIgwrbdr8VQqla/Ra1SVhDGodLOZVEOUpWvUzyr0hQnN0nRPSsc/J0qRTw/4
	lX89kZiMg4jKJ3gzWYaMMS9OBHhrD12AvoPzGxO5fuLwBJjmAqr4EVVHR9PBFkl8xajVdHOxciM
	/uXkcd7g147GHvGanlkwDEMDYKqm8+/j/LlSI4gW540vG642J5NHh63S8df4uUSvBY0b7C4zn/h
	uf8Fd87RE29ms6ffbnK3gH870SRExFvY9+xGVL0Jk6WDpQFZ7DXUXicNsLtpy0UNb3axU=
X-Received: by 2002:a17:902:e80e:b0:2da:eb8f:b4e4 with SMTP id d9443c01a7336-2dd8e007cd1mr27300485ad.7.1789539135275;
        Tue, 15 Sep 2026 23:12:15 -0700 (PDT)
Received: from MS-A2.. ([38.103.200.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f34921sm5749545ad.84.2026.09.15.23.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:12:14 -0700 (PDT)
From: Li Ruijian <li.richking@gmail.com>
To: bpf@vger.kernel.org
Cc: Cursor <cursoragent@cursor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [PATCH] bpf: add missing __printf attribute to bpf_diag_source
Date: Wed, 16 Sep 2026 14:12:01 +0800
Message-ID: <20260916061201.353630-1-li.richking@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds fail on kernel/bpf/diagnostics.o with
-Werror=suggest-attribute=format. bpf_diag_source() passes a
printf-style format string to bpf_diag_vfmt(); mark it __printf(4, 5)
like the other diagnostic helpers.

Signed-off-by: Li Ruijian <li.richking@gmail.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 kernel/bpf/diagnostics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 0abbbe177e31..2421f52eec14 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -794,6 +794,7 @@ static void diag_print_insn_context(struct bpf_verifier_env *env, u32 insn_idx,
 	}
 }
 
+__printf(4, 5)
 static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
 			    const char *fmt, ...)
 {
-- 
2.43.0

