Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F870486BBC;
	Thu, 15 Oct 2026 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059143; cv=none; b=CdwLeelbfPO5QxLJG0Vt3W3CMsGbhSwfBsC9VHGM1eZbr685m0odMSKraMS4nTRn1jAbVBzWi6q4H53StVxShRhF1FSNQhzLGRTV3totwicwiJdyDVyJofdRIUjHcbvM1ySWXNe+WVhV7yR9GbbEj3RraAgUBJAppOsBTC7y/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059143; c=relaxed/simple;
	bh=OJk1cz3CfsO6TmrGjCaPEDykyhiW/es/CCWJikSPDzw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAzNBhey0Gv9sHtJR7ItMLn1MNO4fDr71SwWztRO4qL+pnOaiVht46IS4eWqNeO2NoRqMFpLcYOJT5KXkHosk1/LDgMyn78rbXE1SA6Zv4oYJjYj0Nev1Pzx85o+OpVxs/jMKnTYqiOUzISEpFC/2e0nzYv0wir0p8GjO9Bq7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NS1g0Z2I; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NS1g0Z2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792059137; x=1792318337;
	bh=OJk1cz3CfsO6TmrGjCaPEDykyhiW/es/CCWJikSPDzw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NS1g0Z2IhSkK48VPXeHV6GZx1270udI5iTLqSwhoiro35RwZh7KHd2WE73nIXDsD6
	 5/oUOsNN6ouZUXnhCECLGV6pF3IEfRmNpVMt5cu31wQumHSe9wJ1KVVmJ6khaiLgX7
	 HFDKd2ioeihuSstVoUIxW6t/1xj5ETpVWUgzh3LpAnF3g23BdvNuvQmFAKeg2y9TrV
	 /FoAJkADK3aF2Qd8jqo1x1wuY9NGV+6kN9LFvmkR9ot7/M4X89jNq37gJHfARTfO+v
	 ZH0tBfYDJyXcwOfKiwet6a5WHzDllOzU1DxbMHFVnILQuX/sJoyXMtnKjwQorRirv2
	 upozVtqyncevA==
Date: Thu, 15 Oct 2026 10:12:11 +0000
To: netdev-bot+sashiko@kernel.org
From: quanyeyang <quanyeyang@proton.me>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, jakub@cloudflare.com, jiayuan.chen@linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] tls: annotate lockless access to sk->sk_err
Message-ID: <63MTB0ZQu5tbPM8m7Oa83_El49QoWVCm15ic_XX7RDZNClpaM5IaeZgMhoOC4NhGEzOeVGOdSUpd0EYAmrXxCxXAV1l23w_JhhsImMz7Eug=@proton.me>
In-Reply-To: <179173140561.434549.1271106969659357254@kernel.org>
References: <20261010-tls-fix-sk-kcsan-err-v3-1-e28aadeb31ad@proton.me> <179173140561.434549.1271106969659357254@kernel.org>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 2fdcc952814896e00c571428484493aacfb859b5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, October 11th, 2026 at AM 8:10, netdev-bot+sashiko@kernel.org <ne=
tdev-bot+sashiko@kernel.org> wrote:

> Can the EBADMSG test in bpf_exec_tx_verdict() miss a synchronous
> encryption failure?

That window is pre-existing. tls_push_record() still reports the
crypto failure through sk_err and returns the raw crypto rc; the
caller peeks sk_err to decide cleanup. Folding the two unmarked
loads into one READ_ONCE() does not close a steal or overwrite of
that slot. Routing the failure back through the return value would
be a separate change, not this annotation.

> Should this patch carry Fixes: tags so the fix reaches stable?

No. This series is a net-next annotation of lockless sk_err access.
The consume-once change in tls_rx_rec_wait() matches what we already
did for TCP/MPTCP; it is not being backported here.

