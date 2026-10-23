Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792789591;
	b=z8+PxWaQQfJmN1KENwYGklgOBcsPcBwxryZgpIVIgXtexvVKJO/CrTs0WTfKh/ge2cmy
	 zDjkYbjAzqgl/EfcJrnAOfFlroR/4UGCg1eMuJd5jttIJV32vHNtyzyfYYzKHi9goy4j1
	 rYkmY/wOnDW+tZ0lIv/H3BbhIWCcDNRIb3e9Ne0jgvZrFe1bdvWOQxq/Ho8oBSVyN6IiE
	 qIkL3YaiJ+GhsCKzFTL3AhxoY88LFx1ANumOPlyUkFlmDge9FFbqeyzNXmtM24eMztcmW
	 qZQ/HPyJ9C4xrHYKmz55gJrSVZKy4CpKXFfE7w3/G0VhjkfllueizkQJkvwcoSoZFCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=B81JhG5oBLgzvk4unoyO/Obs8jvRI83INB837bEDY/g=;
	b=nVaVsLABqpQpPA/aO0psIxafZo2bBXAipLQ1uPf0g8YZjhxxrTRse/UpWJzuv+t2w4fL
	 702skOlfScg59J6TJ+XC7ue04rNYXX3DxE7aDZ+S+8+PbTJF2eGZpxw0FDxMZQrx4dX4H
	 fl3XFYAhwomef4Tn+SnPSRt+diURHssr8ajWPKnyZZSf/mWGl3QKOaA9gfA/x3HQPVXNY
	 n8w/lz8/e1dc4WPJQT2csco/CKDnRo4dD9Il1TcPLXt4VIJqZPY+sft4IgzschR9paqAY
	 E3RmFgi8JhrzcQEsCC7h9X3gKTrjechpVkefl0vh5Fn8ipU4t6S0SU7brHkYM4iTEww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LbTEuS7U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C10606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 21:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22C10606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LbTEuS7U
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f48c750afcso800059a34.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 14:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792789590; cv=none;
        d=google.com; s=arc-20260327;
        b=nuWlK02JjzvDkmAXlXozaojiRP/iAlaucg/gtsQ9JGHaJRge76L7f0Kkw4QYRTBu29
         sr1gfC9tabh30+7x6YtRQGBBFOjCSVA7QpHk9TVJxVTXLwpHiCudG68WQAi/Bk+jCqcB
         Fh5r9ZJrfoCFODEn9tYu+MtVcnMGn+aCIskMCHRDTPsKjozMoXrWkzr/f53DmcVUZZRq
         +xkTXbpkw5D7LeegdbyvSafzGjkUWBHseWUeiyFQvVHyvDn/uMSE385d5A9JcDFxrcjl
         axIsiQI4T9e8BidGUqvWh3/TlDoqoPguTWkZVcthxrlmVLDZg7DSYopSU0TPIbUBxQbg
         K7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B81JhG5oBLgzvk4unoyO/Obs8jvRI83INB837bEDY/g=;
        fh=C7lln/g48efu3b/Ij34xPRrLCiJ+tHNuWcTqTFMPW+Q=;
        b=TRX6vl3ZZYjRhXqqjlTURCDosqzJ4JpgLTpb16Ek/EIDVEXJoYV6SvdqoFLT+QVypz
         pvWJQl4r4oOpmYHxyIfUqSuIaK6K9tH6E1wnB0Csq611+2zviyU7VGwozXqIpCkvvB5V
         YUivDAWltVhxTbY1EKN8YHw9osktHj2nR+C12y0r0TH3nGhmtcFhJeP3nzIhHefQPvv4
         MiXI9PIAlqzfm7iEzYjfkGvkAFINnn2sfRpHHFqP0VPrkk6dVtMoCFAPmh/ClqVlWPxC
         vrgyvVxO9eMg0JA3rYn8a0q5fvkfT5/WUmJwYqxczVXceNw5lKogXJHUdnuIiefIbIEr
         +tRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792789590; x=1793394390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B81JhG5oBLgzvk4unoyO/Obs8jvRI83INB837bEDY/g=;
        b=LbTEuS7Ux8e0j573K7MhU2vm79E8Zc5Vd0Oh3AE4CaPKJdlNISyhaBIfBt/OEA0rxK
         yKXIdkZQTz8Jhq9pOzh7yG2EIdEursa1+d+FQo9ycmAl6fS8s8djVJXQnrexZr/pJ8I9
         dPqPg9/sL2VjO45HMToYFi1qNIPCl9VqhlmoXSw/tEd9COrXiOk2svE66Gn+BAMAfoqM
         j9L0dmGksi7n1cNKSLka5bXT2ReWBxYBSwz5sdgNRP+6SXun4xlPuXLm7XIxsYBKmLq6
         ar4JVFIZNGHiK81sMw6ieF+Z/xI1PzWjbsxGoVsumIbd81i6ZIsQzag4d8M47mjJNtX7
         BUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792789590; x=1793394390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B81JhG5oBLgzvk4unoyO/Obs8jvRI83INB837bEDY/g=;
        b=XB2ie22eOfBapFcrVFk9qH2mGfWLqsscaBYT7KAmZXI8b1tXyvWOulCot1783+o5li
         vH34L0cjYd5y5j7HlI/33K+xwFE396yshu89J8fvneQwB3bIOx1yFqi1smd76S6RD+Mt
         xR3GARkXwgAQuTv27NEDjAeyWmJyRbhDt/2A6twquf5pqsVzt8CdhPT+L8M3dbqN4L76
         iAdA8PwR1O9yu8un3si3qB7NwXJbH/ICYVX+pbwrDl6/7xJ6fmDNctNk5rz89ZWzUThs
         TSHiB6YVstot4PB7NjSPyWuPmwBK+x1OqSxoOe8IChtXgoEsjULPo5b2ESB4uYd8IFyJ
         Y8Yg==
