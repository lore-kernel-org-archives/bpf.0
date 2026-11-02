Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793598946;
	b=mVHm+y34fvBMs7wfKBmbpi0r/vQFPvTEHoYPBHyLPiFcNX3LfiML5Zobd2S365cOiyBR
	 Gv26CrAw2g12PiYV8eIt7M1yp7dNmO7J9xYSTJRFYJZLLFwIgeudAw+XuE7fzNjrprjS9
	 GyDnN8toT/h9VL8OGoBogUeZdIhN3ihvxxUDV9CikcX3STcKRUKlPxYF12yv8okcLjxnR
	 LVItSXIeJvQM3hU6ZhtqD6IbP/5yxQ29vGXEVIkKPnM/VIdvMtIDyKmH1spIicobJzo87
	 DpsXjR7xr1ZiPrK+Iv5qmRK4xOytnPTogzs6XhDe0lLOn88iIuYAemG4vBnby/gROaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793598946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TQVGDJ7DbU54rgq1tI+uCAfdrRSrsAKVN4CLgr24J1s=;
	b=uXw+VDCKaJn2KcFT9ziSy840kavXHJXe8mXhG/JUQ8lCsy+NXUTQkecu/UbBkE4i1czy
	 N4YvT5WamlpCIF3A5kIYqHRzq81x/wQFXuaCMxC/yrsns59Hs3xKe4ZuzeQSWEP+9fxcU
	 yM/LPZYK0A48/ufk84xL86ZuiqyWwnQqVE6mhuzJArZf8iJnNPRQ5kTughl1/FEQZX9iz
	 jHn38sWpZyOZz2Kg3zemvTdzM45gHCKmqMe7murzS5unXo2J/Q9Rqz1S5WjyWWPsmoiZU
	 5ilLmahIiOq6GXmhIsGol8gFfEyi/joI3nofhnqo31CasiZ9zv/cDAI1oDTWE0SXepQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A6zYjceb;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD8606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 05:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5BD8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A6zYjceb
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae486f8a27so1444208a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 21:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793598945; x=1794203745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TQVGDJ7DbU54rgq1tI+uCAfdrRSrsAKVN4CLgr24J1s=;
        b=A6zYjceb+1Bn2eNSgSyCo12VQSq5YDNsfVWRxfz3UGPvBTs+04Hn9H3gfLNoJZgzz5
         he8fNWQpM8gTv3gEsqis6xgmOaisSNZYuESgW9DVQBQEj5ZiKT1e1Klz/Nb/Ib43d7uP
         01saqdGxdjOzzdoidrrSm9U1xa2/YQMlRiwv0h8QKzJQyhifLL5iuGL1r0AUKdue1AWF
         F2h+zHK2pHSZJiGaPkpLPYanfToRv1gDFAyxKURs5F0PURgv9ubhswSvCeLguiJqvH6M
         USe2IgILJG1N+D88pebMAyS6kpNavVfXovbszCdpZee0k+wKa/pyWl7r/0jeTqkjdHL+
         YcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793598945; x=1794203745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TQVGDJ7DbU54rgq1tI+uCAfdrRSrsAKVN4CLgr24J1s=;
        b=ZGaZWxcQ8MoI2c6WomzVsXYwaWznUKwi+pphKAHaTEdi26ZqLzFkbkhh/SSCLvgsIo
         /MDBfXxvKfodf4B7VyL1WfmveUa52TPfgJHkTv/te0G+KDD1B+6jGP1v9eJ3fsHRqCAu
         CbHyJaWBFDdZ84B0rp0j0XiITPVZkQ5tR6NA+Z3s1pz7SiDhRghCFj+H41p3jjfEWz7x
         2zL/MftRyD3DQF0YkKbNCB8kk+NRw6OrRA8kSdzVPwb5+K2qPIIoStxnXBVDEm8YkRWg
         lqMqMFLymTHI/TCPjA6/wh1cGjhIFr0viblaRVJ+2Iu8rNwKUMrxR5vQ2DeoxPzxCUOW
         VuSg==
