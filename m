Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964E3BBFBD
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341143; cv=none; b=kn3m3PWnGE7L/QgPxJTdczcd9Ww9Z/iHqj1eWiMHV445hMmx4DUdwJ5eidcp/tB7s1T4dYMFJsSkORipHvYL6v4AKw1EGAPBrOzakWoWSwlCZQf/U0oi6lbitgtYgF6h0xgitg3WZK/rm4RoHJmj0xP3OzsHzGclTP1g2lrgH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341143; c=relaxed/simple;
	bh=JD1nLT7zLYU53o1FV8dwd8Lfd7u+g9ii/mSNl5kx7gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXo4Z6Cy/wIEuoRq5ZHCsa7wNs9BzPTCyJEnr5iOaCydtXlw/IuPQ+lXXleuzNfeVwm9r9flA/XHS/AceqvpDVdyulMUhssFjt8BvzvwNERXxintL8XTHllbHVivDORg83en3nWx2s4RoM6t+K+1yfc2d32o5YPM5efbSn46heA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fH8M64rQ; arc=none smtp.client-ip=95.215.58.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fH8M64rQ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JD1nLT7zLYU53o1FV8dwd8Lfd7u+g9ii/mSNl5kx7gM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792341139; v=1; x=1792945939;
 b=fH8M64rQCfWnzUDL7E3z2DrEoP1h4Y42wNvLUhIxmLHZ76uwr5dxRjYeGxqpE8/cdbILlHDB
 Dd38jnBdHizjA0KT7ZtQTQ3WUxcgcIV8CnLxYfGKwV7ytk4WF3l00vw6qPmr0n9WREIGza+UnIg
 WsW1OszCrr1SVNb1cqi1h8OM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4a1cbad9841a4144;
	Sun, 18 Oct 2026 16:32:19 +0000
X-Mizu-Trace-ID: 4a1cbad9841a4144
X-Migadu-Flow: FLOW_OUT
Message-ID: <733300c4-9ed1-4bb6-a44a-22cceb65263f@linux.dev>
Date: Mon, 19 Oct 2026 00:32:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/6] bpf: Add syscall common attrs support for
 xdp link_create
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
References: <20261017142649.51047-1-leon.hwang@linux.dev>
 <20261017142649.51047-3-leon.hwang@linux.dev>
 <sashiko-outbox-175566@kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <sashiko-outbox-175566@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/17 22:48, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] bpf: NULL deref and format string bug in bpf_xdp_link_attach() via bpf_log()
