Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795262283;
	b=3eMBmGVaAt1sHg/R7ekAyDStGtsWYusYomp6JjYb1tWNeVxFwQAfgOl7CJucBCsLID+n
	 NjqE6dFPaHDsGaOwtE7yqyiLANML36VCGOiBxXPUtq+/UfeoSYXgGZQs1bb+WHFTlFoPT
	 gaV8F2PuRXIlFiG6eOcs9VhR4qgxdnrouKbkMnQ6yiXk/5SUdKSN132m3j9YlXCsBrMaR
	 FNx+xz4yvmxNzhN5ddoRPqk0nLZcADW1SSJaIlpc10mL2wFbZ13omvBF9dE7WRM0fZQMz
	 WfVn38FFc5xJEbs1FrH/BEPgqG+rOJYVo9LiPeHRGSxyp+D5MaEDMT7Q3GB7+Be+PzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6oeoFimhtJH2hxh44JdtBw3TK3noQY8/rbKIHHAErn4=;
	b=kNm2CuBLICAw6l+/eWXYgHAXz6wg3mc1Z/iUuTWKtQGCEKI793GA2JkJPGQfSYgqmSVQ
	 1UsLz/gfYfrVgj6ufCG5eCSCfuKk/Ch3Zj3MjMeJEp1ehLUZaOOecF6ZvO1fsrTFQyg5v
	 D3vCG4KgmbUQK/UBNWHogub0k2Mhl2cUOv6UQlEw7rERnGhffblBX1xys2fhrhR8g3wwx
	 VABUMYfWpkWaxY6TpYrMKy81yZvaKOYKUJy8vDFGhxpwKI0wSnsptns8VfVMuebFFMaug
	 0oel1CB9Ua9zWKZyEK7NdZiIxI9pJCwAzjnWE+uVBbvzO4ukGJsHnlaZpVZrYxaJbQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=tGuwzQ0L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43268606A330
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43268606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=tGuwzQ0L
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so834171b3a.3
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 03:58:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795262282; cv=none;
        d=google.com; s=arc-20260327;
        b=N1fAZ1WYHBGvwfoRzBUWWUt8/aN6MtMHpL3bclCT8B746eHnUbttlW6G268G9dHLHD
         dXriU2aqQBYddAs6IVmXWCdjwbhjmuGDWK4RzEUrTUOy6+XNqet+Y6E/cu8zqo8Krtn3
         u1FivPb+qrHyM+HokxqRGeOfPgwjX6HUtauvTY14hV3vVqLIxNIwOjkGdTW5tyfy7Mtd
         hyNmQttm6HXqzI5/+XiCknGCt8ImwyiHtzt7dL5bYOJixosX5WFtqRFN1P665NjkNfBJ
         72Q1AE1yidm4afVTSLuNs3iz/3qJyPdz7aqlNbpYgvKmMR4P6Kk0uY0q+oa/bnXn1FWB
         QB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6oeoFimhtJH2hxh44JdtBw3TK3noQY8/rbKIHHAErn4=;
        fh=0S9V07r6vft2WHwYQkRsPCmCzwzaWlImX6tVPMV3AYs=;
        b=Q+c6vDEWB6l4d/nQJc3zQScUWxxqbd6qQ2R3o1qXdf7wUQFqAs9gRdknu5VVYLbCd/
         FlK1vFxKGdxOxTcst4RPX/RPVtMjYQAgnm3xr8cewsA9ROtVPVPAAZvGCipcJ95L+Aa3
         dd7Fwm5wapafLGKhfRBTmGSDCFsQd0jLHJN1iEovSkn8nhDFehBliwqCnXzY6jfAOcj+
         wCdneIb1yyyI2KtqQKM9kPyGLPYadZVkTkTL1pCz0xj3j4JkqVQBUY/Be8WUiUUn9CS7
         Ki1NQHtWc5MiMtiYEnWJAZLsu+pZeYRlWUBU35QPJrmsXehlmeY/CDXSznWcvHVV+m2w
         jx3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795262282; x=1795867082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6oeoFimhtJH2hxh44JdtBw3TK3noQY8/rbKIHHAErn4=;
        b=tGuwzQ0LPZl1oA7DlU0y5cfAR3if15FhKZcT67HBYIgCFujoCtXIBXnTWc0K/OKoXI
         dxTHlJwRNwT0H8wTkjnUo6QjsV8k8Ue9qN9DTfnhxHLbt1R4+4lVCyqkpok0V0/zl+h4
         QKkDsPstBbd8/Fw50OiiRtymEzae8Ti4Cw50Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795262282; x=1795867082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6oeoFimhtJH2hxh44JdtBw3TK3noQY8/rbKIHHAErn4=;
        b=RaYTaEtUQ0MW9rUQRn0iIk+9O6WAtv/hH5EmTQCG3QRZctKbrwCQ4kQtGNjf1UzNG4
         OIMn3Id9RhDZ8X6yt1NEcD1V9HXdsjnF4S1D6TeyUsBzpNE6rliq98XkZETiE7Ch49tT
         WqmbkW2rX1vNj++QL195pOX2+PcE0SAhth8HvrPTx+btczd+KQpNmkP71G/DyQgb4k4G
         rSTQIUZeYOfqAUXe/4XhRV4tkolzkTbuqCZBY0lohk7bG1Zq1YxE/myexMYoXe4PNrW2
         yhuUoNg7L/pux4ooifFfYqkM/3TQ8pj8geDPot6OakDyTaTUuvi3JV0p9lsvi4k2idH4
         oqqQ==
