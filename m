Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795653870;
	b=nFx2Ki2rd10hDfLSk6grgsXdRHfshHsU0eq1mgEVjeZIE8vQG3BEy2KbwJJTRRBQcHJF
	 cFfs2uXkGzEG1KbXL4DKl6FEFn/VB3IvG95H5bL9497yh3V23vKObnCljheUvaxMJHMm9
	 znFsR/kMEC0D3nT+kKOpKYCVA6DSJRCYb9IC8S4dSUtCv0gDsYG9jUjCOXT7G48qGDztz
	 js9w3RpUBU1u/0DOrOBR2Ro3nXdqi+j9B9dDlKoL/zKty89v5npX6NRrujAElyHZlBT2y
	 SZiXVaZ3pvZgDN3J6QfdFUeJka2X1+3wROS+XF1F/MeA+Vl64XGqOarpsCuldvrjOjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795653870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iVFnQD3imnTlv+9jxnHkNU96izoDIFXplUev078ijIQ=;
	b=DokpW6mmTt+z3eq8FCQpOwrVpVwRiehh5CT+gMRtMm4Or1VljXMB+zi+XM2Bl9V/WiJF
	 0nwfzb1SHyFPXPatYyt11hVppRyqXSXxdKGt3A84IX/Xd5iQhK8CY/C+Hs6VIfA+jnA06
	 HwugTZwjs4y49KKN0RkMB4U0wi/uY/jixWSJrzxNN+7wT1NeFppqrP2MW9SjsBuXsXAEz
	 mAUFg/NjXhGvlFA7zx4SlvFHZmO5pURlt8GW7zTBv92ocjHt0Ewwi0fFoxMC9PV2hOF1j
	 JBem6Gu8x2a1A+xXOUyziWykJzhq8Fmlaa07Qk2xjcC4leCmgW2NlCNzV5LljfUIytQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TFVWM1nN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8CC606A329
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 00:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A8CC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TFVWM1nN
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c516a192844so630993766b.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:44:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795653869; cv=none;
        d=google.com; s=arc-20260327;
        b=e4rktBdVKTBII3iRikRuTS9mdQNVSASBLl9jSt+sxPP8R0z1cWCDtPw2iJxWvYuPLn
         onZOyLbcebCfw4u/hPn5gLE8NfxOnXP0dP3JV7YBqL99XE5Pcb5b7iEe2i/8bj32IIJB
         XTEudoRqFJmJBmpKMB+aN1VWv9oG5VMVOQ+InFoKEGxtvSsvWeq8+vv5crv0Fj3oEICN
         ICRsDOQsXTgkE0w9DUvYjiU48eTNHz3m20QuQ1y/JaS5SGY+AUNjQAAw94BgxTDHnVfC
         ZV/karbBQCSVnpTOwFr8mSXPDs0mSucI5AOm/juvvvdzIvYMcjp8R5ZzHN6HYx5uYMN1
         5ymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iVFnQD3imnTlv+9jxnHkNU96izoDIFXplUev078ijIQ=;
        fh=AwSFvObD5MGUTLIhZ3S6C/8GT2D6o1E+wS8zcl6Q1IA=;
        b=Xt3XAcrsvB9mE59GlthSn04q5iAoinO85Q7zpaVPXovZRwHQHuRRU6MblVR8KaKgr9
         pWeT2CbAZ6SyzMCF+moYH06FLcawIBzRwM6oD4gG4gDgwZx/0WBBt/VpkviTkAu8IMvd
         L96iIz46z5pIOmxdg75QMOFYSshuSUrRtA7bpEy2dx+EtVkv1nlZUEW7RBNWYlz/mqMG
         lFYFHGiGgk2tkx4WhKihbDYr9stZQVUh/o21nhEgQB48DwIGs5wGuOU+ShwrR4khtJ9j
         btLnaPqFl4GQSJjZs0YQgWiWUQwo5PBXAMY52/Uytyei/+DyyhQfwrdEafD1fSa99MI5
         UXqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795653869; x=1796258669; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iVFnQD3imnTlv+9jxnHkNU96izoDIFXplUev078ijIQ=;
        b=TFVWM1nNu5gApS+aRUNGAO2b47beOviKXKAUtZcibEAeTqBUzqYaxbl/Ez5VQvaHiJ
         TXrTwu8x0jRe4t5Qky6cuxp9+qXTOVpIHPYaRTuFvweUNvzRuyVro3GhlyImE69z5l6h
         8+10BUgXaVnSQdQJL56ogVd0eoghwHYtJzCo3zCbsQwT+vD3SGCXtB3FiXNUreuGXelJ
         f7VR1BO5S+hnTUr9vyAHKXMc2Z8rg1qIpqzDfb7vnBqg8zVirP17bCZUWs0HZkfhTJwL
         aGZZfKvpUl1Z4/v5oLfuk517qMaRDnLShKckyF1bvlHNxOJLhAHLt0pu9I70jGnqlzcF
         ZJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795653869; x=1796258669;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iVFnQD3imnTlv+9jxnHkNU96izoDIFXplUev078ijIQ=;
        b=R1fNtAaEz4tZDrB+V3XdZWG5NZO7ph/NIifsR5Sc7pLDqhMAQX39TXguFtUMV2Z+6F
         GKiqWn7dItFYWOFIx7kIUzNnCF/cVc1KkWs8dvzF4lSNXUK3CQr+W0DXJr1rMFeTSXlR
         Lo2qtyqCkAI4ykqciNVyB4M/wh8M+KpVItQnSfbCIQFDmjHd1dSA/i4aTNv2aNxSxjXE
         HuP7hnRFjpoP9d621XQtyYlP3obegc+MeZtNbyuf6jSrdY99VAvYxZsdNXXbadGZBldA
         tELG6cDpmDK/JbIMA+j0f9hk4x6RrrIHp44gnld97hPljp8S/gCVcadBbWz3tf7ribht
         tvUw==
