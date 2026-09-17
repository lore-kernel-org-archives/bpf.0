Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277F3CD8BF
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673376; cv=none; b=SQSrfdVVc06kaJFsnlCdg48WqUmelKb6vLZHP3bvEaAUPU/SM8x0ygTRVSr7HtDYrNCwym0Koh0Q5toFHPlYTXV1CP8DWxizDDRP7E20qpR4c9ifsWp0ARZWlrwaHrCaMJUxwRuf0eYlDlP8vtvW5Xg9gfLkff+nnfTSKJ+ugng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673376; c=relaxed/simple;
	bh=/X5fmBY9N2F51ZAGnUwxF5L8X24lXU9E3RgGoB9NuLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D39LeAGzOGVBir2siS2y7uGPi0T/3uqM0FHSxjL2JpgL7MDo+VR+o6znbyOttEGmbYs7qk/VR6dosO9QmgJyyaa8ZppTSOE/NrV3VFldhuYwgJxJbPYADTe9Yx7V75UDzQH+W5Mt5uD9aNe+CPedSJUTNOnyl9Xx6peGDzk897k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBPXD6mj; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBPXD6mj"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so17878a91.3
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789673375; x=1790278175; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Rk16+j6EP2/osZ7Z9PR7T2Aj3VzSazi4OFGbepBJGM4=;
        b=VBPXD6mjP+Wckm59asU7+A+/YVzDpqiIkOBVf+iPA/ogW9V4PpaTTJtRcZlrgCxsnc
         MgjRqLJH1+W6AVlPwBcfnaOcgS7Iq1+vAaCv+/GV3c9xaDuQCg6XwrapPxcAaDoxVBbz
         QQTSRgQv3Eda9qrSjw7yBAQJ73r+Epgs4Mpba9d8ge6nWYo2iPU/eY9onb2z228H1U1G
         XZGU4pRWDyfg+3y1/Lu6cgnVFtelFIG8uXTY+pKvfH+vy5NMurXn9qPbbj8sXLQZq8TI
         xvToEMlWT/yJOhbNMJ4JMlzn4vew3Asaq0I5e8Qkgp6p0fMuALIJoT+tG7A6bnFyqQAj
         aAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673375; x=1790278175;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rk16+j6EP2/osZ7Z9PR7T2Aj3VzSazi4OFGbepBJGM4=;
        b=MGW0eOtsWkEe5zuFXXRv7EI5ByMf1fI+80QiRAaHhvJxHVVi56ZxYOaOUQl3A9Gwp1
         VRXoOtTnZ2uQrixY8exCaNcyA/BPeWUoV3CBaUPpnZZ6PGT8xeZxDc4xekGFK5ERKkig
         3RkBnd4uLN5Al/P+70Fxmt1gR54xx4Pn88J8996CPsG91ikd5MA7DoW/ChSeHFuzeelF
         arwOqRjAHpDgiZzF4qE7VrG7cRP8Tzr3TJmd9qXzfcNSoomspnncJ08J8Ztc1uNN5v/8
         zt7W4xhtQWWmQIaKca4a9xOrhlD9we1ojSbLOsRRD2a04w+YWq82xL9kjOthI41Pa2BF
         Auyg==
X-Forwarded-Encrypted: i=1; AKwUvByunuZPwQUfXzHDCQiLbvd378bBNWXyHTtQ+KPTaAyFd4y4BSTgUzJWFyFChRXTJY2KS+g=@vger.kernel.org
X-Gm-Message-State: AFuF++lUo3A3XoQBIz27JNGWIv9lDakD98yoELOqOFOco3QqhsupyqSs
	qCACxZsB2FNempA0mCihytOIBjBZiCZ6rShzc/JtLpnkuMp4uUGSrOYR
X-Gm-Gg: AYBFou2UUxlZXcTwc6ZTW+XAqgr3Eyeb6WjjKITRq8of0QcC9ZCfP6b9XK/h4wUoTYN
	9V9Z6VTgDoqIVetz0STFvVOwW6ZHf2bq72eruuava0pSe6snjX3QkidmSApww1hPy+4XzKKq/WK
	ECY50Cdk6VQ9ld52qXUJREA/HiSrYqOomTm7gNq6NbDLv/pgyLrrBraemhgCxWeR6U1WgHanXix
	0BKOQrRku+v4IDfA3+20QB6Ynu024l27Yxd+iW232wBz2mAkQoxwYInXRSBJa2xxEYzauwlxjFO
	7gFCqZ2IMXYeU700nxB4p1hRRtOj2IoWtqJO4xBlwmwcCy8Rkf7cTPIpCd5SCd6Z6UI2NotBtyq
	uIlGVgZ7ITaQF5B4tarKPM+t74HF5AqfsbZyPEkOLg805U0FZmWrVoGiqTX0XdNK+L2zMgjTamS
	G4SdJ/QvTc7HW5A3r/9Y8BFdfADZp9C/hcWlNo9fmGea6IifRxhAP0qgMt3dV9okw3BU9fKYFYg
	aOq9qtHIuAEnd+emHvi9cCqAnU=
X-Received: by 2002:a17:90b:3ccb:b0:39d:c3bb:98e7 with SMTP id 98e67ed59e1d1-39e54c8a08amr394507a91.6.1789673374675;
        Thu, 17 Sep 2026 12:29:34 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35df479fsm6541931a91.6.2026.09.17.12.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 12:29:34 -0700 (PDT)
Message-ID: <5e9f4e3ebc09b18449bf4f5ac975747ba9fba64f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Fix generic __uninit kfunc output
 buffers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, Amery Hung <ameryhung@gmail.com>,
 kkd@meta.com, 	kernel-team@meta.com
Date: Thu, 17 Sep 2026 12:29:31 -0700
In-Reply-To: <20260916192805.3991983-3-memxor@gmail.com>
References: <20260916192805.3991983-1-memxor@gmail.com>
	 <20260916192805.3991983-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 21:27 +0200, Kumar Kartikeya Dwivedi wrote:

...

> @@ -8885,6 +8889,16 @@ static int process_map_ptr_arg(struct bpf_verifier=
_env *env, struct bpf_reg_stat
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static enum bpf_access_type func_arg_access_type(enum bpf_arg_type arg_t=
ype,
> +						 const struct bpf_call_arg_meta *meta)
> +{
> +	if (arg_type & MEM_UNINIT)
> +		return BPF_WRITE;
> +	if (meta->btf)
> +		return BPF_READ | BPF_WRITE;
> +	return arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ;
> +}
> +
> =C2=A0static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u3=
2 slot, u32 prev_slot,
> =C2=A0			=C2=A0 struct bpf_call_arg_meta *meta,
> =C2=A0			=C2=A0 int insn_idx)
> @@ -9176,15 +9190,16 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg, u32 slot, u32 p
> =C2=A0		enum bpf_access_type access_type;
> =C2=A0		bool known_memory;
> =C2=A0
> +		if (meta->btf && (arg_type & MEM_UNINIT))
> +			meta->arg_raw_mem.regno =3D slot + 1;
> +

Let's avoid adding special cases for kfuncs as in two hunks above.
Please consider a rework as in [1], which makes processing of the
arg_raw_mem.regno and MEM_WRITE bit identical for kfuncs and helpers.
The details are in commit messages (partial slop).
Not identified incorrect handling of MEM_WRITE for helpers
(MEM_WRITE should imply MEM_READ).

[1] https://github.com/eddyz87/bpf/tree/kfunc-uninit-tweaks

...
