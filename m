Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149482AE8D
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728430; cv=pass; b=YnSi1ucHEh7v8B1BvzQNVKeXMalBNnNswLXq2CngSrI4lPWPYjVLIACkTF46tpgs58Nrpn5c9E9S8hcSspd0QnHNNoPDtppqDCpp+Vk1lYteRfHiSYSGrxmVxUQGDRVTDMWVdX4j1SCUK53f6OHEBdFx1ZyOFmkSMU5MNVlGJXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728430; c=relaxed/simple;
	bh=NBPrvAIfRn7J77pp19LwaB//tzyaLAORi7qkoXMKdVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFDs7b2cGDwMEFUsU8puoqW824JLz2Jzp1bGTifxIIqkAcvKSh6ehEXddWo2Tc/zkUIBzTsKIz49oDfNaflA91+7y5mA9yInS9OtA2+7t+hgCTlKSHD2EI5BeTGR4aK8PSyQdSlKM+7XBdLbqfQ4yWBW3ECCG49eTH8cRzY2hKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sVTk29/B; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVTk29/B"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e04df8c46so3201716b3a.2
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 14:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788728428; cv=none;
        d=google.com; s=arc-20260327;
        b=poMAIBCA2krFeB5T92+P6JSUJuYsKyBSIuQW32o+0NFmTatWILI3vXV6Gf1FH0xWG+
         JBDGSU71fSZ2tvZm8YuElAEUMWLUtyDv6ULEwSGzbr8cj1jL8NdLNw3BVWtyzUOcdNBo
         8FpV5Q4Qh3bkt3sqec5wC5cOx1wKloa1w27QcjqBkkMH7Md8mCrECwwNtSgm7eMEyxwy
         QoeBorbzTM29L/1+mUuyca2/F3MjQ+p0Z3760UKS3DbD+cCBEyarE6Cz9NgkZAXtm/0W
         dYzkvGaCfx/fr8QAWFVnxzhS+wgg8MbjVKQTgE+PeAd24n+y7NvYUU3npC42MHTzXxmk
         gdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NBPrvAIfRn7J77pp19LwaB//tzyaLAORi7qkoXMKdVU=;
        fh=wYzPd3bD1zAVQt8ucKNCcEamLuF2VeGqgKL0SwF1+l0=;
        b=Ui1bw0pXr+HBC2cQcM55K3WbCQu2sgqeTxTk1nUZY6oGPegj6vLOaIJQUUiAbqgNXl
         ySDy4yugzp3l2lHr9kkWCYqms/luaj9BhLe5Sexg2ZKFOR8Lf/x50xl4oYYry/K/ExPx
         NJPt/m2pHI1Wnpc6rBf+Md9LAY9fVnzpxEmF1stOSPs2uJr7T6jKPpqcVmjemRbjTod7
         p2Y7XyKcDVfAgX8ClzaGPaZAkt1EcADx1q9ffGnYAzZ/VUwV3CDAQbTJeX/7Bngl59my
         4qJVrtWu+fyWAMY3YAWWjdrJb6bSDmr/HHT2N7mrboOJ30I60OkPJDbtFY7o7nuDW+uV
         RdNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788728428; x=1789333228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NBPrvAIfRn7J77pp19LwaB//tzyaLAORi7qkoXMKdVU=;
        b=sVTk29/BWQGRkkgzWxzk+mxPaf9nsXkycpkHKV5o6cRndPaupmkrbbmui/W9Piz6Nq
         0sVQiw45bx3T+utKq/lY6VoAbIRA7BF0vZVFtDA1NBIQ1uv/e9v39vmyfJvLfUcUk1ty
         u9V3xpLgqqT/XaxjpyoE2B8JmoraufU1Q1pKJoRCT7WVfrofOiO9NipkJmh4L+MCSh6S
         s0V+A+n/8rMG1H+CM4JP9ewuLdxde65rChyu57guRrvfUTGOkRNdjFfLnyzUhsrU/6/y
         bhIkFsz9lUgrBy5bvnpNqEbhq9NRQhn57XM0DCCFHakYXw0VTM0onWY9GxCbjwL9/rFo
         IcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788728428; x=1789333228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NBPrvAIfRn7J77pp19LwaB//tzyaLAORi7qkoXMKdVU=;
        b=I47otbTkKFbcv5etn1FSYvbgVbJY8dp77MikxWpeCCcBSYER1KQysnZJQknABSzi+t
         WKwGRKW9yqpaU9bLki15DsNQtkdzaQTcP9ejcIqhAvxNn/uGGL9RWLl6gV898KvKBYW5
         1lMEKA/NK9q00T+5tIgZjEjDdgKlRh5WJ4MjKnVkFtXvjU4BScFbFzzHzyhqjSx81VIw
         nvPzp2hUjPgzKC8crvyX8P6o/BFewTgtd36nXlqWFNtvBgK03ULKwNF0oEDqUcSLORat
         FwW0jBIAj6m3d0BzOq+zHsQOytekNpNsG+FHDZtY/BJPl9wS+Idhs0u7udcfFtxmE2b4
         7qDg==
