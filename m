Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2134CB5B
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329378; cv=none; b=qo677RD5STfLMP+2/UILkfAnBk36tDKzfObjGBleWZM/+SgB3RFoNjyaUcKp9bVPGESluU7NxSxb5Tdy7IFPU1VHLOnwHQas0OJPDcT/DGp6B4jQJeom1PHzyO29D3PQtKR51weDjO9SszCcyG8qPamFfLyUDTWfDUuVz2e09w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329378; c=relaxed/simple;
	bh=MnOzzzamYXiwghHrVckJNVajr4kLMULxSd8oeLokv0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar1uZNpMXV/cg7BKvPqy88T4ykd2uTqmT5kLF08O6gWqjZNyuq/PdeipqbZhHUH9jXTyVrLJ8+qnnua2OQirK/edzM0QFeDKRE1MG9cMlojCfl2lCSH3uqoEZXcaxW+6O39dyenq+Wa51vRAl2CibOwyAFyNbLHCTsG6QOBQZww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=npN4mFu9; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="npN4mFu9"
Date: Mon, 27 Apr 2026 15:36:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777329373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LsQU2/LjFk+qRAd2b5lbs1cknpmT2BXH5jVMeLp8gG0=;
	b=npN4mFu9PZrqDAG0R8FzMVWqfso7n+haulHAzPTGd9Rax1uBCE5S/e/on4S6r+8qovHxsa
	5JNXDhWy0RnO5IQBexuNjeIv5Wcg68hyBJprcoXHFGKpzrnTcm4MAPmjcpwZjLCMtAwuO5
	/Sm3VA3mUeZh15hz1Jcju3Yft/En86U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: nhudson@akamai.com
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v5 6/6] selftests/bpf: tc_tunnel validate decap GSO state
Message-ID: <2026427222011._PrH.martin.lau@linux.dev>
References: <20260420104051.1528843-7-nhudson@akamai.com>
 <2ea5cc41fd138e94dc34b1d4073833118b93ae48d802aabe480e355e27417b62@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea5cc41fd138e94dc34b1d4073833118b93ae48d802aabe480e355e27417b62@mail.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 20, 2026 at 11:19:30AM +0000, bot+bpf-ci@kernel.org wrote:
> > +	if (!shinfo->gso_size)
> > +		return TC_ACT_OK;
> > +
> > +	if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> > +	    (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
> > +		return TC_ACT_SHOT;
> > +
> > +	if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> > +	    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> > +		return TC_ACT_SHOT;
> > +
> > +	if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> > +	    (shinfo->gso_type & SKB_GSO_IPXIP4))
> > +		return TC_ACT_SHOT;
> > +
> > +	if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> > +	    (shinfo->gso_type & SKB_GSO_IPXIP6))
> > +		return TC_ACT_SHOT;
> 
> Are these IPXIP4 and IPXIP6 checks reachable?
> 
> Looking earlier in decap_internal(), for IPPROTO_IPIP and IPPROTO_IPV6
> cases, the function only sets BPF_F_ADJ_ROOM_DECAP_L3_IPV4 and
> BPF_F_ADJ_ROOM_DECAP_L3_IPV6 on the flags variable (around the protocol
> switch statement).
> 
> Because BPF_F_ADJ_ROOM_DECAP_IPXIP4 and BPF_F_ADJ_ROOM_DECAP_IPXIP6 are
> never added to flags, wouldn't these validation checks always be skipped?
> 
> Ref: https://lore.kernel.org/bpf/20260416124324.B0CE6C2BCAF@smtp.kernel.org/

This comment has been mentioned again. It seems legit. Please don't ignore
the review comment. Otherwise, it will be assumed that the solutions are
being worked on and patchwork will eventually archive the patches after
some time.

Also, there is a 'SYS(fail_close_ns_client, "ethtool -K veth1 tso off");'
in prog_tests/test_tc_tunnel.c. Is the shinfo->gso_type ever set?
What will break if tso is kept on?
