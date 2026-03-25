Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA23BAD9B
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435140; cv=none; b=PtEEmR97tlcy89+1qfi1hn8LGm+YL205KW6qXO5zrLXf/EvuGzm/AyXErCNRJn4V8UDDFgYe8sSrYxjGvE3Ikb4AGaiszMH3wLr5doo3xypX/7SA6Sp7iAwZzE3rmU8BKS5kz0pKF9907XEEtedFmJUEkJpFjE63l28iMV4HKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435140; c=relaxed/simple;
	bh=q/p70rTE9Tr9jRBWaqCRufUFYPNnysoMHcnbGBsmToE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BhKawMMPjlK5bdwFeH8FSBsf+ZkRRs6je0MH2snEZFWwGTl8T9I0AuHded1RnBF9+o6DEBiDYoyozJA8UmT7hOpVmHPP9Xyv2ZUlxfIL6NTiduE7c9rqoeUhaWTC7qJ9MRL/Asgau3T5oNLIVaFDtSfSTUSmaQFQhkSZrqRtBDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVM6t3nS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tX1Yx76o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVM6t3nS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tX1Yx76o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774435137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/Si9+s7QxxoCBvO+kz7sMzfMBjgo1CChr0Lcp9Yhl0=;
	b=RVM6t3nSc59XWWc5n6/TmAIPsU2AtAcw6O6Yqu4pUTCBFQ1/4PF91oubacDp4FndJWwLWA
	QLDgwfK2CVu1XB6Bh6rnX9FZyydxIEAv2ZsjhO7OrKvzvjNqL9NtAPSaLIvUHOKAVTEx79
	RVBegx2pFIV4w0lshV6ewdZEahwn6Jo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-3vjpq1BPNPiWJUMAuRpwow-1; Wed, 25 Mar 2026 06:38:56 -0400
X-MC-Unique: 3vjpq1BPNPiWJUMAuRpwow-1
X-Mimecast-MFC-AGG-ID: 3vjpq1BPNPiWJUMAuRpwow_1774435135
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48534941525so60565595e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774435135; x=1775039935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/Si9+s7QxxoCBvO+kz7sMzfMBjgo1CChr0Lcp9Yhl0=;
        b=tX1Yx76o4hh+qmR6PRkMISJx551kneyHeKyzY9Ebz8VQTodyf2ZdgZsF1W6SQ+0VkC
         kVEirBg3qt0Uc8KEBoVQ0zQgCtpTNMB9irF16uygKLtMPQzbhBvz0wV7hs82XD2WF0Sh
         tcVwwnByJqVp2mz/Rx7TB306oiwQm97j518f/kOOn1RnWU4Sb9FDNS8uolYJt7x63rfc
         Yp19PlrZWf0X6aM7Fvub5ltAjcvvq28fIk1dcbVsjXhDDQ4XI/tuhSqiOEw00rE0B2gC
         C5i6Liq20iEae6pFGmDXdkJdAasqiqE7aavx56AirnURwq9Nuus68BKCo8dufEphpP0m
         PZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774435135; x=1775039935;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A/Si9+s7QxxoCBvO+kz7sMzfMBjgo1CChr0Lcp9Yhl0=;
        b=BhR9G9vBQzm+8wOWVTz2q+7ZWF7l/luA7pQeAdVE4Eln+9GUtZEN3bx4wO1LDQT1gw
         RxRmhqgVuM0oYOkTMFIxIqHpb4N61It6BWYR2dSqi175fPZjNaH5e80YPfw9vEbyxeV+
         TFTEwSNO8OtzCjg0tRoXiJBa8VsrVUSbCfTrxC79pqYcWIQZ9paEWPo4F/I/oMGotkN/
         6qkiRcbI+p9yHGKXIQYQE3Qd4e7ceJSN1IVevFgdd9OuFbvw5FEezLBp3HRUsoIwRXug
         Vch5EGLShRm358rQ4691nmHmHY+Ji2+mfMPcpQpDMgRWkBed3jR2wbMAUkyjf5rmVTIF
         R8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXLaGfzW7xbQ/Ko/rV+r7ghD39pZStwm8TjzpDO4LQ3ZL7CBn5WCVFqYNpoE5PXZ9aAB6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTv7XSEsLNCGVThfsI8Ht7eHR1HPZBBaZgVD0Jnf5h5q4aXREf
	rXFCES/ig99nIxGh1risM339HrvY6AZlifRz9t0wSS1t1zKm/WHMrVV+QQ3OLxCPQJPZYVsVUly
	VYGC+E8KZslz8TOHknuRwuYxSkjbKe4PbKTqUL9evG0/VhuTrXN/8Uw==
