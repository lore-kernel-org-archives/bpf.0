Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F726F293;
	Tue, 17 Mar 2026 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762627; cv=none; b=FBCZJF93bCTvI7xY0dXnySeX+XUE6jsnmh7o4Xu+iM6V+Pdrdu+mgO4EMkR0K/LF7Sdduf+idIm+xJPZBrU4u7POtDJJVQI4V0rKqm0QTHLkY2n5VkkSJQMhIV5hfRnrsNrQaTrAVMFbcQghuuwfWdqB/fWtoCnWOUG44ipqq+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762627; c=relaxed/simple;
	bh=HCwVp7+lOBovxuC973RVOpigY41qLdZOHjba578u8Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9b+X2+PXG3eQg9oCvlB+VOFeqJk7F+j4TtNZOw2rYj0bZDvdiHXsBpWZXYwLYZaWGBal4kbf8FUn8cWFdbsFrDD6mcqi9ZvqjlBeE8zmpfUChsgABtbiGdRkhaHaa3HGddf46YozkRP/B1AaNsI48+wVnSnwquSdEVVUgP5BOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAA//BHw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAA//BHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012AFC4CEF7;
	Tue, 17 Mar 2026 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773762626;
	bh=HCwVp7+lOBovxuC973RVOpigY41qLdZOHjba578u8Vk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dAA//BHwK7ycYboaUTZKCLJR3naxTVJLH9Mj/84DNRmAAMC6f5cZHt1JA2bCb6ozE
	 wx/9ISxSFb5ddul2gw0cOUmSAxl7/XvSb6HNjembVxAK9NMsCC34FJNeukf39f/kFO
	 QvZRJkb7h8eNCEcSgaHdYnGBSS/PPG9edVy0qGvegacIiO7thjc59wDzGlhqTrKVP3
	 Gf+XgP4LmrK02iEeB8O1rB8oVF0Rif4i5gMGQvHFxxqF4xg1YKkqcUxmDYr46iD9Gm
	 asuthqNejYVEyzrG3UxZGStYqXGzKXLZXWmW8BVaY5Dv8kv0XeGMAKYzFwSStVJLw2
	 Q2ymQ2HfShoBw==
Date: Tue, 17 Mar 2026 08:50:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: <anthony.l.nguyen@intel.com>, <horms@kernel.org>, <edumazet@google.com>,
 <sdf@fomichev.me>, <aleksandr.loktionov@intel.com>, <ast@kernel.org>,
 <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <hawk@kernel.org>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
 <magnus.karlsson@intel.com>, <pabeni@redhat.com>,
 <jacob.e.keller@intel.com>, <daniel@iogearbox.net>,
 <maciej.fijalkowski@intel.com>
Subject: Re: [net-next,3/5] ice: migrate to netdev ops lock
Message-ID: <20260317085025.6459821c@kernel.org>
In-Reply-To: <a95fa7f2-909e-4b1c-b25a-1ee88b292ecf@intel.com>
References: <20260310220624.537917-4-anthony.l.nguyen@intel.com>
	<20260313014628.1509116-1-kuba@kernel.org>
	<4537e162-6610-4c3f-b8d5-e62415322282@intel.com>
	<20260316161630.2d9ac04e@kernel.org>
	<a95fa7f2-909e-4b1c-b25a-1ee88b292ecf@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 16:30:26 +0100 Alexander Lobakin wrote:
> BTW, if it's not top secret, how do you run these AI reviews? Because
> Tony used the same link as these reports provide to deploy a setup, but
> we didn't manage to get as meaningful results as yours. That's why
> several respins of this series only due to your AI reviews, sorry =\

Nothing secret, I didn't push it to the main NIPA repo because it
mostly vibecoded crap which is embarrassing. You can see it here:

https://github.com/kuba-moo/nipa/tree/air

It is just Chris's prompts + semcode. We run the prompts with
sub-agents enabled (the "orc" prompt). Right now it runs on Claude,
the subagents are supposed to pick the model by themselves depending 
on complexity.

I don't think we do anything special, if anything it's probably the
mode (orc mode thing) that makes a difference?
