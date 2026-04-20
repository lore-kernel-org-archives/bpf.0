Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6C21C16A
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690520; cv=none; b=oyUdy8l/+wN2CPMAUsS2kdjcUoSdCIfEhZ6uKNSRF1LtEaMSwZaKr+2103aLZntPAmEG8aASMKFFCS/gk/Ygvgi9Y4cmB5Rf/sGjot0mmgc9SUsKBw/EID6AW9y+t23LsgFn0qLDKyo1rvk4k5M+DSdwaeBHkUFVy4dIX3rHmok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690520; c=relaxed/simple;
	bh=WfdVss5pRtKxRJBglQrxBTFvd3jpqaaHpT5PTY30qcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYaX4Z/5O55IleJztmnOXIfoQSF03vmcx1g75UOv4wsBQ0L2c52ZyMPbGJSQo5BzHc7oVZt+AJA2zo4gOeRmZB/nvQ4dVl6ZoZcHQ7463bqIzTVWbtNhDCoGAzI+b1667f5S4FvgSwdJimDoyJJjiZw8VexbWjbLUm5o4PCerTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGltjTc6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGltjTc6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so46859455e9.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 06:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776690517; x=1777295317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wEN4jEMCOiQ0Wb/rEfzmY335o62y1i/d8QKlDPNvdc=;
        b=OGltjTc6So0lhKLVhds0TswoCWFDJLk1RyqcSpCHjngiDSXfD5qOTHXrYL2PTTDpO4
         v83z+cMlwjEC0txBbh1a2dPjxP8+QpQBw1ra0IcEEaVFjav8uooyRRDJ4kIl8ifz5mZ+
         0iNp9vcdp2fR9/OHUfh9qEWcj6f7224FKwuHzEjC/xCOLwHlLOca3Asl1iH9YJYWVHg5
         3fKqSRVvq8ri7c7pvk/zUHTlAfggOHqjCUVBjTqUh0gO2Hinc4TAZ78PrSL0tG//FHFm
         dmnkWl/uHG9tVclZ2rrwN4bGj9SDXe/mNO0Rv6nDsxLy9yoNA1IJfHCpSTeACMyxlcC/
         haxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776690517; x=1777295317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wEN4jEMCOiQ0Wb/rEfzmY335o62y1i/d8QKlDPNvdc=;
        b=HQp9oOUFIfFsjIg6ApzFOu6TL1oYCUy3YuFXZMTeKEexqBNFDuNyeQ1jZC1O/lB8FK
         EVvC4w3ejAlR0mUbgqmSHM0/fi1qAp0M5CqzzSuR1bMJTcJ5j1V1CoeQ2CaHQ20Fp9V0
         mn0YM6nJrRJhoTG7/0RGwiRogesqUKLeuzqPySinOKxFMV71ZSFV9TBb9cyLNuTYx0mr
         JaxsKbgr9F5soGeGcU9SvbULMZry2/gBU7yPx+gbpqOSjwTYehKWHUcbPzLVXy+7QcdA
         rrWDiPeBLLS0SSygjpd/yZmhbmdkhLP9IvusG1g0K9vM3MF6l725vGtl36tcpSGGZEYq
         j3ew==
X-Forwarded-Encrypted: i=1; AFNElJ+XP8KdCs7BS6SkBNWdYTsVH8GINqHzDrl/HvYeOEZbvSHX6f4TRj14IlQEKFngn4Rm0iE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ZRCQ6pBSdEqk0FNjx+nQhErjeHFmRzW/582qvWucNEZqFEXr
	Pdp41CpZ0ApIPEsAML0ESJ6U3mW4oB+klSvw0A+yDyzJlzP/l8x0yuv6
X-Gm-Gg: AeBDies589GoKPOwnCNknY11OJ0PSGJhh2+Iro/hOGlpRY+HYOOLpPr/S3IsrYYPcTd
	fAVT2OEvd9Bf2ZhC32lV4KJjFUmV86Y0WcypE4xr+9JTlygSxaNSfj3Mp2uS5iH6JVfoQN5b6dW
	ZlCzkv8zaAEd1adBrRZ836pRTXydEexKoEz5UqKiGi9DdSOFKYi8aqUZzxxuRAUUbqrEg5v6E5V
	8hgNnNX4Mt4FXT4TtO+q1YmtbSzHMxkX7rPfveBzYDZpsskeHK4e2IXYFDEjCxu6CVDCVHKkKEj
	/zWRtZG9m++IkcB1rEXCq0UOLuYBLcexQKHDn3Suf++Ou4EXPRec3gSr+2d0HkKN+QT99iS5w/S
	hvdoBXRtSuaeHxtypKC1KzpMhJEhFAiIDSUvHAXIPUrwe9xnblVRh8tTIlo4Ur3Uu/ldRaHzG07
	egjVsRFMIW1QP/D4/vNLc4z/BY8rztvyDIzijZ7k3mBe4s/J8k62vvf7iWHGtcd/vS/KygpQnaL
	hoC
X-Received: by 2002:a05:600c:c09c:b0:48a:5363:8cac with SMTP id 5b1f17b1804b1-48a53638e07mr5220075e9.22.1776690517192;
        Mon, 20 Apr 2026 06:08:37 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52583fe7sm21505945e9.13.2026.04.20.06.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:08:36 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:08:35 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
	fw@strlen.de, john.fastabend@gmail.com, lkp@intel.com,
	martin.lau@linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v4 4/6] selftests/bpf: add icmp_send_unreach
 kfunc tests
Message-ID: <aeYlU9r1ZyQ7rcgs@gmail.com>
References: <20260420105816.72168-5-mahe.tardy@gmail.com>
 <4cfe307cc6b1197fc7bb3a11e79382764ac1d269a42eb4e4ffec9e991e6868e6@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cfe307cc6b1197fc7bb3a11e79382764ac1d269a42eb4e4ffec9e991e6868e6@mail.kernel.org>

On Mon, Apr 20, 2026 at 11:36:13AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
> > new file mode 100644
> > index 000000000000..24d5e01cfe80
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
> > @@ -0,0 +1,136 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +#include <network_helpers.h>
> > +#include <linux/errqueue.h>
> > +#include "icmp_send_unreach.skel.h"
> > +
> > +#define TIMEOUT_MS 1000
> > +#define SRV_PORT 54321
> > +
> > +#define ICMP_DEST_UNREACH 3
> > +
> > +#define ICMP_FRAG_NEEDED 4
> > +#define NR_ICMP_UNREACH 15
> 
> Jordan Rife previously suggested in v3 that these ICMP constants should be
> imported from <linux/icmp.h> rather than redefined here. Would it be cleaner
> to include the header and avoid the redefinitions?

Yes it would be cleaner, but looks like I can't do it simply, maybe
there's a solution, see the answer from the cover-letter:

to Jordan: I couldn't include <linux/icmp.h> because of redefines from
<network_helpers.h>.

> 
> Reference: https://lore.kernel.org/bpf/usz5bhydsiejr37owgt3zypckzh7fa7ygmhsyaaiprsljx7iy5@ipopnr5n4ds7/
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24663313503

