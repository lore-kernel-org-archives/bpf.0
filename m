Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043F34071EA
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540298; cv=none; b=C0A7KX8g/lVqKrqEVMYHi4arHS7ha48vSm8rdLN1zvAp8y+tMCjwHcKJKPKuuyaD4kDopx7JGFTsCJhhwCaE4iBVaQuZbmGTLL+c63P0ZrKKkWzJ2X8J80vn3D52PxNN32EFeTYfPMVbWxlKV5FJPkt2GcHiWBh0+GLlD/IT2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540298; c=relaxed/simple;
	bh=IOMZlbpL0GrwFfKcFv9wUsIFMWMA6CS04KAis2OFcPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqEUC/5RgM5mwHYWN32/UW7saHuJPzhU4EVJGD7qO3VxXYAO+04e/sbkvJEG7jsHB4QXKBx0FUEYKSRqdIXRuAF0MtIcn2mXDPArDezpEBCBpCYTmGMLzP9KG5fDKYBkcbztf5Esb0SZOObdowLBCrmtqYcOlQi76TiGRKsCmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+7Vqvs4; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+7Vqvs4"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3075ce9c05aso8897604eec.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540296; x=1782145096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MPPoX2HOZ1fi6+ZgFgHzOVUR8qos12VTmnYrcXYqIg=;
        b=e+7Vqvs4KGzz7EZe2VCDPZAhk2upus5u3tMr9GQx8PGY99IJleNo0LjzqYU9x254yd
         KfDG48IVPelg4b2jF7neX2zK83KQmWCvREOprWoBhic2Jwtk8KeR9cLStMfLJWsnZBOI
         24t7DRKRiT7x6cCvb1nVWJqdWBO6WJsDlQL+VByQnFBI3YchC8xZpdDWFu2YPQVU5loO
         UMqvJWQUYYdnUdr70G5Kgrn22ZP0hJmFBlghvFUA2OYGPsgNuLyVEF8HSQHzPeZUxgDH
         SjlD/DwVB8AZNzGLNpYWUs8ahl0q6LQxbpA6m5MF72tMjohbVn9hpltAkAghS2HW92mV
         efmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540296; x=1782145096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MPPoX2HOZ1fi6+ZgFgHzOVUR8qos12VTmnYrcXYqIg=;
        b=bB6ZjLtCZEcJPVkJZF00vgmdLhEfufD8dNT9kJO0wjpm6MVyAHjTgThd73Yh57zhbX
         mdQKRKk94rYWzylEbR1U0WQ6cBnL7xQ4nl/e4rVmEoL8S+AanMECf71Komwf8Wb4NyoJ
         jBSYGfsutWqp7I0EsogOvpDAFoaIMapGCL96qAXUCjNSwwdkJnjpmpxBlzGzniJ13sWQ
         g/3yXA5ewsomRRGF2XJUGxXZn/1fLGWrbvyinm/DzWg6iHMKGr0/dltJsBziRpo8MLuH
         NjooolPlgtzMEt4iJYcpso3SwTt1MvnHYq7syO9D9PLZDadqRCPIa8M8b7sX1ScluUEA
         txPw==
X-Forwarded-Encrypted: i=1; AFNElJ/M/mO0mXaQkYLFQ7nuB+n0lYajLGt4Ilt0kVqY0v0ZcH1F9dT1NYnu7PFfkTAAfF/lHXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX2XUOstraQnKhaSzO398bYiVYzSk1rEXE/nlxSkNeMrAN4Pbs
	Snl3/C+VJF42bClZIIUDl6qFXGQuNupWzVsjLbhyKiUu8XP7i5gAUXXJ
X-Gm-Gg: Acq92OFFSN4S1RL0mfFG5ntdWzsIp6Mnp/bftjcyyRg/AJNsveOaG6OiR7CuNcWD6Nl
	H+S+mREnLTQqPclUb0864H1O3dtXhrdtQcVbYzKNvTMSaRJCfUWxfgnqrVHJhruWB5Fdffov7QP
	edvMLLrnEFJkpVy34VRPxdCyZRHsMP0oM/ZE4PQvU4xVQKsDf24GFItfzOdPOh4nZLfcE1mZ6vI
	X+V4j7bdNBFdl/6EbaaITfRjOxUyvNASNd9ZqQxuyzneAyk5bIHTB5Noq87j7t7k0SKf7gOk3hs
	LXNFfCLHClATelAZ8YPtw+ln83jjl2ree5s3Ig9h4yhMAe0WJdGlraxVlz1fxPb3sthIc8UwhMw
	JYE6nMffWZi9tToa4wuIHT5mZ+g+IGROuxRZ/NYaBre6b2CBNuYHvDJw2ICI055A9BsjpyzTJWh
	8J8cjshAm4S8mcIKqTySk+iPA=
X-Received: by 2002:a05:693c:42d1:b0:30b:5571:b412 with SMTP id 5a478bee46e88-30b5571ba3emr3834996eec.5.1781540295974;
        Mon, 15 Jun 2026 09:18:15 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5fefecsm15400189eec.13.2026.06.15.09.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:18:15 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:18:08 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, luke.r.nels@gmail.com,
	xi.wang@gmail.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, alex@ghiti.fr, jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com, marscheng@google.com, bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/3] riscv, bpf: Fix signed operations and
 add 32 bit atomics
Message-ID: <ajAlwK990NFUAMwq@google.com>
References: <20260511221648.3251464-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511221648.3251464-1-visitorckw@gmail.com>

Hi,

On Mon, May 11, 2026 at 10:16:45PM +0000, Kuan-Wei Chiu wrote:
> Fix miscompiled signed operations and expands 32 bit atomic support in
> the RV32 BPF JIT.
> 
> The current implementation ignores the instruction offset field used by
> the bpf instruction set to specify BPF_SDIV/BPF_SMOD and BPF_MOVSX.
> This causes these operations to be treated as unsigned or
> zero-extended, leading to test_bpf failures. Fix this by checking the
> offset and emitting the correct instructions.
> 
> Additionally, we leverage the mandatory A extension to natively support
> 32 bit bpf atomics (and, or, xor, xchg) by mapping them directly to
> amo*.w instructions. BPF_CMPXCHG continues to fall back to the
> interpreter.
> 
> As a result, test_bpf.ko now runs with 0 failures, and the total number
> of successfully JIT'ed test cases increases from 843 to 902.

Is there anything else I need to do for this patchset to land?

Regards,
Kuan-wei

> ---
> - Add missing Fixes tags.
> - Fix memory ordering by emitting aq=1, rl=1
> 
> Kuan-Wei Chiu (3):
>   riscv, bpf: Fix support for BPF_SDIV and BPF_SMOD in RV32 JIT
>   riscv, bpf: Fix support for BPF_MOVSX in RV32 JIT
>   riscv, bpf: Add 32 bit atomic operations to RV32 JIT
> 
>  arch/riscv/net/bpf_jit_comp32.c | 101 +++++++++++++++++++++++++++-----
>  1 file changed, 85 insertions(+), 16 deletions(-)
> 
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
