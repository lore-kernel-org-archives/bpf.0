Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCCF2B75E;
	Tue, 24 Oct 2023 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSj47pPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF62C433C8;
	Tue, 24 Oct 2023 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698163741;
	bh=JeHF0yONbQaaHjfO7vos8jWvnwbrXRNrUch7D0Cb9PY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KSj47pPMIKOphYBx8iY7cm5ig2x74gsZafsmHVrQacEzeOoQa/gXOVWbJB8TM9kEL
	 43PW/3riEk2QraYOjiprEb+/PJAS1Pu1T8Ex0akacCCS6ytlCrShDwf0q0elsQ8LGg
	 lNdotLMsa9oXrwRD++o3eO7LPKLIZonPUwigFH5U2IYuhRD2eR+jP6qHKiXnEyE5RW
	 2dxRJuEuW2u0e7q5xntn6bpwgXYum0MT8+0H6+t+F9RLY43iHKxyaHq/p8H2zn4CVF
	 uxitF9H0C4qivL9eRuKqT5bnJkkVWYbjiZ5respLAmEpu1wi49rRDr+zQyXMseqzCu
	 0gx5bOmUXs25Q==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2FEF2EE233B; Tue, 24 Oct 2023 18:08:59 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com,
 sdf@google.com, kuba@kernel.org, andrew@lunn.ch, Daniel Borkmann
 <daniel@iogearbox.net>, Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpftool: Implement link show support
 for netkit
In-Reply-To: <20231023171856.18324-5-daniel@iogearbox.net>
References: <20231023171856.18324-1-daniel@iogearbox.net>
 <20231023171856.18324-5-daniel@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 24 Oct 2023 18:08:59 +0200
Message-ID: <87jzrcovdw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> Add support to dump netkit link information to bpftool in similar way as
> we have for XDP. The netkit link info only exposes the ifindex.

Nit: Looks like you forgot to update this bit of the commit message? :)

-Toke
