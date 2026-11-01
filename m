Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793522928;
	b=XrMRwMI3XxYh3AS1VA2Zz6OAMS+LWdc0pSpxFto1RIs3w/vrv1GorLKFwZOi5aTDzq6U
	 /gWf8jau3MShqbYIHwcb5OWbkQt+efwHwaxLl5zevyxvupZIisqdCJLddySXGn6w1UzHc
	 IfgtUAqS+zkWr8T7SYQvE4yhj2Zia8YaqSSstYG6BjtH/XzkODwrZ4aMeVbkmHR3IDngN
	 nkQ2W9BQ6jNBGCp5Z6RtW2DQ54SVwQDWOxTymXfTFfbeOojSdsQcjzeHz/mB9pk0eFYNN
	 ADm4xHg1nkjxrFw7V7Ie7AWtXKVsDX6dAa/fdAcqa9JBHeDbKzVCtAMBc2a8SZsv9ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793522928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=d/S5ktHJXzZ3XHV4tu6kTnRxiDsegSAXyqGvriPXGfk=;
	b=dydHlCZxnAu4lGczNEA4stkFTOYv29CTIkCJ62oSSNfa72vQcrYgcD3R+YGxjbC4CnTC
	 +EoWA5GTiPLepZXTCltg2TyXXnivWKh9MNMczJsUGML/UOQPnshhXyt/Yx3aXeNSgYHF1
	 tQKeka66KQMHvT0oashdBXArzCPtiH8coHm09qRGv9u1EcxI+0Kkdtc0YeYt5Td49uxn4
	 7hQusAhTrXI5XllRGAt5gsSw5+ObNido42yqDI/asyraY9r/K+0rxx7I6U1Gf8c4vAOxt
	 YZeIqziK3knX7t8Wyy7mCPSy6jQYimfPP9EhstRU+vbUWnsuaPari/aSp1Y4CtWqS+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ObqtDW4F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79B606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 08:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE79B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ObqtDW4F
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-53c4858eb76so1014410b6e.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 01:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793522926; cv=none;
        d=google.com; s=arc-20260327;
        b=HCIkgIPdnZ/Fq0AxRr3I/OYXD2SYbrF7qBrrEMClL5ins/SfXD0wwHy2ot46IQKyJw
         gM4dcFBifNiH7WQhjqrfvEBso6mpQS8P3UtYd05vC4s/11k7jw0dWd0JETdmvAmbZNBt
         XiR92/FHlIKFM+WuCMLSV2d1BbTCzCyqqP/fqi4l2z940rvOgxVmpKb+sBBdSwTYwCeK
         RHYpP7GJd01c0ZxDhXS5CFdt2vd0U+d9tf6TEf26UwFw5s8ARStKrFF7IYI0wFNcLKXA
         3R5f5WG6clx3R+G7FnAhMWtNE6a2iBnyQ4zOSL9l+GHT+zddUTr4K5iwaT7D6ehQ3eXL
         VRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d/S5ktHJXzZ3XHV4tu6kTnRxiDsegSAXyqGvriPXGfk=;
        fh=0iQgVN77xCIP6jAdBuhvpFyBkWuzDQ9iMAAz5/zffVg=;
        b=RqpJ5VK7oZ2O5smIcBduppi707YKqnRV1vaqRIbGZNi5dH1KSScEF7LX9ObtJuskY5
         W3LOa4rhSYucT1dgiLj8c3LwsO6RdVKRGhgyUH8LHI1T0HpiJIw/iaxr1SYoNr70AKGJ
         lPMaM/Vn9R/LYF1e7flCk0A12hDGv6JdgputeFoFpiuvzdo+UZiT0+Yb6+9vIxZ7vpTT
         T5nkRi7elYLbFQgLKn4CssKy8JsqSxIOtKiwpvc/6aXRI8st2cbuKDLivtMNYSMoDWvC
         Nqf4/7G/NdIVGRxZPJjc8A4s013cGTarBTFfQMoC13IjL4r/6PDbdq4QoUwO9RQ8dWgP
         dMCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793522926; x=1794127726; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d/S5ktHJXzZ3XHV4tu6kTnRxiDsegSAXyqGvriPXGfk=;
        b=ObqtDW4FRXJELhMOZeV8NF8cSpvQaH2+hoZiUktDas3rWpL2YDvv/6MsuuKuUpV/aF
         imA0T8VkcX/9fnWMNULQSbQUUsxYHO6pVx/prh3fwzrYanUoZoEcmI+7DdC5AZbhY0JD
         u2qvG1/TW9GE2fdoxQhfkoTnYM4JtMTjLfKMPN5uCZEI/k9HAZ4onhqF9+cxKw3q6AFG
         mnkIluESBi4UNsvnPZvPWt2S02Y5kbQqpN2YOdMcIs4gNMNwhsVPNSpcQOdEFMtMqeTy
         4+0Voc9WymPTAWTaZKNbZyy7vnQTd/PspWBu/KMJOdaD+/fu4cVfWq7BZCac/LpwB5q8
         QHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793522926; x=1794127726;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d/S5ktHJXzZ3XHV4tu6kTnRxiDsegSAXyqGvriPXGfk=;
        b=bcNWgP0pljvpYkN4Icn0bRoZ6wDr237Qa08yEJjEcKY5RM/jro3ZN7t+uY6sj98LjR
         FjJNN7YLwJnS7vXwOZNFYHN3pwhVHB2D7sHUaw3E06Fa+rJqmwuCNvCZ1YpsAFrnx5ND
         teZ0CvmB1jaaY3dqwQ5O9YWsJh629qnzkPLpaBWElPpgaVrmXJRPYOJ3dSyMOFRmhYlz
         E3A2lFolymbTAPEARY0TWDYNqVDsxG7ifoAwfmpvJCZLzXeLQ7wUCwlFw4IvZENOuWDX
         CBXgXb48nG+6HQAT7WImchcyJEKdhEOxV8EHP48JIEdpslQNeCqqP7eKTrrJ2JhEv+Dm
         KDuw==
