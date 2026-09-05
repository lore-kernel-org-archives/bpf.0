Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015928C5B1
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788593527; cv=none; b=qJf7F0I8Fs7oLHU5eHZ5yfT45dpRK9wop8u77pB2Y3DE1GFqvCp86sYRGgPFvDscuA5TqXOlbYN5zrGLOY2rpNjr+R2vGmBsQxTMcP8C10fogn93PmQPPXjLR9VvprPr/DjvlGoYNR0C+xiARC7bl8A8qbLuyjQNIavDUjEa8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788593527; c=relaxed/simple;
	bh=ou2fEbhVb1iPX4oTqnFSegex9wa6QnGgcVFEAR52CRI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WZiSSmJpXEm/p4GNsQzn3NVA3blmxC1zUDqBdlhktyzW6qdooC1tC0Pb7LjCkvDrCbmwAXWpcpeYXMqwVOFLL79RZpF+Qkbg1DIxvPeNxBgtBmi3lhzqXbb63yoejDTJL76kQi+flzaTZZQ0qRfsVH8p+Q9T13Xsma3cUfLoJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8lp01w+; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8lp01w+"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so4106855e9.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788593524; x=1789198324; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Uf35E09dO4nIBoB7Nn5xsD7EOBYwYd1JDja5BkITBhM=;
        b=H8lp01w+YR3Ex4Z0ukFzb8dEtHjlrsU4TBfdDjj90AC6de2zdZNm0sbBxfwOF2P04C
         gluFa+PiNbkc61TiUJdBkKGP1y3Txi9fqedHCI/ZxEu+0FM/r+vya2jJGK0vuIWFZXu3
         OXtNkofCc77O1/5t+ejDgS4axSoFak+H29FBkLKuddsXiuegPIvj0u1G/44GX9s9cFBP
         yZTvRdx786ZsRDZYKiJXJ1GbWC/w4t1ip5qTbXBqbnsm4GqG8KJTr+aCdzoMQxjoD7qu
         SrbuztvNYhM7QVrdjWm0qRicw3gkqdRt48Cc3rqcCAG+QOur/0pvQhrmDso9JQyQ1qT1
         C2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788593524; x=1789198324;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uf35E09dO4nIBoB7Nn5xsD7EOBYwYd1JDja5BkITBhM=;
        b=mlVuKZWyDBdtY3BBwZ/+fUAUdutHarwXqRskXQbovM+nIObzuE5xKSCc/YK1Iw4ea6
         oAofJ6Ak1HLKvjAvXNpFS3TJO0WWHkX0MHvjOV85pA2eCMgtJyxP/Msg3jiXKuHWT//U
         u+wJSafXxCPD5ertUM6AshNUX6jKfokEBd0cyP2mcdozx4AvTfF0BLy2pBsXiwv4WQ3A
         dTZyZdDmE22YOqF7PWJ52N6PqNKES0BDJAh4B20N14j1653NVLVH+OwC+CHTuYUimpb8
         hDrsGHQuVi2BlWsFObT9dr1iTagt5AGKE9U56aJY6gKYH6QEsZWXdXXl8XpCh/ZGpXBL
         LJEA==
X-Gm-Message-State: AFuF++k3vGxJgCBLBeENDa6BrzAC4B3KQ1dMLEOH6f5WLPcKCsYC8+u2
	1+/qVemR7c+j7+GjtLXW7+THpMH05sfDAmhXIyiEfip6STSd5PanbS/3/3IruYfk
