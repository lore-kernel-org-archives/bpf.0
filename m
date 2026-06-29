Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857C3C0A1A
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719167; cv=none; b=nh42oZs9aNLTDAE8aYG8Xh+D3FzQ28rFlCpoqotUtPvI0uE2iwqkBd80eKvgp/Jw209PD5Q5tD/llHvz83Y4BHZZRvnjiRbLHGCWY3kFGhsfzw1Kv8orlOYF65A+vn2PdlKA8So5Q2ykRkBm3tlJJlQlZyl0sxjK06bvu2Ty+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719167; c=relaxed/simple;
	bh=zFYUsp6cZAFkDPIxedrWMdJ7ZDRRo8HHSJBabY52+H0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dWdhv0LGL4oFX5Cm0CzNTO5vZJGtKczgubV8i7iEB4wv98XBH+O4sYEbTaJlNYB1cqLu2BwuP92qhSDR+Vo8wvlBBWAswxDR0HQrmBa/UH5eXXkYo8Z/UwGly3rT5LtHR0pA9+yAkZjajBJDH9WzLPaYrCN9QZQzESuwPoh8lFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=hy91AVy+; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="hy91AVy+"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-519eced8cbeso45407641cf.3
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 00:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782719161; x=1783323961; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pbIiit9pfor2l9pWPhnUoGC5XO11upoc9Oyxmk9rY0=;
        b=hy91AVy+vMGapfCLqz0n9gJ7ptn6BNt7pbVp5dWqPKOm/KtH9+Gu6/kv5tuOU4sl90
         29gRQDbyNj3gGDH1gnTTPcnQrwdNyjSgyUxmFIDAs8aLk8+R+zalS2QFLyFZpeIWB5Hs
         7e8kvH6htyYRNZC/8FXWUXl6sJzl4hQcmwJEK78lKMCYBU5ghNdcd1wKBqcsiI8tcgZi
         frmYRMWh8VgzSEOsDv1UlRvNARAKyCXKBWfzX3ubBo95wRyQIO3qkI0uAf0y4Or8xyoX
         iNFcBfia/c4tU1D0mvIhDDs9nBJiDCdotydFaFI+BnqWyjemsWB0BZBROnuWIowe4d60
         sHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782719161; x=1783323961;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2pbIiit9pfor2l9pWPhnUoGC5XO11upoc9Oyxmk9rY0=;
        b=VS7stsLgKHGJZ3WdhOuR9p27FPOl/apxupUMojHZW8VRJyQxIFOso7WaS3I2iQf6fa
         vyemPsI8dQjjfuYaZMjfJHo5ZH2lESlNiSO/NbIWYrsGv96yjw4SdEa9nQk3JXZPkKoI
         mX+c1KNlsYbUEvBNCw+l6XWP+aBtOewe0twOQT7uczDwuKkX1bo9Pg8B/0gcH4nEmUZw
         fck+CN01RmJzYQAWLDZAKD3HeTsN/HOuYOLLoDHuVWOrpM+ZCKuYrW4Oo4g1bGOHltTp
         QgzOWm65yeNIAeCobilbQT7Q6w7zMWJzs7vyMkiUiJWuz34LR1X3HXSoaB4udsT4jUHU
         fEuA==
X-Forwarded-Encrypted: i=1; AFNElJ8uIv3QlagZn/m2usSpMF67GAsA/H0VxyYe+1XwLfrowMBkQk2ioKN/dhN6QIMw8PBURU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8s5ncYP82m6bkYqUoK4ETnSFn8/uTpWLWqOzGjjiQEmFTRV2O
	3TUzH7U3HaHi28EilyXRI50gdoiMIDzKnn8O2rQB6/ag7iDAtCmcg1tf79ZG+RfPkJE=
X-Gm-Gg: AfdE7cmpF2Z9528OoLwJM4ZG0X0wj9v5k9Y6uvgXMWKfsUN3i64e8GFrBbUYCpUTy8j
	YVnOw+eAvolkXJgAy62nZS+v+si9mof37tHyU9Wae0PwyozOuf17+8rcN91cnzafnFBLPcPvnAs
	L1nnJXW6HZoRQyjIxzXfEM6YTAenB2ISciHkB7Ob79RiWRMXj918JsCedugBS4jaccKsusFtu3D
	rQ3lKvyVjA1VGPzb1NJ5yXCDaQbapbhoEVucFjumyFiDXOG4M5fip5IadaQXYOKfb7JlLSo+IHS
	8whTcmodbTjR2pVk2FRnbepbUbW8hAm99PuhnoJEaGGyc8TYqFgXtnUcUpfSl8STvVb4S5DC2RT
	TiChLC4DGkOusqx7mMdARNbzklQ3H9F+Qw7TSJGFpS+zzx+9ZpOo0aUrbPuOiF0evcGAdVesSr9
	MEOp1GtMOqYaM=
X-Received: by 2002:ac8:5847:0:b0:51c:215:3e7f with SMTP id d75a77b69052e-51c02153f5emr17392791cf.24.1782719161029;
        Mon, 29 Jun 2026 00:46:01 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51bf1457825sm36962201cf.28.2026.06.29.00.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 00:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 03:45:59 -0400
Message-Id: <DJLD780OM4II.3JG0MOTVC3L2K@etsalapatis.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] tools/bpf/bpftool: Reset vmlinux BTF after
 struct_ops commands
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Yichong Chen" <chenyichong@uniontech.com>, <emil@etsalapatis.com>,
 <qmo@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260624025055.1574875-1-chenyichong@uniontech.com>
 <9F9017160ABE125F+20260624025055.1574875-3-chenyichong@uniontech.com>
In-Reply-To: <9F9017160ABE125F+20260624025055.1574875-3-chenyichong@uniontech.com>

On Tue Jun 23, 2026 at 10:50 PM EDT, Yichong Chen wrote:
> struct_ops frees the global btf_vmlinux object.
>
> In batch mode, a later struct_ops command can reuse stale state.
>
> Reset the BTF pointer and cached map info state.
>
> Fixes: 65c93628599d ("bpftool: Add struct_ops support")
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/bpf/bpftool/struct_ops.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_op=
s.c
> index aa43dead249c..835e5e561f7f 100644
> --- a/tools/bpf/bpftool/struct_ops.c
> +++ b/tools/bpf/bpftool/struct_ops.c
> @@ -643,6 +643,10 @@ int do_struct_ops(int argc, char **argv)
>  	err =3D cmd_select(cmds, argc, argv, do_help);
> =20
>  	btf__free(btf_vmlinux);
> +	btf_vmlinux =3D NULL;
> +	map_info_type =3D NULL;
> +	map_info_alloc_len =3D 0;
> +	map_info_type_id =3D 0;
> =20
>  	return err;
>  }

