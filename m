Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167E19D08F;
	Thu,  2 Apr 2026 03:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100150; cv=none; b=gHXWEA4BMjlExrxPwFu3JLh0L9kAboYe72OJgLYajQiayp6DqJEuOw1UO9j2btJFrOM/IHqXAoHNwCKG/gsMCwO/qzJmoJM/zfzm3i1QmUTemihdMtIkVuJsMw95MEKm+LoJGfRaA/W75k6BxcNLJ4po/eMEWucbPuJvgaw6VEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100150; c=relaxed/simple;
	bh=NhDizPiEmSIbGAGuGI1X+OtUkY9TDnMHcZJDxJXZdcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jztlXlYqBX+e7qaB30kfP+wGBOYkgs4rinmmsORL7eLVrtDHaGQP3ZeMRMbHC13ZjVANLFbLpaR3j+yEA+ub4kacIoj0V2HS7QVD2oXYkEzJ3H8W1AxA5/ZEb4NcFXrVjG5UsdzPW4ISpLK7l8OLwbmoaGKysORbMqehn8yGulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rUMzJ7Nq; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rUMzJ7Nq"
Message-ID: <6c1d6987-ca73-40de-adab-bc6f9fce67f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775100147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYveJD6LxHD6hKNngQokJ/HPFuXMnyoAnNnr+LysDbo=;
	b=rUMzJ7NqjEpjA/BUsJVc/rGqQOSQJXaRdiEhk9w3uf2igGz8YutUWH1KnQDJo+a9ShTsEd
	apmk9RSVh0FSmAjBi85mmZ5jOaksUw7rYY0ed11UtVyZZaqi01gBqx7aaZ4T1uyAlX0raw
	wkLJ5lgBSJ9ddi3ZedYWu23DAvT/29g=
Date: Thu, 2 Apr 2026 11:22:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] selftests/net: Add two xdp tests to xdp.py
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Leon Hwang <leon.huangfu@shopee.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260401052746.314667-1-leon.huangfu@shopee.com>
 <20260401132048.3a15601e@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260401132048.3a15601e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/4/26 04:20, Jakub Kicinski wrote:
> On Wed,  1 Apr 2026 13:27:46 +0800 Leon Hwang wrote:
[...]
>> +def _set_jumbo_mtu(cfg, mtu):
>> +    ip(f"link set dev {cfg.ifname} mtu {mtu}")
>> +    defer(ip, f"link set dev {cfg.ifname} mtu 1500")
> 
> cfg records the original MTU, you can copy this line from here:
> https://elixir.bootlin.com/linux/v7.0-rc6/source/tools/testing/selftests/drivers/net/gro.py#L88
> 

Sure, will use cfg.dev['mtu'] instead of hard code 1500.

>> +def _exec_cmd(cfg, obj, sec, ip_opts=""):
>> +    return cmd(f"ip {ip_opts} link set dev {cfg.ifname} xdpdrv obj {obj} sec {sec}", shell=True, fail=False)
> 
> We shouldn't need the shell=True where?
> Also it's probably cleaner to pass fail as optional argument here
> so that you can let this throw an exception in the cases we expect
> to succeed instead of having to check in the caller explicitly
> 

Right, shell=True is unnecessary here. Will drop it.

Will pass fail as optional arg to let it fail if fail=True.

>> +def test_xdp_native_attach_sb_to_mb(cfg):
>> +    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
>> +    mtu = 9000
>> +
>> +    _set_jumbo_mtu(cfg, mtu)
>> +
>> +    probe = _exec_cmd(cfg, obj, "xdp.frags")
>> +    if probe.ret != 0:
>> +        output = probe.stderr.strip() or probe.stdout.strip()
>> +        raise KsftSkipEx(output or "device does not support multi-buffer XDP")
> 
> May be simpler and cleaner to print the whole command separately:
> 	
> 	if probe.ret != 0:
> 		ksft_pr(probe)
> 		raise KsftSkipEx("device does not support multi-buffer XDP")
> 

Ack.

>> +    ip(f"link set dev {cfg.ifname} xdpdrv off")
>> +
>> +    probe = _exec_cmd(cfg, obj, "xdp")
>> +    if probe.ret == 0:
>> +        ip(f"link set dev {cfg.ifname} xdpdrv off")
>> +        raise KsftFailEx(f"driver unexpectedly allows non-multi-buffer XDP at MTU {mtu}")
> 
> Hm, TBH I don't think this sb_to_mb case is adding any coverage.
> Let's just add the test case below?
> 

Ok. Will drop this case.

> 
>> +def test_xdp_native_update_mb_to_sb(cfg):
>> +    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
>> +
>> +    _set_jumbo_mtu(cfg, 9000)
>> +
>> +    attach = _exec_cmd(cfg, obj, "xdp.frags")
>> +    if attach.ret != 0:
>> +        output = attach.stderr.strip() or attach.stdout.strip()
>> +        raise KsftSkipEx(output or "device does not support multi-buffer XDP")
>> +
>> +    defer(ip, f"link set dev {cfg.ifname} xdpdrv off")
>> +
>> +    update1 = _exec_cmd(cfg, obj, "xdp.frags", "-force")
>> +    if update1.ret != 0:
>> +        raise KsftFailEx("device fails to update multi-buffer XDP")
>> +
>> +    update2 = _exec_cmd(cfg, obj, "xdp", "-force")
>> +    if update2.ret == 0:
>> +        raise KsftFailEx("device unexpectedly updates non-multi-buffer XDP")

From sashiko's review [1]:

On architectures with larger page sizes, such as 16KB or 64KB on ARM64 or
PowerPC, a 9000-byte packet can fit entirely within a single buffer. In
these environments, the driver might legally accept a non-frag XDP program,
which would lead to a false positive failure here.

WDYT?

[1]
https://sashiko.dev/#/patchset/20260401052746.314667-1-leon.huangfu%40shopee.com

Thanks,
Leon

