Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.215.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793389611;
	b=xQY1MF+Gsp5b62Y4GexK15hqMzX+pbWOMcZjn/yu9r5ZSHU27G4lqWs/e8mlLEPVSQqW
	 FJtDsN73FLWdv/Fm9j3yYfHGWH3x/23CbMeD2Z4VwRysUyaIMuOg71CJasbC4OmVSd78a
	 B3cIjsVNw14yeND9oj+gvkohWIdpVZdjGILwp29kZGEfNz0ivfyKF8Vazf+/JmZ3wv0Dm
	 JSm9JC+oU9++2cZQndgZx+3Fq9jaHLEmfDUH+9FGWv/N1M+t4flbznBNRpMn8q+EvhG9I
	 2psc+Lmt/K8HRXaJ+LKcRr9afgfTgvhqdf9T/gYt2ubCXvT8K5ONLJg9KwRaI6KhcIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CeYMnZ0Hs9kQNFmpvk862xE4RzZLwCSbGt+rYjnTV1M=;
	b=zfcshesnhSDqQbcl7GIudaq2+YhXSneGcDRLDzymsf1rln35bA2vRYBH6r/450JfuPjV
	 FDUBsynREu5UFDwLOMregl30DOLDqaPpzrrpk3A0gq/R3uGmFgqfCKrcsFhlhGNkuOkdG
	 V9C+FknIBY40dx1qXlzbfsMAUoxuJ3yz+GLUFjrsuHY19o09KWPncKuNzH5dxWOMul+Dv
	 oK7DPmWpn31FW9r+u4PmBZ2Gh0YTIeNSpLTJeHJOZgNw44Duxq16Wy+kGVKkrPRF/2qkp
	 BeYwAEOYd48j+rZCSK976qk4I3M8b2rfM33JH86pmyluuwPo/nOKjRTAuGgb7lPXAlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W7nx3wsk;
	arc=fail smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE05606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 19:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AE05606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W7nx3wsk
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc758830601so721852a12.2
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 12:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793389610; cv=none;
        d=google.com; s=arc-20260327;
        b=c4wlIUrLAoZnaX82dq4Kim1lbi9rCWOymxMEgx01pGNCvnOgwheRS+lZvPkr58U2yV
         s9sSWdRNXjnKUmcw5hASYAZjzgEsfGLDHx2j3hcsLZ2JQWQ+L9Eww7iVQWf/wauc2CFr
         l9Nh6/XKC1E1lFYHSiq1viNh6jH6rN9drDyLy+oqewj1PTryb/5B3J03bt2+2yZfFrV8
         ov2YIXYpNx4avxclgrjgjZrFolPJ6b0cN1/+Uyjl7cS20nO5vApIlir9nIA7gKeMlTIQ
         4u4KxDi6t5qnPzarmEP+ZW+qEk2CSq0tJQLBSfNgTa6cOhU0nIm5UkLQ5qZk6MCjVLEF
         NhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CeYMnZ0Hs9kQNFmpvk862xE4RzZLwCSbGt+rYjnTV1M=;
        fh=9KciD38eiNv/Fsorxi0Gj6k+MjE0StraRyWCkP8Hn+M=;
        b=DeLK5cgGmhf69MgzSR9Pbf7IX3Ey+9ZR439vAnDFgB4k38AMkzWZ5bEhMecgQRd8j3
         dTtkLcUb1kq6ygc/6phAablTdpZLomRqk12D9Tlg70tdv4BlatgWv2ldSs+9RUHV0k2a
         BjlwTYntYW+hYShSYavxdd4ZWhRlQehxnYDpY1/5HXP0qGWqdOf4k4hgCcYY17cSqvgV
         1eulfTMqQeV/aJADE2VmDtDT643ma5ifOPYMutpubzQiKiUUzbkbfeCFe9hlLYPaODRs
         7wsHEsqsed7eDAiEhZHhB2q3/KiRkK5076MPH3TQwtw6Wn/1fq0oOT1W1dFjH/60pOGO
         Rr5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793389610; x=1793994410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CeYMnZ0Hs9kQNFmpvk862xE4RzZLwCSbGt+rYjnTV1M=;
        b=W7nx3wskyb2ms97zKTp/IUvbkm16RpUyZ7ZVI+nDMuMj8eOaoVJbzfyvFZrHU7QioU
         pX24TlS91J9chO/RJ60ZdnEagbwf0udpmfqMNxLCXD8ZguUf1j2N6/RUNU/pZmR8Lrny
         joxtSu4vFkkfBstV4lB5alhZNoLYuDwGa1D71oUxMYjjeHJp97KpmQRBLQNxFwshfNhp
         haFOoMzVolc2eL8JoIYkDcTJUMf72TEXBLVWB2D/w/GtqkQo86wr99nPARpuTfTgXbkf
         d1+stu8r0+utru9aQuGaequzrvuSxF/AQkyQdTgNOTWILDUh2LbOeagZeQKHCzcFq+TX
         d1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389610; x=1793994410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CeYMnZ0Hs9kQNFmpvk862xE4RzZLwCSbGt+rYjnTV1M=;
        b=gBYDfReK4m1F8Y6DvQqCtOcJaaIjtJ90oLBGZBTLx0BbZy8O5V7wPwTL9qmBZTyjU/
         l/LlRrIGoffT0ITiQXdeep32tIeq2or5VM0R7Ew+RuO2axdc+9YWuGN1atsaiHG2AdzA
         4X74IBy5KU1bd3pYdpTldyXgxcX+7O67p3PrX/qRiRuyRrrwBTc3kfu9vqTDh+nwj9lR
         jf39T4Gx8omoi8OspOfztK9HtLUsyBhCogYlSL0LHkCm86iMy002pA4ZPx5eVHl+TpdU
         JV39TsWpezBF0nD+1pxukcDnvIEXQJECunJC19bv/f3N4zrGVtfqBAcYYLZhKgCLQZIo
         NfOA==
