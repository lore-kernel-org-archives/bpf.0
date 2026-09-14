Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E748233126
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425347; cv=pass; b=WNajCDQdiMdavfpJraS6lMu2nUE94vLC/s+NSwP+zBZ58dNCwQgQ0zV1tHRGjGzFvlLONXmCCyqbxnPcVlaGEfPqHDdG+zF93LgCCVDfY3SUkerLYYKgc54ekvdn6qNRccuVfeKBznxFA5J8jBVt0U+s8Wg2fNQhtabHT2886g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425347; c=relaxed/simple;
	bh=mMH1ijQVK/BHrqtJkvFNFIAYi7VmNkP+j6GhBHqzUEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjneZ+cl/ctCs6Yi2lH97ncM4UUP/I06zlbonNuNqJcnq2gRFT3jusMC/cTmHixPyX7lYgdmYXpIC5FIgmUYzBULRPI7FJBDk62FranOwCTtLkxUZ7LEKF0xNyFJBFc6U7ZT+K24i9IdwmvuB8oLrI5t10wDFuw6ZP3MVWf37vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=V81Xlc/N; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="V81Xlc/N"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab19127so2653788d50.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789425344; cv=none;
        d=google.com; s=arc-20260327;
        b=lArMLkWAab4dBwMGMGvDz0SNyzAuIJSH7452lrdmmAjYYiZhpjv89N2y6XpeQJttE1
         64xH4luW8pIzQIe3u+hD9qk/+DiKANpfP3AtV7LkghMIONULYfRCBL+LrD06hjeBFyFT
         ETNtz63+H3mjcCrUGLgD5E2HujEFqfVbT9BSMr9f7bosBI3NaN6pjT5TpuqPz8TMITMV
         ikE4Ut19VQby1a8kqrP+qk5420BaqtRBQ4tTFSL5e1B2LOaICNMPxx6X/jkAPO77WRpx
         uG41X/WLceKVLbl5PKoLIwZPKA9+nUyp8FjSjeZ3oZfHIjSQhE17mqwlDM5vIr7uMf1o
         dwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6f+ibT+gH2nKFJxetkwt2/sBz4ITIBK8m+P62pM4ISU=;
        fh=kohaj8+/CxpjGSiai1o69ZempdnBqbTCxE4iuJ8y+n4=;
        b=eh4xqUY59g4hhYoav+BBV3sqlBgWq9jky59bZGu5zTyhtXHsWxf6VTR9+gZgpOTR2V
         SALgwdrSAgLbztj9GRoygKFL1/Aomv3mtdlsDy6aRAh9WVvG+sscF0BfWBmo5T5mdc0f
         2+T7+TqaPMe9D+HSrImxUos6DJVsp3DhqpNV5NxLQqRKXWlDQURTCxQjy26B88Yl/H4u
         ofSjyEF66Mhk2S+wLf7GSDfF3r4ngvK9o/L5Uy+GRDsOWUTenlPugSEv0mF3GIJxUMvQ
         12XV39k1Pp+f00IRIGhFb5tRV9b7WrMZcC/aDMGuzq0S4GaNJ3kQixxr6RW4Xw9ToBwD
         OLNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789425344; x=1790030144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6f+ibT+gH2nKFJxetkwt2/sBz4ITIBK8m+P62pM4ISU=;
        b=V81Xlc/NWPaz+8j708oFZ9Cwx3qobsfk4X0e+skD6d3IRwC7bJfAxTzG4K5+ByfVk/
         Flve/duxMycoxsxG6QbdkG5mv4gPHGwdKhZKoiswuE5aIL6iAn3Hgn9xMkS3br9vPcY7
         o/hJZaZlE9t1HqFCC61BShbV2SxzlxU+7Rf4C99ci/+nwVBaYib0x5XRlH+7qqj1Ak9z
         GA0Bf9TqZoieWauQrIheOyVUp77RGxLxYaP3skq0kpPzZMIqrNUCsKBSvJVR1uafl7I8
         F28c+e4pNNKhAFRUwlbTlgBQndPwL9UJ/YyzB4sHEWY9hiBDMH0bi7hBW/zi9CxQIKzS
         tceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789425344; x=1790030144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6f+ibT+gH2nKFJxetkwt2/sBz4ITIBK8m+P62pM4ISU=;
        b=10pl4f2ylUKLJc/GbIMkfe2t3s2DQ35mXziQXn4w2dto8rzEPMbhThuPqrZRdavGfV
         4yzUoEacbI/n0d7azjZBsMF1MfloflrSyo6+qXhjYEuiqnh2Gkehz+QzBk0PexHLVuZW
         TXKQfcXf899OOl2MkJeAMP0Ol0I1fr1TbcTCkgLhq/5lLAJznzzKgg+NghmgG6pJhAS9
         ALpyFzqBhTxJqeXRQn1F35ZagI9n4GrUBDKZigVpBYQ8sDOccxSCsdYL1tPQphB8i6kf
         xdygAqYRT4gLRGUeYMW7Mfl3+kGMxH55JBvlstvwZ7Sp23tnxt1jKU+wRNS58HV3Qldk
         66/w==
