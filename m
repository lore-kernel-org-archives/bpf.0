Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD49346FDB
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962864; cv=none; b=eciu42oFTfUI8KKR31i2bq4O21d/uD5hG37jLGsr0K1Dmv3cuXkDzXt3qm9dI14LIty70mGSBSCo6xK9thuH6Ds2ZTY1vHB7Jd6kOeC6RKt4YuOR9JzsfAtLdhQhXrGBmE2ECFQ7VZAQ54iDfa+zuhzFSwT3AZKTmq7pZjLajuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962864; c=relaxed/simple;
	bh=eKrENTy7H8tsgWquHg5AS7iXDcAfESegU4CufjC3108=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPgvHCFGJMZmZxyanfMfxj2tU7xpMPQFG2B67j+pOsySpG2ZxuhJs8RCivJAOXe0Wvkjbh9OYRjRLqIOx9ECnp7jVIpeZlrd7xYz+eJ2Jp2G3zOlTklgZrTtzeSBkXlbIMSvJLxbWSa8w+IWj0ukgD738okrx422Eo16NedbhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNjH8Do7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNjH8Do7"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81c72659e6bso5075897b3a.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 18:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768962861; x=1769567661; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qbrr+1UZQiIzfD9W6IPHVs6CDfw5esgosxo9v9NbItA=;
        b=BNjH8Do7bYSWQsZjbeWWmvWin20k7i8ws+y3Vpxu/Q/8D0YU1HhiNSssJnZoGEy8j8
         hGY1PKE0MJG8uvxg0kOYrFZY8R5yeKCrc6aVXRJ9jYchroOLp+i9IdFeDg49kNUSs2gX
         +UBRRXWMjleJTj7jTS+47EwQAKxOe09ZQgITUwb9p1ieAnhOSekclQz9sClXoZ3R7qsW
         9U4OUHyRqTyaEKs/tMjtb+TJugphdB+cbvtpD5/RKguPYDDjkhFwm8Lr0DDjxAa/Qgj/
         MgXFhJgignut/SWJ0sw2W8TBvUcUVgbYuNex3dqr5s9jceUsJaSQ/WV65+MCCqdwngMb
         bzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768962861; x=1769567661;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbrr+1UZQiIzfD9W6IPHVs6CDfw5esgosxo9v9NbItA=;
        b=LCYxwVGIHvOgb6XRQdkJEzMOSoyBXfTWi99SbcYn/FNu/pf1BRBG9QLMvtcPZxMqbO
         hknF+o0an6qvqmHlExGXNTI7N3bTXVJQ8eZPhWhGhV/WWyL2LsAsVHXWi7gmx/gDtOVc
         n1fXJ+VmbypUPSkxOtAQ4beUvjUL5xbQSy17/48/qe6/OFA3noe+ylMh6iQcB63jNA4r
         3d5IXoXs1KZSh0uIyQo6BSNOWmHjxXj+JuKZGnGC5vZbedtcRU37bIG3MP/lTGuvhRZr
         S/qMKQ9PzVMvzmrop/SJ8zWtrABWQ9x/MpEYAYAhVoRylKFdWNq89JpNhEHRtiOrcuWI
         gwug==
X-Forwarded-Encrypted: i=1; AJvYcCUN3vbRNPDaKLv7dl/XOrz5KqfC66ctr1Wf/Xv/WTHGCMtGF66XGNbPnQRlmL1r06nJYdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqoFEizNVQYlhZxiSmQnH9VJ/6mirxU5YuLs2mlOi6BT3Eg4Q3
	dRygzpWNfDF1syohF9DoKlA/c9Ym6ZcGSEJ5IsVC6+a7xHKz5yNfb7lCh46cigSk
X-Gm-Gg: AZuq6aLIe0LK8SQqn1IGVt48DPRI64QSFzKOf2ijc0OSy2WusqqSwkclhvRwgkbiV7y
	xMw1O4d1sT6g7GRckzmBYQaEdqkWMXU+fjYI2cefePcSV/w1AYq/EwfaBk3FT7Z42LXAnhIv2j4
	AjFHraXBblA+DGHb2FX989kSF160oi/0qK+zAOUHMQswUglPh+JH5zdPsib5wvU2N4ajDtk5muC
	nA6AnUVw19fG19MiNZtyHs/nlBWcu9PAKf5xUWqMXtAZdON0aluYknPLjJCxSv9G1N41qTAXVDH
	9XM5A2bZWWpO5u//Mtdne39u5IZ6KFEeJzkOe1h0BO/UuohxaeR5D4mAUbmmbUWb3S5dlRxIhhD
	PJ14yzoPzLwfTW6UHHggyYfTaGJqRF9CoxM6MolzJhE0WhoV5OeOjex31Snaz3IbiUv4bVuBU2q
	WYUxNw89rFFAp3RRKv+xK55+m/UzKsjeC5QmYroUxig/ctd6KdBKMHkBHkPjt3kxaRvIih
