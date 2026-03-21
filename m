Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ED02571DA
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774057478; cv=none; b=mHQXZ83oB/EE1/rbCulfE4vW/Cztlz9TdBKfYTznb/Lvomjs6JQ0UdKCtEdCZu0Jw4rH+Ys0tWqaNeu6mfgEH7qL+YnJhE34pRIRXo8teP7HfBK9o3KpsQiKvwsnXmvqjR1+c+YXYg6EmOFqJj9X2GF6GiHP+bMGzxp1IX/FW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774057478; c=relaxed/simple;
	bh=MNCOi5/h443DIwoG6VbqkWNCnAEU+MPikOWLWIHFstU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HWIe7t64+UmOTx25iamp8RPHEq6X94Jxru/iyTKe0a1ghhc03R+978K7TNL/CT5KTGGmTZSkIEd/TOZf9BGLXE+7mnlGi8WQO3X1kKHHHr5FOWV1CtAp7UAWshd2/+4HR/vls/e5bwgAN7dXcT8Db3IbXdlSflhNcAVmHq066H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=S7JVVOvo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="S7JVVOvo"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cd71fb9f06so168443485a.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 18:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1774057475; x=1774662275; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3hhbjOHvnbqGz2vwBIyGKF5DZ1+kS7uyDwWIovuGd8=;
        b=S7JVVOvolMPpJV8/J37oZcH70VId2TpkAzKTTE8bGDXR8ls6/ZLh3YzQNSFmV+CiiP
         Tpn4grhmegKJlrKEuEMrsjVFHdtxRYr7Lpik36NAHTvd8pnt+iJ4HL6Jy/xuGf/K1Vr9
         GXRazMcn2ByCKQkc1HAoZ66Yv6fWN+mhzj8eOkaJlkIUvYxABMzv42qbyUEAr430Bn/b
         T9vQ34gtXrAw2NCFrP8mc6+BhDM9yPmKF8MVYoEWCbkKFdYOo0N92NlyC16ntVEWHP+v
         /0HFqLU1YimVST67AXdcG6Vb0DPcsoJAKpn/IgeCfp3pB6H7KW+c16ZyeF9nBCuK36FT
         mTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774057475; x=1774662275;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3hhbjOHvnbqGz2vwBIyGKF5DZ1+kS7uyDwWIovuGd8=;
        b=CkTO9mGrD+7XvKBHjbQ6IMn5Ih15gYgBUQx5g80FhRRtMaG5lWAlZ/pdetbegaSS/F
         YkbzqSFBPZpu30IySMvsIinXwTUPxzAFhAMBKKUfl7F/jKBReBWKK/7/9DCfnDEuFm8/
         Hsb4SX79woDIHyTATKEu6gi4LtQQ7XNx/6vgOLm0jmKM+Bto/1xE/4gMZajoPYnVUPc9
         E4wIqco3ezYxqEIx4IKMcZQf6p4P60IzdhnEEzZvYSNHM4nfhxDIO8UJvZx/ZpO5jgdI
         0SseVBx7bpygoBvts6OWkxpw8FP24J4nyP7NRz1RVVx/qLYuMso+ai3E3mUAN84EhXYQ
         c4uw==
X-Gm-Message-State: AOJu0YxBS4vze6mDdmPWk8pQ0ksIxcytDzLvAjXIB/7zC0ZP877pf4nx
	nRGcImV9JCQGRFc/pyXwrA0DmGCspPr+qcLdaUZBmMj98sp3TI1P7Qq5PQRVWjm8ElQ=
X-Gm-Gg: ATEYQzxh0S0jdWPdFRZOlgSj03ylfK/hqsuPrK++RSsdKA5uH6+jLYY+y768kjrxCVe
	LeDfDXqjxW6iPZZ+gu2n4LEtKv1JbnKuZyYE3T+S1IrehsNlkytMGPULbH+qKywDNptE1FIBJ8D
	sGa3ek3TyLA+dE4/fEgt2apuwXEe62cpT7nYF+mZAEhWzGgWvtkOOwl7KUQm/Qlf8QYFeZ33t7D
	TPzVHEdpgJMhZLy8JTQZYmp0fk/LfoH1AADTYv/0U+0mRtGyYnMI23HBrvtkunZDVAnYFz9+sTt
	q1yCtu9nOGuf7F32xVfNYwRf69plV8IuzSqHY+2K64m2w/RUtC1Yz3z0+8kIbQtMaBhpDNNI4b0
	zd4UYIOk2/TcvNy5w1127t0GRSKwMojeEFajW6GoF1qb9j5+w+zJf8qNL/waRnS8HRTW0VWIyJp
	/sxhTs/4HFvXGhENT2jMt63Ks=
X-Received: by 2002:a05:620a:708e:b0:8cd:8f18:d1c4 with SMTP id af79cd13be357-8cfc7f7fed3mr716959885a.56.1774057475400;
        Fri, 20 Mar 2026 18:44:35 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8f5cd32sm294791185a.7.2026.03.20.18.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 18:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 21:44:33 -0400
Message-Id: <DH82W06EW1BO.3SO7ZOCFR1DSM@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: Fix refcount check in check_struct_ops_btf_id()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Keisuke Nishimura" <keisuke.nishimura@inria.fr>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Amery Hung" <ameryhung@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260320130219.63711-1-keisuke.nishimura@inria.fr>
In-Reply-To: <20260320130219.63711-1-keisuke.nishimura@inria.fr>

On Fri Mar 20, 2026 at 9:02 AM EDT, Keisuke Nishimura wrote:
> The current implementation only checks whether the first argument is
> refcounted. Fix this by iterating over all arguments.
>
Second Sun's recommendation to add a selftest for this.

> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> Fixes: 38f1e66abd184 ("bpf: Do not allow tail call in strcut_ops program =
with __ref argument")
Nit: strcut_ops -> struct_ops

Once you add the selftest, feel free to add:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 159b25f8269d..278443118a23 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24853,7 +24853,7 @@ static int check_struct_ops_btf_id(struct bpf_ver=
ifier_env *env)
>  	}
> =20
>  	for (i =3D 0; i < st_ops_desc->arg_info[member_idx].cnt; i++) {
> -		if (st_ops_desc->arg_info[member_idx].info->refcounted) {
> +		if (st_ops_desc->arg_info[member_idx].info[i].refcounted) {
>  			has_refcounted_arg =3D true;
>  			break;
>  		}

