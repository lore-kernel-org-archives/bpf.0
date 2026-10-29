Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292850;
	b=ZBuYrmrNSnIcFjjc0eYs4KNn3zn/VdTi6YVAsNKqqPXlDeDRpUI9yGm4Kny5AxYb8B8v
	 RXJ4JXmXr+ypoYjrd+Hdb0IXcBrPK5qP7CVX+pCAC2ZEa6dxXZW1PW4vJUtodbvQG2GRz
	 8n2Ys3hGZ9yWOofOZP2IDJHae0nbBFv/vlbCy4TSK8+J4w9ezABjafaQzOnbopvnqImpL
	 yvyHJjpGk1KzlyUa+8YMUBI0WXxwJjN5t9gmjmAeO5UVDzznoLIvxkKmOcodrTlWZXVPn
	 a0jxqm1OMt+p4/CZR/s3N4li6VLdmvGj2RzaTj7w2mL8qVg6NguMyDiRboH6wf2d6yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292850;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=KoCxuWWjDP1yVw1HvFaevXnQ4QC4h2u92EWwxCuPW/M=;
	b=IRVQ9H+/33zqTFH84jgQOQZOu8khSFSMQ4TISPJJzGMtdLX65JQeYlHgG8SArEfhYEe7
	 V+Dl1zKQOvpxTFRsCaL2uMtvDK+pluSkBG4AbUg8xuqVyTobjdkg6aqJKkrA9KQavht4G
	 YD9wiNC+Ybwb956AdljaOxRIZapT0G5QYBP9719hWutwA2y992wnjAp10Y9v0BImF1Aym
	 mR8ts0RStuaLkFbzvjUajcCbNDG6lEBnqp9Sapu48HTbJsM9hAT8AviSc2l5m6/gpjDc1
	 hXCNyXQq/8j1ypVvtqu8EGRj8zUymFieydTPmzhU4Gc+yztN2ISJJ6JhTM5S05Zja+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tEl6cpHA;
	arc=none smtp.remote-ip=91.218.175.87
Received: from mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035D606A31D
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D035D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tEl6cpHA
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rJ+GI9mSP2GAsgikWKRz/p+K9ZdSdVmHlMdYCh8VOxs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793292847; v=1; x=1793897647;
 b=tEl6cpHAtlunNNiZkjSyzVXX/bFpNZ1L7FiVP5ZBpqLFUH0FqeQnS6pzgRm2U9zJeRjiJ6kO
 apM1kLT2Cz+JSlxR/feG7HAFpNQxVco7kOxuv88/RzuR5Yf3UMb4ngwHeRIJqikj/ky6pZlNJIL
 91/zkTlXPShxZxzQLgI1yhqM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 66c164750fba40cd;
	Thu, 29 Oct 2026 16:54:07 +0000
X-Mizu-Trace-ID: 66c164750fba40cd
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 16:53:58 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Puranjay Mohan <puranjay@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: Ben Cressey <ben@cressey.dev>, 
	Florent Revest <florent.revest@linux.dev>, Bill Wendling <morbo@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Subject: [PATCH v3 1/7] scripts/sorttable: Make the arm64 before_func offset
 configurable
Message-ID: <20261029-b4-arm64-callops-kcfi-v3-1-1b011ad5ddec@linux.dev>
X-Mailer: b4 0.15.2
References: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>

sorttable hardcodes before_func to 8 bytes on arm64 (two prefix NOPs).
Make it configurable from CONFIG_ARM64_FUNCTION_PREFIX_NOPS instead.
kCFI kernels with CALL_OPS need three NOPs. The symbol does not exist
yet, so no functional change.

Reviewed-by: Ben Cressey <ben@cressey.dev>
Reviewed-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 scripts/Makefile    | 4 ++++
 scripts/sorttable.c | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile b/scripts/Makefile
index d7fbb7ca098b..7ef1c84cf79d 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -54,6 +54,10 @@ endif
 
 ifdef CONFIG_BUILDTIME_MCOUNT_SORT
 HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
+# 0 or unset (no prefix NOPs) leaves sorttable's built-in default in place.
+ifneq ($(filter-out 0,$(CONFIG_ARM64_FUNCTION_PREFIX_NOPS)),)
+HOSTCFLAGS_sorttable.o += -DFUNCTION_PREFIX_BYTES=$(shell expr 4 \* $(CONFIG_ARM64_FUNCTION_PREFIX_NOPS))
+endif
 endif
 
 hostprogs += gen_init_cpio
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 88e49a5c4251..2e951f2f60e8 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -281,6 +281,11 @@ static int add_field(uint64_t addr, uint64_t size)
 /* Used for when mcount/fentry is before the function entry */
 static int before_func;
 
+/* How far before the function entry a patchable entry may be recorded */
+#ifndef FUNCTION_PREFIX_BYTES
+#define FUNCTION_PREFIX_BYTES	8
+#endif
+
 /* Only return match if the address lies inside the function size */
 static int cmp_func_addr(const void *K, const void *A)
 {
@@ -912,7 +917,7 @@ static int do_file(char const *const fname, void *addr)
 		/* fallthrough */
 	case EM_RISCV:
 		/* arm64 and RISC-V place patchable entries before the function. */
-		before_func = 8;
+		before_func = FUNCTION_PREFIX_BYTES;
 #else
 	case EM_AARCH64:
 	case EM_RISCV:

-- 
2.54.0

