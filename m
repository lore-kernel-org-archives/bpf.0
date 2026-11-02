Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623054;
	b=0r0VVS2eZwQaxOpZtrHhbJofWXwDtlSrwDWdnGsGrtv7V1/4mf3LHI7wUb8FIFg+1JLS
	 gJzmY1BW/ibTrmF3epocroGRcR2Pf7FtTFdd4pevLmv73RLAkPbbxFxn9ozfdTU2rzIMA
	 G/8Tc90l17+VPiJ3fydFAxvYvi4lSnKj3o6PiY3CmepIzCDxuSw1eSHzWgSSHuU7hnEgv
	 yC64DRAR98YrVhU7e5e9vWrsVQh9MAgn00WW4ph4cIEreF0aUu0wWu6LzXfdcei5EXfcy
	 t6p97wC0i8XHfkt2HHq+WtJKziNZZHsE10GBMnr2jGD9D7ARhSKZCCnjrIGLwLsB6zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=UJnsc6rPzhRrohHVm6N1G/brkkNL5aN56fn34HSgfWU=;
	b=y67Xnf0JKOuoSCQ6BbMhlu0Br9cRqp0Lus8514cbsh4FEZ7ktfwiVtCUC0kNLX4ErZFz
	 T96v/c8B5Whbf6bsGupabnB8DCQfIzTxM2LiqGL51djqYOwt3OgQ8fy1mhbzUo3TmqN99
	 KIMXZMs1vJj3H/9YAvjCWTTlh+VZiuilALeS4NfOGuxheXYFyiwkeqDTWzuKq39oDMsWC
	 +5EnoZKg+I9KhNaeA1Zgx2NLFhKC/OiUWj42iTwOsFB/+NWb/X0ohEdb4vAKFysFcDPuP
	 M+nQbz/58wnT5K4a5TRsuutOg9scAuFykmoDQy1mR9mVMjEXNqUKPyU4XqpMRo+wENQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I+iB/xDh";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1B60A2604
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76B1B60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I+iB/xDh
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-353804b591eso5202836eec.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 04:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623054; x=1794227854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UJnsc6rPzhRrohHVm6N1G/brkkNL5aN56fn34HSgfWU=;
        b=I+iB/xDhOLEUFnfAxghqnoWsj2cnfBUPzJ4P/6rflkIGlsnJiibyRWCx5skLYgX2ai
         0tCVXdwrHAVqMmbqTSs1YMv2aLQIBmPIzxAGvnlftxsTGBo6SXHDI+PZ3PgKW96D6YgX
         Q/ZpsHH0SXYQd7gODeYqLgPcRH03uO/DA3G+ew7XpMshOGjQohxzjbBuQj6lUTyx/qYf
         eSKUJ/Mh9VIxzIZb0SliQzlYzB1DhM9M1D/qLSHlCDc0nzc9vDgLc/EvpvDzxXKcSx01
         I39ZhHIQQZISagWDZhnAPMAQ5FLTiSVIhuM6mbO+I+eZJK12ThlMlVyy6KQPKL/9cHU0
         Q6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623054; x=1794227854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UJnsc6rPzhRrohHVm6N1G/brkkNL5aN56fn34HSgfWU=;
        b=tKp7oH8qI5GqBR9UDbsDnBZXoYZNP7f5iemjAMmWjiTk1+MQXB8UtyqKIbWdNTvBRa
         5bOq6iODSFeQJ941XQL/NBawC5ginYOxZdIJjigQ0Fj2fXCWUtwZAh70dGTQ0AmKXGmq
         ErLV6UVBFl3BcnvaTguVP8K5jHAcm2ZvqeL0WRoO2CxjgaSgIr3I7/kK/Qcw5rrQPB5i
         BFVteACZUq5iAlKXv1f6RxEgH63bM1VtLyQplo3Ct/ln4jsaRaYLcw4R/34t3FxAO+Nh
         TbDiVAUcu1tJ+dDbd8ONBQa+GGc3pWotbGklwr9D+Tltc2Rl7EfTKTPrH5zhPVq2JdkL
         Msjg==
X-Gm-Message-State: APuU4Z+EiB0El9MbrEDgkKogEBU5qhKago7CPLjBWyDgAxe/wlIoVTCY
	GrFiGOmMrZgm8t4seaGXVm1+hSEO1xWD9CcSoiZ8c4cNfC1SnA2TDDRj
