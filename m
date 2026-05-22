Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2337F736;
	Fri, 22 May 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462552; cv=none; b=R/tfloTJR6jBV5CWldKNHySci01T+MC8oVVe6S55VUE/T8i0UmsPkyQU24KjUO90wOlTvkcdgC5k/J6r+4xSydsM+FIf08keEa/wrHRp/CMQddhs56OvCxMQdIlKl6kUdBb6tDQXrc4SNyx3mJXSRt9CgwyD9mGeAoPlQODOiRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462552; c=relaxed/simple;
	bh=1Gi+X3nKQB7uXZwsvfUnK3q8KPcY4vrJ9t/1Eql0DJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuSj/YAidhiME/pdGiRL1F7Bg1t4/J9gkkENkRSNG3ma/DglY18norxLdjesCVeM+s1m2zc7nsqsAKDTNscbi+wHRg6ZfNQxdEp+fmKXKiubij/3QTbEPcRLsMlFueivUeclkoJ5wuLaYokL36J18GDFv32z9M5AYbIsP+/c9CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QURClF8+; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QURClF8+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YNX0HLhlWV61z0zqHSdioFpQe9lQsX0gcyT2y1GLi8g=; b=QURClF8+nZC5YtOzXgxwjqusUd
	6zorQWNzYhfF/LQVyPzsvzXvVxc955IxFnt2dhORxVzGkptZ3D3MPm3ni+IilrWCiHhwiWjTPdd7D
	nWtZz7M7Vpd5TyE43yWl6WjsuLy3q7X7IsSsb9wqRah2BME5OZTkOmtStIizCAivCgwWacfkvkR/F
	rDVDBQfQs3O3yUdu/e9mIgG2SdYhjYuIeoZYeOO39SDEYZDFbW6d9d90+2bATb2bIl0JuNDVd9b9m
	LKM6r+wqJ/n5lOqQ1EY0/BZR0497JA4giQpuSMh7eykNoFglChvnGVSh3ncng/TDwW9H3Iis+5kgK
	0ckJwFww==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wQRUp-00040S-0a;
	Fri, 22 May 2026 17:09:07 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wQRUq-000Osy-2D;
	Fri, 22 May 2026 17:09:08 +0200
Message-ID: <3cc241a3-eaac-4395-a9a2-2b405eb0ca42@iogearbox.net>
Date: Fri, 22 May 2026 17:09:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf: Add simple xattr support to bpffs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260522135626.120732-1-daniel@iogearbox.net>
 <20260522144818.DD7EB1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260522144818.DD7EB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28008/Fri May 22 08:24:46 2026)

On 5/22/26 4:48 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unprivileged users can exhaust kernel memory via unbounded user.* extended attributes on bpffs.
> - [High] NULL pointer dereference in bpf_fs_initxattrs() if an LSM returns a NULL xattr value.
> --
> 
> commit 57543eec66ace3d4d002256a01cff4f1797f61e2
> Author: Daniel Borkmann <daniel@iogearbox.net>
> 
> bpf: Add simple xattr support to bpffs
> 
> This commit adds support for extended attributes on bpffs inodes, allowing user
> space and BPF LSM programs to attach metadata to pinned objects or directories.
> The xattr store is in-memory and lives only for the lifetime of the mount.
> 
>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
>> index 25c06a0118258..638aa996cbaf4 100644
>> --- a/kernel/bpf/inode.c
>> +++ b/kernel/bpf/inode.c
> 
> [ ... ]
> 
>> @@ -762,22 +821,151 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
>>   	return 0;
>>   }
> 
> [ ... ]
> 
>> +static int bpf_fs_xattr_set(const struct xattr_handler *handler,
>> +			    struct mnt_idmap *idmap, struct dentry *unused,
>> +			    struct inode *inode, const char *name,
>> +			    const void *value, size_t size, int flags)
>> +{
>> +	struct bpf_fs_inode *bi = BPF_FS_I(inode);
>> +	struct simple_xattrs *xattrs;
>> +	struct simple_xattr *old;
>> +
>> +	name = xattr_full_name(handler, name);
>> +	xattrs = simple_xattrs_lazy_alloc(&bi->xattrs, value, flags);
>> +	if (IS_ERR_OR_NULL(xattrs))
>> +		return PTR_ERR(xattrs);
>> +	old = simple_xattr_set(xattrs, name, value, size, flags);
> 
> [Severity: High]
> Does this code allow an unprivileged user to exhaust kernel memory?
> 
> Because bpffs can be mounted in an unprivileged user namespace
> (FS_USERNS_MOUNT), a user could create directories and repeatedly set user.*
> extended attributes.
> 
> Since simple_xattr_set() does not enforce per-inode limits like
> simple_xattr_set_limited() does, couldn't this lead to an unbounded memory
> allocation and soft lockups during rhashtable traversals?

Ok, for user.* simple_xattr_set_limited should be the choice then, will
fix in a v2.

>> +	if (IS_ERR(old))
>> +		return PTR_ERR(old);
>> +	simple_xattr_free_rcu(old);
>> +	inode_set_ctime_current(inode);
>> +	return 0;
>> +}
> 
> [ ... ]
> 
>> +static int bpf_fs_initxattrs(struct inode *inode,
>> +			     const struct xattr *xattr_array, void *fs_info)
>> +{
>> +	struct bpf_fs_inode *bi = BPF_FS_I(inode);
>> +	const struct xattr *xattr;
>> +	size_t len;
>> +
>> +	CLASS(simple_xattrs, xattrs)();
>> +	if (IS_ERR(xattrs))
>> +		return PTR_ERR(xattrs);
>> +
>> +	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
>> +		CLASS(simple_xattr, new_xattr)(xattr->value, xattr->value_len);
>> +		if (IS_ERR(new_xattr))
>> +			break;
>> +
>> +		len = strlen(xattr->name) + 1;
>> +		new_xattr->name = kmalloc(XATTR_SECURITY_PREFIX_LEN + len,
> 
> [Severity: High]
> Can this cause a NULL pointer dereference?
> 
> If an LSM program returns a NULL xattr value, the simple_xattr class
> constructor will call simple_xattr_alloc() which can return NULL.
> 
> The IS_ERR(new_xattr) check evaluates to false for a NULL pointer, leading
> to a NULL pointer dereference when accessing new_xattr->name here.

(false positive: security_inode_init_security() array always have non-NULL
value paired with non-NULL name.. also in line with shmem_initxattrs)

>> +					  GFP_KERNEL_ACCOUNT);
>> +		if (!new_xattr->name)
>> +			break;
>> +
>> +		memcpy(new_xattr->name, XATTR_SECURITY_PREFIX,
>> +		       XATTR_SECURITY_PREFIX_LEN);
> 
> [ ... ]
> 

