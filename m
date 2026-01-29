Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3519E33A9E4
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707308; cv=pass; b=s/2f0p4JN8gPu9o18wFGpI5auwQNJk/xiwg1ljOB3bkkLGpagkJ/KflDS2a6FdgAp0wrtA3rY988xLVvQtJc+gwkQCRu4kAegZKWBzE962KS2KKoCHzoNAAiY4fSrdCUmthn5WkyyPFmrNencdXCqyilTb+sCocJLGjnk0kQtDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707308; c=relaxed/simple;
	bh=B/Z6oc7nhVZLZTSl8l3OJXcNI+VHpZ9v5E73ZIi4/a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5utKvrY6JQ1DiY8muApLVAATWTnf0kmSCfqASTxo0CARWfu8A7wGJ6gKsJbp/eW7xJK0IQlrZngJxBpbDSNxJzqejatCeTGM0J93vNoGEABd6dcdhatvGnJZoWusiKUobr+YbIE2569SrdfC1bXKeq6NokfUEUt7xgpLaXZHZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqTrkf07; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqTrkf07"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806f9e61f9so6809285e9.1
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 09:21:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769707303; cv=none;
        d=google.com; s=arc-20240605;
        b=A49hyYTzVLPi+B3Im6brUCNQXnZEWOcGvP8LxfLBomLrIRIGC9YZp8iEKIwV+iBLsw
         8UIO3xTMu87F7D2ruAiAXlOAp/lrI68kOSUo6W2UQiU5A+k0eiyO6crVQn4NjVEY1H6q
         zam/7u5J2S1Lme2iSbj4b7KexiwMC0gxQlKrj5cBe0KcS0nSqIYZqtCHFPS+h8OVNT1V
         lDZ+wa5UI3Ae0zqfCRbonjVnAGqgC8YAMxuaiC6i48qqvLHrPmUXw3pXDdv8O29Cuma2
         FbdowD3rbR/ATWihsfytEUv8AtdAdaDZ3MEWWrNrsqbFGSExIhJwdoiKcFY4466t9ZU6
         bfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cikD0DW64ATmIS3V1f2k1Y72bgL6wosY2UHz3lIPFuY=;
        fh=z0TKgKqhpYFfoAhb3m8yj9aPZbMxzArk1AvkngHDaLc=;
        b=Ez3Qj5/wLW16LcFC1LB39RiNr7UzKgTHdAJJS9p/zecVATiwEbOasYMLOshYIUp8jM
         +Teoo1kw/jBpLUfWMGjwhw0ux41qayH/rOIjyWIlKHZpy8q1ZAGqKS/+PPyK8do0EuGp
         EBE0K7IBbpCulpgbBvsQnwj2OkBxNwMBRsCcbk0LifBa1tEDShKHIsj1DYrl7zt7u835
         dRxln8fGIZsPGhYCO+aM9/HPZuCubBGqx0vbuFc44C4W5+Us/yaYiER3RPWyhi089HwJ
         3Z/6pDR2052yCsykzCe5ElX8mXwMMUTvpynJ8eeurONYz/1Rz7icX5VH6nC2TDDAAGYG
         qRxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769707303; x=1770312103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cikD0DW64ATmIS3V1f2k1Y72bgL6wosY2UHz3lIPFuY=;
        b=fqTrkf07A9uNBUvum5EirnKvylY3pj5K/5N766qDYR/JT0w/JKERfjgeKKb7N917H1
         jfFCd0wTlPOT35abzvp+U4WULNOKG6fz7FU5oN2zDG/gE1mYEqlyCGZ+1X+QqnfEVDxU
         Or6i+ZitZzrbXKmiT/2PgI1fSqnEWOCojDSz+aG0YOcv9lTR4wfgQpNU+ZlFsObrliF9
         9m2ylPy6sMBN4bGH9xqpUNjdUr6E7ddniahFrSJICO5Rg2jeB9E1fXnRNyAD/zHapSRb
         jUv2S50Z3BXJAWWmCs+NwGHhOyV14albsx0mlZ3fmARZ4Uz1fmgxIC+6acx4EADMzFs9
         3RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769707303; x=1770312103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cikD0DW64ATmIS3V1f2k1Y72bgL6wosY2UHz3lIPFuY=;
        b=uw5XGVFST9ul0LroSqRr6ftXF/S/Ya7N3Axthch4+eZ1C24rvyHoaW2jRdP25OM/S8
         ZuiyRGIzYuz6xEFmDHaYWyuJFbDQ4dcvW+c9R4UqUqnUHu+rfKPcs2t0I0wbGOJY5Dug
         X8jfLV3MCren78Rpz20ZVEgRP4rs4ri1QrJBYN7maaM5O0HDy3qY7C0njGdobGrobY9I
         LadJB7MDFY9vRQ/SOb78M4PEixnMuNOEFbbVz6KqeQKaYHb3rhtff3wuxu7uAlgk3RDz
         jW4A4tZC3qGJ6ROPWKsyK3xmRaC47IoTEi0MrnylfH3lPXWHdX6znnfLVMRu60hirVCb
         ec5A==