X-Forwarded-Encrypted: i=1; AKwUvBzN0/is5mzT7r5jzBrDw87VQD8+sk9LvR+GfqCTYd7d7dKqj4mAqjF54zu3RCdzv86vAI0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtZbgnCndkEiV9YcWXQtmxA6/2c7MYAtWBgIQNGzEtk0RsZj/O
	dxr7CqkqKCVK/3gd4albuV0QDCollDPPI7SdgS2z0OreB4HDLUmXscHBH0DjNGfHg2YKYQ6/meI
	qjeNgGScagX7+xPhXlV0IfqFxkOI9zQomMhM+wxYmm/AM
X-Gm-Gg: AYBFou0zAjIocTrri8WjbPS99YExpUBYYvFJ5JuR+XGElmz9S7DRtZfbJgOfzZOxomJ
	xQRDReh61r9hYgy6qkOH2Qaj8KoxijScfmPcftcOmoe10QUvTKmDmIX6ltXP4zaG5aVR4CuJ/a1
	MhSBBxOwrPJ/tEU8FaQF3Mm3DHvHTvLtpY0k2ZW0VUAyRefPQeNAdgqirxAZO+Go6rtIOQi9m5L
	d44TSEPpVcWf1ZMlW+Jee/YQ/kH14nVqazhMpQYm8lEbwyto/whUAVfWYqP/kvfg6YADcHLoh5H
	mNMs39ZRFxYh+P+kITemQG/nuvEdZWqPkWaHrhkBhSo95xBDBcrATeuDmOs86p76kTcnhdX6DhF
	EhilIMLUC05HdVB9IQeHDYVasn0hqXA2tUA1eCcwzWz2+HpnBolzCYZ26KIB2OFg5KfOZhXY=
X-Received: by 2002:a05:6808:c40a:b0:4b9:e65b:8c33 with SMTP id
 5614622812f47-5640ddb8b16mr4287436b6e.33.1793522926506; Sun, 01 Nov 2026
 01:48:46 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031233219.9362-1-dennylin0707@gmail.com> <DMJG1R2YIJRK.16CZLV9S5U7Z7@gmail.com>
In-Reply-To: <DMJG1R2YIJRK.16CZLV9S5U7Z7@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Sun, 1 Nov 2026 01:48:35 -0700
X-Gm-Features: AclHuK8izB10BirS0avFrgzOPpGyLn4aCmUm016M7Kdli5O9sXkRb-1DHgSukmQ
Message-ID: <CAGEkeHeVXp7NK68WyOKfTt9429Au7Q5eQ9G0u35m=hZ8mZ16_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Match unsigned enum values when dumping data
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	yonghong.song@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Pls check what clang puts into ld_imm64 for such enumerator.

I checked Clang 14.0.6 and 18.1.3. Both emit 0x0000000080000000
for 0x80000000U, so libbpf's sign-extended orig_val fails the
LDIMM64 check in bpf_core_patch_insn() today.

With Clang 14, -1 is emitted as 0xffffffffffffffff, but the enum
has kflag=0. Using the helper directly in CO-RE fixes the unsigned
case but fails that same check for this signed case.

In my offline relocation tests, with modern local BTF and a legacy
signed target enum with kflag=0, the check passes, but the helper
patches -1 as 0x00000000ffffffff. I'd leave CO-RE unchanged in this
series to avoid those regressions.

> Pls send libbpf, bpftool and the selftest as one series.

Will do. I'll use the shared helper, preserve existing enum name
matches, and add regression tests for legacy BTF.

Thanks,
Hungyu
