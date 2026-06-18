Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217137646E
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758015; cv=none; b=K+LQNQk0W6p5F3/m7dxKLbUFWadgf1OqNCedTh2vgnD/zA0JeB/ZMG48XZpvAKBdnIxvF+rfsQDBVjUnlHWHn2BNggshnXK/vt0uVRxkCAoHNiCa8O5y/3Ez4w5OXJ1YR6RnG3cTppUZ1CtwK8NtWXPkuat3Yf5XDAaFxJ8Kpyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758015; c=relaxed/simple;
	bh=G7NNzpithMzUQF4K63cTAyYOJ7Z0wlyAVq4xsJQDNfk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=aZM7BNb0BGAWOndjTRDFp9GXlnXlOZtuZAC5rcF9pEC3t4Ud7mwZo3lDA24JpgdExfAiehhTotYGDRTkSqFA2kWG56m3kC099cOHFL+Vdf0SSIMg+G6NqIEAvKYNZURbKigeP6jsbVjojLD2BVKl+AKmcSePjuENMsZdYsVKmHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=NKL9QRpl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="NKL9QRpl"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so415537a91.1
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 21:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781758012; x=1782362812; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwYn0b1ljZm5xm9vU8S5Ez8Hx6XEkpn06QsCD9WcSg8=;
        b=NKL9QRple/VLlHvhQyWmRqWTmc3ScY+DppM6hCt+ttKCco2n7TRaEuQe6bvfdeTq1I
         CdgbZUoPo1o00SM+knbWqD+uqNU0+UR0jasVGG4N7Yh060Mo9oXTOtb99nrdiAhIncDU
         4a34dHVv8t8cihSYxH3+fu58ElvwlRHm47SBNi4A1nPvzOYgh3paTH8kmsZi2FLaeZnL
         lFCEFGb2qYuiGbZS6umu7EngXoqf8n7ZZxCdlgHz7a7qfJrlr25uITyt6dxQx7uwGsof
         sJntHc5FsIyY/3Szcl6TxkzGOrGUpcuZEIlT2bTWeCyjneVO7e1E8BVXZYDFbSfl++Gn
         7qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781758012; x=1782362812;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwYn0b1ljZm5xm9vU8S5Ez8Hx6XEkpn06QsCD9WcSg8=;
        b=hTrqQYLJ2gsWuJbc7e5XKfAB9lFh0SVOM/DNOUwNg/vvy7WkqnPb+uh6Rasfv3iSO3
         jpOR9vsA+pX754x7qwnE5ictsgqXf2iuDWq8BZUgndv2gHUmw02GogGEKZbXrMJDgQri
         8Q7jUM0GYybh+Wvy9PdrQh/9os7R/A49rv7+ExzDPEA1/II8vKyTbHFKsxSkpmFuUa2C
         PM+RR+s4/HG44X8bUVNfsJhSTannByRzw6fQqf9Nnvl5zEa3dRtJqprYVlygMzbeWC2O
         343Wh7fe9eB/k5mGuipw5vnXN9rjuFLOG68IHx7QqkuslZ+G59LE/pS+onQMxWpDzCTG
         Gd1g==
X-Gm-Message-State: AOJu0YyJO1xC7Fi1cJgS4b/0ckkbi6W0oBiyM+wNuqHa4LvMNGS9o1Fu
	NI4SMT8q50UEG2asLr1TePI3EFeFs7WQ4/zFpz014yyt7dSAgID1epk7AcoWZEhtiVA=
X-Gm-Gg: AfdE7clRAVMW24fYP2VQIFfmjgsl/pchlRCGGxcExfl+Po3TOncBJIfcDNuZzy9IpJi
	lQkH+IbLN9bpba6qQpk42qvSmSskq5CYfH/VAgWk9pa28mKxuXrscdhwFVmyxFSCtwQXUzHOtFl
	Zk+AyD+kk/QCCLkxHBPC76fSU8Ka7K/m40MIMqDse1TegAATdBq28H/vMFSq6khgqHpHlMoEm72
	HK0NtjIiy5TVbaHvF/zMCVp2WjitvTg8/B9OYX1Yc5cUSGOslhjFz9RzceyRkVBQK5xZzST4ZqG
	mN0aVTr83W8FXxPP9wPA8hlItPAwfoU02vaoGl8u0pfJpQgYWRdjprKMpF2PDixndf+9bku4Hnz
	2G5CK+oFW/C6MA60vDfYj6RFQtFOnqWr6lYo6rir5QNVSj7ZC1ga044G1caH0/2m0ZZGxcMZ1d4
	feLmJLabw0k+wFxKai8w2mlG33uuo12uMrb6vXZbJrh0A+iZ1H6P2TqD4=
X-Received: by 2002:a17:90b:51cc:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-37ce44b6739mr2335254a91.10.1781758011754;
        Wed, 17 Jun 2026 21:46:51 -0700 (PDT)
Received: from localhost (S0106d8b37028eeb5.vc.shawcable.net. [24.84.91.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ae039sm7756627a91.1.2026.06.17.21.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 21:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 00:46:50 -0400
Message-Id: <DJBWI249TH74.C8BAB4SRRTXB@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <dwarves@vger.kernel.org>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 <acme@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <jose.marchesi@oracle.com>, "David
 Faust" <david.faust@oracle.com>, "Yonghong Song" <yonghong.song@linux.dev>
Subject: Re: [PAHOLE v5 1/5] btf_loader: Handle decl tag component_idx for
 parameters
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
 <20260618005731.273181-2-vineet.gupta@linux.dev>
In-Reply-To: <20260618005731.273181-2-vineet.gupta@linux.dev>

On Wed Jun 17, 2026 at 8:57 PM EDT, Vineet Gupta wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
>
> A BTF_KIND_DECL_TAG with a non-negative component_idx applies to a
> specific function parameter (or struct/union member), not to the
> function itself. btf_loader.c however attached every decl tag to the
> type named by btf_type->type, so parameter decl tags were recorded on
> the function rather than on the parameter, and pfunct never printed
> them with the parameter.
>
> Resolve a non-negative component_idx to the corresponding parameter via
> new helpers ftype__parameter()/function__parameter(), and attach the
> tag there. Teach the pretty printer to emit a parameter's attributes by
> factoring the function-level attribute loop into tag__attributes_fprintf(=
)
> and calling it from ftype__fprintf_parms() for each parameter.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

With one nit:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

(Also feel free to keep the tags for the other 3 patches since the=20
changes are minimal).

</SNIP>

> +	if (component_idx >=3D 0) {
> +		struct tag *func_tag =3D cu__function(cu, tp->type);
> +
> +		if (func_tag !=3D NULL) {
> +			tag =3D function__parameter(tag__function(func_tag), cu,
> +						  component_idx);
> +			if (tag =3D=3D NULL) {
> +				fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d=
 in BTF id %d\n",
> +					component_idx, tp->type);
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	if (tag =3D=3D NULL && component_idx < 0)
>  		tag =3D cu__function(cu, tp->type);

Nit, I think this can be simplified as follows:

tag =3D cu__function(cu, tp->type);
if (component_idx >=3D 0 && tag !=3D NULL) {
	tag =3D function__parameter(tag__function(tag), cu, component_idx);
	if (tag =3D=3D NULL) {
		fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d in B=
TF id %d\n",
			component_idx, tp->type);
		return 0;
	}
}

<SNIP>
