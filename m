Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2E3F4DE6
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975772; cv=none; b=PR+5s0lB3no0GLC8sAk3bHWknHI5n0oiDErbhMbJgFqEX9Xyg2cPhTj3ygoTNRv6dpoEjaWsRQUP2HQ1kEMyndr+nfsNrKKKPWRcSNDPwP7MexUXh84w8cH9wGAxlNmxdcB6D+qeGCO3vWPLXbjVnM/WZCDfL6YcLzbjfok18PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975772; c=relaxed/simple;
	bh=GyseGbmre/AUQLLd82Fd9EJWxFGE8hFbdkM2FerSBqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN5XzvslXlBJgH2q2TOo/dzfdHSksOCsRsaPXxh4yFTeCQio7yaxNNtplaUBEMGuWwJgefojubFTb6yxKaehGhAbtgJRU/TPROGhOHTf9gykb7DHiGwPS8dvNwy725gFUnvy8j9gltb+4R/pgFoyalWRkLaZ8Q2rV14G9WrkCWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWvZy6tT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWvZy6tT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A28D1F000E9;
	Thu, 28 May 2026 13:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779975770;
	bh=xB83MMQJtgx4blW20grTGAuXYxlz2Qs+h6trlIglCbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jWvZy6tTmXv4uK2QplcSaUgWUJIz92z+wKhi/zAmihpjBB2KWHqGf0DEnVSVk86uq
	 r5QWeFDoBUFGX134RmM8ZrZqzSq5O+xqC3oSwjHcwiCuGknN2M2Ei+7GuQmYezX51O
	 ZMbnL31fhJM+I5/7JGBFWMA4I1wTvooBYYUBPOCJyY1ftNzU5p8Aw8ndPOKE8P9h9F
	 HrxVYcEdsWly+3Os4Az8KFMGTTmMylXV+WAUPWh/f2IZy0YC/DptI4AjBY/wmRpYb7
	 j7glSISlhcmTvsI3G0e2JzzFARtcEgq80GfqjV3Ln1BI/NNEkJpbI+S3jhxiSodW1A
	 X9gq3AzK6tBhg==
Date: Thu, 28 May 2026 14:42:45 +0100
From: Will Deacon <will@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Enable stack argument
 tests for arm64
Message-ID: <ahhGVf3RSWuMk0ph@willie-the-truck>
References: <20260427234801.2104511-1-puranjay@kernel.org>
 <20260427234801.2104511-4-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427234801.2104511-4-puranjay@kernel.org>

On Mon, Apr 27, 2026 at 04:48:00PM -0700, Puranjay Mohan wrote:
> Now that arm64 supports stack arguments, enable the existing stack_arg,
> stack_arg_kfunc and verifier_stack_arg tests for __TARGET_ARCH_arm64.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c | 3 ++-
>  tools/testing/selftests/bpf/progs/stack_arg.c                | 3 ++-
>  tools/testing/selftests/bpf/progs/stack_arg_kfunc.c          | 3 ++-
>  tools/testing/selftests/bpf/progs/stack_arg_precision.c      | 3 ++-
>  tools/testing/selftests/bpf/progs/verifier_stack_arg.c       | 3 ++-
>  5 files changed, 10 insertions(+), 5 deletions(-)

Do any of these tests pass more than eight parameters? If not, then
they're not touching any of the stack stuff you added for arm64.

Will
