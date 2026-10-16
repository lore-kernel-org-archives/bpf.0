Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65A8287E
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110018; cv=none; b=FQAGF7MKsXFD67CWJxq5Z4jSM3kuUKtqBGWD6c+kz4hRsUlOZVB6x3MUp5NtvrWLvQldDPESfhmi5/uQ2QHEygBxFwztTFYaJ6IR125m6+I++d5tOnFRp7sqEBY+vzNvJU8YLAvRw5wpQtkqLT6R1PyUhH0QHtfGrBbCL0PgyFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110018; c=relaxed/simple;
	bh=qfQkaCmAtrF6fLptfvedEtqsxeWKnfeEPQN+//clhHw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=FVzjXd0qMB63T1MthgRsHF8Q5qAuNcMofQzxW/hSFgd/XpqJMRZxNqKrGV2u36STh+NPcJqRrXO1ZV7mPr0BrM+2LZjpOxMmnNTJv2HAE5pF/lMAGefKBEv67qmC7YUYn4VTmlqiba2Nlkpoa38rB2X+0ATJIHYWoc03QxPA/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWw+hCds; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWw+hCds"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-89f639ba307so83645b3a.3
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792110016; x=1792714816; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W0iK5P6eTmpc3TiP0RQIIzF7dztCJ14ZlhlTgdOQnDQ=;
        b=sWw+hCdsnguAVZwW7EcTxqJefweDbxsWIRvvUsYWYs8ymnfWoIY3sYMoFb9+sa12kE
         D2jYApb8n35fCTuEfAflvmn1uTTGVfDDXdZBMBKbSeNcvDAt1/xN3xnKJZAa8Lu/TLc3
         jkcTD2eCvuN9vfh0yg1Q4vOPwYMsHFPglHKclGUX44DQfKq0Orzl2/jt7nXdkhSIBB2N
         tmMZtNkbMt+LHAis/P57nz2JcOCcPHx2R8SemgyMC2tLW/rOgA2NfFo/mCCVxDREVUVJ
         ecXGJo1y2VbhRzf3PxLrykgQfRchdGCz/SlXE69HNjXpwfII7sYlqFXDgGRKEwk2IU93
         Dnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792110016; x=1792714816;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0iK5P6eTmpc3TiP0RQIIzF7dztCJ14ZlhlTgdOQnDQ=;
        b=tfgPzdeV0yYaQ9odrips2p19o7dMrI8MsAzCZCISJ1CbVmkiDDHNA3HqQ3fdcRDqsE
         UWSiKnBWuM2hOsKALN7WjaEr3t0a/60yVIcmpdyrJ/mK1oyKQr2XS46F8UFnKPMPlpAp
         nP2EZQ3S8gsu2oEKUmXuD/qgU0LX/eVK0PY1U3vZdgrDV3zodm5aOualxUp+2KPf4kHN
         pXl+X+zactkuKpK5ySqdsygdaDTl7cuOqGQ43o42kP3wEkpxAKta9Mim9M08hYCgWHjg
         K7WpQ0AT5awY1KjNgVYPGRpxK87y/QlNOgFmiQfFW6gnQuWBAu+7500TyPiFYD+NNywf
         /mwA==
X-Forwarded-Encrypted: i=1; AKwUvBxAtELWj0KDO7bcNP8A2Nby/IvgCPQWExURV59R7UXcUoHxbrWZiizscYI6JoV+Riv5fko=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6XODzY/m7i13h4jOKW3IjroCfBhd1xDlD2fcfz3EZnWW2owQ2
	BcnZ+N0yQe5N5glNKhj8nLQbutsFfws88rWPbIM6iMBw6bkTDo/g5hHuWYt2+w==
X-Gm-Gg: AYBFou0QxpEKxUyF/8rPCfkgk8aLLC6YGMR7Yh/xJBQRKgSiRobB9ogape0phTn635t
	JIz8lENTM0fhGe6//86lvDOL9khftUEwh7HZM4YfVcsxWdLIbW5SwaW+LZBH8QmMaVAONS/mh1w
	hlxDWGPjwvefDJu10Lnz2HG0ne6H4n/brYk7Stn7xvqNsa2N+b0VF3OUC7fjyR7T+oIZBWwSd2u
	gkByqkzVTEGiszzR4IgNriimAySHo2jPPcUI1SWGaeVQTPfbf+3HLExLP3xyQB0OF1n0QLJC7zu
	5yLfIKGM8/dSS04YSg7i2pf0RSs2hzcBtJFHdlFalLwdl6Le5SOq2wAlL/ptXVD00jOqVKuQXA4
	+2TAMlEX1+KCMzPefzhTsIa6+2LVeKjxtEs9ng8nglMD2nk+bK8RxrPhB2U/H7qU67Mai5tUYKp
	YKU5ghVJYn+9+nylFFT88gDa9n4Mb0Z4oj8AdglMpFjBdrB3fdE8mzzdgFa4ZWgKznYRnPmtGbS
	1q1f7wWMNqba5A1ZSnOjFRxFjKqCZdA0r3Yzut3RpFW3nBGaFGeJDVfeUcz8lOXnAZ6WRUTEjJt
	uiZQ
X-Received: by 2002:a05:6a00:893:b0:881:fffd:26af with SMTP id d2e1a72fcca58-897c78ddee0mr17844265b3a.44.1792110016137;
        Thu, 15 Oct 2026 17:20:16 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57452b16sm269840b3a.29.2026.10.15.17.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 17:20:15 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 00:20:14 +0000
Message-Id: <DM5TZB39B3HK.10G7EQ8CFNLJO@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Tejun Heo" <tj@kernel.org>, "David Vernet"
 <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf, x86: Support fetching AND/OR/XOR
 atomics in arena
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <20261014125017.1426212-2-puranjay@kernel.org>
References: <20261014125017.1426212-1-puranjay@kernel.org> <20261014125017.1426212-2-puranjay@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Oct 14, 2026 at 05:50 AM Puranjay Mohan <puranjay@kernel.org> wrote:
> @@ -2926,6 +2989,51 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  			fallthrough;
>  		case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
>  		case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
> +			if (is_atomic_fetch_op(insn)) {
[...]
> +				/*
> +				 * An access through a number has its address in
> +				 * BPF_REG_AX (see arena_scalar_access()), where the
> +				 * loop below has to save R0.
> +				 */
> +				if (dst_reg == BPF_REG_AX)
> +					return -EOPNOTSUPP;

Reiterating TJ's point differently

can it save R0 with push rax / pop rax in this case, like div/mod do ?
When src_reg is R0 the operand is on the stack: 'or r11, [rsp]'.

Every arena access in Rust is through a number, so after this patch
fetch_or() works in C and doesn't work in Rust.

It's not "as they did before" either.
The verifier used to say
"BPF_ATOMIC stores into R6 scalar is not allowed".
Now the verifier accepts the prog and the load fails with ENOTSUPP
and nothing in the log.

Pls fix and respin patche 1 and 2.

pw-bot: cr
