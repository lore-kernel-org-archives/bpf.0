Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03EA14B099
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075233; cv=none; b=C4mxxkQR/IL4KnmbjW3dQtzHtOzL0g29W76NHonTBGjjc3qBTrWdo/K5Ymw6Yeqdl67RZ5ykYRLQ9whzOOCMT/+AOLSo2hyTIxafPhV91AmBG6fOO9GA1AiDGvNHBTDloSVvUv7uROrGykW2Y7D4Fy8dVnhQqVD2uNuPc7pB0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075233; c=relaxed/simple;
	bh=OJ78DJy+IFw0SBSPCgzgboE7h5k74uCy1cH1VRCRM+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6Mpe4gAV09A1utKScLV5RToTqo4ofao0fUXADrzK9J2DWtjUmxclwZNtbLrRayuodFc0CaiCJukcrsPIuvz1dQGVgWxnz9NweZazeb4mEHZY6l0nahxacaGpRJrlwyEEFfbnyfcLiY9BHorqvT48j75WIfqHysS1oL6yx2hIgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agrwFT1u; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agrwFT1u"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a27ba3b1f3so269900a91.3
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712075231; x=1712680031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUcxN48L1uPnwKbwKrmZ+1qqXgmtQwJ0gF81NWHfHR8=;
        b=agrwFT1uV91BmOUEskq/q3vFKuiwr076fFIyi1U/9cbYIvbZ+eEpBYM5gMa458qixa
         ONZg5/wBPQoCiG4/1rssJHYiWgzi5lDNEzx+YgL2Bo8s8xYASbka6NjFSs+9HbVACz8Q
         4aXr/BKe5wvkjr6d4NYjcUUCvUaNDnA9F/J1SqG/MML32+j47h5GtJ6Lmwm124rqU6NG
         UdjD/tRX/kX/nUJbYGri5wMUwB2R/gWadZGtjvenjD30etKJ7I2BL29DLFCpPDpOLhkw
         CHpB51pcRhHXmv9C5clTKgcrDjPWmQRxcaWsYGtxSjWct4RRkR9zbXo3uycCOB3dV1Mh
         WuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712075231; x=1712680031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUcxN48L1uPnwKbwKrmZ+1qqXgmtQwJ0gF81NWHfHR8=;
        b=ORYrG0zXeM8P+6Hs/QyqGWygxAdQem0H8kLKf73Fa7YHkZIAN7cQR9QYQVZUymH7yN
         tWbL4v5FM7Itp5FPU1Y/oFjO/L+Bl6IAwaElQS6QTYAyaAhjwayw2Cq6n1MHjFyMXVRe
         NTz60n04OnVlCLf09sKT5Or7C7e2t9g2PXYRftq39zhp3rWWqZ43LmW+LxuvOo6ZntTq
         5a/wC6Yoa0T1ij1rpbKpAE8Dc2D1Z5rcS2a15+i7wpmXlNoVFMO0/L6k8iMCd1v7wk/s
         aYTnWXUeq7yeMivppT4hIkwM0otqZzd6rkMPA53syeijZXqgI01J+TlclYvA3rb/4fgo
         RqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0yrVp/m8VfYPLNpoR3W+7HhDT4lvwWeHRTdD/NVBCoF44t5sFKanul1CsC9fyiv6BhWeZlfI2YKGbQgYCof/mqwfh
X-Gm-Message-State: AOJu0YxDt9EIg790wQYHEfFxPRv4qj79z61THjogJyQqzHeTBBB5A7rG
	vliWcG42e9kOvvwq+z0c/n4GlYhtO15SZ8Uv3C9ezaLNNJ/NF/p//gNvbCEKc2JlhY7mTxBlFNB
	Hdeso94ehaqRCX+zj/WTMNV6iK6o=
X-Google-Smtp-Source: AGHT+IGt7EYRN7lxDV0MQ+1QqKtFzKbQkcCbfaQbrKpCf8DQdVZO9F5smaIYhZE7S09Nzu+VSShYD3V8Pu2eVeKKi4Q=
X-Received: by 2002:a17:90a:7e03:b0:299:5b95:cd7d with SMTP id
 i3-20020a17090a7e0300b002995b95cd7dmr9610852pjl.45.1712075230967; Tue, 02 Apr
 2024 09:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q5d5bgc6vty2fmaazd5e73efd6f5bhiru2le6fxn43vkw45bls@fhlw2s5ootdb>
In-Reply-To: <q5d5bgc6vty2fmaazd5e73efd6f5bhiru2le6fxn43vkw45bls@fhlw2s5ootdb>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 09:26:58 -0700
Message-ID: <CAEf4Bzb5jicN61cBwch2gosA=taVX+Y65YSxOjeSLJMSPcQMMg@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: use local bpf_helpers.h include
To: =?UTF-8?B?VG9iaWFzIELDtmht?= <tobias@aibor.de>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 8:11=E2=80=AFAM Tobias B=C3=B6hm <tobias@aibor.de> w=
rote:
>
> Commit 20d59ee55172fdf6 ("libbpf: add bpf_core_cast() macro") added a
> bpf_helpers include in bpf_core_read.h as a system include. Usually, the
> includes are local, though, like in bpf_tracing.h. This commit adjusts
> the include to be local as well.
>
> Signed-off-by: Tobias B=C3=B6hm <tobias@aibor.de>
> ---
>
> Sorry for the very wrong first version.
>
> Changes to v1:
>   - The patch was based on the libbpf repo instead of the kernel repo.
>   - The description referred to the commit of the wrong repo.
>
>  tools/lib/bpf/bpf_core_read.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.=
h
> index 1ce738d91..b5c7ce5c2 100644
> --- a/tools/lib/bpf/bpf_core_read.h
> +++ b/tools/lib/bpf/bpf_core_read.h
> @@ -2,7 +2,7 @@
>  #ifndef __BPF_CORE_READ_H__
>  #define __BPF_CORE_READ_H__
>
> -#include <bpf/bpf_helpers.h>
> +#include "bpf_helpers.h"
>

Makes sense, I'll apply the patch. But I wanted to check if this is
causing real issues in practice. Mostly to understand if I need 1.4.1
release with this fix?

>  /*
>   * enum bpf_field_info_kind is passed as a second argument into
>
> base-commit: 026e680b0a08a62b1d948e5a8ca78700bfac0e6e
> --
> 2.44.0
>
>
