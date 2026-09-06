Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72543BBFBC
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788736727; cv=pass; b=dRxvDz71Juoqnv5JZykCgHmoN+f425iO2KOK4diIEqQfFRzGy+iUdux06F2IIiD4YgdKJcUXKOZh66aN7X3XgaFr94N0K4Lsj3DZIQviAl+dukNKM/3sMW1ycK34d6GS/A2BUp8V2+AZcQeHTKdjanY2i5gjqbQ+phrrpXYOck8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788736727; c=relaxed/simple;
	bh=724XBBM18e/5/TAVSEA0cDWj19CNMiPpyAaDTnCZGLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkobp8dipYEY0MP2ax9dp0AwHKO5WjBU3jT/yZ+slgCIINGX79xxEGeob4hcbcNvtePsAjMLBYL7pqrjPy6Z9GP9quqc96FcJCxZ2rvR7530EChRFK7XEdWMyq6iOTLSn3N46UTEztTRicG1nffEZEe8Ou5X1/bTb3WKL3epfWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0SQSRcQ; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0SQSRcQ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-862815e2683so1459561b3a.2
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 16:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788736725; cv=none;
        d=google.com; s=arc-20260327;
        b=jdc664zgrnHEIwg6GEpw8yVFj1HaIcDBFkeiYzr81VDi5nXCCKG3ZlcCKUR3gCN74U
         /vm6cmDW1pT5geQjDwAAUTs7S1VZTC0PrYgAvbqg1P0u5kd7APzkKXO0ZqW+kL6KO4Go
         9M6RcpyJudnKDy6uvwTSEYpkx1CzJKtBO6HKyPGZ7Wlf/QdY87sF3lePlU7QAy6vWvNP
         A9wlAsh/aBDvegYTfva4zzXsap7BkI27p7PEIeaoMk1+ldUnF38cZbI4CSmnow2sDMgy
         vlM09/i4xZ+k9U+clrCxLB/TzZj270cwOOGMeyCcjLGsEA5NE/GNXl89NWJSQQaXiFV7
         13og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/lolE45Uhyd+sThQbwL8EFg5+bmDGsCrRM5xzs+E9ks=;
        fh=2Un553oJFCtgoQhSZBJxJVwsGna+Fz05ko5/SnVx+Xc=;
        b=ZUF3933/JrZkSFBucv7grD5SGnxSAQAtkTuyfugrDluAhgGakKVBJBBGfWbQvXXabP
         oAdDqMbDfTIFnde92WpSUpT0MdhKca7vLURECj5YWCnD+4CV1eFVHVKui24ciDUw0aqR
         hzVRdDciLOhG0q0AsG2UrMT2Vqpv2Ok9K+zEKpRKgv9sKwe7VHA4BBxHIDkKgnXSa4IY
         nwBpwTIctcNnT0sXiB4wZGSD/rvGC2F/TswWVx7qpGwAMUlxxlzhv5QtCs5qUT3LO8Nc
         sC5RXPVNPT31XYgEfgILeEyLJkGskIg4Uwdw3//SZa9qX0K2SmO8fKNYomZpKfR2ZVG0
         4qLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788736725; x=1789341525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/lolE45Uhyd+sThQbwL8EFg5+bmDGsCrRM5xzs+E9ks=;
        b=U0SQSRcQpQGzr9UR8MK+L9br7STH2Yj3Gw/0QQtpr2LsD7ahUiJPVL6Hd5qyU9tIIK
         LYn9bdXjdL64w/Vt62iOZr+0E6AtPvOvgSMO3Lpo4cyMfumMjOPfrIPqqz+aP/SPxtp6
         PKT78kyRXTaqAnSnkIJEk3RYEVUHwla2xZ4VZKe8qbIfh6mr9kfeMJ/VKro0SxcMWyoF
         X8cS15YfGT6ccabKtuGTcw02h4s0rbfgMU8RbQOL5A5L3KuIVTjjfip0nMIjHVcjmEtt
         M4lQdXCKLE14sGYggseBHXhbq71cm0Ao0+Jqs8JT2t47o3mlf2z3XxfcRwATtyvFSEZV
         aAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788736725; x=1789341525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/lolE45Uhyd+sThQbwL8EFg5+bmDGsCrRM5xzs+E9ks=;
        b=BVwZHeAw+VSf2P0XSHZ1xxewmI31Ez04JALm3FoPQUCwLZbRnEHQeudSzD1LGi3Ki/
         2KJl1RxeEPvCCr9cNcY2wVNRR/FO3/x6PyzxLxIty5V6cSu75WZAtoPhMuVbRwrWIkXi
         +tpMxKSTKqHQhgc9cm7P9cr5XC+eHvjaOgwWhWLBDtUiK5fRwlXHE09rVHsU+MLG6fEt
         FmovoGIhnE89RJqXfYPPNMGSEtpq0cj4U+oAEJKmOBeDI/bQCwgIlM4CUPG+hO//z79i
         3jyajGfXaIizSMvmFz2whtMmRsIgJ3Nfy7l6U3e+qj4E7y3K8FkEh1G/L2IjksNBkfqe
         Kk8g==
