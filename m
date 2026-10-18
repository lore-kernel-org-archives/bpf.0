Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994B4D178A
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337252; cv=none; b=jKZrzG96ibHxvHl7RvPUewMedzd3+8rDKGKcdbF4kQWW5BK7TGJmFDoXkLnbh+Cga1BKZmZFs5Bd4ID2kMpfl4KQ3ZJgfHNj7khkrNr7t23OGTT1RXB6fmJzGAtU6AOGl1tH4PpBuDc4z8xNiLiLuL0AYH6ZTNAUAAiAuO2oDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337252; c=relaxed/simple;
	bh=Tc7Slxp62tn7lMBuq2MMamCQYVGOw9llz5BUjwRrgmU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bxrkW6yVS71ElttJZThRNplUH4HIt1lTb9luomWYdVYN42votEXL8qwanQ2UXVPZKT4kJGZL8fREzx7qoXs7/kvmbSgdTnrmUKdjRBiLpXJ4g15hcUYsdvwoyvfBV+XaXIaft+tvJbXLM4qKh3lgUBdZeYIGJU1G6DrTrjZasE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWU3XXLj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWU3XXLj"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so48540b3a.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792337249; x=1792942049; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PLi9hVkCsH3YiZ+w7j8S3/cxhLWAMV2a1RCiWoqeuBU=;
        b=eWU3XXLj1apmWWABy+WJ62AjGgj8RaOGCfKViHbBK82fHbhDBRSgK326S3zh3D2xhQ
         IisfQdTU7oQsdCWMIx9HV9yNzFKRJhE2ngceFeqe4RxhLTd02J1N9yXBe5SLuETgdodU
         BjL4oEpzZD0qZT8br4rz/wIEI87FAix1Whp+3Fmgc3mtFdoC6QtTRe7JaD9leWLlefyy
         LpSZ1Uc4TrSgWZ3GT20MSTV0KTO4jIdoCu67X8jxOmB2Lpvcb7nHB9c4/zKGxSfvAxoO
         cU3mFNz7BXbSxFVuY0Xv7Xa3UcAfExLB62GFtC9aQd8GFkGTbtAVJkMmhI7Bg7TWzWH9
         kX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792337249; x=1792942049;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PLi9hVkCsH3YiZ+w7j8S3/cxhLWAMV2a1RCiWoqeuBU=;
        b=ABHCTsXcc4A3nPwe95IJcbvLEcH9YfAcf45HoX4MkqNyUQqAVdo24N+9hNn6PLhD/G
         nVRMaxdXWjYGpH2NJrSqTOy+jMQlZ/ud3VzwLdytznTXzJOYBEKNZoORzHJNxsQ8P/VX
         EJrKTUcCrtsi34qfCbO8u7EtO8KKcR4qK9IHapdV9xdj2bSnWMTSr7ob8eU3AZKvp9HE
         BrBK9bj9nzZR69C1Z8pR2B3nLgLXQW+qtMTD8ewZdzl/HDJpxgNVPtkJcGGrJOI5P/Y/
         lmoZjpNFfklDIW9m/1bQA68rHY6XQw2UFSC/cPMkfREf+NNi4oiDjHhpLAiOCXfXoTpr
         BZ6A==
X-Forwarded-Encrypted: i=1; AKwUvBwaeRNGc6QbzxSxAjFU577/YGUFhpEiCBbS8xDlx6WZ5uZpAxKhWDPegy7U5PcqPZl2DMI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJO9waAKn7AJTei5stpnYmnMiKL3MJ7A7u29eb5VAXukh+rYGTM
	tPa+/Ps5u77Cpir+YoXCCA+kNPqfWuYHpQuK+3u63S9C9US6RONsRExY
