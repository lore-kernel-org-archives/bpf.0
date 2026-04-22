Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B293A1A3B
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894689; cv=none; b=MDjPMYcDyQy2UgiLAvrbH9urjWLFMlJrb/+egHMtW3b0kSt5wsKmMYE3V0KA2DH7KH2ayEBh4x6w3HUhZav2dTIu06QTZmBzhA1H0imbiJMnU06VEjdvAha2BGkBAN9QPx9vV7F21RSz6erCCnw+ClV1G5wnL9ogVTuOjLzvWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894689; c=relaxed/simple;
	bh=xLR7/Wot+FXZ1Ew/rIkiouhKCMOIbSMG6rMeuY6RhSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwH2clTky6WtnP2FK+4CJstrkAnAKFWxtcFsxNT6okdA/1/3oQEbYJANeTbtXlZN1JUFU+xzS2pErjDSX0k9M0KL3WTzn30lza3wlqlg0SiL1mEGGZy6oAQr20bI7t08yJ4qyu72OnrYzsf1qWXHKkOCi+I8VsADbweip7VQg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPL2z4cY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPL2z4cY"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso3643556f8f.0
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776894685; x=1777499485; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9npoNohnanVNqr3tknK64s3YC/XC8dcwMAoGONJ+baE=;
        b=DPL2z4cYor+QQH4TF5gXU+aI2Ks4XHr/orJCwc+n8nPdV30R+ltbdooJ2LjiEoqYv4
         oeJlbq6cWS4xcN9URHpLucD5D/FfEijeWmp3+zi4FbbdqkU6dJif1AuDpf6YmU+R56eY
         JscA24tMqMhqWNdK2bgPrxmQYNWlXNGck2BgiruVea/BDmpv+TyB6E5qlGA9bOOy1IgN
         YE1cVsZrCmbCkxTA1JVoHs+H80j8lDEqKvfrwiC3/FQSG/XizywH1Ssf5WYjHBcn2lUa
         13lLs7BAdGNlNKQO1NuUcBUwlqOq4r7J0Eiu4JND+6NHrQ820mz2cPanHDaT38FdI56m
         l1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776894685; x=1777499485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9npoNohnanVNqr3tknK64s3YC/XC8dcwMAoGONJ+baE=;
        b=JBaJ2NVVeyBGN9tnFD1AkmvNROmYicJADjJrLY9SXdiN8T1OEZBH+/fpvhJ2yhhnW2
         xxPEvszdwWo+bYtTPVpJbtirnqtL6Y8RRtOwihQxcB+N1axh9SyRKHY1rFd7FKoF22fH
         i1t0YsePHjVQjubB1Tv7vzvn7aP/jbNU0v2NTr25hRjDx1guUITtMEWMqtSMOT75vtmX
         YzF8XlnBkaYMbeJoXOInmlJftkBWYKNljjP1qyB5vq6I/i9e96moq3pWyh3X+2e24uAV
         Da9WAoPt9DSww3hYgKdcbwVgy7GeHQ1Ayic0ezixfupSvGOjeM9JHl8yLi4IgEVdjZTE
         aj6w==
X-Forwarded-Encrypted: i=1; AFNElJ9IlngYLsvrU9pB6uXDpda4MNEh9+yYOkKCbYGWQWmOuOu+LDtBgYUHkvwn0TDN6q6DCr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rBU/gkrfNjMc/qgfu68wYdJvQNE87cYt5m6C0Y31iS167UeB
	oLF4x0zgNSch9QTjCUbXsNc0dWVfXBqFMaXYkdm0/dVKCvTeiSKEIUjr
X-Gm-Gg: AeBDieuN42MAruYUzqsk98CLzZrty7Nnnf3w+M+7WzafzhVj9aGuyXx9bL+DmwPT6yg
	0v3ELSDXgS2Xb+V2CVIi2rlce54FPO64nUyp7TmMqe2vLoc7kTl7490NiYIJhh5o3oyr1/uBUzE
	EsIWZ+r6SnjMp5/V9KwaRnCOwuCtoGq2+fh/Zxa8tTJf7RFBkEQ6Q83vWZgyEI/ThhdBFvigToG
	nDmML4DlzPqH3pwE9rC+fd6kMHJYFywsNY64rYkF+9ELv57yk4uARbjsnJVowjKvQpWWwMo2E1M
	dmyHet6HFZbQhCnk278LeQr/B9vNJsujpzWfNdsy93fiKrvjC8R3Vz1ayjoLv/zO65cdbo2lLSc
	H8V48yvbAFbKTQJERrlZ8BMTJplM0FJOxGrGWJOIz60OXO9tC2AB0KriXXL2OXHdqicq/1PXqJM
	RqkrDacNlnCArE0kfjsxgWzyk9mN5bD6n6/7hut6ASpajtjScTJPrYqY8lmYNuKIdYXGNojx9tY
	EqkcuCKJXysdD3twulwDOU3ufbqdxlWhwwAinHO9wMvcEVLunP5Fum+ou9jeGltCON1uk9t3SIO
	0NIPHwqaWSxsoO3mX2osBcc2ZAV3YkhLpf8GZWlr7sZbfvwsCNfGFZHtQ1lmnGI=
X-Received: by 2002:adf:e789:0:b0:43f:e94a:e773 with SMTP id ffacd0b85a97d-43fe94ae82dmr22387800f8f.27.1776894684917;
        Wed, 22 Apr 2026 14:51:24 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00069634438ccb7ad1.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:696:3443:8ccb:7ad1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44123d23e0bsm9675361f8f.15.2026.04.22.14.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:51:23 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:51:22 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Alexis =?iso-8859-1?Q?Lothor=E9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, ebpf@linuxfoundation.org,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: make btf_dump use
 xdp_dummy rather than xdping_kern
Message-ID: <aelC2iC_KbIq5jwx@mail.gmail.com>
References: <20260422-xdping-v2-0-c0f8ccedcf91@bootlin.com>
 <20260422-xdping-v2-1-c0f8ccedcf91@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422-xdping-v2-1-c0f8ccedcf91@bootlin.com>

On Wed, Apr 22, 2026 at 06:20:24PM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> In order to prepare xdping tool removal from the BPF selftests
> directory, make the btf_dump test use another BPF program for the btf
> datasec dump test. Use xdp_dummy.bpf.o, as it is already used by various
> other tests.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/btf_dump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> index f1642794f70e..9f1b50e07a29 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -1027,8 +1027,8 @@ static void test_btf_dump_datasec_data(char *str)
>  	char license[4] = "GPL";
>  	struct btf_dump *d;
>  
> -	btf = btf__parse("xdping_kern.bpf.o", NULL);
> -	if (!ASSERT_OK_PTR(btf, "xdping_kern.bpf.o BTF not found"))
> +	btf = btf__parse("xdp_dummy.bpf.o", NULL);
> +	if (!ASSERT_OK_PTR(btf, "xdp_dummy.bpf.o BTF not found"))
>  		return;
>  
>  	d = btf_dump__new(btf, btf_dump_snprintf, str, NULL);
> 
> -- 
> 2.53.0
> 
> 