X-Forwarded-Encrypted: i=1; AL+hErFjmPWCfadMpBkjVbPGKatbuf+iTphxX0mI30LlfNUF/huECSBxSho9YPZPpqyULLz7e/M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sSvOdduMXiBg8v+lR/K0NLE17wiwnme5dGmQa/Yf+gUyVLp80
	RKBHluHebbhVfJ4TPH6GJI7aal1fdfu57dJZNdD/ZItO5h64L6TX7Ur0MsAusZVjRnZWdXYM7tB
	ptJ4ABB3I+se3bn4/eVZABA7x0f5U2BxDmb2rocdOQeycr/aWsea1fA==
X-Gm-Gg: AZFdTZdujP5JrAK6diJ0ZUC8R9e0ZLNMW+xPcrgHsjlEpDSCqBlPR4HW3B+gE5KcGcG
	5KenUnQ8lFcXnRAN4U+kmMEfJwFVGVjsmCaGvJd4hJrLvhCthqf6zCppTRdHHc8hNAslyvUXjr5
	E35QQaq1EkpjYUBTDND5fVkR40yFJsZXSI9VFzAZ1DFCN2Qh02356c1Q1g9iTvxieAEfNz/9/oe
	oreslGOORuKAiqtVa628K99NUwhrAUoMiTGguA+urLjiP1S/q7vCslTgd1Zefc3izxbbjTby2T2
	L3kV9akzfX5uy+oV7o5/OXD+Cy8HvDHKi0/kt1P1hZ9g23M9W9uTr5qmNI5Okjm96ifDwi54y0l
	DpjhkKUb7BeQ1ivnRLLnWDkl9Imdp/8SUmtSZBlzTZ7ug5ms5px3c4xtFR2vAnJ1+u67d6Byle/
	K4Uft5NtXWZ61+Z1xjFlTI
X-Received: by 2002:a05:6a00:928c:b0:8a0:20e0:b131 with SMTP id
 d2e1a72fcca58-8c87bac50eamr5921526b3a.19.1795262282219; Sat, 21 Nov 2026
 03:58:02 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com> <DN09YRKU82D1.1QHV2CIFW2C6H@gmail.com>
In-Reply-To: <DN09YRKU82D1.1QHV2CIFW2C6H@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 21 Nov 2026 06:57:50 -0500
X-Gm-Features: Aa3M54qnMKfTBVbIV7vSbL5S723ov1v1Vl5x3Mva5Jl0ckcThjBjDhbh4ZxcYw0
Message-ID: <CAM0EoM=Panth86S2_RcG6Pt8WA-nyR=1P7GDM0sPsPrOrwjyeQ@mail.gmail.com>
Subject: Re: [PATCH net] net: xfrm: interface: restore dst_orig on every xfrm interface
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Eyal Birger <eyal.birger@gmail.com>, ipsec@lists.linux.dev, bpf@vger.kernel.org, 
	stable@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:11=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 20, 2026 at 06:08 AM Jamal Hadi Salim <jhs@mojatatu.com> wrot=
e:
> > with skb_dst_drop() before the route is installed. The helper allocates=
 a
> > metadata dst per skb instead of a per-cpu one, so the route it records
> > belongs to that skb and is released with it; the per-cpu allocation is =
no
> > longer used and goes away.
>
> kmalloc per packet should be ok here. xfrm_bundle_create() allocates a ds=
t
> per packet already.
> It also fixes the route leak, the double put and the if_id mixup
> that Hanxiang reported on Oct 29.
>

I wasnt aware of Hanxiang report - so i went looking. If no issues
found the final merge will catch what you prescribed below. I am going
to track Hanxiang's bpf_skb_set_tunnel_key() note as a
separate/followup net-next item unless somebody else wants it (in
which case i will remove it from my list)

cheers,
jamal
> Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/48129353.1960c.1a1859496bc.Coremail.x=
uhx@hust.edu.cn/
> Acked-by: Alexei Starovoitov <ast@kernel.org>
