Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427853161AA
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367099; cv=pass; b=FfGbtYK6rVkXZGUs2NvSh69R7q7NjQfWMIjT5jQXTbZDZl1O3JyEcWFduZgrk/6FlevmHI1QG4hjByzxxqqqJpIhHgs5WflCXdHzQcdDvXiRu+f/n8UfFMXoBl4r5HMAnwp7i2a1bG5VRGiczoEBbVA6siqUIqr9nJz05dGNCKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367099; c=relaxed/simple;
	bh=Xpfrmba/zM1tgXneNopEuu3FbsEteTuc4oBvkMv+lYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BP4ul2WvcYvaCqIUwRi1dNaKSim6KLLqe+YoqBwCPKtTgzSSAnupn827ekYzmai2bkZMGwtOCl1qXjL1aKyQ7k25oX6ii2dvk7/0j8KtL+a/tWQsrnJetm0h8/k6z7U1OtSw/U6bs1QR2ARSgUsALro9bAQLKiDLmd+BeCku+oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsiS+Z/3; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsiS+Z/3"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a9296b3926so32261085ad.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:24:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771367098; cv=none;
        d=google.com; s=arc-20240605;
        b=LewFwcPm/UoJFeF7bTJ2hXm4qjngZSxPebwK2uA10xh5y7cTdolaxXF4vd85BzZacf
         RzWfp5Dxa+RENlxxynU+zsGeVLwA87+Va9w3SuTL/265quFYDJkCBEku2QazGzipzzDB
         iFBUbP10qbLjLFRKzY8TtGhEtGUTkZe+llOCBpRFoR+3nPAq0RKlCI2bzvmzPUrNPrPo
         G0Mc8pPmjVuTCy4HDRCEdvrlNM6cJRWgf9kbX2tje/b1EVBqxDH6wxT8OyfGM1o+vojY
         BXCJqJmCNEV7BvufnpkDKbrO59Y+TjcHVo5z2AlwFFzRZrvlYypn7hnI4VfB+kSbowVY
         Je5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I12MYasv6izFgKW7w4OMvpOk+LgzhwIdK1OcGqMNwzQ=;
        fh=kQJoHmciZhFE410Bsj90HR7sS6L9VfCXE26CeirnTkI=;
        b=JADB125iOvlBqdk1yxw44+X/yH0gm0aCLf5MkRLe0rldD/DwbLlTES0kr5TOs+t/ak
         yoMb5iEu6hUt9XIZUSRuu0RFXKQZ5tDOrt6waglcQGjbNO94jszBPEVLqwp2cWmp3DLr
         Yn57tIWpRDxnM0O7ZgRDN8ZNiWdtxMkrEcWG4h1jL9Ekj/zvCUpWw3V4sHcJgkUO5DeV
         e30NSJLZ9Oo5lyzIf0IWUAwCutHbkyiwM0cEbqHLbO/NkzLXGlTdfRU54vN+Pq4k/5/F
         rIduS4zeCRzqkPY8OlKgQahY5WZj1Fg12gcu/r4Z9twuF3E58HezWXOda+gBfArPPSku
         PEoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771367098; x=1771971898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I12MYasv6izFgKW7w4OMvpOk+LgzhwIdK1OcGqMNwzQ=;
        b=XsiS+Z/3oh4HybZawIcUcFBdyIufla+6TQV4I4Vi0jVbih+vwtoom/tGEiwlMhGKvO
         HBonlvDw9AHo8BvDaZIKuL528oqvaIEc0achUkQzqQzIZ5FS5w2u9deersj9HVDtHqRA
         FmSOJBUE9ghZPyOMGBCPaXJvONYZuNEazU9nKU5bfJ8siOGkdV7ijn0AA11y8pJKfTEN
         przRhbcH9Taswi4+R0z87F01c5UgqKuScxxC9zUYGW8o5aH1rx4v8eYS197IH62EYNrL
         g32/gyuAXZfWtxnon41xMaadvUTyBjrbav873O3EAhArusxMB2F5US6qDyvSMAPQbgvp
         7DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771367098; x=1771971898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I12MYasv6izFgKW7w4OMvpOk+LgzhwIdK1OcGqMNwzQ=;
        b=Xl/Jo3Tj8AUpUj+6ROb47ROqVB8uleHhIxT40GYWqBP9PhwAksqXHHjupMUuF2KYYt
         9GmsS1Q8FMuaDq3DDtjqPplK+V9LsmWSKsH155hklvwPYNx/2ib3nZVnTNtvjZ5JaT2k
         u01JfSZab131nnSEpKsb1uUrWL4mBTzsMuGdt2RLZQLnsjkX1VnEruU/I8iGkh9RO/T3
         Y+ZVcSJ1v5va6Cb02+WKY5/O65iNf7QkQYiNw6dmzpmuXYWqMchRoKeUS5zloi8lneGl
         zonAB43Sh2HQhYg8rSqMfVlg7N7lFnNj4RCzY1+lkz2H9nqNKRPRTcbr2ppBhLo2QBOQ
         ljqg==
