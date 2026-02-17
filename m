Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E526B0A9;
	Tue, 17 Feb 2026 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366113; cv=none; b=S6IqI6RxF09Pf2fZL/jbG7CM7PYk1XLV/WGMXSlfHe5lmqJSNaL9KM283hE2Qa8ChM2XDWVKyTtIc3hwK/pvm2+IAq4QUeE7nR9FGGoc66CZ8aBIaGYH8aO+i1KCHxk5uRipOgVbZ7TaxrDuFXUPSsOL9H3960gZuTsjnp3zG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366113; c=relaxed/simple;
	bh=zIwCo0jmxFRZsEDqRMaqYmvvZJGYdVREl1QvazmykW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahyAD/TNWJZHBXfZlOD+F++aHElkibnYxwncD0GousW6Bq3djroqM/SHxdcapAeTIRZLzYPyyttdTmIG2J6pSRoT054EmoeNCafbhaKdu7icBvtM6fMacDKRTtMMqRfhvwKbp2R92BMjv05VUTSarkXkLGGvDVRGPxXsURZU/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KauAiK2R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KauAiK2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBCBC4CEF7;
	Tue, 17 Feb 2026 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366112;
	bh=zIwCo0jmxFRZsEDqRMaqYmvvZJGYdVREl1QvazmykW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KauAiK2ReggbudOBeR9PyyjDjf35pOp4E692h0tcwRcqMEXj12XKcnBpovTMmRpct
	 y/+Aoo9TzJIipsbvswhttNfTNV1vXkOWowlk9cPEQf58Qjc3fcJ4VCbfNIcWyU9Jik
	 grkXqP8Q5emSKuG9AbJFRbhV1EA5o51xTY7pvIvWexDk+1k2mNFb70sOhfTKCINzQf
	 XChkdpl7jGKx3d7HlEdW8FsuemxHfeMPON7Oclu7CiSzwRrP/F1+C/cWDtharDVmsm
	 TM6Tz+fGiobnpmRbwcmoh2XEl/QZ2liOtUYO2lSK+7j8VtRgX45CzjWqDClCWVt7YE
	 6LHdvi3/gZNig==
Date: Tue, 17 Feb 2026 14:08:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Feng Yang <yangfeng59949@163.com>, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v5] bpf: test_run: Fix the null pointer dereference
 issue in bpf_lwt_xmit_push_encap
Message-ID: <20260217140831.52fac4ca@kernel.org>
In-Reply-To: <6528c028-1224-4737-b902-e631641ddb37@linux.dev>
References: <249d6576-2259-4785-87b6-619052b4ce75@linux.dev>
	<20260211075240.70095-1-yangfeng59949@163.com>
	<6528c028-1224-4737-b902-e631641ddb37@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 10:08:29 -0800 Martin KaFai Lau wrote:
> > The reason for the CI test failure.  
> 
> Make sense, but the early point stays the same: the user-provided skb 
> can have unexpected data. Either an skb->protocol is not handled here, 
> or the earlier dst lookup has an error. I don't know what the current 
> active users left in lwt are. Unless there is an issue with missing 
> skb_dst() in other mainstream program types (e.g., tc), I would prefer 
> to add a check in bpf_lwt_push_ip_encap() instead of complicating 
> bpf_prog_test_run_skb() further.

Can bpf_prog_test_run_skb() simply not support LWT then?
Having fastpath checks for test harness really feels like duct tape
