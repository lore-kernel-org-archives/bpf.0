Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9984336888
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715031; cv=none; b=b3HBiI9CTxq/WuZ6TZ3ehToLyU+R2k5HXwtpo5oaxd4SZO1IQiSLECFnVhzMXIHLPwuwAoJ2qMSxo6N5HKzADwgXX6yjm7bJWObtP96Lo4pwZKp5gK2h1CfM7VcMZAX7FVMrWxbrbf2SWZBIgGxhNExfv3QiScsNssz9GHy8zyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715031; c=relaxed/simple;
	bh=WaA2f9pnNzYRXTg0Jfl76OQoMEU7yv9J5GICaafBhEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSpvG5I2+GBxGjW7YD/RNo2RtZgvzS14YY/dcpfZV7Nd1CHvjBvQVAiPC6yTgptuzaP7VclI4i2wHR6TfQxjst4MHHfixPNv7JFgoJ7ivxbMe2KHoynsPkUtoohcGgQhpehHBKBAb2qHQlnPQcsKJ7nB4ctDOIUOT9Tel2UlGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILwkFO0m; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILwkFO0m"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so2807310f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 04:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772715028; x=1773319828; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7D9iLbKGlr5RHAZLbD4GeASM/k9jM5TI1+lPi6p8SL4=;
        b=ILwkFO0mILG8YrCJPPRa51A6rHm36TWAN/ugM65zjT9DqdLGjstdNIGS8UOcoWZLp8
         Mlk3O2yJeBZNtML0hObdBTvjojqlo8Y/RbsYzKuGln094N9FvMVqd3u7gckjsyDhg6G/
         OAlfPHXpEIeL8Umw2qvGdKr/RUrPliKVN9vdFgjnId+S2zL6JiL36w5jjkfAUu+stmv6
         JG8rhGjzmBiYjzx8U9LjCL8FyVf8EveS6PxyPcj2mUjF5Gsz+hiVBU55Pe4hHbrImSOa
         s8eemZxEPvv1GAnWnWNtfwIFersAkfcoNU8NvUudPFChs11uQvoQcndv0kentQl39lcC
         ByaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715028; x=1773319828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7D9iLbKGlr5RHAZLbD4GeASM/k9jM5TI1+lPi6p8SL4=;
        b=RGaM3A0BpRSqMpQsoFfyQ4zn3NQk6nbTTzaEqtCoXVjDsDF9DqmKp7w/vgxYpVFVOZ
         7EzI7FISTZOgcOOgyuGnRZwN3Sv+c+wmp42mU4hkIYbqLGEgaXiJNRPFz1mY9Lho6IWQ
         GGPOuScCwd8wpKB/jzH2PxHM8Mutdg1gWzfr7AoAXrvRG88ipMMX2fj3TyTAp0TG889g
         kdGH7YJwOTQ7tV8nhg109o2/KN0NTXFfzgO3tDZGW9jxUeWdnCT26LWZaWt+8I+zTWvH
         HML5Tvm8oWMXyF8LIHkQPunaGQjK1+05fmadOZ1e+MEvRxHsa6ilZmMxZzQirDfMZxAi
         yK8Q==
X-Gm-Message-State: AOJu0YxGBs6EA0EQt8qXOkEfStItZJVyNGKr76fqR7W5teekCb4dwZJb
	BNkOieA/Ktk+/c0Tq6WQ8C7fWLlz/VBB0XKF23QdboFgvS+63SwC4qFd
X-Gm-Gg: ATEYQzzs1Kg8kKqxoPRGpgcCWxDkLcUTlDISCQ4KDJfqxV2TPlUd+jwD1ZHcAXdHjhs
	8R0ff5OLiBTQpOcLBpiNop1njTArJZIu1I9x3DWNgbcUiKKdgzCSrRibd3GIe05VDqus0s8XLFg
	A1sr3q+gLPJNnqFCNyTl0k45w53S6OmywpU7fTRqnOCeiDf6mU3iXHE3DNpRRgwr5KL0lxnDHLX
	KTwHVzWk9wdNE/pcZmYn979XIiw/xj6UGO8+VmaqOl1jUGou+U8EhfDG707Xpb7P12fsAy4ULza
	LlpLK0Oi+VZ1Fmar+3z9ts8mX7Lm7aLRcm7d5xNCqKjAUIV3wS4hGR7nlOE8G3pgZQtomiRxR6/
	ceF8km7tzWx7JoO1/Qvbe8QgfDas/BeBiiQOHlzJCsxVF5mhu2RXn6ZoK+CFD5EEoGuHgA/bbf3
	N4uWkOz5Cl55KynE+TNp9KPI5/GYONR3M7FfdKAgXjPjMajcdTPdWNLebSbrJeUxiZhfDBD5ysy
	NamsRkr5sciTQSgCtGoOR71X1U7Ec6c9C0p/LUwgDZHrWFzuxDzMI7r0CCkVAEHOdC2b5D75t54
	61QLWAHOaw==
X-Received: by 2002:a05:600c:620a:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4851ee7b0cdmr34114095e9.3.1772715028043;
        Thu, 05 Mar 2026 04:50:28 -0800 (PST)
