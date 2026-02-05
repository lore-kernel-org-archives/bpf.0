Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F73426D0D
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306752; cv=none; b=tprpCWVtD+wiB8LM8eMnAw9cxDYnY/h7hSnWIwQWVKY8DfCTEuZzU6Tx7a9Hxl1W33nPxgtsoVynRGP+FaIUZEQJmHG+kfhbQPx0FzU7w7CVPZhLJKP+mj5cDpBfDeIhfuwQZmAPTudqm+dM6xFjw4KOSQfBHPTogcUZXICOe1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306752; c=relaxed/simple;
	bh=FNFL0/+E2aKnOvoNT9LImHUIIlRjvKZVxcmxb7yxYDI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Za4TWhpFe6hsNWxi3QOM8eOjavtnr6bQ2CSOCv/yK1EoOwOHxipq2YHUYiXExTvV6lfsJFmyUjh6anEterKoWv2FsOABw2wTnfHyw7wLJUNj5TyVtWRW9Y+iFxSANz9eDtebeIA4C3kv5G1cczRkSWYryf+zKfiiLGXCODH2c3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NsdhnNmZ; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NsdhnNmZ"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so9731435e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 07:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770306750; x=1770911550; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTu7qU8UN7vo13iwk65Itm5Hd0Cv+O0GXDEO+OULSSA=;
        b=NsdhnNmZZ+or54k3tuyagYkH2oSUJVSQZusPjtXF0o9co4Yavd9/67+CVje6lfG2GH
         Imm7ruzWxwyorDgaPrNf8XDPNEE5ga3JGo2ASBTBTjhKyJcfNnvRvwRtN5SuGLyuhabv
         S9o+pymxhEWJBc7Xkt7vYF+Nvd1YmnaIv3dEfm6XCXyFjvBRocdIRwxwJQdJOb4nAr76
         DJJ/6AdIYYeNxkfSL4nn2cwmbfJRP3SydAlttMcCVmbksCdxZ1/Pd5e1k/W9xcIghZRZ
         dKglZ5nT67KNqyF7e0tLcJn6w/3Eq6yiXiGxV7e777R8p8qgwuGOZvSil5zYcQLet7ar
         cCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306750; x=1770911550;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UTu7qU8UN7vo13iwk65Itm5Hd0Cv+O0GXDEO+OULSSA=;
        b=r9Hcj2pJL0CWgA2xbpPKU69WVS1HkLAeN0svNKKa0y/ML0fstL3j14ND44NSLTEBDG
         46fUB7QkXCgTwdrwKbmIsN8KoSXtVQByGzV7k+qmqrNdOXZB45r9i//JyynsdYeMNDfi
         nocN7+Dnt6xUuonjcROZ3RuHwx01D7RxKK0poE+Z1NbN5KXrpABsPkOUdds+K6g2cNrJ
         WtJiXyEsWIkHTmxSGnErUG4oZE16PcavZ2ucJXjMuNJmpu6x8iJWbYfevZV7BdU+JhSO
         WeYOIdUnQT79hAjjuY6z316/HEaVyk/Ucad0mcxb9pYKvyiAUsVFyNwlprx9IHDcwHoO
         Zu2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKEsTI1JMu8FdR5kUobl4Od/35admQighDX/fJzq5xzvhP3D7SzP5/3LpL1A81PPwaAsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZg8/X9Ks/O+/dwTALtzAc/L7BifUdjt01jbK7glKytL7T0d8
	M6XzEebMVzMX3NrqA6bJLfwEOx0vtgZVkDQL7U4y2zG3km0k6qSF4fWgYMmalwbqO+E=
X-Gm-Gg: AZuq6aKd4+BI958RG7sH8RNMAQmIvowA83NQxpNdw3b+KHVcRkHHQiyBdzIHnP4Nz0f
	SZ0yh7ZPY/fwSpmBOEvfN/pOgNUglGFP2j8Y69/n1wnm91KuCCYW9pJkOun5r2Y522dCCXB+NlN
	y1yq4mZhnv3qerMv4kB2OvHiANl3cMY6gH1ozYzuYuzZBknvbLp/rWop3IWOgEXkyb/xjv07w68
	Kr/XUYFoY33ymWsFWOxdCRd14gVYC/TzTxgHV64Gj+nIvf7IXc2g2r5OUAfldQ2touWhct/wN6O
	MNfFSdBmPcApfrZe6qXehXUVH79ll11TJTSLw7roBjLMlWLDHUI2FWin2YLGli048FXdFaf+c2V
	bWpOqCvuSd0vfgDw0vdIFD3enz4i4lKZ7YiWdgd3wHQ7g3ohn7O7dS2WoyQR8NRdyYEnolQyvNA
	==
