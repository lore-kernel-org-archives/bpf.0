Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B33431E841
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785739827; cv=none; b=iKPPwarl14HOoB9DEE3ZSTkTEEGS7sX0JnMfrMGMDLUr/dg3YIeP/e6unY2yusQ/9ZQ+bCDxmZIfwy4f9Cpuy9uk7QdTk42CGSnPZe7bQ5K3Hgb5QpdS4kJdzWfTgV7jRgSqJLft3xKz2xB9TxgTNkCWm0jvjhnli+jNEJzhXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785739827; c=relaxed/simple;
	bh=JK7o1vQC5pAznNWxvAZL8s/hFEIa8A/EatmNVhMcPLw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pH3X6zP+9D6DBdtHLAK5vuJNa/cms8gFNDwHR9trgRIrsp+vkzwCPoCGlluxSphZa5zEghvsqo9houUOYXq+pT3X/goYcaKK0TtQPXEjBFWQyjjvGXaP/KRtKKBtpw5n/RrHurQ13qw35MnCkv5TpyC0pZvv8E3THPffigoG4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r33AwgU2; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r33AwgU2"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473b8c0fd5aso611514f8f.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785739825; x=1786344625; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JK7o1vQC5pAznNWxvAZL8s/hFEIa8A/EatmNVhMcPLw=;
        b=r33AwgU2YFEJSZkqqluG9FibLSxywDRqlWafcs/PSd1PzLYxG+NubKzKZEUiRaSKO+
         rb9hG08gzA1xDV4l7K5RcZffIpnYI3ls0LgDNgWS27b/pxPuThfmgE/OodUHxX9M3/wP
         m/Fd1uh8e1Vy5uaxf8OiaAGChtLjVGIvlmIQRH0GM3lbRLMgcnuTxcPz9dh3YISbXB42
         r3/fQOg1AUoxEIEktLYydw1lyL8VK3ySUJpYF42MDim4oUS8AQ0SoENYDquNaxBTZEca
         sM5L6UZJ2tCjTJwQYX/ntWmASCa1QmyNQMr/U4L3bleoP476ryqBQ+hvcbxk+QtrRRI6
         FaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785739825; x=1786344625;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JK7o1vQC5pAznNWxvAZL8s/hFEIa8A/EatmNVhMcPLw=;
        b=hRC01qU4BdGlA7agFssf0XZKjtpCILjqqqavI3exxJ8sX81rgdwfc9FJjztA3BCk2i
         SDcBPF5iRglcIyGmWcXc8kFQ6fHgV+XyKTZSKGqs3+z1091H3u16mEgwNpuQThEzlSi1
         v/aDHaK/JBr/VDaxk5zZNNRFr5rE9gaYjr81K3y5gxnfVP34SW3fTCvcZTNHH2eZ91vq
         RDxFeAZWSKy6vBvaPLAT2yvwZonFj3y/aiso47NIJCE5e2beDlj3zxePXgTZn0xGcFKn
         UwMoU3/1xbQrJBu7MilQcf5OBp2WvK13LdtXGUdnXzMUhF0m8X6Jb6z6odmsa35eLzdo
         7ngA==
X-Gm-Message-State: AOJu0Ywp4rgCrrwTvDyoRdRBVR8fQ9GmH5VqTCnpFiNS+f2JsD/k17Mm
	7Hi6iJ+L7yBIbn30Mf04hCYUVbbsahJPYjmn8gOIGhNQgQ4IvFq8JAZL
X-Gm-Gg: AR+sD10Rai/DgJzCmJ5ySA1yaEWqm1xJyjg4ByG+WqQU7didHz9fUdT7+i9OHumGQ38
	N2ZeGSEL5Y9YoAFH/ymyDx1oopNPI5hBHOQrISEwzAO306uimewTVdOLIqcvonipo3eoeaEiQoi
	HzGba/k3lMLyIcRBickj5AhvDTV+OJ/gj4WTvCWPGjNM/8LME3sMI6KVV+PZBwZcwlUR6D3TUxy
	RvNZ4u+2JvNJF96agEmRvh3hfidSA1fCnqKOiGUw/2xhc69k6DDwNMtOeyPhwngX9qzqz3+AHxd
	J1pF5YzymxOcjCglC3U5fr2mUGn+EUIbHInDZxVkgsQPeBDdnqOWBTxm2wDEszkQz6sf2Dfe9eV
	Mtf1hZyYSIfuiFGY02Zv76KHw/juMvLmjw3czHqRvuTG7vnbl4XbedbQnnaP6IscGtju3IqzVYu
	e1DTl14xLynm9Bd6HnEMVNGrlLL4pdJvknqbLVZDxTJbfUr1KnWictypwEToQWEcy/tuS5tetPf
	c4zD6JknKZWa+6R9Wg5Bb2DQa+uYcZEC0eu/xYaSAoakp98A6XL5s0QFTYThAIG5xgrcirjIY5I
	LmGGnemn8B+C4XHFTB/qsHoSkF3f0VyEBUCkhA==
X-Received: by 2002:a05:6000:619:b0:47f:9760:4d25 with SMTP id ffacd0b85a97d-47fd72c6da2mr15567650f8f.14.1785739824444;
        Sun, 02 Aug 2026 23:50:24 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41cfdc6sm29396424f8f.8.2026.08.02.23.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 08:50:23 +0200
Message-Id: <DKF3XPW4HDQK.FDJMYDLGXZ60@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <martin.lau@linux.dev>,
 <davem@davemloft.net>, <greg@kroah.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in
 refcount_acquire
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-3-dingning04@gmail.com>
 <DKEUKIOKSY28.2XVQVGCKLI40C@gmail.com>
 <CAJP4iuuYfqFChH1P2=3Q6WxHbMTNnAkCagR2k+Lr4W155gCj3A@mail.gmail.com>
 <DKF31NEIMOOB.2CPM6KGVXD73K@gmail.com>
 <CAJP4iuuz0T694PnyZmcq9f9PaQLX2kV+Sd+veQN+uydsvZ=BFA@mail.gmail.com>
In-Reply-To: <CAJP4iuuz0T694PnyZmcq9f9PaQLX2kV+Sd+veQN+uydsvZ=BFA@mail.gmail.com>

On Mon Aug 3, 2026 at 8:48 AM CEST, Ning Ding wrote:
>> I would just disallow it. I don't even know how things would be correct =
if a
>> untrusted owning or non-owning ref is passed around. I think the case in=
 patch 2
>> is demonstrating that it's a bogus type state for being passed around in=
to the
>> kernel.
>>
>> The only meaningful correct use seems to be reading from such a pointer,=
 for
>> which PTR_UNTRUSTED downgrade instead of invalidating it completely shou=
ld be
>> good enough.
>
> Just to confirm, semantically should this case be rejected by the verifie=
r?
>
> bpf_rcu_read_lock();
> res =3D mapval->node;
> bpf_rcu_read_unlock();
> return res->key;
>
> At the final read, res is MEM_ALLOC | NON_OWN_REF | PTR_UNTRUSTED.
> Should this be accepted for scalar reads, or should this pointer state
> be rejected since it could possibly cause read-after-free.

It will work, you can test it yourself. Reads on PTR_UNTRUSTED is fine, it =
gets
handled by the BPF_PROBE_MEM loads, which handle use-after-free safely.
