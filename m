Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAF443A8E
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543734; cv=none; b=HSWemkHw8eD3k5xEsFDInHRba7rKbti7dUIr3R0V19p5DTa37U2W83LsMkUc+5WcXx3nPLi+CURu4If033Zh5Po/pqDhcKoeZ0X/9UQ6fxRNM7r/bmFPGU1IriEGez9EDVyMZ+v7ihjWhV+Txw9Zb/YlxQs9BVVdCTGhID7wo/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543734; c=relaxed/simple;
	bh=IC/3z8Hy6TaGkc5gtqi+JgSvdwlyuX/Ckb5Lj0+8K78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNNo/X96nRU0O3RMbQdDjG8JTyyiG6+YtnsmePSdr8NKJ3Z3kg/7xM2kQwwNVJq9uwVxmak+Knee3/PnWzsfUGw4IsgFQKm4AgbCsiAsJ62+ImSGINR2lfUj1w5ZdLcQNtmNqY/RAySUxAE+NBZlViao1PknTQ5WeEnzT2iy0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TsBB1NN1; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TsBB1NN1"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c25085f2426so6670766b.3
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 00:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789543715; x=1790148515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1uZ+Ugw6iVFEpPAYFuF70IRw1n6Gz3zCvuDx5V84fpQ=;
        b=TsBB1NN1QD3STi+xoxLfMjpfJoTsJfbA/5CW8A/jIpAcgIKOES/lHCM8oVdsnBsN4u
         FLVmB4bamC0z4eQuxhj/2hRJknvAE/ASYHn1aQlAYRe3S/Xrp/7a6JZwpvsY9RklY0mV
         7VlZICFyjCi28p8nudzWuIDQ9M/su0LY+N6SKsIWHffh2TL5YZ2/1dKKXHgdNvtYTPnY
         CVsxD+dPiCSu2y7ZZZakuebkiwuR3dY2S9ucOtmaDSHmfi7S9lvgkz/jps4BIlNLHnn6
         CY6m0yS3jHpDFRZ6nCBMLm6WR0FnhlIxQcZkaBKwN7cWMCERdLeQ3cg6uG7VQkxp+voZ
         uXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789543715; x=1790148515;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uZ+Ugw6iVFEpPAYFuF70IRw1n6Gz3zCvuDx5V84fpQ=;
        b=EUFnknzg/zp7L9eft0QaNJXhJ3xLQNaeKnv6fSnGiQzjy0pj1n0EL5j4pC+K9OHWIK
         hWuBAWN//7BADMZflKaauEsc8RMwCsyLs4srUPtgFvO3qc6Sjm4cuothi8xAdVgfwNjp
         tX/xX0QaxYHW8mIBioEmNCcy1unP4Ut3u1aDo77h+H2wpM6/JHYzQFCCf4/vk5s0fS3W
         fuu4kaoLqRJ2r6sXemMmMuE5rzo4uOd7wGo3tImd2oUQI8Z2U+yZNVBMJHNyrO6jZ+o7
         G1m2C2eH6u2hBca7SQopWylP+gnuRj0goG1dyMQIbsgGQ9xavgWRwGVFUEF9hGqxEd/D
         cfgg==
X-Forwarded-Encrypted: i=1; AKwUvBwoq3KKQsgWlF47tr8PnqFS+apoOvn0cfrnm0FcqDC/FLcWlIzYFrFNUGUS8vpFUAx2TR4=@vger.kernel.org
X-Gm-Message-State: AFuF++lQuu4rfO0XCzqAJXTExQsGHwLosinBzZqDHGv5h9wQF7MO+1BZ
	pMQ3WLGA49dUd7nFiw0EIciQMT6dwV4P+WkpoBQYX5kKJQ79JqcwzxDSwJ5126F0upM=
X-Gm-Gg: AYBFou2hrHV0eoP1vDSAuBFrylFXuPq7bOJ9PJZoKHZPwrWiPjseOh6C4zClqk7QyI7
	Sp9kneaxjiCDtNTN6+P+JiJtSj/bu+az95VERD2qJD8SpyGbbqf/zgRVqRiWheu2vwSBdBHmruh
	BX9uXTkDP2DvNK2n9Kts5Y1VxnmbL97eIE8PG3dJOscGdXktjInSIe+ZvQROBBE9c75Qm6NjycS
	LwwIZ1YztGE3LeinIyz4Ulg4QjxjzX5kKM53rS2mHVjXPS75InCcQaFjZNhrmiGwkVq5Z15dUCl
	F/DwNOs6RkTadH2g2QCQNACt+w22vV3zr1lwkkGGUJMLMv2JIIUVVA8L9YvW8ybws6b49xu/jem
	U07Ia37oLvfwCP243X9ogZHTR+Yctte4UULsUnGtOeEyhL5WCm4hDqX2OUQrOQeSlzaelYA+Rza
	myWtbuPWEwwp1IBqs1AVsG4H4fEqjtawWs8qubXiRofIUj+zd4O/yc2ElmuRTxsAp3JBgCoQ==
