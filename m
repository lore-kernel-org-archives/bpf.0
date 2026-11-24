Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549864;
	b=NNWEocTrAxDBxHqlc4y7UVEPPoCnfHSVvEqH480sGr/VONer4IYrzdwK/PPvSSpRXD6h
	 5HmXAXhpkxmZnLfYBnnKbbMPTx4dR27KDcUhipMinNMlVy0fD6F7Fj1I1Ah5Q5+IikYY9
	 OwF/kxhuZNOvz4Z/WtrQ6VVpnH/nzcjtt5ZUe2+UhAuGJa21FdHm4N5VZpHCkCvtLU2KH
	 LGjytE+4mX/IZ+/aMV6fipclybr/MZtdvWnei9fezjy86v5R0kBbXdoofhPI2nsIlUnYf
	 nqJ/EMDPmHY01y9UfYjO6IpWWsff/k/t071tFkNKHCGonFAUNKoAa/QOqCFyzS8/tdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=G1KHE+mQ+p2MNQj6Mr0phQ687D2wbQgFKTUxpR2BKG4=;
	b=zHMu8W2KWEj/xmzJ5hD37eeMoL6FBTkDNOhdqF6xQdDuuqefQ8YJbqHh7vgrmZRJh2c2
	 8dhSFnKE095dTWmIfzqD1SngVqaXIt0TLnbJzsz7mifjMgX2tn69swM/guiamLB/xou2J
	 uPwga0YsPc6k8IcAnQXuc+5tZ6VvZopQNWbENOLlLA4XHY8cVviiFRXhZQ5z8lHHh/xpo
	 txDmwyQNQ/8iwRjHUTFDaT3VIFTsmSDXLZGHUW/CNQASX3e+j5EBbY9lHhj2Dy1PEbYV8
	 AgS7MxfH3nPvy5wbMoU7Ise/nnfywp0j855KZmUHqM9JdL1WfG6d5eSjHbANlXrpQsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DmCsiT+a;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A4606A338
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A5A4606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DmCsiT+a
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso2371823a91.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 11:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795549864; x=1796154664; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G1KHE+mQ+p2MNQj6Mr0phQ687D2wbQgFKTUxpR2BKG4=;
        b=DmCsiT+adNdW/8HTobqZeDNbK/EnBYerEwwj5IwtwP9Ryae4B3bBEfAzbyVk94F1fi
         x8nyu9fbMlnTPiO4zOGhysFP1C4K+R+E5uLTp1jKFgwMpC20YX0j6Cf5Fti/To+zkqyL
         kE1i6DIGkdecq38XSSQP8ls1RqS5pe2ibnehwURshq/6HLsbNMNCYk/b67i09bmsdB6S
         MAczVchnZQqbKanF/B+smviFW5WnpIXwMGg6rnsaTCzgmiIH7jxy71WEZv2nQphgz67I
         fw0emMtugPqME5wDuh5Z2GKVoCqfgkYwrbQDQkDpcgTcojyydb+Y/YaIwGW30a3bxSQm
         1R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795549864; x=1796154664;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1KHE+mQ+p2MNQj6Mr0phQ687D2wbQgFKTUxpR2BKG4=;
        b=fqjU0xoyqLwuTQjBB3ZNsezs+Nr1X2eQQHeBUNIOcoQSSY2IyC19snvRwD+uQhdxtU
         gZ+0QeiRe6UJu3inWjm+nDyaEIoZpBWDjADP9tIc3bsRBR7aG1b7RrfEj+bUeINSQO8U
         VIdBgSf4OZaGQftcH9ZwF+jCYnMQ4Pp2Pw4sR1hKYzMvG2taSTyzup+JYVB2XrldDWW8
         sr2/j9ypWC23V4u3+rK+jVLRZTTWBZx28g27GKTQSMAeZYXPk7/3BEXNar6XC8awGpCr
         AUoBMOPuMzN8LzgFb0dfxILk7UNOkMtYu0SDrnM5EpS8nBrM5GhvuG1oWUeTTOmFIM0w
         YFsQ==
X-Forwarded-Encrypted: i=1; AL+hErE4R6pWyS256jQXyNsU+5Uep9nMZu0BuEzfOfdbS5WtTIYVJOp1gXwE8nrIFZno/8D3dkc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iIOwDPUeeZKkJmB8s2s1mFRN/HOjOhGOIiHIvNEIcunXF+//K
	dzpI8cD7f+aoeUP+/z6odSTI8rLUdJI4Ql2SQ2KrdUFbnCvWSZjpg6bM
X-Gm-Gg: AZFdTZd7MnWqVTAYXTcbICuhGEeYx6Y0skD5PXWifS6PKUl7sy0YakOBkRCGfOU5M4M
	9bzf/Wh6sp+b5NMF+/hLWNyJkbffaw4vxF9IpXHNZIQw6EsrYSkSjK0uj6rqJFfLZ1139J9jW51
	tCrhsPA1zDL3BzuxyIvyUYDrE0utTiFAee871j5bG1/kYq/GXj5SM30EcXc9nLdYUPwsN/0OFaI
	LpvHvnD7KKNc93PYVnGAN6fJB46QHGRUu4r77LsyfOzXAqjEwgrM2rq4svNbPJCmP15Yru7IAla
	x/gcJqsokRrpX67I4/tQsf4RcaES+rmpB5spJVpsZPi5dNmXyO/4sggch7nqgS/neE4WfwknRH7
	AcxBZQjHBIzb9sy0L4SwHPP98I9Gf5zfYSsIknGp4t+tZTL6lsofFls0j3tzSd7nEHBH5Ijq6sN
	Os2qjntSyLtL93HEWGu3clFgcwSBqymye9qSQV9Za7AbUJ6bgjds7bUl5oMxmj3hhei1WjGt6ob
	WrkG26xcFxydTKL5kOE/319azs+m0udK18CFHjNoq6upkqqkCbLH0HoifnwF0TRR7cWqf5N45aY
	LF+y77Tv1V5i/zU00fdwEJ/o3bEl4jYZPDqaeM8Yjy7Q37XHtXVMZwYg/3zNUGmMlvsxnlOTVty
	pej24tna6WATRjZ4KFC8RurDCPQD8myI4BA==
X-Received: by 2002:a17:90b:2803:b0:3ac:ad90:7090 with SMTP id 98e67ed59e1d1-3b41c9830c4mr14231099a91.67.1795549863413;
        Tue, 24 Nov 2026 11:51:03 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb2076sm24263312a91.2.2026.11.24.11.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:51:03 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 19:51:02 +0000
Message-Id: <DN3PAZH0AXZ2.74LR1B69MQE2@gmail.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpf: reduce kernel stack usage in
 bpf_guess_first_trips()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Arnd Bergmann" <arnd@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20261124140155.1555535-1-arnd@kernel.org>
References: <20261124140155.1555535-1-arnd@kernel.org>
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

On Tue, Nov 24, 2026 at 06:01 AM Arnd Bergmann <arnd@kernel.org> wrote:
> +	next = kzalloc_obj(*next);
> +	if (!next)
> +		return -ENOMEM;

Every allocation in the verifier uses BPF_VERIFIER_GFP.
I changed it to
	next = kzalloc_obj(*next, BPF_VERIFIER_GFP);
while applying.

Applied to bpf-next. Thanks for the fix!
