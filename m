Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE0280A5C
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855931; cv=none; b=cgppef0uxUHIQ4uh7r+kWqZaO/YzX5n3uJQW0mIQj2XYJ5MTJrx6PlGc9eXZe1+w2w32z390if82/7FL2wpsd+cT23WkedTtqbbUmA6HY5GPoYI7Bxw1iV3LqU/g/XbrcaLx+ExcjjNgEFuhMZxR40XNBzllvRWon0lcRD3h3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855931; c=relaxed/simple;
	bh=vPI0v9tLP4dA2zjPWRAwXIWEaY1tBckw+Sxflgn6aCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ikyi60qmPU6fdsoSqplfS/oM1W2j8lfc85ynCNl2jvTApQn/pAIUf9HZI6p8Io9oi3TZr7ETSyTJQkAcOKkCIy19kXuL1UfguMemDWOiivD0Uci5Ox0lxjRI2nu46r4uurtB9ogPdE2bN+IPpbuNxWnmFn4Rhn8R8x1VLfrAJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTNQsHq8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTNQsHq8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483487335c2so40376915e9.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855928; x=1772460728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAuNkcDjgRQes9ZoBfKfcmFmP/VU8bCoDmQ6evxgyE0=;
        b=OTNQsHq8oDtgsYTKRvYADaAalqpsLc8fvFVBwhlaFoHP1tCyfDU+7IyrvZhM2rH3Qo
         8Opb07ZQwP1CkGcM91EPU0keJ20IdyEJhIcQsllrJZa8JWhlpf0b4an17dTmil6afU0N
         TtSVVh3fE69IDU9ZlvvHKj7JSaYt5BsBwmiMNVfqAmoJI3/vZCcSiQNQ5BKtjb8A/ndJ
         Rv8SvJelXINx9M6dR7nrb+sGVzDMlbNHHGNF6z8IyJoaD9vGf/kGtomPJ7B066zEhZv+
         nBAn8EXW/0pHgADxlnIDO2FSc5Kx7PD//5fKPdRTWj1T9wCTlM9M5H2uu3+UxANpOb4K
         TYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855928; x=1772460728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAuNkcDjgRQes9ZoBfKfcmFmP/VU8bCoDmQ6evxgyE0=;
        b=eVjv1QK62onFtbLa7FOP4edfEKEbt3gWMYNx8Gw5W6AZNs2oSioNcDc0zl3PjAh6Pz
         s6724x4EBZhTL821wFIU9kYH6A77bxyfkyLLjrhqieeTJTgVXYvfuUt8xfynqlsTSXY6
         IaaKsU69iE6AFUjbWOG8FH+Sbo9BeubYoCJBCBpfteC6EufwZRrl6y59UXSe6k3Ylv1z
         vn9+D6SLyMBfcrjmLSYy9Wgwfs8f+IBaQQTpcq95YhH/P488U0lLU+bRpRd5Yf8Cs4M7
         LLaFove8MRKgHREVed6o+opNFHSyMQq+wGmFCGeKCrdgTcX13XqXhs2AxDAnsad7p4Gz
         EhPg==
X-Forwarded-Encrypted: i=1; AJvYcCVmslNVx3Ws1wpDQutH33KIeSsnwJdvMNb3/Cg3Ntd9E+xRa8Pwz6TI8gQ2PtPE5gUZd9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzdZEI09RPPv3WnbBsqI8jhW5ZbiC+RIqJAISmkL+F0FuxoQNn
	OXJrpFBxaQHOdGuJIVVAB3JdmZOoRHdOuSWQ+iYVMI+Tg71I3SlspbZaUo+10w==
X-Gm-Gg: AZuq6aJ6pD+Sq0ngQDGTnNtr1+W3s5i2Al5XJt2le0CDD/BrocCXd0gRqEiN13B8pzU
	vYTyF/YKkQqYI+nD/rEBXGSy1xo8YcUGJqJL5V9JsoiAd1KWLjXuBOdIOKd4d1bdcGUVcVMN6Fw
	TMzIVrk1EbiXLwvE4SgBmRsu1hi0ZGk+0V32vopuEK61w6PB5tZevdHggNmENJUEceovPUhLPjz
	KUTR1ilpEM3tqyzkY0aM+EHjDmFhREUhWK9COP2RW7Iulm21OZ7imhRVu2oqdosp942OlGrY8nM
	jEKE9h4iEz8Jk7OdUBaMpyH1CB3msRwpy5uiSu4gGeSXNjdDMK0LVlPEONWz8QYtWPdTbypXPnW
	q+IgF7xojASdCr/m6i8jtjRLVdkUqhiR22lVG5mq3VLKJuT4G4C0PbL2ET9nFiCSpBKC6eZkeZF
	mCAyRV7xoHoCc0Z42V86ZWct1nN8lUx+wq1BMR8g4GQyJuuR9SHiOzas7OWI8ROAkZffJA44CAh
	DFaHXlAsg==
X-Received: by 2002:a05:600c:810a:b0:480:1e9e:f9c with SMTP id 5b1f17b1804b1-483a95bda25mr141490985e9.10.1771855928356;
        Mon, 23 Feb 2026 06:12:08 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm247077275e9.5.2026.02.23.06.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:12:07 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH 0/3] extra io_uring BPF examples
Date: Mon, 23 Feb 2026 14:11:59 +0000
Message-ID: <cover.1771850496.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NOT FOR INCLUSION

Alexei asked for extra more realistic examples. This this series is
based on top of v9 of the io_uring BPF series and implemented as
selftests. There could be more, but I stopped with 3 that should
give an idea how it'll be used:

1. A QD=1 file copy program that show cases state machine handling.

2. A BPF program rate-limiting the number of inflight io_uring request.
   That's a good example of what users asked for before but seemed to
   be too niche to be plumbed into the main io_uring path.

3. A toy example of how BPF can interact with registered buffers.

Pavel Begunkov (3):
  io_uring/selftests: add BPF'ed cp example
  io_uring/selftests: add rate limiter BPF program
  io_uring/selftests: add regbuf xor example

 io_uring/bpf-ops.c                            |  29 +++
 tools/testing/selftests/io_uring/Makefile     |   2 +-
 .../testing/selftests/io_uring/common-defs.h  |  27 +++
 tools/testing/selftests/io_uring/cp.bpf.c     | 134 ++++++++++++++
 tools/testing/selftests/io_uring/cp.c         | 130 +++++++++++++
 tools/testing/selftests/io_uring/helpers.h    |  15 +-
 .../selftests/io_uring/rate_limiter.bpf.c     |  84 +++++++++
 .../testing/selftests/io_uring/rate_limiter.c | 172 ++++++++++++++++++
 tools/testing/selftests/io_uring/xor.bpf.c    |  31 ++++
 tools/testing/selftests/io_uring/xor.c        |  83 +++++++++
 10 files changed, 702 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/io_uring/cp.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/cp.c
 create mode 100644 tools/testing/selftests/io_uring/rate_limiter.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/rate_limiter.c
 create mode 100644 tools/testing/selftests/io_uring/xor.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/xor.c

-- 
2.52.0

