Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0263254BA
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327789; cv=none; b=AEsBvSG47K95cKRo11x9OIn4yCCu9yjYcqklvzgZRieA/jI9lb7lMEBPdbfDpDjfOKPqA7/qxIGIYuuAzKEoI9dYhWiAdqiWpqSDp4TgERFYsRptJid5M4l4eWqoMtEUzrwXnksYj5XpMPLpbjgmQJcfBvgZQdQNpxKM2s4oms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327789; c=relaxed/simple;
	bh=cMuSWvxYR5eb7V3y4b4uzhhpMV1mgsYv1SOkM72p9tY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oipjff5KsQagzCqpcl4vD77HSQoaXO/eDJqT9iUZX7UTdK9uvSuDr41GcOHnAIEu3+YHLIGQKFru7AVw3iuRGDAbtF3+ocxUcsg090hzbTl/+iZUbH7fCa6QKhC8DTwWUb3IGGeozo9fowbfYTlhLyvaFdtoG1EXyvfpPrUm3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyWyEd8q; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyWyEd8q"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4362d4050c1so4722593f8f.2
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 03:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771327787; x=1771932587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QTNpRHxHGxeoSqckXDTYVg2ZKwL+NMU+Mba7FsgZ2g=;
        b=fyWyEd8qZ83xItAZlaWMohAPCbg0n7E2FS+SCzkMnWD6he3s4zZMIxcIf+LCKKitW8
         QK2bu5ak4Xavel2Iwu4M/S/UuwMutPagKQ9yfzrcRCdP9Ba3jbXRxdWgeQ+Em2180pmM
         MtMQiXyY2PecDg8FNc01SCZ2obyOt/tCkU78kik1US8I0UVgTEzvAqzNQ4kxjUCSK+jT
         CATviNwIM4BWJouzoCQuGia6SJJxMZ3r90E94S2YZGwCpJHshtRAc/pPMi9ALB8Fxtmg
         qD8yvQkjSBiGvRdlDoYVSsbcTtxVQBSb80ZV3sB7DNi3JPNLR6cjDvu/0WfTjstFKng0
         8lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327787; x=1771932587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QTNpRHxHGxeoSqckXDTYVg2ZKwL+NMU+Mba7FsgZ2g=;
        b=i8U8M6m9MdhlwJnWAPo2c8q87by2myAlXsSLXaNQi12X0JRU6Bjh//tyOkCN5XYTen
         cgZ9nWzg/THWiMU/iMxMPRx07cAOczC9LQZ7FM5H+jJhveyYBDu5grtvo0Yhge4knhoE
         mKmhCogcn1TCebhsBFJnOep3cKb+5pg9eeEdzcOMgkQF1vMjqdDkQ9LpAIYoaXsxqPNY
         cM0Gu6lEFmEmsnrxIdNl7KLQxnuxgd/cBPiuFhrtsrMSEaUj/Ijl9yjvyl82Q+6rlMQ4
         nymxUSce/ZOUzlemhmSJCxd1Qgtx/unx97xtauBIeFxb3NmexiaMSRBLZ+dr/NVCu6By
         xWEg==
X-Forwarded-Encrypted: i=1; AJvYcCXYpvrUWILVxySYe1ABb5WUOZKoORXURqmScAL0E0NoQvhPeRY6e5AUcI93fL9L7iLErQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhPi5KTnqCBrcto2Zr1a8qAUL6nAgMPxxrOFV6iYsbOoZ/OYcy
	DiMMgeR4IZa9T7ELT2layul2cKy5psGXoF+ymfvQHEDR99eTWiqjSimy
