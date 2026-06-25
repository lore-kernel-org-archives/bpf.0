Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266F8634C
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782347196; cv=none; b=DS06j3AKROOhqob335fldgRsx+guubUiVAxmpwEPyMFwUjPLTSXfhkLu6+z3exlI+8wmwkBat2DI1vxLcgNwhZrj3DH2N7troLObjpVJPD0ICn/tJXx+BDVQNFa2mQm7owlH2QKIzglawrbY6XLqNssihBTaS7de3DZ8mohXK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782347196; c=relaxed/simple;
	bh=H1XoCyqFY1RgKxaDeo+uKYRZWRo8XHehpSHDzgMz5Kg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKmOoS+HL2akdtoB+zZ838UUmEHITKCVrlGAfQmHWPWdoIedRN1l31AyV5jDiTXuHrZdUdNsdwtXJqpKho+Z1/KM7lrBxycHKs5iGHOiD0R4bQTMVsflQopgW10k65nj2F0HGFiJEc+n4Ob9QO7XBGlCprcOHoFi4t1f4Ss9prU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8cxVdYk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8cxVdYk"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84229481d44so870384b3a.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 17:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782347195; x=1782951995; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pBhBmySP/8uSrsH66Cf3R5c7fz4eRdEDml5iwwAotFQ=;
        b=V8cxVdYkewb3W1cuJGb6c1YiBVARnfAx0AQzr4AYmq9bii6TvHtx5n9h14pczDXba9
         azG2lyaCL2tXel1BC6yOWe/KNggK9LNKnsrqHL3PV/5atE3ccdB7h+pxHsWdMkyPEDgj
         PtWQEzruUuUtTEZ/m9SfrBDf+qsez8PdaoDqEpC/Kpny97VjsSiCG22Llq7I7rbtqx+f
         MQfQ0lGDyKHuNBm0TIBhIt9gQuUySw73LraQLfDw665t/RFt9snKN6GMfkKpdG2hj74v
         IAKVjvrPnnUYXZnlWtqWVq+i8iDhowSOKQ+V2eN14yGrEmd6Hhzozx9Jv02ocpxgnx2M
         Oabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782347195; x=1782951995;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBhBmySP/8uSrsH66Cf3R5c7fz4eRdEDml5iwwAotFQ=;
        b=bbUBVKhD65p7RjFNFWHyApM2TX3VMQX/A9bfeCS01vgutchwBqc7B1LGuNhjQldF8K
         q6JCL6r2cm+K2E0B+4vwWG4a8jDYbNGVytdJ9M6yRmCGJOQXsHZFyC0xGmgGEvHGW6q4
         q53fbW9/NSqJu4VT5QATmiWYo7Syf8KGprSNq7kQQU0W5uFYFuIdZERwqwb0RieJcyHy
         4/tqO1JYvVDa3w7S1p7c9jonDN7NbL2Reor0XV9vRfTxv/9+KKCzig6ipxV5Jy0xBY9x
         TD3RWPGFrCajLN3i8geldyquYMdkII8SAx/OjRO8+OfT+W2LuGKKc2Lcvm7xprgbiptX
         Ov2A==
X-Forwarded-Encrypted: i=1; AHgh+RojkDoGuzZAn48b5fb1VLGrvilt2Z/nnakdhEkIucHdLrs4fGwNzOB85q5nIk8GEfMaZno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGIzTYDp6cInISkyim0R4BbyMy+LgGCXumJvc16HGY6HEH7skX
	GYMaX2J6O27HC/pM9DovmhwdkT5HJjZi4rLRPTJ2OjzYsCm3h3aC9QeV
X-Gm-Gg: AfdE7clHSCaFSeo8rDwvpl9Kk4/nTpb6qpp1w04tdBwugxhdIgDRhdW7Te1SvgIgL9H
	YvgJBJFiHWsT8EiyWaxnVv6XCRFkzRk3NKOGtpcJXu2Xt2lxXbJRDI5T/3acPX9s64uu2yM3sxZ
	+OfdTZDg0tRjuuCuOcalyo7ICgb2VIucjkIcLOTTJPLmvOxVm4Ng6oKFVJzWuQIJSGUOwUS8VnO
	R5s0gvRvYt1pYCaH1V0Iup2d3Wm61rCDFudGH1IJISMKGuHINrVFdm9JYBZGvNjkD2b7iAzwyoj
	a0Tmyv8t0SJdsmIR5TIM5C8hlsCouojQUmRQKff206fvvc8eYZ/XVYTZ8D8RazggOBryrcgpFvg
	uGak1kcRdEDIh8ehUtaYfCTh9QS3kkCpYsmGvPl/wHc0c7CzN3ydAQpG/hHg7APmnElAmBa2J9Z
	0RLZeiaLkAUejK0M3eC51Y9ywUl/S/38Xe4qJoVAxAbQ==
X-Received: by 2002:a05:6a00:398e:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-845b39a2b7fmr485077b3a.1.1782347194947;
        Wed, 24 Jun 2026 17:26:34 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d23d7sm3381767b3a.30.2026.06.24.17.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 17:26:34 -0700 (PDT)
Message-ID: <19010f6cf137d7d156ee93ae17a8cc3b5e0c0e70.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 16/17] bpf: Report Verifier Internal errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 24 Jun 2026 17:26:27 -0700
In-Reply-To: <20260619205934.1312876-17-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-17-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 22:59 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ec51e0c81053..5c60fe033271 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8481,6 +8481,9 @@ static int check_reg_type(struct bpf_verifier_env *=
env, struct bpf_reg_state *re
>  				verbose(env, "verifier internal error:");
>  				verbose(env, "%s has non-overwritten BPF_PTR_POISON type\n",
>  					reg_arg_name(env, argno));
> +				bpf_diag_report_internal_error(env, env->insn_idx,
> +							       "poisoned helper argument type",
> +							       "helper type checking reached a non-overwritten BPF_PTR_PO=
ISON expected type.");

The cases below should be converted to use verifier_bug() utility function.
I'm not sure if we want elaborate error reporting in this case, but in case
we do, the verifier_bug() is the right place to inject the call to
bpf_diag_report_internal_error().

>  				return -EACCES;
>  			}
> =20
> @@ -12560,12 +12563,19 @@ static bool check_kfunc_is_graph_node_api(struc=
t bpf_verifier_env *env,
>  	default:
>  		verbose(env, "verifier internal error: unexpected graph node argument =
type %s\n",
>  			btf_field_type_name(node_field_type));
> +		bpf_diag_report_internal_error(env, env->insn_idx,
> +					       "unexpected graph node argument type",
> +					       "the kfunc graph-node checker saw an unsupported graph node =
field type.");
>  		return false;
>  	}
> =20
> -	if (!ret)
> +	if (!ret) {
>  		verbose(env, "verifier internal error: %s node arg for unknown kfunc\n=
",
>  			btf_field_type_name(node_field_type));
> +		bpf_diag_report_internal_error(env, env->insn_idx,
> +					       "graph node argument for unknown kfunc",
> +					       "the kfunc graph-node checker could not map this graph node =
argument to the called kfunc.");
> +	}
>  	return ret;
>  }
> =20
