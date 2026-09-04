Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9CA3F86F8
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496851; cv=none; b=eFBDr/Qlw/OyZzNcOV/ayfnt8BQFr8z1sJN04BJ/pLdBC7XvR14XxnXdCxQG1R3Ow893IcEKnCgeMobLtecNtbxEGMY98SZjlG0wPl8ePpeY+61eXapCXGGcTBvhAviNTY+Idj+/tW1LyEfREcEU19OrmrnkBgVL6ED2hSKSg8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496851; c=relaxed/simple;
	bh=EsZTtJArPdsvjtwLaxJS/36qM9/GD/zNIMERsfsY+rA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=f5heN20EeKAJzlCbdvF+qH/f3rYtf+hforM0Z+YMcGSsVmggBOHW+nNWanLThtje2Inc1XwZ1WMoGQr21kntSzA2p3o72TdSBwhPWzxIZkkPgOGh8HgphgnCyY4xh7KTigQh8PfIuTGsWPWaz6zybzuJM6ddoG8QH41R+Llb6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sN0J4XAK; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sN0J4XAK"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4b3a61bdf22so319736b6e.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 21:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788496849; x=1789101649; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oJ/VSFyHR9Am9gd1czkqm5wZOQgR9037YN91ECA4S08=;
        b=sN0J4XAKlivBXBnXykbQlCZqcMlU231BB8lPZtzzelJjZFf47Rhr10s5zpBuyRhFYR
         J76oLOVYN21NNGz2ADAbytNVn2g/6zh8pJE5V1RFVd0VSeJKDgavNRX5tHh3Kv4gA2Ef
         o95S0VZEOKuixYoIZ4xDNPOuhOcCfdquUZd1PnXRA98OVLTyLNSNzaI5SjNmC76g5Obz
         GHgirfBS/ViXKuRlQ7gbvbFZ1/ENLSTLMTOMKLFygKZFhbrle95IzsPWsLGZDstqLTAs
         Gd7xYFhAUJQ8b2cRMRvQq+wd4mmihBunV3fsN0rokf9MIm25hGCa0HI7IhQiicQz4AHM
         EWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788496849; x=1789101649;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJ/VSFyHR9Am9gd1czkqm5wZOQgR9037YN91ECA4S08=;
        b=pvB6lHQFKiy9M7+BJ4vo8WwT2cqKlpYtY0hMRgWlJ/qE+WeG8Lz1Q52XdgAHQNZKhB
         79Tt1W3fho2YltVWHhyX5CGcHqrxr7AVCgBL3NHQY+ElZ4NvtsDcEwwDEDFAbfbwJtJG
         h7QSnRnTNNUv6TJjCWba6GOPyfNYJznTiLHtYq4rEhtSTIZmhdMIsDm6lRX2M5uiqMZ0
         gIOMiDy6aWOOSK7w2dMZR+xg1aq/dfUfcC765yd5A+3b4CC3yYt10a2sBzypfprDYUA2
         F9Z850yFFOXRA18dO0BN8WjDC5wSXjjxCib7hjPdFw+hEDAo3tlDhCHiSTp9qvaWYIaD
         MeEQ==
X-Gm-Message-State: AFuF++kqV9HrZwXjknlpaM6/l5f36iucpCQYo5Sblys3P5S1XRoC5o8A
	R8r/7bPEqR4GokMPe+EGgzBRm07pVtKcjodPj3Ijv0e1iaFcp69rB473
