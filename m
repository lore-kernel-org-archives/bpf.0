Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669426059D
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769986420; cv=none; b=gJu+sxQoVjCyN6WZg2P+u09VKMjpbC/HEgTuDaX6aD92JSpjw6Ylh93HQAWdWD9/zGlXmGIk1OvXgsJwXEcG5PsDFqPvW70Y5w9DYzp6dsujwjR93ZhbCIxu2NxmRtUeZXZB/Nlsk/rOZyrKRdxQCvJ2A8Bfa0/1aDG9lIYZPdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769986420; c=relaxed/simple;
	bh=CrC+rKWsS2jD6qeUjy96CEbcTrpLD3RqSEyk2wV9/Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cus2yW2ppnhgZ2sC8kc4GFtNip6IwxrbdFixzHuyi1SASMKY4sejqn5AhxDBdvi6Fh9YP1LuPf5BK59FJP1TEZlVtm7VRC9uzujeUsbRSEVE2YoiIa+bOREzz1TjuW4aLy377ZNzvrvjvc05w4F/MC5fSZeCTjaz1PpKB5Qxl/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=FTQTVCi1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="FTQTVCi1"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so2519533a12.0
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 14:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1769986419; x=1770591219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ofW7TCsaw7TZuldCfLGa04IbT0KJlBm0C6e69TvwmdU=;
        b=FTQTVCi12AP7WW6gZYGuHa/4wH3RuQG7Sv//h1XRgombVCmo0Y7tCcIIlCKG/rvgYs
         sZJBaIzkpXjX3SNiBsfKFu44QQp22TsC/JuvZrFe1Ao5P01RtKNBnDpkkXOuTVzT8uum
         /FfQcRp9LHSKugS9BsjbW2ynBdPQAm0PX5yFXDiqeWCVtU/GN0nnVt+HPLZ9IYWWgo66
         apj0E3GnkF+Pa6BDZsWXIuCnRHlXO2GMgUGpnQGi6IzYrpagaI0bHfRWzLf/WbdlgP6A
         uajoHC0KSPCY75usnlFFb81kKFVKFpLutzr91QUoMcBQRQsLscXMEzwXK7Lk1fR4uh+R
         CD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769986419; x=1770591219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofW7TCsaw7TZuldCfLGa04IbT0KJlBm0C6e69TvwmdU=;
        b=iNzFvAd/mu+Krhdq2ZBCMufaIXP1i+X7vFuEaTumknsp3dScsRjiYJZb3GRvLLxxiz
         DRKQ+9L90BFnRWNxyWnkdbTk0DslocgqH9cBDwkMiye6pm2vsvnvr24CnKI0IcB9fPIj
         K6w2VcvXohN+x/JMVvuzDtngLu2K9p4DL4CaneEQH48nSI7MXcHq5GVwMIzMY0ip6Kr5
         2hbBLAl3R14A9Lw4VxvYCueMKQb+2ihdVH5iSgdtBCBVNVq3Uujxve65K9tMPhvAmSjp
         OCRwvcWG5PO3sp9xwIjP3Mo41DhKpCMV4JUdOkMG3jikkFiXi550vCn9pfv+qO0T8aVt
         kIPw==
X-Forwarded-Encrypted: i=1; AJvYcCVkcj+xQL/rI+MsdnjOuJ7a2KQs9MscR2rjrSF7djZbnS247mVmaSX0FNenBDAD9uP8760=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR/UE1pyJ7NsqDWqmwFiFypKs1LbzdF5DzSxMJGK+EuLOeSnz8
	BuXUl/sagKl7Gw+KmiP+FRiF6KfzTuvK+51qM5Ndiaa0tu8ysOxxGrNAoxQx04GRuPA=
X-Gm-Gg: AZuq6aIWE2ard12HNdux2Ry3uNFFzYDKrLvlKeCqI2kW6z6BXm9cIZoDEtm11FLrt8R
	LmCXu/mcISV8PFlJZjMHzmkn/JCjlPaBb6GVu69ObCWxuf5v1mkmZpUeHrOvebbn5t7Fq8ehpTw
	VlMMekhYQoUTW3PTR47QY9APF5GK6VBrATvoOszPbwkdmXF8k6hSsE8k0F+V188ooD6qjtO6cob
	MTLqQaCLgLneohkfQem2rxi7Kn4udAyCLG80/+ia/gxRB8Pra7zbKeGDonZDV2fbSI4qK53JPJ/
	JUDwFWxIuFFqKCeReamvC/QoHIOidcEm9mD+/lCL24v92k237YYUUk8z5czMgvU5haScwLbuKSV
	QY1mWHPg/p4K7jk3Dkx/xrngqZ/0z/5FnyCnwcbTNZ6oBih3PcYWxKfmrv0aiE10Rh9WHe+qq+n
	7V3wIGMufkgzcrd5mA/F74tP4KZmEbqmptKllo+0BNzVtGjmmjDm4gM9ck9GAA/bMM8BfBk2miy
	leyEIVHJrHiIpy0tQ==
X-Received: by 2002:a17:90b:5587:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-3543b3cdd14mr8839548a91.34.1769986419054;
        Sun, 01 Feb 2026 14:53:39 -0800 (PST)
