Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961D3E0093
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787338209; cv=none; b=FnaSRpwdkrxivD4bPf+oMI6LkhTFc66V8e2iJWMUc2CaEx/Dd+eN1ImkVwCW2RWbkz8AacRVoWnydjcA+8091k7ZcRB2a7kOYmEt74hOekLzP+dsakHFECuadGIvcAVH59cT1+0RI2ynmG9MLP2HdUFub9toR8wywJIpW5YP3Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787338209; c=relaxed/simple;
	bh=w8OhNYTb3BzPB5ojbe4bR270KT2CKHlLbR/449Zb6fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOAvWf50Vqdfuf1qibTNZaWVT+D//1R8OGgnmM3pkjzlcI3fhylwwVh+TlObHAtlx2hc5+1aIGzm10/V7F1WLCfv0ic+IyIqjaCN6ZI+t2J2SMKK5fie0A+iXVif9lnHdrSgVTn0+Sj13VE9UAHTrryiPIXvO/idjvczh0Ozi6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EABabr52; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EABabr52"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84a2c90e383so1813923b3a.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787338199; x=1787942999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8OhNYTb3BzPB5ojbe4bR270KT2CKHlLbR/449Zb6fs=;
        b=EABabr52Z6dwp3O5ofknzIhIb9UtwG8PSiVmkRdBGFIxGHdbEhb8my1sHuSmEMk7wj
         OqMad/QjCK7J7xZ9OxLxDVibiy+CwmPyFWeh4n6TC8zoq75HeAE6Kzd/OL5fxTd0UC+S
         217tSEi8xkcQFb58SE+7CjxekSzBp5ykSJtfAKsFBB1IgclPMV/7z9UCTNbamsUOto9l
         lHOrWbvLrUU3r/wdW7je3tKtlXKGPdrXCSSIMPe3nbmN289GIk98vYt4pocylvV9L7JC
         UH8WPVbLTZwjiVPeYWiyzzZFL7cgQ1G6b6AEqgX+c5mXllFo30MB56w4w07WoZzzR4vH
         Vr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787338199; x=1787942999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8OhNYTb3BzPB5ojbe4bR270KT2CKHlLbR/449Zb6fs=;
        b=ra5Qvd5qPQExZyXNeEwcJbWdky0HIeYFuqXqs1CP2I0Dfa5+BMXX6tQWVcWsi3SguC
         LRVePN021jPmJGLrWN+/ZjdTjXBF4SbP7mqnBB87EoxsUyuYbeQKuENscOrp0kqtP9V0
         nEUNe6b48tP3bwPiefUZQR/leNYeSsWjiXlMW0z3JWeVDgUWr5c4ZtPr3fRaLJyBPEd8
         64l9yb3ssVO4Toc3ba6SYgtN4sPPd2bx16QgSM2XMqOU7YRL7gEYD8XXLojZD15KOUeE
         7jRm/t6zYZ4miGPAcmaAA2JC/zsJq8huNzhIQmzUU4Y3hyvTficaFhzpfuHHMwsOAb3p
         KRUA==
X-Forwarded-Encrypted: i=1; AHgh+Rrb7faH9bgn3bE8R/9NHmZsJZjB6CgkF+pMe66Cl4SoChmir6c2/15WoI28FFpC9hRRWD4=@vger.kernel.org
X-Gm-Message-State: AFuF++nd4SV1LA5ulyx24WnV5nv9v/mf3uek/BOJ9Oz+Jq5C+6B4eLRK
	+4PDpfKCeKQqnHnjR6YxXPk+KDoxwvones3xXQKAzJoMFcgOrB0IpppT
X-Gm-Gg: AR+sD11TjiSpKwvAaLuRl7Kj/MpNbCQbLOBXPOXN83jArb0G2hUFpCoWf99g3UxDHmq
	Wt0wpYM5aExZ5ylZ2Zk5A0SIWi91+Llm7UJIOdOYGG0+q+HzH078KXnOj26aUpTAqIRXrvtblwd
	CIYYAGAbeSpyftiKMeG7AxYi5Q1ik4GBG5dMNhiXD5IFhMHUaElG2+IZAuFAZzWyp6SktdYGbFC
	Jb5fSmv4EEbJQ7NOMumamEb/O5YPF2FGN8ZmsPJ8usUm210+nLhgF8NG0UIfN9cIGjAS9HKbEQ+
	1gRvuNAdPzApDAM50vqPoZXIjvC7/l3mpkHu5CqRiTOsnWUn6y5sB5+v0vJLut42FVdKpgpQyC4
	CtebDJDVISxwlZOBZ15ztm2OSo+Jzcnn+pkrz/d3KPXBXWLLJDqrv3hVNsb8KlfIQpOOiPBRAUu
	GHlxRF2uIPNeqjPrn7Ol7/Da+QJB0JSGVfWxRvdODbqMChaSo4rCycAWqjVKcvy6wAUxcHDaJhI
	pf51inwMMDhOEj1vtYG6tvo
X-Received: by 2002:a17:90b:3943:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-395c50b43bamr7549988a91.8.1787338198788;
        Fri, 21 Aug 2026 11:49:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:a800:1010:54e5:69b5:423e:871a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e14b4283sm165982a91.2.2026.08.21.11.49.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 11:49:58 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com
Cc: AutonomousCodeSecurity@microsoft.com,
	andriin@fb.com,
	ast@kernel.org,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	horms@kernel.org,
	kafai@fb.com,
	kuba@kernel.org,
	kuniyu@google.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	yhs@fb.com
Subject: Re: [PATCH net 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
Date: Fri, 21 Aug 2026 14:49:43 -0400
Message-ID: <20260821184943.867-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com>
References: <CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review, Eric. I will send v2 with the data races fixed as
well.

Thanks,
Cen
