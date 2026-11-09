Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249131;
	b=rj5VtFYRQGGg7TMh0LL09kRQ4u9hKQXVgp57ajfXVd0FhHvTITJ5mpF46CZNwp9KSA/V
	 9e5xRspDgxYKMr5D2dtXB5T4s2G27mzz6dznHnolcl/9a0dhoOhuEVkqvwVbDLlgwX8bb
	 gepddjVGrbb+7nmU0Dz6PeEaALvZYQxl6xjsUaJL7QASJbadPN89X3fS2fIWDsrCY3fiK
	 6DkpgKyKfM76+t5hWR8NI1MJPBim6gjW3Df9mQONhbXVZHwJXzNb8Gy1KI+x+fQ+aKIXJ
	 PzAGDBSFpbooBZw66Yq/hAnLDbt8ClQgiDb1zqcu3pnqxD9XItuJzvJoLPFG/l/b+Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249131;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qDrZGbtE45lIKSq9OOM1oZZId39Cwf0gHnE2KBOHd5s=;
	b=oEw+zCbinrbnIREJhNSokJ3PlaHVOlRvQrSQkcVzKKvT6EFUtjBfU5bKRcm0PEn6ehnm
	 98st/Klvt1xBhmB+UZb4hFbhDEE3BTotz0vmK6vDykUKIiWAe8Y3wdCE+dYwGu65mzOHd
	 n0UU7+RWdWbPoSjZ1QASJhLDePhMvDIeAZQv7vT6VZRPXMfmChNgNiW+3jlrrRxdSWji7
	 7V5YHSdyDYnZc1O758LNPCBTp70q4IjS52BuneIYZlgJKOZkdAkv8nTkA3RABOEwqGwX0
	 BAxZTKtF7NLOfaPormzxApqizBZ0sTq167dvFSpqdT1AqMp80mPaZW2iGaq6GOimPUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxGAhb8J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8F606AFDE
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxGAhb8J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B50A1F008BD;
	Mon,  9 Nov 2026 18:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794249130;
	bh=qDrZGbtE45lIKSq9OOM1oZZId39Cwf0gHnE2KBOHd5s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GxGAhb8JqSOXx9iSdRKEhQ52j2h/RFp4fZhXeUZaJj+px0xbRR+jvC3xxOlsWNptw
	 WW1BkD9MSWRCm6ti2GhbliSRTXX3JIFFY3Iu8MbesIpgSlzfCDzpwN8NReSEOslPE4
	 Nv66Z+1tr1mRG4c5J3xLhtkf/1UDsg8cihypW3c5AqgPlSFM4Lf+Gch895xZPcz7sz
	 do/MzkHZvVpI3nOoSV5lzSUTKlrFBQljlotLBDWC87yA5ezjqXseiJg5qPFIOfv8Ct
	 DdiJraGGC2ZwSGYnEn97M7zvkwsz9ZPVdP0k0K+3X0pMEO6fpYNYz6IedjoLLsj4tJ
	 b0mNfNcNH4k/g==
Message-ID: <sashiko-outbox-205417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 4/9] selftests/bpf: libarena: Raise arena
 spinlock CPU limits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261109182055.7581-5-emil@etsalapatis.com>
References: <20261109182055.7581-1-emil@etsalapatis.com>
 <20261109182055.7581-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 18:32:09 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests/bpf: enlarged qnodes exceeds arena max_entries in
  arena_spin_lock.c
--

commit b35a00e6a80fa689cd0b2cdb4e1bcd8899fded17
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Raise arena spinlock CPU limits

This commit increases the maximum number of CPUs supported by the BPF
arena spinlocks from 1024 to 8192.

> diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_=
lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> index 560ee18fd287f..230bd112e8d59 100644
> --- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> +++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> @@ -77,7 +77,7 @@ struct arena_qnode {
>   * 16-17: tail index
>   * 18-31: tail cpu (+1)
>   */
> -#define _Q_MAX_CPUS		1024
> +#define _Q_MAX_CPUS		8192

[Severity: Medium]
Does raising _Q_MAX_CPUS to 8192 exceed the 100-page arena map limit in
tools/testing/selftests/bpf/progs/arena_spin_lock.c?

tools/testing/selftests/bpf/progs/arena_spin_lock.c {
	struct {
		__uint(type, BPF_MAP_TYPE_ARENA);
		__uint(map_flags, BPF_F_MMAPABLE);
		__uint(max_entries, 100); /* number of pages */
	...
	} arena SEC(".maps");
	...
	struct arena_qnode __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
}

With 16-byte struct arena_qnode and _Q_MAX_NODES of 4, qnodes grows from
64 KiB to 512 KiB (128 4-KiB pages), causing bpf_object__relocate() to
reject loading the arena_spin_lock selftest with -E2BIG on 4-KiB page
architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109182055.7581=
-1-emil@etsalapatis.com?part=3D4
