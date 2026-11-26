Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727047;
	b=f8tq5CejQwV/SfVVOnkKFCZFrGJKeUwiOPYixce2haMZcZJAUnRgXrJ9L5/BrWD15bX6
	 RHY3u9slcGNICm6M0krrvdae5R6w8lCfNI4AvIJSYy1HZB/KmT8Or8k9IGcQpwuoqXIgt
	 87tqsLPTt1L+eYaRFvL3x8mTYEfn+Lab4vGS5L94lH1P6rXUBdjhLPBDRvtGnKHKe1oUf
	 TSRcFFnDxrCqFsLfKIWcloDjV/Td0+bZe+F8vFTJ0LLdRGvwIHSCnfEVJfYvWlvawHpEd
	 3HzJ+avvYRVTTvff97BCI3B8/kySKAY/4iSbJ8OAkdFa/Wd1ARurbejUbULYgfaejeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=NzQpi5zLFt48IXOc9gm2YIA1Vaa4QZ9J+BdHMrNcKwo=;
	b=sUSUzuDsE69WaspVTgm//n1Q5jg2iUpo5hCxoCsA+bBrN7sSfSCfZ7cnU80CoUI5TOb+
	 Cy9ArZzT3XgR/zMPKjE23vwyctcAifYXeietaglJUvVoZmevFTEZmQkNDVZLt5/iHzp5O
	 AG0eh1Au7+dplMyPX2Kc+p+9mqOXnxzaHUx7nKd26x6AI7y9l2dTRo5LC5ynB9ia+BlK3
	 vOIfPjwMBZ3Qk6ohKo1JUul7pKFnmtjK/oPtX38ORFTFb5GB38+rSLRgsuoB1ZXITg7K/
	 zYr/l/itZ+Bks+dKwRJQTmQ1pHjYkGAqLgo8xTdgfwNfhgEEhb/9hVLHMXCCsO/v5Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4FG2nRb;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79341606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 21:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79341606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4FG2nRb
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a9f9473029so5571376b3a.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795727047; x=1796331847; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NzQpi5zLFt48IXOc9gm2YIA1Vaa4QZ9J+BdHMrNcKwo=;
        b=w4FG2nRbTI6jBZB8IjIqFjC4oooCxLJV/E4h15HyzKjb0v2HKu35ERPi+n9hRuvPvi
         4DAnrKagzYWi91YvbQ4Wuk0m9yHTJZ4ia7iKOZfTkAHfMkNBIayETrEB/Qd4v3PY9WVv
         KzgKa3QSLXU5B8NZfvH11HegG6bU0KYBRtEsL4VwbKCbYwkh0wIN85RMq7vMDQjdRynE
         XBXLdZd37ulr7YnJ0MK70RksSxad5Px8bTkTRKfWBgLtQMzkAHNKWI+lHWgC3K+pFG/X
         3a8njtoVVEQYpGxAd47TPeuZ0lNnT5CCzy+iypISiWQ13ciwt+DPTCiTo5xLdm45ctFg
         Csew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795727047; x=1796331847;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NzQpi5zLFt48IXOc9gm2YIA1Vaa4QZ9J+BdHMrNcKwo=;
        b=fn/79eJiXTmeaijxqXezgqeNv8AAgYF00siArb/Ii6IhaJllFXsuEyUBGtUMdj/fba
         fo0O7E43euvpE3+BqseK3JP8RS0SLECMC/MQMhJ9onI9GvzXutPmro8UE/CnHFYIKLvy
         f7hkXu8j1wb+9xJov+4W+W2FPMZitdoj5O5T7C1ZRkJ5vcP/JT07Ss87o7XPQibDLc0H
         I7yDntiQt1fL5tNZSBBSPvi4gsiEkZ1yDGDIDjZD5VikVP4Kc5PaEm8HCJWfxjnXu//0
         pb+pUXdFoUOSdjITZnxqTRHhGiWlgbYR/iACAV85cDDXaac2CnqeZLJsIGS/0dj1ssD7
         0usg==
