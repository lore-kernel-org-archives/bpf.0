Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174E1D63E4;
	Tue, 12 May 2026 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552421; cv=none; b=Z+u9gotOCnNiBr51Os7vg8NI1E51IRxFgcv4hDrNeaeiOelYYkANgqsd3Ruk2Lrp/Ao3KZuQQwIRNudPQHMWgXa++kLRISGkGbyYlT3GUdd5j3QGnkjRgmn6orxuTWIzyzd8dCUKbcYaBQkAp3ezsmfVdOhYcnIIdqJNkeDpCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552421; c=relaxed/simple;
	bh=qCpmwOBMO2WUkTkzHq+nS/FnpxquV63bE+Zm5s0BjQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vxm4TVn7jZzw65HqqGK1wmCfTYio2TNJUAgi1brr5QmUOBBVCBr1DMUER2ml8Dt5BWTs6atTLa0ZrcpIM20eoMYb1lI67tYiUbDUgCvKt79g/BwMrk2hMEUPWmzE3IroW/+7VVkFOuyrFZ1vVeMXFkjjBp7KJbdJjnkl/eG5ZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGxfJUCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGxfJUCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FEFC2BCF5;
	Tue, 12 May 2026 02:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778552420;
	bh=qCpmwOBMO2WUkTkzHq+nS/FnpxquV63bE+Zm5s0BjQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qGxfJUCl4H7hCiKozqcohLBmSz2UGHjAUAnhFnbCkokN/8U5+DNCy3gkdREIPy5lT
	 FcuKyjngJ4CLIq0CowDYsBvmOjYrJRSQ/fcF4fZheIk5E9BeebiHbOg+5bpzhegKpM
	 /KDCxxemrJV0rjqXJnckd7dkSlKt6+E3hdojzLsWWTFF3wj41TvRqlfubpWfGfinyI
	 2GEAYue+fArQRJQBENFSnlCcU0Qmx+0fd3NtT7Lj5QnSadh4lBHWrnX2s18U4nAv+O
	 YWfd8QL3KimEIygt1/6FVwEaPCoANw85ANpVmOXB/P/sdTA6ocdQxV68U16KQQaVlQ
	 BVg7iY1KhqMkA==
Date: Mon, 11 May 2026 19:20:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Steen
 Hegelund <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
 "Alexei Starovoitov" <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "Jesper Dangaard Brouer" <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Herve Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v4 00/13] net: lan966x: add support for PCIe
 FDMA
Message-ID: <20260511192018.49dfcd7b@kernel.org>
In-Reply-To: <20260508-lan966x-pci-fdma-v4-0-14e0c89d8d63@microchip.com>
References: <20260508-lan966x-pci-fdma-v4-0-14e0c89d8d63@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 09:35:24 +0200 Daniel Machon wrote:
> When lan966x operates as a PCIe endpoint, the driver currently uses
> register-based I/O for frame injection and extraction. This approach is
> functional but slow, topping out at around 33 Mbps on an Intel x86 host
> with a lan966x PCIe card.

Looks like sashiko-bot responded but only CCed bpf@
Please let us know if all the issues are false positives,
I'm going to assume for now that at least one of the issues
is real :)
