Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8B212548
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776992794; cv=none; b=koneVuKiLj21KKYtY+IMSRmZ+AjAtKNXeTm5PpNavK1JyWYSA2kP/EzIllCDxXmmYMs/8AjRqRrdcVjkebLXHwW6HAfoiOr9/orPMBKRBdFYXovw0gIOKMgpY1fs6EDK7UmToFWnsVBlz1M6G1vlO8zWpcSjcPNE+m3iJ4yaBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776992794; c=relaxed/simple;
	bh=7LMM95UMg7yP38DZK0skWWp8cJR2GRO6hI/cI7m0eOM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I6lmPNKxOD7wXdgHx+c4asfdW5h9xK7LNBGY/09dJK189UpBkxMrXKMkBbIG1m6w4T3GC8Yi24rrkRntTrtqVJNYO0AYe5kBFlGCY3A8f+ghPoq2nbRbHFv+0ZJjWmLDhfjtNJO6xxvK2yvmzrRPCBchkMfThVdhqs3ZSYTTzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/MRQZlh; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/MRQZlh"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-479e7e88fb5so2743412b6e.3
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 18:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776992791; x=1777597591; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xh3t/bv0nfHgOMhcW4p/qplYnwzHag4a5ofsHvIRt9Q=;
        b=H/MRQZlhZdxgZmS1uhYvIyrTsc/5ZZ4ueMxuW8CJKMQFlhxq5ZuB6rVV7exasUzdG2
         atmaa0Zdhu0YzKin4nZz28Wer7V/BD4SOaU7O276MdkaSofkO0duHV+pTdUBb9mDahDv
         kIPn3sDfADPnhCRHUCVuIKEsOxk4XPg0N/RzO24gUZsL/MIaI5emSqrHVORt2vrS5Cci
         4WVgs9R2xQyAA6d32FeF1oaKBgCLG+xvaq6tucrRQDUzRRClshuMZj+d2u7SsC0yoDJu
         a8SZfkTlnbDDEqFAY6KML738qHoEnzkh7FHVpB5+9plGlVjhd+hh5fmcAkBvExlmiWrL
         e2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776992791; x=1777597591;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xh3t/bv0nfHgOMhcW4p/qplYnwzHag4a5ofsHvIRt9Q=;
        b=h1ZjhIEN+HhCfmkFCYSmHohyyR+jlaAUpoKpLu7EzbR+VGMefA0GZ1RJjlCTszX7eA
         ZelI4jowwSEyqXpAoHRzvkWLIbJFV+UTATEGU/cnhm6Kj6OZTou/LsIQSnfRofbWulwa
         V4pBBN6orOrWTyunSoTB64kA/AD6vFm9q6mzfU+ebTyRgXv91DiUCBZTUbF63WBFFub/
         LNBBqOZ6Ow4jJFUI7ni06QB1oCFdFVFNpjnxsyHuZIMejmXjbwrGqZGVn0QvWGPSXAYm
         afvHO5fXTYc2kJjuYdcazn+Lf5xKDQKi+saP1ieyY1/RiyIKNrmoxvTNIc4tDqeAK/Xg
         cGpw==
X-Forwarded-Encrypted: i=1; AFNElJ+/GigJWEgioFR/0aWDzANvXsAcw8vj0URcKFS3MDbUKzpMrevBx1Hv3dPKe19p73c1mEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaq4XI/pjsO7RBJX5vOykY3H+WAQ+320jSYclkSxnuJn7ZsFC5
	zPVkbZ6SjwTXTHyR/1CABccO0o1BMRdYIETVx/yT/BZr6iJoOUA+rr1U
X-Gm-Gg: AeBDiesqEr8U8lFQ3WoVbgBwVUjSz2hpKewW+53U8vI1jLYDcQ2kOhDe0QMx0ETkZpX
	mueDvd37wEEirHxy5FQuNaNWtxmzaY6KBm5+6okXFMHBG+iPpPfmmBiPFqu7dyosGl83zmvlIca
	jkVujrRvSXICtCnrqEuyJGOtESgCkRCSLlssdANtlpirOkXnOPHX7NMCDbQWExf0WThtVyPTLoR
	4RFAhUlU2Y6mQzeLDWmkPzZZxEBDp5BcRRs0RfDX8/PCenASeCF6Pvd0xqL2TtDHHhtqVRAlNs+
	okl6NVhkvH8z+Q0xAmd42UjNUWDYOl+fIYnkzJa7vEcCQoajaodJigk5qwdxbZjdbZCvayB0UUe
	q4qBfIobDNqxOWFPFMqWY6T8X/PUJDQl8pr9LP5EMsn4GZO3K5KFQx9yTF4ZUMHN7fYqehG7Dtv
	BIHDVgYMFg9SWPywqUGmCfpNfAQ3bIR+BbWu+rHsGC4h8QIYnl8S5BER3a5JJecMoir0PSdQ6Qt
	8kHGwPYsNE7luCqv9MNXnZge98gBgAYvQq5oA==
X-Received: by 2002:a05:6808:c151:b0:467:5f1:fc93 with SMTP id 5614622812f47-4799c91872fmr14412173b6e.9.1776992791471;
        Thu, 23 Apr 2026 18:06:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42f090b1de9sm8378833fac.6.2026.04.23.18.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 18:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 18:06:28 -0700
