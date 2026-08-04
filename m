Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C48448D0F
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840626; cv=none; b=NbbHN9xJEXIiJv0N1/v3FA1xKTIx4zewgsUNYgPX3f6nPscdAe3lheBXr1+ersiJP9a5F7x3ywunWKq3pSx9AbK71xskRcciPTN9Yx3LiNHNGQBSTE3YLg2JPn3NOZkrNnFOBzpdzf4VgfNby30jWl2VeRxDMAmVgupqVepK4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840626; c=relaxed/simple;
	bh=tHA/8XTS/8WfJgX5CUbFWf9+gM/JaNaiLdshfCa81AY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hIbhkEcFTZtJo0kgE7H/syALD6HcB2rgWqfXTQQWz3KYWFy6re0/xYYR2E1xpfWh2yrpGXVW/Lh++Vtsa9ylW04FkVa/pvaNwid2lJVG9kKVLmx5DPnZOgfXKPkgeZHz5CFpIdg0ZPPNqyM3psgEobp+AlBKeCwJ5jFyZyZM5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WofishHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WofishHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8246E1F000E9;
	Tue,  4 Aug 2026 10:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840624;
	bh=tHA/8XTS/8WfJgX5CUbFWf9+gM/JaNaiLdshfCa81AY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=WofishHTiBM/JLzjLaj1fqafLRnnf8XWQCmfBdDVbCSioPwKzVXzx3M0583KW3RO6
	 2JGdLvjcNr/qIUnsu4kGOZamYJjKzQmucHr7icqcOU/oJXQ2p0HdBQ6XXoY5XVd7XA
	 kdclo1glV+bSSHWu8hQVjEe9MRfB2TXTFs0TsxOab/msJVXQcpBeh9sci84ZKVb+jL
	 wsKG7h59ww95JV44F1A6iAmyVpPhkIlFR3wEmgDJ1ao9eA8XVwf5UNz6CC4qBSKoUN
	 hmQi2lWahRwcVlq1DFd+Rd4f3NT5cu0c+tBaHMdZsEizqBrQqk06ejoIstK5i7VHj/
	 LFigBR934N8FQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Ning Ding <dingning04@gmail.com>, bpf@vger.kernel.org, "Paul E.
 McKenney" <paulmck@kernel.org>
Cc: Ning Ding <dingning04@gmail.com>, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Invalidate RCU pointers after
 final spin unlock
In-Reply-To: <20260803112615.3362122-1-dingning04@gmail.com>
References: <20260803112615.3362122-1-dingning04@gmail.com>
Date: Tue, 04 Aug 2026 11:50:10 +0100
Message-ID: <m2zez2i2hp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ning Ding <dingning04@gmail.com> writes:

> In a sleepable BPF program, a spin lock can provide the only RCU protection
> for a kptr. The final spin unlock ends that protection, but the verifier
> leaves the pointer valid. Another CPU can then free the object before the
> pointer is used. A capability-limited runtime PoC triggered a
> KASAN-confirmed task_struct use-after-free.
>
> Patch 1 invalidates RCU-protected pointers only when an unlock leaves the
> final RCU-protected context. Patch 2 adds a negative sleepable test and
> positive controls for non-sleepable and explicit-RCU contexts.

I think if we are doing this we should do it for all things that act as
an entry to a RCU read side critical section [1]:

1. Disabling preemption
2. Disabling bottom halves
3. Disabling interrupts
4. Acquiring a spin lock

As you are doing it for 4, can you also do it for 1 and 3? I don't think
BPF can disable bottom halves right now.

Paul, can you ack this? Let us know if there are more things that can
make a BPF program enter a read side critical section.

Thanks,
Puranjay

[1] https://docs.kernel.org/RCU/whatisRCU.html#:~:text=Note%20that%20anything,side%20critical%20sections.
