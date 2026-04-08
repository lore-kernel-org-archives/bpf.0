Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E4A2D7804
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775618091; cv=none; b=WFXS7VaZp72jJSiyOpTtLQwIYPWyNQUYfpMHHHj4n9rGzebomXTHfkFGq16Y3mIA+z2KBlwk4vvwyK53gn+EKtFAlolpzJLM2T2wNMqpaEQT/B5i8DdyeWmasgrsSIqgknShFU4pv0kU8ks7H2EzqC1RkTtbTxv6EBSTWvmEwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775618091; c=relaxed/simple;
	bh=/XwAJKGa5onC7P1zQzNd26YdNtA8vP3iXcjeJBDk62g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQ2tmqN5xXq75XJVyv/tf9texjsIhb4ABodY0Y6smA4d9j6kO3r7+jFUt32yjk6T4+k1dVbqaoMKCWGYwZcKpnGfDcKes1G5gjmT7/6qFgcfG2KhWQSLUjMhd7EYcBanBgyA2Mo2cClvj7cFssUhkdtKL8uEyMIDXBCN+va+5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McpK2WK5; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McpK2WK5"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so4943292a91.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 20:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775618089; x=1776222889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfNTcQgzjgZ3+eS+lc6HGqu2iitn3GexvmimCUxMun8=;
        b=McpK2WK5voGhvPzTPlJyuOxENtQfJu9maoflMAG8n8CKB8wAuL5CCob5cG9KW4+xB/
         xvbKnO4E3N0xHcXUU9ylpYOyDdlEu5t7q0IdZS1SeHvpT9bzP4j08HIwUf9cPS7pyCyF
         vVzA8X7UcY38QYAYJu+1a43G0u6qaBK9laAr68Tuc1SAQY4d7jJhs3BAC9y3mmvOtJnE
         oII9sInv16ggTim5svGVM9lm9/+FTcpoS/Ez7Pib2A7hcQGQe5r2sLE/tT8NZRT3PMde
         hnVvx6HCSMugZ89i96N/fT7HfeIXHtmayV5JplISkbIGnRl2/nyLy0LxbB1infpYcaDB
         //PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775618089; x=1776222889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VfNTcQgzjgZ3+eS+lc6HGqu2iitn3GexvmimCUxMun8=;
        b=X14LIr70fWnuy3EDQupqNarQngmVoeU24HOXvQWedgJAwbBpn1mUX+F9WSgSRxiRrW
         4/wv41ojf5f25QcFS4RMbvfERijLXqtrdscSK9cvun7VJjBhkOKiER276P2rHrOqsSP8
         m1Yu0HqLnxWRX6C1t0BL+i6buv/O2WXZIHGd25EUKVVv0TWxD65uil/AFK60lxQ7kQHx
         cfYhq0IA//DvNInrbpkVmrR5e/5i9+iXPUuQoNUPvQzbEhaHycVplmj5AJuIrv4M0LRT
         l6rnt95BJB/JbIZ4E/r3nsJ5lQNxG69HLDO6zvNTu9Ip3hE3mxApqquxX3rHUxDkH97R
         vgQA==
X-Forwarded-Encrypted: i=1; AJvYcCWTrbcfZgs+YJ+UG+AOnfvuB1Tirp5iI8P9CavzxnsqsB7sPEtcsnLOQbEv6nd+83fQqGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUP1sYhyKcrUL4FgIZGPqvRykKP1+b5Wkk4LaDQrtR4LpgyVu
	E+TE6NXQ56h7rAEWhddbb1kRK3HajzWbKz0hTokS8eMnsJzO1S0Pb5XP
X-Gm-Gg: AeBDievBqdIerP++nuh/rITshuyUHBwe9sHxHgDVX7CLoyjFv6yZ1diQBz0eqv9EFMI
	Weia+SXdOU7+q2asVqsf2vbiXJPUJaRlXMmukERkLAnLXDFtifZV2ijiHTCNyZsWaaV/09heC8w
	rD7Cd6glDMhO5jsbAKXELw9gkAp2FPdKjuKKj9bRxaB+SLZuwYKVs4EGbjks3O30F6vHUwWi1WP
	EmzWhyGjjc1KOc68FcrxCC8uhWXjtgFawrMKQpDfchFMYsa1UGygqcg2TIPY0G0bZ93Gy7nkf/h
	nF+rFk1tM1k0YDO4TVSKuoMXBEVt+NhncWAOxV9b+XhRR0U1gUWj0XjamBE3+/ooWvd/y7cBVvr
	7a5BSBNb8jYIW2yv/mS6oyD10Df4SUb9Ce4WRgLY/Jh5bUvwHPENHmDHEZEIqQH0s9cCZi4mCgX
	2Lg5c1+wad2o9XE4thzJL3
X-Received: by 2002:a17:90b:4ecc:b0:359:7c55:c166 with SMTP id 98e67ed59e1d1-35de67dcbe1mr18630251a91.7.1775618089331;
        Tue, 07 Apr 2026 20:14:49 -0700 (PDT)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe41b11fsm23506913a91.0.2026.04.07.20.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 20:14:48 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/3] docs/bpf: add missing fsession attach type to docs
Date: Wed,  8 Apr 2026 11:14:15 +0800
Message-ID: <20260408031416.266229-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408031416.266229-1-dongml2@chinatelecom.cn>
References: <20260408031416.266229-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the fsession attach type to program_types.rst and drgn.rst.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
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

