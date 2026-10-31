Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793423164;
	b=WJ95tAzvDk6ZaDwjL+d8vZdda/jwY8leV3xKr4KolZ0VSG8TTCt51VSdkQII5nC8fPhc
	 nnE5R/FEr3j6uv5Uiiv6vBdpgozyxhYbinaD3MOpQWAoPQ7usy2u7IORCAG0qwyGe3lkw
	 kkdV7LNGNMLBj45leunIr+bKyc1W9fORVPxvQMV217yps7Kae50hB0cZk95QBTs5Sxpqs
	 XWFlchboX3JGTw3ZAYkYOCSUfKD6GY4mrt5yjYRXseX5hYnjIhfe+BXbj26lBz+w4vdPl
	 alI/SNRnIprVDaYguNNMCMt2QhODHxODoeKE8S5GcAkFiSKihdaBHB3+y+zMNqkZHEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793423164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kTKBYvwZdZogZAp51Ki935REjRct7clR0DFNpXUtTd0=;
	b=ockxsal37P9rfvydw2RXDoxyVsdO36DOTVM4poB0lYERD3IqN4VcGPYshoFHz43fKfdy
	 oFDu031RH7H6Edi/Qo1zE1S2eqov9U/yTYVlz5acYyK8I6Fi3212N4WbaIg30TMpW5s4p
	 TTwmAJT3jShLhSIOCHpWx63CywaXRYZrAmoSJDOyX+TJ7u848NZMBHXp+pM8UX23Q/YWX
	 +bQVwAUZzEHMiQYGFrCAXFy6EZCC6NWfu7LcEOttZbDq6bTQNouqRNkvqJ2JqhI+Uhh20
	 4NkGmdyX/Jdq9Z043vgXx8OAuq/uVuEnd8bWUenVjnIVl1FIbZnIa6hbTr/5l2yEJKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t7lKF4ij;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43930606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 05:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43930606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t7lKF4ij
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so776007a12.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 22:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793423163; x=1794027963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kTKBYvwZdZogZAp51Ki935REjRct7clR0DFNpXUtTd0=;
        b=t7lKF4ijk+LhI2qZLoo+nQdyoHAKrC+AKaGndNC8bjiyKvP11OLUN7NUDtg9tEmOrY
         zxmk6wWPVg+CmHaGP1LiZYgWwrMMneuLiGJRfl2pMVW8/pcAp+qrY06gwiIB4PcvxqvW
         nc026C/DcU2IxfldBxoAXTgsJcrjgcJG31/7u1bARRsH4GIENb2jiiXNDhG/JUcfg3dz
         nNNyaWGnJ1DM04CqMdtNIeoSFp6wgMbaEiQB4gdxT7TVp2RE5zsR/ALn95ddAPOOzKwU
         pyqD5UXFrHJvQZkCNkuA5tAawQdJ6XdG5GhyaM93tko9YilGPf8lPU8FlbwbC7BchRAL
         Cw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793423163; x=1794027963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kTKBYvwZdZogZAp51Ki935REjRct7clR0DFNpXUtTd0=;
        b=ONeufm4mpu5DvElKVrjJcVT7kIeWkNcQLu6ESUqQmx8+TrsDF949vxjmBgQkKAhZap
         URvRf8devDTR831SYumKj/lBboVwJhf+popUiaIXL62PazwdOb9+tac/E21OhDPU7c73
         lJkA4X1S7kLqfkDvqVVXJZUN5OMGTr6wljKd2YwA2+GgXIfKL7PNesQFLfV5jC8oQL5q
         USYN8oaU9eV3LXMhrzt8KS9hXZ0Nq+pIvgrcs5rHA/x+5IQ9nUh7hz8Cd8BkiiJa+CF9
         +/p4wp6/CTW86wKeuqIojI0Xv8oP8V4sXIu3kxETRDLq49VfqCoBYxKvTp8qO41HEtNr
         4jZQ==
X-Gm-Message-State: AFq9FYIkf3MzS5dzNMgDs/Oo1frdLlbPn9XM6bDcdcoMKuv7D9nICvxs
	fJtBJeeStiaWHj9tWeBppSQ66eNvAic+MYz9ZQzM8eSv4tJVsm7VbF74guzxeQ==
X-Gm-Gg: AYBFou2eIWSh5dPhyEFrIrFgVd7XrJBHq5h1orIW0xK9q7dcCoW2hPPYgT077Iqp0zE
	Vr0T5sU1V/n1/w41AAb73ZGPLRPRi8czmd9BAk4ULBbpTsi5uQP9ZLiIZfw3BoKQvyn+Cb7uqJa
	gisJ9yt7nAdsVS0i56GnfQFI75L6gLuBtAW+bga+ploBRmE/BCNJAiboZxchY6mNhJjY5yaXOD+
	r34LfMksjsOggW2A2vfx5OP80z9jBCFI4NjaXbCYMV+z3jOcXXL3mGklDo2g36MxC+I9dGaaSYe
	yjKGN2SN30DgCrEXT7u1qlKdTymddInkoZIz0YgMH6TyLsuxFWgYDZWUk1V/oLBr13ecy0Ys/P3
	fUkBoc6kvGqAd9fbp89VpESO8smzpvOeV1zUrGA/Apg7FENYHRKcSGBzHWz+0U2W70QAykj+4Xc
	eYn7azhWN6BSYqr2PcNUIo0qd1rRAXiqMXA86KOLB9098K1L8pWZ3tlQYAammG84gwqJsQ87CQN
	G/PW+Z+AJfPjbKuyKWpABREbQOKSxKkr0U6glhyd570NO8/mLRRumTXowg0cZ3CvjTngp9ZUq1/
	CfdcFWmTslhlakDUBD7+umu9sFhCSw/euMMj50My9j1N+0HquOKE+3rta7L+/WMU0BRBAd7d8ME
	pzNQguhiq5GmHe4cpy632bnCLNRiXKA9mRn5tj2gvnDJSYu7CRaSM+Ud0UgirFG7pDcfe/NpzmJ
	+F
X-Received: by 2002:a17:90a:c88c:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3ae8977906amr2384481a91.30.1793423163317;
        Fri, 30 Oct 2026 22:06:03 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84580a0esm6165559a91.8.2026.10.30.22.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 22:06:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 0/2] bpf, x86: Fix bpf_throw() in a prog with a private stack
Date: Sat, 31 Oct 2026 05:05:56 +0000
Message-ID: <20261031050558.2410721-1-alexei.starovoitov@gmail.com>
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

On x86-64 a prog whose main prog has a private stack and that calls
bpf_throw() returns to the kernel with wrong callee saved registers. The
kernel crashes. A tracepoint prog or an fentry prog with more than 48 bytes
of stack is sufficient.

Patch 1 is the fix. Patch 2 has the tests. The existing tests of this
combination are loaded, but they never run.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (2):
  bpf, x86: Fix bpf_throw() in a prog with a private stack
  selftests/bpf: Test bpf_throw() in a prog with a private stack

 arch/x86/net/bpf_jit_comp.c                   |  7 +-
 .../bpf/progs/verifier_private_stack.c        | 99 +++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)


base-commit: eaae576c34d7e001767b6845a5950b0b8db3e68a
-- 
2.55.0

