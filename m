Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EBD2EBBA4
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843746; cv=none; b=tgCtS++K26V/xP691OM1+o076FL4faiovYfuANWvslZAgWEcu+6DkDbe7B8qQ2g5JsmKvN4DXmhthq0JnrhBC9DDcfTGgo2LkbifKIzEVb+cF7PRyMaglOUhJ6an0Px/ZzCXCaH97u66GsdI4KTbZuOS+cRv3G5CI10697PSlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843746; c=relaxed/simple;
	bh=UbGOokGAnXJLZUPwl0DTCYBrKplpTx05tiMuCGVwFRk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=h5uOTjseVjHS/qEbnJj2cFeA7VIf5VG1+zjflAyUcHpveaIYcdHe1CmZeaZLHFLD7RbP4/pWyOZ2PXnzSwMIC4ZIk1/iM9pRbgIBGkO/9iMsd/yGPh6oLSX7q4kydkc7lKec9i76jqOlGJLFtqo3psnTgk0sS0ShFPI8SunLacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=uXNj1f1g; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="uXNj1f1g"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12713e56abdso1591866c88.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775843743; x=1776448543; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks7cbw3kYEmiR6nY/nHBGNhDGsKuJ139vFHbAstCWH8=;
        b=uXNj1f1gmtiSFMhGKpciv9/mUjkWa7MSY0H524uEVhjdT5G4lioSUv+p4QVpg7+hui
         zaP8Ek65N4N6OXyzZtuVOj2PIlNfnenOxEMqwlfvGgZN/yLX4icKm3xAkmVsRB6GfIS6
         SNYM9AgYs9Dtea+a/1FE2hh8LIC5pu3902zFK8R2wa76UmgZuTROYf0G7yw+1CkKcp8q
         7sS3oaJc4NWS3KfDghAZflbqG4yD5rfiZIGFQ9Zou0Ns9BcaxDhw6cZyewdatvOC/W9E
         6xrlBPckmKZCa29QE61iEvERVNFtccDovM2q1/j9ubVziqfGWtE4TNUfcj56dcjSshpc
         wmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775843743; x=1776448543;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ks7cbw3kYEmiR6nY/nHBGNhDGsKuJ139vFHbAstCWH8=;
        b=GykUy5NU9jshc4oDtE4sf18H4gFBwtSPnHcHC+zjtDiYcSggR8FWhrJKJAYayu2Mog
         pOlRM0UOJwfx4ZcfPm+aQOwzVDElTpoQ/srUa0xRqJOIsv8ImJWtYynZXK7pLVm9gLBh
         usJxa5u/GyMGZkWYDN6Ooj33Kmxh+cCFUgiFSeihgzgDTWiM1EeceWc5tfCQoIbQkUmb
         QqZr0mtMnK/qNAK8Ty87Ffs5X5G9tavuskAYwVgbLhNFQulJcYShgNYpbqMAYvr8Fg7H
         DbhgYMLPanpbZd3LE8JUHs7TwBzZkn5ZxbQ+Ifb/cfnxRlcn/ivf34GxcdVWO5jaVu8J
         /T8A==
X-Forwarded-Encrypted: i=1; AJvYcCW43kS1olZgkYeuZ8L66boCJUV9cjzOzWiU6vYKXgGUH4Il8SmyrtuNbjT0zlNkMHhf3Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4D1oOlFKPU6B400BItzjb/UJUH5TW/8/OBxXog/PPXfdf8PWa
	yFYPOL5k/Z4U0+y2jdGxlxODG3x6t41/glNwvG0c7ZMPA5J32qq1srmihyWTeAa6FU0=
