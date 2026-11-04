Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754339;
	b=N4mSWJhjqbRVrpIBEMrbX1xo0XwUE+a+oWdJcRdJXalgKVskGzt6XIWK+vV+j5YE5mM4
	 z89tGjFUbssBxu0QzXwDoemZON+Q0yOfZeusQWe393CxtZntr5c5cmBmbjWkDjJEDeCXT
	 jwEu79oLs6zjj9mrGpcE4PgEMWVZ/hsu7jbA0/zi8LKmzcLQPRqyqHdpFL3NXC6hvALiv
	 Am8M/R35Glc6boPXzagl0GrIlxLm0pmwriNbSCQdAzxYmYrHjjVo0C8S6D7Y06ssIm1Ax
	 YCMnTkQLFwxPGouX9a3JJSiCd5tuSjedGxtF6Er7yle28h1I/xnSfqcOMEZ6nOXIHAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OiYsGaoqyzKUnz3XPaxnmXkjL2zBbGhsRecYGJNnKlE=;
	b=z8S2/KQ5D52pxCY8TpwG4EFlhxPuw5dx/NbdH0Sz262UMgQyHm0cBb9u8gebNYQRRoIw
	 IP+BWfV4eO6z3zcHTNQX7ykb+24a1siP2a8XqiHG02CdU9PF9Z8BXPcShyaGgqThP6lJj
	 LQJnkR6pD48OxnEm+mH0WUvPM5pBZ5xFdZavrIE1qh1cAoSssXZDTkWdKw1Eu5OWXitlY
	 TNd9PaeQ0I/JDXqKEWJcZmfqG20Im3V7QZm9nN/HIZFvf6yaUfgZWriGWVmD6QUsh37H1
	 BbgIFVBxseYkwavFR/dnVrIeFlw6EE371VloCloHl/JB+B+OZBfEH/XNi3lNpgjUfJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZOi7AzfV;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF3606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08CF3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZOi7AzfV
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso125244a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793754338; x=1794359138; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OiYsGaoqyzKUnz3XPaxnmXkjL2zBbGhsRecYGJNnKlE=;
        b=ZOi7AzfVPkkrrQ4TF8x+Dj1Jz248HrDrecpVwRWitOb1htWwTZ7fvdFDtqy1lpIq/y
         Beq7CW2JLnfhCtrJxE+i7jJLlDQlA3SioAo69vujrVSUly+CmDusuwpquArWgjcgfDXg
         HpXPpZWhzrU+e76eiHaxOp4cNa96ZY2gnuna4PcNmgw9FdWTH+NvAtVQgn7d/6XQTGPE
         nQLSIqQP2oqKzKqQ1CjoPpI3hQIk6qSG758/RaO9Y9W0nz28O0rQH7Cj94KWaaWYvz2P
         FZXohTsNfe96SXvZmSqwog+8wJEH+chac6qK03kf9Rwkefy4BF3WiLKJYbI8KBgW2247
         EwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754338; x=1794359138;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OiYsGaoqyzKUnz3XPaxnmXkjL2zBbGhsRecYGJNnKlE=;
        b=R4iX5XzW4Ggf5zL5EdjGKeKGTenbS08TQCMo0UvRvV34uM3GwOIXvU5/ukKStusAjW
         fnnj+jGlh3AUggGXkdAwvBE3Hkd79FAA5DOcbDRFbVx/PdcLg2p86pbGpPrTpzANFv/p
         sUaAiDKOu9hSmMJo2aLGZqqbW94AOG9CVhQSxiKyy/RuLXCSC1Lo5QK43GWrN90f3Axi
         NCRrXh8cS59MiniaQuFcQcrxjWKJZ2Iqou6oJhwGp2MV3n69FjhIEtnldUbA/ZRl8+e/
         Y+PvJq3h6MVjmZncHq/Y+BbA30DP8e9UVKSXpEbMh8fuTK1ETLQJhujaLApPcvqAla0c
         cSbw==
