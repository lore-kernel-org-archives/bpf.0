Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656448EC64
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992824; cv=none; b=qK2sdWsC/1DFllmvBAPa7vvetAVFhfdt1BNs/Z8gkZvIoPnNoHtBSlt3Xrm6Qb03h2x9FA5F+pmn42khdSefRwxjRqpEjy/fQMENZvuxSfqm5p9+vzeewNeae9cY2Sx6j9wP05RxIJWtdydiKi+JOtr3xAwcY2bfgFCYh6o2lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992824; c=relaxed/simple;
	bh=LB+qfaz6YdnbxjV+2oRihuPw0uTzVF9Yn8GNWXHeuNE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9dt6VrKVV6yPVgzEv5IvjJmDhjSsMrVrq+qKpsVlFKgwMb+iIE3rEkxWFdBjiTcBUliB+9p4LwCv8ajY51d/yvBTiF3hevaXC/6/+6Xa9F5abWrW/zMqVumuB6mDi+bP4x9YdjTAArsQD/TxhA6hQFEGTntiT+/Rrspn8tW67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3iE208A; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3iE208A"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f066d8so8602595ad.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 15:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788992822; x=1789597622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FoqDybzgM2u1Ti7rz161YwHGpjrOZvM7SVulyrgRa/0=;
        b=K3iE208ARtRxOlistRuy2sZu47/48gA3RxTnb81QTPJgbGoEeE6w8oHetSBppI+HrE
         onOqTODbzWR2L9QKIUh7bCTHIgtwXesFL90tPILhMaJhbEY9L2Bi51Q4jTdCXk/cYcsg
         mfT0Y56h7llcRfi0MpMwXG9dLuuWSWDo7Z8tp77jZjvA/xhug84Vlm04YgH5rYD1vC0e
         SljidOWmb/LLO70W5gII/3FK91VJ/srH97cCLeEp4SPuKtHgM0fR+3EVUICqRDbSqUU7
         1c9LhyCYFwwwz/i3woBsoda1WkYGehJt+oOs2PnNrgtpCQX15XuyYIk+hsBzIlzgOnLI
         1WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992822; x=1789597622;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FoqDybzgM2u1Ti7rz161YwHGpjrOZvM7SVulyrgRa/0=;
        b=iI5+A6uzQSJot6ve8J1WGA7w57g4lOf9L300CKeUU4sjNgPZ9GNZ1WHm0x2qdWEF4e
         zYTGSnWEWg/RCl5QxKIZC+3Yla4PycVoU4SbwxCYaYS46YN3OKoVcsHidpqAX3u8AxpN
         UPHYDOsR+NjJqZRUEnpBxivSJ0m+fUWXRH/HcIB1xWHA9Poe57DHxnPdgKlsMvymFTvs
         J+TzfB3bNZ68u04liegJXF5BU4cm8g2Flk/Hqj/zQMJG8AXr9eNVrI/tsVySZsbSh2QG
         4RFkfqdPzLEV2XJpBE8i3eMecZZ+hyr0SkWQLx5KaJEN0BWSCw5xluiPth1g+tntrnDx
         93/Q==
X-Forwarded-Encrypted: i=1; AKwUvBy9LE0EEHqxaW6CC6PkjR1cMRpMj51N9fzx+nmd68oufMLwaflSk3IprGx6ujJOguzJ0fA=@vger.kernel.org
X-Gm-Message-State: AFuF++l4v/UheKOXrTZ7SCJxLnL9HAnppWtucsI9xE94oMQKDGtBDDSS
	mO66PcrVd5PVfC6S5s9UCXXdjSqPYzINogC9igYn0zFwuztfTGNwmcNe
