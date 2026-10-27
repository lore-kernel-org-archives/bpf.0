Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793131211;
	b=Roz2Ltq3fd7k8kVyTIBKf7XsksZNhTVtxGllDO6WX7LPenaQSEzD+v3O7yyIneSbP5PF
	 aWQVMsaKoJgKgPXAKipNVwgJtTz97l+ZrHOqCbOEvWEZgw2EwYd7p8u1Q0CbNvpm3Ua/m
	 dFHhDR9NrVp9AB3iFuTVtLF6SdLP/QRPmMdKRFgMNmVjQK4T1iFf5+llyyn9kt/gyfcEp
	 ZFcF2f8MIZWsz4RPU9FnjADo6Rkz4OdTQ4WXFPJxBp2hBRcH2OQQa5KLL9Cz2dsazUlRc
	 iloiHwaXuKkXlW6lQb1miV4/YRfef20LSwkEcWDJWJlX30flzAOY8QzRmOJGXLB/zzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131211;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=M+p4uD4bw4Q15g7UNv4/ug73jnuHvxb+UCOa6/M9xhM=;
	b=eF/j0JXqYKy20pF43x3uDb8KQVaC7S7i8AVUF21tIkDfH/BrQsJZ+S4Rn+gdZUutCVl7
	 ZVuT1N3muJoyHlVlEbgNYH9RAiZwbkYzuQsDHEOvNWuh5XAZnJGgat9kdUASKEGiPzM8I
	 6VgS0L59FrL/Wvmsv8CKYJp0mKL3Fia9RhaAxOgY6mfIhegFtMh2+nU2Uy90DFXS8fMkR
	 +Dd+dh2YmsXma4wo3Rdzk8OhzkUZOd0JVLVOZXY73cZf6PdSLBIRVpDHW7nAr7aPxTJLb
	 ZxsgoRxkYj7YD0HPT86zZshFXIlBMN9YDxbwAjF1V/VDhqSr/cpgTbEm9dy+l9D+57w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0KVOyCK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A55606A31F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0KVOyCK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBF71F01825;
	Tue, 27 Oct 2026 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793131210;
	bh=M+p4uD4bw4Q15g7UNv4/ug73jnuHvxb+UCOa6/M9xhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=W0KVOyCK6InMVryKnPi+JsaYnRfnhDKIzngTCLQyQ82kWSa+8U6oCKm389pCeuMKu
	 32Kh4mlHrDuPdkTHNLxwGnoWE8iilB7WNN83gS7o9EY6ecGyEhrWpxt2Qz/GxfKyjD
	 D+UViVYH9JQ9K/1p5CGFtuCPkCcS8pFZZBWCXwOf2c+SZtoHu/RgpnJbgaqJOkDA/D
	 q2oOqjHnQ4YBYY5cRZZW7l6pJBUWA6EjVOSrZaPKp/+fVDn4v98PGJZoTXcwHGWofh
	 dQZDFdCVoW8CSh78222288SXCroOdP+ds/e8uQPNttXQUloNQacOAvBiNCd39HFaLc
	 59toxRj0YYndQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't hold pack_mutex over arm64 IPIs
In-Reply-To: <20261024031046.625578-1-alexei.starovoitov@gmail.com>
References: <20261024031046.625578-1-alexei.starovoitov@gmail.com>
Date: Tue, 27 Oct 2026 19:59:56 +0000
Message-ID: <m21p9avrr7.fsf@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> From: Alexei Starovoitov <ast@kernel.org>
>
> bpf_prog_pack_free() calls bpf_arch_text_invalidate() with pack_mutex
> held. On arm64 it interrupts all other CPUs and waits for them:
>
>   bpf_prog_free_deferred
>     bpf_jit_free
>       bpf_prog_pack_free
>         bpf_arch_text_invalidate
>           aarch64_insn_set
>             flush_icache_range
>               kick_all_cpus_sync
>
> When many progs are freed at once, every prog load waits in
> bpf_prog_pack_alloc() for all of these broadcasts. On arm64 hosts with
> many CPUs we saw hung task reports with sk_attach_filter() blocked on
> pack_mutex for minutes.
>
> The bits of the range are still set in the bitmap during the
> invalidation, so nobody can allocate it and the pack cannot be freed.
> Drop pack_mutex around bpf_arch_text_invalidate() and take it again to
> clear the bits.
>
> Do it on arm64 only. x86, riscv, powerpc and loongarch take text_mutex in
> bpf_arch_text_invalidate(). The frees would wait there instead, and the
> load would wait for them in bpf_arch_text_copy().
>
> Tested in arm64 KVM guests with 16 and 96 cpus on a 96 cpu host. cpus/2
> processes attach a cBPF filter to 256 sockets and close them in a loop
> for 20 sec. One more process attaches a filter every msec. Median of
> 5 runs.
>
> The loops get more done. Sockets attached and closed in 20 sec, in
> millions (higher is better):
>
>              before  after
>   16 cpus       1.6    4.7
>   96 cpus      0.38    4.2
>
> setsockopt(SO_ATTACH_FILTER) of the process that attaches every msec
> takes less time, in msec (lower is better):
>
>                 16 cpus          96 cpus
>              before  after    before  after
>   avg          0.97   0.18        11   0.54
>   p99            20    2.8       421    4.0
>   max           204     90      1738    255
>
> Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3030beb531d9..0fef87cfa152 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1069,8 +1069,17 @@ void bpf_prog_pack_free(void *ptr, u32 size)
>  	nbits = BPF_PROG_SIZE_TO_NBITS(size);
>  	pos = ((unsigned long)ptr - (unsigned long)pack->ptr) >> BPF_PROG_CHUNK_SHIFT;
>  
> +	/*
> +	 * arm64 sends IPI to all CPUs in bpf_arch_text_invalidate().
> +	 * Don't hold pack_mutex across it. The bits are still set,
> +	 * so the range cannot be reused and the pack cannot be freed.
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM64))
> +		mutex_unlock(&pack_mutex);
>  	WARN_ONCE(bpf_arch_text_invalidate(ptr, size),
>  		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
> +	if (IS_ENABLED(CONFIG_ARM64))

Can't we do the bpf_arch_text_invalidate() before taking the pack_mutex?
then it works on all architectures and there is no lock nesting.

Because the caller owns [ptr, ptr+size) until bitmap_clear() so it
should work.

I can commandeer it if you want.

Thanks,
Puranjay
