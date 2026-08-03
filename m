Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2C2C0268
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727095; cv=none; b=f90Qip4AwLxus3uIFafNGCjyF1T03K5to3FHk+nkaDHCE9/FDySlPzsgow0rdbKtKEqGJ+tBRC1WnUpluKBsSqP7gY1DpcmaqcFQrhMZjA3hg+ucC/g1KlDy2IrZyBt4Eh3t5hP6q3+rrJ6An2DePt/gYH6d4J/+vpeNhS87QhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727095; c=relaxed/simple;
	bh=sMhPLBQjQwFrx9E5ZP1pZsBvXOJ7N3bEMXQ2V0UFAVM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=d7i+oGN7WGDlcL/AIQ4lJS3m+nJOMvvrW4OKEti8TDY3Vmy9+f42RjIntU8KdblFYCPHJnZiVr448UUbK1Lj+ynatiaKZFJBxPvtzeXD4WBs+ms+vXbNfSUeYCvkThh39ei10omlxtkVaxTiajlGGdyC6aMuZMRGsdwA4VzAPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KceJK05U; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KceJK05U"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473913157edso1007094f8f.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 20:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785727092; x=1786331892; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3BqM8uQrkffP4F3yMoGM9dimkNHWWLzN/39TOu2OK/E=;
        b=KceJK05UvA8RbjtDrXck+11kfoqMpxGQnsYYy9c1LAxwmkGLZiIRtCGhVH38Fnh6MW
         gXdw5jCWVUT8XqRYoQH/inDovRqhiXX3uTye1bWKBeM5ETkOkC5yvPL3NHKuOd5AZ1qC
         xXchFLXYNmwKst+cxhwfPO9JWe35lwdpjOtlDaX/hwk9If5d4Utg1exM0ASQSuH6LEob
         nARCB0hr3/pgLmmagto1lfgX5aOdGeV6bmykH8Yvu2uBf2Bw/2a/hM9Odq14OP8tlNs3
         cfkiP6VwJbsvsjfemQf3yAAgBpx2ZCV0BeI0bMY6nC3J4Gll0QfCQazQApXieaAWsH8k
         LvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785727092; x=1786331892;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BqM8uQrkffP4F3yMoGM9dimkNHWWLzN/39TOu2OK/E=;
        b=JMS55u3zQf7i/WagyBrYsUiCnnRi/DveclrtZKYq+C7/dWjGDu/uXgakrzGlcM5lwg
         L4zBpSggTBKd5iYH93/7bmeniXPJ1wp0DBIePUNsX339Nar/z6rbbeSYFbY5p6oyqfoZ
         kATPy06KaOcJXKc1swQd72AunODZH35JdhViNZC5O8qZaeDFOGoXnrNj0iWbUmeN7CFF
         +kkMAmjNgaEjmWclMAO8RSkvCQV3+tBCQCStHocvMVrw/+D9FRpg3QkfMZ9/GqB8Iryo
         fjC38+i4QoxfGC6cK7MW1D2Zvdj6or1Q3Tw1KtaFxjhetNIDLmjpJWsTsxF0YKy5KSWR
         M7fg==
X-Forwarded-Encrypted: i=1; AHgh+RrMG+n44Trm8IslLMvVj92bc+Sp+cmX0bp2YzQoU8QOylpxcjzuzxrt1fa0PAgtREn5Ac0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDx0Dvg80hdf7MGFhqRaNIdFesAW8aGBl/zUKcDwfSfolFcRg
	FznUep8XaJ7js7XnJmtqH/Xl37nvSFYvzqRKLb0N/YYPvSwwqAfBysW+
X-Gm-Gg: AR+sD104B4oT6BDL/9OVemAYt5nHiE97KDYPleg6qB1PFPUli/WwdPNr2EXeySnjGdV
	WxOMNhS11sZM2D0aQ5Kz4vEUR/XEiSVYs3AxA80KtLuVbAIhTKpQZIErEU1CqPlwat4iH+0YRxQ
	i+fJ4P1E3eA4lJkakPGWX5/iFa8Ay3f7qYvH0GSvzPJCMgthUkzqau9teUOIr8lQ6Bx3oqPN79z
	pxgjq4cQrSRV2e57d+uklfckIV6dlffjxSERQHli97ETjNJbr1ecchn5bHtAZ7HNJAVQhUAFGJS
	BPrGs80yJynPEn6DjF0y7GqK6VJeJF7n/XXqJzZoe37u1fln6pgXig8e5PHYL94F29VxTrfDDO2
	CxrzCVNyqhjs0G3ESoxVZ8/LthvanE1RNepmm1plglOH3yvfJOP+l6PJU2e//CS1PewS+5vpuOC
	+jqawTMZTWothlDE/hl42MPPLXcvgBQoksU6Lh092A4PL0sb6YDU6/PVIABGHuXsuGdEfYFR32q
	JIheiyn60AEF4379BhS+dXfvzL27jGjdVHcWv8NxGtevMJhP6zWmzL99HZmdG3v8ZIkodRE0gPL
	XaOGQGQUKz5nKGfSHe498qJJdj0=
X-Received: by 2002:a05:600c:840f:b0:493:b6ee:fcb7 with SMTP id 5b1f17b1804b1-4980c6507e7mr162370475e9.14.1785727091761;
        Sun, 02 Aug 2026 20:18:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b916e1sm160614685e9.9.2026.08.02.20.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 05:18:11 +0200