X-Forwarded-Encrypted: i=1; AJvYcCWn53XvddBDoler0FyQvKu8c4f2zC6zibQcEsHV22PoWxcrqGo3VwGzKgJVo+srvbiE/0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgVOeWop2e/+Od/I4XbDLvH9dwtm+Q6B1PhLF9d/XaJNDAkNvZ
	x9/scWpA91W6yMNAG3YEq4Sd15F5G5NnUAwVf+bQJI4FhrEKQ8olmd2ARRVoY/CPBYzYsKgC0GK
	BVlwF6mRA5fklcBAuqRHMkSAtnJzeTxw=
X-Gm-Gg: AZuq6aLC8CMnxPT35XYnPt1M+53dWqEUTv+a7hOWJvjruEtxe0fhGPBhQWp3Iw8+7Cl
	tq0UJTkkTK2sgP910Z6sDu6/eUiobNkmcLsyFnKu31GyndB4PQXKfdrBFP8Jzk34NoKP/2eMYcF
	W01504K9haYyhntup0pWAdy0ck513uGrC/3a37cCuzBpWAfdlQwIJ4tElc9CNdmqb+wxTFbEhsy
	nO1qxhIqbfJPFyHdAIr0sf2VrG+2rwD/rKZp6lFqU9ojT8KP85ttTEHEqbF9kGkal5N1yfktT6r
	Zcl1HhUsNIbE1N+swrleYHN4Guf2mLUHd47+x1BoQt97iMGnaUXwbp1IeRoHadqzWfQz/242
X-Received: by 2002:a05:600c:4ed0:b0:480:4a90:1b00 with SMTP id
 5b1f17b1804b1-48069c69584mr116465305e9.20.1769707303333; Thu, 29 Jan 2026
 09:21:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129135426.93424-1-changwoo@igalia.com>
In-Reply-To: <20260129135426.93424-1-changwoo@igalia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 Jan 2026 09:21:30 -0800
X-Gm-Features: AZwV_QieIcsJO1VA71VFB7TRPCNl-paSdxCtbBMb_Zd5Q7mc_krsW0CoTdbFns4
Message-ID: <CAADnVQL2huFSNAn4Pkbx2GOqAB=Z-rtd+Fp3BnJTZ-tbzOhgmw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Make x86 preempt_count access compatible
 across v6.14+
To: Changwoo Min <changwoo@igalia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-dev@igalia.com, 
	bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 5:54=E2=80=AFAM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> Recent x86 kernels (v6.15+) export __preempt_count as a ksym, while older
> kernels expose the preemption counter via pcpu_hot.preempt_count. The
> existing selftest helper unconditionally dereferenced __preempt_count,
> which breaks BPF program loading on older kernels.
>
> Make the x86 preemption count lookup version-agnostic by:
> - Marking __preempt_count and pcpu_hot as weak ksyms.
> - Introducing a BTF-described pcpu_hot___local layout with
>   preserve_access_index.
> - Selecting the appropriate access path at runtime using ksym availabilit=
y
>   and bpf_core_field_exists().
>
> This allows a single BPF binary to run correctly on both v6.14-and-older
> and v6.15-and-newer kernels without relying on compile-time version check=
s.

See.. with bpf approach instead of kfunc this new helpers
can work on old kernels without backporting kfuncs :)

> Fixes: 4b69e31329b6 ("selftests/bpf: Introduce experimental bpf_in_interr=
upt()")

fixes tag is not appropriate. It's not a bug fix.

> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  tools/testing/selftests/bpf/bpf_experimental.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index a39576c8ba04..0194c0090e50 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -614,7 +614,13 @@ extern int bpf_cgroup_read_xattr(struct cgroup *cgro=
up, const char *name__str,
>
>  extern bool CONFIG_PREEMPT_RT __kconfig __weak;
>  #ifdef bpf_target_x86
> -extern const int __preempt_count __ksym;
> +extern const int __preempt_count __ksym __weak;
> +
> +struct pcpu_hot___local {
> +       int preempt_count;
> +} __attribute__((preserve_access_index));
> +
> +extern struct pcpu_hot___local pcpu_hot __ksym __weak;
>  #endif
>
>  struct task_struct___preempt_rt {
> @@ -624,7 +630,13 @@ struct task_struct___preempt_rt {
>  static inline int get_preempt_count(void)
>  {
>  #if defined(bpf_target_x86)
> -       return *(int *) bpf_this_cpu_ptr(&__preempt_count);
> +       /* v6.15 or later */
> +       if (&__preempt_count)
> +               return *(int *) bpf_this_cpu_ptr(&__preempt_count);

please use bpf_ksym_exists().
It helps to catch missing __weak. This patch adds it,
but let's demonstrate best coding practices.

> +       /* v6.14 or older */
> +       if (bpf_core_field_exists(pcpu_hot.preempt_count))
> +               return ((struct pcpu_hot___local *)
> +                       bpf_this_cpu_ptr(&pcpu_hot))->preempt_count;

iirc pcpu_hot approach was there for a short time.
Like 5.x kernel didn't have it. It was per-cpu var too.
Pls adjust the comment.

pw-bot: cr
