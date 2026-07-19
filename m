Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE63806D6
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784471046; cv=none; b=dGSiEZF8Yvj463bZNUvVH4kL52++PadWuwcoMaoNHrYlI8qwQlwwkwu/QHDUVQQ9J2pQ3h6B4Kn0hBXyFt6r6Er9Q/pl1rYwqumfETOpn8pelRK3HSzDOBwHfuttuepVIo2NbygcHK/hbqJbKgqoJ3sWPHWcETmI0LRQIT2uL8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784471046; c=relaxed/simple;
	bh=uftPH+WIvWetPrfyZNmUd27c7jBYnY+lo6ZB7/P3Jm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTPeZW+3F1SSCkVt94rPx6h4teUSRBJgcz9OV1NGrnyCV8OS4hJm4EV5/bMg+gBGgiUReYOCKOGLFXWSGihhbXnHEnUE1C6MgqoqXNLBL4Iy7F3St3q8OFg0x0Xw8t8IXMjDzbbf3oFTi1LieZCNmx5w9nd94XwaTxGUuKpipbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuDnDES7; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuDnDES7"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-46e747fbf36so4150508f8f.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784471043; x=1785075843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dioaV2xGEigcAguk2WqyZjzfmVmozPI9+1u1vily2c8=;
        b=LuDnDES7bq8LThrBGq4K+hLciG6vzUMBStkt2iYFn6xAlTT+D04QAGjq0uIvR/8r1i
         1H9sWjufemDj5YEW+gAKIfQfhSb0o43ml7k1ZHcYMh0/J6ktZ4KEUo1s5k6wzK5CjkK+
         5a//FQDRh+tX6SfggG/ILLlgbQe0S0nxePHL65LF2IRxDOwL8GAjk7//h8rp8lz4VZTu
         YBf73b4XKTpk5BsI7Xi6dMeaPn2jBklQ9m1BDe3clqmLmB2pZqPbXMDr6r3jTbfrH/bu
         CSoNegGnbYF4Oj39EDhLfoBi2IO0r1fS/dZhJtPLe+2mGAJu3mzODwVXiiXguERoswTj
         pZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784471043; x=1785075843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dioaV2xGEigcAguk2WqyZjzfmVmozPI9+1u1vily2c8=;
        b=D5YSKSAsM6hlhd44Ihe/cAdrgMxUVRk7dfcGbCyJrpG4u7zMaQBIvsod/1NTJ9vf+Z
         Q1IgAyMfzo8xHY25oclZets8wQLt3Yaf6ikLMAotrB7MTNy3h0LUas4zl2Hor8MZpfxw
         fljXd9Kv5fwFn4VzQgKilqWx4sDphc+8mshmI+ka4WFkaVaikNWEX0yXycrFThhNN3Y1
         P+CQjhHuXi1UcVD6UYCK31dzGAN4zBhzF2PyEXvKTGjtPRpKWZhSO4LGoPh1smPO9WCX
         XWOiDXkN4vQ8TQNQmKaLGYP+en66a8IK0GDcL/eNJjboFlZY6+dm82BRYRnIjVFOVn7E
         0Jrw==
X-Gm-Message-State: AOJu0YxnR3rvqlgYquPuphPw5ocXeGGVF8oTlQ50qjiuuY15nRNRHpDt
	FoGK8Cbp6+gNiwhfn0mXeABxDhkVK50gdk4CKI+xZp6I0gOh+vvPHY20jvbUVSEA
X-Gm-Gg: AfdE7cmA2VwZ827jAPyucGRgTKa+RbHTXjkTXQAerzJ6WsOtrD+KX5Cvsrkn6Cvj5As
	UtLcU6VJwrA7coB/ITT6+/J+i3w5LJstygjdDDGrLV8y9Og2nq1m/iV4+2BYounmMhz0RvQDlHy
	xRigzZTvwnqRNIMAuKANRJe8za+8SkmaWadFtUukTjVDuyh1+1yiqWUGWISNnC/ohH39tasY/0P
	1cFLZSbG05x24mxegQzwwKnBefJDOP4QRdR7VB6JPj44Kx3p8j2EYQk6z+mqjZrGz0D0sybZNyh
	Xp6ddXyoEnIOttBpuvPlQK0SdAqGoIejqu25zQUDFdRb/kzEUQEal4fpIeyMzqQlKPTWWVqFGVd
	lqPOIP4DMns6KDzyULD68x8Wd/U2z9NDsKq9D4KVzZxLsVkw+tj1k29a5UpRfb0EkTka6qRPvH6
	lG6fA7rsSCZIOBMslL1P9Rc4+7FSoPopDngWhw+rdweUdf2y8/V9xFugJEHweEta1KtbuF8+j8U
	5GeMV2rC/RDNPLote3+dJw0B/CyF5ZSaGQTM83sR/qZ
X-Received: by 2002:adf:e19b:0:b0:46d:d90b:bbe4 with SMTP id ffacd0b85a97d-47f6232c546mr10386096f8f.40.1784471042654;
        Sun, 19 Jul 2026 07:24:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eea8afsm22250608f8f.33.2026.07.19.07.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 07:24:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Fix unique fields for nested structs in BTF
Date: Sun, 19 Jul 2026 16:23:58 +0200
Message-ID: <20260719142401.2420111-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=548; i=memxor@gmail.com; h=from:subject; bh=uftPH+WIvWetPrfyZNmUd27c7jBYnY+lo6ZB7/P3Jm0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISvm+pMHnTJTLbzsV5yo3/Fp/1Mdo+YvK75pu3gqN+hlm nL7/EjqKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESeL2T4nxPNd+tdEbsQx41b Fv0HNh9rOihuvPezwNKts4SWsQl+D2FkmCjGOfXb5Sc9lZa6fMeW8C+KkWRR9su4cPlP5CTrPy2 +DAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Fix constraint of certain fields that have to be unique when nested
structs are present. See commit logs for details.

Kumar Kartikeya Dwivedi (2):
  bpf: Preserve unique-field state across nested structs
  selftests/bpf: Test duplicate unique fields in nested structs

 kernel/bpf/btf.c                             | 26 +++++++++++---------
 tools/testing/selftests/bpf/prog_tests/btf.c | 26 ++++++++++++++++++++
 2 files changed, 40 insertions(+), 12 deletions(-)


base-commit: ecf11bc5f56abb3a2219a8c75e8a5b54467d1781
-- 
2.53.0

