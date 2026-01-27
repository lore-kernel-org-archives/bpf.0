Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEB346766;
	Tue, 27 Jan 2026 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515586; cv=none; b=GwLKEqBorq24d2cmpPJpI5+F7BUt6CU5gm0sK/c39eAFTwwFr6UumeixDtuV7WbaUSCvdZu4Y9RmHfGoYwIijuihqWXPax+rntnYip6J0gTGxiLh6dlzpuPFJPGtRr1DFYsWcW+gkIrIoA9fgNqq+6GhXCSjmn7qZcOYF3nA9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515586; c=relaxed/simple;
	bh=Yb9lZxivsGxPrQaK/QH2O9mUVmg2N9TGodDCbSjnzfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAIuFoXMxPGvzWaNEYoQDNXeRoBMNpvXddfrhKnUY6SJPd+AJHbM7xWNIbHtJ72Ygb9PtbtGRUsesaI1iTZQUR/LpR9hgmto8tHDnRLy69T1k5Y2CdCisv1UUj/MXl/qbvqK/kDCUd3wjffqZPw8XC/bfVq/6JGSf2jaXUqbRG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=tVr8aQMN; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="tVr8aQMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1769515581; bh=aV5FAftEjO1JhW71J3QNsn4ERdcp6E4DHdmuR2vlPKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=tVr8aQMN6GPqz6aWv7w0JJ8ynnVdDgkjVjrkv4y4LS3GbbRhVthqhff7V7+18h4HP
	 cp7ls0DWyfGwYXj+rIIlylbDi9kjSpf1vfI01WkQAwVpQ795Wnz8trguKTBHeiz60A
	 biSXk6wGCj3IO33bXxL8YuoCBrbsuCW8CnjNvmOqS+/hbRiPpgsBceTywNpgTQ/5o5
	 rvLnlDgOiPDqZJ3sRHrRDuPTrk3U6qfV8VOY4/Uvx1JYSG4emXA/dc0JoNJtBprYqL
	 NJUZ4ZLbzZk/j6v7SJf/wZJyeRkvf723EAtcDYAIELReZN6TBWKJYbngDeajHYK5MU
	 LdrRD3XGiVNgQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4f0kdn4DH3z1yP9;
	Tue, 27 Jan 2026 13:06:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.20.40.230
Received: from luis-tp.pool.uni-erlangen.de (faustaff-010-020-040-230.pool.uni-erlangen.de [10.20.40.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/2XH7rkSWgg4COYI3k9STRuQfFZEP4ut4=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4f0kdk4Fn4z1yGv;
	Tue, 27 Jan 2026 13:06:18 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Ihor Solodrai <isolodrai@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Subject: [PATCH bpf-next 2/2] bpf: Test nospec after dead stack write in helper
Date: Tue, 27 Jan 2026 12:59:12 +0100
Message-ID: <20260127115912.3026761-3-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127115912.3026761-1-luis.gerhorst@fau.de>
References: <20260127115912.3026761-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without the fix from the previous commit, the selftest fails:

$ ./tools/testing/selftests/bpf/vmtest.sh -- \
        ./test_progs -t verifier_unpriv
[...]
run_subtest:PASS:obj_open_mem 0 nsec
libbpf: BTF loading error: -EPERM
libbpf: Error loading .BTF into kernel: -EPERM. BTF is optional, ignoring.
libbpf: prog 'unpriv_nospec_after_helper_stack_write': BPF program load failed: -EFAULT
libbpf: prog 'unpriv_nospec_after_helper_stack_write': failed to load: -EFAULT
libbpf: failed to load object 'verifier_unpriv'
run_subtest:FAIL:unexpected_load_failure unexpected error: -14 (errno 14)
VERIFIER LOG:
=============
0: R1=ctx() R10=fp0
0: (b7) r0 = 0                        ; R0=P0
1: (55) if r0 != 0x1 goto pc+6 2: R0=Pscalar() R1=ctx() R10=fp0
2: (b7) r2 = 0                        ; R2=P0
3: (bf) r3 = r10                      ; R3=fp0 R10=fp0
4: (07) r3 += -16                     ; R3=fp-16
5: (b7) r4 = 4                        ; R4=P4
6: (b7) r5 = 0                        ; R5=P0
7: (85) call bpf_skb_load_bytes_relative#68
verifier bug: speculation barrier after jump instruction may not have the desired effect (BPF_CLASS(insn->code) == BPF_JMP || BPF_CLASS(insn->code) == BPF_JMP32)
processed 9 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
=============
[...]

The test is based on the PoC from the report.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Link: https://lore.kernel.org/bpf/7678017d-b760-4053-a2d8-a6879b0dbeeb@hust.edu.cn/
---
 .../selftests/bpf/progs/verifier_unpriv.c     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index 28b4f7035ceb..8ee1243e62a8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -950,4 +950,26 @@ l3_%=:	r0 = 0;						\
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("unpriv: nospec after dead stack write in helper")
+__success __success_unpriv
+__retval(0)
+/* Dead code sanitizer rewrites the call to `goto -1`. */
+__naked void unpriv_dead_helper_stack_write_nospec_result(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	if r0 != 1 goto l0_%=;				\
+	r2 = 0;						\
+	r3 = r10;					\
+	r3 += -16;					\
+	r4 = 4;						\
+	r5 = 0;						\
+	call %[bpf_skb_load_bytes_relative];		\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes_relative)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0

