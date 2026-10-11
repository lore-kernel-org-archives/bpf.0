Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1A3546E4
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737326; cv=none; b=HiEh/M9tSmv3k0WL4hCf4xKYBYY22tIxT7zFtOy8aYLdCe0aosA38hYNZi21QgYjoQPVbtcOBgkaDG1hKk7jaeNWO/cU0S0kvKwNdURJjNUB2ht0xY+w8xx+KvTdPjxCI4XSqOS3mz0eCGSoF3iJZeJEayj/LPCIC9CS1jraWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737326; c=relaxed/simple;
	bh=pa1Q8hukJT6l50xsgI952xw1ZGNVrqQSRnEJnnQY0uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUSq6XXOJ0R01TN6WOi1xRH14LvlTskuGgTlZwXSicwMhDLowDOH2nAaupp2JRRPLMNcHa4fWnPpnGjAefIsIByDSjgUHyolTHYucil3zStdHVrGvldSZEp1TRaEvaN6XhbDpsGDflpPxBiJWvXSjszx32ENjiq3VhTRiYZ2ZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5VJBaTm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5VJBaTm"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a706146559so703362a91.2
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791737319; x=1792342119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rIaFf5jmExysQyyfLDhJshxjyUhE4Y+j287MLmOGtFQ=;
        b=P5VJBaTmvRWJIa7/ss2wxEWQXsjxrD9OIgWMQ7o9pmImudefKo0rRX0LaYuMlLXSUy
         fPNC+OYYHQUXDGKOsLCpw7EPn1vMBpD+JjbCc2ZLXg+BHCbT2Hv0riUlz8e1VyPv6ibN
         SyU2SrgMMxxv5le/quOLCa0uIqgcsP3ZkOhBZK1ZzVIWR0zApOOLMrx0lB97XlJuvWv9
         NOyP7vost4cRvTVLT75iIoJX1ZxWTkyVETth3LFoSw5anXKkjFV28QLgwvRml7xjhusL
         y9r2iCojsV0z3zUcavKgg9WtM/I75Z1eJxriDQco4w0gkmLJy6kQxpTa7Ft2veIBPyNe
         +s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791737319; x=1792342119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rIaFf5jmExysQyyfLDhJshxjyUhE4Y+j287MLmOGtFQ=;
        b=qkbKEke5BZqEH+hYdrWW14YCITVdzEUFQaPoQ3JpQwWETBwL8dRLufW5OEy3VbPTfw
         /aA5OE+WgwRRsf1mMdXKAEV3tY+DBmBTf+UwQpNPZCRmDwO6sQM45cy16Wuah8JYxume
         nZvx0Ij0ZlXII0P6I4kT3sUWfDM3gb0h1OqXZ+gCFrTWeL3M4q+De2nGOETMEJzZqCnk
         nSy6duPePjdsv9mydmp6T0IaHbKwBnH6FH0ugeebIbujOTJq46CrX+88TSy3Jp7xaQ0y
         AgEgr3paWdamPMMlP5OlYFJE41qdHMpoDTdlrPzS5LeQnDFOXSwTy7I5QImraehRBQIH
         pg3Q==
X-Gm-Message-State: AFq9FYJCt9lnKiGN0wV1mmRGYlu4s0Ln5uz5lDX5JkbiDRw0B4SPchEb
	9KuxbpnPVIVximE99YsFuR0ImZARXOcqt0E2HzYebIFzFS+Z6e4Zybs3QKIGd42atqs=
X-Gm-Gg: AYBFou2nmc8F1asdwJ5+H2LS5V357f1TfhphEa5F3xYtyjZ1mrrhgNczbXy7qSD57fe
	GYbhFm2C28/jg3pyxDMOTxVJE/71LuPbH1Xm9LydN1a6vUyVeTZXQj6sPmLrM3LzozdAQzSECQ2
	YWKC6qr4oeAqZpE5BvCXBUrrEirsUpqdrFLFsTk9Q8WbtyUWTnr1WxoHNiTwZPqfmgvGrps7DAe
	t5NoeEgYJdtzTRkSaodw15EmtsmVbTgBduqYy7Q2Efh77YmmoUl9BU4P0vZAIGhiimZDywISkcB
	druKOrVcYtIQejvfG0X6XOP6Vn8N/7205Kx3PCew/59loOz7n/saoN2WpYtDSerGRv5Oa4Wvd+T
	Et8lS/Nl+6V2xU2wJ4jbd2FZMMB9iFYeY70ZC3eQ/gHYkuj/GPAB3ZhIt87Y0HsQY8mZwg6ur+g
	oD8nwDuaHSMElyP2pBr02a+Ov2y3BH4ATYmbKT0VTN7vxJ19YDs7hB8tJbPSlfnHruMeUH3aCKZ
	myAELydoqW8iXLsmBolxWc4hZ5oV5R8dxp/nCJ49N2R/lb1I2n99MCpsykrQkbdcdp4acjGDqQm
	c41ZdpVdfOLRDpe520pzIWWqJRVnLCgmMLrw9QiQUGY=
X-Received: by 2002:a17:90b:4b92:b0:3a6:f1d2:57f6 with SMTP id 98e67ed59e1d1-3ab3ac9c394mr6202724a91.57.1791737318778;
        Sun, 11 Oct 2026 09:48:38 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f48bfbsm13172678a91.9.2026.10.11.09.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 09:48:38 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/2] bpf: Reject BTF ids with the same address in tracing_multi link
Date: Sun, 11 Oct 2026 16:48:34 +0000
Message-ID: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

tracing_multi link accepts different BTF ids that resolve to the same
address. The attach succeeds, the detach fails in ftrace and the kernel
crashes in freed trampoline images.
'test_progs -t tracing_multi' hits it when the kernel is built with
CONFIG_DEBUG_INFO_BTF_INLINE. Without it the ids of aliased functions do
the same.

Patch 1 - the fix.
Patch 2 - selftest.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (2):
  bpf: Reject BTF ids with the same address in tracing_multi link
  selftests/bpf: Test tracing_multi link with BTF ids of the same
    address

 include/linux/ftrace.h                        |  1 +
 kernel/bpf/trampoline.c                       |  8 ++
 kernel/trace/trace.h                          |  3 -
 .../selftests/bpf/prog_tests/tracing_multi.c  | 99 +++++++++++++++++++
 4 files changed, 108 insertions(+), 3 deletions(-)

-- 
2.55.0

