Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F216346784
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216807; cv=pass; b=r30hlyi+nEpGgqgwB2hEUoDM1FYZH0vaF12wsaGq4ETsgDpBZvF3jFEWiccNAZouCFkDOmbQUPD8E1W696Mm7SMPuKsVpgdzSuup8XREr69koQbYm4UU1zlDWvXUCdbTYzBXisVUELwokD8Xa4AIjXXWQ85BKVASroT90s4G4oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216807; c=relaxed/simple;
	bh=Mp7e4yjhYxRDHFkPbMdL7drS2HhsJ7YpzanX5ys7ayw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/oCMUhs8uMN/LSX9aLFRai8uByJSZwCgDUGZUvZcHGiQ7z0yft0qKpRSQTlw2cZbzfdAAIqq+VpAfBqB9nmZlD7Bo56T75s+IomlinvostrA8wmMNTMQQF87WLJ8biQ98MslmJ4knyPjvU4NhWE07yI855oxUo1bWcO5WY/NIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RiUaPP8r; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RiUaPP8r"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-516d6009380so1501cf.0
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 01:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780216805; cv=none;
        d=google.com; s=arc-20240605;
        b=fboDFr/78DeC+PcjMe3V8PsHQ/6oL3WaIotDWwTKifEL5j8g+mdeHo4MfcQDxHEEKg
         ugYLyr7Bi3qiO4Za7mPV9Mu97f3aIrgzpbRGaM+2Gm2tbul3uxIjbCJKb5UInhD2T+JD
         P/Q7pPEWzHXKXy4OWRulect+bXfnZP9goAtZW5201LG0L4VeCJkmhZvCwFmwwcZDZC1h
         ZTJqBN71Tyb/IdCU3sRQJG3ovOP7RFPPCjv8y19O8JmCj7+2evIfIVDVtMXxjdojjxYf
         OQjPLlTyi9LDI56FEaun+C/+Mm/q4jlJicAKATxOkPZ9oPM+EsNqmJKWE1vA6guWi1E/
         UqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XP+5mGhuqYWyS6t2C4j6lLBTd4uy1YHWUAOZS/b8nWU=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=gw+yTTybmu2rN1DzVIdiAeknjrmtZP3qgbOEbsGrRQA9WHct2w8FNWaNeYWhIA4oyK
         5r2yLaViqBZyMaUnn7IsrpoUYLJG4Ns/Lk0fV7gqVNs5KUODbQrK6Y5sYnWELG6V9kjf
         ZJnQn5n8vZuKdKCjJYoxcpKlakxWsOpHD8lKwZ8deXpK05Ga+4n4mjGXsv8rCWs528E7
         tLSeu+P2ii9krSin7oUYEnPD3e5LvHeoG4/moMqXcM/8MQuceIDbfsxo82bg26ah3yQA
         uTNxbta75MGaOB5zVvGIopfnRqimJq/rCtiLIUV0pWQzP+y65Jq4e8e6boVcgogYom5s
         fgHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780216805; x=1780821605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP+5mGhuqYWyS6t2C4j6lLBTd4uy1YHWUAOZS/b8nWU=;
        b=RiUaPP8r0zlNiNaeuIPNI+mtwrCLu9/cZNiyW61leTQjbEzYFMCe1026Sc+sEpb9f2
         zE0kGUXPJgTZjHXRmQIJvOl9b24yNfr6jE2trwk4AANpqELW5qVb40MKCQjxcdpYRmtu
         fZ2RCGuqBSfCME0jdShruomIkFEHQQzQbaLet2tTwy/dPaEIwmOay+xdg4d/KOS+1bCu
         Oi1fbfXBM3Zx6cbgF8Tim9Wfc0x72o0eobAlioWc2QjtTRShSoPvTF6fLAbnGGGerHOi
         2atbyIOHuOsp/OwCrBmI/XuSU+XilU2RfUFU/kUiREaZdIPIH3qY+mVadk7Xfn1DFXBQ
         2PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780216805; x=1780821605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XP+5mGhuqYWyS6t2C4j6lLBTd4uy1YHWUAOZS/b8nWU=;
        b=gCwkmxCxQYz5N63Cuvj72R/9hBEq6mnOO3xNx/ThSTmh0R0kYY8j02ecwve11/dE3n
         K+qCgwMFMizfxXzHskb3bgR0etUDVdTDAFcN4nG0WwtB7HFrSlLy7zfZtMtM0LKBFOjd
         6oLtPSy4kzUzrYN82fQ1sfw9pSLGritVO3OZO2zu6viIuFrXSYiHNmrrN3nxHdb1pGGj
         06g0p+N6CtG1ZpQCJDy+iIljsn0yF1oTBD3lcF5mwfOPSPB/gnGtBNiJLwotdjTo/Gqx
         zC5sJsgsOIdoYZ68ggifEmWQvUVGrAxG5ajnAw1XxBkMrbs7aXyTa7c+FxKCktzXzxpb
         X4lg==
