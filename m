Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CBF38A9A6
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744624; cv=none; b=s02puOtv3sK1kb2/6sUAHqEhTc8YmfA0WX1O8dDSHgisKV94H55HplH2q6Pxlryo2gxDnWUGsC0p0mVVnnisddpVLi8vvHRLDYbR9rJgfTv1yjgf7OE3dM9HyPyFgtGUdUkHbfcopdQXfF4pxL/1Cg2bnohEjNRcU7SuUHQi+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744624; c=relaxed/simple;
	bh=h4SUjAC1/+1WI5l2vmSlYY/nKJfsmyvesTsuCN94dpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hxd9+ih2GTSgn8KXME2dFN0Rt1VNLSMcwPYm0FuJGtk7GkDoEPCIjCe8zczIlOmeGg5xQ7+KDvSw6OGel21wNNk4nGmazuT5WBtrdjJeFA33Fp6tbXr92pQmXLc+GSS3ohDNMqvBbrRI2xxSrILv94Bzg/g738xQ1pTcyrNTfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=NdqUEyUi; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NdqUEyUi"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12721cd256bso2537230c88.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 09:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1770744622; x=1771349422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uij+yze6+KWtPneIeRHK7BdEXls9H9TrWBaPlCemb3w=;
        b=NdqUEyUihUBWcyrk1wlON1+l0HMKekiKBUYUFH0+/Fr4pAiQMDmyEptnN8YXT0b948
         TS5/3osFxV6DakCjmOzK1x9qHqU79BR+ALthxqTcTOHMgN3EmV44P69seYit5RcOXc4z
         /LTH5+ppnNy0rnWLoziqsH9d+q3VnmbLjR533Dsq+c2bjWT3EY0BCzG9BLmQqe+b4LQ6
         TSeBWmMN6xOIilcGM4+/Ip2ftRrSvgrhfXFVcOTex2fZy/Kx2fdFV6YLCkUaqTyT4e33
         4lQ6Zs42v6HrZtqu9Qc1cz5zir2BhB0miB+F59JX5DmzcY94MBzPqCH13pSRmdMfBxX3
         /zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770744622; x=1771349422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uij+yze6+KWtPneIeRHK7BdEXls9H9TrWBaPlCemb3w=;
        b=RePcslVTLcMWrBTlbvTis7gVxYVN/bLPij0dfx6NU9JizhH2B5Vlx3iPyF4Zvgd/RJ
         d5I6TRP0uMlQ0OvGlmsUbk7vjbVgmsWFRd5xUS6a3yOJ0NiY+k29O8yiNF3U2hc/nWTD
         2kLzzTArTPS7/b+gN9kcxO4f5IzCuRHoCH2TmCJaPt33giXofPYu6UBCqsFigIcUhLHR
         RWm9q3/ZLKFj/c5D6At59/ZWMgBn1x48ethBwIm2CYxH33+aIZVTkcPf4l38daQ0a0B/
         i2b5v3ZCEmX3RtzI/To1E/xgsrkw+FaUWWybHs8KnR0K2pVpHw7BIEWgQppLB+6Y+Ll4
         HkJA==
X-Forwarded-Encrypted: i=1; AJvYcCVKpq1zsvJ3UfQr3TUk65D//SVefWEj1OWGA1ybvVeZ36XmOWnEVsLhuXN7YMnkFuywjLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE5LUdEg7wy+vpVxOe8aDGpQs7E+cGwB7zjgM+r8j+JE7VEFoj
	K6G7oBeqxISd+52z0yN85GmsgCfYfcfX8Rn/tWxblD7szdi++VnhbrPtQsWYYhwTQEM=
