Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.230.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794217639;
	b=2Yi7h5A/8JtN8JceFWYFRx5ED91FFTTW5PQ82VCyjzTGaRQO9/OOjJCzcKvVW58+jxkF
	 KI+FgaMtZTZAjvjBLeNM0hfgk9d1HV7qXPLhqSkq2d/APjbMZX9H/TYSgmpsG2BfnDsn/
	 /srrUD7jtITEoOVC5uH7OeJZYiq0n2gUDRQHOlilXAO4Z+3+H0o4WWtRyPrT116Ja7jhX
	 9I3/G9RkMmBbMeq0aYb/MouDLJS4qIfT6ihx1VBG9eWMF8BIRda4FmygW4XdkhNIWGymE
	 fFjay5nrDXr/GS3WlajXxUKHi5zIV0r2HMHVdxBDBghT1ItHx6BH1fTs0aNIhrXWlOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=uIE3M/acZsAUW4GpaFjQKu2t6slRnu1XdH0mtkmeVOw=;
	b=WTPHDCliSl4IZOxCI5D3O6duGnWWXLY0/TrvJYwIse0BJpB2ap/CIRDsmPmR7L33d9pr
	 dwSg75MKLXMJOkzoWt5lurDFZ/FwhFCPhg1kC72V4YWSXxFVL8IGuOM2HibMrcdPNWYtj
	 atezHuM0o2Gctmd8cGtOd6Yp+ac1Rje3tzX1ggLioK9InxsnNWmSvPPIxSfja44ozBIkl
	 ZtB4s2gyhAMuFrd854Rx2GGuowxnLm/KoUtIK+gip0f+sHq+3G8/Fnt/Gw32IpzIcP6Lx
	 +BbXxrMJZs0rv0qsi1nWHUbUcWGaNG9tmEFBtGtUW7FQ27ZFTPcDsevC3+Ac7okbtuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LvCZ7BOz;
	arc=fail smtp.remote-ip=74.125.230.73
