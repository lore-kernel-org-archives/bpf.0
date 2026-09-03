Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A630569A
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446678; cv=none; b=S0Fi+Ka0lIa8x9hjsNAKcPM334t6PvKJBlhkhbM7UpFcfKgT7bW+eVm25m/XIikmjBoq2jSkRRh7LGG0YsBt74PQfUrKOEoXDJvm8eC2RFxBAUPWyfWo/WPLsU8eXlqSJMeK0ew/09/mV8E81FdN7eI4K8QS+erFI2XuKbkYjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446678; c=relaxed/simple;
	bh=0ovf0EMfZx8IALVjkxahlGjGhwE774VWP1S3v3h6Kxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MLVLsuNGVV/OlJMtG1jp0R5C4xoQv7YTA8+ttT9qEW1SgSM/M9kuFyChLwWYwO5KOqwjOiY5a3IPmUqbUp7uQIONOHKc90aAiYYp0uUWCjY8z3SZbQRFB9wV5XvEmpLIHnhP+qQk0D81RrsnLCx3pJP5fegHo8Ymarm6QT/6DVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNlnj8ud; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNlnj8ud"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so4218985e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446675; x=1789051475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dIF5AygXZimj8u91l9VZHeN2d4HIKiQM1/6WsECbo4I=;
        b=qNlnj8ud4SCyD7l5l8Ix3R24tIjFHzViAeP0t9Q3m/9Qv8ikikkjVYbm3pNzj2aAYc
         IklQx+rtCLX0aouRfnFpY7WgNTvbAFRb6xqMyWbs2LrXom2NGe3o/prSQWqUgX+46Vs6
         2ByqmzZ+4nDx3jo/jHqAqxgkiD1QZWfSnywZXB2nLkbn5DY66/NK+vo7xQRsA6Uowk4v
         9SC0Y7E/K4XmCkzbA4ZbXwxP84To3idkafxrFtpotZANN8VS6w3mFrtmHRPFkcrbthEd
         eZQ1qTQqKeT3jdLZNrWzY/iNYBL8k3t9riX823QDIshL3HDfBJpIFJ0EmMNxHpORWnDO
         U/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446675; x=1789051475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dIF5AygXZimj8u91l9VZHeN2d4HIKiQM1/6WsECbo4I=;
        b=hmSTqCIWS/Ze4uXf7Gh+84I/1HhZuM+1ZNnXBcClTPDBpZHAoDgsuL9xpPwAqIWDBO
         aG2MgF5e2CaXOL58RcS+X5C7KoOctiUdgAx41X1KP0KDNRHbJSm6crTsvIzHtb7iKCC4
         WdDnG8RAaw47wjhHFtVpCLEL56bvW1lKLq2Ws2017f/DUmiPUAF/8WFvTt84l5r3Bn0O
         mbl5FnFHEHlPXwIgwqbh5xcqDFVSeK059Ps7Y0s0crxB6wPWH+cCZsYdUZ09u33ok6DG
         aRowIsqpxLaC9dMvcbd4TKLCiALKAH4fnil577OSwdT2YbaaVQMwmwM/5tTHdnOpRIRR
         QWUA==
X-Gm-Message-State: AFuF++l0XB5FbFZKV8pMHT+4Nx8FzHDOBQwtPRitvsTzitAUvCQQfx3r
	VmB6i0ErgcVQnqi3Z5xAJ7TnNdYvWEc8ZqqjAiLfXDS7Ntlv/VNJT3qP1Ry9cvJI
X-Gm-Gg: AYBFou1HFu+GO7Xa80b5DIlpqGi2mvf0AU4xIwMHPlod3QJIXBeHKjT6xlc8Msiwahl
	VvUFp2E0rRvyUOGpYyflmepYFnEYktegJZRvjTxxIYM0XXHM+ul0k4LiWnLAXS09Jn/23r/uv+k
	7xVAfNPEOuEFSckuhiZ3m2uNyzWlp7cIKOHU1bR1m9zTXqTxPn1JNhOcMoSG4nmCTqBTq0SNMiP
	Vx/gXIZOk3ok9Q9HNmnbdB8m0TW1LfSpjmW/3wsKHD1p+HmrSfVJtQLBug7IBe67fGwbLGvBAH2
	vOpf6l31pjtDpzImLnCuS2ocnIChgPqPi1k1GPMgDepTmMPxt5bBtB57ttZOTBtbDsvkHTxeVuS
	KojDxp68ixNFbdOuV/nguez9wOndlJqYq/W9V/FYxiJjVq/xgLUF45x7MRgUkHXLSG0oEB8KF+3
	wYgYikQ2/PZstd6VInoAcOQE0uY20fRJjX2Uun9RSizku38+dYjY4cAf1PPb5PnTyIING5kBPEv
	VUxnlKBuY/6LhBTjXQ74T6XmT6kzTtlMVK5YFNW8LwCyDX0aUfiOWw7IIgKlVbJxM1Po4epovIG
	OJD8s4MH37qkfckpQyJhptg7c70=
X-Received: by 2002:a05:600c:4eca:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49ce5816892mr196616375e9.4.1788446674685;
        Thu, 03 Sep 2026 07:44:34 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm76649645e9.4.2026.09.03.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:44:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 00/10] Misc bug fixes - part 1
Date: Thu,  3 Sep 2026 16:44:18 +0200
Message-ID: <20260903144433.1716731-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340; i=memxor@gmail.com; h=from:subject; bh=0ovf0EMfZx8IALVjkxahlGjGhwE774VWP1S3v3h6Kxw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtmc7+L8OeIZxw1eY5aqjeuS34+L8RjYrf3+p2wKdkq1 WabT5V1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCKBfgx/5e7VpsStTn12/bJ2 0+8r646v2il+I/fn9sZouY1vzSKUNjH8T0lzfbnaIEzQsnme6KUexeJ3XwycWGyPbHyx/Xic3MS XXAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A set of miscellaneous fixes for bugs reported by Nicholas. These are
easy ones and should not require any major discussion, hence batched
together. See commit logs and selftests for details.

Kumar Kartikeya Dwivedi (10):
  bpf: Mark signal tracepoint siginfo arguments as scalar
  selftests/bpf: Cover signal tracepoint siginfo sentinels
  bpf: Reject tail calls directly from callback frames
  selftests/bpf: Test direct tail calls from callbacks
  bpf: Reject resilient lock operations in rbtree callbacks
  selftests/bpf: Reject resilient unlock in rbtree callback
  bpf: Mark sched_process_wait argument as nullable
  selftests/bpf: Test sched_process_wait nullable argument
  bpf: Mark syscall helpers as sleepable
  selftests/bpf: Check syscall helpers in timer callbacks

 kernel/bpf/btf.c                              |  7 ++
 kernel/bpf/syscall.c                          |  2 +
 kernel/bpf/verifier.c                         | 16 +++++
 .../selftests/bpf/progs/raw_tp_null_fail.c    | 53 +++++++++++++++
 .../testing/selftests/bpf/progs/rbtree_fail.c | 29 +++++++++
 .../selftests/bpf/progs/tailcall_callback.c   | 16 +++++
 .../bpf/progs/verifier_async_cb_context.c     | 64 +++++++++++++++++++
 7 files changed, 187 insertions(+)


base-commit: ac0aaef0aa997fcdcb2458bd584539ba8608d33e
-- 
2.53.0

