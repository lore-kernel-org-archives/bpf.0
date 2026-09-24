Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD9313E21;
	Thu, 24 Sep 2026 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261792; cv=none; b=NeyoaGrTJ2xFnxKamuw9UI62Su4ul0hWjUrA9GYINbbEJGl5JIQz34CP25vzOtRxGbkgZfjfxppyVcZXObsUT6wd57HlK2ASd6Mle70mOVmjnyHXwhkSJvLBbr5epjp6K7q02MBHw/5GETWqKYU9TDeXLpUU9PBxu6shzFzvUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261792; c=relaxed/simple;
	bh=Q5++KPiI6OEspv77pwWZFQVS9wnmhha9Jui80U5sxJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IagYKPlITq04eVEqvHDsLIUcQjZd8xipjbC0C/4l36rC1+amQkzGEdl6iEzOKeZl01TIS2ZKy5/3z5bvbavMTH5HKrmacFwP+bGGg44drB+utMePaKuqy6xRCBhjdTG6kF6HD+0lcZ2ZJ1Ohu+SqmdkcY1YpNlkWu/G910Lw+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9FeczoO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9FeczoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215F41F000FF;
	Thu, 24 Sep 2026 14:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790261790;
	bh=cEXRYGH6UH1XSNcDcsACpBrf+ZCvkDUnv4IVbop/I1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b9FeczoOueRPxKWk72HRM2aOKbTLXq/Ol2iImNtu31EBcpOWaqCMI0Rvy2UQhDOYp
	 6DuI0UZM0IjI8AHN6FZrI2x+rTsKkHL0SJWP3C5FPfuS7GdmkeTZGD8UFi49daFsRr
	 W8x7wabw0q2RUoIQUdaWz/ZTT3mqSnoRjqdC6DRAvKIz+WeX/62f3MaR5Fw+FXQSXl
	 kqwkt2LyHGpG+DvonKc1r2bj/MzflQxkS9H4SG9MUCbBUc71eTwcH06pegvVmj0FJ6
	 sv6ao9C9wpCUp98XWmt3Cm+l91hEFc21ZnaVoVp5VSW6mGxtppWSt6b+jajxHowEvo
	 w/S5rQ1+H81rw==
Date: Thu, 24 Sep 2026 07:56:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nazle Asmade, Muhammad Nazim Amirul"
 <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, ansuelsmth@gmail.com, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Disable queues before netif_tx_disable
 in xdp_release
Message-ID: <20260924075629.711760f3@kernel.org>
In-Reply-To: <47f7d038-3e14-45b3-be72-68c12e64dc19@altera.com>
References: <20260727030645.13280-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<1e258c0f-8663-4dfe-a0aa-7c8be67d6afe@bootlin.com>
	<47f7d038-3e14-45b3-be72-68c12e64dc19@altera.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 10:17:15 +0800 Nazle Asmade, Muhammad Nazim Amirul
wrote:
> Is this patch good to merge or require any attention on my end, please 
> let me know if any :)

The two Medium-severity issues reported by AI looked legit to me.
If they are not please repost and maybe add short reason why its
okay in the commit msg. Repost will be needed since the posting
we are talking about is 1+ month old now..
