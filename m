Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87E946A
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774106115; cv=pass; b=syHkWgqnXeWXxpQa16jCxzJ1UE/EvEetp8W7Y1J4u2vupfB+TtlnAQqIftUfFcskzMPnhQC78JYMG20BNxM353/7cyH2r+NjdFXLqDFPhI5QCU9NaZfDXh+HkA6XelMRyJX2Ny5p7lXpWGr7L8SV9Xv/dsyz8i5r4yecHqP6j6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774106115; c=relaxed/simple;
	bh=5mGL6JLmgZWYyU/qPf6tAQJtZcST/RrT21ppm/U7itk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgTYn4/xlJ9PNBwgFIsbarh99EMEEfGQMDA2yDAcpuBxvNhHLIh2ozq8aW/E8aabvxW8fed1wNqL7PGaAwV+bSZUnhqhc9uoOxro4bobwhUDiBy1WOmilbTZSyJ7AZlTxCYn+z+n73Kqzq1YW962qE9eTdYzOgARSoM1OMxzbK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmWDOwwx; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmWDOwwx"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ad46a44easo2599266d50.0
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 08:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774106113; cv=none;
        d=google.com; s=arc-20240605;
        b=BGkhnt17DRk2KWR9a6JVkhrwrgnVK9ZVkw/bvT+FCr1I+QSq20W/zFQVTFtoN8Ippi
         eHJlffaFs8Ncds9sgo/M0M7rQOWe4RfSAVs2YayvI/Ra34lr68WAj9Jjj55KFLkAxNNA
         FiikajCCKjZt1+RnlGuHYydP6enIp1IJQBe4W1xwTLa+YDjf3tUbbeT56ivDji9TPvjG
         GwIyhkvxUkJM74C6Y+cdWJMzofX2E3WBRzgPE0Z6Ir0hJ7GC6vB2XOMxo0IJlxVChxaS
         5adLQyc+ijxDxMjEedlgC6Z3hhSedt101zRJ6UMQ+uI8AS3sK7H6mm98+tACtc/uCmXZ
         QCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UssSeiCRIOH5UnxRZFcsTlvlkmDNNOvfP0OrvrwVLmM=;
        fh=GNCVTFOGbDeZMVxymcUpItqckfGv2r2aR9FC+xxka+c=;
        b=LfeIYvGTWAr7KmIcOXEXBmSt/mqdZSApxFQNl+Da8KG4yBqM3oDyX7uZkstl6RvCxZ
         w+OwecGKK29egoSo/ytm0r+jfAtEb297WIAQGeDaVI9vhKVpfgrX3i0mFP+6GD/hBdfT
         /quIQINlqdr49BZQpeJb9fcii6+4Ivz+4HzISyacxQRPBUS9zX6NtScWjTjy0vn3BAoB
         umosy/8JA9zCLKYKg9L0riarrT9cMI4WAEI5BcxQVIEKZLFUR5CamFYU0yt2Spc4l6yj
         UNpKLEUHdNgG+ZbwwRv8Xj0JIppAtH6m6wEz0e6WXRI3dQIA2VfuZNFmcxVKvIBDV6OW
         6R0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774106113; x=1774710913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UssSeiCRIOH5UnxRZFcsTlvlkmDNNOvfP0OrvrwVLmM=;
        b=kmWDOwwxtZAVXPqj3U7nhNyQTo9cs1FvJIIqBwngV7GsC4Gz0eAnFGLtmOwCyVLOx0
         j1o4eld92KcdEMCR7qqosEX3CZUnGVFsIJYXvmgH/29YdrhQw8eaOnP1p5Lb+7GJEY06
         +QNib6YPBm5XfgkCCdO2hDunrdxiXmI+o7E1hm59uH0D5tKC/HCp+S4Acx/5TyVjMsAH
         d4rSP1H2zW9IW+Lj/5ttRNpa9fKN4/DITCazai9mmFtY5d1x8Jwc9eIkMk5gvA+wdTr9
         58xqLmMTMPnaoH7lS4r7Mynd/0QUszH9FIlgtkJvqxlxxjuVXcMD6ZlnRoPYtPyyt2AY
         7T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774106113; x=1774710913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UssSeiCRIOH5UnxRZFcsTlvlkmDNNOvfP0OrvrwVLmM=;
        b=RgZ1O1AFYm2MMIDVadGmaeM8eSC1ixOPfZ1gZ8rSLCYFnmIsmTnaiVAJIkyuGkustP
         P+AT++LPt59gJqwyOZ4UJSf5lNTLHCT/xORxUqgN70tyj7euTSpnOhqh5KLkMo+OUR9X
         /teKluZ7QvZ1hi8FeBSU50P47NTNIhcZtM7G9INjMx21X+SEf+N25P+QER41zbDx0k7V
         SrOrRBDerD+zM58VBVtMoWlgITMf3tdRN6zYhehhElztGgceO23uUdsDPB+3/yZqRioC
         wY6mdcjUEAsLl7fRe6zbqJcy76WQxsiA+paOcnn5xxHt5RgRIoL5000nGvDm+m1MJB7x
         uPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX/1HFp8k2I9P9QtyB53W/fRIrlRymzQElB/OL+TUGzY3Idk+Xoi+8kSzuO2y0EFxL5yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8cr/AE6w7WTIraWgAT4miw2HBl5TUkrz0235i7Gea2pCDtHp
	wmA6f9R/fhjwf8UV46aiPIHIQylAUh01Ywp6BcavYwDSY9QwjefEOEOJVlICZ2Tqg4Iz8DQc1GF
	otoIiH4zv/cU8qw0v8ESrKdbrRlmwVbw=
