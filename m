Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC679415F13
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809599; cv=pass; b=qPKSlO1cFmLfe/X15h58Xsq5xsWkogEQIvYBxXvX/sHlRNVJPwJteIGX4MrSoJbk1S0JoUel8EXlvtGbjXU/jNLBH4D5nloMydVBTmZ+TsQsWoBkeHjvzr3CK6pW8YSE8ZGmek+UYVa0edX8T/r+TJnaIW4+atTl8Q/7RsoNshs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809599; c=relaxed/simple;
	bh=LbkJYZrKBAOtEAIquwnyRiPsYzlue46mhX6agZEqU8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRiRLAUFsrqXaVS61oe4V0G9YvMaKDKLV/IICH8gf9pUuNme4Pp1grE+WyLXsDnrY04VhFNX96ijdbotwytFlEcPgdIjBLMb6NXGV9YHzRFqz+mBGxuaJLBqHQkiBikbwaQZ1Lr9i8vbmTTlK6UdqPzNN++zw/98dQEUOn15Ck8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK0qYj5j; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK0qYj5j"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8523cc41f41so150923b3a.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 12:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788809597; cv=none;
        d=google.com; s=arc-20260327;
        b=a6EzeXZiU3PoEKT6d30U5YuL4JsIEansgmsnNlyJQXnJ/FgJ+uR2iFf1GN2w8F8csq
         LCPvXS8FrUwpwHlFqwWeuYD0LTTJaeWF0NP4Q7iXePIgMjKoaIzZ/goAWArTMiKyG1xk
         XQaHJCJyKe/awijcN6PbQa33m0ehVucQsLex5HOuTJaWvxVr2UBoxnEKi2dCXKFBGcPP
         3ngbsnhD/H4nSd1jo4zqxqTaL6FcGXJ1xb/yK9MLChBKTYU/u3tMUmdYlI8FuyveEYcn
         FNV20323FuxsNEL08Ldi0F2SBGhuxpvAD2/HQyTGCRw3dGPOwxyJ2RhAgA0AuuEWgBm5
         /vQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LbkJYZrKBAOtEAIquwnyRiPsYzlue46mhX6agZEqU8A=;
        fh=L2AZQfJFnL/yW3C7LzGXveOr9IB6QcQYmi6+bAW4nFw=;
        b=eggYo26m1ycuo1mgHyn+pS4czXl6xgc+UhU6JQGSGr5VbFfcec8rXeQLrb7TefZ+96
         fWqunjuG9eJHyenuRDZfviWsBRzOu99hgmDYp3B7tFSN8qsn8yElxNfVk8CzVCy2UYxT
         /zcSafPjjZpaN3+T4uGisAj3F6Mu2IIyCfvacyoUuh+unAYp5ZzpXISmKoKUTAID3X4V
         wRK9TsRuX00dJi4hi4X/8yPGwm+uZ6v0fG/9wtzsXfohzWkTjDpa0BkClDYYM9zoYhjt
         n3cxrSgHHPyV5NYnwOxI4wt/QbzHiXQ2Th9MjpdV7m3iGhHcbusIKhxdwFPU8RAjxRQb
         6VIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788809597; x=1789414397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LbkJYZrKBAOtEAIquwnyRiPsYzlue46mhX6agZEqU8A=;
        b=iK0qYj5js7h9LqZ16ntFi4pR+coNw+J1DIsxddLy2bybdXua8s7AhsQh5PKG4aPy8k
         cWfcsot8Jd3QOFo9QOMLhxclr26W+2bFQXUQb/5htv9RCQ75k/nTYOvsiDpAh9ZC1h0P
         17HYrGhBkPAcaFKfVJDBRota6XZwJTFU94U1d0QKrv1bCLj5OM6vuETU3sDAU1WcF6/P
         XwKGZTES39HLJn7EPOvbTJ556I3rp76dCWF5AVgyuUSKXaJklfe1ypw/YLdAV2Pt4o8p
         oIt3UyGz4+F70fE+3rhKKK66OxHCacES0jUQHDbVEe3CfUFb1qgvkTLFywu8+KyEsrhR
         Wz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788809597; x=1789414397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbkJYZrKBAOtEAIquwnyRiPsYzlue46mhX6agZEqU8A=;
        b=HG7hl6vuaG9342BvFt1JvpFpnmY+CvMgl9B4SITBp08kI+0Lf8mEUaiPB0uUi+VfOa
         B3gFxxydvuLbWR4qlqWq4oGRKY07R9SnapN+/cr+g5BlZz3t89kQ62ZGtaAqaZTMvi6j
         NlCEKbCz/csPNc4OaGH44WdZVHQvbscV9mL2qxJvyhiyF53yWGx0alAeZoLTbYu+2boA
         TOasQxPsFAI1ecg9zvTMQ+kmgw2p5wOQucEIByY2a5LRJCrajtgWX69+qcz9SXKk9QB2
         Ul78LV45WQZgGYCdfYWr1EuYcYzkh6BC/m2EcoLZ5vSIE4fxe/zMrywTsWETWsd0S5ax
         brXQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/WbfKIUTQlX6lC7cBq3gFBVOtydrsaW66kbnMLUd6IRZ7tLkVMAdSpllhJ/69PShdITE=@vger.kernel.org
