Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6577317582
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079550; cv=none; b=Q7qaWcXWiazUs2a5azEZIjJyqsElTkbJvn958agt7hd5M0WXF4/VlpBost7ZLhmcsi4Q8Vexgu/I44tT7ZTEAhgfq5OoCLjqofN/L4cyLM0jj29oHd4YJxS9VC2cyaiVudztMIDh3JxFxxe5u98T9iH+vIr5x8p8pCxTbUWlyRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079550; c=relaxed/simple;
	bh=0GyonYsT/K/WC9ydbEUVElxxzZojewc454F6SMMltgA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PnXaCZ4pP02dRbfFS+tD87DKTbmnyzG7XdHiTah7f8eDOXdndugHZ2Q/niyhFj94uL+fslheiuvBVUsxjZpPVwImJv6zjRcV8KNoxAc/+4hhllynzx/yVqs48r6QRUWpmXzkK/HbqFCcr+rcSrypocvAjb9+e58J6igK9tLhQZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbZAXupU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbZAXupU"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso6161981a12.1
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712079547; x=1712684347; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gbi57ChA1VxIrHAztT4+e/yqBCVyFmTTLzogO/L3v9I=;
        b=DbZAXupUqwzMad7OadVxAT36JzAgh5QScPd7xnfYGrkS3jQhO/AoX9/2mZIlgtz3AR
         joUG5NCqWwM7oZR+WCaKyzjnGgq6yeDYBSV0RfDmpzmf+GnAP/gHehRHhMHctpIKousq
         1a96mzgxYKOE8dwTqZrRF9S4IsheiZEVK3UguF0F5b1xYp8qoaKLwmUrAgvm3+i84svX
         h7EoLERjEnidtE6Kf9ANz4+NzBPyRA7q0PGLibcIbdOdE8UU5buMeVO3DkHuBXkpx4wA
         6SBG4SfkHkNtCvSgG+M2rtb6UD63o2bnVlz1/dMKNCcgAbeHfaDPwy7P8tzaMHGSbFvB
         3Pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079547; x=1712684347;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbi57ChA1VxIrHAztT4+e/yqBCVyFmTTLzogO/L3v9I=;
        b=ZeHtvGxg439mrOJPum4Lk9lso9k04v+rQMz/RLJ6TRTWh7rcQcB+uKsALWYjgFY52C
         DtIP5V53FSTeXSBiLk5t70sJQyb7RZC55yVwlkKuLoCnmXf48pIk1uDANkEV5RZBf3++
         EIaKpBxzC+Wu1DY6HlT/ZWv+1OTADgqC/elDdv822li68I4JUiD/URy3eu8jhHC2LTZV
         TwKpA1TyijciDTKcHiI2MsXMfInyvvvNOF0TvEFKknYyMuIubKYkjHAUVpjmJOu+kFT2
         mwFFzx0mNIS7vGB6DWHcD34u5S1SjOGfLQiB7xZAfRQWVcOE5WWc95Ukr8GtxupYVgDo
         fwtA==
X-Forwarded-Encrypted: i=1; AJvYcCUcen0cr2uif0id7X3irShRbZc1ahi4p5Fy4nGvbFMQfGb4L85ievyl+VVyYsZEeV32ycjMBJEZzW4kMqnpKp3Oh7pZ
X-Gm-Message-State: AOJu0Ywlug+ZocpYBvB9jIHjnmUT3o/2+OTKSagn2WEQ9D3j7j+Y9Nat
	lSMRTY+s7BRbwcax36VNmYoucUR2z0g9yHVpe+mxIv+IeqCTVHHG
X-Google-Smtp-Source: AGHT+IFFBPbLvsPqvETCZgzDalx/rQ5u9mBZ4A9lbOV8OwYC1fOJ/j3B9ZO9w5U1c/5FFbrOWAdHCw==
X-Received: by 2002:a17:906:c106:b0:a4e:7475:9013 with SMTP id do6-20020a170906c10600b00a4e74759013mr4819566ejc.74.1712079546535;
        Tue, 02 Apr 2024 10:39:06 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709060f4900b00a472c4b9486sm6759704ejj.84.2024.04.02.10.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:39:06 -0700 (PDT)
Message-ID: <2147f20b0375cb8c45ef4d55f108817409aa19fc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Add bpf_link support for sk_msg
 and sk_skb progs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Jakub
 Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Tue, 02 Apr 2024 20:39:04 +0300
