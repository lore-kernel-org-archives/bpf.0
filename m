Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B607736CE01;
	Fri, 27 Feb 2026 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235153; cv=none; b=Ak/y6hSAy5/En6pa5t9qlbonfxTksNk617OKk/Q/ZFYve+nE0T6RUWP9x8x5C3x5X5zsQeyQoXNp2dhXjbxyRCCZ3iPr1g/wa9w1iIuhN6UemLdglQovurOu9/fc0WNIkzXGEzMxjz3h2khL34eKrUSlFjjBKMCs8MHfP+sOtqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235153; c=relaxed/simple;
	bh=Gl9pmWCL2mZ3Wj2qs5uUBK7sBEzBWHxCsN6KpmSpLyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKrRrh5ltLp1Q6BPjmrJpsb6Sjs8idjMHK97WDPDtWynHQUebpW1ryDyvn0hNdMU+j6N8BnDxVR4tUq3gsl4EH91hO2EeHtrblINWK0g+u2wXJDoBXbzCm/EnjXRuTW23VGTrokEZagRc/lQ0lB7aC4q2MGYa0Y+LMx8ycSeAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYtorbVy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYtorbVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECDFC116C6;
	Fri, 27 Feb 2026 23:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772235153;
	bh=Gl9pmWCL2mZ3Wj2qs5uUBK7sBEzBWHxCsN6KpmSpLyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bYtorbVy8qSlQjd7l1kWdzABNB9LzHi1Yio+QUGF124fthAQR4f7N7zIWocCokrSH
	 6HaBhcp86x89uxkTA+TomGUmaAKGghBTTfUj6NahDiwWzUslVXL08VjcFnQDBOg/Io
	 jyBIrRLIllBPatXEVoiFJHXpmt5KhzPtf+D0Re3hGlhYRxI1cD5E/n8MIHPmo6nQnx
	 lTGii9JUO/lCUBoJsSz3jzYhokGuvhV8Zl6U5EpX+Z9QTXz7gvLD+4IP0br6nhQbR5
	 k932/+YF5E7zJZSNex52AGGP6IAizHjxsVGjkKr7/ZWJWRMQfK/pYEtaLaZqXXc5tK
	 K/alACU4cz6Ng==
Date: Fri, 27 Feb 2026 15:32:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <20260227153231.78d16b69@kernel.org>
In-Reply-To: <aaGaaExy63bGa7Or@lore-desk>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
	<20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
	<20260218174742.62a4074f@kernel.org>
	<aZbuWBnmh_SQJyVf@lore-desk>
	<20260219091344.1d8517f3@kernel.org>
	<aZyKWoxnywXKWth9@lore-desk>
	<20260223151845.06db43b0@kernel.org>
	<aaGaaExy63bGa7Or@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 14:21:44 +0100 Lorenzo Bianconi wrote:
> > > At the moment there is no way to store the csum value we got running
> > > bpf_xdp_metadata_rx_checksum() in order to be consumed during
> > > xdp_buff/xdp_frame to skb conversion (this info can just be consumed in the
> > > ebpf program bound to the NIC) but  
> > 
> > I think the scope here is much narrower than the xdp_buf to xdp_frame
> > to skb conversion. We are just pass information between the program and
> > driver which owns xdp_buff. Very similar to your new xmo.
> > 
> > We could either tell the driver to discard the csum complete or even
> > add a helper to "adjust" the the csum value. Similar to the helper
> > we have to adjust the csum in TC / skb context.  
> 
> IIUC, for the CSUM_COMPLETE case, we want to add a kfunc used to update (or
> invalidate) the checksum value (if the packet has been modified by the eBPF
> program bounded to the NIC) and report the updated checksum to the driver if
> the XDP verdict is XDP_PASS. Correct?
> 
> I guess we could have two approaches here:
> - Write the new checksum value into the xdp_metadata area (if available)
>   where the driver can load it and update the checksum value before
>   allocating the skb.
>   The main downside of this approach is we need modify each driver.
> - Add a new xmo callback used to set the checksum value and report it
>   from the eBPF program into a specific memory area provided by the driver
>   (e.g. DMA descriptor) that is used to build the skb.
>  
> What do you think?

Exactly. The invalidation is easier 'cause using a single bit in the
flags should be uncontroversial. If we want to be able to repair /
provide the csum complete then we have to pick one of the two options
you outlined. As you may suspect from previous discussions I favor 
the latter. But we'd probably have to have a PoC with either one and
see where the consensus falls.

Actually, thinking about it more, I guess this is not just a
CSUM_COMPLETE issue. XDP_PASS will also risk reporting invalid
UNNECESSARY to the stack (e.g. when XDP stripped a UDP tunnel
which which the NIC compute the UNNECESSARY but the packet inside
the tunnel has an invalid csum).

> Moreover, since we already have this issue upstream, do you think
> this new feature must be part this series or can we do it with a
> follow-up patch/series?

We don't have to add the kfunc to adjust / invalidate the csum.
But we should document how the drivers are expected to behave until
such kfunc exists and we should add a selftest that checks the
documented expectation.
