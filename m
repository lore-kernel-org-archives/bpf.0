Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153329CB24;
	Mon, 22 Jun 2026 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169629; cv=none; b=gYY9uT1uVrvZVokhqSgjY0mBGd0FxnsTKuHVkvRdaK17g23ssxwdf6ijINsKG/nx7qrncFW0di+Y5kBV57Hagfprpgur3r3iaiblTYV2hfGmkZU9ZcwkrjD35JdFGFo9hhaj1V32bhqpropBnNW+KMoV0e2F+KRJzGXzJFFLMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169629; c=relaxed/simple;
	bh=ZCrur18+Wg7U3Z/xV/x3d/MB0rbNSKyaG9fG6dhuIus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmwsKoMqnkMvGq/CzuKiMN1PJGKwLs3CEoWO0ZN5UHYkqHBXP1gyZv/SJllq1e0A8iDeXh4eRwJcDAqqJdGzOfE0IVMuDWwXQlWQ8DwWm63aSwHLZZTQMvxJRyBbt3TJ3A8ddYNB9m/spz/s3eJZBAuMiI6YQmRJF0olZGzNDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqgeg0gG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqgeg0gG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701861F000E9;
	Mon, 22 Jun 2026 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782169627;
	bh=ZCrur18+Wg7U3Z/xV/x3d/MB0rbNSKyaG9fG6dhuIus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iqgeg0gGsnJSDop3NXGqNSYRA2h+8cY18oImtCZ+7gf0XPUF4xanvRYp7w20alAia
	 mYmVhJvtnrd+mm+FIAWVyP6Wq9eu8XfHJWaq2PjxIq+MvKJDAAR6O3IERc0z5azaJ+
	 O3SajlwsUKSZwqTn5BvUNIUhLDuOAcqnaSuwFyg4klTz4OLGn8mmHl7GiYaogk9jHD
	 jlO9qmnKKUfE5+LF8tnNq5Mw76rfy4mZUwpZiuMG1BPMTyVuL4bvr6hw3FXIbA3HWs
	 T7Zo9XxwYLl2F3LQ41H4ouzrjDIbdLwohhOZjHg1WBOth9GlHOINAS2J8jBx9u4MGS
	 iZ6KW+Xp+lVeg==
Date: Mon, 22 Jun 2026 16:07:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
 <kernelxing@tencent.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test
 behavior
Message-ID: <20260622160706.0b4a27bf@kernel.org>
In-Reply-To: <ajJsMj0QMOF5I8qq@boxer>
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
	<CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com>
	<ajJsMj0QMOF5I8qq@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jun 2026 11:43:14 +0200 Maciej Fijalkowski wrote:
> > On Tue, Jun 16, 2026 at 11:50=E2=80=AFPM Tushar Vyavahare
> > <tushar.vyavahare@intel.com> wrote: =20
> > >
> > > This series improves AF_XDP selftests by making timeout handling
> > > explicit and fixing sources of non-determinism in xsk timeout tests.
> > >
> > > Patch 1 introduces test_spec::poll_tmout and removes implicit
> > > dependence on RX UMEM setup state for timeout behavior.
> > >
> > > Patch 2 fixes thread harness sequencing by attaching XDP programs
> > > before worker startup, removing signal-based termination, and using
> > > barrier synchronization only for dual-thread runs.
> > >
> > > Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
> > > configuration does not leak into subsequent cases on shared-netdev
> > > runs.
> > >
> > > Together these changes make timeout handling easier to follow and
> > > improve selftest stability, especially on real NIC runs. =20
> >=20
> > net-next is closed, but in the meantime I'll review the series ASAP.
> >=20
> > BTW, another thing about selftests I had in my mind is that are you
> > planning to work on this [1]? =20
>=20
> This one is on me. I took your changes Jason and aligned ZC batching side
> to this behavior, followed by xskxceiver adjustment. I am planning to send
> this today EOD, however let's see how badly internal Sashiko will kick my
> ass.

Hi Maciej, do you want these applied? If they help make the tests less
flaky I think that it's fine to take them during the merge window.