Received: from Tunnel (2a01cb09b0519f200bb44bd7cf65ea8d.ipv6.abo.wanadoo.fr. [2a01:cb09:b051:9f20:bb4:4bd7:cf65:ea8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fad2812sm62638475e9.1.2026.03.05.04.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:50:27 -0800 (PST)
Date: Thu, 5 Mar 2026 13:50:24 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Avoid one round of bounds deduction
Message-ID: <aal8EEOvx8dbsqlM@Tunnel>
References: <aac2GMpnpoAKD4jX@mail.gmail.com>
 <d9c98aac-6c4c-483e-9e9a-0659dc03f9e7@linux.dev>
 <umlxk5jo72ii4efzcethwcwtr7e4scq5iicb57huuhb3qtvcuc@xhl3c6acyzga>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <umlxk5jo72ii4efzcethwcwtr7e4scq5iicb57huuhb3qtvcuc@xhl3c6acyzga>

On Thu, Mar 05, 2026 at 02:54:07PM +0800, Shung-Hsi Yu wrote:
> On Wed, Mar 04, 2026 at 04:48:43PM -0800, Ihor Solodrai wrote:
> > On 3/3/26 11:27 AM, Paul Chaignon wrote:
> > > In commit 5dbb19b16ac49 ("bpf: Add third round of bounds deduction"), I
> > > added a new round of bounds deduction because two rounds were not enough
> > > to converge to a fixed point. This commit slightly refactor the bounds
> > > deduction logic such that two rounds are enough.
> > > 
> > > In [1], Eduard noticed that after we improved the refinement logic, a
> > > third call to the bounds deduction (__reg_deduce_bounds) was needed to
> > > converge to a fixed point. More specifically, we needed this third call
> > > to improve the s64 range using the s32 range. We added the third call
> > > and postponed a more detailed analysis of the refinement logic.
> > > 
> > > I've been looking into this more recently. To help, I wrote a high level
> > > sequence of all the refinements carried out in reg_bounds_sync. u64 ->
> > > s32 means we used the u64 ranges to improve the s32 ranges.
> > > 
> > >     /* __update_reg_bounds: */
> > >     tnum -> {s32, u32, s64, u64}
> > >     /* __reg_deduce_bounds: */
> > >     for (3 times) {
> > >         /* __reg32_deduce_bounds: */
> > >         u64 -> {u32, s32}
> > >         s64 -> {u32, s32}
> > >         u64 -> s32
> > >         s64 -> s32
> > >         u32 -> s32
> > >         s32 -> u32
> > >         /* __reg64_deduce_bounds: */
> > >         u64 -> s64
> > >         s64 -> u64
> > >         {u64, s64} -> {u64, s64}
> > >         /* __reg_deduce_mixed_bounds: */
> > >         u32 -> u64
> > >         u32 -> s64
> > >         {s32, s64} -> {s64, u64, tnum}
> > >     }
> > >     /* __reg_bound_offset: */
> > >     {u64, u32} -> tnum
> > >     /* __update_reg_bounds: */
> > >     tnum -> {s32, u32, s64, u64}

[...]

> > If I understand correctly from the pseudocode there is a dependency
> > loop between *64 -> *32 -> *64 -> *32 -> ... and so on.
> > 
> > This got me curious, why don't we actually try to compute a fixed
> > point here with a loop? If we were, we wouldn't have to guess how many
> > iterations need to be there, and the order of the narrowing steps.
> > 
> > So I implemented a dumb loop in reg_bounds_sync() with a limit, and
> > added global counters to collect stats. Pasting a (mostly vibe-coded,
> > sorry) patch at the bottom.
> [...]
> >   $ grep bounds_sync tools/testing/selftests/bpf/veristat.log | grep -o 'max_iters.*' | sort -u
> >   max_iters 2 avg_iters 0.09
> >   max_iters 2 avg_iters 0.10
> >   max_iters 2 avg_iters 0.11
> > 
> > This is across 400+ progs of various sizes. The vast majority of
> > reg_bounds_sync() calls don't change anything (0 iterations), and
> > those that do converge in max 2 iterations.
> > 
> > My interpretation of this (assuming I haven't messed up anything while
> > experimenting) is that the situation you hit in [2] is rare. And I think
> > it is safe to implement a loop in reg_bounds_sync() with a reasonable
> > iteration limit (10 maybe?).
> > 
> > Am I missing anything that makes it a bad idea?
> 
> My (limited) understand that this would make verification of BPF
> verifier with Agni[4] much harder, because it have to unrolls all
> loops & branch based on the result. Having known number of calls and
> no limited makes verification easy. Paul and Harishankar has a much
> better understand there.

That should be fine actually. Agni doesn't verify reg_bounds_sync as a
whole anymore. It follows a divide-and-conqueer approach and verifies
each subfunction independently [1]. So as long as the subfunctions are
individually sound, we should be fine and having a loop shouldn't even
impact Agni's runtime.

1 - https://lpc.events/event/18/contributions/1937/

> 
> From a conceptual view, we're trading always the understanding of
> fix-point convergence (or the potential to understand it); with a loop
> subtle difference will be hidden away. Might be reasonable as a
> security-hardening tactic, but seem to hurt the codebase on the long
> run. That's my 2 cent.

I think I agree with Shung-Hsi here. I'm not against using a loop to
ensure we always have the right number of iterations, but I wonder if
that would be over-engineering it a bit. And as Shung-Hsi pointed out,
once we have a loop, we lose the opportunity to identify optimizations
as I did here.

The one upside I see to the loop is avoiding unnecessary refinements
(the 0 iteration cases). But maybe there's an easier way to detect those
cases? And even then, do we care that much? I noticed the impact of one
more iteration is very small—I couldn't measure it on the runtime.

> 
> 1: https://lore.kernel.org/all/ZTZxoDJJbX9mrQ9w@u94a/
> 2: https://doi.org/10.1145/2651360
> 3: https://doi.org/10.1145/3728905
> 4: https://github.com/bpfverif/agni
> 
> [...]