Received: from mail-lr2-f9.google.com (mail-lr2-f9.google.com [74.125.230.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8948606A32A
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 09:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8948606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LvCZ7BOz
Received: by mail-lr2-f9.google.com with SMTP id 38308e7fff4ca-3ad31c004d8so5717021fa.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 01:47:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794217637; cv=none;
        d=google.com; s=arc-20260327;
        b=eID+xjI9e0ODrBhSiT1SPDxgHxt+5taYYVA3bZx66uPOLoVuuPlvQ4Ef9S5DX82YRn
         YfDY7gcfS4n1gU2K+g62nH2xE1GfaGnOXk9XxaoXVNUz5wt5ehdy16+UyVoVuBjj1T9D
         62hcYlV42sOo6swfOF0P604e38qlqzeKNSejJJZjdbsXl9IT5IjeWGlQNHBhtb9d3FsI
         jvJfwT8A781tRS1tPclPUmDz/JnOCCjh3sK4FRV41dI6lk9LUo7zhwfBGqyd60rTTfod
         e6/F8p9ca3SpEDEGFWd/LS6oE/AOOzFVEzlRPCstVBPPlyI6d/yiQHqQsqhoaXKDRRxD
         v13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uIE3M/acZsAUW4GpaFjQKu2t6slRnu1XdH0mtkmeVOw=;
        fh=t8fSlha0kbvYnp344UcqxpAoQjsWz96gblH5i935t7c=;
        b=NoLwl0GZxavnWSVePJITjh6TxnHto8qebPhz6/geCAHOiu0LU+xsHPjun8lgImhKxv
         nac2PP3ExchyKybYJnalqZFyR+gyR+BCM976Qw5Je+eh0tViYQd3prbhTbTLV7SW7K0l
         1mCiw9jnydJr8hnzjJ6xPlUlz8Gvt9B+VesCozWxiLpxBUz9TW2Is4HzANeMfiluDGno
         lVHoHv0mw3uf+JmtLZRb/G5O+lJ4BZu1NOTitUSPa3KsgRFKBsRiiaDlFucBZfgbxitL
         M7QokQ0mf86wTofele/L+J5KbFo49bDosbI5s2n0jTMFlDyCKTjyerouAlavAtpWNl7R
         RhDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794217637; x=1794822437; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uIE3M/acZsAUW4GpaFjQKu2t6slRnu1XdH0mtkmeVOw=;
        b=LvCZ7BOz7L9xsFF9pIIYU0sJoAffENWr47gDWv9IWQ1QEmHfxPMJ4fHFpO65igbwf/
         btyP0wpGhrftCX2USHUqY8YlBNGJkg0OaDQj0LqTiFwa/TBM7O7Ya9JKfp7rcSj/HMyI
         ZT1NvOPJKy4aewilbFWsFh4ysRqbsG0iCR8syaIJxOaIDBTYzSkgz6A/WGgN7ZOaIPMH
         n1oH5rr2ocBwrWAJ1eBVXoNhNCPTTpCsbyJCzRgR7IkC5rKKwDt13Th2lIk6SJ9J55EI
         xAnpnen4dOuv90Afp2v4f3foX+cesBt5tUBinsHcr/99PLjD07UYl0mekEOyOSpI9cB5
         PxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217637; x=1794822437;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uIE3M/acZsAUW4GpaFjQKu2t6slRnu1XdH0mtkmeVOw=;
        b=ump2+SdfVW7Vrpqsyn4pfGKzyDSWptCDSdHKbMQkDVhegmBELBj1444m3ta0KbZNYd
         BZPdZRGFN25xwQDPewA99cYL9Vbdaozv8Xd5K62gL/k9Do8XOFGR0tm6xke3A6Fc8gSL
         zXm6akXAcFBox9IEBdHNMN8thI6LUj1BGqRQdT89jvPFrRIYy3WGVeAmMUoPj14ghw3O
         uKu3bkBpz3VdeHbyfy0Y4jwLzN/1IS5wOoOqFnVLnlDNGlXr7kEcBCTy78FdD08lubFG
         E2JoFifAslBOm3POniSO7NWTUOTCc4eVWv8nsjF7/TS+qVjtbvCENb2jaYABUgLgnc5+
         irFw==
X-Gm-Message-State: APuU4Z+tz+HZEZmK0MDQJA/H/vrt18iGEAgmK9BTlRUWtHputOmjZi0M
	cLWY3FyLNt/lvNm3px6GhlupKDXprv2Ti33pAG+jUES1EMiNjqxJQLCJVeSSw4TB0ptzDZaHQsV
	UY0ZZAqISumDLps2QIvCJetooPhksY2A=
X-Gm-Gg: AYBFou3PDE0m70Q7ziwCU+zzZGtsISVZhyuLzfzC60DjBFgBfVJlFZXPp42hlD53BK7
	Ed0Z95+qRZtT1sggC/MJfz7MsiF+sXtiKcfl3vWXNHxvr8BuXRtkmo5rx0CfflNapbdKtTadqtX
	eyuKFRiCEp4uV5GbcaVoOdqkplhxJ/18LKcd7ymRwbx/9NgYxHYWjBMgNNiisgagcbw9SW520Tv
	INli0WSMw9ZSgXLSXqT+1wMmu7Ehw0ECQI0booPRjeQ2Wo35iGR0rwc6fCyp+0VqCAdMhXotuRO
	nQ1x6A7K5Qsx8HLUtA9DzcjACX9gIOjbKeZCMvb6HGe4FQP6FbLO9zg9gy+uPxffrr5n/2iRZRU
	VlYl1xn1uy7vThUbQOVG8Mp7eHQHWrpAuaiKgbw==
X-Received: by 2002:a05:6512:3ca6:b0:5c0:a57:2cc5 with SMTP id
 2adb3069b0e04-5c14bf8d68bmr915317e87.3.1794217636586; Mon, 09 Nov 2026
 01:47:16 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108152941.7363-1-shlomojune6@gmail.com> <DMPYM1AW7KEU.3RX07MQ1JMR39@gmail.com>
In-Reply-To: <DMPYM1AW7KEU.3RX07MQ1JMR39@gmail.com>
From: J4f J4f <shlomojune6@gmail.com>
Date: Mon, 9 Nov 2026 17:47:05 +0800
X-Gm-Features: AclHuK-9V7GyigGbUP33a-mJIWhckUNjthd9aaYGGc_zn8e-Id1zaC-hC2qKmZo
Message-ID: <CAE_Lbwn14J=hsjARLPUKAGQZmEUVXfit6fnEgk5m7g8xADRnAA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Check variable-offset accesses against
 special fields
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 00:11, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Nov 08, 2026 at 07:29 AM Shihuang Liu <shlomojune6@gmail.com> wrote:
> > Check every offset the register can take (min_off + k * step)
> > against the record.  Constant offsets keep the existing check.
>
> No need for the helper and the second loop.
> reg->step is never 0. ___mark_reg_known() sets it to 1 and
> reg_bounds_sanity_check() reports 0 as a verifier bug.
> So a constant offset is the k == 0 case of the same check.
>
> Something like this (compile tested only):
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8bf3909..2265362 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8094,7 +8094,12 @@ int btf_struct_access(struct bpf_verifier_log *log,
>                 for (i = 0; i < rec->cnt; i++) {
>                         struct btf_field *field = &rec->fields[i];
>                         u32 offset = field->offset;
> -                       if (off < offset + field->size && offset < off + size) {
> +                       /* An access at 'lo' or above ends after the start of the field. */
> +                       s64 lo = max(min_off, (s64)offset - size + 1);
> +
> +                       /* Round up to min_off + k * step. The step is never 0. */
> +                       lo += imod(min_off - lo, reg->step);
> +                       if (lo <= max_off && lo < offset + field->size) {
>                                 bpf_log(log,
>                                         "direct access to %s is disallowed\n",
>                                         btf_field_type_name(field->type));
>
>
> The store to arr[i] from the commit log. It loads today. With the fix
> the verifier says "direct access to kptr is disallowed".
> clang can't emit such BTF. Compile the struct with p at offset 16.
> After __open() move p to offset 8 in bpf_object__btf(), then load.
>
> The store to arr[i].data from my reply to v1. It has to keep loading.
>
> pw-bot: cr
Thanks for the review and the suggestion.

Sending v3 shortly.

Thanks,
Shihuang
