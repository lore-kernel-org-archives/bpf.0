Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93B8365A1D
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713823; cv=pass; b=FWsnO2IM9u8sqYu1Rr2oxsAMo4+MLZlKk4VIZEbCewF4wDz5TQ+dzvJNVuUHjuGrEpESKx2VjUAdQjHejw6HgNNePSEVShu69UG9T3Eol190KFCZhXx2HrK9Pl+vM9TzO78XWhoSQU90hlv3q+YZXksq50VbdOWbgo2JFRTeN4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713823; c=relaxed/simple;
	bh=jLbNWAYKOjUjCxKPAnKQtbCBXntzd3CfPr6hFf0UbZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jpc0LCwIZDKd3XbsZESIYyhtYWCyiJTkw/d7h2RUr/9Bm0M/NUIBKu8AbnVmVIjHuNSkwE6KjSJV0HY/Vx29GMo141/qs5ce+Q2ZurVVNS5TRSCZJNja7WW4BSTJVFtD/HOWjNd84sNNbkYeTC4Yk7QTz3/BLCfPB3FybvwSSOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjHPtZQt; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjHPtZQt"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39666e7c9efso175596a91.3
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 09:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788713821; cv=none;
        d=google.com; s=arc-20260327;
        b=knaTW8h+Gvb2g2FjDlm7JENdEkSdQfLABsI4IqKM8vhENeWPcxlNmmr3d5dJjbft9h
         T6pIlQhJroeu1lYoK5YyxRSDQReCGjlCa1egqxnaSFxdGxpnOlSW3HcXAOwYHAqZLqlt
         yq67SLk4y9Uzgk5dEavQkc38+CgYa049xAzi8+1d5KQuNfozTgs6qvUSv2uZ2NzoLT9F
         KQYd3Wuz0UUIcxoQiA0YpMaa1dHQfUqysmLbgP8alZyg/Gc4FRtN73dABcFDJc2Y7c3D
         S0GHYnJQF8H0luhwoXZP0J0D9HjpdqrOwAFXMijHnZDlomKKs9mQBphSfFK8evlm0E7+
         cN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jLbNWAYKOjUjCxKPAnKQtbCBXntzd3CfPr6hFf0UbZI=;
        fh=/LK8FqACEcbRNXwmM9M2Uy2RizFCSgId7jPi2t7TuK4=;
        b=gLY0rl7x4onV2mxktakzZW9T+povRDtmrr4LABcLUnNlHc8AXwJVPVwjtwuj5OE4F7
         y/6rXK7Pt5l5M557CBigCyi/vtoAAe17Z0QsRge9ubQIJFp0Be+6m+eK8t8+MPwWoOL1
         UOnbG1Y9HAfwMTYcMaMayW0FnCf5XlPm7oGXJFqroiisSWTiAm+PnjCoQHjuFCo48f0Q
         Ky1JkH2K6JVtj7yQHd0ECrKZIT6dB146DzHAtkXG1U3DHIjZmgWR8f4KlcwLVb0+oMgL
         HbRtu2MTi/hCpK+V6kkREL/2bI3m76Iec0t/2MSOjOvACXTYRvgQf031o4TyhE1rnC++
         fO4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788713821; x=1789318621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jLbNWAYKOjUjCxKPAnKQtbCBXntzd3CfPr6hFf0UbZI=;
        b=UjHPtZQtZlfn+jMBdsesbKV9hhN0VxB45TUW8NF6jsIj/u6sMjuVZl/S6vNiEMAdHB
         Te+UXjaLTopyZrVKblQ6F2RdO17BiDzp8YSjJWd1LjGv8/lpVMX/mJq6tjMcQBGE+lh3
         gkbl212FSvMq4hzn08kjNsXAWfz8CFVxj8DwBvGDcA2V9pboEq4SigdRgrpS5P3lbPAR
         WaeQlpczdSbYO4EXZkRcm/d2DFhfIccQOCyUcacVGnAtc0aqHvm4nD/lvAQStGw+ys2S
         nEMr3QPCYz3NCaB4lrh+lVRBv1NLXl63CMfDijyK5BqBSV6Pp1fy8GFAFtzsiR1Bm/Qi
         cjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788713821; x=1789318621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLbNWAYKOjUjCxKPAnKQtbCBXntzd3CfPr6hFf0UbZI=;
        b=MxL1kX6wsf7ksrlA4ENONUkL9Xabg9hDVUNk2luCVAgj1YZByOIl1Hiw7Unaj5segz
         b1UNePd1NB8j/vmR97bbetRPu3kYT3Fib3ugK5WUlYkkMdJUd1AjEbySMmg0/3OQpVdM
         iBc7joK9gmPnOysbgaxikvUovq3Vsi/bRKZPsIt0EOmXRyzTjFNgyYKYjZB+zgJck3MP
         1uVQAwAhRxSja3bSzqoNuQ6SPoEuH7Q3T22cbLpgSb4nqyG7kcIv8yjLKoij6z5AHc6O
         SD+C3E/pimaVobpdO+GkTFl4J9WGmHbtC5cHLCmSmgt5EHwHPSK8EL/eASyoIagIvEFc
         NS+A==
