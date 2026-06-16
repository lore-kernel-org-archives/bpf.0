Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5DD3E1682
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591619; cv=none; b=ojNLXA2oTAQHtmyF9aK2KwGVtsFE8uuK5pCWLARAifbd9dI4+2pOEEFkHt/2qIdZWvypShzziskOv725LTKX2wtg1RkxfCkBXTxuFWVFdtggemA5ZdshsSKcRqqelsYhtUW7P4Ae5aRu0W2kZ3HE063WnkqT+UCRIJxUDFLf5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591619; c=relaxed/simple;
	bh=UeuCMINapsR5SpBtSghJeUH5E+bHG6j3AAxRFbvUaQ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Zpei1oTPqs0J+tt+k+eBGZbPbzJVUAORdRD8++sUvxvIm3MsjwAWFsCCydNL5wY4WpLvSwJlzG6n9LBnKxQeKz/MJ750BRw5zojprPBM3rLdLCrkDC4xqzSK0rTysWEnZgTRULO4jkOna6P4WlR6K3ifYjcJgZBsGuEaIRiQq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=J2kG4VTX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="J2kG4VTX"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so2446577a91.3
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 23:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781591615; x=1782196415; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGRIaPvdUzg+ueBfQuakIepjwNDKmjuhE3vFhhrEoHc=;
        b=J2kG4VTXq21cXpfiQrLKFHdXSgoZPN1y0pKAddXzyD22uYO1SvNthUhwVmLiuxVRtA
         pWfWYXqYf+WUQtt8VoeLU/6WwDWjUuWIZsPrj5u9SGkgsfU9vL3J2NG2Gtt5Nsc7I5Dz
         aF0XyusE7CiPJH/LH+TtxtZeXPyZyqwHKZYWt+tXDtMLoekmV/bqmewPgzCH6quGr2Z+
         SWdeAPfnbwKf7BNkxA49D9WltxHKdRMuYevvWifkbM43eAOdo8Dkmdsi4ZFs2l9G6ER9
         kX1ft6hFflE1Bvroi+uL+pr73GGpX8C2O/P3xoxzqTPtGGn41m+1qCQyy+2/0XNAfe5F
         WlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591615; x=1782196415;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGRIaPvdUzg+ueBfQuakIepjwNDKmjuhE3vFhhrEoHc=;
        b=P/5sQkIqF3dVHBehddYtWLlfQvOmlqXS72X+P40ny+e4O4ZlRJ4L5iF7DVI4t1K917
         nsJMtIxbNEj7YRvXFZZKFilpeDiqDi/BOo4yyrqt7Na8Ix2IBt0v2tNcN91b18cR51Hy
         VThqQeBfIfcoAUu9VTiVaLIPFimQvVfWsj3tp3KdQ7WwhudhIpM3PThbpDYKCnrIjR12
         4JGgRv3HTkHUJPz0YeAGwX2xJgXwmD+OLex3cAKufLD615fCZ+bXP0C5y8EP3kUh65eQ
         jU8rYeRXzflo8t0gQaS8xwfgQn8NqmFiH0LstiHNZJIYYH5Zk/qZPBX1xnFbqzC9uaLT
         qq5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+bKSRciSwJPNWU1xvozqLoLJfkwX7YCe7QfWDz7H2RjiACMR4G575qMIWiILeUWwlHy1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPuPSVEA6DQMoOAy4UtJhockjMs895bCbWO5KYt1c7/x2CI2Rc
	uPfU+Y2UsXK6ww7cVmL9P2pMu0sDF5m2+4OUF/ref2APvxebyrIkhtAH0YM+aAqNfr8=
X-Gm-Gg: Acq92OHYNXVJFvHGHeFdxFGXOMNPiurovHO3YIsFgSDFVRy85Dl0jzpn3RNFIvaRv1k
	8thQ+zv4MgVQ+Pc43elbGBZtNi9wDpneKqVF1+qI1IbQG1oeOsAW9+Mpaz+g4S3OeV7HVYOFZyg
	rAmupHcvHWQY4EvHvfU2vJoYBKyR1eJRu5kdrHjyRcTBY5TPV2Hxl0EMCDn420QlK43dItPJE5d
	1N4Ehnhxs/A8PrSkDep2Mt/jAIiZBMPqOOSgwZfghEPQDA153Z00gt+ktIVozOQwvISbgZ5shwv
	CWucSfLns4o82S7nNp43bIW8VAnFDddNcMzu9qiRkQ45EreDME6u2ksL2VRQbG+2DAv7fecpibm
	ja4Qt+CBdhPoSfVepBp4Wz+YGNXmK/NFtkj0exXuzo+osXZiC3OEqkubdQ7+b4eV3uMCVXwx1Dd
	RdoXtw1+jBMdBOOUkHmLcJ1xP5GFLN0Galn4Gp9QOPPrH9oVciHW2edox8
