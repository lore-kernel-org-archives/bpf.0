Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B841A547;
	Tue, 21 Jul 2026 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661537; cv=none; b=hfkPnp3f/3//czybVC+/QSJDmZB+oiqLMdCuS0IyVMSOC+Uaezp3YtHZwGw4k7sMjbqiWgffYVrUCgNOuJfhdbHtcB/fDpiExXkEMCSfWyGunne40/4mccO2e7IxIHnfn4cDobEDmefLeCReUZBT8W0A5BsB40geHvaPIMF5fps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661537; c=relaxed/simple;
	bh=AmlNQUy6TMrkGt5/PdbUxj3gJkNxonHkJrb0So92u8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3l1+kZusQWc95+dqJXSkjIzSNonZSoCjjM3sWizTo2SSy+lp8o/ZfiaC3Kn+CDpUmFQC3Zii6XZUBlWQGb/+TDgIOqb5jF1Lokxi4hmPVZFPHBotEPzoH2e061qQCI+jzzbZB4ih/W0h7YtejPVKrvF3IcxCoF0mU8KTqN04A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgYMCnJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgYMCnJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CDF1F000E9;
	Tue, 21 Jul 2026 19:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784661536;
	bh=AmlNQUy6TMrkGt5/PdbUxj3gJkNxonHkJrb0So92u8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NgYMCnJa/3Mxjt+ig4GnTkbU0Wg+1wVdCcCY8H8vMyBNFA/oRo/rg03svWYkyoAhc
	 Ua/Q63IDZRGLOfsfdX6g76y6uDj+x1R2TfD49Dk9rIiYSKMhuB88PFpY7Bwtw8Ilni
	 ry1UdMbum5BiitjzD2rbmO/zpNjbSVu8rDvLlHy68WWAO9ojWrQ7J5MtmeFk0+EuLt
	 TVoAOd7rj2V2z1XfCDoSSBvfM4tFzCQVt4KLQYKDBw2IAK9tNBLN2/qtvdUOjUT0GA
	 ZKfGaVyrCpgnw0DG/dwRzn3sJ8axVOpX/jqY+NakDdvdJSQUBMz+Awq/RhYqUKSGg3
	 QNn1fGh56i17A==
Date: Tue, 21 Jul 2026 12:18:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sukhdeep Singh <sukhdeeps@marvell.com>
Cc: Yangyu Chen <cyy@cyyself.name>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jesper Dangaard Brouer <hawk@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH net-next 0/2] net: atlantic: convert RX path to
 page_pool
Message-ID: <20260721121855.06a796b9@kernel.org>
In-Reply-To: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com>
References: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 01:36:44 +0800 Yangyu Chen wrote:
> Subject: [PATCH net-next 0/2] net: atlantic: convert RX path to page_pool

Sukhdeep, please review.
