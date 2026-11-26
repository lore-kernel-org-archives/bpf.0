Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697932;
	b=z1xOAPaK8w5fWkKK2dTeNyoKOXgzJo+C5AEEgLOpBzzCNoe7qhzRDxIj02tau/aORsP+
	 cibE/TyoTtW7tS430SK0yIu/Lu1UZINmtZB3c9Bk+9tOMeZ8PhHm5s7IQN7x5cbMiKZpZ
	 GIkk4kO4bAmSeLbi6DoF4XAVs3+bKSKtuuOtObieaKdU2QHiWSBHEqWYawnZ5hJjM7VbX
	 yIvEYqF03l6fgyDRnmVDdrbrIJfIxo9lZpAEWe5IbKICv7nTw5iIG34V67qyOrx3r5OkD
	 DbI8B+49eMXaPwwFxiisviYSKYjjUuroSKjHasTAEIMoRgJ3Oo3T916857/ff3IWk3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697932;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=iJwuuiONsYMEScR+HUCfdA0r7t01n2I1+SX02myWP09aOwtPm3Z46gJf3hRxmH7m5v9A
	 tgAZ5mLF1ORCS9bEOfvk7+xgfjKmtzgsX533aazNHTQxoRmJEgIAlDlqBQLwGUbScxYN4
	 nXdZaijc1MAf2vhG9/AhEZmf8iMoEndXUQALbAnWpAia/VdKBEBGjZ0rnnskDeb3SHS8C
	 3SKUQLBCq4CxACh5LRX3k8a8+pMDrHLIeVBlc+bNsB/JTkQOwARTnlI5lUO8/inw4me9z
	 DgILV2uKlUUfcyHp+QH/8iZ0+TGDgLkBYhW05w4fD4gIvKV4xdm3PHddFi+Ry3txVgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYEjgAVw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A971E606A31C;
	Thu, 26 Nov 2026 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYEjgAVw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CE11F000D3;
	Thu, 26 Nov 2026 12:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697931;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYEjgAVwQB5yQDjh3gmTb25q5va0T4F86hUP6EHfkVomrb9OIDRor6la/Y/ytF9xn
	 DEe8EUaqkVygzrgUt9+gIcTKWBuDPz/VHLNjFpEaxMUDNRcMwArJBN7n88HmK/pS47
	 tcxWcSgJIHV3X0ttdUlWs4lvhYXQQxlcS9JYs5qtf7qzOO3/1AOm96okWgtqD8PV1M
	 lunodwRH7tLU4Xxi/xim1ErCUrLn34ogku4ylQIXGBZSs2mbnaaqSKzTT5ynm1npvp
	 x8ZLk72OjEtCVHNk/wXkgC1iEpf6Nuv0C4cm8JOPcv5L+5t81k6bo+KuhSom64V2vb
	 cVzEwpTkl3ykw==
From: netdev-bot+sinfo@kernel.org
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, tehnerd@tehnerd.com
Subject: Re: [PATCH net] net: xdp: Fix skb->tail after bpf_xdp_adjust_tail()
 in generic mode
Date: Thu, 26 Nov 2026 12:58:50 +0000
Message-ID: <179569793062.3294.6946658046125535159@kernel.org>
In-Reply-To: <20261126125558.2032158-1-rhkrqnwk98@gmail.com>
References: <20261126125558.2032158-1-rhkrqnwk98@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
