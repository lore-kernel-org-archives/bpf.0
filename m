Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60CC27732;
	Fri, 13 Mar 2026 00:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361842; cv=none; b=tjv675ThceMji/rA/kPdgKrE8fJW6dlZVdaSh558pJH4uBuB63aFhDckSZ36thJ0oX3zPTe9QLODruyDxUkzEFbZ5fMRH2vCktiqEI2I827dt7LMQsylhOeIrb7NF7pCQtBD9WmNeBd8UOYkglYP/xMbK565Q/fJOT+fTK4hUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361842; c=relaxed/simple;
	bh=jPBjmC8v3oCh3buzBC+OKyJfHUjkqON5IH8jJionL5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uziSEY2n7JRHNz3MgmCRrH5bGMdN6x4ivYaqROjCLbeJFlwWRo9r3Xif3ftqEt1Q+INXrJ/VYhfgZmVaXWTiyVRi4fDuKleB4GQjRO93P2rttvUdUtGqF8YWLqV7SJnO616xSiieGuMyBmmrldMB+R4Huckbr09dPX2WX25ATOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHogtIIn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHogtIIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEF4C4CEF7;
	Fri, 13 Mar 2026 00:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773361842;
	bh=jPBjmC8v3oCh3buzBC+OKyJfHUjkqON5IH8jJionL5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UHogtIInX16RjBKUao/wjaYuYAW4Cg4jk2dFhmm1jw6Irxjkj8r/p7ZeOPTEsAgwI
	 ugPHsc5inUgT2oZpy35AwxooPnlz25M+maOXm3ehSZakNrxKbrMtJZLXawNwnzUsbQ
	 SWbEVZwkgQocfhL+iEkbw2DhCmhePBD48077a5KNzZ09cGaRvFov6qHIhMPN6tsj3H
	 FG6MF7ErXRHfsv695eS/69pvRhv67CDXSa4iVAoCilrc8uIXfrPHye4wvkfvsqvyzQ
	 L4T4FHl6EuM+lCQ5fPmp7zHm2jPN11u1FcQVdF4US5QzAi/P5/lpu0PTO95Vfo9hcJ
	 ZwN3W1F5phl8A==
Date: Thu, 12 Mar 2026 17:30:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] e1000e: add basic XDP support
Message-ID: <20260312173041.36bbfe4e@kernel.org>
In-Reply-To: <20260312183817.104878-2-teknoraver@meta.com>
References: <20260312183817.104878-1-teknoraver@meta.com>
	<20260312183817.104878-2-teknoraver@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 19:38:16 +0100 Matteo Croce wrote:
> Assisted-by: claude-opus-4-6

>  .../net/ethernet/intel/e1000e/netdev.c.orig   | 8529 +++++++++++++++++
>  .../net/ethernet/intel/e1000e/netdev.c.rej    |   46 +

Well, I guess this gives me an opportunity to test some new patch
ranking features..
-- 
pv-bot: slop
