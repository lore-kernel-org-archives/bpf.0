Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88243DB311
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394008; cv=none; b=RKaBCV+B2/ey4P4BN+rqIKPPwz8oQsjZa1EN7kI13vACeenviTihSeVJNsDBBFM3hJrdxz2BSPNNBEtNn2Q5IeLEUJam+qCMjVczQSiXiRQTdxzn9/dIrDHX2LZNBlefw9gNl41G0nCAf0IYdsyVFp02W/ER0DGNw1iAwtGvAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394008; c=relaxed/simple;
	bh=swuno9D7K1A4nv6Mxj/FFqq6a3u/tMKfvC+iHoB999E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzLV2j4pHPcwqea1fKGneyxjwas7k8/FmshlbI9+TP5eohJp4T5qoTpGX29FXg3b0d6PLsgklvq2cQv1SGfY5E0B+Z6EBfmdu3JA9o+FPAmAjaqez3QTU8tYD/YT7FMixySRioJZcEXGfSz61hZTeRgfYbZXpmX1YmZt3SFb3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/8fdiE5; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/8fdiE5"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-3a4883304bdso1126890a91.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791394007; x=1791998807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3tm5BNWgpkJffRSGEsUTNvIFSNGIsrYOIofDXmnoaQw=;
        b=Y/8fdiE5RBNJrmhZfC6IhUClZpGLZv7ZPxxkHfoIbWR304ImEsc8sd9qFqWLmkx5oJ
         AxYtBGOWKU14aX9RY/n+AIT2WheFTesfyxCach2K+3TrcbbZ+JA3a8JyiTBHGEt9iDls
         AbZCKlVfm2mMCtCSuDZfit2DBJbum8KJ8xhiKmDMQULjsEDxCb712IJG1XJRY/c2jEIT
         FKujW9pqeZpDtPthnQBp8RFNIUc/0I0xsIJ9jxu+2aJYOvHGNP0i7nZBEnmXlEimRWl2
         m9LE+heu4l7KSyWth7udRyAWNJh7DYyxQShr6cCcCl9DnfZMV13SlBuUDf0yluAJRsjd
         yKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394007; x=1791998807;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3tm5BNWgpkJffRSGEsUTNvIFSNGIsrYOIofDXmnoaQw=;
        b=yKo8RLwPOYj5zUo0gcTP/HS/x560B2oHgP134Csb4xLaeCGwUIMsauJhNfw1S3X9oP
         6I4cePKJEgEzsXE//IPsWYCDBEHI7q+gpvpgLUNdizYJgzaA0MJDPmDwGKTiBE/LTQjz
         Dy4JFbsO7pT8Idy4zAzFFNWLDxpUAFnDUVy0MbE7jUUkIUOMc/cDnnpCuY/N25Qg6xEk
         0i6VDcleWG0z/nOUt1l/2py2lZHyAgpI3chhn+gwyRJ8vMX05pe0DPMTf2/YC53WiL1v
         AlMSYwH4lYG9fijgh9yv1ggi2VbU6HAifK5yAO3QD/YO+4cxCv+FHXbH0sCvmaKMOUVG
         sM5A==
X-Forwarded-Encrypted: i=1; AKwUvBwOEJBDrjybvSk+7H2TpCtZS9WJoVoOHeje9gLakhzcvGXSiJXupM/QTItrIoifJfm6W7o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLt+UcCHKZGoKI1+Z5oo2vxbQFJDyH0ZGUoGUF9o4xk7t/hccoE
	Z33lxl1nG6aGtoaVEYO2dT6doU4luZd1uxNYhY1nfxsCf9xUFefXO0uG
X-Gm-Gg: AYBFou2ZdJTzijkFTNWBCWSySn12tebwHasSUQVB4TTT+IyasnlrVTR9EeIbjnwSCzl
	uDNzkQsDKA781Th8rjCygHAYT0QWcMcBmKjVkL+AypKiLSrwSCYL+8cGjfTjk0fNDB90qc06LbO
	xprNUVpTFkroG6eTnufCDmqrmyQBJftbXWQ/PIO1i8cwybwBxyt9OnOQZgLaOyWe3IvNBU8ZRjC
	ASr2MVJ7ZXH2NYVxKbOqySkfVzKjQJQbMcWCcq34VC4y1Cp2EqLZHfkXjdBvvASlfehVY6+lETy
	Ua0r4TK47AGWL32ADHtsLAJnCHEtbZqM6R1itoH9gkHSEt7OKYwiF7bJZ1bOkuBmxJH4DsTfqLZ
	m1xOgBB2kTQRrR9QMpRMmR9HTQ3zXac8irIZYbhmfPbCY9vjrOwB/WXjKFa9xsxphBaqJeqD29A
	e7glm53mghKkJlgfLGVcZcjd7GPMItPvVDTf4wWYRk1KN0AhFdM+MXBEYXmS1BGoLg
