Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB43CB91C
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790312155; cv=none; b=dWZ0KQPsumhU8DivJi/RL7n2pL6uDUIcdhxtwipGUk3vtP16yNWLZaBBQ3fTBNDzeU1h37l2VCeqvJXZ2GOXQ3D+EjLp6tIE2u2E6mHm6id3U6ZbqguTlAUyrTuaz55ksYKdQE/tnS5lSrxP02W0BD9ntSS+yFMdHyg4TFC/tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790312155; c=relaxed/simple;
	bh=2HoPBrk1ChjhABWZYhpk1pI1CuLHum8uTkMj1BB7ynE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odH4jjhPcP5ZHUqakbqJrMZu4W0FIPspJGLSp9kDmrlWXq6HEuxicNrUesNyKymRRc6eIeW28/jBcm5BIEVpkI3CcqryVcM3lJAWz9JgXmzPXQNJ/XfCAPn8kN5dHbZATm+7U1A1ajYZb9CPnRheqFpr23kamgcOlC/Vi0VJnbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTy7/Byr; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTy7/Byr"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bbf77e8so900965e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790312151; x=1790916951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lwV1PwAwbX8W5yHBsZtTTKxTanpBD0gk+rl2xeap38Y=;
        b=RTy7/Byr7CkBOg/s8HN2yshfRj9K7GKWD00Z9aFD3AdjWkh3qu9q8aLYN5iujqdQwU
         K7yGKmesFmY/JG3fGZwONFNGm9wHtew/fzdx7hRBISNP8h00/8OAx77+p5sUw1k9AnUp
         EmhLsT3TQAEX73+gbF2eNeB57EZGB+hjTKMZXiQferjkAHHQskVP1UBGGB79P5uVVawa
         8wGH0HMeDbrYhG3eH5OzmHyDCnO0MEA69hNCjDJ0GCyMsqvup2gIbq7tThMmENraKVlP
         Ay6SiMvjIaIWWoaNeGffJpGaSmd/ltWLdCID3SOTacBd4nq7Ff1mExv9cSsN5rLVOp9v
         liJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790312151; x=1790916951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lwV1PwAwbX8W5yHBsZtTTKxTanpBD0gk+rl2xeap38Y=;
        b=TUfXh+c/M4pITdQwJNxpoZCMzVnLdkpfCHBLEe4R3tcWpwVplJjmqbErLqAjIdCGqd
         VMJiKpalhOFjJ5ZjC5gYa7aK2P0wmmnTU7BgFap+y28WCXMq2LWGwIo8R5xokEOHFMlf
         rwoVuvPJgYf+T6qLpjxpPU/IlK9hS/JHGw3z4w22jRe6la187pVPDFl0nMtdyWRV0xH2
         tIEAU2b78TC7gRAObo3z3wTPx8n4zrPc61D0B64TWokkJKcCvFT/CY55yicQ4nUNWHSe
         Z+75B8Sj8jI/zTpJKzpBQbzH4e8xi20bgaaqk68q41LJhrSgjGNNrQkrvXLrgpOYPueQ
         Ww0w==
X-Gm-Message-State: AFuF++nZCfcdsWMwIkpGVk0XgWTFN3gJhL+RHD+D6dbVXktkx7XZplKg
	RkpzbeLIPNABIsIjZum1zj0g2nLafuZGXnVgHHCdgdeURyo4hlEeaYJn/WEis7tc5oY=
X-Gm-Gg: AYBFou3Oly2p0nNCzhHsu7HoYa+jGx9Ebm1mzpywOcl8UATIwsXv38dxUqBlR+3rgRy
	AZneyJgFq8qO84CkDceACodEn3kHQO7w4L4SWtp90NGj39/eXuklVwH+gaHPhJpF+fRhnIVY7Az
	2qdqxeEULAOyTNii+QuMwpVC/n3sAIkK5xd/7Vt+kmdwCV9SgU6eB4cAcVO+rhkhSI1GNeQLTD0
	uDwpzDHfNJfJ0g3/NBXgraPfC+kH8ltU4lR0qC8iK6v6Htz2ho3g06qcl+BfNQCK6fXa3qmu9pN
	0LS35aj7Z70wQ3wEVsMdqTEbxSQb+oJF8y47jTeKsc5Erd7dFFAEJvt6Goeq+wGF/bUTQOpMZ3f
	t3yCYfKKyPhWt+uWWk7pHU6bbieDPyD60ntV+moyCTgE8QGX3d9rCRf5f7uW9qWlT8v0OHMSk0F
	kHYOGusZqPJyI3Hf3iZ2DDTTOoqMbkly7JAeIqbhfOhbs8lk561FRsmc2mVPYvKWMV6HyJcIatl
	8Efb6V7RmeXfRIumQlntxq8vxv0YWV6Lma3ROGy6lQ56bdMpStQa4vWHM1yymtzlAv/l5R1zbyG
	/bGusF5tAsvbkYmnszxsTHu1FYQ6lQg29dRizQ==
