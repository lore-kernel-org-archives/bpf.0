Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F501365A08
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774197997; cv=none; b=LfCmz3vIk++T48DNJO3hUlh6o+es+af+YY3gqW4De5iMx+AKfwoSGkTwXWr43qKt7htd9bjQKvIiAf/GE3zNvRCwytF5IFW1NxxuaAGSUIQP4EUaF/SFQgwuIKMpeYyi6gYeFwh0NVe76XuaBqtHmR55eRI6kB4bgLY8jNMvsg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774197997; c=relaxed/simple;
	bh=heJXcVGbao+l4xu98TgSVGUkyWOmRwmmQFDnmM0vEN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzDZjRWpA+bbhU2HOvCdUpHytrTwnI7BNtpfpULQHjAw829R+VoOt/6sirNE/ydk3NxCBgbdM2Jl5cFljK2m57KxqMnGagzzIYU9dIrRTerkRnC+zKG7tJxci2Ne02Tm0wqeLf89x7xYETg4X+X4nmUUcLMkKIz81ZGVGCo92Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyW5+/cj; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyW5+/cj"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35b98def50bso2456249a91.0
        for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774197996; x=1774802796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JAhWS23yo1BXeCK8GNy0gtQ1Q0zUM2QRvdrgWHtUcys=;
        b=RyW5+/cj4WFzuqQ+xhrKJ2LdDnCAHwthQaV4n4yqRE0+x1/kxKKmhR3F3TnQ6gKjgL
         03VibN3uKAP8DxLT5a3dzizj01Dr/rfv3o+ozosHl/zu6H/U6KBnRy+wbHZUgM1DQanp
         X3EFsbiHyeKeh89Iw7WPw3JrGwZK4+iZ7gcFy/lAzHxAowZ8mP6IqmGbv7i3ljsfmeDe
         qqvaVDOOp86DS2nvvbeX3Yk7leZ6xCd662RWTxrslMkHvwIni3nBKFlxPpk+YPMEviu8
         /yk99oPiY+DTpJstudqw2+VHn6xGnODuyQ9ssLhqI1QCz1BWjUmAAkmserwzH5vR+nJ3
         K8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774197996; x=1774802796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAhWS23yo1BXeCK8GNy0gtQ1Q0zUM2QRvdrgWHtUcys=;
        b=UhKCUtSPyK6f1iumB0ErAN1Pcn1zBaqxLnq0anFvm38GadPWwpHyg3Nf6rsfREFGaQ
         Y/j9u0bkDLn3CVctwcyEFM68O3o/gnwmrWvPWb44yDlkO4fX8iYGiPwv95RY4C3axnzz
         tWI5BDUNbNQHfKstLqBqgwwW3CH5bF8VapIoW24/AZ0hIuEeQDmcU7rGkVa6m3RqIQm/
         vTpl9f9kVaIh2JBHSdVM4XeEIj5Sb/44b63yiaWGDrL3CTxFbjihrjYf9OCTZRvAXjCl
         UpSn81m1U2B0J+LLGsIZ4977l9KBMewko9QTf+V90rMzNOiAFIdneWMIyO9bmDGWzglM
         GQXA==
X-Gm-Message-State: AOJu0YxiGmGD6JILqSHJ50iRdHZdwQ+NUKi6+J2acXDoA3nmJBOu9Frg
	PJJUSHaDpoPQj7Q0eU976yrwHJwWX6+u5bY7muXO8tpZfHT5eBgTp3aGD8sC0A==
