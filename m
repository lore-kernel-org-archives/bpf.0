Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007D4195DD;
	Mon, 20 Jul 2026 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589055; cv=none; b=SeqHblBV5eAHCV444yKRgUDaNO0lq626xEBrd/qM9mBFcXzfRauXUXRVAhW2nNBlFxishsiKYYfroatVdyXukcFTkRAJWlIn4No8Y2NinNMh59VSXaz0aKySbXqkA+96caoe7NxqPw7rLBZk7lpS32JVos2i5kQiEEmgGWZNNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589055; c=relaxed/simple;
	bh=QfrHrj+nfCb4gymVxWpgvJvxSl0/TjHwUI2B+Chu3Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZqhaVc2dSwb9dRZc1f1A8lYxVI8NxPfsVbqBMj2+dLueD3uzylZ2quDATNmeTo7yZOGjJXBICK59oGvRqQZZXtfw7sC6EoUU3BdaP9Kh9ZiAvKW0rPZxOedvN4HVnbxWcvXtiNixudv6VVjz2SvO8VWTquTJ2CrSMEkeepYTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhRnHgyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhRnHgyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69DF1F000E9;
	Mon, 20 Jul 2026 23:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784589054;
	bh=gS0gMDGlUdcF2JXB+ELT/UDkf3TxaGidausPdyd/ojw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YhRnHgyQ/nbvWgtc7huR/wKtoUWVxB77iLvFI1oIqeZSc5Xr+PQcgmqlmRwq2QPZ4
	 iTFOpqbAKPg8FMBeVlWI7QGOg6Bit7HqX4Suc1lBTHgUqGaPSl/dLq83B274ERTwVl
	 5DZXj7u2F8f5EKaVitv5eANrTdgLB/M8z3xcWYbhpWiAOJe8Cppzl6mbZzLBRzv9jl
	 lJdIXFg9Rst4nHGROGwf/HUscSN3ZX+x2d8SmKBvCa+EplxsKHrigwSYlpS24J/ZZr
	 Qdvc8Xx2zSGoewqwkRz3H+11P4EbgUSKD2TobGbHWRzWoRycDMiJqV6g6s4s0/sC3y
	 JcWN0uW1pRjWQ==
Date: Mon, 20 Jul 2026 16:10:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Shuah Khan <shuah@kernel.org>, kraxel@redhat.com,
 vivek.kasireddy@intel.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH v2] selftests: Open /dev/udmabuf O_RDONLY
Message-ID: <20260720161052.394687f2@kernel.org>
In-Reply-To: <CABdmKX0-tubji_pBiaZbePrxVLA9qkw5ez61wyzjDz8-pko9SQ@mail.gmail.com>
References: <20260701192210.2997769-1-tjmercier@google.com>
	<akbPrI67h5btdI44@devvm29614.prn0.facebook.com>
	<CABdmKX0-tubji_pBiaZbePrxVLA9qkw5ez61wyzjDz8-pko9SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 09:29:40 -0700 T.J. Mercier wrote:
> > Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>  
> 
> Thanks Bobby.
> 
> Shuah, would you mind picking this up?


Please split the networking part off, networking selftests must go via
networking trees.
