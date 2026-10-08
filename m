Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F25322F767;
	Thu,  8 Oct 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465209; cv=none; b=M40jGoCR+id1niTKF8SvY0k64u3++xEV+wZyvg8T+YIFA84uGz0uXg9VxbunBzBP83nR7TMBXBiMN59VxVieDUQVbwlAxDzXcvRtkrcJ7GGU1WPiyDBEhQxWzjsCoyAHJNDPukTP1JXdRWlacfGP2TwnKgdS6F3oRs3hRj0Omgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465209; c=relaxed/simple;
	bh=k1TJBFkSAk3KtFliSXk0zhsSmUITNqHtxPWRH4+FByc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qRCHanlbA9zIoAIDIAfegczCSCSj82HnCFxr+oaGd6x1+clX+W6Ch8VLTK1IGHb+rIYVRsgHIBgJsjnDo4tQLTA57PRd3Vx2qn3J1AA6OXUvWGjtjF1aon3LPYpm7IH28ipcW1If1bINr/RgaUjoS8W9Ui1PL7eVtmxdv5Sttko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkWI8EJs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkWI8EJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B790F1F000FF;
	Thu,  8 Oct 2026 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791465208;
	bh=f5PLISdsbHKFluYJ5yvZ5YvG5VrlUsaLajuhgKm/fUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BkWI8EJsBXHH0wrpbxOqswQs8kxgxYXVUniGBKWDEdcDw7XxDYbWym2WUHNNR0fBa
	 fDFrOd83swNWnluQ/buMEf50XvzoHCiwdzJbAIQimdk2cMIT+Udzs3ULu4wm0HyIxR
	 Pr1VAxeakLwNVW4MdicIz/0ZIfym5gRIU+QCjfxOj3nL2xQ/AQJZA2wGScrtzWgXEn
	 JZDKGeaDTLeiWLTs9mSgRByKY7FP6v6yuX0ye6UkVdPljkgVIkQA5gtfioJoFBweow
	 zvO9TUXpo8sthTAnzoH2T7GTIsYIZRF7MbLwTM6/xT/VemRN1mOLW8tyJr+Cmc1oVC
	 HbTbi9Kdsynnw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, James Hilliard
 <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Eric
 Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net v2] xsk: freeze deferred pool teardown without
 blocking unregister
In-Reply-To: <asaTvPO05EpmUEgN@devvm7509.cco0.facebook.com>
References: <20261005-xsk-suspend-teardown-v2-1-2d87228f4329@gmail.com>
 <asaTvPO05EpmUEgN@devvm7509.cco0.facebook.com>
Date: Thu, 08 Oct 2026 15:13:24 +0200
Message-ID: <8733ug2v4b.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> On 10/05, James Hilliard wrote:
>> Deferred pool destruction calls ndo_bpf() under RTNL. system_wq is
>> not frozen during system sleep, so that callback can run after a
>> device has suspended and gated its clocks. Use system_freezable_wq
>> so running destruction finishes before device suspend and new work
>> waits until process thaw.

...more PM suspend/resume issues...

I'd say this a bad smell/poor XSK contract that we need to use wq
freezable here. XSK capable drivers (and the core) should tolerate
calling the pool-removal path on suspended hardware and failed
resume/unregister.

Now that poor design leaks into net_device. :/

>> Keep assigned pools visible to NETDEV_UNREGISTER independently of
>> the socket list. A released socket has already left that list, but
>> its final pool put can queue destruction after workqueues freeze.
>> A resume-time unregister would then wait for a device reference
>> whose release cannot run until the resume completes.
>>=20
>> Track assigned pools per netdev under RTNL and detach remaining pools
>> after the notifier socket walk, including copy-mode pools. This also
>> covers leased queues without scanning pools from unrelated devices or
>> network namespaces. Remove the entry on assignment failure and normal
>> teardown. The deferred worker still owns the pool and later observes
>> the cleared device pointer, avoiding a second driver detach or put.
>>=20
>> The lifetime problem was identified by code inspection of the deferred
>> release and system-sleep paths.
>>=20
>> Fixes: 1c1efc2af158 ("xsk: Create and free buffer pool independently fro=
m umem")
>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> ---
>> Changes in v2:
>> - Track assigned pools per netdev instead of scanning a global pool list.
>> - Keep deferred releases visible across queue changes and queue leases.
>> - Rebase onto current net.
>> - Link to v1: https://patch.msgid.link/20260930-xsk-suspend-teardown-v1-=
1-a6cac8c030be@gmail.com
>>=20
>> To: "David S. Miller" <davem@davemloft.net>
>> To: Eric Dumazet <edumazet@kernel.org>
>> To: Jakub Kicinski <kuba@kernel.org>
>> To: Paolo Abeni <pabeni@redhat.com>
>> To: Simon Horman <horms@kernel.org>
>> To: Andrew Lunn <andrew+netdev@lunn.ch>
>> To: Magnus Karlsson <magnus.karlsson@intel.com>
>> To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> To: Stanislav Fomichev <sdf@fomichev.me>
>> To: Alexei Starovoitov <ast@kernel.org>
>> To: Daniel Borkmann <daniel@iogearbox.net>
>> To: Jesper Dangaard Brouer <hawk@kernel.org>
>> To: John Fastabend <john.fastabend@gmail.com>
>> To: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: bpf@vger.kernel.org
>> ---
>>  include/linux/netdevice.h   |  5 +++++
>>  include/net/xsk_buff_pool.h |  3 +++
>>  net/xdp/xsk.c               |  5 +++++
>>  net/xdp/xsk_buff_pool.c     | 25 ++++++++++++++++++++++++-
>>  4 files changed, 37 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 3cff2174dc03..72091938f6e6 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -2545,6 +2545,11 @@ struct net_device {
>>  	/* protected by rtnl_lock */
>>  	struct bpf_xdp_entity	xdp_state[__MAX_XDP_MODE];
>>=20=20
>> +#ifdef CONFIG_XDP_SOCKETS
>> +	/** @xsk_pools: assigned AF_XDP pools, protected by rtnl_lock */
>
>
> Can we mark this as being ops protected (net_device::lock) ?

+1

> xp_clear_dev calls netdev_lock_ops, but xp_assign_dev
> has netdev_assert_locked_ops_compat, so maybe there needs to be a bit more
> care. We don't want to add new ASSERT_RTNL if possible (and extend new
> netdev lock semantics).
>
> The rest looks good.

+1

I've made a mental note to try to improve this, and hopefully the we can
get rid of this in the future.


Bj=C3=B6rn
