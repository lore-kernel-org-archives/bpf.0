Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92F3D410D
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607938; cv=none; b=or71ilxtmOhLKYUa8NGAQ/Gb6LYUQpDsZLlgUDUYLvy9xNwNcl9RnYJpNj67Hk/XgNxglCXc6hSzmHJ/ubCYdLVPvb5IboikmqZrh7Ep+H+aAp0eTNBcg72bX0jsBGYQwUplYe+cOdR5mGqlN/ICyMikdiVgdzQ47mQUlebfdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607938; c=relaxed/simple;
	bh=j5Va7+gmykjYF242T1iZbiZTv44+SJJypaxifOh0AUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfFLTvaN0GYnNohR/5Rlv8C7hsi6doaFKTqjJIIABEHjVurBGelgQxSSqaqVTIZ7jlrXLXbrHDfndSEJRpd4M2TnneEVl4GtWeN7bzlPrN3YpP12mapwYFMi8jz/FhmIqbjUMKAcd8qDcYfxLjB0wVB7fCTJ2gUAdRulJoRd0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6Iwf48g; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6Iwf48g"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66049669d78so1286951d50.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780607936; x=1781212736; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m2J8USZDL7/DpTIcuYHRyNZJXHApGCptCywopvKKKw0=;
        b=f6Iwf48g0sV8eFbaZLcfnfr49MvzIaKGKwgcqlifmYPouS15GCriYWKZBmyjHTmuzE
         zjyEb/65tqbtpv+uvM1STrUQ4ohRKKbNqvAdYScq0AP58i8eViSLl7y9eXrhBJLMPk4b
         v4IPBECBBEtfa9hc5CXR83YHg4q7n6bGKdhQlu8qU9Ybwv20FlAFkAHQsTUAmixwupZP
         sNXGO8teGzeRUFpJQkqDlyjDgU35kk7BO0ILO3T3VWR1fpcBUuvz7Dff3TKaQJTtgPKt
         vhwY+cm8yBYVDli1ckPgytEZo6fMcITwrLoUhTXHvtvbutcw7lWkW1kyrbdvyHuNex5h
         Pbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780607936; x=1781212736;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2J8USZDL7/DpTIcuYHRyNZJXHApGCptCywopvKKKw0=;
        b=A89RWmtNJ3eDAnUpAIBSwu0qeZd06vOavwLt29OzR26ZD5p4DtjL24ERqG7RG2VKtB
         K8jrHh6ogZQ7dVSU4ihZqhQYSeaSOqRaqytYf2Hre1+PzjHTNURwMLWzcpBcjI5rEAZN
         tl3PXmhRxfgWUgpj3yopRtwKcaM2pMhWAO3XOwPVaixcrk6Q8oe5zO6m8wdE7dTb6oY5
         BAmMHT728VLSpNUu4HtX3ASDz3qUmkIcvIRN1LEEiry9gz3oJBYeiQ18Aov/55EjmJK6
         7gi65+dlZ+NAwX4Ay8J8iHB31YKYhe69mzXJGSzywAEGZtxEUIVZhwngpjRRTXhYS0uG
         qN0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/RSOHHckXn7RH1kI8uNFjPj6TKDgVNyJYQNcFZYfGj7ZjPZ/yOhY7cUG5/1d7g9NcvkIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuOPCdeSFl/v3MUCLGkgUO80is4bFu5Df/8+/SBnIYrvCttU7k
	+DSRjLpSTjkojh1OV6a9DDqn6GjaZJuwOw8SEKIqcOpIdUL794nCfX/f
X-Gm-Gg: Acq92OHwNPywixwYKuTKgBVAaYa5w9xDeSY0a/IiS4rWL+zByVq+tn/Q+B2yCyL65L5
	CQWvzvtLUw+9OSQz5fbF6k1uRSStjHvqFqCY2PZ2XuAYDkT//sVa5kpXWGZqZk3AC2ORBeaMMDv
	TiFQyllRO4PUZgxGtiUpxp//cy+08sQW/ySMF5GHzpxy1Q74GA9SvHIdbyEc3JHz0m5poIps1Nl
	afgfaMOyZdkqqHB48bWiCdxlhssfAqOntFNECMifiXkMCgOxXHO0J9nvgu5OLH9xTV3deeik2Ng
	sUmXp37+QjE0pzXQFaB7rguX9CiB8gKL0D6gBDPr8G8qjTdZ2RPOdybiyTrMMg9FC7FLjC+M6bl
	o1tXrTTyiQpbKEKJNw1uBmWzM7cb1+SHXSl7u6epLlWP8rB7HDy8jOLjKDP6FzCh/piWpMyTBFj
	6UtF6+zkZmNcoLft1CuFgiccuSEsTE6v9ADvgRcTn/MtEyM4+6B+37+U90o/2Xmw2IeyA=
