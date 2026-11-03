Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744116;
	b=GSqCLkW6LKWVlHLY5KVX9BukVHwuQwEuvhzOY8P06Sgiq9UZM/uRBh2eowUslKBepwAw
	 Bdf1HDpl2eFOwZbaI9DmNcvWPnGmHoFN8keALpL5FIifUWnk8WMbG6cC3fyTqIu5bRqPQ
	 x2abOpraWWcKyWJ2FF89XZ9E0NwHERG+Dzid4srr5sqGnhuSGBQzyKlSFWv7AZR4vgwM1
	 4dvLsQ5r6DLxwD9LT/IcFJpmgR8oxsOx479KZKWyGBdNmEL0qe7NOeRtsCt8055IvNKnv
	 OLb5Wh+WBBFGK9z+P3AST8ybHoK0u5WOiKjFEVoom+L3dPusuRsZXiuZwolC0Fnlm6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744116;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Mvv2wGJucIK4i40pMSN73E6sZVDFbcdjmQUxUgdeHA4=;
	b=PlKGda5+FDjBhrx2hspn0sdDBkssNVLBxAuy2mN/EtvP36M6qBPfFPeSNM9EXQDLrrgm
	 mL92DVMihj6+duhWRWkYqxFdoSKWT0S1QuGhEUkO8dyZ2i25auPo6883uALxgq4CF5LfO
	 TU6V+Y7/FS3uAKYtGQv6bDYvgvFZ3FYQuzhHIpUV3Z1mNtlEGQ41eHHAlOtFsHY0LjP8v
	 QydmbOyoNjKptymHf0a2HZnGcSFtpkOxI1OKqTGXurYQUTTrcPx/2sPPjhUVNh5qwjVY4
	 no+hVzYIM95oUiO1sN3YslFfkzj3p9mc0orS4EyR8xXmksDidiV7JfmXEGV4V6UJGaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzGiS8Fj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B21606D833;
	Tue,  3 Nov 2026 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzGiS8Fj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819FC1F00A1D;
	Tue,  3 Nov 2026 22:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793744115;
	bh=Mvv2wGJucIK4i40pMSN73E6sZVDFbcdjmQUxUgdeHA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XzGiS8Fjf22QyDqi3in3ikSRlUJDAV80S//Lz7bGTv7goh7nu9zjuNDDrYN7AYDTh
	 BCXSiTciuZaTWyzpmNjHprQGbrLqvrTUW1C3Jqcf0BizLpAnq9RVKsTEPVlPWvfTdJ
	 XeLcXRgolCPeq6Gf6oQhWrnLUusNt45v29ad8a8goKsRaeWoicng0wWrUusmsjlnZ2
	 OXcDSvy9nzs0IqMNloo6Sq9ZH/OQjGf5TJFYnK4D9E4O+sLErnFp9UiuDNz6TQkZ8J
	 80Pfw2ptCDLHdx2jSMNtTQMbF1ft226Sh3jtxY9RlRAZLU35vYTxrvCfxmbsv+h3+r
	 /273TGKHqhzfQ==
Message-ID: <c259191e-d72b-4237-ac58-16298ab5c04d@kernel.org>
Date: Tue, 3 Nov 2026 22:15:11 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/3] bpftool: Make the LLVM disassembler an
 optional runtime dependency
To: socketpair@gmail.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Nick Desaulniers <ndesaulniers@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
References: <20261103-bpftool-plugin-v5-0-683e08a25df0@gmail.com>
 <20261103-bpftool-plugin-v5-3-683e08a25df0@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261103-bpftool-plugin-v5-3-683e08a25df0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-11-03 18:59 UTC+0500 ~ Mark Korenberg via B4 Relay
<devnull+socketpair.gmail.com@kernel.org>
> From: Mark Korenberg <socketpair@gmail.com>
> 
> libLLVM is only needed for "bpftool prog dump jited", yet it is a hard
> dependency of bpftool: on Fedora 43, installing the ~730 KiB bpftool pulls
> in ~140 MiB of llvm20-libs.
> 
> When libLLVM is a shared library, don't link bpftool with it. Instead,
> disasm_init() loads it with dlopen(), under its soname read at build
> time, and resolves the few llvm-c functions bpftool uses with dlsym(),
> like perf does for libcapstone. Distributions can then make LLVM an
> optional dependency of bpftool.
> 
> "bpftool version" still reports "llvm" as a build time feature. Static
> LLVM, and LLVM built with one library per component, are linked as before.
> 
> Link: https://github.com/libbpf/bpftool/issues/262
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Mark Korenberg <socketpair@gmail.com>

Tested-by: Quentin Monnet <qmo@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks a lot for this work.