X-Forwarded-Encrypted: i=1; AKwUvBw8fDgw/ycSwChcCv0IpZpfZTG4wy1NPPxS7R/g1+6DYC4sg6BPodnQYqtL2o9w/pXdVxM=@vger.kernel.org
X-Gm-Message-State: AFuF++k6h7klsBPA/KaQmWxgyF4/X0kR4QI5UQlCq03dzo1g6G+riv0H
	ojYcrAc+tZkYsesvpDWHqiDtUdfN86JtwNWWiF2HFJQmhLnk3JIUBkHrKvh4FzO4OHmenwlzedw
	hWp5de9w/LtkQbPwUq2jYqVLmlxIkgfg=
X-Gm-Gg: AYBFou0lhDYKIKGrHsfX7BeeZZSMfzvBUC6kbNeDQeSqdw/3hay4ANXlJQXxQTCBHHY
	JFWGLNdIYJbI3vunCqoiuv/zyraDHSJ3fiVszAz6u9zH7pvKNJsWecDv2skucww2rqZQRP/QFdo
	gItxpQDHv6vKzNsBESK2j6RpQD5PX7UgLBNqtIfqihWgKwDnwe9bjRMF8qZSzPI/OvNMT0D/i4h
	pw/jf4vO2CGRCBliqF5BNEGrJVaB+iZxxNY2J96uR5Kjzq8NhGiZwZasnNTN8AYQIPzHRFSmW3V
	Jyt32Jc4WzMMJrbi+YtJW08Ugx03qXviLHqyBBsLx4kbHgG7J77MEh+ImJRlu3BDalkRFaNdN8N
	KVPOjRrpTcLQJhfO3SJ1Sg5d7KoLFzFI2a2vFXT8qrUsidryq5raAA7oE13RXMGEM7LF0XnSa
X-Received: by 2002:a17:90b:384d:b0:398:bac0:238e with SMTP id
 98e67ed59e1d1-39b3d8377camr12050791a91.6.1788713821151; Sun, 06 Sep 2026
 09:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev> <20260904-b4-arm64-callops-kcfi-v1-8-ce6687739b0c@linux.dev>
In-Reply-To: <20260904-b4-arm64-callops-kcfi-v1-8-ce6687739b0c@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 6 Sep 2026 18:56:47 +0200
X-Gm-Features: AcwNN1Vz7OHfpHx7W0dFC3jg8glvxcm1hmRiClFLpwy0F6DpBbL1JHHuwRxDDvo
Message-ID: <CANiq72=xOrSXBBdmrKYfX1=qgF37LRAMzMJd4GJkXaYHMVe9yQ@mail.gmail.com>
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

On Fri, Sep 4, 2026 at 3:20=E2=80=AFAM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> +# bindgen generates no code, and its libclang may predate the section
> +# argument of -fpatchable-function-entry that a kCFI kernel with CALL_OP=
S
> +# passes on arm64.
> +bindgen_c_flags =3D $(filter-out -fpatchable-function-entry=3D%,$(c_flag=
s))

In general, one should be using the same version (we warn otherwise
early in the build), but yeah, it is just a warning for now and it is
nice to try to remain a bit flexible.

Now, if we are going to filter this out for Clang, should we just
filter it out for GCC too? i.e. outside the `ifdef`?

By the way, "generates no code" sounds a bit strange, since `bindgen`
generates source code...

Thanks!

Cheers,
Miguel
