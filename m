Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793162850;
	b=v767ZMe7m+ItZxd8McXop5gjfFUO1KX/h7q2DDTZNfHJpcD36NGymRbUqvIj8cVwliHC
	 NhXMYXqeEftml6/d81JH7VT9oWB+8pc3vCM2UbA0GcO9tGIgTUrvoEzztOisL7C802DLw
	 R/bQmhs2JtGPJwplhhv8WbnzJ2Xlvx8S3xkG0dvjpZHcQzy4woer/QBOySurUJD6ZNepD
	 YRaPXLh2UtK67MqTBMwzDExbTLXB82aTkjyKKjSxtjU7pM2M2GNvsh8z2/OoqmVahTlGq
	 4NkvWWHZANTAb1xbwe30IKP1LV9ffS5AmiqmxJdPe0J5powHr82KUfmOj3d2nq0iuaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793162850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To;
	bh=PEriOiInZOzzIFmLgjcTJauDl3UChyw2thlqsjEs/lI=;
	b=LKs+KrYZY7FfK9EB9q2dnXP8VpoaLj5zkViivfxRV4HIRLVpevCLofnHn1ZscolDFKo2
	 JYJGrbPqUeyOTAZ6VtLe/L6ADONueRcdwn0TGAHPCUgL9hyl9P1rDvjNokpJod42DUzRM
	 5lVRvzjIHCjfFbqjtVhtvOjYUxAZd/XbR0FyOKzhlcZ6mXu/fuz96kMmI970jzJJ0L7tE
	 mOi9sQ16Qbx92LI/WKgq0QEZtFJTAOQyiREJRmbaL/E2bAqHFdr0C+wZUbwl1RO8QWovK
	 5W1NwRuJkzBz9E5MHxxsKWdnG6hUDmiBu3yxJExU6kk5gZZXLywMuzD4OhC/4Ok0/EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7ldyWbX;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29C606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 04:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE29C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7ldyWbX
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso282776a91.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793162849; x=1793767649; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PEriOiInZOzzIFmLgjcTJauDl3UChyw2thlqsjEs/lI=;
        b=X7ldyWbX1NnFPg0mJF8TUbQ3RQOLXQ+pwPrU5jGPJyBZL7+q7XUW5Pt8JWheEFtK2Z
         DtaYrw3WzhMgkiLIeNUw7KkSkYBkMVXIWAb+6bT9EZjDMjtmE6kwwcvpN/IS6G0QP+fK
         kUS2T0l0iGVGUZwu4OCCwmuTPd9NvohK3TYvyfewNfLXv6yLPL5bkMPqoVooWVUolI1j
         eOteU1VlnLYiSh6GGp7zkqL7erikoiHYzCnL5+wvUCNdl6oozR3LFOHCCitB0xaoh5X2
         9p0cOP3gfyFBlJesmEIrkqshj5QMk12hw1r/UFkP2x9ZvW6F1uBoOBb3Ku1F3j9SIUT7
         GLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793162849; x=1793767649;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PEriOiInZOzzIFmLgjcTJauDl3UChyw2thlqsjEs/lI=;
        b=H/nlwYt6WbK/noqSvIbzNt8bKf4QbWffiAmJ7tPtSENU3Yrxvgo88oxjpoAFft/S82
         zsTC9qUNCcLBxqKoQpY0DCvAhpljRFwGrSQ7n8QHdtV0Mi9vWqyJlvj8luvI8TgdMXFI
         7fvip/RqhFR4isQUCSh+uNucGO9nBIP6LfPtvv1bMDkn0rjknG4/F/MtBkNFrxumjXyF
         2MW+JnLXbYFcQEfS7mN5QZQfEBig01Rp99eNbRPnXxr3gd2XKy9t31cg4ThsuPJC9uhc
         X+EOA4IGCC4Ou0zNSUYPZcA66AG2CFkqI2zeuin3Qj2TCuckChmpbeYovgbgr9uGMjHw
         t+Ig==
