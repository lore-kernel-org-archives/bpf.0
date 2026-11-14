Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794624989;
	b=OPcN4UA1ke+q16Cn+x8KARN8ykXRpACuPBcQ4PNoITUo+5YiNk4RXKBt+jjox74TVx26
	 cdnwOD0F0Z8oZgEi9cCAQeXBpz/Tk04FgdpjFARhWpNbCTQ4/rtShvTk/DNkGQ9HQHnRW
	 J8MJzp4ZO9dBbwBhwAiUoSSJwNW7KSeg5jXIOibMsqYFd5v3MrJEdNIR/5sBx/c1d21IZ
	 FCJgoOEYkTXR4whypnWtjoJquqbYO54rat96Yz0dxS+M9zWYBo9jUW82YjD059vLYWQ89
	 geFWpwgWZbcznOMBtRJED90JbcdjpNV5Uu0WGRSzWEOnWqqhkjdMXix8j5sTrzcuD/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DXaSN0Fr6JcTZ0oBKaOBneCo8B26Hy879oIpVgJVCjY=;
	b=LOjXEzhJdOizg952ciTJ9vvWC2OF7Mbhvok7JqT4bpcXuZl4oa8Usp9KMOwsgYrinbdd
	 FH+4zNgwa7NzUP7GW923oMqb+Jn3Tli7DcIJIaab/5PI8Ncb3wemOtZHjMPmzNV8WefkY
	 M1DiO9EEZp6XLQBDcghPbZCYKkmI0Y7IUM+Feqi9cG0ciuUPZswykYCH3kBEXgwXv7XOe
	 eIOYtCn+bXXLfjdU+Ld3d50AMyt5flOqh2nU6b2OSCnu6uaDUN7/uRy2vqSsurRICRqaW
	 OdIEZBEnUGNLEqlIg6jJ1ok2BWVABmet8u1cVr2yrmuKbBnJQcmUEdlhatxrkmLBgAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F271ZPsA;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD4606A330
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 02:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45DD4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F271ZPsA
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so886268a91.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 18:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794624988; x=1795229788; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DXaSN0Fr6JcTZ0oBKaOBneCo8B26Hy879oIpVgJVCjY=;
        b=F271ZPsASE2nn0cBwU2z3nrOqmEB7IsBi7VUB1XP8xsVs1T36Rk8uScTq9dzju/j/E
         YXOtKWlbcHaZNdCd0BfMqsL/3tjLyk4lBaT2dw88DFSDjqCLFo1dk12pvlC/rjzGJUxG
         YplTHJLUdUz2B+IRhFYAQG/ZFMPd4Zn50chZwuC1XSdivJus957D1HaVsTA9VnCHGa+a
         g1T4FbYIxG6Pd3ZXDO6162e95icEmczP6ScbJInpHqDxrBg3L9Npabsy6YF2r47EzQpi
         q/vhw2hSaAojeqc4ikfTVrF/WnvMFHXgrxB/f3rlSbbiJGyX1N1VChVS8GeqMMwwbvR9
         +csQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794624988; x=1795229788;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DXaSN0Fr6JcTZ0oBKaOBneCo8B26Hy879oIpVgJVCjY=;
        b=qnF3dTifTDT/y1AmdJLIV5PEix+60BRSJ5uU5qyNtZgzA53svm+Ju9N1tJyeOk35/2
         KHjx671tg26VKyhbPdJ+/ROZdS6Jdp2dXH8YtWsAVOpH0UZWSa9TNm/WyDG43Q4RKRSS
         awunEu5RHhDQ4XILY+jZD6lcCSDHwEdJyo8ckGT/OXsPfRJQ2R2zvst6tmx/lQuciO1+
         RJGrRlojnrbZvFS3kw/ERLHOCBIvXsUAkxrckX7cJ7Z+yWZfyCUD6skppWLNS9Rob6oH
         wsRHM637tODC5ErkRPAV/lHPJf5H9O6X7dI19VY438Zzrf4cpyDuUMkT+R5LmlohmOJy
         sEsg==
