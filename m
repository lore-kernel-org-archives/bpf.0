Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703DC2DEA86
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772315421; cv=none; b=rbsoX0Ryk7jJzsJWnaXWI6OHMFzzj94a/sPqFYHCUbZjeFUBiRIUuOP4wTyS6qKvcuSqR5C5wRl1jZ/qd5Go7sJNAPwCEidfq6vTf3WiTuQ72xL4ZgQi1mDA8QkcErTCjXYNsHRJ394a992dAC6W01QaYukIgLBVbSESTXPZN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772315421; c=relaxed/simple;
	bh=jmfwJKfAR1jtQZJ+9zA6M6A9IQhwuA9QpgAiwX12Wu8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=EIdnvCw1t20JWJYz5UQAt7nqpITYDCX93fWEZLTsG6WoP/wxmbVMK8d7obLL4FRhWQjJsn5KfGfvwQS8e4HNB7XzPFbGuBFyuY79AQQvAXUQs7DtYaTKXvFwiIdaLKWx4zmw+QllIy4wbKeh7PN1n/Lgao/Z9ZsXhkr1QXA+6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=LM+oo9rT; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="LM+oo9rT"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506a67282a0so33295921cf.0
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 13:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772315419; x=1772920219; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+f8XonCm5/3C5EterxMhivO6MSQ1rxOv28So/EOBLI=;
        b=LM+oo9rTgYwhOb46TcQS6IEmiF4HjyjrIeBK/6apJedTXFWNZlbdAGF7RIwt22Ic/p
         5HHEfnGLRuiEZXjmnS7+Qg4DloYzh+KzDRiM97yW1yRbuGrbb6Mc/JDfUIsPW10MwzAg
         WbqVz0lB8FqzYVhXbMC3ddgX3xhG/WZhJlZFx0dYM8SJHBVYdvnyoo7FaOHkT116+ooP
         PS4ujBnJMG+8eOFYQYTJJ12v8s8KYgL5Z7yVqDIuFdqT7YVJkvEx+XR+21Dy+idPiqJ4
         e1fR/vlviuJYXbfjeJL1N+VktYZ3joUfrZx4LQlBOpnFV88Dntme63dqQ+NEVUAtRY86
         hsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772315419; x=1772920219;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+f8XonCm5/3C5EterxMhivO6MSQ1rxOv28So/EOBLI=;
        b=PlI28LN2rrrpSJ4Ms7JiUrTzmN2/2UQDN5fdMwbCjb69ERCbv2tZtsoDfF2/CDa1+m
         pIll/P7oyNktjZ2F5sXqdkkcNkJ6klLqGiLoldfbTLQjf07QPSvhypJMygdppH9/dK6i
         eRcybIxbFKtbX+QTRxZIwCeIZVbMEB9b1Amt3uQQBFV1ljr7duoemB8HmegfvB/6y4cz
         K2fBNZk2GBy/pc6FxJAVpCKb+yi0yhVZPqXnu6JKlnmAfMzhxX61CV98VOzVUV86ZWi1
         +W2TaIvBQ71Esx/91rM2G99ktomFddwx1WexSQtkLHtXBnRIeXPqsPaI7fB7ZKbWksxr
         kCuA==
X-Forwarded-Encrypted: i=1; AJvYcCWIFNQtf+xXRxg/aTJ+fKcFKDzcitKjhD94CADKa0y9T8LrdChM93yzdZkmJM9+gsZ5UCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBw/rgCLHUdhljCTCZJ4rbbL1Eucrd0hrsL9unLIdrPI9B2OCA
	2s5NHSwmNXbeZ+pHObXeNQS1vyR4iakJLMe986x0CwjMoM8vaRfT0uiDH0rWAuS6/n0=
X-Gm-Gg: ATEYQzzLOucEX25Pr8qiIz9vEtgeJUAllxaV8q0nWtn123EUMR+wSwk2OdwNKlVgg9l
	A67HCsSMgsjlKn15tPMkRVwh+4QqDKqGbhOVHw2gbiGAspRugoIx9Ocp1pgdHHI9K3D+e54sae8
	z2lvdo3BDK95ztjJxdKqBs7LkcG+q63HJBi8KII4c+azmURO4nMoZfBaJdPweIAdwLZgx7BxxES
	iOjr2/YwaJ6LFy//VdTqQAela6TMrZ7KEpXM65lzulH7A6kmm3C1INpFu0tNMJamchIELcC4yTk
	j3kwbYY6dQwNpwvDoEkEV3f8KBG2W4qhaBTROZmUon+NG6mLxZPSPAEv+5hC3F0FLQX6IcCRJwZ
	PHYsddpBtGy01RNiFWn7cGsZGsrdkm8h3GnW2DjCxY1pILzlf+J3uIG/Fygd8q5iM+B4aKDCdcB
	c76SGaYEMbMQlyc/vi5T85lVo=
