Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83BD31735;
	Mon, 27 Nov 2023 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Joazzyn+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE16C433C7;
	Mon, 27 Nov 2023 21:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701119254;
	bh=cIm4i4ni8q9KxV9YAi623eGX0mZmJPuO4aPGKrPyO/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Joazzyn+WlzTbkWr3WmPWY6ApFhiHgfBQ7BQF2nF8Lau630P+33KXOuL1L8ecSE9s
	 xQtFShRFR7LjTr9rSgxPVLU+1Vyb+3bC/cdO5xJuW48Q/mcKdSjk39TimxLEaeoNln
	 sMVq/xNds4evFmR9xzj9NEoyECDTJSsmFidB1eZUmDIZ5v+wx6HSFwY2Jr7g5hckHH
	 9crRHSCLqEQUHKL3V7CHQZS4qpAk3dQOV4s7Vame26l+OCqaLz+kaU4KrLW8YUvyON
	 Vihrof7DNbNQWuQMmOpABCmjI26txkePUSYi5zXnd5Gb55ZMnWoc2VSgg3fjr8rS1n
	 9z6wcIi0WQjDA==
Date: Mon, 27 Nov 2023 13:07:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, razor@blackwall.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf v2] netkit: Reject IFLA_NETKIT_PEER_INFO in
 netkit_change_link
Message-ID: <20231127130733.6182c088@kernel.org>
In-Reply-To: <e86a277a1e8d3b19890312779e42f790b0605ea4.1701115314.git.daniel@iogearbox.net>
References: <e86a277a1e8d3b19890312779e42f790b0605ea4.1701115314.git.daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 21:05:33 +0100 Daniel Borkmann wrote:
> The IFLA_NETKIT_PEER_INFO attribute can only be used during device
> creation, but not via changelink callback. Hence reject it there.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
