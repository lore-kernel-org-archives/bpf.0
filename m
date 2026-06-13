Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD121CC71;
	Sat, 13 Jun 2026 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381026; cv=none; b=tGWi657y4wnb/V/KIBgJRYe8THpKbVlJUKLBTplMmsXmL2fFFWJfvKxc1oPxcj/tDZbnNSSqwcis8KK2P9Q3UVzh9R8zF2abB/0mf+ZkaV76rvcbckbHAz11KOX//OYumIV42kKZkEL8MHw5QkxVYAvDtd5G/uvxJdJiqBA5+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381026; c=relaxed/simple;
	bh=MajHWP36pywmpHXIutnrtvjgrOaNo1sOUa38DWPkGqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0eWF3ElcMlBLlZgv3q9C3rOyU/nO6iIwN1gzEu11HF4ZK5elK0J8hV67EiY/WIfLJeaOnniTH4jKIwm8KqwBn9RZwZqg2LeF+uoc+dn4UC50vjE1lMlQsTTIBRu7TsdSdgZwsMZptCvtfqhuDt48fZDysuR1m/T9oHqAfXrykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+0YbmSl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+0YbmSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA711F000E9;
	Sat, 13 Jun 2026 20:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381024;
	bh=MajHWP36pywmpHXIutnrtvjgrOaNo1sOUa38DWPkGqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A+0YbmSljX2VbpxkK5dc/ihCO36cuH/Mt2Soy5Pnz2Em5SHZfkJ1Pxx2i9QDGjhJk
	 FtFEMirkQKmnuP41y3L9hXmk0SSpe54xsy66sxpDbmZVU/OGL1V4elLg+fY97KaXf9
	 Atny5XMcXhWlhPU3fHgOlcxbaV+glBvbZkHrUgL4SAWzIz47/B7mGnT3sN4HNxrP4y
	 GK3kl75FyUtF5uKabdd4J1nYqV82FZKMbZzCct3rY+yAMA02NtAM+qsZ1ykOAAnh3M
	 ia/pBQgBeY/sW88AtPPOxAKKTgAmAMxjDgnWRLA5Qj5WMy55RGTQ9UVD2h4AJMme+X
	 pLMfZ74dxEb3A==
Date: Sat, 13 Jun 2026 13:03:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sun Jian <sun.jian.kdev@gmail.com>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, "David S. Miller" <davem@davemloft.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Shuah
 Khan <shuah@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Menglong Dong
 <menglong.dong@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Run generic devmap egress prog on
 private skb
Message-ID: <20260613130343.3984878b@kernel.org>
In-Reply-To: <CAADnVQJyOR0hppTmhbTRS8Sp5ci-L0fmQ6V+R9eiJDop_95rVA@mail.gmail.com>
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
	<20260612114032.244616-2-sun.jian.kdev@gmail.com>
	<20260613102549.0061a875@kernel.org>
	<CAADnVQJyOR0hppTmhbTRS8Sp5ci-L0fmQ6V+R9eiJDop_95rVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jun 2026 10:53:35 -0700 Alexei Starovoitov wrote:
> On Sat, Jun 13, 2026 at 10:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Fri, 12 Jun 2026 19:40:31 +0800 Sun Jian wrote: =20
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org> =20
> >
> > I did not suggest this =20
>=20
> ohh. I didn't follow discussion closely.
> Do you want me to revert the whole set or just remove that line?

It's alright, I was just being grumpy.

Maybe we can amend Chris's prompts to catch these?
Noobs tend to add Suggested-by for people who simply commented=20
on patches.
