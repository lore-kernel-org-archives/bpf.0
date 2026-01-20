Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F09C2EC560
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935101; cv=none; b=Fc6jByuWw4sEruujsLWuHGwqY12YgOmSy8/e+M47uLYrTtTnuZnh64sLRlX9plaP1QZo5dYnyYt9tffKEREEyFZY/p7pZa1xDyBNHw7+VYnnYOdCj1BIO2FFxlOOKaIdqPmLVAptly4fbECRjR5jdczpcj5/+xAKuHV1W1BNT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935101; c=relaxed/simple;
	bh=sDgTp7IkPT0uFGFX/Gd6oobYQUPpzuCRi8oJc3BybSM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=trwyyWOg/e64RGu0sKNq9O4d7JMoINyex/EfIb9by7LgpvtnP0QeI1XMcjF4pybOG/hQNxJWYIbnzXP2dcP6H6YPBdXOVIHG54wpjd4NAq8cRt4xFy/MqYDCRouFeU5VLtIRAUsNgOIEE11aZkNtmrdZCRiTF5vyYW8ZOkfZnAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7iLvxfy; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7iLvxfy"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b453b17e41so91388eec.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 10:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768935099; x=1769539899; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FQgecD865lAo4vxm8hgDCvY/P8AjLOIXd+ZSv3+0nTg=;
        b=P7iLvxfyt2O47eHl5O+Y/YtpVhzzou+J3uMkj8YyfJVxAQ2Ow4pqNAaA7cN6EN0K1e
         k6EJ9ggBOXQFNMIZUPAJJt4yE9YUT8BFmWXQxzulbr1GL2aIjq7xvq5sRNEX7Umv/9TU
         PHxV8viGSz4l4fBHEZtWRLeSS4r9df/NVgmktgzQmwZHv9eycwG/FoVb0vv1yyjoumwm
         Dds7D6WRyEJb/6Ze/U4wY9NkF3grWzBoTuEzw7ximaLlMaKyKUvLO4hEYQkmts3VEp8U
         ZYCvjBomNC1zTTZOsXGxxdTaJ88YuyPB3aBw+10yzVdV9Yi6MO6/Wm8saBBQieXDrsxv
         WJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768935099; x=1769539899;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQgecD865lAo4vxm8hgDCvY/P8AjLOIXd+ZSv3+0nTg=;
        b=j65XIsvD2PP8cxaYHsdycd6+UvG6e4/KtGpwESxIz0FDvQbbCo+7wJWLcDOgRqL+Hb
         ZIiWq8i3JZHQRmOo1eiEnmCahtob8HlZONchTT5wnBP1sy8L/dUoFlYI+iCwJk1/GcFY
         rsTJ3TQjMZqpFLj4RoSPHvBBYZSQOUWcScz+ty+gw2WqEX5MVbT6EVyHD5IFvc4f+XAE
         Z3IHb4NIHeJ1WiThoG2tgUYQ8o/mvQbWsLdwl5m9NdkO7FiMfWMiIbkepfeGxwtsdzbu
         DqTi7US8wLP1NDZOldy4zEf9G5u+xfEq9Cqg4tJ2GsUT6O7/8MvqpjbT6dYpuAmOkMMu
         rLGg==
X-Forwarded-Encrypted: i=1; AJvYcCVCGvKe1MppkYbvfQix6+j7wHmibuZARlnSqJgdA+sUcywUZI67Fxpjs8wXB0GoySbavJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0r3ctQHWRuMxTTzOHTPJ4tgJfukvP9qUB41vcEbZYHzfYY5wE
	1s/D6yjiLof0ti0k/Yokus8m9LXRcH83x0sJh9nErNOmHelug0JVoR/KpbxyhQzO
X-Gm-Gg: AZuq6aKu0P3kiZe58wP7eYqlEAzRXY9S1lZNsgA2HTfsfvv84ggmsawgCAj+raW7fXL
	amldJNBxeRA4xeENTytTVHvb9TiMweCd8c1HSBlvGOFz5GF7EPOCVEAD0K9tFbVMqHUV0UH5d5f
	1nCKSau8VcYLAZny2wzmezpAOX25Axl0sOyGrY9xgi7BVGSoNCpvawRE1L8xT1Zp2XBqg9qezqG
	NwavKvIqRhxynH09IWujy1UQTkHxfH+qAnKzPxb5vX9IVGjbxmU9yDv1pPXyl7cVT6/9y67Wp00
	QzQlLkuEpIWz1q24yzVlre39B/ukTxytyqSe2ueoshPjPZS7AtKkn/KhUF5S0MOQ0n8yokH2EKP
	QTWQhRGIT4tCLzH2HAuPJu32m+d42vzasMyLZwmK1dU+IeFunokh7E3kw1sU69RDYSLXsNyGD7p
	Kmzhj7BA7cEdi1awUMksuALOyyPThmsw9DcOq4XQwijLoOU2Q+5xCms706laEsMaXdRpDnmnQ2Z
	VpVeoI=
X-Received: by 2002:a05:7301:9bcb:b0:2ad:a3d6:7446 with SMTP id 5a478bee46e88-2b664323897mr15995490eec.16.1768935099156;
        Tue, 20 Jan 2026 10:51:39 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11c4sm18031117eec.1.2026.01.20.10.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:51:38 -0800 (PST)
Message-ID: <57dbe0b62e2cf0370f90825f9508c466cd673704.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Add range tracking for BPF_DIV and
 BPF_MOD
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn, 	syzbot@syzkaller.appspotmail.com
Date: Tue, 20 Jan 2026 10:51:36 -0800
In-Reply-To: <20260119085458.182221-2-tangyazhou@zju.edu.cn>
References: <20260119085458.182221-1-tangyazhou@zju.edu.cn>
	 <20260119085458.182221-2-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-19 at 16:54 +0800, Yazhou Tang wrote:

[...]

Hi Yazhou, Alexei,

Sorry for chiming in late in the series.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu=
.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> index 2129e4353fd9..4d8273c258d5 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> @@ -173,14 +173,15 @@ __naked void flow_keys_illegal_variable_offset_alu(=
void)
>  	asm volatile("					\
>  	r6 =3D r1;					\
>  	r7 =3D *(u64*)(r6 + %[flow_keys_off]);		\
> -	r8 =3D 8;						\
> -	r8 /=3D 1;					\
> +	call %[bpf_get_prandom_u32];			\
> +	r8 =3D r0;					\

I suggest we special case `rX /=3D 1`.
Maybe in the is_safe_to_compute_dst_reg_range().
This is an old trick that might be used in the wild.
And optimizer should remove any such instructions when compiling from C.
So I don't think adding special case here would hinder verifier versatility=
.

>  	r8 &=3D 8;					\
>  	r7 +=3D r8;					\
>  	r0 =3D *(u64*)(r7 + 0);				\
>  	exit;						\
>  "	:
> -	: __imm_const(flow_keys_off, offsetof(struct __sk_buff, flow_keys))
> +	: __imm_const(flow_keys_off, offsetof(struct __sk_buff, flow_keys)),
> +	  __imm(bpf_get_prandom_u32)
>  	: __clobber_all);
>  }
