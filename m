Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793385354;
	b=dggPkTYNZ+swO7qIHc6J8k9s+xChO85xsoezFxWcvn4lpnmdfXdYyHELeIHlN3V9p/8R
	 xhR2RXRkscJ7IwiP/1Aq23uq/8RrFG587o8LGIevTDE7XvtDyOS14zwopS0En3pP3iat1
	 6GZbbLwtJYv9A8RfuCO5uKB61R9VkO7Fh+gQAPiTeVItlHUeW7gXK8M8XK8zocEjv/Der
	 VIbablVr8PnY2KhQZ5o1JXjW5K4m+Et0qyVLcxAfuGBv8sTNND9ZNCd3/rCyuBP5mPwx+
	 l1rf1dPlymHngxfjGgYY3C2vQuLEPHGbmxqbp7PG4Ii/C5emPp7D0xURRJmnrKJu8Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VCrSy/ZuuMPWgt5tPyrPzSqsMBbI257M3gbzDa1WLh8=;
	b=M+0bDS85Q4Saj1DwgTQR0P2pO8rz8mHTNV/Hxg5kVzBXx6qq6YaJKWpp9Iug0ZEIL0yi
	 BsqMH2nDb/rVzvE19bNTi01vBzN7wCxykTKAOGIB9qGxYFl9KZfmyzk4W1WMvO6nBNEBL
	 WMHM04ZY+hnDN+OY/wnTE7vaRjD4OlGUfrYWACJoQenmOYkwdTLIm3OveqLZetYygIgfJ
	 MBw8+doY8PJEbjpkwtKO71aUZHg6N+lba1zWxtHqWTgx2sqdTW+BvaAbGUb3ar7QteOdi
	 zvY2qwnQ73HNH7mJ3fjiVCxGQkd5h6GICVz1cg63p4gyBi94Ge7AJViSWjurwyDPdbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aOnOGARL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443E606A323
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B443E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aOnOGARL
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so650049a91.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:35:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793385353; cv=none;
        d=google.com; s=arc-20260327;
        b=AoP/i3ht6FT8T5azZwRIycMwxybpm0EBmCmqWZ6HZuKz7gtbX0FVC9gQowU2JgAw2r
         bnzzWP1lmhQF5QBa45V5mSoCF+Yn7efrKpoajNzJ9BZhEptuOM/WoUlhz/8/rlxUzRYf
         SSAjw1QTmTIOcWX5AuKKsuHQnJ5z2GNQnFnaxZVrQMdViYdg5VgiV5bMnIZWQaJiXI/j
         ZWf5Vrr6V8zfypKGFwbXa+1hWEWW1+hsi7/nhWnDCNTvpN3jjjx2NUpb7gAM8bIUFI0Z
         bH3jANI44dqvXCzcYBlfv4Ucbm0K1KNnSXb5awxlp1XdZqJOtf7o1T85Iz9LpWfr7EZm
         036w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VCrSy/ZuuMPWgt5tPyrPzSqsMBbI257M3gbzDa1WLh8=;
        fh=BRKHuN7aRUnHSjXP+NyDjPdYEXbkK8lhbo5O8HSlgBU=;
        b=GhepYPkiRLYZ1FSGkwd0m/TeMxTHmLKDUrcQVMVPOkeeoSKfmfIgZ/jP0fdd1/9VXI
         KNN+Lqf1WiN7rVI/Nr8gqjBgIC5Ycg6fMsnd1tE+6+vy/v0T404swWW2+BI943/8+Vpt
         CV436+c7brNEOSiTYdTVoWSg29QbZicWh+2KqYTsxH1by1iLVmSWjfdQg0Oc11Z2o0GR
         XSjfzwQ9XIgB5hVOZTsR4faZHloNcyZ5OO6WWj22djpCwadfRKGPx9nYzW3ofxhbBSFC
         ZUYRHsikSIPTMBEGRd3vbw1BH5HY5UD09OoX5bnTfp3HHer4ChgrEebNyEcpFmNgy0Yg
         SsLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793385353; x=1793990153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VCrSy/ZuuMPWgt5tPyrPzSqsMBbI257M3gbzDa1WLh8=;
        b=aOnOGARLAq3+vS3+AUAPyMDEM0nVkyJNKoWKe1zBx9m4Ld6GSVIyxuBOaQ3UWb3jFq
         lKxLW7kPynGs+3LpOSvm520sBcekrqRSz96tcQ84lBgloV+yvgMCAzMa5u0twtKKwnJN
         dK6rh1c4jZz3yV/7uszUoYNY1jKh5ZF00RHaOiB3baCOd6i611tMdmidenXyi9PaDQoR
         XHqhK+Tj+iJSzZsPXDs+fqIPuIcCVpeA6Yt9Xgq5CqPtieDLghs7tLs/66sIMMks50qZ
         OjfNQyLtLTkebbTfQEVo86i/SKSKpWDfJRE3Mb9+EtfHLwhJDq6Y8/2NeKEeFfCV9zLb
         TkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385353; x=1793990153;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VCrSy/ZuuMPWgt5tPyrPzSqsMBbI257M3gbzDa1WLh8=;
        b=L2WVhVk3GmY2fg9TeEcboF7RfgnRdM21VX7/dTz04dCp3w5CRErPTyDnWeDC1lL8bj
         FsUEzEzfqUOxbffNF5M/bNGw58xxf/z9OSccLQFquZ71O8rYMHtsb5cam0AlVpQPTJZ0
         iMD4Q8KUvfAqBHEkO2HZx43Fl9EKsyHzRh+OWX57tVHwba8uPrShWin66S4CPhrFkrtD
         MS86bDARltkeaNZ0B1ltQBgwp+mNpVebkIjNwLgQiHVun4vDbJLliTnwnI1V+svbb4+W
         XYucJ5uRmBm4+69ZHuyhYXyt7Nh42+jSChqJLhOjN7cJDUDTlM1Cx/QvVNwErkOxCDqh
         FJOw==