X-Gm-Gg: AYBFou3T33tz/Oa+l9gSBK55IKQwB9n+IGCn+b/EtgqanDZjDbf/4CEQVL31/8hdwtv
	wJykdvYlwLkhGpP4KmwE+mLlCEP1y0+QI6U1L7IjvdFbuSgG5I5ptr1+15dqqzjVmEKiguEP6x+
	3Xi9S8mxQTq+Ek+c/Tgwsn0Ff61E4f4x2nx0+Tx4xVmBIJOUBMjFptRQ//ci0Qd/0ihcoC9qg7K
	59wZk2kdEqWcypPF+N34jyhEkzIjCz832yvGA1e5TWtl+Tj98YLFPdDw/bUJUaVFJf6prgU5Y0a
	jAzlFgut+gF9iukBhDwTsBtkO6vw+1gvoPgfXw0uZoRV6tZceHWXTEK/kj2JprYtWgEYag0JURH
	my0aPrsCukr7zONwwp7k2mGfWCqyxp1mnFQFKx5SZ1rZ8+Qf0qsJgy29kTB9beKN6su6mj0BXQS
	4C9P9RkT7UhnJo5/GoTE9b+JIFkeGjfxcrmnHs/JN+xgkmbmjS8NkG050Mtfo5WI2Ic/m8Nzn8F
	1jW9TCZ5KRIQWKW7q7mDbFbLlU=
X-Received: by 2002:a17:902:e551:b0:2d8:d4cf:fe45 with SMTP id d9443c01a7336-2dd0ec7f206mr13292005ad.11.1788992821597;
        Wed, 09 Sep 2026 15:27:01 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db195a1a59sm76352065ad.47.2026.09.09.15.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:27:01 -0700 (PDT)
Message-ID: <e517c80062551871fa9008a223bc0044217354cb.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/18] libbpf: Add support for BTF kinds
 LOC[_PARAM|_PROTO|SEC]
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, jolsa@kernel.org, ihor.solodrai@linux.dev, 
	yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
 martin.lau@linux.dev, 	memxor@gmail.com, emil@etsalapatis.com,
 mcgrof@kernel.org, petr.pavlu@suse.com, 	tj@kernel.org, kees@kernel.org,
 bpf@vger.kernel.org, nathan@kernel.org, 	nsc@kernel.org, arnd@arndb.de,
 puranjay@kernel.org, yatsenko@meta.com, 	atenart@kernel.org,
 ojeda@kernel.org, linux-modules@vger.kernel.org
Date: Wed, 09 Sep 2026 15:26:58 -0700
In-Reply-To: <20260901165757.801449-3-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
		 <20260901165757.801449-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-01 at 17:57 +0100, Alan Maguire wrote:
> Add support for new kinds to libbpf.=C2=A0 BTF_KIND_LOC_PARAM and
> BTF_KIND_LOC_PROTO are dedup-able so add support for their
> deduplication, whereas since BTF_KIND_LOCSEC contains a unique
> offset it is not.=C2=A0 LOC_PARAM is considered a primary type
> since it contains no external references; LOC_PROTO is a
> reference type consisting of LOC_PARAM references so they
> are handled in the primary and reference dedup phases
> respectively.
>=20
> For BTF field iteration, BTF_KIND_LOCSEC needs 2 m_offs[] values
> for the associated KIND_FUNC and KIND_LOC_PROTO type ids in
> each LOCSEC entry.
>=20
> Add APIs to add location param, location prototypes and location
> sections and btf_is_* tests, data accessors for each.
>=20
> For BTF distillation we add location info to split BTF.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(Please see a few nits below)

...

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c

...

> @@ -4395,6 +4653,45 @@ static bool btf_compat_enum(struct btf_type *t1, s=
truct btf_type *t2)

...

> +static long btf_hash_loc_param(struct btf_type *t)
> +{
> +	long h =3D btf_hash_common(t);
> +	__u32 *v =3D (__u32 *)btf_loc_param(t);
> +	int i, vlen =3D btf_vlen(t);
> +
> +	for (i =3D 0; i <=3D vlen; i++, v++)
> +		h =3D hash_combine(h, *v);
> +	return h;
> +}

should v->flags be hashed as well?

