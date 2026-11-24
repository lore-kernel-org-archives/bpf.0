Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501080;
	b=Q4UtC5CT/d9EU9/FPgDaV879BqQshig6flGWC3+DxoXb8734u3aM6lXbnLLi/t0TFr8V
	 fDZUbKYFvwa/kVhFMuQYGvzsu9NCe3Cop1k2VzPfl8AmmkykG4mYU3/WU18AbNxUMSxMl
	 uTNkxOOBM11YSNK5pt8A7VvEDhv7nh36Lq2VfUnYSej6Aa2rHAuDrnPRhNDW3LMX3Z0Xm
	 aefQAsB5tW4znl1Opi780aoKEmRTCsL6tb5e1mtJ9JCp8iPFw4xWIIibEKfVVAfgVDVrr
	 cGZwQ+aIaHRtRWQKoYeIq824eezdfdCpYX44ZDgcNR1Dyyo6pKSmgdRVuOlkYtoq1xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501080;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vx5SJ/tGUsAcJ/MElZq8UTSM9S0k4FwLjNuh805EEcI=;
	b=wbzlhuL5GcacW8TtrFeNqGP4AYbYjikfKl8WtuRH4JcbWumx9Ky7cV015gQE7LoKw2mY
	 g7a7MZNQLIawRdjQzjmIcYDSk5uXMQkndKOkhRDTMGMZnwuSlhdQpOdNwSvj+FvhDXn96
	 7zs3lt6Zb+3QHgf14MtXjC0MQOy020XyQQKARMxk6146XzIVbZ8i+1thuxdLiA0Kxv/l4
	 GKrbLEXbEiFa0XoE5iXo185+NIlUt1+VpvpKoToD1kCjLi7rlxuGfi5gtWQXWNRVq+XbR
	 Xl7nParkbYSeH1teUtwMxBwFu9h6nzI2wGCxdkWIgXrEOmKlhqadSzLYEJQHwWPhXOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVdSflMO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FAA606A32D
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVdSflMO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5791F000EC;
	Tue, 24 Nov 2026 06:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795501079;
	bh=vx5SJ/tGUsAcJ/MElZq8UTSM9S0k4FwLjNuh805EEcI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OVdSflMOZAiepOPAL6LcSYWesiQAacUuxU7UERodpvihJzcAoPJu0JK/cR/+vn4ie
	 ZEmxy/OdyrXQbdTMf7PbtZpHYs4WAN0tL88iUj6AhCXesFybYNpZGh0aStTpB7L7bT
	 tIv6uBScHi9b2VmKd4BmFXKhThOMkYENSgWfnJWO56/SQuOrl09BbD83O9F2QSyNW+
	 PSKiMaBytnsJu/Cc7gZwPtLKiqtRDhJ5j2pV5fRkNXnLD7sKDYsZUzsxJhmESfnT3S
	 tVLy1QBup6OP6eLuvJAAS2wDO9/ENRVBqRQgHI0EQU/6VHZONoQ1cWICU7haGSGDW1
	 VPHlVIKN0kPMw==
Message-ID: <sashiko-outbox-230585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/4] bpf: Plumb local storage context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261124060357.11700-3-emil@etsalapatis.com>
References: <20261124060357.11700-1-emil@etsalapatis.com>
 <20261124060357.11700-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 06:17:59 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf: bpf_local_storage_update() 6th arg breaks selftest
  fexit_update() probes
--

commit ab094afd08fb6622ca0c449a168c674fa21d6976
Author: Emil Tsalapatis <emil@etsalapatis.com>

bpf: Plumb local storage context

This commit passes struct bpf_prog_aux as a hidden fifth argument to the
bpf_*_storage_get() helpers and threads it into bpf_local_storage_update()
while consolidating local storage memory allocation into
bpf_local_storage_alloc_mem().

> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
> index 6c643ac510799..28f6ffbd75741 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -213,7 +213,8 @@ bpf_local_storage_alloc(void *owner,
> =20
>  struct bpf_local_storage_data *
>  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> -			 void *value, u64 map_flags, bool swap_uptrs);
> +			 void *value, u64 map_flags, bool swap_uptrs,
> +			 const struct bpf_prog_aux *aux);

[Severity: Medium]
Does adding the sixth parameter to bpf_local_storage_update() break the
SEC("fexit/bpf_local_storage_update") probes in
tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c and
tools/testing/selftests/bpf/progs/task_local_storage.c?

Both fexit_update() programs still declare five arguments before ret:

tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c:
SEC("fexit/bpf_local_storage_update")
int BPF_PROG(fexit_update, void *owner, struct bpf_local_storage_map *smap,
	     void *value, u64 map_flags, bool swap_uptrs,
	     struct bpf_local_storage_data *ret)
{
	if (IS_ERR_VALUE(ret))
		update_err =3D PTR_ERR(ret);
	return 0;
}

With aux at ctx[5] and the return value shifted to ctx[6], ret binds to aux
instead of the return value, so update_err is never set when
bpf_local_storage_update() returns an error pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124060357.1170=
0-1-emil@etsalapatis.com?part=3D2
