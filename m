Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604633;
	b=IJD6BlMd0jnvBPz6aFjPqvl7IbQnUMjmLsy65iKWZsCbz4KKf3pkCWMYf60qYsfkpVRJ
	 gygwiG9yM6X72BjojhNXCXbXL7cAzKMIPjB5nZ3YozHmtQrmYBuDpUKPx70tAya8v9UZF
	 ZTxaOkpotZfTenZaXDVvcSH4Lxu+FAK+dykIedJX6T049ckR/ZWv/0mrYzBVX+3jC+xUO
	 bgJnUlKGYuL1S5hv9rmvftpbCoZSh1HqtNXz0ZZAhOU4Dun5GWojp/q8pI0WSCaOwpN8D
	 Cp66VykJXlgN9h+tolw5WAqRFTNTG1xik+jJubYnb6M7KJhwSRsnEzsjpMqjT2jKJDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604633;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=mrSzuPMkqX4MWQZ1Vs04gvpO/41JB6WErbOM51m8MaU=;
	b=ABFXk5ia+qKEjD80Nz5f1Kzt2i+Ifyb3FBESgPy/yMCP/ok94qt4knUEUkQXJ19nbsz9
	 6h1C5x92TmBTBS8TGgY8jOy7nEuPwIGuHqM56suxlviPJ9eIobAIcu1SgKG3lm1biASR9
	 8n9VJqewv80bx2Y73wQIyokZrmu3ZP2XpYn/sWnn2DBSZuQrZZE9xvdhsNjg7EuYPLku4
	 NLeSPBObcauridNQJgixQLAzWaFaZqTt/0ims9B0yVXJNqeYkxb+PFpKzgYw93eYb/F7s
	 5QWApuJQbc+SwChp4dmXoJ72T7aHpp2Euf1Q/rj+dHDNZcTDY4NstXwOYTCg+p/NsJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marliere.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=marliere.net header.i=@marliere.net header.a=rsa-sha256 header.s=dkim header.b=mVZBe53b;
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349C606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 11:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0349C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.a=rsa-sha256 header.s=dkim header.b=mVZBe53b
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-57309bd40b1so2959073b6e.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604632; x=1796209432;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mrSzuPMkqX4MWQZ1Vs04gvpO/41JB6WErbOM51m8MaU=;
        b=01f4HU1RESHnVDDmsAbjEJG6yFGKVVlsYK9ZoUPpBu1jisw0/M45iMaIXeUOl372Ye
         c900AK+RsxlLHKDHaghrfphMdikjBlsz+2rD19BpFc7BOpDx1/NphcitDXMOtaxyKOie
         ywIzQLBhTQ1ZLqO8/kJ1uaAUM1KDqVWIiFOtk9ggRzwPxEdg2wm8m4Ec80SFiR1xmAj6
         c6EUrE2mW5i8Z3BNGGcfjyU7eSIZa3fSyj0LF2gSs44kyOUuU7Nd9Yixbwreo7IxHHDO
         w5HdUiSMz/udgD2MzlLs8GlXyf9dL2PF45dzWqvgwwG3Gw/AEt9GogRKBa517Mrz9jT4
         lFcw==
X-Gm-Message-State: APuU4Z8IqhOCtZ+NimG5LsXR7VciYH2nklH4oHd5Ff8ArjcnL7VBB4W5
	I5OO3YJWJNSzu7gTG3UyHWzXJ5Svn4O/dz2RvwIhLO/MOxQ7Lb5sMd2r
