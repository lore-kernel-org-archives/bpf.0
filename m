Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905C518155
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756508; cv=none; b=CracqZrYbIBA1i50eWb67AdT+xYSyg2EFh/AbD/PqBo48m0MesMxj0plYcRPXs/H4ucOH4Hutqy9CCv4tkQevZHp3Ui+i28dEo1TRRpxiMQF56R14uNrae0rp+dWXOk+PMCfLDU1Jw2jRg26mDEFPSJKXGRbcHpWRIQ64zIq4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756508; c=relaxed/simple;
	bh=IZQkC7q4WlqaqawfmTdELQgW8PLPnhmHUz6qXWUo32E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWbGo7BrEO82QlkCqfmV/kzMTYsQj+cPi48H40GLFeQKvU0gSGIwEL7clM/T3Bjt7phqFNKxXAJy0ym5MPF6LyK6d6C6t8YHU1jVp+pqF578unSzfltEwawPWTDhVcZYlgkjiIHAoeUf0H34TpaRoqKVnMKE7tFX8H5lqnG4ZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jP0IllLG; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP0IllLG"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f7so7917265ad.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789756501; x=1790361301; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nVqw5PJZe1oyV/mC4YrYdyGHr2QxufjLUBCKW5hMzdQ=;
        b=jP0IllLGUGQfv7xJSkzDO6Hx4PshOmH7dt1rUDrYqrOd7sSp4dqqfNmcvJdksTYBQ/
         q1L+IYFb8vqEW3CYEF4ZzdCoafR1BpHzVJuQRCC4r59k8YS9TGLKosrgMPUyTfMAAkEq
         RgXwcHG3B/fK/BFEuKiCLgfpFrKzHg4Q/ZnOrVymgdu+63x6fX2lPLpYET7K1B8wsBHx
         69qr0UMRwn2AoFQpuZ+Cl2x9O8LVfyoki9IoqLQ4mnSOSA8GmedDDV6iOAJt74x3Mqy9
         W4zkNiNSrBHqBVv4J/Lpg6C7Fvx+nXBjkQS8+basTjF0c/Yxak42gXKfqgvmEK0D+7/O
         FUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789756501; x=1790361301;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nVqw5PJZe1oyV/mC4YrYdyGHr2QxufjLUBCKW5hMzdQ=;
        b=YD0Hs9K8/VG+qwseD/viLpCAhDR5s0CpPvHcJodok8o5+urc2JQAiCCJ4TazzTOHCC
         7Z2BenRXO0Pf4S6Dnq6aP4eQjMojreDXogbJDmwlJdujJRsrcAX3mwuCqYBL8cmVfcuy
         8LotVNUAQBbSyfEaqz9LI75utu8gReltHEOv06AWLi6oJY+Iq3Z0nrK+DUod6tU5lJRk
         ZgXDtuzdXndUn2H1AaqAhvsFGj7Ef3I39jU8/UMHaJcvVTiT3Lz+nYxF9Kb5Exgy3jUx
         gmIqU/nBLqmaw9v0XkdD1iHISGuo81UdgymVeT6La6ck5vGJtIae7usvF+Tsi1gYdLDp
         PQ2g==
X-Forwarded-Encrypted: i=1; AKwUvBzI7l5ATz+bOQ2UEubYT6SyyFV/XGOsNfFQNnduJDCIDbtX6GUTcsiCYBliZx+nv+vquMU=@vger.kernel.org
X-Gm-Message-State: AFuF++kfnMRajs/RAkcSNfqHEY3bE9bOMsfm+Dner4ZdDPWSanOuYp2u
	1d1wde4keSMAs636SnyYgDEFqVrg1UVPkGjY6hF6NiZj3JIofGbqXRZa
X-Gm-Gg: AYBFou3ZS+ok6AgREyENlB6HaRlEVCzqXZ1Q4PGHlAP+pifOXAeHipXC+tqYONuYe/u
	oY8QCILucSDvbRRKUqUc0b69CHnn93KBTtZl+szivlmbB1/7e5CkCq/tF7KRpZ73cogZaqQiDUj
	D7SCEVnfRl4Pcluo5hmi7fhasRuTJs4k/ajjhxt5xq7/oLV2jNZDHPGISWEz/ZKskNrDze3AvFT
	IgBlRwpFZm04nLzHyhpDvCpRvuUemPH79/Hqzs9kAqmvoN1u0KLSB1PJn8puzDbAQgPw6nuVihI
	Ef8bf+NuHmou4BqA2YTxTxIy12zpTR10+jXebMm3rGawFy5yoOCVd582a2OO1+5+eAXQf9CSztn
	IYspsxzNZovRCVgEiDrOKJESQb+9sNlx9tCR7d4x1sgEx/+wBSxMG+1eu+mroQOfhM/R6FJ6b5v
	lecgKCsQ33LIsWKhiC0o4V16RFwStdqxSs2Joj+NlgW1JQEvPBsw2fxPHQuedIlHTBW+e+dLhdx
	oR1impqBx58a8nvS+owdEhDuECq5mhIwV0S84iWJ4AdtP9vYKFULH4Mhg==
X-Received: by 2002:a17:903:3c43:b0:2db:5f8c:b81c with SMTP id d9443c01a7336-2ddb1b86d9cmr69719445ad.19.1789756501022;
        Fri, 18 Sep 2026 11:35:01 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e136:8952:772a:93a4? ([2620:10d:c090:500::4:e681])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c32da4960sm621183eec.0.2026.09.18.11.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:35:00 -0700 (PDT)
Message-ID: <156233341a2694196f96f0dad569f8dcc5eff1fe.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/11] selftests/bpf: Test helper support
 for BTF_KIND_LOC[_PARAM|_PROTO|SEC]
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 andrii@kernel.org, 	jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev, 
	song@kernel.org, qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, 	yatsenko@meta.com
Date: Fri, 18 Sep 2026 11:34:58 -0700
In-Reply-To: <20260916074118.1007116-4-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
	 <20260916074118.1007116-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 08:41 +0100, Alan Maguire wrote:
> Add support to dump, encode and validate new location-related kinds.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/se=
lftests/bpf/btf_helpers.c

...

> @@ -203,6 +206,37 @@ int fprintf_btf_type_raw(FILE *out, const struct btf=
 *btf, __u32 id)
>  		fprintf(out, " type_id=3D%u component_idx=3D%d",
>  			t->type, btf_decl_tag(t)->component_idx);
>  		break;
> +	case BTF_KIND_LOC_PARAM: {
> +		struct btf_loc_param *p =3D btf_loc_param(t);
> +		__u32 *v =3D (__u32 *)(p + 1);

Nit: use ->values[i] field here?

> +
> +		fprintf(out, " size=3D%u flags=3D0x%x vlen=3D%u", t->size, p->flags, v=
len);
> +		for (i =3D 0; i < vlen; i++, v++) {
> +			if (p->flags & BTF_LOC_PARAM_SIGNED)
> +				fprintf(out, "\n\tvalue=3D%d", (__s32)*v);
> +			else
> +				fprintf(out, "\n\tvalue=3D%u", *v);
> +		}
> +		break;
> +	}

...
