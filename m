Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A803EEAF4
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346589; cv=none; b=WO+9YvZDUskRvKlsmjvUGtdzP0criqn1LGizkzDAr5gJMbBVFV3n6u9+h31ELlSitPsPbtBZ3CKzcTkP9SwH14IE79D/zNa8eF8AM8HWXkyLHj5YvsuixxCd8YckXv3c64yAQd5L+/o0GK97aegoOeLJb8VMA/9ESKKicqgggS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346589; c=relaxed/simple;
	bh=IU9mD72RW6tOuUl4nsToXOsYhlFvtbvwkM8BaO+7sZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFRWYgLQHYKmKu+djnKc11Q+n6AJ64Kl2g9y5SgYBJF5gedUTf4mBfNq3wC9Gq7PfzUis4J/wDmpoDjpaV9n0KrlFR41wzaDLYLbp6FlBTiooTntt5uIQgOgFA+NmTKcgOtTZ3iF6M7C48JcqHQfi4JFVkER3UAxYfFhUyjIt6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QqaIeAfZ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QqaIeAfZ"
Message-ID: <d8ee5e71-aa2c-4131-ac80-7896b1042ae2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780346575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYdVNKBJgvNp8FnUHs378L7WyhpJusvPXtKEO7BsI3c=;
	b=QqaIeAfZDgY8SupkljbWyZ3HOWu102BZMpRDpyc2nm3ue/OLdDbgSDScXqsEnco7YdodCA
	5qSKzMVEVwdsFPK1CH+klnyXxZ7y92uvOdPpo9bxd0LSHf1bkZw+8yFnMtj+uHSwXvl/Nj
	w+gnAVyNX463b+aLTxFYLl4/1LYzCSA=
Date: Mon, 1 Jun 2026 13:42:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: defer bpffs symlink inode freeing until RCU grace
 period
Content-Language: en-GB
To: hongao <hongao@uniontech.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 jolsa@kernel.org, kafai.wan@linux.dev, linux-kernel@vger.kernel.org,
 syzbot+0962e3a1af6d5e26a52c@syzkaller.appspotmail.com
References: <B36A1A9E983EE6EC+20260530013022.1692378-1-hongao@uniontech.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <B36A1A9E983EE6EC+20260530013022.1692378-1-hongao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/29/26 6:30 PM, hongao wrote:
> bpffs currently frees inodes directly from ->destroy_inode(). This can
> race with RCU path walk following a bpffs symlink: a lookup reader may
> still hold an unstable inode pointer while unlink frees the inode
> memory, leading to a KASAN use-after-free in
> security_inode_follow_link().
>
> Keep BPF object reference dropping in ->destroy_inode(), where sleeping
> cleanup is allowed, but move symlink target and inode memory freeing to
> ->free_inode() so VFS releases them after an RCU grace period.
>
> Fixes: 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning htab with internal structs")
> Reported-by: syzbot+0962e3a1af6d5e26a52c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0962e3a1af6d5e26a52c
> Tested-by: syzbot+0962e3a1af6d5e26a52c@syzkaller.appspotmail.com
> Signed-off-by: hongao <hongao@uniontech.com>

Please have tag [PATCH bpf] to indicate it is form bpf tree.
Please have proper name instead of hongao. See examples in bpf repo.
Other than the above, the patch LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/inode.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 25c06a011825..a1e9660f9237 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -766,10 +766,14 @@ static void bpf_destroy_inode(struct inode *inode)
>   {
>   	enum bpf_type type;
>   
> -	if (S_ISLNK(inode->i_mode))
> -		kfree(inode->i_link);
>   	if (!bpf_inode_type(inode, &type))
>   		bpf_any_put(inode->i_private, type);
> +}
> +
> +static void bpf_free_inode(struct inode *inode)
> +{
> +	if (S_ISLNK(inode->i_mode))
> +		kfree(inode->i_link);
>   	free_inode_nonrcu(inode);
>   }
>   
> @@ -778,6 +782,7 @@ const struct super_operations bpf_super_ops = {
>   	.drop_inode	= inode_just_drop,
>   	.show_options	= bpf_show_options,
>   	.destroy_inode	= bpf_destroy_inode,
> +	.free_inode	= bpf_free_inode,
>   };
>   
>   enum {

