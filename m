Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2003438488
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267213; cv=none; b=Br3497a4245QbXBHaHacXitekhqx4fPaxcTehKSzHIBV7RMEJnfp8oC5TxVEcrWoYbV+rcY8SexdBvAhrdlZRabh+gG3Sjwoyya8Ic1x8cpszLVUR3z0yZOD8o7eGsCVu6ntxbxTteUUkR+oB9Pzx49f4WHL9duUEOlOsylP2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267213; c=relaxed/simple;
	bh=FO+CLqoKGrK1EXYSkttfZxmRAO0FGDg3m+1dWBuCJtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAec+3MxIsspWGo9P6TRWWRkDnbfHxVHtt5putbUZ7YbkGqT5uN7uzBGBduHZsgJ4y1O8E/WTQIJBlXCyh2s7uXyBOm7eAeiWMYx+N5Vj34UBZv3+avDuS5cktTk5yZbAQQYl/aF2HuYKBYVml95upMsXit3p5OG5q6LCpeXPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc+gzGwl; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc+gzGwl"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-484392e3450so667f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267210; x=1790872010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2N6meC0pEVsmcMKFjV6yTKmqsLM/5h4vcFncOyj+Ifw=;
        b=Rc+gzGwlnlmaAgWt8VgHqs4SDVbxiHVR8vK6O2ODtimMYMAJID/1VNgXi9gq3AgsKt
         +btcZ2wclGpwQCP9/13mvuxS4crZfuY/0eFcjuOZ32csVkQoB9dFO4a2fvD/V8MFMl4W
         iw8t95mgtvZHOgykqlFUrjK5/hhvWbFUhKk16wgnyNuVW/mjb+9tLXakCGCHY2HH3p6c
         nIkSM8Qwy455msth9YbDkwpyU4+iCxbDyvtBEntfsYy/yj8H2DXdHry9toP/WTEk1YLB
         IyV25SEBHifN4SoHWVLvyqINdCniysJWASjHbBVZRf9igEsCQx4ONzF6maRPbkXWk9QB
         IQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267210; x=1790872010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2N6meC0pEVsmcMKFjV6yTKmqsLM/5h4vcFncOyj+Ifw=;
        b=iCfwdLoxlj+Edpp5JX0EOpYrtMO3phXWd2NEWwTnFCahqjrTZveq/u552G5PphtAin
         of98fxUkF7mR6m19Q2/eEG1cQqLSu343J5awWNzRnj/kaM4CKxAn6oSvcR5qpLLm6CW7
         GYb22tbBdbVRvTdQT78zyCIM459ubHx5wyMT1UDCGVNO1Hi9oqTUOr/bo4ol8dKtzyzG
         0S+mkeJvoDh1dcCI8ljpKVtr9JsG+uVO3ry/AOehExLbVulj/6/fAQAArQodiBGDXjig
         KqVfAaDXmPCLu5WVEJDRYueN5D6O3ZF41Y+x0OikxlqpIFGc4LwDSbCElM+tf8ZDAkM4
         0Mag==
X-Gm-Message-State: AFuF++kAI8Y+anDR64mFzsmg2cQ/6PX6LX9oPm2Xh220eGyt0f2IDqB/
	cqP5gCCc/lQXTL3DBDMMlzNcxyFdXB700QQEKtM6PAk/TJ8Z/n7qzAvWzDvmpmds
X-Gm-Gg: AYBFou2Qioa/4c4derURF01x2ZIxUic69NOXvJ42thXWYpe3J6Uc8D8KQss3OU10pQ4
	IvbdF24kirw+UqufsA/j8l8t/pAeRn4n+6xzQDfeggWdMg5myj3xu3XIecCsq8YxaajnYFhTzPw
	buVhh0r49HDGBsjONI4tncYpnPTgcCgQHp4BD11MjofYYqvlY/3A/WwSYrobnniOqDj5tSzPgJd
	q79v6fsrdVyGePNLRIF/fn1BwocZf3KPt9GN6LjS9zenzEL2uoolShnUSnvgyn51edQYdy4cFIo
	IiX8jwVibhDA4roo2sSlVcmuIqHJV3zw5IqoO/FmXxhbc7+pvct/j9+MCP9FcO6G/fZPDzLzwW5
	uuxGgGKdOfXXoSk26QhiGK490cOlxspchngajvWruETrTPKKrzVi0Rke4C1QPDKKi4COEUk1+DX
	pf0n8cywrufmEl9uTxWgIoeHGLygJvmVdOAH5CZcTzX9DFZQqQb974hsoGxdQX9n/1oWTqzz7DY
	OoPEMQCoQ1VrDquDk4dWUD3tchKA+9oWCMAJ/B+WFmQy0x6MPtacPfwpaM88gb02a7Ua+72bo8a
	9FFdA33JaljZtoYV117n83+CtfOi9Av2tvpieeRe4V/Px6PJ
X-Received: by 2002:a05:600c:468c:b0:49e:715d:95ca with SMTP id 5b1f17b1804b1-49fe66f9fc1mr52815115e9.13.1790267209685;
        Thu, 24 Sep 2026 09:26:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cc9a37sm89061495e9.11.2026.09.24.09.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:26:49 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/5] bpftool: Read program streams through file descriptors
