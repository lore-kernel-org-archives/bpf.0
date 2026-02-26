Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174163876BA;
	Thu, 26 Feb 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130520; cv=none; b=PIvELhAL2lgavay5eJaDERUtRsRwNyyRX6UWHSAAFDk+zBHcH+7DePbLrIiz86pz9qUMdZhA1PHhcJN30hlhKPlNwBFbU1GLP1icHC9bd2P/fhT8n2PIzIuzokIlW5+sHWS9/9y5I1I05+L2s3DLo0xyLjVXYFoFTOsYKjQzUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130520; c=relaxed/simple;
	bh=oeZrAgJFMwqGZHSjk5nZ3zbz2F6r/nSnzcy3tZ0eXY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpNsEukkJf/9cumcl8TkYm0dvNzjmnW9VvpkXn4jA+7keT2xucOAo/kYt+MTYktULuA5v2Yn+KVtVppHadKZbFGU7P80VPEogM1KqaKvLx+468H7I85rZBDOPe/XOnMS1WDzo0hWk7bOs90HZA7MK5uCo3Dx53xs9Ny19RdE/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8/1orjP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8/1orjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C55C116C6;
	Thu, 26 Feb 2026 18:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772130519;
	bh=oeZrAgJFMwqGZHSjk5nZ3zbz2F6r/nSnzcy3tZ0eXY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8/1orjP1X94HWjRzto4h4vmRPu2QG8g68OkYZOh24/S+GensgXNzGqQ29TavR1ib
	 9aICWL1knlGq7TcrGD93EPt0C2UHmvYu2/wEmEHh+CUqbKh6pYCzxAX1OZPKBIz/57
	 Q+WW2p+w151zgGRO9zQVB8poh/U4D4TyydM+M9lZ0YTlw8WPxypZlPkLJh1FZC7Ii0
	 m1izZdv36Z4ZK28DAFU/SoRJySegWXfkIllPjpTnuEkvuBfVbpAK0GDRfBqFmjPkdk
	 NjoPr5QZ6xl6x2TdLVE2FPGR9yMZECx5wosnswAtSkx5mxQtcuXYpAW13fVMqope4i
	 1uMzB6mmLBL2Q==
Date: Thu, 26 Feb 2026 18:28:32 +0000
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jean-Philippe Brucker <jpb@kernel.org>
Subject: Re: [PATCH v3] arm64: bpf: Force 8-byte alignment for JIT buffer to
 prevent atomic tearing
Message-ID: <aaCQ0M9h1QfCPKGb@willie-the-truck>
References: <8b7050b7-f2ad-4237-890c-76fc13dc0189@huaweicloud.com>
 <20260226075525.233321-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226075525.233321-1-tabba@google.com>

On Thu, Feb 26, 2026 at 07:55:25AM +0000, Fuad Tabba wrote:
> struct bpf_plt contains a u64 target field. Currently, the BPF JIT
> allocator requests an alignment of 4 bytes (sizeof(u32)) for the JIT
> buffer.
> 
> Because the base address of the JIT buffer can be 4-byte aligned (e.g.,
> ending in 0x4 or 0xc), the relative padding logic in build_plt() fails
> to ensure that target lands on an 8-byte boundary.
> 
> This leads to two issues:
> 1. UBSAN reports misaligned-access warnings when dereferencing the
>    structure.
> 2. More critically, target is updated concurrently via WRITE_ONCE() in
>    bpf_arch_text_poke() while the JIT'd code executes ldr. On arm64,
>    64-bit loads/stores are only guaranteed to be single-copy atomic if
>    they are 64-bit aligned. A misaligned target risks a torn read,
>    causing the JIT to jump to a corrupted address.
> 
> Fix this by increasing the allocation alignment requirement to 8 bytes
> (sizeof(u64)) in bpf_jit_binary_pack_alloc(). This anchors the base of
> the JIT buffer to an 8-byte boundary, allowing the relative padding math
> in build_plt() to correctly align the target field.
> 
> Fixes: b2ad54e1533e ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 356d33c7a4ae..adf84962d579 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2119,7 +2119,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
>  	image_size = extable_offset + extable_size;
>  	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
> -					      sizeof(u32), &header, &image_ptr,
> +					      sizeof(u64), &header, &image_ptr,
>  					      jit_fill_hole);
>  	if (!ro_header) {
>  		prog = orig_prog;

Acked-by: Will Deacon <will@kernel.org>

Will