X-Forwarded-Encrypted: i=1; AKwUvBzajIZ5v3ggAEpzfSo2TrshYD/9TpxTngB4JT6V2rw3c4kKOADkdDNEHZovjnmlPNHFD/Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lDoEVSnkpa0SJRHdoyKuBUsBYufT5n0jxti2ZiQZJnc4HPDYNg
	9chfciNtV0LhSVJ/wZPtfKvh2kFh9KYMWsHRlL/ufrTpWo2gxj730LCF15TaR9h5km5y0tpOUhB
	lPWpPvBoP7+soTBaeYIasNxAIFJBSVX4=
X-Gm-Gg: AYBFou1FVPNo6iEsTMkhJemxbnnk83UD/Nh7vxiuNXgMhV++QsaNGJunvL8NGKfph2q
	er3uj87ueiA8ixquEHOMiVS9++xfxW+Uws2w8g6Ni6HqC+dNV1oMmhlRL4UhIAokNhcF0l1vAMi
	CkH39OCZWuRy6TkjrD467GNgzJ+S9NM1qTzA2baLU7N/VTkRg8tOfS/FDp6XJeti6asEToLxdnN
	cocG/2eGccu4kVdQVGoMWWJrLcTRXTrlUv5pGrGr5lXCEia5vwyY7TKyB+eutPvZ59ddEtyWvYj
	9qW95JolGmsx13jtGB7Sr7GO0/tM8Wq67NcKjVIcagpsRoMQOktIf619CnfPChEcxvoPZ6m4jZV
	vtyg9H3CriiH6cJROeD7xXkUWjr2Q
X-Received: by 2002:a05:6a00:2d0c:b0:851:c2a6:172f with SMTP id
 d2e1a72fcca58-86169e749aemr23088612b3a.7.1788728428193; Sun, 06 Sep 2026
 14:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905095649.42351-1-kmehltretter@gmail.com>
In-Reply-To: <20260905095649.42351-1-kmehltretter@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 6 Sep 2026 14:00:16 -0700
X-Gm-Features: AcwNN1W0leQx7aOqOpgYlMw6jEVxRWE7KhwONL2bRxF0V7A_0KXDBokfekOTW-0
Message-ID: <CAADnVQL8xH+zpZEfRX4oi+gTWJeNVE+bQk6tGZQny2o10k+-3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: Fix the struct btf_var name in btf.rst
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 2:57=E2=80=AFAM Karl Mehltretter <kmehltretter@gmail=
.com> wrote:
>
> struct btf_variable does not exist; the name is struct btf_var.
>
> Use it.
>
> Fixes: f063c889c945 ("bpf: add specification for BTF Var and DataSec kind=
s")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Pls combine all typo fixes in one patch.

pw-bot: cr
