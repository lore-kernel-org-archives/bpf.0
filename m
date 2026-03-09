Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53030101F
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091514; cv=none; b=ZdH+qAPIyjx0LyogHI0gk9jsojLZJer+d8qA9NijxNagmcChd6YG1K48vGOBRExvWWDlzsqepIuCxCKItu8EraDrS1VotYoxBB8ufDJKBnhqJ4HEvxVDZH09kF4bznoQ58ATTnoQJB2kQaUUfoOxvZ+7KcgMYZ8CCMpLloT4m4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091514; c=relaxed/simple;
	bh=7ZX6FNqeVcm8OfkTYxBGEd3xk8t8pcMQCgcQXoRql6s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXDO0dkEUTHGSOIGwIfY9CrMqGxl6J52cHgcTfkY1gFywgE7+G/VCsVzuwsCuuyUyBZBFsb/4BHUddhI6JJto8RBbZAeLOWcF3wq29HllFy8zkv1SZhtSfOuC4SmgwVR8qCXrFlWjhCKcY+8OPAMBcJ9fFIzo5P3iQrYEHlppDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCqRnivk; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCqRnivk"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12732e6a123so3757302c88.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773091512; x=1773696312; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FAHsQdzzN+FG3XbYUMM1my4gp2tn4lNHzdIDSZZfH4o=;
        b=HCqRnivkfexdBtqWT7LyDLXXENqEHJQGKFZNt6iTSkGbFdCgJeSN5DCYJ+dAlNo6v1
         SrOBtE0PlWYbiV0Zg9XEF2mmJLNCY/hz+2HuMcwUjo88qGmHWgsdK1OufautM5xODsA5
         sp2Wv1u/K3ARamEGbJZWwo89SJqd9DLGxpsUc4Liik8aBYUJ3D5KYnPdfXtq6FZKJB1Z
         /6BCfkWzF69uRKuSDVQfaXkNUv7l/DMb3wQFWOUOe+YYvj6DR7Yu7/t3+Gn5L5T+CEq9
         9ieoXUaAjsBlzQpVbjSUtRuu1VGNw1kaHQPAia7n6c3ZoXrIHffOQ7j8YTWIVL/QicyL
         BaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091512; x=1773696312;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAHsQdzzN+FG3XbYUMM1my4gp2tn4lNHzdIDSZZfH4o=;
        b=vFwhPnk+ZwT+8JCCeddPWiMj1Nb6PIBsI69047huVHOigudk5cqzxna1LJSvpPCX3w
         dJMyrjq+o3AhCom7PsrUdbxKFc6V2rlcT3opgDls1ocyDn1xrUp958JLRDgbK4gQGQIg
         RMJEjuOl5qpTPRbJ7rnYCtQbqJZaNe0v3ULhrGhwUyxVlQuNdpxE80eDLTI4dnxbBRFs
         npLixicPBi2LW/e3Qwo1lhHFz8iSzLw200RfFdWr0H4M5Q47vrpM0N8ZngsyadEAUpw7
         AeY/HqXIa1TbxFmoSFJY/hK0Ir7hjwuY2qMxjNQKv+0WsRqBosH9raeX4nFlV8d28g6Z
         h/tg==
X-Forwarded-Encrypted: i=1; AJvYcCVYNF/BxTgFZkX+crTHqaKWr/dhVvFrBSfvfBq5risePB80OAnPW59BiTOH5lMjcHFbdDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPy24cwN50MjcgBDAnItp4h4H5gLAtD9gi5nnVyBJS4gZVPS61
	7PQKagRngf7p+cyl2MDcaNXSRuOuKAT5uCZ7+7B8zgJfA1o2t1iR/k+y
X-Gm-Gg: ATEYQzxwoSzfB/fDi8cy8NB/4ikCsjIWaHfwUc4ZwpoHPqxR5JhX1E/e+KfQ5YWAleT
	ZznDWYqIpHhU0o8Dp8rdRcFS/R/01Cntlbrs9JK4aJlNV/eqv9s7/tE6aMlUarKSzbK6vSPLrC5
	hW8KNdNl5mS6SsJvcquoXCz0E5kuXK1ct1xG4W16k3rXK5aARsAA6RB9w198h2eocxMW3Q1zDwD
	lc/DaxraYQn5zfiTvtbQ3xWpXyFtLKSK9qj0w0s29MrYI9LoYi32Y+7V0L6A2VX4HsgZAIcmOcA
	zOiVztEEprC1z2Z9gLxZ/kCs9pnHAlCiYSYbPNz/nN8QAiPu1vGUIum6SaIhCTNCgKGSAfIxQeD
	CEnP4e/x4AKSPTR/r4jad+Xk9VQuVoXFS0lT+F7WnUzb5rqB8w5TEPHW5XeVLeGSQRN1bfd1dIE
	3ZPSJmZf2ZMsknS/y6DKjm3dexW24drfZ2gtCDt2UvoiHhplLuj0m5wT+yWhZtiz8qHrPREc3Pu
	SeoYcg=
