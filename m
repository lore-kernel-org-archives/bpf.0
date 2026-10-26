Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058358;
	b=MaldEVA2euzqkRhjYRhs6p97dFlUUB+T/58H1hWRn12bo2aVDyMalgLnJ45sWNakh0V/
	 HwAIK4TXsJxRGThyn0NSwuuFrAWURelQltwh/6VPSy5lksqiK/+0GDOpbGjMurBVR84ve
	 91kHb7oI/tYy+Rgo4L6K6liW8KE+B83fOF5rqPEniZOH0Oxi5A1Tb6Drm1VsiDgwuJj2C
	 KdlCK3Ik9zITTA44oxjl5U/T+4QOkxWC7l9aEqJaThfRx+AhayfcDOpHa7caZBoQG7awa
	 tmXLMjQ7v2jtWsdJ4FPyCXedQvomuwMKqf38Opt1ior65f8HdooKo07SvSBxaurWMjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=0L+DA26R5f0e1Zo2jw/RAAb6vEdfm25gLGHfLsfS6FA=;
	b=sTm1CLJmneaH8cMThVn/3+fvyoGTfAw4HMrjnxyJVEFIjxqqDwQ+AqlPasGwZQKdvJBQ
	 iJccLYBB8RwxBauAHioG9/Ytpe9YZ9JWOfSQF6kVkVzNwzm1J5hfPwn8vUs/88YDn7MT4
	 TDrH6IggDX0vp5GPuOIA0ioTkdlf7DfhblsUB3dmGkNM1Hko7jHiA+L3saIakGYvrkavl
	 K4+Hwf9VIhbN9ajNIQ/oWubsuJDjd7f7qHk7UoxHAEI7RvPABIzyM/vAUH+M54Qv6K1RA
	 G/rnKNu5JHz3XUO4ItzHd/NW8VYAGNvq1YiJexMHDcAv4OYnRNwnZ0irLcMfBwRyzsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bOHIBvJR;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A77606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0A77606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bOHIBvJR
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1851098a91.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793058357; x=1793663157; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0L+DA26R5f0e1Zo2jw/RAAb6vEdfm25gLGHfLsfS6FA=;
        b=bOHIBvJRqDqYOCAM4C2zv1Ai1PaQD70Y3eizor7fYpQIvYstaJnBB3n63pDV/95m4H
         aDkjHUYqYFUeBlQzUKDMzHTKmmTeZN/UochFl8euFvQ4GOrmtxKv1McVN+EpAb6ooCyO
         XRt1MVWKwav9JOGneoO14tz8xoD/r0EXCuNtm2EiNXR34ElbNf1ophT0uaE+rku8szg4
         6OqYXbQpqGsSh11nbvCnAj4BcN8YfbIGN1BkH0GIgytulhUa9LCeVNP2z4kkP1PbMy07
         bivbRsWDzJhTjsLuYJHrlCHtbYKgmH6sr07wkpoemBMSq2+WzOoJ55qEPXhy8MQy4qkr
         GCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058357; x=1793663157;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0L+DA26R5f0e1Zo2jw/RAAb6vEdfm25gLGHfLsfS6FA=;
        b=Fm9fNBvXuxDm4EWlV9nyxIK3YVhJKro9e1HO0NvYTDjFlL58yaYmz/3eMTWlxq/4TN
         oKI3k+tDonXtLXK5q5UR1EgAXyWEXb3Dq1Or2OQRDCTY1r1orTxEep6p3NyDXzI+qUxB
         4j3VexIRWd3dYmVgDe1TizG5IYNk9FHoCsX8QiR8a5CG7cXbjIJXW5GDkaiWTao1v1PA
         8EmDrxYfPiH0HCN2e2000ESg1kRg4ucfwXoNVVp5KK2z2gIE3cnvctY/MivBqUbCJ7cO
         DB5kcTQKwnnlkOKkgLBoXjRGJJ6zjckfwSulMuB6Qnq+x386P8C2JrxWAXcueny3KyWq
         OG2w==
X-Forwarded-Encrypted: i=1; AKwUvBx1ZGOq48/8G2uTqjXl2hszmNdGWHRtME1zKMA3FBnvYlznzCww4WhB46QTOWpUCR+zBh8=@vger.kernel.org
X-Gm-Message-State: AFq9FYITjn71Q5vTnX8QDrN9RQgMMP5AqTkaQU4vKXqHFWRRVqEzDKKT
	me0oPPBsIny4QuY9AE2xfsEiU66NhI1hxHZffkSrf1yao9TJ1ZOUiBJO
