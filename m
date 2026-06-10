Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4B41363D;
	Wed, 10 Jun 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103021; cv=none; b=c62r3v8oVTEZffI8YO6m8ewyNlGzbWX7hgNw63PhkT5YDQBlY7pn/W+qBVCmBBPjjEerr2VBt7oX8Nv+0IywERFTEvBxB6tvv/LI7HEeEQR7QU9WAUbYtUGR+F2fgMUDiguADgsi8ls706h1HH25j414l8fuLKJlH8uyJ1i5k08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103021; c=relaxed/simple;
	bh=w8LFiEqPsoHCGJ7V7q3OkFewhWDwjFL6aU017uETe0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNV4lw8OebhxI1z1jk1K9RnqpjBmVezSLZJfa7uJueFRUxDOD8YnldMbCVBMsSADWSNzmrllTe5KynK7PXf0N8wDJE/QGyv/u6BQJc11OqZeuMZ+XoLFArbBBbB7QPyYPD7L2HAWRutweKJ4MU/X6lz9ip+NQkDd8V72g/6T500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af8cplbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af8cplbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFE61F00898;
	Wed, 10 Jun 2026 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781103020;
	bh=D5CCH02wB/MFP5coqv/yqXlOWXmdXlPrcx0MjZFRh1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Af8cplbZaC/EZauqmx7UqRWVG/9ZhZSCb/sipy0V8Z0rSb7C3lT4gNH4QeJt0R8rO
	 4EikIlmnavbGnyEvTLS9QXS1vcl/56iaQ4VFIiaudl5ZK773vE2jE1IqcvlBGU7Xu2
	 ld89ohs0MW/JaoKb+jizQAk/k6WAhX9hpgkHQCZhUBCe285R6R3AaSekrfWzGzeIYW
	 z03fnRPHp9LAUUKvcOBfuWNYaCIRG3+WP1jF00RgpsA1H2S1lU1pdAM0VJgEh5fvfw
	 bhXH/EcaXSNOTQtCJxQK9gV+jbI/8HOsZ0Bryg82MMR5nvKeCteIk8ggdgK9EMCpL5
	 BIR0kDEuwtvAA==
Date: Wed, 10 Jun 2026 07:50:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Sun Jian <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org, Menglong Dong
 <menglong.dong@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, Jiayuan
 Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf: Run generic devmap egress prog on private
 skb
Message-ID: <20260610075018.6162cec7@kernel.org>
In-Reply-To: <871peeacre.fsf@toke.dk>
References: <20260610102850.483291-1-sun.jian.kdev@gmail.com>
	<871peeacre.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jun 2026 12:52:21 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > @@ -700,12 +700,22 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf,=
 struct net_device *dev_rx,
> >  int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_bu=
ff *skb,
> >  			     const struct bpf_prog *xdp_prog)
> >  {
> > +	struct sk_buff *nskb; =20
>=20
> nit: this definition could go inside the if statement block below, to
> make it obvious that nskb is not used outside that branch.

Or maybe move the copy inside dev_map_bpf_prog_run_skb() since it only
has one caller and already checks if prog is NULL?
