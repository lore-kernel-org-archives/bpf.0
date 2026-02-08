Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC482857F0;
	Sun,  8 Feb 2026 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770563170; cv=none; b=g4F8KktzEcXF02g0/MmlETl2shTZP6N8px2I0fXnhi2d5wrxjPndX3Te8Yn9h81X6JGeiH+9BRgIXr2BfFT7dwvD0PmNEfVRydVnxKGOy+uh1EPBknThHa76lrwRqoCOk1NmMWhetu7gGPcSGkbgv9nd9FJulhlB6shkfLt+y7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770563170; c=relaxed/simple;
	bh=wuPCFzGfoo0AhMa0+JGsVwhpyQ4xaN5ZqtpP6JjE/CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXomA3UwhkTGVVAXv63NMmSk4mZ4r6ZXP23p/c65p+UB7N7f+0El1FdccADtC3R3UW/CXcNbimWyrAM7E7fJ15pSmmG+j97SQru3s5Ma+Peu7jY14u08rZmedXQvmndaWU3nXcQX2W3FNJKQG9Jt6AjGu5AUIo5+tJPPc/4WMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aVv+Cpoj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aVv+Cpoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B1BC4CEF7;
	Sun,  8 Feb 2026 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770563170;
	bh=wuPCFzGfoo0AhMa0+JGsVwhpyQ4xaN5ZqtpP6JjE/CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVv+CpojnTRuEUTGZhidFmWk3jaKbwjCp+bG/khYCMRdhVj+tO39zlo9UUJF/NrNs
	 MeSHW5XhzagOUnMX2g2I2TwpLjmw9k9Jvva/dzSnmo6J6Hybta+czpZqjCkIuZs8gs
	 3Ljr/X+7haphO2cVodL28ScUAMvTPZALk+e4Wh+M=
Date: Sun, 8 Feb 2026 16:06:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Cc: stable@vger.kernel.org, j.vosburgh@gmail.com, vfalico@gmail.com,
	andy@greyhouse.net, davem@davemloft.net, kuba@kernel.org,
	kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, borisp@nvidia.com,
	aviadye@nvidia.com, john.fastabend@gmail.com, daniel@iogearbox.net,
	ast@kernel.org, andrii@kernel.org, kafai@fb.com,
	songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org,
	carlos.soto@broadcom.com, simon.horman@corigine.com,
	luca.czesla@mail.schwarzv, felix.huettner@mail.schwarz,
	ilyal@mellanox.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com,
	tapas.kundu@broadcom.com
Subject: Re: [PATCH v2 v5.10.y 0/5] Backport fixes for CVE-2025-40149
Message-ID: <2026020802-unwound-chokehold-3b23@gregkh>
References: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>

On Mon, Jan 19, 2026 at 09:25:57AM +0000, Keerthana K wrote:
> Following commits are pre-requisite for the commit c65f27b9c
> - 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)
> - 5b9985454 (net/bonding: Take IP hash logic into a helper)
> - 007feb87f (net/bonding: Implement ndo_sk_get_lower_dev)
> - 719a402cf (net: netdevice: Add operation ndo_sk_get_lower_dev)
> 
> Kuniyuki Iwashima (1):
>   tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
> 
> Sharath Chandra Vurukala (1):
>   net: Add locking to protect skb->dev access in ip_output
> 
> Tariq Toukan (3):
>   net/bonding: Take IP hash logic into a helper
>   net/bonding: Implement ndo_sk_get_lower_dev
>   net: netdevice: Add operation ndo_sk_get_lower_dev
> 
>  drivers/net/bonding/bond_main.c | 109 ++++++++++++++++++++++++++++++--
>  include/linux/netdevice.h       |   4 ++
>  include/net/bonding.h           |   2 +
>  include/net/dst.h               |  12 ++++
>  net/core/dev.c                  |  33 ++++++++++
>  net/ipv4/ip_output.c            |  16 +++--
>  net/tls/tls_device.c            |  18 +++---
>  7 files changed, 176 insertions(+), 18 deletions(-)
> 
> -- 
> 2.43.7
> 
> 

What changed from v1?
