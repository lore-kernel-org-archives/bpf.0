Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CE438D3EA
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782239343; cv=none; b=sUX+4/XyGxy9PhyyFmcqr8SlBiuap84O81s+HbGdd9BywlyQYN0jORq8eDQ1HIWeNsW3zWrTdQuvrmbsCARVaCVjgYLLEhp7NB6krrGzg1GiEskJQGsR7vtZWk50nuCpfcElyRtXRTDKMWiI5PcOE6FJUCXcfLQOhqFVfTTuNIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782239343; c=relaxed/simple;
	bh=ur9YcBIx9OOlzB4KIAFGKXMYB4qRT61i90PE7nu7grM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAQ8Up0BmXJX+hSJ+YH2yaXHhrFmasZhTHjo+U+Ha6S6v5Yq9AWRiZlQ3E5jElu7pvL+a/PMXmfrDnANfDe3ZrhuOA6FENKVpAzTKtCgY57PJzPx8JeR1zbh5WGtUGDH4Be3jivPUw0PdYYDPW7XD+kYjYUBPS0gEm4is/jYvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVAUnxd2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVAUnxd2"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c89370405aaso63130a12.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782239342; x=1782844142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTYF1+0lyIvhIpVE2MUXYwIwgLw0923N5fDH7s7CEkc=;
        b=dVAUnxd21rzpHnZY+B0acolaFB2lQ/rSbryQr5/laYEv5DoVJ30e40G/FimJRVPOfD
         V8bZ7HqM+qBS8h3ZDJTjYyFrxicvx4wfPFfSQ+dM55uMiJFeOpq5NyxldSmVYrah1laK
         I2vedj2wEvkv0Q7OqL/IaeA3gdEtBYEGexVyK/bqEsj/iDpqQ7gm8B674Rplj2il39gj
         FsdWZkUbLUAmHeIb0QLRQH8l/WT5G1JWkwcM1O0fxxLCMqvEBLQ3D4gFBrjToLmYKCVQ
         fYDlATYC8MDtpuYtpjLh9V5t1ei3n2+mrkQExzSHzSQFW9CYRFKf9NWh5HAj80RY/OZw
         ZNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782239342; x=1782844142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTYF1+0lyIvhIpVE2MUXYwIwgLw0923N5fDH7s7CEkc=;
        b=lVkdCZjHHNo9pDoxQRMquBdspkGSZP/IwDUhm5ZJpVknJQKys74W6ddx83AF06bIT8
         q28WqEh1KJOA1XOQQYHeqZbTAv95bBmdjMuM3DDHFvRI8zulLPWtwMWD5nsYM+boeybS
         UcQwiTEzxIXR98D1D14k9BvkclkD45IjLmxET1eR2xO+spRH3ho7AvQ1vgkljK8ekRtP
         XWv1xCYMHhq5T4y+HfnHFqrNJnsM26d2sVVQl4gB3+l2TEQvIrPvomL4CXvj8T8a+Lbs
         uVfOtzItJwLd+RUoosrQO7DHNjsl1NZnwq9uK9daq5/BfwASgpsouYRfLLicPxNjsBJ2
         /v6A==
X-Forwarded-Encrypted: i=1; AFNElJ9QyZmr8kHRHnMH8hf+sJrMKKTqiLDvZrbmyIvRD28yc6CC929gkSEvqEsRj5hdPd99rHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrjk60Spdrb2t2tkTotqvF9wHbmYGaAMl/JC7pIRHF/2XNzX24
	F9GlT8KWJat2yb2N1J7cqR5Emr+jF17FMY2xqY3OADloAGgR9VawgYuH
