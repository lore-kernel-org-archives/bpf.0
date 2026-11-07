Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081222;
	b=Ueh2KjvFKcd+hKACl6hcddxn7A6O/w2iP0ROLfaL7kpmjAq8Kp5lZcEMdHyIDYrc/BsL
	 +/e4q1z8SP/A6b5bR1UvcZoh+8sdLHXhcoKb8cS+ZX5xFo+Qmeq8iV28ksyWUzH0Xv43L
	 nXzIGItkAKVON8hVlWMV6e7R4t8cyDhVyjRn3HwaOyKCcjccTVNji5e9pZj0kLJ95ZYEQ
	 8j5/3jQAUv9CCEu6tQ6Dmf5iqH3oOUgn/BCk2ClYqRofzYHTqjAquQScQcvUXvHqDU899
	 TQTTSQ3/WgoSOs4FhNtlcsAp7OvnrNq5BapbKE9kcHMiQlqmLPwoMqtyvP+46xSRGig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aDZ68c9QI8zugnRRjirZtU0A/GBNiwDPbLZHWfZlZRw=;
	b=OfS+yf8xFfnnVJNOf1Jfuuxh1xSapPkacHEmdnKE9mT7vOjfYpxYbCJ9Z4UZ0p94zDhT
	 0tBmQW30XVwcxIzV3jYRuWPb3tXjmVUIAWXpWUmX9bJlu39nn4wOVrK1L4uQJpWPo5uxK
	 wj20BJ85arA9YCZzcRSjLUpGWIC1EqVqCxUnCLU1z/JAsDsHcec28eB0erN2L1Rct+9ep
	 pbvA45cgaQ18zTb4RnyZ3zleszsn0Tq9qwsOUt/c1Chz74P4MDYaekNRnkBmfj8pl/2K0
	 ekvwr14yDd3QdBKxBB0W/olFeZelbwqzo2NvcaSJflpa1tps0j6edGFpIkvfQvY/uAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wkvIjMIr;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCDF606A32D
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 19:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DCDF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wkvIjMIr
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso791135a91.2
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 11:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794081222; x=1794686022; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aDZ68c9QI8zugnRRjirZtU0A/GBNiwDPbLZHWfZlZRw=;
        b=wkvIjMIrogDMoWYdXmOlA0m2ERQp6Apu2EDVk3l6utD+jFd+Lh/6heMm8d2Vl4P2GO
         Fb//gs3EZ5+tKC6gqcGpI35P5tz4YxTxnlRxdHBinNVWuoy5CI1B70uiykPZpsjCPtdj
         A9M+TK4D5Jk3st+YO1jRLF1wPe38KqD0a08HjrJusVX/HjbzlrjMmMyQeVm2D/cpwINs
         NLE5t2eEqEn4bc5saN0SQs7Wt06rdRyyuq+RLg8XiAJT1kAZqg0EmyoHQ3asfczQK5Pq
         KsOlFtUSGmvCJyF4Gw66Uz33KgWrdFDC+FYk60/BOnpWpp/CglWF8QSGVGDTNk0OeUkv
         a4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794081222; x=1794686022;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aDZ68c9QI8zugnRRjirZtU0A/GBNiwDPbLZHWfZlZRw=;
        b=AB0myclR92XpJZv+aom4MenvJPd0OJGLN1kuoFuav8a8zkytrvTP+Lx6mRiMooy5/X
         Nor4gHpCeUVPtyzRo08t/2yAhoMRt4VZ5ichrqEmdcSJ+2VeyX1j6dXIreBBbcLn5aSt
         BNLos4Cfgq3iZLteZivmBkqtrUIB4eETo1Z/K8ufR09+UHZx49VbQJz7K+3H4zvrNwzA
         pxphT0CAhBbJNwxuzvWCDMywYfZNhobVLcRiMFcPiuymtQioqaHzy3+cLaucwjoEeuCe
         i1sDRUkEVXYIs3g2yUZ9F+3Q9SHc4F2yzfMMQ8w4psRfhYKkQLRE835lFqDOesVbaBEU
         WicQ==
X-Gm-Message-State: APuU4Z9vSDSG1gt0WuLsLuJaFIoBuRgnpDy+uKEo3J+QbrsaNmvTllNd
	6n1bRB7pDTKN5Ax+7vPCZjMe7XDbwc6NQOhJ2VP+9oylrHhJhWnfFhQr
