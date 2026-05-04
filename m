Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E03DE45D
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903554; cv=none; b=PvDoC8uRk39WyU3+uGAX9SGxl6DStHxKj1geUuY6w6dHcIHsC48dqTZkJqqqWunVJHCTuduB/hmKR/ptFsRTRm1PlggqAom4bRfbnkA5LwvlmY3z8gTjsfcAQI5bsAqur0QtGeCLa+lquBZ5KVVnNQC9OGtDCoEjqHVxShnsAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903554; c=relaxed/simple;
	bh=puUQpxpOOMqnVd2eFLdmJ7ba/xPE6klpnVs5liK0em8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=tMH0y5QgXhiOwBXHm3VUzKm7j1vaHMLfbzvzj/LGDoQjNMwYA8bjVLBfHekQ7NmDcYjCfhMP4jHXVJpsKrl8X3eUFpogsamtKrbjSNO8cYACEnEVLngELwkU7etq0vDIzWY1BppOPkr754LbuLgMxl3WvkzPDZD4umbXE6Btjco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DxNcDIBG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DxNcDIBG"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bba0dde4f43so667198566b.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777903552; x=1778508352; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxH/n2fmjxOiVX9boi8Uf5ZeGO40PmkXCnUi1eKqyXY=;
        b=DxNcDIBGFCSvjP3F8COyW4TYD3OkmV5R8C/gk5EGyNTePyZGoLPBOnRRGQpbEay0x2
         CQhQif77TqeXgN6akSy9/YuXhUoqKNqZcZpXr/PbSPWNRV19iP6yUlQvVff8kHgi1I1B
         +Yam1GTZ57agNtH6AZ6855pfGA8Y9JqQHqxQvIWypTAla3Q+bZ38YJ+9GSIyFXvl+gJY
         qaxH7Tal91MSDstmAIZRCs257gxGhOiAB5ntK9awRSa2V7CBcUAgwC9O3AbVyzWKEH34
         WoVGQq21sTLCv6oY8DFXNg9TjOST/MwVY3klj99ysVoR8tOYd47HFJjMGZmrAqiRCoBx
         kZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903552; x=1778508352;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxH/n2fmjxOiVX9boi8Uf5ZeGO40PmkXCnUi1eKqyXY=;
        b=EJ82vq6U7yTliNxBhgQtQABD+xAIFJReaMIpHzpIzpqfElVKcKHlGjVAFAAiUV6nfU
         dfPaCrn2Bw3LeQYovozX00FT5k+J6CwT9XaseA6EjRrCAJCvlDqamQxVefuflgglt/yx
         inxseNln3YvR6c7bswSdnbWOYT7bNRWdPS4NwRQr/MqCigvylMGRs0xsvH6sEq+VrU7o
         EUc+c6UioFQzAoqNs0Yvm5iG4CMXE00hWQeGaIrjjyuFwtmkHtzY1G2N9WOvAJQ1PUd8
         FU0Gwlrlsj4MsUr/yGFu1Eo8f4KSymBm87yyN8lnef7pIV7toGSu7GQEpXFG6kbSPy7M
         nKGg==
X-Gm-Message-State: AOJu0YzNgGhl+w4XuHw5vch1VUfm4kEDlpIhAorZmWIwhLowhD0ZSjUG
	mJv360Cr8UwNKaH0Q1bjDfkvOQ6idveJ6VWEHLwq2xe553AadCoZ8FvkkIAm28kj6dOH3iegnNW
	UTjuL3aY=
X-Gm-Gg: AeBDieue3rTwoNjdWT9HoogpYph80vsfleCysT02pC5U9efbmlWtSfMVdwtFOB5x3OL
	zjwSY3Khc1xZDVAPpHLYBGKY3d68VH0HTYVSJ8cpKms3k3QUl98QSAEZnv62TmDcXco24/GVmnh
	eCLndgBpm+0YqtV4nmXmYXzEQ6x/Sj6vKo/HJmDI9AqpTwhyQMIVHswI20tMgXNARllfKpQwjI7
	Cw9fzXOxlDIFdyXriNhjYhzZM9OFSA7oPeBlMJ/JwEib1sL1ewRzA/mB0718E/0e3HgbAIHpKd+
	MxKoNWIFUJ21sp4kp+mjhV/X275AceqZswXx85JdZzKqha+w1h4XxrRFYLa6gTYK00O6noCW4Y+
	Y53SPAv5LOyy9R+LHgEHvi68XKfDNvVf1Z8/9P05GP2JPRkyWj28y9NdBmYa7d1SmPnyW3Hfy5i
	IyAw+H7VOJ2lsixCv99K+HdA==
X-Received: by 2002:a17:907:3cd4:b0:bad:d530:dbf7 with SMTP id a640c23a62f3a-bbffd6c43bbmr534556066b.32.1777903551577;
        Mon, 04 May 2026 07:05:51 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:1294:2ecf:67ff:fe81:9da0])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6ee0b24sm6221372e0c.16.2026.05.04.07.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 11:05:49 -0300
Message-Id: <DI9Y7J0BSMZQ.1JG02IF9PP4QX@suse.com>
To: <bot+bpf-ci@kernel.org>, <rbm@suse.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <shuah@kernel.org>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH bpf-next v11 01/11] selftests/bpf: Add BPF_STRICT_BUILD
 toggle
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
 <alan.maguire@oracle.com>, <martin.lau@kernel.org>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260430-selftests-bpf_misconfig-v11-1-e11f7a8c4fdc@suse.com>
 <62fa35211e90c3961079550e6b826dd1bee301e86838a03ab15cb0b4a631aa8d@mail.kernel.org>
In-Reply-To: <62fa35211e90c3961079550e6b826dd1bee301e86838a03ab15cb0b4a631aa8d@mail.kernel.org>

On Thu Apr 30, 2026 at 1:41 PM -03, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -44,6 +44,12 @@
>>  SKIP_LIBBFD	?=3D
>>  SKIP_CRYPTO	?=3D
>>
>> +# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, or
>> +# benchmark compilation failure is fatal. Set to 0 to tolerate failures
>> +# and continue building the remaining tests.
>> +BPF_STRICT_BUILD ?=3D 1
>> +PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
>                      ^^^^
>
> The PERMISSIVE variable is defined here but never used anywhere in the
> Makefile. The commit message claims "subsequent Makefile rules use to
> make individual build steps non-fatal," but a search through the file
> shows PERMISSIVE only appears at this definition line.
>
> This makes the BPF_STRICT_BUILD=3D0 option documented in the commit messa=
ge
> non-functional. Users following the provided example will expect permissi=
ve
> mode to work, but it has no actual effect.
>
> Should this commit include the Makefile rules that actually use PERMISSIV=
E,
> or is this feature incomplete?

Users of this come later in the series. Kept as standalone commit for
improving readability a bit.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/251764=
31268