X-Received: by 2002:a17:90b:44:b0:3a8:10e2:ad05 with SMTP id 98e67ed59e1d1-3a8a1d521a8mr2509566a91.50.1791394006786;
        Wed, 07 Oct 2026 10:26:46 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a8bfd740sm2028586a12.5.2026.10.07.10.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:26:45 -0700 (PDT)
Date: Wed, 7 Oct 2026 10:26:40 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com, 
	kerneljasonxing@gmail.com, bjorn@kernel.org
Subject: Re: [PATCH net-next 00/13] selftests: net: migrate AF_XDP test suite
 over to net
Message-ID: <asaAkGZOEqT3MhOm@devvm7509.cco0.facebook.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
 <asPlpJdawXNRAGAR@devvm7509.cco0.facebook.com>
 <asUzHc2Md9qu8Hx5@boxer>
 <asVwEyCK0NR4AwE9@devvm7509.cco0.facebook.com>
 <asY5bpkHoqiX7rxk@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asY5bpkHoqiX7rxk@boxer>

On 10/07, Maciej Fijalkowski wrote:
> On Tue, Oct 06, 2026 at 03:04:08PM -0700, Stanislav Fomichev wrote:
> > On 10/06, Maciej Fijalkowski wrote:
> > > On Mon, Oct 05, 2026 at 11:06:52AM -0700, Stanislav Fomichev wrote:
> > > > On 10/01, Maciej Fijalkowski wrote:
> 
> [...]
> 
> > > > > 
> > > > > 
> > > > > Known issues:
> > > > > - Every case pays for process start-up, XDP attach and detach and, on
> > > > >   hardware, its remote commands. We used to configure resources once
> > > > >   and then execute the whole test suite; it doesn't seem to be
> > > > >   CI-friendly and it is preferred to have each case's resource
> > > > >   management separated; that on the other hand increases the
> > > > >   execution time of the whole test suite.
> > > > 
> > > > [..]
> > > > 
> > > > > - The XDP programs redirect every packet, so the link under test must
> > > > >   carry no other traffic. SSH and the control channel go to the
> > > > >   REMOTE_ARGS host, which has to be reached over another link.
> > > > 
> > > > Will this work on NIPA?
> > > 
> > > Yeah good that you're bringing this up, I see NIPA has a e810 setup within
> > > same machine which is not what i tested on my side. This means the
> > > assumption/requirement of having isolated link under test has to be lifted
> > > as e810 cards on NIPA will carry management traffic via same link. I'll
> > > add XDP prog logic as you point out, thanks.
> > > 
> > > I also hit the ice bug after connecting interfaces within single machine
> > > which was hiding from me throughout whole local testing, during RSS update
> > > where we only want to touch indirection table, symmetric-xor hashing was
> > > being turned on which caused later rss operations to fail; I'll post a fix
> > > to iwl-net and include some heads-up to v2.
> > > 
> > > > 
> > > > I took a quick pass, nothing pops us for me. The only thing I'm not sure
> > > > is the bpftool dependency (whether we need to build it or there is
> > > > something on the system).
> > > 
> > > We need it due to skeleton usage and other change was also utilizing it so
> > > I thought it would be acceptable.
> > 
> > No, no, I'm not questioning the need, just not sure whether we need to build
> > it in the selftest makefiles (like bpf selftests do) or it's ok to use
> > the system one (if there is one).
> 
> We could build it within makefiles as a bootstrap. How about that? I am
> not aware how much of an effort would be to provide system installs of
> bpftool on CI runners, so maybe this smaller build would be acceptable?

Asked Jakub, looks like those machines do have bpftool (not the most
recent one, but we don't care?). So let's just add that missing
ingress ip filtering, rebase and retry?
