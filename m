Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038BE248880
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772314266; cv=none; b=Fm+bpzpMJxWaYaim70PZMOhVItQE9rpkBm71Ia4rd7KEw8JsbXHEjn1NknExkqTPyrBO7PHvuWzZSqWKFaYrWHtqf4hg4Js8Qf8sBr5EQHzNLMO1Q1AzcT5Ie5133nbjQLzB/ozIFNoQekM9hFbyHaWVM3UabFr1BLmpTRusNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772314266; c=relaxed/simple;
	bh=MNqlDapXdiHzTEmeLLtwBromOwc12WuSih/Ud7CnCsU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JGqGqpHt49X8RDyTn0fM49ie7SApF0E3orFe8veqgNfPyWMaYHchNYW529ckQmeFZLr0RKNcylAcDbgSuvqkybecKgO0amhJXZBJkXFzYi4u6ctQd590755+KznvdA1iom7MMlfgzfGixPX18fXEtcQgWLdQjJ9w6NwNjyb6uDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=QJbhO3iJ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="QJbhO3iJ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-896f82e5961so50342266d6.0
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 13:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772314263; x=1772919063; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XswkprWZKrLKuM/yjjoFLV+zgozxncFY35B5DZOsTz8=;
        b=QJbhO3iJva31rsYTY9kWFwenQh8gK0Jhl0SOG5Nt24HB2HuT2mOjSfu5syrVthdqbt
         VfIeHtxxij2AjEd9+QUdvd4KGdupv2hwEkc7QLw9OkV/X2QCQTDP6dQmaazpYcI+cJkA
         lC9i2uP0Usl99lODQD4xu5MoRbgxlSiSojVfX6hRnY82B/9a4YDBLaEVXLQJhCGiTssa
         Wv1lTMboHWw3uTsrfs+KmpdFr5k1RgxkcVgVwXyalK7NqV0hqLItT7nAXhgmTB0vguuH
         1Emps6NAOo8ae80vbQk/HBoYtKEJ9CTs6lnVVvDztj6CGAx938z/D2qsvDNSz1G/g7+b
         NsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772314263; x=1772919063;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XswkprWZKrLKuM/yjjoFLV+zgozxncFY35B5DZOsTz8=;
        b=Qu7fbSYHOrKPh0tzjijcGhZw1wIfxbRHQvGoSpovpl5siWNAENAK+nXT08wUuM0V4l
         t92iASjIEaLeACQClG1MGqHDhPcHtUTfB5i4ODTSZCf9GcI5BnXLv2RuHDwtU5ihspX1
         CX31bWqQ+WVuBWGjqP03TTZlTdNDKmiVf6xnMDp9G/C2I5Of8IeQMVIzCroK8AUOhL0u
         E591gZge+sW3/0mj6gIKTtONK0tN2Z/lSElnpoc2wsLbzeAVpZ8+H0pfWp68x8hX4CQs
         zqL2wdD0vCg6M93ZJZd3pC3fJSauatfMV3Hz+WhW0xGMmGyOzoQyqW69d8FiyNYYdCAH
         cjFw==
X-Forwarded-Encrypted: i=1; AJvYcCVp0PFF2R1j5JwZK3dfIWeiLW86PvwMC7H7lEmWBzfCCwiD3KWLgPhAGVUSmAQZTKiLu8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkgYt0IN0ArokUoAVr7A39nfVXoAomepZ6iABtttRS5cRk2sIg
	7Tc4W1dYxLCyV6GiWn5ogm4dZhhZx8/zDatVAN10n6IlVZ0MLAMJLQt3WUlZ5RIIfbs=