X-Received: by 2002:a05:7022:6620:b0:127:345c:439c with SMTP id a92af1059eb24-128c2eeaf9fmr5484444c88.45.1773091511897;
        Mon, 09 Mar 2026 14:25:11 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9362:b19:e25f:7640? ([2620:10d:c090:500::2:405f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be7cdfc6c9sm349706eec.23.2026.03.09.14.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:25:11 -0700 (PDT)
Message-ID: <7905ed2d99a46a2f7a4eb41d4cb9f1dec108ecd3.camel@gmail.com>
Subject: Re: [bpf-next v8 1/5] bpf: Move constants blinding from JIT to
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song	 <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov
 <a.s.protopopov@gmail.com>, Shahab Vahedi <list+bpf@vahedi.org>, Russell
 King	 <linux@armlinux.org.uk>, Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi
 Chen	 <hengqi.chen@gmail.com>, Johan Almbladh
 <johan.almbladh@anyfinetworks.com>,  Paul Burton <paulburton@kernel.org>,
 Hari Bathini <hbathini@linux.ibm.com>, Christophe Leroy	
 <chleroy@kernel.org>, Naveen N Rao <naveen@kernel.org>, Luke Nelson	
 <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=	 <bjorn@kernel.org>, Pu Lehui
 <pulehui@huawei.com>, Ilya Leoshkevich	 <iii@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik	 <gor@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Wang YanQing	 <udknight@gmail.com>
Date: Mon, 09 Mar 2026 14:25:07 -0700
In-Reply-To: <20260309140044.2652538-2-xukuohai@huaweicloud.com>
References: <20260309140044.2652538-1-xukuohai@huaweicloud.com>
	 <20260309140044.2652538-2-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-09 at 22:00 +0800, Xu Kuohai wrote:

This was discussed some time ago in [1]. In that message Daniel notes
the following:

  > constant blinding needs to work from native bpf(2) as well as from
  > cbpf->ebpf (seccomp-bpf, filters, etc)

It appears this patch does not address the cbpf->ebpf part, or did I
miss something?

[1] https://lore.kernel.org/bpf/284404c7-c6e0-4cf9-8ada-71ebfc681541@iogear=
box.net/

[...]

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 52162e4a7f84..7a7c49640a2f 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[...]

> @@ -272,7 +250,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog =
*fp)
>  				       extra_pass)) {
>  			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
>  			bpf_jit_binary_pack_free(fhdr, hdr);
> -			fp =3D org_fp;

Is it necessary to set `...; fp->jited =3D 0; ...` here?
It seems it does if extra_pass is set.

>  			goto out_addrs;
>  		}
>  		bpf_jit_build_epilogue(code_base, &cgctx);
> @@ -301,7 +278,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog =
*fp)
> =20
>  	if (!fp->is_func || extra_pass) {
>  		if (bpf_jit_binary_pack_finalize(fhdr, hdr)) {
> -			fp =3D org_fp;
> +			fp->bpf_func =3D NULL;
> +			fp->jited =3D 0;
> +			fp->jited_len =3D 0;
>  			goto out_addrs;
>  		}
>  		bpf_prog_fill_jited_linfo(fp, addrs);

[...]

> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 1f9a6b728beb..d6de2abfe4a7 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c

[...]

> @@ -2383,7 +2360,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *fp)
>  	if (!fp->is_func || extra_pass) {
>  		if (bpf_jit_binary_lock_ro(header)) {
>  			bpf_jit_binary_free(header);
> -			fp =3D orig_fp;

In the similar condition for powerpc you reset `...; prog->jited =3D 0; ...=
`,
is this case different?

>  			goto free_addrs;
>  		}
>  	} else {

[...]
