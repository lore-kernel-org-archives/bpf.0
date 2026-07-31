Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76073442B37
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513247; cv=pass; b=Hlbwfeq4jd66OJsh9p6GVUQ26/bfijtlbAilVOJBmsMC5PvSZjcXsczkIj7CmSRbyprJpLVjh2hojymndh4QME3sxwEP/hMyIzS+G3/KFPGzwXCO175Zj6FB68YD4dS+pjpXtbgHPKhwXirRYeh8jk4HfyRU2MNzqwuBQfKrc8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513247; c=relaxed/simple;
	bh=NdjZUpmzPZnbev3nErg8Ah5yqfjCOeg4X4X3Z2k7pW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsYTyMx/Edlhnh6gi83fh9mx9/UW/v8wK48gO/7uapQa+gsyouYchLb5n4mM4yPea/NBE9IkWlCG9W+5ho9X04Be2uSv8Ex5NAzvOTFawSdxbepoSOMipHhofSDYYhXPfx8cqzgFbnxNWrl+WhClk4ECz/qjGKevL2yaFRRNl0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ovj9T6dv; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovj9T6dv"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c16794450aeso167478666b.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 08:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785513245; cv=none;
        d=google.com; s=arc-20260327;
        b=fhCz+W1wrldoPwOIPqfnx5G84DN1SCc8akQomjtPhl7XU8HKNIP2E571SM7hpqy7PE
         SjJfNfwwVvTNsMPn8u/lbRcitDb04AzOLIcFjs42e9yZQnvw0w6vPPSh+GFEglO1Hzpy
         Pm4yssXlcdh/CFVxWVcB987gT/rrrxq2pM5fVqdvh/kw1sA4jhfStacQA1xH00GWSKLS
         ybGt7iFPnzKB3qj6Bp0pFYOvd1Rv4qZf8rmRHMxpwuExMlkIyFW4oQ8pEetH6qBR0D0V
         GS0LbXsq43od2LO70cLvLa56UCDpnslMoYy/yhObo5xKI68YSXkSea1DvPYACUF0lplk
         tUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AUMtluikfNRsC8Z97PB9sPGKAI0yWhOSoIYDn0tGlXs=;
        fh=jT1HXWBa+0yIeZWXshyhsSrnuihNE+ry+k7Rcm1wtko=;
        b=oTMZShtYxr7bU/5IwjG7kWb4iVwxTEchqJQ9kt/hfabh65u50zZkkqyLISQKJBanDu
         PPNTXmIrjBGr/FxN3YN3kI2moRU+efjGde+LtSCjpmrUXWL8HbtDYSZzlgbg3rqt9EWS
         nPFf2eNoKalXnedr8qgRWIu82bhAQUrMYOmav0LuEGJLdQzfsWucxw0UIr7QsEouksuE
         ThKv5s0FXH0j85+Nz0ZCmBokV6roTlnJbO+LrB9VYAUO2gAIeAbdcJxILwGzJCFbzBQT
         mPIBf4Xs+2d/BfRBipBkQhe1xugJ4cMxtljS0poq8y5vEmc8H326DC5cWw/r6YCLOR69
         Df+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785513245; x=1786118045; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUMtluikfNRsC8Z97PB9sPGKAI0yWhOSoIYDn0tGlXs=;
        b=Ovj9T6dvfrqi7Fjb6LI7ewOrAsaXe1PQul4uGXl7vrX59UKJrY7IImsY3Ou/2kYZVH
         n/ABKgdR92URlX4tZeFFC7TtS7i3wwmsKXhraKBBZB0PYZAYJdmXn8+XiiulrgW1Vpbs
         aA00gvHZNYXDwadmNdzKi0TFB4IY/Zy2kSuGeVpkRzRuufM65kE7V80qY6HsvV4OAqPn
         z5xqQb4/9PvNyrmP4FbEvSUwL9ldeYALje9JkEwX0hip2aXreIjdg4BSTQG9kXjoTMig
         ppORU5DLmiICruySbckr6nlqvxqMZ92sBTnEBWwgPaqtt5nEMeYa5sk3xXTNkz7fiERx
         2Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785513245; x=1786118045;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AUMtluikfNRsC8Z97PB9sPGKAI0yWhOSoIYDn0tGlXs=;
        b=MNgj0tMK9Voj7K516+sTJENwu27/v7uvMoSGfhjhdsVDA6DyroowA/vGi5W0WN4uav
         gvs9AEBgGYACJdoNByp/2/rhZpiEStTfl31dvxYFm3nEmSPSp+aDMXMKFgzSf0/QDmmp
         d40/bDoscjKCka5BCNhYd1Jivg1AE+djECGn2BRKIrTpru5IYAduDNO2G1F04xfE07GN
         zLkZmaIw/zoM1hdAOj7Sbp/FQFZQwiynIndU96TIum84QOifetGtmtXC2SI3pR7tYZfe
         +yr3QmkzeVHTo3P6fooCvgDtRx3j1T/tfMrN8xLcjHJsi8KGp4Ehg7lIB0w43tgnycpm
         0u0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrHrbi5dGPOzjAkC9V2cEk06q9BofOnVkM2wMbXnaPZhDPDa1MiIJXbKsK3vGZdOA1em1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaiKkwk0xBNRItmJFXBZVCe2fiUyeod0E0EbHUyLcCwo9fnHVC
	8MfFhC4G/iwU9lBMJvxbDWTeC1CNpJLvo4Z2bVS4h9DKajFj58ffH35omgND6AY8FOxX8xPmJ54
	E+As9j0Ef4OPraFFi8acj/96mPIsNKnM=
