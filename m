Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF54418FC
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931706; cv=none; b=L1CY4dweLGkypBRC4JYQMskKuDLyWfzUoNxEId69Y7z1DfN4pcsoF/ALic/i2804b32hNy+Y4fYgrj0YU8nooSEoODcccZOpw2JA0zqg/8Tpx1RNhcH4jGZ3gtmpkWnRjfkOSL9iJPSyhvXntmYudBa3o6lHL1yF//3+aOuQ7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931706; c=relaxed/simple;
	bh=KS8mCNBYfPwO900RIuZ97F5SmyGc3OhWN2Izos81IfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BfUbC3nYnsy+M0vP3dJRU9S3Tc73oZWEOqCPAD6rz6+QRvGO7s6mx3N90U0fTWvig95bb7cSTLRlFDrnqgFqr7BIfaU46XylP9va21Shs5qJu92jM538/DaU39UD6C4fpthfU69hJJUyNcOtMAo8SrupESGpPCuAeCIHztNeifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdsDEYyp; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdsDEYyp"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7774114eec.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768931704; x=1769536504; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Zkk8Rbl5UtyAFvKLFxnlSYhtBzOt3i2r/yOWe3G6LM=;
        b=QdsDEYyp1nQu9i0VDh0MQvtMzZTlMZFk2coVgfRqGYRlBEY4B8dnMGIuA5hXrTxEC1
         JMcsTejg5t97f1JRitW3HI720QK129l4Z8qQ7Mwn7GPgBHyR0DjOzxBMlMqZLae2bgke
         HXRdYqR80d0rnZgaReH64BB24/LXONjR1AbbctU9XE9jWp7Xy8z2MTjCykKT8kOxN5wA
         jMdpdUaTRbeG1gsVjhb83WwWhWz+o1mymhF5fR6U28pIlBMT5nbMsdM0qwMwlJw1L4Gh
         tgrIknfldBiqB04DraAusko5duhzhR3ZP1504Yjl8kaT0iSIR0o1mCyFQE0RPjxBlawb
         yU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768931704; x=1769536504;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Zkk8Rbl5UtyAFvKLFxnlSYhtBzOt3i2r/yOWe3G6LM=;
        b=cwcCrRlQVilFQ3bL793xi6gAxNe5hx18Zsgcy8O49yYDqSVdA2L2A4tju3hv/xeaY2
         7YmRiXVu/KkAO8SehcfE5yLPaVsqODQuGYJ8nYMvPTCABwGeVoJFktvhyUSF57Z9A9xg
         Mn7Sm6T3CAfHa7kUr961Px/dUZqGQB9K0A1VTNOD9HCJvGMUlrRz6ZDdEg/m6ZLFOp36
         re9EAiJGEjzJ/nJATvu3U6awArrBT19+aE4jI7mqQRy9zIbeXIevybjDDb56EFN9RicB
         xnq1s222XI2313rzNcGo2XK7zjEfG1a/Ca4ugzLTZDw+6xHtR9KxCW0zNPGYPdUEkuTr
         gnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW/0cGmamyfCi+/YP583X8zExGq0R+7bM3TFCpevCgPzjUH6fpdczeDtD9rLCVa4oTDSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyisLvfy/+erVPT4Hce5m84/4Yx01hGhASel4tpc+z45Rahb5Hf
	m9PZWacq5J3kmXjk+Sw/gBybfGedXV8BAnjX+00I3FWxjtlNx4pLz4uD
X-Gm-Gg: AZuq6aJ6K5tEKO3dPNNGgqHlRzFbU1qlGOEVaWtjnzzbQrB/767vz/gMm+/PyahAF8E
	cPDQgXyIpP6LCj6vruzhtnk4Rd5lIu//5KETMOuhzuA68tU5PfiBs993Wi64nkWcUHbwZ8eqCwP
	RlH8vEthZjaoTZeIEjtjxcZJwOuNgQk0Yxnvm2wdeETzgB5lESHFpiB1f5qk+LCNhHgtStH6e7m
	0drg9DnVaCUS8Nm3C/Sv2impAMwECJr/FrSJO81nbWDni/3aI9Z0xzp1OVrd0vt4pjy+HzMuC0E
	P9YxmaLoErzUC+pfubljhlvTY9xWmQFSxOWU53rH6kLgAT4OGKKw4ZkqjbsAn+eU8eCiFwOIta1
	cTU/H92z/39M9Rs5tYFsJC8BzCEOmJ7AN0/KK708ZwmQQZ5Kcsv6hhN/Hm9GQH9ABzu12puaY4c
	DWhfq4lCaOn19CsJEqeLGvd/FYcO3fdvry3Q403Mmo48lHKI2MvU2pDLgRXWTiNV2oDsmV
X-Received: by 2002:a05:7300:6ca1:b0:2b0:5a77:5753 with SMTP id 5a478bee46e88-2b6fd78df36mr1990065eec.21.1768931703406;
        Tue, 20 Jan 2026 09:55:03 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c0f7fsm17960598eec.3.2026.01.20.09.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 09:55:03 -0800 (PST)
Message-ID: <5ca8756f0387e5b2be47e9522b1f4b5fc149768d.camel@gmail.com>
Subject: Re: [PATCH bpf RESEND v2 1/2] bpf: Fix memory access flags in
 helper prototypes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Zesen Liu <ftyghome@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski	
 <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Daniel Xu
 <dxu@dxuuu.xyz>, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, Shuran Liu	
 <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, Haoran Ni	
 <haoran.ni.cs@gmail.com>
Date: Tue, 20 Jan 2026 09:54:59 -0800
In-Reply-To: <B91D5A7E-4967-416D-A2AC-CD3428F3C702@gmail.com>
References: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
	 <20260118-helper_proto-v2-1-ab3a1337e755@gmail.com>
	 <55f01664fc714615206cc8d100cabf4f310f2302.camel@gmail.com>
	 <B91D5A7E-4967-416D-A2AC-CD3428F3C702@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-20 at 11:39 +0800, Zesen Liu wrote:
> [...]
>=20
> > On Jan 20, 2026, at 04:24, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > Q: why ARG_PTR_TO_UNINIT_MEM here, but not for a previous function and
> >   not for snprintf variants?
>=20
> For bpf_get_stack_proto_raw_tp, I chose ARG_PTR_TO_UNINIT_MEM to be consi=
stent with its siblings:
>=20
> =E2=80=A2 bpf_get_stack_proto_tp (bpf_trace.c:1425)
> =E2=80=A2 bpf_get_stack_proto (stackmap.c:525)
> =E2=80=A2 bpf_get_stack_sleepable_proto (stackmap.c:541)
>=20
> All of these are wrappers around the same core function bpf_get_stack() /=
 __bpf_get_stack(), passing the buffer with identical semantics, and all us=
e ARG_PTR_TO_UNINIT_MEM.

Ack, makes sense, thank you for explaining.
