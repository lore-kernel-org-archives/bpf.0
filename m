Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769899;
	b=THAXHv+abJdauD1QO0N9ny/yqhKhw6GqCH6OhFPGOf9soYhWtcsYwDxYqQgH3lZsoHFj
	 NSK0sgXOTB3AIZSF2aVG8gpi8sCxIgZ1wM39gb/CwN5zhzCJZRPUnIY0N5pRuiiByHGF8
	 YEv8TM3V8qEf8qdrWzv3x6m7vjZTLo6kv6mTCaJ4V+hPVw8yNyE2TswRHf2441naZ5DNE
	 iaPKS/KRzZsO1jrG6yPwNmPe4MEG9AIIZd/j5R5eok4YJ1fzpj9p5k6l4ct3Aro2CWWri
	 0r5uJb/YQ1vQ/SnqtkgEuHwlCUxyz7MKtcvPCwEFzV4adbQNPRVqUfHfL+WzjY6ZZgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769899;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eoBDVmnVXuE8Yo+S60hLCqU6/yj3dqT4h3cmEdolbz0=;
	b=jEAyprYfkqMRIoDzlO7TYD6YKW83t0qt2I3fitIcc5bHxE/86YCh2xryzj+1RRBcp2su
	 ElQKB9+jouu5zJ4FuYtfZnXV5dYnLV0JxhpzrVLc/Ag1kHFXQxYpGx1JD6pb8GfCSf12o
	 kwecE3X0exekloltBdDkWKL3nipJ9Vb2CXiT9dbFnhky4dIhJ3X1C9aCjczFpFSqjyxvB
	 A3sN2U0y5mhvlhsMO/9lrM1305qCd2dbYqoir3wYGsr3uMiB1sZsLQnUJsitm9oZzf+sH
	 A4gOsRkOc2JNEoBiwSTMRalc5ocDWCAAGvqtul37Rze7r0LNVqkVuv8ZFLZ+yt1XtXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKex3rK3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7058606A32C
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKex3rK3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5775F1F00A1A
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 05:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793769898;
	bh=eoBDVmnVXuE8Yo+S60hLCqU6/yj3dqT4h3cmEdolbz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HKex3rK3eL7Rp+GBrver63QLhTNWwbrojE6jrALo/bgcnVPFsgJw69EDdGp9yf0At
	 UJCYzMiHiMm8mro3z0bORkKypfRCvYuyw0KZIgXNsbPwDTpnsKi3VWl75HxnPBSnfN
	 vwWQj0xjj7wdxmwhl5W9vaEBE01eD74N08NnyBkn/yH7yDjlOubDBt4cJLgWHi8vVU
	 ypkweTk0bpKGBm/+6ZHfgln3QvR3vhFeAfACoYkq48/lm3pZSZyiIJhhjjkTqzW9+k
	 frv64kta+N44II0PcjIjZNMJqd/uICDBJayXP4ZnG4FWNvlhm5L51ZJXf/QlPIp3Dd
	 /r/NgnopgPFHQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4a822463a22so214450fac.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 21:24:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByw99mFrrzPDD0TKaNieT8OhZCXmc2Ns1z6bK4BnoKW7ZfbUa2VsrsO2kFXZwm2up4ybMA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JmPX3sb/KHfW8GT866A7CJfEO+wcP1O7V7AhaZYhp8ny++0tF
	5gUF2ZLgljDcj31PcEnJTRq9EVmCbTQMsJSaW/+Ud/Uvl17ZTRbzGfCn9NqJ7AGNSiug9ydArrU
	5Yyk3aYHc+aK6RteiynfKyDnrIkWWNCM=
X-Received: by 2002:a05:6870:960e:b0:4a6:fa51:3c89 with SMTP id
 586e51a60fabf-4a9077ef1a1mr9007007fac.51.1793769897717; Tue, 03 Nov 2026
 21:24:57 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <aujuOJCs5zZyon2k@john-p8>
In-Reply-To: <aujuOJCs5zZyon2k@john-p8>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 06:24:46 +0100
X-Gmail-Original-Message-ID: <CAL4WiirLdpvLGKDrfM3s1Gx_JsUuA+QVQS_3TY28gttdQnEF6g@mail.gmail.com>
X-Gm-Features: AclHuK-kl3984ixA3XfcRldmIqqk9PcGSyvzJ0kBvOxBMRAIApqefCIEr1A6YD0
Message-ID: <CAL4WiirLdpvLGKDrfM3s1Gx_JsUuA+QVQS_3TY28gttdQnEF6g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 00/15] bpf, sockmap: Fixes for verdicts, redirects,
 corks and recvmsg()
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, jakub@cloudflare.com, 
	jiayuan.chen@linux.dev, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, 
	matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, 
	josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 21:11, John Fastabend <john.fastabend@gmail.com>=
 a =C3=A9crit :
>
> On Mon, Nov 02, 2026 at 07:20:57AM +0000, Alexei Starovoitov wrote:
> >From: Alexei Starovoitov <ast@kernel.org>
> >
> >These patches fix bugs in sockmap:
> >
> >  patches  area
> >  -------  -------------------------------------------------------------=
---
> >  01       recvmsg() after a fault
> >  02-04    the verdict of an sk_msg prog and the return value of sendmsg=
()
> >  05       the backlog of a stopped psock
> >  06       TCP listeners
> >  07-08    the target of an egress redirect
> >  09       the TCP state in recvmsg()
> >  10-14    corks and the redirect target
> >  15       bpf_msg_push_data() and bpf_msg_pop_data()
> >
> >8 of the patches are from Chris Mason and Josef Bacik.
>
> Thanks everyone lgtm. For the series.
>
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>

For the series:

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
