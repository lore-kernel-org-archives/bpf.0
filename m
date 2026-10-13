Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3951E3B3880;
	Tue, 13 Oct 2026 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888950; cv=none; b=CNl9+TGnslb+KKIpHrfMBl16Se2nS9PH5IGCS5JupR/M9IQFXeaAL2Fkln9AHnPYPaSBTxIbbsyAIAers7A6wPixMQoUUgqH0MOfNvu3cFnuyLafKbLBZx6ULW6+3dE3uM/w0lADZEyZiEQKuJ4HTXOrKVJwpiuR/83RWxf7dd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888950; c=relaxed/simple;
	bh=QkWkK5UBh6sejl7i2+FBqrV9V6Mas66Aq0n4y9xdxDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYP1RKzoAtyiRtG8/A4FZ2bnK69jAayZyU19yHucjImCXjFzNTvDfwImfETqzedtj7OyydoKmvE9IFlXeBw8XTohT+NE88s1TlobRFcws5GbfoKonYRoMTGNAKuuWkjVFH0IwVtREa2ggbr9mnYadKcP4H8A79XIpoOHEAayjuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMyBoF8s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMyBoF8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA19C1F000FF;
	Tue, 13 Oct 2026 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791888946;
	bh=YlQM1vo+xVHOnZS5ltwnkdgR6XoIDw8YEYSgv4HYeBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HMyBoF8sFuTODbmgFXCfrCXPPS4w6umjZojTVluIHWtP6NA4WS8RqJcFVcRgModND
	 YcVr+0eN/I/RqMtWkbrWD8Sk0dyGjVmqB8qyF4sbWTtBtq7h2rF01/efwbI85aDqwY
	 xJNab8jj8ZbhI8tVhCuE1VQbgQoW4cI+ykE+BRywrpxO2kg1WAbLq5eWbS2mcggZI+
	 vfZMH2Q7ns2orvKo+DSOL/+FZd8rAeKaVDxtcxWWqOYqeTYunzi9465DS3G0+kLaQ5
	 lhBOxOmkKqhQFq56IbYBBYT53QBCNe5VAQXjL/a57hLa/jWiwMJEhmFAAaejdcLGGF
	 a9FL32NalsdxA==
Date: Tue, 13 Oct 2026 11:55:41 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev-bot+sashiko@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, edumazet@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	sdf@fomichev.me, sgoutham@marvell.com
Subject: Re: [PATCH v19 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Message-ID: <20261013105541.GA83879@horms.kernel.org>
References: <20261006094357.840823-2-rkannoth@marvell.com>
 <179162646892.434549.7222119532595039059@kernel.org>
 <asxR6rpmf9b2by4O@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asxR6rpmf9b2by4O@rkannoth-OptiPlex-7090>

On Mon, Oct 12, 2026 at 08:50:10AM +0530, Ratheesh Kannoth wrote:
> On 2026-10-10 at 15:31:08, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 · High: 1 (3) · Medium: 1 (5) · Low: 0 (1)
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> >
> > - [High] otx2_sync_flags_from_rep() (otx2_common.h:625-634) updates the
> >   shared priv->flags word with a plain read-modify-write:…
> Pre-exisisting issues.
> 
> > - [Medium] The commit message presents this as a cleanup to atomic
> >   bitops, but the patch also fixes a user-visible representor bug and…
> This is side effect of the fix, not intended one.

Reviewed-by: Simon Horman <horms@kernel.org>

