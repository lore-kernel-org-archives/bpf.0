Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6061397E75
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643782; cv=none; b=XTc3PZR+VplvPStpjQ3OHAp6p9//3vtF1njIcAhjo9Csi6bl82lB0eJXFy8AJmMeo03WHfqeeFk77gRcDcAb+X1sFRJ9PvVNZ7TEVPJORDdAgzNuxXxS6Jskbeq77Tvo0JUa7Oge/Oj45cyEllvi1hVLUcL6dismCxtga6BI74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643782; c=relaxed/simple;
	bh=GS2fEMFBUVhajDpP3zSZFxMqp0jKTSPYaGNLUwEWlA4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=hnW1g9+/LeIH4nA7cFuEELSFDaupOq0xepEjwesFEXs889I7PzctN9M3A+johExl7CTtOxBfu0mSzMVeBKxBuBXNylEaJOoKPPuARD3BL3XH2yh3WoBaDVMVblePGgOEmB9APRvOoyfz/wPLsd/h5IdCS2WYl2HJNaeoQJWjtHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThWJF3od; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThWJF3od"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f3ece23165so1980538a34.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788643779; x=1789248579; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GS2fEMFBUVhajDpP3zSZFxMqp0jKTSPYaGNLUwEWlA4=;
        b=ThWJF3odswcaqK1yq3AiRhnOA/lhbJmLnmzoi1O3LbNnQzTfCdbkcEfU99ZiNps1I2
         p0bCIe6fjUq9m2ZxLzsQj8+7ntbTZh8RWQafJJ0dqvonWK0EKqOEz8mQJa9q5vsY1G6U
         jBhbGbnXI5Ni2YqVAQPx5AkyrsO/1B2kT7FVjbF5DBE6BYLRxT7vui5B9ksr2jEGfhgf
         8eeaKW2on21JM+F+kGd7X+IsresbYyaG8k9MPGXAc5bt9AKh/tKIsOWxoiWP06qyz+XI
         P+Yb3nGi+dnsuoE+FlBmec9Jr+U4V9V+dc3zCyD0gcmywK1s2GuPc2FC21PxsoWZ+/6X
         3aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788643779; x=1789248579;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GS2fEMFBUVhajDpP3zSZFxMqp0jKTSPYaGNLUwEWlA4=;
        b=hHPGPYCHy1vs49p+piAVog54r3VYyO/K4RUBWZUOLS7jPwi1c1KmdteyHwBMig1tuj
         9oKMjX321fwi989nHL0o1GQQCALwaijlb0GjpPauMo79Nr/E1ma/zRFapxqd5oT7snZ9
         OYPDJKDVx+l/ZuO7w4didMWnmZH16XzVPpCPXN3GUYL6fnI+tH4a2zskKor7XaxI52+/
         n15WyCzz2xSZn2d6PjKUkNIR4zTZSBq7Ml+H3Gjkzokd6kZSP1r7Fm0I4IbwT5T2O31p
         wSz+JV118RxTxXt2kyypkGQ/QKHL4N4KiWY5cocbkiIsUGUvLNcI7iOYUZyB1+o53FxS
         uMZQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8GJ1qDTcJPZ63duwdKlTSFvGxXKLtj8XuAo3CDDMoXoHEsoKqL54IfRijIQyzL4kwon4=@vger.kernel.org
X-Gm-Message-State: AFuF++n/fvjzoRHbxEwz/QwCtLUNeD2G8mr56ydluE0uBqYOLPrNhXK7
	ypf0GNyp3FOuQefrsaR9+vmLcyDKGOz71ypRqwHMLBdN68W+V+LJys4tJaO0BQ==
X-Gm-Gg: AYBFou1v+VLv5fJ4IdEwNUCAs4jVCVCpH7ieysvE8KXPVScRfkw/fKqe4hL4sZdxZL6
	96XkwrTdc6A6KdtqcjzBHdLCEceaX67/Ukx6Bbu4zcO4A6Fxz0/tWjlFJRMsbALoq60SPOfGiP2
	th5Vk3w2Gb8E+PiedBiZQc6c64qFS2PBvUVwEkNsoY7gvxkqdd7bJPdKb2AZSjUyfUFlChFge0U
	NQU0fPysJuCNpqlUjqZ7gyQpLs14xaBDylbuvCuZuK/+CP/7tAoHh2oMr3KXrRVz/NVPmYOh5CL
	TK0jdjcgggpuucouoc+46zFysl7WEDkHvmVEa3BLYBONgVjsKMqrlY1c/dugX7JFoejhx3Cce9G
	VBA91ovWi3aKFTuu332rjWnKsp1gZ/v4CoGC6+YVLdRNuxguW5kjaWNSS4VjsyWB7zoQfPFc7Hu
	b4LBHZG+tNiux7QMjB0/R6udW/9qQe2t+fOMP7ZwHyVmJuevQ96fMD14RdOSuqNu8k+6O+I74ST
	3Xf0nK05XeHCjqEf+cq5OaK5fe8ukjxIVFEDzkIWAe6rbQxtMdsR05Z1BdctW8HxA==
X-Received: by 2002:a05:6830:2544:b0:7f1:ddf1:c731 with SMTP id 46e09a7af769-7fa1fe6b941mr10802928a34.13.1788643779382;
        Sat, 05 Sep 2026 14:29:39 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fcc45d7852sm1178325a34.20.2026.09.05.14.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 14:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 14:29:38 -0700
Message-Id: <DL7PAW1GJ5EE.3A8VB5PA5K3H2@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Nicholas Carlini" <npc@anthropic.com>, <kkd@meta.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Validate graph ownership with a
 bounded walk
X-Mailer: aerc
References: <20260905090750.4064411-1-memxor@gmail.com>
 <20260905090750.4064411-2-memxor@gmail.com>
In-Reply-To: <20260905090750.4064411-2-memxor@gmail.com>

On Sat Sep 5, 2026 at 2:07 AM PDT, Kumar Kartikeya Dwivedi wrote:
> btf_check_and_fixup_fields() prevents graph ownership cycles with a
> one-hop restriction: a type that contains both a graph root and node cann=
ot
> own another root type. This limits graph ownership chains to three types,
> but also rejects longer acyclic relationships.
>
> All struct metadata is available once field fixups finish. Move ownership
> validation out of the per-record fixup helper and walk graph-root type
> relationships directly at BTF load time. Reject cycles and chains deeper
> than eight record-bearing types, which keeps recursive destruction bounde=
d
> while permitting safe acyclic layouts.
>
> Keep the depth limit independent of MAX_CALL_FRAMES because graph teardow=
n
> can run beneath a BPF call chain. btf_check_and_fixup_fields() continues =
to
> initialize graph_root.value_rec, including for the separately allocated m=
ap
> record. The ownership relationship itself belongs to the immutable BTF an=
d
> therefore only needs validation once during BTF load.
>
> Update the graph BTF tests to accept the two acyclic relationships that t=
he
> old approximation rejected.

Are you saying old approximation was not correct?
Pls explain how it missed it.

Probably better to merge patch 1 and 2. I don't see why they're split like =
that
and patch 2 immediately fixes patch 1.

pw-bot: cr
