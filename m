Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A747F2C8;
	Thu, 20 Aug 2026 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246150; cv=none; b=My8Sf5tTamq+yC9MP8PtRU8WpWuqhytLdPRLDOIMdCbf6U9+iKg134tbbl7wx1yPBQFadi4KBCBGp1grJEZgoOSHu65uhzobe8df/wupM1eE+0m2G116nq/utDmBTcBp1/ZXSQ63J50ZYjR4cfM1blH8Xijw2VR4r72V3B4siFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246150; c=relaxed/simple;
	bh=1e6wKhw1CG4ZfPd5rw0354soRsVciSGiHI/FONa2Fos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0YoM8mAN4VUiZe4wrLOfeIC+DgjkDBkLyMbdSmKrPj8isaL+JZxviSZmiXoI7y2GvIyByIxF4LPblK5O8G6CeS6pAFcq6jU0Bu6ptWpmjhYEEqmtTKGc9h2zVzDCFn8AIHqk8uWO2QT6EHeGuWJFvE6zGdvRpN3QN35vPfuScE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJMQg6NV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJMQg6NV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B677D1F000E9;
	Thu, 20 Aug 2026 17:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787246148;
	bh=GBEUXij3saIoo9mKJC4Xzqpeo4qm1AjJczyu6HrDWtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EJMQg6NVkSZ4fwmRxIpXvnXb65ziJRbLxHdtEsfW5SvEnJ83i3LMJDpu8PoEx84ww
	 GAITmyH+sEG6ax50Ff1gC0Cf8/d/LjUABOSmLh1caHYkzKV5nP2ZnngcW8WPby/Ag/
	 FbEzbeXmOIE5FDZABRkKUkevJfPwXm0tVJzwkIStVfMCtttrs6sQoFdXP4lXlqhHCH
	 9jO5wCuoNhj1AE+8bm5s9hLRhBNx8vdR0YQCTovjFSssanbSiUYfsjI74tcNNOkGCt
	 ZgiSuzrE3PAW34AKIbVmFIPpm4JS3/PUpFdMEfg0gCTBsooQetlzXIXP8SlZqgRbZa
	 9dwg+HsI45atg==
Date: Thu, 20 Aug 2026 10:15:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <pabeni@redhat.com>,
 <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v9 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <20260820101545.2c1c6199@kernel.org>
In-Reply-To: <aoUZWdZ2fy8rJUkM@rkannoth-OptiPlex-7090>
References: <20260817032747.1765883-1-rkannoth@marvell.com>
	<20260817084212.5d46a501@kernel.org>
	<aoUZWdZ2fy8rJUkM@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 08:17:53 +0530 Ratheesh Kannoth wrote:
> Resolving these pre-existing and error-handling issues from sashiko (see below table)
> will require additional time and refactoring. I've added temporary TODO
> comments and debug messages to track them.
> 
> If acceptable, we would prefer to re-submit v9 and a follow up patchset to address
> these fully post-merge of this patch. Please let me know if this approach acceptable you.

Fix the bugs first, please.
