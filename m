Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F734FF4E
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804640; cv=pass; b=GnYMAyCz9+Qj0eJJ4MnZ2liy0fb1Ya2Dq29nXk4p+wpTPFHAJJBCJ2S11hrIwhWs8MF5R7QHHTe1S39u2otFghjWZ1y1nds/S36LpCN1mYqVB6/QZCkaUq5yR/DaieJ/0s5e+l7r94RlmrvZLmirOLC5YsgtEvfIeYAJGMvrabQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804640; c=relaxed/simple;
	bh=LSbCuEWjDyxHHbdfWPZfE+rO0gwrV/np3QjQSXS/U6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoHaKLclxMRxTvjQtyAEbDZjuc25sHXld8EA9YNtHFTj66TnoGNR6iG2+sfc94OpDXpsSX/WEG7eGGgykTy7jC6GPAAMJbqoozYHEZNVzYEsF1MJPYrVTv9hrUdtov4IVMoxIy35qbobGepIQQgkYDyyzpTW06EI7a7v/U/S7Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLEsjyh7; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLEsjyh7"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d256c2e6so2221989f8f.3
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 12:23:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769804637; cv=none;
        d=google.com; s=arc-20240605;
        b=PoV/fOvuB8Yozp8ItPYl9RH/fZnnmFnl5Ydoy3KcosSSO7ma8pFN1hkvx1SLpMZqHi
         PSNDkhjCfHBhppxIlJR57O4xC01VFFo9Mpknn/mvLL20uBVAO875+T91f2zkyvcBHv1w
         JZoc24IKrz5SxPLpx9eIXxMbY+mLgCCMGYjhm1m3hEkUzrirhfiOyhRx3dP4XlLQwGy4
         ssXj5LLjPvBQb+M02oLbB7Bwai6000c0BSPsEVVDjbLlyUM2d+NOEW+v1bh1UNtVsCx+
         uGg7l76/VJjU5urEBvpZmclgt3kFU16Q2eI3bVoR2cO7c44l4FJjk68PHVag74r80fnn
         aIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bBwlax1uJEe2vt97vaL600iF1Si6VhncixuT6qdHH8w=;
        fh=EsmXJcEL6WsMHdjvcObSm5HE156IJjTfIl7ps6QUCYk=;
        b=fbvZUjPL1mfe8d/KlshsSTjfX/kPgYvfZvfPVSsB87tLKvBihjwvroMAVk9dqeatTY
         OJYcVm+jNT2Y5Cq6ahLb/4a3a25uLbQ526Fy4jabpqCOqVP40q3YZ7vnjg1OXg/6UZde
         5svpUfAsw+FXQutDEtIsYbdZuG1uoASnGaieAkWo3nkysZl5KhexyHJ7dqAqOYKydSvt
         yoKkAk1+yjK8I7jyp5Xh6QabOLg/2egpxi1/vCGCO1zPO8RpNKD4vZtjgnQOeTTGeuoE
         o9L9GVu1KCB0exDdCMlwoFYU/Hv8zpQyBDj9VQB8iVOIVyUA9CmQBei00sJMZ2R/XzkX
         cVLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769804637; x=1770409437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBwlax1uJEe2vt97vaL600iF1Si6VhncixuT6qdHH8w=;
        b=PLEsjyh7YjlSS0F899rtagL2ikqRtbELz+YHhT0yeAVmVuV0p8O4qLA+X18scWUqZ2
         657TrGV9wNXSUcrtyY2PzFz3/w9wYboKvuOebx82PwNfVYbYh6zLkw2E56+JvfSeJiX/
         8f2N/nIRh1MNEmSEUwNvKqV7zxljhq8IQHOcH866kYaDyFjfWQHILs2ovQUZ6FNQQDjj
         PhbX/GufOmz/xK6eYwK5IIbPfWVvYGtUEblSRW/iVQjsGIWnVHzleTSJ56QlSuBxc+M5
         GbLMywtldptg1ZA4Kjxuy/FbLF4EhJcoFWs/TWEYlWYpaObgyqbLKvnRUgZLkYxlXelT
         5zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769804637; x=1770409437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBwlax1uJEe2vt97vaL600iF1Si6VhncixuT6qdHH8w=;
        b=c9zkE/fDDNI5o3szbuaqRsojUAFepOcVFc9Iz8Rs/xC3PdaOCewqN1wL1VgkwDWHcm
         z+yuyN120IhoFGBR57ExzKKx7TGmfRRuzlP8J98CmwKi3tb0jdfbnXN5yxp6YoJ6H4oq
         nl+iotBt5/zs3ZwB2SSexXjqprJgtoqmLFAWdZBXWgK19XDZ3uExJWTBABwQFobdmpqP
         sM27yt2reuixoGTsy45hPifNVABcISpGQMDTK7bKFIqhroMvyj8CnVxvzgtSD+a+fXaV
         Rzd0nI9Uq0dstD+xuyB5RzZZGxnltNuJCsIMzOaYnHd8iyORQNsNOefb6+TBrWypZmxH
         epGg==
