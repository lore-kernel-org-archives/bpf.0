Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793754317;
	b=fArWg86qXccOzu5hoUiCJGJSd+vPwxUOfESuHuxQ4rodWLS0XWIMiR3VhjkUJamVWNZs
	 u953ftpkt3iXO7EdpQoNPVfyC9wPPlgGGOD2pGkGfEy4t2tCeE4EH5uo1LFE0ixk6g0Xy
	 oK/5jFkqeWqhXfFQmVai8iMS9VbnIzUjyWC+6Jfw6MEQ8iRTKmP/1oCFjOly9i27wtRXp
	 F4T2NTYg88GJn85y2pSaOQ8S9GLjsX3t8ur7xKnjeB7tiA2kkBKXxyWsU5/FaP8HIQ9Je
	 b7Yx7daWvVVODz5RpEr5XNkSTgH0i6l9LK03zOK27Z4ipOcEh7+umg6iFTptj7mpmqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GGVgNCMMS0dFIobhgfKFI81188J1mL3nz/OKckiJVo4=;
	b=HwPpjGyObx9z0ZRUal8VSjWmC5AR7y1pQmWiB7E8ykhQfrt4CZ7jQrDsSLToloa2XwDx
	 Fzo7KOHUOkaGd+GdorGkvMzxkHZW4tBl6KL4eFGRc6ZIX8WqO4WHeQyPUltWHSRsSer7k
	 pgK/fg6cA/0OQjpYpco3zlZ91Uxx+D3WtYYmkRjxqQN6I9EDqz+/5wTgCgSrek54UsbKt
	 ZNoRyLDEKPrTJhClIgU4aKjvJ/4g9654CeKdUGNQJT1+3nYSwUJ/HOWPb9T1yNV7dMMVl
	 Ng2p46ZyuK1ofVe8YC1fCynKSlMlogw5x8Tcwwltb0Zkul2vGE9aqPm8kaciiDowaIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="NmCY6l/h";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17074606A329
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17074606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NmCY6l/h
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4ceaee6770so26203666b.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:05:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793754314; cv=none;
        d=google.com; s=arc-20260327;
        b=LOD/i/NB6j/MGr2X8TqNtDmjL7u2ELcdqa+mg0r1X+hgkm2eN9Q0DkWfsEVahgRbMV
         kwYd/oXPyRoEMz75qzqIoVHwMhA17piqNbNp7MJriDQdoLErXN1pc+o25wdfie/Y1e/c
         yLz0kfI19tnvXoDenh0THECBgUPN+xn6JuK1ZnOjA8wOlX79ePInMXOho/QNSCxbUPHF
         mXwETGnqy6fNO1zCoHjTf5xaJLvpWLm0nLa+IMttOI3vZugXxZn2WgrvWLU92u8fc/iP
         XJ/yagUgVxSv1hyzeZHQMvkfAizoWT+AbiLzWfTu7y0qRH7Y254fqxsKF+j68gswdT51
         Wfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GGVgNCMMS0dFIobhgfKFI81188J1mL3nz/OKckiJVo4=;
        fh=jIjeNRuOt1UDKxb09L56jMpuk86CZ/SIX3QTfrabWnc=;
        b=PCBUxmFVIglYpW9SoUO3REcY2Uj/gSLZb2MlGH9OuNVNHjY69k9IRkuiMtw0WLaZI2
         T4nlOCq5jHuXQVSGQnPlvsn0b9LUkRY4CXwutzNdr7umOwT+W3hj0HZRaLinvVLQV5FN
         B+jakET/+/gsS/nCJ7DxdBnN5ThH3Z9ig4C38cTM5haFaTmCEqlgfyjSVOR0aMjhVFg6
         YTDLCuSk2Oj0E0jxulJoAVL0Xa9UUSQNjWi/Z86Fz+hPgJFcdthSuzehYv4/m+UTeLuX
         7f5Or3SyKV8CytG/0qTkd7OHjSk8rJZCs3EL370oovH1BclWl/5F5xyB9XgxqZonOMnQ
         ezAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793754314; x=1794359114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GGVgNCMMS0dFIobhgfKFI81188J1mL3nz/OKckiJVo4=;
        b=NmCY6l/hddhLIayqwx0pWhDlzky4zOFriG2Pdv4bVgKzrRIN/6DXrKq8SeIFpFSDzG
         OSms2h9cDJSkVBH5/IkifIVYnfvh+hsyQJtRrGsZdUmtb2ziewUHbbsX1RP1CEZB5HxX
         iy51pExN69DyKyexFvTHkYAxYP21gKZD8XowMLSFZiekG7RpaJCHxS4fldPWq/wG8Dtt
         kOM/cipylAMQawMEXaxMxu4+TRBFfLAxSQw9WjmITlds8lBIpEAlzKgdz84Ey9gExnv5
         /B1iiJxBuoY8in0DZjwRakIl1gpv9h2omGVHDsDWWmXteA1WCj/AkvnaACWyEIR7eDwF
         HTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754314; x=1794359114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GGVgNCMMS0dFIobhgfKFI81188J1mL3nz/OKckiJVo4=;
        b=xlB9VpqyAVJReLVJNNlVKrwwsnrZowdDp+j2OcU0tc36GakO0sN7Xr8BV3argVq0Bc
         g5qpbceO1ZAa/G5Ph0SN6SvpvbqjtNBXpE8aIOoEH5Es+E5kqszK0g1zdF6NZx7CIRQ6
         rlv1F1THh1eZ8LyJPgYN8CLAp+nGPQV+AHsXNPm0b+zuGtSQTrCFPVNEXxZhwdQT4kuG
         sij1MZfQH4ua0tPUSQNpC7jkHg5Ntc4QCYvWgmbngtjtBSnaGdJdbgNdnRzQ49C0Ghzn
         mLJhHAVGCnHRyI7spsT3JEGGu0tUxWS+I8pdmS9j1Ay1U9i79gfMlqFdGDyt9hQ5J5+G
         I5xg==