X-Gm-Message-State: AOJu0YxmvoQpXrzxK/hco1qNF4DrNIfc6g2QlhMOrWIkCTBcP8YarLK7
	OGImBGrerJ0YyyJPIl4WttS8obyi4bWjcA9KMM1psy0gkxNyQzqQ5XbBjpKDgvlHdjZXZG9r9sQ
	icXZCn8pihHwjvWYh5z1aGwFSzcaEOs9XbYWbIQ5ksBOIgSxt5lc4HTkZNUJ2FA==
X-Gm-Gg: Acq92OEM4geTqPaAf+R8khwFE3Zc6k1YGsKz0NdeifVjCe3feBhfMyEHxfLMY6slHkd
	V/OLnkcgYQgENtWyhFfkwEK/VoHGXrHrwwOJovrZAoDJwjUlx2Yg0VcLOhLDux/Tli7IXbquh0f
	KAbTZrYLxrmq0Ol/JKyzmK26gnZKDDaKaHHyexgmLrmxALWF2XVHEfawbOhRbF0xKsA1lgHLpo4
	vP2V38ktEJ03mQwjOfSY3JolxqX53k4EdTEvEFYtAT4tus2RLgPMXYRMOmNe3ZPSFLbGSOOQP2y
	aqPbRFxxbDRGVxkJyMI2bEzVjc7n/nEeZnMeE3XbLaThhopFkuLVtRmFsQn2Lzt+
X-Received: by 2002:a05:622a:602f:b0:516:3f51:81cb with SMTP id
 d75a77b69052e-5173c7c62admr9973511cf.13.1780216804875; Sun, 31 May 2026
 01:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531075600.4058207-3-yuyanghuang@google.com> <20260531081909.B43831F00893@smtp.kernel.org>
In-Reply-To: <20260531081909.B43831F00893@smtp.kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Sun, 31 May 2026 16:39:28 +0800
X-Gm-Features: AVHnY4KD0paNIVBC9uNyVFvRzOcbfSBNa0NzD8UXl-UeIELrmKSNma308t-9CmA
Message-ID: <CADXeF1GFXkh9bRPN1xs=OqVbg3pQpkh8p-aChjHsR3sNVrjPTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: add verification for
 BPF_PROG_QUERY attr size boundaries
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 4:19=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> [Severity: High]
> This is a pre-existing issue, but while this test checks if the revision
> field respects the buffer size limit, do the other fields actually respec=
t
> these boundaries?
>
> Looking at the BPF_PROG_QUERY command handlers, they appear to unconditio=
nally
> write to output fields without verifying if uattr_size is large enough to
> contain them, which could cause out-of-bounds writes in user space memory=
.
>
> For example, in kernel/bpf/cgroup.c:__cgroup_bpf_query():
>
>     if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
>             return -EFAULT;
>     if (copy_to_user(&uattr->query.prog_cnt, &total_cnt, sizeof(total_cnt=
)))
>             return -EFAULT;
>
> These writes happen unconditionally regardless of the size passed.

attach_flags and prog_cnt should already have been present when
BPF_PROG_QUERY was introduced, so those places don't seem to have
backward compatibility issues.

>
> Furthermore, in kernel/bpf/syscall.c:bpf_prog_query(), the central
> dispatcher drops the uattr_size parameter entirely for almost all backend
> handlers:
>
>     case BPF_LIRC_MODE2:
>             return lirc_prog_query(attr, uattr);
>     case BPF_FLOW_DISSECTOR:
>     case BPF_SK_LOOKUP:
>             return netns_bpf_prog_query(attr, uattr);
>
> This means backends like bpf_mprog_query(), __netns_bpf_prog_query(), and
> sock_map_bpf_prog_query() never even receive uattr_size and unconditional=
ly
> call copy_to_user() on fields like attach_flags, prog_cnt, and count.
>
> If a user application calls bpf(BPF_PROG_QUERY, &attr, 4), which is only
> large enough for target_fd, would the kernel proceed to write multiple va=
lues
> past the end of the user's buffer, silently corrupting the process's stac=
k
> or heap?

Per the discussion in the previous review thread, the fix should be
minimal and limited to __cgroup_bpf_query only.
