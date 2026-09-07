Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B04381E81
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809416; cv=none; b=FeSQTSj7nqklWo1VUehHo/0k+TCeLWHscnsPQe93VVxZ4cNrGKYdwwdfIjPqngKbt/Lp3+T33HJ28/TMG/n76SmRHyNxaSjmUJ5VrdiuCNTdOcyyHRTWYf1+qH+3oDkIpU68LCKfeAE/FrpjjMPjtXj/RAxdqa3uqfEMcaAXD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809416; c=relaxed/simple;
	bh=j+BDnmDyh74w4pgL8Rn5XSmIJ3N/HoQ0HgjCKl4qQrI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=buraYCsr+jyI/FpzDysHCRJqfaRbuDgoCdz6qVCj1XSn0s1Q4nf+z5dz0aEMsg9kTleSj0eH2KLlTyN4Kkd0JCPLreHFqyn2Ian5YZwS9vV1aDIbNkY1ewfVZR+7AFfFORkmKFbesYwYrkYpeeV3UhqIgdPxwJ7lfqMKJ2YMcdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQEdwIQQ; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQEdwIQQ"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae6c9b72so88009eaf.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 12:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788809414; x=1789414214; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dIu/mIBPX0VHys6MmT2l2fjN8J667C9u+lhywd7I4Hw=;
        b=mQEdwIQQxvu7HtbSjhgKlHYS+LW6upkjK4w7BYQyqZuBtcJIYPwsiDBEsz2s29L0Lm
         XfhAvRDcLQSBhxelMgZkOgPzBXrWJskuZwU98w5xmGmqnp6h1NnmaUtQXhBTmduvQys2
         TNC0kZ9KO/QP/Gtj/3dcZ7hf2Iaqui+3yaDljYla64K92dJj92hEixhmzBtMAF+ic0tC
         Piqgn+nFNPVz99EI0rI8+5oi0TYvCOIa5YDWfJTy4SseR8yiA2kQDi76oc6bUsFqvVyF
         vHnxPZkFMrt5+bhzJ6nh5xYUPbof2ZqUpkt6bmLwnJXkWp8jTJ6E375LMmYGEuIGkVRt
         D/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788809414; x=1789414214;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dIu/mIBPX0VHys6MmT2l2fjN8J667C9u+lhywd7I4Hw=;
        b=sCixa2pQ7+rifbYiAoov50cDdojyiJuqksg2+UK8fIaf3/seUpP7p7SGC7kqIC2iZZ
         X6AgnJbT4p2tcTheLMHMjcPoIMS2ICT9ETRt1JVXYf8IWj6ANOHJZILbeuVZLd887Emu
         vvfuFvFa7ycdDeM8JfMgMFc/hAc1gounB2OXmeXIdmOMU5ceATvTVeQPg6UehHPs7kLJ
         O6yH64gpPX/yOIuPJ7pLRAen/4HCEkjzORaOMqgKlsqnNbIvuujpWC08hSIcFh3vstkA
         FsXXDORDsGaOtKwRUmPXLLNt5xozWI5vVM0f38lM4HgmKCyiYAPWsHxFPKc2SvUGhllx
         WFPw==
X-Forwarded-Encrypted: i=1; AKwUvBwdXAIQEkM1+mfD3NkKRlp7eOPkpFNaF0IwHoTx1J0X5aUuWRetwcAmnZHQYjue5SBlAG4=@vger.kernel.org
X-Gm-Message-State: AFuF++koIAOuoo4w52NLCvYwSnvBA0bfQ3/3nZC09slrOQiRTtVU6YkW
	jOI3zfgw5z5U0eNJOGCjsIlecoU4JWgkVjv8Ta/GZsXy4hImCSKUUOiy
