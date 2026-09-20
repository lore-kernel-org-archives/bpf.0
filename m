Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72AE31D39A
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 06:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789884073; cv=none; b=AnPXH8H3m8vWz2lJFTF1A1JI5BLzubCqvhNDPJC1GU4vch3VwLcW49iJMgsg/SF5dOjLHH0IzqCEv1MedibrRqpTxskMT0coNGc8Fc3+FyN+bj022F4ORfHuZnG9/qO3iW4Z7oIZNlCU4vKSZ6B2e9ddbwS9UAB7OPrsTNmx2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789884073; c=relaxed/simple;
	bh=qJJ2tU2MydiGR5/7k41lt4fADJqYIqQRuMqsQ7qgJ1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NGJd1KEew3bCb7QPl6/VVsCWbHYvnkFutRs1RNRImPn775ngYKXMGGI1xKxZAFwkoIbwI3ZCvBiAr22LND75EIfPK3rQN/nIN+jUdKJIpypu0m3tit1qJl5rZWLOv9wqv9rs2cLgWSZ8920gizjy2hEV5SCNd167NHlDAvD/Rds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHZDDmUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHZDDmUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9011F000FF;
	Sun, 20 Sep 2026 06:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789884072;
	bh=ablm1lcVRA2SPK/r1zW8O7laW4af410ZQ8sp8/GYNxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aHZDDmUEJwT2lYGnV7Oao4aeegtRXEwaFZ/R/5H/SDWZLb5iBLv+kqSNClnSfwdVS
	 gNsyB+/GGXOXMppJQpXBdnJ28hPa+DHonWnT3Tmc+3MQtH4G2sxrvKbRuIiTF9bkH/
	 w0TGqkHooEJmDPtW6T6hTh2Z9awlQbeK5cELS7g47pF402Nnqm2m0j3qY/LL1qMBnt
	 PNaYG+x1uO1Bqs9LrKLeb6NbV3wJZGhKsBfXbxqekq8ntDHvPsTnvXbJVj15S9QbBZ
	 YpsegYO9YkWoERN3ZlV4yFxMN8KCY1ZMB1d8lus+c3Z1TZD4YmZnv8ryfLvoSOOsUv
	 004MI79s/MD1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 16/20] libbpf: Carry the exception cleanup
 table through the light skeleton
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920054347.872462-1-yonghong.song@linux.dev>
References: <20260920054225.864535-1-yonghong.song@linux.dev>
 <20260920054347.872462-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:01:11 +0000
Message-Id: <20260920060112.1B9011F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: Integer overflow in cleanup_info_tot_sz leads to heap buffer =
overflow
--

commit ae662736be5da05d165c478a926196fe248e707a
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Carry the exception cleanup table through the light skeleton

This commit updates the light skeleton generator to emit BPF_PROG_LOAD
instructions that include the exception cleanup table. It stores the cleanup
records in the loader's bytes blob, calculates the needed buffer size, and
byte-swaps the records for cross-endian builds.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index af3a04f161ac1..2345fbdd46f56 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c

[ ... ]

> @@ -998,6 +1000,9 @@ static void info_blob_bswap(struct bpf_gen *gen, int=
 func_info, int line_info,
> =20
>  	for (i =3D 0; i < gen->core_relo_cnt; i++)
>  		bpf_core_relo_bswap(cr++);
> +
> +	for (i =3D 0; i < load_attr->cleanup_info_cnt; i++)
> +		bpf_cleanup_info_bswap(ci++);

[Severity: High]
Does this loop write beyond the allocated buffer if cleanup_info_tot_sz
overflowed during its calculation?

If an untrusted user provides a malicious BPF ELF object with a very large
.bpf_cleanup section, load_attr->cleanup_info_cnt can be extremely large.
The loop uses this un-wrapped count to byte-swap entries, writing past the
end of the buffer if the allocation size was wrapped.

>  }
> =20
>  void bpf_gen__prog_load(struct bpf_gen *gen,
> @@ -1011,8 +1016,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
>  			       load_attr->line_info_rec_size;
>  	int core_relo_tot_sz =3D gen->core_relo_cnt *
>  			       sizeof(struct bpf_core_relo);
> +	int cleanup_info_tot_sz =3D load_attr->cleanup_info_cnt *
> +				  load_attr->cleanup_info_rec_size;

[Severity: High]
Can this multiplication overflow a 32-bit integer?

If load_attr->cleanup_info_cnt is a huge value (e.g., 0x15555556),
multiplying it by cleanup_info_rec_size (12) will wrap around a 32-bit
integer.=20

This would result in a small wrapped value being assigned to
cleanup_info_tot_sz (e.g., 0x15555556 * 12 =3D 4294967304, wrapping to 8).
The resulting undersized allocation passed to add_data() would then lead
to the out-of-bounds write in info_blob_bswap().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920054225.8645=
35-1-yonghong.song@linux.dev?part=3D16