X-Gm-Gg: ATEYQzzeyCEL9p8n751UuY51KFEzqMOzFbzW9T6RIPPZcjGgpTmB4UTuIuVVLfL+B9L
	2I4kzfT9VF6spHuw3xCTFO1TIpN3LG96CsQQAWgic35MGAcSUJ1RUbhH+1SWIyA099ttUhJtzDb
	ZfH3xDr+OT3EJirUPZ3Cr9JtL7FAyrEPn+GrKadpUyDMhTrrhWY9y0fVI2hTJZb1HhJ/VKkbdyp
	NSU8VKn+NJoCZHcpGiK8KfZ3zNhI86MWCjFbIZmNmL6BakNfyT4iB5ETDGqZvm6RedSyE2jqtNG
	1K5b53zVfnyap2V1Y1zOk0uBTF8ROBIAOROm0k4Ff2+AK0qzxF+y6k13YmMksPtw7GywbhfVQO6
	NhGcqrk90IHoLIxdSQ1EmBUc5iFvC/dmIjF3/dUkgNWYmbPUGUBom1guh1bbEsaVbDDpRcKWuMp
	wre39aOhPIAsfkldZZHkmIwrg=
X-Received: by 2002:a05:6214:ccc:b0:880:5bff:74b6 with SMTP id 6a1803df08f44-899d1d6ca5fmr106612076d6.7.1772314262776;
        Sat, 28 Feb 2026 13:31:02 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7158db9sm73834406d6.3.2026.02.28.13.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 13:31:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Feb 2026 16:31:00 -0500
Message-Id: <DGQWYZE6I292.1BN9TAIIVRK7T@etsalapatis.com>
Cc: "Hui Zhu" <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Use bpf_core_enum_value for stats
 in cgroup_iter_memcg
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
X-Mailer: aerc 0.20.1
References: <cover.1772261955.git.zhuhui@kylinos.cn>
 <3a788ec239e9f9590897b43d21995e3a3532d916.1772261955.git.zhuhui@kylinos.cn>
In-Reply-To: <3a788ec239e9f9590897b43d21995e3a3532d916.1772261955.git.zhuhui@kylinos.cn>

On Sat Feb 28, 2026 at 2:11 AM EST, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Replace hardcoded enum values with bpf_core_enum_value() calls in
> cgroup_iter_memcg test to improve portability across different
> kernel versions.
>
> The change adds runtime enum value resolution for:
> - node_stat_item: NR_ANON_MAPPED, NR_SHMEM, NR_FILE_PAGES,
>   NR_FILE_MAPPED
> - memcg_stat_item: MEMCG_KMEM
> - vm_event_item: PGFAULT
>
> This ensures the BPF program can adapt to enum value changes
> between kernel versions.
>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

Bot's comments aside:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/progs/cgroup_iter_memcg.c     | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c b/tool=
s/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> index 12f79a44133e..06a385c9d85b 100644
> --- a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> @@ -26,11 +26,18 @@ int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
> =20
>  	bpf_mem_cgroup_flush_stats(memcg);
> =20
> -	memcg_query.nr_anon_mapped =3D bpf_mem_cgroup_page_state(memcg, NR_ANON=
_MAPPED);
> -	memcg_query.nr_shmem =3D bpf_mem_cgroup_page_state(memcg, NR_SHMEM);
> -	memcg_query.nr_file_pages =3D bpf_mem_cgroup_page_state(memcg, NR_FILE_=
PAGES);
> -	memcg_query.nr_file_mapped =3D bpf_mem_cgroup_page_state(memcg, NR_FILE=
_MAPPED);
> -	memcg_query.pgfault =3D bpf_mem_cgroup_vm_events(memcg, PGFAULT);
> +	memcg_query.nr_anon_mapped =3D bpf_mem_cgroup_page_state(
> +		memcg,
> +		bpf_core_enum_value(enum node_stat_item, NR_ANON_MAPPED));
> +	memcg_query.nr_shmem =3D bpf_mem_cgroup_page_state(
> +		memcg, bpf_core_enum_value(enum node_stat_item, NR_SHMEM));
> +	memcg_query.nr_file_pages =3D bpf_mem_cgroup_page_state(
> +		memcg, bpf_core_enum_value(enum node_stat_item, NR_FILE_PAGES));
> +	memcg_query.nr_file_mapped =3D bpf_mem_cgroup_page_state(
> +		memcg,
> +		bpf_core_enum_value(enum node_stat_item, NR_FILE_MAPPED));
> +	memcg_query.pgfault =3D bpf_mem_cgroup_vm_events(
> +		memcg, bpf_core_enum_value(enum vm_event_item, PGFAULT));
> =20
>  	bpf_put_mem_cgroup(memcg);
> =20

