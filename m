Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E2156F45
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779622969; cv=pass; b=p4MCkEhEqwQHwiTddVSkYi55vVcFD//1N9d/aEhX5CsjBOQ1aEhSbzxxRqapIFzk/NWniwcnKasdrwmkulA0ztVJxwSr0f3xcif7QqkLG1eyoGjC6hQsbMbKaBvz/No26x22dVGxNLJZCy/JDgYMNiJ5czdU/9GB0vNDSeKIQDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779622969; c=relaxed/simple;
	bh=syTurp5k/FlY7i6SKtVhRdWPCeN2KaSAYAUI3RPnRHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCZxUWEFbutULvz/uR/ZJcylGdqvU+aN9JvPudYA+bmw16x0cZfubAW/H1gUPuhzQj1KB/kSA6JB9e5VqIufKC0p5gFJYISZHbHR4ZD3G6JeQvb8fbvwroi8XWh7+95WC8rn2GFFTldPY9Jnl1uWH4VSTzyhVh6WX5UMGTBV21A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p05ijP4K; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p05ijP4K"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44e1860558fso5566716f8f.0
        for <bpf@vger.kernel.org>; Sun, 24 May 2026 04:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779622966; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZLxjJQyVu6mJVw5WNZtKI06zge+9qMuEMSafvsbcnGCG87FemYVUWPgvqCwnBJSDg
         Nvijsf58rk1Q3PdWAYXUDR4a4QtRAvjhHTkmQIqN8PiKwReMtP/90TAdZL20b0EtHA1m
         IxmPeRV1R1MhJ9PNRbbZAXGITitmGEJjTxU+rnEp5yNWXd+Y77ztbJV1Uz3HJMjW6igt
         13uJniiALhaoTQw1rAe/pwFSlseTWCR6ZTx04iEdwgHSEvyRloFuTI/2ACCylslXaxPE
         b+xRLP76gzUWVRH3Ob+aGmfzp0JQevZaZ7rrNxAGv9M+1uGnLf/A0zny6JVfmQt13LLB
         lHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C7kVc5tvVpJCHGYmnQpLTEkuF8MvylkWjklHoDCHw2U=;
        fh=JZyr5dtIAwkcXOynYB2XnosWvFqSp7tNAclj0QjCNbw=;
        b=Svs/MtTHqvJwxQXYH3zruHyhyCnhSDNmt/iNAQXW0PnH8VonBVfhXgy1Yc0qXtuKRU
         yWYm7kdoLOcxLQpkU9D/OR50ioYSfKCckwwWYH7WuyHolC7FmhsyfbvU3iAx77Jxm74s
         SEvvFAiyuZv8R2RxA5NkjtKFF3XxkqHD4K/1hIX8FOI36p4Ryzoii3+GfIspZrqauEyc
         TEsd/PaLy0H+Mp1ZUXDzM1RX9yisTfUfV+xCix0QK56NWFFrndn2P3DI3Xc6igovB+Nw
         brllRRn9q/Ntz0WBeH8XvM331e7xZXvmkd/akdIHJR8l66jq6f8dvyjEkjKCvGcEx2pg
         yOsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779622966; x=1780227766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7kVc5tvVpJCHGYmnQpLTEkuF8MvylkWjklHoDCHw2U=;
        b=p05ijP4Koe8P2fwbdD6a5LntXsiLWfL4hGcbXvWk2rjyM5mXCiLBkKVgj9d7J/M6mV
         K0/PIGDARx2n7aA5P2a7+zfIB+JMd7tuJuZttyytc64BtrurcisCHEtwgBXFN1HWSi7x
         ozwF/mDORuH79258AwYmXZyizerru1FY4a6ec9Pqsu7/SoAL1XsSPad2rmlktClIgtfF
         GRs7zpYm0ErTRqIO6/x+OhlJYExosKcF/2ZXSrdjWm7VTHLA1vl1e6IWjX4Z0t5GYeWV
         yFkTCduoV7b+OeELw2F7wgIxgpgpZQETCzX6W47Inq5YJk/3MNUfftQW76SGtew1H27s
         /loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779622966; x=1780227766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C7kVc5tvVpJCHGYmnQpLTEkuF8MvylkWjklHoDCHw2U=;
        b=UpTq4KbXnGFhDbaKZVGpMXgQENlStXJhQDvQsT2zrtIKIsJg4FCLcXNK9O7RQis7cE
         Nqa5VOfOmIpLs3jHpFLYlaBJv9Vz2wuc7L70yMp2m0RJJB9dTYrbpcauVpZE/0FuxTHX
         hVMwzkiljAgfy4dmFAMtf+URe7qjQ2ADWYnBZUgD5jtQpVcIsi+8a0EGQ982jyQVyq+Y
         OFdB1ygrdEPGoo24G72wqVbqjXWgfadJjVmtt4xvp58hLp4rA9Hdk7B1xhE5+ykbCr3p
         u/v2uGREOKy4T7dbPm0/I32zwUyCKyNdKE3pX/GEGw207GqInsfqp6pBGAcIslFkmcFJ
         vWoQ==
