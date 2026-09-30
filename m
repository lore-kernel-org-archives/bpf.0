Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321BA4E9C32
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799829; cv=pass; b=r2wX1ZpIpkVPVICIam/Iv1XaphOGuYhQFWCKBX7kBo1G276NqGSqAlmHOrTcNU7EGEKv1XKFOVK/cYPhPS5FPHe5CFJHpNESv7MeCIo1YfJm5kLnky979oiir483p7n32LsVyD0vVudpPWZaQMR6wC4Qpi04cyaYDPa6Ldwr6tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799829; c=relaxed/simple;
	bh=tjWVkCtWN1ksllcHQbdL3oVrHpjh5qWpPcUDOolq1cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBS3mt+NEyLXR+LATnTFXyUKi3aIniaIoAbKn0I3DqRAqPBR7tWIlC9fCtaGwK5jefujS/DcmXTc3jksO9eMPrg5f/CZ1wvJ8JorrpGfoEJL9T5gbpyvkIuxrk4VorAt31oVScaWGA3clt8wDuv2rncOOAjwfiXgiYA3rtdr+eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sm03E8CI; arc=pass smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm03E8CI"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-81acede04c3so2163572a34.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790799826; cv=none;
        d=google.com; s=arc-20260327;
        b=XbbPyG1sw9dkPHT0uLuoO70VbP6fPVwFJeOE0WieUKvnDHuwMSExKJ94dWsZ+NLSn+
         Y68GNirsYPdA/ABecc0MG+7zWs2fgd8Squ5xiOGBIZP2v87lXUHUYl/jU3GnUPGjcTsO
         8TIbIkECtvo+ZLt/pO0pCW+eKFJ0PQmLw/GqBSlxqiV05nAqJmEbRmElBZEEnXH0Bi3D
         y49/wn8/16k/X+dhMCfAtcGuYMefVca0fQ1sNph2DIsGUELbWwRpIXE1IKez+XMfD6Oy
         CLrt59t5+Mi/V2bIDZKDO0L2ZgwgPmheFP2wstrX1MkLZD57T1YCZn9/IYGwU6X9a5Ce
         nLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3NFT0Auogh5UB9tx8XlsAJmBChn/jmV5eAEA0nyqDX4=;
        fh=V9c9pomTpbR0oUsSJ8bN2ciV8tN9so1oJSYZPiRyWMs=;
        b=OlofSacGIHAKvOko4nagcSii37jX2iaUAKsoPJfwtCViGn/O+ItVgotKgIJo8n2vDa
         sKAfCrHwK6ewVy5Hr3Er9Xx46TQ+TTBJxHcOCh3gpR+OLydU3YHagmQuQ6T1dbWT3RW5
         hxrGRezzvB0o01A/KG0uAfoO7j0LApZoe6FXjtst35o5SaIwfOYLg9sV+KYBo9LZJU+9
         by+ijO9n0AiiF4m2dQPFlx5XL+cwkC4s/M8tZfgC3PP0paGZ1xb/M3MTG1NzRKFrNnlQ
         yXxVlO4loPlGySFXMsqdEjjm7ob39YN8k3XUoY170uechtsU7huFA68QpPCyEFXnJhX4
         R/2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790799826; x=1791404626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3NFT0Auogh5UB9tx8XlsAJmBChn/jmV5eAEA0nyqDX4=;
        b=Sm03E8CIiAErKAfcG0Ci7cfDCjiSCua7PP0hSuKhHEZdq0s5qxXQb8oxDMisK+LU/y
         pqyxaoj3mmm8ti3Mcw3mFjXdeB7fcC7oPzvZEDp9KAQpGE/sqzP3rnxFeo+CIz8hkV4U
         EdiPmnajp9YiNPwSQ78W/hQdr5FS//g971hrNLuOsTLJPKkNMvDMLPdSq7MNgM9Wsa3m
         V3cfmsKzV79kP5yvheQd5vONp2bthr/W6K63iTbydGgwH6RRmhatlxx9V6D3OSTkmQKZ
         TaPGsmQasVCz2NI+WfhZs2dUbaoDQJdfZ6WqeXZDN8OS1mGdihtwxnfRE0bwU1znk5g1
         aVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790799826; x=1791404626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3NFT0Auogh5UB9tx8XlsAJmBChn/jmV5eAEA0nyqDX4=;
        b=I+gncnfbqx+ugRBuNzh+eHtGcepulv4WGlCevicKSRocFJ2WxFgoeBj03Vnn1bEvfA
         gbJjl0I5BVGVCfJhUNrodcd2TJlVqZkZilzBw2QG85lrkGbOH6AdLnXkY3T2fY53yNlw
         GF496qsDQxTVLGDCo5f7f2vx75PI0m74V59W1nei99ifmFdVxrUdwWvimuI4PElZIj9+
         AwyNeiPn0heJzgTgsLv6xcfJ4s+lXgtQQa/Ohq88YlYLqfAvhld/H+d4kYRGw8/qWtcv
         55vYVKK123sAXM6e2CQt2oTQGbhYzN9Y1iiZo9WLVAcflB4bJS0rhfP0wT38H1v+7EaN
         LH+A==
