Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DD42048;
	Wed, 13 May 2026 00:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778631245; cv=none; b=g/HJ4zhgMyx2KIUZ1GCpG13BnYAw2Y6ZenLzKVUSGn/T9JRja+1Xjr1lL1q+2VzGsQENMBQ1bniIVUWMYCjZ0jrRVqypeka6RcuI9MB+DzdGFvIfNbd5f4IOISRTu0JdG11sGX3Pr5+9iH3cHLHcAM1NDBemWTYbeD6zFePpT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778631245; c=relaxed/simple;
	bh=4GruWIT/Nsui7uZtqmIZLbC4ZkcuiHVREH43fi7IohM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKSYDFj/xTwQhNg8NJx3F77qD4jobh0t/Bo+G8Pv+IIhjPPTDZQUK0ybfA/LvlsyyMf49R96N3dHGGr8zJ+qt4isSYoPMqWLSj0qN1iYVa12HEFL3X9nSXTFmTCiKF909uoLUNM7F8GvSqJViy7o18VWapkXo2TWHGOq3HpHWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcu+vUuW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcu+vUuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9979DC2BCB0;
	Wed, 13 May 2026 00:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778631245;
	bh=4GruWIT/Nsui7uZtqmIZLbC4ZkcuiHVREH43fi7IohM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rcu+vUuWIuDEY8ieb95Amzv+7aqQxyCn+n16/MmYkoIPzz2GGbbvGoIQsHRFRlX8R
	 jidecfhwgvnbfcDxyne/wa8Y1PlGgTfARvHUjqW7U7n9Zx3/aOKpQOX6u7wmbwPRBh
	 G3LSktdzXVdpvnIR+4S+2rQY6RdoAn6QSASnh+Esz/mlmdRsh0Q3CXqpldk0oneWy9
	 LoI7TpYm0p++hvw7ff1gWPVkc2G5sJDnPiHsbsnD5+J+4/NzYsSTJdoTw7VvC9nZFf
	 3NJbdjrDYdyAe21ibfo0TOsCXIXDu8YoKg0o+t1ZIWit5xKvfILVkHSdz4gbN9acX7
	 mwQR+Log8Mt7g==
Date: Tue, 12 May 2026 17:14:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 john.fastabend@gmail.com, bpf@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>, daniel@iogearbox.net, jonathan.lemon@gmail.com
Subject: Re: [PATCH net v2 2/4] net: tls: prevent chain-after-chain in plain
 text SG
Message-ID: <20260512171403.17cdd5d5@kernel.org>
In-Reply-To: <agOqCETGrzQccEGn@krikkit>
References: <20260511174920.433155-1-kuba@kernel.org>
	<20260511174920.433155-3-kuba@kernel.org>
	<agMKcBrJYK5UIcsZ@krikkit>
	<20260512090342.15779c9a@kernel.org>
	<agOqCETGrzQccEGn@krikkit>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 00:30:32 +0200 Sabrina Dubroca wrote:
> > > Probably a silly question: why do we need to chain the content type?
> > > Could we just drop it directly into the right slot of msg_pl?  
> > 
> > Good question, IDK either. Maybe anticipating the need for padding?
> > Do you prefer that as the fix, or follow up in net-next is fine?  
> 
> I'd go with "make it a bit more straightforward" and remove the
> chaining. If you want to retain the hunk moving the other chaining
> (for wrapping) around, go ahead. Not sure it would still make sense.

AFAICT start=N end=0 and tls content_type chaining are unnecessary.
So I think we can keep this fix as it.
