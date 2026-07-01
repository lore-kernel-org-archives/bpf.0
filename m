Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCD3C0A03;
	Wed,  1 Jul 2026 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918490; cv=none; b=Sr5IaaVrWA/Wvg7cVficvL6aFE88I3xI1iu2TwQtMk0gtFk5cTtk0SHD+3JLJGouwmqyHjyRZ98pV3GaiQpymb2zCIGbQ2WaUm2DAaMSzsfLb737bhnYDEF9Phlds+iQ9+R3N0sJUilItgAR5u9NR63mIoCVFcy3y1jqxZxuAd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918490; c=relaxed/simple;
	bh=+IqmZ0jp3BkS12QUziMDsgo4lVv7ySDOmKcheSJJMA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwyhpSeqMNhov38Z3EhbYpxC0ETwfF4K7GZXp1mxchEEGAU7g/QUapQALOX+/ybjVSs0CMBuf8C6wIVj3hWNDcEV4CTqQAslMKhsP1/E47o2LAMDjhTp4zY5/hGUWl4lHf8AdrKfWkBro5Ox0cWR/dlblOv2KxmHTp97GnAZcGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnlqNMCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnlqNMCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C11C1F00A3A;
	Wed,  1 Jul 2026 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782918488;
	bh=pcq3/61rIYYvcomftDru58HT4A9zIw36pp+6xIUh46o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WnlqNMCII1bhQZtjU/NUdR7hJvI/G4uAQE2tN4jrgwB4XtkHVOGzdgKn1nci+WCOI
	 ySOFXkdGJUyeoZ+9XGl7aLYgwh4ZUYCgFyOn2SrwLapVayh2XCMe9JOwFkKumlV3/h
	 r09KAHCDVONwoyCz3yg23GeJTSoQ67epvrtzlO8Nqj1updHyyUHe5SatRCaNTIdT4O
	 BJ9iAsgiSBKgvAtMlvxaAc8qHdtrpjpjAioNMNV75rG3jcVttFQmR9Itk9unevDhZl
	 dxLHXcCMAu7F2E0bCcddVgljObAWNmU827A94/0TQDUCllubM3qFptuI6Lef4MUcqw
	 8lpoeYScerfTQ==
Message-ID: <9d14ff4b-eadd-4ae2-ab68-5927d4f19eeb@kernel.org>
Date: Wed, 1 Jul 2026 09:08:06 -0600
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
 <cf25f667-1095-4f84-98ff-bf4662d3faa8@kernel.org> <874iik2ew4.fsf@toke.dk>
 <916191fc-2e10-4449-b82b-c086d90283ae@kernel.org> <87y0fv0y79.fsf@toke.dk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <87y0fv0y79.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/26 5:02 AM, Toke Høiland-Jørgensen wrote:
> David Ahern <dsahern@kernel.org> writes:
>> Seems to me the fib_lookup for xdp needs to return the bottom device,
>> not the vlan device, for forwarding to work. That's why I added the
>> fields to the struct. That allows the program to push the vlan header if
>> required. My preference (dream?) was that Tx path had support to tell
>> the redirect the vlan and h/w added it on send.
> 
> Sure, returning the bottom device index with the VLAN tag makes sense,
> and that's basically what this series does (but bails out on stacked
> VLANs). However, that's not what the helper does today, which is why the
> flag is there, to opt-in to the new behaviour. I don't think we can just
> change the ifindex without breaking existing applications (as noted
> up-thread).

I do not see it as breaking existing programs which is why I chimed in
on the thread.

> 
>> But really, once stacked devices come into play, I just wanted to make
>> sure thought is given to different use cases. As you know the lookup
>> struct if hard bound to 64B and it is trying to cover a lot of use cases.
> 
> Agreed, I don't think we can handle stacked devices in this helper. But
> we could split it out into a new one. Something like:
> 
> struct lower_device_info {
> 	enum device_type type;
> 	struct {
> 		__be16	h_vlan_proto;
> 		__be16	h_vlan_TCI;
> 	} vlan;
>         /* add other types here */
> };
> 
> int xdp_get_lower_device(int ifindex, struct lower_device_info *info);
> 
> called like:
> 
> int xdp_program(struct xdp_md *ctx)
> {
>         struct lower_device_info dev_info = {};
> 	int ifindex, ret;
> 
>         ifindex = find_destination(ctx); /* does fib lookup, or something else */
> 
>         while ((ret = xdp_get_lower_device_info(ifindex, &dev_info)) > 0) {
>         	if (dev_info.type == VLAN) {
>                       	push_vlan_tag(ctx, &dev_info.vlan);
>                         ifindex = ret;
>                 } else {
>                 	return XDP_PASS; /* we only handle VLAN devices */
>                 }
>         }
> 
>         return bpf_redirect(ifindex, 0);
> }
> 
> 
> With a helper like this, we obviously don't strictly speaking need to
> change the fib lookup helper at all. However, for the single-tagged VLAN
> case, I think supporting it directly in the fib lookup could still have
> value, as an optimisation: it saves an extra call for resolving the
> ifindex, and the fields are already there. So I think my preference
> would be to merge this series as-is, and then follow up with a new kfunc
> to handle the stacked case. But we could also just drop this series and
> go straight to the new kfunc.
> 
> WDYT?

no preference. I only chimed in because of the added flag to the uapi
which I do not see as needed. If the consensus is that it is in fact
needed, all good then.