X-Forwarded-Encrypted: i=1; AL+hErGec80glNiFh9wxZnVtpL1CkgJaPNM2KGxJL3qF/vEJ5RcW0OeN2+Q45dAdcPvNWNzknac=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gJrFDv62gFimyH6qFUsUr+m4rwrqepG6MS97eOwBjqtnejx1s
	ylRRCiAJv8nECLo2JLIZdWxBzz2wrJrustb91hBkK0jk6WcK+rHTCncn
X-Gm-Gg: AZFdTZfKMXnaeTU+IwqLFod1s9B4fs2X8cmV/PEwqLOWyEiC+ewCvKRrJspttIk0YGQ
	91Jl0UUGz8hetzjsjHcmN8IURPQhPawygDD5fsjYmV8dg0mtpPeY9yHeh+mj7NzBFR2srdx4IcK
	vder2cnN8ck4LExqFFUwg58+J4SZznI1/sStLBkSd3RGKQedKzVKGANgpTEPaSKjdAFTOXIKD/p
	wID+j7SWuZIXdO6+cLcGa7WgkMiXE180O5WIYc1GN9XHsqxrw3AXfRE8FBZmXDmC8B+v/m/P0CS
	g7InP18bZmgznOom/4YBHq2D4EskfLIarnpaI+anoNJ3b51H9EeTB/bc7hf+tIrVjvDAC5MX6v7
	ruGq7sexan3xK7yHaBayiRqh5vGOQOS/XXtUiw7FgO9y9HUTBBIXtngE0q0CszZDW1kxlRE7lvo
	Dk/6nZX4ijvBGC6Y3xYGMOx6o6OKCJlbz341IQfqbVtSQJwdT3l0Eozov0SbqPJFTme+wkZNjA1
	e90gQh/wJIhFL7HjMbY8wyp2Rz5gYdoiR+ySdkiOHr0ikJu9xCdY4X04VUbdu70u42UwcJ7UJcT
	SgjGU1/c5zjzStP/zVjQ4RKaetQbT5dqfJ7eZBWZnhMa2QN84IIARihda+3eeuVyapRQ52dNVXT
	ZwVinzk3obs6TECJPs4YNRI/vFeue6d+hG98=
X-Received: by 2002:a05:6a20:430d:b0:3fb:1640:c525 with SMTP id adf61e73a8af0-4014dd5bab0mr24693403637.67.1795727046733;
        Thu, 26 Nov 2026 13:04:06 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4af1fsm11430391b3a.28.2026.11.26.13.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 13:04:06 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 21:04:05 +0000
Message-Id: <DN5G409Y1VV6.FWWRMP1I8IB1@gmail.com>
Cc: "Harry Yoo" <harry@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <daniel@iogearbox.net>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 <linux-rt-devel@lists.linux.dev>, "Vlastimil Babka" <vbabka@kernel.org>,
 "Hao Li" <hao.li@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Brendan Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>
In-Reply-To: <3a44dbfb-265f-4749-b411-9491a0bcf8c0@kernel.org>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com> <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation> <20261125140902.GE2668804@noisy.programming.kicks-ass.net> <DN4QLI2XAGO1.2DDIFJ49PNRPS@gmail.com> <20261126094403.GA49833@noisy.programming.kicks-ass.net> <aecebb39-47c9-4b0f-a076-ac0ddc7724d9@kernel.org> <DN5FM9P3X2P0.2IFD5DFBRELP1@gmail.com> <3a44dbfb-265f-4749-b411-9491a0bcf8c0@kernel.org>
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

On Thu, Nov 26, 2026 at 12:45 PM David Hildenbrand (Arm) <david@kernel.org> wrote:
>> Which part?
>
> kmalloc_nolock :)

lol. Agree. I guess it is in some ways :)

>> I don't see any new concepts of failure modes vs existing code.
>
> I hope we can sort out the rough edges.

100%
That's the goal of this diff. It removes one of this rough edges
for user's of kmalloc_nolock().
Today it can return NULL when another CPU holds zone->lock
or n->list_lock. It took long time to debug in production,
since it didn't look like lock contention at all.
With this short diff that rouge edge/corner case goes away
and spurious NULL returns disappear.
