Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623029;
	b=tsz9WJ/pU+xW2pJ/6W7s1WiI3FDC1T3wzczA6JN1xjtRmrAhKMjlGNj/iD9bit35XlsI
	 6edcaruTsXN7DAecXdXn0TMgp7HRj2GjU/2efsf5VCdvg1qEMtsm8d+sIBb17jghWYH98
	 hDQXb4GYliaOwxFAspHevHwFw0i5UoZBw71pnB4pqo2mqyUTX2d3ES+/V1sQGuEd2i5D0
	 DP+6yZspKe2+u6Oiz3CLPfOtMnj3VOuvTTxGyLqexLpd5pAVvbCpjBkja+gxqadmpnyl0
	 6LRoyDifDNueu18d2yHTQxkprO6RS0eE8ouCAFGtMD76BtBmvzjpfmMAIYM2ajjbRlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer;
	bh=jiUaz4f9o+mDn4Avtd7lFhAHvXfThjVzdbQTeYRRX+0=;
	b=Y9kIURmS1xhcrDZRQm37iRC8G7AZJ2U4vOAOFcJSD77zNEcOC7as9Kck8MDK3L2FB12V
	 xBWYVBcHpih+MWM31J6PUie9IAgHkzD/gNU7oC9Oa1a8zr9tzIVYeWGPwe8oz0p3cNhvH
	 otTJGpOHQ32uGiHaK3PjVHudC+cEupaONtySAw7dQL3RlkfgvwJ96yAIkQ/d+PRdQSFNT
	 y89ubnz99acsmp5Q35Q4CbGy8ud+Wf/0qe8G136qE2xXbmrkxg0Le1qisAA1QfAQtgKav
	 i6/u8fe3ka7J9UyHr/aj2vGXqpxICLNrbdwtviodPuIhDK09AA5MMpCzsjkPV2p1ByQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UvfS7rY5;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78DC606A335
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E78DC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UvfS7rY5
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so5521611eec.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 04:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623028; x=1794227828; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jiUaz4f9o+mDn4Avtd7lFhAHvXfThjVzdbQTeYRRX+0=;
        b=UvfS7rY5xoMCyzIjp8URThf1WnyL9SRo3oRA9q6a4+i6rBO3La1sR1ZLXpsw16dUtG
         GQ7dv4C25qefwMqVETPIyu7hwbbUxrBICSY+fcT4RF32ADFhrzO6ORqoBa1hZhS8W1zU
         wtp+bb84P5Q4RZPpp/DjQEDrvQiXExSMtaCypR7TzKBcggo+wnXWRyAkBo8CtnJiCvTy
         i0Dk/8C6JkxYz7ND5HvqrJoa0AFFPda7JEw+iggns4Lp1HL+zxX5ZpRZaUDQx/oRgf1j
         zR8lYCMDavas7noWIIgsKpxiGty8ygKH5ygr6B1aBoFkb8cm87pqbArjWSniQm/G//mg
         PQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623028; x=1794227828;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jiUaz4f9o+mDn4Avtd7lFhAHvXfThjVzdbQTeYRRX+0=;
        b=ZbS5rYYqtEcMrDFgYM9NilOxNuBo7mtqGxRlxmfAVA0LVuPYMA34HLCcngVRwtseGp
         azGepxdM6xIZ4CkCiIa51wVB/I44O56N9pUgx9h01ytdyeU/+oFWeiDfk5UQFQexpXA9
         fLFFRiIdCLfT5n5ZC5XkJpzwCDCRYK9XEpYMHCtd8wFekJSSw/G/zwQ/uC6wvcNPDZbb
         u1aTU3kBqK8DaLiX64ihImQwceGElJnJDfc9kJQuqWZOImBis+gO/3V4Rw6Ks6FS+v9k
         1q5kQm+2DJ9z1jW5W5jhs/FYm+CnCL27m7NDqGAYTQQgS/0lgFDGkP9rPFOxJHV0+8Vv
         4xlw==
X-Gm-Message-State: APuU4Z/LqsqHN06jg66FcZEbOteLnLQ2LWT4dVWBKqBB6CFFVU6bNv/c
	Htb1Uuusn/LMDB2Wk2x0ZzYaMl0ByrgklFGs35KES6e1epS1cqjZDCUw