Received: from [192.168.100.174] (p94025-ipoefx.ipoe.ocn.ne.jp. [153.246.129.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f3ed0dasm12897942a91.14.2026.02.01.14.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 14:53:38 -0800 (PST)
Message-ID: <9037828b-c7fd-4eb1-9dd8-19ee49063361@davidwei.uk>
Date: Mon, 2 Feb 2026 07:53:34 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 15/16] selftests/net: Add env for container
 based tests
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-16-daniel@iogearbox.net>
 <20260131163834.2c3d160d@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260131163834.2c3d160d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-01 09:38, Jakub Kicinski wrote:
> On Thu, 29 Jan 2026 23:28:29 +0100 Daniel Borkmann wrote:
>> +class NetDrvContEnv(NetDrvEpEnv):
>> +    """
>> +    Class for an environment with a netkit pair setup for forwarding traffic
>> +    between the physical interface and a network namespace.
> 
> A little diagram would be pretty awesome to have here, and perhaps copy
> it to the README file too?

Sounds good, I'll add one. I forget how much you like ASCII diagrams.

> 
>> +    """
>> +
>> +    def __init__(self, src_path, rxqueues=1, **kwargs):
>> +        super().__init__(src_path, **kwargs)
>> +
>> +        self.require_ipver("6")
>> +        local_prefix = self.env.get("LOCAL_PREFIX_V6")
>> +        if not local_prefix:
>> +            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
>> +
>> +        local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
>> +        self.ipv6_prefix = f"{local_prefix}::"
>> +        self.nk_host_ipv6 = f"{local_prefix}::2:1"
>> +        self.nk_guest_ipv6 = f"{local_prefix}::2:2"
>> +
>> +        self.netns = None
>> +        self._nk_host_ifname = None
>> +        self._nk_guest_ifname = None
>> +        self._tc_attached = False
>> +        self._bpf_prog_pref = None
>> +        self._bpf_prog_id = None
>> +        self._init_ns_attached = False
> 
> I'm not a Python expert but the pre-init of variables that are set
> later on in __init__() (on all possible paths) seems like a waste of LoC

It's so that exceptions thrown -> __del__() don't complain about
undefined vars.

> 
>> +
>> +        ip(f"link add type netkit mode l2 forward peer forward numrxqueues {rxqueues}")
> 
> Would we be able to do this with YNL?
> no big deal but always nice to avoid the dependency on very latest CLI

Hmm, I tried looking into this already. My understanding is that this
can be done in C but not currently in YNL, not without adding a spec.

> 
>> +        all_links = ip("-d link show", json=True)
>> +        netkit_links = [link for link in all_links
>> +                        if link.get('linkinfo', {}).get('info_kind') == 'netkit'
>> +                        and 'UP' not in link.get('flags', [])]
> 
> And of course if you use YNL you can actually ask Netlink to
> echo back / return to you what interface it ended up creating.
> No need for the scanning..
> 
>> +        if len(netkit_links) != 2:
>> +            raise KsftSkipEx("Failed to create netkit pair")
>> +
>> +        netkit_links.sort(key=lambda x: x['ifindex'])
>> +        self._nk_host_ifname = netkit_links[1]['ifname']
>> +        self._nk_guest_ifname = netkit_links[0]['ifname']
>> +        self.nk_host_ifindex = netkit_links[1]['ifindex']
>> +        self.nk_guest_ifindex = netkit_links[0]['ifindex']
>> +
>> +        self._setup_ns()
>> +        self._attach_bpf()
> 
>> +    def _setup_ns(self):
>> +        self.netns = NetNS()
>> +        cmd("ip netns attach init 1")
>> +        self._init_ns_attached = True
>> +        ip("netns set init 0", ns=self.netns)
> 
> Hm, refactor class NetNSEnter or just use its enter method?

I did consider this but I didn't feel like it fit the very specific
purpose of NetNSEnter. I needed the init ns to have a valid nsid from
within the test netns, which I didn't think many other tests would need.

> 
>> +        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
>> +        ip(f"link set dev {self._nk_host_ifname} up")
>> +        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
>> +        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
>> +
>> +        ip("link set lo up", ns=self.netns)
>> +        ip(f"link set dev {self._nk_guest_ifname} up", ns=self.netns)
>> +        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=self.netns)
>> +        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
>> +        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
>> +
>> +    def _attach_bpf(self):
>> +        bpf_obj = self.test_dir / "nk_forward.bpf.o"
>> +        if not bpf_obj.exists():
>> +            raise KsftSkipEx("BPF prog not found")
>> +
>> +        cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj} sec tc/ingress direct-action")
>> +        self._tc_attached = True
>> +
>> +        tc_info = cmd(f"tc filter show dev {self.ifname} ingress").stdout
> 
> Don't we need to also add a qdisc if there isn't one already?

Sorry, why would qdisc be needed? The bpf prog attaches to tc. I don't
know anything about qdisc, though.

> 
>> +        match = re.search(r'pref (\d+).*nk_forward\.bpf.*id (\d+)', tc_info)
> 
> I haven't checked but TC doesn't support enough JSON and YNL doesn't
> support enough TC to avoid re hacks? :( :(

Yeah the old TC tool doesn't give me this info programmatically :(

Borkmann mentioned TC is outdated/unmaintained. I did use tcx via a C
loader before, but that was removed in an earlier iteration.

> 
> 
> As I mentioned to David in person, Wei Wang also needs to use this
> class for PSP tests so would be awesome to detach these from the large
> series. I promise to prioritize the "detached" bits of these series in
> case you're worried about the MW.

I'll move the env, basic ping test out. Then keep the queue lease tests,
adding the error paths you requested, in this series.