X-Gm-Gg: AR+sD13cmuXsR7HaeKLlF7zRjfVuJxH/CcIv5VdmKa1j7IQJosfBxmyHEd+Jh8MqG0y
	JSjJCyB/jxmNBLJANpRoWBgNRVEmlsYZdzx7i5zgwTraVldjEug5nZU/iO15sUguOs2B9gl0+Di
	bjpfy5lQdtRnMsdIUU3/7JfECwMESvGpywWKNuADXPuT3J+4fR6C4qOdZYAcemGbQHqZpEyXoDv
	bbpmc58uxcnlcQeJydQZ6oBOfmiFK5r94ViggYsbundCFYCEW9vElXqJkjJvR1CfhVVxtS8wT03
	o1yKPH1PtG5BVnw3C/V7FrNXto7JcIm/LUDBgouNWIHlWQ==
X-Received: by 2002:a17:907:e1cd:20b0:c19:80cf:4c75 with SMTP id
 a640c23a62f3a-c1fe7f3c548mr8494566b.20.1785513244463; Fri, 31 Jul 2026
 08:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729162931.2369353-1-main.kalliope@gmail.com>
 <20260729162931.2369353-3-main.kalliope@gmail.com> <CAM1=_QS79dDBfaaNQXnWd61AqHd1M4o9aDMMiftnoJveNr=FZg@mail.gmail.com>
In-Reply-To: <CAM1=_QS79dDBfaaNQXnWd61AqHd1M4o9aDMMiftnoJveNr=FZg@mail.gmail.com>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 31 Jul 2026 11:53:52 -0400
X-Gm-Features: AUfX_myt_kB7E8Gv4Te28D81GXbe5vzIGv6mSlzfyJbuG7pj3zf6QT86W9HaaAw
Message-ID: <CAJZwKkgXoHhaej_hkBfytY_6N0PdpwfGMt+GUcHJGyaH0+e7RA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf, mips: Add support for BPF_SDIV and BPF_SMOD
To: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, tsbogend@alpha.franken.de, paulburton@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	philmd@oss.qualcomm.com, visitorckw@gmail.com, bpf@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

Thanks for having a look.

> Let me know if you are already working on the remaining v4 support,
> otherwise I could look into it.

I'm working on separate MOVSX and MEMSX patches. Would you be willing to
take BSWAP and JMP32_JA? If you've already started with a different split,
let me know.

> Consider making the uasm additions a separate patch.

Agreed. I plan to structure v3 as:
  1. Factor the existing DIV/MOD emission into helpers.
  2. Add the signed DIV/MOD uasm emitters separately.
  3. Add SDIV/SMOD support in the MIPS BPF JITs.

> Should not "quot" be s64?

Yes. I will make quot s64 so the remainder calculation stays in signed
arithmetic.

> Please propagate the raw offset value and do the interpretation in the
> div/mod helpers instead.

I'll pass the raw s16 off value through immediate validation and
register emission, and interpret off == 1 only in DIV/MOD-specific paths.
That leaves MOVSX free to interpret off as its source width.

I will validate each series boundary on MIPS32r2, MIPS64r2, MIPS32r6, and
MIPS64r6, and build the complete v3 together with the MOVSX and MEMSX
candidates before posting it.

Does that sound ok?

Thanks,
Nicholas