X-Gm-Gg: AfdE7clIijCZqjjv13BgfK2QbSANzWsm5dh3AlvUOlrYiN+ntDEEjqZ46m1q5CPpcEa
	fEWt4I+ARET3j/H3rV6gmXJRkmzXJyGLd2k0UTYORY9Bp/ACtSKjPgvaGeRbroVkvO/1PDfCbzD
	NGDDhLHCOBL6NXr4z5xCunHM5T8B7kiddBRYEu2oH6PRpykaOQSWNArUbcbNGG2p1NtyL5aL7UK
	/ZKK3MbeVHoKDOeYNtlLElojyjsNUqUtRW19weam66GX1Fa1fKAbdVILO7ERueRaErSJaWMASCp
	+McMD7JPqdpnwHamYPkYMjF/1UUKpXAlSbZlLIfypy9A+gXQ/kS46sYg1d/nGK9nCenlfXKkQ3e
	D1LL9Hr9ZEn26b47hXnQkTJPVSy95x/jRaj1bLLghJbzGop8bSp6vLLXBP2IJYmPoa0oC8hwoey
	u2myGxEd5THDuibulGD81rTEIkXlK1np2j9B1J+FufXSLYtiUfW6WTcKdKSiZx
X-Received: by 2002:a05:6a00:6c90:b0:845:3033:6cb7 with SMTP id d2e1a72fcca58-8459524d4d5mr5244859b3a.9.1782239341727;
        Tue, 23 Jun 2026 11:29:01 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6c5dbsm10835213b3a.12.2026.06.23.11.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:29:01 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	yatsenko@meta.com,
	leon.hwang@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	eyal.birger@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Tue, 23 Jun 2026 23:58:49 +0530
Message-ID: <20260623182849.2623521-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <877bnpeaeq.fsf@toke.dk>
References: <20260623025147.1001664-1-avinash.duduskar@gmail.com> <20260623025147.1001664-2-avinash.duduskar@gmail.com> <877bnpeaeq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Toke Høiland-Jørgensen <toke@redhat.com> writes:

> I think it's better to just move the assignment of params->ifindex
> entirely into bpf_fib_set_fwd_params(), instead of this restore dance.
> That way this can be simplified to:
>
> 	err = bpf_fib_set_fwd_params(dev, params, flags, mtu);
> 	if (!err && fwd_dev)
> 		*fwd_dev = dev;
> 	return err;

The caller-side restore is ungainly, agreed, but the assignment can't move
all the way into the helper. The early params->ifindex = dev->ifindex
sits above the neighbour lookup on purpose: that is d1c362e1dd68a
("bpf: Always return target ifindex in bpf_fib_lookup"), which took it
out of bpf_fib_set_fwd_params() and put it there so a program still
gets the target ifindex on the BPF_FIB_LKUP_RET_NO_NEIGH path and can
bpf_redirect_neigh() on it. bpf_fib_set_fwd_params() is called only at
the set_fwd_params label, below the NO_NEIGH return (and below the IPv6
NO_SRC_ADDR return), so an assignment living in the helper never runs
on those paths and params->ifindex falls back to the input. That would
change the reported ifindex for plain bpf_fib_lookup() callers hitting
NO_NEIGH, not only the VLAN ones.

I can still get the caller down to your form by keeping the early write
and moving just the VLAN_FAILURE rewind into the helper, with one extra
parameter, the input ifindex saved before the egress write:

	err = bpf_fib_set_fwd_params(dev, params, flags, mtu, in_ifindex);
	if (!err && fwd_dev)
		*fwd_dev = dev;
	return err;

and the helper owning the rewind in the unreducible branch:

	} else {
		params->ifindex = in_ifindex;
		return BPF_FIB_LKUP_RET_VLAN_FAILURE;
	}

So the restore leaves the caller; the early egress write stays because
NO_NEIGH and NO_SRC_ADDR depend on it.

3/3 adds a NO_NEIGH arm that pins the egress ifindex (input != egress):
with the assignment moved into the helper, that case reports the input
ifindex instead, while the return code stays NO_NEIGH, only the ifindex
flips. It passes with the early write kept.

> If you move the ifdef into the if statement, the if statement can have
> an else-branch that assigns params->ifindex, so you don't need the
> restore dance (see below).

Same constraint: an else-branch inside bpf_fib_set_fwd_params() only
runs when the helper runs, which is never on the NO_NEIGH/NO_SRC_ADDR
returns, so it cannot be the sole writer of the egress ifindex.

Does the in_ifindex version look right to you? The alternative is to
route the error returns through the label so the assignment can live
fully in the helper; threading the return codes back through it works,
but it is its own kind of dance and reads worse to me.

Thanks,
Avinash
