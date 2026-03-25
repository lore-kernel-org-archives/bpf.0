Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037551D130E
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774408778; cv=none; b=hsMOyFZNRh+8Uo+ICkzP8CI4+VF7sCFCWB7NWDnUJ8/XJ3qPFzdD1mplFXgBuDHdno5+hWY5umSfHu9IjIOP88tcFg+NEcuEB9Fn+t2UCanHao6OfcxJvz6KPJZLKZqJXDZ2kuEA3oTW//GTYD4Ov/aL265sJFibVt+PEVJxVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774408778; c=relaxed/simple;
	bh=ldusxSsSzJNWYITwxAoP9ADHNJIQwQmzjmUVhB6WPNY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HfMB5IvHcv1GDuVWGZFmXpf1VhCjP5IR/rjXKHVelV4iEIy1rwu6wqN1ghtW/PS6JW6gGHpqU4fjwfiTK95yodp1YKeuwjA0Hj/3Aq8X0VT0mGwEryzRD+5LE9dR906Wzwmmyr0gd1DV1ceuMbszIy/hDIfq50GWQRhUDuEpkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=P8M/Btq8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="P8M/Btq8"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50b268fba9aso17703291cf.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 20:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1774408776; x=1775013576; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEld8D2ocGYqinW5QV65/BBdDiSzVVXzuCrrB42/tBA=;
        b=P8M/Btq8vIp8vJDsI9C7P5xmbF/Pc0eoc1DHB1q3gYEEwjby9KlYzekSRKOTZp6Jof
         NAwRu3RpP565tnArGyviv0ULehR2QyIrpJaFDGu0xGZDL7f9tY7tGMjFBCNohAeHuSjR
         UJ88+qPi6jl/TMs8q6iJ8f/FCQmkqvWfacMara5TMDJNGDYT+574xlIPTbquU6GOG7E9
         svSFv760fJjKzqgV5ZvaqD59rsNLdpBcxooav715vWY2AlLLluhZeqtFmW1xBuxnxBqS
         AdYgd/XHGDxmmZKWUgU+T5E41QUc+9yag9Rzj+XyNcvNUIwxwy9MKvAX0+02QcO/1Gk5
         dhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774408776; x=1775013576;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEld8D2ocGYqinW5QV65/BBdDiSzVVXzuCrrB42/tBA=;
        b=FFZr+0YKQyAjAd9SM24+Rzqn0PG1BVNhMz1jEtLLcCzHNtiZh5cIe38IQ3PXHT0+V+
         wrva1ndvaJci7DbSkF7m5zHSn8cnDz3LSTdlITYpDW4/8WmWyaiycTSM/trgcaQPTE3G
         3APgRPm9aVZdlOhWijrHaWIjzZCRghyOkp4w46SRdLmepLGSP5BkWPE5bZvq7S961mqy
         H0yf7fYwV/PUxJwyNX8Gifp36VSihPQf07wAGIKXuzHhUFy4GUzyOXG2hr8dOZue2e/2
         aVEbNQWryy9/v6HbWKBuK5Hf0oty/loB2mO5Pv10Adbl27l/Kwww9aOPJJRcb3UBwTLL
         tzww==
X-Forwarded-Encrypted: i=1; AJvYcCXWg9jBKOfDK+/gVqFy8tW/1uwh1AOqTadEImJhZAMEazdro0hZJeXjyTmuoW8VCFRlSF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOyMRhqEZR9Mh/x1MvPmTE5rmCiwACalu5hO6cbaCSQWw/mRxD
	u0BMDbYNvw9R4ouhEtTtMCF1eHCO6Kpq3U8mK8xSvRMqSmPMmHTpcCeGxHH7eHbGWes=
X-Gm-Gg: ATEYQzzW7ZtiYQ/9xgfkx4hMzH4gRFIofSGJQmaD6TCHFSZ3+bToe/uGwielti3b9+O
	mnAvYrP3cEvVIm3f6xn142aMAL3lL7Brd4Gh4bA5HGXp8KSaeiYS1qxrctrOjV+hFZ/+QlHA2qQ
	bGCiKlu4OeaXr7ExHbtOmIgRu6g7YDp1htGTCysd1iK+ZiCPAPRZYuXQSyE17WWIXzJ48vXdfbI
	AgOoHoaDz0oGniP/zyS4IYvvSBYNKj/TxFo7J4ffn5RfQg1SkymPQQOd3q/a5H0niOJMI4zrP0l
	SpveDrh1wdpHrOc383uUXeuhXQ1jhDYw9F/4AZDq0wi4UPNTSw9YxQtD9dXFgi3pZbmvrXP8/Cx
	S14CiJCcd2xTXPs1GQYDTnID8BEDWsQDjHBic5U8VwJ10MfbR7atJB6sv3tFmH9nV102jqa1dBu
	pRWMxXAamMqR+kIRTRx/x/NNs=
X-Received: by 2002:ac8:7d54:0:b0:50b:2876:586 with SMTP id d75a77b69052e-50b80cd3831mr29513191cf.5.1774408775825;
        Tue, 24 Mar 2026 20:19:35 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b68c89e78sm48239791cf.30.2026.03.24.20.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 20:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Mar 2026 23:19:32 -0400
Message-Id: <DHBJEWWLVRCH.2ZH320TJNWI21@etsalapatis.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@kernel.org>,
 <memxor@gmail.com>, <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Make reg_bounds test more
 robust
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260325012242.45606-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260325012242.45606-1-alexei.starovoitov@gmail.com>

On Tue Mar 24, 2026 at 9:22 PM EDT, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> The verifier log output may contain multiple lines that start with
> 18: (bf) r0 =3D r6
> teach reg_bounds to look for lines that have ';' in them,
> since reg_bounds test is looking for:
> 18: (bf) r0 =3D r6       ; R0=3D... R6=3D...
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/prog_tests/reg_bounds.c      | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index cb8dd2f63296..49886f1b21e5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -1217,7 +1217,23 @@ static int parse_range_cmp_log(const char *log_buf=
, struct case_spec spec,
>  			spec.compare_subregs ? "w0" : "r0",
>  			spec.compare_subregs ? "w" : "r", specs[i].reg_idx);
> =20
> -		q =3D strstr(p, buf);
> +		/*
> +		 * In the verifier log look for lines:
> +		 *   18: (bf) r0 =3D r6       ; R0=3D... R6=3D...
> +		 * Different verifier passes may print
> +		 *   18: (bf) r0 =3D r6
> +		 * as well, but never followed by ';'.
> +		 */
> +		q =3D p;
> +		while ((q =3D strstr(q, buf)) !=3D NULL) {
> +			const char *s =3D q + strlen(buf);
> +
> +			while (*s =3D=3D ' ' || *s =3D=3D '\t')
> +				s++;
> +			if (*s =3D=3D ';')
> +				break;
> +			q++;

I think the increment could alternatively be

q =3D s;

to avoid rescanning the whitespace.

> +		}
>  		if (!q) {
>  			*specs[i].state =3D (struct reg_state){.valid =3D false};
>  			continue;

