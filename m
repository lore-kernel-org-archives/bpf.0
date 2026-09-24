Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B24C8C5A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790293206; cv=none; b=HTgloftxGfQv4OsPoW6y7xRnI537ld2XTzSmqP+0PGHLwA6NOpZ0tsS2bwIQVhq2UUergUDMbiuJK3WzjCVGNzV/hslacJyyy9Pv903abGW0M+VvIBwVBFZBt7xH/1kFTa6U8uZ/xfFL5W01NNn1fXMCJ4Jr429QMUuUKOiEEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790293206; c=relaxed/simple;
	bh=4h4cpDObZqi2JEPN69eOCH4YBG2slYUeYHjBIAENU48=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=oZ2W8gwYU4JSWesAgNW+foxNpmKs58gJvZ0xANX0ygqtwMLFAV/l80Mv592g3fpq/0cydnbTFRoFkWlfkXFzB7mqbR3cxX72lgZsm2El8GlF1cYrUIIy+Q5NNXphRvd1n/9pwQqfsE6mAeqYW3H3vDurezBCpUSXBVog9ZmXM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGFYs1jG; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGFYs1jG"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca069c8so1214635ad.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790293204; x=1790898004; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gn5dD1CJfoor6GODqvLgahaKF8S1PUZ5xI0XuIL5LIc=;
        b=ZGFYs1jG/Xr4uwPy2133K5sF0poGH1omJ0ns5UwD8enApwiJPDDFi1gLMSA+UY+qrO
         6lyZmvL2zJXgrS4urBwMTV3vFSBosNfxEeAHC2L0cHJkMBE9Oj9QKSvAuXGCWTgwH0c7
         yWYOAFlZXJt9BDXnhQUwZElM3+pKqDf9ymR/77Qjhm4q2k9A8H7TmnWzDJf4Vw1zQ8Vz
         HgO06YL+sF+7Efo+udo1jYXz4T5XB+sMNcQcYJJG3eDGSkCa/UybsOWnOQ+yWqiUaJ9C
         yc+2TaftdirQziHgwjLgiQLYNZ+cgLnH7mjbZhOQnbR+1/zQ5qgml8qc2Dm7Da1OEro+
         myTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790293204; x=1790898004;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gn5dD1CJfoor6GODqvLgahaKF8S1PUZ5xI0XuIL5LIc=;
        b=FOnyMrCmiY3SxnCCPFsSb0eLFUlu//ScOtFs7FsA/mZf9T90wK/ybTh7eCx13urgx5
         1M3IxhT6pt+8Tz8FOeS/Zv5BajR7GJlXvxKkAnzxry3LUjpEHgy+xsp9rczEkeP/qRai
         F4DkB5HCBfL5rLIWAF/giT8M2mlQqEDWhckJpHxUgI7LKeAarVXIWwlb1Yw+Y4yZmOqa
         5WhltlMIp+P12cxToGCC3civYyPRDEtwdzhDUXWddYF0gCxjB/XpMPlIy5kD65mn29/V
         5cinKMWnEcjhmH/PNSLwOii41ldH38/XiGxXUTXCYk1wnCBb2pW8kUfODB+fAR+fQOKP
         nCBA==
X-Forwarded-Encrypted: i=1; AKwUvBxofyxkpdhSfAyojvISrZ24dp9tPi9zeP7fy+w9yqIMutmKNFNbFuhLlJNxmxh1jrMC3jc=@vger.kernel.org
X-Gm-Message-State: AFuF++lHNM/xvNdP2kJokcSfy01OBYo0L4oMTTfvZm9jteCgsv+WebX/
	9oD5/nxi0s85AY6eb6WFX5lhaXIm+9qG4GpVg5PaAlzCLcSUYBPYbAOU
X-Gm-Gg: AYBFou3I3HgJoovoYsxGqnJBjtVaiDr6KoUBIs9dBQ+gHsaJd1DbXnQLsasr4EF6S4z
	JHuD4Q6SbO1PNPVqiyJcaohKJNauVTDFcOS3Aj+ix7LioQPBnA/hc9p5RXKQFFHOsio6IQPCetd
	2FAmx1N2hhYkp/slwT/cZMKSNUQBIkuq4kwBw2QDHiWWMYyqQn6B0E8jpgPVMVane3YWq3rXjou
	TzRTZP3dh2dZA0HcCJvyHlxksftei+CdSRdwhJZTpvZgqMK1/XtHA28k/WB0cImcKjKu08F4/XS
	KUOjej23in3jPpYAwHadCaWR0aaChYVelnGSwWlJa4ds+bIY+gHxDL0SFfjK5S1shu4Kpenpr1S
	D836g1fPAAZIlYx+k8ga1oyQcYzgqDCz/l2M3tsJtg4S47jqIqIgPdyPDwgPy/Iw5/MTj/MOXO5
	bp21Z6h3PTOEIvjm3YSUMPl/aekxhAwcMK+sATroghyKo3js9TeePppZwLSY5LhdR6/3AdIKKf1
	j8/9KhvUU5zBMsVH40ugc2QYKJwI4GsbHNxmiPcDaHbyXAxFw5DqG9yEYNeeBY1xUr8lG6gCciw
	PXw=
X-Received: by 2002:a17:90b:1648:b0:39e:6c69:34d8 with SMTP id 98e67ed59e1d1-3a098fc574cmr3554656a91.60.1790293203799;
        Thu, 24 Sep 2026 16:40:03 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efaeb3sm909723a91.2.2026.09.24.16.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 16:40:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 23:40:01 +0000
Message-Id: <DLNXZ2WK7TPD.2RZBUNRS4FA4L@gmail.com>
Cc: "Leon Hwang" <leon.hwang@linux.dev>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Josh Poimboeuf" <jpoimboe@kernel.org>,
 <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
 <llvm@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <bpf@vger.kernel.org>, <linux-efi@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Ben Cressey" <ben@cressey.dev>, "Florent
 Revest (Anthropic)" <florent.revest@linux.dev>
Subject: Re: [PATCH v2 6/9] arm64: cfi: Use
 CONFIG_ARM64_FUNCTION_PREFIX_NOPS for the type hash offset
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nsc@kernel.org>, "Nick Desaulniers"
 <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Sami Tolvanen" <samitolvanen@google.com>, "Kees
 Cook" <kees@kernel.org>
In-Reply-To: <20260924-b4-arm64-callops-kcfi-v2-6-587865b6d991@linux.dev>
References: <20260924-b4-arm64-callops-kcfi-v2-0-587865b6d991@linux.dev> <20260924-b4-arm64-callops-kcfi-v2-6-587865b6d991@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 10:35 PM Jose Fernandez (Anthropic) <jose.fernandez@linux.dev> wrote:
>  static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
>  {
> -	if (IS_ENABLED(CONFIG_CFI))
> -		emit_u32_data(hash, ctx);
> +	if (!IS_ENABLED(CONFIG_CFI))
> +		return;
> +
> +	emit_u32_data(hash, ctx);
> +	for (int i = 0; i < CONFIG_ARM64_FUNCTION_PREFIX_NOPS; i++)
> +		emit(A64_NOP, ctx);
>  }

For the series:
Acked-by: Alexei Starovoitov <ast@kernel.org>

unrelated minor issue:
ctx.offset[] is counted from ro_image, but bpf_prog_fill_jited_linfo()
adds it to prog->bpf_func which is ro_image + cfi_get_offset().
So with CFI jited_line_info is already off by one insn.
After this patch it will be off by 4 or 6.
s390 does
	jit.addrs[i] -= cfi_get_offset();
before the call.
Would be great to send a follow up eventually.

