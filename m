Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855068;
	b=kicJXp+ug1GjF4F73aQTwDAhEOlciSc+4PCzWJQi75jjk74HgNDsT8f7beTO2GeDwhI+
	 TC84CIRmgxlpMkGC/r0U6D0/+eh7DPYspewCfQhgygBA8SWQ1KQgw3zK0qcOV1sTEguHG
	 36FrQFMmfHilhNh4LryBWPpJ/wbQFPqQ9rXgIglbkIPyaAxIBFpZQbwguON7YhP4Q6Wah
	 0Cdu6iaU+DPsACYXlnaQa06M22wJr3RWnyscaSdTKhAph+rIId8VTpuxomOwh2hz3BHzd
	 R53+AOYrXKgLE6XFhj4hGtoukhjwkcOHKlMwd/VVkkIHtGslax0Q2wwRpLf39J1tsBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=QSsoBs++E1Zy9/EZXTnsibMmrB7qsgpC/C817yrdOkM=;
	b=W6sDcE+xXL61RwVgjzBKLODj4wAHCmN2JxBazT4P+PENRHWOgtxAfZfyxx3MORhWD1Eu
	 aLSA1wpiP9TpE65cf04Y14GBqH9skE3bYhNlYwFHVb9q3fTtlvTMTgl5Y5aJZuozGVrNZ
	 FFPmC3W+bPeaX4y/AkHZ1wWPC1iud0yYPLO2LKc0dp3ux/e9aEKo+iHSeMQ5wlCvALXAJ
	 6+ZNEm3mHEm4fsdprLoqOzPSKRV9C/S6+k53YsEzf8az7tgZrUjObR/gywqj1GhwyKajz
	 juT3Q+4jW+HzVs1OGCnqiCTtE3hkxppFOrXRYbTcbREtRMJlKrxTgFw6xELK8Ynw6Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=R2nzstyH;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575A606A32A
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 18:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8575A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=R2nzstyH
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso22367765e9.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 10:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794855067; x=1795459867; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QSsoBs++E1Zy9/EZXTnsibMmrB7qsgpC/C817yrdOkM=;
        b=R2nzstyHPvDSLsixsYcF+z62ybrB5a+AataWUm13bOnj5D6xUz1phe1zPL+6DzlMLu
         UFoD0bpj3iyp1BwBilkdbaFyTxLiudKNKwVGiRaMP/uCjDqChc2HKqM9rfLy0jNhnnJZ
         15ud/3kdUj5Wo6BkIVNMKmX6lktEST8V4/m21oPFb4+E+a8pMZgpK/3tGguWhYevHF5J
         W9HghqDBIPKw3OaWJ1hFi5tHjyjo7V3FznW1wfuI8/eM3cRT08flsJ2YaEFcMHAcEHxs
         qjOu5ky8ZxY21+2BxgrZabnbKJt0fIwIIrjuovfef+8H8/gGZ2r/00/saIRTE108nJ1G
         oSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855067; x=1795459867;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QSsoBs++E1Zy9/EZXTnsibMmrB7qsgpC/C817yrdOkM=;
        b=bJ+d3Q374AJcduy7qyChN4bZyl8epSAHwQkpzssHqhuJSGwMqcReRLpc7+w3TPGnBU
         iRteKP0zxwqORR4IoY2cKL4DGEmU61v5wAzUPwhpDgFfNb8z+d5g94ZtsMytcIoVQiu9
         rfCZdna8KxgUPqC7g4hoOPdobrwCwtWMKE3wiET1e0bV+aWjUmJbMmGMkTmADJm1Ye+D
         6+jIu3NJ5bbwNFANFeLiq0ZH1cTHdDUPqpi/b8feaz1hpYvtlR/sXc73fNESlDf1JCx7
         hkaaNvZ8qfVxeIuFCrTEHb/YoqTmhxFvjYhClEZRwYfwU3vhLODVIyBfVGidG+wu5Pxa
         Eiqw==
X-Gm-Message-State: APuU4Z9sb2atydyLoKv5yKDbaVc+yWb2Mvc3PudKojmlByDQ+JSMTRHO
	Kl74y7farimceRP49hNEjhoo9RGsZXthdgKjoV7xIHRltVXbKu2i1cT46nPTJ41qj7E=
