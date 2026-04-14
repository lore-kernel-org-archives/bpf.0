Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5330BB91
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776189069; cv=none; b=I04SLM+JeAlN+fnbsiCPFg/q7dvW8Em2sWxfqrcBCT7KIQ/1ptYJlml796R6dYiKbN0So/eUkKVeR9ujxnl+JP+0wO3rHkyGGb9CLYZS2gpvpRSFGwzdJbDcUO7AOX72huyB4qEzCvU+DO8GBi1ZpICXsLuyPxi+3JuhsESXLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776189069; c=relaxed/simple;
	bh=yqx7fB+tkOC7Fj7uX4IZycvUP3GGAdK3Dv4+Yb7jGro=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=N3bjkPSZPgCFyLhJqjsgc47SxcnrXS1HgHqMYdkK3RF4lV0YhVUmuopgTwPjKWKe8+J/1Zh987mUR5KV2NCdacv2wIo2pefH/kUGrFaQD5aK1wvhgBZ0QbXBT9b5xZs5hqYNUTxdmyoSzWBi+u6p7G6rWK2xmRzoOlqk4NNoj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=KfS5bhNM; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="KfS5bhNM"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c555f886dso1411357c88.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776189068; x=1776793868; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hzOAQCStV7yM0FsaA3XQZ1OLxRBJk5gVi7sZfbB1pE=;
        b=KfS5bhNMQwZBEsSW5DEQ0OeIPhqZWLvTdGdlmuIg0IiKbfQv1XvEEeMBf0n/7yQjKm
         2/A0OV2al2Kginqwnk/kCqvhuqf7NoqHXLmP5Ye2YKRzwq+0d7v3pHg5JM+mS7DOuF7+
         XO3Tc4GgTON4z3BR7OzlONPWGPaIuV84eqP1CNxQfD7GEeqI2CB+ugMu8WIJUs1WINyF
         stn7pWt1+7z4u+on6uaAUnF6td1n88rj4nHq1UUr4f4HzTcqdAIAfY3zThDhZ8dSjtsQ
         jH51KgC3fnmppEPtzXOwlN1VUB8JZpj8pP3ERrzotb3kDw7sYXwgl+3UeklcTKEeiymx
         HViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776189068; x=1776793868;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hzOAQCStV7yM0FsaA3XQZ1OLxRBJk5gVi7sZfbB1pE=;
        b=iHgvSRJcMM4vMndj7Uv/E3HiZqusdYteqDd3xC4ebfxZcm9lcb/Qtx+6RWh6M3905j
         cwlVMOcbCJN6aTqEQADGc2zOp2Ahr06wbW8pjh+4mzP9o/U1ZNDX3gct4h3Asgd4NaYP
         r9nAmMQbaLtgpmj6vtOLVDh6rKT/zwrMcWdLGmU3HlgCGLLY0jpwYcCidGnvBR4sgHCs
         /H6X0KuXLSoECibgjJ+2d51JDR7fp4fkHvcFBlvwjtgAYV/B55mSOAZxyCxnhfVtiiAX
         497pjP+i7Cb/UyoRF2cwzMmI2XMHVllqVmsQQ7n14j0M6uditc+W9k+ZZAoGzqsntT/B
         dPCA==
X-Forwarded-Encrypted: i=1; AFNElJ9Q8DnlNvbFlfy11rHubnaMCdyFP/z+CfMY3B8vS1NH98JZDC3T+wT/uCMAR8ZEhjpBza0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn05GTKz47l2Q3u0wC81wwD+rvDRy/c5E3P4r6GINa9M0hTHdA
	jH1yKTAxDuX6g/MTJXxRg/MCNBeyJWUM7g8Xs3wa0HelxWCE9O8nTH4snRnt3ie+zTo=
X-Gm-Gg: AeBDietOYQLbh9SkeQaB54yVbZjBowDKSQvOJ2twFdWGz5AiHkkzvFmuGdhBYLnVlx4
	0+AtokCxqPjQqzh4a+oBTETjTsIYbIN/w78NzcSOwQhLeL3rHQ5wWzSmPM2DkB4ivyDXjG+wSi3
	iTp5lWieqCyfRfi0Q8iRVdH8DciPwslCCjNCZ8whrJ1CuEBFpxnSW6K4WrtkwpfrieX92j4O39k
	h/i6CZYuPzTHyeRug2od8TRoJc7mImldkC12o2pIGR5947pnFl98zK5/8vLKGhCkK14WaS/ZDeU
	VKlPlHPfKZOpqejaTzMYS1XWfogzRxcVhBfc3tLScuqNczOctgCxnnd5vall5gKn6aUCazCjdl2
	1EhlwM6KIiWyXieKYwHOdDnkjnQIHJjYnpzXfVzmtjwnZHDIIJfVl2eymZAyR9asSNZINTv7Z/v
	EIge3ks/ZTHno3Bbo=
X-Received: by 2002:a05:7022:20c:b0:128:bc19:813d with SMTP id a92af1059eb24-12c34eefa5bmr9670560c88.27.1776189067437;
        Tue, 14 Apr 2026 10:51:07 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::cfa6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c4acc7d6fsm12439963c88.5.2026.04.14.10.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 13:51:05 -0400
Message-Id: <DHT2H40J5PFS.3OI8QCPWKDZGK@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <herbert@gondor.apana.org.au>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 17/18] bpftool: Add rhash map
 documentation
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-17-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-17-3b3675da1f6e@meta.com>

On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Make bpftool documentation aware of the resizable hash map.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
>  tools/bpf/bpftool/map.c                         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/=
bpftool/Documentation/bpftool-map.rst
> index 1af3305ea2b2..5daf3de5c744 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -56,7 +56,7 @@ MAP COMMANDS
>  |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_s=
torage**
>  |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ring=
buf** | **inode_storage**
>  |     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_=
storage** | **arena**
> -|     | **insn_array** }
> +|     | **insn_array** | **rhash** }
> =20
>  DESCRIPTION
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 7ebf7dbcfba4..71a45d96617e 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1478,7 +1478,7 @@ static int do_help(int argc, char **argv)
>  		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup=
_storage |\n"
>  		"                 queue | stack | sk_storage | struct_ops | ringbuf | =
inode_storage |\n"
>  		"                 task_storage | bloom_filter | user_ringbuf | cgrp_st=
orage | arena |\n"
> -		"                 insn_array }\n"
> +		"                 insn_array | rhash }\n"
>  		"       " HELP_SPEC_OPTIONS " |\n"
>  		"                    {-f|--bpffs} | {-n|--nomount} }\n"
>  		"",

