Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123A372EEB
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244674; cv=none; b=NS4vdeRtheTt3pQhap6ecd8/DMVS7p0grEiVpGtKTZzGQTEVSP4jv32p60NZSK8CsQGK6vn/KXpXm9d7ru4N+ByvyptgPViAD5pl7d39rHtmG+CHLxmAZZiwB6JhZD+Gi/EmFK4+uEeRYICXaPURv+yegKAL3Ar485yo6Kfa/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244674; c=relaxed/simple;
	bh=EmmYw85cVUEsq7+BHHJmxj7CNzz1yX/2XuoCf8SaapM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pbaRaNGQD6rlzAk1cH1Dhz7VJv8U4XV6mLwD1A3Sb7uqQTObEcBeecrk1c1FGvRHte1ubQsP7WwgECVSEvZvjAN61r+zR20x9CwAxERJyzp6EX2jwLZcx4vc/5qDYDeqGzw1CjiKw/NO2IxkpeayXAvC4aCTj+YS38ZxHdsT+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=q/gUt48E; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="q/gUt48E"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cd71fb9f06so350713585a.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773244672; x=1773849472; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aURB3PEouSQXz0zXeDm8x4IHWh8OR3JzdVl/0kglorE=;
        b=q/gUt48ElTwVligbHJp00h1JLgIXQHL3UojNoZaeDQwsSBmNXXDA0cYYJXCtPxA9OP
         2dpCmCZRb7lFbnKdpnY+nWkyrA5Y/4pPdibAN41BpZg3M6ShsY267EsdktwhYpqJ+7hF
         HcEVB5HgsbE8zrdquOpn+n0tJO8IE3mNcKEWomjHXzpJBt8xnGahfGaeAbIBvA4gbvlK
         kOhzPB+sTsvqyOiwMtdRmDNoEZFoaFY8KFHs2z/nfISdudDmNKDOH3UUQrJcZL9On6Yk
         ebGm/ofB4zUAvFQTuUXjQe/nJjF7XFZMHZ4aA17lpA9n+loJ5ZeVGx2j2aLTvJ1XqjlR
         DIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773244672; x=1773849472;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aURB3PEouSQXz0zXeDm8x4IHWh8OR3JzdVl/0kglorE=;
        b=EvnLAxm+aui+KNHudgoWgAoJchbNnge/Xd03sYSTFJX++074wuW2/RF8opU+nfkTTC
         KCe1XPMtT0ZNAR+SOV8S01U+MaRW6nzBWlWL95dcc+Hs4OK/s40MpLttN1C7z+souysS
         FOAfHtGQqT6ZJcnHYq2rkEVlo5QE1d1iaXOTcNihuH0ZCj5ZS1y30I9z2GK12h+mfEPn
         s4UZF8m02rbL+hz/GjiFbN20kv2yu+6zb/NZqbU2T1mleKvgTY2Vc0fJwKBL5j5vzkhl
         9YEdpRl4R/o7runBv9/7hF0X354B8lRROre9HnVc+3G7oL/AF5rsiS9TunX0fCKW3U/S
         X5tQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1LhcBk0Xu/2Fu1vnq8YdPaJwNyywCLAn2oUzUQ5lthLsL5V1dYH9isooCKhw30mn/9/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+EKZqCtHCUweYm9Ev+mk14zIzigDhmtqUj6pr94TcZrjcd4I
	Nw0PtRa63+UapL2x/YhC5RgEWzwcUHhCNQTYX0nDjF3+n8rOpgaPKfrz9OSU+T+sh7M=
X-Gm-Gg: ATEYQzyZ5ms/F7w7BSytPOUvzDlqNPAIfZzuACZxKzU1MWK9U0utTpoITk54X3O7und
	nK1M2eAdkbkaaNAFpiSdJeYAFlnPFjYN70aKWBnr7bSsSQGoGqgLHNip+d3oyJPJtV4l+BOp0G7
	7BPVVC9JeuqtKf6tSlsCbWcwHDovUEW1ABzHjTvU4fW0P8bMwX7W6IbsqwPKUMv05JFps/Ilvcr
	Wrriadgqd+C2SR7hGzXC5p2VP43en2QuRCetDmZd1cg/fsj/rqVYL2pKLN0z5ELatwM5vjqszFK
	1um4qzE9UWk9v4Rp50V8LDCbdk+49oAhh0dqAM1PrSOaUGXNtxZYcXeNuKCd7mIKSubfGTqIOoM
	d8YI26ZAgJWx/IRJ69CEh2W6NJzwRrbxIJdbjI8P31Wgg1VTrHqz7bUBngD1OiCt+h+g6FNgpr5
	c1P4uak9Bvm0e3/oj3oayN6Es=
X-Received: by 2002:a05:620a:d83:b0:8cd:a071:9ab2 with SMTP id af79cd13be357-8cda1a826cbmr359119185a.77.1773244672044;
        Wed, 11 Mar 2026 08:57:52 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fc474dsm167299685a.6.2026.03.11.08.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 08:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 11:57:50 -0400
Message-Id: <DH02RVPTQ78K.3CPL9LSSI6IIO@etsalapatis.com>
Cc: <loongarch@lists.linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add alignment flag for
 test_verifier 190 testcase
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Hengqi Chen" <hengqi.chen@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260310064507.4228-1-yangtiezhu@loongson.cn>
 <20260310064507.4228-3-yangtiezhu@loongson.cn>
In-Reply-To: <20260310064507.4228-3-yangtiezhu@loongson.cn>

On Tue Mar 10, 2026 at 2:45 AM EDT, Tiezhu Yang wrote:
> There exists failure when executing the testcase "./test_verifier 190" if
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set on LoongArch.
>
>   #190/p calls: two calls that return map_value with incorrect bool check=
 FAIL
>   ...
>   misaligned access off (0x0; 0xffffffffffffffff)+0 size 8
>   ...
>   Summary: 0 PASSED, 0 SKIPPED, 1 FAILED
>
> It means that the program has unaligned accesses, but the kernel sets
> CONFIG_ARCH_STRICT_ALIGN by default to enable -mstrict-align to prevent
> unaligned accesses, so add a flag F_NEEDS_EFFICIENT_UNALIGNED_ACCESS
> into the testcase to avoid the failure.
>
> This is somehow similar with the commit ce1f289f541e ("selftests/bpf:
> Add F_NEEDS_EFFICIENT_UNALIGNED_ACCESS to some tests").
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/bpf/verifier/calls.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing=
/selftests/bpf/verifier/calls.c
> index 86887130a0ef..29e57f0e56c3 100644
> --- a/tools/testing/selftests/bpf/verifier/calls.c
> +++ b/tools/testing/selftests/bpf/verifier/calls.c
> @@ -1521,6 +1521,7 @@
>  	.errstr =3D "R0 invalid mem access 'scalar'",
>  	.result_unpriv =3D REJECT,
>  	.errstr_unpriv =3D "invalid read from stack R7 off=3D-16 size=3D8",
> +	.flags =3D F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
>  },
>  {
>  	"calls: two calls that receive map_value via arg=3Dptr_stack_of_caller.=
 test1",

