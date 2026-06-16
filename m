Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583653BED44
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 02:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576471; cv=none; b=TlblqMnGjRQQZDgiP1ZgVMeaOBFnCrLWVQIvJ510A00LbtWJ5Hg4bCzm3VhzFwOge2QqH3UEyej2odbL5zQyCS0ExUMtOqPaxwMOtp3bboka4sAdcBo2Q8WpPDd1z7JiQjDptQ5Nr0tzTLPHMmu5lQo/ay+SfMouodKutk+vc9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576471; c=relaxed/simple;
	bh=6oQjwVA9B/dpSWzK7h9TRxrdJBhQIxFcZOvgsR0/5us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1xOuHhAWp1n1P1H+k2Gle2/GN5j5a1V6De4Exiv8tsH4+ph/J8aMUfVkBIi9DZS1kGUlmbALz9K881kKnTHBIcQy4fAZSxSw6RGdD4GAlsigTokvNZB0NI4RvqMfFJA8Zgacgafkh/3ucqk8U9iK6Dc7DeIeJAW1Ooqe0MrL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIMoxbEO; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIMoxbEO"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137335bc3caso4809131c88.0
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 19:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781576469; x=1782181269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a6IEVsqYp5cYVGQwVC9lenyJSUbd6i5nZsgE+48XJIA=;
        b=ZIMoxbEOXQ6pGUtgFpkwr05AiChx8CIlKWCEyvpQPDVdTDXiL5rQoyzRQAd3j4mLCx
         sFJUuwUOxEEtUBLyuP0+wP28rOtgaQM0UL9dbmc+xsvTUt+AWtzVdM4vpAifl5U+ISJ9
         3Vt5f64aL0ULrJLtRopi50VZ7qdiAnreGZoTnZzxlzozuie/e3LeW6prZgiWJR/ApCYN
         0+5LE/BWElCgeXCyZDy/0EjuJ489Ta8gJ16j5KjJq1pfw8uMx6Gg4O6paixfM/TZMO7K
         6gvbDOJ/nWV6Yvj72IM5ys9kyLw5ICcvDEBuegYsFjvzDXXXFKKYA8XzXdG4U3AdSExg
         9UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781576469; x=1782181269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6IEVsqYp5cYVGQwVC9lenyJSUbd6i5nZsgE+48XJIA=;
        b=GYX9HZUC8nnCwoSBwnBpbcALsAo09R2ptKuSM1SA4pMQfbxdNptXNUJZFRf6w5AGkR
         mDuoqmaRkfnYgR1qSHywSmG9wI9Gz3fnERzt2RpqP+y3YblXRw/PVVg9aBXHbz8Nzy1b
         rdw7HXo1TQtpZ1Kdbd8yGI5h0YPYm4Svke7cYtIJ28NtT07NIWG/+Xccz454PKyMnphU
         A6bukx0D+1KVybaEm0vKKnWEBZRM+b3OB+9V+hcWbjt5OLOBghW4l7oSe810HmskRT6M
         4dQDNMoMN4wgUQIbEMasWRzD+9AuTzhzl/gsK6jd1cHScKR8ikLKdomoj02PwNjnNJG5
         ufRg==
X-Forwarded-Encrypted: i=1; AFNElJ/BhALQRIyfzUi2DAYFVRALoJte95SoFr9kLN5uw+z6Dp4EJZKa0LHhtbGwSiFW+Ti9VFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgBNbbxjTlKdKyTkxZGRfYDv57t4nHQjmd4P4AtrhRc5b00od
	E5GKDyRX1izkoUzINfdUGPEXjsDwedAXTmufrjZXnZc1lNQMEy38QbxC
