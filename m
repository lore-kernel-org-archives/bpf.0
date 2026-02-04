Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D03A900B
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236100; cv=pass; b=GXaho9XPELyMcqOw7pmmQ7g68ebVQ91jWXpIZT7XO+DUl4mgdyxbHevC7FDLRAUyaEXV8sq6RiQLvRvpd8hFmVU/3Ho2vwwW3yFL7YKnn5oh/NZIqLs+Zdpbah+sJgAYuE8+gt2qsfw2b2EkQP6c4h66QyZAGN07pH49ZlPCiNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236100; c=relaxed/simple;
	bh=3XOUAy3XIIn08AGjDN/QS6JH3XCKP3Voe4vAPQObQ5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsOZckkbSX1uucm4wL3y/OznqLHiGHNrgkwhcV3EuHn7nWLoV2CUOKJOFW26JZD/obGj6O5txFQ1rnb2G/VQvuGiXevC0ZPf6DDpuyaw76LrUpINEOk1NghIvoFk4fdHtlUQmkQ4Yf/w/n49RZ45g9oySNqhPbsdDcQIjubiASs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mqs+z+n5; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqs+z+n5"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4359228b7c6so154040f8f.2
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 12:14:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770236098; cv=none;
        d=google.com; s=arc-20240605;
        b=OAa66Em7jh29VduEUvLXW+2miuazhgmAf1RvQC5QtWguKjSPBXw2ti8GQMaI4rUM9N
         TExDXc/y9ssZAXP2/CQVPnAWXsWFwdAFxA2eSlkueF/pKqd/1mUbfa08VsvarDialX+Z
         /7mcAzF3Yr4dho/q0XeKuYRwQ/5KFgNHh341fUxKv7F6TvXkYaVmebMOeWC63K3XZkPp
         jziYOfJ4PF8ebck2/KSJre1c95AGHes1Qm8otstoWCvAFV8YHuaByjX34PrmZuwBnjxQ
         f7PHsRRwqYZuD/HUN6JkVoe7ilNxhgO9gz8G0UM1aPqGkKktO3rckxKzjKXRQELtlONd
         +j/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mkiN7mFgrITdHV9O50DWF0sIOrkOU+OBcsroscUTkI0=;
        fh=Qwi4bkM/TcZNakyBIOP2hHL6j49r9ebjziY5QnZErxA=;
        b=RHE6Bpl3mAAVNsNGDq8D9skLQUDB/U+ahd46EOPwhuchaJ72E/x3wgkmjQtHdiE72k
         kRVUe9EoPNPjQHwiO1hpHJBsXhAdtbGHLs7VROdDxYkKGMI7OYzrb1AQYrMAH+IgHq5C
         Wq9TrVj44EE5qVS8w8QYihBdK7Z0mlR4/3ZG0sE1nEP8TCAvgTvitO2IUtVgfg0yruNZ
         wOY/MSnC+QvsZdL558qVMfZR1Swn7kfIZvUxOjEsYB/QMQrM08X45Hvrji+SQBS1k8Gm
         H6tK8x5D/rP8H0Wz8HYt9vqlgz+aaywtjSTyTQxOHsU98WnSHwFfxzvt7BlAw+4AODPo
         xIhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770236098; x=1770840898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkiN7mFgrITdHV9O50DWF0sIOrkOU+OBcsroscUTkI0=;
        b=Mqs+z+n5WxBiO7kMqf1V6wR2WYuYti6pChwKSKEIYJB8cb6dSpRXg0lPgGsj6b519z
         27iO4sSJfZat4DWYDVRneTTbCo0w/ZkfQZ8jGZnrzpVwD4C2e1K2VSVM0fj92KbtdvLw
         YV71YM6cWLMyI5QUTSGtP5K+M1Atrz6TZlyBFmOsC2jB2+Da/c+Qgnj29PPytFUVJkih
         Wp4CXgnIH6hA6d3p8/i4VAP4nZKHblZ6rK4ScxSmfRrxm3OZdlHSEYEWpzXovSUNEeOx
         p40y8b5OBjAoC4EJPz3PrNImtf7NI8j87+KpeGYRsVmdIPGewi4BKtGk6A+f1ubqjXgb
         B2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770236098; x=1770840898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mkiN7mFgrITdHV9O50DWF0sIOrkOU+OBcsroscUTkI0=;
        b=m3VreYAss7Nev9qeHeceMcIwfZzEpiFwfAvQAADrGYuSXKzTuG+U4DvnFrRY/eFs8O
         bk5pzasrL5ueT8+C2qAWCjbq5nsL/hSKz69xEgopqp8Jqo/pzOp1xEr+1kTkanfFhb1J
         ietVEus6FibIgJH+hcjy/lt1S/xoz/5hk3ZIukhcMZNuBimZyHjc/UBlRoezju2K39NZ
         cieWmUjA2onNElEqH7WNWSDt83XsICaq2Yd/FnMUSX42KdWwpsP68j+bXr+wQ6ZrCvY+
         VxswFqoCzesmW4bUS8y8Ll/D9z8FIStf2v8sWM6eBlcdVfgokVnN0V5I3g5AGOsbicRB
         23qg==
