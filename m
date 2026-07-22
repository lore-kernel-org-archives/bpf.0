Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CDE439F74
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737549; cv=none; b=aWhxoB/yGxnC5Fftg/mBZBk0blWjqKjEdpFgTsxzEZ7lr0SX8J8vmDkjheC0CrIFeQnfE6UJPxkwFKDdgG9aU56hJq4c7cL+XMh3HVDevzhCHPSz25VyZjFFQzmxPKaGaaxbGUdJfblgSR/LQDslCv6pPuF3apXOr3KtdqmXWmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737549; c=relaxed/simple;
	bh=LGFj0f5U5Rg6b5unu6LCSaSHumocHaERBEdfox9875M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aXBzTrlIo0P3OtDByaK+GC2qEaif0rQT9jwqhSn58uSBS6W6PPpQ450su1U8TNBR/xE1/lyDSEh8CAL+5vU7KZgpLuHFKcFUdw58gk6ndhnO9XFVhBJQzU8kBp6MjAYaTawURF6ZrjlYrfKN+Hjht70X1+rbqqOpJXuW2UCzY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=K7n4tdvj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="K7n4tdvj"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8487088510aso12842475b3a.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784737546; x=1785342346; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IZkomDUrGkXkXZb8BhxXqnqY3bkstvsHnN4dmShpkRM=;
        b=K7n4tdvjQ3AMaeNHQyIIOXB0GdIm5YLSgwT6QUuTKVUkgwoqt22rhUPhs2SVFFxvCU
         1Baj+/W3vuTwrkrY8O2SYbFfInux/2oZTObxEvCWRcKRacwCR7+CThH9RdOm3xEqDqCb
         eyGhymQYSDJYLAsPxQixMoqcjO3ZOkLAlhdHU9IpXBfo5R9ZF1QOWUSrtzqTVWPg0HnJ
         lUQ99a6ZaMw3u42zPOAhdEuV8Ij36NXIN4NwtwyJ9sTHVH4xx0EAvcLFaBDAQLIKUEdr
         j7dQDYcsZTAloQfIp89e6mzLkhdZEJEsI0s2cSIWetLHmcFKH6b+G67lX6SjAQwKWL4J
         mffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737546; x=1785342346;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZkomDUrGkXkXZb8BhxXqnqY3bkstvsHnN4dmShpkRM=;
        b=LWyLhEvnXB66Cl6MrgzxjkZ+xiAPgNNmSG/behnPqsSvarXG4Wvmr78Jvy9WButFN9
         0smcMnQVD1ug1jRxLSylk/mmuz77H4ID7lHi11TRIIfqHZkHRGidGx2lzrNYTM1UrpqX
         3h09tt6WKtOOW1dftx4p85HDqfMntTzWVQzTMik+k2Ad1kUG4epOM86P01r92EUfO/fU
         0/OIkoNlu0m4WrCNTD6pzc8SYx42rkwaqQOw2yx0BgIKv4h4YaAFlFCGvbkdShDzaOcU
         3j5sQhs53oIfMDlby0lfNBDROdrweHwjzVHEeAZ/YH3EkKiTqDVkhDHWcu/RJyzwtMyy
         YmgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rra3PWkvKFhiflphUX6E0rH09evr6wWzYzqMnjNUbLyuGNoNBAl6uyXS8aN1omGFuW1NPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTApdhntepPIZAdfQXQ2vXW430Xb0vGGcEytMsw/c5fkBszJkU
	VmtMcho8nbsscjb1x5DZ6uqcZYakCt2eWz2AIGkTP4ZqTODUk+XTb8VReKv9sAsSm0E=
X-Gm-Gg: AR+sD12HtZJdUSIopEWnWLFJNOYzAZZ+0hsxjF6qE5jKELD1phdXCyYP0rsIEDRYtE0
	xSLMRtS2g88yZ85NUbc1mFIgdNlbT9E1rWlwzBDIYLXj3WSWiuEFDcv+ywQaOipImA5D15lA72+
	s7UzXK5aV4xKLApgrE/P0ZT6ZP3fAjnmwx97dSVsryhlOi1mBmcBXYgXAuk0wZRUC39auvkBGDv
	if+xfdn8BqacIJFrgjxl7+myFJ5hi1amjWgxmWYBhjwX4Y3iulC0y9NFN+3fUQ4VuPAWNdJyLew
	tfu6snaX21np3VVHNYDpLP5FRyPIcPmBEzcEML93syupyLYXnpgho/HNIASqhOWGZx1M7WQMIPU
	1rSwKpEmL3MSbq+g+RfE4AKK62a0aS1aDzQ5zNAzKabUVF34jmwaCkixWvOs183EOzv1DmfeYWt
	QuMD29/N8DLb4Ofl71RamrGavwkthRKuTWoiRRKIy7rA==