X-Forwarded-Encrypted: i=1; AKwUvBwMVZZUR32fNyzhNnkxNt7XViL2rzUjqKnASeEufdfUpbtYS1iC66ls61Dl6iTQPOY26QE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmEYne8sf2Bj5JYpCvXxj4BxQZA3C5Hovt6GJAoubkU47HaeQr
	CfG/kB/2xddt3sUV5ar2NIzAJ/UWFuCCcMHPdmFVeK4YKB5hKVfcV9zXcwcIcF+lHHR6ey+9+Pz
	9puO8M/FSaXEGbrTs29l9wMLFXbj0RE0=
X-Gm-Gg: AYBFou2ztW5xVRSg1Dy8ogi/RmYaBNc3o8JWc3cjJJv/7/e815slWiMoet6DN7Mu5Rh
	ZDZ4ebor0prETgmHmt7gUPM/nYdfkXJ22X2/ZpRRnjFTFvnVtUNxLWCIGPOyKSTb1jhdiAhKzSI
	cRnRdCafVO8QFvJVwuyy9cdB4F65o5sJqyAWwJiLp7s735g57Jc3lUkZRlosPDfJiz+QOogmCgE
	zkPaacSfHgJGEpEOFVeeT194cYFPwf17CdYgAINxKb7ALjQ3J8Xev7pfAkP+azacKf3m486JvtT
	BxTo31q/eYGcpJ0e44QA2p27wgDjgXpV6hqxpmd4js8ZLls5EXGVQQY14Q/ATl7vDM8LMEh6I2D
	rwFzl2942Kia12DtWprjbmtHKiLO+eQS4DI2J
X-Received: by 2002:a05:6808:11d0:b0:4f2:6f1a:a34a with SMTP id
 5614622812f47-55c00261ddcmr323202b6e.12.1792789590065; Fri, 23 Oct 2026
 14:06:30 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
