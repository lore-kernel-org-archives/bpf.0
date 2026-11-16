Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794834514;
	b=hOJ6sFm3pVExMqG9F7sy9JSUg8mwPYNT7qLxmJAeZuFB0AlXezmwX2NftiB731TTa7mL
	 dPt5JgNS1pwGGWLEplo8ofp2HKQBCO71UqB6tyosDFuRn3+nQjAt5xEGWBpVgx7iF8nst
	 GYWp3yWRvNG6QMMD3zQGcxcF1E0tYr+3haSsWpMheX/T1fTFGYHZRWGO9dIqgXWzVteZe
	 YftHq/dgvNWj1+elJjL8YSpPMYd9UFOaKbykioqsijNhHdlHveiLmijTVqaqNQJqSANBA
	 y9j5LuG5dBk1TiFrZc+XKPs1vytR5IJx8qPQ2LcRiorg1C88cF88enekcnC3wFlrnrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SJJ2qpANvyTR8K9yLqvEvSV/pVuGUPXCU9gwVqvlEl8=;
	b=OKFpx8ZZe0i/RVhnzFoHIhFopkirbIScm9UWZweP61/yC1baS4iHEJyQwmLPoZQahVz8
	 qGld9ecOPz3IAQNfeU6BGOU5N8r8w4Gcoged6KarsLruzVqUgc8bAKcRtDWEeaS+Tknh7
	 KONiCqLLiz1Y9Jxx7tEjFT6oYbjkfJUScetwZU8aNMjvHIS7Cp7OPSw64tve23uz1Cwp/
	 OAUIGLnNC64AFe/eeJcf4tckDAe9TtB2G9saU4G7zf80qr3dGDWuunxS4+67IsZKzP6bb
	 GSgGFDxYFZGH9c7iCyJLMbaIm/HK9xzVWVX39BRAXUx1e7dcFH1c+dVZuJliLEBwQxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=PnAQWxel;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EA4606A336
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 13:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5EA4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=PnAQWxel
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-705cb6ceebaso3748960eaf.3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794834513; cv=none;
        d=google.com; s=arc-20260327;
        b=IL0f9Y4lzc7PTNeujHXZs5NH5mQyAykZayi+hLTE6CKYQ5bHoTxlSaJdqpiFoc6Yl/
         xtNGssnEpZ5m0nT3P2DELs/fIkgon9RI62D9EjyWF8YstH01xJxq6SRdIhdo+jWuOjkm
         vAZV+ElpZZOV22r7Mth4UEDOoTmowDqw1z2ODwfd7aJsOCd9Y2sTGhcKV2BPSkhqjHEf
         Ii427us6lzcJEHXzmvWwnT+Uv77YJ1yvGGHgAYigT48I/lyPdjYuidnIje+Psc/8Lkru
         oyELw0Rz79g1SXhVR1cd7ymkf9F7X7B8VnVA9LoTGqzER3Yx7SPnZTAQ9LXCNkvObNr0
         25NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SJJ2qpANvyTR8K9yLqvEvSV/pVuGUPXCU9gwVqvlEl8=;
        fh=7FK/Lglblx6obX6qCBHmTXlv+oZLMEELTD/5YV4aLhQ=;
        b=iYguWvLm/NDFOcB9QOEkLHE5T8ruGZ4o0hfVOq8la+RiaJF3PVy+vJwMqzeUfbcCyt
         Qvxj7/2+8rCKWqbEdrE6tPlThT0Fd2rAPLME8g2/BHEcVQvTsc4CGtgwRYMowI3Xl4Zy
         pkghNfaMqk3yxMI031wuasrY89Twq2sJCEBEB4a3ELI4tu2b4Z6q4Ns+RIt/retNrX5e
         vUGe/EFVspTkq3stAwflyn4SoQNJHXgctkAkz7v5rlTgovQKz0hJLMhjihXE/w7aQGs+
         TJvTy4/e+48TdjPQBrToJ12DnLVyLrBP6O21FoKztTm8jo2MoY09nkdZp25MRWVwCcX2
         NDUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794834513; x=1795439313; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SJJ2qpANvyTR8K9yLqvEvSV/pVuGUPXCU9gwVqvlEl8=;
        b=PnAQWxelMKwpd/v8tbVyyOErhLwWUPNbTk2/4gueCFwPgYw6eHD6HmaM3cU08ZM+j6
         oa5z84SDbXbMpZF+YkdoogskH90WSyO2Rh4Sw54JrWdnYU2ENifHszT2VKQRClf/mV4k
         M6fLcrjpThvrZs59s+qKwl9uT9gWAo09lPVxe3keTMIesHftOhFOnMXBoTQoKklyIwpu
         8xcVN2djQ6sruVDJvP0WoKsKGqpL+A1PFZ6/qAdLf+9fyy2wE07uL2z2G2z+kbl/pSDX
         wohfgUgE3Wu4jCDfFixk85aNjSVvUrsuIr58jeTwo715+6AV7uFFgbcRxPM1CXiTWWqn
         AUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794834513; x=1795439313;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SJJ2qpANvyTR8K9yLqvEvSV/pVuGUPXCU9gwVqvlEl8=;
        b=2el/EHzBepIiHkRwTnZCufUdh6wr3Tcdi+CjCDuBnuk197G61jFm7jeOx2MqwLcr85
         qj4ilDegUTsTU2p5bnqkel6baFsj/sV27/rM6ORfl/Sj+Z64j/uck5hfGumMOUS6NRwQ
         XjenhuscS9BC3lXc01aruwATA23cHZih6JIOt2jXKJj9n0YkB/Gk6zemAjxPezDYlmhS
         wNNggYQZw1AyrQsyt9tCJBSiJ8gWpb0f6hqv3UsfP+EDEcjxoIhtcPDZ+Mn/W9RzieQg
         40E9GZm488MFwePYl9XzLQ2JYamhtteTXIHKgfCgunohNpUP+PNH5Ml0i+Pg3cweF+1k
         zi0g==