X-Forwarded-Encrypted: i=1; AKwUvBw28+jLkUrGg7x3jekTJ1O8sDvbfcSa1Qo1kWLt3Asd5Ll0xQlAj3tDo4Wse1YrChnEZf4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kMWokdYcqTDGCL7bJ7uXykQIzqV53BaKrSqv3ROCDP5laC0mF
	iuOGqlnOwrW4UBEfCalM9YeY3TXcTzPQwjLA1JmUqpE116V9Tgc1vikxivpmN3vOrsyMAxcpMN4
	TGMFw/EJQWPCEPvKUtKBgTYtkL/xt7cfGWfdhZU5t
X-Gm-Gg: AYBFou368ncIjw6c8EWOv87HR5tRDvFcnW6Gz9or2uW/kF8DLJqVvEYZw3bjL6lp1vg
	Hwo5kFWikDBuaHuBXfKveyze1k1hJ2L4eGQyM4TE2UFkYxYU4Z5QuO+FlM0Y/wiNOtcY0y5xVRw
	UK0oOBlQB0L1YJCpE8Oe+SdU8p+7kyIvxFQHNwhaCf0ACSDkrxWyee/YtzWXtLw2jPJug/cokeI
	EvovhG1LW6cxoaXAJYvyPmkSQ4wi1F1tn9LMkGyKxv3DmV8H8ho6ZdAbLPuEte6p2pGAohiyd4S
	J5AghSWnmmvOpS3Rl3yZ8t+OYllAl6cAg9ak6QIqHobTztVe+mOmVbULl8RWtTqdHtIa95JE9f7
	iN/CR5kWRrCulN3liKsu9WveH1svL0lQpKqXwelxkdmSZndxawLIRmx8vwEgT2htYPqapmrw=
X-Received: by 2002:a17:906:c145:b0:c46:7ec3:fdfd with SMTP id
 a640c23a62f3a-c4ca7a1c3ccmr1392142066b.14.1793754313888; Tue, 03 Nov 2026
 17:05:13 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <CAEf4Bzb--Jzz696u057G9_CgQN7zf6ksvoL80KJacKO2CorsnQ@mail.gmail.com>
 <CAG2Kctojb7xiOqTmwWqoAKFaNUECjOzXVc_t6KbG13Pqm2dbng@mail.gmail.com>
 <CAEf4Bzbs8F1DPBz=WXVTExrrNjzvaFsi4L+HEj+zbUTpPSTX5g@mail.gmail.com>
 <CAG2KctpSTCyWQHgJ8GyFEhHPdFawUa6zy0g7rkfCcujJRN6f6w@mail.gmail.com>
 <CAEf4BzbyqPC=RQGWEdpkqu1WDQ2_S0H8pZU2i=_gLuSDQtpFbg@mail.gmail.com>
 <20261030153528.0d5113e7@pumpkin> <CAEf4Bzbw6hZ3T6uO-ah7c0+K9_kc+k32hV88YFP=qPnHos+-AQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzbw6hZ3T6uO-ah7c0+K9_kc+k32hV88YFP=qPnHos+-AQ@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 3 Nov 2026 17:05:02 -0800
