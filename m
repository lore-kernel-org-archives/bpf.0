Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567781;
	b=368aiIIHeRyk0P6b7JGkAtgLfFGbh52COkLmY43Zil+1tsvfRbLZOPkAZat8O4c01Vtv
	 pOs2QHI0yb+YYHVsLfK8yFPJK6INk/7zflmcsb/5ExfK6O7JpJu+Z9MBhlY1UDbsyrb6K
	 t6NL2SPKem64oM1pohfbMPM6SGGFUg7ENWklD8FolL7FzYqevRBUKbs6Q4JyOOk2GonqC
	 uH+mVJI5xrfkED3/jgRxnVPuM9eosOks/84VbpFI29BkUbVNFT4EUHeooNsg/KyDMcJ2o
	 TR5ROfbYJ845MBw9l1jYub/es3sJ4BSGH108V/oNcqOyErfGwMwixyiNBXL5Em4UtDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=cyNNuOa161K+iR4qAyNpNzJrMoWbE+BM8LRvvuUtRMQ=;
	b=RX2OhBK6Qn40WGQJb/NVvEJolofmszTDhKIJOFGZl5Cu97tCD4ObXd4Fp53EcariWNno
	 B2D5R10lsm0iix+F+pSIIk4dZH4JLutGZqADyKumNDoS7Dv1cFYvMj6DrV50Dt1yluu7V
	 CywLGcxQwB23SIlCtRh1mbVy0s2j9Hna9MS6l0ybZs8bOU3MPBZQXWFqpLKm6IvUk7Sba
	 T92L8YOb+pXomQtMe8H9w3fq22W2TrD5zfvCAKcAyabPQAODiA1/CtbIx+XqqW0bgClb1
	 3ueHZXvSae783pQGYvsXOHMLMbSaaye5866BBvbxZc2VS/jihBthU23gJpmXA5V42Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tweek.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="BT5WE5/N";
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786E606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 00:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E786E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BT5WE5/N
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b427e5a37dso4118750a91.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567780; x=1796172580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cyNNuOa161K+iR4qAyNpNzJrMoWbE+BM8LRvvuUtRMQ=;
        b=BT5WE5/Nf7L6JkcXmbd9i1EXeP3frwZMtIJPaWoBwtxMNNKBIi13PZaX3vcs8tha+8
         55NISiItQ7qA/5OUJkLOEItIpGy8CvqJC61oG+BE6yF1FQoI0WgxG3KU52/0GMPzQ7CJ
         dr6MIQjb6aYbEPR1R/aKQ8Ki1VEv5/8bE3dzg6tCbZNaIzAWT0o60X0I/5BPuaxnsMPv
         AjCiSJGWmF9oF57kfFRqTAwTKz5+KkSMf3duZxk6sYUR18KGzSQUjXHHfAgkUlcHI7/r
         KG2s8NhfHhK4gp1cE4zwhw7VInBfDNV6gNT1KudUPcsDHy53HvJ3PaMSubVf/y3c8Ice
         zJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567780; x=1796172580;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cyNNuOa161K+iR4qAyNpNzJrMoWbE+BM8LRvvuUtRMQ=;
        b=IWwtp0sx69Litqe6yKCMmmjlbpYyf8RxcMlzFhsP/rRhhq8F3mQyx1lQqJWAx47994
         h+OkCmCqGdBZxKjv/83EgtRcPTgY6sZgGmiksFC1txT8XWsl8w019Xz1Sg/dbpSJ7P5/
         XSta0oYShrPopSQ+gfRNcOj9kR+cNh3xq17kctJoQXgDftdpulr2cnYqcboPYikC6oLt
         p5MAvq9rLT7oTv/GINr5JNrFZhzym3wR42e6Feo9vHB2h6VgXtoN4AVtx00ntu1b+rhc
         uBJFF5ESAxgPX6bmXMvN+Chckud35+kxFlnPfgdMcyJC+IswTTGzxWw6WBA5b8a30Q2k
         TvSA==
X-Forwarded-Encrypted: i=1; AL+hErEtOvt9GdMq7ydSqqOQfc/GjAlo+u7G+45wFj7x409LKNv2CEkfynTWFmQgiZCESjskXSo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+R/nRMFWOeyoeSK8vTgat82WE2IItafEzdlwhpeBYuiVsCH5Cc
	7c5tyo0z/yH9wLeH4VvBh92kIp8KCzJ2xCJlQjjc+J6OAods9klwBVG7wQDafwTStKo9oLUZ2q2
	yEQ==
X-Received: from pjyf11.prod.google.com ([2002:a17:90a:ec8b:b0:3b4:3d61:7517])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55c5:b0:3b4:5b2c:2959
 with SMTP id 98e67ed59e1d1-3b45b2c29b9mr10853767a91.63.1795567780147; Tue, 24
 Nov 2026 16:49:40 -0800 (PST)
Date: Wed, 25 Nov 2026 11:49:11 +1100
In-Reply-To: <20261125004911.3937193-1-tweek@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125004911.3937193-1-tweek@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125004911.3937193-4-tweek@google.com>
Subject: [PATCH bpf 3/3] selftests/bpf: Test non-autoload rejection in light skeletons
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Leon Hwang <leon.hwang@linux.dev>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Sid Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a test (bpftool_gen/lskel_non_autoload) that invokes
'bpftool gen skeleton -L' on an object containing non-autoload
programs (test_global_percpu_data_failure.bpf.o) and verifies that
generation fails with the expected error message.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 .../selftests/bpf/prog_tests/bpftool_gen.c    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_gen.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_gen.c b/tools/t=
esting/selftests/bpf/prog_tests/bpftool_gen.c
new file mode 100644
index 000000000000..f0a0da6210df
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_gen.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <bpftool_helpers.h>
+#include <test_progs.h>
+
+#define MAX_BPFTOOL_OUTPUT_LEN	(64 * 1024)
+
+static char output[MAX_BPFTOOL_OUTPUT_LEN];
+
+static void test_lskel_non_autoload(void)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret;
+
+	ret =3D snprintf(cmd, sizeof(cmd),
+		       "gen skeleton -L test_global_percpu_data_failure.bpf.o 2>&1");
+	if (!ASSERT_GT(ret, 0, "format cmd"))
+		return;
+
+	ret =3D get_bpftool_command_output(cmd, output, sizeof(output));
+	ASSERT_NEQ(ret, 0, "gen skeleton -L non-autoload should fail");
+	ASSERT_HAS_SUBSTR(output,
+			  "is marked as non-autoload, which is not supported for light skeleton=
s",
+			  "error message");
+}
+
+void test_bpftool_gen(void)
+{
+	if (test__start_subtest("lskel_non_autoload"))
+		test_lskel_non_autoload();
+}
--=20
2.56.1.831.g720f3f5937-goog