X-Forwarded-Encrypted: i=1; AKwUvByBtSF/O8LqzQoEdcFc9R8YXmZWq2furV+uz2bnpoNIn4ReASsr3mJbJIW2fUtagKEeUlE=@vger.kernel.org
X-Gm-Message-State: AFuF++kLneTnXbMTWk1uzDrz0WCSCFJxGTuY9fIvByDPJFd/cFMnW2CU
	sFToEone1Zon2xE78OSh8DQUfXeJOddIrL5ct72ThlTFGXomurTwjwhX0klGufp+ZYgQ1dj9dDj
	bTgrcR2A9Fz7P970Te9Pi3npv0SEV0O0=
X-Gm-Gg: AYBFou2gavkoGmOup0+CsKIZiK94U2U4LqOZSXXFaleuOLX8mR6DGy7PiFEHKyfM9Ch
	ScXZ9y14nMfGHp0BaqY2FrXytG0Rqbq6zFP6kthr3A3fK2rqqUD28lokm2hs/jHs9/lhtiquSPw
	mNTpw+AdhAKcZi5/9aDDvwfWdssixRKgex6ykVF0UUIYUUkF9kt03xVt4RIhTpF3NT9S7icgoPi
	4HXPs7qo0GPVP/EM8x9Vdl0cVyE+MNj0F1PVLOHZiMIFBwlpskbFQrsXMzai+g6+wvlSDrcuYPS
	rO+4R6F5BPN/TcxXckiMNjj+o6qJqKW4kmYYsvt1H6wTwS/2/rW20XkvZMP3SemkCNHR+bN+79Y
	79BRIqMpqZe9sSKfRdgsQRlcoaXJKJVSjJSyiK5s=
X-Received: by 2002:a05:6a00:13aa:b0:84c:5b65:ef86 with SMTP id
 d2e1a72fcca58-86168e88261mr23644101b3a.17.1788736724956; Sun, 06 Sep 2026
 16:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apl_5AVsAYLjVX5C@sirena.org.uk>
In-Reply-To: <apl_5AVsAYLjVX5C@sirena.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 6 Sep 2026 16:18:33 -0700
X-Gm-Features: AcwNN1WQk-B2sF_oTeT_a5F-7sgNbJL45Qm1_BHeZkWfObnP1i9S5tuc4ycX_W8
Message-ID: <CAADnVQJuAGh0P0sw3wWWPAmq1OmAX27KNiCYn6__rZkGs0hPrw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:10=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/backtrack.c
>
> between commit:
>
>   e3e4f66cc4b72 ("bpf: backtracking shouldn't clear outer frame R1-R5 for=
 callbacks")
>
> from the bpf tree and commit:
>
>   5bbb242c08590 ("bpf: Handle R2 as a return register in precision backtr=
acking")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> I'm not entirely happy with this resolution but I think it's OK?
>
> diff --cc kernel/bpf/backtrack.c
> index 47282ffeeaf94,653db80bcc47b..0000000000000
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
> @@@ -533,8 -538,12 +537,12 @@@ static int backtrack_insn(struct bpf_ve
>                         from_subprog_call =3D subseq_idx - 1 >=3D 0 &&
>                                             bpf_pseudo_call(&env->prog->i=
nsnsi[subseq_idx - 1]);
>
>  -                      /* Sample the return registers before the callbac=
k
>  -                       * handling below clears R1-R5.
>  -                       */
>                         r0_precise =3D from_subprog_call && bt_is_reg_set=
(bt, BPF_REG_0);
> +                       r2_precise =3D from_subprog_call && bt_is_reg_set=
(bt, BPF_REG_2);
> +
> ++                      bt_clear_reg(bt, BPF_REG_0);
> ++                      bt_clear_reg(bt, BPF_REG_2);
>  +

It was more involved than that,
but now the conflict is resolved.
