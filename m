Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FD72E06E4
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789231333; cv=none; b=tWaGDjP6v+fy357MUYh//Y4VZpjZufFUHnMl1uPayD2N+aXNH70JQBFK+67S0XLRbVwFpMQ99xxS2ypjmj85GY30zB9eAWCDw6lsO51Zm/57afz3wXXadwo8NxE0xTozBK8/2AUqtQXiSQ3Vi/gcsW9UyFm9hQ8lnvpdN/BO8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789231333; c=relaxed/simple;
	bh=T60Nqt2c8Xn5Gatb3hVDWMSkm5r5sH3Ts3mlaHRL2CI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=UuAYUKp0Qnxj3E+SaoYPQ6exNvZyuLWX4nDzRaZ+rHpaNnriPsAyTu+2g3aVKS1hKaz10y0rWv9l0yNCa8ny7dr/voPlQCgRUdz5/1eEdw2NemuTf4CdJdZ23PX+DRtVh6dm1Ns8erF4Niim1RnePJ5eSBaMz8urHfuYBOoQTgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+gptKKG; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+gptKKG"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-478cbd5b48aso796912fac.2
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789231330; x=1789836130; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5EoE7eZ2BnjQmEntJT5alFbk0z3p9k1vzuNo2TJIcNY=;
        b=E+gptKKGvTaVCfBw9yxRqKWzuvyKh4kqEXhh0x5WA/0V3oXvEu5swb8vzFcfoEQ9Fk
         Av/Bm7ystT4sOWfYqEMFD2wStyuiEgxMSmPGiEPO4x3irWqcT0N/Bfd2eCTEFC/v+6Y7
         JEMJ1S3Z2J4mmEZ7qYk12+0dh8735CVFy7uXK1OVEt/FwanF7j5JePRqSvWqvEQnWBFP
         +TfI2yDeqkXWsMzl4YOK3nWZ/zaWu2xGC6nuLzuqtLX16Wabc4Rcw9yAq9amqaoHXcA2
         cMR5TNBDdA4L9MOuzvvnlwAeIEPZjeoWo/VSj5uA5srWECzyUfdQnJ4gENlFFYLhlfMc
         IPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789231330; x=1789836130;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EoE7eZ2BnjQmEntJT5alFbk0z3p9k1vzuNo2TJIcNY=;
        b=o+I0grg/Td4Z4ct7z/vov9JEucapA3FxsVFizySlvNEDMimkj+iRX3Ewg4Ij77j2HQ
         dYIzAgR/CBtTKaan81wHlKa9nTgkckYPOwpWsgLQuVVgrfRpD/p4TDKs2ezoiFQmRiE5
         xY8aA1ONno7nsCLFih3M2On2m4K8Mc4pHVobdwcPDm5BHnuL+mp/zQL94diLXiZup2vw
         memi+IAmgGuMzUP4Uc+lr3KpxNWj6pkoMgoh9dCJC4xv9CGeyrsRADtxPHSPYkyfit1v
         rDLO8NUZlYaxVY0VbK72lnmN9JEGdNpQ1wCpsVV++t/hl4/PO05sd1adwcIouMh1yPph
         O8ew==
X-Forwarded-Encrypted: i=1; AKwUvBybsXvwUHlWqUIy9dD1Q8+l5H9UaTF1aBkSVu8TRjdBG1sMb76nPVmTSM0I2oV1gQA8eeE=@vger.kernel.org
X-Gm-Message-State: AFuF++nblAw6KVt9+Lmnae6vgN+tksuyNGDfO2AIbmgGL0xmeb8zqS82
	+fnHXvfKlTxfhyqElCCRvxigR74xknM3Xg45/8O//ImJ50TW0D8cmn99
