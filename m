Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798591;
	b=nanjw9o2eCiUUikqzmU/K6O77uYkGAXr492rDH3CK4fsEutFKHqSjbutSednRYKa+C21
	 DkQaJeUxwgUvZTr1OVQ07HKKwo2l0tMqY/sES5kDwdWhyPGnQ7P4kCJY/eIqgFAkpwp9n
	 fvhuPWT2i2FFQYk8+5hpXdAv6PQrfFORisdR0hBKrGYh6KdOWf5fJ91JiIBIxM+pnGylV
	 WHHTJMPya/bBnrebwGdWS84Sv2KPdgiG1B/mrC1wgZ8erkgbZjqST00ySOi819YDxdCGH
	 KYvVyKg/5dBh4mAAho1/HJW3wqAftMDB4bWHfd77igYoT2Tge/c2kyvFcEQDHa4krTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798591;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=V9s5cE0YFouh5jmUZ3qtfKF7Wf5pwrkzWs9hUWaorfQ=;
	b=2iHru7G+yOyHR7oF7NQjll3WBCEFISJ+MOX77Lkdj/m55pZnaNPWapmUUt3KJANB7qlo
	 CVW7WewQh2zXpidhHxtsAVG8uWJXT5IBaaTBSiJzfcguu4fJwqOEE0rwfoNzem2G0ztm+
	 q/moRF7bsVZyGkGAKgTI5c2HN3ZS50Ru0IrNNALQGqpJrDMpUm2vdEkespa68BOq2FT2n
	 5KIV3eZuYfJ+EHW8qnik+wcaqVBGxyY3foamJKkC55fM8d6l8qlgd4snBiHT0Ju6eIKNq
	 bJBLME7pAqaOeG+pOwFC+gNER7IB35V9leLam8+kUoOjFEjM/lVSFyxgiEgD/lSdrrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqajruAc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8E606A329
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqajruAc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215011F00934
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798591;
	bh=V9s5cE0YFouh5jmUZ3qtfKF7Wf5pwrkzWs9hUWaorfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RqajruAcR6zloTFF9yw5YIV2Y3qMAhDUo15smivVrvxMIjmpi1Dg32UTAhlRlcFsr
	 UKLfOvt0GbAIWYvaOynCACibHxabakYD35LazrIFriffOBsOoiOG7MNv6FJMwvbx43
	 Sv45hfvkBDGCcWPdABDvCeENnCbyF23zAJFZzg6cyqE/yPq9YQFenTIWhDwZb0sW2z
	 q8VDTAbP7zUDQZKmb7JFOQ1/67cnV/iARtxXwaMAETkmuJKF30hrwnN4xP5AVBKMqr
	 rWwmDgDEG/hOsMzX535nwZ6cJbdg3KD7kCFnUH3WXnOaoMfFmnk9UXyqg1P05UhEPL
	 eZB6WJXZuqnBg==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-94961ed97bcso820573185a.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 08:56:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEdmtyps7WfBzo6I+QRjo4VcntSa7QL8UzSHXH2UdxcJBq7YiGvyvBEpib8qcAnyBgtnMY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GuyqjY3zY91N97YFJG22fnAMIM1chryb1XfXhzwp3WWomsr9g
	mSKKGYXXggjc8S8wBejtKS60/33SJksTsO3ZNF0eWugKBduI799bWBBj81ncTR94Fk86MA6ljHB
	keckb5MS1IN2OkqaS2FEUdj6bn9OH0iw=
X-Received: by 2002:a05:620a:649a:b0:949:752d:31e6 with SMTP id
 af79cd13be357-949bac8557bmr4188486185a.79.1795798590170; Fri, 27 Nov 2026
 08:56:30 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261127142131.3527737-1-bjorn@kernel.org> <20261127142131.3527737-4-bjorn@kernel.org>
 <awmmhuuailYkTtLu@boxer>
In-Reply-To: <awmmhuuailYkTtLu@boxer>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Fri, 27 Nov 2026 17:56:18 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNhwOrsGZoUz4wYokaGOOzEeCTAdkVUtvY5REV27gkbDww@mail.gmail.com>
X-Gm-Features: Aa3M54rS-Z7TnayrDFO8SKtWi5cnEqowLhI7xQRnBgqe0ZPhgLbFwKqxRVt_Mys
Message-ID: <CAJ+HfNhwOrsGZoUz4wYokaGOOzEeCTAdkVUtvY5REV27gkbDww@mail.gmail.com>
Subject: Re: [PATCH net 3/3] selftests/bpf: Drop the zero-copy tailroom from
 the xsk tests
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Tushar Vyavahare <tushar.vyavahare@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, Colin Ian King <colin.i.king@gmail.com>, 
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Nov 2026 at 16:49, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Nov 27, 2026 at 03:21:29PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> > The xsk tests take the size of the shared info off the UMEM headroom
> > of RX_DROPPED and off the growth of XDP_ADJUST_TAIL_GROW_MULTI_BUFF,
> > as zero-copy multi-buffer pools kept it at the end of each chunk.
> >
> > The previous patch moves the shared info into the buffer pool, so the
> > UMEM headroom limit and the frame size no longer leave room for it.
> > Drop it from both tests.
> >
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/test_xsk.c | 10 ++++------
> >  tools/testing/selftests/bpf/prog_tests/test_xsk.h |  2 --
> >  tools/testing/selftests/bpf/prog_tests/xsk.c      | 13 +------------
> >  tools/testing/selftests/bpf/xskxceiver.c          | 15 +--------------
>
> This is based on old xskxceiver location, would it be better to have this
> one send to -next out of this set? I assume the move might not have been
> back-propagated yet...so seems we would have to double the effort?

Ya, good call. I'll pop this out of the series, and respin a v2 w/o this.

Please have a look at the Intel side of things if 1 and 2 is a good
fit. I'll spin a v2 when Sashiko has spoken!


Bj=C3=B6rn
