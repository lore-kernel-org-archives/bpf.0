Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684334403E
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846328; cv=pass; b=fEvWTyDdtCO8w0wM+O4uC96vmpvSODAeyikNKCHt86SoaibhEu/hiIgUvn2Dz+TWGU3i6zbEVeFkR9EQl+IfQybblUTXXOzz+6rmUf6l7KK0F5DQ+4b3ebicbh+RCMwx0OZYrNKQF6bU0g4KLv2TWRnsWiMm5fPDKDm34zmauXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846328; c=relaxed/simple;
	bh=oE5292nTIy9aZKSsNHlN2v1dVsdb+jkr21kUcN6vbsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIPMJmBvf/l46CTDCIKbROzv4BDGP4TlLpIpSXlM+tWqQwRUzk8TSY452Kh/KX0B7QH7cj1HGSDBdxxKnlT8UpVEu9Yoq/qCBs7D9fsAOm6Stf2JCpB59PnH73Q0/avi9dZCiHDea2okekB8bfIyTg7wDXDm++hRdGCg6hkzuMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJSCRBrK; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJSCRBrK"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3566af9900eso1280032a91.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 13:45:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770846326; cv=none;
        d=google.com; s=arc-20240605;
        b=ljKX7JyYWhFu6wTn2o2iwpyQo0MYpGFjLUk9KKyfzi++GoQrWJVtEv9grMtA+ty8Sl
         pBDHKPS7HQAdT+nfGrNkS5E+qkK4miABJN8+muuisSQN2lRs5dCrW6gaECmaj5qMYa7B
         k+zDEjPk1H1bBg31/kjx1skbhZp+HbsRYUhk94v//MmCdeHC3jpHMJiasJD+o7hVNNr5
         vOSxYASUNLMzgp900Xi2YAMFGON4zLPMRKKA80DH5X8QOvVYy2SKSSdXeX3ET4IDz2ta
         viYrELIpa4Fq9dlSU8zYfSkC2FGPKJNZggV7YMk5ASHbB/XBnw6W5NFZ4o6WkgmuZpQA
         vKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jugqz+Pr7LV9DH0N/CO8cgzksjzwYA5ItNBKj2VnUgo=;
        fh=n86t8k9d+3nM7KpJRrd4odS39qTqxgAvIpFrnFJNOnI=;
        b=R4HV7EXPx+bXsQj8kRquJaN19wOLMn0nEZcm0pQnxRZuFOupcU0SAkrWRJGg5SyXZM
         RQoOR+DAMn70Qn9hYCfdK8Lnn37b8O2GqPz3gGjtqZ1tiZjt9SbdrEW7ne5aADPExMmL
         XfGlHZl7JsKDJeSBdguHhmwmV9WGFD+Iwq2WdvJgp7gLrV2hLcqx2NRMv8UC8vHDDRCa
         tF5G4n9ERT5aySODCehVkiWVbPuXtulCSbCze43fBUUqhiUWEucIwAvo4ESn1MPp3UWU
         EzamBqnTNkfJBXx7GXKBBUn3za3LocYZzBbBJLW8NMLo/xZSiSAo+qv+XTO0u1ATM4RD
         eUPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770846326; x=1771451126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jugqz+Pr7LV9DH0N/CO8cgzksjzwYA5ItNBKj2VnUgo=;
        b=VJSCRBrKzxbF4jmLvpLBs6GW++EDjo0qgkCW9V9e00RYBO/iV9VyF4I1kcQuS1u8Yg
         dLExMU43WDcaYcSCwY4nXkNWbwHqQ9DWI2ig6blz9/G7ptThqsaoaInPizurPzi2ROvV
         /5FNMSmB+Wx2+5rR7agsc/qIYrSdG4S4f6X5U1cUgDkyz8P1bxiRhBQVKErZFYpQ2sqm
         O4n/d9gxUCymR58mDZnG8EgeipxY4uAhbCX/wBlJnAdZT84WRKlKTYfxeWHmVd8c/5cM
         eWI+aYQw1/w/EoheiMYMx846Q0wCQIcVXMkWyPEd6I660ctCFSd+iXAuyp9JkeMrdVTL
         kEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770846326; x=1771451126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jugqz+Pr7LV9DH0N/CO8cgzksjzwYA5ItNBKj2VnUgo=;
        b=KLzB5KNYW9E3zj1rg5K8dQ8WAwbOuyXwBC+vAlcVgcqNYi8Y4P32xNIzD+WiKP/3lC
         jwxVcj/y0FSEJriH4dnLmqinCCO14VOdUry+E3e70rvgPmBRckA8gQfXksAX8EYz7+zb
         p56V+hSvrfxaIdx+umzyFG795MQaIB7dzZXmY08lo+JmhNmPiAzswIqTQVBvV+T9poL7
         ckFtjIdZvvgXWUsZPTBtSTk4pIbqO4xhpSTije/4YUNnMK9V5ZW5z+mNFUDdlHak3A7Y
         STm0XWB7Rbu87WeWE+uP5xp0jsXG3vwlgI2VbARlhXdWDBsrdnbc4w4FkNMimfHy2Ok+
         +iyw==
