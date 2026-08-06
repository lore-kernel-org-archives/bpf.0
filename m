Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468647ECFC;
	Thu,  6 Aug 2026 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031503; cv=none; b=FVTNgkL1j/OISK5fYdn+hrCYFUFOAASjcUtqCx+SMtV4HxKv4FCbXM+gvhg5Iq8dWOXQ4X/SQ4Bqgdy6DQCE5GHRw6I+Lmj7F/qF3SwPnZYuc2zEa3/Ja56utLYA9y65Kq0ZNQ2KybsNAMMsK68Wil5Iry/gKrrDc9fDilo2zHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031503; c=relaxed/simple;
	bh=DHAMDofy0v0ZcqdESb/mXHKqW4bQ5ymTCqmmDZZ7XaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSwuO3VDkdlaKL4s+sbCiR5SblrZeqpMtMzhUCA/K1Og05hHMdVWdeaNICDtDsROIyHfku8AucrJSwJMsm9s13ll6jdRHrYn1dYTD5G2aSbKgS4793RQl5Iu2JcdVCrDfiMvA2viDl/FInIpEmv+RroPeylQ4yfs3eY181k5z70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0ElQMtM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0ElQMtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE2F1F000E9;
	Thu,  6 Aug 2026 15:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031492;
	bh=MGxT4UPnXoxBFzlEBm6kLfvcvlPDQNH9r2avYAVzCvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I0ElQMtMJ3PRcviykZlX2fLUJvVpLGQojBhk77L7HAoWWZrgM8dmmdS2ux3XOxPes
	 5JtnKTXZLCDJskJM1S+CClOQeD55mg2zspELI5+pLGeUdU2AZlq7F0LTldGZ5mIQX/
	 lbfFiSunLr8OXsZQFQk9uAhxkU7WnaoosfnUZwY4Phr6QdRewE4rja3t4fXO3VSolM
	 oiF+h2OHLbf0cne8Sb60u9e7l2z/y5l4JVhhAA81qr2gcqJJLryPVvccDD+pNJb3JO
	 hIBUwIDPBFOJwlavr8rsV69XJkJWI0h5ZlRDhmy4vNR5/To2Fnw/4t1XjQSMBX0Ax+
	 RDw8U1Xsf6HVQ==
Date: Thu, 6 Aug 2026 08:51:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Andi Kleen
 <ak@linux.intel.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: net: reuseport_bpf_numa: consider
 cpuless numa node
Message-ID: <20260806085130.46d9e676@kernel.org>
In-Reply-To: <20260803014214.80748-1-feng.tang@linux.alibaba.com>
References: <20260803014214.80748-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 09:42:14 +0800 Feng Tang wrote:
> + * error (very unlikeyly) happens during the libnuma calls.

spelling - "unlikeyly" instead of "unlikely"

when you repost please tag as net-next, rather than net
-- 
pw-bot: cr
