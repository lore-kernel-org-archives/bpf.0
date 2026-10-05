Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6A374A0E;
	Mon,  5 Oct 2026 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243802; cv=none; b=MuQE6MafKHsPwCeiq8MVAD+Std/6GHmrEbJIj2H/u+oK8wfiwD64zf3UMcUG94bjcIZW2HWZXHB9EUdFoiUyGZukV5O5a4Vhl+8RQ9pEuKJifJw0mz3dOy/2MeJH5H8oXd3rK0Z5lo4ft+ToX/7L+fHio+2pan4a7shVoN8Bd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243802; c=relaxed/simple;
	bh=9DEhj3E2Z2okJQt/crAHUr/v9cEfQDABwJkEAZASsK0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OVOtAyPzUv8zmUa06RgjviOX27Lrz1lUIzOz9rosmOTmiVrRZSpkmpQ+qmktOkMw1C8mXWUPGX7RN8CEEcYKxSbBvPhkwl46m8F6vx4AeJIx2fQJUGXfIMf6qnHZBhrjsmHq1XO1ecAXQqvxQTD8apeyCCfIpiZJWLsmw7Sdgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHZDxiuE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHZDxiuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465491F000FF;
	Mon,  5 Oct 2026 23:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791243801;
	bh=zxf0bLE4pWJCsdbiay9wtqu5N/mppcBbaXd1zM7Bf5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=NHZDxiuEAQHT71RANR9YkRmn9Cz1QGeAO0R347lZlOwalZUPOTOCo8x4fXxPvRQVs
	 qHXlPdFOXKWNzA55IqHpI0V6KVYZpZoftBbU22rSDv/LfUuGIrbpYXmN5+NlPYjLlm
	 z2zjpvoHS1IRtHMUQSjwWUGwjq3mwg4zdJ8fwGMYIs3xU9dB1sJqjER7uEC1xquwYs
	 970ocnssRejCzuc8NDwh+aULypn85kfdnrLClU+HPT0Qhd1GLRTfvwIYKkjQeclcV3
	 nt4k0MF2A2MXbWrpee1SC1lHT+dqidu50IZsayWLrPoSvgkrXWTkOra688kKk3ln3R
	 MqioahbxsbmMg==
Date: Mon, 5 Oct 2026 18:43:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Nikola Prica <nikola.prica@amd.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the
 pci-current tree
Message-ID: <20261005234320.GA648423@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asAylbswc5WRADZ2@sirena.co.uk>

On Sat, Oct 03, 2026 at 12:39:17AM +0200, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   drivers/pci/pci.c
> 
> between commit:
> 
>   97958feb6560b ("PCI: Accept AtomicOps already enabled by the hypervisor")
> 
> from the pci-current tree and commit:
> 
>   40cce45b921f7 ("PCI: Accept AtomicOps already enabled by the hypervisor")

This fixes a regression, so 40cce45b921f7 ("PCI: Accept AtomicOps
already enabled by the hypervisor") is already upstream in v7.3-rc6.

97958feb6560b no longer exists in pci-current.

> from the bpf-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --combined drivers/pci/pci.c
> index 62729ade496fc,8cc6a89130b53..0000000000000
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@@ -3770,10 -3770,13 +3770,10 @@@ int pci_enable_atomic_ops_to_root(struc
>   
>   	root = pcie_find_root_port(dev);
>   	if (!root) {
>  -
>   		/*
>  -		 * A hypervisor may expose a topology with the root port
>  -		 * not visible to the guest.  If the hypervisor has already
>  -		 * set AtomicOp Requester Enable in the endpoint, we assume
>  -		 * it has verified support in the root port, so it is safe
>  -		 * for the driver to use AtomicOps.
>  +		 * A hypervisor may expose a headless topology with no
>  +		 * visible root port.  If it has already set AtomicOp
>  +		 * Requester Enable, there is nothing more to do.
>   		 */
>   		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
>   		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)


