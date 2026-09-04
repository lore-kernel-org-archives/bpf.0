Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245B46DFF6
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518538; cv=none; b=NipE502PqmCy8WoDVlDinw5x3KGyzeCP+sMxLtbgMrrn5AXS5mUKJq6HytT3FdsPjIfU9VaCkso3VepLS22PoBvfv05Eq2P8tg5kx+bmKdWzlzg9HtSsubvUvyxzS6I34fxUiHZD2cYQPIzVDu9d5cOhPPLahLt1UlXso6KfOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518538; c=relaxed/simple;
	bh=PvDOXuMQIL9+Fz4xIXdO36vYcxrBLDTHXZWfXC2yyKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=plNnvsRVgWKL6cL0ln3HC9otOr+kxVaZB+GnVsg3ANZX/RCEt5WlTZxeN4n9SrrFyVwTe5QvupFj3jKH4dwNpP/lhQX03D8HLTlPHwvhEOZa/o9KOexC+xv+7F39Ox3AaoHAPJXFFGUW0lURnsRKCCYozVSP9b5fD0EVrbxblzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEei4i84; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEei4i84"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484372811e5so255608f8f.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518533; x=1789123333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UGlOdWXsvrZLG/8+RL4yDxqQumX6vl1tnB/N7TwWE5M=;
        b=eEei4i84s226qSaWx7fqNIt8JDBP5y527PbgwE/20DYTEEfZ8ut+dJBCAM99FIvbGp
         Sf9JEIOTReI+WDnvkmli+I0tt9sSVQnGVlfwoRUPttzLNfaejdCU6ANUAKxzIaXv7w3n
         DtBeVRxBuH+3N+D/6nwP944V6yfc8Z1xDEXeXWGjWBg1HiVdq0TmoxoOZ63MbDdxx4Zy
         XT45DQgaxft4gh7wsiakQ8yZHNxZmBWZd8kXRrFz5Ep8YcMWYxCaQ+uUsS7UdLYDxfpm
         lVY0G7aR7biL8mNZy/h7yAVF1j9UGNeFnJ3gwutmtZXD1ZMGWLp/8yYkm8/uE8kwQme3
         /t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518533; x=1789123333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UGlOdWXsvrZLG/8+RL4yDxqQumX6vl1tnB/N7TwWE5M=;
        b=hfIZlPWUKQv9q0lkUkrHszZEe4pt5F43t7fWjpHWN0OCAAEgaJ3lYP2XjoTgYodVTP
         17EXTcb0bp1Py1nYqvPOhGsAMaFF1KmF0+6sxDh0twkd+hj3J08RmknTPTvYco4GjH+d
         /XUe8eY9xXUygk69IHyd5a2PqWaktCmdLILGVKo2j7B0d7zhrgddYzJ4qCoVWray/4xl
         QyHeNCWTdsyOU3qh7ksTbr+a+JzNu+oNCFKYu7Id8w8NIpbzw6+f/JzBfc1IgfZLsKvB
         rOqVEsQwW3uuPcI7pFMwf68Wj+0TvrgdtMxu2q3++COt51/KsfD+KOxoO+lUcCniiYGM
         nHXA==
X-Gm-Message-State: AFuF++ksaoRDLgO7ScL0LgalkwrJSyETzZ2PhBAPjhEaQtUOLlnQ/80+
	4bml/p6+kOqmdv4d1plMIV6TOs/q9+wxX9BmxgYRb/yy6N58duxdthdtXHaQq7HL
