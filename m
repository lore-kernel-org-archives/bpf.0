Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8BF3502A9
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201513; cv=none; b=TtkdnoRnYvnIvmEL5JXlOKM0rn941KslVZsTd/3k7uBs0MECbOYFcNIaNwJcaKl8uKtVOLd7fZ/SVjY1hJJZgpV2hdki5lKMFiYF8nOX8Dv9OiKJTA6wOVYrUPCm9/GCBCJJ/Bl2yjsx334Mon4HUYd/RKwza2lSh4jK+Ho0cXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201513; c=relaxed/simple;
	bh=sGex/JtTk0jOQ38eZT0kslFT80OGgFCCaKn9KlGVl/I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X/f3rcN292cs833pOLJkXDYmTDlqbHrc9RFcVaYML8bLuGCHx0azf+1JKs1G8WzBFlmMyKEM1euGLvFSMrxJpCOde0GNQttQ4xoNqOUUOm43d/0rNXxTlbkBEOKWcSfHeS6tbccf4kjbFi5NZJbiSAmi12t6/qHv8oHLiPMVpdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8gGi/bX; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8gGi/bX"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so26369095e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784201510; x=1784806310; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gZCQhVXkUWTDzM8gJJA9BBZP8wsTQOpKKaJUyhI6+CA=;
        b=k8gGi/bXHOxrYjd/dI940y+MLB7bQKIInpk0MS3vIGv8DdM89EvK61/U5lMjDPc98Y
         nZmqXY8tAWhVWJk/k2kC/s7fkpyOggz3Mo+IayqPFMdI64tNLE3a6ekIVc/ZGBNUxhN2
         lYKHYNAqr0SDFa89UTaP8OOFIMKSa6bRAu9KPPSMI6qSwOx/wt4e4olBj3oEzPzjiQry
         VlVt1dbBrIWHJKUSxPlbwxmzZfupHDJnwsedqLjUTk0Vj7QLlv2Ymid65HaPzATaiZsS
         1wgubMW+FHyLUnEynCk0ii9C4/+Ep6qOqhyi4Pyo4BjcTqO4/xShGiEbE73H9TGqNUjf
         iGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784201510; x=1784806310;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gZCQhVXkUWTDzM8gJJA9BBZP8wsTQOpKKaJUyhI6+CA=;
        b=ogwdAiAml6RWvJUSCe0IPqZ25ubvLY18ZJxZBqfhTtsxHYGvYatSwg+TTjkrO8RPEE
         BjtPvIvS/0GZa051193ZXyF2ZuQU+cB8hibxUKF7HnIvIn5YPnxSVfweCF1bFSNP/Hll
         WjhpIfkKmol8S4ucPPOYKxzLqKiDNyqdvYN2evZwZpxTaYYtkv4Yyqy2EISHPq6RfyTM
         PxF5FTNRuB6S6YIjc74YHdtLvCzLjhj/uzhvmtJ+avunDQjaYqcnLEdy9ILWDIG5e9Uv
         tRYfzh0Qcf9xXKvh/xL1lIcMcJH3X2oRCmIxmdyqdMk8YFKwielwnOW35FxKlwYLIDoK
         Z44g==
X-Forwarded-Encrypted: i=1; AHgh+RotItzGHW+2it1ClzbXP4DcU/wBcHvpsJflq2743HuzL2kBZIMCDaodixGezwrBM9l1W50=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdd+TzIqh4MIZLWVZfeF9I1afuDC+EKrAyUqV4TSqEf51qSzQM
	eg7NZLQCqTLEkDyINed4aPBSg4ACd6bfM/tqQhW90WIjZ8DHr5hTxXN7