X-Gm-Message-State: AFq9FYKkQraGe/FtbcktWDChCZa1wAlVkQ/5zEnburiGbNYNyHRArSE/
	9+5D8ubzl/b9zb76LnS5it2csaJSR659iP+1Sa2l8hrLjzTDMmaSidNp
X-Gm-Gg: AYBFou2+n4/iDFF3IwZBz6dFOjDbr25Cq/CklS6oCdw7rNFkrHKgyNt+Jw/VfBy86n8
	fZ+RnFDBn72PWUFHhrDjPrudO+Osyret+lquB/1iYhYmue45jbDFMZ+Y61mjwAk6ZVoBw5WhKCl
	pvb+2GxhbNI2bXT7EdIv9p9A7eIxiXWz1N/1mDbcLoJGkzXqRFZQYdTGIpji9+mTdIbMuYdVm57
	bpS+B2icW29+K2L8lRyhdyJI/W0zzK/bTImn8Q37/AmuH90c6kBfkbuRX1HUkuJQmqa5rMMEORp
	/eStKY8iU/xZ4HybcmiQk4qZfr4jL0b4IQVH9GYv1GemUk+TEjwjs7RljMF1nfHOMdP3yUTjKIF
	XnK0RA7JaUyfk7+RfhVy2X9T1W2pd+UkssF+/3S6jDx1OeW6uND++IEICGa+SXHNuYy/RCpToTv
	vCiUWXYr1CCIslBJRGJcfg34k/mRLKgY7C1rDYPRt/9SacR2oFCXW9hqbIHhwxM1lDhWlJhROqp
	0fnyLeBY6VgvV1nk3klGGJa8/iOMzhQzsla0rCnqnmti/oLw/AHLCCXo5jajRkxAJzQWZU/ZF58
	ElXuba0valkaUeoKmqZc2Qh+mqKS29R4ZY1To4YZ1kUJo/abgtz0Yio0BbpABPl8YAi4i+OMbco
	Uyf5ep1/dsCgjP6hiOc4N02C6eaw8evOxJg==
X-Received: by 2002:a17:90b:224f:b0:3ac:a7ee:6760 with SMTP id 98e67ed59e1d1-3ae57f637d9mr821853a91.23.1793162848927;
        Tue, 27 Oct 2026 21:47:28 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9a5e81sm1052270a91.12.2026.10.27.21.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 21:47:28 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 04:47:28 +0000
Message-Id: <DMG76G7GIPN7.HQJKZIE5J8R6@gmail.com>
Subject: Re: [PATCH bpf 26/81] bpf: Support BPF_REG_ARENA_SP in the verifier
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-27-alexei.starovoitov@gmail.com>
 <CAP01T76dRouzrPOZS8AQ4TMnJ0GzyRm8cPJ8RYUTu01bQgf2Xw@mail.gmail.com>
 <DMF694XH2TJO.P59A31VE6GWP@gmail.com>
 <CAP01T75HAHkP4bzdGzeazN4n_FNd5w1Pckd3GBN68V0n1PNe_w@mail.gmail.com>
 <DMFUDQAC6N4S.1CNBGYKG58DMR@gmail.com>
 <CAP01T74C4bBZntDNLrCxe02prWiF3pnUfYMFTUU6-44O0zbnPA@mail.gmail.com>
In-Reply-To: <CAP01T74C4bBZntDNLrCxe02prWiF3pnUfYMFTUU6-44O0zbnPA@mail.gmail.com>

On Tue Oct 27, 2026 at 8:23 PM UTC, Kumar Kartikeya Dwivedi wrote:
>
> There are other ways to address this, like ensuring r1 holds fully
> formed pointer pointing into arena at the point of dereference. I
> don't think we sufficiently explored alternatives to this problem,
> which is much broader than just stack and arena mismatch, e.g. ringbuf
> memory buffer and arena memory buffer as same argument to the same
> function has similar problem. The other approach would be testing the
> value and deciding the form of access based on that. There must be
> some way to distinguish arena ptr from other kernel ptrs at runtime.

agree. there is likely another option.
Please find one.
but I was working on this since March and what you see is the best
I could come up with.
Once you find it I will be more than happy to delete this approach.
Until then we have to move forward.