X-Gm-Gg: AYBFou2c18KkBsuYRJAGeXqdkJ2vCpRJv49Qev+BobY6QZt+nYHBPiFitcbJ78OTXwD
	1sz9zqAZFqYyvQ0OwlmvWe9QSNU4evGKi9Mt70vspILP6h779QG+610Ux5yFmCsHxidExS2zq3w
	XFzwHHuLwnjDQOmyydCP9yXhKF6v6khr6IbDtP0Tn6h2XA5T2BwCWTm4XxaSVr1BwZDA6hYVDTW
	Mzee+kck7uVktUeQNPU5a5vy7g4Sg+T8M2xmmikriZDoksS/MarvEBW1W99aMRSmZ0GodsVSgmd
	TtuGZgIKnzY7msaD+xAG3vFOU3kjDOzRXYSpJPMOA1zmwzIMhm7bJv5LZqUGgT45nRv17YJjwVC
	g9wlsKOuatXdoRUvFo/lSpP8B822x/UeiDbWnbP+r+XGIC6yX+YdEsY1B5mwp+0ckTJJOlPKd+u
	8NkGjJo8YOgX1KF7VqwtIm740/lE+bT78mYh+WhVk30zs9uX3u2yWkzjelaCTonJlmY0wsPSTME
	kReVteNRrHcMuVDDXIz6AuuSrQcg+Hn0ztbhPSsAx0xoa6KLDUyoto=
X-Received: by 2002:a05:6820:81d4:b0:6a3:7424:8db5 with SMTP id 006d021491bc7-6bc24aa0316mr768736eaf.3.1788809413944;
        Mon, 07 Sep 2026 12:30:13 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b7691588f4sm12107567eaf.13.2026.09.07.12.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 12:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 12:30:11 -0700
Message-Id: <DL9C0IVB1HCG.3B2WEUW6ARHH5@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <ast@kernel.org>,
 <andrii@kernel.org>
Cc: <daniel@iogearbox.net>, <eddyz87@gmail.com>, <jolsa@kernel.org>,
 <ihor.solodrai@linux.dev>, <yonghong.song@linux.dev>, <song@kernel.org>,
 <qmo@kernel.org>, <martin.lau@linux.dev>, <memxor@gmail.com>,
 <emil@etsalapatis.com>, <mcgrof@kernel.org>, <petr.pavlu@suse.com>,
 <tj@kernel.org>, <kees@kernel.org>, <bpf@vger.kernel.org>,
 <nathan@kernel.org>, <nsc@kernel.org>, <arnd@arndb.de>,
 <puranjay@kernel.org>, <yatsenko@meta.com>, <atenart@kernel.org>,
 <ojeda@kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 11/18] bpftool: Add ability to dump
 LOC_PARAM, LOC_PROTO and LOCSEC
X-Mailer: aerc
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-12-alan.maguire@oracle.com>
In-Reply-To: <20260901165757.801449-12-alan.maguire@oracle.com>

On Tue Sep 1, 2026 at 9:57 AM PDT, Alan Maguire wrote:
> In raw mode ensure we can dump new BTF kinds in normal/json format.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/btf.c | 85 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index bca0a3982f09..4d8991c99b48 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -51,6 +51,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =
=3D {
>  	[BTF_KIND_DECL_TAG]	=3D "DECL_TAG",
>  	[BTF_KIND_TYPE_TAG]	=3D "TYPE_TAG",
>  	[BTF_KIND_ENUM64]	=3D "ENUM64",
> +	[BTF_KIND_LOC_PARAM]	=3D "LOC_PARAM",
> +	[BTF_KIND_LOC_PROTO]	=3D "LOC_PROTO",
> +	[BTF_KIND_LOCSEC]	=3D "LOCSEC",
>  };
> =20
>  struct sort_datum {
> @@ -415,6 +418,88 @@ static int dump_btf_type(const struct btf *btf, __u3=
2 id,
>  		}
>  		break;
>  	}
> +	case BTF_KIND_LOC_PARAM: {
> +		const struct btf_loc_param *p =3D btf_loc_param(t);
> +		__u32 *v =3D (__u32 *)(p + 1);
> +		__u32 i, vlen =3D btf_vlen(t);
> +
> +		if (json_output) {
> +			jsonw_uint_field(w, "size", t->size);
> +			jsonw_uint_field(w, "flags", p->flags);
> +			jsonw_uint_field(w, "vlen", vlen);
> +			jsonw_name(w, "values");
> +			jsonw_start_array(w);
> +		} else {
> +			printf(" size=3D%u flags=3D0x%x vlen=3D%u", t->size, p->flags, vlen);
> +		}
> +		for (i =3D 0; i < vlen; i++, v++) {
> +			if (json_output) {
> +				jsonw_start_object(w);
> +				jsonw_uint_field(w, "value", *v);
> +				jsonw_end_object(w);
> +			} else {
> +				printf("\n\t value=3D%u", *v);
> +			}

raw dump into json is fine, but please switch
to pretty-print normal output that humans can read.
Print function name, argument name and registers/stack where args are held.
