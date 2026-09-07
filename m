Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE40371D01
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756708; cv=none; b=Ue6r4MHTerOM1DADTw281dGMu5roa2T1g8xGdui/BHQC83yyFuCVw5K0//qp3zJlDtWgkvk07e12C9wBp/gYy4E1MW2Uv3jUfv5Ug3m3Y2aULkfH/ToW3pxkNQZFJXZbsJe32IzzYkBUoLUl2NVie1awhXn6vpfOuu2FDEwHew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756708; c=relaxed/simple;
	bh=GYLGPTz7B4DR+c4lAIA8hn1QEzqtbEK6fanc+u3joVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niVBLRPkYkDRWmxRxDyDlUvR7cAh5/D9CB2OFKjld7gZa+3UBXHoew6dMPdocbBftirxni+Q/TtPVsasWLILP4guk2auxvCQd5NgmfcxBvNGhykdvi2GyPzH4VbBZnw/H/jW3CBaKWMtJL245CD9WAGckvBCX1nThJny8Aks9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnRN3Zzx; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnRN3Zzx"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so1992347a12.3
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 21:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756706; x=1789361506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dSkZ75+revt0e4KyfnrpcrTujkH4yPeuqSBvDGGLspk=;
        b=fnRN3Zzx+m/zlZ8cev3X69P2unCU/hKmk9KjTIB3yjMi8U152ulGdkf7hT/RomEYNI
         XuYqllVVPpP67DyqhwAO5tpBTEatOmP/7k5ybHQErlPeSHslie07gjN+XwRst7xjKrtt
         8YFQNXz4EqT0gN7d289pFJ0/TyownBzAv1nJKSsshKAVbPUSed1KJsb/dgFRzqDaSPPL
         OSWkArHfoZK/XeqQnBvR4j8olsKFu9t528W0R/d0+ahTHcfwTqkNVWjamdJ7cMmkLpVz
         q9R4iQ5uYJoAyPcXs58eKuia1X4/81NoH1Kg9HTUOXRa7j21BfB6Phi9wJ1dfFatS0Kp
         N2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756706; x=1789361506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dSkZ75+revt0e4KyfnrpcrTujkH4yPeuqSBvDGGLspk=;
        b=FRPbKhvBRe2ulBQznAnWuY+V8RWxKAEYP8Ej+GiRVuqYtCgNPtoDGzwwltn8jHeEeh
         pr6WTZbVbSgd74j8w44qx6qT99PAm2kNWY1eTmgpRVmVxXsp3JwNdia/hW4TosgruYwY
         y5SkTHw3c+lN7Rk1026KSnD4kkbzOmPCGsRrnGEp7wPJzKZZNr6l8sBoUFigT7Nb3aZU
         iHmsxXCfePCg6znmU0fr3DKWmXrTEy0hLi2lsmCemb5MYtBQBqyvrH1aeO4PphEv213c
         dW+M+n2TLiUoGJwCnuTX60h+2L6/liigcOj3Pr2nU3ZxAMwHiye8svjhSnj8YwGqcDpq
         27CA==
X-Gm-Message-State: AFuF++kBS5eX6Bpn6ZFlSpx8YfkFJW6rE+yBXCEmYiLK235rljHxXEdY
	PfngjW/788zKaLUoUGkyCVxz7fCv+SbaAeJ0VWTSuyaMDIIxL8O4H7fU
X-Gm-Gg: AYBFou0/DGHXE5bD9Ak6v9dpPJivC6sQOPIuoTmDmYgKQ7GVDRLqatbqLQtKOHEe5qA
	O3S6XGSkfJs5cnjL6RvpT4eQscBQVjwBxhTNMMYWnyHnfFbjFerxgjmE3QDTUG0GZysZ+2KpoxE
	DwTCTicSBB7m5yQKKmJnX2xMNgcgeoObryOznmwnG0c9+9vmIRt16Gi4OIcJCpunnVXzRMJfLXs
	PJdvlU7ujqB3END1neNQOj9N7hZJdwIDrL/17IvUMTOyMLZ1rrBIcQ2GvwcPB+JB8z965nNJMEA
	S849b/Qp0NtS+8cWGAWjARIZDVdOsWij0ApEChX1Y2oxicLfFyaVXZ1Am5O1E8EqbW3+tIJwSBx
	Z3ZaGHJQIAB/hCciTqoASwoZHs7XeYmnLPqcsUjAZ9WCcGCsZ8ddTKh7pA6N6yTwaXePxgXAEpm
	CbOXBDbnJS+PZxHlSkNwHxBJX0vAzH+9BaP3Eymj4cENucNhz22Q1yz0bUNaKn3UH2wqfqbb/d9
	r/LEZgRk5YV1g==
X-Received: by 2002:a17:90b:1643:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-39b26272f04mr30192034a91.14.1788756706071;
        Sun, 06 Sep 2026 21:51:46 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:51:45 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v2 0/7] bpf: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 10:21:28 +0530
Message-ID: <20260907045135.13317-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the spelling fixes for this tree.

Changes since v1:
Subject prefixes corrected: 'selftests: bpf:' becomes 'selftests/bpf:'
and the tools/lib patch becomes 'libbpf:', as the CI bot suggested.

Only comments change; no code is touched.

 arch/arm/net/bpf_jit_32.c                                    | 2 +-
 arch/powerpc/net/bpf_jit_comp32.c                            | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c                            | 4 ++--
 arch/sparc/net/bpf_jit_asm_32.S                              | 2 +-
 include/linux/filter.h                                       | 4 ++--
 kernel/bpf/reuseport_array.c                                 | 2 +-
 kernel/bpf/stream.c                                          | 2 +-
 tools/lib/bpf/btf.c                                          | 4 ++--
 tools/lib/bpf/usdt.c                                         | 2 +-
 tools/testing/selftests/bpf/libarena/src/asan.bpf.c          | 2 +-
 tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h     | 2 +-
 tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c | 2 +-
 tools/testing/selftests/bpf/progs/iters.c                    | 2 +-
 tools/testing/selftests/bpf/progs/verifier_var_off.c         | 2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)

