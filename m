Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022CE39FD8
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696730; cv=none; b=XI0mD1gOV7JKsybrhyMCgFxR0nIgF2kgHmsWYyAHkJ5tskBiDFZ3B9uGspJMNdYRAfNZJ2LVPhcWGQ01/rzkiVT2qV7zoC02OxdO5x5jE0UTYsrgxLahuaong+Gs6r2Sy34oVcN7TIHnjNADl8ee9veQ2bWwmlhQKVrSnIvtjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696730; c=relaxed/simple;
	bh=TwaHVFCHQ70BeTVqRO21kzPvFWiz1VsbRoZxLc49ayg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U3FKtErPAQ5Imy0aQX0Ki8jZoh3nZv4mlblx3GqeMvcIerXSq8EbUnCnMhROdwOS2BTby+Y1ZVXVvCio62qgHXpvgzc0uLEwIeHIhx0v9jA20QTTFd2/iNftMchreNmRj3bNHPzI0p4CdR/q7o/0xbzse0cwLTG/VEussSQS2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=c0AKn8cs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="c0AKn8cs"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41488e17e1cso10564385e9.0
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 00:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711696726; x=1712301526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krS2D9ecgFkqS97xIEeJ9AxALCcjlxzIgSfRElPb5PA=;
        b=c0AKn8csY6fOKeQbqGmCXYWZ00qQWSk24yYTOW8/TScs9xNdSGzV1XHEmA7oCT+P5I
         qZs9lNOASLVcwB4VspDU38KnWoihEsn5/c3lUlBXg1yQxJ3/6XLO0ES97S+INfkr6hBL
         bll+3Q1dL7peEv2WzxlNXnGIRyYsFfK6qzb8RUGOdg5InS0gs/tdTR4bZNJpRZ7w/8vK
         z4D82CCIkRYLqgbAjg6NnEeFCqR+7oGxUzaCxC8pRcaflTQoSU583K1UAtCPO7npnLKL
         NncEG7VwUSYDmcn43o9y9yF6qdkShpGWHTPVi4G4V+u4X+Q1n5A1/16YazaZb0v4glop
         On7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711696726; x=1712301526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krS2D9ecgFkqS97xIEeJ9AxALCcjlxzIgSfRElPb5PA=;
        b=Y2ih2oUzM4jrqT17Tst5uXs74mPdVYzSncu2SkuTzLe1dtSurR82JAAf1lNZp+Dz5q
         ldROSM7a63kjHnkSZ3ciOInU3GyFL7J0eJJzW4yI2CXdqCgRj/FmcqrnbatQ6ORQGZJs
         yk1deGTHMLLOcAOWF6dXkPpLRZ9xmrA8oe5H0rA/tBWmz/uxfBtZ+Hla/TojrvH0qAT/
         TdHFmsWuD3wTmDDcqh3iTJ43A5fqGL87jgFkhSJ0Dr9cDssgGT7X74S9kxHb0IgpNWzV
         CkxiDkKqrdpbh7CpBfCHSI0IIV9G/G3VieVTnp41RUO99G23abzM2bFh9jitL9k+oiY6
         X8nw==
X-Forwarded-Encrypted: i=1; AJvYcCX7zAbOQrzGJpT3bzVZcuejRnj94CBN5uwB7yesXCUovm+2IeDCxJLaBSFxuChtXindblbQsyD3YEYlqAiEE0CjalGP
X-Gm-Message-State: AOJu0Yyoeg+R1VUCWzfVW3u3qau7BdY/ljfVqSezqIVLfKenDCBQ9ldT
	5IqZ/4g5ZTYu1V/6qiqkY6t5w5NmLtLVdydsT1rglmcDvcWO0drfDHfrFSgRgbQ=
X-Google-Smtp-Source: AGHT+IGvCGV5hX08Fnpvw3B3BdBVzfCRVAHpCYpmyO5jxa9ci6bswKwPiaRVKK/oFpMoVPVfth3tAA==
X-Received: by 2002:a05:600c:4f90:b0:415:43f2:332b with SMTP id n16-20020a05600c4f9000b0041543f2332bmr1118723wmq.2.1711696726258;
        Fri, 29 Mar 2024 00:18:46 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id iw1-20020a05600c54c100b0041550e03bc6sm554986wmb.44.2024.03.29.00.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:18:45 -0700 (PDT)
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
Subject: [PATCH bpf-next] bpf: add a verbose message if map limit is reached
Date: Fri, 29 Mar 2024 07:20:50 +0000
Message-Id: <20240329072050.68289-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When more than 64 maps are used by a program the verifier return -E2BIG.
Add a verbose message which highlights the error and also prints the
actual limit.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 58952f040761..fa73009d05bc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18348,6 +18348,8 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			}
 
 			if (env->used_map_cnt >= MAX_USED_MAPS) {
+				verbose(env, "The map usage limit of %u is reached\n",
+					MAX_USED_MAPS);
 				fdput(f);
 				return -E2BIG;
 			}
-- 
2.34.1

