Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9527F29C35A
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061131; cv=none; b=eYAD2Xw08I801FAOhAOXWi214iOeWs6nSwxzpIzIkm9eJdWtXuHOzx+O+fxZLVX1KnnoW0xkk8F+g5VhZf3GCwrvr9eRmmlMUOh/+8YXAHldr6NZ1s3y33oE2XDp6nxTYjJC2ywNl//8MpLAyjCSw8QqufQVB2Jk22H+oNlpOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061131; c=relaxed/simple;
	bh=/f45TGhiRpH2RbxOCsOiCwxyvAjF88RmLq2aBHY2Fs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgUFgstE8/VhT9gaMH+WjPhY6N8GdDHcP4D7eW3N32XBpR4T0vEg0VUWRlCH4RDsFInQZpsbTfxyUtiyQ2hyEqICP95yMIc7eAguLMMBqPu3RIk8nK84k0xoogZJF0lBin9cJpyipamhIH+ytgD6ODVeZIJlUhWk3OpBvzWXpuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=EpgKNC3N; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="EpgKNC3N"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba895adfeaso9103800eec.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1777061129; x=1777665929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmQ/TEcLmXYNdfvNlx7+MJGDvd0ss7R7PnbOgKIaRis=;
        b=EpgKNC3Nw3MaNXMr385VZ5hoDkdqcvtN606XDHEgLRV79Zxevmd5KyME9zj96B4IvI
         TnIh17o546uTxhsjaGStXvKS9VphXERvh/VcIvTu9EHlFVAEP8xMjDG2FE+2w66+mc0Z
         oNeegKoIMJjX5pOu3eFs3mD60OhAIQZjyCruoDa3Mvkb06TxML4WphJk+la/LMszVACa
         87FT4Ug+H8aX7ooA11vni+8C9N4wqaUojarY1cGa9c8zCLJY71HZnPIv5n5LKUPQfyS5
         UH8rgnosmt1cg7OcDJISFvGI+QBlKU0YujCBdxtVxMnoWYgQntsnxBRF8XRM937BgP8h
         Z7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777061129; x=1777665929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmQ/TEcLmXYNdfvNlx7+MJGDvd0ss7R7PnbOgKIaRis=;
        b=CHqDo8kXUV02ENYMOne8kR6WEtTuHpUThVoE2DIt8DEELCRnT57YqH2dBKo1BgTPXB
         y669na26kSOvwebrMXfUSaSGj3sdiqMwhbpCRU7rzLXZGBEUC05x6YGr5cXYw/BcLspX
         8d5B4YPcsiOlW9XhVqFLK5EoKM3VF5X19iOXabqgjFu/lW09xHBd3R71OVATSHzmoT2C
         fpDCVpvzQBD612GcLPx2dqCOusleVo+WtSetBgLSq4bnBoR9I04H2iD+DTV+1ShOC1yc
         a/2w0p6G+hhtaBzICnnzLxhVPugFl7HzNPY0RMFhjZhyVOpNWfPU7pYN1kTDxbl05ldH
         f+7g==
X-Forwarded-Encrypted: i=1; AFNElJ+e+01erc9ZkBkPdDE4qj9lDl2Mhz376W5rRaAhlFsXhGfm9xLqNd1xdMkbC/nvVAzm/Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyfn75sIsaYH46NptdP4hYI/cyGlT7RmU6PGHLFtOY2aiCZgX
	zVXl/z1MFBWaU3MKc+bxG5QnvjAQoqEfcLq2drN7BqA7bJh5U0ZQnM7Drv6laFTHFZ0=
X-Gm-Gg: AeBDietrWTaWt8TlE3m2SPXax2+3yeM0TPmDMbcHsTlZYTh5kOePAhOK/95RnXZsZyM
	QdC2Qvyt3vjttQyF6jq/noU9yBypjVmI9TMvu44L67MRNecPY1YgjFHzCuPOaJHW0vajL/LxjFG
	R+X57Pa/8hFsYHcegqXGPg5exKOGijxAnVuxmDCb4V0drYaAmyM8dMYmB1Sf019Sv4P7eWqGvMa
	gHHLCkn+k6hsD83UOlGCykFK7UEUoCS2fDC1kAuanKZuk3Lpwp/jddnhD1rBjsbck7H55H6vaRb
	sL7PQtQu5ocDNasxfUO7SystABnJN6zWxFAS9ox4QHDROnxUs4RzVkAoo6iVjkVifhCZJrxMEsV
	wa3mk5VdRw8KTZ61mD9c19U1uwcrvVIXfa6ZjiOSP29dJ4e+H/JJAi4VFvMIhDXfAUTyw4Iw7Lg
	vIa5rYFooWV07wlC4UCHhiZcKwTCAQ3Sa16kKmOleHX5/W8/9Z3t6TRwLniPCqj1J1DhtZlj8aW
	CLY9OtZSXOk/5wN3UYHaHd7IEREatBf2Q0=
