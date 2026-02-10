Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0B336EE3
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757981; cv=pass; b=WNDc6U4uUXe+VZDj/huAbFfaKPydxFUkIa8fycPHxa1J4dh0UUDdNkBeXJy6D7aVTmtYNBo+xVHJhCVcO/1GW6oMj3OedoTwRGPN4qk3XKKd4HoIoj9V4B2qKpxZ19+amzUPfxmowQpcivxPpaLk/1C4IO64056BTovvr7NL4Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757981; c=relaxed/simple;
	bh=6G2FPHoUQwJEXbcptfCsU+xunHg55aMR3i99xGJc9sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMKKF1NzWqn9nIREZeZGIZ6nBtY4h3fgKvdAnW/MfpKm1KhC9swPi3wPd/MlK4mPjH5/ODtcKc2imTPjStSHE9ftWh9JgGOKTG2zII7rifRTCoV4gkpbR0wRRidVRl7EuiJeuAcH5wPuVomQ6GP0uYch6bG1xzSRLbkHDfhgbIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXfMW/Ld; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXfMW/Ld"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35621aa8c7fso2279219a91.2
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 13:12:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770757979; cv=none;
        d=google.com; s=arc-20240605;
        b=GYT+A3ZPgFGD7Se0fCoCZZexzEZTi/jc4zGJxBO0V5c9Jwhp0I4b+RtmjpLeO08kTe
         Y7Tgwt68TARl4BiFRWBv5d1AzRSkwNAJ3ikL5qsTbUwnw1n4qSIM0I9ZQEYQe/25Suqd
         n3Vt5Odm2rJCMO33bfQYGw/AHI99GpMsjS5qT5aFVeA/Cfm+fc0VZXF1GAOWyodJdzgn
         N4UvTb4IQF3E43Ee2n4ix5bJO6NYryPfQOOBTpzLC18SGGLNitrnGngcDYQkG0uSFaUK
         G0YU2xsH8zNCNF8v6vW4TFjnb0ZVatuF9HryPQTRjGNBEvqOj1q8g8iza34CGb0Lrykk
         r8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=my4eVsw0fdFqsNeqn4Wf73lQ7adC/oE4r1qTVoyOiho=;
        fh=YtRnqfwLKkFafGxI2iK8dKBe0+LDQSwAhX8LmM4k7vo=;
        b=aBLGUKVhc4u4m1qC6ZAlq7P2V3Cwtz32JxC+HHSMTU181S3wm3hNGKO/WZjgXrZn7m
         zMIv/fFCOmGXV4rVSFCA4FC10dUZZheEFEZCPlXJeKgtHh3MhaNEfjgLwVeTKW6Sd3CY
         kY2WgaN9PH1rd4qYHR0qUElR3WwdvVYEEBjOJDArI/vAr4cFnKRXjsWK8vEu850ho0su
         FWmFssavLhQsBNbkCjq0WO5YUKOZ+O7Vg2LiKlknEMQR5F5SyfgBS874IgG6iaV9vWSB
         ZKyjDrZdBg8WSyPNOdOdDHWPTtTKse7y9XeeucLgUlBW0/x20VhQ8PUHDgRoFcpC/TPj
         qDhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770757979; x=1771362779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my4eVsw0fdFqsNeqn4Wf73lQ7adC/oE4r1qTVoyOiho=;
        b=RXfMW/LdUc2QQQI/s/igd9oWIsaHdelfUxSO+QLEoPLpKGzLh38/EIFJXFl/ZmqaBv
         7XR04kojaEo1Ce2EDw8OZ60FlsaQnwsuAxg6aILGi1H7FtCAnB2Kg4mtA+eOCUW+vm4L
         gK4NywE/iwWl09hccyV0roSpvS1+Y2gsc0hhm84V9uzgGvathSNixVrtQdcAL7kH0wMk
         upD+fnijY7EPvljJ7tOGrxsV9VrHjrcJcWhHHl/3fDZADw7TrgklBZjX6SvskvdsFuZ+
         JOQqielT+BVoSj60yA3MlDodjrXuLc99xLHT05wJ4FcQ5UJvbAhjOdgNsGrWwIfnJY4r
         rR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770757979; x=1771362779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=my4eVsw0fdFqsNeqn4Wf73lQ7adC/oE4r1qTVoyOiho=;
        b=EbnX3RnFb7eUrkqP0gFirdcgd5Y7Cdy0ZrI55TldD4U3xTUvTg3NsxrIezxG9SDS9P
         0pj0nNNzFDZzBebZCa4oJUFfLShBIAwKKZq0KOYPuNUcBco5n5x3Fg2MmAZtVRk/+oQ/
         XdEI9DjAtQV/EsEGYv0/lmZBD214uAz2kPl7j2PvTnqEntNVW280eyTMu0f396hKXXEL
         0CVEzIH2z6IAQY3KABND0c3AYNiJAuNFzPTYuwQNmClUTDQHgMuxE3tcyeCbVlf2sGVm
         XAbxs3H24vkHs06/Mv0MMMu2Un2crlw8Ymt51XcALPdw27alsyvzvzdFMw9zqlmP91cw
         ZjwA==
