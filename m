Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337380;
	b=lPWv8GUkWMRSacS/Cakta2VYnycPv+tJXCGQuA0P/1qlIlYKF0OqFIHItYcthP9KRZg5
	 X9Gg+qYQZSmh5OAjgL5jV1vLk/uBQqEEI0u2wB1e2zeLdnEfx8fCtaN6iUgBwSIa2yqQl
	 B6Ew3OW4LsT+pylmKUrxzt7JzZZElg3of0euPVArXj01mN4le7v5HC0r63jDK8aM79Dai
	 R6VrI1Cjk+Jm1QHlqk3kZbBZCxBLuVzdVe805jwIkRBfj4egw/X9lVSzmGEns3rOWVxYB
	 u+cA7wi9BNlXAff4MG2TlSIYK03MQIdzP23iROnjrmfo0fnu2ImayqIbU3Nznb+6I2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337380;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0Nen3DE75lFZ06p2iNZ1cFUOV53MmCW0/dJJQgl8Lz8=;
	b=QQtIBv5NdsyECZVWIakuwWvFGyu4PWNc2myc9/OaFbFHpugiJ7y2tNFCejIIOR2c/7h/
	 crpi+ChyTN48ZCdPOIdCHvhA6uVpQ9VetSzlWnCAjQscUIcVTaIyH+8ZvUSFBAAl0dyuB
	 fLD98RG9irQogGfy3UM3pxgiSp89k4UY6144covKnaK+tsIYpJKegdmo6jiE9Qho50jD6
	 kgJTQc7gLJEMXr4avuzBdxrrQdac+xwjr5eTgjuvFnvk9q5NtQEQ4HxivbZyZpa5pDrfI
	 J4y2QgLTnW+Zoe62zkbNxKSdGr7Tv1NF+AxkQbXYogg2fun+1XGsfGnMwXpnSMmXFlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ta3ME0TX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A088606A327;
	Tue, 10 Nov 2026 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ta3ME0TX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3691F008A1;
	Tue, 10 Nov 2026 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337380;
	bh=0Nen3DE75lFZ06p2iNZ1cFUOV53MmCW0/dJJQgl8Lz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ta3ME0TXdyjvWLI8RTl/D/KZ8OX9eIxFE8UPaKUmoHdPpjemp7tE5UYSsEA2L6CRW
	 cgwohAtvbGVrQJIfaEdZBgeoaeRENsZIBNBiAOa3T2ub/q7g2ZlDykuscP9cTSI9pC
	 30iE+bW6Rah/0lNVSndbLQYrMidX0okCN6w+9u/kEVQliehneqd0xc97QGwKo7BhXA
	 Sn3Zr4b7fX5qYWipbipSYJ15Avc4tik8tcKOdsXEzBxQvy0CI6ip7NTIJpyreEieBV
	 b6CIolTXu7DrA7wTUQrNO6nM+BgPe4fWWpweg2ZgH48TkJJf+s0yAhdgAhifNidIOw
	 9qjcOvdQJmqhg==
Date: Tue, 10 Nov 2026 19:02:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Chao-ying Fu <chao-ying.fu@globalfoundries.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	torvalds@linux-foundation.org, olof@lixom.net,
	aleksa.paunovic@htecgroup.com, arikalo@gmail.com,
	Boqun Feng <boqun@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	Nam Cao <namcao@linutronix.de>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v6 2/6] riscv: build kernel atomics from LR/SC when Zaamo
 is disabled
Message-ID: <20261110-revivable-saint-9bcfaa2fd0e7@spud>
References: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
 <20261110-lrsc-only-v6-2-bafc3cc0fcae@mobileye.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yEOv5UU3yImNGsK0"
Content-Disposition: inline
In-Reply-To: <20261110-lrsc-only-v6-2-bafc3cc0fcae@mobileye.com>