X-Gm-Gg: ATEYQzzhTBUJqzYM+fJ343gcgzvTPi1XqPWD/qeR3+BBmgf8F0oqJlJtHRu5GxgYoAc
	BeRR37In2yiZACNcq2vSmg3A1Lgc8anhK/hJcsqESOGPo56mEZkMS5KjOlGoSVIUs5t6gqMdPgH
	3JuMFwDsSXS08JFJV7+WoXPVgMd+piz/Xq3gTdDOfn3mPXZ1ktkn79gyxwNQu9j4tlRyoOFHnao
	v8vaSxFxcwJwL61hwIF2+uQ6RQEPOlwyKHW9NgRu2GRs66gHZXkRgVqEuIeCZTVNb4vStZoODP9
	/ozzLRLMz/1rlINoaI9HDi4DlgwCz8E8hZ9yWZFJvOOOfgUqs2UiNujj+DdpVf7OFuU54Y5IatJ
	ABu7x/zSiK4PO1u/TEdPrU67D5Uq3eQk+jTtRuxNZYtMPYkls
X-Received: by 2002:a05:600c:3b22:b0:485:35a4:939c with SMTP id 5b1f17b1804b1-4871608dca6mr40636805e9.29.1774435135140;
        Wed, 25 Mar 2026 03:38:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3b22:b0:485:35a4:939c with SMTP id 5b1f17b1804b1-4871608dca6mr40636315e9.29.1774435134601;
        Wed, 25 Mar 2026 03:38:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871174f2cesm122268625e9.10.2026.03.25.03.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 03:38:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1A9015A4A85; Wed, 25 Mar 2026 11:38:53 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Disallow freplace on XDP with
 mismatched xdp_has_frags values
In-Reply-To: <401134e3-2a2f-4c23-8ba0-3a4cc901d6a4@linux.dev>
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-2-leon.hwang@linux.dev> <87ecl9mc9d.fsf@toke.dk>
 <401134e3-2a2f-4c23-8ba0-3a4cc901d6a4@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 25 Mar 2026 11:38:52 +0100
Message-ID: <878qbgmbwj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Leon Hwang <leon.hwang@linux.dev> writes:

> On 25/3/26 00:18, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Leon Hwang <leon.hwang@linux.dev> writes:
>>=20
>>> xdp_has_frags was introduced by the commit
>>> c2f2cdbeffda ("bpf: introduce BPF_F_XDP_HAS_FRAGS flag in prog_flags lo=
ading the ebpf program").
>>>
>>> The commit f45d5b6ce2e8 ("bpf: generalise tail call map compatibility c=
heck")
>>> was to ensure backwards compatibility against tail calls. However, it
>>> missed that XDP progs can be extended by freplace progs, which could br=
eak
>>> the backwards compatibility, e.g. xdp_has_frags=3Dtrue freplace progs a=
re
>>> allowed to attach to xdp_has_frags=3Dfalse XDP progs.
>>>
>>> To avoid breaking the backwards compatibility via freplace, disallow
>>> freplace on XDP programs with different xdp_has_frags values.
>>=20
>> The problem you describe is not actually a problem, though? A
>> frags-aware program can run on a non-frags interface just fine.
>>=20
>> You're messing with long-standing behaviour (since 5.18!) to solve a
>> non-existent problem. In a way that completely breaks the frags handling
>> in libxdp[0]:
>>=20
>>     Running tests from ./test-libxdp.sh
>>      [test_link_so]                PASS
>>      [test_link_a]                 PASS
>>      [test_old_dispatcher]         PASS
>>      [test_xdp_devbound]           PASS
>>      [test_xdp_frags]              FAIL
>>           Kernel supports XDP programs with frags
>>           check_load_frags:	FAILED
>>           check_load_nofrags_success:	PASSED
>>           check_load_nofrags_fail:	PASSED
>>           check_load_frags_multi:	FAILED
>>           check_load_mix_big:	FAILED
>>           check_load_mix_small:	FAILED
>>           Test test_xdp_frags exited with return code: 1
>>=20
>>=20
>> Please don't do that.
>>=20
>> -Toke
>>=20
>> [0] Run 'make test' here: https://github.com/xdp-project/xdp-tools
>>=20
>
> Indeed, it failed to 'make test'.
>
> Will drop this patch in v2, as it wasn't an issue.

Great, thanks!

-Toke

