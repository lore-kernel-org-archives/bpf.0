Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE03F210C
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975755; cv=none; b=SdL1j/2k+qw04EnPElP4WWoBlr0wM6W4eEprmOLnZE2Y1KdTUVDxDGXIxruJGRC7GI3y6WB4FKq6TT49oJ/XlRclvZ8XhII7h8UbJeF/ltujx3Ys0u/LyUvBlUXCR3LLuaJ6/LWpx69Yl6yUOyYHR1n9dA+qBde/c9CdqyXT8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975755; c=relaxed/simple;
	bh=7Ne9XUX7pf2i+w9IypsJo3JexjfBLfWOpCVBBy1LOT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIWU8aqWNfBeWDXPtw7J5iyh9XB3pSCxdL0RkTi6OzefdG0lKZod+Ndrx0rFJSCGELofD6DKaI4dq9JsaBdjHFjqBzByHOBgQAngkOseCKuVQpu6L0xCMHXrfayco/mGQEhk5DnT0wDrIqczqOrerIaE7vxkSxWAWL3GbY7iQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/eOirRt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/eOirRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F1B1F000E9;
	Thu, 28 May 2026 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779975754;
	bh=5iz8ds4uZ2EdfTix40+LNtvuVP+Qe5SJurgkLudTtf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S/eOirRtRg+k9VxeW6cpoCGScVER7L0A1GqHjWMZGjObpzAi7rvaHZZBu9euEosWN
	 elg3rKSSMkJFV7O5icFbkbAV6pYAglZGtL/5TphWk1AN0VdOKt9dBxJs5jXtU5RbAG
	 TyOB7x92Fv4C3N6UKBJxYmCQhCCqBNJwd9YuvN6gGSED3+5/Bz5BpkLuiEZwi+mQAl
	 8xCRUKrQAbvujN/wzDQi0WtjiZxDnxJtGMixV9lW2FJ509ux3aJTvMx/a3p2L01sTj
	 C9rrf7EHngjvrhtbTb0h+GvxlEk5o5SYNMF2HV019QRcpjTFvBGcV5F6LSR3Q12vtY
	 lRbK4SVBt8nqQ==
Date: Thu, 28 May 2026 14:42:28 +0100
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
Subject: Re: [PATCH bpf-next v2 1/3] bpf, arm64: Map BPF_REG_0 to x8 instead
 of x7
Message-ID: <ahhGRE1efWfKsvZW@willie-the-truck>
References: <20260427234801.2104511-1-puranjay@kernel.org>
 <20260427234801.2104511-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427234801.2104511-2-puranjay@kernel.org>

On Mon, Apr 27, 2026 at 04:47:58PM -0700, Puranjay Mohan wrote:
> Move the BPF return value register from x7 to x8, freeing x7 for use
> as an argument register. AAPCS64 designates x8 as the indirect result
> location register; it is caller-saved and not used for argument
> passing, making it a suitable home for BPF_REG_0.
> 
> This is a prerequisite for stack argument support, which needs x5-x7
> to pass arguments 6-8 to native kfuncs following the AAPCS64 calling
> convention.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c                          |  4 ++--
>  arch/arm64/net/bpf_timed_may_goto.S                    |  8 ++++----
>  .../testing/selftests/bpf/progs/verifier_jit_inline.c  |  2 +-
>  tools/testing/selftests/bpf/progs/verifier_ldsx.c      |  6 +++---
>  .../selftests/bpf/progs/verifier_private_stack.c       | 10 +++++-----
>  5 files changed, 15 insertions(+), 15 deletions(-)

Makes sense to me:

Acked-by: Will Deacon <will@kernel.org>

Will