X-Gm-Features: AclHuK9b_Pt7vf67g62PZ8vH_eaq5fO461r38gdQA-3gsipu-4DIyrTVCZocpdU
Message-ID: <CAG2KctrmAVo-jC5zHURvx9-V_Wu4U8PctxEevycV+zq+6GngUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 11:42=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 30, 2026 at 8:35=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
[...]
> > Doing a system call for each symbol is probably fine and scales nicely.
>
> Yep, I agree, for BY_NAME case it should be totally adequate. And I
> agree about not needing to do full count, just whether there is more
> is good enough, good suggestion!

Makes sense, thanks both. Nearly all symbol names in /proc/kallsyms
are unique (~99% on my test VM), so I'll have v3 keep the kernel side
simple and let userspace apply its own duplicate policy via one-by-one
pagination: KALLSYMS_QUERY_BY_NAME takes pos (0 to start) and returns
next_pos across all sources (vmlinux, modules, ftrace, BPF JIT, and
kprobes). The kernel peeks ahead one match, so in the common, unique
case a single ioctl() returns the symbol with next_pos =3D=3D 0; when
next_pos !=3D 0, userspace can step through the remaining matches one
ioctl() at a time. libbpf does that and still fails the load if the
matches have different addresses.

Paired with a prefix flag (KALLSYMS_F_PREFIX), the same lower_bound +
pos/next_pos also handles suffixed symbols cleanly since they're
sorted: querying <name>.llvm." (or "<name>." for .constprop, etc.)
lands directly on the contiguous suffix entries in the sorted vmlinux
table and userspace can choose to step through clones via next_pos.

[...]
> > You'll find that _IOC_SIZE() is used in many places.
> > Amongst other things it can select between 64bit and 32bit compat struc=
tures.
>
> I see the trend to stick to fixed sized __u64 and __u32, which allows
> to not worry about compat. I'd go with that (we have used that
> appraoch extensively in BPF syscall and it has never backfired, as far
> as I know)

Ack, I'll update v3 to use __u64 fields throughout. There already is a
precedent for this, and it is simpler to not fill holes that __u32
would leave.

[...]
> I'm intending to fix PROCMPA_QUERY's embedded size (so that to
> user-space it stays the same no matter the evolution of PROCMAP_QUERY
> interface). I really think we should start with embedded size zero
> here and have size embedded in query struct itself. This is another
> thing that we've been doing in bpf() syscall for a really long while,
> and given how dynamic and complex that syscall is, we had a great
> success in building and evolving API in such a way that user-space
> code doesn't have to care all that much about multitude of different
> versions.
>
> I'd really-really want us to not have
> KALLSYMS_QUERY_BY_NAME_{V1,V2,V3}, it's just a pain for user space.
> The evolution logic for versioning is simple: if user space provides
> too large struct, unrecognized (by kernel) fields should be zero. If
> user space provides too short struct (for initial version we can
> enforce minimal supported version from the get go), then we just not
> touch any fields added after that size. That's all there is to it.
> User space, on its part, just provides its knowledge of struct size,
> and then kernel will implicitly assume zeros where appropriate.

Ack. In v3, I'll update KALLSYMS_QUERY_BY_NAME and
KALLSYMS_QUERY_BY_ADDR to be _IOC(..., 0), and so the sizes live in
the structs (size; sym_struct_size for the nested struct
kallsyms_sym). Sorry for the back-and-forth, David. Also, the nested
kallsyms_sym needs its own size anyway, which _IOC_SIZE() cannot
carry. That keeps userspace free of V1...Vn command variants as the
struct grows.
