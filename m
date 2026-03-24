Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC320E702;
	Tue, 24 Mar 2026 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388407; cv=none; b=XlVvTUdkVYNxEUZqObmIL9+6D2hvGCso5AUXs5/Ii5qBXNirPrz945fkdgO+gIc4Z8I/yI9ItKK640KvDa0V+nvlcfI8IxQklFQM23Oubn2A+RJvidmJtBDMh60le4z0LXVrvZ2DY9O9VYIFGL7faA5Ir6ckMiX/t05tOXyyuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388407; c=relaxed/simple;
	bh=8v+dODJrBzNlvBVF4LvIA0u2R9gJvbmMW52sfGetRSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwPYGw8DJd/81uGHtHfdy7P2xHdS7UjbKeTOwUSvxowO/uqMr1T7RcwS3d6rNMA2m1X7/Bo3dT9/leuQu0Hu0c2WF+vWbBvYrpWU9LBIQam0v8i0tqpDscOnLSXDZzYAXUH59ptH7i1RTh/jJT1BeSdkIzoVdjKYUQGoXjKFIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY4JKY8p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY4JKY8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5E5C19424;
	Tue, 24 Mar 2026 21:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774388406;
	bh=8v+dODJrBzNlvBVF4LvIA0u2R9gJvbmMW52sfGetRSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZY4JKY8paN2tXqPjhtLxE6SRRcch7EYq/gR6KmAurcKWYknRh6ml2elZqkIL73rNs
	 sTuC8GN5pfDN3pkbmNlcI5bX4QfPJVCbIVHXWLV7wdiXkQyc5BerBBUQAg+eSJc5z7
	 KughY+TizI+71FAvSl/gmhRxnfX9UkhJhayRlHunfXzowWrYiaKcV7o1U8UWUc3vUo
	 8kV6T7wdTkdA5An9YLcnY4aWCIpbFHX3GeLvNdJGSqvgveRY+vJTMqLpAlGvzLZzxZ
	 LsGXUO1PPj5ecuE0Nh2cGYIVIznHLjO6Fr6xoFB0l3tOgu3Nhlkxogf4hFXtLfOVr9
	 7L4i1/3/LI6Ug==
Date: Tue, 24 Mar 2026 14:40:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v9 14/14] selftests/net: Add queue lease tests
Message-ID: <20260324144005.6fc51849@kernel.org>
In-Reply-To: <166265f6-119b-4b97-80bc-68b93364bf7c@iogearbox.net>
References: <20260320221814.236775-1-daniel@iogearbox.net>
	<20260320221814.236775-15-daniel@iogearbox.net>
	<20260323195542.18ea6ac7@kernel.org>
	<166265f6-119b-4b97-80bc-68b93364bf7c@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 10:29:16 +0100 Daniel Borkmann wrote:
> > Please look thru the Google review as well:
> > https://sashiko.dev/#/patchset/20260320221814.236775-1-daniel@iogearbox.net  
> 
> Haven't seen this on patchwork

We asked Roman to integrate but I don't think he has gotten to it yet.

> I presume to locally repro and work through the
> findings, its https://github.com/sashiko-dev/sashiko along with Gemini 3.1 Pro
> rather than Claude Opus 4.6 for review?

Yup, I have a sneaky suspicion that it may just be a matter of how many
tokens the model is configured to use. Cause IIUC it's mostly using the
same prompts as we do in patchwork, but it surfaces more issues.

> Either way, I'll try to set up and go through the findings for v10.