X-Gm-Message-State: AFq9FYJOyIAoW0sfODdduHgPcLXzAvc2DPzAXMpoX1uSQYy4K7Onq7kB
	5HCasnFBanD9uFi5h5WTDvT+6WHGg/RLsX9sQg3AAMCvlt8ENOIsCXQ3G2iJq4fNqco6WYvTsdX
	LEwLgaazCifyf+9I66nY24ooH8NkoAVk=
X-Gm-Gg: AYBFou21Av9hDnqofbxHASIXZNSGQEtamoR0o064ELcVOMKuxDJNAk7Tz50Bqx/947J
	789f8sEF59NV3ktfuo7+cl1L9RJjYAtwI7Y1VHrH9bKWnsmkHxZ7tiHrwy1c+zWo1+LqqSXGXJi
	CfbfkMXx5IRzoOPlxM8KT7msBcVc/DJGORGT8vlmngUDJLCmI24/hfxAvXG4YRtunDixjkzgQo0
	ttfUhuKxbRn2dI8di4inex+6uM4sTj/2jL1FpnNxgSgCE0e5C/TQUleTU1wKLUGyCn/jUcvWGFi
	kTkf9ViQvb5CeKZNAybak3o8dvJy2QyLZuS8b0cLbz1Dc/yVWe6CCfDPIiGSvTI2GxbvF7l3afU
	swTGHpuuXj2oSNUJ648HIUrP6KBtkRqnCH6mQU3T5nsaijzKwdEgbRdFUTLspAhDhtZG4idyaeY
	sjY6OJ6zv70fSUWgLe1g94Jf44UtXHmcPP8g==
X-Received: by 2002:a17:90b:1811:b0:3ac:9176:e836 with SMTP id
 98e67ed59e1d1-3ae897ccb04mr2554974a91.21.1793385353016; Fri, 30 Oct 2026
 11:35:53 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030092248.7388-1-mahe.tardy@gmail.com>
