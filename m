Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C35B10A12
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965579; cv=none; b=SptZgsm60GkWWqaeKwIm3A7oNMRiCM8V08rjg9RUOTao4HAD31nfDEUmZVYlfuUMVWhsraNBV0vT+ttT9wAAHtfVgsm9A6N1aB0g0kwINtRHxLfo0P0NJlwf81NQk6Fy6uQtqaipSdPWZQ49Fi/GGK7+9EA7UB9BRsbW5mAfYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965579; c=relaxed/simple;
	bh=NuaWxwWBmhsYXymqFEf/pRk/Mi0mnzpQzdB5w54C6B8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m5Hbvsft2yE90rSef/F7waYl9amA/n3P2GhpOnBRpoE1Vzz5qGbi99j5auO9geJGSate0XFPXIcV6B9LLbCSujS9V99RhNmRvwUR+SPivjzrjFzaN6HnwQHcgmkYARkDLid2Oe3Y2tlMhKDb+Q1lPamYB82Xszj63ct9uB4MrNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=HDsWcWe8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="HDsWcWe8"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4156c7664d1so1022665e9.0
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 02:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711965576; x=1712570376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tex3jXTphEhl78osorKcXj9Q2DFvqeV+FdD0gQRprT8=;
        b=HDsWcWe87bqbUg7CLSOpNEJuBinHfAsWwPNmKrEZGoCIIZmmPa34PTgO+rHbPcf8OW
         EQLq1Seec/HrALi8uiGmWem6m0T/ut+gl9XTC8ZnbshjJtWjesBlR0z0bGIQeKUfDTNe
         DZyA5RIuNl/BkhXr5FIkMY3H/OgkYQ18ZpK09pQc4/FYthldg4xPXU+Iofs2/u4FlxsJ
         fIk2Q9sw5lXR4zV00g51cDSd7lJMUj6HMRFpyg/osQ9mx5e+f6ls1EBW1JT66Mv7DxjF
         QWZaO/3yMc+kuy68MANM3O4/F1c5HcMOWHMZonek8tPIgDa9xRlGdUcImZlgnurj25Jg
         f/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711965576; x=1712570376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tex3jXTphEhl78osorKcXj9Q2DFvqeV+FdD0gQRprT8=;
        b=e/Vtrf3rKq3b/TIfG+01wn2ehTjiRoJXC4808dp4SVV+EIgbKWc2pSdhWZmdvGR+yE
         xuGI50/LJs3QHV9IHrXiUSRIy4FFECH4RRzuo7XW9jQXG9aQSdN1TsKssrlEKkqR7oge
         VixXb1t7R6YMUvBtTZlizktQwybbWtJjn8P1Eyk8Vj/vQ9xFGjf5bKyjGx79fG6OP/s5
         XZ9IpMArI00LJTPdO5f1q0x34xpSers60hOanqxG9RDBNxQUH4MbpxIlFp9vbiAPkeOT
         Sv4PSvLWpQL/lRiSrSxpV/An7fkWVPdGDyIpbLbKgdMJhYhQm8VPzjiQpXWs9MnFODW/
         B5jw==
X-Forwarded-Encrypted: i=1; AJvYcCWLnzLsV7ynTLHPN9yl6YqBCHr4b6FVXROvix2bTu/ry2q798aFmbaNmocxUrnrEpJi7C3q6vZ+mt8YQ8wSd5V8S2tr
X-Gm-Message-State: AOJu0YwxrgzRqIhh0rJJ7SZ5x+iDB55mv/qhEEI/OKNKAzUsgX42NN98
	4wTt7WrWyGzyniLYXDcUiH9t4h19Uu+rH+faQHVsdBswWrJ7orSYGGZKHwQA8zE=
X-Google-Smtp-Source: AGHT+IEZnVUrkkbfmJWd+Nq4QbtdrV6NP7W1fsw83jQk3QZLW4i/gwmP6OrAtVZc5BnqF4G0A4fB8Q==
X-Received: by 2002:a05:600c:3c88:b0:415:46be:622f with SMTP id bg8-20020a05600c3c8800b0041546be622fmr8064977wmb.14.1711965575732;
        Mon, 01 Apr 2024 02:59:35 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b004156506921asm3046373wmq.32.2024.04.01.02.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 02:59:34 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next] bpf: add a verbose message if map limit is reached
Date: Mon,  1 Apr 2024 10:01:32 +0000
Message-Id: <20240401100132.167226-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When more than 64 maps are used by a program and its subprograms the
verifier returns -E2BIG. Add a verbose message which highlights the
source of the error and also print the actual limit.

v1 -> v2:
  * make the message more clear (Alexey)

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edb650667f44..559526191ae7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18348,6 +18348,8 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			}
 
 			if (env->used_map_cnt >= MAX_USED_MAPS) {
+				verbose(env, "The total number of maps per program is reached the limit of %u\n",
+					MAX_USED_MAPS);
 				fdput(f);
 				return -E2BIG;
 			}
-- 
2.34.1

