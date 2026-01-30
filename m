Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC06313E20
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769803940; cv=pass; b=uUU+N+XtzpktL/H2ZFhORWBKNMkXhtaaJqmaBz5C96hJS7mFXcf5kZzicsfBebRlkywoEVOqzisn7U5zGoXUtUaiPhIBtxAjKXDwC6f/AgQP9UaN/v3bsATuMQ6JNmqX6OpWkxLvmYR9FWdvIWlGA9NZy2pcPNxkdTmNM3yp+70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769803940; c=relaxed/simple;
	bh=MhwO1+PHUqHtZ1O7ir9Ivwk5ucIgcQpOyJ87nfqaKYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzdd5cQRl8m6pALTmBxVP2ZUpXkzGkCMejp+AqLP2K1Qtq28b3Asl9TWCMeqOJyx7TzZyteXhSBOM/6dBNtm7Fa89y2ZIm8wkXn09p/Tp8ao68IcXBXFYbBv0tXUsGPRBgbRDLonnH7e7obzfBZHSEAD43lTNJOqISUNc45BnLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYpnfL9t; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYpnfL9t"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbc305914so2270575f8f.0
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 12:12:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769803937; cv=none;
        d=google.com; s=arc-20240605;
        b=aFKMAdORB2+1slGmK9p8kbFfcZI/5VbBd1yZNRvEJ664ih+E3C1JDtx//NP54Zxby3
         dX/uWvCDX2Ap9NIPyl5DIHGRdeYqQTg5/y7VJwh//U3zA5SeX8xTuEpGwyQluTY22pPF
         cUP+Yu/ipUVhEJ3qOtawEid/yB2ax/NIlWOR+PauXKCFM35QL4JqEcd3fyYIgVmhUQHQ
         LsxmSrE4o7gR1D3cfhX7FfOBnAs2EgAMwNC6UAexXKmkknAF8LrLJblz0bt2GEHoBlyq
         l+V8my22HMZBlrNFmtEVXWnKwOcC7G80GUCLVlkZISr9Ic25hYsL8bUnNAZyN9F3J483
         k4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNkWGolxQDh6EVvN+xcGZ4XW+NwLQCLTlADMIxMO8Wg=;
        fh=2VxfD+1i4VRA/MrwNkdscbZtsVrvZugyuVwKZFzznmA=;
        b=Ot1AL8wU7vQNc40C1/dPqrNxFRuz1Q3ItRLDfBcr6TTx++69UqziOIsbJSkbhnrevO
         Kfzur1wJ7Xy/Q3lA6xtX6Bq+VOai4uwQcbi64TtkrZ6w3jbwvGlMkSfTrqCpnxiNSZg2
         ylLElWVqRvayrBTT2XKbeKJ3P7e6W1A67RrZqtPTlctO4gTqqD2NNocS9kL4FCqpUC6O
         YSH7vIGrwKfZ3d7zQYg5pFT5yw2VwEROVO+uRL0SeSYb2EDLx5fpl3J4KouwwbySfM+A
         tpvH4gv97GAfTgTRQPVOvotoF5uXI8vQ5AQ7BQ+peaNKc8rpZK3R/R0V0tpjIYEz27EX
         1J0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769803937; x=1770408737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNkWGolxQDh6EVvN+xcGZ4XW+NwLQCLTlADMIxMO8Wg=;
        b=fYpnfL9tImfpy5OWEoMynHZ1BP1dc06Vm4Duh++k7cg819JSL/bYy5HbM8XXiVPQ/I
         IDkf04c/paKogoNQzosPLEJapOEg0xDhSKubOlTzmL/8NVd/aHhnIPJ9ErJ22T+BXYnQ
         AM+gSTXhE+ZMeE9rLTnX5hyQf0Cn9xKnYRICIWkD/FPmbj0J2SWdQlNV5q3cWh6h18Iz
         DdQ4kh3XU6aK1Bc0UhGl9Tfqfv65aO0NBSTFWl/s6xqE1e7vJQRPUU50ui0Hq/tSZuWk
         SOblqLNJKNy41NBPMU7IbNQdhtREHrla/fPSvRA4ryJiNxkRB351hUGCCHZdKsqMmuXZ
         s3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769803937; x=1770408737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FNkWGolxQDh6EVvN+xcGZ4XW+NwLQCLTlADMIxMO8Wg=;
        b=lgrDsVB+m+7SkYOiiDttB4PUWA19mVc6ZeIrmwXhikuL5pDhi9gCb7aMkOW4yAuRSF
         HJes7p7TWZ8JJ+wJzV5eP6onfh4dt8cIn4OXn+KOMFDZYaufxuhhoVWIGG9PP0seWwCh
         RNySgbx17ENOvzQngOgBcrzS38uY6HKpQFxDhiMVq71HdoU3FtdW4Usz0z7aoGaOCYGN
         wmNROLYTCR2SSCNAhSdkcT01hkHQ6M2qdQ/GEZCWU+ocVEG++asoyFLH/dbC7ZVKpe5W
         Ca37UdY0qPhmhOtXCmywJtkSnBdE+pXJXkecMxpz7jdMjvEs1Z0bXFudlNTcKjJp/pi8
         CM6g==
