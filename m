Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B49480DED
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450878; cv=none; b=rURB8zRx3qygzAk9N4HWUW1Lrj7nqPK2pzze1oLTEJDVZUKM1yqkNeNTbUNT33D+cutJYbb11+ZSfvgqFi5G3ueC0ROeNzZyjfksGG9r7jAe55e4zzRmKyzf2fWgMd2e8E48ZPdY5wy4a+p77FiuyzsSQc7nAtdVH7fWeTXg0Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450878; c=relaxed/simple;
	bh=SkwS1obEXFRQQvMZKWNRCoBrZa5SCh4GtHmEQeCBxC4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C6gWeShzACe6e6hSVefw/96JAL/CDfeeRNoZoQhjcSrymdYfZTVlD5w8J2wW+x4T0hGybuu+TfXU2LzOaGinYUTiArYd2BVAfEkfmypcJoaw0a/+GyU/ZAzUQGQOyz0LuBDyjK5W2e2xlX8ZDOU44xvhuJuMAk33XhkFMhIhvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtSuaMVL; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtSuaMVL"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499c930cb9cso88435e9.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788450874; x=1789055674; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D8VbwdlqCQxfdIZO7e9acFweb5EzcAb7QaDyJJVU6kI=;
        b=VtSuaMVLsT+uzmwqffKthFYg7e5jZXxSURe8c8eYFe6NRYnw927+Vwjm/VLvxM5+1H
         lSXZ3PCIdfBkRA2g0nKdjyk8aOibJgwb5mhymNt9asXc9+txCmMzlatMsRWjKu11pg3t
         kE/4HOu3SB2kP4bAVgYxzCal4U3+fOkR6ggqmTsO1G83dZQZ7slnoENCjyD31QT6b3Mq
         iNTD5iMkenIFH/Fls8QMsraGu3PP+LlIjv4PPf9tjJUMwyz9eXNNrpPRYdboAAqacZTV
         dWxigqfmsihsSWyU6lN2oTbWTwiJupyl1z8CLzx9mfdyibdWnJ2/Umsu9DAlbZWwckWS
         igxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450874; x=1789055674;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D8VbwdlqCQxfdIZO7e9acFweb5EzcAb7QaDyJJVU6kI=;
        b=N5cvTRW2urskmVvR0VjL38KlNe2yZkuC4fLwrk+tO51aNQrGbJfdLbpHyPMTFfLvus
         jsoBTVQ+nsThqMxdVjhM2lUcbvHNm86iMsdh9ktR4fhQkCf0uQFN5zYdEqZZIXvEib0B
         r0IeXhNu6atn4dKX8fA3r8wtSCrvC9R+0i7CTiwqpb5sNZI3StuCFoRIHE3fHkuUS0rK
         xSMpa4eCyF+6S3LVYFh2va+Bb+JQgv+9BHMuHx8OUZVeqevje2MyfNyqv2JbRax5rzPG
         2TNXZCHMF5C7sI9HKnNgqVbjST/gvE9bzY/rrCzhukTj1f9fBQ5rN37ihR8QB+kd4jZw
         noFQ==
X-Gm-Message-State: AFuF++k8dCOrcD7tBoDLGjqVmR8z0eEBk2Tr7eiU1AawEQKtCZ1GXy2G
	QkK6h8GFYfRZ3KKSZjSR5b3O2hfAGGrjHtxkMOlP5VcKXPHjQuQIRm8r
X-Gm-Gg: AYBFou0QY5hm0KjdkbYxrVNcQoF2dSmBFspHPHP/C+DJMLXmLRCwwVSEOauc4xcPVyi
	sQgNTgVYuQsox5fQ7LYyxJgITMIvHcQAMErifCS4bDBZkPuycXzebvVQ5D/uy5DWwsxSTvN1LfG
	HgfZffJlItBL3uwRGmTL2R2vtKruA7vJBZapNGoxT1qkmZ4J3gNGDfmqziYvSXo2O6wLTmRtbVh
	UtPvohTOCMDHqg3Sp6yXaUvXLdoDpasbbfOLWni0ZcY+CUtq201MQwxTCZuEYuZ4Oh52r62EmX1
	ndUxsoz4UroIOqrG2l5tEiud2r0YcY3yyNc6ooVKc+1o4C1E/8MA8lvJGIBnWE8PggbdaRqn6SJ
	A1ErbNNw+KhWeCKF7Z/8FbyL0Dcq0JujpyZksK5DOhRZjRusXrxKxQ+y7hrR1vrG0KxL3fikyg/
	32Jqhb87oI5TM1uqDds5tNLSqk1kWnglfXyD5JSBhVQd15vKD4IOICqlg3S8mvJ3ACkewOPX2Am
	OA5g6u4mcY76REyB4kUYGF5EDIOvZwXHp+ocS6ftrppkHaKRkGTIOKMVxPlzPCcOlCN7GpAZFU2
	nMWZujPZawoEPfvTF6QlaDhmCmQ=
