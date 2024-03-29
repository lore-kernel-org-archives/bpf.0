Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626E3BB55
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696151; cv=none; b=P+i/xf8SoF+W9WhypJXoHpvK10DBfGg4EKHtJAjg6sd09NC0uptRXUnXGA0wwD3t7aM0zbCrMsWJMRgnbIZ9YczA3lQwqbeNENAGSXmSvuVZnMVd4ODns2KwrVt+nsrhLB5IlYE+4iKLrVY8gcYXFQj3LB9wYmSciTyvlpKY3PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696151; c=relaxed/simple;
	bh=fU0FfhuCA62Ip8DsbRLe1RkzGYxBaX3PWZYXDpOwXNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qr1O5CNws5MAqjiiYHRqyprAtYsVndriekfv0lxcqZPuFZyGvZTLEE8lTwNc9y3DwbH2poLVn8WwCCXyaWZzGMIc/5KgsfsDxB+MbvC6+0G/T1rsLRaQJRcXebDRzwvIwq67SDkYUPQ5c55jmCSmjhOlUqObOea3eADBKkgRJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=d4x0A7af; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="d4x0A7af"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-415446af364so7519405e9.0
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 00:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711696148; x=1712300948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMvT6pVbEhmONvWtSmDK3OaqXJMmfa7zgekf1pe+F9g=;
        b=d4x0A7afBRVAhKWuS7WstdCPcuL4WUbdq1JdkMJTs2+ocz0PUzQKFX7aayteoO8/Jt
         RYXCvfUsmThjdydHxuJ9tTWY7+7MlEe1H9j/kfFsWYc/AxG2TStn3/b73FLqR8cOekX6
         Q5o7Ue9l0J2L0jeQD40JWzwFvl6PJVQzo/kkPucBv5hWRvJna2EmO1rLsNaaSxom4qK2
         noAn/VPWFbtjCSYUYPiJOT7+TqLPyGKXO5jL7TpF+r7RF8uUWIIszVkxn14Q3jEzpnnH
         Chw7rTks0PB1NmiVcwuqXisZt6NCTCdEwqOeHZ7dT59M6DXBnLNUshuokJ/Adc/kk1IH
         ZeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711696148; x=1712300948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMvT6pVbEhmONvWtSmDK3OaqXJMmfa7zgekf1pe+F9g=;
        b=COIbJtUH103fssYpl+6x7ROOpRn2fw5Rzh6iRXDZgGf7y6+aLfiHO/lV/8c1AfQMa9
         6TsVJrkSG/vpPu9xZ5/D1Tep/QxLHYpaGmJUR20f1wx8icgvc5lkJxoJQ5Ka3xYeKo13
         Dl3SFBaUy8Cg7+K3xitNO8oB12iti0cnVv5ft+UefQQkDbBSe1f1FYlD0Kccxfd3uilv
         93yqjGlZgFHMmU/1ag0TlyJv2aBsLGKgOsb/k+Iwe9YmeIfAs1YLq5m7PnEnLs+dk3Ky
         hj7L1f/hCM7uJZB7lhsdMzQ8RNq//Fe4zowRLNhl2tsKZpQE49x9XyqrSisl9iHwhrlx
         ZhvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvRNHeQI+r3th2RAiHR6JXyMMzYj3blmusteHyNgqKDwbDTozVaKlFRYxXDWCbRqsVaQ3wNYHoMvhGw2/Z7g2VJsWI
X-Gm-Message-State: AOJu0YzBYLnn0zBnfE0Zwi0nGXIbo+D2aSAI32TTd6MRmawdOD3v9rFe
	jeFU9s7VHVd2W2skdVt9AAVgoSDoXbByVAkqkbMu1V2vwE3gEMycLaRPsqxhJdE=
X-Google-Smtp-Source: AGHT+IHj+4tP8YsKnvL6hDt8n0NJtlYb7uEfuwxfo3vIOCbj3G+nAWHfn8M6loLsd+0oNYx5exsvLA==
X-Received: by 2002:a05:600c:4746:b0:414:8941:e831 with SMTP id w6-20020a05600c474600b004148941e831mr3897946wmo.15.1711696148105;
        Fri, 29 Mar 2024 00:09:08 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b004146a1bf590sm7602892wmb.32.2024.03.29.00.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:09:07 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v2 bpf-next] bpf: fix possible file descriptor leaks in verifier
Date: Fri, 29 Mar 2024 07:11:06 +0000
Message-Id: <20240329071106.67968-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resolve_pseudo_ldimm64() function might have leaked file
descriptors when BPF_MAP_TYPE_ARENA was used in a program (some
error paths missed a corresponding fdput). Add missing fdputs.

v2:
  remove unrelated changes from the fix

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edb650667f44..58952f040761 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18383,15 +18383,18 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				}
 				if (!env->prog->jit_requested) {
 					verbose(env, "JIT is required to use arena\n");
+					fdput(f);
 					return -EOPNOTSUPP;
 				}
 				if (!bpf_jit_supports_arena()) {
 					verbose(env, "JIT doesn't support arena\n");
+					fdput(f);
 					return -EOPNOTSUPP;
 				}
 				env->prog->aux->arena = (void *)map;
 				if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
 					verbose(env, "arena's user address must be set via map_extra or mmap()\n");
+					fdput(f);
 					return -EINVAL;
 				}
 			}
-- 
2.34.1

