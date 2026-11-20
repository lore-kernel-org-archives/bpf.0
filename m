Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210483;
	b=5B1Lpu9OdHANUj8XmMBMIszWmITQFYZJ1ZOZnFXPp1CzFsmvejYZAIQg3fhfPxX2PsKr
	 qflFe41Q5DDsGYD3wenXKRNsXRbJ88QSrUDw4wDw+H2LH/6mJ46jAEQQFwXpbTSdtXDMM
	 xKuwpBF2XyH0RXRc93e/uZmtKwWUrwU9OX45asE4R7Jtj6gTNRkJJSOPuykG/Qp7/+ii9
	 qnx0m9tbkJuoIkxVLsot2opIVF8n5gnAoOoIxfY/694ZxaxXoUfaVvr9XAshlagbv7Fa7
	 FITyv2q2X3856QYyHBGanR5TcA73oRvOaTMVUZ2Bsd/JKDh5cXSH7EX0SKLwd5h6k5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210483;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=osxFcrXFsZ10Rw34Pp4DNhCUdffhqgh+kWswa5nw8ow=;
	b=Y4CXZ7D/4DWwixA6I/bWQcxlPdqxU1iKkIuqCve4irNReH9BVWGWTu+UrzFEF1HKF8Yq
	 wC0UXvVuDc+/pgCdioGNTwyx5qwhPPa7kFd/5xLoasu/z6zV1bkhUwD1FD8iIIaHkzNav
	 p4i2Vjbaysh2nUH89A+gZknYKQU6KQsvJBZe0+x2J8Gb5Eexe/83qhpkOV51rcL4MwQ+J
	 M5ltRS8+QHYDpm7L4avlQ69kXOQJYsCAptvgAKPBgUsbBI1zbzV4IV0RfJVW7IsQG1wCP
	 CUGyBp4bOUiH8OD3TMD51XSHnRMR9Tr2I56vnpoQ0Djb7JV7l94chMfH34Zpj2AM4tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMsH60BN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009F60A2601;
	Fri, 20 Nov 2026 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMsH60BN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3EA1F000EE;
	Fri, 20 Nov 2026 21:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210482;
	bh=osxFcrXFsZ10Rw34Pp4DNhCUdffhqgh+kWswa5nw8ow=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eMsH60BNDLAyg5oWX3GVPeMo3tj8QACBC2SbVElKFH5Jj4OHo0aADZMwQeJ9cN++1
	 BF0DMWT3g55GCuZLQ2XsPluj6yBIXn8jVfFB3PFrQ+u1HwWPP/BqcF6RfF/v9GH/0O
	 5KOWc6fgE3+8z+FnjeDklx0P8EDCD4uKIqm1fdpM8oPvQBVlHg6K9b44k9T6jNwp6v
	 13qHztTWtz3QNHCmPN+QUrUNEyIRCUqFivs0P111cHENeZ7IYOFIxUTV+43zjknoT/
	 PsCG660E3Ny9gStBA2I9m/D7y6XdGcDT2AtZ0wLZrAcdV/YRoUgGqHTeWjX8JbwzZs
	 WFdUQZ2UaVwug==
Content-Type: multipart/mixed; boundary="===============5420069646821151809=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <879cbd5d4fae85a5ccdb53e5e89ec64f6039e1017b62e548daecbee9bc05e900@mail.kernel.org>
In-Reply-To: <20261120-bpf-ringbuf-fixes-v3-4-ff7ca15d6c37@kernel.org>
References: <20261120-bpf-ringbuf-fixes-v3-4-ff7ca15d6c37@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/8] libbpf: ringbuf: Add a caller-owned iterator
From: bot+bpf-ci@kernel.org
To: tamird@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,arighi@nvidia.com,xukuohai@huawei.com,andrea.righi@canonical.com,billy@starlabs.sg,void@manifault.com,ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,awerner32@gmail.com,zeffron@riotgames.com,andriin@fb.com,tamird@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:34:39 +0000 (UTC)

--===============5420069646821151809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: ringbuf: Add a caller-owned iterator

TL;DR: The new ring_buffer_iter_new/next/destroy exports in libbpf.map may not
follow libbpf's double-underscore naming convention; they become ABI once
released, so should they be renamed?

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map

[ ... ]

> @@ -479,4 +479,7 @@ LIBBPF_1.9.0 {
>  		bpf_program__load;
>  		bpf_program__load_strategy;
>  		bpf_program__set_load_strategy;
> +		ring_buffer_iter_destroy;
> +		ring_buffer_iter_new;
> +		ring_buffer_iter_next;
>  } LIBBPF_1.8.0;

Should these three names follow the libbpf naming convention for object
methods?

Documentation/bpf/libbpf/libbpf_naming_convention.rst says functions that
work with an object are built from the object name, a double underscore and
a part describing the purpose, as in bpf_object__open and ring_buffer__new.

The other ring buffer exports all use the separator:

  ring_buffer__new, ring_buffer__poll, ring_buffer__consume,
  ring_buffer__consume_n, ring_buffer__ring
  ring__consume, ring__consume_n, ring__consumer_pos, ring__producer_pos,
  ring__avail_data_size, ring__size, ring__map_fd
  user_ring_buffer__new, user_ring_buffer__reserve, user_ring_buffer__submit

ring_buffer_iter_new(), ring_buffer_iter_next() and ring_buffer_iter_destroy()
look like the only ring buffer symbols without it, and the iterator is
created from a struct ring * while the existing per-ring operations use the
ring__ prefix.

Once a libbpf release ships these names in libbpf.map they become ABI.
Would ring_buffer_iter__new()/__next()/__destroy() or ring__iter_*() be a
better fit?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44815895103
--===============5420069646821151809==--
