Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDB523D291
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791030222; cv=none; b=jb2u6uw8J5eAauaVMMaCslzWE7k2xf6LqVvGUn1Hm4iZikABnrmg/kXoDfim6lDtaqU3GosuTM1PacthqJt8oDWw2MtNxPbIcziqe5x42bdwY9cs5ckiqWt9wfOCQoyFsBtHz0GZZvn1hlWSXt5UFACyW/or6d/u+NfgBJ7szd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791030222; c=relaxed/simple;
	bh=IwXS5G5JDXaoeb3NBU8UTPECe5eDb0oqWDHfW2Ns1JI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=t7NBoRKKc+M8SzWrBdTz5lWh1aZyd+kZdD2iizl5Rf72gwjELiu2PWGP0j7bqbWy9R5ZaTnRk7OxFLWIX7J5NI1kcAxbzm0j6EQIF0jiLvO4gDSJBrx8VcrRnq4904DIdVy5Mr25iAy6gV0wLqGb2+24bAAE5lOwEcigUeE1v6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj+stghZ; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj+stghZ"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d31bda43so145080a91.1
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 05:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791030221; x=1791635021; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IwXS5G5JDXaoeb3NBU8UTPECe5eDb0oqWDHfW2Ns1JI=;
        b=Yj+stghZbn/BQKJgVkzLKe/ukbOmjm4j1I7s1zqbvO5BAy3/3eWEKDlL7NgK+e/lnw
         BcWhGTLJcA2cOzO5imHh7PuLKfoFDKl1sdMnbcv6L+Y+vyqW2jcuc1ksAMZAlGRs4vEV
         2dsurm0YYDDd+kqIWLhccXMUuxxb2vKOB4Nobnk21H9aGLzNmf1tXbW+dMvdpAyeJ9ti
         lupMcn+EwwDX+Fe8+A7kQLRicBhlank/8ewBns+nQao9Rqs+Mg5jXNhUpoEg4ju3yGcy
         S7X7f6T6H3OyDRRkLj+7tmFsrDy5RmVAf50QiWliU0xfKHuq3zkLMP9Ro14A9H3zSnnV
         l5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791030221; x=1791635021;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IwXS5G5JDXaoeb3NBU8UTPECe5eDb0oqWDHfW2Ns1JI=;
        b=RjSIPxfcfNYoyrNy0DaXlgbHgZMNagv986bHqcPqB7J3qVisBpmnuvFvXply7sqnva
         VrsaNgPtJEp15D9EtQ0BLih4GplolGD9RWx/70AGIl6rf1zvhsJ5G8AZwExrjdgYMXVr
         GhFdwefVjPIpv2x95V14tTB3JvQ5GHP/uXVfwohw3VKsp8bkcJOpoALvIEdh/naja2Y5
         7ccNRcvA4fkOXXMQYm4qoQUt1Y9JRLzu5cNN6jvC1UTzSbjV06xD43gr8Ein4HmjH5+E
         yhFWnivh6cIoHaSHEACWy3A75KGIaPFK/76ngYN2VwzEQWqpVWOjZEKqg/sGlEqn61xO
         qq2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxPJcbkPRFZ0mLYByZiMiGL0j6H5u89RXDCbq2qibAMbCYou3+NOU7X27L9CTp/qgDpIz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5vo2xytr2AOM3Xmxa36vHQczZo2vaLAPPtCnStLCjdMG/VGkT
	FyJBI24wkBbZC29pNDQoPu4mxTfWOjKB2GoIZ7baFbGJkG1tNXtafVA9
X-Gm-Gg: AYBFou2vRW+g2LTatYw69YBwm/136rQN83SyGCS+VjfIfgLaggywOWOf6b1PSCc8lKg
	y9w3FLm+LzGIkr8GoeR3e80/hoPh2qTI0CF9/0QCTaTH7zOa23Ds2W37bIYiPPPExwpvnF0ywN0
	rYVVKgcLvCwMlJyUhm2WsWSwVbkCg7yBke16yRVmcBuYsGL5uRz089DsyZQfEGP1kyjksZt9k//
	Ywp7hs7vBT7m69KNayyL9127jQZVnMU+B3c5Ulqx4qcbQzY4KtBLJt/j2Jg1Hu5/8jnj2Dm4t2e
	JMtyRMhixRMdC8JO8Sr6VxrUiMsYvcG1IPtOm+tAB30JWSaQKYnadbGCrdCg7Ts8Z54YXQvKo2l
	N0x1ROSZ3/W3TeOdbcWIkjhubjCvZK6quRkDmiOIIQw7F1lnq54NQtzIKe7Kl9o4vEKPibyto0A
	8JKUjoohykhiTlShoOStYE8Tovi+PRiovih7bgUSwOYisWhiZYAVpkj9/MHxOiqV0bQX/YhW3i7
	1219Am4k/v3N9Oygjjo+M3smjqRi4Y9qpevVvs1mf7AhMEJv2BJ8AAwFNFZCcnjUInaXgWLLnpk
	Rl0=
X-Received: by 2002:a17:90b:2d10:b0:3a0:42a9:9c75 with SMTP id 98e67ed59e1d1-3a6ce814944mr4225671a91.43.1791030220679;
        Sat, 03 Oct 2026 05:23:40 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4262f0sm3121570a91.4.2026.10.03.05.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 05:23:40 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 12:23:40 +0000
Message-Id: <DLV784DBX12N.12EC4LTWZLKXG@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v8 07/22] bpf: Follow an unwind to its landing
 pad in the verifier
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261001133042.1339539-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev> <20261001133042.1339539-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 06:30 AM Yonghong Song <yonghong.song@linux.dev> wrote:

in addition to what bpf-ci found...

can we let both kfuncs go through check_kfunc_call(), like bpf_throw()
does, and follow the unwind after it?
Then there is nothing to open code here and no need for
check_kfunc_allowed() and check_kfunc_allowed_only().

pw-bot: cr
