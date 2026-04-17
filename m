Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A857221FBD
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 01:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776389744; cv=none; b=KrUDMMnSJ1thMl8bf7TcEM5cPgkjiDsiaIeu12nQaXURRM1RLtncCfJFbxMKfiK0vojjrRMYh0c4O1m0SthYfSS/SGGaI9TZGYOOpZhImz4ydhcyxHlAZXTWofJ8YSALvtw37t+8Mi6hewZFVYCe7XuXfxp38ar89YWgKBG5Urc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776389744; c=relaxed/simple;
	bh=m38mPK3/TMPhsgDXtdOvPcXA0HU7wBjC8sj+T52RtZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DII0r3fuRpC3TVGRLChK9u3P/e0mCxpl9vjfmNpHBVxMZ4BBMyaKLhMHVWSopTptozxCum7Q8tLyMepVISsjl7PElEyggNWlvB7pKLQ+H0o9YQnWyMak8gXXX08+rnheyXExAl7MyJDlBQ2etuIAi1s/7SradqTFO8n+3+e/y3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oHAfSeBf; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oHAfSeBf"
Message-ID: <f1b20180cc6127b990e5f83face4ca77bab49e89.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776389740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0H5hQUEnmKlUw/TUQjD2ettr9nUmryS/LkDIj0eKGB0=;
	b=oHAfSeBftXqqpxbqcuiRD/KV24YEMdiSmn0zwFaForJy/YWCgekFMyLxz2a51aclr3v/dw
	GbOzU0ZiLKhoTD89mvRb1NsIm7mPB1k3Vac2LOar2GQgfwOXR4yb84QkF/uHqac8o1boHX
	VNCd2ToqxZe02ZVha0wf7SFsnRjZFhA=
Subject: Re: [PATCH bpf v2 1/2] bpf: Reject TCP_NODELAY in TCP header option
 callbacks
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org,  shuah@kernel.org,
 jiayuan.chen@linux.dev, bpf@vger.kernel.org,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org, Quan Sun
 <2022090917019@std.uestc.edu.cn>,  Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan
 Mei <M202472210@hust.edu.cn>
Date: Fri, 17 Apr 2026 09:35:14 +0800
In-Reply-To: <2026416172759.GIuu.martin.lau@linux.dev>
References: <20260416112308.1820332-1-kafai.wan@linux.dev>
	 <20260416112308.1820332-2-kafai.wan@linux.dev>
	 <2026416172759.GIuu.martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Thu, 2026-04-16 at 10:35 -0700, Martin KaFai Lau wrote:
> On Thu, Apr 16, 2026 at 07:23:07PM +0800, KaFai Wan wrote:
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index fcfcb72663ca..911ff04bca5a 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5833,6 +5833,11 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_s=
ock_ops_kern *, bpf_sock,
> > =C2=A0	if (!is_locked_tcp_sock_ops(bpf_sock))
> > =C2=A0		return -EOPNOTSUPP;
> > =C2=A0
> > +	if ((bpf_sock->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
> > +	=C2=A0=C2=A0=C2=A0=C2=A0 bpf_sock->op =3D=3D BPF_SOCK_OPS_WRITE_HDR_O=
PT_CB) &&
> > +	=C2=A0=C2=A0=C2=A0 IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP &&=
 optname =3D=3D TCP_NODELAY)
>=20
> IS_ENABLED(CONFIG_INET) is unnecessary.

ok, will remove in next version.
>=20
> pw-bot: cr
>=20
> > +		return -EOPNOTSUPP;
> > +
> > =C2=A0	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, opt=
len);
> > =C2=A0}
> > =C2=A0
> > --=20
> > 2.43.0
> >=20

--=20
Thanks,
KaFai