X-Gm-Message-State: AOJu0YxrssRh5POPs0sxPqI03+piGYdoaWN/liHu0ggtcK7w4EChf1oG
	pNMr77KztE1OfUChOQkte9ZVu/8Evjk0SQHV781kZFbD2stfuP5V80jk4zhMhl4uC2I33/qlqcO
	3Lw26FwIcfKJ15WYp9r9vZu/2w81vlkA=
X-Gm-Gg: AZuq6aK8A9wNvcU1Ds6+Dl98Nd6BvuqfIBoo9QQl/gLhwz73aq97bHOrGhpGf350Xfy
	4PNiamyD3ynP9Qequi8tLYGKfQUWDMg7BDJN+Dv2vn+7C+aE/y8Dki74NWx8bN8McrrS3YgfAAx
	9l68DmDbeiau1UVmr95CK4p4sIcLiSvB0XQoMSk1NOT0EhBIhsi8enWMSrubsOTHrwSGQMPSMEn
	qyWvDEgFNM/Wcnm8Zset1FY0h+qRMGLkyS8tI9K7QC0CKRrxLKjp+R43sgWk3ZSOvpfgRbJkxyd
	bilRTMyFDzMQMUi6hlXoernPz6f1VFe3FjyDGBIlAvcPuktz0wc0k/E/1dh7MOu2bMKNl0azsIF
	EOMQPJlsQCpW9ug==
X-Received: by 2002:a5d:64c7:0:b0:431:488:b9bc with SMTP id
 ffacd0b85a97d-43617e351camr6268378f8f.10.1770236097724; Wed, 04 Feb 2026
 12:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-10-leon.hwang@linux.dev>
In-Reply-To: <20260202144046.30651-10-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Feb 2026 12:14:46 -0800
X-Gm-Features: AZwV_Qj_M0j2QuFHcqb1uasQT0CwO6eJFnjOQYZ1YB11d59OLhbMlJUDF0EXYlY
Message-ID: <CAADnVQLXWQ8Miq2WBoXRDsEVP1QPwk=a5=Rj_uPN+9qKHZZmZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 9/9] selftests/bpf: Add tests to verify map
 create failure log
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 6:43=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> +
> +#define BPF_LOG_FIXED  8
> +
> +static void test_map_create(enum bpf_map_type map_type, const char *map_=
name,
> +                           struct bpf_map_create_opts *opts, const char =
*exp_msg)
> +{
> +       const int key_size =3D 4, value_size =3D 4, max_entries =3D 1;
> +       char log_buf[128];
> +       int fd;
> +       LIBBPF_OPTS(bpf_log_opts, log_opts);
> +
> +       log_buf[0] =3D '\0';
> +       log_opts.log_buf =3D log_buf;
> +       log_opts.log_size =3D sizeof(log_buf);
> +       log_opts.log_level =3D BPF_LOG_FIXED;

Why? Which part of the test needs the log with this flag?
