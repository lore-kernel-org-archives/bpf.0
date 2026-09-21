Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8A4E323D
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010338; cv=none; b=fgWqgWYBzu9rIYWjMfXkWnw8L9Ybw/93nVdja+JxneRSzuqxBR7o7B7hSK00go6RZwQ6IgbnMH2t3QY97oD4AaoybRlVJG4/WjDaERePtZ0NMwI8fKup8lWkUdbKCHjZOMwDuOKc6M9IREDUv6r8aTxnCVASZRMjgnPaLFskapE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010338; c=relaxed/simple;
	bh=sxrqKSwS1aorwF9WJCKcZM9J2sb1lpvGqut3ne1KxxE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=djBONKQOOJSI0zSNXeuceiypG0O/IcZZzUsvmgL3Na0TpPlMnZwi76yiCzQ+Q9HKQZj+VVJfre5z8W04ZQILYR0tcTZhYpF9HUEIawXjYpx79r1tNPcFwGWKr/lYGnY9cbn7RDrQpkfi9kFCIwnExLsEzSjisZUVBg49yfYYkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e01Bk0ye; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e01Bk0ye"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso3544797a91.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790010336; x=1790615136; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hcS6tmFExHZcf0In9X6bDYXLCnLsTisUwJksVN/pUS4=;
        b=e01Bk0yez5VZ5jUF8jiqRrY251Qq/kSTJdfERazEX42BnRIDkYDNZ/C8j0HhleNTcU
         /f3E9VshD1wnSAyE9lPLaJnK/Vx1kVSHZatw+BpyspWm6SJxo/CRgrB0v2uProIj/hyr
         zZHDX2UNup5jUQqIpXz1sp7o2UV7Ta97oUy45gdn1PcZ1iguDHPFEM/OihLooBPqFDhM
         WEl+3uQoILBNuUDEJAhRnXxRg2INZ/9tiMkkXeGXfXNL8AlwM3jVSvh5Kf9t4HStwz7y
         gTuY2fVluSfv7ekX5Vj7C13kfns36bFVOBlu1c+GxWyhnbvB8WUQsrSE0ply5+1VCuAz
         +nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010336; x=1790615136;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hcS6tmFExHZcf0In9X6bDYXLCnLsTisUwJksVN/pUS4=;
        b=aViBmq+QbPRUImjI+Jdosg8E6WOaD4Y8D9nMbPzwFgbaiPVdYByBoCVY2UZ40GooTV
         fVkiwFMsxEqRpD8kKMNFKn65+yJYXfQn8IXwsu9yvjXM56nEPj32ZH3u2h96cNG0Dbt/
         XA1R74Kk4Pvk/j3OYhV/1dxxdCALMh/SGU9TR/1geWC9LZACyC/aZ+YWVxnQ22dhXh9l
         WdO99T+aEufjM7IfpOltFwd4unAig/oHD4oX8XYsCcmg9eVBIJWM1qSuXHpuqp87tobw
         +1P32fku3tazMHmWgcomp9hib+x8ZomLMg3vYjFM5ejCzmxye3STrGKqGfUm4ylyRQvI
         t5FQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4X+MKM9dG4IdROneDNPhbpC0Ei/o5JG0OzP377YGjpmZuHWkdml3MHkJLQPRFNg3gPGY=@vger.kernel.org
X-Gm-Message-State: AFuF++kQ/kqvegKXZqzzs3B0ekiTUj8m3gixnuJbAqW1CPwq1wciPJXM
	LnHYXd+sAC+y+0ybxXhz5VXLH1S1Lqgu5GLskzjle2VAwXWSPomjVbXP
X-Gm-Gg: AYBFou0uJWkPqzX8EkyaiHBZGIDsJczlCzyPV8R+RlauOcLb2y18w8+fuJUbPXfqEW5
	CMQgomscjxve81YlBk6bcrmy7fsAfEz6eBmMADj6nxmdq9irz1TREhGehdHIhbb4v1G6cW4y6Yw
	R1LWEWedaXlPHVm8dsqmCX2gtMjfxPQrU0weHuhhGU+mk36uFtwb4j+kqd7frxz/y2e+lhUZ7Jz
	K8x7Ef1EJtkxWjMgT2bb/KiopkFChfddOW5Th0TCGgCXaR0NfkszTACSQbV6Mj4Vh7tVRJ/qJd5
	Y/1Erl26VboWyyVQeBGrw+A7jEOpIux+oMpKZGZxcKJACPueL/vrnY70mZzPpcLotjnyRsMRjHf
	5ajRxAuTwPG4d6LUbj7/DKZYt1QU3+SaRGFdFR7JsjcWI+rzwTvhCJyOXe78VoCm/TF4XvMsGTZ
	ZHz8bgWE22PAC4Xjqsk92xIkvsWDpZBt6ilX8+kBQX4rvJgc4elrh/CY/1CNWrqn8dYeSrE3LCb
	s03s685XHpgtl39kOYZQDu0ZEIgEDfYupUZ5tRvtb+STV+TpWLQh6NKP9pwOjjfTnhzpfSZpdUC
	YWwMfiI4U1f1qMo=
X-Received: by 2002:a17:90a:3f10:b0:39e:5cd8:2140 with SMTP id 98e67ed59e1d1-39e5cd825f0mr9887668a91.20.1790010335748;
        Mon, 21 Sep 2026 10:05:35 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0673b64f5sm189723a91.5.2026.09.21.10.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 10:05:35 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 17:05:34 +0000
Message-Id: <DLL5PFJLT64M.1W82K71YXNT3A@gmail.com>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: add diagnostics for rejected memory and map
 accesses
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>
In-Reply-To: <20260921154650.130677-1-suchitkarunakaran@gmail.com>
References: <20260921154650.130677-1-suchitkarunakaran@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 09:16 PM Suchit Karunakaran <suchitkarunakaran@gmail.com> wrote:
>  					verbose(env, "sign extending loads from arena are not supported yet\n");
> +					bpf_diag_policy(
> +						env, i + delta, "sign-extending arena load",
> +						"the current JIT does not support this load instruction for arena memory",
> +						"Use a kernel and architecture with JIT support for this arena load.");

Did you read what AI generated for you?
"Use a kernel and architecture with JIT support for this arena load."
?!?!

Please apply human filter to every single line of "your" patches.

pw-bot: cr