X-Gm-Message-State: APuU4Z99M4fVLYNTuD3KH+SnjcgtJgRRr3Sh7YUfnt+0P4h7L5l/yOh+
	W5gHMrSq2WbReiLExbYCr4bq9mUSk8wzegIbsvJwMN2+YwYTT90LeCYEsoS//w==
X-Gm-Gg: AYBFou2QPNV511M07K+e5A1SYluyvfImmv9nBzCZO+dUYleY7XG37IRVG8TyXwE5AKZ
	EhyoVl0A9HyRh/pVUa3RNkSmeHiGRH71LX7LuBTRagXg2sAwOoz9+96Gw43XahRHxvWTwMbIf7r
	ZfsGZJ4Yi3FhqpgMD59OphXxDmndlkuaoFAquBeHUDWghZZ4/fRL/GMXI7ie//c/9k4phxswcih
	BFVNvohPkR319mVsiRp48c8UlRWmwnKsPHuHo5C3gMahDRdVrJ42BnO+IOgvm6dTIA9fINkzKWr
	3Ur5Rok26QdrtwS6E+Q6u+/3+qqIHvL4xHWxeLlbDdH796vTGLHAAdyYGkrVI62K+zOivm326vd
	bMUVHEVJ8ILVqY8n98goKdQC+RvBlhLeXt8V2XVcJ/dRhtl5VkDSuIWLjEYn7ArDOtmepUSk6q5
	79vx/JRGifWyVL5OxV9hzAOj+w7ODWN6rZg551kDI4ZfjphozBAxY6Emwlgk1uQVonocK7AWMeh
	iqPR1fOrEmATj4T9NXNY7PmKJxMMFnb5RZIa7EpWAtICYDgHP01rSiQXsQcaxL+jW3w6aM9LmTu
	UyjD/lKFC7dm6bixsEmWMsaheNkeKSjnYaShJE6o0N5ElZlupGIrpqLGoV1RU0RSkvuBVTW0ZEt
	C48bv94/9itkxzBbVTEXxr0XZ/74+s0xweBfmXVtu+MHZx0Go8ImZqcbfSAPNGh2o5bBFsTUyts
	k=
X-Received: by 2002:a17:90b:1b12:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-3ae896f51e5mr8063296a91.14.1793598944959;
        Sun, 01 Nov 2026 21:55:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm16754654a91.15.2026.11.01.21.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:55:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 0/2] bpf: Fix the stack buffer that bpf_dynptr_slice_rdwr() returns
Date: Mon,  2 Nov 2026 05:55:41 +0000
Message-ID: <20261102055543.3584718-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_dynptr_slice_rdwr() can return its buffer. When the buffer is on the
stack, the prog has two pointers to the same stack slot, and the verifier
knows only one of them. A store through the slice changes data that the
verifier tracks in the slot: a known scalar, a spilled pointer, a dynptr,
an iterator. Such a prog loads today and can crash the kernel.

Patch 1 invalidates the slice when the prog stores to the buffer, or when
the frame of the buffer returns. Patch 2 has the tests.

The selftests that pass a stack buffer to the kfunc only read the buffer
after the call. They load as before, with the same number of processed
insns. Cilium and sched-ext/scx do not use the kfunc. test_progs and
test_verifier have no new failure.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (2):
  bpf: Invalidate a dynptr slice when its stack buffer is written
  selftests/bpf: Test writes to the buffer of bpf_dynptr_slice_rdwr()

 include/linux/bpf_verifier.h                  |  17 ++
 kernel/bpf/diagnostics.c                      |   6 +-
 kernel/bpf/diagnostics.h                      |   1 +
 kernel/bpf/helpers.c                          |   6 +
 kernel/bpf/log.c                              |   2 +
 kernel/bpf/scev.c                             |   6 +-
 kernel/bpf/verifier.c                         |  64 ++++-
 .../testing/selftests/bpf/prog_tests/dynptr.c |   1 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 258 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  38 +++
 10 files changed, 394 insertions(+), 5 deletions(-)


base-commit: 714b7112017fc7f8b2afabccf562acdb12d2ea7d
-- 
2.55.0