X-Gm-Gg: AZuq6aJzV6ohJ5ncJTXXfIkKJ3+XcKJqZZ58E9ZCkM7O79E5tLX9lRoat8q1SCt/UFY
	NNNMzZaIBREzhCMEh6mnleFBvEq7o5WK8mBPsywHIUe6LDVFpgzysTVM91n8wRnFEXDfPi/Kmx6
	I2MpqTcVwmgl5nC0p+J7t5kxqEh5IkH5uuUvVRJltgRebMNm+ftjIws4hM5j0ySaiGUrCechQAZ
	mEB53UJ8TnhKQ0oe5+QlpN8Jvm34S8Jsx21qZo7ltwq8PeWvEkvpnrl+uq0hv/0Haj6XAXP+FYQ
	L8550WG+20uOrkB2POO1VNrG3mNElZvgM/0y1wHo9RKM/lQVeLg3SeLULAXn46KI0E+WTo0iyNH
	95164Jopiu3j52Xrzti6y7Ybyg7xwxNWZd/Ho0UHYUU4jl2OFQJv+7sha6sSLw1JiVp4JYgOk9r
	atIDXsNqESmClHW39NHzilYDAFtpsqbqkt6u8k3xEKqzA8ssPwELlfF7oHykYkY2k3VLn7AmEBn
	U911lti4POp0G/9DUKwVtjB
X-Received: by 2002:a05:7022:1285:b0:11a:37a7:3d2f with SMTP id a92af1059eb24-12703fe8c82mr6800135c88.37.1770744622066;
        Tue, 10 Feb 2026 09:30:22 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::1:a031])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041d9c91sm12989395c88.2.2026.02.10.09.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 09:30:20 -0800 (PST)
Message-ID: <82535cd8-7bcc-4454-b8ee-2af513bcf31c@davidwei.uk>
Date: Tue, 10 Feb 2026 09:30:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 15/16] selftests/net: Add env for container
 based tests
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-16-daniel@iogearbox.net>
 <20260131163834.2c3d160d@kernel.org>
 <9037828b-c7fd-4eb1-9dd8-19ee49063361@davidwei.uk>
 <aYP7uiuPWAbJEgLD@devvm11784.nha0.facebook.com>
 <aYQBsTfF4PrJcHNl@devvm11784.nha0.facebook.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aYQBsTfF4PrJcHNl@devvm11784.nha0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-04 18:34, Bobby Eshleman wrote:
