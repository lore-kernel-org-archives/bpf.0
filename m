Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB937C0FC
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874492; cv=none; b=rNSCM49geSO4CesDB47llVZ6TBu+qxsaPcvPy8IZahNnyVQf+v1r9qXXkMTJ/l4faRnaMdUAYgql1xCCaQ3neDC+6qsnqrjkFS+C893Bl6UuHVydob1wMNh/c65/0flUQ2nImh2ybvLls50217rBZE3+wi8TUzRtcJ+gLJYx8nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874492; c=relaxed/simple;
	bh=YQTSnBKXSZ6DXmMJfmTI8kl5fiE+zcKdBcwFS7x8CUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MXCYsUVDvh4UxwjK9GBUZynSFN8nul+cjzVKAK5RJmTESHidwHN3E+saOgZjh1t7sfvs6+HEzuDorwF4sZyamiHh87K9bXshNho+c2PQwMFaLuI2rsDcMO9xJWGbOnuiRQoupmk97jpngUcZznaYUM0Ki9YUPS9XgGkZ+9M2NJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyZIE+G6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyZIE+G6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so1607665e9.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778874478; x=1779479278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cuBiYanhPSZBjczVVrC3iA2zrRkOY+30jLwNONrxrkY=;
        b=VyZIE+G6fLnoAz0wHrGaFGvWYJ7XAVr/rcPyS2BblOtCXeujJd6SxyE6q4ymZwaYAC
         t+ZLCC7svN1A666OScZtJUD33UsqvMc1PPWedmlvNR0CTRgPaLc+UYWC68SpgJmPL4Iy
         ggFIhMns1/o4f8OMM3WN7lkFWAWVoYcCTqp8pnBhEuS420k4Q8JtbY8t7FChhw13Do5h
         Bqvn1xwZf05ZAvAdcAcV25TCpS2IppYWS6gNwvipCuqgctDFtuvkWC6YzzJWOwAu8509
         kiTc8OSt8MTY7I0UiZwo3O91JfzrGeiHFz/mn1MxL2RftCleNbyX76uTmkoxj6kkN3Ay
         P7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778874478; x=1779479278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuBiYanhPSZBjczVVrC3iA2zrRkOY+30jLwNONrxrkY=;
        b=Bmo3kOmXpNUohDYTrnTZW1NHjxUiH14ev7OYR9YCIkIsJIGkshW1Jw0uXBgfWgcZOb
         CcVM8rOH0mGEiikqqMpd4UesIOPb38K2MlVtIV62TcfOp/LqiJq3QK9DBhq46oS9sBiI
         FL9KpwpWjN97oEt3Nunt7wac171XTqcmRQsu2mc/Y/VU8FjRoZj3RN0G3TIchMJQoQHV
         wE7RqNkb2OMtWnVWiabFi08Wybs8jYgeDde8KZ5CnBAK/vpz3RGrQ8JgwSXhSQ2alRj0
         eqQXXQT7VuKS0bZKxOYjwSJEwtF1ADYhYBK1CbuxQgg2VysxxM5BGgVfoQhJSAITPau/
         TZ4Q==
X-Gm-Message-State: AOJu0YxvwB5VaBw0B8q2gEPv45ppnmNecNRviVwO7ZHAXKaJgC7v7kWt
	r0VeGmx+TK3UZVVhZrCjX2Tzxoo9PCLp71rTKINoS4cb/Oae7XoZVzZ2npZ6HD8n
X-Gm-Gg: Acq92OFU1KkmZwEe5oI3pGXFJDat8jYqD4npt4nri9JlmNEehMomgw+J4F3vP/66iCY
	mNjWDbIJh0OhkQUDMb5ha5RFtLcP6ikvg90Xb6fFk0Alo8XhqlZLveqqm/vtkLl6R9/08LGlo/Q
	/fvnB8KomABk9KQouoH1ci7kcfTT7BPZf4Y/hHmexelnI8XYsn2pgeg+6x61L3N9JoPtIo0z3M7
	LVRa3NLfpnqNAU8+lzoFVSfIElPUw1GdAeRF64vaa522s8l7vOLVvBcbELXEoNQFVwnXBpbAkAE
	bkNGyVWdWMuF9ihNh5dnMOoVfSdKY17/yn9NGSEvbUlmdDTc3Zu21ZdLv7+suIGfZGyWo3hIvWs
	XYzw8WhqMnJA4AH9Q9OMR2RnIQkZTgx3EF63H3RLdMswloNIyLxLECeN+1bE8UnRiofF3kNoMGN
	+hurt0fRtZMMAbDIzrl9SgArsD7CI=