X-Gm-Gg: ATEYQzw4w0kVwpAxNlk9uYG+HitD2CThafv1tvr3Rhlmg8NKc+eGGZPMbk0iqEYJC0y
	fEL9ZN4PiJfB1Mxl38me6OvACU0753ODK2wwQkqrwkZdXsAgl2GgipyD0BMTjfAr8aB5miyNOtc
	ljSp8HVf7NgpjNdAxzr+obsrUkJwbJLsGTVyrCf9FCxn6+/53fJz3QBtY+oxCCEbMgQS5vxJwrM
	ST0TnbMA3cv3jeVmAI4sL++2HesDJ6o01PWb7CxdGzJok43bV+PBCxM3LEATpLV0WqTaE2/JM31
	vz1C0gw=
X-Received: by 2002:a05:690e:2148:b0:64c:9d01:aa66 with SMTP id
 956f58d0204a3-64eaa7f8629mr4933310d50.68.1774106112934; Sat, 21 Mar 2026
 08:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320130219.63711-1-keisuke.nishimura@inria.fr>
In-Reply-To: <20260320130219.63711-1-keisuke.nishimura@inria.fr>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 21 Mar 2026 08:15:02 -0700
X-Gm-Features: AaiRm524IURUaLU_ZZAK1W4WFYkEMnn8cpPmIw4xpR-I_AUQgoo6W0C4j2gA9nU
Message-ID: <CAMB2axOSUF9MnYnKZiBNpGMi_Ay81Ph3T6L83yG3g9A=2grNCQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix refcount check in check_struct_ops_btf_id()
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:45=E2=80=AFAM Keisuke Nishimura
<keisuke.nishimura@inria.fr> wrote:
>
> The current implementation only checks whether the first argument is
> refcounted. Fix this by iterating over all arguments.
>
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> Fixes: 38f1e66abd184 ("bpf: Do not allow tail call in strcut_ops program =
with __ref argument")

Thanks for fixing this. If there is a respin, it will be good to
include what problem it could cause in the commit message. For
example, a reference acquiring struct_ops op could tail call if __ref
is used to annotate arguments other than the first one.

Acked-by: Amery Hung <ameryhung@gmail.com>

> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 159b25f8269d..278443118a23 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24853,7 +24853,7 @@ static int check_struct_ops_btf_id(struct bpf_ver=
ifier_env *env)
>         }
>
>         for (i =3D 0; i < st_ops_desc->arg_info[member_idx].cnt; i++) {
> -               if (st_ops_desc->arg_info[member_idx].info->refcounted) {
> +               if (st_ops_desc->arg_info[member_idx].info[i].refcounted)=
 {
>                         has_refcounted_arg =3D true;
>                         break;
>                 }
> --
> 2.34.1
>