> +static bool btf_equal_loc_param(struct btf_type *t1, struct btf_type *t2=
)
> +{
> +	struct btf_loc_param *p1 =3D btf_loc_param(t1);
> +	struct btf_loc_param *p2 =3D btf_loc_param(t2);
> +	__u32 *v1 =3D (__u32 *)(p1 + 1);
> +	__u32 *v2 =3D (__u32 *)(p2 + 1);
> +	int i, vlen =3D btf_vlen(t1);
> +

llm is right, the p{1,2}->flags comparison is missing.

> +	if (!btf_equal_common(t1, t2))
> +		return false;
> +	for (i =3D 0; i < vlen; i++, v1++, v2++) {
> +		if (*v1 !=3D *v2)
> +			return false;
> +	}
> +	return true;
> +}
> +
> =C2=A0/*
> =C2=A0 * Calculate type signature hash of STRUCT/UNION, ignoring referenc=
ed type IDs,
> =C2=A0 * as referenced type IDs equivalence is established separately dur=
ing type
> @@ -4622,6 +4919,12 @@ static int btf_dedup_prep(struct btf_dedup *d)
> =C2=A0		case BTF_KIND_FUNC_PROTO:
> =C2=A0			h =3D btf_hash_fnproto(t);
> =C2=A0			break;
> +		case BTF_KIND_LOC_PARAM:
> +			h =3D btf_hash_loc_param(t);
> +			break;
> +		case BTF_KIND_LOC_PROTO:
> +			h =3D btf_hash_loc_proto(t);
> +			break;

Maybe add LOCSEC as an empty case, same as for VAR and DATASEC above?
Otherwise if someone ever tries to dedup a non-module BTF with a LOCSEC
the operation would return -EINVAL.

> =C2=A0		default:
> =C2=A0			pr_debug("unknown kind %d for type [%d]\n", btf_kind(t), type_id=
);
> =C2=A0			return -EINVAL;

...

> @@ -5489,6 +5813,41 @@ static int btf_dedup_ref_type(struct btf_dedup *d,=
 __u32 type_id)
> =C2=A0		break;
> =C2=A0	}
> =C2=A0
> +	case BTF_KIND_LOC_PROTO: {
> +		__u32 *p1, *p2;
> +		__u32 i, vlen;
> +
> +		p1 =3D btf_loc_proto_params(t);
> +		vlen =3D btf_vlen(t);
> +
> +		for (i =3D 0; i < vlen; i++, p1++) {
> +			ref_type_id =3D btf_dedup_ref_type(d, *p1);
> +			if (ref_type_id < 0)
> +				return ref_type_id;
> +			*p1 =3D ref_type_id;
> +		}
> +
> +		h =3D btf_hash_loc_proto(t);
> +		for_each_dedup_cand(d, hash_entry, h) {
> +			cand_id =3D hash_entry->value;
> +			cand =3D btf_type_by_id(d->btf, cand_id);
> +			if (!btf_equal_common(t, cand))
> +				continue;
> +			vlen =3D btf_vlen(cand);

Nit: btf_equal_common() checks vlen for equivalence,
     so it appears that the above line is redundant.

> +			p1 =3D btf_loc_proto_params(t);
> +			p2 =3D btf_loc_proto_params(cand);
> +			if (vlen =3D=3D 0) {
> +				new_id =3D cand_id;
> +				break;
> +			}

Nit: It appears that special case for `vlen =3D=3D 0` is not necessary,
     wouldn't memcmp(..., 0) be 0?

> +			if (memcmp(p1, p2, vlen * sizeof(__u32)) =3D=3D 0) {
> +				new_id =3D cand_id;
> +				break;
> +			}
> +		}
> +		break;
> +	}
> +
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}

...

> --- a/tools/lib/bpf/btf_iter.c
> +++ b/tools/lib/bpf/btf_iter.c

...

> @@ -94,6 +109,8 @@ int btf_field_iter_init(struct btf_field_iter *it, str=
uct btf_type *t,
> =C2=A0		case BTF_KIND_DECL_TAG:
> =C2=A0		case BTF_KIND_TYPE_TAG:
> =C2=A0		case BTF_KIND_DATASEC:
> +		case BTF_KIND_LOC_PARAM:
> +		case BTF_KIND_LOC_PROTO:
> =C2=A0			it->desc =3D (struct btf_field_desc) {
> =C2=A0				1, {offsetof(struct btf_type, name_off)}
> =C2=A0			};
> @@ -127,6 +144,11 @@ int btf_field_iter_init(struct btf_field_iter *it, s=
truct btf_type *t,
> =C2=A0				1, {offsetof(struct btf_param, name_off)}
> =C2=A0			};
> =C2=A0			break;
> +		case BTF_KIND_LOCSEC:
> +			it->desc =3D (struct btf_field_desc) {
> +				1, {offsetof(struct btf_type, name_off)}
> +			};
> +			break;

Nit: can this be grouped wit the _PARAM and _PROTO cases?

...