X-Gm-Message-State: AOJu0Yw1Utcbbwiw0Pa42U3ztHQ+ZgK498prcDE5N1qICn8yEquCdIKU
	MiHl94XWF+UJAPVbQl4fYGaGLXRJqRcYGPxZFe/VfyzmZwfom+MQTeAlvd7BjM/nUFPCihoAw3L
	4jnnTTvnj0RRQaUfcUA1iWFTY9DSSkD8=
X-Gm-Gg: AZuq6aJyL5VNtLt8K2/6T42pZg7B0S3SNmCXR7ULPyBuYrrHEBQVJSFIi5905qIjNxV
	IZ6kINtJAd0C7iHjBoc+sE1YP+w6IN+g8nJuYCNdEqNi2CKCEPydwKY14D06/lNtbiaLXsGQipH
	lxDku0Kr6RYT+9WapLX7DDoJxx0rasd36kD/5RnpjQ47ml+++YZwVCnOEZ3qdy582B8XHW4RB/u
	jcgGGUOLEk1GQRaTtXi5+eahsYyCYMfheb9gKdHmtlSLx3FcY7gYHR4uFYg6KuydFG+9aVT6H9E
	Ebx57XNfky4SraZDJ+XsRTS/GZy/d8WY5CHCLSzPHpyO3qeuRC7FB4aYRKHVNPQoqOk1dDctm7u
	p9CpIHUMknQ+B5w==
X-Received: by 2002:a5d:5850:0:b0:435:dbe3:c6b1 with SMTP id
 ffacd0b85a97d-435f3a92b77mr6548800f8f.25.1769803937424; Fri, 30 Jan 2026
 12:12:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128150112.8873-1-leon.hwang@linux.dev> <20260128150112.8873-3-leon.hwang@linux.dev>
In-Reply-To: <20260128150112.8873-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 30 Jan 2026 12:12:05 -0800
X-Gm-Features: AZwV_QjdO1kPJVwhKD_i-fkrT0ene5FMAqGbrhrNJNSUzbF4B1pZUOSE0M6KT9E
Message-ID: <CAADnVQLmPPBazEGn5bvg4MMYbxtj6xZu3zo-V3DoqVYqZWDt3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf, arm64: Add fsession support
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 7:02=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> +       cookie_bargs_off =3D (bargs_off - cookie_off) / 8;
> +       for (i =3D 0; i < fentry->nr_links; i++) {
> +               if (bpf_link_prog_session_cookie(fentry->links[i])) {
> +                       u64 meta =3D func_meta | (cookie_bargs_off << BPF=
_TRAMP_COOKIE_INDEX_SHIFT);
> +
> +                       store_func_meta(ctx, meta, func_meta_off);
> +                       cookie_bargs_off--;
> +               }

I think the name could use an improvement.

> +static inline bool bpf_link_prog_session_cookie(struct bpf_tramp_link *l=
ink)
> +{
> +       return link->link.prog->call_session_cookie;
> +}

reading the first hunk without looking at the body isn't trivial.

How about
bpf_prog_calls_session_cookie() ?
Then it's obvious that return is boolean.

pw-bot: cr
