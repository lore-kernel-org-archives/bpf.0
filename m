Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D7D369D4D;
	Tue, 19 May 2026 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779233256; cv=none; b=ZT/COX7wATVoAN0sL07dWJmFS0wS45jDa/b+JQsu6IcR39lEVqHzUhJxqtlh3/A0WW0JO7lAkaOX+MEMQIoTvCVY8NFGUGtqgf04fZ8BrVkSPa574JnHi1NngGamYIjLv06bYlLHuEMgmpwuUObsiy+1LbQkL7Jdnex71dDrSMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779233256; c=relaxed/simple;
	bh=LresoJMBliSTJ0gLRz7zwGGd5xyOcccMyUikDbSg54Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+JGN/GTKfPHrFFU+z3jJuW4pSGl+3JeJ1v7wyozKwFHwVM/VrW6U8fb5cOj8yKajHtAU7eHh43g6u6W2g8nk6re35a2qx2mpM4uYIj+Ej6a8qhxmjgVje5T4myLu2mszoNrwxhzGahB6Y0JY9W2CXMKHNtfnpfBEJiq4o8BZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkEV/E+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkEV/E+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFCB1F00893;
	Tue, 19 May 2026 23:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779233255;
	bh=1NywW2m3p3nUPZKoCbvZovAaBqZYfLm47Ryb2FylT4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AkEV/E+B7HmPzBHHoSXrDI0HXQnO2NLAT79R/+eYqR8VnTsmwMpoSNMM0m6SIK5c6
	 q+b2KcGgbg3D6h02wamjNiOvf67kiF2sSigIdPqJXWr3Y0mEe3qt66eqBlFt2SQpg1
	 JrHTbnqj3zwUCLAyrAydXaJg0Kr3sI/XXIE2Kx1QAmbyJsgmrdlLogD7E1MwUEjIOj
	 Mad/K5esQfFH5VOijzGiZcBtuMc7jPtZorq2o3Qd+GB1lPKjnwUWXIkewVE40ifURy
	 UMrsr8moNhVJXvUxwjts4dvVsyzFbNuz5CQP+rfGzsPaN3Xc4Ta8OCrIPmdsHIpECL
	 I42FxXiCt+04g==
Date: Tue, 19 May 2026 16:27:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Amery Hung <ameryhung@gmail.com>, Martin KaFai
 Lau <martin.lau@kernel.org>, Dimitri Daskalakis
 <dimitri.daskalakis1@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net] selftests: net: Fix checksums in xdp_native
Message-ID: <20260519162733.25114c19@kernel.org>
In-Reply-To: <20260519162651.765cd587@kernel.org>
References: <20260513072355.1083381-1-noren@nvidia.com>
	<20260514183832.5ef205c1@kernel.org>
	<aa818076-6e5a-4b61-bc7f-0bfe3907fe2f@nvidia.com>
	<20260518143138.74839bf9@kernel.org>
	<364bb4db-2a45-4b01-b2bc-1f6fdff937ad@nvidia.com>
	<20260519162651.765cd587@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 16:26:51 -0700 Jakub Kicinski wrote:
> > All issues are pre-existing and harmless, so I don't think they should
> > be addressed in a net fix.  
> 
> Please fix the csum thing.

Well, that's not very accurate. I mean carrying the overflow.
It's trivial.