X-Gm-Gg: AYBFou0cGUOesEQx4GtaU1X3y4WZ6b2w5AQjZV1e3yGmipH1UDC8XrdDigppAIJ9gZC
	Hm2AzxT93vSC/kuaSgwxxnmtqEXWeeu0KewAtzMHkNqfuFnncoXfW0dkEe7GnJVnznr12i3H2Yc
	lbWSI18NErVJ1BlZ+DhzLQ416lwMGYlt/JZoSbBjLTGfVjw1Nm8yDNkOc1oMknJ7HXLSWvywCaD
	v77V+P3MxyKeM7zrraJziZ8hIstxBm/L/LDn5d+XtQ8ZrVRdynOZndT7RlThVCnNrMZMD4PloSw
	yi90Eipw21kfJNUlvfGhywOIbWf5TBPwFfj4OJo7sCe46SjtsHUn/d8fl4Fy4m4L2BFaO/Zw8xv
	C2DO5LEmN9bU+G9aCWvVKzKwU6Pzxtwh3v6nAGZKAKRt0NIGy7oFXNpdcC/v4WhwAAw4GDrFhLi
	Shb1dTSTpqe89NWKYonDha1YOsirbtQD8LA045UcUd7eHMwoy2r0y771ac291bYCKsCqrLgdylV
	ALV3pxV9dM8RYO4TljIUQHo0ptmHTbYyii4OTdBlizJ3UeJ4YZ6gzn8//v3aCqyb6ODpm/c6I6y
	pR0oeUxmNpLyyZwrQ8uSGbgk98g=
X-Received: by 2002:a05:6000:993:b0:485:847f:fd7d with SMTP id ffacd0b85a97d-485872d5061mr6293406f8f.24.1788518533183;
        Fri, 04 Sep 2026 03:42:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885be1c1sm5329776f8f.32.2026.09.04.03.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:42:12 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 0/8] Misc bug fixes - part 4
Date: Fri,  4 Sep 2026 12:41:51 +0200
Message-ID: <20260904104203.345917-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=memxor@gmail.com; h=from:subject; bh=PvDOXuMQIL9+Fz4xIXdO36vYcxrBLDTHXZWfXC2yyKY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvW/DMs9zIuu+mrB8zpf7TLz/ubKvfDbdOFW3ZLiaQmv pebeP9IRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYy353hf/h+vXcTVh9/9LZt 8+sp+vpx9w+J83wsvRx4y17g/uV0lXeMDL9ZDBZlhyfunvhn/+7pcxeIyMzQZnacEt95d9Lnz7q PK1kA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A set of miscellaneous fixes for bugs reported by Nicholas, and GPT-5.6
when analyzing those fixes, batched together again. See commit logs for
details. Related rhtab fixes from Yuan Chen and Nuoqi Gui have been
folded into the series.

Kumar Kartikeya Dwivedi (5):
  selftests/bpf: Test timer field on recycled rhtab element
  bpf: Mark NULL kptr stores precise
  selftests/bpf: Test imprecise scalar kptr stores
  bpf: Preserve inner map identity in callback frames
  selftests/bpf: Test inner map identities in callbacks

Nuoqi Gui (2):
  bpf: Cancel special fields when recycling rhtab elements
  selftests/bpf: Test rhtab kptr cancellation semantics

Yuan Chen (1):
  bpf: Preserve special fields in recycled rhtab elements

 kernel/bpf/hashtab.c                          |  18 +--
 kernel/bpf/verifier.c                         |  21 ++-
 .../testing/selftests/bpf/prog_tests/rhash.c  |   6 +
 .../selftests/bpf/prog_tests/rhash_timer.c    | 141 ++++++++++++++++++
 .../selftests/bpf/prog_tests/timer_mim.c      |  29 +++-
 .../selftests/bpf/progs/map_kptr_fail.c       |  37 +++++
 tools/testing/selftests/bpf/progs/rhash.c     | 112 ++++++++++++++
 .../testing/selftests/bpf/progs/rhash_timer.c |  98 ++++++++++++
 .../selftests/bpf/progs/timer_mim_reject.c    |  84 ++++++++++-
 9 files changed, 525 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhash_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhash_timer.c


base-commit: 254c881fe0554c5efb16d355c273702a27a32a20
-- 
2.53.0

