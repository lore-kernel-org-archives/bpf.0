Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841829C328;
	Wed, 10 Jun 2026 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134619; cv=none; b=mGlylTHTJBI+g3S32sqUJN2nty6CButOWgMmY2tgJBY//Etsk6BaVCV7GguyHJ2xYwZA1tMeoMSleErrJ6CWkKekve3TPoXHjZg89AGqxa6hT7mqwCS5JD7qQaApORT5KCuETKS0RszfKp1NdA5G7sY+LzsaTLn4Q+QH+XcLccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134619; c=relaxed/simple;
	bh=VCVCOjXPTtK4G11i+IY3ZJ4sgEJA4p10ZObDPKF/III=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La29E2g1EJ5UP5CXsYWg08KEUk/rIpfL4tP6ACfHs2+nngrS5OqfnxMj702/i8425SIjEXLZrtqn9WlH36D2Rz8EV6EwH5YUF7A/8PZpnH4SAeLzfihqAdLTx5jpvvMFv17IPpwVk+eJgNu8b6E55JL/sxkf7orRQbNxjM/Ut8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9olKbpj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9olKbpj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B633F1F00893;
	Wed, 10 Jun 2026 23:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781134618;
	bh=J/HJPNa4Oa5DLM5df/yKw+CscA/qZXvMF0PIQU0JPWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V9olKbpjJXSmWwsrWI9yU7LD3jo8E4jJVQIa7SKztF8hn+yzrWQ2uIE3jjnxrF7/l
	 w9390+npwpd2GKOVjZe43fglD+CB1VDU7AQznNphuEFHvHXd1lmkX2J6QiPgcMb63a
	 qznCw+fNa81Z1e1sPGInUlG2XFjpVFqmUAlcZp4eIPPTU2fHdDGd8yxk+7jiOnnecc
	 iGmcAWoOvcTDAq9sQq4nxwOMfaagFyrFMADeuCfVTizmmUT6gqLLMqPmAWPtmpqqc5
	 q8ylHsS5PGpOomB8gXS9boORsd2PGZP1X1SjwcPMgDopAd/2W8Jr2lvPrGbdYWl8L0
	 eBO7poY2Twvyg==
Date: Wed, 10 Jun 2026 16:36:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	bpf@vger.kernel.org, Florent Revest <revest@chromium.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huawei.com>
Subject: Re: [PATCH 0/2] arm64: ftrace: support DIRECT_CALLS without CALL_OPS
Message-ID: <20260610233647.GB3099686@ax162>
References: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>

Hi Jose,

On Tue, Jun 09, 2026 at 05:19:25AM +0000, Jose Fernandez (Anthropic) wrote:
> Jose Fernandez (Anthropic) (2):
>       arm64: ftrace: prepare ftrace_modify_call() for use without CALL_OPS
>       arm64: ftrace: allow DIRECT_CALLS without CALL_OPS

Thanks, I applied these two changes on -next and it looks like it
resolves the issue I originally noticed with systemd's restrict-fs
program not working on both of my arm64 machines.

Tested-by: Nathan Chancellor <nathan@kernel.org>

-- 
Cheers,
Nathan
