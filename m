Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041874;
	b=DTVOzHOt9Wt/Nb6PfqOK076Fcvg9wCxlVJ3rCkMLTj7ikZO2f9p7Yd8M06beTOwmdKxy
	 sXIURv4ydYyOT0KK3mTi61KMPk/+jWBsiSfmsLcEzStQ9F86ENUMof592dsNSUqgj615w
	 n3ouEPFmO1vOQod+jz7wmL8ArXL5q7iupk6bbpwPatjjLLpENBdYh6tYotfPp6HbZB5fD
	 bmJAq6DYpFbe+TnuvnALyfq6kcaJbhkisscwPTZXPbjDgLtePz6ugKH4qr4AKcz/fE4LJ
	 v0yUeLBNbMwOnnxy2wbJXHuTe+xbyZFntCHZ/7CEUkwBUk2Z1fs2366NpM3CtaGavYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=xb8vaYkXb3WyePVM4A0uNn/vxbvhHtvysyg0tVAcvjw=;
	b=WretBUkBEcCtBZqmW9P3FdSbDfHc+V2dIGluTmXwLJfMFHDa8YqjrdAral/zGqaotxjL
	 Uobs8V22XvNLoNVRAFYOnEe47FQt8FKZHKF1lhx3rDwbAl+YHxUBBjNABFdheDXyNGg7W
	 JH2fu1yQQyi6vZ+e0ElP3KqcjtC08KRz/fJ2deKqKeIQZkMWpBEY7ZS/6TKFhO3rii+Q2
	 vbOClX9BzfMPHaBaGzpViQSOMNhJ0kXHth8slW+JEEimVAWhe08bO0/8J0KP2Del8lAB+
	 /Rxwr0khh/QunDwQOUv1ImrrkbcBPNowybbMrA0YKi4engOLeH2yfhXb4qIpOPjHcVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HKSytXbh;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C2606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB7C2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HKSytXbh
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so658668a12.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 14:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795041873; x=1795646673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xb8vaYkXb3WyePVM4A0uNn/vxbvhHtvysyg0tVAcvjw=;
        b=HKSytXbh+AqtrY+a33cZHshN8To9EdC+T6+DNRWu+YI2uB4Yx08lFjSHSUSrgXYKYm
         j3CdR9qkoaftAeiuXRPH1omdTkYc9Ya4BVFCW8kWqoziJk+YVXljpWRdHuXQRZ4S05o1
         Ea97QQNZgrD9DtRRe9zhXsSm5jvRAMkeVY5imSlXp60p5/KVVfbSGCTwKXpsOt8TkJSr
         C+AtI9gnPz5O0hwiZEo6ik66y+CnSiTsJToJiYVyNMClVx8qGEcIPp3jpxrovTv/KIBn
         dY28hivSWVdiRbOTsyuxPfFH8a0O9X/ZRhJP/cjPqq5DRupRPabmtZKXEAG2XMZL0oqq
         Xl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041873; x=1795646673;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xb8vaYkXb3WyePVM4A0uNn/vxbvhHtvysyg0tVAcvjw=;
        b=naD5o1ONE12xyIyxnyDrOr6SfLdV3z7X1WWsZ08Pui6e2adkihhFlx3co2c9c0yBuP
         nYZmU0H528AY0LtjSpomVU3Q3gNv9jpm569nhXzEPRdBuU5TzdY2HBw7+XeEVskr5oCn
         CnY+GP9/arf5yYYD9nwiugOKnpzP+T5aEKLgN0MYFEGYrjeneQJWyQvcFlLBsvBKOw/p
         0+cO0tSRY+A92OxEbe379vUOaAZ0G/qYWZqSHUYZXw4+ylDG+5xxJWRPDflBIt+UBJEx
         +if5ZRbXo+x3XuolfKjkO2XPyGRTZ+1OfXueNkCnNDdnJ3V3ydXHZWO+zcZj6UxERR8W
         NVpQ==
X-Forwarded-Encrypted: i=1; AL+hErEKtPN8ghl2I0x+y77wFhkmRx5doFjQmjXO1xd1EcDVPPetMCraRZao4QJzteuzYQ9yUv8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+h28yj5XA3fO8Euz0zUwV5DabCN0njT8NCrB7a5mGRa888aTQw
	okTFWAd2YRRBDplXBCJNX4K7JQPI8qtMtUAPgME9iq5EJktOr2AkOlLX
