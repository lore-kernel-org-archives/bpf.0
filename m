Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984B11A01BE
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087071; cv=none; b=CDH8ygNt9g2XPNPHZv3rsSIKV07z2jni9Y+bpvGj7ijWZaSMEp/KQRUQftbGGBtpDLNJJtJ0N8eHSWEk7MynZt6kI8lgfRe2yCPAPKskKssyGUp0mFBG7nl9hrbuouHy68Q3/s/UjusGrcphuLVteYaQh1m2lmQ/pcNjgXuSi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087071; c=relaxed/simple;
	bh=aRtMEKCTfPkS8t+UDrw5mp6YZgq5wGRD7BN/DBb2Ghk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZISd+mRMTswvA5aOZQA93UNTOqVCO6P1M9gPgWS1j44p6LGzq1e4x6IStmwGIPgd1PVQb/oAC7LGhd3aUHLXH0sHyoHUJ/yVb3omT+PcwhET49pCODen2eK0fpIsFNVdIxOHXQ+i3uBg/2YMMGz3hGMmzVxhCHJmlo77DAICuto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJqTlMaQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJqTlMaQ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d7650202fso912007f8f.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087068; x=1776691868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+2lQLXDCJ4QwMRolgqc05f485esSt5RUtvgpjkR4TM=;
        b=aJqTlMaQ5FVmnnddAEihE0qCM57Edh8tLrXG2nWhshAg8fwvJPYZwqy4J9I6mJvC5D
         3Pqc/mwKPgCbKruXSzudilfVmMDOyQSJ7ZZ86TkgbbXgN4Vhj3PnPecaBdN+eFEcvyXF
         bRWaQ+BrdnL3tS0f+Bni9Lrr066xnWtm4twtnhcNBwB/Y+xCqTrIe6etTnhEwg1EFSpn
         7lyC7ccsgZYflij/DMjc3QMFppie65cO9+U/rA8aPNAi07/FTm/qmhzj5SwuJmqm5hxf
         xoi1jrxekLnEPVjt4QBUxSnuXKPchfiIlkGK4EHqIJIg6YFENIJkFNxxnPrSuVb6MOcq
         YBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087068; x=1776691868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+2lQLXDCJ4QwMRolgqc05f485esSt5RUtvgpjkR4TM=;
        b=bVDxMHpq66EjalnN6f/y5zR44RqJiGkU8I87ZLsyUFao4t5xCNfalbdb/L7wPmQ3fK
         7rufGzIq/ULnb0zj+bW+n3EGF9PaID1SH+d3aBO+5s4VUxaSPjhULk1YOwrfSyU9VcWo
         wn1elQL9LQpKS1+W6toIeoHdTcNhuvDh1DbTbqRNu5BcVYCxWhd7LJsYQqqhdOzROUmN
         Df0eBzKwCvHZ1hy6tlx2TfRKLQVAViODcQh2ecd7gwIDlhlEOyHgQyWqFVrgHyPyAnmJ
         GYNcP7T+oqfc+uVs6PBXHn5aFlG7DF9EmTdxR0f/L+FWMVQJn+L1ruBbszbIT07OMWM7
         IaGw==
X-Gm-Message-State: AOJu0YxjdL7rEpLboyXwa9B6Djudy657UA/PN3X18yLB39ik2zdv8Sij
	R+PQAt2stdeSEVZ+AObfQ4ZAF7vl/iWjWWL2iH32gBexdx2ao8SX0ZPV