X-Forwarded-Encrypted: i=1; AJvYcCVradd/8Ms0iz9CxmUp0Xkr6DEnZftlv4jf9dq+nVp80PR85Wkf0jGZELbEsMz2JgTYFNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8dg8XL5gaSh1SK96xjwaYsQMPnKHQwtJjbxOOkj1HQ8C2BxZ
	8uDvt0RsGIsNUB52BL2hAjSWP7ww2m8rHaG1Ye5dTwr7kgolD9WZkmKQcoW7GZKSWXearMyjXhJ
	+ciMgy4bRu6sn/kdCxUBlinXMgcTqig4=
X-Gm-Gg: AZuq6aJ1hiYHaNpnXnHWBGd+2ZrIROkXLS08l/bX+Rf324reD6hdhYh894ud8uh4yPM
	S3a18jajhV8ANbtvN2eB6XrGzJmgaQtLPhUSntZRyS+5xAuouK4wi6OI+alpzd7AbBH5vCSroBK
	E1ru8YaYpgH+Fm+u62zzsVoTcrDfhKSk/Sd6+8vhLxT2+L5jDg8bXkFmi4bAt168vdBbjwdf7H+
	kIOgah9EUMdGuuGqKQtwkTZutd30bOUk1dNqMQjX3adMXz463O0QZoZZZWmOJBRMFE4Hh/aoNpj
	LABYEy5UPpDSTA42tBFz0fo=
X-Received: by 2002:a17:90a:d2ce:b0:341:2150:4856 with SMTP id
 98e67ed59e1d1-35693d5e966mr61285a91.17.1770846326520; Wed, 11 Feb 2026
 13:45:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211084858.750950-1-jolsa@kernel.org> <20260211084858.750950-4-jolsa@kernel.org>
In-Reply-To: <20260211084858.750950-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 13:45:12 -0800
X-Gm-Features: AZwV_QigiVXi-vlTXykI0gTexyuGN9GBJj96E_o03_5b43DhFk6mJmCGWE_C-2I
Message-ID: <CAEf4BzbFjXDiQUcZbxpceVTGLa4UGvm76sAuGXEFVREj9FLoJw@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 3/5] libbpf: Add support to detect nop,nop5
 instructions combo for usdt probe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 12:49=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Adding support to detect nop,nop5 instructions combo for usdt probe
> by checking on probe's following nop5 instruction.
>
> When the nop,nop5 combo is detected together with uprobe syscall,
> we can place the probe on top of nop5 and get it optimized.
>
> [1] https://github.com/libbpf/usdt
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/usdt.c | 55 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index d1524f6f54ae..4e5f70bb4c31 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -262,6 +262,7 @@ struct usdt_manager {
>         bool has_bpf_cookie;
>         bool has_sema_refcnt;
>         bool has_uprobe_multi;
> +       bool has_uprobe_syscall;
>  };
>
>  struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> @@ -301,6 +302,13 @@ struct usdt_manager *usdt_manager_new(struct bpf_obj=
ect *obj)
>          * usdt probes.
>          */
>         man->has_uprobe_multi =3D kernel_supports(obj, FEAT_UPROBE_MULTI_=
LINK);
> +
> +       /*
> +        * Detect kernel support for uprobe() syscall, it's presence mean=
s we can
> +        * take advantage of faster nop5 uprobe handling.
> +        * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to sp=
eed up uprobe")
> +        */
> +       man->has_uprobe_syscall =3D kernel_supports(obj, FEAT_UPROBE_SYSC=
ALL);
>         return man;
>  }
>
> @@ -585,13 +593,42 @@ static int parse_usdt_note(GElf_Nhdr *nhdr, const c=
har *data, size_t name_off,
>
>  static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_not=
e *note, __u64 usdt_cookie);
>
> -static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, cons=
t char *path, pid_t pid,
> -                               const char *usdt_provider, const char *us=
dt_name, __u64 usdt_cookie,
> -                               struct usdt_target **out_targets, size_t =
*out_target_cnt)
> +#if defined(__x86_64__)
> +static bool has_nop_combo(int fd, long off)
> +{
> +       static unsigned char nop_combo[6] =3D {
> +               0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> +       };
> +       unsigned char buf[6] =3D {};
> +
> +       /*
> +        * We are using file descriptor that backs Elf object,
> +        * let's dup it to be on the safe side.
> +        */
> +       fd =3D dup(fd);
> +       if (fd < 0)
> +               return false;
> +       if (lseek(fd, off, SEEK_SET) =3D=3D off)
> +               read(fd, buf, 6);
> +       close(fd);

ugh, use pread() instead of all this ? I wouldn't bother with short
read handling, if we didn't get 6 bytes, so be it, no nop5.

> +       return memcmp(buf, nop_combo, 6) =3D=3D 0;
> +}
> +#else
> +static bool has_nop_combo(int fd, long off)
> +{
> +       return false;
> +}
> +#endif
> +

[...]