X-Received: by 2002:a05:600c:870c:b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-49fe66d76camr78717875e9.15.1790312151251;
        Thu, 24 Sep 2026 21:55:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff06d4394sm31072155e9.15.2026.09.24.21.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 21:55:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/5] bpftool: Add option to wait for program stream output
Date: Fri, 25 Sep 2026 06:55:31 +0200
Message-ID: <20260925045536.1480933-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925045536.1480933-1-memxor@gmail.com>
References: <20260925045536.1480933-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8857; i=memxor@gmail.com; h=from:subject; bh=2HoPBrk1ChjhABWZYhpk1pI1CuLHum8uTkMj1BB7ynE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvrv6mVklFXnZlWP9ktFzm5IsO4jaPV+dCbeatPp3ybN Kdmx/u6jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEwk8hkjw+p5az4dfC59z/Lu 8hCXF4e2emh7nNywiekb4wv/bcUMr3cwMhy5sW/NpaWt65/NFw63/2ob7sZ57Y9F0NEj12ImRUn LODECAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpftool prog tracelog { stdout | stderr } PROG dumps the output buffered
in a program stream and exits, which is all BPF_PROG_STREAM_READ_BY_FD
allows. Waiting for further output means rerunning the command.

Add a -w/--wait option that opens the stream with bpf_prog_stream_open()
in its default blocking mode and keeps printing output as the program
produces it. Flush each chunk as it arrives so redirected output is not
held in stdio buffers while the next read blocks. Waiting is opt-in: the
default dump keeps using BPF_PROG_STREAM_READ_BY_FD and exits once the
buffered output is drained, so existing scripts behave the same on old and
new kernels.

A stream descriptor does not keep its program alive, so bpftool drops the
program descriptor once the stream is open. Waiting then ends with EOF
when the program is unloaded and otherwise runs until interrupted, as
bpftool prog tracelog already does for the trace pipe. Exit from the
SIGINT, SIGHUP and SIGTERM handlers like that command does. A flag set by
the handler and checked before each read would miss a signal that lands
between the check and the blocking read(), leaving bpftool asleep until the
next print.

Waiting requires BPF_PROG_STREAM_OPEN. The bpf() syscall fails with EINVAL
for an unknown command, which bpftool reports as missing kernel support
rather than degrading into a dump. Document the option and offer it in the
bash completion.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpftool/Documentation/bpftool-prog.rst    | 12 +++-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/main.c                      |  7 ++-
 tools/bpf/bpftool/main.h                      |  1 +
 tools/bpf/bpftool/prog.c                      | 62 ++++++++++++++++---
 5 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 90fe8c61bf42..17aa0d560e32 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -18,7 +18,8 @@ SYNOPSIS
 
 *OPTIONS* := { |COMMON_OPTIONS| |
 { **-f** | **--bpffs** } | { **-m** | **--mapcompat** } | { **-n** | **--nomount** } |
-{ **-L** | **--use-loader** } | [ { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certificate.x509> ] }
+{ **-L** | **--use-loader** } | [ { **-S** | **--sign** } **-k** <private_key.pem> **-i** <certificate.x509> ] |
+{ **-w** | **--wait** } }
 
 *COMMANDS* :=
 { **show** | **list** | **dump xlated** | **dump jited** | **pin** | **load** |
@@ -186,6 +187,11 @@ bpftool prog tracelog { stdout | stderr } *PROG*
     error messages to the standard error stream. This facility should be used
     only for debugging purposes.
 
+    By default, bpftool prints the output buffered so far and exits. With
+    **-w** or **--wait**, it keeps printing new output as the program produces
+    it, until the program is unloaded or <Ctrl+C> is hit. Waiting requires a
+    kernel that supports opening a stream as a file descriptor.
+
 bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ctx_in *FILE* [ctx_out *FILE* [ctx_size_out *M*]]] [repeat *N*]
     Run BPF program *PROG* in the kernel testing infrastructure for BPF,
     meaning that the program works on the data and context provided by the
@@ -267,6 +273,10 @@ OPTIONS
     Path to the X.509 certificate file in PEM or DER format, required when
     signing.
 
+-w, --wait
+    When dumping a program stream with **bpftool prog tracelog**, wait for new
+    output instead of exiting once the buffered output has been printed.
+
 EXAMPLES
 ========
 **# bpftool prog show**
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 9d9ced270685..a28af31937ad 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -269,7 +269,7 @@ _bpftool()
     # Deal with options
     if [[ ${words[cword]} == -* ]]; then
         local c='--version --json --pretty --bpffs --mapcompat --debug \
-            --use-loader --base-btf --sign -i -k'
+            --use-loader --base-btf --sign -i -k --wait'
         COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
         return 0
     fi
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 83884b21e708..d15fec71b64e 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -31,6 +31,7 @@ bool block_mount;
 bool verifier_logs;
 bool relaxed_maps;
 bool use_loader;
