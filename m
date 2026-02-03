Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8B1318131;
	Tue,  3 Feb 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136076; cv=none; b=Y1CXZ4EmgExhgsPHzosaaI8ZD6tYVpjbCVPXJ5rVmU8/y2LmIPoIycG37fw2aJfJPfkAKbkxoAcbg0v6kMqi+YDkx4ruFI9ruGHgoTnjnot3BIBhl59j/yzGIIs/21MaatZTfhSV2Q6c2cR2aX9kZLNBI6+1BG5p4Qeby4R6X+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136076; c=relaxed/simple;
	bh=hEIDVLnUUtdPZocLGK/ulilxSWoh29S4Ua9ZNH+2nSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Stdz4ZBl076bvPC6gsMyzGdh6fq7t59D4ZWdkt3mdKuPsDEsCesl6xpvUQbQjDWhkggSHWqdB+VgbjNe5LLKJu/GmtHxU7mWa6nFRNepThket4u3sFN8uLGqIn11PDJ9SGdl3etsdRZpceBFZ7wG0bJYTZtsqH1SrjnbL9+q5wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvdFWjHD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvdFWjHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB36C116D0;
	Tue,  3 Feb 2026 16:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770136075;
	bh=hEIDVLnUUtdPZocLGK/ulilxSWoh29S4Ua9ZNH+2nSA=;
	h=From:To:Cc:Subject:Date:From;
	b=nvdFWjHDv1LPUqGf1N+K/1GFRo+xHhVV4Ih8zeZqYjw7Qzt80/ce99zOmVRatm3At
	 GRYDIdEXZpqlPXCtQjTt8AHs8TG+OMwAXLmA2AZKYO77nPsAgen/oJ426W846Zg8ED
	 Kwk4KIn6rrLlh3MReEjGwarm+QFE/rpAJrq1ukm02jVnOJG8i58b46PEUMavuje5jo
	 5ZvpNXFgf8sjK99nndeDVwsJTVqrCoTj3Y0D5kQu6598FbG2h1MGXyP+tq7qdFeApd
	 gfNrH9QF+ba203Bnc6xCSVsz8y17FSBvUqc7cNknzbPGDStbseRpYG2LJU8uTWCrfY
	 6O3IaexDWC7mQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] bpf: add missing __printf attributes
Date: Tue,  3 Feb 2026 17:27:08 +0100
Message-Id: <20260203162746.2337002-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Some internal functions in bpf produce a warning when -Wsuggest-attribute=format
is passed to the compiler, e.g. in 'make W=1':

kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_printk' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
  377 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
      |         ^~~

The attribute here is useless since there are no callers from C code,
but it helps to shut up the output anyway so we can eventually turn
the warning option on by default.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/helpers.c     | 1 +
 kernel/bpf/stream.c      | 1 +
 kernel/trace/bpf_trace.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b54ec0e945aa..45d026fc4e8a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1046,6 +1046,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 	return err;
 }
 
+__printf(3, 0)
 BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
 	   const void *, args, u32, data_len)
 {
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 24730df55e69..816fd7fba3d2 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -212,6 +212,7 @@ __bpf_kfunc_start_defs();
  * Avoid using enum bpf_stream_id so that kfunc users don't have to pull in the
  * enum in headers.
  */
+__printf(2, 0)
 __bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
 				   u32 len__sz, struct bpf_prog_aux *aux)
 {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index eadaef8592a3..2d3de71ab86a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -359,6 +359,7 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 #define MAX_TRACE_PRINTK_VARARGS	3
 #define BPF_TRACE_PRINTK_SIZE		1024
 
+__printf(1, 0)
 BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	   u64, arg2, u64, arg3)
 {
@@ -412,6 +413,7 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 	return &bpf_trace_printk_proto;
 }
 
+__printf(1, 0)
 BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, args,
 	   u32, data_len)
 {
@@ -455,6 +457,7 @@ const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
 	return &bpf_trace_vprintk_proto;
 }
 
+__printf(2, 0)
 BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 	   const void *, args, u32, data_len)
 {
-- 
2.39.5