X-Gm-Gg: AYBFou169QhOvt+tibSxEHhCnNB55ki0TPQChEdje2ruECnJQN0K8XCJdtewfNyyyJP
	UlHeIw2sO7qpxPpVTOYHceBHU9XWhtzzveDf86ESx4YMd/YkZnuKp0/SI6q2UHecrWrbeG72IAG
	pFVThN5RtdGSMrEEjiJ+t7ifYEhxGor/1hMAKvxDAqwInVn2jhckIV3Hq7wiMvvKNdII1j9SHdF
	SAce7kqbH2w/3+rT6Kgd7pagRy3JYeF1nUGjymt6G0Fr3inA5lnRX5rBGqN2iHyaFO3bQ4Fne+w
	w3QqJCQ9PwKuNYJFLDC+DXhulvd1fOBDAk1n+PdMsu+d04/z7vduiKkxqmGC18ufyTCGDtvBbSS
	PsnO52wumcZLus9ISTctHihOVXaAoV7LER0jiw8SMXlJhBJ5UZLLL+QJaU1G+nGlihINKWf7yEy
	kLOackjZbHsWAmuORwClsGRnsevoc4uHLuEyLgB69zmwKKRz/jjLVLVr3TVCp3YwdUatfYuJrXG
	ncJnYYReCO5u4OEt/pxvnGSKs/2LqNsOJHueo+kJ0YoupdMo4hZZ34ku26H/9WwpO6KAmqfnxTD
	faDo4e00
X-Received: by 2002:a17:90b:2744:b0:3a8:495b:d64b with SMTP id 98e67ed59e1d1-3ade9a36318mr6525812a91.4.1793058356812;
        Mon, 26 Oct 2026 16:45:56 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4064f4bdsm1109688a91.11.2026.10.26.16.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:45:56 -0700 (PDT)
Message-ID: <5e87915b1065db0c4ce8f7f4368a8c3109cfe891.camel@gmail.com>
Subject: Re: [PATCH bpf 14/81] bpf: Fix a false verifier bug in the clamp of
 scalar evolution
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Date: Mon, 26 Oct 2026 16:45:54 -0700
In-Reply-To: <20261026025943.404450-15-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
	 <20261026025943.404450-15-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-10-26 at 02:58 +0000, Alexei Starovoitov wrote:

...

> @@ -2869,6 +2869,8 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *en=
v, struct bpf_func_state *cur
>  	struct linear_coefs coefs;
>  	struct env *header_env;
>  	struct bounds bounds;
> +	struct cnum64 r64;
> +	struct cnum32 r32;
>  	u32 r;
>  	int err;
> =20
> @@ -2892,11 +2894,18 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *=
env, struct bpf_func_state *cur
>  			continue;
> =20
>  		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
> -		bounds.r64 =3D cnum64_intersect(reg->r64, bounds.r64);
> -		bounds.r32 =3D cnum32_intersect(reg->r32, bounds.r32);
> -		if (cnum64_is_empty(bounds.r64)) {
> -			verifier_bug(env, "scev clamp produced empty range for r%d", r);
> -			return -EFAULT;
> +		r64 =3D cnum64_intersect(reg->r64, bounds.r64);
> +		r32 =3D cnum32_intersect(reg->r32, bounds.r32);
> +		/*
> +		 * The state at the head doesn't know how the variables depend on each=
 other.
> +		 * It lets r6 =3D 0, r7 =3D 9 into the loop when both count from 0, an=
d r7 =3D 10
> +		 * comes back. No run gets here like that, so any range is right for r=
7.
> +		 * Take the one it has at the head: the rest of the state is still com=
pared
> +		 * with the head, and what was pruned on the way here relies on that.
> +		 */
> +		if (!bpf_reg_range_is_empty(r64, r32, bounds.base, bounds.step)) {
> +			bounds.r64 =3D r64;
> +			bounds.r32 =3D r32;
>  		}
>  		if (log->level & BPF_LOG_LEVEL2) {
>  			bpf_log(log, "loop header at %d, clamping ", insn_idx);

I'd suggest addressing this as in [1,2]. I'd expect that selective
clamping would be a subject to counter-examples as well, just a bit
more convoluted.

[1] https://lore.kernel.org/bpf/20261026-scev-simpler-clamp-v2-2-f373aec982=
5f@gmail.com/
[2] https://lore.kernel.org/bpf/20261026-scev-simpler-clamp-v2-3-f373aec982=
5f@gmail.com/

...