X-Gm-Gg: AfdE7clAUcsKWSGHmKRZE16WOw5sXSi5URTNNjdTzbN+Jv6YOeQ+0UWeU8tbcLC+E0f
	FA40g+Puf7t8TkMidKYq3d/O41viK6r8ihlKMvvCucFRaWgavmn4C9Wl6U2fSqWtqNih6lVRryl
	VtDwxj6fYb0ijtjN+71CB4UOZv6e1UxNx8xtH+izmpqDMa2fpRu9UmXjkIY2G6bHqelcJhiCTwU
	iy2jOjG0boN1tGVyRpj6vGKY/vRBrd19heBDNkxjPrXewvZmv/dkGD5uYJKpkB+veEVbZ46Kp+o
	nspe0r+hbxjAh9dA5VMsZr/uj6/Fg4vcySahz7amOgyX676zsi8hTjD8W/HmbOkiMnoBRgPkBnG
	vuOnrO4LewBshUYYQVn+uxlg9X3J8ZdTmoxfs9qODNRWj+c6/3nlZCxcxtnbnN0lucVW4iQkRpF
	JAJZNIr8pHISnb4etK1pnIefCesva2XIfDwZTfudr0NKtqmPmDqP8u9ED9qYGtImFT8WrtlMQAt
	N3p54TIBX+nDc1QhbFbKk/nURBNUjHC0JCVV930Fh92
X-Received: by 2002:a05:600c:1f91:b0:495:3f84:a792 with SMTP id 5b1f17b1804b1-4953f84a866mr50112875e9.12.1784201509478;
        Thu, 16 Jul 2026 04:31:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9425asm85411405e9.11.2026.07.16.04.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 04:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 13:31:48 +0200
Message-Id: <DJZYNDFLW8ZJ.2XCIK1AVCDHR@gmail.com>
Cc: <tj@kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Support __arena and
 __arena_nullable kfunc argument suffixes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260715220052.1590783-2-memxor@gmail.com>
 <af44252e506d749246d5f7593468acd22dc8e9968f99566e43476f4136869259@mail.kernel.org>
In-Reply-To: <af44252e506d749246d5f7593468acd22dc8e9968f99566e43476f4136869259@mail.kernel.org>

On Thu Jul 16, 2026 at 1:05 AM CEST, bot+bpf-ci wrote:
>> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
>> index c801a330aece..a980266ec788 100644
>> --- a/Documentation/bpf/kfuncs.rst
>> +++ b/Documentation/bpf/kfuncs.rst
>> @@ -250,6 +250,33 @@ Or::
>>                  ...
>>          }
>>
>> +2.3.7 __arena and __arena_nullable Annotations
>> +----------------------------------------------
>> +
>> +Both annotations indicate that the pointer argument points into the
>> +calling program's arena. The JIT rebases the value at the call site so
>> +the kfunc receives a directly dereferenceable kernel address, subject t=
o
>> +the access rules described in :ref:`BPF_kfunc_arena_access` (at most
>> +``GUARD_SZ / 2``, 32 KiB, past the pointer in a single unchecked access=
).
>> +
>> +With ``__arena`` the rebase is unconditional and the argument is never
>> +NULL: a value whose lower 32 bits are zero arrives as the arena base
>> +address (arena offset 0). The kfunc must not check the argument for NUL=
L.
>> +With ``__arena_nullable`` such a value arrives as NULL instead and the
>> +kfunc must check before dereferencing.
>> +
>> +An example is given below::
>> +
>> +        __bpf_kfunc int bpf_process_item(struct item *item__arena)
>> +        {
>> +        ...
>> +        }
>> +
>> +Calling such a kfunc requires the program to use an arena map and a JIT
>> +with arena argument support (currently x86-64 and arm64); verification
>> +fails otherwise. The program can pass any value without compromising th=
e
>> +kernel. A value that does not point into the arena is a program bug.
>
> The documentation says arena argument support is available on "currently
> x86-64 and arm64", but does arm64 actually support it here?
>
> bpf_jit_supports_arena_args() is only defined to return true in the
> x86-64 JIT. The arm64 JIT is not touched, so on arm64
> bpf_jit_supports_arena_args() falls through to the __weak stub added in
> this commit:
>
> kernel/bpf/core.c:
> bool __weak bpf_jit_supports_arena_args(void)
>
> which returns false.
>
> On arm64, check_kfunc_args() would then reject any __arena or
> __arena_nullable argument with -ENOTSUPP. Should the documentation drop
> arm64 from the list of supported architectures until the arm64 JIT gains
> support?
>

Thanks, fixed the documentation.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/294547=
48905

