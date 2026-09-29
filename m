Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A085012B2
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692434; cv=none; b=WNv/j36RlN7HfCIEB/dBCy6Qfrt7kE1PdJHzMth+PB3af2ZUIE1v09IlviZhnZO7Yldn6LMCIbchR5vRX80Z/klWOgdSU8oXxbIrBON+ZqQCDSl0e7arFJkDpKZNuT5LOCTyMwOr1VpnxR4BRwyvzhQfh2fFJum9f3/kPwDXLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692434; c=relaxed/simple;
	bh=Ictfo6ayTgeVzDX16BAuhDJZt7+ZVbpOljn2/hm1F4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyttQg49y2DArU8xpjO+Ks5YqTKiuWyUGJoJjtNUWaoZ4TiDAh5KtTquxzLNdKUeVw2O7YtWDCx2KZq7dBpCLkm/3JXn8At77EvPjynhK1Rx9h7pcQU7Js4cYEy2yav/0YfeBlrQsFuAZWsRxxn/7QowrkBB60m13is44OPVsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqqqOADG; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqqqOADG"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc4c3304833so1619770a12.3
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790692433; x=1791297233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43/3dmeDG8ZHEWDYTwQfHePyNi6D0sJRBJ/5pN8ksjc=;
        b=VqqqOADGK6buDD9+YdT2fixb8lVGHvp3cKk7QAzHyXYdA8vECGq3PGXJYbV8TuPLiE
         bql1PUi3LBcRrpJgVxElHsQu9EZKzFyPt1RXXJ2/On/2OC5N5GFvvRub+gc2q8u/KpPr
         q/uBw5f++mbV3baaqeWv2dGapSDGOdByBbE/E96XOB8x7ypOI5qvrH14aH8X9e6wvrG/
         TPMQA3IjGZ+AHIXeBOMMw9lS5PWRKqaYfbsTi8RIj4A5R4blk8EWg3ozH44hRZ+QZuev
         PXZcrLMqDGfDCEfqndU0xo4plN/R5W7rYfcpLa4kztm7oIqK673+V+SCfO+VJqlylPrW
         MVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790692433; x=1791297233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43/3dmeDG8ZHEWDYTwQfHePyNi6D0sJRBJ/5pN8ksjc=;
        b=uc9udHMC9G2WIgyJTAP+VZcnHg03S089Au8jdDz5ZZP4wZf02SKdXaGqkearh9C3Wv
         n9oI2auS5ARpE8ynkwcvURMlwSsnx9Vpbd+O2FwNEkk210Nsyhjvtkos7IG2X5Tf6fyE
         HwN5yz+8jXyTH6xFWrQjHxVhvd67tv8YiTyhH4JYzqdI9yOgvxBJ77fbZFgrhrUliff/
         zDy8EEhlbi7y5vUpMMQ8mV301V0F4uYj5qOYPHQ7m7DA17ElSb1dFMBUWBthGjaXcQzH
         Ok2ZEU2i1BbGoURCFQCLdXp+K5UTxY646Wqek4V/SBG/WuRfhHyBvc7cK8IvO8Ndto7z
         ZAmg==
X-Forwarded-Encrypted: i=1; AKwUvBy+5dPUQeNPDv5dY1+K/B8sW4nYvm0bUncGGzd14+WRLc7d9OKelzRrbJ8whbBqJ8MsyaU=@vger.kernel.org
X-Gm-Message-State: AFuF++mmyXYF8yieBfl2TTvrysSV7ZoMuPcUZHfN0QLpJp7i6j/htbqK
	XSo+SGGvNmuVFJgmvBdOrRKjbFQsUiTsI1suDaLC+NRItCLDYbgLuiws
X-Gm-Gg: AYBFou1fj1E7ZI+wlvUdxllRrOhDQ+r6Ep18UbUIj+G2ZpGAIQUMKmVAymeCl8eQdCa
	BXBHa8FrkqB+AsP3qe+ydccbeAYy7fGWaTp3hJsEEV1hsrRi6lxO3817dFnGMPrUxK4JjggzqUP
	RQVGOFG0qCo/RUH6NazCuTOfn+XKYuVtv3n8NSyB7Us9QTD1ojpCayN2qM6STribFeK9b6Ad4Ju
	bAdYdx073Azpu1EgzytQY3BKeya+NQSCXHurZhKgVir2OcksP37VD05bY7uhj1QL3b4drLRNEff
	CEXjlL4oGWPopPxFKSK4dJJiaS/qw2iHKHgN+uKRHl/iaQu1xviIDtigTs1wornDySOH0r9+ASs
	NdsOb4VMN2s1XCi3Qfk8GyVItPTIA7T/H8u7c64+6lEpWSMWMhKsKls3R/9utVeM89Ddb0iBdUM
	fZnNUlqapBe+ZYtparIdLzOvWmLNEoKvp45y8PGpDWw4sBsUe2+AufdZmheX0bCBIED32zKKk=
X-Received: by 2002:a05:6a21:6089:b0:3b2:a809:1000 with SMTP id adf61e73a8af0-3de0e6f07edmr15049574637.3.1790692432560;
        Tue, 29 Sep 2026 07:33:52 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7a3bb2d5asm4339524a12.17.2026.09.29.07.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:33:52 -0700 (PDT)
Date: Tue, 29 Sep 2026 22:33:46 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, ast@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
	andrii@kernel.org, gerg@linux-m68k.org, rdunlap@infradead.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, bpf@vger.kernel.org,
	jserv@ccns.ncku.edu.tw, marscheng@google.com, eleanor15x@gmail.com,
	Daniel Palmer <daniel@thingy.jp>
Subject: Re: [PATCH v6] m68k, bpf: Add initial BPF JIT compiler support
Message-ID: <arvMSjbC23bPf3l-@google.com>
References: <20260927205501.672807-1-visitorckw@gmail.com>
 <CAMuHMdVcpHrxg_Kb1vpguSYbRg4CU4DxNuPAv3UqHNHZTNk33A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVcpHrxg_Kb1vpguSYbRg4CU4DxNuPAv3UqHNHZTNk33A@mail.gmail.com>

Hi Geert,

On Mon, Sep 28, 2026 at 02:15:43PM +0200, Geert Uytterhoeven wrote:
> Hi Kuwan-Wei,
> 
> On Sun, 27 Sept 2026 at 22:55, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > Add a BPF JIT compiler for the m68k architecture.
> >
> > The JIT generates m68k machine code targeting m68020+ processors and
> > coldfire parts with an mmu (ISA_B/ISA_C). It excludes plain 68000/68010
> > and non-mmu coldfire processors, as it relies on 32-bit branch
> > displacements (b<cc>.l) to handle large bpf programs.
> >
> > Tested with the test_bpf.ko:
> > test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
> > test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
> >
> > Tested-by: Daniel Palmer <daniel@thingy.jp>
> > Co-developed-by: Greg Ungerer <gerg@linux-m68k.org>
> > Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Changes in v6:
> > - Fix kconfig sort order for HAVE_EBPF_JIT.
> > - Update eBPF-JIT/arch-support.txt
> 
> Thanks for the update!
> 
> Are any of the issues raised by the bpf-ci bot valid?
> Thanks!
> 
Yeah, I'll address those and send out v7 shortly.

Regards,
Kuan-Wei
