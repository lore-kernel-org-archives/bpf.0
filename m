Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C7441048
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979459; cv=none; b=nS3F4bI2BP/eFTV9BgpN1hN+6xhiFejNL6HVg58B//KMKNyQApfjvbvZYpBXdy75hX0fG3TzESSiFX6b5t8gmzp9DHQgVJ0F7tbxbgG023DYeWNOfF9ByPwVIC0M7AkfZFNiuhI4xtNpYdRMagxJRwdwWPFjSgBexLXFyx94Mw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979459; c=relaxed/simple;
	bh=vyqjmHbzGT9/NMRea5kg7rnFU5rJExDxfDVl3Z2LR9o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uCbu0kDhkngkb68sPNPCnv7laysRGMeD1466g+c63aMGc5bAVgNxRtUC8t5jt18H9V7XNnF9sikw9NW9JUjHS6wN9x6dTVRcj2nNgkbgW5SSMbZMTIK852XEoojX2pTVCYqrptd6IvBDUjWhwHNp6Bhgf5o7sPEmyHnqzs6VB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COENj0ty; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COENj0ty"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c757a9251faso2336951a12.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774979458; x=1775584258; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v5iG3uF4phLJUqmslcwf6Mn7DKllp1JowzxrcVyo/do=;
        b=COENj0ty7Tn7ocDY5Q6Q4h/XIJB3Zz6FJazMW5F91tKZLR2Xrb/ql/NlOaAOeEZoQK
         pjEHzz2yS118fXOJlJhFzxem1WEpN3pljbHHuiUqv1MJakjbOlsh5Kfw/C3yfqI0Z9WB
         pWCOyxdNvaho0WzyUNVt7WWr3DDuYqmwCvcwzfdsnWLq3aeaV4jiUgmcbDXcsF36iMUb
         Sf9YFpiXZtOrg8j3XDVEebUo0nXExSQv+Pcf16irB2ddM4xJzQgqW42FxattbFCm9ivR
         POPG+rFvrrn7ncrtNktPe53md+7iAfL22l19sVCuWeX8k3UYBdt4L33nsa1Z1hABJUG0
         whlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979458; x=1775584258;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5iG3uF4phLJUqmslcwf6Mn7DKllp1JowzxrcVyo/do=;
        b=FDw4iQp9GAjEiNEUvKD55CbSakdEIf5P5tC6M7YgcvSm4y2inw9o6H4l9mac6wb4Vo
         juX++ZqJiM37duPw1P6HUBHNqNGwsJE+VSZVwaLRnduzB1DZLUAgEhnX0el5VfQAdtZ+
         zRxWACHuKkfUzU78FLraUza382zf5SJxki5DyY2XmxnyO2SYZRHZP7x3mpQ5RMb4DN2P
         u3bTnTNn/DNS1wPEKM6qhupBTJls6ImeAkV5mEKJwWC+YOSnmb7SW67SQSIDGqbsznws
         4MXFBk0+5sxX4ceTVQFN86mquVZCUXvlGyalOTRFpr8oT7coxysETUO5vN/q4o6Tzdis
         DW+w==
X-Forwarded-Encrypted: i=1; AJvYcCXqmle8w1O1Td1A1/fwJHHeReTSk0BVT/9H3bf58X4ieQaLKXAa47gJi0bI2MEWpDOeRjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZjql16O5y7hpdTovKRx36xsHLUz5zULIeoRNSsUcEBOnx5J0
	2UNx97mPJGFulcHTw0huJJVDQ2rrcwIGG/GZm2OjwsYkRlZqv2NxN6p3
X-Gm-Gg: ATEYQzyXgcTsdUXdu737+hkCeg6nu1O93f4CZG2oncTvN8qitEHAkBjP4yjRFs5qBA8
	FdI2HdeE5Zvdvwgz3mx0nMzJAo2DiJySyBdQKdZqktlpSAMwfd5dhyYPCbd8uyIZqRYGHpgNZ9r
	eEQeQl8gEqcnZG1gInjzytRoy2I377dwSydhSyF9YbGkDM3HJZWeYWH4BU4G9IfmjMxd1k//Ci+
	ITlgEvG5aTKtfvmu5+PKZZRn5WF4glRSQQ/MsQkumTpPf3TZ7WebsgiFlp4h99/43m7IIOtT7xZ
	M7M7mlKsfU7s+1M8rttGkiXfklOO02Cs4jWIvTwJOEx1Sw+QNsekihh2voGce919+DMQeKaaC6Y
	FOwoZepIu9DG1Ba+zG5Qm5iTATmxtmwPyHIy3cDBkQwTQ/cKfbe1fl1KBsl9KGeXFtQ2sY29rhG
	QawmxVa9eK39Fsthj/635bntRH3jwuTlXfEUXJtAH4Erech0q2QzPs
X-Received: by 2002:a05:6a20:244c:b0:398:c2d8:153 with SMTP id adf61e73a8af0-39ef777bf0bmr158611637.56.1774979457855;
        Tue, 31 Mar 2026 10:50:57 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917db770sm9256192a12.32.2026.03.31.10.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:50:57 -0700 (PDT)
Message-ID: <9594e5fdeaae8f81edd3b73ff7e263c535d74c7c.camel@gmail.com>
Subject: Re: [PATCH] bpf: reject direct access to nullable PTR_TO_BUF
 pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Qi Tang <tpluszz77@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>,  John Fastabend <john.fastabend@gmail.com>, Song
 Liu <song@kernel.org>, bpf@vger.kernel.org
Date: Tue, 31 Mar 2026 10:50:54 -0700
In-Reply-To: <20260331172720.29938-1-tpluszz77@gmail.com>
References: <20260331172720.29938-1-tpluszz77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-01 at 01:27 +0800, Qi Tang wrote:
> check_mem_access() matches PTR_TO_BUF via base_type() which strips
> PTR_MAYBE_NULL, allowing direct dereference without a null check.
>=20
> Map iterator ctx->key and ctx->value are PTR_TO_BUF | PTR_MAYBE_NULL.
> On stop callbacks these are NULL, causing a kernel NULL dereference.
>=20
> Add a type_may_be_null() guard to the PTR_TO_BUF branch, matching the
> existing PTR_TO_BTF_ID pattern.
>=20
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:bpf_prog_5f0e2be830ac3243_null_deref_iter+0x10/0x25
>   Call Trace:
>    bpf_iter_run_prog+0x1c2/0x2e0
>    __bpf_hash_map_seq_show+0x120/0x180
>    bpf_seq_read+0x29c/0x530
>    vfs_read+0x179/0x930
>    ksys_read+0xef/0x1c0
>    do_syscall_64+0xe0/0x1290
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   Kernel panic - not syncing: Fatal exception
>=20
> Fixes: 20b2aff4bc15 ("bpf: Introduce MEM_RDONLY flag")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---

Hi Qi Tang,

Could you please add a selftest for this change?

[...]