X-Gm-Gg: AZFdTZczNG5twK+VS6c23Mwo4VTHGkR+rsHRd66hG03F9s0HHdliJvxU42743w5Ez+E
	SaLCIT23scpDO0e9F8t0r9c8pvVEoLhhVWyQyWDPx0Fmi280dKtpgmPfdRp6MbVSJWFRltCjIQa
	vwqtmFgis1l1olRM4+2lu8nbkTYqw6DaXWgzbp+hBA8A8uNZmqTMTp5SCinkZlTZqScFH6mpp4o
	YxeOfkCWjlo2K2jqOW4BDeBpP8cU3raUHR/azMKurbMLYARxVwj2CBLepD/V4FzL9xyYdf/Q0xr
	cDE5vmjWy2BVargqw5HKFomoeOgyqOk7lnhx8hMWJEC42ULre9g0bBFg3BksnKDKAoCKB6zNBV3
	z6docfq+WME0grufx6skBSnrZ8yjaxxmxm1KgfG5b+IsWxG2mQOhSCphtORCOn3xF/SigLaLeIW
	Oyd4mU1rQgywZszjCxDsvCndzyfUdKGyDEji+S9M2OOmZKF7QcGV4Y6Vd5CmOFtf/0Hab05Q0kV
	AuW/GNYYO7Ujol86RmuWL9y1sQYAsEKMuro3LdpcKhVKaTa6LwQpcBaDsn2r4lOplxdW0p9mj/f
	uf/oXZdfCId49sG6kYMMzvi4w93cofcEbQfFI5BGYFoX3CNXNh5nziTQ0YSF28ieShFhtbXKTM+
	lFzOtfFvz8QkTdtfUHpIFLtvrPZlQ7BE=
X-Received: by 2002:a05:6808:3195:b0:564:5fe0:dd80 with SMTP id 5614622812f47-57a0c6b6b35mr18642000b6e.49.1795604631958;
        Wed, 25 Nov 2026 03:03:51 -0800 (PST)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35655a5bsm13720074b6e.13.2026.11.25.03.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:03:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D3B7605F4;
	Wed, 25 Nov 2026 11:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1795604629;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mrSzuPMkqX4MWQZ1Vs04gvpO/41JB6WErbOM51m8MaU=;
	b=mVZBe53b+1iYEz2JUxIuiNR9+Py0/uSe5+otcdgdQWU7Taf9dvO+hB3dYAycHS4mpFX58G
	vV6DZzVxJ5w8FUgTr4XqUexlvB7GaFWiW3OZc5E5vLnquW3/R7BVCiaQEAmhTwaI6KYcz+
	WKMfwezQ7cQLflxSwa/Npl0fQJVmkwKtEmDNd5aNJMCbzuVVe0ajurUaD5bCcm6NTco6Ds
	1vtjOlq9kbB/huibnDLki/qUWQ4E/tssU1ut6areHNAORl2PP6lefnfCyTkQSBxPYZQ5Pt
	HHr38vyct1t04ZK9gvI9jxbGiJLcYvYDkBcVLc91Rz0kWIqh8m/9Uy61UkQceQ==
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 08:03:46 -0300
Message-Id: <DN48PTO1CTAC.3DAKV5TKHPXLJ@marliere.net>
Subject: Re: [PATCH] selftests/bpf: Fix kallsyms parsing with long Rust
 symbols
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan"
 <shuah@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?=
 <ricardo@marliere.net>
X-Mailer: aerc 0.22.0-17-g7220139118bb
References: <20261124-selftests-bpf-rust_sym-v1-1-32c450d0c4ee@marliere.net>
 <DN3YHFL4G7NM.36YOROLVGCSN3@gmail.com>
In-Reply-To: <DN3YHFL4G7NM.36YOROLVGCSN3@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Nov 25, 2026 at 12:02 AM -03, Alexei Starovoitov wrote:
> On Tue, Nov 24, 2026 at 03:33 PM Ricardo B. Marli=C3=A8re (SUSE) <ricardo=
@marliere.net> wrote:
>> -	char func[256], buf[256];
>> +	char func[512], buf[1024];
>
> can we drop buf ?

Sure, that works, thanks for the suggestion! Sent v2.

>
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
> index e871a26..06f6553 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -64,7 +64,7 @@ void free_kallsyms_local(struct ksyms *ksyms)
>  static struct ksyms *load_kallsyms_local_common(ksym_cmp_t cmp_cb)
>  {
>  	FILE *f;
> -	char func[256], buf[256];
> +	char func[512];
>  	char symbol;
>  	void *addr;
>  	int ret;
> @@ -80,9 +80,7 @@ static struct ksyms *load_kallsyms_local_common(ksym_cm=
p_t cmp_cb)
>  		return NULL;
>  	}
> =20
> -	while (fgets(buf, sizeof(buf), f)) {
> -		if (sscanf(buf, "%p %c %s", &addr, &symbol, func) !=3D 3)
> -			break;
> +	while (fscanf(f, "%p %c %511s%*[^\n]\n", &addr, &symbol, func) =3D=3D 3=
) {
>  		if (!addr)
>  			continue;
> =20
>
> pw-bot: cr


