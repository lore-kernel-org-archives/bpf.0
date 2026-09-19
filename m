Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F631B83B
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 04:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789793834; cv=none; b=tt0s+g1v/eHbe+XmlVr6InsahbsoUskSS240mirSTe8dqD2baO5QKbPiZQvirpkU/r85APyBdcI+P9RjPsA1wtsZI8HQHk3v7li5O8EOgVV2cvpQ4sWALQtXnprc2ZppT5aYZH7KEsTP6SUt5pec7Pf4OTruHKeWf6IETS3Y+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789793834; c=relaxed/simple;
	bh=Bm9T7VsbpN4kAeOh6i+m2XK8iqNQI+ZnFx7v2vTBHlw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=jJbOJJwkJGPw4SmA4cQzVGNQ5/jcO6MVNOZ/IMTfbnjKwakJOt7NnfEjpXUdM8rwTuOnSer6iRhhG+9caWcLdkBpGRmBJAmQCR79zRD3vJCsZ/q1fU5tAurbw6dBOsMgtEQRF5DMg5tDhhnVc9TlPBwwstNVk58y5ruoqTwbOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WClvpW2q; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WClvpW2q"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so1023971a91.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 21:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789793832; x=1790398632; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+yPadxEEa48XwAs6qga1q8XePDfActjosPWpavIz+SI=;
        b=WClvpW2qxYxtQBywpyIGoj+NhAx4Px9BkM//9htUAK7lfwy+WjsvBFiLwq43uaXbzd
         WDyl+SM9JS+S0hTKYhRQLON0uS+sWhW7WcibsQ5y9YBfjcICGr9PB88iGApPKe0synQr
         72uhtZewjX6naf/Bn/F1LDNZmoSkyKmJEDpebUlq9tjfhpdghGDCb6nCbHivDLpV/5F1
         Mw7U3pFrqaMO5CLLjnWnf1tVcOW0SK8Z73o7GLZzlB1OOZkhTFpZiF0aC4pWKlICpVQW
         UKb9rOxsZClmuluytiw4inRvkO6K0Ses6vVjuKiuOOTeYpbCCLZLl93h1HUjhaazzSS+
         6wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789793832; x=1790398632;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+yPadxEEa48XwAs6qga1q8XePDfActjosPWpavIz+SI=;
        b=wMq6fJdAVyZYDgy7Y9HG9K+ifUCijlBwQVg+1zo+VNsbiEIDbQoFFuO/t+CwLkVjLb
         5TebowvDKXe3Mn4Wl9kN/AcVc6c1MBgZZE6xciSXHJAcNFakU+NJ7sU0r0aMkuKuur1d
         GYGIY4I/UIX5rnEDv5nA67s3EJDVUgkuseVhDIrG5duUrPvbw9rdqmWjsd5GcyruGZms
         BLK2gOmSewIJZlQbs0Hk2M9Vwihz7P2OR0ScdF6B1wpesQiSdnO8ekqHV/yybBiWBT0o
         P8zlHsMPbkDuHMOZrL0SxIDMoNzgGjZpct2MXF0w69K+0C/p8B4S4oDiqUeqZ42pxR+3
         YE2g==
X-Forwarded-Encrypted: i=1; AKwUvByuvjiMIy3BiphlFkLjuuf2L5H48NiTsFohq/PapK0jJboCgUn9y1228CykIttC9PtyXrI=@vger.kernel.org
X-Gm-Message-State: AFuF++l6hJjrJL5T3M5sLCjfdkCExw7wWJFUvtO4cBiRPT/dMfeS6mQK
	uTU8N4G+n1MRbNEDW4rSLF5drfcfvdMh93ooxrCQcB+ulwSSdhL7eflj
X-Gm-Gg: AYBFou3e+Tb4qFzWfoPWd/6Doqm/Q7dtfvYd/rTI1wv/XUKKQkfAR308L5eIz6JAP9H
	XpeKQJr37HIPPsrJKJZHH0UU7pEn+TyAO+Y5z+Wd2jLkf2JjZkTtyWzpdCHV/OnC4+y6t+8L8eZ
	X2XWJbG2dvEPOw2l1dhwYp0b5StquzzukOGC344GmRYwtApsQfz2E09c5PDbYkmVySI2E/LDpSB
	wpKu+SXD7B14sA6llnJS90ZcWEGoYUs0yUr/4EJXXmhdwFCB9100IIEYMsvn61nVAYf+CvvXEl9
	YNmSXwbK+weLQQ1fc4tMTxEHH9JqkMuVEojNoYMLUrZZUTum10gVtXrDGhwsKncQiv2jOg2WvCU
	+qsvhXp/0RqT8ukZB0Ce1h77zNOGPctpurHtu9hijum1Jk9QxLcRpp+TONSD9zdYVsm9PNC7lK9
	nrKYvHyz0AGLJOw+SnMzysBTVYV3Yy/tKS+Dm51RHOzc6jQkRn2gXSpUr3XHrzuPq98ggW9YhlM
	8coUM1qpOpibMbmqmJM71mQtmBQ+RPA+18vY3YtSQYii4aGpueYzejUkXIAIcfYqyCIU5lAI8BW
	N8E=
X-Received: by 2002:a17:90b:5305:b0:39e:4c81:6c64 with SMTP id 98e67ed59e1d1-39e54dbeb52mr8417807a91.31.1789793832278;
        Fri, 18 Sep 2026 21:57:12 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca86d83sm2410562a91.6.2026.09.18.21.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 21:57:11 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 04:57:10 +0000
Message-Id: <DLJ0YN08I6GZ.324HCC3XBJ738@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 07/20] bpf: Refuse exception cleanup shapes
 bpf_throw() cannot dispatch
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20260917055721.3930090-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev> <20260917055721.3930090-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 16, 2026 at 10:57 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index dfe9c2a9ce7d..b2bf831242b8 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c

[...]

> +static enum cleanup_insn_kind cleanup_classify(struct bpf_verifier_env *env, u32 i,
> +					       int *next, int *target)
> +{
> +	struct bpf_insn *insn = &env->prog->insnsi[i];
> +	u8 class = BPF_CLASS(insn->code);
> +
> +	*next = i + 1;
> +	*target = -1;
> +
> +	if (insn->code == (BPF_LD | BPF_IMM | BPF_DW)) {
> +		*next = i + 2;
> +		return CLEANUP_INSN_PLAIN;
> +	}
> +	if (class != BPF_JMP && class != BPF_JMP32)
> +		return CLEANUP_INSN_PLAIN;

robot voice:

LD_ABS/LD_IND is not plain. bpf_check_cfg() treats it as an abnormal
return and gen_ld_abs() later patches in a real "r0 = 0; exit" for the
failed load. With this classification a pad in a tc prog that keeps
skb in r6 and does an ld_abs passes t
he "reaches no exit" check,
cleanup_check_pad_insn() doesn't look at it, and check_ld_abs() only
wants no locks/refs held at that point. At run time a failed load runs
the subprog epilogue on the walker's stack: callee regs get popped
from arch_bpf_run_cleanup_pad()'s frame, leave/ret with rbp == the
unwinding frame goes straight back into the BPF caller with garbage
in rbx/r13-r15, and the rest of bpf_throw() is abandoned.
Treat it like BPF_EXIT here or refuse it in a pad body like tail call.