X-Forwarded-Encrypted: i=1; AJvYcCVEEQph/GdjElhL/HPTqrykyr7rqXzdk+TlQdxvq1ORqEBBMa1nbb6yhxkzRUjpx4O1a7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNeI/GN15XIaLwz1+9ddu7H9S6mOT8NMQq7Zv9gXkg/dGkpNV
	/vdIfTmG/nOzDOwWsq28BRwMxp3bNTGNfAhzO7wgVpp/LpDEyPAWjND13D+TyPTg0d9+ISOcsVi
	c5ot/jDPbu7hZUJJ5Ygq1zgjnLUft1pk=
X-Gm-Gg: AZuq6aLJQ1W8w555CyuNCbXDMYXOQUT23At+x/UBgwl6F9gDZUBte6ryyBVCbxVTxm3
	V6QW+UL9JoctA6v9tlsjMG955VW2AJGayGiwLEIUgaQHJ5qfOHG3w3hUntA5oIg4Zq0C3pDoZei
	OuWvECtIBpemZAqq1M9+oZ4eNOx6ulAl4lxT40zkH1HcaVrUzx5iPPFMjwdh22yU4zYnUHVKclz
	WNr6YBYLTOPxnSXU1YlMF8J9ek24wj3yV3dJFnsZhPj4pSiQT1TPPwd3qx1e6IsMRbyPKxSS8x5
	NasPQLa6aIx6/cAHj89bUkiVRZOS0mx6AzMuHjwx/GQoq+ujzFg1taciIzeNwrcIV8Ue1JA2XAi
	EGFYw4XIIwBbwFw==
X-Received: by 2002:a5d:5f88:0:b0:42f:b9c6:c89a with SMTP id
 ffacd0b85a97d-435f3abc68cmr6202323f8f.49.1769804636726; Fri, 30 Jan 2026
 12:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130021843.154885-1-changwoo@igalia.com>
In-Reply-To: <20260130021843.154885-1-changwoo@igalia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 30 Jan 2026 12:23:44 -0800
X-Gm-Features: AZwV_QgVIyfECQMmhpFdjuibFf6ud4d60AK0JQfLZpsdvQJ-mBanXyhqw-cL-f4
Message-ID: <CAADnVQJKguqUD0bYh=tHnrGXOUOMrSk9_72HDFVcuMsv7=S_nQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Make x86 preempt_count access
 compatible across v6.14+
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

On Thu, Jan 29, 2026 at 6:19=E2=80=AFPM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> Recent x86 kernels export __preempt_count as a ksym, while some old kerne=
ls
> between v6.1 and v6.14 expose the preemption counter via
> pcpu_hot.preempt_count. The existing selftest helper unconditionally
> dereferenced __preempt_count, which breaks BPF program loading on such ol=
d
> kernels.
>
> Make the x86 preemption count lookup version-agnostic by:
> - Marking __preempt_count and pcpu_hot as weak ksyms.
> - Introducing a BTF-described pcpu_hot___local layout with
>   preserve_access_index.
> - Selecting the appropriate access path at runtime using ksym availabilit=
y
>   and bpf_ksym_exists() and bpf_core_field_exists().
>
> This allows a single BPF binary to run correctly across kernel versions
> (e.g., v6.18 vs. v6.13) without relying on compile-time version checks.
>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  .../testing/selftests/bpf/bpf_experimental.h  | 21 +++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index a39576c8ba04..acabf869d2c4 100644
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
> @@ -624,7 +630,18 @@ struct task_struct___preempt_rt {
>  static inline int get_preempt_count(void)
>  {
>  #if defined(bpf_target_x86)
> -       return *(int *) bpf_this_cpu_ptr(&__preempt_count);
> +       /* By default, read the per-CPU __preempt_count. */
> +       if (bpf_ksym_exists(&__preempt_count))
> +               return *(int *) bpf_this_cpu_ptr(&__preempt_count);
> +
> +       /* If __preempt_count does not exist, try to read preempt_count u=
nder

Please use proper kernel comment style in the future.
We don't use old networking style in bpf anymore.
I fixed it up while applying.

Also use [PATCH bpf-next] in the subject to help CI identify the tree.
