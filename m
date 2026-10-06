Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE54B8273
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328344; cv=pass; b=lnFI5v1RrpEh6iVCR9vNOF8jzCKfFOhm5mgfqpD9xchwv/vMYKRg5AeSRVZmTvwCKzHZTot+8zpCl5zWAbaTIpvgUEGqXReZ+gb7MoB1fiEIQfe+84940ccXig0/PnQchhL8oO9rOayWUNKDqeMrr6lNVqmJTB6fnGN6NjPkGb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328344; c=relaxed/simple;
	bh=k6xPrmlkyguhHKDxpntIY2d4H6WRRKWpaP4dH+hr6vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKfABAWD3ayYS7V3ZNbHMQi+Zkm6DQVwTf1B31hTEydsSQNHArG7Y9FQJ2uYeVnfxpRsU3la/8F/MfXDEqj9QubenQV4rZKBgezBtCZM7gw72KCQJvZbtY2OsoIz8CLBgyitHEJktmUxQ/mIX+QiXKg1CqWkXPoTKbpJotgs90M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/UOYQV7; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/UOYQV7"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-483c607ccb4so1841904fac.0
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 16:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791328340; cv=none;
        d=google.com; s=arc-20260327;
        b=rsFmUQLEz0jEaDbkR6iM0ro/4q2TPk/V3FzjrkJg1vNNgz4GLrGIPp6cKI+1k6g3x9
         9Ri5j2ZeNb3xVFQmDKq7wIul4ewQINWnToZrc71vuCHT3fTFX+UIa1Jc6OY6GfLF0K6b
         JHoKAFmrsseZRX+8Jn8RczyE2VDUdwYp8qMvhWz2OZO6Uh1re22eeiHvYFpLQSisVA8R
         e7wj1pltP4/+0J0hVN3/5OGgmlkrnFnhqeo3MkZRWX1LH4EhYhyNVnJCdCQIH7cGMyG9
         APk4jsm7yuJN42hISAM9nM3i7wvr7rJ6pKGnf5rFHKPaMAosnT1sKGpOarMeGBi14C3X
         VhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6xPrmlkyguhHKDxpntIY2d4H6WRRKWpaP4dH+hr6vI=;
        fh=SJCQo2r1J5SkgKi9eshh/mwYIWp0FmGTEsNpK04Ejt0=;
        b=W+nUj2odCImecCOFm5pEXDEJ3HGFDpnU/VXYYdFNpHYXrER8zR3fEvVWpdkF5TMQnT
         4r+A2sP5SBFFA0tOZHYHSnNGga29FLWP1wkaDa7lri3QbPghtGjvNH9/oxgVY+fTR9RQ
         8xkUtlvyOwt0ddlxQZFLpIDGVzO1FcoW6R5kIZr35cqLNeVwcvhcMpMag7TtpSB/NH8C
         B8Y/0PQ+icPPSmJbPC7dqTf/AGEcppEjl/8mXpos8K39+woMDM2eamxDB2ET4YH1NiMw
         Uajelx/2xG7PrKJV32RWMSUcD1w4+uVfPCr8VSZ0/QMgQ9KCBcxte2vHZmNK20817hl+
         9dYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791328340; x=1791933140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k6xPrmlkyguhHKDxpntIY2d4H6WRRKWpaP4dH+hr6vI=;
        b=R/UOYQV7x3GP4uccj8bB9IhEKNFFZ3s5KNxhJpKw89OTZI2u3XkJwR3X6X9dy4sNZu
         1HYI3W6UdF5LYDd3VdOKUrqm9UbrRvLFgvu7kV2rQODbh/oJ/nAZXfvmR7GbCSgGcr+S
         4kpiArWAT/ANz4k+1h5WCNKsho/pFzl3W0jS84i74JI92wqlNpPk7Hh/+hHZFGrBPMc3
         2XAtPLB4RMgU/4GgltzyXGUCpMZEXeZmBM0mdBnVRY+rDdow/UnNlnkrJCLWUYMrP0oa
         /IyvlAOQzFxg5uQHdMeHcu/pfKW5/7yZw/b2zLBu2Q9t+muTDKPr7rUpa7B7cLEWUDbo
         VtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328340; x=1791933140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6xPrmlkyguhHKDxpntIY2d4H6WRRKWpaP4dH+hr6vI=;
        b=zbdLoObymMEo/UKQlEaeBBCKsAjmmvK0ZoRFEf0HwHhNy7hDNRNAjga+Fpjb9rGULM
         txO5ZpSIwE+b86JC5sWVmA0JJCKfQAARUSxb328s8O+kek9bWSvOMwhj4C30RkNP1YwD
         HMuCAoz84liIBJJ7jvIuZAR5YhiM392mO/cgjDXjp1CPHqpNSsE9hivbNX9LrY+2m7eB
         rEMQddiz9dR/j0BeIQzA4Tp7yl4gMN3PZNf02+Tj+/q+lZ67+OCiM78kn2pGI1ziHdRs
         nGzoHnxn46L+ttibDy4A/AdTuIZ/PIH0VJ/uOqdZfKy0NhhinWH1xNlQX8PLj1YRa1OI
         6dTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkfr0Q/knk9q9LD+PMQv6UC9sNg7eiyRDnx1LZ9UqHYoaCGmq5bf5ZTFtyVhTO0PBWhdE=@vger.kernel.org