X-Received: by 2002:a17:907:3f1a:b0:c15:c651:f28f with SMTP id a640c23a62f3a-c29e53aa447mr104464766b.3.1789543714645;
        Wed, 16 Sep 2026 00:28:34 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1d0be48csm822599a91.3.2026.09.16.00.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:28:32 -0700 (PDT)
Date: Wed, 16 Sep 2026 15:28:29 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: alexei.starovoitov@gmail.com, brauner@kernel.org, dwindsor@gmail.com, 
	john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org, matt@bobrowski.net, 
	bpf@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH bpf-next 1/8] ocfs2: Copy the xattr name in
 ocfs2_initxattrs
Message-ID: <aqpEvwAtkyohFrRQ@p15>
References: <20260915150739.284189-1-daniel@iogearbox.net>
 <20260915150739.284189-2-daniel@iogearbox.net>
 <aqoCVQ78KOo2GZ8S@p15>
 <f05cc7fb-9766-4b2d-9422-45ea1822578a@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05cc7fb-9766-4b2d-9422-45ea1822578a@iogearbox.net>

On Wed, Sep 16, 2026 at 09:07:13AM +0200, Daniel Borkmann wrote:
> On 9/16/26 4:47 AM, Heming Zhao wrote:
> > On Tue, Sep 15, 2026 at 05:07:32PM +0200, Daniel Borkmann wrote:
> > > ocfs2_mknod() and ocfs2_symlink() ask for the security xattr up front
> > > through a struct ocfs2_security_xattr_info, so that they can size the
> > > transaction before setting it. ocfs2_initxattrs() duplicates the value
> > > since the array security_inode_init_security() hands is freed on return,
> > > but keeps the name pointer as-is, given so far every LSM stored a string
> > > constant there. bpf_inode_init_xattr() places the name in the same
> > 
> > Typo? I am not familiar with BPF, but I only found inode_init_security in
> > include/linux/lsm_hook_defs.h.
> 
> Its part of the series here; should have added "upcoming" in front:
> 
>   https://lore.kernel.org/bpf/20260915150739.284189-1-daniel@iogearbox.net/
> 
> > > allocation as the value, which security_inode_init_security() frees on
> > > its way out. Copy the name alongside the value and free both together.
> > > This is the only special case wrt xattrs in the bpf_inode_init_xattr()
> > > context.
> > > 
> > > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>
> > > Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> > > Cc: ocfs2-devel@lists.linux.dev
> > > ---
> > >   fs/ocfs2/namei.c | 2 ++
> > >   fs/ocfs2/xattr.c | 5 +++--
> > >   2 files changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> > > index e9c7774ccf91..e24f0e337a56 100644
> > > --- a/fs/ocfs2/namei.c
> > > +++ b/fs/ocfs2/namei.c
> > > @@ -480,6 +480,7 @@ static int ocfs2_mknod(struct mnt_idmap *idmap,
> > >   	brelse(new_fe_bh);
> > >   	brelse(parent_fe_bh);
> > > +	kfree(si.name);
> > >   	kfree(si.value);
> > >   	ocfs2_acl_init_release(&acl_state);
> > > @@ -2068,6 +2069,7 @@ static int ocfs2_symlink(struct mnt_idmap *idmap,
> > >   	brelse(new_fe_bh);
> > >   	brelse(parent_fe_bh);
> > > +	kfree(si.name);
> > >   	kfree(si.value);
> > >   	ocfs2_free_dir_lookup_result(&lookup);
> > >   	if (inode_ac)
> > > diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> > > index 35bcbb0ff607..d83840b6bed9 100644
> > > --- a/fs/ocfs2/xattr.c
> > > +++ b/fs/ocfs2/xattr.c
> > > @@ -7524,8 +7524,9 @@ static int ocfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array
> > >   				    GFP_KERNEL);
> > >   		if (!si->value)
> > >   			return -ENOMEM;
> > > -
> > > -		si->name = xattr_array->name;
> > > +		si->name = kstrdup(xattr_array->name, GFP_KERNEL);
> > > +		if (!si->name)
> > > +			return -ENOMEM;
> > 
> > The ->name is a constant string (i.e., XATTR_NAME_SELINUX). We can refer to
> > ext4_initxattrs() => ext4_xattr_set_handle(), which also uses '=' to assign ->name.
> ext4 is not affected since nothing is used outside security_inode_init_security
> callback. ocfs2 is the only case in the tree affected, see this sashiko report
> which this small patch is addressing:
> 
>   https://lore.kernel.org/bpf/CAEXv5_gTJcP5BkSysZujLxiUcjbbBNi_NNbAnOJsQQVLyO9HoQ@mail.gmail.com/
> 
> Thanks,
> Daniel

Got it, the patch looks good to me.

Thanks,
Heming