X-Forwarded-Encrypted: i=1; AL+hErEv50Dwt/XDDX9bP/RxGG321bnYOjQkkb+jLQ1rCUun0P5hmjYvLsYse4XIqnXuSZ/XM4M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8tUTxadSPnALFEkacjgEekb6mcEiaaiFZxfpASNopguSYx/Y0
	1noyQfvNpi+PTRnH2gAIvub6CEnWZ3OGPu9lmjULU+Es4dpXaTr00t8sajibUQOw6G8/m/iamXO
	DQLFo+xiPA+VEH3MHFR0Uuf9/s1v8HaSBTwSiaFk3
X-Gm-Gg: AZFdTZf2VkYTjteVxHmeGxafTRNPWHo4hZPgA0dKsvsxGSsEOpigQYTjZZj2zxBuPmn
	n8F0TSPjWQF9+rTc0MNY0oz2mvWiXeFATZpy8xkdUPblDiLz+qjgynFReueW2KLwr+TsJAJFE6m
	3ywi8+UdF3G/5dTuCh/dEgCJbLz/4Gmzk7pMdKcYMAMVy7RmXEWO50k83OKOJIbPCOXdoIU8nWf
	gR7BwhK6djnZBzX/0GwRNo63bjjhztUx/JEkJ7VJVukL9fwDiPymEuJM/ITl9qdPZ/57MJEZJ5U
	2eX5/Cwb6ueEqsuw6iu6QEII/VcT+0r2sRblI/dSV0+bQL9tmFfARqVJktZ6Ph25Xl/zH5aNqQ9
	fCheyrYmuyp/d10vlosXVODcD5OjX6xhK2frjd6kgTo7R1ocap0pIBrfjz9idr7jFeYI=
X-Received: by 2002:a17:906:6412:b0:c51:24eb:e5ed with SMTP id
 a640c23a62f3a-c513aabb094mr1147878466b.42.1795653868573; Wed, 25 Nov 2026
 16:44:28 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-13-wusamuel@google.com> <CAEf4Bzb6LQmHHkvB8WBezU6YRtggycRvvA3L03mQHDr3WQM6mA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb6LQmHHkvB8WBezU6YRtggycRvvA3L03mQHDr3WQM6mA@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:44:16 -0800
X-Gm-Features: Aa3M54p3EatRpTsPAm_mcmxJ6hPDpQs1114Xl7F84nCmfTvZhGsQScuZoJFkxmI
Message-ID: <CAG2Kctr+6-EESkYn+Dspg0FxTOMFRoj8269UZaNNDFNf3d+bHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[...]

> > --- a/include/linux/kallsyms.h
> > +++ b/include/linux/kallsyms.h
> > @@ -24,6 +24,13 @@
> >  struct cred;
> >  struct module;
> >
> > +/* Exact or prefix name query, optionally in one module. */
> > +struct kallsyms_name_query {
> > +       const char *name;
> > +       size_t cmp_len;         /* bytes to compare; includes NUL if exact */
> > +       const char *modname;    /* NULL matches any module */
>
> will "vmlinux" match just vmlinux? or how can one express "I only need
> symbols from vmlinux image" with this?

At the ioctl layer (patch 3/9), passing "vmlinux" in query_module
restricts the search to vmlinux without calling
module_kallsyms_query_name(). I will clarify the comments in both
patches in v4.