--yEOv5UU3yImNGsK0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 03:20:59PM +0200, Vladimir Kondratiev wrote:
> The A extension is Zaamo plus Zalrsc. On some CPUs Zaamo is present
> only formally. MIPS P8700 traps every AMO instruction into M-mode and
> emulates it there, so the extension is supported but very slow. A
> typical uncontended atomic increment costs:
>=20
>   native AMO                                     2..5 cycles
>   LR/SC, private L1 reservation monitor         6..12 cycles
>   LR/SC, PoC (L2) reservation monitor       about 40 cycles
>   AMO emulated by an M-mode trap           about 600 cycles
>=20
> The last two were measured on the eyeq7h hardware. On such a CPU the
> kernel must use LR/SC for every atomic.
>=20
> Add RISCV_ISA_ZAAMO, default y. The default keeps "a" in -march and
> the generated code unchanged. When it is disabled, -march carries
> _zalrsc instead of "a", and atomic_*, bitops, xchg, futex and the
> early boot code use LR/SC loops. The sequence is chosen with the
> preprocessor, on CONFIG_RISCV_ISA_ZAAMO like the other ISA options in
> the headers, because the assembler rejects AMO mnemonics once -march
> lacks Zaamo. A kernel built this way runs on any hart that implements
> A; it just does not use AMO. It is therefore a plain option, not a
> NONPORTABLE one, and the hart keeps advertising "a" to userspace,
> which is true.
>=20
> The LR/SC loops follow the ordering convention of the existing ones
> in cmpxchg.h, from commit 5ce6c1f3535f ("riscv/atomic: Strengthen
> implementations with fences") and commit 1d84afaf0252 ("riscv: Fix
> fully ordered LR/SC xchg[8|16]() implementations"): a fully ordered
> operation is lr, sc.rl and a trailing fence rw,rw; acquire is lr.aq
> with a plain sc; release is a plain lr with sc.rl. The futex loop is
> bounded to 128 retries and returns -EAGAIN after that, as arm64 does,
> because userspace can keep the word changing from another thread and
> futex_wake_op() retries on -EAGAIN anyway.
>=20
> Zabha, Zacas and the ssamoswap instruction of Zicfiss are AMO
> instructions, so RISCV_ISA_ZABHA, RISCV_ISA_ZACAS and RISCV_USER_CFI
> depend on RISCV_ISA_ZAAMO. The riscv64imac Rust target emits AMO too,
> so RUSTC_SUPPORTS_RISCV depends on it as well.
>=20
> The choice is made at compile time rather than with alternatives.
> Nearly every CPU has a native A extension, and an alternative would
> inflate all those kernels with the nops needed to pad one AMO to the
> size of an LR/SC loop, at every atomic site, for the benefit of a few.
>=20
> Turning Zaamo off needs a compiler that accepts _zaamo and _zalrsc in
> -march. GCC 15.1 is the first release that does.
> TOOLCHAIN_HAS_ZALRSC_ZAAMO checks for it; with an older compiler the
> option stays at y.
>=20
> Three sets of extensions provide every atomic Linux needs. "a" is what
> the kernel supports today. Zalrsc plus Ziccrse is what this patch adds:
> every atomic is a constrained LR/SC loop, and Ziccrse is the
> forward-progress guarantee for such loops. Zaamo plus Zacas would do
> as well, with CAS loops in place of LR/SC as on x86, and is left for
> whoever has such hardware.
>=20
> Suggested-by: Chao-ying Fu <chao-ying.fu@globalfoundries.com>
> Nacked-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://lore.kernel.org/linux-riscv/20261106-smock-headband-d6a7d56=
8c228@spud/

I had a quick glance at this revision, and I think you've at least tried
to resolve the things I was pointing out. Did I miss something, or why
have you kept the NAK after having resolved the things that I was
objecting to?

Thanks,
Conor.

> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

--yEOv5UU3yImNGsK0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavNqVwAKCRB4tDGHoIJi
0vCIAPwI9tv4/veY1c2lX/x6cUlucNBdIPbCVw9jI0m16SyQIwEAwvrqq4Gw4cdE
G3N4rmccRtmc+qeZKgNCaWp7/G74kQ4=
=vYmX
-----END PGP SIGNATURE-----

--yEOv5UU3yImNGsK0--
