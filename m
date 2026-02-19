Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02D34E743;
	Thu, 19 Feb 2026 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521227; cv=none; b=jRaOtiNQsNxc972QuN3hmHUzDVQR2Dnlizep1i3nFg88RxtUWVAwACAptnhVzbCfIo9LMfbjgpkBbLeO410mZxl8kpzQZm5waexf7YC9Q8H+L3e7M3VwU1S7KSOBck+Vr1swfmqQj0qVHfzNNOEam2WluwMXyXhWPVLriWhMFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521227; c=relaxed/simple;
	bh=uSNP3MgJa05tgGcM2PHS+3DfjpvUZxFcp68M0fm6gMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cinAxiwJpYaxej6VR+0GzbixRtOTUlARkrPPWh3ktBqmeLYCbTnm2U9/qQQLjSm0B9EEgIuQEiluot+oQRUlgJ7uQ04jDlS2/n4hzKPvqnWE3e38JC0bm9dFvUFSnhWJftM716BYPQHVqUObB549h2Z62+iVlwKpYECsqom7r+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBECWMXb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBECWMXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99FFC4CEF7;
	Thu, 19 Feb 2026 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771521227;
	bh=uSNP3MgJa05tgGcM2PHS+3DfjpvUZxFcp68M0fm6gMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YBECWMXb0l7YTspH/2A5O3YVGZH6sWYLy8DEUbYHZmd42ojMoLrQlGcLCCJMrL2hh
	 x+wP36x5mPRNiQ4YlwXCwC/juipG7QbBpRGokXKhMip0rb+zqeOyz1T/oyqvIsqX39
	 0uWM5uc3clsg6rObH0QWpBsHgl6EHjxydLfuQ8y75z5noUysamoKS2gFAR01od1G1Y
	 PgTXezyWl0CqUO+nYC9xJ+/p3WCbTnYD1J04ekQmer9tzg7Sw1gmJB6VQvUPRZySKk
	 heOGtRDTg2rnD4IQxpqSjHoTGMLaI1R6+dFrvzNnqVQa3aTn6B+/CDnUXAC+onTPQe
	 wmiBxtyJ7m7Wg==
Date: Thu, 19 Feb 2026 09:13:44 -0800
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
Message-ID: <20260219091344.1d8517f3@kernel.org>
In-Reply-To: <aZbuWBnmh_SQJyVf@lore-desk>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
	<20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
	<20260218174742.62a4074f@kernel.org>
	<aZbuWBnmh_SQJyVf@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Feb 2026 12:04:56 +0100 Lorenzo Bianconi wrote:
> > On Tue, 17 Feb 2026 09:33:56 +0100 Lorenzo Bianconi wrote:  
> > > + * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
> > > + * values are:
> > > + * ``XDP_CHECKSUM_NONE``
> > > + * ``XDP_CHECKSUM_UNNECESSARY``
> > > + * ``XDP_CHECKSUM_COMPLETE``
> > > + *
> > > + * In case of success, ``cksum_meta`` contains the hw computed checksum value
> > > + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> > > + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NONE``  
> > 
> > It's fairly common for NICs to report both csum complete and
> > unnecessary. Which one should the driver return in that case?  
> 
> Do you mean what is value for cksum_meta if we do not report csum_level for
> XDP_CHECKSUM_UNNECESSARY/CHECKSUM_UNNECESSARY use-case? (as suggested by
> Stanislav).

More fundamentally whether the API is right.

> My original idea is:
> - if the hw reports CHECKSUM_COMPLETE:
>   - ip_summed = XDP_CHECKSUM_COMPLETE
>   - cksum_meta contains the checksum computed by the hw
> - if the hw reports CHECKSUM_UNNECESSARY
>   - ip_summed = XDP_CHECKSUM_UNNECESSARY
>   - cksum_meta = csum_level <-- Stanislav suggests to drop this one
> - if the hw reports CHECKSUM_NONE
>   - ip_summed = XDP_CHECKSUM_NONE
>   - cksum_meta = 0

Off the top of my head drivers prefer reporting UNNECESSARY when they
have both, and reserve COMPLETE for cases where L4 could not be found
or is incorrect. Why don't we report both? We're using 3 args, we still
have 3 to go. We could turn ip_summed into a bitmap and have explicit
output args for both level and csum complete value?

One more thing I'd like us to at least have a plan for at this stage
is how to deal with COMPLETE + modified packet + XDP_PASS.
Right now some drivers discard COMPLETE when XDP is attached since
they can't be sure if XDP modifies the packet. Other drivers don't
and we end up with bad csum splat. Do we have a recommendation on
the correct behavior? If not - should we have a kfunc to adjust /
discard csum complete explicitly?
