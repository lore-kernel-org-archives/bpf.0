Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E93BBFBC;
	Mon, 12 Oct 2026 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831410; cv=none; b=LfTz4Q+NZPxe6PNTj9ziFYi9tA2hpg+o+jpZNqMNc5uiGx5Bau6ITUq6ju9UYYg+HMoIYAgkDzQJQsV8LGiGmIuQHIIACw1K++VQyOMkndHbZEClCRWjObxbCH6w8XryOGyVhbemi3jOwIC0dNBxDF27EfJ9ft81un940bUDYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831410; c=relaxed/simple;
	bh=0KoQNMqbI064B8xjtyvLrDixlTFdTVthLsLSB/NCxIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WPxf4KnyKVrmKAPXwVXzAkUR+MGggdtLUC15TLEXojeTziq2SuaD7XZLJRNDLk6Ga/xqOMYDuZKTddRdu4e/pcmQcGYTfYT1nqUIb2q7XXVBD8CzP05T9NLmURVyyCDjNNmpaOmm9cmGQPKdEp8VQJIUp3TaBnpDPbEjLPluQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUUUgAmS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUUUgAmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACD21F008A1;
	Mon, 12 Oct 2026 18:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831409;
	bh=DE7onI6PEOoe95KfUfw5GYM1uYcrFjxbS9CkwWhG4ag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nUUUgAmSs4DveLGHkLOFbH8HMM7nKziGqQHHeLiJnEYTMZQ0lnEOjaZNNGByl5fau
	 2Vbyak4BlmWqUF4/QeNE6USAWsYWWbhBJSUue+JK9I++U15+Klx/3MGD1OHuQPqKq2
	 6n4Qum5nx/nPhjRVLyuA9cYRjIo7g674FCgCOkokIunSvQNV+bAfpeq3A6jO51DG5m
	 ss/DrQESvpVTqXbw3wuQHvAcBmdIZ5L2VRwC1E2SkZNTKcroHOnRR54RkQ64wROiKn
	 A/NdwJCYK/wVOh1xk5/PgXDxF838LyPbne4b8+isdoXrTjEECA7WyrZvPpU38Nsfsb
	 sAV3MOzTzbofg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [RFC net-next 13/15] eth: fbnic: Support AF_XDP zero-copy receive
In-Reply-To: <20261003190241.90D191F0089B@smtp.kernel.org>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-14-bjorn@kernel.org>
 <20261003190241.90D191F0089B@smtp.kernel.org>
Date: Mon, 12 Oct 2026 20:56:46 +0200
Message-ID: <87tsmqagsx.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] net: deadlock on 32-bit during u64_stats_sync update with preemp=
tion enabled
> --
>
> commit 1bc54e591deb70184971cd19a4b1a9d18715cb4e
> Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>
> eth: fbnic: Support AF_XDP zero-copy receive
>
> This commit adds support for AF_XDP zero-copy receive in the fbnic driver.
> It integrates the XSK buffer pool as a memory provider for page_pool and
> refactors the receive ring refill loops to balance header and payload buf=
fers.
>
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/=
ethernet/meta/fbnic/fbnic_txrx.c
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> [ ... ]
>> -static void fbnic_fill_bdq(struct fbnic_ring *bdq)
>> +static bool fbnic_fill_bdq_one(struct fbnic_ring *bdq, unsigned int *ta=
il)
>>  {
>> -	unsigned int count =3D fbnic_desc_unused(bdq);
>> -	unsigned int i =3D bdq->tail;
>> +	netmem_ref netmem;
>>=20=20
>> -	if (!count)
>> -		return;
>> +	netmem =3D page_pool_dev_alloc_netmems(bdq->page_pool);
>> +	if (!netmem) {
>> +		u64_stats_update_begin(&bdq->stats.syncp);
>
> [Severity: High]
> Does this code risk a deadlock on 32-bit systems when called from process
> context with preemption enabled?
>
> If memory allocation fails here during interface bring-up (e.g., via
> ndo_open -> fbnic_up() -> fbnic_fill() -> fbnic_nv_fill() -> fbnic_fill_b=
dqs()
> -> fbnic_fill_bdq_one()), the sequence counter is updated without disabli=
ng
> preemption.
>
> If the thread is preempted while the sequence counter is odd, and another
> thread attempts to read network statistics (like ndo_get_stats64 or
> get_queue_stats_rx), the reader will spin forever preventing the writer
> from finishing, leading to a hard deadlock.

Hmm, this concerns the 32-bit path.I'll check the process-context
protection on that path.
