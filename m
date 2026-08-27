Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EF40682C;
	Thu, 27 Aug 2026 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823502; cv=none; b=sBcrbST3wCq2wLaDtkNEAw6Qoyv/ORISgJkfbkmcvk2vFVla3shcGb+qijpcMnEW+4pe2WmmyxSug/DVIPVptgpAX2srYJ3YlcIp54VwBIyq1D+xDNLdH/K0cuIJ/7MV5rUMrDr9VLKB/hVc1QColTiS3y1NP9T7HmQQGgl/Il4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823502; c=relaxed/simple;
	bh=e81a7B7e6BAfdUxEoq1bxfDYdozfWoLcX7ktH1Mvil8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnj6fKZ1vz0q5PdLxhSD7hVQJnBjGDRECtPy2yDl86PmYTRe3MkBjoUvn3M9chZp7rF+vz/qPq0eDChaf4Ao37mv9k+N6L4xfrZ8NnLBMqW0bDX4tb+6GCG247wxuAN9rElP8OmmRfYZ7mzs2t5C0DlQQQKvlGFO+UYDaKpWsGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NiYRNw1S; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NiYRNw1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787823501; x=1819359501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e81a7B7e6BAfdUxEoq1bxfDYdozfWoLcX7ktH1Mvil8=;
  b=NiYRNw1StKxMIxA3He8PKhz7wKGof0Y/236JpPwchM3x4CqK0mFsASod
   Dp0gzQ+xNr6KVHKjCvsaZ3y8QBxbxyHUjfAMuM9mnuARfaNQGPAjn/27F
   rXtiWdqdgum20VBXbpFQaUQv7F0KRJQyyK5fzQBSNjsyIZCI8aXIYQdFl
   iKMmP6ECvQ2JEEbp4M0ga2pU9zfstwv+/cH+6Z0P3KH/AQNSNZ8bACA5E
   eV4iINfHe4VMCEPKw6El7UjnXFH03tk9m06G/jyCWR4GRt3AandtmwwI7
   /EvNpfA6j4BCenhThxi4+bTMob0GxnZOSA5HBjWeDLYr8/KYkVCN3vz5K
   w==;
X-CSE-ConnectionGUID: PrlgIxWMRKCL5XyvObe2DA==
X-CSE-MsgGUID: 7V1sKLlKQhajAyfDsq9g9Q==
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="61841232"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 02:38:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 27 Aug 2026 02:38:08 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 27 Aug 2026 02:38:04 -0700
Date: Thu, 27 Aug 2026 11:38:03 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, "Steen
 Hegelund" <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Herve
 Codina" <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v5 08/13] net: lan966x: add shutdown callback to
 stop FDMA on reboot
Message-ID: <20260827093803.nhsmd4shql6hk75a@DEN-DL-M70577.microsemi.net>
References: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
 <20260520-lan966x-pci-fdma-v5-8-ca56197ae05b@microchip.com>
 <20260522184545.43e00be3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260522184545.43e00be3@kernel.org>

> On Wed, 20 May 2026 10:12:20 +0200 Daniel Machon wrote:
> > +     napi_synchronize(&lan966x->napi);
> > +     napi_disable(&lan966x->napi);
> 
> Why the synchronize() before disable() ?
> napi_synchronize() is a simplistic disable() + enable()

Agree, the synchronize is redundant. Dropped in v6.

/Daniel