In-Reply-To: <20261030092248.7388-1-mahe.tardy@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Oct 2026 11:35:41 -0700
X-Gm-Features: AclHuK_HU1GMC63pOJOmbeN9dxKnqqj0KjBqnZHrkyWTnS7x8iHm_3dMKvMKKEQ
Message-ID: <CAEf4BzaUg_KPB+k14ntDTaqU-3hEUQ8o5E2hSeUkaw4xwFwi9A@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Enforce program limit only for loaded programs
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 2:23=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> As explained in commit '259172bb6514 ("libbpf: Fix gen_loader assumption
> on number of programs.")', nr_progs which is obj->nr_programs at this
> stage is including subprogs and autoload=3Dfalse progs which are filtered
> later during the generation.
>
> Quoting Alexei, previous patch 'aac5ba0a4d52 ("libbpf: Reject excessive

we had a rebase, git sha changed, updated it here and in Fixes below.
because of that patchworks bot might not send confirmation, but this
landed in bpf-next, thanks

> program counts in generated loaders")' does move rejection at gen time
> instead of load time, but some programs are still wrongfully rejected:
>
>   Two objects with obj->nr_programs =3D=3D 33:
>
>     object               before aac5ba0a  after aac5ba0a should be
>     -------------------  ---------------  -------------  -------------
>     33 progs             -EACCES at load  -E2BIG at gen  -E2BIG at gen
>     1 prog, 32 subprogs  -EACCES at load  -E2BIG at gen  loads
>
>   The second object fails today because of the cleanup loop in
>   bpf_gen__init(). It closes nr_progs slots of prog_fd[], and
>   prog_fd[32] is at r10 + 0:
>
>     r1 =3D *(u32 *)(r10 +0)
>     invalid read from stack R10 off=3D0 size=3D4
>
> We now clamp the loop generating the cleanups, which may still be more
> numerous than necessary and do the actual E2BIG check just before
> writing the actual prog_fd into the stack for the cleanups, after
> bpf_object__load_progs() has been doing the filtering on progs.
>
> Fixes: aac5ba0a4d52 ("libbpf: Reject excessive program counts in generate=
d loaders")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  tools/lib/bpf/gen_loader.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 80a6b5306183..555d4757a898 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -122,11 +122,6 @@ void bpf_gen__init(struct bpf_gen *gen, int log_leve=
l, int nr_progs, int nr_maps
>         gen->log_level =3D log_level;
>         gen->nr_obj_maps =3D nr_maps;
>         gen->max_func_ptr_maps =3D max_func_ptr_maps;
> -       if (nr_progs > MAX_USED_PROGS) {
> -               pr_warn("Total programs exceeds %d\n", MAX_USED_PROGS);
> -               gen->error =3D -E2BIG;
> -               return;
> -       }
>         if (nr_maps + max_func_ptr_maps > MAX_USED_MAPS) {
>                 pr_warn("Total maps exceeds %d\n", MAX_USED_MAPS);
>                 gen->error =3D -E2BIG;
> @@ -144,6 +139,8 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level=
, int nr_progs, int nr_maps
>         emit(gen, BPF_MOV64_IMM(BPF_REG_3, 0));
>         emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
>
> +       /* nr_progs includes subprogs and progs that are not loaded */
> +       nr_progs =3D min(nr_progs, MAX_USED_PROGS);
>         /* amount of stack actually used, only used to calculate iteratio=
ns, not stack offset */
>         nr_progs_sz =3D offsetof(struct loader_stack, prog_fd[nr_progs]);
>         /* jump over cleanup code */
> @@ -1139,6 +1136,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
>                 gen->attach_kind =3D 0;
>         }
>         emit_check_err(gen);
> +       if (gen->nr_progs =3D=3D MAX_USED_PROGS) {
> +               pr_warn("Total programs exceeds %d\n", MAX_USED_PROGS);
> +               gen->error =3D -E2BIG;
> +               return;
> +       }
>         /* remember prog_fd in the stack, if successful */
>         emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7,
>                               stack_off(prog_fd[gen->nr_progs])));
> --
> 2.43.0
>
