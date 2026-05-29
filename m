Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FB3346BE
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040379; cv=none; b=Y0L21A4DbOjSfAi6taltnmnRS+IixvZJkEWBSnAt4DBzu3Szsgqzuq2ArM26JpNBynJtuuo9YHrWDyogXq0L0R9dFmu9TDrspFnZUTQwK95HpdRF8iPbUSHFsFp2k9IiZwLIYkiEdlXTihMpgwVDeVw9Je3aJgvPNlA3vhIdxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040379; c=relaxed/simple;
	bh=73036+Nf/FaBbujgMKjPHUDS6X66wjc6LgBWcMBCgVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dP282EyRfz0NhnTMNu/G+xTLnKLdliAWkkaRvJq/tEJfAOnB7/qEMZKORtRaCIYHmhOloD+QWG/VY0wEqqDJ8f/jxPy8IKDiwXuPv6AV8FXx3NJWW4zN9ePE1t69lD9BOIWNXb+hQqR0C1RbFmCoQLToC3Gi+NCWxtNSL77jeGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=RrYVfpV9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="RrYVfpV9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Azy+axFr08Q52wAYVVFbbjePe5cxDL+s8eJ033wqhL0=; b=RrYVfpV9y1rOdu87hYYsKKm56l
	agPdm6mue1wjbrV0PEzahoGDWkq4Kgruo3srxQ+2eeTEA+SDnzoFHFdUXaWUGsuMwWI5hvmzlx3PR
	reqk0gnsAfdvkL213hB4VHzFAH7ZsmdVAIxrlzycCfLLAw00Wl/fGuI0dlpiFLML6TjKu50Aw3Q6C
	H4JmLwqNW95z+3HhVOKzD987gh7vFYlM+4OPSPgCq7VsP2VOMOEJtEFUY84b5W0X/95QtshDTuUrt
	XMgfWtvzRZlpR3pR/rCc0CZ3AsPc9l6TxgNkrSze6zziLC81EL5F83RkWqhRXGjZLvr0BiIkfMHHI
	ztEk4BTw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wSroc-0005s2-0E;
	Fri, 29 May 2026 09:39:34 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wSroa-0002bj-2A;
	Fri, 29 May 2026 09:39:33 +0200
Message-ID: <a3b92c03-ff06-4ec2-a903-9f879acd0fc5@iogearbox.net>
Date: Fri, 29 May 2026 09:39:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf: Add simple xattr support to bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, john.fastabend@gmail.com
References: <20260522135626.120732-1-daniel@iogearbox.net>
 <20260527-irrtum-holztisch-risiken-690a7fb93843@brauner>
 <576b6350-6635-4544-9a06-f4777e3a0e65@iogearbox.net>
 <20260528-verraten-innig-sprechen-fa8bea6696f7@brauner>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260528-verraten-innig-sprechen-fa8bea6696f7@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28014/Thu May 28 08:24:59 2026)

On 5/28/26 2:54 PM, Christian Brauner wrote:
> On 2026-05-27 14:36 +0200, Daniel Borkmann wrote:
>> On 5/27/26 2:19 PM, Christian Brauner wrote:
>>> On Fri, May 22, 2026 at 03:56:24PM +0200, Daniel Borkmann wrote:
>>>> Add support for extended attributes on bpffs inodes so that user space
>>>> and BPF LSM programs can attach metadata, for example, a content hash
>>>> or a security label - to a pinned object or directory. BPF LSM or user
>>>> space tooling can then uniformly look at this (e.g. security.bpf.*) in
>>>> similar way to other fs'es. The store is in-memory and non-persistent:
>>>> it lives only for the lifetime of the mount, like everything else in
>>>> bpffs. The modelling is similar to tmpfs.
>>>>
>>>> bpf_fill_super() is open-coded instead of using simple_fill_super(),
>>>> because the root inode must now be allocated through bpf_fs_alloc_inode()
>>>> i.e. carry the bpf_fs_inode wrapper and come from the right cache -
>>>> which requires s_op (and s_xattr) to be installed before the first
>>>> inode is created.
>>>>
>>>> bpf_fs_listxattr() is only reachable through the filesystem via
>>>> i_op->listxattr, so the BPF token inode is left untouched. Name-based
>>>> fsetxattr()/fgetxattr() on a token fd still work since the get/set
>>>> handlers are installed at the superblock.
>>>>
>>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>>> Cc: Christian Brauner <brauner@kernel.org>
>>>> ---
>>>>    kernel/bpf/inode.c | 254 ++++++++++++++++++++++++++++++++++++++++++---
>>>>    1 file changed, 237 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
>>>> index 25c06a011825..638aa996cbaf 100644
>>>> --- a/kernel/bpf/inode.c
>>>> +++ b/kernel/bpf/inode.c
>>>> @@ -21,6 +21,9 @@
>>>>    #include <linux/bpf.h>
>>>>    #include <linux/bpf_trace.h>
>>>>    #include <linux/kstrtox.h>
>>>> +#include <linux/xattr.h>
>>>> +#include <linux/security.h>
>>>> +
>>>>    #include "preload/bpf_preload.h"
>>>>    
>>>>    enum bpf_type {
>>>> @@ -30,6 +33,22 @@ enum bpf_type {
>>>>    	BPF_TYPE_LINK,
>>>>    };
>>>>    
>>>> +struct bpf_fs_inode {
>>>> +	struct simple_xattrs	*xattrs;
>>>> +	struct inode		vfs_inode;
>>>> +};
>>>
>>> Note that we are in the process of making this a lot more elegant and
>>> the interface changes significantly because of this.. The patches for
>>> this are currently in vfs-7.2.misc. I can shove them onto vfs-7.2.xattr
>>> and keep that branch stable so you can build it on top of it. You can
>>> merge that branch into -next. I won't touch it again. Just tell me if
>>> you want to do that.
>>
>> Good to know, thanks! We could probably pull that particular branch into
>> bpf-next once you push it out, and then I can rework & resubmit the patches
>> on top of it.
> 
> Nice, thanks. I've pushed vfs-7.2.xattr and marked it as shared now.

Awesome, thanks!