X-Gm-Gg: AYBFou1DCUwYzaZdg0++ov78tR8eIp+OUKhzDO++TC2TEulUopsVh7ro5CUrH00DXyK
	ZuNhKYqzITIy4KObrMqI/K5NKbVvgg4Gzi4y2SK531E2UJ79Up1xUL/BVRFmox1Xe+oN9bz8bcr
	XZJt/3tZDqz2SX2tmxnQ9Pz0D8+wbxuqh4pTFpJAaPxi89AKVpF5YTCmhyOMZd6WUpQofebAJ+l
	+bNtCJGeY0PD1qqR89to3vp1RJ0UR4sL7tNd9OndQr+81Q01cOMZgArFZ/wtajtPK0sFO7Ebb7E
	vkRrIDeb4TfofStpYDmE2HFYS5bIr4KxqNrwLaWMa5SR4pFS7ULpKP1flYU0OeezkRSIC6XCXKx
	zplzA2p2Z6PdVMs39f80OJAXG0Ir1moL3xClGaIUQewRXJOA69Ry66JVLB47U4YvcLHJfbik27S
	rK46Uc6jDGplhG/kx0nLA21Yxv+usMwbJ3kSs9EvR+eZ5sHnraE6KErzipB3gD0NzSnKu7zCWZ8
	WfugYwIkNe3HDETIDLpY7ktifsBSoI0dg2es6f86mb46FxOozDWgSpAsvYPe+JrMw==
X-Received: by 2002:a05:6820:83cb:10b0:6b1:b23c:2142 with SMTP id 006d021491bc7-6c0b9a5fbb1mr4774103eaf.1.1789231330275;
        Sat, 12 Sep 2026 09:42:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c2072f33fbsm3117683eaf.12.2026.09.12.09.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 09:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 09:42:07 -0700
Message-Id: <DLDHKKLCOAVR.3PHQ832S121Q2@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Florent Revest (Anthropic)" <florent.revest@linux.dev>,
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "KP Singh" <kpsingh@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Leon Hwang" <leon.hwang@linux.dev>, "Junseo
 Lim" <zirajs7@gmail.com>, "Sechang Lim" <rhkrqnwk98@gmail.com>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>, "Ilya
 Leoshkevich" <iii@linux.ibm.com>, "Hari Bathini" <hbathini@linux.ibm.com>,
 "Christophe Leroy" <chleroy@kernel.org>, "Naveen N Rao"
 <naveen@kernel.org>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 "Pu Lehui" <pulehui@huawei.com>, "Tiezhu Yang" <yangtiezhu@loongson.cn>,
 "Hengqi Chen" <hengqi.chen@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/2] bpf: Skip detached progs in trampoline
 images that are still in use
X-Mailer: aerc
References: <20260912095924.866254-1-florent.revest@linux.dev>
 <20260912095924.866254-2-florent.revest@linux.dev>
In-Reply-To: <20260912095924.866254-2-florent.revest@linux.dev>

On Sat Sep 12, 2026 at 2:59 AM PDT, Florent Revest (Anthropic) wrote:
> +/*
> + * Each prog call in a trampoline image is preceded by a nop. When the p=
rog is
> + * detached, the nop is patched to a jump to target, right after the cal=
l, so
> + * that tasks still running in the image skip the prog.
> + */
> +struct bpf_tramp_skip {
> +	struct bpf_prog *prog;

prog pointer shouldn't be necessary.

> +	void *nop;
> +	void *target;
> +};
> +
>  struct bpf_tramp_image {
>  	void *image;
>  	int size;
> @@ -1374,8 +1389,27 @@ struct bpf_tramp_image {
>  		struct rcu_head rcu;
>  		struct work_struct work;
>  	};
> +	/* entry in tr->images, the image holds a reference on tr */
> +	struct bpf_trampoline *tr;
> +	struct list_head list;
> +	struct bpf_tramp_skip *skips;
> +	int nr_skips;

I don't follow why you need link list and 'tr' pointer here.
Also why keep ip_after_call ?

Replace ip_after_call with array of bpf_tramp_skip { void *nop, *target; }
and then in bpf_tramp_image_put() instead of ip_after_call do:
for (i =3D 0; i < im->nr_skips; i++) {
	struct bpf_tramp_skip *skip =3D &im->skips[i];

	err =3D bpf_arch_text_poke(skip->nop, BPF_MOD_NOP, BPF_MOD_JUMP,
				 NULL, skip->target);
}

what am I missing?

