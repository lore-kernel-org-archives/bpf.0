Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587631;
	b=1bEnRb9LP2TQACg9oWzN4gbka2hOO3lK7ll4cV5kYE0xeAHrROAPi+6Lf/VzEEK+kOUQ
	 NPcb/5pE72k+AYho50oT0j0P/GjJITtpqFJzVxYczBovG9mjMLKcatsNFcuLSRbxHmeCJ
	 LnpE43jscDtih20q6O0wPChpQBh7f7p24Vo5aqwLzJnCzr8PC/2/GRM4WiwGmSdHfk2EV
	 VKszAB+sP1PSnQYLYgE5UIFUo4cWGqV5U5jNDQVVa2mCO0/4hYLMMXVPRllOHTaJlih7j
	 nzaBCznt2WVaW4vAUTM4cASpyFYRsHJYnBe1EPP5Xp/wezikFQ/CfS+4KZqe51O8XVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=MXX3akIJJnniaTKNyBd5BFOan5vtWMWqc3ToNszlBxw=;
	b=Sdo6+QD0V28fbHrfoI7dfd28F04ttqvJpbsN9KBrO21mRSHAZDwy142e/68tQdasSVjQ
	 l9PdCjPxEbrYoUcAq3aP5eTDvcoHZ1ndhD3uv348rQoDbJlAjeBF4eCN5wO6+0ABR7HCp
	 vMDaB+nwlEryR8ZlFi7ExiLYp80i4zIqACzp6K+It4Jpr2EOuGXj3h2H2X5ncjdxC0Yl/
	 MYtWFA7vncAOmbEp45pps3HiR7v1a910ZQGzKZ34Dp0i/OGSlrdq3+qYvuKHI6arX+LDS
	 i1n5fIqyF4CjEAIr2F+w1r3g4mGoDZwb8OwuM7Yw5E+0VekKEkuXSUR76UbZAOPHJDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yalAuqPc;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F0E606A32D
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 16:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F0E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yalAuqPc
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so467447a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 08:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587631; x=1795192431; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXX3akIJJnniaTKNyBd5BFOan5vtWMWqc3ToNszlBxw=;
        b=yalAuqPcOEWyZTcExezZehIbYLE/2/dgqSNKpActhbBVaBqSgaWvjIjmznMJeS6ep4
         7XzNftcbBJJK8emreUrXdWyhEmDtqbbKnpHJLbQc5gVBBPyma7UsC7jvzSzV8+moBVVL
         /bwjxjOj8jV4AWaTTTKh+QgwoXbIBb215sAvlyCxaXnYasfhb2PcDzOizfe6jGEtmHAM
         6hadodUN7VESv9g0PPuDxgd4fZhYzU9j0oHa9BIdSiKZVdqil2wauU2pSZB6c1Cl4fOx
         igj6HPsrqpdN1IrDf+D67gBboWuYyH0zv6K5wlmKa3KINbEsNptLpLXNtKBrwdnLUY1v
         /coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587631; x=1795192431;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXX3akIJJnniaTKNyBd5BFOan5vtWMWqc3ToNszlBxw=;
        b=rdCDkXV9Yrq/wnNgYQ1rPv/95jEuRMR5eEeHhy7o2egYeKxB9xuj8RF/azZzFMKfNC
         4kdhc9I4qba8eEIQMLvL0dGoLdj5pfLBW5ovuUUU8pe8hvWKac03R76v9Krjymg8oafe
         Ou4zl4MMCPD8HxdY01V35tJEcmIK0QH6C2IefI/LH0OUo1iH8/ax80NwaIS3C07QXIt4
         mLdd+wKTX/qlaCBdvGQyBYwwomqh+2MymG2i0xkcLkbxlndvRZickDNreUuOa4JskCGG
         3F80pZLAAGLQkxDI27gNieEZsJaID3NxvOxloE3nDPnD8LmGi2EheB1t8pHxfBIsjcmY
         fdUw==