X-Gm-Message-State: AOJu0YzLOQ2NLXGRQXutsgweWt5lFc/4pZmq/3BPSYlGP5I8eV7ENXKA
	2I1XB0Zu+/1pK1KGCox1tFONVm3PQiTZ7RwHHsdL5XKxloRxmXu7c0aANM+cYbmsSx0Ocp/cvoV
	N+rdMqgRMvxftDaYJd3IK4CMXzi3mrtk=
X-Gm-Gg: AZuq6aKx0g1HzxJ+uE7PSAP3GDuf5mPn4eAT625ghiDcSloQhdaCAkA7kN13aEihV6E
	A7u0ciTDT4dO1bJ+eHgMu515uqq83yTPgobU7msTaThsVWs73CQU7VH2yPnYIOPhlwFrMeyaKic
	exRFj7QZGSAaMHhA5YxrM9ZK7kmgM1wuomCXiqtkP+opsXyooLPwTivOxIrrd5bj9qzRZnhemDP
	11fswp4uYKiOk3WoZDDMjHQRS5mw2WneSfYrwQRlqp+Xo1h9pUiC++ju/P9vI+/mfc6b4KpZfCb
	uFaoxsJ2uk1ZVC2UyWj9UEghrgj2uvkwAQ==
X-Received: by 2002:a17:903:41c6:b0:2ab:2633:d986 with SMTP id
 d9443c01a7336-2ab506100a5mr150181515ad.49.1771367097566; Tue, 17 Feb 2026
 14:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217204345.548648-1-emil@etsalapatis.com>
In-Reply-To: <20260217204345.548648-1-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Feb 2026 14:24:45 -0800
X-Gm-Features: AaiRm50vV6cfNqn7eQ_UUopWxMZ-De1Dzis99LgU5Yi1aX5r6fnz3qiifpr2hYc
Message-ID: <CAEf4Bza6QyG-y_Pm7RdZTKEGEOqfCK5JCg8o67-aGsBsz4a8oA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/2] libbpf: Fix perm errors for LDIMM_64_FULL_RANGE_OFF
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 12:43=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> Commit 728ff167910e ("libbpf: Add gating for arena globals relocation fea=
ture")
> adds a feature flag for testing whether the running kernel supports LDIMM=
64
> instructions with large direct offsets. Fix two edge cases that can
> cause unexpected -EPERM errors in two ways:
>
> 1) The probe program used for the feature has type TRACEPOINT, but it's
> possible the caller does not have permission to load it, even if it is
> able to do so for generic BPF programs. Use the SOCKET_FILTER type
> instead that requires fewer permissions. This does not affect the check
> itself, which will always fail verification anyway.
>
> 2) The probe is triggered during bpf_object__collect_relos(), itself
> called in bpf_object_open(), to compute the arena relocation offsets of
> arena variables. However, the caller may not have permissions to load
> BPF programs. This is the case in some systems with the bpftool calls mad=
e
> by the BPF selftests during compilation, e.g., for skeleton generation.
> Move all uses of the feature check to bpf_object_prepare() time instead.
>
> Fixes: 728ff167910e ("libbpf: Add gating for arena globals relocation fea=
ture")
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> v2 -> v3: https://lore.kernel.org/bpf/20260214021014.15670-1-emil@etsalap=
atis.com/
>
> - Only zero out the first byte of the log buffer (Andrii)
> - Minimize invocations of the feature gate (Andrii)

applied to bpf tree, thanks!

>
> v1 -> v2: https://lore.kernel.org/bpf/20260213181752.505318-1-emil@etsala=
patis.com/
>
> - Adjust the hash of the original commit post-tree rebase
> - Ensure close() is not called on invalid prog_fd in feature probe (Cover=
ity)
>
> Emil Tsalapatis (2):
>   libbpf: Do not use PROG_TYPE_TRACEPOINT program for feature gating
>   libbpf: Delay feature gate check until object prepare time
>
>  tools/lib/bpf/features.c | 10 ++++++++--
>  tools/lib/bpf/libbpf.c   | 26 +++++++++++++++++++-------
>  2 files changed, 27 insertions(+), 9 deletions(-)
>
> --
> 2.49.0
>
