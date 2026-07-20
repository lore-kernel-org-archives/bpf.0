Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AAF3B0AED;
	Mon, 20 Jul 2026 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559157; cv=none; b=AT3GGLGBNY9AlVfVi3IMF9DXzt2f1elriVT2eb8c4c5i+TljB/QhDTCdFWTmYWozc4Tycmt3qmcptErIcmVoCoKall9EUCuWA5LudbvMPyYubBHdytER4yzsGwVSjnd9dE7Bg+4Tf37qqJO5AlRZ+wA25rzF87ra3G4HVvf1XV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559157; c=relaxed/simple;
	bh=Bjvohq2v2i23IEhIm+ccU0SDBpPI/BIJpQ5q6pACfL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNqGs49GKT/XZ7zmlJIxHvdqg2CFayYBSLhFZdrL1fXxN34ddmhf7LVG3rShWaS3vOf8GBnWGJRpYAidTiIFKHg+jKi+pggDE9bgBLtt3EtXz+7PmSae1HtaTmQO3wCKXDXVVzlvAkYoNVCyT0ZDBuuJ3yvnt03nApkwQFRnmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mq+oV9iT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mq+oV9iT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F/s/d0Z3FHuRMkX/iyDz3gNuTnsiDhmQLCtHl/3v5LI=; b=Mq+oV9iTDJbPEvI+/L8X0qI3B0
	P5XOU6GwCf88RpweGIauKuaejgy61H89UBY4DiypkhEENyjSSqrETelO6qS3OmX3iaYp+sykkRo8n
	MFpQf9IZb1queduUYN3qbMdUaZ/Vm2I70J5BIg843EMckOmXIoFGVUF0HtIrrPQz6acM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlpLk-00DHHV-Iw; Mon, 20 Jul 2026 16:52:08 +0200
Date: Mon, 20 Jul 2026 16:52:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>, Auke Kok <auke-jan.h.kok@intel.com>,
	Breno Leitao <leitao@debian.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH net v2] e1000e: Fix out-of-bounds MMIO access by
 validating BAR0 size
Message-ID: <d86c6b6a-fa9a-4429-b004-8c54b2232797@lunn.ch>
References: <20260720133049.1289167-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720133049.1289167-1-pulehui@huaweicloud.com>

> --- a/drivers/net/ethernet/intel/e1000e/regs.h
> +++ b/drivers/net/ethernet/intel/e1000e/regs.h
> @@ -242,4 +242,7 @@
>  /* PHY registers */
>  #define I82579_DFT_CTRL	PHY_REG(769, 20)
>  
> +/* Smallest BAR0 that covers every register the driver accesses */
> +#define E1000_MMIO_LEN_MIN	0x10000

I commented on the previous version. Is I82579_DFT_CTRL the highest
register? Can E1000_MMIO_LEN_MIN defines based on that?

	  Andrew
