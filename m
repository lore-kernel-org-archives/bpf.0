Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AA5699;
	Wed, 15 Nov 2023 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiDcn7Al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7179C433C8;
	Wed, 15 Nov 2023 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700040361;
	bh=ola6mLeFQVzgiULaIACvGqnS+C3L1wIoI8gY9SqISgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NiDcn7AltpXq7ukQh9imyz7mZQCIcvC6TXdBYmfF3fGQldRFIVH/U6OgC4woct8cc
	 Ra8MO0czJba4N3KTWUYEjb44qLzxkywKmjal6PfmtT+nWU59nqPND1aSgxoXzEpDOq
	 yYLmQrqSiMDaXheIQjictvL16ZrAYctzD7kEtTbdmb/SLVm9XgZShqx7oZy2POiYPT
	 /hTvHttCRq1t1/kRhhF/j4ORP0NiXkAcfyxf6Opi5OVBLPR47eEiiuPzO/wtfTFz/T
	 Cr8wzrR87myRlhy9mXJ+O/FCkgLTkZj4eUJNKGrETdagFXYfkuaIsxBD2idjOCAKqg
	 MvYclJwk/XzsA==
Date: Wed, 15 Nov 2023 09:25:57 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, kuba@kernel.org, razor@blackwall.org,
	sdf@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf v3 0/8] bpf_redirect_peer fixes
Message-ID: <20231115092557.GJ74656@kernel.org>
References: <20231114004220.6495-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114004220.6495-1-daniel@iogearbox.net>

On Tue, Nov 14, 2023 at 01:42:12AM +0100, Daniel Borkmann wrote:
> This fixes bpf_redirect_peer stats accounting for veth and netkit,
> and adds tstats in the first place for the latter. Utilise indirect
> call wrapper for bpf_redirect_peer, and improve test coverage of the
> latter also for netkit devices. Details in the patches, thanks!
> 
> The series was targeted at bpf originally, and is done here as well,
> so it can trigger BPF CI. Jakub, if you think directly going via net
> is better since the majority of the diff touches net anyway, that is
> fine, too.
> 
> Thanks!
> 
> v2 -> v3:
>   - Add kdoc for pcpu_stat_type (Simon)
>   - Reject invalid type value in netdev_do_alloc_pcpu_stats (Simon)

Thanks Daniel,

this is not a full review, but do confirm the changes above.

>   - Add Reviewed-by tags from list

...
