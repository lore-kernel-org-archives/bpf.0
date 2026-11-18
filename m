Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035145;
	b=vDU8ztnAAFH21+JP3/gjfaTXOPCev5ySKNEjgU0tZOuiasAdioHru8xI6GQN2+vaqwzY
	 ejtV7NSDniN2+qX13XJq5lZt2Lnh+9hXIAKJabVhkQv+M+m1LYEVArbTQUfvlwrsoU76k
	 Xbz9WspUReXho/rpv0TeZVUzH7t8pjI+8+k3M4zh0B+5d2nrVH4DT/LpdVPr3u5ZGl4Ws
	 CKsKW1YWFNZjOydGWzhLh528Zx3BD+Yv+N0Pv4MdwUowH7JY0X7+JBXmscw/AUaZj+ri+
	 osv51t5hSkwCZc6tQjDzH74Ck+bJ8WWs9Y9shh6UNNjQOFFp2tX9VVLaN2LI9VrYk2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dxmySTmEZ3hib+9H5pqVDEDQRI3wIZljNjzSSTwZn7w=;
	b=UFWKGEi0e7lp13wquy+CmYQqUMIdqlnHklOOlpocbeXQjgZAym58Li8uY1/cqmz0Lt+e
	 jG0dSTpIoHH8LJGq9ixDSmbCbBFXoVGr9aZpk1fqPCGlhPlBN+WtYtJXlxZEeSq4cev7B
	 qH2E2k+ojc94t/UhhReuxlbmH0FvSfbS5UJj2BvaYpX+CEcjnQDz/6tY3oc8xFOrq6dMS
	 odpbPBT9WxY5vlsudVRfJbT9cEWC1Yw2CifPlbEqu4A7w4da7yt4C+oUKhQushpNVL+HD
	 oMBRc2XcPtCf1nzMTOXrTUmm7EhLPlhiW18wt2wjeYzwNsRyefI9DviDOvajnhUBKFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SqHUcWGu;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4697B606A32F
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 20:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4697B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SqHUcWGu
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1052737a12.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 12:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035144; x=1795639944; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dxmySTmEZ3hib+9H5pqVDEDQRI3wIZljNjzSSTwZn7w=;
        b=SqHUcWGuBJ5iPjwuoExkJaVT/UVpfdPBxDUFOXh6mpiQuWiJKjjQrPeuXpWMmMwI/u
         soWYK+E2+ktGyN0Mz0Y/0hREtps/a3j0GpYhuBoacNC49w4L3fbdbfPmwLRrhgBUxom/
         zsFLmibB8/aUwOgVfsoKnxJ48Wg/ZX8wwMZkIxFkXgN/13l5erXTN1NQchLap+467x4c
         LCR3snF+qsFzpxzJx547CpICfIsqqVjRXbemsyTJ97tlHu3vMXz0w3VotAin2HXQMLVk
         F9I4XGQ2sfHYLYsTlk2h/KNSgRqNnjIIIS8lmZtgsWecH4GG6FpElOb4rFYA1+uwN4pm
         irLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035144; x=1795639944;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxmySTmEZ3hib+9H5pqVDEDQRI3wIZljNjzSSTwZn7w=;
        b=FhjlMXBTl7bLK0gS+GsOdyRoHF+/E/1U1js4XQ4TlG/smg6FWJy9QYbhjuEFbXvPYO
         VEv/UOU9vdb2qVZ3ogkRkRs5gNshNnQyDESp8/1MRDf6k/Z2u9me9EOXaumjDaacdw/5
         rga9mpXMWK5faZcu/UiccapthIubQEA+RSobocGJUPmemrPNtN8IpZwgKdh1o0abgHhJ
         l8FEf04kSeIgMcYd6qTz2p9dS1Sc6Uv0O38GBFdvYojeViW7E46z20hbCwutrQ7CnfTo
         zgss0o8zoDtW+S7a1xX028zNvTSbxiu8P5vAqwVtVt9QEIuXMcM3htsz4ogqyDhw2i4O
         rTEA==