Message-Id: <DKEZF8L6GNUP.3W0UE7JXQSKCK@gmail.com>
To: "David Windsor" <dwindsor@gmail.com>, <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: add BPF_F_SEALED flag to seal BPF links
 at creation
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260803021643.2189641-1-dwindsor@gmail.com>
In-Reply-To: <20260803021643.2189641-1-dwindsor@gmail.com>

+Cc Christian since he was involved in the discussion at LSF/MM/BPF.

On Mon Aug 3, 2026 at 4:16 AM CEST, David Windsor wrote:
> Introduce a new BPF_F_SEALED flag for BPF_LINK_CREATE that creates the
> link permanently sealed. A sealed link can never have its program
> replaced via BPF_LINK_UPDATE, can never be detached via BPF_LINK_DETACH,
> and holds an extra self-reference that is never released, so the link and
> its program attachment persist until the machine reboots, even after user
> space closes every fd referring to it. There is no way to unseal a link.
>
> The sealed state is tracked by a new bool field on struct bpf_link.
>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  include/linux/bpf.h            |  2 ++
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           | 41 +++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h |  1 +
>  4 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7bfc28673124..a9600a1483ec 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1934,6 +1934,8 @@ struct bpf_link {
>  	 * link's semantics is determined by target attach hook
>  	 */
>  	bool sleepable;
> +	/* set once by BPF_F_SEALED; blocks update/detach, pins link until rebo=
ot */
> +	bool sealed;
>  };
>
>  struct bpf_link_ops {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ffd96e8b920b..8cb30d18fec7 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1251,6 +1251,7 @@ enum bpf_perf_event_type {
>  #define BPF_F_AFTER		(1U << 4)
>  #define BPF_F_ID		(1U << 5)
>  #define BPF_F_PREORDER		(1U << 6)
> +#define BPF_F_SEALED		(1U << 7)
>  #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
>
>  /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 94091130bcc5..e8bd57d5c907 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3411,6 +3411,7 @@ static void bpf_link_show_fdinfo(struct seq_file *m=
, struct file *filp)
>  		seq_printf(m, "link_type:\t<%u>\n", type);
>  	}
>  	seq_printf(m, "link_id:\t%u\n", link->id);
> +	seq_printf(m, "sealed:\t%d\n", READ_ONCE(link->sealed) ? 1 : 0);
>
>  	rcu_read_lock();
>  	prog =3D READ_ONCE(link->prog);
> @@ -5776,17 +5777,41 @@ static int bpf_map_do_batch(const union bpf_attr =
*attr,
>  	return err;
>  }
>
> +/* Seal the just-created link: take a self-reference that is never relea=
sed. */
> +static void link_seal_fd(int fd)
> +{
> +	struct bpf_link *link;
> +
> +	link =3D bpf_link_get_from_fd(fd);
> +	if (IS_ERR(link))
> +		return;
> +
> +	if (!READ_ONCE(link->sealed)) {
> +		bpf_link_inc(link);
> +		WRITE_ONCE(link->sealed, true);
> +	}
> +
> +	bpf_link_put_direct(link);
> +}
> +
>  #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.path_fd
>  static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>  {
>  	struct bpf_prog *prog;
> +	bool seal;
>  	int ret;
>
>  	if (CHECK_ATTR(BPF_LINK_CREATE))
>  		return -EINVAL;
>
> -	if (attr->link_create.attach_type =3D=3D BPF_STRUCT_OPS)
> -		return bpf_struct_ops_link_create(attr);
> +	/* Strip BPF_F_SEALED before per-type flag validation. */
> +	seal =3D attr->link_create.flags & BPF_F_SEALED;
> +	attr->link_create.flags &=3D ~BPF_F_SEALED;
> +
> +	if (attr->link_create.attach_type =3D=3D BPF_STRUCT_OPS) {
> +		ret =3D bpf_struct_ops_link_create(attr);
> +		goto out_seal;
> +	}
>
>  	prog =3D bpf_prog_get(attr->link_create.prog_fd);
>  	if (IS_ERR(prog))
> @@ -5880,6 +5905,9 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>  out:
>  	if (ret < 0)
>  		bpf_prog_put(prog);
> +out_seal:
> +	if (ret >=3D 0 && seal)
> +		link_seal_fd(ret);
>  	return ret;
>  }
>
> @@ -5932,6 +5960,11 @@ static int link_update(union bpf_attr *attr)
>  	if (IS_ERR(link))
>  		return PTR_ERR(link);
>
> +	if (READ_ONCE(link->sealed)) {
> +		ret =3D -EPERM;
> +		goto out_put_link;
> +	}
> +
>  	if (link->ops->update_map) {
>  		ret =3D link_update_map(link, attr);
>  		goto out_put_link;
> @@ -5984,7 +6017,9 @@ static int link_detach(union bpf_attr *attr)
>  	if (IS_ERR(link))
>  		return PTR_ERR(link);
>
> -	if (link->ops->detach)
> +	if (READ_ONCE(link->sealed))
> +		ret =3D -EPERM;
> +	else if (link->ops->detach)
>  		ret =3D link->ops->detach(link);
>  	else
>  		ret =3D -EOPNOTSUPP;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index ffd96e8b920b..8cb30d18fec7 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1251,6 +1251,7 @@ enum bpf_perf_event_type {
>  #define BPF_F_AFTER		(1U << 4)
>  #define BPF_F_ID		(1U << 5)
>  #define BPF_F_PREORDER		(1U << 6)
> +#define BPF_F_SEALED		(1U << 7)
>  #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
>
>  /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
>
> base-commit: 28e911d61d66b92a3bded8b54622ed3cd2795bf6