Message-Id: <DI0ZDDJQHSXI.2CMCJQ908T1KV@gmail.com>
Cc: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <byoungyoung@snu.ac.kr>,
 <jjy600901@snu.ac.kr>, "Alexei Starovoitov" <ast@kernel.org>, "KaFai Wan"
 <kafai.wan@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>,
 <bpf@vger.kernel.org>, "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [BUG] KASAN: slab-use-after-free in link_path_walk
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Al Viro" <viro@zeniv.linux.org.uk>, "Eulgyu Kim" <eulgyukim@snu.ac.kr>
X-Mailer: aerc
References: <20260423013916.1589029-1-eulgyukim@snu.ac.kr>
 <20260423043906.GN3518998@ZenIV>
In-Reply-To: <20260423043906.GN3518998@ZenIV>

On Wed Apr 22, 2026 at 9:39 PM PDT, Al Viro wrote:
> On Thu, Apr 23, 2026 at 10:39:16AM +0900, Eulgyu Kim wrote:
>
>> We suspect there is a race condition between vfs_rmdir() and may_lookup(=
)
>> on the BPF pseudo filesystem. It seems that while link_path_walk() is wa=
lking
>> a path, its call to may_lookup() checks permissions on the current direc=
tory
>> inode through nd->inode, and vfs_rmdir() can remove that same directory =
and
>> trigger inode destruction, leading to a use-after-free.
>
> Not really.  What happens is that bpf does prompt freeing of struct inode=
, instead
> of having it done with RCU delay.  Everything else is a result of that.
>
> What's going on there?  It used to be in ->free_inode(); who had moved th=
at into
> ->destroy_inode(), why had that been done, who had ACKed that and how hav=
e I
> missed the discussions on fsdevel?
>
> <digs>
>
> commit 4f375ade6aa9f37fd72d7a78682f639772089eed
> Author: KaFai Wan <kafai.wan@linux.dev>
> Date:   Wed Oct 8 18:26:26 2025 +0800
> =20
>      bpf: Avoid RCU context warning when unpinning htab with internal str=
ucts
>
> [blocking stuff done from RCU-delayed callback, so let's make everything =
prompt,
> whaddya mean, what was the delay for?]
>
> Reported-by: Le Chen <tom2cat@sjtu.edu.cn>
> Closes: https://lore.kernel.org/all/1444123482.1827743.1750996347470.Java=
Mail.zimbra@sjtu.edu.cn/
> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Link: https://lore.kernel.org/r/20251008102628.808045-2-kafai.wan@linux.d=
ev
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> OK, that answers some of that...  <looks the posting up>
> To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
> 	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
> 	yonghong.song@linux.dev, john.fastabend@gmail.com,
> 	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
> 	jolsa@kernel.org, shuah@kernel.org, kafai.wan@linux.dev,
> 	toke@redhat.com, linux-kernel@vger.kernel.org,
> 	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
>
> ... right, that probably answers the last one.  Incidentally, that commit=
 has
> brought back the old bug with cached symlink bodies getting freed without=
 RCU delay.
> It is possible that it was discussed on fsdevel at some point and I'd mis=
sed it
> there, but...
>
> Folks, the rules are simple:
> 	* anything that might be accessed in RCU mode (inode very much included
> for objects that are visible in the tree) must be freed after RCU delay; =
that's
> what ->free_inode() is for.
> 	* anything that can't be freed in such context should either be
> dealt with in ->destroy_inode() (if it isn't needed for RCU-exposed metho=
ds)
> or, if it really is needed for those, done via schedule_work() or equival=
ent
> done by ->destroy_inode().
>
> Seeing that bpffs has the grand total of zero RCU-exposed methods (no ->d=
_compare(),
> no ->d_hash(), no ->permission(), no ->d_revalidate(), no ->get_link()) I=
 would
> guess that it's the case of "have your bpf_any_put() done promptly, leave=
 freeing
> the inode and cached symlink body RCU-delayed".  Something like the delta=
 below
> (completely untested):
>
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 25c06a011825..bd052a8e89a9 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -762,14 +762,26 @@ static int bpf_show_options(struct seq_file *m, str=
uct dentry *root)
>  	return 0;
>  }
> =20
> +// this is done promptly
>  static void bpf_destroy_inode(struct inode *inode)
>  {
>  	enum bpf_type type;
> =20
> -	if (S_ISLNK(inode->i_mode))
> -		kfree(inode->i_link);
> +	// better done here, since it's blocking and we'd need
> +	// to use something like schedule_work() to do it from
> +	// ->free_inode(); since this stuff doesn't need to
> +	// be delayed, doing it here is less headache.
>  	if (!bpf_inode_type(inode, &type))
>  		bpf_any_put(inode->i_private, type);
> +}
> +
> +// ... and this is done with RCU delay; anything that might be accessed
> +// by RCU pathwalk (like, you know, inode and symlink contents) should b=
e
> +// dealt with here
> +static void bpf_free_inode(struct inode *inode)
> +{
> +	if (S_ISLNK(inode->i_mode))
> +		kfree(inode->i_link);
>  	free_inode_nonrcu(inode);
>  }
> =20
> @@ -778,6 +790,7 @@ const struct super_operations bpf_super_ops =3D {
>  	.drop_inode	=3D inode_just_drop,
>  	.show_options	=3D bpf_show_options,
>  	.destroy_inode	=3D bpf_destroy_inode,
> +	.free_inode	=3D bpf_free_inode,
>  };

Thanks for the fix.
Feel free to take it into your tree directly.