> On Wed, Feb 04, 2026 at 06:08:58PM -0800, Bobby Eshleman wrote:
>> On Mon, Feb 02, 2026 at 07:53:34AM +0900, David Wei wrote:
>>> On 2026-02-01 09:38, Jakub Kicinski wrote:
>>>> On Thu, 29 Jan 2026 23:28:29 +0100 Daniel Borkmann wrote:
>>>>> +class NetDrvContEnv(NetDrvEpEnv):
>>>>> +    """
>>>>> +    Class for an environment with a netkit pair setup for forwarding traffic
>>>>> +    between the physical interface and a network namespace.
>>>>
>>>> A little diagram would be pretty awesome to have here, and perhaps copy
>>>> it to the README file too?
>>>
>>> Sounds good, I'll add one. I forget how much you like ASCII diagrams.
>>>
>>>>
>>>>> +    """
>>>>> +
>>>>> +    def __init__(self, src_path, rxqueues=1, **kwargs):
>>>>> +        super().__init__(src_path, **kwargs)
>>>>> +
>>>>> +        self.require_ipver("6")
>>>>> +        local_prefix = self.env.get("LOCAL_PREFIX_V6")
>>>>> +        if not local_prefix:
>>>>> +            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
>>>>> +
>>>>> +        local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
>>>>> +        self.ipv6_prefix = f"{local_prefix}::"
>>>>> +        self.nk_host_ipv6 = f"{local_prefix}::2:1"
>>>>> +        self.nk_guest_ipv6 = f"{local_prefix}::2:2"
>>>>> +
>>>>> +        self.netns = None
>>>>> +        self._nk_host_ifname = None
>>>>> +        self._nk_guest_ifname = None
>>>>> +        self._tc_attached = False
>>>>> +        self._bpf_prog_pref = None
>>>>> +        self._bpf_prog_id = None
>>>>> +        self._init_ns_attached = False
>>>>
>>>> I'm not a Python expert but the pre-init of variables that are set
>>>> later on in __init__() (on all possible paths) seems like a waste of LoC
>>>
>>> It's so that exceptions thrown -> __del__() don't complain about
>>> undefined vars.
>>>
>>>>
>>>>> +
>>>>> +        ip(f"link add type netkit mode l2 forward peer forward numrxqueues {rxqueues}")
>>>>
>>>> Would we be able to do this with YNL?
>>>> no big deal but always nice to avoid the dependency on very latest CLI
>>>
>>> Hmm, I tried looking into this already. My understanding is that this
>>> can be done in C but not currently in YNL, not without adding a spec.
>>>
>>>>
>>>>> +        all_links = ip("-d link show", json=True)
>>>>> +        netkit_links = [link for link in all_links
>>>>> +                        if link.get('linkinfo', {}).get('info_kind') == 'netkit'
>>>>> +                        and 'UP' not in link.get('flags', [])]
>>>>
>>>> And of course if you use YNL you can actually ask Netlink to
>>>> echo back / return to you what interface it ended up creating.
>>>> No need for the scanning..
>>>>
>>>>> +        if len(netkit_links) != 2:
>>>>> +            raise KsftSkipEx("Failed to create netkit pair")
>>>>> +
>>>>> +        netkit_links.sort(key=lambda x: x['ifindex'])
>>>>> +        self._nk_host_ifname = netkit_links[1]['ifname']
>>>>> +        self._nk_guest_ifname = netkit_links[0]['ifname']
>>>>> +        self.nk_host_ifindex = netkit_links[1]['ifindex']
>>>>> +        self.nk_guest_ifindex = netkit_links[0]['ifindex']
>>>>> +
>>>>> +        self._setup_ns()
>>>>> +        self._attach_bpf()
>>>>
>>>>> +    def _setup_ns(self):
>>>>> +        self.netns = NetNS()
>>>>> +        cmd("ip netns attach init 1")
>>>>> +        self._init_ns_attached = True
>>>>> +        ip("netns set init 0", ns=self.netns)
>>>>
>>>> Hm, refactor class NetNSEnter or just use its enter method?
>>>
>>> I did consider this but I didn't feel like it fit the very specific
>>> purpose of NetNSEnter. I needed the init ns to have a valid nsid from
>>> within the test netns, which I didn't think many other tests would need.
>>>
>>>>
>>>>> +        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
>>>>> +        ip(f"link set dev {self._nk_host_ifname} up")
>>>>> +        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
>>>>> +        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
>>>>> +
>>>>> +        ip("link set lo up", ns=self.netns)
>>>>> +        ip(f"link set dev {self._nk_guest_ifname} up", ns=self.netns)
>>>>> +        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=self.netns)
>>>>> +        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
>>>>> +        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
>>>>> +
>>>>> +    def _attach_bpf(self):
>>>>> +        bpf_obj = self.test_dir / "nk_forward.bpf.o"
>>>>> +        if not bpf_obj.exists():
>>>>> +            raise KsftSkipEx("BPF prog not found")
>>>>> +
>>>>> +        cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj} sec tc/ingress direct-action")
>>>>> +        self._tc_attached = True
>>>>> +
>>>>> +        tc_info = cmd(f"tc filter show dev {self.ifname} ingress").stdout
>>>>
>>>> Don't we need to also add a qdisc if there isn't one already?
>>>
>>> Sorry, why would qdisc be needed? The bpf prog attaches to tc. I don't
>>> know anything about qdisc, though.
>>
>> The ingress qdisc is the attachment point. I think we need
>> CONFIG_NET_SCH_INGRESS here too?
> 
> Sorry for the config stuff I'm replying about, I ran into needing these
> too for this:
> 
> CONFIG_NET_CLS_BPF=y
> CONFIG_BPF_SYSCALL=y

Thanks Bobby, I'll add these to the kconfig.