Date: Thu, 24 Sep 2026 18:26:36 +0200
Message-ID: <20260924162641.1922423-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924162641.1922423-1-memxor@gmail.com>
References: <20260924162641.1922423-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4984; i=memxor@gmail.com; h=from:subject; bh=FO+CLqoKGrK1EXYSkttfZxmRAO0FGDg3m+1dWBuCJtg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur754dc86eCc+YpSVnLPo4I/vLj/MVRzsjPe29mv9zM K/OedPRUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIn8vMTIsOzufaZ/Pqyzndrv WkfzXZ664uIO2/uNjk6Ge0KchT/JnWdk2GR8amrcrD3ZgoF/rk7uFit+5XJGeLPVS8ZVDbn3Ty1 +zQIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Use bpf_prog_stream_open() in its default blocking mode when following a
program stream. This lets bpftool wait for later output instead of exiting
as soon as it drains the currently buffered bytes. Flush each chunk as it
arrives so redirected output is not held in stdio buffers while the next
read blocks.

A stream descriptor does not keep its program alive, so bpftool drops the
program descriptor once the stream is open. The command then ends with EOF
when the program is unloaded and otherwise runs until interrupted, as
bpftool prog tracelog already does for the trace pipe. Install SIGINT,
SIGHUP and SIGTERM handlers without SA_RESTART so an interrupted read ends
the loop, check the stop flag before each read so a signal that lands while
output is being printed ends it as well, and exit successfully in both
cases. Restore the previous dispositions afterwards so batch mode keeps its
usual signal behavior. Report errors from the fallback read path too.

Fall back to BPF_PROG_STREAM_READ_BY_FD when the open command returns
EINVAL. The bpf() syscall uses EINVAL for unknown commands, so this keeps a
new bpftool compatible with kernels that provide program streams but
predate their file descriptor interface. On such kernels the command still
dumps the buffered output and exits. Document both behaviors.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpftool/Documentation/bpftool-prog.rst    |  5 ++
 tools/bpf/bpftool/prog.c                      | 62 ++++++++++++++++---
 2 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 90fe8c61bf42..ef7e00eb5e47 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -186,6 +186,11 @@ bpftool prog tracelog { stdout | stderr } *PROG*
     error messages to the standard error stream. This facility should be used
     only for debugging purposes.
 
+    On kernels that support opening a stream as a file descriptor, bpftool
+    keeps printing new output as the program produces it, until the program is
+    unloaded or <Ctrl+C> is hit. Older kernels only allow dumping the output
+    buffered so far, after which bpftool exits.
+
 bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ctx_in *FILE* [ctx_out *FILE* [ctx_size_out *M*]]] [repeat *N*]
     Run BPF program *PROG* in the kernel testing infrastructure for BPF,
     meaning that the program works on the data and context provided by the
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 24e40dfab469..f0241dada548 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1119,21 +1119,69 @@ enum prog_tracelog_mode {
 	TRACE_STDERR,
 };
 
+static volatile sig_atomic_t stream_stop;
+
+static void stop_stream(int signo)
+{
+	stream_stop = 1;
+}
+
+/* Consumes prog_fd. */
 static int
 prog_tracelog_stream(int prog_fd, enum prog_tracelog_mode mode)
 {
+	/* No SA_RESTART: an interrupted read() must return EINTR to end the loop. */
+	const struct sigaction act = { .sa_handler = stop_stream };
+	const int signals[] = { SIGHUP, SIGINT, SIGTERM };
+	struct sigaction old[ARRAY_SIZE(signals)];
 	FILE *file = mode == TRACE_STDOUT ? stdout : stderr;
 	int stream_id = mode == TRACE_STDOUT ? 1 : 2;
 	char buf[512];
-	int ret;
+	unsigned int i;
+	int fd, ret;
+
+	fd = bpf_prog_stream_open(prog_fd, stream_id, NULL);
+	if (fd == -EINVAL) {
+		/* Kernel predates BPF_PROG_STREAM_OPEN: dump buffered output and exit. */
+		do {
+			ret = bpf_prog_stream_read(prog_fd, stream_id, buf, sizeof(buf), NULL);
+			if (ret > 0)
+				fwrite(buf, sizeof(buf[0]), ret, file);
+		} while (ret > 0);
+		if (ret < 0)
+			p_err("failed to read stream: %s", strerror(-ret));
+		close(prog_fd);
+		goto out;
+	}
+	/*
+	 * The stream descriptor does not keep the program alive. Drop the
+	 * program reference so that reads return EOF once the program is gone.
+	 */
+	close(prog_fd);
+	if (fd < 0) {
+		p_err("failed to open stream: %s", strerror(-fd));
+		return -1;
+	}
 
+	stream_stop = 0;
+	for (i = 0; i < ARRAY_SIZE(signals); i++)
+		sigaction(signals[i], &act, &old[i]);
 	ret = 0;
-	do {
-		ret = bpf_prog_stream_read(prog_fd, stream_id, buf, sizeof(buf), NULL);
-		if (ret > 0)
-			fwrite(buf, sizeof(buf[0]), ret, file);
-	} while (ret > 0);
-
+	while (!stream_stop) {
+		ret = read(fd, buf, sizeof(buf));
+		if (ret <= 0)
+			break;
+		fwrite(buf, sizeof(buf[0]), ret, file);
+		fflush(file);
+	}
+	if (ret < 0 && !(stream_stop && errno == EINTR))
+		p_err("failed to read stream: %s", strerror(errno));
+	else
+		ret = 0;
+	for (i = 0; i < ARRAY_SIZE(signals); i++)
+		sigaction(signals[i], &old[i], NULL);
+	close(fd);
+out:
 	fflush(file);
 	return ret ? -1 : 0;
 }
-- 
2.53.0

