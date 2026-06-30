Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159F81A0BF3;
	Tue, 30 Jun 2026 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829091; cv=none; b=tpIPWjp/O7M8fG5rbrJPOmfmd1bAB6n98Acjn3l8mYkoZuS/93XHNUoBqrRXFaz0bUoWXVqL1xSJj8CfG2vhZCh/T/FevJcPZqO8cUiK7+EgYiCropqMPVIFYoPISYgrVT298ffj5r+a9hqnQdMw940iAd1vV2J4H/TizpA1tvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829091; c=relaxed/simple;
	bh=B8Y0dTMlB+oB9s7duvm7DhqDyHlJZoxRIu7q/l43pzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8imXBJh/C01TMsDpNM4o4NQ4i7l+DjSf+tigGqyDa5LfrHrM3QExEVfo/vwJPYJbFJQNwBLRsg2Lzb58DHcCG1WW242wShg4+q5Z4XCOm1bl7lvZ3sBLWZrAFbjAYx8WqyJ8tjl3ca6WoRW5dCuF6dOBd01NDMXbhal54B/eco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czOvN6MP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czOvN6MP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6491F00A3A;
	Tue, 30 Jun 2026 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829090;
	bh=nJE7z6y+b0729BtKGMZ7zs0Yot0Hv1XhxgGW0/v1JZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=czOvN6MPHetgLKJr5rLG6WWWF2AgkQQu5eBvJsJ5Yt9XG/CkpJu012K4kYCMEmjhI
	 4y+VvaQY1M81JIrE9e0akdnw63N8atIg83+q2d23SSmfhcjoi4giHM+aMJMRvPWyaT
	 y0dgHzWvwh9pCQIsK2MTRRFAxmlYSIbSJ542/LL5+05w6s5clcKLi82csRNiMgBUPx
	 fim/GrOlNnCOZaDrf6+O5NPI3DJgw2owkORlK77Y0c4sPGgJ722AuYSOVxedB+973h
	 4RdfQWcQBo8KurgCe1FP+gvQeAlCDe2eFNB/VAYbdvvmHQVXEu2cXuQpucrg+aTtbT
	 EMSWmRA6izxyw==
Message-ID: <cf25f667-1095-4f84-98ff-bf4662d3faa8@kernel.org>
Date: Tue, 30 Jun 2026 08:18:07 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org> <87se65bd04.fsf@toke.dk>
 <2ffa32dd-5c88-488a-aa23-deef13465eb9@kernel.org> <87echobb5h.fsf@toke.dk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <87echobb5h.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/30/26 4:00 AM, Toke Høiland-Jørgensen wrote:
>> It does not make sense to require a flag to get lookup output. vlan
>> proto of 0 is not valid, so it is a clear indication that the vlan
>> output parameters were not set during the lookup.
> 
> Okay, so we could just unconditionally set the VLAN fields, but if we
> start rewriting the ifindex that would be a change of the existing
> behaviour that could break existing applications, no?

Consistently dealing with upper devices is one of the reasons I never
sent patches for vlan support.

xdp support is at the driver layer for real (physical) devices. The fib
lookup is going to return the vlan device index - a virtual device.
Support for xdp should not be propagated to virtual devices; it goes
against the intent of xdp. Any trip down this path will have to decide
how to handle vlan-in-vlan use cases. Where is the line drawn for fast
networking?

> 
> Specifically, if an XDP application has a table of the interfaces it
> forwards between, today they'd get a VLAN interface ifindex, which would
> not be in that table, and the application would return XDP_PASS. Whereas
> if we change the ifindex and populate the VLAN tag, suddenly the
> interface would be in the table, but because the application doesn't
> read the returned VLAN tag, it will end up sending packets out without
> tagging them, leading to broken forwarding.

I have not followed developments over the past few years. Does XDP have
support for vlan acceleration in the Tx path now? You really want that
to deal with vlans and not replicating s/w processing in ebpf.

> 
> So if we don't want the flag, we'd need some other mechanism to resolve
> the parent ifindex, AFAICT? Maybe a xdp_get_parent_ifindex() kfunc, say?
> That could also be made generic for other stacked interface types, I
> suppose.
> 
> WDYT?

dealing with stacked devices is hard :-)

What is the return is a bond device or a vlan on a bond device?

