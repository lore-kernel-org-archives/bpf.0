Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9FE2E6CC0
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191890; cv=none; b=D1xhDzh/1XvQ3oTK0ngUWsMI7k5BCMLGNCcMOFWd0OXo0IFTTJJ78j1txq1BwZx5WMzT1Rv6tzsq4roqdIDHdJF7fPz/rhgyq+XT8ll0RRgX57js/UQyMIGupbgn7rDPdlH0H4qyKvjRp5g0ycEIki7fteRV+XzeNijkGSW5flw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191890; c=relaxed/simple;
	bh=kjtrSJ6uJd2eJjgC6tROlR2H7ioS6iZD6j35sFeiR6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La6+AYfiz50bDpBqZelP4UVOmbREoJ5a3yuj6LFxpcw9jQmwH489eC7mRmbHZ0Qm5OPxamchO3L091tOQynuau1YuE64pWWZsAwHfYNaz3WhDJvfrXUIZqP6UpuT88vA9B4eIGF76dw1darIj0JM1BQazpyTfBvzHWJtT2Y57rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pL6p/9eK; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pL6p/9eK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=V6qZ4+ninNEgXa5X2GFHT3e2zs661Phk/DWVMeldBpI=; b=pL6p/9eKf8yUL0AolwibMjBFkp
	ZeaBk8uhQJ3mPUjNMZfYYD7r30MZM4qPccDviSnuXqPMHTcMr8LCgKevIPkJobJdVOt3sMZ9ZsdwK
	iAJXRSrEhHa1CaM4wPm0LWwhZqKJm+pXwctJgK0qs5K/AmPonO8cuB7256eJv6SHdgL1mlOp1fisA
	h34fNLeZmUsxfXHEcO1Aauk5AKmQxS9zvUBEpXx0ThGsHHXpfDIkRvrZrrzUp2iA4hsKMeAIfzef1
	CFTqWDOX8+fQlJLUIGO7Cv/lgA2T+iTBBn1eaSC7Zbe0eGCIW/LgLUrMyuC4UB6SX3oy0bUSDnSAs
	mjhIpaVg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkHoP-003hal-1Z;
	Thu, 16 Jul 2026 08:51:21 +0000
Date: Thu, 16 Jul 2026 01:51:16 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, martin.lau@linux.dev, 
	pabeni@redhat.com, song@kernel.org, liamwisehart@meta.com
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
Message-ID: <aliZnM1dSGKQEASf@gmail.com>
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
 <20260511085344.3302-2-mahe.tardy@gmail.com>
 <20260511182019.69ebc7c6@kernel.org>
 <DIGBS3WKQN94.1YYMZM0K6CETY@gmail.com>
 <20260511193603.3ef00cee@kernel.org>
 <DIGD21MXE0XM.3CLUL6BVK74PK@gmail.com>
 <20260512065335.50647ee9@kernel.org>
 <DIGZA9DICBXO.2QQ1V7T186JW2@gmail.com>
 <20260512163255.34162f1a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512163255.34162f1a@kernel.org>
X-Debian-User: leitao

On Tue, May 12, 2026 at 04:32:55PM -0700, Jakub Kicinski wrote:

> I think you may be overly optimistic on the dependability of netpoll.
> Rik has added support for serial scraping at Meta because netconsole 
> misses a lot of crucial alerts. And I can confirm there's a bunch of
> errors that appear in that dataset that are missed by netcons.

Unrelated to the discussion above, I'm curious about the nature of these
issues. Are the primary problems related to try-lock failures—where
packets get queued after failing to acquire the TX queue lock, then fail
again during queue_process due to the same lock contention?