X-Gm-Gg: Acq92OFthKchzkz2b91MjqiQTJAr9WJqq6KJnXSXbrlu0NSpzbZc5W3QsuQRPkomX3+
	PNTnd3DLzAhiXmIUJYODvBgawm2hf/DzxPr9KP1WWDCeZ8hgpAX8ZnZnIkF5AbIsg9JSwPzfewu
	IJKA5s2i5uiCCVH2BSHnpAB4bSx6HGwaHesVzObGXsIjOa24Bu8y/Jr4n3AXtm8p4y65Sv2D4Lz
	7dT7ayaVXzkA0Gctl9cYlZ5r5zGKdIGxvJrTxikHZASyrWUXoB4JxOzoodzdR9h+SMXIbCkUkkO
	60o+uw/9eEa0t+OD1MvAHAMqGehK6nOwgtKo+t+Ycyxg12a7pB79WOi/ZPi5BZeaMs8XG7ESNSi
	xJClU1kemUQ0ACYPZc2csd5XdbJngbW28Emj5KFoMTgZxYyf2M0tjRgVQpRzy/6F+ub0moMQ7dk
	Dt6pfRSlNZb1zqQRehIQx47Zy+6D06DgMf2zuNx8l/vflnI70AzURWDHWOyQ==
X-Received: by 2002:a05:7022:250c:b0:137:64ad:76d0 with SMTP id a92af1059eb24-13985e99350mr720917c88.7.1781576469334;
        Mon, 15 Jun 2026 19:21:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:7d96:5166:93ee:6926])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b919ef9sm12517464c88.7.2026.06.15.19.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 19:21:08 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:21:02 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Pu Lehui <pulehui@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, luke.r.nels@gmail.com,
	xi.wang@gmail.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, alex@ghiti.fr,
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/3] riscv, bpf: Fix signed operations and
 add 32 bit atomics
Message-ID: <ajCzDo7bnUqE0DiW@google.com>
References: <20260511221648.3251464-1-visitorckw@gmail.com>
 <ajAlwK990NFUAMwq@google.com>
 <216ee1df-2945-4266-9c70-ebcd36faeb7f@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216ee1df-2945-4266-9c70-ebcd36faeb7f@huawei.com>

Hi Lehui,

On Tue, Jun 16, 2026 at 09:41:21AM +0800, Pu Lehui wrote:
> 
> 
> On 2026/6/16 0:18, Kuan-Wei Chiu wrote:
> > Hi,
> > 
> > On Mon, May 11, 2026 at 10:16:45PM +0000, Kuan-Wei Chiu wrote:
> > > Fix miscompiled signed operations and expands 32 bit atomic support in
> > > the RV32 BPF JIT.
> > > 
> > > The current implementation ignores the instruction offset field used by
> > > the bpf instruction set to specify BPF_SDIV/BPF_SMOD and BPF_MOVSX.
> > > This causes these operations to be treated as unsigned or
> > > zero-extended, leading to test_bpf failures. Fix this by checking the
> > > offset and emitting the correct instructions.
> > > 
> > > Additionally, we leverage the mandatory A extension to natively support
> > > 32 bit bpf atomics (and, or, xor, xchg) by mapping them directly to
> > > amo*.w instructions. BPF_CMPXCHG continues to fall back to the
> > > interpreter.
> > > 
> > > As a result, test_bpf.ko now runs with 0 failures, and the total number
> > > of successfully JIT'ed test cases increases from 843 to 902.
> > 
> > Is there anything else I need to do for this patchset to land?
> 
> Hi Kuan-wei, it seems Luke and Xi haven't been as active in the community
> for a while, I'll make time to cover the review and testing for this.

Thank you for stepping in to help with the review and testing.
I really appreciate it.

Since Luke and Xi haven't been active for a while, I was wondering if
we should consider updating the MAINTAINERS file to reflect the current
status?

Also, if you need extra hands, I'd be glad to help review and test
future RV32 BPF patches.

Regards,
Kuan-Wei

> 
> Regards,
> Lehui
> 
> > 
> > Regards,
> > Kuan-wei
> > 
> > > ---
> > > - Add missing Fixes tags.
> > > - Fix memory ordering by emitting aq=1, rl=1
> > > 
> > > Kuan-Wei Chiu (3):
> > >    riscv, bpf: Fix support for BPF_SDIV and BPF_SMOD in RV32 JIT
> > >    riscv, bpf: Fix support for BPF_MOVSX in RV32 JIT
> > >    riscv, bpf: Add 32 bit atomic operations to RV32 JIT
> > > 
> > >   arch/riscv/net/bpf_jit_comp32.c | 101 +++++++++++++++++++++++++++-----
> > >   1 file changed, 85 insertions(+), 16 deletions(-)
> > > 
> > > -- 
> > > 2.54.0.563.g4f69b47b94-goog
> > > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
