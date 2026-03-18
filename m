Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4F3DE431
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846002; cv=none; b=YRZrRoWdhDodt6SwDhsP8rZJsHEFrm3yL0TkvckJZQc5szDQog2nJtskdHF6sKL1B2T0FYPfB22vl7ixb0gJDLcakMGI6r3Xb04XgcMsYvbuK/sOwJy67lojknCpmEmZbC49WBUo27tOiHutTFMJjFlhMpA9NaDRbFUqc2CHInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846002; c=relaxed/simple;
	bh=bEBit3v/3EaAeXPIrEhvLJqSi6H/H8xXCeELyouAkUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFnVfDEeHMZf9yD7+XVPKB536Ef7Qo4QX+/VklozIx7c0+fIOOt8PhCMXyoLTmZmkcIxA6+eYoGed77gmblgOR6QleH5/s/AxSCxOiBOqtedWUIGX4bx0g1dZomR00LebNGapZnU+1wOZNRCMrFHR7PRUbjjt7Rbx86hFCoNRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3+P9n0z; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3+P9n0z"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6b0500e06so8339243eec.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773845999; x=1774450799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GnznBYtreFWiJHMzmWhLo1aMVcwsFyxP3+fWvwEHCV8=;
        b=L3+P9n0zXI//cQ4O8pD4tXKfXA9JJZViwEaz858VcWyAtkmPOPJ1pqP2YR7Y0oZxJn
         g4869r/W9sg9XydsDfbUKDrlgveO8J+xFVDR/w9vdh0p6Qs9vDV9LQItLKx5yPWKhR1K
         cFcLLath8FwNc4Mlk22IJfXScbvW4ghiVIC8bn2Ii51mF3L1c5E2kUKgNrrCxIXMHRb9
         Am7YnncgNsLNa0etUwOVxZSP4wpG+sDRmGX7p+aYo277p9qvCsa6YgpxoFv2+RQ/YJG6
         UVWLQreP+I5Fv1Ma3x9J0YfV3oTzlI5cczqSZ4/GW9oIb7tYBTQWhtcb5A+C2vA/Wy4f
         /cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845999; x=1774450799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnznBYtreFWiJHMzmWhLo1aMVcwsFyxP3+fWvwEHCV8=;
        b=gXbIBDqR45UxdfGWIA2iPr2D19he4Kej9hUgKgIxEorzqgZW17xZGMbrf+Ug+aPtUA
         y7DL5GPhbIDUfP6CQpEwkbGUgdH3rPnjJFK7ptsPPNxFgShSajRXo5+FMRShMSHMERH6
         O+Sz5pOISbGKNZhiduSfplgWaeW09YhmYcMg133gA009bLy3W0YZVwOOIWzNzzX9/+Yx
         Q2KwbTL7ChLJ0k1UlRy4ETQd+RqgQU5PYN2C6APrYngD4DJRV2NgFg6g6M8Vfb9MBtEq
         x7NJk+ei2hdAOI2TtDc14QL530Rt5AZm5ZSnLTeGd4UAAujiAj3ocU8LLFEbNn3fiNyZ
         QNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5YP2i28H1gOsf2LA4Jih6cOvh4TOUdWfK4Gojdz9b99IjUpLattZzggR5Wl4n2B+Oe+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZ1L1ofRuistsgbzqGko7Q01vrzgMWPfkpRf9442X8UCeypjv
	oOCC2tAxxglRkhUATausYXpRHIGsMQDqWrPDuZo7tylYxOAre5XOZ58=
X-Gm-Gg: ATEYQzxPZus3MGAT9/H0Hf8lTfM+904c58Urqgl9BwJwL092sa2Wb7SEsv7KWDbc8Li
	RVCA9iEmoVQbf599pA7DGh4KOgf0lQx/u23Y0hTSz8iueZTZ7Nf9tx4AUsjvAD8r4b3Et9J9Eg+
	FgMB5c57mzzpYkN/Mhof/Ex7v9Oic52Ytykjbwnfsf7ufdTOKSF1thv12ISkX90EHwYdrHKd3yS
	LeglLcH9Cxn7SB0vLvEZFIpkLBq17XFq0I7uLvS4sToztVdNelJs9CdVoBrxH+C4xmnwVp6dYam
	xa+9kDKHRzk3s5SMVWhAkbB85kn2ZzfpqOI71iU41IO1v/8na4yjucI5vDZRSkpgnlzrjX42S6k
	Kk01Ppf93uJODWVJeVAaRb0lBLLg8euleyPOZeV4S9s2oSVp2u2ipzdRsJiuRN0ttJE36xDKXmN
	K9KWL+e7kVwxMOz4Z6nwNHIRDFtbcc4G+bKFAoChHluXsV9YmytTf1rclZpzXyIoQi3LKEj/Sbz
	G6zZ8cPTZ0tPhDUYg==
X-Received: by 2002:a05:7300:ec18:b0:2c0:c415:cfd6 with SMTP id 5a478bee46e88-2c0e50a0a8dmr1648662eec.13.1773845998562;
        Wed, 18 Mar 2026 07:59:58 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55a489bsm4388531eec.23.2026.03.18.07.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:59:58 -0700 (PDT)
Date: Wed, 18 Mar 2026 07:59:57 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 5/6] selftests: drv-net: add netkit devmem RX
 test
Message-ID: <abq97UD7CHR7bdod@mini-arch>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
 <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>
 <abns9COj7WagFtZ8@mini-arch>
 <abn3rJGXXyDYSNzA@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abn3rJGXXyDYSNzA@devvm11784.nha0.facebook.com>

On 03/17, Bobby Eshleman wrote:
> On Tue, Mar 17, 2026 at 05:08:20PM -0700, Stanislav Fomichev wrote:
> > On 03/16, Bobby Eshleman wrote:
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > 
> > > Add tests for devmem RX over a netkit device with a leased queue. This
> > > is the same as the other devmem RX test except for ncdevmem executes in
> > > a namespace, binds to a netkit, and skips the ethtool NIC configuration
> > > steps (relying on the test runner for that setup).
> > > 
> > > The RX path is setup as the following:
> > > 
> > >  RX Path
> > >  -------
> > > 
> > >  Remote            Physical NIC          Netkit Host        Netkit Guest (netns)
> > >    |                    |                     |                    |
> > >    |--- TCP send ------>|                     |                    |
> > >                         |-------------------->|                    |
> > >                       dmabuf                  |--- BPF redirect -->|
> > > 
> > 
> > Is it too messy to parametrize the existing test to run both with and
> > without the namespaces? Feels like should be somewhat doable in python?
> 
> IIUC, we could have main() do something like:
> 
> for env [NetDrvContEnv, NetDrvEpEnv]:
>     with env as cfg:
>         [...]
>         ksft_run(tests, args=(cfg,))
> 
> 
> And then the tests could call helpers that check cfg.netns to use the
> nk_{guest,host}_ip6 addresses when true, otherwise use the regular
> addresses?
> 
> It should be doable if I'm following your drift.

Yeah, yeah, this plus some small changes here and there (to pass your
new -n in the netns mode for example).
