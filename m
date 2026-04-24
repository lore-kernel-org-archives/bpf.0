Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380935B658
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013653; cv=none; b=dB4jfgqKamFP+FbS604ZaNclBRZMJK+u4hpWDxK+q5Pz5De/SztvnK5uXuFJPwPmAoDxHkSgljnACkHYwJ5Jgc5NOK526G9yXnOvNkGqsiSBNJ91ZSx0KdjJRRDZewWyOwT1E6qECOjP8oVYRYoAc2fwdN4UtQWKDC7Od8w6hbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013653; c=relaxed/simple;
	bh=tM6pwmW4hdyJEX/rGjUB02qhERuPDDbyqUIW1ki2lhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUHh1xlbj4JMNU6dEIudfcjUAJFzF4otbEaEW4Jx8PHaaUXxW7amql9XB8zXSEmsFi4eJwj6cukn/wT6+81kr64Auai3nSruMYdoFZBpC8WKVIhg+0uY/XSauQiVrhTLpP7lXSiJoMouzbZ/iGSNMM9JXESDl6Kit9TCaLK8vXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FcKrX97u; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FcKrX97u"
Message-ID: <7ceb9dda-16af-4fcc-a47a-2099408c0e10@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777013650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEnwoYJ3lg1FfiYRhZPdxAbcM6wgqjZ2mJ9S5OM9bwk=;
	b=FcKrX97usfikriwN9exERSf7fVXzya46I4dZ/LwhB3iLGBHY1aT9xpSPhuoVHDhwcP2z/q
	q5EM+aohzsGicjtZBnoZPqIsZsDefbm1dXrGowe8vBz8tmq1lUoej4tw2Us0oebeaGXLbS
	9sgUTcgCE9A/GkjKZu2Vp2AD0nqvBIU=
Date: Fri, 24 Apr 2026 14:53:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf, tcx: reject offloaded programs on attach
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260423033609.252464-2-jiayuan.chen@linux.dev>
 <20260424033751.61B00C19425@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260424033751.61B00C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/24/26 11:37 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] Incomplete fix: Offloaded programs can still be attached to software paths via BPF_LINK_UPDATE
> - [High] Missing device-bound validation in TCX and Netkit attach paths
> --
>
> commit ea2bbf8a59b47b06842fc8c920b0debcc1bed553
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> bpf, tcx: reject offloaded programs on attach
>      
> An offloaded prog's bpf_func is replaced by bpf_prog_warn_on_exec(),
> since it's supposed to run on the NIC, not the host. But tcx doesn't
> check this and happily attaches it to the software path, so the first
> packet hits the WARN.
>
> Closes: https://lore.kernel.org/bpf/64d8e2b5-a214-4f3c-b9e8-bcedbcb2c602@hust.edu.cn/
>
>> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
>> index 02db0113b8e7c..86f4636d5a677 100644
>> --- a/kernel/bpf/tcx.c
>> +++ b/kernel/bpf/tcx.c
>> @@ -16,6 +16,9 @@ int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>   	struct net_device *dev;
>>   	int ret;
>>   
>> +	if (bpf_prog_is_offloaded(prog->aux))
>> +		return -EINVAL;
>> +
> The commit message mentions using bpf_prog_is_offloaded() instead of
> bpf_prog_is_dev_bound() so that dev-bound-only programs keep working for TCX
> and Netkit.
>
> XDP validates device matching in dev_xdp_attach():
>
>      if (bpf_prog_is_dev_bound(new_prog->aux) &&
>          !bpf_offload_dev_match(new_prog, dev)) {
>          ...
>      }
>
> The kernel relies on attach-time validation to guarantee safety for hardware
> metadata kfuncs, as documented in bpf_dev_bound_resolve_kfunc():
>
> "We rely on bpf_dev_bound_match() check at attach to render this program
> unusable"
>
> If a program is device-bound, shouldn't we still verify it is being attached
> to the correct device?
>
> Without a similar bpf_offload_dev_match() check here in the TCX and Netkit
> attach paths, could a user attach a program bound to device A onto device B?
>
> Could this cause driver-specific kfuncs to execute on device B's SKBs while
> blindly assuming device A's internal data layout, leading to out-of-bounds
> memory accesses and kernel panics?


On bpf_offload_dev_match(): SCHED_CLS doesn't allow dev-bound-only 
(rejected in bpf_prog_dev_bound_init()),

so bpf_prog_is_offloaded() already covers every case: A program offloaded
to device A attached to device B is rejected unconditionally.

>>   	rtnl_lock();
>>   	dev = __dev_get_by_index(net, attr->target_ifindex);
> [ ... ]
>
>> @@ -315,6 +318,9 @@ int tcx_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>   	struct tcx_link *tcx;
>>   	int ret;
>>   
>> +	if (bpf_prog_is_offloaded(prog->aux))
>> +		return -EINVAL;
>> +
> While this prevents offloaded programs from being attached initially, do
> we need to protect the link update paths against this regression as well?
>
> It appears tcx_link_update() and netkit_link_update() pass the new program
> directly to bpf_mprog_attach() without validating its offload status:
>
> kernel/bpf/tcx.c:tcx_link_update() {
>      ...
>      ret = bpf_mprog_attach(entry, &entry_new, nprog, oprog, NULL,
>                             link->flags, 0, 0);
>      ...
> }
>
> If a user creates a valid link with a standard program, could they use
> BPF_LINK_UPDATE to replace it with an offloaded program?
You're right about the update path — will fix in v2.
> Similarly, does bpf_xdp_link_update() lack the bpf_prog_is_offloaded() check
> present in dev_xdp_attach(), allowing it to install an offloaded program into
> an SKB or native mode XDP link?
>
> If an offloaded program is attached via these update paths, its bpf_func is
> replaced by bpf_prog_warn_on_exec().
>
> Would executing this on the host datapath trigger the WARN(1) panic this
> patch intended to fix, potentially allowing a local DoS if panic_on_warn
> is set?

The same hole exists on the XDP side (bpf_xdp_link_update() bypasses 
dev_xdp_attach()'s offload check); I'll send a separate patch for that.


>>   	rtnl_lock();
>>   	dev = __dev_get_by_index(net, attr->link_create.target_ifindex);
