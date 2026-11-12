Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517026;
	b=gBz6dLzrgC/KB2tCqW2HLlZIo+VNUfSlAF5u9zzMceujvg0F94rrTWI7Yu2/c/TOjrSt
	 MIq2b6rXhwC+pzjLq08mX9rh4vOFbyOVroj0eWqaN6KBVkYQorOBbSgat/tTnv+R2Uif2
	 VfFfRjkNUw+43DhO96gTaLI+msyFgm6vewfZ8DleNkIRfe9y04EGDrVmMPa7bFU6EU1a8
	 SH9JYEK5QBc0/Uo/8qKxXHDCUr/14+yLlxD/+VicTeM4XzMGUtivRyrc8548SB8VD7ev4
	 wL+0MTwZelFVTse1THRIiRd7xs5hQJyH4Xjn/cWT9+0CNNnJNJbD7aLcplCWgtL8Cjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=e68ELQiwpDBaPgGFwS4ZSzIkJMM3tSCd+P1yanX7rwI=;
	b=H7fjbeXrqWfFKKjO/fseZigIQQmZQdnUqHrwgU7U2r2DPZQbnXVXYOU7U292hznw8Ppf
	 td7tE/U6uTfvALOmOvgkpDZC4x44BzEb6ZFcfDrfXSkXe0utBOUJpZVt7ehh6mpi6Iqde
	 +MyvvLCOJ2RUoSHoICHKZlsb6F8N2nPSDEQCcSedbK2ym2u6SCMnLdCd7/mDXoDxN4t6I
	 CnkU05xIjbPg3/MLozrtLbcs/JFbUy/XAn8B47CpJfNLiDBIz7Ha4DueSG7kdVuyWbhRL
	 BRtA08RRMwOZclVpHouytBniexmaiUYwc8iRtwQ8ozOhA9gyshgYJYzeuU+jKA5Jm6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KxPew1I3;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E725606A321
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E725606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KxPew1I3
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so106111b3a.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 12:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794517025; x=1795121825; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e68ELQiwpDBaPgGFwS4ZSzIkJMM3tSCd+P1yanX7rwI=;
        b=KxPew1I3PwGG2pZNZWgWXa4GjYWse4SICR+kgrhTAZDwqn/mr4LrrF5//drxEAdXtS
         bYS4STAcG1SSMPUIni9SDqmZXrpmxeOni6KgALgJ1gTiCUL6YFqXI0nrvom4PRghE0Ur
         roXqFwE8BgMRZzDlrgZpzqfMFRheyGcwOIuMXB0daNpLM8c9FKB3zWwZUFH0hao00cVy
         JeLOnYefOTHEZCJD3sGAl43thCrm0qfXXyP3US7YtnQJfuTF8tDb+WzTYJEQw2InvPvD
         +3W1n1SHxOSN2SMYPNXkhbRABaanDfullkwvuhui6bphElr8BW5lVmwq0M1u99knPaUH
         3bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794517025; x=1795121825;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e68ELQiwpDBaPgGFwS4ZSzIkJMM3tSCd+P1yanX7rwI=;
        b=1YuIIcjJ2De/O2miWbYusk4opaGxDAiRi5t+9luMDcPHSoC/LiQudTksYiWugecmdH
         vdJ2+lhmguhMapP7DYK5iBuKXuEPd1EltRymF1jEmNgMsqR4Ia1A7mlBAEbXAJ4dx3aB
         Deu6qsUAZUHKBntCgUTfLo7fdmH0jahqENDUylqgQ7gIw/buQHqfk/XCNl6lojQf/UJW
         zeeCPtqRhq0MnN4dwnMr3dhwm5f/0UBh7hguSdYLtpKaCYoGzyWCOr1Nu2VLtOPGyPZM
         9BhmlqSQ2+CGgWdF/HLJTsXVEkwfaeTzrorglt8b43NZ7wJPf7INKcmy6eMl+Vbt2zA6
         dzFQ==
X-Forwarded-Encrypted: i=1; AL+hErFOXEDKFL62j3oceq5c1fZqsGocmOP7V2zlDmPD2iQ419JR9AVE3brxOBdiXxNIkJkJ/84=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9YgRss4LcLnRPzOwmz9eEb2YHe6SqpylOIdqCrpZN55ug+toB
	/CvGLgwXVr3jZkC+D0CuHk+v3yPpJwllUOxvuoZT8c8GNQ/AQms8CT7F