X-Gm-Gg: AYBFou3PgIH+3oq2MVj4OY80nCiZSuwoaMPfdUMXtL/0O7k/ovX6bOUaLsmfoZARnPH
	Ernl7Taff5aG3F3xP93Ryk1ScQh+fWrluCoJM3Di30B09zbtM6h86YqaKTESiVC1b0QEaVLK3nr
	9LeivqS5YhG+5imfWLukb49qhSpcvDd+f38hWHHuyNPBZ+iT/77Kkq95ZWIkyYypUigFz14p2cD
	NOOAwAPqttzWGIFtoMskbbgugkfcZduPMIn3JQ+gEZJA6uE+yivDammBtLbmu9o97AQftGbujqs
	2iLUDNxnSMszHxJukyeo9uCFK5h7cI0/nYr+LYEMOBaRjkEady0Vxu7O2fkWRYZoGwGp3JGuFkt
	/h1YhJ5MXtC/uP9RUbVr+/L3BNUbaaqLgerP6t8NAz5/HOcLTz4/dCtpzvjLPBi+6cY1of8NIM/
	rnmqMDfz5T+ZFWvuFxLv3X7wpLKEW+T7VJr7hQO6P4VlcxkQYgQ+9EWICKzmJp3FMImWrRtwMAL
	Mbuln7W+p2UiwJw0F3oy9IHcNpL3nYt58UNtZtM5mbSY3c1nLSsi35qNCfL54klFkve0ADvOMpt
	TzQjeMgxOsxhYMmQnNA2RgxKgmLV2vvZvrQ6CsAPIKEsiVCKTyXd981IPSC1fwO5qISGZ4q+q8A
	NRJAVtMFkgGJ/cjXGO4t6STHj1IqnfDoLkg==
X-Received: by 2002:a17:90b:554d:b0:3ac:bfa7:b079 with SMTP id 98e67ed59e1d1-3b0db5edb73mr6825490a91.7.1794081221674;
        Sat, 07 Nov 2026 11:53:41 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b126385c62sm226598a91.8.2026.11.07.11.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 11:53:41 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 19:53:40 +0000
Message-Id: <DMP8PQQ4S8F9.15Q6N6B56KY39@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Reject writable map iterators on read-only and
 frozen maps
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "AdetsGithub" <adethyasrinivasan@outlook.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <LO2P302MB0197FAF0305A94F7575CA700BC752@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
References: <LO2P302MB0197FAF0305A94F7575CA700BC752@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
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

On Sat, Nov 07, 2026 at 06:14 AM AdetsGithub <adethyasrinivasan@outlook.com> wrote:
> The bpf_map_elem and bpf_sk_storage_map iterators pass the live element
> value (ctx->value) to the iterator program as a writable buffer
> (PTR_TO_BUF | PTR_MAYBE_NULL) for all non-percpu map types. Since

Way too long.
With CAP_BPF and CAP_PERFMON an iterator prog writes into a frozen
BPF_F_RDONLY_PROG array.
The verifier treats the content of such array as constants.
That's all that needs to be said.

check_map_load() doesn't exist.
bpftool map dump doesn't use iterators.

> Fixes: 8d0358f6e8b3 ("bpf: Keep iterator programs off special map fields")
> Fixes: d3cc2ab546ad ("bpf: Implement bpf iterator for array maps")
> Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
> Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")

Wrong tags.
8d0358f6e8b3 only added a check.
sk_storage maps cannot have BPF_F_RDONLY_PROG.
Keep d3cc2ab546ad and d6c4503cc296. Drop the other two.
Don't add a5cbe05a6673 that bpf-ci proposed. In that commit
bpf_iter_check_map() returns -EINVAL for every map.


> B) Patched 7.4.0-rc1 -- writable iterator rejected with -EACCES on all phases:
>   ./test_progs -v -t frozen_rdonly_iter_write

Pls add a selftest as patch 2. Not this one. It fails on a fixed kernel.
dump_bpf_array_map() in progs/bpf_iter_bpf_array_map.c writes into
ctx->value. Attach it to an array with BPF_F_RDONLY_PROG, like
"attach_oob_write_iter" in test_bpf_sk_storage_map().
The attach succeeds today. With the fix it returns -EACCES.


> +	if ((map->map_flags & BPF_F_RDONLY_PROG) || READ_ONCE(map->frozen))
> +		return -EACCES;

bpf-ci is right.
BPF_MAP_FREEZE stops the writes from the syscall side only.
Progs can write into a frozen map.
See BPF_MAP_FREEZE in uapi/linux/bpf.h.
bpf_map_is_rdonly() needs BPF_F_RDONLY_PROG, so the flag alone closes
the hole. The flag never changes, so there is no race with map_freeze().
Drop the map->frozen part here and in the comment.

pw-bot: cr
