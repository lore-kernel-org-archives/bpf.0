Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795346770;
	b=VvEhCX5TSzqW/OWZzknD1im2keMs9gRkVEg7hahWIpp8MgZgRrlrS/YKzPeSLi2xZVSd
	 WUMq6LPs9sO1snMFT9xdENrDyAegCRpXXFts8U1vMCuPLr5oTQbbz9L9s0UDYqNBvx8Sz
	 RF5ahXQf9nr21M3d2A1La4o6OBCEwvLueGsQ43ZvQOtGbdRkaP5hShK2mf2oTR7TW1yve
	 xJA1s+A1n5H+pv6DF4w/0xkcSkeeyepZ7dKzhsImlV1h9R/t97hoDxCq8m3bhOrcGrzPm
	 3FStrqy6o0Wmjj35rG1iqORsmuGx3ViPwA4Li+9nATmNxhTjOakb/yd1NV3JyLyrivA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795346770;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Yo4OyXgsbDZvOTNjPCohqryanR5Sy6EJCm3Q+WjnVhA=;
	b=DcxRmnhID3cXaDbMas3F0/nBlgCjXIH6i8mLq7JRSY9AId6/amAw00WIWgAXuO8HepRV
	 dPv5jeGyQnObnwCvvH1REZro8EW2nWzD5z3kn3gnGjVigc7J4DUEX1XuyX0Qg4tcrD2We
	 G8UNxzldYhz+/eTi0+Uxw+ercoBsJe1F4X7Umwmlo0jCYhvlnSZNy1tRG9hcwTJqw/KkU
	 SM52BQckQF7uzZN/+9b6fmbNZ/jUfFexYzwybeHTj6kGJSU/WslA1cYz1+6TUtWmBPNYw
	 WRRI+nvpxrR4sgrruoYGVZYsaCCZ2H9vscetVGlaOhOqkYqAm9MmpJsLNImsfw65ltA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLBiCrNd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F24606A320;
	Sun, 22 Nov 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLBiCrNd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FDF1F000C4;
	Sun, 22 Nov 2026 11:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795346769;
	bh=Yo4OyXgsbDZvOTNjPCohqryanR5Sy6EJCm3Q+WjnVhA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NLBiCrNdZcA2MVv8FiASBBH4kJiWgzyfk1BDTo9TKUNaBbLkWAND0nXJmgXt+vSyY
	 EBnYOSx97b+FUNaouJBdgIYBibU3JMl/vNUayZ7XQSVW5Wh68yUwzrekcN7uH2gt/6
	 DYTxREkjtpA8lHVFVf/dCUsThwDNHTRJ8YDz+nk4WSaxLcSINveLD/dyk7jzwocODu
	 0nheYprry6AnOLosQp1sOcEXEK68fO1dcEFO5ONyFMUUAT5ZjmNemh8TpLdNfXV/TS
	 SZxAkSfanDgOg31a7XDCeHs+XUhAbyzs8rjblti9grLdcexwK+yEwUw5OVQEJAoTJR
	 QxihemA+CiYmw==
Content-Type: multipart/mixed; boundary="===============1811446893963645883=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <47fe648c11a1926326e2c6ac5fa1275b8eaab628d352c192811051516e36e54b@mail.kernel.org>
In-Reply-To: <20261122103838.244974-3-abhishekkhade69@gmail.com>
References: <20261122103838.244974-3-abhishekkhade69@gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/2] selftests/bpf: Add selftests for bpf_memmem and bpf_dynptr_memmem kfuncs
From: bot+bpf-ci@kernel.org
To: abhishekkhade69@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,memxor@gmail.com,linux-kernel@vger.kernel.org,abhishekkhade69@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 22 Nov 2026 11:26:08 +0000 (UTC)

--===============1811446893963645883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add selftests for bpf_memmem and bpf_dynptr_memmem kfuncs

TL;DR: Nit only, in the memmem selftests: the (void *) casts in the
bpf_dynptr_from_mem() calls may be unnecessary, since the arrays aren't const
and other callers omit them.

> diff --git a/tools/testing/selftests/bpf/progs/memmem_kfunc.c b/tools/testing/selftests/bpf/progs/memmem_kfunc.c
> new file mode 100644
> index 000000000000..8abd06e9758d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/memmem_kfunc.c

[ ... ]

> +SEC("syscall")
> +__success __retval(7)
> +int test_dynptr_memmem_embedded_null(void *ctx)
> +{
> +	struct bpf_dynptr ptr;
> +
> +	bpf_dynptr_from_mem((void *)bin_data, sizeof(bin_data), 0, &ptr);
> +	return bpf_dynptr_memmem(&ptr, needle_null, sizeof(needle_null), 0);
> +}

this isn't a bug, but are the (void *) casts needed in the
bpf_dynptr_from_mem() calls?

bin_data, needle_start and oversized_buf are not const, so they convert to
void * implicitly.  The bpf_memmem() calls earlier in this file pass the
same arrays without a cast, and dynptr_success.c passes map_val directly.

Dropping the casts would match those callers.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45015018001
--===============1811446893963645883==--