X-Forwarded-Encrypted: i=1; AL+hErGd7a2ni9hgK+px5bHlKUfg1nc0jyElFXNOJjLvRsOAvto7Qs5HKO/Etdw6C4dRsNHEbak=@vger.kernel.org
X-Gm-Message-State: APuU4Z/R2ZszTNfxoBuUvKM0LhIbcwh00gQPWYaITwxRhIJpO97CYXfa
	SLuMqMtdaQbdWgCczVVN9TErE9Kd1tS3ZAx2LYKYaUSbkH4IJ57GcPQi
X-Gm-Gg: AYBFou0eU4jO9RMihM1HMEOsD1K24Pnra8EJlkyc2g5pe+GoWTPnQWpWDoGVWNsu6y6
	nPQvba0QgUtaQ3gFGaDOUr3Oahph0snt6dR+xR98OBCY5IeeKnR4HlXoJE1WXqy1dxFuh8ERqEh
	nYI6NWpgEKyhveE9Y3JqITOIa9jzcZpgw6LlcKDD7lAj2F4+CmWNklujkEjEUyRR0Qep5+QowKf
	J/+3cdtB0Fgtgh36wtArK+/gK0yIGOBvuAmrSm55QarTgYclHxy5TozXDqlMw5/ljyPe/SWyAgm
	4DbUSI2IH6jrWRTHxO/aiHvrn19xAsHgjWrguPzSuJ4K9c0aLUy+fnz51aLmT5D5NIN2VaUh1nQ
	uSeI7VPkyHLwQZ7J2wBzsu20mdlVFMfY73dMQhU3l2p6bPcjwqfMcCArnkHUYxtAmKgYfI6GZRV
	IRrfF7QUtch7egKbjP1NPq4/fKzdgGBtubeMGNSoZJwi7K1F9o8Bjxe/vQKo16uz17o7GvRhAnJ
	4VSV0OvRB7/WY/hbL+WBcQtlZxFAaV14QU6C2uQKhSz1wLew6/QYmTJYkR9MljHrsDF5pg2loXW
	ojGoryTC1A9F304J2lmphb/Zb6FxoKVuZ0sbotrKX4q66q3/xEslshTqnUDCURZm4s81Fsf0WfX
	1p3xMxlxwI3XssxtMygJa17Uf0mDHN6HWNQ==
X-Received: by 2002:a17:90b:3c4e:b0:3a7:b260:9ced with SMTP id 98e67ed59e1d1-3b1b0b87f83mr2684082a91.58.1794587630503;
        Fri, 13 Nov 2026 08:33:50 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b24938bdsm2417857a91.1.2026.11.13.08.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 08:33:49 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 16:33:49 +0000
Message-Id: <DMU87ZLFC00R.263G7S4GQS8HX@gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Treat the type of an untrusted
 pointer as a hint
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <a.s.protopopov@gmail.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
In-Reply-To: <cdadf16f205392dbca1eabedeb3123c4b4ff7512d74b4c7f52f4b6b8f671a48e@mail.kernel.org>
References: <20261113050901.1399091-13-alexei.starovoitov@gmail.com> <cdadf16f205392dbca1eabedeb3123c4b4ff7512d74b4c7f52f4b6b8f671a48e@mail.kernel.org>
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

On Thu, Nov 12, 2026 at 09:52 PM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> Both tests reach the kernel type through bpf_core_cast(), so they hold an
> untrusted pointer, and a failed walk now gives a scalar instead of an
> error.  The tests then only check that the walk does not crash, and no
> longer exercise the variable-offset logic in btf_struct_access() that the
> comments describe.

Right. flex_array_field() has the same pointer, so it cannot fail either.
arr_unaligned_step() still covers the stride check. Nothing covers the
'nelems == 0' check of the flexible tail now.

> Should these comments be updated to say what the tests check now?  Or could
> the two flexible-array cases use a trusted kernel pointer, so that the
> stride check and the flexible-tail check in btf_struct_access() stay
> covered?

Will fix in v3: the three tests will take unix_sk->addr in iter/unix.
It's a plain PTR_TO_BTF_ID, so the two tests stay __failure.