X-Gm-Gg: AYBFou33uBGltjcm1zRb4xwDEMHCDlHmnYM7hhe4NOF1VwzudqZrWD5QVS3/MAlyNik
	Xwa4MNsHh4edycQQQVwjWhEnJgIxxK4D9Gd09oZYijloR5tKZ8cCsmb8N0iiPi/Vh8syJ2OABSt
	SZ5RfmGyNOnZNCN95ztgenlQVXMZYOknqPZ5qp86bU0hU50Q2Z7RGV+7VIb7WoCX69+pgJfNHhK
	c6c/ol2WQCNosLMdI7wOG0DNi+4IZhzulXWXs3hrwm2WSUTGUHpzucob3oLuM5uJMK4px8sS3v9
	+Y6x0K4j1yyyod5CO0OlYUk/huHvcjJVm07BVIpVa9mGkCtZ5aHBoRs42c5QzmPI6C17aYo4SRy
	O4TDBL4LWmnjQifSRV+A71ALzCQLe8B8K9WSdV1CD5SbPivjJ34MTNbfM+KT558NS0/lSxtXu65
	nIg2ClnyLjZdX+jy5OcBNiAXHqkwzC29u700CzuHEkAr0koxMKm9oUNykwc5tgFh3xLXO6gA389
	GvAtaLVnGyzCyUKxVKrnoGL8lzpRGr+HmrkUtfFcBmPweoIb8e5L4jQxOoz9B5sqCxQWmcl/MGZ
	/ZZZu3nKqnj2eDb4GJj0qacb
X-Received: by 2002:a05:693c:83dc:10b0:365:d42a:f415 with SMTP id 5a478bee46e88-36a423454b2mr17231783eec.12.1793623053582;
        Mon, 02 Nov 2026 04:37:33 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm36326095eec.6.2026.11.02.04.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:37:33 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 02 Nov 2026 07:37:05 -0500
Subject: [PATCH bpf-next 5/5] selftests/bpf: Test log_true_size with an
 error from blinding
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
Message-Id: <20261102-bpf-blind-nops-fixes-v1-5-844300e42cdb@gmail.com>
References: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
In-Reply-To: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
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
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

A prog of one function gets its constants blinded when its runtime is
selected, which can log an error.

No test checks that log_true_size counts such an error.

Load a prog whose jump goes over 11000 constants with bpf_jit_harden=2.
Blinding pushes the jump out of its 16-bit range, and the message must
be in the log and in log_true_size.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com/
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 .../selftests/bpf/prog_tests/blinding_log.c        | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/blinding_log.c b/tools/testing/selftests/bpf/prog_tests/blinding_log.c
new file mode 100644
index 0000000000000..658a8494dae5b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/blinding_log.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* The verifier log of a prog whose constants are blinded */
+
+#include <test_progs.h>
+#include <linux/filter.h>
+#include "sysctl_helpers.h"
+
+#define NR_CONSTS 11000
+#define LOG_SIZE 65536
+
+/*
+ * A prog of one function gets its constants blinded when its runtime is
+ * selected. Each 'r0 += 1' becomes 3 insns, which pushes the jump over them
+ * out of its 16-bit range. Serial, because it sets bpf_jit_harden.
+ */
+void serial_test_blinding_log(void)
+{
+	const char *harden = "/proc/sys/net/core/bpf_jit_harden";
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	struct bpf_insn *insns;
+	char old[16] = {}, *log;
+	int i, cnt = 0, fd;
+
+	if (!is_jit_enabled()) {
+		printf("%s:SKIP:JIT is disabled\n", __func__);
+		test__skip();
+		return;
+	}
+
+	insns = calloc(NR_CONSTS + 3, sizeof(*insns));
+	log = calloc(1, LOG_SIZE);
+	if (!ASSERT_OK_PTR(insns, "insns") || !ASSERT_OK_PTR(log, "log"))
+		goto out;
+
+	insns[cnt++] = BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32);
+	insns[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, NR_CONSTS);
+	for (i = 0; i < NR_CONSTS; i++)
+		insns[cnt++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1);
+	insns[cnt++] = BPF_EXIT_INSN();
+
+	opts.log_buf = log;
+	opts.log_size = LOG_SIZE;
+	/* log stats only: level 1 logs each insn, which wraps the buffer */
+	opts.log_level = 4;
+	if (sysctl_set_or_fail(harden, old, "2"))
+		goto out;
+	fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, cnt, &opts);
+	sysctl_set_or_fail(harden, NULL, old);
+	/* don't mind whether the interpreter takes the prog or the load fails */
+	if (fd >= 0)
+		close(fd);
+
+	/* expect the message about the jump in the log and in log_true_size */
+	ASSERT_HAS_SUBSTR(log, "cannot be patched due to 16-bit range", "log");
+	ASSERT_EQ(opts.log_true_size, strlen(log) + 1, "log_true_size");
+out:
+	free(insns);
+	free(log);
+}

-- 
2.43.0

