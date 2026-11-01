Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494099;
	b=POp/SNtLzMUVebeRMQKiB3WeUXQ+I7H2RYKi7qNGOAzJsxLVjTrLOwT+BCJ8si3vefL7
	 hkqXZLXZo0AtdBjMxhTaU3ZAEKCNH5zNTLh53Xaksby6Zva+W2TlSPYTI1qB+VMuIrHj0
	 Uy3p3YvbWLHChMNzzEGnKWf9RdqYQW+5X0U6xP4aVINWJdnzpHPfHBveTIsLwIkV1016m
	 +FGYhzZk7BDotSnRhC6UFUfIK8U2BAdTRR5CbQP1pj2lhKxyzh1Z9QOJjjdDMmrDFXYgq
	 ud0XxmnHNwSp03epAqTbt49Pp3zvefHfcej9LoZgnSdkKhH/s2lukraIbIjmqUltN/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494099;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=qiBXgiJ9Ba/bNGwnar9WXOyZXhMwdXUsGURoDBNNhxM=;
	b=SP+RKjBQpuTYeKwfD2cvOb7ifrpeoF/rM0GaGUas1MwEJxJnyUlxBxaBAZZ8jglF54ff
	 uQ6ZO8g/PEc0fzU2KaQJ4/VXt5rFuyzqJxy/ALU61s1nv40qX1hN72QFll8gsRwrOMzxs
	 G4sw5FuHLwU8Dg9+kTWC12VLS3XHpZ2ZMc8D+Kv8l45Mjfm6gUGHha3bDg6Nz2y2LTZDZ
	 z/fHMDK3+bp43IJZPz1XizcmgIsnvWD+wVnJDtqQdHZMOdahRRkbxFgikwMfW6j6hnEkD
	 1kTVecsopjIxsJFgMqmIG0aQog4MdIL2L/qtHzJiI6vI/E7HM1wkaifrHtfoPfEHaDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSJh+GzC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5C606A31C;
	Sun,  1 Nov 2026 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSJh+GzC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEB81F000C1;
	Sun,  1 Nov 2026 00:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793494098;
	bh=qiBXgiJ9Ba/bNGwnar9WXOyZXhMwdXUsGURoDBNNhxM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BSJh+GzCX9mk5P3FNT7SjonJ8t+ZGYLLvRzGJDR4YNY1uEaWO1Y7KDdnFA1sgGekM
	 xgIETOzGAfMeDXuZ0SWEt31cZ4Q+0Cuf/MaoTZA8IbgNrey1PEdxe9/bkrFhvUo9jF
	 QxrPveNMbjNY+YybcxpUOEzaUmm4XRk6lmX2W0Vowmfj6KUiNRRPt7w/wV5PFPX83l
	 05aExwVHbnSSBX4ERZDsHyTG+tjdQiXhfmFgpLM557Nfc59LRfjw0wA2QYxxXTUsjM
	 IvbbIpKNfoWeQ77fzVY/ltvGgdbFfHh/6XGmwcIwCqnalG+1AbLGxTFX3OvovpcdG6
	 ISoZNM0dwQq9w==
Content-Type: multipart/mixed; boundary="===============2802907230478521436=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <70bafc49483a4282dc63ce31809672c2c86426b96f0c981fcd8f041468b46702@mail.kernel.org>
In-Reply-To: <20261101001024.9994-1-dennylin0707@gmail.com>
References: <20261101001024.9994-1-dennylin0707@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Preserve unsigned enum values in data dumps
From: bot+bpf-ci@kernel.org
To: dennylin0707@gmail.com,qmo@kernel.org,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,yonghong.song@linux.dev,linux-kernel@vger.kernel.org,dennylin0707@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  1 Nov 2026 00:48:18 +0000 (UTC)

--===============2802907230478521436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Preserve unsigned enum values in data dumps

TL;DR: bpftool enum dump may regress on BTF without kind_flag (older
kernels/LLVM): small negative enumerators like -1 in 1- or 2-byte enums may
print as numbers instead of names; not a crash.

> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -149,7 +149,8 @@ static int btf_dumper_enum(const struct btf_dumper *d,
>  			    const void *data)
>  {
>  	const struct btf_enum *enums = btf_enum(t);
> -	__s64 value;
> +	bool is_signed = btf_kflag(t);
> +	__s64 value, val;
>  	__u32 i;
>
>  	switch (t->size) {

[ ... ]

> @@ -157,20 +158,21 @@ static int btf_dumper_enum(const struct btf_dumper *d,
>  		value = *(__s64 *)data;
>  		break;
>  	case 4:
> -		value = *(__s32 *)data;
> +		value = is_signed ? (__s64)*(__s32 *)data : *(__u32 *)data;
>  		break;
>  	case 2:
> -		value = *(__s16 *)data;
> +		value = is_signed ? *(__s16 *)data : *(__u16 *)data;
>  		break;
>  	case 1:
> -		value = *(__s8 *)data;
> +		value = is_signed ? *(__s8 *)data : *(__u8 *)data;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>
>  	for (i = 0; i < btf_vlen(t); i++) {
> -		if (value == enums[i].val) {
> +		val = is_signed ? (__s64)enums[i].val : (__u32)enums[i].val;
> +		if (value == val) {
>  			jsonw_string(d->jw,
>  				     btf__name_by_offset(d->btf,
>  							 enums[i].name_off));

Does treating a clear kind_flag as "unsigned" break name matching for BTF
that carries no signedness information?

A BTF_KIND_ENUM with kflag == 0 and a negative enumerator is common in the
BTF that bpftool reads:

  - kernels before 6.0 reject kind_flag on enums in btf_enum_check_meta()
  - libbpf's bpf_object__sanitize_btf() clears the flag when the kernel
    lacks enum64 support
  - LLVM before 15 never sets the bit

bpftool map dump reads this BTF back from the kernel, so the path is
do_dump_btf() -> btf_dumper_type() -> btf_dumper_do_type() ->
btf_dumper_enum().

For example, with a one byte enum:

  enum __attribute__((packed)) e { NEG = -1, POS = 1 };

where NEG is stored in btf_enum.val as the __s32 -1, kflag is 0, and the map
value byte is 0xff:

  before: value = *(__s8 *)data = -1; enums[i].val = -1, so it matches
          and prints "NEG"

  after:  is_signed = false; value = *(__u8 *)data = 255;
          val = (__u32)enums[i].val = 4294967295, so there is no match
          and it prints 255

For four byte enums the name still matches because both sides are zero
extended the same way.  A negative value that is not an enumerator (for
example -22) is now printed as 4294967274 rather than -22.

Would comparing at the enum's own width in the !is_signed case work for both
encodings and still fix the reported unsigned case?  For instance, comparing
the data against the enumerator truncated to t->size bytes, where
(__u8)255 == 255 and (__u8)-1 == 255 both match a data byte of 0xff.

libbpf's btf_dump_enum_data() makes the same kflag assumption, so this isn't
a crash, but it is a visible change from the earlier bpftool output on older
kernels that bpftool still supports.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41256964100
--===============2802907230478521436==--
