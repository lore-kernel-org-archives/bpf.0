Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F643E9F4;
	Wed, 22 Jul 2026 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756418; cv=none; b=tvOS/hEOw9ndqyM+1uNh83OdeHTpa/fOk3cP+2x46GEpOCk8Kuhnugul2uy1AORQzGzKMJrwR/20qUJkBzJrcLEWtCeMhOPnCVkN34XbUgQd9v8WmZ8g1SK6QNMJkKKyVB9gR9oz0XRvDVBkxM5DG1AGyoey5fWQEC7ttMcsh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756418; c=relaxed/simple;
	bh=LHGRFLXQfRcR+pvqeqZGWFDrFa2LhclQR1cE8OQjQwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkFVn7pY+zz4naG2OxFLoK05Yu6GMCt/eWIyMcgaDrRbyhEtLxrCd0AXVKzgYt/VMwRfRIx0018s0yuCFYvSdQ72bLL4BfKBihC+QALY3H00U+p4K4OIh/V7MXH3I8HNIJcMg8s2bxPYRMTg1GGrwOLQYhBcfCWfQkXtJuNU7Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUPZN7pW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUPZN7pW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19DB1F00A3D;
	Wed, 22 Jul 2026 21:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756413;
	bh=+eMYlOGfJ10tYybtvyrsW1lB+RoAnjB3FfjZYdMkZkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AUPZN7pWFQ8uxNPRAe4YDaLWmhexm824Tfmx7Fb/7Qj8Xjp1s+JDFfA0QfJ2sC2Hn
	 aXnEEM6d1eIruBNgHtfE6cnyP2fxiBhmrHGdhcKL9yUmaxwS6wfPTbyYPNdxfLMvaI
	 GLwleQEecZXVWfg2JhxChcVGypsbOvolr65aisR/x1JfjW/gX+OsHFLF8x8GvzXL+N
	 lhiquT01UYjN0fDVSZ6aS3PGWTFq++8xZO62wmfSy6ZllHAU3wb5OWHmfirAWz4qtX
	 Al+yVvDRcGgr4+p8XPw8aHh+sfIYnsv0DuFQtCPky6xPCFeDiLsy6CemEV0iTUUL4u
	 cneF5UJf738sA==
From: Will Deacon <will@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev,
	bpf@vger.kernel.org,
	Florent Revest <revest@chromium.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huawei.com>
Subject: Re: [PATCH 0/2] arm64: ftrace: support DIRECT_CALLS without CALL_OPS
Date: Wed, 22 Jul 2026 22:39:25 +0100
Message-ID: <178475345276.2109707.13204683362381752837.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
References: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Jun 2026 05:19:25 +0000, Jose Fernandez (Anthropic) wrote:
> On arm64, HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is currently selected
> only when DYNAMIC_FTRACE_WITH_CALL_OPS is available. CALL_OPS, in
> turn, is mutually exclusive with kCFI: the pre-function NOPs it needs
> would change the offset of the pre-function type hash (see
> baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")),
> and the compiler support needed to reconcile the two does not exist
> yet.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/2] arm64: ftrace: prepare ftrace_modify_call() for use without CALL_OPS
      https://git.kernel.org/arm64/c/123b4fc0f857
[2/2] arm64: ftrace: allow DIRECT_CALLS without CALL_OPS
      https://git.kernel.org/arm64/c/9315e22b0c0a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
