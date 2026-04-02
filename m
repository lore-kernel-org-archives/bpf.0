Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2562D0603;
	Thu,  2 Apr 2026 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140522; cv=none; b=RV9byVoqZuAe5zEaiEeKSvUdbQkKVAOyOyTtEpT1n+poyyJBawwfWNcTdG/jyhnGKGBIYSXWz/T92RdMIQp5vOr7sV/4J+HBLf+uESA4Ubhco7+6aR55CN8G7vH+XWQSn1BxTbRuIe1qw8pEXkzCP8qYaf9Xr0jPkldAt/0ElaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140522; c=relaxed/simple;
	bh=Ehxrl/qgHg9vBeDxMprCB7n2Uvojn/WK7PPS3gbJYeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSrCpzMAg1/biB6498u9vjr+/XNlzNks+laQK3EaMLTAwoaOujElN3yOAhYTwh2ZHJPglP5pVPTCoQNJ65H5o18CG11gKg0Vp/7Vc6pqD9ALyArwEvMJ4Q/XFb2a1LKSSIOc8W7jFaLmp78aKEf3e1Y6H8NC/+C/nEOjlrDD/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiunMrka; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiunMrka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90091C116C6;
	Thu,  2 Apr 2026 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775140522;
	bh=Ehxrl/qgHg9vBeDxMprCB7n2Uvojn/WK7PPS3gbJYeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hiunMrkaAWdLyhJiicbHDYHGMgx9FVWLxhMJombymF+QtBSKfB/SLKmKRTxmzb/Pz
	 JGmkTsvxvsIJFUwgMTkZ2i/sbh55iY2CfC6hHiP/UdLgLNfN5c4SSuGMkV0ehhvIhy
	 oaV+H5aR4tlMI1E5kuzHQsFSq34EylEQY71iqYur19GW6ZMIE5zS1Ou+FZGbkgbh/7
	 +PDeiLvWUMRUomBsIjh6yTCWhqSocIxdhmc+jTMy4zhsHjuA1P20HdlzfuF2EyqTv4
	 z7Tcle4m9m75f88ha3TeJjTeA3vwx99wFrTQjsVQuGiLl1YoXhKrpajZYQi7UJ+yy9
	 aCUcIakwqUUTA==
Date: Thu, 2 Apr 2026 07:35:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Leon Hwang <leon.huangfu@shopee.com>, netdev@vger.kernel.org, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah
 Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] selftests/net: Add two xdp tests to xdp.py
Message-ID: <20260402073520.697dde02@kernel.org>
In-Reply-To: <6c1d6987-ca73-40de-adab-bc6f9fce67f6@linux.dev>
References: <20260401052746.314667-1-leon.huangfu@shopee.com>
	<20260401132048.3a15601e@kernel.org>
	<6c1d6987-ca73-40de-adab-bc6f9fce67f6@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Apr 2026 11:22:15 +0800 Leon Hwang wrote:
> >> +def test_xdp_native_update_mb_to_sb(cfg):
> >> +    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
> >> +
> >> +    _set_jumbo_mtu(cfg, 9000)
> >> +
> >> +    attach = _exec_cmd(cfg, obj, "xdp.frags")
> >> +    if attach.ret != 0:
> >> +        output = attach.stderr.strip() or attach.stdout.strip()
> >> +        raise KsftSkipEx(output or "device does not support multi-buffer XDP")
> >> +
> >> +    defer(ip, f"link set dev {cfg.ifname} xdpdrv off")
> >> +
> >> +    update1 = _exec_cmd(cfg, obj, "xdp.frags", "-force")
> >> +    if update1.ret != 0:
> >> +        raise KsftFailEx("device fails to update multi-buffer XDP")
> >> +
> >> +    update2 = _exec_cmd(cfg, obj, "xdp", "-force")
> >> +    if update2.ret == 0:
> >> +        raise KsftFailEx("device unexpectedly updates non-multi-buffer XDP")  
> 
> From sashiko's review [1]:
> 
> On architectures with larger page sizes, such as 16KB or 64KB on ARM64 or
> PowerPC, a 9000-byte packet can fit entirely within a single buffer. In
> these environments, the driver might legally accept a non-frag XDP program,
> which would lead to a false positive failure here.

Yes the test is indeed not checking all the corner cases, it should be:

	# set mtu to 9k

	# try attach xdp
	# if ret == 0:
	#    return // must be 64k pages or something

	# try attach xdp.frags
	# if ret != 0:
	#    raise SKIP // driver doesn't support multi-buf

	# defer xdp off

	# try --froce switch to xdp
	# if ret == 0:
	#   raise FAIL // replace is missing a check
