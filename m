Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804D3D1CA7
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538102; cv=none; b=cVvdOis2sjDxTKO9XlpM8HBq4WabbFqaxLHT3HKBadv76X6Y6VkmVom5zxUPtMutTM0Ngc7c/JTHJyMwcMzwVJsL6X74WiD0qoK+M5yaMZu3RiAZXvkVaKdO7xulvLsEBZSEsbmENVllq5ahdwXiV5FUvPOs569QtR9BXpVgnvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538102; c=relaxed/simple;
	bh=GmqZdwFkLdyb/nXXBEuQdcvZo/D+zeMbOHpH8ifaGQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=thNjRjIuJBqs3pFt+v1RqWFFJ7paYPltRcu19WKb0xp7NOpCnnpBCv+WP07U+BtdKQYJbiOeEHnQjiXxwVRUnFQJqyyR5ZIA6czplDNijf05sfEij5Ayq42IDZSkKbTugd+gghorGp+CvQLL0qcRMyZ7y30i4gI4oyQNuZQteI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh4Vl82c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh4Vl82c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DC81F000E9;
	Mon, 20 Jul 2026 09:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784538101;
	bh=z5t1dU6iRjhpqA5h+GXJyQ7xgDWQSQq53YRFF5X4aPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eh4Vl82c1et+C+ZXBMhnjsbw1p6hyQ9bmpjEs5upmwp6qcJFrNAUy5+oS/ujZABzf
	 eKoiQbAIS87/G4VIzKZpmnjDAbI6EcmI6/Ym8FvDuVwLkHPdQjGqPUpPKw1u8A917E
	 zwPCbsUkNkl0uj0dfwCWf7+uW4HeQDYE0xy+2+bVy6FsLPcJZJPdWExiDyVFIpDnsa
	 U7NqysEm/V9978R/fTzYAuK0yD4BoRSxDlBrnp8EyIkVCXVvPOy69fbbqk0RlBk0HM
	 8Rxopy1sEyIu7+Jh0fpeLLriKFJzFC67iVLf+9nP0X/tBQIvfRc0oX0/5MDkbp+nvv
	 wDdWNceqn1nnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/9] bpf: Factor stackid_new_bucket from
 __bpf_get_stackid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720085351.655075-4-jolsa@kernel.org>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-4-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:01:40 +0000
Message-Id: <20260720090141.54DC81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly introduced `stackid_new_bucket` function accepts `trace` =
and `flags` parameters which are completely unused within its body.
--

--- Patch [3]: [PATCH bpf-next 3/9] bpf: Factor stackid_new_bucket from __b=
pf_get_stackid ---
commit cee0ea77a9c1144b54fb0472b1788623044b5650
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Factor stackid_new_bucket from __bpf_get_stackid

This commit factors out the bucket allocation and initialization logic
from __bpf_get_stackid into a new stackid_new_bucket helper function.

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 7bc2a966e3e81..48a2e28f0c68a 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -559,31 +559,53 @@ static int stackid_fastpath(struct stackid *stackid=
, struct bpf_map *map,
>  	return -ENOENT;
>  }
> =20
> +static struct stack_map_bucket *
> +stackid_new_bucket(struct stackid *stackid, struct bpf_map *map,
> +		   struct perf_callchain_entry *trace, u64 flags)

[Severity: Low]
Are the trace and flags parameters needed here?

Looking at the implementation of stackid_new_bucket() below, neither trace
nor flags are used anywhere in the function body. Could they be removed
from the function signature to clean up the API?

> +{
> +	struct bpf_stack_map *smap =3D container_of(map, struct bpf_stack_map, =
map);
> +	struct bpf_stack_build_id *id_offs;
> +	struct stack_map_bucket *bucket;
> +	u32 i;
> +
> +	bucket =3D (struct stack_map_bucket *) pcpu_freelist_pop(&smap->freelis=
t);
> +	if (unlikely(!bucket))
> +		return NULL;
> +
> +	if (stack_map_use_build_id(map)) {
> +		id_offs =3D (struct bpf_stack_build_id *)bucket->data;
> +		for (i =3D 0; i < stackid->nr; i++)
> +			id_offs[i].ip =3D stackid->ips[i];
> +	} else {
> +		memcpy(bucket->data, stackid->ips, stackid->len);
> +	}
> +
> +	bucket->hash =3D stackid->hash;
> +	bucket->nr =3D stackid->nr;
> +	return bucket;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085351.6550=
75-1-jolsa@kernel.org?part=3D3
