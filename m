Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93619440648
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787168664; cv=none; b=Wwovp/1ME1Rv7YG7B5w9hmbs7GnHcPvdN5LSB5RWRKhob9NCavL1vo5Mq7ddw1CbZBrmwKvnwxiyqPZWvh5KfZ8BJo0ZZGeOLX3PfDkI2wcTSF/0zBV2VdU/RxGvonJJm70GMI2LIQCuh7LyD7QN1AFxdPBvYbRA5lrjdwWF8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787168664; c=relaxed/simple;
	bh=Z+QxkOwZTebWGhdloR8z3hb4zcv63YIqdGCWwtqSb2U=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=r7NN0AZV8qrsKHEKTp95db2h4gySJxfVnNmbSBFpYhBi3IUuuXG3tTTwLkemMyagO0mdIWp4LaQc5+JeBwG0B2+3dpd14wQw2jK09VzXyxqdTLptsPP691GYMkJlGozwGamuhrTd/bOgRI9AekLdsAD+iImCWenPMA5eNKfjOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=badCG73v; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="badCG73v"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38deea72eebso1539303a91.1
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787168661; x=1787773461; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6dToT+SoDmLEhppV2wNvfcF6U10Bdergy/VLIZNHkt4=;
        b=badCG73vCRYVe1YP3HK9FiIn0uJs1oNxvR1OIM1CQjlX//4TvTt4THJ6ukicyoMsjf
         ih/cThNAj5x1oKK5JfWoZ+HJewOUWWWPoI5C+Of1S6DKyR4SsNg64x/KAyKyGlZXjhum
         HsUf9aWnLB3NXSS7odeXDtASpsyoKsfg1AeUi0+/oDYX9R81jhlNWy20yr9CpcHBNyOr
         XYE1h7azgJWjzDTrqmWBvTkS1Uc8RHh73922p1QfMrpKYkipwEL5abfNQ4BfcgCnkwA7
         RB8HXJ8fdqe+aBDg8jboZvLYENJYM+pRl1VpnQvGFxGbAFf7Woy29iys3O5dkU7g3+Hf
         XIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787168661; x=1787773461;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dToT+SoDmLEhppV2wNvfcF6U10Bdergy/VLIZNHkt4=;
        b=YwdK/m3zaSqx3ZwSU9mvAT2U/WyB0rDXChy/FI4VYDm8EViulVtZ9I1/gGshuQnWFc
         vHNb7woZzn8Tu7EALbvNa7nvGh4jGJO/QdrUPrShB5xF0HXKXq0dBfX2IZVwxTALhbyf
         TXc9KJDbg1r/Jg8J+wqDL7m5JdQ80fy4MveMxFXDunxgT+epupkJJCh/VCOitYqIB6EP
         mJ+N177TRxMrQ/166w2icsr9aVrVr3In4CjMskWYx3neRPcGrBE037Tx7340Xa9qsrLe
         kSSSXs78rdT9K4TzV56SNH1qE1ZfhqdDNQqGyN3MGc1nDS60y6WzMoTkusMefmZjwN88
         JZaA==
X-Forwarded-Encrypted: i=1; AHgh+Rq29teC4LswvXTKcLHnlMB1LDSdDetxLUwL3mGp3J7Xll51CfMDs0hb/s9O7VwMYk7Ls4Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kYI3vOOKiZ1+rxQnFTCJp84Vh7CGZrgSts28YSzFdVBx3NidWB
	l9pTDtXkF80qlNhhyFVeSSdF8bZ/rbZGLp0Xtm+uKj7rnxL8UvNIDe5gaQXYK847GuA=
X-Gm-Gg: AR+sD10OjUpEjfWGP3uh4Ln4/bZxp6Wc+NPSDZvhfFb705gw1jQaW4i6wlk97b6/IRV
	h8e6IPyeK+4PXXKHdPOC5pkd51oa4XqigJtUYqKa6Ha+o/zFS7ri1aSgSb0nTNniOnQwHJHhkis
	iH7FFstq3NC3znsZf6NqCGJD7eDZKJOe3xRvQ8IAr2q+jQgAZLsH83GmWS/4JWmNO34jW0Mom6n
	ASufG0pZ/9shmiMVzTvqX1k0BA6M6Hqi7ZfpExHVsRsXbKIXWciI5Jb0SF9xjBZu80Hd8CXPWzd
	TywZHh9TThckastIYVTSIGbSALvDuGUqmEfRq38PjZV+cBZholcQncnNfNZkMQVNpiu1GqJGstD
	S/IMPB4Jdgr4Ac5TB/WsG2Ns2cDW6fXce7YJih01lE8vbOodSb/FZqGkcXcRone+HeRra1HosEO
	Rul79p1KnbJh42fn2oD5xmPP644ACpSNbN6oeJlgkA2f4Ss71ttbBsTLcq6E1uHkqpG4VhV/oeO
	aK5hg/f4G3nyxtj0w==
X-Received: by 2002:a17:90b:4a05:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-39580a80a65mr13110595a91.4.1787168660704;
        Wed, 19 Aug 2026 12:44:20 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f82097esm1646692a91.2.2026.08.19.12.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 12:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 15:44:19 -0400
Message-Id: <DKT6EZTQI7LB.3ENA5VQ5OVMNQ@etsalapatis.com>
To: "MahnurA" <s.mahnur.a@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>
Cc: <netdev@vger.kernel.org>, <andrii@kernel.org>
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in
 bpf_sock_from_file
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260818174253.492196-1-s.mahnur.a@gmail.com>
In-Reply-To: <20260818174253.492196-1-s.mahnur.a@gmail.com>

On Tue Aug 18, 2026 at 1:42 PM EDT, MahnurA wrote:
> bpf_sock_from_file should not dereference a NULL file pointer.
> KASAN detects a null-ptr-deref when eBPF tracing
> fentry/fexit programs are attached to points such as
> __mmap_region and file_map_prot_check kernel functions. This can
> result in a NULL file pointer flowing from context to the helper.
>
> A minimal check before dereferencing can fix this.
>
> Fixes: b60da4955f53 ("bpf: Only provide bpf_sock_from_file with CONFIG_NE=
T")
> Signed-off-by: MahnurA <s.mahnur.a@gmail.com>

Patch looks fine and the crash replicates. Please resend with a full
name since we don't take pseudonymous contributions. Once you do,
please feel free to add my reviewed-by tag.

pw-bot: cr

> ---
>  net/core/filter.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 16845987b244..7c3caae4bafc 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12182,7 +12182,10 @@ const struct bpf_func_proto bpf_skc_to_mptcp_soc=
k_proto =3D {
> =20
>  BPF_CALL_1(bpf_sock_from_file, struct file *, file)
>  {
> -	return (unsigned long)sock_from_file(file);
> +	if (file)
> +		return (unsigned long)sock_from_file(file);
> +
> +	return (unsigned long)NULL;
>  }
> =20
>  BTF_ID_LIST(bpf_sock_from_file_btf_ids)

