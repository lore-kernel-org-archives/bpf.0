Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4A91A6836
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787512934; cv=none; b=kyE7XeSuFNwoV7QPpeEq9KSufv/jUG5IqYDCBKfjMyRwFcnGzdeIIaANd79sDKVExNbrdsNWPjAvhSY3fezR7oRlM6LCcgburSFZe+davW/RleHXkN62WBEmnsjnTNsrx/bH1c1WUiTeto3FCs8F7jqJUvy6754UdGJ7WvBkfew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787512934; c=relaxed/simple;
	bh=j45b+uAVcfYFp9miH01OhKsck29XdrcoZPx//LaW6lw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=MSodCUXtqncRv+3F+Z6yBCRatWfmzFEu4bE+/muK2iioNCCcVrFzP3hXGxfIg5DaXswicvgzvG9gOuIKwnWR1KRQq1CmtJNbGgJrFy/5OfAwQbfLlJysWzZdXw6RvAJVrsP0rnhSjx4zSr8PlZJOmwwkkOlLKrSiVscpT0LnL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+rlXt5d; arc=none smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+rlXt5d"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15be76348eso130684366b.1
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787512931; x=1788117731; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AgbQ6sZtBwwoD7uNP8BvqrzBrojliltUsB8bki3GEHg=;
        b=R+rlXt5dkInnSJ3NZQSwxUUdX4Z0mj2ZEFxfW2KkD0PUyY8iKA8hsFeeQEHQnVczl9
         nNdNO5m+PXtaw1kp+pSAZbiWmWEKo6vDXec4FD6l3v+qFaf2YxtyN4BFhHse/RnjxI9E
         YZphmItM4uOipqM6OaNqQsAchiutBpVR0IxG8N+Eld8v52PyFn1C+3Dkh0st98AaiZeJ
         C/rhdnUNkymz8Ba2AMSYsiA8bzmKw2U+lkM07fX+XO4yP3/FcSLPpzdaeN1fmyY2KP4D
         GOOkCpioMbQtD53ACATWu4ws6JTtKCEl7l4GTTU4avt+oympJQcDXUcn0w5tpCEG8Njb
         UZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787512931; x=1788117731;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AgbQ6sZtBwwoD7uNP8BvqrzBrojliltUsB8bki3GEHg=;
        b=JsSpMhC6tztigm/1oX+RGedZDgFKjN6aig0kQp/sJy4aghOqElabe1FI+t3I4pOd3s
         4N4yMOzXaSALQpn1a2qOn0NaNEDQzhbbab92xLRGpaHDTivwA+0eADhyduhGq6DrJwXg
         LC9pcVlY1mAA7pmPNHMDegVQXb7wTQNhNcJVTjNrvjXNBrKDKf/KSbZ4QVSk5MGW9KYh
         n2TvJHCsg3jtclHK2RNFMy5s7o1/pXbN8rJqplAeKlvaV7WLCL7jv/R2OSXLvBL3vTEj
         5xQAb1/Hky2JpfkYALqLN6ynMWVAa/tPtW8udDJ3WUQ6IvgBSslkkhLot+5uKseZOcen
         haNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqf+OGLwNPfR4bbbZohRFfLVxWwAKSpJAg7XfnrKyMrqHTIj5Gb7KazYB9F4dMd/G5vEDc=@vger.kernel.org
X-Gm-Message-State: AFuF++kwxyYYELmEiAPItFdgnVcf8FBtLZV8uENDQ4ziQaUfD9MQJVZP
	fg3SHAQ+tOX5iwcwZt093q82avOn2EH/Teb4Rq7bytYqrZ7h5riOEkOu