X-Received: by 2002:a05:600c:4692:b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49ce57f569cmr198422585e9.2.1788450874124;
        Thu, 03 Sep 2026 08:54:34 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce591f846sm61152355e9.1.2026.09.03.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 08:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 17:54:33 +0200
Message-Id: <DL5SX8TPQZ4R.3TTGUMLHYKN4Y@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v1 09/10] bpf: Mark syscall helpers as sleepable
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260903144433.1716731-1-memxor@gmail.com>
 <20260903144433.1716731-10-memxor@gmail.com>
 <20260903155150.D57251F000E9@smtp.kernel.org>
In-Reply-To: <20260903155150.D57251F000E9@smtp.kernel.org>

On Thu Sep 3, 2026 at 5:51 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] bpf_btf_find_by_name_kind_proto lacks .might_sleep =3D true, all=
owing arbitrary FD injection via softirq.
> --
>
> commit 1d16e876066d61c09bcc6698ca694cdf8336d52c
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Mark syscall helpers as sleepable
>
> This commit adds the .might_sleep =3D true constraint to the bpf_sys_bpf =
and
> bpf_sys_close helper prototypes. This ensures the verifier rejects them f=
rom
> non-sleepable contexts, such as bpf_timer callbacks registered within a
> BPF_PROG_TYPE_SYSCALL program.
>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 6874ba1424af0..c7bc9ba9b331f 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -6568,6 +6568,7 @@ EXPORT_SYMBOL_NS(kern_sys_bpf, "BPF_INTERNAL");
>>  static const struct bpf_func_proto bpf_sys_bpf_proto =3D {
>>  	.func		=3D bpf_sys_bpf,
>>  	.gpl_only	=3D false,
>> +	.might_sleep	=3D true,
>>  	.ret_type	=3D RET_INTEGER,
>>  	.arg1_type	=3D ARG_ANYTHING,
>>  	.arg2_type	=3D ARG_PTR_TO_MEM | MEM_RDONLY,
>>  	.arg3_type	=3D ARG_MEM_SIZE,
>>  };
>> @@ -6593,6 +6594,7 @@ BPF_CALL_1(bpf_sys_close, u32, fd)
>>  static const struct bpf_func_proto bpf_sys_close_proto =3D {
>>  	.func		=3D bpf_sys_close,
>>  	.gpl_only	=3D false,
>> +	.might_sleep	=3D true,
>>  	.ret_type	=3D RET_INTEGER,
>>  	.arg1_type	=3D ARG_ANYTHING,
>>  };
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does
> bpf_btf_find_by_name_kind_proto also need to be marked as sleepable?
>
> Looking at syscall_prog_func_proto() in kernel/bpf/syscall.c,
> bpf_btf_find_by_name_kind is also exposed to syscall programs:
>
>     case BPF_FUNC_btf_find_by_name_kind:
>         return &bpf_btf_find_by_name_kind_proto;
>
> Because bpf_btf_find_by_name_kind_proto in kernel/bpf/btf.c lacks the
> .might_sleep =3D true constraint, the verifier will permit its use inside=
 a
> non-sleepable bpf_timer callback registered by a syscall program.
>
> When the timer fires in softirq context, bpf_btf_find_by_name_kind() call=
s
> __btf_new_fd(). This attempts to allocate a file descriptor with GFP_KERN=
EL
> and injects the new file descriptor into the current->files struct of
> whatever arbitrary process was interrupted by the timer.
>
> Should bpf_btf_find_by_name_kind_proto be updated as well to prevent this
> cross-process file descriptor injection and scheduling-while-atomic issue=
?

Yes, this also looks broken. Will fix after this set lands.