X-Gm-Message-State: APuU4Z83nseLX4+bxMF25bkcjIGAo1YJGEs+ZhvdAljOjuUsZySaKVNZ
	H0g+/X+LCDlxxjHFB8q71tkg/BfeixnTBH7QWM9Jabr5dcxXQGc+jsp0
X-Gm-Gg: AZFdTZc7cyAQkLR6RaUKdKggO36TaM+Ahd6U3zgxD1e2NKysZKW5lTeCVSUKNlZwgfy
	ZH5HTXXWoWoaTSkXfF7UneAZybJWYZ86x2GGczIQdVzaV8zUpYVcMzpi0Eol/8L6VdgymC2kU7W
	0P8vEq1DdubZ7pvXCrotIO69LvhlXLnoB+RO3ut1p3pgasuZ5LV3B25cCP9macxVuPGfFpVTLUc
	Kj2AcRIpumXG4Ij/RY9tdedZxnrETDjbdDrY9dESJAKJXNiHGyslHVzwHjqNYata1zHcZpO5gdc
	iJ8HCdkS2+T90byPGFK81Fw/WYB7i/8v6DLyPZqw5VmNKVMysTRmLo23yjdm0vudxMpxVwl2djq
	TNQYFEm1/dkltwLFlQtS/GessOfEhXLDZ2MJ9R6AuBkTDwyAGTDqtKmFkVE3nSGPtDHbqYOQJax
	ivDUfcCMEtqfskknIjLmbx12ckwvN0VXUYI/6tYvh0z4Q8CTt+uI35fC57hSaX6/OpPMUfHep33
	Bsd3R6MraeDHArw3DMV1Kj8Vl8Qp11/ftFTQrCKakD2yF5WsHabTWTgL4t/lwH1dsTQgpTX38zr
	xOUklzfJjZb36zm0XE6myFZwi+VRk5wiJ+P+4vWc0nOHI27KCdphoycaBfu7axpYsuFs1aNAO43
	DW1shqqx/wZBXymk3m35s900oD4bdPFMYNQ==
X-Received: by 2002:a17:90b:17ca:b0:3b3:c00e:56a7 with SMTP id 98e67ed59e1d1-3b3d07d458bmr3354393a91.42.1795035144417;
        Wed, 18 Nov 2026 12:52:24 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d56a3f93sm2644508a91.2.2026.11.18.12.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 12:52:24 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 20:52:23 +0000
Message-Id: <DMYMUOTUYZIC.3CG88B0ZSFU7E@gmail.com>
Subject: Re: [PATCH] bpf: Fix cgroup link update after a failed effective
 array rebuild
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "J4f J4f" <shlomojune6@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Tadeusz Struk" <tadeusz.struk@linaro.org>
In-Reply-To: <CAE_LbwmtogEFvk5jDUcYhjSaX7_5bsHy-OWxCKPxmiBVDcjj_w@mail.gmail.com>
References: <20261112134942.288831-1-shlomojune6@gmail.com> <DMTHXFS504S9.2BU4PDLEWG3PX@gmail.com> <CAE_LbwmtogEFvk5jDUcYhjSaX7_5bsHy-OWxCKPxmiBVDcjj_w@mail.gmail.com>
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

On Wed, Nov 18, 2026 at 06:41 AM J4f J4f <shlomojune6@gmail.com> wrote:
> I reproduced it on f66469d9905b39 (7.4.0-rc1).
>
> [    4.307527] BUG: KASAN: vmalloc-out-of-bounds in
> cgroup_bpf_prog_query+0xdf1/0x10a0
> [    4.307589] Read of size 8 at addr ffffc90000073050 by task exp/74

That's the last step of the scenario.
How did the alloc in compute_effective_progs() fail 4 seconds after boot?
It's a small kmalloc with GFP_KERNEL.
I think it fails only for an OOM victim or with failslab.
So it's still wont-fix.
