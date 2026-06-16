Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72009346E66
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593654; cv=none; b=dOZu9tPKLZLD7BFiN65KKoJLITJ8tRGRpucCebkdtXjEK+O3kScP+m6T3Jn04uze4PXtVUZkwe9JvxQ0CUkVGcgpHWR1kZ2yq/sf7cC85N5fRn67aHazdWBS7WuOgd/Yi/XCYpY1K4+nShWSJGfu5MWePeRckSk+hyM40b9XZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593654; c=relaxed/simple;
	bh=mPXdKYwDz0xk4Rh5YVPEDuEuCc1dfd+SD4yHv3OITxI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=M8ogJ7W4Xmg1MdzTNhFxuOs7Jgs+NL3sRLJiveIoXSv87yCDBIWGqTH3G9JpkEnAH3k6yWr/ArV+ICWDrqeu4gMPktPxk38PWhin2/t7i1uEDHmm35hvBFaGVIkU0OVtBAcixEUvDdVGwA6hMnM4X0tnaOktP7gJ00fi5X2hNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=MopNBGn3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="MopNBGn3"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so3352885a91.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781593648; x=1782198448; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efFAPo1eL0J3dsu2A5wxzYPQWfYJHzDPadyLXJxvyQo=;
        b=MopNBGn3xlChpNwDv7oIYdpe7aF4VI1YHvh4+h0rQZlcPqH+v3roqIVSg5KWg+7nBG
         ZS/3qLh/pktH6GDzG81IRpniVpwuuTCNvUnLMYUUDlvvk2u43OU+7EBM4iV9lbELn9yT
         k9U55TE4R4Krm0gpsS7NwHlzErGldQgn5yrSkMBLXa3Xuza1U5LXEi9y+eurvLcUK84t
         FJFOzBPromP7TYIMlTYGYphpOyioWQwf3cmLN9Iqi0OadtqxcuOWMavzihR48ALJVw4m
         oGRSc5x52FscVTwj7F6sEenOhzPP0cjcKhOa1pMU7Q2IwAywPALlENrf4tO2RouwvzlK
         jf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781593648; x=1782198448;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efFAPo1eL0J3dsu2A5wxzYPQWfYJHzDPadyLXJxvyQo=;
        b=jb8zsUurwCekRx/aVbrvjBXF6K95+UJsKCP8A9L61WkQy4xUciZPKZuIxBBt/5Q3SV
         BEANfMBRvMzAgW9byjUSg8xl0mfMmerSXQqko9ziAK/7Mopx2dt1xde+OZqNU7w8F4sp
         sS4S5VBnJjud7Kv3CKlWjQcdLirS43DkEHN2p11w3Eo02x92nt2hmzaeirD4vpFYSz+A
         PcNELlmofx1V41PjwPtcqZ6vqDByyd2gGUvM2lugAONB5/91YdDOnnzflz7+04c0prgo
         VLjf1FUteAXCKr34aPn9iMA9xwbXnk8FeVdsnEQsCR+HZQT6/Pi0RDczcaxZlJ3AjoCE
         +nxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bounxVAWb7zxEtkyKsKSn508HzRUbyOT9kUtfa7hU7RTfBNgSdW9q+6CVZoOctudLgMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdjMmQFu/sQ71oyJjPlzyx5ce3I8VqzgKnDjAg8qLFSZCvrj2C
	WCFMfYbYayGLsmMPZDiywVLdXqlcI1jLQ1HbQMcNi/U12dqa2VOJV4H0RTz5gpjPvMc=
X-Gm-Gg: Acq92OEvxtiYPP7L9mYlmxC7QApY0oDUn73BoQLhYXAYZE0iiY071SONoEmPPdJBST3
	b0bw+LixNEt2Z3MwG8FPPHQ2EEpYq0Uuoj/80ID+oFErSTtlgUYggNq8gVJjI1O7JkJYnH1I23V
	uKfZghnnBz7XEKd534gA//VP6tYE+LKTuRuTSDtGW2gQ3nTt4GhLaivz2poSbXY8sRopvu2k3du
	YrwFyAiwKBarwg1HeOBZoT7BsEDGatkOTwN3IFTS3EeylelWmuUWIV21ewoNqIviWXndCbvYjUw
	24tK6UgMoQ0B8hWGetbTpHXJKXtKNNhen2vRkfbDZV62IEGmXnBBxEVTuE/C7XE7AUy3zY2PD03
	qeMu7PzKhnzkoKL9anYuJTrZsdqnqgmOy3z84VhC5kHKP2ZDQog0ObMNNSAMmDNd/pDKQiKVUyy
	58y0IkwirLjfLRWEF3Lq9Yj92jXsbrHS0v4FbehHeRnr2VMwXK75AvmB6X
X-Received: by 2002:a17:90b:4c09:b0:368:3d3e:efa6 with SMTP id 98e67ed59e1d1-37c523fb93cmr2722990a91.20.1781593647586;
        Tue, 16 Jun 2026 00:07:27 -0700 (PDT)