X-Gm-Gg: AZFdTZfAnpDNsr1E0v5sLj87HLVz8mWLaGkUvqaC0Us1QA5yI1L/4rHEJXjUzFQBzhE
	1aNIIez/PBW5joH7qLud0CWGj5oxNerXGvfoTP8sbxcca173EZeNYfdkLg0qPJRhRHkfgp2akok
	xvJL8fvhPqmHAQBFMcAWatc7rPWvDpW0bTtQoHR2bb4e7h1fNRcc8uUfaxCFykEPG/szdrBasVm
	cSVjvQ80aOrv57MPVZn+O+NUjNYwai3MSaQkYUKditnp0kpfxtQrH7xqsApWm+3HwQgwFv6SY/w
	Cbh6pMUuNNEmQmZHbki03Oktfqku6K1NgN32DjQ25y1BGXTRzL1Fg6CEMgv0By5ZlASDm4rAcDw
	8COs79WWloYRxvSPIm6e6MT4iK+OII+rZ0vn3cZ06OmDtUkRIrvF6NBqGk4oTPuNdrBlFZ5Zl+x
	z6+8kBnITS02aVKhsa+SYEWxvEXkeD15HIfogU8MdIRi3EdhYKPanfufgl5AUj4vJ5Ez7HxCOG1
	1yvxg8SEEPyoUgurVYc4sYSOdi/5TMTxPlN5Wqfr1jb/TpUQbZ3QneWfHOWzTMcBKJ214yv5c/k
	2SkJZqy8lD0ajcKxW1wvb1wnDZdd6m+/RpII/e2iX9gYM/tDg/UayrFDpA==
X-Received: by 2002:a17:90b:2b4b:b0:3ac:8af9:4a73 with SMTP id 98e67ed59e1d1-3b3d07b90eamr3666378a91.28.1795041873232;
        Wed, 18 Nov 2026 14:44:33 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3fe09b6a2sm207669a91.7.2026.11.18.14.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 14:44:32 -0800 (PST)
Message-ID: <9e6ac7882314fdb1215dcebff1c35db72380ad0c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] libbpf: Fall back to kernel ___ flavors
 when resolving kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu
 <song@kernel.org>,  Tejun Heo <tj@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Date: Wed, 18 Nov 2026 15:44:31 -0700
In-Reply-To: <20261117192153.3384031-2-ihor.solodrai@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
	 <20261117192153.3384031-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:

...

> +/* id is a kfunc named <name>___<flavor>, where len is strlen(name) */
> +static bool btf_is_kfunc_flavor(const struct btf *btf, int id, const cha=
r *name, size_t len)
> +{
> +	const struct btf_type *t =3D btf__type_by_id(btf, id);
> +	const char *kname;
> +
> +	if (!btf_is_func(t))
> +		return false;
> +	kname =3D btf__name_by_offset(btf, t->name_off);
> +	if (strncmp(kname, name, len) !=3D 0)
> +		return false;
> +	/* kname is <name> itself, already tried by the exact lookup */
> +	if (kname[len] =3D=3D '\0')
> +		return false;
> +	if (bpf_core_essential_name_len(kname) !=3D len)
> +		return false;
> +	return btf_is_kfunc(btf, id);
> +}

Why is `btf_is_kfunc` filter necessary?
As far as I understand, main kfunc resolution logic does not check for it.
Having different rules for exact name matches and for flavoured matches
seem to be inconsistent for no good reason.

...

> @@ -9526,6 +9650,17 @@ static int bpf_object__resolve_ksym_func_btf_id(st=
ruct bpf_object *obj,
> =C2=A0
> =C2=A0	kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->name, =
BTF_KIND_FUNC, &kern_btf,
> =C2=A0				=C2=A0=C2=A0=C2=A0 &mod_btf);
> +	if (need_kfunc_flavor(obj, ext, kern_btf, kfunc_id)) {
> +		ret =3D find_kfunc_flavor_btf_id(obj, ext, &kern_btf, &mod_btf);
> +		if (ret =3D=3D -ENOTUNIQ) {
> +			/* an error even if declared __weak: ambiguity isn't absence */
> +			pr_warn("extern (func ksym) '%s': more than one compatible kfunc flav=
or\n",
> +				ext->name);
> +			return ret;
> +		}
> +		if (ret && ret !=3D -ESRCH)
> +			kfunc_id =3D ret;
> +	}

Idk, I don't like that this is implemented as a special case:
- Check exact name match first.
- Check flavours in a separate loop.

It appears that having a single loop looking for name candidates is a
bit better from code structuring point of view.

> =C2=A0	if (kfunc_id < 0) {
> =C2=A0		if (kfunc_id =3D=3D -ESRCH && ext->is_weak)
> =C2=A0			return 0;

...
