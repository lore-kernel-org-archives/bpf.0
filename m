Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CC483BD6
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524315; cv=pass; b=p7dcdylTrYUa+YHZYsOGBwPXYVsvn/ud7Jz98uk3zG0ygKqdq7/JcFwGDTg1N73sTWBUuhKuk3OZG7ISAutSON0tm4BDYGgkP+bNhLYJxtEMtAX1I6kTlbXtYI0DMMlqWaZRxT8TqL8lcFaxfr7YHxMcWwiAh8cvOKcqeGtouTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524315; c=relaxed/simple;
	bh=eO4W0pBpUA1VKwgA7pWUVcs1Sx0AhhcRANb40uA3yFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5YOkYBIuH79IJ80CrgrFuGrGG8TQFGTJXBdWKsOKbEvKMdps42DO+FyqiVP8sS3W11nAH4x+HwB5ssYgx2W5HilUdYI7FJ7K7QU5GanZ4tlaBo7pAz5rmN9ICh6EFlKGAn9etODHoLvHT0n1AEHZitVyIldjlxnDqas4MaMiSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMNauiri; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMNauiri"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398a29be161so122816a91.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 05:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788524313; cv=none;
        d=google.com; s=arc-20260327;
        b=UOCGN1sWrUwqI5itJtXVWhsPKyu8K89dEJSQpk7KsBRuilArcWt5rZ6w0DOYICwf7w
         eYJx2LZkW1vlFnMPkL4SjyzmnLNYLKcZarFgJiL4zxoDHkXNeJQ/9k9W7unsmaNdcugU
         zZRp+QwFgJqQhJL1d7df6xIQzFoofdnQRzkuYoMt5Lp5g73sjjTKvZS4Y89ClpCokcv8
         u1MN+fDL9ylpvxnYnNZy7a3DhedbKEjklOwvf6PNvTNZYHMObQzuRT62hsuk11BidnrW
         VPjCNRwx22PbhizCUFm0K5iZ/+nbrkrP1gH2DRKvuJ5UTwETDJNplkUjXJbi0UPv5wCn
         eBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eO4W0pBpUA1VKwgA7pWUVcs1Sx0AhhcRANb40uA3yFU=;
        fh=MlPrV1/m5HDWbOZHDPDUy2N8MRN6A6IGktcSAnnOl7k=;
        b=CWpo7HCVK/TaP+XCmR/9mJQlvX5iEk0b6/4WJdndeicpjk/XUoU0TIEbLXHzfuSoku
         aIS0bEtCn9rFDzxMyewxV7DPh/tXhQ/UQU+Uk8yYnADgtAOe9CYhy97xPJkp6pOViNYV
         gawPdz5uYtB3kefEMk8oluL8/LRdGJ2CfuLNqov+jZ4/s+tJx2vlPowoNFLIuhXAfPAw
         OiJYpRm1cSUM/tkHBZJHwnVRpjHa/8MStoFUU9zQ/ql+15fMg080U9xuBTbe13GEDhqH
         92CfoSJ/nIcMtJrpchkXkxHd00edUPUFroZeE/7vkvxvM7mtEnTiwvDlRn02vFawZCtQ
         qxaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788524313; x=1789129113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eO4W0pBpUA1VKwgA7pWUVcs1Sx0AhhcRANb40uA3yFU=;
        b=WMNauiripi6Md2Q3C3KkcuWrocOGGRafMxbYDlATW6HV68aOBusr3FL4eXVoF4vhsX
         DO7Jgfmeno5zhnwRWIgfHvrvUM+3XTG/xFulQb6uxqGbEytQPlf+GGxxMKD983IfwasK
         JZ8dP4XrZbEY8oiEzvYHXjbMf5wbZHBRAbESh+IxlSqcdT149S3ok0u273lxbuoHsZB5
         x3PySqQZGNcJbPkCUFb2OKLEFffWYo+K3UUed1DYlevwTlbFIAr1+u029uYrVRygQ4ml
         OkrtFQlxk0wYKPBPPf39rZeJx4CxE/88YUpd0GyCLyKaJbRs/qop3EUiAQiviishSpQw
         WkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524313; x=1789129113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eO4W0pBpUA1VKwgA7pWUVcs1Sx0AhhcRANb40uA3yFU=;
        b=YG5fQo4ofVO7YuYBsqg2j0c350tYnAIOJMqW514z2GBI5oA60ugaKGKLII8AF1ggQY
         tqu2SeR42428OMMdhQC3SUqBuiBd7nhIqromHrMGwjzftwp9ztRPhIg9eGhGnmFMQdi/
         G+U2/7Dufc1kT/SnL7oFCKYlwwb5Q4/xCF5ssIAJ8t9xLxQAQs9oMaXg5r4R5NpaNfPT
         mjur7LUzf7m4yAxqu4zY/ESTbPCuGa/04pNbAXBOCuKFEPUDoRzmUlmDtoBBkOwQo40+
         vUHR9R4AZZBXRkyDHqvUA/6rC7tuvD/eZ2ZCwMIGpnhDPX9VQT/KgSscr2j/COctB4PK
         Spng==