Received: from localhost (d206-116-244-52.bchsia.telus.net. [206.116.244.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e810f98fsm5811867a91.2.2026.06.16.00.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 00:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 03:07:26 -0400
Message-Id: <DJAA8M3U5PJ7.W84BYRNJA7UY@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Jiri Olsa"
 <jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 04/14] selftests/bpf: Add kfunc set test to
 resolve_btfids
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-5-ihor.solodrai@linux.dev>

On Mon Jun 1, 2026 at 6:17 PM EDT, Ihor Solodrai wrote:
> Extend the resolve_btfids selftest to cover kfunc sets defined with
> BTF_KFUNCS_START/BTF_KFUNCS_END.
>
> The test verifies that resolve_btfids correctly processes BTF_ID_FLAGS,
> resolves function IDs, and checks the kfunc set is sorted.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

One nit below.

> ---
>  .../selftests/bpf/prog_tests/resolve_btfids.c | 56 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/btf_data.c  | 10 ++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/to=
ols/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index d0e51979d455..f6fd79b9dd23 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> @@ -10,6 +10,10 @@
>  #include <linux/btf_ids.h>
>  #include "test_progs.h"
> =20
> +#ifndef KF_FASTCALL
> +#define KF_FASTCALL (1 << 12)
> +#endif
> +
>  struct symbol {
>  	const char	*name;
>  	int		 type;
> @@ -26,6 +30,17 @@ struct symbol test_symbols[] =3D {
>  	{ "func",    BTF_KIND_FUNC,    -1 },
>  };
> =20
> +struct kfunc_symbol {
> +	const char	*name;
> +	s32		 id;
> +	u32		 flags;
> +};
> +
> +static struct kfunc_symbol kfunc_symbols[] =3D {
> +	{ "kfunc_a", -1, 0 },
> +	{ "kfunc_b", -1, KF_FASTCALL },
> +};
> +
>  /* Align the .BTF_ids section to 4 bytes */
>  asm (
>  ".pushsection " BTF_IDS_SECTION " ,\"a\"; \n"
> @@ -77,7 +92,13 @@ BTF_ID(union,   U)
>  BTF_ID(func,    func)
>  BTF_SET_END(test_set)
> =20
> +BTF_KFUNCS_START(test_kfunc_set)
> +BTF_ID_FLAGS(func, kfunc_a)
> +BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
> +BTF_KFUNCS_END(test_kfunc_set)
> +
>  #pragma GCC visibility pop
> +
>  static int
>  __resolve_symbol(struct btf *btf, int type_id)
>  {
> @@ -108,6 +129,18 @@ __resolve_symbol(struct btf *btf, int type_id)
>  			test_symbols[i].id =3D type_id;
>  	}
> =20
> +	if (BTF_INFO_KIND(type->info) =3D=3D BTF_KIND_FUNC) {
> +		str =3D btf__name_by_offset(btf, type->name_off);
> +		if (str) {

This can be rewritten to collapse the nesting:
if (BTF_INFO_KIND(type->info) !=3D BTF_KIND_FUNC)=20
	return 0;

str =3D btf__name_by_offset(btf, type->name_off);
if (!str)
	return 0;

<the rest>

> +			for (i =3D 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
> +				if (kfunc_symbols[i].id >=3D 0)
> +					continue;
> +				if (!strcmp(str, kfunc_symbols[i].name))
> +					kfunc_symbols[i].id =3D type_id;
> +			}
> +		}
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -162,6 +195,29 @@ void test_resolve_btfids(void)
>  			ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check");
>  	}
> =20
> +	/* Check BTF_KFUNCS_START(test_kfunc_set) */
> +	ASSERT_EQ(test_kfunc_set.flags, BTF_SET8_KFUNCS, "kfunc_set_flags");
> +	ASSERT_EQ(test_kfunc_set.cnt, ARRAY_SIZE(kfunc_symbols), "kfunc_set_cnt=
");
> +
> +	for (i =3D 0; i < test_kfunc_set.cnt; i++) {
> +		bool found =3D false;
> +
> +		for (j =3D 0; j < ARRAY_SIZE(kfunc_symbols); j++) {
> +			if (kfunc_symbols[j].id !=3D (s32)test_kfunc_set.pairs[i].id)
> +				continue;
> +			found =3D true;
> +			ASSERT_EQ(test_kfunc_set.pairs[i].flags,
> +				  kfunc_symbols[j].flags, "kfunc_flags_check");
> +			break;
> +		}
> +
> +		ASSERT_TRUE(found, "kfunc_id_found");
> +
> +		if (i > 0)
> +			ASSERT_LE(test_kfunc_set.pairs[i - 1].id,
> +				  test_kfunc_set.pairs[i].id, "kfunc_sort_check");
> +	}
> +
>  out:
>  	btf__free(btf);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/btf_data.c b/tools/testing=
/selftests/bpf/progs/btf_data.c
> index baa525275bde..8587658012c3 100644
> --- a/tools/testing/selftests/bpf/progs/btf_data.c
> +++ b/tools/testing/selftests/bpf/progs/btf_data.c
> @@ -48,3 +48,13 @@ int func(struct root_struct *root)
>  {
>  	return 0;
>  }
> +
> +int kfunc_a(struct root_struct *root)
> +{
> +	return 0;
> +}
> +
> +int kfunc_b(struct root_struct *root)
> +{
> +	return 0;
> +}