X-Gm-Gg: AYBFou38758cbnHG4xjd6QrMfhfb/ijeSnwfu940c6//ywo1capLPto0AgepVUHrqcY
	6iF6zl5MTDH6yWZnePK6ukLAhB21P6nT5ooxCcSoAeoxih1vgLLbsMWi6T78JWCtMs8d0kCerlt
	7Sm4yKpg2q8u8jz0l7BAD1/fWUH6HQX0R+sj9RSAPkmIaIVQJYfYXhTnn8Gn4IItEB9CnqvekA1
	tF8EFmbuxxpA53dY0nZ1XrmBnJd2voBs0+6D5qAaRJyE2GT81Ip5eC49rR03b+oNhvAGVrozqj/
	6q1kpVthHdsMgmoAw80pN3yPmd9io0woQCtLy7tpHKmY169Hu+Xvga66DYHkufIt9A596tUnJng
	BP06JkkirPTLtJJkZV6I48/C2OwRi6a5wd500u2mpr/ubjgN5kaFL7hMiu7QaYoOQ6Iq+lu817H
	4wLaIkO+r35E7C25pmDKF9KstO6fLcG8DotVNesdDJ4or6QlL2l/C9nI6a5Sef9/22YirO0fAaS
	YJpK+d98Bq3tAZZi9nwr897/3m2XsC2yMt2cP8RHvX4ncrbQ/Ka6B3YirvCIMNEt3y2lTjHVCrz
	55I7HmpZGKx7lr5XVpI=
X-Received: by 2002:a05:600c:4e56:b0:4bb:7292:b871 with SMTP id 5b1f17b1804b1-4bb7292bf16mr87467245e9.14.1794855066970;
        Mon, 16 Nov 2026 10:51:06 -0800 (PST)
Received: from cloudflare.com ([2a09:bac6:314f:191::28:17b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm10795765e9.8.2026.11.16.10.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:51:06 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Ahmad Wicaksono <supersonix03@gmail.com>
Cc: bpf@vger.kernel.org,  rhkrqnwk98@gmail.com,  ast@kernel.org,
  daniel@iogearbox.net,  andrii@kernel.org,  eddyz87@gmail.com,
  memxor@gmail.com,  martin.lau@linux.dev,  song@kernel.org,
  yonghong.song@linux.dev,  jolsa@kernel.org,  john.fastabend@gmail.com,
  corbet@lwn.net,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] Documentation/bpf: Update sockmap docs for
 mutation restrictions
In-Reply-To: <20261114170117.196552-2-supersonix03@gmail.com> (Ahmad
	Wicaksono's message of "Sun, 15 Nov 2026 00:01:16 +0700")
References: <20261114170117.196552-1-supersonix03@gmail.com>
	<20261114170117.196552-2-supersonix03@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 16 Nov 2026 19:51:05 +0100
Message-ID: <87ecckr4o6.fsf@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 15, 2026 at 12:01 AM +07, Ahmad Wicaksono wrote:
> Commit be39165224d0 ("bpf, sockmap: Disallow update and delete from tc,
> xdp, socket_filter and flow_dissector") dropped those program types from
> may_update_sockmap(), so tc, tc act, XDP, socket_filter and
> flow_dissector programs can no longer call bpf_map_update_elem() or
> bpf_map_delete_elem() on a sockmap or sockhash; the verifier now rejects
> them at load time with "cannot update sockmap in this context". The
> kernel-side sections of map_sockmap.rst did not mention this at all.
>
> Record which program types may still mutate these maps, and note that
> sock_ops programs may delete entries but have to use
> bpf_sock_map_update() or bpf_sock_hash_update() to add them.
>
> Also drop the reference to
> tools/testing/selftests/bpf/progs/test_sockmap_update.c and its link
> target. That file was removed by commit 5de7a6eaed89 ("selftests/bpf:
> Drop tc/xdp/flow_dissector/socket_filter sockmap mutation tests").
>
> Signed-off-by: Ahmad Wicaksono <supersonix03@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
