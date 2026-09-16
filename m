Received: from mail-ej2-f28.google.com (mail-ej2-f28.google.com [74.125.228.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EE3443E31
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543797; cv=none; b=JXnK7AzVY7mD0FHrhmIdGGzuPhquHK2ZfI3X1ItLn5Rb1hsTHQObeOJRbDJ0RlWBq4uYMpCUkcnegVaAOxd+V9tXtKyTMwpkV53mzi1PFL8bp2G98Uar5qSE704FR4zERMDQxrEjIbdZW+ZSPRbo00ToCVZDEdRs2yv+w4SgL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543797; c=relaxed/simple;
	bh=bmmtTqNINt0Ys7otl8qQIKrpJEF4Ec2i5M8l0wtuXWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0ErbybBTEb7APacXP/+Kjjmatzh26ACFhDGHs8tDL3wnoFN1IvsglfNrlak2/yozMZDsGdKPLDnLSOvKmwbldOVAybggoSeISHLple75CmNp6YrNk4+568m/HhE59yp+dFblrIpTqCeRb440UuEYZYDLTuunzc1yke9+KkibAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tpm3xldB; arc=none smtp.client-ip=74.125.228.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tpm3xldB"
Received: by mail-ej2-f28.google.com with SMTP id a640c23a62f3a-c29385fb97cso5564366b.3
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789543784; x=1790148584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R8y6AgD1DWAa0DwP9jnsCXImYYgKSkF2Ce/d73expsA=;
        b=Tpm3xldBuLLNgvBRNbX9t4rGsA2XpXTH0rZ4uNMdhZk+PlM34OeIuM9nXLFgbwDRaU
         1ZtNIPIpHfSIbPoD8/uBuCLVWwpn5nBK8QJRLWbbeVEbE4Vw8JTp8DDL9tac5L9anVo5
         PalFF7GlCsxdCipHsQ1zIU4VJTRBDYDrYhSY2d8UwsVADuxaVCoEuo/HrMADN5rPRPnQ
         wEIKuZYD+FFfRIMYEA+9cAjnBjr+HCAGASi20m4+MjTietW+D/Uuh/N2M2/xzA/K3TM3
         GTc0eFS5VcerV+yg+sDac32yHK4fG/phOidtDj1hMtnGDPQg556OA8Ik97KA2Dhvx7XH
         3G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789543784; x=1790148584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R8y6AgD1DWAa0DwP9jnsCXImYYgKSkF2Ce/d73expsA=;
        b=bh5WvuNSN1ZwGT+S2IJRwtHeYtsILblHRdLVA4Kv8/AbHAxFwzhpJyPs8wwOIzY2Xq
         O1bx+VEbhsnj9qSQilYZvbZ/gPi7rAIqLMZ7QFUF0qs2iwTyv8QZGL5zmytbfTpnmRiK
         +mOhcznQBi45sdrR9igQxqLP9XX7pTM28NpYMQX5/GmTh1EwFo1xR8yFbgLO/iyMihY1
         QeoMrsD46IYfBF8xs1O/kc/XBBs69F4Ap6uADsIFOgQ+GqNFpQC3CqG8sNjpVNy+da5J
         SgNHSO2H9b8TvgJ4gQ6Dr2noylCa1pXHZt8zKGoStxsa3JbTdW3hAqolPBBeXAVIDuVe
         oKiw==
X-Forwarded-Encrypted: i=1; AKwUvBzBVQks3Q6HEJCmXnR5YTUPNnYY45DntwMZQPtBVEAGfaOyRVa/fNy6cAQ3iioh1ZOfb3o=@vger.kernel.org
X-Gm-Message-State: AFuF++l7BlRNCk5WKZH43+CngmDhmYqX4x9udbbDKeDK2nQQBGr+QtIy
	XL3BoIuxYStLHZ95c8LPT8zGkBMiA89IY+6PsUmPuzfP0GyipgDFLy8FU4B4CT2ORfE=
X-Gm-Gg: AYBFou1ckMwZfbl8y0DSEek/EgAvsg0rXRpbrXX54krxJXIFjMjNnyvBRqa+o4Jdrqw
	ItqCvVGQydW1q7npQK3WYzlQ3HbVuFRxFsT1CnHRdmOEZJ2pivBl1N/0a988lmAk4TSHFTvV9fP
	cD27N7uTKSgRJRxK5SVKujEUHhdT1gOMOgG+K6idQFHkoQZ08zGE1roM/H72qAob5QUXyQCYxjE
	xz1RPLbsd6BDAM1GjYAlJ0ZjSYXARFlvoUPHbvmccfDmzQ8YZOt51WqOISnP1qicfcuzxBP6h/I
	5rKp8kNfRz2Yiug8QNg3Kod9vKROpTw8GZWyDhgOqC+lm7EWmJFUWtzIvhVSKLKjR+NGG9luWB3
	7Agevb76LinWAKVH00/bD/7ch6P31T0MiwCnDCoYvQ1MiDDn04ZvaOB4MiH3fUqFiSZqWOXZcLe
	OBYpzb43cSU16jjm1TmIhKUR9pWn44OeBHCkoZwBNMAsRODdtRZVTKgDXcaDReP1fvn8J+2+w=
X-Received: by 2002:a17:907:c05:b0:c29:5637:ed76 with SMTP id a640c23a62f3a-c29e52c0dc3mr93106966b.2.1789543784244;
        Wed, 16 Sep 2026 00:29:44 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89ee75c9sm6672175ad.57.2026.09.16.00.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:29:43 -0700 (PDT)
Date: Wed, 16 Sep 2026 15:29:40 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Daniel Borkmann <daniel@iogearbox.net>, joseph.qi@linux.alibaba.com
Cc: alexei.starovoitov@gmail.com, brauner@kernel.org, dwindsor@gmail.com, 
	john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org, matt@bobrowski.net, 
	bpf@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH bpf-next 1/8] ocfs2: Copy the xattr name in
 ocfs2_initxattrs
Message-ID: <aqpFJ6qeEBYBu7is@p15>
References: <20260915150739.284189-1-daniel@iogearbox.net>
 <20260915150739.284189-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915150739.284189-2-daniel@iogearbox.net>

On Tue, Sep 15, 2026 at 05:07:32PM +0200, Daniel Borkmann wrote:
> ocfs2_mknod() and ocfs2_symlink() ask for the security xattr up front
> through a struct ocfs2_security_xattr_info, so that they can size the
> transaction before setting it. ocfs2_initxattrs() duplicates the value
> since the array security_inode_init_security() hands is freed on return,
> but keeps the name pointer as-is, given so far every LSM stored a string
> constant there. bpf_inode_init_xattr() places the name in the same
> allocation as the value, which security_inode_init_security() frees on
> its way out. Copy the name alongside the value and free both together.
> This is the only special case wrt xattrs in the bpf_inode_init_xattr()
> context.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

LGTM.
Reviewed-by: Heming Zhao <heming.zhao@suse.com>
> Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: ocfs2-devel@lists.linux.dev
> ---
>  fs/ocfs2/namei.c | 2 ++
>  fs/ocfs2/xattr.c | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index e9c7774ccf91..e24f0e337a56 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -480,6 +480,7 @@ static int ocfs2_mknod(struct mnt_idmap *idmap,
>  
>  	brelse(new_fe_bh);
>  	brelse(parent_fe_bh);
> +	kfree(si.name);
>  	kfree(si.value);
>  
>  	ocfs2_acl_init_release(&acl_state);
> @@ -2068,6 +2069,7 @@ static int ocfs2_symlink(struct mnt_idmap *idmap,
>  
>  	brelse(new_fe_bh);
>  	brelse(parent_fe_bh);
> +	kfree(si.name);
>  	kfree(si.value);
>  	ocfs2_free_dir_lookup_result(&lookup);
>  	if (inode_ac)
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 35bcbb0ff607..d83840b6bed9 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -7524,8 +7524,9 @@ static int ocfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array
>  				    GFP_KERNEL);
>  		if (!si->value)
>  			return -ENOMEM;
> -
> -		si->name = xattr_array->name;
> +		si->name = kstrdup(xattr_array->name, GFP_KERNEL);
> +		if (!si->name)
> +			return -ENOMEM;
>  		si->value_len = xattr_array->value_len;
>  		return 0;
>  	}
> -- 
> 2.43.0
> 
> 
