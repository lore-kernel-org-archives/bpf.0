Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC08131720
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730730; cv=none; b=V8PqbA6+5Kx7ZKuofDZTd809PPcYmjJBeAdke9XrG7iYRqGPQR8j4h8pEuromgH7VuR6CvmbT78pXALeSEZYU/hjUBOkUq8hr6OxvfDoR+HxENoaHPSmFlhL/iaafx8SS9QHUAABvTAt4i0LuJn7uGMEfz4cASEIaG9b99mZuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730730; c=relaxed/simple;
	bh=oVKUqanUGAcq2NWxlbbq/+er60MgHhBcCtUj4CoQsV8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s+KTtMn+sgSP8IQeSB++2dVEOBLEQLGV7P54t/ijk9Q3ldZwLfPmFjLEfSgb5hPftWKAfPCN5iP1wGolHeiYnKkG6z6L/I+Ha1pEENyjLXNkagt+50ZW6osyEjzvuoeolk646MYcKr1Y0WvBoMgjV4DVdYrenE09rdasmprk8Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7fZ1o/w; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7fZ1o/w"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so8635552a12.3
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 05:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709730727; x=1710335527; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ZIy1xwiIRwXJ/TPCtZPshhjhmF1b2jcglnJlzmWcHs=;
        b=I7fZ1o/w1wynqAMtdrSEGbTNc/2I8j1sEDjifu/fPQ5Tzvg2nQbeP4gXmnL3yoVeBD
         naCiguxb23spoiA4uB60dPfWiGj46n6lJhlCsE6xrs9jjN4Q91AOfP0EC0A3yAnGFnlF
         3Qugg9BC2jzkai8hy1t2D22O//heTlP3A6QE3yNif/+jXo4iD4ZpoLBSpTXgPOh5y6lh
         r2rEEeIHF38OdCLSF7s3RtwiHmSLf4VvzTuC47Q7kts5ZSFi6mMS8rvBZL3ut9N7FBrN
         T9I8hC3O5ADBTkuV1l+ckFzjCvohADwgDnMMz02ZYNoHt5hi9ezxwXJdYfaesld4HU91
         M/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730727; x=1710335527;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZIy1xwiIRwXJ/TPCtZPshhjhmF1b2jcglnJlzmWcHs=;
        b=ok6xrpdcCY5X04t0MmNkNN2CKhn6T5kJrgOUtLHIESy/t68f6vlp/2XwkB98zKhr5q
         EPOPtw6APj9Xp0xSPOv+eVOjJcbjt5js7Tdm+fgVkEtmVK2OSS8CONSlpeoU9FtRUYd5
         uxm+KE8cbdnpFx+cmP0aWICv0KnmYzBNzQSEB95WDoMKDhXDs77P2cCZ41Lf/oIT/pAd
         SjS2sQfpGzGMwEuJ6oWWsL979nNE7CmGrFn01DMrFCraK9zksDltDSoqpi3UM8C7g1aS
         GkNn8WutWv96sdkaEWbv48hxT0eIxRwv49GnTtGXk44J6pm1CmVsHhf98c3l/e+BH6yq
         PlJA==
X-Forwarded-Encrypted: i=1; AJvYcCVKrhGucQoVcLz4z6PdqxGkOvWAWRDBwM4M1gMzkjHYLUKL69L2OQv1GwFMV0vwFqQCrAlS8mw0+hnLJ5GamCsAEC+e
X-Gm-Message-State: AOJu0YwbVU+EAQyhiZVaRXnR0tmds68B0b4cSoZMB94Nlwk0USCnvXuI
	pc0gCQQ5zR7tm256siIpPuZ9sScgxRQ1n0Wa+9NM96rzqADubJ/S
X-Google-Smtp-Source: AGHT+IEA8orCjqWvz4seHKDEwZ7QLgf9MfE+1Ut4/SQ2uflmhcVmBCO3CJGBOm6qPaEFPDPT9poDGA==
X-Received: by 2002:a17:907:7677:b0:a44:7bbe:d770 with SMTP id kk23-20020a170907767700b00a447bbed770mr12276912ejc.7.1709730727255;
        Wed, 06 Mar 2024 05:12:07 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709067c9800b00a4528658771sm3841399ejo.31.2024.03.06.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:12:06 -0800 (PST)
Message-ID: <d7b7dd3eab10ff5b57799e16b95ef1a45c90285a.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/4] bpf: Introduce may_goto instruction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, john.fastabend@gmail.com, kernel-team@fb.com
Date: Wed, 06 Mar 2024 15:12:05 +0200
In-Reply-To: <20240306031929.42666-2-alexei.starovoitov@gmail.com>
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
	 <20240306031929.42666-2-alexei.starovoitov@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 19:19 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>

[...]

> JCOND stands for conditional pseudo jump.
> Since goto_or_nop insn was proposed, it may use the same opcode.
> may_goto vs goto_or_nop can be distinguished by src_reg:
> code =3D BPF_JMP | BPF_JCOND
> src_reg =3D 0 - may_goto
> src_reg =3D 1 - goto_or_nop
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -14871,11 +14882,36 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>  	int err;
> =20
>  	/* Only conditional jumps are expected to reach here. */
> -	if (opcode =3D=3D BPF_JA || opcode > BPF_JSLE) {
> +	if (opcode =3D=3D BPF_JA || opcode > BPF_JCOND) {
>  		verbose(env, "invalid BPF_JMP/JMP32 opcode %x\n", opcode);
>  		return -EINVAL;
>  	}
> =20
> +	if (opcode =3D=3D BPF_JCOND) {
> +		struct bpf_verifier_state *cur_st =3D env->cur_state, *queued_st, *pre=
v_st;
> +		int idx =3D *insn_idx;
> +
> +		if (insn->code !=3D (BPF_JMP | BPF_JCOND) ||
> +		    insn->src_reg !=3D BPF_MAY_GOTO ||
> +		    insn->dst_reg || insn->imm || insn->off =3D=3D 0) {
> +			verbose(env, "invalid may_goto off %d imm %d\n",
> +				insn->off, insn->imm);
> +			return -EINVAL;
> +		}
> +		prev_st =3D find_prev_entry(env, cur_st->parent, idx);
> +
> +		/* branch out 'fallthrough' insn as a new state to explore */
> +		queued_st =3D push_stack(env, idx + 1, idx, false);
> +		if (!queued_st)
> +			return -ENOMEM;
> +
> +		queued_st->may_goto_depth++;
> +		if (prev_st)
> +			widen_imprecise_scalars(env, prev_st, queued_st);
> +		*insn_idx +=3D insn->off;
> +		return 0;
> +	}

Nit: for other conditional jumps the fallthrough branch is explored first,
     I tried the following and the tests keep passing:
    =20
@@ -14901,14 +14901,13 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
 		prev_st =3D find_prev_entry(env, cur_st->parent, idx);
=20
 		/* branch out 'fallthrough' insn as a new state to explore */
-		queued_st =3D push_stack(env, idx + 1, idx, false);
+		queued_st =3D push_stack(env, idx + insn->off + 1, idx, false);
 		if (!queued_st)
 			return -ENOMEM;
=20
-		queued_st->may_goto_depth++;
+		cur_st->may_goto_depth++;
 		if (prev_st)
-			widen_imprecise_scalars(env, prev_st, queued_st);
-		*insn_idx +=3D insn->off;
+			widen_imprecise_scalars(env, prev_st, cur_st);
 		return 0;
 	}
=20
Maybe this is a property worth preserving, wdyt?

[...]