X-Received: by 2002:a05:7301:4586:b0:2e2:27bb:a4a2 with SMTP id 5a478bee46e88-2e47873a866mr19109354eec.13.1777061128748;
        Fri, 24 Apr 2026 13:05:28 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::1:eae7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa6134sm34784052eec.3.2026.04.24.13.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 13:05:27 -0700 (PDT)
Message-ID: <685d7bf9-062d-4bd2-8448-f7714bb05302@davidwei.uk>
Date: Fri, 24 Apr 2026 13:05:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stephen@networkplumber.org, jacob.e.keller@intel.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 dipayanroy@microsoft.com
References: <20260407200216.272659-1-dipayanroy@linux.microsoft.com>
 <20260409183509.0b24dea6@kernel.org> <20260412125917.4fa8fc8d@kernel.org>
 <ad5kuCZz+gR1TlSh@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260416083146.0bb94d2b@kernel.org>
 <aeoVC27mIzoKytqA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aeoVC27mIzoKytqA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-04-23 05:48, Dipayaan Roy wrote:
> On Thu, Apr 16, 2026 at 08:31:46AM -0700, Jakub Kicinski wrote:
>> On Tue, 14 Apr 2026 09:00:56 -0700 Dipayaan Roy wrote:
>>> I still see roughly a 5% overhead from the atomic refcount operation
>>> itself, but on that platform there is no throughput drop when using
>>> page fragments versus full-page mode.
>>
>> That seems to contradict your claim that it's a problem with a specific
>> platform.. Since we're in the merge window I asked David Wei to try to
>> experiment with disabling page fragmentation on the ARM64 platforms we
>> have at Meta. If it repros we should use the generic rx-buf-len
>> ringparam because more NICs may want to implement this strategy.
> 
> Hi Jakub,
> 
> Thanks. I think I was not precise enough in my previous reply.
> 
> What I meant is that the atomic refcount cost itself does not appear to
> be unique to the affected platform. I see a similar ~5% overhead on
> another ARM64 platformi (different vendor) as well. However, on that platform
> there is no throughput delta between fragment mode and full-page mode; both reach
> line rate.
> 
> On the affected platform, fragment mode shows an additional ~15%
> throughput drop versus full-page mode. So the current data suggests that
> the atomic overhead is common, but the throughput regression is not
> explained by that overhead alone and likely depends on an additional
> platform-specific factor.
> 
> Separately, the hardware team collected PCIe traces on the affected
> platform and reported stalls in the fragment-mode case that are not seen
> in full-page mode. They are still investigating the root cause, but
> their current hypothesis is that this is related to that platform’s
> PCIe/root-port microarchitecture rather than to page_pool refcounting
> alone.
> 
> That said, I agree the right direction depends on whether this
> reproduces on other ARM64 platforms. If David is able to reproduce the
> same behavior, then using the generic rx-buf-len ringparam sounds like
> the better direction.
> 
> Please let me know what David finds, and I can rework the patch
> accordingly.

I ran a test on Grace, 4 KB pages, 72 cores, 1 NUMA node.

Broadcom NIC, bnxt driver, 50 Gbps bandwidth. Hacked it up to either
give me 1 or 2 frags per page. No agg ring, no HDS, no HW GRO.

Use 1 combined queue only for the server. Affinitized its net rx softirq
to run on core 4.

Ran iperf3 server, taskset onto cpu cores 32-47. The iperf3 client is
running on a host w/ same hw in the same region. Using 32 queues, no
softirq affinities. The idea is to hammer page->pp_ref_count from
different cores.

* 1 frag/page  -> 32.3 Gbps
* 2 frags/page -> 36.0 Gbps

Comparing perf, for 2 frags/page the cost of skb_release_data() hitting
pp_ref_count goes up, as expected. Is this what you see? When you say
there's a +5% overhead, what function?

Overall tput is higher with multiple frags. That's to be expected w/
page pool.

There are some 200 Gbps NICs but they're mlx5 so I'd have to redo the
driver hack. Are you going to re-implement this change with rx-buf-len
instead of a private flag? If so, I won't spend more time running this
test.

> 
> 
> Regards
> Dipayaan Roy