X-Gm-Gg: AYBFou1WsQ4jVx3E2dW6uQ2Udp4VI1/a9kK85ZHPE/gvgLQeYQwz7Ll4KYHfvFhsjvK
	iBC5h9YC3atQQZf6iR9KrXyW7RdG6cjqhtLWyO8lKN6WUFyEMdKphisAxVMs521KeMhOgBrkK2g
	9ubBK6+zbOCiS9kwZmwANSWFPUyi7QYo9Ykq5QzeIZB8+yMWJOQ3NrgaR5/am0y5uFrSm34n0V1
	64RDGgnVmIc0jaBS7Ikucc6sxwqucMk4hrxtWp2Cxb4k8xf/5E/GpXnEsZDkcWpbA1HYdMGhBau
	/Bouuvm0KDURa10uEP5gFpF+1wnkun32GI1Au9KzMD4fNX1QYl2YzNVUhjKN/hX3PC/n11gdt/9
	GMJJnkhcvmL5XPJf2MqWxlJgksloMtTXecZYL+p9QHJn//8lHA3WWZRKRWy8jqr1T+U3/D4+2Fo
	L2fjuYkz3z3/96O8doM3v3cmgEAv5GJm6q5dHX73zeHJPe/r4tBhJDU5nNrUO2AYS2Ggs95CvRv
	RjW88vDrdNC/QODV0nZ1qYYTMs5LYSzCM1CS5mDBYxIiss9PEbnhix6eWatu1GHu87k3vhVS2iM
	9YYrMWgf5PoeH9TnQoWOO3x7FZ4=
X-Received: by 2002:a05:600c:6748:b0:49c:fc6c:bdfa with SMTP id 5b1f17b1804b1-49cfc6cbfa2mr78895535e9.17.1788593524391;
        Sat, 05 Sep 2026 00:32:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm216139135e9.4.2026.09.05.00.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 00:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 09:32:03 +0200
Message-Id: <DL77HLIRV4VF.A1KEEFA7OJXW@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v1 7/8] bpf: Assign lock identity to callback map
 values
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260905070003.3193366-1-memxor@gmail.com>
 <20260905070003.3193366-8-memxor@gmail.com>
 <20260905072143.975EB1F00A3D@smtp.kernel.org>
In-Reply-To: <20260905072143.975EB1F00A3D@smtp.kernel.org>

On Sat Sep 5, 2026 at 9:21 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Lock identity aliasing across distinct inner map instances due t=
o flawed static identity check.
>
> Pre-existing issues:
> - [High] A BPF program can cause an AA deadlock by acquiring `bpf_res_spi=
n_lock` twice on the same single-element array map element, bypassing verif=
ier lock tracking.
> --
>
> commit 996188899c474047a5a9bb68f80d0d3c3e5a5b6a
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Assign lock identity to callback map values
>
> This commit assigns a fresh verifier ID to lockable map values in
> callback frame constructors to prevent lock aliasing. It specifically
> preserves ID zero for single-element array maps to support stable
> allocation aliases.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1c3039f3fc323..b08501734ddfa 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -447,6 +447,11 @@ static bool reg_may_point_to_spin_lock(const struct=
 bpf_reg_state *reg)
>>  	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK | BPF_R=
ES_SPIN_LOCK);
>>  }
>>
>> +static bool map_value_has_static_identity(const struct bpf_map *map)
>> +{
>> +	return map->map_type =3D=3D BPF_MAP_TYPE_ARRAY && map->max_entries =3D=
=3D 1;
>> +}
>
> [Severity: High]
> Does this check fail to distinguish inner_map_meta from an actual
> single-element array map?
>
> When a BPF program retrieves two distinct inner maps from an outer map
> (where the inner maps are single-element array maps), and calls
> bpf_for_each_map_elem on both, the verifier tracks both using the same
> inner_map_meta.
>
> Because inner_map_meta has max_entries =3D=3D 1 and map_type =3D=3D
> BPF_MAP_TYPE_ARRAY, will map_value_has_static_identity() return true and
> incorrectly assign id =3D 0 to both callbacks' element pointers?
>
> Could this allow a program to acquire a lock on an element from the first
> inner map and unlock it on the element from the second inner map, corrupt=
ing
> the spinlock state?

This one is real, will fix.

>
> [Severity: High]
> This is a pre-existing issue, but does preserving ID 0 for single-element
> array maps leave an AA deadlock vulnerability in bpf_res_spin_lock tracki=
ng?
>
> If a program acquires a bpf_res_spin_lock using a direct map value pointe=
r
> via LD_IMM64, check_ld_imm() assigns id =3D 0. If the program then acquir=
es
> the same lock again using a pointer obtained via bpf_map_lookup_elem(),
> check_helper_call() unconditionally assigns a fresh ID to the lookup resu=
lt.
>
> Will find_lock_state() inside process_spin_lock() see the different IDs a=
nd
> fail to recognize the lock is already held, causing a system hang on the
> second acquisition?
>

This one is not.

> [ ... ]

