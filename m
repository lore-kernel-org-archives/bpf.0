Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB122173D;
	Wed, 18 Mar 2026 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797362; cv=none; b=l9I0K32tjhhBK0+jBeuqWtxZJrm66r/wBW/gjTAwG6wWT8lBWnfUTpVleQ/ncuo+1Cs9o2SerePG/8op/rQtG2EuGQ7RE63bN19sbuDxtKp0Kk10n9MGuu6I6WtjzOANZudBJDugM/k33T7OKa3m883bFHvFHA5EXEznE4MJIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797362; c=relaxed/simple;
	bh=Dv+JEpBFgrAy98wW9koJXIR6zjsFbdTYTx/tYC2Gty8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3Rlqh5E3ckxdXIiELCfrys5iC+44wx+EZONGx0Og4yqN1ViWOmmuidiTf16evgyBVqdx8FuQoizKsOFrzv+UnS3N34f449KPCSNl+2aDwnWOo6Bk47w6eeLviK8DFmHAdXYI8rsyJqCjPEk6zOrtdFeyCV+qOAshWu4VOcGoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+GYD79H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+GYD79H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A7EC4CEF7;
	Wed, 18 Mar 2026 01:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773797361;
	bh=Dv+JEpBFgrAy98wW9koJXIR6zjsFbdTYTx/tYC2Gty8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+GYD79HnC/miwLDEG/EdHqCOG8EkZo4TE43F8DvWswodRwDJ17OxFkoe+qA0l9Bg
	 Z5Q605f4vtIL7R/VXiIpCgkyTH6LRG0BHFsJ1uwWPjqs7kXECHJXYQRiV+ctAtMSac
	 IWua7LDNZjH7bGQA7RfeVvcbSVntUrjnt3lrwo/vjovrIOXabamWRrU3/3zdFg9Pc+
	 Q5xD5j5YiXk9NG3Q/YSnBNXQzSKuCUh/+IkaK/8R0vwjiBht1IZUmb97KhT8SGWInv
	 ESiZkH62C8kvqUSRebfqcIDZE9IoK4mob22jbjGlpfI4GsGrPNA+D2i2NJ0XppJyNy
	 qLGAesRMmmbqA==
Date: Tue, 17 Mar 2026 18:29:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
Message-ID: <20260317182920.3f4fd8eb@kernel.org>
In-Reply-To: <CAADnVQLZOUMGxNDwxhRzfx4finsF3aua31cggKpgTA6h0pjgAA@mail.gmail.com>
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
	<20260316171200.4b8a96a0@kernel.org>
	<CAADnVQJ=nryHHb5A3r77H6dzg=vzC97eHe8mCeBA=BMxa=+P5Q@mail.gmail.com>
	<20260317152045.58c719a7@kernel.org>
	<CAADnVQLZOUMGxNDwxhRzfx4finsF3aua31cggKpgTA6h0pjgAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 17:57:32 -0700 Alexei Starovoitov wrote:
> > > Do you guys need it in net-next in this merge window ?
> > >
> > > We have nothing in bpf-next/net so far, so should be fine
> > > to take this patch into net-next directly?  
> >
> > Somehow __xsk_rcv_zc_safe() landed in bpf-next/master f620af11c27b8ec9
> > So I think we have limited number of possible moves now :)  
> 
> I wasn't paying attention. We can revert it in bpf-next and reapply
> in net-next and probably route all future xsk patches to net/net-next ?
> since it doesn't have much to do with bpf anymore.

Maybe we should defer until the merge window and let it sit in Maciej's
local tree for now. It's a tiny optimization, Maciej can resend in the
next cycle.