X-Received: by 2002:a05:6a00:cc7:b0:847:9565:7a58 with SMTP id d2e1a72fcca58-84c294d43f6mr23330487b3a.48.1784737546418;
        Wed, 22 Jul 2026 09:25:46 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17297f8asm1641552b3a.25.2026.07.22.09.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 09:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 12:25:44 -0400
Message-Id: <DK58NPCIRLIH.SMOILLVYTZ1Q@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Pu Lehui" <pulehui@huawei.com>
Subject: Re: [PATCH bpf v6 2/4] bpf: Fix UAF due to missing link type check
 in mprog
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Pu Lehui" <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Amery Hung" <ameryhung@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Mykyta Yatsenko"
 <mykyta.yatsenko5@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
 <20260722072326.1545677-3-pulehui@huaweicloud.com>
In-Reply-To: <20260722072326.1545677-3-pulehui@huaweicloud.com>

On Wed Jul 22, 2026 at 3:23 AM EDT, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> In bpf_mprog_link, the code does not check the link->type first before
> dereferencing link->prog->type. This missing validation allows a user to
> pass an abnormal non-netkit or non-tcx link via relative_fd. If doing
> BPF_LINK_UPDATE on the abnormal link, it can trigger a UAF issue.
>
> CPU0                                      CPU1
> netkit_link_prog_attach
> bpf_mprog_attach
> bpf_mprog_tuple_relative
> bpf_mprog_link
>   /* non-netkit or non-tcx link */
>   link =3D bpf_link_get_from_fd(id_or_fd);
>                                           BPF_LINK_UPDATE on relative lin=
k
>                                           ...
>                                           old_prog =3D xchg(&link->link.p=
rog, new_prog);
>                                           bpf_prog_put(old_prog);
>   if (type && link->prog->type !=3D type) <-- trigger UAF
>
> The reason for the UAF is that each subsystem provides its own
> protection for link->prog. Since there is no cross subsystem protection
> (if not considering the RCU of prog tear down), dereferencing the prog
> of an anchor link that does not belong to the current subsystem is not
> safe: it may have been freed. Therefore, we need to validate link->type
> to reject foreign anchors.
>
> Fix this by strictly validating link->type in bpf_mprog_link against the
> expected link type. mprog APIs is also adjusted to accept and pass down
> the expected link type. Meanwhile, add a comment explaining that when
> ptype =3D=3D UNSPEC in bpf_mprog_detach, it acts as a wildcard.
>
> Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for multi-=
progs")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Unless I'm missing something, at the very least there's no need for the
extra argument in detach() since we pass UNSPEC to bpf_mprog_link() and
never use it otherwise.

Even for the attach case, aren't we required to provide a new link
for attachment, and so already have the ltype available to test
against?