X-Gm-Message-State: APuU4Z9qaJ4fUnwiLpaS5yxe0Ik2TaZrI0ajOkwA7Q6Eg9daZPggvLpq
	scKKPWMHjQioGj+ySo0LCTZo+ivV43L8TPQn8gP40Yf+Cy1n1eXK6E7M
X-Gm-Gg: AYBFou2Hb6RLnirFiN0R2YTjD0a3I1w6w4IDGB8PxPjvTuOKSetn1c6Vmj0hPaoPu6w
	U0pqQjhcPCdlPg5Io50Nd4ljNU48k43iYr3IIO+6+qucUk8OV4T30qgeI/XTFWMCIPfX7lOSUtX
	kkdOW1F9i7nuTuGT0sXS6ts6D8VZZ8s0Lg2o1sHVM8WH8iEBssldMMsb3JWvsw67Upae63rBAlp
	s1kbyzVeCF3LcQgUmMcgmWA593SI5YxXstaI1pjFJt6nNl9oHex+sHQAZ0lncxff4mXAQtsmzy8
	JycfW0x96xf2dHEMEjVvqE3Xlt6MyYAgWgQNRJ1feq6nfLfPnPAh6N3Yfu3D2UVa2YimwrOEJ3s
	xL0qIDSlGaztO5oF7wOpGGKhLhOalfPiGrRcc4uN2y8NUrNfMZG9Ta81EuwUlesi53JK6sVV21l
	YVf4PAgj8FhV4I66bfCDT7DHwEaBga23/KmXcF3argZVcYXiJbKWVKx8WxQ4pSDEx5ZXPX4lYeP
	Xw+rCN57FzrcCZO0EtbkQ5jNbIMFHJgQgPtVgM3ztcDUsa0G3G/IE33ghUZd1GVmhoDzlUHl+gT
	4VSPYoC/kTm9aYLS4QX1DnwhpO0MInfQqmiOTAkpwb8rpLR4ePlCQ6vNMY2F2xekTCb/phgCoXz
	oFE7sIHkQSbhT4e3AW1RDEl1n4EylvUy1LiHg52EIR/l8h2dxDRxLxOo=
X-Received: by 2002:a17:90a:c784:b0:3ac:8af9:4a77 with SMTP id 98e67ed59e1d1-3b1b0a0e859mr3188105a91.10.1794624988299;
        Fri, 13 Nov 2026 18:56:28 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b25ebf34sm2758293a91.1.2026.11.13.18.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 18:56:27 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 02:56:26 +0000
Message-Id: <DMULGPH2RSTQ.19OTSZVNUXME4@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: mask speculative out-of-bounds skb helper
 loads
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Trujillo" <datrujillo@nvidia.com>,
 =?utf-8?q?Dani=C3=ABl_Trujillo_via_B4_Relay?=
 <devnull+datrujillo.nvidia.com@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>
In-Reply-To: <PH7PR12MB879437C51235E3A3094EBCB9B27E2@PH7PR12MB8794.namprd12.prod.outlook.com>
References: <20261113-cbpf-ind-nospec-v1-bpf-v1-1-764ac4c14573@nvidia.com> <DMUHIJ5FC8EA.2XFM7TJ6AH0YB@gmail.com> <PH7PR12MB879437C51235E3A3094EBCB9B27E2@PH7PR12MB8794.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 13, 2026 at 06:50 PM Daniel Trujillo <datrujillo@nvidia.com> wrote:
> With the instrumentation described in the commit message, the
> reproducer recovered the target bytes on the unpatched kernel. The same
> reproducer did not recover them on the patched kernel.

That instrumentation is a CLFLUSH added to the kernel in front of
the branch. Nobody runs such a kernel.
So it is theoretical.

Sorry, still wont-fix.
