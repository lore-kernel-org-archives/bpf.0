Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A75233BBD9;
	Tue, 24 Feb 2026 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971083; cv=none; b=AgbHtFAb0jEynW7Df/RirQUURFpk274HOQqnyxqeWr9v5BlE+RawP3N2b3HKWB5CM27HBSv/YCd/3ai8SfLNEpi2rKXA9M4p/DRBXbQfTYQcNTSjvRNgBtLRSxj7E4s+3cQAisBEvCo0UOnZ83MHVckVDZAXtguLeuq/LnrKwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971083; c=relaxed/simple;
	bh=6ZqYqq4IRN85KW12SiEIDbmT9hRIl6C7svor3k6zd5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYQeA1EbdYQZ50J4+Q4/LwQDy0pps20lU/wt3mKUKn96t51pFgvuY/idm0x/VYqVgwQiL03YBwJ0wmh4CGOvGrI/Cx8gU122CDPfSm3oBCLvRlA/8gMbPJdVug0lKKtPIpHLfrS3+epmzeHMNaUt9IEOUHZ3hGYd8qe4KlHzp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxM7NCjh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxM7NCjh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D50C19425;
	Tue, 24 Feb 2026 22:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771971083;
	bh=6ZqYqq4IRN85KW12SiEIDbmT9hRIl6C7svor3k6zd5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxM7NCjhcWEDiqpj9bDwCgF7TJxK+cKbBrZfC9Myv2ik90QROYMa47BYsrUudAtH2
	 hUBKPBdJwYD47iETy9y3oJts3e0+LXquOb4zOT86xxalFU/jxXhJCGoE6sp6mXyAgP
	 5i4v3MqQzN6zOH2BzHOMpjoCcHEwfCRfFya25wgbuulo8P6UJGIuVy6XURO1ur1i7H
	 d2g4HU6isRIIlsNG+MyWxWiTkzqJles1AJp6J79/v+6V9CEnNaSBXJOXaBMMOD/BnU
	 8eX5CBGXFckqZgCAfK9x8KmKvOAD+CepXe3DTMoQ0gJkPHsW4ihoI3bIsV+6x4T1so
	 XHd1D4/RYriPQ==
Date: Tue, 24 Feb 2026 22:11:18 +0000
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: bpf: Fix UBSAN misaligned access in BPF JIT
Message-ID: <aZ4iBlzQ7kyxByg2@willie-the-truck>
References: <20260224092915.1925488-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224092915.1925488-1-tabba@google.com>

On Tue, Feb 24, 2026 at 09:29:15AM +0000, Fuad Tabba wrote:
> struct bpf_plt contains a u64 'target' field. The BPF JIT allocator
> was using an alignment of 4 bytes (sizeof(u32)), which could lead
> to the 'target' field being misaligned in the JIT buffer.
> 
> Increase the alignment requirement to 8 bytes (sizeof(u64)) in
> bpf_jit_binary_pack_alloc() to guarantee proper alignment for
> struct bpf_plt.
> 
> Fixes: b2ad54e1533e9 ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
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

Did you see a functional issue with this or are you just trying to squash
a UBSAN splat? I can't see an issue with the code and it seems a bit
over-the-top to over-align the whole JIT buffer just because of structure
alignment rules that don't really make sense for the actual PLT.

Does marking 'struct bpf_plt' as __packed help?

Will
