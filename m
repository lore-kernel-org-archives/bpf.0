Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D3376BE8
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316566; cv=none; b=Xm4NI284zk9bWtVD9Aa/pdqZisjNobAfv12SMLPe4MecHA+KkYCFyBmYp5UCrc6RRaInCO2TBCyHIN/C+OicSbCYn38MKbLn9d+cnjcUOdr0c4DNZyrO+A8ZU3jGpVoeY6fObesnVUpCP/paDWZQLL9BcNZF3/zT0uJbfasczAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316566; c=relaxed/simple;
	bh=uxx6uSvKQFfFof6VsAJqD0+hNi05NgTJ7SDXHj9G4iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6arVv/1ywYnrLpx2O8v9CRZY+uB9+9X3YVyBftCRxeVUhdUSmrrFkB1EF7NlzJPu3eXDewd4ioGvzfQ8V1UvMn1j2CntbsIKjZ4XKBZY1EKhCkUEVMd/P8Z/LCMAPhEfPwaP29C19TmLsuPXBSHwH2U1Q+3a5n8ogXBZVr8JLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozyoPr1d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozyoPr1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7CF1F00893;
	Mon,  1 Jun 2026 12:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780316565;
	bh=vy/ioHAfGgSkFdNc33HjVxuu78qVZ7b6Jf34zd+7p8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ozyoPr1djBhYccGfc7owfgDXZIZtffVobIwU6L6JiS+RsTf6d0Pe5KtRJ6GI/YIwV
	 byJw3B2negs9eeYk/+fbeH56VlkpRWDjDWI0WpYWS2bUlWha0H+zdXEeaaPlrR1ppS
	 mrievXjj2zAUuk24XyMRDsli0CVhElWfErksVokevtW03l9jZiQHBj98KcAqlM33mH
	 6QHqlLUZi43oDtCZOYzBeEfo3YUYzA1S5PQVoPTXLS/NXKdW43hGIZjoiL/KnqvhUA
	 VK8dkfF8d3C0BCde1m/m69ionvV6YxJ8JwCUC4sA8iuvUT2aqrB63ZwLpxU33tY0hR
	 Rf4QqHF5L0k6g==
Date: Mon, 1 Jun 2026 13:22:39 +0100
From: Will Deacon <will@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org,
	yonghong.song@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	memxor@gmail.com, song@kernel.org, xukuohai@huaweicloud.com,
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf-next 0/2] bpf, arm64: Stack argument fixes
Message-ID: <ah15j0WGcOz5cjnZ@willie-the-truck>
References: <20260528161750.1900674-1-puranjay@kernel.org>
 <178027501939.3441607.3307361090146995963.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178027501939.3441607.3307361090146995963.git-patchwork-notify@kernel.org>

On Mon, Jun 01, 2026 at 12:50:19AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
> 
> On Thu, 28 May 2026 09:17:46 -0700 you wrote:
> > Patch 1 fixes a redundant MOV in the arm64 JIT's
> > emit_stack_arg_store_imm() and clarifies the stack layout comments. This
> > is not a bug fix but an improvement.
> > 
> > Patch 2 bumps the stack argument tests from 6-8 args to at least 10 so
> > they actually exercise the native stack on arm64, where x0-x7 cover the
> > first 8 arguments.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [bpf-next,1/2] bpf, arm64: Fix redundant MOV and clarify stack arg comments
>     https://git.kernel.org/bpf/bpf-next/c/12a585e607fa
>   - [bpf-next,2/2] selftests/bpf: Use at least 10 args in stack argument tests
>     https://git.kernel.org/bpf/bpf-next/c/157317ba662a

Thanks, Puranjay!

Will