In-Reply-To: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 23 Oct 2026 14:06:17 -0700
X-Gm-Features: AclHuK9TRgslO5apNkTHDd2WGpGoCt37hFcjtmqCOM6wGIxqCzpcyynr5JgcoDw
Message-ID: <CAMB2axOYfDT4HiaWvjJwcBvsXsUL944scQNZjMAPAgJchG26ew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Fix a struct_ops use-after-free
 behind a flaky assoc_in_timer test
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 1:48=E2=80=AFAM Qiliang Yuan <odys.yuan@gmail.com> =
wrote:
>
> st_ops_assoc_in_timer_no_uref drops every reference to a struct_ops map
> and expects a timer callback of its prog, 500ms later, to find no
> struct_ops associated anymore. It fails now and then while test_progs
> runs other tests in parallel.
>
> Since commit 5db69b0fbdc8 ("bpf: Make struct_ops tasks_rcu grace period
> optional"), a struct_ops map clears the association only after the RCU
> grace period of bpf_map_put(), so nothing waits for a prog that reads
> the association in between. A timer callback can then return into a
> freed trampoline, and the kernel hits an int3 Oops.
>
> Patch 1 lets the association be cleared in any context, and patch 2
> clears it in map_free_pre_rcu(), so that the grace period bpf_map_put()
> already waits for follows it. Patch 3 adds a test that catches a map
> freed under a running .test_1. Patch 4 has the timer callback of
> st_ops_assoc_in_timer_no_uref retry until the association is gone.
>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
> V5 -> V6:
> - Rebase onto current bpf-next
>
> V4 -> V5:
> - Drop the free_after_rcu_gp of struct_ops maps, which is dead now, and
>   update the comment of free_after_mult_rcu_gp in struct bpf_struct_ops
>   (Alexei)
> - Also stop the tests when associating syscall_prog fails (Sashiko)
>
> V3 -> V4:
> - Clear the association in map_free_pre_rcu() instead of deferring the
>   free of the map (Amery Hung)
> - Add patch 1, replacing st_ops_assoc_mutex with a spinlock, since
>   map_free_pre_rcu() may run in softirq
> - Stop st_ops_assoc_in_timer_free and _no_uref when running syscall_prog
>   fails, instead of waiting for the timer forever (Sashiko)
> - Point Fixes of patch 4 at 0e841d19263ab, which added the test, as the
>   delay left after patch 2 comes from freeing syscall_prog
>
> V2 -> V3:
> - Wait for an RCU tasks trace grace period in patch 1 for every map, so
>   that progs reading the association under RCU tasks trace, e.g. from a
>   bpf_wq callback, are waited for too (CI bot)
>
> V1 -> V2:
> - Add patch 1, fixing the use-after-free behind the flaky test (CI bot)
> - Add patch 2, a test for the use-after-free
> - Point Fixes of patch 3 at 5db69b0fbdc8 (CI bot)
> - Move the restarting of the timer into patch 2, which needs it too,
>   so patch 3 only turns it on for st_ops_assoc_in_timer_no_uref
> - Rebase onto current bpf-next
>
> v5: https://lore.kernel.org/r/20261019-selftests-bpf-struct-ops-assoc-tim=
er-v5-0-77b2e181e5cc@gmail.com
> v4: https://lore.kernel.org/r/20261016-selftests-bpf-struct-ops-assoc-tim=
er-v4-0-9ad31c21220c@gmail.com
> v3: https://lore.kernel.org/r/20261015-selftests-bpf-struct-ops-assoc-tim=
er-v3-0-efe643d4b2a3@gmail.com
> v2: https://lore.kernel.org/r/20261010-selftests-bpf-struct-ops-assoc-tim=
er-v2-0-d7a43896dbf1@gmail.com
> v1: https://lore.kernel.org/r/20261009-selftests-bpf-struct-ops-assoc-tim=
er-v1-1-9a97a9b3d1db@gmail.com
>
> ---
> Qiliang Yuan (4):
>       bpf: Protect the struct_ops association with a spinlock
>       bpf: Dissociate struct_ops progs before the grace period of the map
>       selftests/bpf: Test freeing a struct_ops map under a running prog
>       selftests/bpf: Wait for the struct_ops map to be freed in assoc_in_=
timer
>

For the set

Reviewed-by: Amery Hung <ameryhung@gmail.com>