X-Received: by 2002:a05:690e:4805:b0:660:8e61:1a49 with SMTP id 956f58d0204a3-66106e4abb7mr376567d50.18.1780607936124;
        Thu, 04 Jun 2026 14:18:56 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6d35:e45:54a5:6b0f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f883e2sm4500821d50.6.2026.06.04.14.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 14:18:55 -0700 (PDT)
Date: Thu, 4 Jun 2026 17:18:55 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	live-patching@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Joshua Peisach <jpeisach@ubuntu.com>, 
	Florian Weimer <fw@deneb.enyo.de>, Breno Leitao <leitao@debian.org>, 
	Anthony Iliopoulos <ailiop@suse.com>, Michal Hocko <mhocko@suse.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3] killswitch: add per-function short-circuit mitigation
 primitive
Message-ID: <aiHgdw_fBv8RTgC2@zenbox>
References: <20260508195749.1885522-1-sashal@kernel.org>
 <20260517134858.146569-1-sashal@kernel.org>
 <CAPhsuW4x8shWon8Moi5VgCq2n4E2EzaaauZ2HHpy42Rp1Y-J-g@mail.gmail.com>
 <agsVDqdALBoHEHlv@laps>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agsVDqdALBoHEHlv@laps>

On Mon, May 18, 2026 at 09:33:02AM -0400, Sasha Levin wrote:
> On Sun, May 17, 2026 at 11:37:36PM -0700, Song Liu wrote:
> > On Sun, May 17, 2026 at 6:49 AM Sasha Levin <sashal@kernel.org> wrote:
> > > * fail_function (CONFIG_FUNCTION_ERROR_INJECTION) is disabled in
> > >   most production kernels. Even where enabled, it only works on
> > >   functions pre-annotated with ALLOW_ERROR_INJECTION() in source -
> > >   no help for a freshly-disclosed CVE. The debugfs UI is blocked by
> > >   lockdown=integrity and the override is probabilistic.
> > > 
> > > * BPF override (bpf_override_return) honors the same
> > >   ALLOW_ERROR_INJECTION() whitelist, and BPF itself is off in many
> > >   production kernels. Even where on, the operator interface is
> > >   "load a verified BPF program," not a one-line write.
> > 
> > If it is OK for killswitch to attach to any kernel functions, do we still
> > need ALLOW_ERROR_INJECTION() for fail_function and BPF
> > override? Shall we instead also allow fail_function and BPF override
> > to attach to any kernel functions?
> 
> I don't think so. ALLOW_ERROR_INJECTION is not a security mechanism, it's an
> integrity/safety mechanism for both bpf and fault injection.
> 
> It protects against a "developer or CI script doing legitimate fault injection
> accidentally panics the box" scenario, not an "attacker gets in" one.
>
At that point why not just make this entire killswitch mechanism an expanded
version of the bpf_override_return helper that doesn't care about ALLOW_ERROR_INJECTION?

Then killswitch mitigations are just BPF programs.

This could be paired with a userspace tool for building and
loading the killswitch programs conveniently.

You can make the helper function only succeed if (CONFIG_KILLSWITCH=y
CONFIG_BPF_KPROBE_OVERRIDE=y etc.) and taint the kernel on the first call.

BPF has the crash_kexec kfunc already that can take down the kernel.
Thus it's not crazy in my opinion to add a helper with a similar intentional
intentional footgun in another kfunc/helper.

We can automatically benefit from BPF signing mechanisms to prevent
unauthorized loading of programs. If killswitch is enabled, users can
restrict unauthorized use of it by restricting the loading of all BPF
programs to those signed w/ the key.

Thanks,
Justin
> -- 
> Thanks,
> Sasha