In-Reply-To: <20240326022158.656285-1-yonghong.song@linux.dev>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
	 <20240326022158.656285-1-yonghong.song@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 19:21 -0700, Yonghong Song wrote:
[...]

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 27d733c0f65e..dafc9aa6e192 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c

[...]

> @@ -1488,21 +1492,90 @@ static int sock_map_prog_lookup(struct bpf_map *m=
ap, struct bpf_prog ***pprog,
>  	return 0;
>  }
> =20
> +static int sock_map_link_lookup(struct bpf_map *map, struct bpf_link ***=
plink,
> +				struct bpf_link *link, bool skip_check, u32 which)
> +{
> +	struct sk_psock_progs *progs =3D sock_map_progs(map);
> +
> +	switch (which) {
> +	case BPF_SK_MSG_VERDICT:
> +		if (!skip_check &&
> +		    ((!link && progs->msg_parser_link) ||
> +		     (link && link !=3D progs->msg_parser_link)))
> +			return -EBUSY;

These checks seem a bit repetitive, maybe factor it out as a single
check at the end of the function? E.g.:

	if (!skip_check &&
	    ((!link && **plink) || (link && link !=3D **plink)))
		return -EBUSY;

Or inline these checks at call sites for sock_map_link_lookup()?
I tried this on top of this in [1] and all tests seem to pass.

[1] https://gist.github.com/eddyz87/38d832b3f1fc74120598d3480bc16ae1

> +		*plink =3D &progs->msg_parser_link;
> +		break;
> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> +	case BPF_SK_SKB_STREAM_PARSER:
> +		if (!skip_check &&
> +		    ((!link && progs->stream_parser_link) ||
> +		     (link && link !=3D progs->stream_parser_link)))
> +			return -EBUSY;
> +		*plink =3D &progs->stream_parser_link;
> +		break;
> +#endif
> +	case BPF_SK_SKB_STREAM_VERDICT:
> +		if (!skip_check &&
> +		    ((!link && progs->stream_verdict_link) ||
> +		     (link && link !=3D progs->stream_verdict_link)))
> +			return -EBUSY;
> +		*plink =3D &progs->stream_verdict_link;
> +		break;
> +	case BPF_SK_SKB_VERDICT:
> +		if (!skip_check &&
> +		    ((!link && progs->skb_verdict_link) ||
> +		     (link && link !=3D progs->skb_verdict_link)))
> +			return -EBUSY;
> +		*plink =3D &progs->skb_verdict_link;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}

[...]

> +/* Handle the following two cases:
> + * case 1: link !=3D NULL, prog !=3D NULL, old !=3D NULL
> + * case 2: link !=3D NULL, prog !=3D NULL, old =3D=3D NULL
> + */
> +static int sock_map_link_update_prog(struct bpf_link *link,
> +				     struct bpf_prog *prog,
> +				     struct bpf_prog *old)
> +{
> +	const struct sockmap_link *sockmap_link =3D get_sockmap_link(link);
> +	struct bpf_prog **pprog;
> +	struct bpf_link **plink;
> +	int ret =3D 0;
> +
> +	mutex_lock(&sockmap_prog_update_mutex);
> +
> +	/* If old prog not NULL, ensure old prog the same as link->prog. */
> +	if (old && link->prog !=3D old) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +	/* Ensure link->prog has the same type/attach_type as the new prog. */
> +	if (link->prog->type !=3D prog->type ||
> +	    link->prog->expected_attach_type !=3D prog->expected_attach_type) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	ret =3D sock_map_prog_lookup(sockmap_link->map, &pprog,
> +				   sockmap_link->attach_type);
> +	if (ret)
> +		goto out;
> +
> +	/* Ensure the same link between the one in map and the passed-in. */
> +	ret =3D sock_map_link_lookup(sockmap_link->map, &plink, link, false,
> +				   sockmap_link->attach_type);
> +	if (ret)
> +		goto out;
> +
> +	if (old)
> +		return psock_replace_prog(pprog, prog, old);

should this be 'goto out' in order to unlock the mutex?

> +
> +	psock_set_prog(pprog, prog);
> +
> +out:
> +	if (!ret)
> +		bpf_prog_inc(prog);
> +	mutex_unlock(&sockmap_prog_update_mutex);
> +	return ret;
> +}

[...]
