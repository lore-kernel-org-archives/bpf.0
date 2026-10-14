Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA43438BE
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977855; cv=none; b=GdwGW3q+h/NG1zEyWz2pMPiVCJ69g12w8v+sFIrT167b3ITFS1tXVUF3D6VP04gX8KykdaVfC//4PgdNr1xF5pNTf/P8kNfoCCRjeHDbQg1E4c2MU2TbQDEhNmlo/sgGbkt0Q55cv6kR4irBsdaFxtmBZVSSHKgbZVaMcxhz5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977855; c=relaxed/simple;
	bh=4m6waPUkhomHnW0R2SZtL391TEfAQDn4Lg/PtkdlnYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkMmyADEiQjQW784tPAc3aGkZ6LYBvvgGKJJNeDklCyl4S1Wj2fx9+hKEfTBGRgv5Yy0iSfyKkvcFzpveJW9lb9RPdQ+seu0rZlXaO+eSjUlAVghDkALYoKsSa5+i5xA+q21RO4r1NDl3WyCSg9MqoRTN4sW7WxDUHZT2kL5LxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WimA8nXl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WimA8nXl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 78EB91A120D;
	Wed, 14 Oct 2026 11:37:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4D64760368;
	Wed, 14 Oct 2026 11:37:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E41B010328B3C;
	Wed, 14 Oct 2026 13:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791977846; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=V4ymEuqTqyaGq+HF/qthlrZ+HnGnQbv0+xl6gccW0qw=;
	b=WimA8nXlV/g+Y+ZUIyVT/eGUQPHsoHwQzPZbgc659ZiDq5n/nyjMkKmB2jsahsmpXVBHUP
	y1WXOeZ1wKwgk3+PYlI4eB6+NWmltzXZNzbCp66isfr3QC2VMC+z6WQKBD8roI+iEaX95N
	toqaPVbA7yACgD77dKlLz4jiqTb17fQVy/V3wPWUrU/V0b3c9ByJcdYZKXkeq9VOaFVatD
	+lIN5IIQC3cHqry8fc65sYSF6slJRSPpzw+e3PFRpHrosx3UgmgL7aCXDEAOH5X/op4zVi
	L9j25MgZLf3mpLJRNOfaH+tnn4VMCddzGSYn4eIOr7MFSwrAFVpBkPMVKTPnwQ==
Message-ID: <1e6bee3e-a4fd-4cdb-9c42-5cee57e3ed83@bootlin.com>
Date: Wed, 14 Oct 2026 13:37:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: stmmac: free RX resources when TX allocation
 fails
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Ong Boon Leong <boon.leong.ong@intel.com>, bpf@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1791958735.git.kmehltretter@gmail.com>
 <e7a5380aabfbc03bd560ab08f37ea255d11d528a.1791958735.git.kmehltretter@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <e7a5380aabfbc03bd560ab08f37ea255d11d528a.1791958735.git.kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/14/26 08:27, Karl Mehltretter wrote:
> alloc_dma_desc_resources() allocates every RX queue before allocating
> TX queues. If TX allocation fails, its error path only frees TX
> resources and leaks all RX resources.
> 
> Free the RX resources after the TX allocator unwinds its queues.
> 
> Found by inspection. On a BeagleV Ahead (TH1520), forcing TX DMA
> metadata allocation to fail left the RX cleanup event absent. With this
> change, both TX and RX resources were released.
> 
> Fixes: 71fedb0198cb ("net: stmmac: break some functions into RX and TX scopes")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Also covered by https://lore.kernel.org/netdev/20261012142458.2845385-1-dinghui1111@163.com/.

Thanks,

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 495ff7aef..8fd7d2173 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2425,6 +2425,8 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
>  		return ret;
>  
>  	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
> +	if (ret)
> +		free_dma_rx_desc_resources(priv, dma_conf);
>  
>  	return ret;
>  }

