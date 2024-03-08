Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6054FB0
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894903; cv=none; b=r4eRSgNysXhC1Y0/e7hBVxmZ6+sZ6xE9Iz2KfEZg7sk2ZQfaF2FD/c0iF4OI06aUdaf1KPNYkXui1WOaTikF4E1qA+aDdoseta/NoLhNtS4ZHtBI1xz7bjNBwV6AcjoegSgQE+4bQTD/AlgxO684wuu+UKRXC+YfvtHs79tIrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894903; c=relaxed/simple;
	bh=Q2p1nqdXkF20Wgelw53WVgSL+Uq1JR8kxpIUSAn3Gpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt0aNrPkVDYwu6C7na8MDdDkckFHEB15HyzSEWYAwtY3sJxppKbSp4TYGBgrFqSD4WIwCD1+1cRk7GjN93RvA2E/spu+cmHReSVy/8mzxCnjcZGYi3xKh9VZcWAlm54fa8Mmk8IIN71NaHnMdYHQB91JpSup1zOC0cHm9Es9mvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JFxjUbAn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFxjUbAn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dd4bc7a87aso3219965ad.2
        for <bpf@vger.kernel.org>; Fri, 08 Mar 2024 02:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709894901; x=1710499701; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=26hAEq53OJfxkgYSi/GiWOaFJ9O8E1BfJnbrW6c9mKE=;
        b=JFxjUbAnVrElm7ywcn9wyjWG4718Np5cjMARdL1Eel4X6Qqz/zhUgp1l4sooS6eddj
         qs2olmYz2Dohl983LUvOPd9Bog2aKCWd5RP54nQdnk9jO7/JbdG44gI6L5+SXZpY6dBC
         bKDNIY2n+sq32ikkS5ucTMcQX55kdw4UWfW8kicdSZjHRN2CWvykzZsv/2ct/BYPhrFN
         U9Nl/rbn3nU54/ffsG88+v3jns+A5nNGVEWzrVcmy1AC/BHwycIbl7eIH5QPlm/ckJRJ
         CtOb4JofPP0OIXTQb256tWVq+YN/B+CnvCSRU8ZKv3Hawmp5qXgXf2Mm3L5o1OCR/IH8
         FidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709894901; x=1710499701;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26hAEq53OJfxkgYSi/GiWOaFJ9O8E1BfJnbrW6c9mKE=;
        b=csX4EHcgaB2UjH8hLw3zBcWULcxLfXywIfPAoxjzE0YaD7MCTCCmPVpPnRnoo3QGR0
         zEc0b4uaSHwh9lMQr0yjKIkHCrlBrGUJ1gB/AQwk/zEt7miTkNiNRyXVFHq37DvVBI03
         D3xPc8wkYR8evWZDHCVXf4Lr8KoGcB6OUF7+2aoCnQgC6gNYf2+pBX78nEq+dkQpl1NI
         +tjWX+y9oQtiJzOGw2pPhM+lA2I6ynOJrdC8ges3Efh/focDPtspFyoMns8WSf8T5IF4
         FBeqGAdTus7KdWYbrGhoEMhvOI//ybB3njumMlw1P4Eo6zAFCtQeetS0gwjyxUqoUEnO
         WpyA==
X-Forwarded-Encrypted: i=1; AJvYcCUczqMHGAeYrEkR+/dtQQ1dMEiXR2qbdGwOixtK29pODVoHoviCgNFtiBBGwQimn4CE0OaYyW1jwa8wfRpHrP7uQQU0
X-Gm-Message-State: AOJu0YzeB/4k/wOlK/W4PHsc556dgF3pSwp5oVE5wlMVotATdPct/vJG
	+PTc7ecwPKSa/72lvx69sLrr2rDhy/XlXit77x6P4aajuXCYx2BiRsXZEwxHQQ==
X-Google-Smtp-Source: AGHT+IGTZSiRBTMWUdaBO1vqD4dWLINeszuACZPHN9xahf3y7wMBHlVvLuZk7dXkbF83IM4NNHUGtA==
X-Received: by 2002:a17:903:2443:b0:1dc:ca1b:279b with SMTP id l3-20020a170903244300b001dcca1b279bmr13328124pls.1.1709894900832;
        Fri, 08 Mar 2024 02:48:20 -0800 (PST)
Received: from thinkpad ([117.217.183.232])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001dd3bee3cd6sm4853039plb.219.2024.03.08.02.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:48:20 -0800 (PST)
Date: Fri, 8 Mar 2024 16:18:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
Message-ID: <20240308104811.GA53064@thinkpad>
References: <CANiq72ka4rir+RTN2FQoT=Vvprp_Ao-CvoYEkSNqtSY+RZj+AA@mail.gmail.com>
 <CAADnVQL1Zt5dwFv9HPDKDuPEKa6V7gb5j-D-LPWv47hC6mtwgw@mail.gmail.com>
 <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>

On Thu, Mar 07, 2024 at 07:49:16PM -0800, Alexei Starovoitov wrote:
> On Thu, Mar 7, 2024 at 9:54 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 7, 2024 at 9:42 AM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > > Hi arm64/bpf/pci,
> > >
> > > In today's next-20240307 with a defconfig LLVM=1 I am seeing [1] under
> > > QEMU virt, i.e. from
> > > https://lore.kernel.org/all/20240305030516.41519-2-alexei.starovoitov@gmail.com/
> > > applied to the bpf-next tree.
> > >
> > > Cheers,
> > > Miguel
> > >
> > > [1]
> > >
> > > [    0.425177] pci-host-generic 4010000000.pcie: host bridge
> > > /pcie@10000000 ranges:
> > > [    0.425886] pci-host-generic 4010000000.pcie:       IO
> > > 0x003eff0000..0x003effffff -> 0x0000000000
> > > [    0.426534] pci-host-generic 4010000000.pcie:      MEM
> > > 0x0010000000..0x003efeffff -> 0x0010000000
> > > [    0.426764] pci-host-generic 4010000000.pcie:      MEM
> > > 0x8000000000..0xffffffffff -> 0x8000000000
> > > [    0.427324] ------------[ cut here ]------------
> > > [    0.427456] vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
> > > [    0.427944] WARNING: CPU: 0 PID: 1 at mm/vmalloc.c:315
> > > ioremap_page_range+0x25c/0x2bc
> >
> > Great. Thanks for flagging.
> > Looks like this check found some misuse of ioremap_page_range.
> >
> > Note that without marking the address range as VM_IOREMAP
> > the vread_iter() will be bulk reading over IO and might
> > cause hard hangs and what not.
> > pci drivers need to mark their range as VM_IOREMAP.
> > That was the reason for the warning.
> >
> > I'll try to figure out which piece of code missed passing
> > VM_IOREMAP into vm_area.
> > I'm not familiar with pci, so help is greatly appreciated.
> 
> Ok. I think I figured it out.
> Please try the attached patch.

I tested the attached patch on Qcom SDM845 based dev board and it fixes the
issue. So,

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

On a side note, PCI is the only driver making use of this API. If I'm making
such an API change, I would've made sure that the callers are unaffected by the
change.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
