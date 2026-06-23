Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F20330315
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251116; cv=none; b=XszpFjJRIKfkNR5doO5g4tLRyB/SomGQbyxBUf2du4+1bk4EF5MIl0MesLDH/tqP4je/cf85Tb9jptwFZ4s0jB4lWsDrTQ9L7bk6rbGePW+eVsJuZS8OY2b8brgJ9uxXEs3hhXzEj90vNswfu/Offd51eW73cRnzge7x8Fl8RUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251116; c=relaxed/simple;
	bh=KVXTpBigc4LOIOv9wF0VWg5u69S8Jzw23jcmP1kPT64=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JhGDezbYNg9L1yYvbnNj0sdngwnnYx5r1ekZXgXfMa2GHSRGQrpGg9GBLhYT4xQAT5rkBQjEw35+2X/PmgLo/1cALBXWffdCLPoFmL+da1Ix/E1P4DTQPY9eimWywxSbpDQ3q6cbf0TJam9spTJKz4BPJX6Kk9g4RKJTKO6j0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=uy3QDpjC; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="uy3QDpjC"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30c591fb1cbso478009eec.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782251114; x=1782855914; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHXAd/f5rDSr7v51TVuMcnH6ZaDV9eNTIeTTyhu5DWE=;
        b=uy3QDpjCbzEU4jRqfn5skKhOOckPuuOgW55+El+SaOXhB/amgzs4JN7fp6zwZeX1mS
         VxnR/Gep5e6NSOh9xwuR8Rk/V9RnkUiOZaT/JxSdvP2cHU3vGDkJDxx65BYH90rXc2Sl
         pI5DfnmJW/iY9SqHojDxj0iZlQC6+xzjA7vD3ikaB9JqsK0R9vEB131WRJ0Y2K+TTI6P
         gK4j8cfPAAWj/Y6pHs98IBNxMvKrewKBy3pjpz27WhjcG4CBNuc/5BovQX2l4dmrfmrw
         NYUL+///wSFMQrVJLlMH5q7bdIEeCB7Y3KSvvdfwxKI+qC/QdP2gmqfiN0Ma++IlMqlO
         Fc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782251114; x=1782855914;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHXAd/f5rDSr7v51TVuMcnH6ZaDV9eNTIeTTyhu5DWE=;
        b=MM2qtHS0OBZqGBjRZYdPKgfSNMCOCu0xp4av9dH7bmklsq8dXZ1MVhR5MgXXvPbYIW
         UW2DyG/PXb6urieZrSwxKWou3KWsaMw/Gsm5jozUaYarCTIcXLKduIee8mZdm5TmX/lT
         5rXdR63jGA7kZv931GUs/El4k0rgXPHXpj0sAIzN9eN5oHYqK7VO8FaAgz51JQHxqZ3y
         A/tMQr0rtp6mq1b+assz3F4epw1xQ73hLRVWaWyTVUmItJoDfp+if3766f4LX6iU8+SJ
         GZZaNsgaSAGfq+a5LXJWvMj9OhJX5EC/ArjV9MzOqMB40QQ63qRHN1aZptdiAqn+lOVc
         IFOg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1vazg+c5pQ33ZZwK8MAtR9r5SPTKCWxcTE4Q5HIt12XySbexa134g8tGYhyslmjRoqIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5S9q7B2VIr+YYgszft6Mh7sLkPjP0g1710L11gIzvL6ASYOOX
	kPyMkXCVYSWldcrjqIHqyAVDiH9JWXiJSYNOqI+k75kDfdll1rsSEtKrigiE974Tv5M=
X-Gm-Gg: AfdE7cnqKYm73IHUx58MKXIvcRvfBPPaZn87HcEFVmV85Gf4RB7/P/EIPo/tn+eBD4z
	s4mQ/wPYywtxcaCigrReWkeGbVag3aOwIxBK1zbruQraNK08ssejQnMmEnU9gj+vi5T5o+iLjiR
	/cmsVnxta1KpIO7U6EgSzjKGQge8gS6Mftkx9eu4/s0OUyYWIGdQfMjSflXJbkYnvxNdhj0Czlh
	DwwrTi5nkMFT4SaE4GNaUHJUekkZfv92XbVMvb6sD8zITlarjirIBqZoWAeHZfRUkbxabYU9jK4
	SV8d/wNgBNG3TvbQqGsrakL7NulL7mHB5LpqKWseICV5GCBnBAnzVvR0qyQVq1x9fRUYvWQ9TVE
	gjDJT5qm+XLIV4tOT2ypJTmzHQ12pOtglTN62nTNP6ohLsrAnqpsKGxuf5hU/zHOcl2cWdFfe1o
	59k/FG
X-Received: by 2002:a05:7300:80cf:b0:2f2:6dde:df54 with SMTP id 5a478bee46e88-30c68e904d5mr1013855eec.33.1782251114258;
        Tue, 23 Jun 2026 14:45:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2526])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be45a00sm18657595eec.25.2026.06.23.14.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 14:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 17:45:11 -0400
Message-Id: <DJGRAHJ8EXY8.2EFSVWYZJZ1KU@etsalapatis.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] tools/bpf/bpftool: Reset vmlinux BTF after
 struct_ops commands
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Yichong Chen" <chenyichong@uniontech.com>, <qmo@kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260623072220.1421837-1-chenyichong@uniontech.com>
 <871EC84E76334A24+20260623072220.1421837-3-chenyichong@uniontech.com>
In-Reply-To: <871EC84E76334A24+20260623072220.1421837-3-chenyichong@uniontech.com>

On Tue Jun 23, 2026 at 3:22 AM EDT, Yichong Chen wrote:
> struct_ops frees the global btf_vmlinux object.
>
> In batch mode, a later struct_ops command can reuse stale state.
>
> Reset the BTF pointer and cached map info state.
>
> Fixes: 65c93628599d ("bpftool: Add struct_ops support")
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
> ---
>  tools/bpf/bpftool/struct_ops.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_op=
s.c
> index aa43dead249c..4dba7c96e5f6 100644
> --- a/tools/bpf/bpftool/struct_ops.c
> +++ b/tools/bpf/bpftool/struct_ops.c
> @@ -21,6 +21,15 @@ static __u32 map_info_alloc_len;
>  static struct btf *btf_vmlinux;
>  static __s32 map_info_type_id;
> =20
> +static void free_btf_vmlinux(void)
> +{
> +	btf__free(btf_vmlinux);
> +	btf_vmlinux =3D NULL;
> +	map_info_type =3D NULL;
> +	map_info_alloc_len =3D 0;
> +	map_info_type_id =3D 0;
> +}

Nit but I don't think we need this to be a separate helper. We use it
once, and it has the exact same name and type as the one in the previous
patch.

pw-bot: cr

> +
>  struct res {
>  	unsigned int nr_maps;
>  	unsigned int nr_errs;
> @@ -642,7 +651,7 @@ int do_struct_ops(int argc, char **argv)
> =20
>  	err =3D cmd_select(cmds, argc, argv, do_help);
> =20
> -	btf__free(btf_vmlinux);
> +	free_btf_vmlinux();
> =20
>  	return err;
>  }

