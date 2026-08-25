Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DC3F0765
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695630; cv=none; b=qzph/BRQ95E/9CLF2O+sNDLl54RdLnAXkaSbfCRdDBu13xKLqojGNVf9mjjkZJkjEOxDYAqEYInnVy6OPbSLtN4aG5F9fKKOhTr2hxSqeYFKZIwLgZlzqGshUywYkR90V5Z7J52mBXdOAgKsQ682oiNW7gYKalZePoPPm2O+8Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695630; c=relaxed/simple;
	bh=63qI2K79bcm4cDczUBl3jeHM3xipML3Gz7DLpnr04Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Het3t4PBfPiOWDNr2l2wF8a36/jA0PPVS0dQdnlUzFSnUgystNMyMdR3ey2PMWXpZfvkt1bZIX+WxdTLPWdyoq/E+felebYAXVtO0HeB0ke0tD+RH3gssbo60t/onVcBKgujBFe97qRJi+dGVgQaCfIU4VAoinKecr11L+OEN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd59fMiL; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd59fMiL"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964deae8a7so129494a91.0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787695628; x=1788300428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E2HRqo0BNmOG+wvSL71FMHVkpYIR+F5v9R73Mp72HJs=;
        b=Yd59fMiLkFIJFSaPsIB3sDLIkOhLNFFSJ2OohGDo2kEp+Mb7bBfjkPhbYzXsKoDtEc
         FaYfC+TL965X0LUTYCDhIDa36EfNtR9+jpwimN1ufte8eJSU82m765RVGEXCcLF1iNvr
         +84R+0SeJ0oEC8f0mLCRlZ/PFjelJ84y3Iw0SepbLLH7NUfwhNK2Q4Pmtmib1bhF+aE5
         4awltP8HYAr1IldJ4ip5GO8ANpYtn8dq4nAXzbPufhc38milbbM/HQh2hrxR0QsEwD8G
         Oye1PCF41GB17nFHF1WxRpSFCg1VH8tHC+XWKOJ00JSEJiy7F779FWtSYWPw90kn/ViJ
         QCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695628; x=1788300428;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E2HRqo0BNmOG+wvSL71FMHVkpYIR+F5v9R73Mp72HJs=;
        b=T/FCz7NpdTrDccKA8tOThbBt9SlvjrdR97C5yg8E61xRU/lFAaxWzYFxrWo9ANXphS
         hAGisazieuTLNZIZG/2/UYPO2U/qdYs4fscqD7Wqm8VBbWFkEuGzO1MqFYcDU1SJW/vB
         5f+sWV8xQaESK8MawTUXiVJ/jBmeoa2ApNrROvdp0CcDwPJg68LzpevxnbsEittblL5e
         uGg3bM2F8n09+TIPOOP4uJSpOuECVWZWUTO/OrYVKsuShOS2iDJPXfVYkLaj5xX5uyx8
         zfzwfEdHZL6MUDbkVo+ePDCHUExugDQvY6AalFG2MQwH7+VsSz724EocDtp4be2T3trp
         /0+g==
X-Forwarded-Encrypted: i=1; AHgh+RpEMIAYODnKrVoIBAc0zNcGFYtrxHdRjQ8pgWle2CjD5Y6CwPsxOQs5p/yHFxoOJQzavN0=@vger.kernel.org
X-Gm-Message-State: AFuF++nq6B3lZv8sB/EHXK/HRcefEmyTBp9Keo0CsrtLXBuTEtxqti+R
	s+sE8Op+qu79rkkldbRMXB02qOmsFflzYdK0YFttYTaWHpcRn9jt0ny2
X-Gm-Gg: AR+sD13/hcPLGXlROOKkKbR/IaQEtxlUUg+eTknBrVMtGJXbyLc4oNHcaNEKDkt/Xan
	2UzvOR6nKBxZZSK7m1SIg6JKQ5J0xPJ8pilLhbXcRwi1AYZJxPu7NQyKYbH8G0cRAuA4TLVcmpb
	l6wiV+rrtq6rhXzpztslTPxV4FaoVmILyWpe2P9cwQoKn3Z1umLzSyQ5GykZ6jOc+W9R3Iuk948
	mf0Z8QVVMYM2JBxRgGkSEElekn3RWSRg8sVqCoXVknAdFhl7m8prb2ZiTZxd5UMgn00VYNwfZRR
	E92OYA4V+lViiWnsCc0c09WYy7HKmaZQC4f+Y72+9sgOlry6s7GqvAG9Xir8hD9afB/XnZFwYEb
	00qXmhG8l507JoyXoq0JqTNv2FXcPobLFivZMYYRA86lrImi0IWHKkQLqOCT2Mbh2qbXNVE1iAD
	Qe0bzFy1aWqX0o7X/fzGKwyaWmwCE79RCLqZ7iw5HXm8+E7vg8zYrh9NFcz0MKNbR6
X-Received: by 2002:a17:90b:3b4b:b0:381:11eb:d78e with SMTP id 98e67ed59e1d1-3966d8b6295mr4351538a91.14.1787695628197;
        Tue, 25 Aug 2026 15:07:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a57396sm1314425a91.13.2026.08.25.15.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:07:07 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:05:46 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	guoren@kernel.org, dtatulea@nvidia.com, witu@nvidia.com, martin.lau@kernel.org, 
	yoong.siang.song@intel.com, intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, linux-csky@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP frame
 handling
Message-ID: <ao4RsulsnIEMOmiG@devvm7509.cco0.facebook.com>
References: <20260819160535.1472459-1-sdf@fomichev.me>
 <20260819160535.1472459-4-sdf@fomichev.me>
 <aoceSoSFMx69Z9up@boxer>
 <aoeoJ6-njBxcWs4w@devvm7509.cco0.facebook.com>
 <aogpDsa8hz6CPpD3@boxer>
 <aoiIarzdjk92RkCN@devvm7509.cco0.facebook.com>
 <20260824111443.34bffe04@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824111443.34bffe04@kernel.org>

On 08/24, Jakub Kicinski wrote:
> On Fri, 21 Aug 2026 10:28:47 -0700 Stanislav Fomichev wrote:
> > > > I do agree that a better idea is to probably do these checks during control
> > > > paths, but it's a bit more involved (and not sure if it's possible? if we
> > > > have a bunch of xsk sockets and we change that max_sdu, do we go over all
> > > > sockets on the system somehow?). My main motivation with this patch was
> > > > to make our LLM reviewers less chatty about preexisting issues.  
> > > 
> > > I hear you, however I feel like we do not know this driver too much and
> > > probably we don't have a HW to test out such changes, so maybe let us try
> > > to fix existing behavior?  
> > 
> > Let's definitely fix it properly if you have better ideas. But since we
> > don't have HW, I'm not super confident doing anything sophisticated
> > myself :-D
> 
> Let me take the first 2 patches and leave the stmmac for later.
> I don't think anyone involved care particularly deeply here.
> 
> Maxime said he bought a bunch of relevant HW. If we finally wrap 
> the AF_XDP tests into driver runtime he should be able to help us...

Sounds fair, thanks!
