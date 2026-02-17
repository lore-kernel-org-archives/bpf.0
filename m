Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45C3246F3;
	Tue, 17 Feb 2026 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771371566; cv=none; b=WTF3UldzKNybHZYf5LHFxxuLsmIeHm8C4lrBYCkfAP20UWddHqwjKywdFbfNBKuuu3x9WYpWyvLFjAYXchCFmkdtnKCld9VYPqAQoEbTvj55phbFFHcN7KKT2uKq2nTxizorAXU5cwJZFqqtpAXrYfnzQfTosRNL+LwKTxbDeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771371566; c=relaxed/simple;
	bh=jH5cv5yobD1Hl3ed844CW4T/8eokkPla+TCh0fbSBzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0HY1Edz0NsHwBrgFTsZISSb/Dsf5A0WFZMLWaEvSpJTndmmPlY7rs5d/m4XSnVBQW0TOsYmNWniOBLG2/kdM3EHakHXwsfo/PawlagdvBLAaXCF7HnXtdpsvc6apQS963puIe9usNxJeM1Vg2cqQYGlStDXFwj8hUrcoUAVP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvtUy++1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvtUy++1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1FBC4CEF7;
	Tue, 17 Feb 2026 23:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771371565;
	bh=jH5cv5yobD1Hl3ed844CW4T/8eokkPla+TCh0fbSBzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nvtUy++10NDtbMGGOfgIfzqsa/VwitRvqq5/6ZxO30aJSY+s/GDDkLWkq1GtJUqpd
	 E4TFFCTdwVcQxJe5v0YaTNGlxvoWmmp2KsKyzDx1rLFILHlmdQYgnjL2YXaXQFmgjO
	 iYohMWKNaLK8hzJ0rwfkzQZ6ZuN++kfO64LmYrYZoh5IZCtY+PLK6H1UkVkk/S1br2
	 zI07FTL+u2vc6JZ0l8Jwil38tbWeF/g4XFhilsnFgoDew4bCOlswuSJ52liofM3ehe
	 xDM9BUHHDozk4cy/K88GSE3UifKDLkzqhhyjGaT1dG/yxGC7712Zcd1j5HIESg6Spw
	 Vd043lW59FPEw==
Date: Tue, 17 Feb 2026 15:39:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Feng Yang <yangfeng59949@163.com>, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v5] bpf: test_run: Fix the null pointer dereference
 issue in bpf_lwt_xmit_push_encap
Message-ID: <20260217153924.33391554@kernel.org>
In-Reply-To: <1bc24867-edde-408e-ac1b-2ca2a41622b5@linux.dev>
References: <249d6576-2259-4785-87b6-619052b4ce75@linux.dev>
	<20260211075240.70095-1-yangfeng59949@163.com>
	<6528c028-1224-4737-b902-e631641ddb37@linux.dev>
	<20260217140831.52fac4ca@kernel.org>
	<1bc24867-edde-408e-ac1b-2ca2a41622b5@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 15:26:33 -0800 Martin KaFai Lau wrote:
> > Having fastpath checks for test harness really feels like duct tape  
> 
> Adding route lookup on ip[v6]_hdr does not work well either and is a 
> larger duct tape on the test_run_skb side.

Well, maybe to clarify, the responsibility of the test harness is to
generate valid inputs. Whether it's hard or not to address this issue 
in test_run_skb is a less fundamental than whether it is the correct
place to address it.

> An option is to always set skb to 'some' dst (loopback or 
> ipv6.fib6_null_entry) on all is_lwt cases without doing the lookup. It 
> is only to get it going. It is a duct tape also imo but maybe a middle 
> ground.

Sounds reasonable to me, FWIW.
