Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F024DCF9
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977457; cv=none; b=jdlJTmuKsWZz73ohiOg40QoMVWPz2ycD1mHpH5Yqlr5WHQ386KpNr6dWviVsZgO+Fu8nSh2hoPaHGoqN7+GckNuVZyM+1dUhUKz6wSnxEXpax+oAei0GQXBIayOVADzX2jvyy0n+kUckghk2ofkFRRqdWgEgzyvuMmIluCsaE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977457; c=relaxed/simple;
	bh=XdjL+DsZlxx/MaXCS+LVig1iCqZ/grsNtC+27vPV6MU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LwL5UoiK4S9lh4mGhcQQ6BzIVjO4jNGmraSEsk1h8Eqm3LYTaVV1hsItNLz8XqP4NCKjyJlI4Twq2+AxyLQ6j1cb91qssi5RoU/4bl2WkgtfyqU+XBIF2EvLHwExf3qfkHpU759qvOsH/uReyydqZuIOSEBMONxAkznlGEPcuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVfTNxbn; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVfTNxbn"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a0edfe29ecso572600eaf.2
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781977455; x=1782582255; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeGJYdAKjr2ewIveC64bw2Gycnlw9u3WsN5+LRl0ZgE=;
        b=XVfTNxbnUm0gYBB5EKzPoKyGh4SwD5sWLLw4HBofL2HSCH2fDAlEEavV4enDaI5D+a
         yrjqgmtng8FNtqTaf99b2qhTQPTkbkv0KQZuxlUinww2AcyVRMYGyknid4RAraG9B9Dp
         epG/1x3u295OmMXIeHnMIRzhpk99jBLp7UDwKBnIXEBOKmg1OrQMVWMA7nJHMeuNFDfI
         QP67rGhW5Okhwk+0attJ3GgvBbGhCsh51AmUYkXzjYbkhARiBA7is2o13BTWaxVR8znF
         eVJqowHkoaYgSasFJ1SMQe0WqWHvbu+YnHTKq4y6MGXa5jIVXZbMT8CjmzxFNcjln2Pr
         xVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781977455; x=1782582255;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MeGJYdAKjr2ewIveC64bw2Gycnlw9u3WsN5+LRl0ZgE=;
        b=BmZm1WRjlDWcl9yddJ/YC3mxXazkBrZXC0Sf0gMri1QB7Ai+ULtZeZkbEd8ClIyliQ
         ESOwb+wPCsXro1aDcctt8x2MXXAygiz6bcUclLw35XClzCptMOGxjPQeooof4HfMT3sT
         NUC68gI52oK39xvyn9LJfduYNSEueCfciwEc4Ar1dDK2GdSyu2bZvNUYGAXociwCUMt9
         08FmFt8OaGNCSeoNsVKcgJ6/f+/s5pRXH0SuLbUcjTlF8fFCJ7xyZOYsBpJG5TIXrgmf
         Nv1poHyItPCed3+UvdrIPujKSsCT1vAftwmde36MoqaSi2AKg/TdkJwrUCBZj5SB+644
         o6OA==
X-Forwarded-Encrypted: i=1; AFNElJ+4/wEEuXrwjb/7SZZE3z8ON+jbK9NGI8HczuC18w5fbIT5qf0L2rJc8gx+rkK54GzeDZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsEywIjzie7/JWdlJnaEREYWXDGbCcW8cUw34vM9+ao4BlXEd
	w2ZUqabe61rfTcdvacHwSd3zGEu1gmeTDk2Kfylr5V3vOw3IB0urUiza
X-Gm-Gg: AfdE7cm5C07t1LpBtNKNvoVvzyO9T6HYmWuKEWn+vvsGWROGMEy0Tk6JaPJ04rLirdG
	cor+npD0t3IqdHV0J4nZXI2LIk+rAR+y8eUsCR03UO3zLvaYCcMblzGh8RmHwReGt8OHLAkGq3M
	vpMSVzONEvv71oDzCJO6aw7TUaL+a0Br+C7DAGO5Lppuzkdi9Y3dx0NF1Md3xv9/TXYdNZZfYjC
	++1SUHj4DhvunSbBydEau87oYyqldNgUXtCkpCybD/NTYTuooxouwyS4stZkK3iAss0tR9v5MEj
	h1ymRDklSIbgFcCVuJuSSeRNRZBpxdrp/54r+/OcQbfkVha6pwDkER09K5IyzjT7IY3D8ZHsLXu
	gyfITg7/+wEldeF6UJjIh1cFo08Dy3vDuhy+2vvjLaEm1QuwWIYCSKxO++cNAry39RUStCEVhFc
	iOpf+jc8RllszCU7TnbVDFG3vsSEI66d2mkznUx3liRP51AcoWbyNazkLO5Q1u/09V+7fIoV3Xp
	GtNp/1jQ5aQAQC1KA==
X-Received: by 2002:a05:6820:1b19:b0:69e:b86b:1acb with SMTP id 006d021491bc7-6a0d8c61d96mr6582265eaf.24.1781977455160;
        Sat, 20 Jun 2026 10:44:15 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472e79af8fsm2187384fac.0.2026.06.20.10.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2026 10:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jun 2026 10:44:13 -0700
Message-Id: <DJE2ACQKYFBN.2CZVF3NIXP9FF@gmail.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Preserve nullable RCU pointer state
 on unlock
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc
References: <cover.1781968391.git.chenyy23@mails.tsinghua.edu.cn>
 <aaad3eeba3ea62f2c332701b28bc28387dcd5a42.1781968391.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <aaad3eeba3ea62f2c332701b28bc28387dcd5a42.1781968391.git.chenyy23@mails.tsinghua.edu.cn>

On Sat Jun 20, 2026 at 8:17 AM PDT, Yiyang Chen wrote:
> bpf_rcu_read_unlock() converts RCU-protected verifier registers to
> untrusted pointers so that programs cannot keep using RCU-trusted
> references after the read-side critical section ends.
>
> That conversion also clears PTR_MAYBE_NULL. For fields from the
> BTF_TYPE_SAFE_RCU_OR_NULL allowlist, such as skb->sk, the verifier record=
s
> MEM_RCU | PTR_MAYBE_NULL while inside the RCU read-side critical section.
> Clearing both flags on unlock drops the nullable state and allows a direc=
t
> post-unlock BTF member load without an explicit NULL check.

That's exactly the point. The code works as designed.

> Only clear MEM_RCU during RCU unlock invalidation. Preserve PTR_MAYBE_NUL=
L
> so normal nullable-pointer checks reject direct access, while an explicit
> NULL check can still refine the pointer before use.
>
> Fixes: 30ee9821f943 ("bpf: Allowlist few fields similar to __rcu tag.")

Nothing to fix.

pw-bot: cr

> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf..e53c4bfe4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9001,7 +9001,7 @@ static void invalidate_rcu_protected_refs(struct bp=
f_verifier_env *env)
> =20
>  	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, clea=
r_mask, ({
>  		if (reg->type & MEM_RCU) {
> -			reg->type &=3D ~(MEM_RCU | PTR_MAYBE_NULL);
> +			reg->type &=3D ~MEM_RCU;
>  			reg->type |=3D PTR_UNTRUSTED;
>  		}
>  	}));