X-Gm-Gg: AeBDiestqRqq44TldcwT1+FR61V+y9SWqvdwwDD/Owq3UYQ97gYr5iUTf4h+wZplcmC
	jlGtCTgZrWtzzjfu6ceUu+xX6nSglvjZ0C+iG0KODaz3BeI8SG+e3R63BqZhh2LBpCnvL/B4aH0
	awbw2h4ACReT7glfvY4w7aZn72yDL6mUDgY6xT6MJEqbqko2/5nld4Y6Kx8ZWAi4LU8S6NeXRKZ
	RKwT+hkB8573uZwkJ7+b7xLLB1tgf0FQDEmIaL5j1nPVMm6g90JdzgUQLVnF7g/GzZ6kvzuEgFW
	TKGmWOuidl1qWX5ZiM7GYRO0iEzamld2SHos5fJ/LimNq5wgFwijPWhzVkn9DC4sMFkIFAOdxx/
	C3YY6bTjU8hVVstn8PXHOaGw0yweFKfFd/pRHWQzc6ivjZKFyEAEcKkNysIAEDtQbGlzpSeHKE8
	AFY/RBt3LrmVDbGfQZoj3yBx0moRvkGFmvP9iI11FFHGiDGHi99pq9eogmMB75GEhkosFlpCWAy
	j1mpazgE1HIloE+iS4KsujNsOiHYOPR6pPEUAwo78XHhJhWwquFWCLWcQboumvWZWmcWyGj00Wv
	Juu7LywAHl+f5MQpGUgekdiDO1BSkg==
X-Received: by 2002:a05:6000:25c2:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-43d642dd457mr20229398f8f.43.1776087067618;
        Mon, 13 Apr 2026 06:31:07 -0700 (PDT)
Received: from Tunnel (2a01cb0889497e0026a90df73e9caffa.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:26a9:df7:3e9c:affa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50015sm34924379f8f.27.2026.04.13.06.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:31:06 -0700 (PDT)
Date: Mon, 13 Apr 2026 15:31:04 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v4 09/14] bpf: simplify liveness to use
 (callsite, depth) keyed func_instances
Message-ID: <adzwGJXuXcVbF5H1@Tunnel>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
 <20260410-patch-set-v4-9-5d4eecb343db@gmail.com>
 <adlt_kFLi-rA_zTR@Tunnel>
 <fb4290b261d2265e9cf64cd6f67df9d0e1a1ac74.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb4290b261d2265e9cf64cd6f67df9d0e1a1ac74.camel@gmail.com>

On Fri, Apr 10, 2026 at 02:42:53PM -0700, Eduard Zingerman wrote:
> On Fri, 2026-04-10 at 23:39 +0200, Paul Chaignon wrote:
> 
> [...]
> 
> > I tested this series with Cilium's complexity test suite [1]. We have a
> > lot of different configuration and some producing larger programs than
> > covered in the cover letter.
> > 
> > Overall, the impact is quite good. It reduces the number of processed
> > instructions by more than 60k instructions for some of our largest
> > programs. It also increases the number of processed instructions by up
> > to 20k in fewer other cases, but I think it's manageable because they
> > are not the largest programs so we have some room. The mean diff over
> > all programs is a reduction of a few thousands processed instructions.
> 
> Hi Paul,
> 
> Thank you for testing this series!
> Are the regressing program open-source?
> If so, could you please point to a few?

Hi Eduard,

Yes, all programs tested are from Cilium OSS. [1] shows the overall
results grouped by program (each line covers multiple configurations).

I've uploaded details for programs (a) tail_nodeport_nat_ingress_ipv4
and (b) tail_handle_ipv4_cont with configurations for which your
patchset causes an increase in complexity. The object file at [2]
contains program (a) compiled with the Cilium configuration from [3].
The impact of your patchset on that program is at [4]. For program (b),
see [5, 6, 7].

These programs are quite large so not the easiest to dig into.
Unfortunately, I'm not seeing anything obvious that differentiate the
programs with a positive impact from those with a negative impact.

Don't hesitate if I can do anything to help! I can also share the
verifier logs if that helps.

1: https://pchaigno.github.io/assets/static-liveness-complexity/complexity-results.png
2: https://pchaigno.github.io/assets/static-liveness-complexity/bpf_host-3.o
3: https://github.com/cilium/cilium/blob/12955851fc2f0c25f01d0df27a66c0ed6c275f59/bpf/complexity-tests/netnext/bpf_host/3.txt
4: https://pchaigno.github.io/assets/static-liveness-complexity/bpf_host-build3.png
5: https://pchaigno.github.io/assets/static-liveness-complexity/bpf_lxc-7.o
6: https://github.com/cilium/cilium/blob/12955851fc2f0c25f01d0df27a66c0ed6c275f59/bpf/complexity-tests/netnext/bpf_lxc/7.txt
7: https://pchaigno.github.io/assets/static-liveness-complexity/bpf_lxc-build7.png

> 
> [...]
