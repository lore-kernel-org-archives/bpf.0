Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E622571A5
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769986479; cv=none; b=nvZ1acMUNrtDq2MB8JBRktS9tzC73O2Fjl25Na7b/8rEGhHh8VvNjDTSDv+LL64Ffq5lhzNx0agdER9DBl1voo9PmSg/rR1cjvd7YIcEYkVJtb7mY2W+VoZaYnIrjF6sw0hkFEFOvwh2rc0tICnQh4Qx2neueU4hFUqWMaa7n24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769986479; c=relaxed/simple;
	bh=h+GpOYR5Bgm8Qm5oFwKf8BpUMmb8W/5/khQY5yPladE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cc/41mvFfXnkCia+58ryrYdi2udShOzDT8PMEJVs2kRH6tbK0EFO97lqVx48phdpubRPIvUIHWdozjICeTKXFy5RV1MOSBfOB2pf//znAu54Bm0aCDFZZvTu3YI77YlYsywDyiwvhFitosGqMLw/88O2zW7PiucK+BVutVBJpDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=br7q7Dsc; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="br7q7Dsc"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-823081bb15fso1936963b3a.3
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 14:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1769986478; x=1770591278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8Sqabui1WaQIPpj7PzlekdVT08tCINJf1sIn5iJIEE=;
        b=br7q7Dsca6DYtCi6ypvs9XuuhoR9T8uQqTEtOR6A7QIjLNBBW8i+7hZi0nubM6Oj3F
         A4vtxo/eKVTbJjU0r9XSSc/oRRViP+d49ZPx3vI6w7KCiUMHeQOQG/tw7UwJHmPaJxNV
         Hs5Ort0aYSgT44Yr7nD5xtZ2HulCynqyHfFktGiPIH5aIZ46AUDPxyYyJuyvDjT84Edh
         ASBAytVE+amWYXrnHgebv4vq63M+Pn4XHiA1IgoKFcKLOpU0k22OiX8xFZQBbQsudgWN
         Xu9xM3Hbcc7xrp9jFN6sxWRNTFZELSA3aIib6XpQfUhPNAvaYXcjaTzDGr/dmLgyvNgD
         T6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769986478; x=1770591278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8Sqabui1WaQIPpj7PzlekdVT08tCINJf1sIn5iJIEE=;
        b=ts2AKQAs8aiylTKAWuAhFsJodopjVMpa8DzHDi2XelF/+y/eYu7lAFe4GEtn/TOaaP
         Dc1seIsjMuxnHpbqp9CJVV3ZL/oCDSabYemBm3dcMukJEFwml09m5vPYr/SFTtGOG1aW
         vUQxIx6Q7vz85cEa0IahWHcl+ruqSZLN/EMJr+BTfO4CsP6zNfrk1QKjbdMrH+SDSTFW
         aPdNkJM3d5Bfvetyd4cDtDMLn0Xuv7QOURqzbvgGxdNV7eJD3B5kdwdAnOgSxkynB9Bz
         2kE/yF/EwcJ/tK4Ol0RAeDl7gRlPU9IFflwziq8s8N+clmaItmVaqllHGsOUhR5fRZFW
         o2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq3QAPI/FfUtHAEowTDvQz5h4LRvKGjInQzBYSO6qi2ywoOFSg/J7Z3mJ6pS4PNpthubY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA4apHcKF2lFCkMKAzjYJ9rDWcA/gDQiWKQI/Op4gV3wzpPZOr
	UQz2QSogN34aYSZlRasFRj5lt3d9Z0a7sR9zkSvn09hfd59Ic6+MCgiMWpioO7wnuEw=
X-Gm-Gg: AZuq6aJlql2GdygGls1Mpb7JURBw7qBOqoIGiR574oOCWjqIwCihn4gVZFlrJJxigNK
	W6MefbJNxnH1GkiElPeSHrMsCRwpj3eBDaDxiOEixaw0s0CuJHhjwX6pY/BfIVggpNo8kWejpmZ
	16J1HOrp1AUB93FHRbQEL3pMqm+VRjHxOjkTDDfZYw63Xyk0LPLLr0S/kSJ8JVdU6vHRwBrms/r
	yezQrzr94r0Df+gUjoSiOdD3YLaN7MO7vJQtORTaDCq4BXUoB+IXONQmRA0Z7p2KgOVuDXrm0q8
	oB7o/dh/xkJR4EGscyjg5Bl4NDffrKRn/FYyEq1T0kLrtDGpSNVKzMSpooffEzPffhH21UW8TbY
	nBqDbBZSTnsEZM2qVDu/ZSw1TmfheW60GqKLNyz4ARpi8Tgt8IhwiO9TumKz0BvsRUAP1BLBtDW
	ayW+2ZP0/UdTAKgcZR+2G0lo1BRl6sg8BxbuPU2moUzPke2yD/cXkEjMUoW02ruBnwNs262Fi9e
	pEihpHgkhMf3eJ8+w==
X-Received: by 2002:a05:6a00:bd03:b0:81f:be3c:8a24 with SMTP id d2e1a72fcca58-823aa6ec4e2mr8638004b3a.36.1769986477775;
        Sun, 01 Feb 2026 14:54:37 -0800 (PST)
Received: from [192.168.100.174] (p94025-ipoefx.ipoe.ocn.ne.jp. [153.246.129.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfd729sm13164495b3a.44.2026.02.01.14.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 14:54:37 -0800 (PST)
Message-ID: <d7490f71-72ac-4c50-b848-c3d366e67a80@davidwei.uk>
Date: Mon, 2 Feb 2026 07:54:34 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 16/16] selftests/net: Add netkit container
 tests
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-17-daniel@iogearbox.net>
 <20260131162427.741b8085@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260131162427.741b8085@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-01 09:24, Jakub Kicinski wrote:
> On Thu, 29 Jan 2026 23:28:30 +0100 Daniel Borkmann wrote:
>> Add two tests using NetDrvContEnv. One basic test that sets up a netkit
>> pair, with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF
>> program to ping from a remote host to the netkit in netns.
>>
>> Second is a selftest for netkit queue leasing, using io_uring zero copy
>> test binary inside of a netns with netkit. This checks that memory
>> providers can be bound against virtual queues in a netkit within a
>> netns that are leasing from a physical netdev in the default netns.
> 
> We should cover the uAPI and the tricky part of the handling please.
> 
> So off the top of my head main bits:
>   - the expected attributes on lessor and lessee via Netlink
>   - destroying the netkit with MP attached
>     - checking the state via YNL,
>     - attaching MP from the main dev to make sure we didn't leave
>       anything behind
>   - destroying phys dev while netkit exists (prolly netdevsim :S)
>   - making sure XDP can't be attached on phys dev when MP is installed
>     via netkit
> 
> ... whatever else you found to be tricky in the implementation.

Sounds good. I'll add these test cases and more.
