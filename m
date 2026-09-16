Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5963E6DC9
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539301; cv=none; b=nqz9wObyiGsGIvkIUBHtP6H6tK1zi4RDGr1/2hvhwHukXtFktFFWSuI6jUmOly1JnKzDp5RtPGQOOu0q2yAd7V8qjduEnpNgCPKI177fxS3VEiB+eNhpJL8LIAy0mKJww4rcHSqlO3CEf0ISY6D7VQO7jkoHJYIZftWCwSj98yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539301; c=relaxed/simple;
	bh=bEa4qO88nA8/qLPLqhXgHOJCKLupOkNX4kfesKgt13o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrlpFQPb3lGVs86pPnSNuFZxxn33Hina5ECYC4101+4zpndHIrRhV53gnpV2Oxth7wLJMgtoiIpXJag+x9pgpHxqF3bTOoYcTzd0ygtPYW1o8wF3Sm87+pI61So5pglhjsOfRyjzjyl7myCIKjtYJkjvDs3iQyG4s9vteNq2G/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UILgjirf; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UILgjirf"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d942de6574so34112775ad.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789539299; x=1790144099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7QCKIBAsyBgRflIM3No1FQ8OuKChtBTQtGCZAZUwjvQ=;
        b=UILgjirfjSwn9ntmp71gm5atUqt5MU2HG5oOI4wXYLTgdNOwdXpqP30XdSuCQQSj/9
         QG0PVk6i6vFblrkAChtt0rk6CQ1VqgHdVSRBiEtBCftAflxuh2yjfBIEy+4/JPNed7eQ
         73T3XEfaswPMnYdJbCXBvhtHujEO0wRH26WcKYdNUoGlKG3GiJbOu6DcYTswBPYfmrCI
         iFtXxA0gmQeR3PoHF1VhYEsTJ/E7qlxIvyQKKq78sLY/7QOFV7kdzWS8OcmDAl59cPoQ
         KBWxwOpIwjL/oAHy7cMdHE5xPHY9jT6TsCOXkGK7HUZ+ICoUuAREi/4moVu0wCsRPwC8
         pBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539299; x=1790144099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7QCKIBAsyBgRflIM3No1FQ8OuKChtBTQtGCZAZUwjvQ=;
        b=RuED4V694DZ/EU1LdfYg4V6sW1pyZaPaBvZdn5lR7crFmxNuiGaeuAbPPMr9e87Ju7
         EqhNjLSNSkcrc4bvKVLuUOQUzacCeiI7XcdksMFwCzdlOqv0lJBMeKe4UZrQ3NrUmWvz
         XyZaPkpDLElj2YoQSuYnkU69VstkK6chjJnl3IwXHFXHQPDdmus6ktC9EYcDeE2vO+vF
         j/M67KjtkWhjmn3NUjd3/0wQcIh3tTeBo9EIqRD0hltjUQFJN9alemOiZ7i2xwEzdIje
         ZYr8ri7WXw8ibD6gwakY31S2ujT+5emQfJgfiGe8SyvgjBxlej0h8Dir2XEjvQ19mI40
         ekoA==
X-Gm-Message-State: AFuF++msP59P6gPHqnP6AfnEn/qpvacHHhgm+nmOAylCXacRTLhCXA4f
	5Y6GxBjkLubhWsCm8mS+Wdc581kGTukS1ET8NklFyyu9W2y3m+AX2Ac5OwShEIkG7RefUPZI+Tk
	=
X-Gm-Gg: AYBFou2MGdHzs1I9b7clz1UOCeP2v0iRqFwkkZYwpaUM6/8aoacb4q8rurMYj2HA1rn
	RcYccnIQU9iW8ABPodicAcLSu+DO/KnyzEA0U+AQ/zy0SI2e9CkMf/yH8ZzLUQvoeLCdySsPbLG
	yUHLZ6uOK5wcjsq9f41wmFkC0QFe4AsJLAjeFAAyuiye3jtCX/wRgMI1TampQQUhvHFlLvrDxTh
	QxxfOqafu/mQHY5R0XhebcRnhoySg7zOrivwlLCBiwUQ9m/67y91nez5HDWKjMi6T1CrE3/ndkL
	oSTG9TVTE/pMgx1cHgytOm1a8KIAu5U5tsN+9ZLTc3G4UyNDfZTb9Mn2IbJ6XNvSX5jRxUv3u2q
	cvUqopJhC5HnKPJNV07NGrxtN8Dy6HAoYAWGbWKkjC+k45S+Gn6AwBkku13MpvY8kEynfcnIJw/
	uB/f+kYAnrMqvUT/6t6Qi15k5ODSlS20dfBZWCTH0mlSc7xw+kE4XdpR+0vFyQzalFtKQ=
X-Received: by 2002:a05:6a20:9d93:b0:3da:9f19:bf2 with SMTP id adf61e73a8af0-3dd5f5c7a3dmr3647336637.18.1789539298788;
        Tue, 15 Sep 2026 23:14:58 -0700 (PDT)
Received: from MS-A2.. ([38.103.200.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab50d67sm975157a12.6.2026.09.15.23.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:14:58 -0700 (PDT)
From: Li Ruijian <li.richking@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH v2] bpf: add missing __printf attribute to bpf_diag_source
Date: Wed, 16 Sep 2026 14:14:44 +0800
Message-ID: <20260916061445.356935-1-li.richking@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916061201.353630-1-li.richking@gmail.com>
References: <20260916061201.353630-1-li.richking@gmail.com>
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
---
 kernel/bpf/diagnostics.c | 1 +
 1 file changed, 1 insertion(+)

v2:
- drop accidental Co-authored-by trailer from v1

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

