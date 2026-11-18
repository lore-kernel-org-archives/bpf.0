Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991498;
	b=JtBMNgOpAD2RN5BS6ZSVfqtHobrNis+Ba18edYcalceTVV0uQsq5T/6CAnl/utc95LVQ
	 zZa9LKSbvadaIhoLu/XtyQzjVERFKzWaYxm5q3EbuGgktLE3mUBwjajZkKziC/BuCuvAz
	 gdQPYRVzQkSr2kxGBA79BOAVALxLqMkvGzehU6zpXcxnZ7onDSRA7cqThgRNlOIrU1dz2
	 R0hpdzarnmLW+R2BJJKQP+jFNTbHmenTh9/9KHXAIWKM/w3MOcRmlFVQacufnTFOUeu8Y
	 XO4rV5qbgYq1+2bNoNbvkzn7TH903q6+vq8pAsjkcumf5YF6zaOKroe5Sgr9Sq4YUBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991498;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=N1sGH4N/SXZ2PEylzDQSbka+G8mKbWTDfMxnhcO/bOI=;
	b=FfPaXblNKc5pluYmsP5EoGt50E+PGHjSAtEQfXfkViaP8HmHeDRezHp+VNgF4sMC9/AG
	 UYtbE5TN6uPKyiDUMnwGe5UucGtxgH+f9PYVF9QYiGA2+/m9nJCrFW2VsBnWDuHaG1UZj
	 2e60ZDlCH7BZrYNKyKWwroDBjPxMq87jqgXXWWM0h7DgFeVqeNEYtyhWaohDM2iOngKmI
	 iA01l+OLSqp4sf5Fk0py49mGGj1jYdBR1LVyw3cn8Fi5fjDaRFR3gNrmEQvu+3ZVJU6qJ
	 RVYrW28EMAAUahqqUtoqo43XV6bIiiEuvpW8y8BxAVQAcdJTJ5SAVv5cHTfSIgiWyFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGD7mkyb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413F606A31C;
	Wed, 18 Nov 2026 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGD7mkyb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C501F000CA;
	Wed, 18 Nov 2026 08:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991498;
	bh=N1sGH4N/SXZ2PEylzDQSbka+G8mKbWTDfMxnhcO/bOI=;
	h=From:To:Cc:Subject:Date;
	b=dGD7mkybV8hQ9Llilny4jnyX3zQT0Ep2HY++G1vuIMeixLzwoyK9sNKrxLwcrKWQN
	 emllvu4pbdquNod7Hx9FgiIoOU9Zd+4skmIOVpQTSWxXveVf2yN9WeFzDATL5KrhKS
	 MgjoZsAeS5Zxh01cDqv3SR3Wv48Wxwza3jqYT832xXOtKqvbB6GUeFtf2ZrLiSLaUZ
	 /UHzPCif2KRBYmQQvehes3R7fSGJPUFhT0O33gF+7buYD5RzICjcbUwiuBCG/8YKKf
	 QdLfBN6Kj1BMYKCzIpb72hYCwqwixDKEWPhwx3Cs83oya/cvb+Fo04xbCgfNB8ozCq
	 /PcxyBMVA9WCw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>
Cc: bpf@vger.kernel.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	rtm@csail.mit.edu
Subject: [PATCH bpf 0/2] bpf: Limit writable registers in uprobe context
Date: Wed, 18 Nov 2026 09:44:48 +0100
Message-ID: <20261118084451.12590-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,
a uprobe BPF program can currently write fields in struct pt_regs that
are loaded directly by the architecture’s return-to-user path. Some of
these fields are restricted by ptrace, but the BPF verifier does not
apply the same restrictions.

This series limits uprobe context writes to registers that ptrace can
set to arbitrary values. It adds architecture-specific writable-register
checks for arm64, riscv, and x86-64; other architectures default to
allowing no writes. Reads are unchanged.

The second patch adds verifier tests for writable and read-only registers
on x86-64, arm64, and riscv.

Patch 1 fixes the issue reported by rtm and is marked for stable consideration.
Patch 2 adds the regression tests.

thanks,
jirka


---
Jiri Olsa (2):
      bpf: Restrict uprobe ctx writes to the registers ptrace can set
      selftests/bpf: Test which ctx registers a uprobe prog can write

 arch/arm64/kernel/probes/uprobes.c                            |   6 ++
 arch/riscv/kernel/probes/uprobes.c                            |   6 ++
 arch/x86/kernel/uprobes.c                                     |  15 ++++
 include/linux/uprobes.h                                       |   5 ++
 kernel/events/uprobes.c                                       |   9 +++
 kernel/trace/bpf_trace.c                                      |  10 ++-
 tools/testing/selftests/bpf/prog_tests/verifier.c             |   2 +
 tools/testing/selftests/bpf/progs/verifier_uprobe_write_ctx.c | 196 +++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_uprobe_write_ctx.c