X-Gm-Message-State: AFuF++l0v40txPYReQ/SWO8Wm9QotQFScy8T4p14awoVKlaV0BscCY2J
	Dw/98IODx5c3uaFRFxJs08WftI7GR3MDdLTEGKRmNC8OWOoFF6ePl9RwcRlLjYBNqBuzediy3ir
	4oJrR5xKemIpeTivYR+mN5hXySOeYCSA=
X-Gm-Gg: AYBFou2xNLErrm6Agr9nE8SQa1/lBSxvfVOfm/Ezb1ec7VwqhL1M3OMoMAQ0rbARRFf
	JCf39ycRFuD5c3FIMME5uTXCPouf8YATIFfPOTnZmtzyimRhNpF65EzwT0aaxuoKMDT/Ryy1seT
	tIdMOJXWHSgDKDQ/K2SZttc7tib3/BH/Wni+9Nkf+vj7mxLLOLC0ahKp9n59EbsNee0OgSJF8/9
	4UhyTTsrsW49Tt05WfzbjjnfgmXqE+BBuV2sEJqJuTtVYn6Y8Ov2KDTcqGmISrhJXNuhbTXz0SR
	P6v0YgfnxMWUSIQQb5pORlsMaoZ6DIHa5WKuXirAk+taD9ulkJ3vIcW+MH+EVw5t7A==
X-Received: by 2002:a05:6808:16a1:b0:4f4:4de8:9373 with SMTP id
 5614622812f47-4fc46890902mr831448b6e.21.1791328340247; Tue, 06 Oct 2026
 16:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-4-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-4-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 6 Oct 2026 16:12:09 -0700
X-Gm-Features: AclHuK8B-88YW137pfmmCWsnwNdwV76mFfbjw9iApZp3P37MJmBB-x2hO4iEa84
Message-ID: <CAMB2axOh_b0TmmjFdonmr_7A7QEFmtO7nfRbYRD=LcfyxKMfMg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 03/10] selftest: bpf: Use bpf_tcp_ops_set_flags()
 in bpf_tcp_ops_hdr.c.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> The next patch guards bpf_tcp_ops callbacks in the fast
> path with per-socket flags.
>
> Let's use bpf_tcp_ops_set_flags() to enable flags for
> parse_hdr, write_hdr_opt, and hdr_opt_len.
>
> Note that BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL and
> BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN are used on the
> server and client, respectively, for better coverage.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