X-Forwarded-Encrypted: i=1; AL+hErH77k/y9rdQXP9pwZASHADx+BLOZGKLJ3hoWBAT49OTnBj/xYHfcXJxE55dNhtPUEof6ng=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1WarZ5Cd/CkNymu8LTzo2fFhSfKUUbOUBsW3jJgkIIugeXA8O
	WzkQozxSI5F/zqjo3I5GWBhLZ+qiONJ/PbYeNzqLtzSO7UL1e2jgt3Hs5XSDTkNyyj+ykLNq/ZD
	giXiFUGZ9+oJ2/kg9LltW/ts1XFYxCITwNaxfvZ0V1Q==
X-Gm-Gg: AYBFou38j8rYV8KFls+cY8tUgafF9Jxes9hmAZ8EWNkMWAH1VOx71vfRmhBVEWGd+Q8
	WwlqAcb4k2JCgpLtnxqPCoaSq2654m4KjPUQu6uTtUQvz4GmjxR+ttLKRI029y5hZvt2J/ErDvx
	m3je6GFjlDFYpFJhV1gWS4ojYNEmIxzzFD8BjBkxojxNvA0Lz168SlS7H1y4bPB29BIlJZCjqYf
	EQf4h4vha3dJUXYNUTvfHpeJMaOpIQwjkcFjgexwZRRQkqYCrbo1CvfDccCyzohTN1VNpKGePGu
	lRxWlizrdCIbyiKjBNBrL/VOco87eiZihbc5vsCK5sTty238l3RGDWc99+NL+Wls/hAJqLTrFRL
	zcezp2/EbaDPMZGypwsebrzoHv6eunnZ+RLzfk8k+oGjOCObu1+4yvNAOFmTAzNCIJFz0qpVMUm
	EjRD9/oSw0qA==
X-Received: by 2002:a05:6820:761a:b0:70e:78ba:1193 with SMTP id
 006d021491bc7-71ab4f10ec2mr6796326eaf.27.1794834512803; Mon, 16 Nov 2026
 05:08:32 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com>
 <20261116084107.6675-1-emmaonana18@gmail.com>
In-Reply-To: <20261116084107.6675-1-emmaonana18@gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 16 Nov 2026 13:08:20 +0000
X-Gm-Features: AclHuK8ATNHdUFf-g1l7OKHnDpIsGdknxqvgkzdQ5Cs4Ojj7SzQBhCC284Pvha0
Message-ID: <CAG4wq-fhK3Mav3vLFUVYZhiXy9oF4CdazxkbOK2NNy7-KoLyXQ@mail.gmail.com>
Subject: Re: [PATCH net v3 0/2] selftests: net: veth: propagate check failures
 to exit status
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 09:41:05 +0100 Omokefe Emmanuel Onanaroghene wrote:
> Changes v2 -> v3:
> - Add Tianyi Gao's Tested-by to patch 1 (thanks!).
> - Add patch 2 fixing the remaining three checks.

Thanks for fixing all four checks.

Please be aware that it is recommended to wait at least 24 hours
between postings [1].

[1] https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

Cheers,
Tianyi