X-Received: by 2002:a05:600c:3104:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-48fe651b57fmr71443215e9.27.1778874478278;
        Fri, 15 May 2026 12:47:58 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm77509945e9.2.2026.05.15.12.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 12:47:57 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v5 0/4] bpf: add icmp_send kfunc
Date: Fri, 15 May 2026 19:47:42 +0000
Message-Id: <20260515194746.50920-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v5 of adding the icmp_send kfunc, as suggested during LSF/MM/BPF
2025[^1]. The goal is to allow cgroup_skb programs to actively reject
east-west traffic, similarly to what is possible to do with netfilter
reject target.

The first step to implement this is using ICMP control messages, with
the ICMP_DEST_UNREACH type with various code ICMP_NET_UNREACH,
ICMP_HOST_UNREACH, ICMP_PROT_UNREACH, etc. This is easier to implement
than a TCP RST reply and will already hint the client TCP stack to abort
the connection and not retry extensively.

Note that this is different than the sock_destroy kfunc, that along
calls tcp_abort and thus sends a reset, destroying the underlying
socket.

Caveats of this kfunc design are that a program can call this function N
times, thus send N ICMP unreach control messages and that the program
can return from the BPF filter with pass leading to a potential
confusing situation where the TCP connection was established while the
client received ICMP_DEST_UNREACH messages.

Initially this kfunc was named icmp_send_unreach but now the interface
accepts a type parameter to facilitate future extension to other ICMP
control message types. Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH
are currently supported.

v2 updates:
- fix a build error from a missing function call rename;
- avoid changing return line in bpf_kfunc_init;
- return SK_DROP from the kfunc (similarly to bpf_redirect);
- check the return value in the selftest.

v3 update:
- fix an undefined reference build error.

v4 updates:
- prevent the kfunc to be called recursively and add a test (thanks to
  Martin).
- do not fetch dst route when unnecessary (thanks to Martin).
- extend the test for IPv6 (thanks to Martin).
- use SK_DROP in examples and use non blocking sockets for testing
  (thanks to Martin).
- test when the kfunc returns -EINVAL (thanks to Jordan).
- add the kfunc to bpf_kfunc_set_skb as suggested by Alexei.
- guard the IPv4 parts with IS_ENABLED(CONFIG_INET).
- fix a wrong initial value for client_fd (thanks to Yonghong).
- add documentation to the kfunc.
- to Jordan: I couldn't include <linux/icmp.h> because of redefines from
  <network_helpers.h>.

v5 updates:
- kfunc name is now icmp_send and takes the control message type as
  parameter for future potential extension (daniel)
- drop the net patches to route packet since now the kfunc is limited to
  cgroup_skb and tc progs (daniel & martin)
- linearize skb headers (sashiko)
- zero SKB control block (sashiko)
- bind to port 0 instead of fixed port (sashiko)
- poll to wait for POLLERR event (sashiko)
- do not use ASSERT_EQ in CMSG_NXTHDR loop (sashiko)
- fix comment about byte order (sashiko)
- fix endianness IP address issue (sashiko)
- add forgotten cleanup_cgroup_environment (sashiko)
- let packets pass in recursion test (sashiko)
- clarify evaluation order for recursion test (sashiko)

[^1]: https://lwn.net/Articles/1022034/

Link to v4: https://lore.kernel.org/bpf/20260420105816.72168-1-mahe.tardy@gmail.com/

Mahe Tardy (4):
  bpf: add bpf_icmp_send kfunc
  selftests/bpf: add bpf_icmp_send kfunc tests
  selftests/bpf: add bpf_icmp_send kfunc IPv6 tests
  selftests/bpf: add bpf_icmp_send recursion test

 net/core/filter.c                             | 103 +++++++++
 .../bpf/prog_tests/icmp_send_kfunc.c          | 215 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c |  99 ++++++++
 3 files changed, 417 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c

--
2.34.1