X-Forwarded-Encrypted: i=1; AKwUvByS2FvmSiX49G5BkA/c5iCVWneq5WGv/855+xejGBD7WRtC+xglDMLx96Pw9Q+k3CZ7kCQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l8LQuo79ConK13evs+QNRAB47nlavKYvKu0EqaxW+X227CTTal
	BTuNKPuK+GO39nGUAwg7piUGv5QYyI4oNpZ2FdXRn+qOUtQ0ISDfYT5fO6ScVDFJCWDc5qRQAgS
	/dXVoc2BaOEu5B4tdayLfHwiO3WKrQ0U=
X-Gm-Gg: AYBFou21DGlpGqlaeeOa7xSsQ6H5EiqhHUhltURJi/HSY3jdSc2HPNn3BzsCEgZqbt9
	PIuY9/CzWevF1F5xB0GfFy4sDLE4d77rFrv1lgAJUChBi1TjU+FQoh7IxqNV6659ynCP51NPkJw
	zls2PaKCAH4OC/o+9UmbCDZvjjEevX2XP7qi3PYDYVX5aWQ/b8V4Dz7u3Cu1E+6PK8xKq6w7EAR
	lbxPBwblR/3B11XZUVlBKrv/lYdVqJauqR0VzVQfVQZnEJ42u8ymrKzrJweJnpjOjJzLD7DQdwz
	jr/LMSQ5o6bMKUp7kL3sv2/zSC5Nq4KPK3xKHEdGlfHx8HLjWHCfHbL4dPShiueff2TfAUNIIIs
	IoEQ1CpcfoW/E+Zy46p2fCt4IKEYADW2f0a/bsugeKfq1YU1ca6HP+Z8Q/kA3
X-Received: by 2002:a17:90b:5404:b0:396:d28e:b52 with SMTP id
 98e67ed59e1d1-39b26229b5dmr5722108a91.3.1788524312944; Fri, 04 Sep 2026
 05:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev> <20260904-b4-arm64-callops-kcfi-v1-6-ce6687739b0c@linux.dev>
In-Reply-To: <20260904-b4-arm64-callops-kcfi-v1-6-ce6687739b0c@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Sep 2026 14:18:19 +0200
X-Gm-Features: AcwNN1W-BJa7t0_HMwRoOS4jQPgmmEa3lTrRn_StsdokzqumkRB4EleU3vHebmI
Message-ID: <CANiq72kg3Z5rB28H4Ck+EzqQgiRSSowBMe3YW6p_iNwOG_dzWA@mail.gmail.com>
Subject: Re: [PATCH RFC 6/8] arm64: ftrace: Support CALL_OPS on kernels built
 with kCFI
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

On Fri, Sep 4, 2026 at 3:20=E2=80=AFAM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> Gate CALL_OPS under CFI on ARM64_CFI_PERMITS_CALL_OPS, which needs
> clang 21 or newer and RUST off. rustc has its own flag for the prefix
> NOPs and this patch does not pass it, so Rust functions would have no
> prefix and a different hash offset.

Why doesn't the patch pass the flag to `rustc`?

(Looking at later patches) Ah, is it because you defer it to the last patch=
?

Thanks!

Cheers,
Miguel