+bool wait_output;
 struct btf *base_btf;
 struct hashmap *refs_table;
 bool sign_progs;
@@ -462,6 +463,7 @@ int main(int argc, char **argv)
 		{ "nomount",	no_argument,	NULL,	'n' },
 		{ "debug",	no_argument,	NULL,	'd' },
 		{ "use-loader",	no_argument,	NULL,	'L' },
+		{ "wait",	no_argument,	NULL,	'w' },
 		{ "sign",	no_argument,	NULL,	'S' },
 		{ "base-btf",	required_argument, NULL, 'B' },
 		{ 0 }
@@ -480,7 +482,7 @@ int main(int argc, char **argv)
 	bin_name = "bpftool";
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "VhpjfLmndSi:k:B:l",
+	while ((opt = getopt_long(argc, argv, "VhpjfLmndSi:k:B:lw",
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -530,6 +532,9 @@ int main(int argc, char **argv)
 		case 'L':
 			use_loader = true;
 			break;
+		case 'w':
+			wait_output = true;
+			break;
 		case 'S':
 			sign_progs = true;
 			use_loader = true;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 48eedcb9f6c0..fa2c877a3cbf 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -89,6 +89,7 @@ extern bool block_mount;
 extern bool verifier_logs;
 extern bool relaxed_maps;
 extern bool use_loader;
+extern bool wait_output;
 extern struct btf *base_btf;
 extern struct hashmap *refs_table;
 extern bool sign_progs;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 24e40dfab469..5e27b22444f2 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1119,21 +1119,66 @@ enum prog_tracelog_mode {
 	TRACE_STDERR,
 };
 
+static void exit_stream(int signo)
+{
+	exit(0);
+}
+
+/* Consumes prog_fd. */
 static int
 prog_tracelog_stream(int prog_fd, enum prog_tracelog_mode mode)
 {
+	const struct sigaction act = { .sa_handler = exit_stream };
+	const int signals[] = { SIGHUP, SIGINT, SIGTERM };
 	FILE *file = mode == TRACE_STDOUT ? stdout : stderr;
 	int stream_id = mode == TRACE_STDOUT ? 1 : 2;
 	char buf[512];
-	int ret;
+	unsigned int i;
+	int fd, ret;
+
+	if (!wait_output) {
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
 
-	ret = 0;
-	do {
-		ret = bpf_prog_stream_read(prog_fd, stream_id, buf, sizeof(buf), NULL);
-		if (ret > 0)
-			fwrite(buf, sizeof(buf[0]), ret, file);
-	} while (ret > 0);
+	fd = bpf_prog_stream_open(prog_fd, stream_id, NULL);
+	/*
+	 * The stream descriptor does not keep the program alive. Drop the
+	 * program reference so that reads return EOF once the program is gone.
+	 */
+	close(prog_fd);
+	if (fd == -EINVAL) {
+		/* The bpf() syscall rejects unknown commands with EINVAL. */
+		p_err("waiting for stream output is not supported by this kernel");
+		return -1;
+	}
+	if (fd < 0) {
+		p_err("failed to open stream: %s", strerror(-fd));
+		return -1;
+	}
 
+	/*
+	 * Exit from the handler like the trace pipe variant does. A flag checked
+	 * between reads would miss a signal that lands before read() blocks and
+	 * only end the loop at the next print.
+	 */
+	for (i = 0; i < ARRAY_SIZE(signals); i++)
+		sigaction(signals[i], &act, NULL);
+	while ((ret = read(fd, buf, sizeof(buf))) > 0) {
+		fwrite(buf, sizeof(buf[0]), ret, file);
+		fflush(file);
+	}
+	if (ret < 0)
+		p_err("failed to read stream: %s", strerror(errno));
+	close(fd);
+out:
 	fflush(file);
 	return ret ? -1 : 0;
 }
@@ -2659,7 +2704,8 @@ static int do_help(int argc, char **argv)
 		"       METRIC := { cycles | instructions | l1d_loads | llc_misses | itlb_misses | dtlb_misses }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-m|--mapcompat} | {-n|--nomount} |\n"
-		"                    {-L|--use-loader} | [ {-S|--sign } {-k} <private_key.pem> {-i} <certificate.x509> ] \n"
+		"                    {-L|--use-loader} | [ {-S|--sign } {-k} <private_key.pem> {-i} <certificate.x509> ] |\n"
+		"                    {-w|--wait} }\n"
 		"",
 		bin_name, argv[-2]);
 
-- 
2.53.0

