Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293039;
	b=w3Nqtcnr9g1aFy9L/mRzxx5OQudqXN/ersoqjSv1Stoy5RUEF/o9KvmQrOvWakOcEN5a
	 YtBvsh8O/+MRvaKSYNTRbwTVCjVBiYmIstv4wY9f7AA7r6ioqBI40UQ9VlPW6R/wCyGlV
	 RSyt1qGI8lBxnM4swo6BxMQMIItX4/PGi/Aoc6X9w9jNKeW6iDiVc3pZEJeFPHeWsCbPA
	 GAoqj4c3y0dsByQ5B45UYH7sfN82v6EwfLFxJxkWddn687ZhJ3/034PQXTZEDXSUXUiN+
	 r0g6XT2Wh1xyb5fEjzoQTvOE5DRHKaSWok2HQmE9scDtqNOV9U0sx4mLeOKnrKawUfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293039;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=BfqsXxL1rgrukdQyTNx4+JIhiUPg8ohWg3FwnLI2hP8=;
	b=X+3bk5rhyZgpkWETrG9firsAlDPnIWW3+jFxpwwtyXc5bJAWRjYyscB6Sa+k2XfmjpVL
	 9cVbw3zAbgp/Ty6+5JvxgFwszBL2cS/GJSszsMTZ9+tcXZ8iTSp6FPeGZCMKctoccErDP
	 XzLveR6dOjPD2eaAFZ67I08hVhhm6FdARPcP/45vG3I2K0PhKXwkqYX+MBF3auzB4qcZI
	 VkFvmtUbTsb/8g+WDJAIesJI6ZNOrXqXwvHqoMjcK+IcZBL6PflEyCGLbh6RdkElnj4r6
	 +Wu2H0aa+EUM7lza8hh86f3XRPnshcZK6ajf8skcbtHWrCSb0HaMqNOyjWBtx6sQhQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="vHKR8/fy";
	arc=none smtp.remote-ip=91.218.175.176
Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847B606A31C
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2847B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vHKR8/fy
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xrX26dabxOZos4tCxbHq0hnwzFDsl+RM+u3ssoKzekQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793293037; v=1; x=1793897837;
 b=vHKR8/fy1gGLzPk/7dE/yvu/z1/wCGN2geIm5nFwlLMJYL45BnKFjiqdZttWfGTrfRf9jdfO
 lxiro3UjQmQVw0rHOKTxdrzNpXJ1LGYb4urQGNX5YSP3Ad8hyLkH2j4R+PrN6WjB8DH0kJLgVae
 Em15vXBImb7NBmiX4KFZ0n20=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 47818bb9047c54b2;
	Thu, 29 Oct 2026 16:57:17 +0000
X-Mizu-Trace-ID: 47818bb9047c54b2
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 16:57:07 +0000
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
Subject: [PATCH v3 6/7] arm64: ftrace: Use five prefix NOPs on ThinLTO
 kernels with BTI
Message-ID: <20261029-b4-arm64-callops-kcfi-v3-6-1b011ad5ddec@linux.dev>
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

Default CONFIG_ARM64_FUNCTION_PREFIX_NOPS to 5 on ThinLTO kernels with
BTI. Many functions there have a landing pad but no hash. That moves the
entry point 4 bytes. The 8-byte slot lands on the landing pad and ftrace
refuses the site. With five NOPs every function has a slot.

Commit d3359af21fc9e ("arm64: bti: Disable in-kernel BTI with recent
versions of Clang") keeps BTI off on clang 21 or later, so this default
does not trigger on a mainline build today. Josh Poimboeuf's series to
bring it back is under review [1].

With five NOPs the series costs 7.4% of .text on a defconfig-based
ThinLTO kernel with clang 21.1.4:

  Kernel                 || .text bytes | Delta       | Delta
  =======================++=============+=============+=======
  ThinLTO kCFI, base     ||  21,466,256 |             |
  ThinLTO kCFI, M = 5    ||  23,047,312 |  +1,581,056 | +7.4%
  -----------------------++-------------+-------------+-------

ftracetest results match with and without this series. The three
failures on a ThinLTO kernel are pre-existing. The BPF trampoline,
struct_ops and kprobe_multi selftests pass with CFI enforcing.

[1] https://lore.kernel.org/all/cover.1786768375.git.jpoimboe@kernel.org/

Reviewed-by: Ben Cressey <ben@cressey.dev>
Reviewed-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6715adcae38b..e8cb44d881d0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -285,6 +285,8 @@ config ARM64_CFI_PERMITS_CALL_OPS
 
 config ARM64_FUNCTION_PREFIX_NOPS
 	int
+	default 5 if DYNAMIC_FTRACE_WITH_CALL_OPS && CFI && \
+		     (LTO_CLANG_THIN || LTO_CLANG_THIN_DIST) && ARM64_BTI_KERNEL
 	default 3 if DYNAMIC_FTRACE_WITH_CALL_OPS && CFI
 	default 2 if DYNAMIC_FTRACE_WITH_CALL_OPS
 	default 0

-- 
2.54.0