X-Received: by 2002:a05:7022:e23:b0:119:e56c:18ae with SMTP id a92af1059eb24-1244a7360c9mr12030676c88.22.1768955569148;
        Tue, 20 Jan 2026 16:32:49 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6a7d:961b:9e54:4392? ([2620:10d:c090:500::2:634c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac5842csm23073378c88.1.2026.01.20.16.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 16:32:48 -0800 (PST)
Message-ID: <15c9dcad21238daf988e1631319bb1b9e77ec021.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Add range tracking for BPF_DIV and
 BPF_MOD
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn, 	syzbot@syzkaller.appspotmail.com
Date: Tue, 20 Jan 2026 16:32:46 -0800
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
> From: Yazhou Tang <tangyazhou518@outlook.com>
>=20
> This patch implements range tracking (interval analysis) for BPF_DIV and
> BPF_MOD operations when the divisor is a constant, covering both signed
> and unsigned variants.
>=20
> While LLVM typically optimizes integer division and modulo by constants
> into multiplication and shift sequences, this optimization is less
> effective for the BPF target when dealing with 64-bit arithmetic.
>=20
> Currently, the verifier does not track bounds for scalar division or
> modulo, treating the result as "unbounded". This leads to false positive
> rejections for safe code patterns.
>=20
> For example, the following code (compiled with -O2):
>=20
> ```c
> int test(struct pt_regs *ctx) {
>     char buffer[6] =3D {1};
>     __u64 x =3D bpf_ktime_get_ns();
>     __u64 res =3D x % sizeof(buffer);
>     char value =3D buffer[res];
>     bpf_printk("res =3D %llu, val =3D %d", res, value);
>     return 0;
> }
> ```
>=20
> Generates a raw `BPF_MOD64` instruction:
>=20
> ```asm
> ;     __u64 res =3D x % sizeof(buffer);
>        1:	97 00 00 00 06 00 00 00	r0 %=3D 0x6
> ;     char value =3D buffer[res];
>        2:	18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00	r1 =3D 0x0 ll
>        4:	0f 01 00 00 00 00 00 00	r1 +=3D r0
>        5:	91 14 00 00 00 00 00 00	r4 =3D *(s8 *)(r1 + 0x0)
> ```
>=20
> Without this patch, the verifier fails with "math between map_value
> pointer and register with unbounded min value is not allowed" because
> it cannot deduce that `r0` is within [0, 5].
>=20
> According to the BPF instruction set[1], the instruction's offset field
> (`insn->off`) is used to distinguish between signed (`off =3D=3D 1`) and
> unsigned division (`off =3D=3D 0`). Moreover, we also follow the BPF divi=
sion
> and modulo runtime behavior (semantics) to handle special cases, such as
> division by zero and signed division overflow.
>=20
> - UDIV: dst =3D (src !=3D 0) ? (dst / src) : 0
> - SDIV: dst =3D (src =3D=3D 0) ? 0 : ((src =3D=3D -1 && dst =3D=3D LLONG_=
MIN) ? LLONG_MIN : (dst / src))
> - UMOD: dst =3D (src !=3D 0) ? (dst % src) : dst
> - SMOD: dst =3D (src =3D=3D 0) ? dst : ((src =3D=3D -1 && dst =3D=3D LLON=
G_MIN) ? 0: (dst s% src))
>=20
> Here is the overview of the changes made in this patch (See the code comm=
ents
> for more details and examples):
>=20
> 1. For BPF_DIV: Firstly check whether the divisor is zero. If so, set the
>    destination register to zero (matching runtime behavior).
>=20
>    For non-zero constant divisors: goto `scalar(32)?_min_max_(u|s)div` fu=
nctions.
>    - General cases: compute the new range by dividing max_dividend and
>      min_dividend by the constant divisor.
>    - Overflow case (SIGNED_MIN / -1) in signed division: mark the result
>      as unbounded if the dividend is not a single number.
>=20
> 2. For BPF_MOD: Firstly check whether the divisor is zero. If so, leave t=
he
>    destination register unchanged (matching runtime behavior).
>=20
>    For non-zero constant divisors: goto `scalar(32)?_min_max_(u|s)mod` fu=
nctions.
>    - General case: For signed modulo, the result's sign matches the
>      dividend's sign. And the result's absolute value is strictly bounded
>      by `min(abs(dividend), abs(divisor) - 1)`.
>      - Special care is taken when the divisor is SIGNED_MIN. By casting
>        to unsigned before negation and subtracting 1, we avoid signed
>        overflow and correctly calculate the maximum possible magnitude
>        (`res_max_abs` in the code).
>    - "Small dividend" case: If the dividend is already within the possibl=
e
>      result range (e.g., [-2, 5] % 10), the operation is an identity
>      function, and the destination register remains unchanged.
>=20
> 3. In `scalar(32)?_min_max_(u|s)(div|mod)` functions: After updating curr=
ent
>    range, reset other ranges and tnum to unbounded/unknown.
>=20
>    e.g., in `scalar_min_max_sdiv`, signed 64-bit range is updated. Then r=
eset
>    unsigned 64-bit range and 32-bit range to unbounded, and tnum to unkno=
wn.
>=20
>    Exception: in BPF_MOD's "small dividend" case, since the result remain=
s
>    unchanged, we do not reset other ranges/tnum.
>=20
> 4. Also updated existing selftests based on the expected BPF_DIV and
>    BPF_MOD behavior.
>=20
> [1] https://www.kernel.org/doc/Documentation/bpf/standardization/instruct=
ion-set.rst
>=20
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> ---

Fwiw, the logic looks good to me.
smod is probably the trickiest part, I tried it using simple test [1]
and everything seem in order.

[1] https://gist.github.com/eddyz87/da600f6d738fccdd7cb8a0e7ab4214e7

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
