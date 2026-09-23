Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51027413798;
	Wed, 23 Sep 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153416; cv=none; b=GtHqVsT1qBC5p41FX3Gtw/T18dvkPWKNuaGUgr61Pdf0R8nbO+MZaFcAhCrJvjIYLMQJtbuNg4oOwYSgjewxAlWxKXZ0mx96ENGlk/hU09L7P4u7wPknNxhD1iCCrWOuLfUUKuJtO5Y07ZwJgheomAWrlE2HDaJ/E9tStlN3/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153416; c=relaxed/simple;
	bh=vw6CA2I173k93qtQof0Y5hXQlDUAFKr5FN6nPvywoH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv1LcvrG+RWFlqfXowIDSzpRYJKoTqWN0Myg19QC7taiXH3jqFFfeBLlYwGUjNTIP72d1Xjml93IGNT+Jc5KzidwvXHE/pxELFJfJP/UZmIr8FoVatAgnFIj96XdTTNeMaJvi0PpfIhUbsIhCvA1fnlwxi8eUqThony0BJYOGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkKZSamI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkKZSamI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F52C1F000FF;
	Wed, 23 Sep 2026 08:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790153414;
	bh=/mgicnWaAz9WEZlH7S8mQa/MGfsAmlS+pMaAuGE5fsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fkKZSamInRjp0YI6W/QSd94uSdRqcQ9QG3AN7LzO5kpo4tlYBH/7stKVPbI3rLWyM
	 51Dj3Xr2eoRkgKWBU4SY7eLclI1AxSXOsxKETndqXL9ldyKkMhzAv/ZNZvub7kjzOt
	 DDU8nJDFcNzSiHFvnUTGQ0mtBiDOKWNMcWZumwBbB59w2fcSByR6RtKjuxmaYeao08
	 FQOno6iQvFl5zGAI3kL6lHZK/oMgAFXCndNUeKC7Nv1r0+KwtkLxzlLsPWdLNJrwdl
	 iSYhji6PMY481nS8SormHxQvzAsjaFE//fvW59ZmXBe19z1plukrQPQnmnIQ5+SRM5
	 IeQxyNoTML6Gg==
Date: Wed, 23 Sep 2026 09:49:38 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Herve Codina <herve.codina@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v7 02/14] net: microchip: fdma: rename
 contiguous dataptr helpers
Message-ID: <20260923084938.GK13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-2-0ecc179c8a2c@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-lan966x-pci-fdma-v7-2-0ecc179c8a2c@microchip.com>

On Fri, Sep 18, 2026 at 01:33:54PM +0200, Daniel Machon wrote:
> When the FDMA library was introduced [1], two helpers to get the DMA and
> virtual address of a data buffer, in contiguous memory, were added. These
> helpers have had no callers until this series. I found the naming I
> initially used confusing and inconsistent.
> 
> Rename fdma_dataptr_get_contiguous() and
> fdma_dataptr_virt_get_contiguous() to fdma_dataptr_dma_addr_contiguous()
> and fdma_dataptr_virt_addr_contiguous(). This makes the pair symmetric
> and clarifies what type of address each returns.
> 
> [1]: commit 30e48a75df9c ("net: microchip: add FDMA library")
> 
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