> ---
>  drivers/net/netkit.c      | 13 ++++++-------
>  include/linux/bpf_mprog.h |  6 ++++--
>  kernel/bpf/mprog.c        | 23 ++++++++++++++---------
>  kernel/bpf/tcx.c          | 13 ++++++-------
>  4 files changed, 30 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index a3931cd82132..99ddf2befb23 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -768,7 +768,7 @@ int netkit_prog_attach(const union bpf_attr *attr, st=
ruct bpf_prog *prog)
>  	}
>  	ret =3D bpf_mprog_attach(entry, &entry_new, prog, NULL, replace_prog,
>  			       attr->attach_flags, attr->relative_fd,
> -			       attr->expected_revision);
> +			       attr->expected_revision, BPF_LINK_TYPE_NETKIT);
>  	if (!ret) {
>  		if (entry !=3D entry_new) {
>  			netkit_entry_update(dev, entry_new);
> @@ -802,7 +802,7 @@ int netkit_prog_detach(const union bpf_attr *attr, st=
ruct bpf_prog *prog)
>  		goto out;
>  	}
>  	ret =3D bpf_mprog_detach(entry, &entry_new, prog, NULL, attr->attach_fl=
ags,
> -			       attr->relative_fd, attr->expected_revision);
> +			       attr->relative_fd, attr->expected_revision, BPF_LINK_TYPE_NETK=
IT);
>  	if (!ret) {
>  		if (!bpf_mprog_total(entry_new))
>  			entry_new =3D NULL;
> @@ -850,7 +850,7 @@ static int netkit_link_prog_attach(struct bpf_link *l=
ink, u32 flags,
>  	ASSERT_RTNL();
>  	entry =3D netkit_entry_fetch(dev, true);
>  	ret =3D bpf_mprog_attach(entry, &entry_new, link->prog, link, NULL, fla=
gs,
> -			       id_or_fd, revision);
> +			       id_or_fd, revision, BPF_LINK_TYPE_NETKIT);
>  	if (!ret) {
>  		if (entry !=3D entry_new) {
>  			netkit_entry_update(dev, entry_new);
> @@ -877,7 +877,7 @@ static void netkit_link_release(struct bpf_link *link=
)
>  		ret =3D -ENOENT;
>  		goto out;
>  	}
> -	ret =3D bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 0, 0);
> +	ret =3D bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 0, 0, =
BPF_LINK_TYPE_NETKIT);
>  	if (!ret) {
>  		if (!bpf_mprog_total(entry_new))
>  			entry_new =3D NULL;
> @@ -919,9 +919,8 @@ static int netkit_link_update(struct bpf_link *link, =
struct bpf_prog *nprog,
>  		ret =3D -ENOENT;
>  		goto out;
>  	}
> -	ret =3D bpf_mprog_attach(entry, &entry_new, nprog, link, oprog,
> -			       BPF_F_REPLACE | BPF_F_ID,
> -			       link->prog->aux->id, 0);
> +	ret =3D bpf_mprog_attach(entry, &entry_new, nprog, link, oprog, BPF_F_R=
EPLACE | BPF_F_ID,
> +			       link->prog->aux->id, 0, BPF_LINK_TYPE_NETKIT);
>  	if (!ret) {
>  		WARN_ON_ONCE(entry !=3D entry_new);
>  		oprog =3D xchg(&link->prog, nprog);
> diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
> index 0b9f4caeeb0a..1fbe1a923968 100644
> --- a/include/linux/bpf_mprog.h
> +++ b/include/linux/bpf_mprog.h
> @@ -321,12 +321,14 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
>  		     struct bpf_mprog_entry **entry_new,
>  		     struct bpf_prog *prog_new, struct bpf_link *link,
>  		     struct bpf_prog *prog_old,
> -		     u32 flags, u32 id_or_fd, u64 revision);
> +		     u32 flags, u32 id_or_fd, u64 revision,
> +		     enum bpf_link_type expected_link_type);
> =20
>  int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>  		     struct bpf_mprog_entry **entry_new,
>  		     struct bpf_prog *prog, struct bpf_link *link,
> -		     u32 flags, u32 id_or_fd, u64 revision);
> +		     u32 flags, u32 id_or_fd, u64 revision,
> +		     enum bpf_link_type expected_link_type);
> =20
>  int bpf_mprog_query(const union bpf_attr *attr, union bpf_attr __user *u=
attr,
>  		    struct bpf_mprog_entry *entry);
> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
> index 1394168062e8..b4a1b35ff569 100644
> --- a/kernel/bpf/mprog.c
> +++ b/kernel/bpf/mprog.c
> @@ -6,7 +6,7 @@
> =20
>  static int bpf_mprog_link(struct bpf_tuple *tuple,
>  			  u32 id_or_fd, u32 flags,
> -			  enum bpf_prog_type type)
> +			  enum bpf_link_type type)
>  {
>  	struct bpf_link *link =3D ERR_PTR(-EINVAL);
>  	bool id =3D flags & BPF_F_ID;
> @@ -17,7 +17,7 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>  		link =3D bpf_link_get_from_fd(id_or_fd);
>  	if (IS_ERR(link))
>  		return PTR_ERR(link);
> -	if (type && link->prog->type !=3D type) {
> +	if (type && link->type !=3D type) {
>  		bpf_link_put(link);
>  		return -EINVAL;
>  	}
> @@ -52,21 +52,22 @@ static int bpf_mprog_prog(struct bpf_tuple *tuple,
> =20
>  static int bpf_mprog_tuple_relative(struct bpf_tuple *tuple,
>  				    u32 id_or_fd, u32 flags,
> -				    enum bpf_prog_type type)
> +				    enum bpf_link_type ltype,
> +				    enum bpf_prog_type ptype)
>  {
>  	bool link =3D flags & BPF_F_LINK;
>  	bool id =3D flags & BPF_F_ID;
> =20
>  	memset(tuple, 0, sizeof(*tuple));
>  	if (link)
> -		return bpf_mprog_link(tuple, id_or_fd, flags, type);
> +		return bpf_mprog_link(tuple, id_or_fd, flags, ltype);
>  	/* If no relevant flag is set and no id_or_fd was passed, then
>  	 * tuple link/prog is just NULLed. This is the case when before/
>  	 * after selects first/last position without passing fd.
>  	 */
>  	if (!id && !id_or_fd)
>  		return 0;
> -	return bpf_mprog_prog(tuple, id_or_fd, flags, type);
> +	return bpf_mprog_prog(tuple, id_or_fd, flags, ptype);
>  }
> =20
>  static void bpf_mprog_tuple_put(struct bpf_tuple *tuple)
> @@ -226,7 +227,8 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
>  		     struct bpf_mprog_entry **entry_new,
>  		     struct bpf_prog *prog_new, struct bpf_link *link,
>  		     struct bpf_prog *prog_old,
> -		     u32 flags, u32 id_or_fd, u64 revision)
> +		     u32 flags, u32 id_or_fd, u64 revision,
> +		     enum bpf_link_type expected_link_type)
>  {
>  	struct bpf_tuple rtuple, ntuple =3D {
>  		.prog =3D prog_new,
> @@ -243,6 +245,7 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
>  		return -EEXIST;
>  	ret =3D bpf_mprog_tuple_relative(&rtuple, id_or_fd,
>  				       flags & ~BPF_F_REPLACE,
> +				       expected_link_type,
>  				       prog_new->type);
>  	if (ret)
>  		return ret;
> @@ -328,7 +331,8 @@ static int bpf_mprog_fetch(struct bpf_mprog_entry *en=
try,
>  int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>  		     struct bpf_mprog_entry **entry_new,
>  		     struct bpf_prog *prog, struct bpf_link *link,
> -		     u32 flags, u32 id_or_fd, u64 revision)
> +		     u32 flags, u32 id_or_fd, u64 revision,
> +		     enum bpf_link_type expected_link_type)
>  {
>  	struct bpf_tuple rtuple, dtuple =3D {
>  		.prog =3D prog,
> @@ -343,8 +347,9 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>  	if (!bpf_mprog_total(entry))
>  		return -ENOENT;
>  	ret =3D bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
> -				       prog ? prog->type :
> -				       BPF_PROG_TYPE_UNSPEC);
> +				       expected_link_type,
> +				       /* Use UNSPEC as wildcard when prog is NULL */
> +				       prog ? prog->type : BPF_PROG_TYPE_UNSPEC);
>  	if (ret)
>  		return ret;
>  	if (dtuple.prog) {
> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
> index 02db0113b8e7..f208cef13a98 100644
> --- a/kernel/bpf/tcx.c
> +++ b/kernel/bpf/tcx.c
> @@ -38,7 +38,7 @@ int tcx_prog_attach(const union bpf_attr *attr, struct =
bpf_prog *prog)
>  	}
>  	ret =3D bpf_mprog_attach(entry, &entry_new, prog, NULL, replace_prog,
>  			       attr->attach_flags, attr->relative_fd,
> -			       attr->expected_revision);
> +			       attr->expected_revision, BPF_LINK_TYPE_TCX);
>  	if (!ret) {
>  		if (entry !=3D entry_new) {
>  			tcx_entry_update(dev, entry_new, ingress);
> @@ -76,7 +76,7 @@ int tcx_prog_detach(const union bpf_attr *attr, struct =
bpf_prog *prog)
>  		goto out;
>  	}
>  	ret =3D bpf_mprog_detach(entry, &entry_new, prog, NULL, attr->attach_fl=
ags,
> -			       attr->relative_fd, attr->expected_revision);
> +			       attr->relative_fd, attr->expected_revision, BPF_LINK_TYPE_TCX)=
;
>  	if (!ret) {
>  		if (!tcx_entry_is_active(entry_new))
>  			entry_new =3D NULL;
> @@ -152,7 +152,7 @@ static int tcx_link_prog_attach(struct bpf_link *link=
, u32 flags, u32 id_or_fd,
>  	if (!entry)
>  		return -ENOMEM;
>  	ret =3D bpf_mprog_attach(entry, &entry_new, link->prog, link, NULL, fla=
gs,
> -			       id_or_fd, revision);
> +			       id_or_fd, revision, BPF_LINK_TYPE_TCX);
>  	if (!ret) {
>  		if (entry !=3D entry_new) {
>  			tcx_entry_update(dev, entry_new, ingress);
> @@ -183,7 +183,7 @@ static void tcx_link_release(struct bpf_link *link)
>  		ret =3D -ENOENT;
>  		goto out;
>  	}
> -	ret =3D bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 0, 0);
> +	ret =3D bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 0, 0, =
BPF_LINK_TYPE_TCX);
>  	if (!ret) {
>  		if (!tcx_entry_is_active(entry_new))
>  			entry_new =3D NULL;
> @@ -229,9 +229,8 @@ static int tcx_link_update(struct bpf_link *link, str=
uct bpf_prog *nprog,
>  		ret =3D -ENOENT;
>  		goto out;
>  	}
> -	ret =3D bpf_mprog_attach(entry, &entry_new, nprog, link, oprog,
> -			       BPF_F_REPLACE | BPF_F_ID,
> -			       link->prog->aux->id, 0);
> +	ret =3D bpf_mprog_attach(entry, &entry_new, nprog, link, oprog, BPF_F_R=
EPLACE | BPF_F_ID,
> +			       link->prog->aux->id, 0, BPF_LINK_TYPE_TCX);
>  	if (!ret) {
>  		WARN_ON_ONCE(entry !=3D entry_new);
>  		oprog =3D xchg(&link->prog, nprog);

