Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4DE3FE34D;
	Mon, 11 May 2026 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508996; cv=none; b=iPvHtNyNKTJbPvW4a3eT796xILG6YaY/qfcGH0Xfw68E4DVpLPOp3l8uVbalAaVrOm1I+OemzzO41p4419J0DHePE0G/5ctQPKISj8QK/2bwfJxzoFbO83f1SK7sHq+YHgKLy5CRGscmJx/87u+FLHDO3AioF/EItx7Qm1e1EtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508996; c=relaxed/simple;
	bh=l9s76vlJeUgRWNHh/t01VYmRzuAMECx8ccD1yIQ7gaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aW5txlyz4OzWNgT+nenEnUzbxNBoe7tJczpJpADZSl5NvNd9ucrFG1KWGLPYDsLsnK9vYenTCUIX0pylPKEOk+mlZqPKk9+R/l0PBHosqXFgETOX7LYZjEXcYgxmCHPDM+BA39qwLl5wFm7zrkOaRQtZfsoU0ow7Qdf3e0IPiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5H9Jvs9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5H9Jvs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9ECC2BCB0;
	Mon, 11 May 2026 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508996;
	bh=l9s76vlJeUgRWNHh/t01VYmRzuAMECx8ccD1yIQ7gaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C5H9Jvs93HF+O4qvnWcmA1g+XB01ivlwYAHVrb85MQLqRuQpwmAJGXaTF2EwB7Ljg
	 MNPKHsxrhByfdlU8xa/tNF0C32J2/1PywMEaO/OOgsQYtn1TBFmDt6hgkYHCwYmQvq
	 axnvoOAgHGVO9Uj448mr4tgg++SX/8XsbJPOz3q9eGJqB39XUT/8FlIc2NWYISnLZY
	 ZUqU+XrbIqAgwWtePfl4OA92evxrtCSYheV1JXzH1eJ8bPsTEif6pHsvjkMitNpIhe
	 4Odc0kdvHgEvPQufjW46xeYZUn6pYzbAAi4Ta7bHJ11MuXcsLLmHlC0H3IxQ4n5ikR
	 6cCZqIN36v/UA==
Date: Mon, 11 May 2026 07:16:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 0/4] xsk: fix meta and publish of cq issues
Message-ID: <20260511071634.463aea60@kernel.org>
In-Reply-To: <20260510012310.88570-1-kerneljasonxing@gmail.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 09:23:06 +0800 Jason Xing wrote:
> The series is the product of previous review from sashiko[1].

This series breaks the BPF selftests, it seems:

Error: #277 ns_xsk_drv
Error: #277/21 ns_xsk_drv/ALIGNED_INV_DESC_MULTI_BUFF
Error: #277/22 ns_xsk_drv/TOO_MANY_FRAGS
Error: #278 ns_xsk_skb
Error: #278/21 ns_xsk_skb/ALIGNED_INV_DESC_MULTI_BUFF
Error: #278/22 ns_xsk_skb/TOO_MANY_FRAGS
