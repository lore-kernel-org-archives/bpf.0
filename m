Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325089;
	b=y3uR5yHtrRYQizdxRT07rEe8XFqsVJA7Xe5MksFW3mpNsr+n3yy5T0OqKRuu+aDOz6Za
	 AZNMfzi1f77NCls2ul/DCG6OJZgKt09uc99X4Yi+RxpVNChTgfgP7JyGXw8QL1aH8EJQn
	 A4Nn378S1Mj99TUgnDc13gk+BJm/uI7f5bCJIOIvTqv6JO49D7YAYu2gu23GY8+ARVTy4
	 eUOUhslhEppqCC/Lav4tlM5o3+y6MpWYSvlKsUzybuUooDSqcEQx7qhUZb7gWuwSGC6QC
	 HxOFyN6J62g3mH3x87mryeWBLb1vvV0ijT8GI7L0mlBtZjSiBi9P8HoeviCheTjjkag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IVo53ZWRUxUZncXLcouJ/TarKckoa/ysa4d9WVjKI9w=;
	b=C6oUnB/wh4YI3vdij68QjELPhXR864bIvKfEtORTJ0eGod+vB93poHrkszND/hlG6HaE
	 Ulu7YRAAjN9ZqIJud7VLdx4BvfgvCeyd2D2/finqwVK2q0CTdY8GGfWxiqxUMD+3MYOGw
	 YZQs/xH8eRhTYYE9el8/O9rG/jGfsMqBKfP0iKvr0SvZgude9wLsxQDP0G0vuUtOmyhW+
	 /6BqR0S2SXjM2CTvXjTSdb4iQwbmZsS6u2uayzqR2Y//FucrlcDHiktKStoNIm3NjmjHd
	 Z7E++i9DTuLLASCVHsLk5iqlih7JMeWp3dVWg3rhjDfL8zc3aj0yDFAQL9cezUB4okA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpxYX4HJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F232606A31C;
	Tue, 10 Nov 2026 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpxYX4HJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F011F008A1;
	Tue, 10 Nov 2026 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325088;
	bh=IVo53ZWRUxUZncXLcouJ/TarKckoa/ysa4d9WVjKI9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VpxYX4HJfpGO3in5SPsTkLkztMer+aY4KhEdu4iJt4LxMLP6GYp5AQStRQi8bGNTZ
	 +Lva1wWNVdUP8kN4bWaKG2te4boPLWczOKmXofNhsbtqFqyHjaa73+Q+zdozZQxeEQ
	 x3IKkdM3ttweOOZTdd9KYRFJi2OVVyrqtPWEf7Z1gggMJmyLqTY+dLP5YW1ESu9xo1
	 3eeNj+M1zD+YSeQCCG89K++LjDaUiZHIhiXLIucTKEsdo45AXqsP1eDMyW0wOPLbg2
	 AwyEWZLcm+Twz2HUfB3N5aq9ssbBBOsz1bhGvsXSr29Ocg9eVvgGb8lm9k7Ud5kzzG
	 +kwZO5mWWwmbg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Naveen N Rao <naveen@kernel.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>, x86@kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 04/13] kprobes: Maintain an rbtree of registered probes
Date: Wed, 11 Nov 2026 00:38:03 +0900
Message-ID: <undine-1794325083765212173-9c2dd2a4d5c010fe@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <avLz8k0gdZwYTeA5@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org> <20261109195517.1090787-1-jolsa@kernel.org> <undine-1794298339502831052-1b6960b8f9b38e7d@undined.local> <avLz8k0gdZwYTeA5@krava>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 10 Nov 2026 11:37:38 +0100, Jiri Olsa <olsajiri@gmail.com> wrote:
> On Tue, Nov 10, 2026 at 08:12:19AM +0000, Masami Hiramatsu (Google) wrote:
> > On Mon,  9 Nov 2026 20:55:17 +0100, Jiri Olsa <jolsa@kernel.org> wrote:
> > > Add an address-ordered rbtree for registered probes. Keep it synchronized
> > > with the hash table when probes are added, removed, or replaced by
> > > aggregator probes.
> > 
> > Could you tell me why don't you use hlist (get_kprobe) instead?
> > I would NOT like 2 different lists which is basically doing the
> > same thing.
> 
> The speedup comes from finding the first relevant kprobe, then iterating
> over the remaining probes in address order. The hash table supports
> exact-address lookups, but it doesn’t provide that ordering.
> 
> I agree that maintaining both indexes is less convenient. What do you think
> about centralizing their updates as in the change below? untested

If you can replace the hash table with other faster design, it is OK to me.
But I would like to avoid this simple-adding another lookup table for the
rare usage case (because of the maintenance cost, and duplicating a list
makes it difficult to handle cases where discrepancies arise between the
two lists.)

Can you change the size of the hashtable and measure how the performance
is changed? I need more options.

Thanks,

> 
> jirka
> 
> 

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