X-Forwarded-Encrypted: i=1; AKwUvBx8tm6LhtELTXxS/U2tlW5SAyzs02+HiHjUwrPRyA9IIokJ+yGeaP0LtpB1kLVUnQ8W9yw=@vger.kernel.org
X-Gm-Message-State: AFuF++nx4yyXWhBx73ZDifOqHIIuChb1EhPqkIzd7xsAwGwFEX6H49Xc
	LGTCH5C27CLmvARvow7DZh4YActRjX4DWjJa5JVAzM5wWb8TJ5tB459ORBv2EJiwleDFfZuYNza
	VbXnPwWGez4kWK04SwrPJvwQgYhF0M6e2VA==
X-Gm-Gg: AYBFou1vHXD0PucOfQZclPJ+FuA1rIrwerLGiZo5wwtCj5DIa48M4UpS+aTMiWb+zhS
	ErsHbwVszM3FB8aQm2mgaMkWyNP35iIHAw3gcC56g85aI5eoqdWuAhBPTDrGzkXQsbpTHvF5mdd
	vArIzlg7cv6gHuFl2/HlXmpVtRghtZbmWklm5Rpy1MMoB2ivij9S48IJDy9AQgdFGAWXVylG+6a
	c2S3KYH4sgN98tr24tMeo90Q+x+JR0uP6dC7OJ8oOwIkWsxuvgx5us2tBh9gHZfG3CS2u04tQ9D
	0XbiKQJXmrLzgjHJoM16eovNEtoXXYdfP3NoFVeeIGmAZHC+wKCpVnQ=
X-Received: by 2002:a05:6820:290b:b0:6b1:95fb:81e with SMTP id
 006d021491bc7-6dcf4559dfamr2868200eaf.22.1790799825918; Wed, 30 Sep 2026
 13:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930135159.3926039-1-shakeel.butt@linux.dev>
In-Reply-To: <20260930135159.3926039-1-shakeel.butt@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 30 Sep 2026 13:23:35 -0700
X-Gm-Features: AclHuK-HRG7T7XdhgKdEFkDWm3u0VW3bj7sKHiJVcbdSbgRB_tt6JD2iyN6YLbE
Message-ID: <CAMB2axN6-sMPu++HPXXJmPp03f80G0WhgHPLe4Tx2N53V5REEA@mail.gmail.com>
Subject: Re: [PATCH] bpf, cgroup: fix cgroup struct_ops query for a second
 attach type
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 6:52=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Two things in __cgroup_bpf_query() work only because CGROUP_TCP_SOCK_OPS =
is
> the only one struct_ops attach type.
>
> It calls cgroup_bpf_enabled(atype) with an atype that
> find_atype_by_struct_ops_id() works out at runtime.  That macro is an asm
> goto and needs a constant.  Today the compiler can see there is only one
> value; add a second type and the build breaks with "impossible constraint=
 in
> 'asm'".  Add cgroup_bpf_enabled_runtime(), which reads the key instead, a=
nd
> use it here.  This is a syscall path, so the cost does not matter.
>
> And find_atype_by_struct_ops_id() matches on type_id alone.  An attach ty=
pe
> whose subsystem is not built keeps type_id 0, so a query for type 0 finds=
 it
> and returns success with nothing instead of -ENOENT.  Skip such slots.
>
> Fixes: 369d9dcd8fb8 ("bpf: Add infrastructure to support attaching struct=
_ops to cgroups")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
