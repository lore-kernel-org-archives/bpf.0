Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2433936C;
	Fri, 25 Sep 2026 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366445; cv=none; b=dbvVJciMOeXmj0x/m5uCL8RWinRnwlBZcaGkiaP/zPY/MGcuAV4ZbqvrbrQNsxsL+t5M7HY0Fp344mM5JJDOwfV14yUfHyJWizSnZqUaxwef3rj9wa5RzVjM7XvZ9QI4yJbSAMbI9O8aLGaks/bBC00kATwmMCvW9/stYTyp5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366445; c=relaxed/simple;
	bh=258aN0iU60ZiOhSJPJ1uFlNvHQ4PD2fYmazZ2JzZB9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFy+JwV9MzX+/cVl+L1SBnajmfPPy5z5hDDgaJbVBM9EugrSOHFvTd7Z34G0Pkt5+z83Fmo/jVzmsawngZ8aRZY/t13CKMGqEjP2D7cVsUEG1Zxdqu6HSiuRrW+/OU7A7zDsqOr7jUVWqjqtmiWALvokTBJYKVKqA4wrZq1JQ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnhefbCj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnhefbCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F601F000FF;
	Fri, 25 Sep 2026 20:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366444;
	bh=0Jo4jkxXowdPcStA4ouXArt1nCt64P5BTWQg3qWOEb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VnhefbCjt12d0GPCoJOZ/cVMHknpiKq3oB5FbVJljJ8+4yq6o7M6UbBtBNYkqGdiR
	 j9uALJGK77p3MsRmBDG/70tbAIqMD+t8+OeY+AQCateJn6d9PVqHdfYbMdbajytEo9
	 XpaUJ5l7ceo/511bzIsRUoEj4bdR7tgl4nkcVcnleznzLDz+p3YzbDpZJIcJDntxg2
	 6vSrIAHXDL8ntDNdD3QoZCtGpDBK69LzLjy+YQ8kbhDK1PE/TPHepohzzHJuk3oCrA
	 I5KQfByGO/GdEAcRnGXvYTRyonhJuYZZx+OFc0RSWj2B6eOwRUkFX7geACTtKLOUl3
	 hrYPkChjQnr2w==
Date: Fri, 25 Sep 2026 13:00:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
 <zhaochenguang@kylinos.cn>, <magnus.karlsson@intel.com>,
 <jacob.e.keller@intel.com>, <przemyslaw.kitszel@intel.com>,
 <jbrandeb@kernel.org>, <horms@kernel.org>, <kerneljasonxing@gmail.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2026-09-18 (i40e)
Message-ID: <20260925130042.7e20db0c@kernel.org>
In-Reply-To: <arZtNCWXQMA5Pm+/@boxer>
References: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
	<b67609c0-d640-47bc-b25d-d40bb59f237c@redhat.com>
	<b5e4e86b-356b-4ec8-b6c9-e5ef6a3b2d50@redhat.com>
	<arZtNCWXQMA5Pm+/@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 14:46:44 +0200 Maciej Fijalkowski wrote:
> On Thu, Sep 24, 2026 at 01:25:14PM +0200, Paolo Abeni wrote:
> > On 9/24/26 13:23, Paolo Abeni wrote:  
> > > It looks like clashiko has found a few serious regressions, worth a respin.  
> > I almost forgot: please note that the current expectation is for you to
> > address the clashiko comments on the ML.  
> 
> Okay, there is a bunch of stuff that are reported at early stage of change
> set which are later addressed - I thought bots are taking this into
> consideration and therefore would skip it ?

We changed that because people order their code poorly, break stuff 
and then fix it back later in the series. But, indeed, it should not
report pre-existing regressions if they are fixed later.

> Has the gemini LLM fell behind the others given that it reported no issues
> whereas gpt/claude produced way too much of output ;)

We probably have a better models but we fell behind Sashiko in terms
of the pipeline itself. There was a major redesign upstream, needs some
time to rebase across it.

> From trying to fix one thing I'm about to be in a place where I have
> refactored most of the rebuild path, which have been used without much of
> a problem for (at least few) years.
> 
> It is what it is, but I have a mixed feelings for where we're at, not
> mentioning where we're heading.

Well, maybe let's go the other way? Given Linus's recent complaint
can you trim this series down to just patches which address real
issues you are able to trigger? The bigger rework can target net-next
as needed.
