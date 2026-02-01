Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB1183CC3
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769988581; cv=pass; b=a0xG/qdUezKre8o21lolrUtmefmGcaGFLTWRckYtDlhErqCaSccb4yEnBIPDl7tr+b0V5lqB5fmevhTpIuGWZ6x/oIBsx4NEEZsYiL7SGpMbHRzd98+GJYjDG4N8U31SWdWemMEFFcbsetVEisWV1FW6zJNREzC4fPvV4iyQ2ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769988581; c=relaxed/simple;
	bh=e8ReX8e88Ag4Qzd4SHgnsQJCxLwBL5X//YElMuIDLU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbErGzZDhLjzpbwtqHUmM3nIMow+y05p2ymF4r2VF7/XrELAKGSG3R/O8v9vmsABuL9F5BRTHINlJGU0rC0s2dA6iyoBlFHuDbEJnI3zSGQIqcKMgLmhVURqDGolt9m8THtCYsE8LiK95la0v5v+gpYQMu/+x4nmAqMYJ5MjNhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrYtnijW; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrYtnijW"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so29498855e9.0
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 15:29:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769988578; cv=none;
        d=google.com; s=arc-20240605;
        b=AqbNQwzgZyNc51kfbUVF8kdcNwaPHJ0VkruNuTFwvGbI8zThAY6cBX9MSqLR7VIzg+
         R+mvaKiSq1hVjioyv3ONKGEsDMue0v69JhmJFOleFHo7N5qSfafY6XCt5xLMw5D96Kca
         P3+KypQtWcXup6wGUn6SKIl0FvB+Vn7A5+63KALHbFsFHMs4o7gzhsuO0c0zOBOf/QZB
         xjFrmFtaL9d4sdjFOF/iVMVP4iZSKD4WSCVruU9W+tPfwiMsTOwMmvjdjcjRd0u7IUDz
         3Gn7kRGMyfskpu/nyZxDsz6P3qsv5yusDg+GgCp62trvI8mzJPmFTOU29itzDapyI1cy
         gvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e8ReX8e88Ag4Qzd4SHgnsQJCxLwBL5X//YElMuIDLU4=;
        fh=/xayM9n/CAqGFzqsSM+cYYKjqRiirjncSkgOphcYFBA=;
        b=AsjMrByKl+JeuNlQ2lC5LCdQRh6hPzGpqQyYTBzooiZz/Tviu+/5Xzs/cLRIVvrcl0
         O7mLxAwbSbpjYBHBnQOtWtlm+d9rJLn1yBkR1Wnd2MbuMZdo/Y7UqljTRk3pcdoIt0Xt
         r4zGTfRyS5aAIoh3T6XwfsXHE9ke9VhE3WyaYGaVmm+8F30QLosq/ZIE1kHOK4lpEE6n
         Ahlpu61mwDUdAEAVZLfR4vcNTX4lq8z8zXEuFEG0DPHdbj5ch3IeLWMUfpsBJGu4mfny
         d68lW/itEQe/Amjsn2weA6PkuM+aapf5B00puRWHh/m9oM/Jajb5Sd+ESguBJRCqbr8d
         RRhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769988578; x=1770593378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8ReX8e88Ag4Qzd4SHgnsQJCxLwBL5X//YElMuIDLU4=;
        b=mrYtnijWNKGXC/0CzSclTmWu8AKqhk/7o1qqjgEu37pch/cjpourDfO4XbMaMMllpq
         otzmNiT5g1SXQo/Q3aMYBIaDevNPTU5fVyxUvk5MSWDGDdR0zUrZmX7Sx3F2lmpObEX6
         ZhRscv0/WDx1YteVSCAW+cXwxQnVA7hCMwb8nL9d/bA3V+MFukyeIBs+UiXTvMDFvXpV
         4BS0tOznSz9pY8BC7AYtITEZV05rN3Cg2RpPrgyxM/L6YsDy6fWKLVO4aBoizADteqKE
         ku7kMPC0O/ZxPasY9aEmSJVGCsqb3jU24KrRNs7PQpCAUaeg0yrBDxxqUvOP1zyEE3MR
         18jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769988578; x=1770593378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8ReX8e88Ag4Qzd4SHgnsQJCxLwBL5X//YElMuIDLU4=;
        b=j+d2sh4asMJt1RXfTl2gkW+1GtEPT4F3ScxprhicA2qXfBcI252uaVsMdMyAJ36fu/
         OBchv2MOg02yaPiBJ45Mt7t9UZX5FSrCQ/kU7JBsL3Ufq43AXnI2cs0m4moA6FuHTg01
         GzMfikGCHsLcnpEm0B4PiK1Jd8+Mr1o3VQyWzG2iEiI2o2SUlBqx1Y9TY94q07OqrhNy
         ijS0iPqVaqp4znQc9DHVlDH4GpRDYIEtRohLNdqcpX2L1YYCRZDqFHL/L/BGWvV44mjI
         uAo/dNeAOqr8S6OWZoinZYJfiuyAW5hcaj6mTT0zJrWs3Xie1wDfb1CDn8YBXUU7kPov
         8W6Q==
