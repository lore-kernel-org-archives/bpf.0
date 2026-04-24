Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39B3B9D95
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038834; cv=none; b=oMWCUI8Xh84AQ1iuzsvw/jNTe2HFZLECfvnJwulccJhfnObO/IWn9+pdgf8QmAeFkA0iwgx5UFXjhXDiAKWQvsCrTa573rhVP3xeJDxZB0QcsZS8Ar2jJMj9LZbgo8G7cAy2jzv7/Iuj4FVhdPypP/gBScVmzX7HCHygLJ/grPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038834; c=relaxed/simple;
	bh=dHTGc7U51s/9RfpRNgmdCl3F348SExuagSV9wIZzXe0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=s9L+KE1FqfEw0yUeGY/TLCmuIOA2mqjt7bUg6dw1aifauYpCNoQaoFKra8lhuN4iXmaujgLZ8FwJM87+Vj6+Aznog7jGr2j/LBr+5QlpDsu6eqBEfxWZLZiK/mmz6uKHNJ6NUWeVN0R9zAiao2pYV/YB0B661U19Hf4KCkqIEWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2TNQviB; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2TNQviB"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dca00c1591so2487695a34.3
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777038832; x=1777643632; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHTGc7U51s/9RfpRNgmdCl3F348SExuagSV9wIZzXe0=;
        b=R2TNQviBbswq0JsnMfvHeKrUZOwgQqQiqY9HEaqjZolINYMRL3hKH4xukFQgIBgR1W
         vGU+pggx6TAUiccKFAJjxn68gZUeN+sff5oFrbJWlIPBNlgxANHbelPEIpKRgUgk6cwx
         W/LWFae6Na1T697G33USXa7NLUSyIvUaViMIxgErY/xUBzJz5nTEjKr4+xnFrt6QSu+r
         DhYvvASeLtqiHiXFgS72c90LqWpQ5GB7ikqL5T2SemUfSGikrhLRULgPYfNpEhOLgp09
         LK8KAeAqtfPLMVjTw8Sk6BCEqte8i+R9bf7A9kkJhn1Yk44KAhnNe3WYkvVeKJd415Cq
         0gQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777038832; x=1777643632;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHTGc7U51s/9RfpRNgmdCl3F348SExuagSV9wIZzXe0=;
        b=iHv0rWvDGwaGSy4Z0iLDrE5E9heKxACCydWdpBo2Xl84/riz3KWRzFVMNeMYVvD6Yi
         tjeGpDz/EZu6VE5Qux+jYTbzVtzIXTCJWdgbrjx+209eZlHxu3ogDseBQZqPCOFYpBcL
         RQi2NHK3xauI0dLsoLPpmxoVqEHBzOTs5Qq4uoILZuLJte5U12GfeUZx4KyYbWUCH4iw
         fEzp/CxDvKS0pOnTUFFU5DNbL5fGdC9JTt6PveALZcnsyVOd7aPkYN8zHNYYHM83jnRp
         9ZR2pscVcTip2lAWDH2b18Ui8txa9CN3kLhA4NCN47T/jrTuMc8CPifXl99AJpjZkNVW
         ccYA==
X-Forwarded-Encrypted: i=1; AFNElJ8I4M0eivnWa1vWoQpYffVseCIX2Kelze77WYng9wrggpOmhChyFnGN6zdexAE8XykT7Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9GsUk5YfAeLNBO086zYDrxXgMJ4+uiGaRbz/5IJj2Cjt4NAh
	fwFUh2ApY/hkAQI8ETtD7qZT8uXrQwd7KdBWPAsBh/Eto07GRSEPNUM3
X-Gm-Gg: AeBDieuIGC08uDYRu3/OuTxLBW7fdtS/a1pxv6Ezz/Oqq/64khRvsBpULbZb0+MvEiB
	raB4RxV7zkiCYmDEvUE8M5V3P1LEsRbrcB6iCEH6p8A9l2VqVosOjwwSjCHWnPvmAiz85T8qjyS
	ygMg9gYv48oRYdXV1VIRIAcNg1SPM0hWnd0klBkRri7ZEhCoJ9VdhsVTCEN0e6wqN06JvLth3qJ
	yTgwpD1GFZH3iusKBUrrBZJGaUsyu5+3O8+4SHW+GnrhzLTLrdVshkPGCPK96vvDFVNTVoEsYEr
	iwlR4yUwhV9ypS0q69p8OYaRf3Xr030Kfbkmf9w/mZyKQN/qNjulE6TbcZn26XO8IKthbIAQnTn
	sbV8ocP++5Wg22Qit21OkhgnBr0yn9BS3phaoY/laJmcl/qpcWZbbtsRSxxsvHuGbwygrcDTx7Q
	wttPKLGOOB4PIYofkmZjUkJIS+v2lO/du1mhdCkBDi5O1+Kz8eT6KpWuViDt8C0Exj2YmHMX+Qp
	/AUQAH2sNFfW1iNA1F+oMnUcyd9
X-Received: by 2002:a05:6830:3508:b0:7d7:ef35:2c4e with SMTP id 46e09a7af769-7dc951a7664mr18794418a34.15.1777038832230;
        Fri, 24 Apr 2026 06:53:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975b0591sm19196626a34.19.2026.04.24.06.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 06:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 06:53:50 -0700
Message-Id: <DI1FOWOLC37Y.3DK99VJZDMWKI@gmail.com>
Cc: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, "Zhao Mengmeng" <zhaomengmeng@kylinos.cn>
Subject: Re: [PATCH] HID: bpf: Sync KF_SLEEPABLE flags in
 hid_bpf_syscall_kfuncs set
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Zhao Mengmeng" <zhaomzhao@126.com>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>
X-Mailer: aerc
References: <20260424-btf-define-v1-1-0f52dffad5aa@kylinos.cn>
In-Reply-To: <20260424-btf-define-v1-1-0f52dffad5aa@kylinos.cn>

On Fri Apr 24, 2026 at 3:22 AM PDT, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>
> Pahole intersects flags across BTF_ID_FLAGS() occurrences, so omitting
> KF_SLEEPABLE may drops the flags globally. sync this flags in
> hid_bpf_syscall_kfuncs set to enforce consistency and safety.

Makes no sense.
These kfuncs are not sleepable.

pw-bot: cr