X-Gm-Gg: AZuq6aIAMINIYziyQfpWgulQEvGslz8tsYkyu7avKNrRvLGavFKkMSVC1FqcNPZde5U
	0Am1+H+SP+G+eJBkkRDlmhDxT0UEIFcVj0pzbq7C2dF4jgbMGnQtP4n+7quYZjGjRQpc9f90DnZ
	tXkyKTa6oteO6xDdCFstVs0ggbaXdhZPueY5073MH00ZumGFctkVWBcyYu8OEuULBjU6SCJIi9k
	MmhKfNR/VKvO8Q1AfAwPNnd+c9DgreTlZKS2ZumL/tjGMYDBALVY9rFcBlOxBvbTbFMUSsjE8tS
	2qL4m/x+y4PyOiDYFjXBYOY/vDLKzQft2zJqnn4+Qu+UFqv+jX9meOTBXvON/FWawi3KrBUtn2P
	rkKQHZlf6mzIKIIM2gviZ0xz0p8zFqgvwJdAHZBi8xOUX1ysATV3VNxl4MtvYh3pKVHRhANlCHk
	4hbgqtg3+WjpujFza9ujnIVw/9If3Lj42ZL7RN6xM+aEcK+MsaQNaG2YWRcJ8KpGAP
X-Received: by 2002:a05:600c:8b2f:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-483739ff865mr193668865e9.4.1771327786470;
        Tue, 17 Feb 2026 03:29:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a29982sm104891805e9.15.2026.02.17.03.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:29:46 -0800 (PST)
Date: Tue, 17 Feb 2026 11:29:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko
 <yatsenko@meta.com>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: Remove hexdump dependency
Message-ID: <20260217112944.75610d2b@pumpkin>
In-Reply-To: <20260216-bpf-sft-hexdump-od-v1-1-f8cebd8eb9d0@kernel.org>
References: <20260216-bpf-sft-hexdump-od-v1-1-f8cebd8eb9d0@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 17:30:34 +0100
"Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:

> The verification signature header generation requires converting a
> binary certificate to a C array. Previously this only worked with xxd,
> and a switch to hexdump has been done in commit b640d556a2b3
> ("selftests/bpf: Remove xxd util dependency").
> 
> hexdump is a more common utility program, yet it might not be installed
> by default. When it is not installed, BPF selftests build without
> errors, but tests_progs is unusable: it exits with the 255 code and
> without any error messages. When manually reproducing the issue, it is
> not too hard to find out that the generated verification_cert.h file is
> incorrect, but that's time consuming. When digging the BPF selftests
> build logs, this line can be seen amongst thousands others, but ignored:
> 
>   /bin/sh: 2: hexdump: not found
> 
> Here, od is used with awk, instead of hexdump with sed. od is coming
> from the core utils package, and this new od command produces the same
> output when using od from GNU coreutils, uutils, and even busybox. This
> is more portable, and it produces the same results as what was done
> before with hexdump (without trailing whitespaces as a bonus).
> 
> Fixes: b640d556a2b3 ("selftests/bpf: Remove xxd util dependency")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Originally, I was going to add a check to stop the build if hexdump was
> not available, but switching to 'od' seems to be a better solution while
> not adding a new dependency.
> 
> Because test_progs was not reporting why it became unusable, I added a
> Fixes tag to have this backported, to help others. Feel free to remove
> it, or even drop the patch if you prefer to stick with hexdump.
> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index c6bf4dfb1495..5a618d14243e 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -723,7 +723,7 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
>  # Generates a header with C array declaration, containing test_progs_verification_cert bytes
>  $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
>  	$(Q)(echo "unsigned char test_progs_verification_cert[] = {"; \
> -	 hexdump -v -e '12/1 "  0x%02x," "\n"' $< | sed 's/0x  ,//g; $$s/,$$//'; \
> +	 od -v -t 'xC' -w12 $< | awk 'NF > 1 {for (i=2; i<=NF; i++) { printf "  0x%s,", $$i }; printf "\n"}'; \

That is subtly different.
The hexdump version deletes the final ',' from the last full line.
But not a partial line because there are trailing spaces (from before
the '0x  ,' that get removed).
That may not matter, it is valid C, but not C++ (unless they've changed
the rules recently).

od could be used with:
	sed -e 's/ /,  0x/g; s/$/,/; s/^[0-7]*,//'
which outputs an empty line as well as the trailing ','.
Both removable with a more complex command line.

	David


>  	 echo "};"; \
>  	 echo "unsigned int test_progs_verification_cert_len = $$(wc -c < $<);") > $@
>  
> 
> ---
> base-commit: 886bf921ecfc30f8f31341bc26560d8bf08b937b
> change-id: 20260216-bpf-sft-hexdump-od-abd07a3bf026
> 
> Best regards,