X-Forwarded-Encrypted: i=1; AFNElJ93iprHd7oBjewqO5BVsGg0loAl0Xjn4wFghLveRBGYOd6AMtc+e5pQLrGDberiw+JVr4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuFjJ1Nw0mLjojHLw7R3WXLn0l9aazKIpdZHLSPzQfQlqWSSi
	/Ly+kjNKylpolYj43HRo9N2+mC8kVSTX+apTP9sDqW+etm+61nGwZ8wf1LfJZ3BDHRHaTErGoLo
	aoTP7526aiT8E3p7geXgLlWBv4vdFjWI=
X-Gm-Gg: Acq92OHoeTHjvo9drYlXQMl3CqK8wIjR3FdaqzG50WeAmwW10VDLmPdCPOhEJe7Z2KI
	zuGDOj+3d1Vho/S9NOMCk5/nQn17WNZAn5twUvICv+0w4mK3WjbOdGOrBoFG0SFHyFJQm7oLklP
	cMwRITPk2xnRsW/DM293w/qsM9FfcZ4NM2c91ZRrsjaSiAjJ6gjCYKos7DT/+JrsZb2Dwcg9K01
	kIC8gdzPXhBNQyPcKaMqllbSUEkjqAJIj70U1GmhmoOXHg7Z3eRk08r9C8WUO0x9NLvQUIcjCCQ
	3CqVNwwG8hJJEdQEmWcER4QecHdRLohiP+UHH5cCblvTDfA1jzGU/Xw7UnQczM/a7p8i2DHg1eE
	IL+wyVThrc+tPjZA=
X-Received: by 2002:a05:6000:4a05:b0:451:bee9:17c8 with SMTP id
 ffacd0b85a97d-45eb36b0275mr15888127f8f.6.1779622966075; Sun, 24 May 2026
 04:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524-libbpf-load-vmlinux-btf-in-gen_loader-mode-v1-1-6f57f191a7ad@google.com>
In-Reply-To: <20260524-libbpf-load-vmlinux-btf-in-gen_loader-mode-v1-1-6f57f191a7ad@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 May 2026 13:42:35 +0200
X-Gm-Features: AVHnY4KeehVzrtMXstJhyW0ANjT15musXecpNTINs5b7P8dSOZCGDFz2Z42__pA
Message-ID: <CAADnVQ+M6pJJJ_YY5QO_EYJyDfd=TNs=A1xFB9_RFLTqaM=w_g@mail.gmail.com>
Subject: Re: [PATCH] libbpf: load vmlinux BTF in gen_loader mode for struct_ops
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, gprocida@google.com, maennich@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 1:26=E2=80=AFPM Siddharth Nayyar <sidnayyar@google.=
com> wrote:
>
> During light skeleton generation (`bpftool gen skeleton -L`), libbpf
> runs in gen_loader mode. Previously, `bpf_object__load_vmlinux_btf()`
> completely bypassed loading the kernel vmlinux BTF (`obj->btf_vmlinux`)
> if `gen_loader` was active.
>
> However, BPF `struct_ops` maps (such as `sched_ext_ops` maps) require
> resolving the kernel-side struct type IDs and member sizes at
> compile/skeleton generation time. Without loading `btf_vmlinux`, libbpf
> cannot query the kernel BTF types, causing light skeleton generation for
> `struct_ops` to fail or omit crucial type information.
>
> Fix this by modifying the check to load `btf_vmlinux` even in
> `gen_loader` mode if the BPF object actually requires kernel vmlinux BTF
> (e.g. contains `struct_ops` maps).
>
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
>  tools/lib/bpf/libbpf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3a80a018fc7d..cb1b7ea884a7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3590,7 +3590,10 @@ static int bpf_object__load_vmlinux_btf(struct bpf=
_object *obj, bool force)
>         int err;
>
>         /* btf_vmlinux could be loaded earlier */
> -       if (obj->btf_vmlinux || obj->gen_loader)
> +       if (obj->btf_vmlinux)
> +               return 0;
> +
> +       if (obj->gen_loader && !obj_needs_vmlinux_btf(obj))
>                 return 0;

That's a step, but please provide an end-to-end solution
where struct-ops and sched-ext programs are supported
in lksel mode.
This step alone may be more confusing to users than helpful.

pw-bot: cr
