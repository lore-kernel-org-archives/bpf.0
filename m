Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0B3B8BDB
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591626; cv=none; b=mAv7Q8q0YvF9Tb/jer/5kyGRG0TWEfLTSEigfb1M75y19Gu4MU79QWB+Pf4fJAOFDaKoeAmyOVtqP+6kg3kftRBkwdU0UbgVAlZeonN2rrk0sbqVYgB6PtNn0Ek+2KdHaZHGp7vczBT2IykM6UTvGCM/veQxecaNNqmCNVhXl3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591626; c=relaxed/simple;
	bh=Fbg+q53eaIdWc70RpBnXyMHBUpNIW6oY+j96Qo8cGwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgwm0eoOBRK/K4+DIH1UrD68HYZDUyGw1tLiMd8bsOX3tGdGmhiqciabrEUOHpbzUHAdAerOi5Mm5/EFzH+KYxr2Exc7txvsocueRNgO9+qESAUusAYIUpP4ZiSAjz5W2oWU/sgN8K2/OFlUfTib4KsTn9JKy4SBk586Zs65voo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXiTx/Fg; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXiTx/Fg"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49b0dd21eb8so3837135e9.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 00:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591604; x=1789196404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7QS6wTMFwAv9E4gmpuGdbxC40j+RAB9hJvPkXF2IlIE=;
        b=AXiTx/Fg+wMbI0ExvXFZxtIwQ5kR3LfYwopYEmnlP8W/1p8C/NJSkI2iEd2ZOVqmh2
         CKSkdHzT0koTrBd/cKzGA0/sfEzqvaP4QrXIXLDTd/wqQMnfCnvryU8AogMxmvkK0gpY
         os29LWDnJD1bjUjNLIDuKLnu8FH7z6Wq7uZoJ4XXllEBTdcFsuMcL24hvN/RMqiWmwgO
         tQxQBuje7mpnSsoUUK4I4T7rCxoZi5FgLKO8Z7BolNKrqmCkqrleWgv++HbJudI2wKpe
         j7dqzTrkIXcdrUXPq0HZxD71CXj7DWpV65+dfJJOtndoZMHbsRB0DArv5uVT2JaCMmLM
         cViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591604; x=1789196404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7QS6wTMFwAv9E4gmpuGdbxC40j+RAB9hJvPkXF2IlIE=;
        b=ehIKa2so0N6/4iRb0SVNdM6LORvL9Kf0jnD2TmBKdM6CpiM0DmqSr2/q5fu8ZmPV3E
         jpWREkaradaZyRt7XwxXm2AajiolnLeuKCtcpQPYSt44zgK+e55QKmoYrs3XYLUMF3RR
         uAT2P6N4ZbEsU4iErAmCgsi+ojYatL7MKlFEBCXlH6H3o3TAmSzvlukj08kNuYrbTU4l
         XB5FFoXctfqs4ha0Fh79MUoUdlifVirb+RYTf6laSH+nAhVfA153URTjF91hFXqZPO5L
         vl49+OZOCbS/sg1kf/9BdFWtxjqKqv7FVi0khl98Wcli+18DIYn82swKq/4BWLtVd/E3
         lnog==
X-Gm-Message-State: AFuF++lflCLPTsXFo6V2ccIbpMiFflzcRSXCrCH+8ycvR9luPp2D7HnB
	UO2Le1GS+UoF9/WHj52SGnQe3U5sOfIvooKurC0AnVOz/vFwVabvNZL3vYFb7vqD
X-Gm-Gg: AYBFou3CBtN9mLlVDnJb94YD9wmcNY8DBJo5PQ4a+9xeIL59tp+MQ7ipP/WCyZKBOqL
	Rbjgo7NTPuNnVioUB4uYSpSq9svyNveH35GU1WvQKVbP5zLJitrJuMw6KqG7Y+EhMETRyEY/Euk
	v361gcZEoktU+M1yX2gkJ4hrd7kd3NhF99a8J+/KEilUvk/mv9PFDpmPz2WPHKY+ddn1Y1LnGDb
	TLNeJojxJfYYZBqI3Hr5mXougkaTb/Xww8hngHQPoAkjB2/IdjM6UoikdhakMHYKDcpdr8VMhfc
	gawnmkNLP5a2fPOq6ejXYRaWl+RUBhGsgOL1vftbuGJA4lifPoL3gmtzFcWb1zPO+Fd7ovPrjMs
	yVRj3H1Bt0yfJmjggn7Pddbph+YgndVcgQBAgEAveb6B4KuW9oA40VHkNHVKOMy7wRQdL9SkdWX
	a23KXquqZLGYjZBKxLy+Xc2105ihpNHBO5g3EiYU3yjB7sbyMJNRJpD4Xa2WQwrLR64K7aICNqI
	6qmXItQzE68yvOoRFayKV4VBnYEi7nbywS5UnuXzpYN2Sg4/rUZzHB0ExRJHqnxt5SDNFxJSIGT
	721DOKOkucYO5miZxGuxaGi2Cc82me/CcEegGA==
X-Received: by 2002:a05:600d:650c:20b0:49c:fc6c:be08 with SMTP id 5b1f17b1804b1-49cfc6cc026mr63224525e9.31.1788591604385;
        Sat, 05 Sep 2026 00:00:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6023d6sm209050945e9.8.2026.09.05.00.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 00:00:03 -0700 (PDT)
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
Subject: [PATCH bpf v1 0/8] Misc bug fixes - part 5
Date: Sat,  5 Sep 2026 08:59:51 +0200
Message-ID: <20260905070003.3193366-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=memxor@gmail.com; h=from:subject; bh=Fbg+q53eaIdWc70RpBnXyMHBUpNIW6oY+j96Qo8cGwc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv23qW1gkZi/6aJxTj875x5+aNLwZW7KVuXaEVYnRNUc 9Fc/vhERykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZy5iMjwyn7pnfTw6bYqT96 +dO1+L6ydbV7l1R4Qkudn/iFy5ELNzP84TcNyDp48vFMFr+EFa4XouN57simBet/f5jeIb3wTt4 xbgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A set of miscellaneous fixes for bugs reported by Nicholas. See commit
logs for details.

Kumar Kartikeya Dwivedi (8):
  bpf: Make post-verification instruction rewrites killable
  selftests/bpf: Test killing a loader during instruction rewrites
  bpf: Preserve packet pointer class displacement in regsafe()
  selftests/bpf: Test packet pointer class displacement pruning
  bpf: Reject fall-through across subprogram boundaries
  selftests/bpf: Test poisoned subprogram terminator
  bpf: Assign lock identity to callback map values
  selftests/bpf: Check callback map value lock identity

 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/cfg.c                              |  21 +++
 kernel/bpf/fixups.c                           |  21 ++-
 kernel/bpf/states.c                           |  42 +++++-
 kernel/bpf/verifier.c                         |  14 ++
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 113 +++++++++++++++
 .../bpf/prog_tests/prog_load_signal.c         | 131 ++++++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_callback_lock.c        |  73 ++++++++++
 .../progs/verifier_xdp_direct_packet_access.c |  44 ++++++
 10 files changed, 460 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_load_signal.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callback_lock.c


base-commit: b75a000f2ac15f4778ddd6d9298d60b24ad776fa
-- 
2.53.0

