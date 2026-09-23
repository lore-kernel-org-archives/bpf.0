Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5719005E
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139252; cv=none; b=fC95g8sItqVt2zSY9b/Bbfolc2ClXrzMKbLApFNoIwPVX0znuI/QNzjnhgAATNFk2plV+Ftr5PeAlothuN+y35KwdKWF5K04+v4rNQaOmoPsfnMCMMOBk7Wa4AecvIPEQX3PLrV0HJh02rcmsY62LlSq0iG+MfnKVJAYQSL3SqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139252; c=relaxed/simple;
	bh=xX6oGqFvEh6pOEGnO4RscuKne8zvQ+zJjRdTJfWdqKY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Xrr0qvr2gmCm7dE/tvs/oG/r5hIghN4ODy+Nv0rDujGDV3Se10g/aC5ViF53tm00kibdK3if5xE180qs3rekrIVetnBfcM0eo3sn7mYgRmTOQIOlFSFfW+tdil4+BjO8D4uCCbGbYfTlgHQrV5xFHeuA+53v3DsdtC/WWgC+tlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikSs3CgG; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikSs3CgG"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4aa0f1a94so275690a12.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 21:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790139250; x=1790744050; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xX6oGqFvEh6pOEGnO4RscuKne8zvQ+zJjRdTJfWdqKY=;
        b=ikSs3CgGdmudKEO9+Nf7fD66rJ+DTSLpXpyWhbcs1h5ilMWfygCqsGjBIms6GD1UY5
         uItKkcA/2pcVn0dV6jSHPSIDKFKVjFfH48S5OzRLgu9b3Ck18J1c5jD7W19EOPUaA/xa
         dyzd6i5bKN97tjRylOdX5LmxXLmFOKPYr/cWSXWE/gb2+C0e4Q0oQBiQfElNxpUXmhck
         3BK5t+ZHznKYvRsBuigFE1FpvFo/Om60XkqvqiYXqkvvQ87kn2iicakTPMLKtBrLx1+X
         ltdQA8FeXyM/47JMBbrK1459IRrrFLOWINIJGwHixhnTnllx0NE6NBAzWxIOCvEhs4rk
         oUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790139250; x=1790744050;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xX6oGqFvEh6pOEGnO4RscuKne8zvQ+zJjRdTJfWdqKY=;
        b=f6ftBhVGBBAEY9isjipiagxMAdKbMx5lb87LaNMcZIQh3GSg4CTl6qWvLzNqljZa7I
         8ZCnlmcHVNaLuSM5pL4d0W7oaR49cR6BT/q4A4wEoOK08Yo45BybeNyxGcLWtGucXLKl
         lHdze61+P9nGQiBW271YxOqFGifPAiGplzBAKV2Mgk20aOo8Hi+SsUAV+rleRQ3MltPg
         5MMxESwuOFFcATU7t4/80XSqXyao8Rsu41JL0uV1O0KRcYRSala+1uF1IRv9nSgnROaE
         dEp6AGjxNHTorUs7mwBLS3YFAdtbPGOKmcN8ScBKuv8LsVPNifNPbmWN5UZ0fOteL4VQ
         G1BA==
X-Forwarded-Encrypted: i=1; AKwUvByfEd+9gXJd3dzVnTtVyZ8fXAZXigASYXo/uvc5g5MFO82+2QQaISvrjrO1MJKCvx4YbUU=@vger.kernel.org
X-Gm-Message-State: AFuF++nf0oovof887b2QPbUbnEj2+r18awl0w9khF3v1zvQjb47Fw9u9
	vJYDtvN9golIoMJ+zZ+rA43RjAeNYFA0PCYT623MovpfYDOtLtuy24GD
X-Gm-Gg: AYBFou0E1hK9k4zFyYZLcN5ZgCNDaJ1PDSi5PHqCcVwn65oqgDyVvEXG6cr9q7g2O8f
	aQ6hUQoDW+hSmF8n2Vt+VPs9EDFT/lgbxo9YxITX8cUhP9Jk3KvyKqpqaM6NE2my6ZEKB5cE819
	AGtDtB8GbE5QKXyw2OpaWJ4X4odlhHiDKFreHPPMa9w+Np66Ar4VIE+MPtek4p66dqWuXS2s0tu
	8ghhApPpROykn2HM/LFpud/6vW3JGRex0aOBQAoKuRf7muec6mIbXtBMF5DGYWYvfFE1OH/j3WK
	gkJhy0pSkFS2okK/GGvHGcaAj3Ih/2bxIZdCFdwToZsQcXUnUGdFGhDUVcZ5rToS/KU+1A/c7Kr
	yy9ilpqEQ0ipa3g0ggNU3vCHE1tyfjpDBJbxDEFh17Qf8/SmNoEOAG+Bprgb9rHZJe6YwyIP/rf
	uYXuTAQZzSpFHXNQw+sg+t52D//eyHzp2M2bJNU7HHFZrDTBM6oHiXfimjHCvtGV9drcmouKZig
	hSRpaukO3c00a9aBUTkIhAp7HpHeQyPWk5nyp/e0zVZe1gee5YKBLbq9BocWX4vWiIWW8IsLxiL
	+Qk=
X-Received: by 2002:a17:90a:d408:b0:39e:6c69:34cc with SMTP id 98e67ed59e1d1-3a07e7558d7mr1403150a91.48.1790139250303;
        Tue, 22 Sep 2026 21:54:10 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a085b5694dsm1004556a91.6.2026.09.22.21.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 21:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 04:54:09 +0000
Message-Id: <DLMFEI43TYVI.1KNMAQLNWT2JC@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Eduard Zingerman" <eddyz87@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, <bpf@vger.kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
 <DLLHQDZBGDUO.2TT8UBHIMZEFK@gmail.com>
 <DLM696EA5JAQ.3DBNX7Z6DB7N3@gmail.com>
 <CAP01T76JZUzzyr50dk0NzGv73p12v8E17Lbgy1_yZVqg3Qju0g@mail.gmail.com>
In-Reply-To: <CAP01T76JZUzzyr50dk0NzGv73p12v8E17Lbgy1_yZVqg3Qju0g@mail.gmail.com>

On Wed Sep 23, 2026 at 4:36 AM UTC, Kumar Kartikeya Dwivedi wrote:
>
> You can obviously insert aborts at any point in the program, provided
> such a primitive works, even when the compiler doesn't see it. It is
> just a way to halt program execution along a given path, and has
> plenty of precedents (assert(false), std::terminate(), panic!() =3D
> abort). That property can be used for several purposes, including
> proving a condition true on the other path that does not abort, and
> retaining that path condition throughout the rest of the program. That
> is basically the gist of Eduard's suggestion.

That's only true for user space.
For bpf progs there is no such primitive. bpf_throw() is not it.
We cannot make it work from arbitrary places without introducing
massive verifier debt for automatic creation of exception tables
or via equally massive runtime penalty to remember all things to cleanup.
We're not going to support rust panic=3Dabort for the same reasons.
If rust-bpf prog is compiled like that it will likely be rejected by the ve=
rifier.
Accept-all-rust doesn't mean accept rust that can leak resources.

