Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062494;
	b=zmfA1pGjCLsbZ+sasv4slibOmNk9c+enwasxXdFWE2X9buwe9hm6q9VcLSMtsDoYROp+
	 ppQplFsUy4pkyCmU9IjhjUQ4HUrPQhuKTHcNKdpZwHTd3pu4FjiP4KmnSGigHe9xE+/5v
	 xUi+qqrCXLLNCgjf7E5RmSpoIzAOeg8RJUX5y0f4O6XQv0cTSAVWllWOVqEYLzAD0zTEj
	 WT/AlvWj0HS6va9/s3AxwlIi9H1dJGi7Xm4hNLgEtjunc+JivzayX6IrpcDDjQUZn5DN+
	 Kcs6hrTayurSvcPYwxHjaS9B6sFIhXQHhpBKTDe10aLhbhjtJ+uLZhTTdNfN/9F8ZVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062494;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NQDkgt1n1TgP+Nr+A995ehf1Cjc4i+Umrhd3hedk1kA=;
	b=MNku7bJzfy851w/OTxNwrXk/d16++kZl5zQzx/+NTEBEv4QBKbr/znM3dj/EdNHYFCJB
	 g3UBC1M22YcdI0GIqXq/DfGUXztG1iEeF5iDYTxvLz3tgedmAiqKdYNYnUq0Vd/pY+PdT
	 rdFgfPKRGbBVkdA8TUVkWJNKhgINkBc6pNFitbtXtig77kNeoizd/n/kfie6d0NjFLNPx
	 EVZUJtzHxFDRX02NeF2EZdPNA6O7JIQiEbxgg7Ukoy3eCC+YEtidp8U9nnMjeuMnrEY5S
	 8pBCFvnHCEtr0CEjZbc7Mh3vtVSi8ZXxNj99OrJGMNidva7F8mMibOalEN0aYcr/5zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItRev573;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF7606D833
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItRev573
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD1C1F008A3;
	Sat,  7 Nov 2026 14:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794062494;
	bh=NQDkgt1n1TgP+Nr+A995ehf1Cjc4i+Umrhd3hedk1kA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ItRev5730tWWL3lBCpxzTXjkrU9G/ASpvtBtMLGQ52bi7n9TQdElEviiKpy6Xt2Q7
	 4Swdq5Xljkj0AEKxC8+TYxh1krE0AAP/RWogsWJHS+wF5MiASckCL9HUOO8Y25+Nd0
	 z29DcBjVa9pXRD391CC5riAPuDB4ny8BnbSReGJskCZkov8kgSufw7LPo7fqDqUKvM
	 wiRGzf1pnx63pPJU3/vHRC3mm0tGeWsMJpDAorLNE9qqzAsQ0ebOk4r/TpZraxiKqM
	 esH/GPONEArwb71I0YJf1gvcs/WCbQZ6saCWsr2dyUnRXMBeVA94vgUb3yB/c7dwKe
	 03m749Y9GRkbQ==
Message-ID: <sashiko-outbox-202965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Reject writable map iterators on read-only and
 frozen maps
Reply-To: sashiko-reviews@lists.linux.dev
To: AdetsGithub <adethyasrinivasan@outlook.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <LO2P302MB0197FAF0305A94F7575CA700BC752@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
References: <LO2P302MB0197FAF0305A94F7575CA700BC752@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 14:41:33 +0000
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
- [Medium] bpf: missing freeze synchronization in
  bpf_iter_map_check_value_write()
--

commit 1e3fa097f2efa9dcea1ba23069784fa975915ada
Author: Adethya Srinivasan <adethyasrinivasan@outlook.com>

bpf: Reject writable map iterators on read-only and frozen maps

This commit updates bpf_iter_map_check_value_write() to return -EACCES
when a writable map iterator program is attached to a map with
BPF_F_RDONLY_PROG set or with map->frozen set.

> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> index a58c148692e6c..d74e1152c7f81 100644
> --- a/kernel/bpf/map_iter.c
> +++ b/kernel/bpf/map_iter.c
> @@ -99,8 +99,8 @@ static struct bpf_iter_reg bpf_map_reg_info =3D {
> =20
>  /*
>   * For an iterator that hands the live map value to the program as a wri=
table
> - * buffer: the verifier knows nothing of the map, so the special fields =
of the
> - * value have to lie outside of what the program may write.
> + * buffer: the verifier knows nothing of the map, so read-only / frozen =
maps
> + * and special fields of the value have to be protected from writes.
>   */
>  int bpf_iter_map_check_value_write(const struct bpf_prog *prog,
>  				   const struct bpf_map *map)
> @@ -109,7 +109,13 @@ int bpf_iter_map_check_value_write(const struct bpf_=
prog *prog,
>  	const struct btf_field *field;
>  	u32 i;
> =20
> -	if (IS_ERR_OR_NULL(rec) || !prog->aux->max_rdwr_write)
> +	if (!prog->aux->max_rdwr_write)
> +		return 0;
> +
> +	if ((map->map_flags & BPF_F_RDONLY_PROG) || READ_ONCE(map->frozen))
> +		return -EACCES;

[Severity: Medium]
Can a writable iterator link attached before (or concurrently with)
map_freeze() still overwrite elements of a frozen map?

bpf_iter_map_check_value_write() is only called at link attach
(bpf_iter_attach_map()) and link replacement (bpf_iter_link_replace()).
Unlike bpf_map_mmap(), neither path takes map->freeze_mutex or increments
map->writecnt via bpf_map_write_active_inc(), and neither
prepare_seq_file() nor bpf_seq_read() re-checks map->frozen when an
iterator is opened or read.  For a map created without BPF_F_RDONLY_PROG,
attaching a writable iterator link and then calling BPF_MAP_FREEZE allows
map_freeze() to succeed while subsequent BPF_ITER_CREATE and read() calls
on that link still mutate the frozen map in place.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/LO2P302MB0197FAF030=
5A94F7575CA700BC752@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM?part=3D1
