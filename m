Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF08330675
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699553; cv=none; b=E8DcCHk8iRWdQwhUDiQQ2Sv4aGeDMHt+9B4i1pTR97JOMfV2MEY3cxertREeG67/7uEqi/Iv6Fmf/6QpRbg3O2lHdre3KQBl40/Vag0zjYnh9ZSXF7DitxzpwRwUUYoVJnePpaXLoc8IfBEsran/p6yam8V2EQZexmrsVDv7TAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699553; c=relaxed/simple;
	bh=CwSTe/qpL7qzlOFyJ/vTT7KDpK5GmaxHom12OT3uCF0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=WMKi60dthMvWzgXfr1ABLYq0oujJpNTpitdFa1+TWDrnWRecyHm3wacJH5IYjdAeMhDrZsYcs610lf+5pIs36ISVCCv2N5cLKHWiEZoiqq44Nb/W9/jMdWG3M2IBqtRjMjak6zyJwmBED/cbKis10uu2LB9Nc/6QQfKd0fHJ7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwyvmJwZ; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwyvmJwZ"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40efc77933fso2180661fac.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776699551; x=1777304351; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoFFQuLpG5Mt/AIKiw49NZtReeh7XqzcSdVHqZoLYZY=;
        b=mwyvmJwZrLqAQYaDty+MxTpTWg7NqjQEgBS5enDE8SnDbyqDVHQ5j8AqWAqIXFRrMI
         /ItLq0ACvjdeeSomPIEm/9z/5p0eqJmzz4P5km8B4k/K0m/mZBEDD6segH1mHaUgZ0U7
         H3PUlaHtITbfgHey0BSQIcCYH7JrFP85mjicM1/hb4QsL4Pm3X7U9ahr4svLZ1I3RQmU
         RrcgldRqyQlJUkWHnye2EzcB4zHSHAZP/Mjl0dIg+DNoE0X9vj5GZWGJY34URLmDIxhJ
         czb2NhxePucaWkO1C8K463GxXc/xGLKX2PbZFkAeBei7Azy4sj5BuSULkhjJpgBTm2LW
         qIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776699551; x=1777304351;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NoFFQuLpG5Mt/AIKiw49NZtReeh7XqzcSdVHqZoLYZY=;
        b=phkCS3Qg31KaV0UIbNXWqAWsa+2uvfhlH17Bg7zkSD+K9bNMwwHZeliANhOJ/ypVXh
         e9zkYHNkjW2tAxu1zdagphvMzQeFA0f+EN8jSTWw1qyY+O15llPHkK6aAgQ7GFWEtxxm
         TgLHG1gc158N735W8kdES8+b5Dues3BHjbqM3iI7rtkN9acigKCPiVgftmox1nZy6cLk
         5QVZzjleNIGXUMjkbX8+Jh3j7iRPmUZuuUyy1Np4W1lzB5n5bWKVHLH6l07fuFSSj/bP
         SCYxp1K/dNvYS+PZxdzVDBfC0XzxAJqZuM+xYpVh7y8rYS1hy6uVQ0yqTI097ZhzB87q
         p0Kg==
X-Gm-Message-State: AOJu0YyvulBgEDSgxu3C1I0XGaherTdHevttJb9HHtqA3sE1384PSWcb
	T/05AuQ1asp/U7pcbYC2lMZmnwOGBxM17+BeSCg9UIO6JEYX/jeoJ59BEnFLMQ==
X-Gm-Gg: AeBDiesd7y4lC/6VEVejels3nO+UNniAz8tNGlivwalFmciDaICsDOhgrdyKKTrGwg4
	IZVxwcsvrD0CiCagUJGQTLDoovWzBKLp81IVXsizhp9+IHZpgmTYYMlif4V6+W2KqCefxot3zhF
	MwTOJY58NBMCV4M1p1i+LF+K3RIocJFCz0YACIAdAJynXP7/oF5B3L3fizXTZEU/5VRWhi+/rCm
	6YWft8zuLlUpp8eW73vbFd/uzMR4D1sPmXWaXTXhUbrFtgcUxAizlxbKmzFmtysV2rkgaQJlPam
	npUFEBx4Y/Zp/i21SkFOnovcdAdyvcLOKRmB2t//R0d670hQnZCXdRTg8d1e7C0JQ3zDFfICx7w
	M/6FyppoJ51f90JVSa06be3asOB+eftO4Rf0U4fuNJBjWv7Vwa3UyjknHhFGtALzzUSBcJ7ELpr
	6i96bSwvEeGu634F6nuWufdeN/3hWGcYRMORWy+2WuzX7SNygui545MaE9myKOOFT5tRZzE+G5J
	7dP2o2y3bjYvphcf6SnBJZi7i8pS64DicPPyhc=
X-Received: by 2002:a05:6871:758a:b0:42b:ea6d:a8ed with SMTP id 586e51a60fabf-42bea6dda31mr3493259fac.20.1776699550939;
        Mon, 20 Apr 2026 08:39:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b930480bbsm8353573fac.4.2026.04.20.08.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 08:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 08:39:08 -0700
Message-Id: <DHY3FCU01RAG.1AACAGEQVBFCY@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <sashiko@lists.linux.dev>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 2/6] libbpf: Adjust btf_vlen() to return a
 __u32
X-Mailer: aerc
References: <20260417143023.1551481-3-alan.maguire@oracle.com>
 <20260417170712.74E77C19425@smtp.kernel.org>
 <40708ab6-7a2a-4c7a-8943-88f25c13036c@oracle.com>
In-Reply-To: <40708ab6-7a2a-4c7a-8943-88f25c13036c@oracle.com>

On Mon Apr 20, 2026 at 1:02 AM PDT, Alan Maguire wrote:
> -       return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind]=
.elem_sz;
> +       type_size =3D sizeof(struct btf_type) + l[kind].info_sz + vlen * =
l[kind].elem_sz;
> +       if ((size_t)type_size > (size_t)(end_type - (const void *)t)) {
> +               pr_debug("Overflow in type size %d for kind %u\n",
> +                        type_size, kind);
> +               return -EINVAL;
> +       }
> +       return type_size;
>  }
>
> Given that this problem exists separate from the extended vlen series, mi=
ght make more
> sense to send a separate patch targeting the bpf tree for this issue.

Make sense to me. Use check_add_overflow() when you do.
Are you still planning to respin the set ? or is it good to go?