X-Gm-Gg: AYBFou2P5+2FvHPxczGzIP66h7AGAUyprI/dSwroh8IAW/DDbceNR714APykWc8clyh
	yOoxLW+9kY+rBEnD/ON5jOm4vF5+YBvQ9jNdPK4R2dbmcm4zfMZFwAOvBWgFkU2g2G5nGelyHlc
	j2HFNLm0WjwtdNltBY/x5BQES9Ftpjxpz+TP4Gs/rYZsWXk3JygQTnYXRrJoIf6VEf8cPkYWlZH
	wvkj4HuPaubUXVuL2nEFM0WoQpQ4VP2lin1OW2oK2hGEj5ICc+I99tSDQjeigAUF1WPZQbcrvSe
	OmqGaUdwvvawZBK6165Grvo0JKEJDdRs2nYukMlSFnEH8znvCdrrWrD3g0syiD7pZxK4Z7YOTLs
	ny7RU5BhX10vlfaUTS6dVhV82CiKl7RyxQpxcLoHXEenPEKFW+kOcSd6rz3qdXudkuim7CQFzd4
	BYb2FZMQ5pJFm6Pb5Lsavp62GPB78jG9ZT5GVXFM/66aMoWZILtsAkJqYUzBKf0US9KTm2ZJmoX
	O6Uc+kues5TH6sGZ4koAaZTb7jc58Syxi11Oh8s8+ll4/AEtiGX478=
X-Received: by 2002:a05:6820:179b:b0:6b0:589e:42f4 with SMTP id 006d021491bc7-6b6fcac5a26mr2565373eaf.20.1788496849073;
        Thu, 03 Sep 2026 21:40:49 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dbedc38bsm2253243eaf.4.2026.09.03.21.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 21:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 21:40:46 -0700
Message-Id: <DL697WN5AOBE.C8WRI12FLOG2@gmail.com>
Cc: <bpf@vger.kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Mike Rapoport"
 <rppt@kernel.org>
Subject: Re: [PATCHv2 bpf-next 3/3] bpf, x86: Add support for jit dry run
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>
X-Mailer: aerc
References: <20260903092039.477827-1-jolsa@kernel.org>
 <20260903092039.477827-4-jolsa@kernel.org>
In-Reply-To: <20260903092039.477827-4-jolsa@kernel.org>

On Thu Sep 3, 2026 at 2:20 AM PDT, Jiri Olsa wrote:
> Adding support to run jit code generation in dry_run mode that won't
> store any code and only returns the jir code size.
>
> The dry_run is enabled when __arch_prepare_bpf_trampoline is called
> with rw_image argument as NULL.
>
> It's used in arch_bpf_trampoline_size where it allows to skip the
> image allocation, that gives speed up for tracing_multi attachment.
>
> With current code:
>
>   # ./test_progs -t tracing_multi_bench_attach -v
>   ...
>   serial_test_tracing_multi_bench_attach: found 55227 functions
>   serial_test_tracing_multi_bench_attach: attached in   1.563s
>   serial_test_tracing_multi_bench_attach: detached in   0.256s
>
> With the fix:
>
>   # ./test_progs -t tracing_multi_bench_attach -v
>   ...
>   serial_test_tracing_multi_bench_attach: found 55235 functions
>   serial_test_tracing_multi_bench_attach: attached in   0.798s
>   serial_test_tracing_multi_bench_attach: detached in   0.258s
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c | 42 ++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ee2ddeba3de1..d1af7dc5c5ce 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -25,6 +25,7 @@ static bool all_callee_regs_used[4] =3D {true, true, tr=
ue, true};
> =20
>  struct jit_emit_context {
>  	u8 *prog;
> +	bool dry_run;
>  };
> =20
>  static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
> @@ -42,7 +43,10 @@ static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int =
len)
> =20
>  static void emit_code_jit(struct jit_emit_context *jit, u32 bytes, unsig=
ned int len)
>  {
> -	jit->prog =3D emit_code(jit->prog, bytes, len);
> +	if (jit->dry_run)
> +		jit->prog +=3D len;
> +	else
> +		jit->prog =3D emit_code(jit->prog, bytes, len);

Sorry, I don't believe that skipping emit makes that much
of runtime difference.
I suspect jit_alloc + jit_free are costly.
In such case the earlier patches are not needed.
Point emit logic to some scratch area and discard it.
Same effect with half of the changes.

pw-bot: cr