X-Gm-Gg: AYBFou3GPg2eLOpTK2na/ZeSxA6L+2WuEw7TcBifo4sfIkrHsXp5380oJYIvvQ/B8nd
	tpQ7WwTGzXTXR4miq+tfU2St2br57u6ecNeVF2ggP5AGjpOMroT/6TqwtmN8Vk+Jj+YYttRHJqn
	dE+StRyMnXFcITkw97iIONoSywDdZZh/ZIzYakV2ckhYYRPxNQEyFtGLnRxSrtDl4Jp8ubv/lXw
	1zPicH2IOheQ8LyjoyI3ECspnELmKAxIN9trCbI191lfRFUlRN6HREOfvolaFxSMk124i7ABloO
	Ze/Zq5k6HjtU8GqoKF1CFLJYUzSd3l+czRXW6C7ifqYpqGkNElvM1Zlor5pVJanP+q7fFIdwn9+
	xl008z9GYQLGaQAE11QlKvNsle3d58oReIzsv6F274GVUWgWv1qzxHQ/DiLiTEiZhv0goUm1CMW
	xaY5k5bnEonRCbkjoDNynoIuhgmsU9stDNVF56yEP6wZgXdhej2/Dj+yjYj/8IIJzRET5Z4RbhH
	AfAL/FGYNydS/wIwVQ4/+z74PRs1f5UeCLL5oibakmqFfajXDEghhI1YwR4g8+Fcscu2u2usROg
	+O1DWHs2a0k3ZHNlGdHWVDBeJdUyUIPc0BSCVomldCZ6Drb3plHjDwy6XdaVWmwRbulo4sbLIrz
	ErpxHJ0oIFuizlij3lZFE3d3Y9C3E3GzdFQ==
X-Received: by 2002:aa7:9063:0:b0:8a0:3ed7:93a7 with SMTP id d2e1a72fcca58-8beb6396804mr736741b3a.32.1794517025098;
        Thu, 12 Nov 2026 12:57:05 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a7edbsm134654b3a.18.2026.11.12.12.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 12:57:04 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 20:57:04 +0000
Message-Id: <DMTJ704LM94F.W2LQRVNGZAJJ@gmail.com>
Cc: "Amery Hung" <ameryhung@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Nicholas Carlini" <npc@anthropic.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf v1 0/4] bpf: Scope callback arguments to their frame
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261106231157.2840635-1-ihor.solodrai@linux.dev>
 <2785198b-ca41-4cee-9dba-bc0c1e6e8f25@linux.dev>
In-Reply-To: <2785198b-ca41-4cee-9dba-bc0c1e6e8f25@linux.dev>

On Fri Nov 6, 2026 at 11:32 PM UTC, Ihor Solodrai wrote:
> On 11/6/26 4:11 PM, Ihor Solodrai wrote:
>> [...]
>>=20
>> Ihor Solodrai (4):
>>   bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
>>   selftests/bpf: Cover the user ringbuf callback dynptr lifetime
>>   bpf: Scope the bpf_for_each_map_elem() array key to the callback frame
>>   selftests/bpf: Cover callback-frame map key lifetime
>
> Alexei, if this lands first, your pending verifier rewrite will need a
> hunk like the one pasted below. Or the other way around.
>
> Without it, a join can link a value to the wrong callback frame.
>
> diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
> index cc4494aef187..92b94e18c873 100644
> --- a/kernel/bpf/join.c
> +++ b/kernel/bpf/join.c
> @@ -464,6 +464,9 @@ static bool join_func(struct bpf_join_state *js, stru=
ct bpf_func_state *fd,
>  			return false;
>  		if (!join_loop_stack(fa, fb))
>  			return false;
> +		jid_note(js, fa->frame_id, fb->frame_id, true);
> +	} else if (!jid_strict_ok(js, fa->frame_id, fb->frame_id)) {
> +		return false;
>  	}

This and your other set no longer applies. Sorry.
Please respin them both as one set against bpf-next.

pw-bot: cr