X-Received: by 2002:a17:90b:3bc8:b0:36a:8240:2477 with SMTP id 98e67ed59e1d1-37c2bd3325dmr13622453a91.19.1781591614779;
        Mon, 15 Jun 2026 23:33:34 -0700 (PDT)
Received: from localhost (d206-116-244-52.bchsia.telus.net. [206.116.244.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521d96ddsm1612226a91.6.2026.06.15.23.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 23:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 02:33:33 -0400
Message-Id: <DJA9IOJTM7K9.7G9QVJMZYSRZ@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Jiri Olsa"
 <jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 02/14] selftests/bpf: Modernize
 resolve_btfids test scaffolding
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-3-ihor.solodrai@linux.dev>

On Mon Jun 1, 2026 at 6:17 PM EDT, Ihor Solodrai wrote:
> Refactor resolve_btfids test in order to:
>   * use newer ASSERT_* macros instead of CHECK
>   * extend the lifetime of loaded BTF to enable additional checks
>   * cleanup unused/unnecessary code
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

One nit below.

> ---
>  .../selftests/bpf/prog_tests/resolve_btfids.c | 54 +++++++------------
>  1 file changed, 18 insertions(+), 36 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/to=
ols/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index 41dfaaabb73f..d742ecb2ca8e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> @@ -10,8 +10,6 @@
>  #include <linux/btf_ids.h>
>  #include "test_progs.h"
> =20
> -static int duration;
> -
>  struct symbol {
>  	const char	*name;
>  	int		 type;
> @@ -95,25 +93,15 @@ __resolve_symbol(struct btf *btf, int type_id)
>  	return 0;
>  }
> =20
> -static int resolve_symbols(void)
> +static int resolve_symbols(struct btf *btf)
>  {
> -	struct btf *btf;
> +	__u32 nr =3D btf__type_cnt(btf);
>  	int type_id;
> -	__u32 nr;
> -
> -	btf =3D btf__parse_raw("resolve_btfids.test.o.BTF");

Nit; Maybe #define the file name instead of using it directly in
the code?

> -	if (CHECK(libbpf_get_error(btf), "resolve",
> -		  "Failed to load BTF from resolve_btfids.test.o.BTF\n"))
> -		return -1;
> -
> -	nr =3D btf__type_cnt(btf);
> =20
>  	for (type_id =3D 1; type_id < nr; type_id++) {
>  		if (__resolve_symbol(btf, type_id))
> -			break;
> +			return -1;
>  	}
> -
> -	btf__free(btf);
>  	return 0;
>  }
> =20
> @@ -121,25 +109,22 @@ void test_resolve_btfids(void)
>  {
>  	__u32 *test_list, *test_lists[] =3D { test_list_local, test_list_global=
 };
>  	unsigned int i, j;
> -	int ret =3D 0;
> +	struct btf *btf;
> =20
> -	if (resolve_symbols())
> -		return;
> +	btf =3D btf__parse_raw("resolve_btfids.test.o.BTF");
> +	if (!ASSERT_OK_PTR(btf, "btf_parse"))
> +		goto out;
> +
> +	if (resolve_symbols(btf))
> +		goto out;
> =20
>  	/* Check BTF_ID_LIST(test_list_local) and
>  	 * BTF_ID_LIST_GLOBAL(test_list_global) IDs
>  	 */
>  	for (j =3D 0; j < ARRAY_SIZE(test_lists); j++) {
>  		test_list =3D test_lists[j];
> -		for (i =3D 0; i < ARRAY_SIZE(test_symbols); i++) {
> -			ret =3D CHECK(test_list[i] !=3D test_symbols[i].id,
> -				    "id_check",
> -				    "wrong ID for %s (%d !=3D %d)\n",
> -				    test_symbols[i].name,
> -				    test_list[i], test_symbols[i].id);
> -			if (ret)
> -				return;
> -		}
> +		for (i =3D 0; i < ARRAY_SIZE(test_symbols); i++)
> +			ASSERT_EQ(test_list[i], test_symbols[i].id, test_symbols[i].name);
>  	}
> =20
>  	/* Check BTF_SET_START(test_set) IDs */
> @@ -153,15 +138,12 @@ void test_resolve_btfids(void)
>  			break;
>  		}
> =20
> -		ret =3D CHECK(!found, "id_check",
> -			    "ID %d not found in test_symbols\n",
> -			    test_set.ids[i]);
> -		if (ret)
> -			break;
> +		ASSERT_TRUE(found, "id_in_test_symbols");
> =20
> -		if (i > 0) {
> -			if (!ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check"))
> -				return;
> -		}
> +		if (i > 0)
> +			ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check");
>  	}
> +
> +out:
> +	btf__free(btf);
>  }

