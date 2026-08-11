Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0BC44683E
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457967; cv=none; b=YU80dS3AKAVmMqZoEUgnnusVB6BwiuPul0bfVFyk5c3LtievIw0ktfHTG+4MuFdlro6efercTwTT5fONfYWv3WWId15riECfLQXHGtVMuN8ckcEDnnxIQapRqOreVyosd4VTA+pfYA8C5/c8T2IGbBMjZwLzH4Iytzwuk4c3LZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457967; c=relaxed/simple;
	bh=fl6lfBtHnEcKWredUepG6OWnZ8HLbdJ7IuQlu4Oxyb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLw7FHq77TyjJSnRZuFSACbQQm7CFCtIu8TfCBaOpt6IY/SZ0o58M03UipMAzGWiPyT0viYVhFCwfLG+pQocQ/8qD+EfT+08qG8RsuDtV226KnXcAF6fyq0AIkgqLWxYbp2BI7WBiPoPA/AIvFG2eveZ063sb3sqPGmjtLLEja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm4NGNIU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm4NGNIU"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2654650a91.0
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786457964; x=1787062764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F+AoUrsBpUtc9cshP/vnlsCUHVE4oAKvZ8tNF60vxD4=;
        b=Vm4NGNIUM3qpsXd5V+IDqCW3zS+zncWbzxgctrgS6tfKKECb1Ed082I8aw+s03j9dV
         M408HlzzV7fdckO2YKL7F3bpDkfuFwLHDeY8bScfwc9CsuzHalwKePq+/2hw9Y3p9zG1
         F2SWiRi4BUUFq4AT69VSSSuVxTj1c3D/jfhTRC8OzUxNw7/GD/vEFc+ol7GVMHhn08om
         xUwWrBHKzT1jBsXzvcLHwTOqGNH4nrT/UT6RJVf4tdn5tPPB/obRpf1ETo/cQvQInHPl
         roOWOMbs986flTQ7551UJuwDIBjUJExuZayG3MLNGqnrO0H5mpXgTW7z/V/HASlJrcPA
         4E5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457964; x=1787062764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F+AoUrsBpUtc9cshP/vnlsCUHVE4oAKvZ8tNF60vxD4=;
        b=eTFQPWBJbnwRMyI0DLhXgFJLBYMe6fyer5HV0NiNGCJuVAdLbOVqVazKuVx7+tmOSE
         DXXqH6jibYRspBeLRAYokzW7Et+FlT9wP6feqQLl6FMOUQNaSILEKgE6/I9m9KQ9ohIM
         mQqxOYl5sqEnup4O+WHZ2YZovLm9HHalyagtGqUMXeWOADk0ln71ZJlxFizIQzEvnSVm
         SrsHGA+Yyx+eDjGPnaFa/6MnrWiY1QQ7Drv5H4KXZINIEPmN4NaQ4+xEGqkS+p30Rrn/
         nsGoJWswKCQK/w704lFMqnzuu3gMJcJySdTmlzi/O2v7EN6OuFJRjUcW7raG39vf5xgz
         o7vA==
X-Forwarded-Encrypted: i=1; AHgh+Ropy+iF88hpZ5ywJDtgCHKKAZfyt6L4IGk74OybLxK8A4sj+CeTKXk+mIcLkdKZLX+1+L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0FpPHPY7vHcs4lqWJImpWNVnHDLkUTCl2vWD8WG78HjvKtRDk
	FNOxSgKchLBNYfWVxyB80J5BT9++n4jDhE4E0NAetg+evQetzE53pl0n
X-Gm-Gg: AR+sD12YkYEgI5a87QPQThEuoaE6ttKw+VYMizC1qg0g96uFcY4rnSNAXB0bXUdlY+c
	Y+Bau1Xk5fOxXGerEX2h6VAWa3eJL/b68ji8UwZ7iDtinv3tgojNhcI1BeBFNGwa/T5p3zgZ1+v
	BqQeXNRbcZSq0IA0rrrhQGAxVhGipH5bNEyNyiuxaO5tMfJPZt2zBoRLKKNAnpI/F//Iof5koPt
	9GO7yVb2/E85SmUuhZNG/htc4zJxXabrS+NiLDt5vd+YBsRPg0JZ3MGIutgu39h+5KnJDz4j69P
	garMDUa059V9iVQefRxRALuhxa3KtSeMCHfEhOAHG+ObzG6+n1L2v2fwxbPa46+GEfkw8J3ltzV
	QLAlvG//uo87df16+jNYV922/m5cjL6uDwO7iSD30GdDU7+JEGyvVldvq3GANPEFPs+5joirJ4Y
	WMKr3/4NZERTVMGSz5VClb2E1GHnRlG9sqVtuKlYtpXfzUkP7XZ+sZiTA=
X-Received: by 2002:a17:90b:58c3:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-392ec622163mr4066567a91.16.1786457964178;
        Tue, 11 Aug 2026 07:19:24 -0700 (PDT)
Received: from omen-arch ([211.58.239.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d534bfc9sm4028489a91.10.2026.08.11.07.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:19:23 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Exercise negative optlen in cgroup getsockopt hook
Date: Tue, 11 Aug 2026 23:19:08 +0900
Message-ID: <4dbdcda23b2f2be06c5659f8102cd6bd036825b3.1786448307.git.zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1786448307.git.zirajs7@gmail.com>
References: <cover.1786448307.git.zirajs7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a cgroup getsockopt selftest that sets ctx->optlen to -1. Use
TCP_ZEROCOPY_RECEIVE to exercise the kernel-buffer getsockopt hook.

The userspace-visible result is -EFAULT on both patched and unpatched
kernels, so the return value alone cannot distinguish the bug. The test
still exercises the kernel-buffer getsockopt path with a negative
ctx->optlen, which reproduces the hardened usercopy warning on unpatched
kernels.

Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
Adding the selftest to sockopt_test triggered the problematic path, but
detecting the broken behavior was not trivial because getsockopt()
returned -EFAULT on both patched and unpatched kernels. The selftest
mainly serves as a reproducer for the hardened usercopy warning.

 .../selftests/bpf/prog_tests/sockopt.c        | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index eaac83a7f388..3834dcf0f9dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/tcp.h>
 #include <test_progs.h>
 #include <io_uring/mini_liburing.h>
 #include "cgroup_helpers.h"
@@ -283,6 +284,27 @@ static struct sockopt_test {
 		.error = EFAULT_GETSOCKOPT,
 		.io_uring_support = true,
 	},
+	{
+		.descr = "getsockopt: deny negative ctx->optlen in TCP_ZEROCOPY_RECEIVE",
+		.insns = {
+			/* ctx->optlen = -1 */
+			BPF_MOV64_IMM(BPF_REG_0, -1),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+				    offsetof(struct bpf_sockopt, optlen)),
+
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_GETSOCKOPT,
+		.expected_attach_type = BPF_CGROUP_GETSOCKOPT,
+
+		.get_level = IPPROTO_TCP,
+		.get_optname = TCP_ZEROCOPY_RECEIVE,
+		.get_optlen = sizeof(struct tcp_zerocopy_receive),
+
+		.error = EFAULT_GETSOCKOPT,
+	},
 	{
 		.descr = "getsockopt: ignore >PAGE_SIZE optlen",
 		.insns = {
-- 
2.55.0
