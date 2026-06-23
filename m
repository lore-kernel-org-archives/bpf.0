Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E9E3A6412;
	Tue, 23 Jun 2026 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247400; cv=none; b=V/pCY74duziZNqathqCcJYrfW/lQhiGTqQ+b2d5ls1eTcoaU1qX5MNkgLu3g8DoXTigQ2wH+drZLJdqy3N2hSbkcuUoGdLKLkd//MkL8EqzJnZma4EeJ9F7R2ILgWMbS1or+NYB0H7ZAjilKnZzpxwsJDkdNG8kQGJRrblHZDU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247400; c=relaxed/simple;
	bh=bxdpOUstBCi/uW0riU4hf67CrouU75y0S9yKrVM+dc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWFZfGFksv35SZbSKtuaUEbck24bbXtZ7d+pOqU+4IfSB+E4LM5LIGr+A5rApRnN6XKRpg9KZxuRjprvbffZWtocodq41ipQKfIvGfBT4573gA30jNGTON3P2o5QSgHjn9abIVsPTFYLAN20jHejkVLs7SfvGLmZNMGR/rTFWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8lQUOvh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8lQUOvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8562A1F000E9;
	Tue, 23 Jun 2026 20:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782247399;
	bh=bxdpOUstBCi/uW0riU4hf67CrouU75y0S9yKrVM+dc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N8lQUOvhAlO/2JTSvbob9ze189NTzBrB426ZtGUB/fyg4Zrwp3iDrrUchhmhSa21H
	 v8bK5gQ4WVICay4pZ5P+c/kGcF0HSUKovnOc2mmWJF5soFF9/AfxE32i4uAhHGQZUA
	 1eoAbsopeVwoTn4DYimlnE6qrJDpV2ytL81d2TL5q46qJKSy7B5+yq78XE2+91TF8m
	 7EIVU7HGvc/+ptwUOCzxQQeE3OyHF406TuadmjCrI/8K/vTkbnEKLu5j22PXhkX6ES
	 RQlMiCq5h0c/OfRVVuaavCKBoMZqJAtjAT5f+ibP8PfGQXVTZDsgRJ4cLZSkjE1ADq
	 qeLAonY34pKPg==
Date: Tue, 23 Jun 2026 13:43:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Xiang Mei <xmei5@asu.edu>, Jiayuan Chen <jiayuan.chen@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Jussi Maki
 <joamaki@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Weiming Shi
 <bestswngs@gmail.com>, Ido Schimmel <idosch@idosch.org>, David Ahern
 <dsahern@gmail.com>
Subject: Re: [PATCH net] net, bpf: check master for NULL in
 xdp_master_redirect()
Message-ID: <20260623134317.4c0db3e8@kernel.org>
In-Reply-To: <20260623065218.GA378121@shredder>
References: <20260620201531.180123-1-xmei5@asu.edu>
	<7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
	<CAPpSM+TRJaqSSUs6tBp_CBSVUJMiDZm01o5BK6aCNak8vuQi+w@mail.gmail.com>
	<20260622155854.75977aac@kernel.org>
	<CAPpSM+Q4O704OaUAXqKpL6ffvudTfqzzLzLExziUExgvxQWmxw@mail.gmail.com>
	<20260623065218.GA378121@shredder>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jun 2026 09:52:18 +0300 Ido Schimmel wrote:
> On Mon, Jun 22, 2026 at 04:34:06PM -0700, Xiang Mei wrote:
> > On Mon, Jun 22, 2026 at 3:58=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote: =20
> > > Can you double-confirm that this triggers on current HEAD
> > > of linux/master ? I thought commit 2674d603a9e6 ("vrf: Fix a potential
> > > NPD when removing a port from a VRF") was supposed to prevent all the
> > > torn master fetches. Adding VRF folks to CC. =20
> >=20
> > Yes.
> >=20
> > We have triggered the crash on 56abdaebbf0da304b860bed1f2b5a85f5a6a16a0,
> > which is the latest for net.git, and 2674d603a9e6 was applied. We can
> > still trigger the crash: =20
>=20
> 2674d603a9e6 was only for VRF ports, so it doesn't help with this case
> (bond port). Also, the problem that 2674d603a9e6 fixed is a bit
> different. We had a NULL check after netdev_master_upper_dev_get_rcu(),
> but the issue was that this master device was not necessarily a VRF
> master.

Ugh, sorry, my bad. Poor pattern matching of the bugs..
