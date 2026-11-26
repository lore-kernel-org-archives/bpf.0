Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795722258;
	b=M7wz2OB1eL83Sm4088SdbdW72sKi7mW7aJ0LW0k+aONxS4C1Ro4TtDiTpwI5H/gveapF
	 aa5UmhgWh5HISCcTAdwi+bzZujnKj20Oi6ilkF0MRMurE1JoiDI65CVIHX3s0htV1nlei
	 2xm+uVfKKTU85jb/a/e9xw8ddHRem8219xC3xCEWAbA8mhjuWwQUFl7tg7V3wyMojqD+x
	 KVDYLCDebjjdYGMx0GB3AAcHdIiWgHnXxeN+3y5oWTLyNTLI3RFKVApAAy1lcMVlo0FqQ
	 ZclvmRbEQpKvYctBgOqr7PaHDKZSk8OIjURy7mEOsYYYxy4mE2RIU5vV0wIZji+gvcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722258;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:Date:X-Clacks-Overhead:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=/VeOoM8IZ9NB9AVZCDWfFjLfcEOJ01bHy1/Epj3tsYg=;
	b=l6vYCDUFBjZlXDFBZUa53GoIK/ywjR/AK+9sD71MnVMEo0ip6+zuZojck+wzthsleCbw
	 RGkC8y9zJ8CcgGh/rlQ3hnjqBsfAGWKlB7GT+1p+5z0Hb/kTmN7ITI4MCUFL3p8m0Rqr8
	 LKEQr+G8jTC38oPBXVi0K3IJZ5bx539h5F1lfjxEzhdZLdVghNUrBHBeY/nScfjIq8DaM
	 oeTHpYT0ebUT6YVjsgcgb78mUDHv1qtVg96ieb030LDBERmr2yyQHXmoCSd03DW6yCAo/
	 AyNXrno3nisuKTt05c90dtF4zHajQbcP63Gpz3hqn6Sa5ByM9E8PEYZbstKaJtlhgGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=iXVnNu51;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A594606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 19:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A594606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=iXVnNu51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795722249; bh=6xV19XvlsF8HGzU8uN77Yoe6D0bj/rvFMFUKDzicMZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iXVnNu51COf3M2AKI9Nn8dgD5emID8e25ziY0mVMbZhBO1TOQzcDucL0Iv1RPkrtF
	 fNnLa005tbbYYHIrK3iZaOk6w/o7fjtbqg81HrRXhj67sNPYGVuRTlrUKJq1JnheK2
	 H6+8bHBwyy+TXEXliow8yJw2I/HJW0WEtiPlcgwWjmK28/3wEeKSpX9tuJQaTo0gWN
	 qpkGFXb8+kmlYs6T1Rld9c6I6iQKBGWU4cRKkRNOfXSJZBkn2ElOszQZ3vG7nsVLf/
	 bmtqagEId9yWS8GknnyHM8AlHTjwaXVasWqyUQ9afuW+qYrPd2qGZAKWgAvlXhGUD6
	 XScpq+5oERydw==
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 4/7] libbpf: Move bpf_object_prepare_token()
 to object creation
In-Reply-To: <sashiko-outbox-235780@kernel.org>
References: <20261126-bpf-relax-get-next-id-v3-0-338e1d3077e7@toke.dk>
 <20261126-bpf-relax-get-next-id-v3-4-338e1d3077e7@toke.dk>
 <sashiko-outbox-235780@kernel.org>
Date: Thu, 26 Nov 2026 20:44:07 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87pkvrcr94.fsf@toke.dk>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] libbpf: dead gen_loader check and host token probe in
>   bpf_object_open()
> --
>
> commit bfc72a1132d0b5606c8e46c132afab5bec32d57f
> Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>
> libbpf: Move bpf_object_prepare_token() to object creation
>
> This commit moves bpf_object_prepare_token() from bpf_object_prepare() to
> bpf_object_open() and closes any acquired token fd in
> bpf_object__gen_loader().
>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 540daf7752b45..1f1569a35f92a 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -9281,6 +9281,7 @@ static struct bpf_object *bpf_object_open(const ch=
ar *path, const void *obj_buf,
>>  	err =3D err ? : bpf_object__init_maps(obj, opts);
>>  	err =3D err ? : bpf_object_init_progs(obj, opts);
>>  	err =3D err ? : bpf_object__collect_relos(obj);
>> +	err =3D err ? : bpf_object_prepare_token(obj);
>>  	if (err)
>>  		goto out;
>>=20=20
>> @@ -9873,7 +9874,6 @@ static int bpf_object_prepare(struct bpf_object *o=
bj, const char *target_btf_pat
>>  	}
>>=20=20
>>  	err =3D bpf_object_check_gen_loader(obj);
>> -	err =3D err ? : bpf_object_prepare_token(obj);
>>  	err =3D err ? : bpf_object__probe_loading(obj);
>>  	err =3D err ? : bpf_object__load_vmlinux_btf(obj, false);
>>  	err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
>> @@ -10543,6 +10543,11 @@ int bpf_object__gen_loader(struct bpf_object *o=
bj, struct gen_loader_opts *opts)
>>  	gen->opts =3D opts;
>>  	gen->swapped_endian =3D !is_native_endianness(obj);
>>  	obj->gen_loader =3D gen;
>> +	if (obj->token_fd) {
>> +		close(obj->token_fd);
>> +		obj->token_fd =3D 0;
>> +		obj->feat_cache->token_fd =3D 0;
>> +	}
>>  	return 0;
>>  }
>
> [Severity: Low]
> Does moving bpf_object_prepare_token() into bpf_object_open() make the
> obj->gen_loader check in bpf_object_prepare_token() unreachable and
> reintroduce host bpffs probing during offline loader generation?
>
> Commit d92defe04ad5 ("libbpf: Skip BPF token preparation when generating
> loader") added an early return on obj->gen_loader to
> bpf_object_prepare_token() so that offline loader generation (such as
> bpftool gen skeleton -L) would not probe /sys/fs/bpf or honor
> LIBBPF_BPF_TOKEN_PATH on the build host.  Because bpf_object_open() now
> calls bpf_object_prepare_token() before returning obj to the caller,
> bpf_object__gen_loader() cannot have been called yet and obj->gen_loader =
is
> always NULL there.  If LIBBPF_BPF_TOKEN_PATH or opts.bpf_token_path is set
> to a non-empty path that cannot be opened or does not allow token creation
> on the host, bpf_object_open() fails before bpf_object__gen_loader() can =
be
> reached.

I can remove the dead check for obj->gen_loader, but I don't think the
other issue is worth fixing; if someone explicitly sets a token path
during skeleton build and that makes the build fail, they can just...
not do that?

-Toke
