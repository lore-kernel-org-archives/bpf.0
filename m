Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B5408014;
	Fri, 10 Jul 2026 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685853; cv=none; b=EqoFQ70/RoseaWxUGGi2DpDGpI9K43Umy62ErG3kWTnMqe4vxFPCSB43uKxirNIWEyxPXXWO07EAkeOayWpaozlMRrkeOmFwOayUVKnRIvthsoBIB8ZZReKiVAEPJncQihHSdm479DTvkXNYPfS4K60JyeAZcbxl9OXcPkQ0hq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685853; c=relaxed/simple;
	bh=QH3ypTBThWLx2yzXbQtsMjbM9zD9szUxg1+lAOb70GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzjXH5DrMisjfuzbbcSzJereUiGLYgOUNPHzSnTNJhM14ws1/mkEAN0gVdF1ltN9XbzJxvoWu/y79vVdHiOwkqakop6KqyaSfBNg03n5qGuGsjKp3vN1Pkd4zZbJDE3Y0JcIiZ1dgC2ZIbZvJgoe/ljMKszPHwR73aZ8U86IKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=fxZPDxOg; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fxZPDxOg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fgmRBpjGBlz4D8Ta3gytmcGGk/kFhfjPCclltIQNQxM=; b=fxZPDxOgsDn4BOI4RxZCxcfihD
	oKyxBcwoBfKtl98B8qq499qYUqTAwBMytwi2UoZq0flwE0v9+n8bDSdVQKg6UqZ6X6J7GU5i58yX3
	k6IVgvmVYQl802JiqXRYHFOoO+OmplN6hNdI7AEfp26KvHT9UjYteYLx7C/h3xkFOVhpPM2ZaPXRg
	A2quFzV3zW59QLeJAGSuUcK18i8sICD+PDb2npqYKmmkzz1Y1Z53Vn4VT6SPSJkSz56haFnFgDZdX
	pfeozxdQ6FplFW9I0/CQtr+q8li5qbJrViB/9LMnd+p3ok/AI4QGfbOKRfBamolUERaEhK0NQ14lT
	Zcw1n0sA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wiAAZ-000Fub-2B;
	Fri, 10 Jul 2026 14:17:27 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wiAAZ-0003f2-2q;
	Fri, 10 Jul 2026 14:17:27 +0200
Message-ID: <01421d53-c379-4044-9da3-5990186303ef@iogearbox.net>
Date: Fri, 10 Jul 2026 14:17:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs/vfs-7.2.xattr v3] bpf: Add simple xattr support to
 bpffs
To: Carlos Llamas <cmllamas@google.com>,
 Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>
References: <20260602074012.416289-1-daniel@iogearbox.net>
 <20260603-abwenden-plagiat-abtropfen-31bd59c3140b@brauner>
 <akWdcp6P0FkNDzBk@google.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <akWdcp6P0FkNDzBk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28056/Fri Jul 10 08:24:04 2026)

On 7/2/26 1:06 AM, Carlos Llamas wrote:
> On Wed, Jun 03, 2026 at 09:07:55AM +0200, Christian Brauner wrote:
>> On Tue, 02 Jun 2026 09:40:12 +0200, Daniel Borkmann wrote:
>>> Add support for extended attributes on bpffs inodes so that user space
>>> and BPF LSM programs can attach metadata, for example, a content hash
>>> or a security label - to a pinned object or directory. BPF LSM or user
>>> space tooling can then uniformly look at this (e.g. security.bpf.*) in
>>> similar way to other fs'es. The store is in-memory and non-persistent:
>>> it lives only for the lifetime of the mount, like everything else in
>>> bpffs. The modelling is similar to tmpfs.
>>>
>>> [...]
>>
>> Applied to the vfs-7.2.xattr branch of the vfs/vfs.git tree.
>> Patches in the vfs-7.2.xattr branch should appear in linux-next soon.
>>
>> Please report any outstanding bugs that were missed during review in a
>> new review to the original patch series allowing us to drop it.
>>
>> It's encouraged to provide Acked-bys and Reviewed-bys even though the
>> patch has now been applied. If possible patch trailers will be updated.
>>
>> Note that commit hashes shown below are subject to change due to rebase,
>> trailer updates or similar. If in doubt, please check the listed branch.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>> branch: vfs-7.2.xattr
>>
>> [1/1] bpf: Add simple xattr support to bpffs
>>        https://git.kernel.org/vfs/vfs/c/a146500e1144
> 
> Hey Christian / Daniel,
> 
> I'm getting a regression with this patch when using genfs for bpffs. It
> seems like calling selinux_inode_init_security() with !SBLABEL_MNT will
> leave the isec->initialized before doing the EOPNOTSUPP exit.
> 
> The genfs path is later skipped because inode_doinit_with_dentry() sees
> the inode initialized and I get denials in userspace.
> 
> I don't know if this would be correct but doing the check for
> SBLABEL_MNT before marking the isec as initialized worked for me.
> 
> Any thoughts? Should I send a formal patch?

Yeap, sorry for the delay; fwiw looks reasonable.

> Carlos Llamas
> 
> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0f704380a8c8..9cb1724d2bbc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2980,6 +2980,10 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>   	if (rc)
>   		return rc;
>   
> +	if (!selinux_initialized() ||
> +	    !(sbsec->flags & SBLABEL_MNT))
> +		return -EOPNOTSUPP;
> +
>   	/* Possibly defer initialization to selinux_complete_init. */
>   	if (sbsec->flags & SE_SBINITIALIZED) {
>   		struct inode_security_struct *isec = selinux_inode(inode);
> @@ -2988,10 +2992,6 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>   		isec->initialized = LABEL_INITIALIZED;
>   	}
>   
> -	if (!selinux_initialized() ||
> -	    !(sbsec->flags & SBLABEL_MNT))
> -		return -EOPNOTSUPP;
> -
>   	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
>   	if (xattr) {
>   		rc = security_sid_to_context_force(newsid,

