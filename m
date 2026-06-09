Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F93FBEAF;
	Tue,  9 Jun 2026 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042253; cv=none; b=gf0T8JjdJdpKUHJBqpn8atb//WqMW0c2HvzwqN42OFXfisZNIDASTPof6DdDPindLWkhwLFtwnri8eDWn/H7qxfvabDS22pTq/q/VEaf+FezYby3u4mcWg0FfVHsSNDymE0MUQ2Ckmu3ZPZ7+8HY6/7v78nxIUn+gSS0BaawQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042253; c=relaxed/simple;
	bh=0CYUk3mcY2Z5Sz4+beWfJokuW2ClAlI66bTArmd+Fz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOX+P71JMxmjFNeTlfiSj+HrAokyPWaObwCStLULMvx3J/FH2oKCItmDUlDFQR4Atr3ho+vFjPCDnN5AEYdcg4Gzi3bahwF+MLRI7gmW3D55c+teL3++1kW9SFJLN8NoH+E2fv/E1h0JwVt8vq396ZYedP2uAYPOD/G0/9/4h+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT6Akloo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT6Akloo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4420F1F00893;
	Tue,  9 Jun 2026 21:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781042251;
	bh=qddQ3xG3nLP7iaPeo6rwHCCEvIqeK9/UCvhobSlMWdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eT6AkloofolTU+44bYcsvAKqeDvXgLLmDorOoVoh5fclXviRz9sdo1x6Jql0WQ1KZ
	 ZqL1L3btKOb/25lrFBiiqKftLEOWXYZS93U3p1Eyyg+Or3iwJYw1eLnjdj3WySxvNH
	 T6Gaa/V7DB2JXZxo2Zn4fO57JFy8U70YDhrdewG2fd8ldx5EM0ja2m+QaMZ4DzsklQ
	 hXB0VWUGqEYdaLtAr0Tr8DQuvyqV5BL8eC4oUCpesj3hCXWGwW9F1/wPmTYTCi7hCR
	 PrE4RFmGg1nYWSxItAObqG0AJyfnIxTcQ8PBsvBtXEaaugY1B58uRhElvspAPynSad
	 oyPrxjfP/kbpw==
Date: Tue, 9 Jun 2026 14:57:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: abaci-kreproducer <abaci@linux.alibaba.com>
Cc: Sechang Lim <rhkrqnwk98@gmail.com>, John Fastabend
 <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver <oliver.yang@linux.alibaba.com>
Subject: Re: [PATCH net] tls: fix use-after-free in tls_sw_sendmsg() cork
 error path
Message-ID: <20260609145730.2497829f@kernel.org>
In-Reply-To: <178101875671.841617.9555980064609175426@linux.alibaba.com>
References: <20260605214802.1647008-1-rhkrqnwk98@gmail.com>
	<178101875671.841617.9555980064609175426@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jun 2026 23:25:56 +0800 abaci-kreproducer wrote:
> From: abaci-kreproducer <abaci@linux.alibaba.com>
> 
> This is an AI-generated validation of this patch. The issue was
> reproduced on the unpatched kernel, and the original symptoms were no
> longer observed on the patched kernel. However, additional issues were
> identified during validation (details below).

Please never spam mailing list without automated bots unless
the maintainers have given you permission.
