Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02783387375;
	Mon,  2 Mar 2026 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439028; cv=none; b=t7rIfM8IR+kM7/ox1UBSNxQjFAaXzlzNXlbYtPIgDb1WcDjQova1GdcZmEOEC3Q8uxE7U8ld3a2fb93Wouyyo48LR/thUB84yg2AeXMhs0O+qF4Dg+wr54INWBgFqbk8vqhzu+0a+WZXstaubA8Xk4cTigCenIuyufmNGd9IfNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439028; c=relaxed/simple;
	bh=ixwb2BfKeXCQX9PRIL0yEWU0kFZM8JpQv09X0+Nrxf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFMtTJv7zrxvucN35Hn5TuVOtPjQHWJzGuhIGNyzHUs/qv1FVsMb9r1xkG9HL5YUdjv4+oXbBfNqb8duoCFnNrh7EYTO2Dm82Ohj6SSFKK4zGlXMN4muTo/qJIljF0DTNPylFmW70LLxGT8bJlBYOlB2Rdg774we3j6FW8HKy24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i0z5fL+d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Frz5mpdt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i0z5fL+d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Frz5mpdt"
Date: Mon, 2 Mar 2026 09:10:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772439023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fP9PDZ0ex7zg1+9lEL3J8b+iUpbzj2YqlC1Ik3cqycM=;
	b=i0z5fL+dPf4DSFLPFFGUMcS1Qpj4WciBpkpp0vjWjT557q69OmoTm++NPAZWE/ihdilmNm
	O9VEs64vxnXGZelMsMZ/5iLDzM3jdyLMhPgjCKDTIAgJ3gcSB965tGbP78LEEsO3vIeqgv
	SS09fSdQjwnFCrfOg3+dCKGh0Sw4l+TXCUPPOaxJAjTiOjXNAt+t7S80+6usOAw7NTVg9X
	vCk0c+Iin5cHZm5TXaYiobySBxJ6IDIQshAFyixoyZKH/+8sYcKKvaHYn2i2WQFraWmQDB
	dt55ls/rmSueX1es8uRgyfWGEeptvTB4BPRU3pZ3s+r7Vf22FiObLCzcc3sA1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772439023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fP9PDZ0ex7zg1+9lEL3J8b+iUpbzj2YqlC1Ik3cqycM=;
	b=Frz5mpdtnq0z0zW+g9iPn0htrzPFk03OgVA3INCawCilnQ/pPwwNwd47M8j0CcCwzfhhnT
	O75Y2MIz3PiZRsDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org,
	jiayuna.chen@linux.dev, jiayuna.chen@shopee.com,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v3 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <20260302081021.MiQQ_LQr@linutronix.de>
References: <20260228021918.141002-1-jiayuan.chen@linux.dev>
 <20260228021918.141002-2-jiayuan.chen@linux.dev>
 <999129.1772247707@famine>
 <08041bd78c06981b18b3de90a95e0c951bf1623c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <08041bd78c06981b18b3de90a95e0c951bf1623c@linux.dev>

On 2026-02-28 03:36:24 [+0000], Jiayuan Chen wrote:
> >  My only concern is that this will waste a percpu u32 per bond
> > device for the majority of bonding use cases (which use modes other than
> > balance-rr), which could be a few hundred bytes on a large machine.
> >=20
> >  Does everything work reliably if the rr_tx_counter allocation
> > happens conditionally on mode =3D=3D BOND_MODE_ROUNDROBIN in bond_setup=
, as
> > well as in bond_option_mode_set?
=E2=80=A6
> An alternative would be to allocate conditionally in bond_init() (since t=
he default mode is round-robin)
> and manage allocation/deallocation in bond_option_mode_set() when the mod=
e changes.

This sounds reasonable.

> This is a trade-off between the added complexity of conditional alloc/fre=
e across multiple code
> paths and saving a per-CPU u32 for non-round-robin bonds.
>=20
> For the per-CPU u32 overhead, it's only 4 extra bytes per CPU per bond de=
vice =E2=80=94 and machines with
> that many CPUs tend to have plenty of memory to match.

4 bytes is the minimum allocation for per-CPU memory. The memory is
already "there" it is just not assigned. So for the 4 byte allocation it
is needed to find a single area (the smallest allocation size).
In case there no free block, a new block will be allocated and mapped
for each CPU which the part that costs memory.
That said, we should not waste memory but it is not _that_ expensive
either for a bond device. Things change if here are hundreds of devices.

> Thanks
>=20
> >  -J

Sebastian
