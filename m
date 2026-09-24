Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54C3EAC8F;
	Thu, 24 Sep 2026 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264921; cv=none; b=XILutmvVp9j1baFQaU4BdwaYEjDeLMFvMcTGVH6gFqcY0mopn0mmDElT8Mn5E0uCVS5ziHkmP8LYjsXxr0mg5Ssm7CO6lFYpOAsQBt6sEw79bDejP3VJukmPBI2fnm6X6nXA5A7Yov7SijbAyc9J87jMIBXnnrWl6Q65HlrS1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264921; c=relaxed/simple;
	bh=HLisvpRZLu8nEZDHRNFgCxsrgUpFlrGFkXzXtadU/0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JG0HFvLiS28GyQR/dUmsyLa0qzdPHZYyTjM4CHYMwkOBF1eMm+Vk68Y8ZD4uO7hy+66jbIGRD1jdxqQucPB4LsNYzOMFFk5eXctfh6qf44l/QaFGQCTvGmFCuVdJFS0qquT+EFSJKopKksO7tI4O06E0jU4jmGcMeVuy/HkM7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHzAM7SY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHzAM7SY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA681F000FF;
	Thu, 24 Sep 2026 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264919;
	bh=HLisvpRZLu8nEZDHRNFgCxsrgUpFlrGFkXzXtadU/0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=AHzAM7SYWMqk8PkwoBw1/dZQ9GWWjslMSDAaYr/0UlHzJvzw6u6SYcg0Xbacruq1c
	 6niHIUbH6fW2YpKnr2HHjd8sIO1NKmGNbkKlcNfJO/e6p5jDFY8C180IS0Jh2mPZmL
	 aB0JDrg7D3EhBD6eVWALjdH0Z6NsR8KnEs4ap0rRRGIGAbA4npXD8mfAl3WRILV15F
	 tAR08qwUSt2O5hnEErwyf6p5R9Qcth9Ix8BK1lT+uzOkzGaFINKxiF9NSgQTxiXjTo
	 wuqPHC3tx+U0fl7X6182Keen5engdz0nSn/0vPP9jhq5ynhzCQyyycffdFYBR+KQhf
	 6xa9+57hwOXWw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Alexandre
 Ghiti <alex@ghiti.fr>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next] riscv, bpf: Adjust bpf_func to account for CFI
 offset in bpf_jit_free
In-Reply-To: <20260923144216.934701-1-pulehui@huaweicloud.com>
References: <20260923144216.934701-1-pulehui@huaweicloud.com>
Date: Thu, 24 Sep 2026 17:48:36 +0200
Message-ID: <87fqyyps4r.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> When CFI is enabled, the actual BPF program entry point is shifted
> forward by a CFI preamble. During bpf_jit_free(), this shifted pointer
> causes the wrong ro_header to be fetched, leading to a potential invalid
> memory free.
>
> Fix this by subtracting cfi_get_offset() from prog->bpf_func to
> correctly restore the original JITed allocation address before freeing.
>
> Fixes: e63985ecd226 ("bpf, riscv64/cfi: Support kCFI + BPF on riscv64")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