X-Received: by 2002:a05:622a:213:b0:4ee:17e9:999d with SMTP id d75a77b69052e-5075291190dmr102299771cf.34.1772315419311;
        Sat, 28 Feb 2026 13:50:19 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507451cda0asm81287321cf.24.2026.02.28.13.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 13:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Feb 2026 16:50:14 -0500
Message-Id: <DGQXDPH0QC4V.1LVX4WKVY8DWV@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Check
 bpf_mem_cgroup_page_state return value
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Hui Zhu" <hui.zhu@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "JP Kobryn"
 <inwardvessel@gmail.com>, "Roman Gushchin" <roman.gushchin@linux.dev>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Hui Zhu" <zhuhui@kylinos.cn>
X-Mailer: aerc 0.20.1
References: <cover.1772261955.git.zhuhui@kylinos.cn>
 <fac266012001b88e2bd6e33578090627b919fd70.1772261955.git.zhuhui@kylinos.cn>
In-Reply-To: <fac266012001b88e2bd6e33578090627b919fd70.1772261955.git.zhuhui@kylinos.cn>

On Sat Feb 28, 2026 at 2:11 AM EST, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> When back-porting test_progs to different kernel versions, I encountered
> an issue where the test_cgroup_iter_memcg test would falsely pass even
> when bpf_mem_cgroup_page_state() failed.
>
> This patch adds explicit checks to ensure bpf_mem_cgroup_page_state()
> doesn't return -1 before validating the actual statistics values.
>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

I'm a bit confused, what is the exact scenario where we read -1 for
these stats? AFAICT bpf_mem_cgroup_page_state has to return -1 for them,
and it turn this is possible if the idx we're passing is not valid - but
the ones we do always should be.=20

> ---
>  .../selftests/bpf/prog_tests/cgroup_iter_memcg.c       | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b=
/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> index 88fc3e83d2b7..9eadfbd3fdb9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> @@ -53,6 +53,8 @@ static void test_anon(struct bpf_link *link, struct mem=
cg_query *memcg_query)
>  	if (!ASSERT_OK(read_stats(link), "read stats"))
>  		goto cleanup;
> =20
> +	ASSERT_NEQ(memcg_query->nr_anon_mapped, (unsigned long)-1,
> +		  "bpf_mem_cgroup_page_state NR_ANON_MAPPED");
>  	ASSERT_GT(memcg_query->nr_anon_mapped, 0, "final anon mapped val");
> =20
>  cleanup:
> @@ -88,6 +90,10 @@ static void test_file(struct bpf_link *link, struct me=
mcg_query *memcg_query)
>  	if (!ASSERT_OK(read_stats(link), "read stats"))
>  		goto cleanup_map;
> =20
> +	ASSERT_NEQ(memcg_query->nr_file_pages, (unsigned long)-1,
> +		  "bpf_mem_cgroup_page_state NR_FILE_PAGES");
> +	ASSERT_NEQ(memcg_query->nr_file_mapped, (unsigned long)-1,
> +		  "bpf_mem_cgroup_page_state NR_FILE_MAPPED");
>  	ASSERT_GT(memcg_query->nr_file_pages, 0, "final file value");
>  	ASSERT_GT(memcg_query->nr_file_mapped, 0, "final file mapped value");
> =20
> @@ -119,6 +125,8 @@ static void test_shmem(struct bpf_link *link, struct =
memcg_query *memcg_query)
>  	if (!ASSERT_OK(read_stats(link), "read stats"))
>  		goto cleanup;
> =20
> +	ASSERT_NEQ(memcg_query->nr_shmem, (unsigned long)-1,
> +		  "bpf_mem_cgroup_page_state NR_SHMEM");
>  	ASSERT_GT(memcg_query->nr_shmem, 0, "final shmem value");
> =20
>  cleanup:
> @@ -144,6 +152,8 @@ static void test_pgfault(struct bpf_link *link, struc=
t memcg_query *memcg_query)
>  	if (!ASSERT_OK(read_stats(link), "read stats"))
>  		goto cleanup;
> =20
> +	ASSERT_NEQ(memcg_query->pgfault, (unsigned long)-1,
> +		  "bpf_mem_cgroup_vm_events PGFAULT");
>  	ASSERT_GT(memcg_query->pgfault, 0, "final pgfault val");
> =20
>  cleanup:

