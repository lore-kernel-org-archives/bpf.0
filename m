Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805293624AF
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629305; cv=none; b=BxFdbxKIfgzbtk56FrhZy+pjeYJ9GSQfD/R5gw1ZO29z/pb17fqL+iy/J4WSZPp/WF+wBjXRJUukCP44fUERhZyM/rH62bl2cfqKn2F1L/pSzAWBmTIGmJaSJGQHBQEsztxO9L48TDAYiDBdN6FJGVzpUH2pc7np8D0N7gnNCBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629305; c=relaxed/simple;
	bh=bFdBj9bbHDLyz2yZxEb5IcrG/27D5JU264pttwp06WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYINfASzy6PZAqDy9tptuRMa+N49OLTF6oBnD5jRV1ANeBFCiRR4fs0DQ2LqW7is9RjsnqnJDLH0EIPI4TLlvfc0U7pvox1dbZMJAIWIKVpo6LZip+IlgWlFncAULI14FscWikDg/WEMGD0bQGA1TXkvY3udtLxOAm51qzW0HFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk6UZCR9; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk6UZCR9"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82cf96ca071so2617942b3a.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775629304; x=1776234104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvsEcC9YBgoHRcgVgcVWA9zsiCb/IHA0zRMar9dtNCc=;
        b=Hk6UZCR9xRTZBheqV3cSG1RdMeaetI9HN9O9rkKNefW3nY7cq8ARJcWo/x1I2FYPPF
         bCyGg5054TA2H3vqrEHpgUXC5aBJrysQBG1ckojW9DGNB9FlVKWzxjRwLIsIhnqK2t/K
         yyrQ9ISx7EAtb7NzEmiErczOTv2pAQS0lb6zTsCj3sqr1v3DVzRWsKNdmyMLGxEYcSfj
         PZ9mer14KmWktoEKBjV9k1qxSHOABb+x1yfK40wq2B19kkfpXr9ZIAdWT/9mSxsaTh4s
         dAaI6Q3xhFChz8cSYHZtbdRKv55ixwVEHoANaP2rjIDFuGxt2FCCXqS9ZggshqyBgbcK
         t7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775629304; x=1776234104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rvsEcC9YBgoHRcgVgcVWA9zsiCb/IHA0zRMar9dtNCc=;
        b=FmbMNfQ9Td/4lwE82IzYT518Y1feMcYcK7GF7cgr++8CdbmbguFi8eA+8GeeIPb3md
         4MKmn5iia7DPsvNrqSM8E3y6MZZBfSRuxs34tM3qP570y+8OjAnd0G04JIRjAUIUEcXI
         7OcWoUZsoDYcgPU19koaUchugH8lPda6l9zbI8Gy4UvEtjOJirh9MwlFODmz9H02Xzmn
         izipkHnk7fEspECgsafJeJ+fdL7OTsmysxj8KC6SNtInD2ctG9chAWM7Hvr4bhaKzEZy
         6y4WhsdfHGPcCM6ouahcRdT9Vtum4q9yaUL5FjsNKn5Xq0fJ26781gvKdUEsisongUli
         46tw==
X-Forwarded-Encrypted: i=1; AJvYcCW953r3xaUBL79hNPydlIvaOL+0GbpdEsgG7x+rNVeD3GEeZEGtHvtYj7t67okc2uCoeXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJRBb0culti8FAkZb7cevM5gcyIWcAFOB8NtGWtrQ/pMSY/63d
	kV1iml88+6qVARDUE1JLFkSEVhBWk4AGn/Z0KtrbpKmJLiWvIh0MoAWA
X-Gm-Gg: AeBDieuBhOPwmYwtryDKAj12iyEcHVHu5TjdkqIGUsFkvIOGpM/q/JsGIWQy+IcvPua
	CtjT9QcIcsAYZPaUk95IeepscOXDpsSOAFYQdMRGvxqr8/vGK0PSU/fu2Jab/tXxOrbgVvQcULJ
	zKuG69iiu3cOgqpZwU47ygHU82YxUHx5qhk/yGrLvM/+9ubiWHap7yNajCIaCxfnl3L5clz0Jo2
	bt2EcYflJvmtXtNmutdeElV8j7in0o9VUWrbkUhjp0+YBeWA0gSEPY+GrWa4fQlJvIzBhLs2s8f
	8uIODOQFGQrrISGMyRM1rGoYp/WFmKZCTYoMNzUkZLogN4uv6s2GzahWzEDCDi36RC0IAdZFSiK
	9vNjHh8BSfOBUOENyfz1GJ1/55DlkomxyopoTp8EJjQpXewrfZBmGPO9xpglJxpu2IpfUKNW0mu
	9hU/W3xEL518VzwxyFOVC5
X-Received: by 2002:a05:6a00:800f:b0:82c:e60c:f36d with SMTP id d2e1a72fcca58-82d0dbf1a4emr17998807b3a.48.1775629303845;
        Tue, 07 Apr 2026 23:21:43 -0700 (PDT)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b60199sm17827638b3a.25.2026.04.07.23.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 23:21:43 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	emil@etsalapatis.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 2/3] docs/bpf: add missing fsession attach type to docs
Date: Wed,  8 Apr 2026 14:21:08 +0800
Message-ID: <20260408062109.386083-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408062109.386083-1-dongml2@chinatelecom.cn>
References: <20260408062109.386083-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the fsession attach type to program_types.rst and drgn.rst.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
---
 Documentation/bpf/drgn.rst                 | 4 ++--
 Documentation/bpf/libbpf/program_types.rst | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/drgn.rst b/Documentation/bpf/drgn.rst
index 41f223c3161e..cabf702eb75a 100644
--- a/Documentation/bpf/drgn.rst
+++ b/Documentation/bpf/drgn.rst
@@ -26,8 +26,8 @@ about these objects, including id, type and name.
 
 The main use-case `bpf_inspect.py`_ covers is to show BPF programs of types
 ``BPF_PROG_TYPE_EXT`` and ``BPF_PROG_TYPE_TRACING`` attached to other BPF
-programs via ``freplace``/``fentry``/``fexit`` mechanisms, since there is no
-user-space API to get this information.
+programs via ``freplace``/``fentry``/``fexit``/``fsession`` mechanisms, since
+there is no user-space API to get this information.
 
 Getting started
 ===============
diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
index 3b837522834b..3a07ce3b7f79 100644
--- a/Documentation/bpf/libbpf/program_types.rst
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -207,6 +207,10 @@ described in more detail in the footnotes.
 +                                           +                                        +----------------------------------+-----------+
 |                                           |                                        | ``fexit.s+`` [#fentry]_          | Yes       |
 +                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TRACE_FSESSION``                 | ``fsession+`` [#fentry]_         |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``fsession.s+`` [#fentry]_       | Yes       |
++                                           +----------------------------------------+----------------------------------+-----------+
 |                                           | ``BPF_TRACE_ITER``                     | ``iter+`` [#iter]_               |           |
 +                                           +                                        +----------------------------------+-----------+
 |                                           |                                        | ``iter.s+`` [#iter]_             | Yes       |
-- 
2.53.0