X-Gm-Gg: AYBFou3EL9FtJa6UwfiuIyxXN2L6my+q8KyB5qClyFSWmdlAXdXETSCraFpmikGYZZO
	U7aWEVXrYa1ef25JK8xSu3CpPX5gULvxoVcPyBm47IJJfAG32gbloGU0JbWHHeQFbWJeWiuqFoq
	DKpaG3txL95enu9VwWkX0oqBzn+CCjLsjkPmjSOnJrGgiaPEvSmv8N5IScg3/1cXkn2sJjKCS7Z
	BPpt/K+ZYg6SIklMKhFXE565EAQUnKOEhg+r2pugh8BD0pdHFxJUaOIYwGhPRXZp7LEk4H0MDHM
	r+ZLN9hIk7Y3P4UO4Bo7FglbY0ZLvAB9hyg6uSDDrBGm+5Vfed0MK63Yrt3oQDLOnxsvWJYB52J
	QO00dTJpW5aBz4+RvW4mtr6AptZ/H7yqWD282/GPgiiS5NSfMCyz6SluIWiPQ1kgNLn0NIULbuW
	qe6N2tYpC/e9tblhcYwYZ6A/4uyFLw9iBh6KMJ//PMN6atDE7xdfQMYLUm9c6g/IKoO/fqOJ+G4
	LwQkuDLhHNbgxPHcD3BNnsQrNUWPzJCBzvxtLuyC7aYS3lr5BsqD6ohyFcOUtXZ7GsIe2186oVc
	PBrEy2tw75yJrozkdc/khcbt
X-Received: by 2002:a05:7300:c8c2:b0:36a:117:522a with SMTP id 5a478bee46e88-36a423bf71cmr15537738eec.22.1793623027994;
        Mon, 02 Nov 2026 04:37:07 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm36326095eec.6.2026.11.02.04.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:37:07 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH bpf-next 0/5] bpf: Fix three bugs around constant blinding
 and nop removal
Date: Mon, 02 Nov 2026 07:37:00 -0500
Message-Id: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOyD6GoC/x3LQQqDMBBG4avIrB0wobHoVYqLan51oIwhU4og3
 r3R5ePxHWTIAqO+OijjJyablnB1RdP61gUssTT5xrfONZ7HNPP4EY2sWzKeZYcxHgGdi22YnoE
 KTRn3KPJFl1DsXxrO8w9Md1K1cAAAAA==
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luis Gerhorst <luis.gerhorst@fau.de>, 
 Henriette Herzog <henriette.herzog@rub.de>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Hengqi Chen <hengqi.chen@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

Alexei listed three bugs that were in the tree before the patch list
series [1]. Each patch fixes one, the last two add tests:

  bug                                                  fix   test
  line info stays blinded when the JIT falls back      1     -
  removing a nospec jump as a nop drops its barrier    2     4
  log_true_size misses an error from blinding          3     5

Patch 1 needs a JIT failure behind blinding with
CONFIG_BPF_JIT_ALWAYS_ON=n, which a selftest can't cause, so its log
shows a run with fail-nth instead. Each bug shows up on bpf-next and is
gone with its fix. test_verifier and test_progs show no new failures.

[1] https://lore.kernel.org/bpf/DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com/

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (5):
      bpf: Put the line info back when the JIT falls back after blinding
      bpf: Keep the barrier of a nospec insn when removing nops
      bpf: Finalize the verifier log after the runtime is selected
      selftests/bpf: Cover a nospec jump that becomes a nop
      selftests/bpf: Test log_true_size with an error from blinding

 include/linux/bpf.h                                |  6 +++
 kernel/bpf/core.c                                  | 29 ++++++++++-
 kernel/bpf/fixups.c                                |  3 +-
 kernel/bpf/verifier.c                              | 13 +++--
 .../selftests/bpf/prog_tests/blinding_log.c        | 59 ++++++++++++++++++++++
 .../testing/selftests/bpf/progs/verifier_unpriv.c  | 35 +++++++++++++
 6 files changed, 138 insertions(+), 7 deletions(-)
---
base-commit: cd5bc55288d4fd999595c8f2af6a5408cbe92a52
change-id: 20261102-bpf-blind-nops-fixes-e45e91d65c75

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

