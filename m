Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E3255F52;
	Wed,  1 Jul 2026 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932231; cv=none; b=Bwjcy/GdNT+o+4JYZO0SaCR0X1/d4RDplpL08RsDTsj7UzE+KNJjFnJKP7HCI+mwF+xbagYu4VtvAEgHRAuuZ+FvRIVOguytTLo6QEKtZSQSP0Mc3CdwOgVw6vuDhLGJXaaTZnnSONIqUhgxQVxjBb8vPX/6/L9R/yZWoY/V3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932231; c=relaxed/simple;
	bh=gQPcuA0VnAOVz773vffCLhCgBFP+s329xS/59tPycIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khRyMJq+xUOEU/BRK3GRunDrpfJCjMifvXj9vHWwwVaurr+YoODiGN/VCP7GFuTVpwN31f0a5tDAeQeK/92zjpi2MoYOatmzCbVoBB6+H2cQkZdyvJoI3/K03jrVQ21Jfpz5pe7wFanhsYWwrIJ6Cyvla2JFqXyNt1xSjSfWEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4nUi7pq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4nUi7pq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75931F000E9;
	Wed,  1 Jul 2026 18:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782932230;
	bh=gQPcuA0VnAOVz773vffCLhCgBFP+s329xS/59tPycIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M4nUi7pq1yKiNqPaAvvGGpSq9wAAMs6VtKTB5jPjUooZgK/xCNzpOhsH7aYiP8nsN
	 g7qbiAyH4lXsNlWWNOcUckfk4I0pT9Q+3+UzBEaoiwI/KHPsDN5qmY8D2qNy1g2SEI
	 mh4s9f38K4RANewWLnsmPY9D1NpnS1yRCTiZUIE2fMh3zkiqzdCcudPJ8Od6LMnqAd
	 /s9ZTpHhr6V6jFHwZ4DkGm9RU79xeNRf6fgHCcRYbFkTx2Z0UGkMFwpQkbxTbuzhW0
	 8FD59xf5cCOlnDfXHiqjfyckWnfOJZdB/0tUOulajoNEUR8N0nG0c8JYkn27o7rrQX
	 z7RCdwpJ68DYA==
Date: Wed, 1 Jul 2026 11:57:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: kraxel@redhat.com, vivek.kasireddy@intel.com, Shuah Khan
 <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] selftests: Open /dev/udmabuf O_RDONLY
Message-ID: <20260701115708.01213909@kernel.org>
In-Reply-To: <CABdmKX2oG9m316hiJpSXbujrT3vgE5hUpzH_WHfjNxBJ1_+BdA@mail.gmail.com>
References: <20260625181557.1086105-1-tjmercier@google.com>
	<20260626180941.45158025@kernel.org>
	<CABdmKX2oG9m316hiJpSXbujrT3vgE5hUpzH_WHfjNxBJ1_+BdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Jul 2026 11:53:15 -0700 T.J. Mercier wrote:
> On Fri, Jun 26, 2026 at 6:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 25 Jun 2026 11:15:55 -0700 T.J. Mercier wrote: =20
> > > Write permissions on the /dev/udmabuf device file are not required to
> > > issue ioctls and allocate udmabufs. Applications should be opening th=
is
> > > file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]
> > >
> > > Remove the write access mode from the drivers/dma-buf/udmabuf.c and
> > > drivers/net/hw/ncdevmem.c selftests. =20
> >
> > You need to explain "why", too. Why change it if it clearly
> > worked for everyone running this test until now.
> > --
> > pw-bot: cr =20
>=20
> Principle of least privilege. Folks use or point to these selftests as
> examples, and then wonder why O_RDWR doesn't work on systems where
> write permissions are not available on /dev/udmabuf.

Alright, pop that into the commit msg and repost please.