X-Gm-Gg: ATEYQzytVJ6sXwqAKhfWOPVFRl2Yrwi4HloeQ0oYj/St1owyn79Nd6GNpTVI0Zmrwya
	rI4CVoJoj2tm4fzs3iHwcHD1EUznK/R6WEP18hX+8EPmAfQhkchqCYtAUpXqHOH//tzwlJa39XG
	cQ5MQu4XYN8FOgl7Pqdi8OasFEdheOyD1bTmaY0ExOqP1+6ZL90HSf8POfurnBPh76FRed5cJDr
	KKuqIF3++//m54JYl7pSJ88mdvGLJgCmEN60+uGGRbusxjni+TtthLP82xzMReOQ4X5wYazKN7t
	kXoHxvm0duzR6pmSRiWOLKt0sgG5tPUdjWo8P2ibQiGu5++W+sIFqSuoMn39wqIY6QKfdufhDvL
	qV8GiuZp7NHQmSltd/ZgfNwvd9keJ2kyw+IvucYLaedILlbWllNMpnNF5UqfdQ6P6bxwVJrN4mx
	OCbX1FT1mMOoqaeenH7CAs12AIQg3jpciv8hDZ3XUqBUu4ywJSyYfQKCfv8WrtZO0wfynQJmdL5
	NJDYtWsExrmfb9VJ/euIIZf7TqlnlVORANko/y/h9E3Uo1wo9Lqsfnqapvxig==
X-Received: by 2002:a17:90b:528b:b0:35b:929f:7e92 with SMTP id 98e67ed59e1d1-35bd2cf802fmr7777971a91.18.1774197995789;
        Sun, 22 Mar 2026 09:46:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a939af0sm5279274a12.16.2026.03.22.09.46.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Mar 2026 09:46:35 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 7.0-rc5
Date: Sun, 22 Mar 2026 09:46:33 -0700
Message-ID: <20260322164633.4165-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 4a04d13576fd69149b91672b5f1dc62eca272fa5:

  selftests/bpf: Add a test cases for sync_linked_regs regarding zext propagation (2026-03-21 13:19:40 -0700)

----------------------------------------------------------------
- Fix how linked registers track zero extension of subregisters
  (Daniel Borkmann)

- Fix unsound scalar fork for OR instructions (Daniel Wade)

- Fix exception exit lock check for subprogs (Ihor Solodrai)

- Fix undefined behavior in interpreter for SDIV/SMOD instructions
  (Jenny Guanni Qu)

- Release module's BTF when module is unloaded (Kumar Kartikeya Dwivedi)

- Fix constant blinding for PROBE_MEM32 instructions (Sachin Kumar)

- Reset register ID for END instructions to prevent incorrect value
  tracking (Yazhou Tang)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (3):
      Merge branch 'bpf-reset-register-id-for-bpf_end-value-tracking'
      Merge branch 'bpf-fix-abs-int_min-undefined-behavior-in-interpreter-sdiv-smod'
      Merge branch 'bpf-fix-unsound-scalar-forking-for-bpf_or'

Daniel Borkmann (2):
      bpf: Fix sync_linked_regs regarding BPF_ADD_CONST32 zext propagation
      selftests/bpf: Add a test cases for sync_linked_regs regarding zext propagation

Daniel Wade (2):
      bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
      selftests/bpf: Add tests for maybe_fork_scalars() OR vs AND handling

Ihor Solodrai (2):
      bpf: Fix exception exit lock checking for subprogs
      selftests/bpf: Add tests for bpf_throw lock leak from subprogs

Jenny Guanni Qu (2):
      bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
      selftests/bpf: Add tests for sdiv32/smod32 with INT_MIN dividend

Kumar Kartikeya Dwivedi (1):
      bpf: Release module BTF IDR before module unload

Paul Chaignon (1):
      selftests/bpf: Fix pkg-config call on static builds

Sachin Kumar (1):
      bpf: Fix constant blinding for PROBE_MEM32 stores

Yazhou Tang (2):
      bpf: Reset register ID for BPF_END value tracking
      selftests/bpf: Add test for BPF_END register ID reset

 kernel/bpf/btf.c                                   |  24 ++++-
 kernel/bpf/core.c                                  |  43 ++++++--
 kernel/bpf/verifier.c                              |  33 +++++--
 tools/testing/selftests/bpf/Makefile               |   2 +-
 .../testing/selftests/bpf/progs/exceptions_fail.c  |  56 ++++++++++-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |  94 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/verifier_bswap.c |  22 +++++
 .../selftests/bpf/progs/verifier_linked_scalars.c  | 108 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  |  58 +++++++++++
 9 files changed, 416 insertions(+), 24 deletions(-)