> - [Critical] bpf: prog refcount underflow in link_create() if bpf_log_attr_finalize() fails
> - [Low] bpf: link failure in bpf_xdp_link_attach() when !CONFIG_BPF_SYSCALL
> --
> 
> commit fa16fd00d8499a718392032e57d440248e048afc
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> bpf: Add syscall common attrs support for xdp link_create
> 
> This commit passes the verifier log to bpf_xdp_link_attach() so that XDP
> link creation can report target_ifindex and driver errors through BPF
> syscall common attributes.
> 
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 252b479937a4d..e96d5f09486f5 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -5921,7 +5921,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
>>  		break;
>>  #ifdef CONFIG_NET
>>  	case BPF_PROG_TYPE_XDP:
>> -		ret = bpf_xdp_link_attach(attr, prog);
>> +		ret = bpf_xdp_link_attach(attr, prog, log);
>>  		break;
>>  	case BPF_PROG_TYPE_SCHED_CLS:
>>  		if (attr->link_create.attach_type == BPF_TCX_INGRESS ||
> 
> [Severity: Critical]
> Can the cleanup path in link_create() underflow prog's reference count if
> bpf_log_attr_finalize() fails after bpf_xdp_link_attach() succeeds?

Will fix the issue by reporting log_true_size twice. See the pseudocode
in patch 1 reply.

> 
> When bpf_xdp_link_attach() succeeds, bpf_link_init() transfers ownership of
> prog's reference to link->link.prog and bpf_link_settle() installs the link
> file descriptor, returning a non-negative fd in ret.
> 
> At the out label in link_create(), bpf_log_attr_finalize() writes
> log_true_size to uattr_common even when nothing was logged:
> 
> kernel/bpf/log.c:bpf_log_attr_finalize() {
> 	...
> 	if (attr->offsetof_true_size &&
> 	    copy_to_bpfptr_offset(attr->uattr, attr->offsetof_true_size, &log_true_size,
> 				  sizeof(log_true_size)))
> 		return -EFAULT;
> }
> 
> If uattr_common points to read-only memory, copy_from_bpfptr() in
> __sys_bpf() succeeds, bpf_xdp_link_attach() attaches and settles the link,
> and then bpf_log_attr_finalize() returns -EFAULT:
> 
> kernel/bpf/syscall.c:link_create() {
> out:
> 	/* preserve original error even if log finalization is successful */
> 	err = bpf_log_attr_finalize(&attr_log, log);
> 	if (err)
> 		ret = err;
> 
> 	kfree(log);
> 
> 	if (ret < 0 && prog)
> 		bpf_prog_put(prog);
> 	return ret;
> }
> 
> Overwriting ret with err causes link_create() to call bpf_prog_put(prog) on
> a reference that is now owned by the settled bpf_link, leading to a
> use-after-free of struct bpf_prog while the link remains attached in the
> process fd table.
> 
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 18dc88990510a..fdc1de21f3589 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
> [ ... ]
>> @@ -10771,7 +10772,8 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
>>  	.update_prog = bpf_xdp_link_update,
>>  };
>>  
>> -int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>> +int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
>> +			struct bpf_verifier_log *log)
>>  {
>>  	struct net *net = current->nsproxy->net_ns;
>>  	struct bpf_link_primer link_primer;
>> @@ -10784,6 +10786,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>  	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
>>  	if (!dev) {
>>  		rtnl_unlock();
>> +		bpf_log(log, "Invalid target_ifindex.\n");
>>  		return -EINVAL;
>>  	}
> 
> [Severity: Low]
> Will calling bpf_log() in bpf_xdp_link_attach() break linking when
> CONFIG_NET=y and CONFIG_BPF_SYSCALL=n?

Correct.

Will provide a stub bpf_log() when CONFIG_BPF_SYSCALL is not set.

> 
> net/core/dev.c is compiled whenever CONFIG_NET=y, and bpf_xdp_link_attach()
> is not guarded by CONFIG_BPF_SYSCALL. While helpers like bpf_link_init() and
> bpf_link_prime() have static inline stubs in include/linux/bpf.h when
> !CONFIG_BPF_SYSCALL, bpf_log() is only compiled via kernel/bpf/log.o when
> CONFIG_BPF_SYSCALL=y and has no stub in include/linux/bpf_verifier.h.
> 
>>  
>> @@ -10812,6 +10815,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>  	if (err) {
>>  		link->dev = NULL;
>>  		bpf_link_cleanup(&link_primer);
>> +		bpf_log(log, extack._msg);
>>  		trace_bpf_xdp_link_attach_failed(extack._msg);
>>  		goto out_put_dev;
>>  	}
> 
> [Severity: Critical]
> What happens here when dev_xdp_attach_link() fails without setting an extack
> message, or when extack._msg contains format specifiers?>
> In bpf_xdp_link_attach(), extack is zero-initialized on the stack, so
> extack._msg starts as NULL. Many failure paths under dev_xdp_attach_link() ->
> dev_xdp_attach() -> dev_xdp_install() return an error without calling
> NL_SET_ERR_MSG(), such as netif_xdp_propagate() when a device has no ndo_bpf
> callback, or driver ndo_bpf callbacks like netkit_xdp() and veth_xdp()
> returning -EOPNOTSUPP or -EINVAL.
> 
> When a user provides a log buffer via syscall common attributes and
> extack._msg is NULL, bpf_log() passes fmt = NULL into
> bpf_verifier_vlog() -> vscnprintf() -> vsnprintf(), which dereferences fmt
> unconditionally and crashes the kernel.
> 
> Additionally, because bpf_log() is a printf-style function, passing
> extack._msg directly as the format string rather than using a "%s\n" format
> specifier allows any '%' characters in a formatted extack message (for
> example from NL_SET_ERR_MSG_FMT() containing an interface name) to be
> interpreted as format specifiers by vscnprintf(), and omits the trailing
> newline. Should this be guarded with if (extack._msg) and logged with
> bpf_log(log, "%s\n", extack._msg)?

Sure, will change to

if (extack._msg)
	bpf_log(log, "%s\n", extack._msg);

Thanks,
Leon

