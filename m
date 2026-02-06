Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B9334372
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770377402; cv=none; b=pU2o3fSela+fxsQWMIB676wD9t/lfNDO2qElIbpjDlnrjfMQ1iMRH0pdEowxcxlIOc/3egPwmSE6x79oujSfQAH76BeHmbiyMfNL4uC0OIauSDQMBfmsbFep3SIo7mfmeoU1rYAuo8edyfKnjyH5cnsOVOeF0tOyxQrQsNDP+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770377402; c=relaxed/simple;
	bh=C3EnY4z6SVunLCvifbIeQhC85t89mR/otobl+GoS5mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaset/QGfhuqCwmS2oj7TwkIoh5RtrYuapMQyz2Q+64YQqxOHGIVxF53p/+hd9u2wFdlrcQrXYfkxnj2/Zil4MrOlxBIzbCy9X25SmNJIutR0+rnWr5UYdH7D/GGKroNozwK5M94UJCUT8Tf+R+EVNYIFDfQUvz6pBrE7foUbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rQK0YrHA; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rQK0YrHA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770377400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITumhlz+/UdtXGfg3WyulDtDYIlhfRGFQ9+Wjyji2Rk=;
	b=rQK0YrHArRPOsJYN3KiV7S4p3dtWZ8Tbj/6UY7zrqJPfGZtFxyHekDwmjG0sGFDoBoJgjb
	2Miw/wRC38H5Mz1a0tX5ea7YNdtcrr5x2wykbba6TOelzcCqA6tAA6cauqagNDreVejUm/
	8mzvFdpyvPhG9W5cdn2sVaIMdoerqUI=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, jiang.biao@linux.dev,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 0/3] bpf: fsession support for riscv
Date: Fri, 06 Feb 2026 19:29:30 +0800
Message-ID: <2830483.mvXUDI8C0e@7950hx>
In-Reply-To:
 <CAJ+HfNh63kg7QNOVhn4As1nGBLDLEy72zaiz0i2+CZKe=f9WuA@mail.gmail.com>
References:
 <20260203055231.1088479-1-dongml2@chinatelecom.cn>
 <CAJ+HfNh63kg7QNOVhn4As1nGBLDLEy72zaiz0i2+CZKe=f9WuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/2/6 19:20, Bj=C3=B6rn T=C3=B6pel wrote:
> Thank you for working on this!
>=20
> On Tue, 3 Feb 2026 at 06:52, Menglong Dong <menglong8.dong@gmail.com> wro=
te:
> >
> > Implement bpf fsession for the riscv architecture.
> >
> > Menglong Dong (3):
> >   bpf,riscv: introduce emit_store_stack_imm64() for trampoline
> >   bpf,riscv: add fsession support for trampolines
> >   selftests/bpf: enable fsession_test on riscv64
>=20
> I'm happy with either addressing Leon's comment with a follow-up, or
> spinning a V2.
>=20
> For this version plus Leon's nit as a follow-up, or a V2:
> Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> # QEMU/RVA23/DT
> Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Hi, Bj=C3=B6rn. Thanks for your reviewing and testing. I'll send a V2
now :)

>=20
>=20




