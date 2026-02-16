Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9A2690C0;
	Mon, 16 Feb 2026 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771244337; cv=none; b=e9Pe3bXo9XBeHPexMokiF3Sx3ANwE20/BRo3APPRnZ1ZzIKUPLekFg7yjID5iEhjKe3J06Dgf9NdZsDojmivvsSzNtxaQS7iTwGpEg7JiJw/I3QcbampDxS1JJhXHT5IrHmp0nfdFJ13PRntpNcm2tuHcOncdvYg8EaPDrWw4Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771244337; c=relaxed/simple;
	bh=Hr6sWNozHcIqkYyQhJ753UqohgXVIZtkIn4+7uzTfok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4tLapRrBT9ND4mBdh3ZfugNhinOD3f6jh7OzSOEEwmQbAp01ALziAJUeUGmShJ/16etR2WPeYgqEYYOECQwNvwyJwsb3zVWTb0cvbdxCp3TG8nQNAfYJ++91gAckfWe5t/KjuOWGgWOXoHGGOu/9S4ay/QlGvmIPPbPOL21I7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iydi1NuJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iydi1NuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0117C116C6;
	Mon, 16 Feb 2026 12:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771244337;
	bh=Hr6sWNozHcIqkYyQhJ753UqohgXVIZtkIn4+7uzTfok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iydi1NuJLyQmwfBLduz7qcgfJ0i7MIIkdgYNPFV/pPY3E6fq+phL/izkA+oZRN1YM
	 +JzJL5EdfN/VQ8DkN9hUUwbj/POiQZTJFv1P31OCBkIQLW9OmGDOGXxtvdL0H9Ns2w
	 1RqVEX3+jQ7vBIu5Js2g+ZuP6pwVytZZYQINQgZCyHZfKm8fBMQhKUvzAoxwKKTwKE
	 pL2jD6TxCf6JPAV2XdVl7K8kZgCuEDes5+ryH6xjLFjTjX27e6fTGRqXINk4eLJQKp
	 QU+fFHD3aIfQXd7713p+Dz0Ciu+WX2UY+VmzdOmV6e9ulTSiyNz6o69WJNGSBDRERO
	 6/9/X7M3HKvvg==
Date: Mon, 16 Feb 2026 12:18:51 +0000
From: Simon Horman <horms@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] eth: fbnic: Add validation for MTU changes
Message-ID: <aZMLK7CVV6hSbUOg@horms.kernel.org>
References: <20260214171949.772493-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214171949.772493-1-dimitri.daskalakis1@gmail.com>

On Sat, Feb 14, 2026 at 09:19:49AM -0800, Dimitri Daskalakis wrote:
> Increasing the MTU beyond the HDS threshold causes the hardware to
> fragment packets across multiple buffers. If a single-buffer XDP program
> is attached, the driver will drop all multi-frag frames. While we can't
> prevent a remote sender from sending non-TCP packets larger than the MTU,
> this will prevent users from inadvertently breaking new TCP streams.
> 
> Traditionally, drivers supported XDP with MTU less than 4Kb
> (packet per page). Fbnic currently prevents attaching XDP when MTU is too high.
> But it does not prevent increasing MTU after XDP is attached.
> 
> Fixes: 1b0a3950dbd4 ("eth: fbnic: Add XDP pass, drop, abort support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