X-Received: by 2002:a05:600c:810b:b0:480:4a90:1af2 with SMTP id 5b1f17b1804b1-4830e979f7bmr95259165e9.35.1770306750051;
        Thu, 05 Feb 2026 07:52:30 -0800 (PST)
Received: from localhost ([2a09:bac5:327b:2541::3b6:79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436234781fbsm5263375f8f.15.2026.02.05.07.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 16:52:27 +0100
Message-Id: <DG75D8PWP35E.2MD9TYHOCQO9V@cloudflare.com>
Cc: <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
 <haoluo@google.com>, <jolsa@kernel.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-team@cloudflare.com>,
 <wferguson@cloudflare.com>, <martin.lau@kernel.org>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>, <bot+bpf-ci@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_tcp_sock() helper in XDP
From: "Arthur Fabre" <afabre@cloudflare.com>
To: "Martin KaFai Lau" <martin.lau@linux.dev>
X-Mailer: aerc 0.17.0
References: <20260204-afabre-bpf_tcp_sock-v1-1-a22b40c630c0@cloudflare.com>
 <167a8f4235973cd42372884aa66182a10fd17e50c70626b1fa0e659933e82b4e@mail.kernel.org> <917eadc0-9341-48d5-a795-8a7d5318886c@linux.dev>
In-Reply-To: <917eadc0-9341-48d5-a795-8a7d5318886c@linux.dev>

On Wed Feb 4, 2026 at 11:27 PM CET, Martin KaFai Lau wrote:
>
>
> On 2/4/26 5:04 AM, bot+bpf-ci@kernel.org wrote:
> >>      But the TCP TIME-WAIT state needs special handling for this: pack=
ets
> >>      received for a TIME-WAIT socket can either belong to the current
> >>      incarnation of the connection, or a new incarnation. The only way=
 to
> >>      determine this is to compare the sequence numbers.
> >>
> >>      Add the bpf_tcp_sock() helper in XDP to allow the socket sequence
> >>      numbers to be read.
> >=20
> > Can this approach work for TIME-WAIT sockets? Looking at bpf_tcp_sock()=
 in
> > net/core/filter.c:
> >=20
> >      if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP)
> >          return (unsigned long)sk;
> >      return (unsigned long)NULL;
> >=20
> > And sk_fullsock() in include/net/sock.h:
> >=20
> >      static inline bool sk_fullsock(const struct sock *sk)
> >      {
> >          return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_R=
ECV);
> >      }
> >=20
> > TIME-WAIT sockets are explicitly excluded by sk_fullsock(), so bpf_tcp_=
sock()
> > returns NULL for them. The sequence numbers stored in TIME-WAIT sockets
> > (skc_tw_rcv_nxt and skc_tw_snd_nxt in sock_common) would not be accessi=
ble
> > through this helper.
> >=20
> > The change itself is useful for accessing tcp_sock fields from establis=
hed
> > connections in XDP, but the commit message implies this solves the TIME=
-WAIT
> > sequence number problem described, which doesn't appear to be the case.
>
> or use "tp =3D bpf_core_cast(sk, struct tcp_sock /* or tcp_timewait_sock=
=20
> */);". The bpf prog can also read all members of the kernel struct=20
> instead of a subset defined in bpf_tcp_sock.

Brilliant, that works! Thanks Martin.

>
> pw-bot: cr
>
> >=20
> >=20
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >=20
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2167=
1977729
> >=20
> > AI-authorship-score: low
> > AI-authorship-explanation: The commit message style is consistent with =
human-written kernel patches, with natural technical language and standard =
formatting; the technical error is more likely human oversight than AI hall=
ucination.
> > issues-found: 1
> > issue-severity-score: low
> > issue-severity-explanation: The issue is a misleading commit message th=
at claims the change enables TIME-WAIT socket sequence number reading, but =
the bpf_tcp_sock() helper explicitly returns NULL for TIME-WAIT sockets.