X-Gm-Message-State: AOJu0YwkBVjESpC73d5ZkudzIKggU8Zjb6jUfUGQdP603qp8KWTRCgEr
	faD/Q8OFvCIM0miRLWN7A4LqDysO5niYLBLmldbeOA+4nHoP0qqLapwjCm4o6UnDhkZ3q7seaOH
	uSGdjv+xUDCENOybl74irXkeJn8mUR9Q=
X-Gm-Gg: AZuq6aLgcH8ZzkakrXbGLss/3vzkDgdLfj9ql3LsbTmnaF2ghEAhcCRB/9DLd3yy8XE
	ijOdvmVDn39TPlDxjAXw08hUZRAIVLLBiT8oRpCrzyXZbiZBQ41dqb+S0MOG463eUq2m1BnJDky
	o7P5D5RgM3ny1DAJMcSt1Yf1fZb0pmeavTzEbbhiQ3YqaD3DLR/t5Ocs5fph/zCKaZD2uNJB8Hs
	bn++3VqNV0B/FqXgvq39dC7jUG9alxltEUW63Md6RfFKZez88Y/iRmPLg6r7vjx3ed4xbxO06Wq
	I5bc9KfuOZBdRGopoZE/ewTpZEyMspGXsDEjISF2e165MDlJbC7SoQ8Fu5za0ulTxqcnbkt8X9q
	U82hPOdG43e+DuQ==
X-Received: by 2002:a05:600c:3b23:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-482db49ff27mr126833365e9.14.1769988577771; Sun, 01 Feb 2026
 15:29:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201175050.468601-1-ameryhung@gmail.com>
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 1 Feb 2026 15:29:26 -0800
X-Gm-Features: AZwV_QgigZDNlyNlUEuotYwPWIfWCOvZzkooPWr-8YPomJXC71WGcJvjLP8f1xM
Message-ID: <CAADnVQKxcbWB03cu7j0RC6-iR1gT=m6n8ZgqDpoQXW0MB+eqUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/16] Remove task and cgroup local storage
 percpu counters
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 9:50=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> To remove the percpu counter without introducing deadlock,
> bpf_local_storage is refactored by changing the locks from raw_spin_lock
> to rqspinlock, which prevents deadlock with deadlock detection and a
> timeout mechanism.
>
> The refactor basically repalces the locks with rqspinlock and propagates
> errors returned by the locking function to BPF helpers or syscalls.
> bpf_selem_unlink_nofail() is introduced to handle rqspinlock errors
> in two lock acquiring functions that cannot fail,
> bpf_local_storage_destroy() and bpf_local_storage_map_free()
> (i.e., local storage is being freed by the subsystem or the map is
> being freed). The high level idea is to refcounting selem when any locks
> cannot be acquired. Additional care is needed to make sure special fields
> are freed and owner memory are uncharged safely and correctly.

for the set:

Acked-by: Alexei Starovoitov <ast@kernel.org>

Martin,
pls do another pass and apply if it looks good.
