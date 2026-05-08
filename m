Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E11A6836
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263215; cv=none; b=sVPxhIehCkRww9M/p73BALJFMk5CxwLKgXteyj3ysCLKwDl/PDtod93+kmlFVGFs1TzlwG0OhLXTKumKcrFrHjRV9Flb7rBv22OWS3k6NPV+6HvcW6vmjSb5p1F1w7C8bWpIEj0aKyK8qU/4+A6JdWbU+x9IPNDevNwB8UTeAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263215; c=relaxed/simple;
	bh=z2+FdiHHd34WtJXTlsUivqhU5htop71ETBedaEqyXMA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=DvgACV/RqBP6hX5IwWJR0P/tmQ6hxQQI578ad4e6OcxYc9zM1a6xaD9YIEIVZbJ98oG/kkbRLrvSA2ANKPyHr7SxOsod6fBB/JOdKKFpE//Qj+7H4q0mdzgTNLczJTvNIEVNMTW+WaXPBYaGIv1HXrm1xaByKho0HrDuqn8moS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZ6bzLeX; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZ6bzLeX"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479eb8bcacbso1440727b6e.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778263213; x=1778868013; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3eiz8B4gyE290fSNmPbev0Opny71ujBl+NCBo1EhR0=;
        b=pZ6bzLeXQ0UiNHpo1Q3Kl5zUBpB+Uquc3OEags2P1r39afb0roIjbuo7ggiXGsrVlO
         1UfB/GY+N9W26nEf4QXeUhh8FCN1CxuFXHSwHDJ4HNp/sxQ9zVUxt3eDFPwTYAKwuxJS
         ktKuq66isZgMAcoO/qZ12x4X2oswhlkOKIhXLxnF7y3NYZHXhjC8KjrVhnCvRt9ZqFZl
         OF1CsTBueVEzPf8EhZQ1ByWXNty+ZczkiNCBHoBHKMTSPW6kO9NKK2OTbaCvj2lmn7Xv
         /c6hw2QNZ0ISiOKbVpMjktQNU44k3VUUI/qumaQKx+UeXQ4/EBmvCY3LDle/Y4cJ1sQv
         0vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778263213; x=1778868013;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3eiz8B4gyE290fSNmPbev0Opny71ujBl+NCBo1EhR0=;
        b=nvIbMy3LDtcXFEvvT7OuVxEq3exLQYC9i6tCbqIdvfxTsv2a8gvOdBfOMBKOFcrQDe
         1fhjBIASg80uoQmNTxF8RA9Ty9AVptmBg78NohitU17I5woXomKsKuikpkWScmDxSaN5
         aIiaQZ1i4LBmsAlml7/7Hb+Jya9US6XsnhN48BMfMbG3bWAf0PAPf+ChnvjlcfGW5bic
         0PpJE1wmaElDkL8ec+Txs2LIUSV47BzdaidLBWDj3C+pzN3pBCckriOov/C9cMNRNlKX
         m1Qm57uXNs95Sw167TZ17lu02lgagT92W1Ba+idHkG+AlEIOUA3luP+JsZoPrl5pt7Tk
         N3Pw==
X-Forwarded-Encrypted: i=1; AFNElJ9/s3lfTkiTSFsazt7G9Y75pRw2ye1X+cSOk0YsyhA4Zi26L2Ha9WndjBhza8pGhVpCubc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6S5jQe7CDnZ3MPN+LZS6oehFHCPfz94BK2XUnQknNir1avMKo
	O14gBLrxAROtt/AGCM72LVg64zo9zoQs5eRoWe6guGVqj2ozJ2RYNL5a
X-Gm-Gg: AeBDietEM8uMf6eivTeUYN+crJSO0+UKrqj04FJvJSz4qWRMGp9R1P6NRnwF/zGssFW
	lwiO6SoVWaj/vfxdjVmjDukDQJ3ENqVDtzmLI4WuLtZgRKuyZhcjPCuNu2fybA50To6R0NcrFqT
	idFbGAfUeNwS0igH6Omsda9A5CQfQrBpIhkNgMhxK3MuMo1ZB9tvkpzrFPsp2TGt/xmnWW9lXIU
	WgasMcMVcDWcHhWYn+2V2jvxSmO7uuXXn8+I/z96RPk9xwIWwmK9bXvffGmsRJpkDP03fjtQdhd
	CTKw0sY8Kl+UYbttjclZJAbjuQZSyy+AVGTGXbQBNLFiyJeK8GjOXlS1jyNZlcUSIZxByNNTA2B
	uoI3JTv4fieiXROOGY3dTegIcdacOIOIR8aFB4AiRJYD9z04aQS2Aqvo7FHX+hKQnE/fLx92vkt
	16OzXgENahnKiPEoGzLANOdzDKx+1xZAJhx4apsg/kzAMOLd3dwl6PbXN3OQ3tDD8gRZ0l+/g6a
	MYIxsoWEJtmwjmxHzGv6zOATPGq
X-Received: by 2002:a05:6808:1924:b0:467:1458:2a8f with SMTP id 5614622812f47-4804248d382mr7926799b6e.37.1778263212906;
        Fri, 08 May 2026 11:00:12 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:57::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763ffe6csm15144103b6e.6.2026.05.08.11.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 11:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 11:00:10 -0700
Message-Id: <DIDHP578A7HC.1LDN8799EQTFV@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 05/23] bpf: Support stack arguments for bpf
 functions
X-Mailer: aerc
References: <20260507212942.1122000-1-yonghong.song@linux.dev>
 <20260507213008.1127429-1-yonghong.song@linux.dev>
In-Reply-To: <20260507213008.1127429-1-yonghong.song@linux.dev>

On Thu May 7, 2026 at 2:30 PM PDT, Yonghong Song wrote:
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index fba9e8c00878..0ff8cdf4394f 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1123,6 +1123,9 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
> =20
>  		func[i]->aux->name[0] =3D 'F';
>  		func[i]->aux->stack_depth =3D env->subprog_info[i].stack_depth;
> +		func[i]->aux->incoming_stack_arg_cnt =3D
> +			bpf_in_stack_arg_cnt(&env->subprog_info[i]);
> +		func[i]->aux->stack_arg_cnt =3D env->subprog_info[i].stack_arg_cnt;

replied earlier. Should be no need for this copy.
