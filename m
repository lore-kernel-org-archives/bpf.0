Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578559;
	b=MOzXw4Wsd+5bQSsW9RLTGR06g5zeS5f+w3lBikujm9L6tlCXXvqBTdNINPXidQnlshPJ
	 STL3jrZHvnprcreEGA93pEY6Qtz3nH44JV4wESRB4XHs++HA3wnOtR24EvN1pfnGzf68s
	 S5R8euCmN2Hz7NGYaoLz1RjWfBnt+la03VwZmm0sRiXy5zJVEl74qjPrIcCvRtL+mXU+L
	 BgjrbbbF2/bUOI4dagJBhhBlZt+sFsP+TQieN7n1hnH5XMtHGUNYPJ1OhAEhEU7Likdmm
	 af9V0esqQXo7IVvptdUDHm+ubqUYZSw7RbM7kWt1bhjZDQHhTaTRG4zuTpZTwFZZMkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=gOTk+4QV9R7r+hqcOhyi+ZUpTGPG1XQYb6SJ4CrnYRs=;
	b=cpXQK1hOp3D6yum2DJYhQA1Jy98YcZMZ7DZFiMH4Sg4iAZd3m6xSpuh9XyXxvb4VSpPA
	 dz0A18M/v5C+DPEGeZckuQFe3nsbpk3vojbpXpiCCHAuXI5AAsgE7QhSl8PN1ELTMu2WO
	 Ne/ssNnQKXcmR6hCXvV0622mLoD/w3sjg4pyS1HzqouHDYOZO6ugoXKQgC2wYV4pw7Y3I
	 +PS9zLQ8StbvPeOOWNy3IkqlsIuClAxB7orid/qqLnjUBpMe20Hid+sZ3HBVe65PUgZdv
	 MUxtsyO8/Nnwllmr/rYHoy7dyqG81iXVn+Cz7H1a8jYQ6YdSW7LTQAMtqwZYR/feAdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6E5FGp1;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0812606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 00:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0812606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6E5FGp1
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso13542755ad.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 16:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793578558; x=1794183358; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gOTk+4QV9R7r+hqcOhyi+ZUpTGPG1XQYb6SJ4CrnYRs=;
        b=X6E5FGp1fRWEJvP6dFCEW6iONcxuuBTQCHYR9GuaDNiD8qpWJSbE8dGdvLcN0FeWcg
         romalqrs22M6d/uErTVRWlezi3rBd93vifgzSxl+aCFEoFudtOqnLtCoB7DiOBIYflDr
         UeL/PEABYrr/OJOcthGljwOh8vFbjt2HXU1XeuPX2VSkuNTfoGVLXud4nIA/Tfy6oCY+
         WFFes0HVKOfTIWHsPLNxql34g+fwc/H9eke0Vd0w+NcnAQ3YmD2MYYRF29lv00DuihBD
         OqoujEZkbeTotxebCHzvjqUhiDLOyJpg3tKxZzzNisdwR1OZhZEkZXllOUWe6xpYkNnn
         lmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578558; x=1794183358;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOTk+4QV9R7r+hqcOhyi+ZUpTGPG1XQYb6SJ4CrnYRs=;
        b=sT2B7rQF467WC1IzLqJazcomg1iCR2wWzRx65+C0KDXRZ1aHVA0PwC1iAXCT6EBj5k
         90ssIhabBrDnQ1zPmZritpxDy6ufW33sMnacHlaxiBMJwweESGS+Y1mwQKDlsqFuMSLk
         18r/BJISCDi4e3RnuqBDUx43JaCa1ULOHDGKxukj5jViQqgicuLFe9dvkp1qGrUzy4oi
         Qs+FukXzHiMRFuUatewEP8POWShuIugPMw5/6yk9F9dxCFt9P/jIYzdUbmlOmXw6tDgE
         Gjw+Ds3jBIRzFZxv6tTl/RAcPTyh3XrQ7IZOHKb8wO2hL7gOFsJH/be9q1W9OR2u6m/d
         /L1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzMKeCfxuSgx2h1hDsOpcjBRIweR8BapQxNoc7sCNqqSPzkuAm3XOHaQCwlB6S+a07mOMU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8s3L6eeMHYqStAhzwdWAbKA/GuOL/U/A3UA0m5Jp7xFeCTh1HP
	ZZg473BTJnX+cAtoeBkIPLBLX2nHbbnS7GivUAmdFgHEIlZ+/jHpmoF/
X-Gm-Gg: AYBFou26cahoZHwxebUcByot2e+5jYfxoaHvvcmPrpMcrrjbRVkHqu1pCGgyB7PQVaQ
	oahN8bFvTA9BHg/04MvVTVLqNS9qPEL0XUNAmTocGN3BHJIfBrBKcuWjjC1OeLrVu0Lsud2w9cF
	aNETRdBhr1/Htxy+C+8RxiRt96cVbKGqhUv96vDgEUIMfjnITgITJjxlHlJ034vkzLjwlD2+Ng5
	1W9+I3eX1Kq8BMJWeUatgX4LX8YdvEaa3ew/bNENeSyQfaactsU8TuXYR/1JUspbiYFjKUXgiVV
	aG4z9H7ug1eIpelvpt3QCl20UAVGnDM9QtQbwRivp5DygaxNdG5ojVO53v4iNSll7y0ANMJ81zB
	8Hmam0t67XH4Co48VRWQHOhSBw/7jnTuelwBJ2S8i2ncJ1wUoSMZzovtN4UDAWYODWo/nuVCo9T
	zOB9uFz53bJFJiB7aNMgbKaciZ8KFd3swOk8huUC6H4YdTvhpdH2WFOWhn7HoUC25cAmkmIJ023
	eU5gscuBbRTTQ977J9WKn9HlAZAh/+pgQgvUi4KMHTz5MNyaBQ7NXVSF1234MAP/AGUxhmP7Gvy
	mRU/7mVKq0RdG0CeiQa9m53Xu/ilTobv+Bh1VSOUot491737bFfMRR0kENF2Tu72mLU17xC2OTc
	z2sqEe8f93KzsQb3JZ/+FpfbtqHN/w3wKJjIDCA/wuqCQhc6JGZfEJyy3
X-Received: by 2002:a17:902:ce04:b0:2df:9a7e:d41b with SMTP id d9443c01a7336-2eb36462d49mr84627265ad.37.1793578557953;
        Sun, 01 Nov 2026 16:15:57 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052ec9sm20149455ad.6.2026.11.01.16.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 16:15:57 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 00:15:56 +0000
Message-Id: <DMKAJA4HTOBN.O8XO807UAB6Z@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf 02/15] bpf, sockmap: Don't let an SK_DROP verdict
 stick
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
In-Reply-To: <0dd29e75d62b7190a9808444743fc5dcebd3fd42ebff15602c7eef5a9313784f@mail.kernel.org>
References: <20261101192057.2296489-3-alexei.starovoitov@gmail.com> <0dd29e75d62b7190a9808444743fc5dcebd3fd42ebff15602c7eef5a9313784f@mail.kernel.org>
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

On Sun, Nov 01, 2026 at 11:39 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> Now that an exhausted SK_DROP verdict resets psock->eval, the prog runs again
> for each later message.  Does that make an older accounting problem in this
> branch happen on every message instead of once per socket?

Only between patches 2 and 4.
The wrong return value is an old bug. Call 1 hits it without this patch.
Calls 2..N return -EACCES today only because the prog doesn't run again.
That's the bug that this patch fixes.

