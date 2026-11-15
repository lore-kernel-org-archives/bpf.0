Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794749867;
	b=l6T02FeXyVxg6ljpCbwBzGCaR8lkOdYQh6AReGM4t5pNVeG3voj/ph3tacKDQ8z/H3/h
	 lQeQD79iAb0VswG5RyRYx2xBtxcmgl9XiXwp+kFe874IEz/EoSMdAwPNVipdxJsoxzvR5
	 KZnju1rkuScg2VGEsR0JjoF2ZKTqsDJpImr71izY1WEbIi0j1SoQ9nEOGBtlWqt6F+J80
	 sjqXWW0dJqi6RXq2FMgsWnue62y0PWPOGIn835CBOpNW4e+djpqOQUl3LJoHxb5XCYKH8
	 +1ppp8mH3ziwdB2bcYaq9rFKlAeyC9s7j4n7L0AsvC+PgAkETkjcW5H0nK5qB9NE9Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794749867;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=DXgbDNc8MoITwG6XL1PCwv3Ndt81BI1V9dNVTbanmzk=;
	b=LowPOYTBfrQKLDloSLSMbQvEin+C7YXvtk5K3WXIwnq0LwsMiiHnFEG0A6I4MJKHdm0e
	 p3nwx5p4+2CSIkD5u5TZFeicmIdVd5gHPaUs5+yZUcwAKCS93vwWSSj8Y8vkniBwr7DDN
	 bscON/9k3FR32h2UToqXLIiddJ0Uzd3dGILRRRyaDi/jeHNKkayK6kIufqvW3cCOgIerD
	 ehhL+dSiZdspgI8S0z0aHGEI9tIb0Ku/haXWlhurFA6lQNBGaXc7CGuYl4KW1eReKKGB1
	 2wYonrUswK+3g0wRDrmq27IPcAgSJ8pFoDxtAjUGZzSwuGSzkShiU4AQSB6MYddGrDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gk3Q0jML;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A32606A31D;
	Sun, 15 Nov 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gk3Q0jML
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7B91F000C4;
	Sun, 15 Nov 2026 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794749866;
	bh=DXgbDNc8MoITwG6XL1PCwv3Ndt81BI1V9dNVTbanmzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gk3Q0jMLYFrsl1YQVVuzwPX+5aGWkqyiQPTGZFIoSQNti/ScEKUtUjGZsYP2z2YpU
	 JFf9GLi1+wbT8VAgtPsIQ5BQGlUsBlvLigWgAltZokkfgZ824BXNIlxXYoY9Wshhq0
	 sMSTKT9Whm6M7oQ9v9od4g60+kOvtqa3EfEg29HHZ5Jhi+ccunjf70jGmKu4WITR+T
	 dZX4hlzC/aT7BTU3+OiBZXfBUDnpVV7x0N/SrglI0r5YKs5tJ0gJYWJiKiXYTFFNXk
	 sC1pUW+LcO0eYgo3jeQGEWFpX7q8T8GLxCK+ZcUuvU92tOjD2yCRvy1G+rBB4NF0LK
	 8zqztGW7akXwg==
Date: Sun, 15 Nov 2026 21:17:26 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Mike Rapoport <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: mm: Pre-allocate module page tables for execmem
Message-ID: <avmw5hzuVxEk__WR@xhacker>
References: <20261016102847.96530-1-kmehltretter@gmail.com>
 <avgpqlpWf01mwo9P@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avgpqlpWf01mwo9P@gmail.com>

On Sat, Nov 14, 2026 at 10:29:29AM +0100, Karl Mehltretter wrote:
> On Fri, Oct 16, 2026 at 12:28:47PM +0100, Karl Mehltretter wrote:
> >   Unable to handle kernel paging request ...
> >   [ffffffff78000000] pgd=0000000000000000
> >   ...
> >   bpf_jit_fill_hole_with_zero
> >   bpf_prog_pack_alloc
> > 
> > Use CONFIG_EXECMEM for the module-range pre-allocation, as powerpc does
> > for its execmem page-table setup. Both CONFIG_MODULES and CONFIG_BPF_JIT
> > select it.
> > 
> > Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Acked-by: Björn Töpel <bjorn@kernel.org>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

> > ---
> > Changes in v2:
> > - State that the BPF JIT region lies inside the module region (Mike).
> > - Add Acked-by tags from Mike Rapoport and Björn Töpel.
> > - No code changes from v1.
> > 
> 
> A friendly ping on v2 of this RV64 execmem page-table fix.
> 
> Is anything else needed from my side?
> 
> Thanks,
> Karl
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
