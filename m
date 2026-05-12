Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F17383306;
	Tue, 12 May 2026 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551606; cv=none; b=CkekSBYr0iZTYeYdl++Q4C5kM1yDPeaofukC0qcJLLomlGgORizCjk1YO9znku0Ma0dDcBvb+6kRwqzmOaptb3DDWLzBBg4noYYDfHL/7OROMCEzZd26nB+d8KeJPUzyuX4hJk9/+y31e3/Pn6BlNGhKkFDH2SLTBq3fTDImJGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551606; c=relaxed/simple;
	bh=BpLGV2IDDxHKkqsJa+hf67v3+/szAmmH16JzI5sEPks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GG7bIshQP94PZCkpgtN1XZ8m4ADTU0FJclcCAtPORqn6JfhN/AjHmAeVkxhNMrCGhxocJ8m0KaeqSVezhZwZiGwPJgrafoc4NzfX9M+/2UCQ1n3i+SVbhy+/wZu3sm9xrJJNlrDmWKS0wHVyALiMgVbhgPEUpbvwy+YcgPKGuQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWTUt/PD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWTUt/PD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970F5C2BCB0;
	Tue, 12 May 2026 02:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778551606;
	bh=BpLGV2IDDxHKkqsJa+hf67v3+/szAmmH16JzI5sEPks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sWTUt/PD3R+SLthnc8kI8voPh2alsy5pjxEtISaIOHKNGnuvgLdqQFaITHVJ48Wdx
	 2+ofy9Nae7T9RkFTvpJwTPypCBOdyPPhOoMlmLvLN5317q8frNTa8z/MZ5YQNG6rBE
	 D2qJu3a9MMjGqKAmeU7qZusH+z/y4YBx5Ln2HBPUXWkFLjno8o3FUKOnTtFi3GV1ij
	 uijeanyamlpJUs5f0AzpCk0E6bPorBFy6Y/YJM2pczgTJaXZB5Uz0uzmB3rzFkFK6M
	 +8JDcpYDpD3CiinPCcU6IytsSd+IRzl1IBl9ZXcKg+txWNVs69rKFT7qUzf91873/a
	 DElIojfZmj4vg==
Date: Mon, 11 May 2026 19:06:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: xw x <v3rdant.xiang@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, jakub@cloudflare.com,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, Jiayuan Chen <mrpre@163.com>,
 Daniel Borkmann <daniel@iogearbox.net>, john.fastabend@gmail.com,
 bpf@vger.kernel.org
Subject: Re: [PATCH net v4 0/2] net/tls: fix UAF when TLS_RX is set on
 sockmap socket
Message-ID: <20260511190644.23334e6d@kernel.org>
In-Reply-To: <CAFFJMPwtWZDrD0=hANXk2cdZGt2ArQEWROGRswKPyiZ+FrG1XQ@mail.gmail.com>
References: <20260511155210.32926-1-v3rdant.xiang@gmail.com>
	<20260511161320.358cfaad@kernel.org>
	<CAFFJMPzw8pcwX9g7iv3F=FpHQyovUgZZ28P7XfH3gmiay-JfpA@mail.gmail.com>
	<CAFFJMPwtWZDrD0=hANXk2cdZGt2ArQEWROGRswKPyiZ+FrG1XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 08:10:03 +0800 xw x wrote:
> On Tue, May 12, 2026 at 7:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > Just to check - how much of this code or the patch do you understand? =
=20
>=20
> I think I understand the root cause. Based on Jiayuan Chen=E2=80=99s
> feedback=E2=80=94that we should deny TLS_RX attachments for sockets alrea=
dy in
> a sockmap=E2=80=94I've prepared my patch to do exactly that. Do you see a=
ny
> issues with this approach?

I mean.. I have no proof that real users of the TLS + sockmap exist
but I thought that they did.

> On Mon, May 11, 2026 at 10:13=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux=
.dev> wrote:
> >
> > I think sockmap + TLS_RX has no useful semantics(fix me if i'm wrong).
> > sk_skb sees ciphertext and the TLS keys are pinned to this socket, so
> > redirect is meaningless. And both sides racing on sk_receive_queue is
> > what produces the UAF.
> >
> > The fix should be to reject TLS_RX when the socket is already in a sock=
map.
> >
> > Note TLS_TX + sockmap remains useful and unaffected. =20
>=20
> Additionally, my changes seem to trigger a failure in the
> test_sockmap_ktls_tx_no_buf test. Specifically, it attempts to set
> TLS_RX on a socket that is already in a sockmap within
> init_ktls_pairs. Since I didn't author this test, I=E2=80=99m not sure if=
 the
> TLS_RX requirement there is essential for what=E2=80=99s being tested. I =
could
> use some guidance on whether the test should be updated or if my
> approach needs adjustment.

Your report is narrowly for the verdict-only case in sockmap.
But you're banning all TLS + sockmap.

I think we need a similar workaround in sk_psock_verdict_data_ready()
as what e91de6afa81c ("bpf: Fix running sk_skb program types with ktls")
added for the full sockmap path. Or selectively ban the verdict only
format. But that feels a little less clean. Dunno.

Please, do not repost this until 24h have passed. Maybe Jiayuan Chen
or sockmap folks (who you apparently didn't CC?) have some comments.
