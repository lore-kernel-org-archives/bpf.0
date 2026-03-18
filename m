Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF63FF8AA
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850901; cv=none; b=kvDsrXqkKJPI/0GTsrXbLoCu2M01I3GPsdd7f2cKnywO5WeOOYb1kUB5koWaNVdX6Fj7oW/+ko95SNPuGBWu5EP6FEn3wor7BIZI0Tt2QsyKVlvFC9CjOgpF2wJq/WAdH5PcpgdnQeUZw+tbqvoQBFyZDV++EbZTy6VrfxOHXiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850901; c=relaxed/simple;
	bh=Xais5AlC7gPN/jeDsX8Mvz9zOloreO5rETe4qgoEMv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4v0NfLwlX08+NNT/T35c6QTb8yGsa0qBbAqwxCG3Um+MxePab5rceSiAYJTxN8hg0u7JdzDM2PP9IJMz9kbdgRRj6asAXeys7RSITpQbhqF9Pp+yJ62dIfE8C6MRUI4gNjTY4uzHhw11hVfsXROF+Z+obt4qw9sFcJ00zxzOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghQjv1fp; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghQjv1fp"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64e87a81639so167235d50.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773850897; x=1774455697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aU3ZUegYeNO/2K6RsfKemLkoDaSg+c0LeYfQDENeDh8=;
        b=ghQjv1fpKGyjAGY79ZcebNubMwKey2UMAJ+vXMYM6mENNEt2d1R6+094CRB6n9HS9S
         TtXiUaRH9zeze9hhcBD4cIARmC6nni/zibKmo2VAKQCv/0oZCbspsWvBaf3HIf17uCSa
         w1kyqUmlxwH0XvJ2hYOIZE9JpbJwY/CNUc37YJ5C+A21Zz+JyDLX17kpcpXi0kpCosF7
         jQ8S/5SU9DYPRClxCFgCgujLt7Q6yEw44BqQDJN/zKVml+y709iUUhRrHHpok4Tnit2o
         nTtXZKN73Rf1eGqei2dkTBNBcB6U1Fmt7S1bbBdkTYQTKKBdIE8gxr5w+LJXISzdCVne
         ox1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773850897; x=1774455697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU3ZUegYeNO/2K6RsfKemLkoDaSg+c0LeYfQDENeDh8=;
        b=cVcHvmAgj+I5ZGhFcgWSeQpHtpOsbmBCn32FvXkX5DazvRi7FHfebCy6Z2pEj24ldJ
         bkBIxBRZcYuGBrDGYejWhBbOgr77BZJ2hUOiMVlAY/YGPHanwXz+1cTfY94sl7H/DY2y
         dMPF2oScL8Rurmmp7Jtt6h2xzx3NMG5TUBw0cNQ1C3JDpW6fmJM8b5pS6RIwTlXbfZiN
         6y/5fUgBgNNdbR/4DxEOlpqmqkX+2dB8RwlxkRt3EcwgaT3+APQZa8g45YASwCpytYlq
         HNqljIni79xgWsT/blY/fassWTUaEliKlJm5vF8Pikb0+p8leertQqVg/08FYO9lt3kj
         pEyg==
X-Forwarded-Encrypted: i=1; AJvYcCV0YR33HMAEVb/CEIUIhJUfiG7gBoctfilRjdOwg+4TWrIzjfDI4IqJtE9rQC3ruU/11aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZCxa3pqecKaY4nLCUgkFb0BkEfIkhqITh/AuChRBlVNpau8Qg
	yr7jM/9ryVLdVdUpGN2XlhGHLdqfZSifKgMnHF9gC0K2C72TqI3+EPyi
X-Gm-Gg: ATEYQzwV33jP6taKLvzxf8c0VDNzd/bp8Z24B4tRWhBqzSi/YsbPa7kbX0tAlerQ334
	VKsYgpBKqNKLvYYLnOX2Zi33ITsBjcRwpIut7LY7wOXbK6pPGTklXZJeMdm9Z44fBptnklUNonO
	Nsh07Wljzk/BCdLhUaflma878mTGAbIqUJ6ryT7kuhkM5xguJHU3tWQNdI/Xjq5HXriM0Gr3HEU
	LJWKlHVmjBqqRK0lukcbXRm1V8nb4OiCDJiIqSDtEG6oUo26Mb4cZUn5UNnnEI+ZMrQo8uJsh3j
	MYYHZRAusiO4Lt5NMVSKwb7NZJdwDcRM6lY8l5ulcoQqs0vFDQS066TPlHMZFzc2HtIbzbWf8sh
	yHDoG1/MMz/9R7UnOyfFutdSd2UWJ5ySLdQ6PjDgAJZM8XJ8qx1c2W/qLh77hFRg0wDL80LjGYA
	dI29dBCie/QrQ6cnD/5nwUDgYCyhBPqo4cgs7GNUcPifkqwgo=
X-Received: by 2002:a53:b20d:0:b0:64a:df24:813a with SMTP id 956f58d0204a3-64e91351a08mr3367724d50.29.1773850897139;
        Wed, 18 Mar 2026 09:21:37 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91c06df7sm1882816d50.17.2026.03.18.09.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:21:36 -0700 (PDT)
Date: Wed, 18 Mar 2026 09:21:32 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 5/6] selftests: drv-net: add netkit devmem RX
 test
Message-ID: <abrRDNi79H9ircl1@devvm11784.nha0.facebook.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
 <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>
 <abns9COj7WagFtZ8@mini-arch>
 <abn3rJGXXyDYSNzA@devvm11784.nha0.facebook.com>
 <abq97UD7CHR7bdod@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abq97UD7CHR7bdod@mini-arch>

On Wed, Mar 18, 2026 at 07:59:57AM -0700, Stanislav Fomichev wrote:
> On 03/17, Bobby Eshleman wrote:
> > On Tue, Mar 17, 2026 at 05:08:20PM -0700, Stanislav Fomichev wrote:
> > > On 03/16, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > 
> > > > Add tests for devmem RX over a netkit device with a leased queue. This
> > > > is the same as the other devmem RX test except for ncdevmem executes in
> > > > a namespace, binds to a netkit, and skips the ethtool NIC configuration
> > > > steps (relying on the test runner for that setup).
> > > > 
> > > > The RX path is setup as the following:
> > > > 
> > > >  RX Path
> > > >  -------
> > > > 
> > > >  Remote            Physical NIC          Netkit Host        Netkit Guest (netns)
> > > >    |                    |                     |                    |
> > > >    |--- TCP send ------>|                     |                    |
> > > >                         |-------------------->|                    |
> > > >                       dmabuf                  |--- BPF redirect -->|
> > > > 
> > > 
> > > Is it too messy to parametrize the existing test to run both with and
> > > without the namespaces? Feels like should be somewhat doable in python?
> > 
> > IIUC, we could have main() do something like:
> > 
> > for env [NetDrvContEnv, NetDrvEpEnv]:
> >     with env as cfg:
> >         [...]
> >         ksft_run(tests, args=(cfg,))
> > 
> > 
> > And then the tests could call helpers that check cfg.netns to use the
> > nk_{guest,host}_ip6 addresses when true, otherwise use the regular
> > addresses?
> > 
> > It should be doable if I'm following your drift.
> 
> Yeah, yeah, this plus some small changes here and there (to pass your
> new -n in the netns mode for example).

Sounds good, I'll give it a look.