X-Gm-Message-State: AFuF++mOSQMp+bCjs2WoNQUlJXi4J9lcN70Q+3JDnQamYhn7Vbmun5/A
	7P8MKkN3kn1wyVb15LgcibfvDCL1Uy7NCN0HtMojJwHRA4o2+0VkLcqMwh54v1pEhuc4RIuZmXg
	jNuAA405T4t3urNVzVf0dMT+3R4qMkoo=
X-Gm-Gg: AYBFou1R/QQ3kBqCeVQY4y4w3H5FRLdJjVuIsNCkISxDuvbk0mGkNrjMondr3D+uXQ6
	AiCau5QlylsjW0tiscTcRb6xrY2mLNXMIAiTjLReyJ7vKx7ArpGx9jK2T6VtKdl/dLIHbzYVRyo
	fpW14BY9u/gy0OLQoYong85R+fk1MVEchFlEr4S6Dp7Rfc5IhYIP2cUPgQ2lXkZN7P9X/zUCxzY
	qMVp6rX4ifNh6rMehaCli8IsKtQmrwjnlC5H7JUcoQSUXu1Og5M7AcrHcAluKc04CqNvTGjklx7
	wsK/lb9gjoyU1nS2Nd6jVSEeMnCIHpsiJVntn/0vq5ge/HMZHZIPj/z+TqZjKKLMOY8svRSzLn0
	Tyb8aYYyw8gPBpdk6SzU75Z4EEPAtOjVqYm9cvOooFGV/6Rj7OjKkUiclZ7evzw==
X-Received: by 2002:a17:90b:1e04:b0:396:463e:2eeb with SMTP id
 98e67ed59e1d1-39b264b24e2mr23088437a91.0.1788809597288; Mon, 07 Sep 2026
 12:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev>
 <20260904-b4-arm64-callops-kcfi-v1-8-ce6687739b0c@linux.dev>
 <CANiq72=xOrSXBBdmrKYfX1=qgF37LRAMzMJd4GJkXaYHMVe9yQ@mail.gmail.com> <ap3Z-YDtzmdtMiMk@linux.dev>
In-Reply-To: <ap3Z-YDtzmdtMiMk@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 7 Sep 2026 21:33:03 +0200
X-Gm-Features: AcwNN1UJ5AD1nmjaRgagxZvj3fkfuD3Z7c-j0Zc231NENpcPq2HjO9j40kxIvNk
Message-ID: <CANiq72mVXNmqh-RdOunFLBKRwMgYHFBqJOP7NbXrd8WHPb3sAw@mail.gmail.com>
Subject: Re: [PATCH RFC 8/8] arm64: ftrace: Allow CALL_OPS on kCFI kernels
 built with Rust
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	Leon Hwang <leon.hwang@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Ben Cressey <ben@cressey.dev>, "Florent Revest (Anthropic)" <florent.revest@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 11:24=E2=80=AFPM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> # Do not pass -fpatchable-function-entry to bindgen: its libclang may not
> # support the section argument (Clang >=3D 21), and parsing does not need=
 it.

Thanks! Hmm... Not sure if "parsing" is the right word, i.e. a flag
change could still make `bindgen` parse and generate code fine but not
match the ABI of the C compiler.

i.e. I guess I would have expected something like "...: its libclang
may not support the section argument (Clang >=3D 21) and the removal of
the flag does not change the ABI" or similar.

Cheers,
Miguel
