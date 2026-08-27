Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B13E6DCA;
	Thu, 27 Aug 2026 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829528; cv=none; b=GE5Jnp+ti1JTXBN7CPKH1GwXuaJFAN/6HfDD6sZ00XvtMdxloeL9QhRCD4zRskDBwb+LuFks4YsUh9XIWLpyFCQSWW4ysa3t9AxI6UR4mBfJpAOO5R1cZxT7sfnWyG2UwCck8AGex4IQ7ELjeqGjpADawFlq+2Yjg6YPhyi9two=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829528; c=relaxed/simple;
	bh=l96QKR1qSNS2rRA2a0GsZJo3vHPe31giO0jIcFVZ3zQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrNJ4ix7EIJNxOWOF4EYuGHjOvGchvrgvnNyoxveTg+3/8kRMN7wzIxoCRuRMyMyF7PaAc2QJt0WdBhWvZZzIqnn7mUfK9sFxt2u7TZ/n8B9ux0T0zyzcSkpwMdzFL6DfGu2iFSLKyQ+Zsy5UwLcWNrv1I2Gme8/pkPFw4aUIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Yu7H2B2y; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Yu7H2B2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787829525; x=1819365525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l96QKR1qSNS2rRA2a0GsZJo3vHPe31giO0jIcFVZ3zQ=;
  b=Yu7H2B2yOapM7Gr0BxIivhcnO0ORQnZPCt94+dqsDfRdqfvmUpAvLll2
   wKZFfC9BBVeHp0CDfplka6MmF9UoDdZCW4X70jvp50E8objD9qlmqu2Wv
   Hed+rWv1hQkzzXD81vV1OF1FjXtoHO9i078UUrGsSOF84rbbI6BRgQL9K
   9Pje2Ptwve1eegrSpATba9MbKHjT8q8XbEA3vQyPTWcG13TRMlMYDA7my
   8JgJiW0LAjHv48PpJbNs9NfOaiC5zsR9JCvYSF96rwJHCFgXoFzyJKFVB
   6VF3rLiiLGaEVQepPfxaexMbUEswEX+bsid7C1ujyVPcgcTUgwy933NiF
   w==;
X-CSE-ConnectionGUID: QNjRJ1JeTdO8OgG6Qe7F9A==
X-CSE-MsgGUID: NdHPSxSJQKaOue0owqLo1Q==
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="229862350"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 04:18:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 27 Aug 2026 04:18:41 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 27 Aug 2026 04:18:37 -0700
Date: Thu, 27 Aug 2026 13:18:37 +0200
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
Subject: Re: [PATCH net-next v5 12/13] misc: lan966x-pci: dts: extend cpu reg
 to cover PCIE DBI space
Message-ID: <20260827111837.2mjyx6sicuxseq6g@DEN-DL-M70577.microsemi.net>
References: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
 <20260520-lan966x-pci-fdma-v5-12-ca56197ae05b@microchip.com>
 <20260522190157.02e1e3ff@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260522190157.02e1e3ff@kernel.org>

> On Wed, 20 May 2026 10:12:24 +0200 Daniel Machon wrote:
> > The ATU outbound windows used by the FDMA engine are programmed through
> > registers at offset 0x400000+, which falls outside the current cpu reg
> > mapping. Extend the cpu reg size from 0x100000 (1MB) to 0x800000 (8MB)
> > to cover the full PCIE DBI and iATU register space.
> 
> Are we supposed to take these to net-next ?

I think the original dtso was merged through soc (maintainers are CC'ed). I am
not sure if you can merge those two commits through net-next? Happy to clarify
in the cover letter that patches #12 and #13 are to be picked up by SoC
maintainers. Let me know.

/Daniel