X-Gm-Gg: AYBFou0XFPURigEM1SfdUB0OQ3Ysw+2aRuOGMwaL4/Il1XnWMauSytGo91FM9lTYIA+
	jiVa8jCiOIuA2qG8SVswVEnbRDDPYVKv5VOGgHt+iKtOU6EMMBSbyRPvP1TAF8FZCYon7mIyab3
	bXuHTbxuhH0Vh0xnsNw15T2oWwKkOEo9I7mLJ1XgHMZf/zrID6tKxq+PbQucxAd+Ui9yFFBgHEe
	Rqa+QC2gdKAqcEWaZq5Am+NmyKnQpS0ood9yq+wGGsMk3YAthAfFB0Bv66l60xHI0WV56ZtTiQr
	8jzjwIPwagCL6ds71KQjjqvegCexHJJgXgNGcHLCuCQ8AmRbHHXHxaPfstJ8v3fsQ14wlDRflg3
	72GYJhEbeoUfvD6epP1UjG8g0Q2DENl/NCWhKZRyEU/iMln6s9JA4fD0PN0pNboskg4Mbp7r9vE
	+fQLPVQCVzKicP2HOcPrKPTD6u7NlnrHTZQF9mNPT6a3qVDf/NKOKbmNkgJIXTxJswV4jMTcUL5
	iRIEKovqUtr5q/Yi5d2so/K/PdZnQ4kPT2S9bdIH5NMaCZOWG/X2t3XBuO+4hmmlGx7H7UyChOC
	ESh2fEiUzXWJtw==
X-Received: by 2002:a05:6a00:b84:b0:89d:7f51:6492 with SMTP id d2e1a72fcca58-8a04cc24de8mr4216832b3a.32.1792337248874;
        Sun, 18 Oct 2026 08:27:28 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm2997008b3a.42.2026.10.18.08.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 08:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 15:27:26 +0000
Message-Id: <DM82J03M6JWF.39ILAQJO5Z6E2@gmail.com>
Cc: "Josef Bacik" <josef@toxicpanda.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Jonas
 Bonn" <jonas@southpole.se>, "Stefan Kristiansson"
 <stefan.kristiansson@saunalahti.fi>, "Peter Zijlstra"
 <peterz@infradead.org>, "Will Deacon" <will@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, <bpf@vger.kernel.org>,
 <linux-snps-arc@lists.infradead.org>, <linux-hexagon@vger.kernel.org>,
 <linux-openrisc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "kernelci.org bot" <bot@kernelci.org>, "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH bpf-next] locking/atomic: arc, hexagon, openrisc: Define
 arch_cmpxchg_local()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sasha Levin" <sashal@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Vineet Gupta" <vgupta@kernel.org>, "Brian
 Cain" <bcain@kernel.org>, "Stafford Horne" <shorne@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261018132907.3823160-1-sashal@kernel.org>
In-Reply-To: <20261018132907.3823160-1-sashal@kernel.org>

On Sun Oct 18, 2026 at 1:29 PM UTC, Sasha Levin wrote:
> Commit ccb88db8dac8 ("bpf: Don't hand out a linked element as extra
> element") made alloc_htab_elem() take the per-cpu spare element with
> try_cmpxchg_local(), the first caller of cmpxchg_local() outside of
> architecture code. It doesn't build on arc, hexagon and openrisc:
>
>   include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit dec=
laration of function 'arch_cmpxchg_local'; did you mean 'raw_cmpxchg_local'=
? [-Werror=3Dimplicit-function-declaration]
>
> raw_cmpxchg_local() maps to arch_cmpxchg_local() unconditionally, but
> these three architectures don't define it, and unlike nios2 and
> microblaze they don't get it from asm-generic/cmpxchg.h either.
>
> cmpxchg_local() only has to be atomic with respect to the local CPU, so
> an architecture's own arch_cmpxchg() can serve for the sizes it
> supports. arc uses its relaxed LLOCK/SCOND variant when ARC_HAS_LLSC is
> set and its atomic_ops_lock() variant otherwise, and openrisc uses its
> LL/SC arch_cmpxchg(), the way arm64, riscv and s390 alias theirs. The
> hexagon arch_cmpxchg() only handles 32-bit words, so hexagon uses the
> generic version that disables interrupts, like sh, sparc32 and xtensa
> do. Linux has no NMIs on hexagon, so that is sufficient there.
>
> Fixes: ccb88db8dac8 ("bpf: Don't hand out a linked element as extra eleme=
nt")
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Closes: https://d.kernelci.org/i/maestro:78b65519ee4561df1fbf1e72f1dec9da=
7e5b153e
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610181750.BoqAddaF-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202610182048.aEaiBP8W-lkp@i=
ntel.com/
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> The only user is in bpf-next, so it is probably easiest to take this
> through bpf-next with acks from the arc, hexagon and openrisc
> maintainers. A similar change was posted in 2023 for objpool and
> stalled once objpool stopped using try_cmpxchg_local():
> https://lore.kernel.org/all/20231121142347.241356-1-wuqiang.matt@bytedanc=
e.com/
>
> Build tested on arc with and without LLSC (including both KernelCI
> configs), hexagon (clang) and openrisc.

Thanks for the quick fix. Applied.