X-Forwarded-Encrypted: i=1; AKwUvBwSacroqw1l7dpo9CrFwqTF0pqPllfZ7d7MVPAnXQuKM6HXiT5dpyWkhPQnZfqd8KDsvZE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+slUcj0Bgvdfjz6T2k2Eie8xGiZ+5uAK/o2/g9zXQhzi73CBhp
	kpqJCNpVYNi8j7Jp5A/BMwNoJMAHCU7RZbJJIMNOagZE0vFryNxmpNbQ
X-Gm-Gg: AYBFou1Uazz6+lLkGRiSv2FwZyn+NCRUzQ2GeockcIhK1DfVEujEJ4cJey7qzK51YOk
	aDiBkmQyw37Vb5D8fbhYJ9t+gtttA6qyb3qL/xcjv7wF5s05xrFOGOEAREOjyT5vv2nuKnLrE+s
	mpAReTb7tKiN22DwkklwNLqWNDfOePpw6ZcCrWDVioKhC/iaROhLRRQui2sJ0evKpslM18JKNPM
	bu+n7pJSmnw5EQkXwNxmajNXSf9UPDKdJg8rGW5ZOmsS99BB6qqZ9F1KOIZ3dWI/8TDS825uqUB
	drJpgf9VX3P1aEFB8uNq5l2FBF/jwXVDsgKrgLrsAdrk8wmGbtoSoYdnbwrzl/uOT5rMyvpw6nC
	7GlpXaUCtylINYQbqzuUVJyvukqvQquIvsTkhXfvUUzmyu5ZpFVR+/8XnyRwrAMgmNcAyiwymSV
	V+0BXdU1smSjDMzezeD7Kt2kmRvK8JRwGE1wo+MQcDxgs6LeafvZ8JzpSBU/CkQqqzdZkPiw/NH
	EGsL5oseFz5OZ3fdDFIQF6+2EHgGL6/6WieXDaqiirh0kEbok0xWsi5peSngZAmB8MgwszhoyYH
	lOGvAa2DgCVblCTvCqq7xvnd8qiFJarWhaUx+/tVSN4izUYpY5RU5YkXcKQuB5wLu2jg1pBKCeM
	2GcBrVFaElpPh4p8GuH0r0uy/uCEtKTYLBQ==
X-Received: by 2002:a17:90a:8398:b0:3b0:9984:18c9 with SMTP id 98e67ed59e1d1-3b0998422c1mr181065a91.11.1793754338082;
        Tue, 03 Nov 2026 17:05:38 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944d1a43sm1272825a91.13.2026.11.03.17.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 17:05:37 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 01:05:37 +0000
Message-Id: <DMM0UEKUOMVQ.18RYWJLVRPXUR@gmail.com>
Subject: Re: [PATCH bpf-next 06/37] bpf: Count stack arguments of a static
 subprog from its code
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-196294@kernel.org>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com> <20261103234104.208239-7-alexei.starovoitov@gmail.com> <sashiko-outbox-196294@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 04:14 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +	stack_arg_cnt = bpf_in_stack_arg_cnt(caller_info) +
>> +			max_t(int, callee_incoming,
>> +			      min_t(int, caller_info->max_out_stack_arg_cnt,
>> +				    callee_info->arg_slot_cnt - MAX_BPF_FUNC_REG_ARGS));
>
> [Severity: Medium]
> Can btf_prepare_func_args() leave sub->arg_slot_cnt undercounted when it
> returns early on a static subprogram with multi-slot parameters?

[...]

> using the parameter count rather than the slot count. Because this
> undercounts the prototype's stack argument slots, wouldn't
> bpf_fixup_call_args() reject valid caller stores to those trailing stack
> argument slots?

Not from this patch.
bpf-next has arg_slot_cnt == nargs after an early return too, and
bpf_fixup_call_args() rejects the same store with the same message.
bpf-next also rejects the load of such a slot in the callee.
