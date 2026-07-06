Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FF3AB496
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358373; cv=none; b=kNZLXiveIEQfInMM8sFE8Ur/MabObNM8XQ16kaxMMaqb4bpTFV8D4DPhFajV5ozzgUcYGHj+ibILoafEMQ0pQiWmPU+nTTvtj3XhXHO6l7zJYfYH+pXwWXXT3Ibvoi0UO9VB+RakPuKgxoIVYEJ2KjWWTqPuyVKvTJRGtkx0qfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358373; c=relaxed/simple;
	bh=XZtVUQcCsDDKg0wSm4JJ3T71Iojch8O+uv9g9Sl3lgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qD48RPsP2sf1cdFSeVPm6RjEXtfqlOHQoZGug6tjK0KmzNFKNgfzn/X2/li2Sy8MW9Q5rWcuy7lpsv8iujhxlBrcxSVnMfBNw32cJ4n0Uy5J0qr27pzEWTHCWdT5sY0wzwnVX1ZLpvd0AEmH2hMw5FJbCaMBfAdfbY17wk4xJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSauimhA; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSauimhA"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a168dc590cso2430520eaf.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358371; x=1783963171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZlV9XfIJTTA6Pu1Hwj8l2qlXdENOMQrIYnP3ua+eJM=;
        b=MSauimhA52MZ/+iiwKRy2XqJ4PQ15qyUBcMyrOySD4eTL1ngC+5yHFb12NEhHRkIUd
         4I8UKIZQvydEGGaXcOa6fmkHsLd5toY8iGJ/nZBf9aXj0a9G6XIpHIuPrrF1OSbkEtoa
         GQlK9mkQvXlKgrjZV0RjRQk2q6SRoGNBwd4GqbXwrXz2p4mL9viRypqpjWoY9JKbh1rb
         ucjo+NKiVfyFp82kKz/dMdpcNs8Y55YAxQ99brjnQVqSzJFLUnxw5XivsvkLLrOWonIn
         b5IRVK7h0PXrrpdn8ptcC41CdojAMIbo1g1I6lfAZB4hNeSHMyr7nITR4HSuEEFzq7oA
         eUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358371; x=1783963171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZlV9XfIJTTA6Pu1Hwj8l2qlXdENOMQrIYnP3ua+eJM=;
        b=WaZQ3zqW6vGTkRe2+F9pgAKsFXN3TR9qqQOnbQyqWv6jtLtGGMwQam3r0CbLUu6qVy
         Lj36j4tgb5VhXiVbC7BNltWhB2SfaQ+lo226UVzN52E9vRhdG2pu1VfTE9j3rxDeCKYx
         Ox0NExQEW1YnTFWrHDsU+xiNEKPJ1UFaPrlKVRzK2eF4/0Qh+9CIwHtGZKTCU5FSbCtw
         akgQZXFbd8bNqmGscK70zleFSNb+kamt6fGyqrLrtxqHSSDsErBCh9PhdldNYGHBOZiO
         fMJfcx33XzEl4ftZlcsZAQmp8PUpfnyi4Opw8CYDSImRUL3Tgmf9WL36GMD0EieDf8XE
         o4IQ==
X-Gm-Message-State: AOJu0Yz9I+y3H8IP47x9tUUeqner48VGfyy3V/FLtxJ0PII+NeVH0jcE
	sEAYEM+vF0PSMUSE/y9p6h1Zm934QSb6gjRq0r+2BQBBmIrro1HxNuptQE8P9w==
X-Gm-Gg: AfdE7clDi8VDPITlv1Aq47ewv0XzvQF9TFiFnCptvLzYMgmBd0i0lz6Axa+HyUvBRSu
	RR9bqf63FRZlVmzu9cj6gwN3RURGlqRPtWfgLwg3UKnwdupM88O12Wm91XBRliCELYbW3GU5laV
	ql9zFzju6L1QMkXWG1MK/w4KDp2tCkAzhyuUbgQQ/8aNGt5XmvCKEHUXT3A8XuMOdgHExPT/725
	4L+KUOeXf+H5sftoTNnylCEIOCWJuWlVBk+/uiHq9ODHzGuMx5UF5mQ7af2VS7jupEt2CqTB6l9
	7q+4k/MeNLhiyT79veHhESqkEQtHWchuPDSg5aFWM5gHdECLgYGzsoK7echlsqP02vGjuAAFW81
	xMTzpDGCkTdQjRq7CxaBHOHybR6uAtaU2aqf07HirWpNvobGQiJGwz/0akZlmZtLWl4h8pPRoKL
	YAUFE=
X-Received: by 2002:a05:6820:a09:b0:6a3:2b61:4cc7 with SMTP id 006d021491bc7-6a355597cdbmr958874eaf.72.1783358370791;
        Mon, 06 Jul 2026 10:19:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a30ffce324sm9600123eaf.5.2026.07.06.10.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:30 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 04/15] bpf: Remove unnecessary prog_list_prog() check
Date: Mon,  6 Jul 2026 10:19:06 -0700
Message-ID: <20260706171918.317102-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

effective_prog_pos(), called from replace_effective_prog() and
purge_effective_progs(), tests "!prog_list_prog(pl)" to skip a
'detaching' pl.

When detaching a pl, pl->prog and pl->link are set to NULL in case
the update_effective_progs() failed.

However, replace_effective_prog() is not detaching a pl,
so the case "!prog_list_prog()" will not happen.

In purge_effective_prog(), the pl->prog and pl->link are restored
before calling purge_effective_progs(), so the case "!prog_list_prog()"
will not happen either.

This patch removes them as a prep work for the upcoming work
in attaching struct_ops to cgroup. When attaching a struct_ops
to cgroup, there is a link->map case and the prog_list_prog()
will not consider the link->map. The replace_effective_prog()
and purge_effective_progs() will then incorrectly skip a pl
with struct_ops map attached to it.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4355ccb78a9c..b64f6757096c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -965,9 +965,10 @@ static int effective_prog_pos(struct cgroup *cgrp,
 
 		init_bstart = bstart;
 		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
-			if (!prog_list_prog(pl))
-				continue;
-
+			/*
+			 * No detaching pl (NULL prog and link) is visible to the callers,
+			 * so skip the check compute_effective_progs() needs.
+			 */
 			if (pl->flags & BPF_F_PREORDER) {
 				if (pl == target_pl)
 					pos = bstart;
-- 
2.52.0