X-Gm-Message-State: AOJu0YweYgiMjWKEadz0TumnGr0sfhs2F6gHKQbJ57Qs+SpVEXCIuoVB
	WQeSakFuSW+dsjEUnDtg5aBntkzr6DaRmomCaWS1jEiliWg3EknOV144LcJxnj2DNl7+oibKA8c
	HBY0CRtEfG6eo0QmOOwsJma0+NstZCkmuatKi
X-Gm-Gg: AZuq6aJ2GUtTT6g4f4KsNkW3hLd0MR4Q9UChohbivz3JP4WC/iKIYJ0TVZTcdv8vBNe
	XnH0rL7youBFx/mNLFRofPHSA+Y+FP8u+kcfoJzdK6joS7aU0JKePIF+1naXopJBVRuR7ArzjG3
	pro4HcgJ1dpJKgaFs4H7XADGp1tjVv8qEI4ILxnpVfN0dmK/WWTlPt0E367q90aypsxPQ2C1rC9
	tgUHXpKBkv09FvGHmnMOkNeUtsppfdtaZ5ad5kfXW092SIcTt0R0KbA0ut5ZptnmL6ik9V3QPqO
	fsEJ7n/Z5gmW2GJQq+2i3t0=
X-Received: by 2002:a17:90b:498d:b0:354:bfb7:db1a with SMTP id
 98e67ed59e1d1-3567b0bfa81mr368488a91.31.1770757979096; Tue, 10 Feb 2026
 13:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209230134.3530521-1-ameryhung@gmail.com>
In-Reply-To: <20260209230134.3530521-1-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Feb 2026 13:12:46 -0800
X-Gm-Features: AZwV_QgCpe0fg8xSwqhLOHtJwp2FjI-L1Wl17iBoelZnxiuEqrLezbTc4z97KjQ
Message-ID: <CAEf4BzZ1sxpwKXVK9KNKzKOjSkCu8ck58JBGBjr18f32Hnc2Ag@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/1] libbpf: Fix out-of-bound read in bpf_linker__add_buf()
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 3:01=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> Fix a potential out-of-bound read in bpf_linker__add_buf() by advancing
> the buffer pointer and reducing the remaining buffer size passed to
> write() in each iteration. The bug is reported in [0].
>
> [0]: https://github.com/libbpf/libbpf/issues/945
>
> Fixes: 6d5e5e5d7ce1 ("libbpf: Extend linker API to support in-memory ELF =
files")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/lib/bpf/linker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index f4403e3cf994..78f92c39290a 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -581,7 +581,7 @@ int bpf_linker__add_buf(struct bpf_linker *linker, vo=
id *buf, size_t buf_sz,
>
>         written =3D 0;
>         while (written < buf_sz) {
> -               ret =3D write(fd, buf, buf_sz);
> +               ret =3D write(fd, buf + written, buf_sz - written);

The bug fix is correct, but commit description is off. There will be
no out-of-bounds reads, we'll just corrupt memfd contents and almost
certainly won't be able to parse result ELF file correctly. I've
adjusted the description as follows and pushed to bpf, thanks

    libbpf: Fix invalid write loop logic in bpf_linker__add_buf()

    Fix bpf_linker__add_buf()'s logic of copying data from memory buffer in=
to
    memfd. In the event of short write not writing entire buf_sz bytes
into memfd
    file, we'll append bytes from the beginning of buf *again* (corrupting =
ELF
    file contents) instead of correctly appending the rest of not-yet-read =
buf
    contents.


>                 if (ret < 0) {
>                         ret =3D -errno;
>                         pr_warn("failed to write '%s': %s\n", filename, e=
rrstr(ret));
> --
> 2.47.3
>
>