X-Gm-Gg: AR+sD13tPA812JCYVEOghUrghj87PXsmSb+ZvMo56g1me42j6Y9KoRgW/yEh4+4T2ms
	Wb/h9ApcJUv5bhAFUWia1Fyl2ODq/+O0nEQ3XLp73QJbA069q5w87POAkXq0+g6BP8gbbu7+Wpe
	k4DX9dAAvx9b74jjLpuYhd4ORqxyN6y9qoLecS/2Ox/LIZYIBEBXwjQHWhY0lrMpdN4WbrLcvpd
	dnvm3sQGvMsH0N7z1eoQo2WruGT+nwkJv/xpl9uMDmltnyLF8abeD0lMLCVPJcXk9vk5PO5RCL4
	JxgW89GELWnw4KjT8k1IsLUiR2/VnB/H2RG8HsB35x/oOnJvKpDW2yDAnScu5pydg+eh9yfSp6c
	dJYe+jGIsQgk5sFGpvw6Cg1dG5C4ACKnT42h0jq72UwIcR7qXUE8++q6NDQkrxlZX2VxgDtZsrA
	/oYEU1OLwRC5ToBnnlSiliQAEXsDnDqHy1VbNafQqaqsj0SHmynpOQxZJtTPPhD/OXpJtCr8OeO
	AP29z3Dynh509o2/VHYw42yGBf8/c/K2+Rgsoo2PrUKrTEoCT8ohYNsKlK4K0pILAJfmVZEqpSE
	r8EhWI99DJaTGZeVV2Y0AHdHv2I=
X-Received: by 2002:a17:907:c243:b0:c16:2e4f:a372 with SMTP id a640c23a62f3a-c246a5f45b5mr2793318266b.13.1787512930795;
        Sun, 23 Aug 2026 12:22:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f809bsm1023976866b.41.2026.08.23.12.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 12:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Aug 2026 21:22:09 +0200
Message-Id: <DKWKG7IBK7NR.2N7RGBGBM22JV@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Jianlin Shi" <shijianlin11@foxmail.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <martin.lau@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
 <kpsingh@chromium.org>, <sdf@falco.dk>, <haoluo@google.com>,
 <jolsa@kernel.org>, <emil@tsalapatis.com>, <pulehui@huawei.com>,
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 0/5] bpf: fix stream capacity, read, and
 oversize handling
X-Mailer: aerc 0.21.0
References: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
 <cover.1787492521.git.shijianlin11@foxmail.com>
In-Reply-To: <cover.1787492521.git.shijianlin11@foxmail.com>

On Sun Aug 23, 2026 at 4:17 PM CEST, Jianlin Shi wrote:
> v3 addressed Kartikeya's review on v2 and the related Sashiko findings.
> v4 fixes the stream_oversize selftest to verify capacity rollback on the
> same BPF program stream, since streams live on prog->aux and are not
> shared across programs.
>
> Tested locally:
>   stream_oversize and stream_partial_read (equivalent to
>   ./test_progs -t stream_oversize,stream_partial_read).
>
> Changelog:
> v3 -> v4:
>   - In stream_oversize, perform the oversized bpf_stream_printk() and a
>     subsequent successful "foo" push in the same program; read that
>     program's stream in userspace instead of switching to stream_syscall.
>   - Drop a redundant vscnprintf() comment in bpf_stream_stage_printk().
>
> v2 -> v3:
>   - Refactor bpf_stream_release_capacity() to take a length.
>   - Fix staging-path capacity leak; use vscnprintf().
>   - Return partial bpf_stream_read() progress on copy_to_user() fault.
>   - Reject truncated bpf_stream_vprintk() output with -E2BIG.
>   - Add selftests for oversize and straddling-buffer partial read.
>
> v1 -> v2:
>   - Retarget to bpf-next as suggested by Pu Lehui.
>

Adjusted patch 5 for AI concerns for the selftests and applied. Will post a
separate fix for u32 concern. Thanks!

> Links:
> v3: https://lore.kernel.org/bpf/?q=3D%22PATCH+bpf-next+v3+0%2F5%22+fix+st=
ream+capacity
> v2: https://lore.kernel.org/bpf/tencent_C919BB32458A4DAD645A68F441345B971=
E05@qq.com/
> v1: https://lore.kernel.org/bpf/tencent_E69EAE29327E25B3548A9AF3F4FA289A6=
806@qq.com/
>
> Jianlin Shi (5):
>   bpf: roll back stream capacity when allocation fails
>   bpf: fix stream capacity leak in staging path
>   bpf: return partial progress from bpf_stream_read on fault
>   bpf: reject oversized bpf_stream_vprintk output with -E2BIG
>   selftests/bpf: cover stream capacity and partial read edge cases
>
>  kernel/bpf/stream.c                           | 53 +++++++++------
>  .../testing/selftests/bpf/prog_tests/stream.c | 65 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/stream.c    | 18 +++++
>  3 files changed, 116 insertions(+), 20 deletions(-)

