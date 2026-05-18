Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644933ED5BD
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101147; cv=none; b=hSCcJ4Zu55fv8DYa+AJJBBb4LTp8X7N1BCxV8GaeNXZ1tRS/3uQG/cATsoro3gLgQb8HcP9lvyaGkIoHms8Y9icKbvhMI1sl0ts+9siC5hhuC2WmgreIE0tPizXoLYpOXwV8bNPOa7jNZp4/RmNoJamaYd9g/fd5U9xaflX3iyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101147; c=relaxed/simple;
	bh=UNbnn1OwVjs/XTOsrNsgcUPw0FY868fvZw4sFHoiKAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzeSruxAbCt9O/NvVYR5+RY2uwAcDtwFlY1vxgHxLoHWVFJQ7n18l3Kc9W/Pe3ZCPU6giH3TLsaZGo8Bk1csADoJmjs482kbnwAi0bwziKLiTvsFJKeCR1cK3okUBQelU8VrGYSVdyVvxDRNxW3iE1AZQHm+60KsIKX6C/1Q594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fuCzRZ8i; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fuCzRZ8i"
Message-ID: <80621876-f151-4373-aab9-336a2c483d95@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779101128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQviGAWxwFAf4WkF01qNgkMltd5nkvNvc0xoQtBJuqg=;
	b=fuCzRZ8i2Zon4wIhfwPBC0YBqMv8mNKHPUR+u9mIqKp98FCI50rT1Z/UTH3TFKJ4vb8iqO
	GmSZ3TmBv3Tj1aA98am5ffqDlvq6SMEmLnswreQBb5Vf8OiWlHeJFpBWbXTXd5iPcQwEyp
	Jc6xBH1nueXJGJiTur4JM5kWwgBvanY=
Date: Mon, 18 May 2026 18:45:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] tracing/probes: Allow use of BTF names to dereference
 pointers
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>, Tom Zanussi
 <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <olsajiri@gmail.com>
References: <20260516173310.1dbad146@fedora>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260516173310.1dbad146@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 17/5/26 05:33, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Add syntax to the FETCHARGS parsing of probes to allow the use of
> structure and member names to get the offsets to dereference pointers.
> 
> Currently, a dereference must be a number, where the user has to figure
> out manually the offset of a member of a structure that they want to
> reference. For example, to get the size of a kmem_cache that was passed to
> the function kmem_cache_alloc_noprof, one would need to do:
> 
>  # cd /sys/kernel/tracing
>  # echo 'f:cache kmem_cache_alloc_noprof size=+0x18($arg1):u32' >> dynamic_events
> 
> This requires knowing that the offset of size is 0x18, which can be found
> with gdb:
> 
>   (gdb) p &((struct kmem_cache *)0)->size
>   $1 = (unsigned int *) 0x18
> 
> If BTF is in the kernel, it can be used to find this with names, where the
> user doesn't need to find the actual offset:
> 
>  # echo 'f:cache kmem_cache_alloc_noprof size=+kmem_cache.size($arg1):u32' >> dynamic_events
> 
> Instead of the "+0x18", it would have "+kmem_cache.size" where the format is:
> 
>   +STRUCT.MEMBER[.MEMBER[..]]
> 
> The delimiter is '.' and the first item is the structure name. Then the
> member of the structure to get the offset of. If that member is an
> embedded structure, another '.MEMBER' may be added to get the offset of
> its members with respect to the original value.
> 
>   "+kmem_cache.size($arg1)" is equivalent to:
> 
>   (*(struct kmem_cache *)$arg1).size
> 
> Anonymous structures are also handled:
> 
>   # echo 'e:xmit net.net_dev_xmit +net_device.name(+sk_buff.dev($skbaddr)):string' >> dynamic_events
> 
> Where "+net_device.name(+sk_buff.dev($skbaddr))" is equivalent to:
> 
>   (*(struct net_device *)((*(struct sk_buff *)($skbaddr)).dev)->name)
> 
> Note that "dev" of struct sk_buff is inside an anonymous structure:
> 
> struct sk_buff {
> 	union {
> 		struct {
> 			/* These two members must be first to match sk_buff_head. */
> 			struct sk_buff		*next;
> 			struct sk_buff		*prev;
> 
> 			union {
> 				struct net_device	*dev;
> 				[..]
> 			};
> 		};
> 		[..]
> 	};
> 
> This will allow up to three deep of anonymous structures before it will
> fail to find a member.
> 
> The above produces:
> 
>     sshd-session-1080    [000] b..5.  1526.337161: xmit: (net.net_dev_xmit) arg1="enp7s0"
> 
> And nested structures can be found by adding more members to the arg:
> 
>   # echo 'f:read filemap_readahead.isra.0 file=+0(+dentry.d_name.name(+file.f_path.dentry($arg2))):string' >> dynamic_events
> 
> The above is equivalent to:
> 
>   *((*(struct dentry *)(*(struct file *)$arg2).f_path.dentry)->d_name.name)
> 
> And produces:
> 
>        trace-cmd-1381    [002] ...1.  2082.676268: read: (filemap_readahead.isra.0+0x0/0x150) file="trace.dat"
> 
Hi Steve,

Great to see that BTF is going to be nested into trace.

I'm glad to share my BPF tool, bpfsnoop [1], that utilizes the similar
way to inspect argument's data.

Read device name:
bpfsnoop -t net_dev_xmit --output-arg 'str(skb->dev->name)'
--limit-events 20
- net_dev_xmit[tp] args=((struct sk_buff *)skb=0xffff88818821d4e8,
(int)rc=0, (struct net_device *)dev=0xffff88984ba64000, (unsigned
int)skb_len=0x1f2/498) cpu=2 process=(0:swapper/2)
timestamp=18:06:17.309492697
Arg attrs: (array(char[16]))'str(skb->dev->name)'="eth0"

Read dentry name:
bpfsnoop -k 'vfs_read' --output-arg
'str((file->f_path.dentry)->d_name.name)' --limit-events 20
← vfs_read args=((struct file *)file=0xffff888175e08400, (char
*)buf=0x55c7a1168400(0x0/0), (size_t)count=0x10000/65536, (loff_t
*)pos=0xffffc9000f707bb0(0)) retval=(long int)510 cpu=3
process=(339834:sudo) timestamp=18:24:16.22021166
Arg attrs: (unsigned char *)'str((file->f_path.dentry)->d_name.name)'="ptmx"

In bpfsnoop, it provides a friendly way to inspect argument's data using
C expressions. Under the hood, it compiles the C expressions, specified
by --filter-arg/--output-arg, into BPF byte code by parsing the
struct/union member access with BTF. (I'm too lazy to write documents to
explain its internal details. But you can study it with AI assistance.)

Insanely, after developing such feature for bpfsnoop, I wondered whether
to embed a light-weight C compiler into trace tool in order to compile C
expression into BPF byte code, and then load the BPF program to
filter/output argument. Finally, users are able to filter/output
arguments using C expressions. It seemed too crazy for me to post such
idea to trace mailing list at that time, as I wasn't familiar with trace
infrastructure.

[1] https://github.com/bpfsnoop/bpfsnoop/

Thanks,
Leon