X-Forwarded-Encrypted: i=1; AKwUvBz77QZl5kXXFT8UwtqNP5AZ6kE8E/jqhSTsBDc6odXAZnyxs1U5jeOl7aY15pDwcqN0es0=@vger.kernel.org
X-Gm-Message-State: AFuF++nZT5U4CsRus70rsbcqZhkSe0elOl+SwTRwzJVaysZ7H2QCMBtp
	608BlP5eI9BBYYwMtMeIDFnaq2aVofbk0wfYoSernq4F/RejFlqU9JgivI24BSHtepLwNPPVQ2I
	wtPmzF6CfkGtLUo7tR2eV933jvzNRiofaUzb8veKxzEwr6V6MDuARc7E=
X-Gm-Gg: AYBFou2ib2FDU4r1PzKH3USkQhA6fvqpPigjRPT/nQlV300FpDGqzRGxxwS5nvalpom
	e7IVlOPouw9lRhcWzWnjcioHuLQ5mzxsyZ3XxggLGWB9z+zDN7wZ6JKY/4tqZC0g0dL/GFqC8uf
	o2Dest2jFL4quVhbg4DTKGepeF98IptOZnqxXOan52ko0c5sy+1sisTX/RxBYEGyk6IHPzNmJmg
	+Iu6rB8pUnkC1WnycKwAq98HYb/GOS+MAXw3j1GP8RrUgtTD4juzimZi8UIarW/vViyG5czO2aY
	kS5OsO3mZHUm9yyJQHgnpJYHVk3BONt8zaGZNGmMdn/gakDHS7R0aFo=
X-Received: by 2002:a05:690e:1286:b0:66c:c215:ef75 with SMTP id
 956f58d0204a3-6714dfeeeb9mr1693024d50.19.1789425344497; Mon, 14 Sep 2026
 15:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789056660.git.zhilinz@nebusec.ai> <7d2cb8e8dfaa9eb8fdff85156987a60960787dc3.1789056660.git.zhilinz@nebusec.ai>
In-Reply-To: <7d2cb8e8dfaa9eb8fdff85156987a60960787dc3.1789056660.git.zhilinz@nebusec.ai>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 14 Sep 2026 22:35:33 +0000
X-Gm-Features: AcwNN1WUa8mlYWrVLO0LqM9p8NTaYEkhDdFDcjWZEzIHDnE_gBeKM8jut5VcLDo
Message-ID: <CABFh=a5jv9KG2g-8mU+kxmEawr0aMt15du0aemA73uq9k9McAA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/1] xsk: use a 32-bit compare in xsk_map_gen_lookup
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	jonathan.lemon@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 5:07=E2=80=AFPM Zhiling Zou <zhilinz@nebusec.ai> wr=
ote:
>
> xsk_map_gen_lookup() loads a u32 key and compares it with max_entries
> using BPF_JMP_IMM. BPF immediates are sign-extended to 64 bits, so a
> max_entries value of 0x80000000 or higher becomes a threshold larger
> than every zero-extended 32-bit key. An out-of-range index then skips
> the bounds check and the generated lookup reads past xsk_map[].
>
> Compare with BPF_JMP32_IMM so the check stays in 32-bit unsigned range.
>
> Fixes: e65650f291ee ("bpf: Implement map_gen_lookup() callback for XSKMAP=
")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

For xskmap specifically this scenario is pretty unlikely, so this could als=
o
go through bpf-next. Feel free to follow up on Sashiko's feedback, but
they qualify as followup work and shouldn't block us from merging this.

>  net/xdp/xskmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
> index 3bff346308d0f..bf00d6463c191 100644
> --- a/net/xdp/xskmap.c
> +++ b/net/xdp/xskmap.c
> @@ -124,7 +124,7 @@ static int xsk_map_gen_lookup(struct bpf_map *map, st=
ruct bpf_insn *insn_buf)
>         struct bpf_insn *insn =3D insn_buf;
>
>         *insn++ =3D BPF_LDX_MEM(BPF_W, ret, index, 0);
> -       *insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 5);
> +       *insn++ =3D BPF_JMP32_IMM(BPF_JGE, ret, map->max_entries, 5);
>         *insn++ =3D BPF_ALU64_IMM(BPF_LSH, ret, ilog2(sizeof(struct xsk_s=
ock *)));
>         *insn++ =3D BPF_ALU64_IMM(BPF_ADD, mp, offsetof(struct xsk_map, x=
sk_map));
>         *insn++ =3D BPF_ALU64_REG(BPF_ADD, ret, mp);
> --
> 2.43.0
>
>