X-Forwarded-Encrypted: i=1; AKwUvBxlkw945/OHKSvhOFtQDoUgs5WmYlsLEoqwxmvyyB9hQ9Erk0VT4AKsEo9b5xlsE0TzHpI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDuBV5G/AlgjQu+KI0G/BA6gyPuKNst4m8bMuyEsDjoWLYF/e/
	zVud6RZa9zLrvoygH57hSZuje8X+VrEC4Im/Z9XhwzMAlzeBLhWXwV0+oe4QCNOM0V22LFnySYr
	QzQQt6RaxTuWLBYdQq1GGzeibtnOC07s=
X-Gm-Gg: AYBFou3hjz+NSqeCBOC0Zt2CxmE9dBNKXFGtGDQgKJZTmMB1ViDXSU8WxCwUk4JQUZ9
	20OEroJapvXGp/GYmhpoB0GGlK5TpQR8Jmo/fiol+luG4bam1S1gvC/cI+kkukj0pzX/ndYCE35
	2JUGS4vhC4J4t1DJ6geuTgdWrBVCALg3XxYAVlYWCKUTe9vh+L+ozfaN0GkXbH/KTQa1RvrXDok
	mpcaA77aBJgmg11GXJ/qSllCNC4P3c4utt8392NWpgQQ1r0cnINR7lPQC3jdYKdUJA8SDMtqnOX
	TUqSZISVoqaoBowZJ2LaDa8Sfrt6nU1E2cuHV2n2KXxV6sLT67H1FqGECVZKkxT4wPKuBp68LyI
	MDQH3blnCbnHZnr7FkqrmUBThBmr9RnOZHLew9JAwDtOS9TiPB1Nd02U6Uj+5zFKmmyQv6piS7h
	J6444mKdZDnCNyw8SlbRMdfusq67ED3SzARw==
X-Received: by 2002:a17:90b:28d0:b0:3ab:36c4:b500 with SMTP id
 98e67ed59e1d1-3ae895743ddmr2828942a91.5.1793389610430; Fri, 30 Oct 2026
 12:46:50 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030090913.76944-1-dennylin0707@gmail.com>
In-Reply-To: <20261030090913.76944-1-dennylin0707@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Oct 2026 12:46:36 -0700
X-Gm-Features: AclHuK99K7jolqpzeCXX2GNRVUBbkjuXo-dgHHmAo-9xOFMWgJ48dDT1RplKGj4
Message-ID: <CAEf4BzaMDRa8xD1oR587P82MYKCYR61gyjgvjKySSnnqFb27pw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpftool: avoid sign extension in unsigned
 enum JSON dumps
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: qmo@kernel.org, bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 2:09=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> The BTF enum value is stored in a signed 32-bit field even when the
> enum is unsigned. Passing it directly to jsonw_uint_field(), which
> takes a uint64_t, sign-extends values with bit 31 set. For example,
> 0xffffffffU is printed as 18446744073709551615 instead of 4294967295
> by bpftool -j btf dump.
>
> Cast the value to __u32 before widening it, matching the conversion
> already used for plain-text output.
>
> Fixes: c93cc69004df ("bpftool: add ability to dump BTF types")
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  tools/bpf/bpftool/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

please drop RFC tag and report with Quentin's ack

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index abd661db91e6..385521e6b028 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -482,7 +482,7 @@ static int dump_btf_type(const struct btf *btf, __u32=
 id,
>                                 if (btf_kflag(t))
>                                         jsonw_int_field(w, "val", v->val)=
;
>                                 else
> -                                       jsonw_uint_field(w, "val", v->val=
);
> +                                       jsonw_uint_field(w, "val", (__u32=
)v->val);
>                                 jsonw_end_object(w);
>                         } else {
>                                 if (btf_kflag(t))
>
> base-commit: 7101b10cf281f629ac58c99697ca6f6d082b99a7
> --
> 2.43.0
>
