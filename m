Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849295;
	b=QVwP4tgnSTIOF1UsUJsY7CqlAaaom2El7xPV+h1qeEuMiawzTE/xrfM+FoqyJJN58f1a
	 +ikX1yfAHIpxWuCL4JWY19jzW/6D+U3lRD3Zntv+X6WMXZK0Yu/wxVP16TNCf6ddGVbMo
	 Wc6sh+ntHXzd5sqLf6+GFRFJoViFcbf5dpRoGSnmR5GnM+ARHU0WOKtb6cohOEaAaAhcJ
	 lShbPS1PpJ3klFMWt7aa7Q5gzbGD5U+yB6rkDl7m91ORVRdo8WZr62MU/1n9C0vQOrHoW
	 mmYZ3ldklYWlh+JM/tmAP6R0otcRCGwNgylcyIWwRgtXxaVlQUlkW71jomHw20qzOyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849295;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R3AayEltuaPaSc8ERAQfW5YeyfzxTpEYZhzgv4GQkHY=;
	b=SS+ZxP0PaJwui4VmlimUJK4zzXQYRSCrIcNjrVoHpnbYrSJTJ+VbCdgBIDPux5jxPyyi
	 W7u8Inrf2bIPaR8FpP6fWChibGva1N4KbjCu5b3hQMu7dajDLBl2fi0SFK3VLhFwgyk6+
	 YiP2b1GGoEc3j0nKiMGC48ySFHSrFRH8sYoKbh5nl5Cjp6VLmOPQmxHKFeopzHvUsDvLs
	 RRtTVGXiN2q71uYj+jprDGUDmDMKY1OYeEu7vxJAPzbROvox7JXRox2GL8zdLDwQDanqp
	 7KeAoZqvpeoLF3Na+K//vALcVGpiHWogdjJDWBNfhyoRNAA94+/D8uCEu0yCFPIFkFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ToaMIdu/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1DD606A329;
	Mon, 16 Nov 2026 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToaMIdu/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB661F000C4;
	Mon, 16 Nov 2026 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849294;
	bh=R3AayEltuaPaSc8ERAQfW5YeyfzxTpEYZhzgv4GQkHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ToaMIdu/5Nw6gYTd8dKnI+IbBbxNZgnb4fzduNfFHN9sWkkaCbz70GToCW+nEDm4Z
	 9uF7aB4TmCTaZug50b7ulcfEcxnEmVk2y6hiNSjA7jeGkGkT/ShZXqpwy4hLr9/aj2
	 6NNvcIDIQJyhn921LolKVZXRXN1h4Ga0LhQtINeSDy8hIqBMGS+mkousnN6WdK46gS
	 HsC7Ssh/0Iajvpgfbo3BwuIO222ho/1CZeWVo1XVKShBg67CwppzE5LJyhKkteezT9
	 hDnjr1Y0MiqO1CP017SxVisOiKTO0ep8ghfKbj8w4YBnPbOdKVd/ClnQqPqoHRyDb7
	 tFmEJTYAzrZ/Q==
Date: Mon, 16 Nov 2026 17:14:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
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
Message-ID: <20261116-manifesto-edginess-7f1663f9a76b@spud>
References: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
 <20261110-lrsc-only-v6-2-bafc3cc0fcae@mobileye.com>
 <20261110-revivable-saint-9bcfaa2fd0e7@spud>
 <3308062b-9d0f-436f-a22a-217cc1c59aed@mobileye.com>
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
	protocol="application/pgp-signature"; boundary="Y+J9n/Hla/zwW0HU"
Content-Disposition: inline
In-Reply-To: <3308062b-9d0f-436f-a22a-217cc1c59aed@mobileye.com>

--Y+J9n/Hla/zwW0HU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 08:37:23AM +0200, Vladimir Kondratiev wrote:
> On 11/10/26 21:02, Conor Dooley wrote:
> > I had a quick glance at this revision, and I think you've at least tried
> > to resolve the things I was pointing out. Did I miss something, or why
> > have you kept the NAK after having resolved the things that I was
> > objecting to?
>=20
> I'll be happy to remove it. Was not feeling right to do this without
> your permission.

IMO, if you sort out what the NAK was complaining about, you can drop it
without permission. Worth calling out in the cover maybe.

I'll take another look at this later in the week..

--Y+J9n/Hla/zwW0HU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavs5/gAKCRB4tDGHoIJi
0kGoAQCWFf5JHxUi2KeNm9DOhemQnYUrlSxe7T4A8/hbZExUSQEA9loerGhdWm8V
n/SfaKiJfp1FHsN6OT9U8lG0cS4ZPwA=
=yrBS
-----END PGP SIGNATURE-----

--Y+J9n/Hla/zwW0HU--