X-Gm-Gg: AeBDievZLlA/hjVb3OwgrQiuChKDn4SrmchjK9IqTcdJ/oF4c0NR+bNgzfwWyb2T3f/
	EOwYeTQoo2DIRDt58jDQXXpTCXHWjKA1MWaVfzS8qkMJXBJUrUU7oGd5CrrUCfTlktwOzGuNpYR
	0Qp6gCzpEw5JEurT/nYk0oYI2jE+XCxgd7B1Y7M5bdXYBf0SKLcVNZxblRy2b8kcJBxRt41R9WK
	x4aMfy/fkr6eBbFbhH1mq0RcJUbfhyANgn01byxySD4uV6Lz9rqS3gJV7oDMW8nJwLXK5gbV0fQ
	bvkDXj1Y7h1UigDnpeZhJ3C1y3jNZ7CUJK1RhIhdw5JIr5z+kjBN+3ZyB9VKbe2kfLZ/7Z3mDpE
	oMXfVj/CL1De8zXMPX54lIF276hBM8Xqur8zEeDo9LiXZRcS/UboehKHE+nYPSU8oqJYh+vzTSA
	e4wWKj
X-Received: by 2002:a05:7022:ec2:b0:12c:1288:ce63 with SMTP id a92af1059eb24-12c28c2953fmr3535497c88.13.1775843743428;
        Fri, 10 Apr 2026 10:55:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::df61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2a4esm6550822eec.16.2026.04.10.10.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 10:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 13:55:41 -0400
Message-Id: <DHPO2G9QEDHI.ERBXQTHDKU02@etsalapatis.com>
Subject: Re: [PATCH bpf-next v5 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on
 arena pointer addition
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260410163041.8063-2-emil@etsalapatis.com>
 <44b371bad4d974ab7a780fde68c937820201144e17e2b5a26e908dbffae19f4e@mail.kernel.org>
In-Reply-To: <44b371bad4d974ab7a780fde68c937820201144e17e2b5a26e908dbffae19f4e@mail.kernel.org>

On Fri Apr 10, 2026 at 1:34 PM EDT, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 9c1135d373e24..6c5721434bc4b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -16655,11 +16655,32 @@ static int adjust_reg_min_max_vals(struct bpf_=
verifier_env *env,
>
> [ ... ]
>
>> +		if (dst_reg->type !=3D PTR_TO_ARENA) {
>> +			/* Can't do arena arithmetic with non-scalars. */
>> +			if (dst_reg->type !=3D SCALAR_VALUE) {
>> +				verbose(env, "R%d %s R%d: Invalid operation between "
>> +						"bpf_reg_state types %s and %s\n",
>> +					insn->dst_reg,
>> +					bpf_alu_string[opcode >> 4],
>> +					insn->src_reg,
>> +					reg_type_str(env, dst_reg->type),
>> +					reg_type_str(env, src_reg->type));
>
> reg_type_str() returns a pointer to the shared buffer env->tmp_str_buf.
> Its own comment in log.c says:
>
>     Note that reg_type_str() can not appear more than once in a
>     single verbose() statement.
>
> Calling it twice in the same verbose() here means both %s arguments
> point to the same buffer, so the error message will display one of the
> two type names twice and the other not at all.
>
> Would it work to split this into two verbose() calls, or save one
> result to a local buffer before printing?
>

Ack. We can just split this into two verbose() statements.

>> +				return -EACCES;
>> +			}
>> +
>> +			*dst_reg =3D *src_reg;
>> +			dst_reg->subreg_def =3D env->insn_idx + 1;
>> +		}
>
> [ ... ]
>
> This commit fixes a bug where the verifier rejects valid BPF programs
> when the compiler places the result of a PTR_TO_ARENA + SCALAR addition
> into the scalar register. The bug was introduced by commit 6082b6c328b5
> ("bpf: Recognize addr_space_cast instruction in the verifier.") which
> added the original PTR_TO_ARENA handling in the verifier.
>
> This was also noted during review of the v3 series on lore, and the
> Fixes: tag was acknowledged but appears to be missing from the final
> version. Should this carry:
>
> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the v=
erifier.")
>

Not sure actually. The original patch logic was overly restrictive, but
it's not like it was broken. This code is more of an expansion than a
fix imo.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/242540=
55723

