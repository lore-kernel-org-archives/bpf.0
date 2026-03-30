Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E34282F20
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881068; cv=none; b=NvmVh7yZcob7aZLMuZPhUeymWU1Etq/TMwUx+UlKKZcI+az9XNVxFA2D66bU6bFbDRk6DzNLmnNkmcVdHmS1Wi0Vqu+7IEFZO6cA9gtPVcDmn+CVAkUbJweA3xQyz3UlszBfky6D1zECYlxYiHraJZTI3FwrE+TByOUfHiQiwwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881068; c=relaxed/simple;
	bh=I+n8smcGeDmy3CeUeFQfZ2fklT2h4ZSvdbaHSLP1djM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTqrbC8LYlDHy2h1hW8Ebfy1BnSoZZZRbrh1H4ovspxFvk5LSa84gVWIewrCEJBI1t6eyzLTElD9c0zdnI2tpfiRgPSk1d9hG4OQ9yS0PcVSArkZk5WlRdspjv6MFGhv/borfnTpcfEntWYI0PJrunMSRy7/xQTnYjmaBNpaRD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7NW8E8C; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7NW8E8C"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d9c98e437cso3895839a34.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774881066; x=1775485866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ytt82goEyZROf2QU98dAjCTaum7PBDKxX3PNNvVgZ+s=;
        b=D7NW8E8C9dAC7xRSvS2YNx79QnbdL2GorQw3CDkEIBiyWI9992Kucd5Szgdka4Dbrh
         WYmDIN/OhfNGBZ1L87vBfHm/q97KXOwaT5DkuxITb6gs8VwJl3M14j9Dz+3CkMhhpwMh
         MtMXIhr8+xIr7sDEQyvHDIwTMFd3aXDSpr0lYYlh6WB92tI+jotLGdqDGpQ62xmTXoPx
         9mlU1+6OZl1GbVuo8n3TuKX2vANihR+HVYKECuuNMKdUVHTxuDMxRGjgw8oAhtLBY9Xi
         WBvd3ceutQG1j4/ax21XPdLhpsXIjgam9n9PhlTDcxldSIlwD6yOHYuXeRhCWz8/lQFC
         mrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774881066; x=1775485866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytt82goEyZROf2QU98dAjCTaum7PBDKxX3PNNvVgZ+s=;
        b=qgLr0XaZBrkoq2wqGSVjvMT5uEl2b8Mv/27scByTmYGu+GsgGC/QcQepNdHW7kDgNN
         VGXj/WUnVujIuv31gNJICm58zA93odbkUmPTUt8P7o5ZrwSoYqckOznzEeSKY3tVPrIJ
         AwuZvYwhxqs/fuMvikWikkqCmrOcb6s2gQSLK0e74J8f0nH6n4Q1ykxJZO54XgzFBnZo
         2vDIIvR+T5Ko9Pe7PpPkxbknpvkyOlA65VCCwFDwljsnpbkVThjC4yFJtgOy4gYmWSDy
         UDviaAgCFXrqpA31SsR4jfpx+az2VpGEry53dz9bq3x9rntXlflLU5K2tBjsMUS+mp1S
         dTzQ==
X-Gm-Message-State: AOJu0YwRqp7LtJcu69vcCVtKYG1C7x0b+ONm6daVOpRpQuFEgei08VL+
	9MUotxKKxTIcFdTyRM7vZORXo3Ua3gPEYog6YdY5GtYtV05D0ocqzH9e5h+SALab
X-Gm-Gg: ATEYQzzfZUdUm3YSzW/ghiaV4qsqOFB3tnWsUHOAYlx6LovJ+QaMMXV6fWLaV4Dyk39
	xoxnZC5W26PwhW/kn+VaLP4m4QRoSkvKDne88hOvpAK6kZuzUbKAhpCTBTZZBgwzpiZqNC8POz4
	bQnnmI6uz73PCgvVV6DK4UBNsGfLcT9J9hpLm1pOIA2AHajJ9fv2VaLeuBxNa3fcMJyzwpJQoQ6
	a+D/5UhzCM9ev/yxK9NXe+SM6jXU6cM2OpfNOCckeYqLfvY5r0IuXUPg2GRaXmvo7e5iOKQX2pd
	f5ifvXC1mTnCmwrmD5jt/inFluOqCeU8xEgicCo6KgsvzznjBNrNwE0oZTp+5GSqOi/mYz8YN2D
	JG5OgTcqWpnyH1NFFFBaxvU6yyUypsVkJOeeNWJDrI2ILaFnyqA0WguQz5sakEfZ/3TkRQ491C+
	jcJyOJc3EGuOJwvNEFOZt5od1xBUH2Z1cSholZYG3S4WmH
X-Received: by 2002:a05:6870:218a:b0:409:a4d3:a30e with SMTP id 586e51a60fabf-41cec0f1467mr6707897fac.2.1774881065602;
        Mon, 30 Mar 2026 07:31:05 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04d79c35sm5270462fac.18.2026.03.30.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:31:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 0/2] Fix bpf_link grace period wait for tracepoints
Date: Mon, 30 Mar 2026 16:31:00 +0200
Message-ID: <20260330143102.1265391-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; h=from:subject; bh=I+n8smcGeDmy3CeUeFQfZ2fklT2h4ZSvdbaHSLP1djM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfNUx45nN7/vXFhw/4BTunf2ufcTA5aksvSGKLxRqm733t7c pRbcUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIk8CWD4K9NqV9q/+bKWk/vJZhetT+ X+FmGe7LsP/l76fsoJb46t4owMvzwNgjfzM2psm7ri763vz3rKu8Un1tTddJOO+HRm+qZEJgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A recent change to non-faultable tracepoints switched from
preempt-disabled critical sections to SRCU-fast, which breaks
assumptions in the bpf_link_free() path. Use call_srcu() to fix the
breakage. While at it, retire rcu_trace_implies_rcu_gp() and clean up
all in-tree users.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260330032124.3141001-1-memxor@gmail.com

 * Add Reviewed-by tags. (Paul, Puranjay)
 * Adjust commit descriptions and comments to clarify intent. (Puranjay)

Kumar Kartikeya Dwivedi (2):
  bpf: Fix grace period wait for tracepoint bpf_link
  bpf: Retire rcu_trace_implies_rcu_gp()

 include/linux/rcupdate.h   | 12 -----------
 include/linux/tracepoint.h |  8 +++++++
 kernel/bpf/core.c          | 10 ++++-----
 kernel/bpf/helpers.c       |  2 +-
 kernel/bpf/memalloc.c      | 33 +++++++++-------------------
 kernel/bpf/syscall.c       | 44 +++++++++++++++++++++++---------------
 6 files changed, 50 insertions(+), 59 deletions(-)


base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.52.0

