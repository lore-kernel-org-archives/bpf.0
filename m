Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CAE1C84C0
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771470457; cv=none; b=qc3t/FF45SNOOpkm2BGcXwBeelbOGvjQefC/r58CPILR0o9s9CCUncZTuvev2xYjoFVTEvwinJiqZqSLLS9k7PPg1hu4y3kOWVdd1/GEvrtRdDx/ed7FcLcendshpN3KbNKekVdGSK7zR2qbmakP6uE815C9749nrWFZuUXy8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771470457; c=relaxed/simple;
	bh=CtHkwMSsX/PQHM+rCwTONcEP7ipj9S9lwPqDm1G2TU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDTb/xkfBVi7kIR8Mm4j5muuuDTNx/RyZtJdi37g9uR2n27icn51Lz5Q08UquHIUxWQWjDCUFg1VH50zkAAWYVD5VItggHbKJbfOyt9WyfpwcOBErkMkjum5oyrOrr9Fi3HIMe7Or43IjA2pBriQyj8qSD65aqbvf6YSkmVx8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gUZvwfqd; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gUZvwfqd"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-45f053b7b90so329483b6e.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 19:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771470454; x=1772075254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxLPkM8L6GLDJDpp1vYLlNTIitTDnz/kCc/Md0UNwPw=;
        b=gUZvwfqdfNgCd2BNpxnJiT2PpMgsG3wgKKvcI3V7xiZGmzvukWE6+WmCorebLaWdSU
         caSlxNEmkKZhXBjXtqMKv8pB+4r16l5kuxye+SSwEklIgHXAwOP6cxhjV5cAWmE1Gcoz
         1Q6Pu1qO8UUQqmX0uuGmAZOIBrNQOtM20FcOAgTrtlpmf796sLyID8MIZe/ZMxUWS5ZE
         oyrfrOzbamsmy3ttAdDm6ND7JNrCCMk2I9d3q05jP73r1f6sbt5oPdHf7MqW/5dJSXpi
         wwrcfpHyKBkuCsCp+00Jkv1rRCa2nry3OP93fY1NMxM9Rv2sMdozCx03GsEkU88pQuUi
         W1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771470454; x=1772075254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxLPkM8L6GLDJDpp1vYLlNTIitTDnz/kCc/Md0UNwPw=;
        b=QQyUMvPHSpKpvHCN7afm/EHUBFBWwLdH4SwmmO9ZHHvw1DvNe5fYmqE0E89GiB1jpO
         Q45Q9ILJdzy1EWjG5idG+yHa2vB74snYoyYGG0ZyFCPdaHaD/v9qcQp1pY6w90SnRLDK
         F+8PMwULAlnxnwDMJyALXTlyuNjqvRhFmMiVOZWQm7nvRirBh/ryTKkFEWrUhzjSqNSD
         XY+TSLDQt00JA4jpUQ8n/9TKs5zEh7b2i3S/y1YCncFQnNykh7kaJf5ji7NhhSQ4sZyG
         2e5tNLMt7CW6+ccfgWXQ8R673EQqcVWxeJXa01mhkEGzJdSZV0DXuElU5nG4SR0mLZdk
         iI0A==
X-Forwarded-Encrypted: i=1; AJvYcCXi2Mm+5NrCwQycV+lc2Q179dTLod8uFtfphl5votzrS2QzZMdbufJmcyctoQXwuKlR1XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyElAYNVB062aHjAVxKO2YkxWZuTthMzBF1zVGjUMEY7zAWEQTT
	2oX5Sk/eeTPqYdUJG3E0ZWCungeX99ei/Lp654jioGntBSH36LMPxE4WuqkoLCyjaGM=
X-Gm-Gg: AZuq6aJOvLjfMRbJ2rSrpWmpAFeyR6eOqo7tuDsi94c/pG6NkNU8aCnYyHtwEEqRozP
	anrOC9cZscbUiNQXQllU/MfN2gS4qULcNMcAEH//5E93jE+Voejm5PmANQoWoLS43ZiTjziMYm1
	zWkIKPvjFV8m3G8IlCYBXUoas0Ylr4wOmHEwl4baQazCV8UKE9xWe3nv8dTHG7X5WjZDXt93J54
	MA+5nUYsOypmI4Ih/1RAkyLc2DyhHDxFjXk0UHltf/pVQpc85cVDQAPK3mzzmMVQQ7t925daDBX
	iWD183m1DZ9QC/DsaE+B3Ny+VlWL/lV5OVkOEyyfZ7GLFiJ+sQToCUPUBMSWP/hnaDrOoBPqwvP
	zbJFs/GIOhat3tGAEeqapHIIJFOUOqsvvhnZ7LyUavX/MplSL31lfMIujZ4UHjO85IfgikGgK2n
	W5hTdzBg==
X-Received: by 2002:a05:6808:16a9:b0:459:9630:3739 with SMTP id 5614622812f47-46410bcbd39mr2220772b6e.18.1771470454220;
        Wed, 18 Feb 2026 19:07:34 -0800 (PST)
Received: from 20HS2G4 ([2a09:bac1:76c0:540::281:62])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40ee62b6f61sm19367758fac.10.2026.02.18.19.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 19:07:33 -0800 (PST)
Date: Wed, 18 Feb 2026 21:07:31 -0600
From: Chris Arges <carges@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	jbrandeburg@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/2] bnxt_en: Add XDP RSS hash metadata
Message-ID: <aZZ-c1zHJxyldRGm@20HS2G4>
References: <20260213192449.1294830-1-carges@cloudflare.com>
 <aY99llj2HmFNrR_5@20HS2G4>
 <20260213120915.6af2bc65@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213120915.6af2bc65@kernel.org>

On 2026-02-13 12:09:15, Jakub Kicinski wrote:
> On Fri, 13 Feb 2026 13:37:58 -0600 Chris Arges wrote:
> > On 2026-02-13 13:24:26, Chris J Arges wrote:
> > > This patchset adds the ability to use an XDP program to extract the RSS
> > > hash of a given an xdp_md context.
> > 
> > I see net-next is closed: https://netdev.bots.linux.dev/net-next.html
> > I'll re-send with proper target after Feb 23rd.
> 
> Would you be willing to add a test as well?
> 
> https://github.com/linux-netdev/nipa/wiki/Running-driver-tests
> existing tests in tools/testing/selftests/drivers/net/

Sure, I'll add this and kbot test fixes when I re-submit the patches.
Thanks,
--chris
