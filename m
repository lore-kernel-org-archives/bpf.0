Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2C1386C9
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773879315; cv=pass; b=JyhvJs33hvuCEkKI5DulJUqP5rxVJW3FntNlLNaHdaB02Bh6MHZHxt3bBToQ3X4Yw54dvGj7oLVAsuZDsZtzkQ7mpp/+t/eTo6bxNJ6vI2LEjrMzQVFyVkBY5P0dPOFUdIb/czIMO+za3NDZlX8UzkY1kwwkOZ250E4L3opYWr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773879315; c=relaxed/simple;
	bh=epYQYqmeoxnhnwHsy24c76hvYzkY8TlUlbKYfVRPK/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WshiQpsI35y71aDhfgq9KsIFZ1tGTEBzeJcGhpae9ENMkOaC61tyMapK45HeWidqod6NWX/CBvwMuF2OlqOtr454ZoehZGZIdtU2C7ulEDGs2zhWy82TQUxdohBTr7H1hH5JUj+CPxPksV1u3TKy+SYrejA0ZFmEOL25BZ7ag1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGAO19Lm; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGAO19Lm"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fb439299so431945e9.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773879311; cv=none;
        d=google.com; s=arc-20240605;
        b=aHp86jyXh623DLhI4yqvN8l6R2DstDapvmTOyQl/gxr398/twuecWKYj/TX2oV0O2K
         4MG9r/hdF3pA8AHeMrhoQ+uK+stQUzIZCPus0V/wlZM6LI8IieszIGoUXzA1VaPH2zJQ
         0kYeQmgtihvg+5UXgKldu7hf6wxyl/OUtehI4Any2OpaZB5OTjCizfHbBY9lrDAIaOkY
         K90QSEIoGOs1ch3MuQBCGNWo34222w8i9fy2LJktrEKtaT++zMXmbq4xjKrMJipAaeLV
         ozmw0SFFhgwcg4SWB52W2fPpzjVca+05YmZMjH7wiYMMaQHEMfVlvTmeRh5/Q6cfGTXE
         LZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fNm3pnF8KBRqftmVyJUTYbKuGaX4295I9FrzXBtq16o=;
        fh=639JwA1h6t73wmE5mooeN6NShKnvGE/JOC78cfYJDgE=;
        b=bPhSOYIMUCeoLDB5als0EH/Ms+p7aQmUQiqwe5zaoXExx5IXuDYnSpwUsE5tztWXFZ
         aps0Q1zgiGl8cfeMGXC7hdd5PSreFBR4OgPwVpSrdSpsqKYEkhdP4x1V4u69D69PFHRu
         Qdl3DcnzT9vjpUeWdzIKCofhiB/HE8CSgO89cX6bun9yL1ThRJGA5I51Fm+7xqpaMVT/
         Z3TIyKJr13quUv7yNo8W0jwNUSSU2v4UM2PWGWrb2bdL1IN97XZlCdv4hSTXHeydacBl
         KwKKW5nn52KyB06Or/naRWtPiIf5VUyyAWIKQJZiapsTFzw4uEVmzRgOgnGIo0XxMWyF
         w9Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773879311; x=1774484111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNm3pnF8KBRqftmVyJUTYbKuGaX4295I9FrzXBtq16o=;
        b=AGAO19LmCF/7aGXPG4tQesf0ArmFcLADinZIqretbvI5erEL2FHVwCTfZq2qQRLx41
         xOXR7iRf73ojAn6g+XcXL53uTFTc8VVsw3DBkgyMt2JyHvOwRQ6jxTFW+dsdbFJL0zK8
         K/PM0kYIUP8BoKCaZ8nT15GLl+QJnLGkUpdndW9tIQS4RjPca+99UKU1yzOZL9kWA0QR
         Hh0jIRQUfthxOxVzySkc5NaMvnSuzcx5JUkpeFxD44yGIT+iKEAo4PbKqeG1f22IcuQz
         T1BiZ2cf01QNz7q5Tu7IRBRgXvLcyFYlnXJhqyd2bU+c+6Xgm58lmP+NNWZfG1Ru40QN
         y7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773879311; x=1774484111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fNm3pnF8KBRqftmVyJUTYbKuGaX4295I9FrzXBtq16o=;
        b=TXNL/+Q3crPV6ddCkXpQXUR8xDWz6qpbiZiFmp5uTpwq7E1cpfN5CDzNcaM1Q9lTWK
         Au85ZMNT6tp3uLqvMcvv//6Xa9j9mem7MPdkULBehLJzQrUHKFmC5r5tCmSs7wN5TYDI
         KGNi62sKhfWjPNVWWvO6RMZu9ddrIki0z9+u7jjkjR0C0lbaSHse19Nn0qXb1sOoA7u5
         jU8Ry4RE4Gnhk59ERAMpHCOCNgIRw7DAYqvbPLeCDI4hOYn1drnTbL8r5tqXXZx/CAht
         KVltpJPSVc+/5LsakhsHUu3Ijz4gTYkSq6DS/HN5W3cjsYEAIkcWR7df0HS1e6iXUfy1
         53bg==
X-Forwarded-Encrypted: i=1; AJvYcCUWba03jyzto0HUkp+lWBX+1m8H12eEXLwORbwQA7ZbfAStmXwx3oSzhODnr2vcbiHk0+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vpQIHZ8AVFdRTAWXqzsGdiI+qK5mJIx+3cSl/bxuNdjGc1Oe
	Ze/UHKVYC9+0j4/cGoV8GhFSwEhQM3KZ9ynTuU7XtxuLDsPbyWJCvyXo3VxzTxY5UluQ8rMCqhc
	wXmM04sKDaHdxYnYuy3HvS7lJErJ++K4=
X-Gm-Gg: ATEYQzycIqqAgcAe2LWghSdaIOeP94UCPr3SIIDrR5kpVOiTbm7h+KFj7a3AN2zVs3g
	dhbbhy0WcdxMHQi/b6AerX6nW8q6T7d54s0vOArTqNivA5Xkbg0N9hfJ7g78sMvYO2qnq5RWl8D
	eCYvLTHlDX5baNq2Ufgu+FZo5s9Jpbz4exv2mgf/eodrqM3ynX9d0diAdoAyWLJ9TtRxq3s6hxs
	iR0CBtug0o15CHyOq5H456r8wiq8GQZdxOs/mr1wxT4nCY5Ig/SINWTB0hYT+ETRke9GFxiJRk3
	0y4pNAgKxG8t0NStfYPrqgnccmzK9JmjIbnKeh7emyGpffuY3tBXbUhIAmIJSPqyhe+f/VuLBBD
	+WwCye3zoZ4dKmcVGMGJBxlpT1bNysFUABXTA
X-Received: by 2002:a05:6000:40dd:b0:439:c510:f97a with SMTP id
 ffacd0b85a97d-43b527cc57fmr9256013f8f.48.1773879311405; Wed, 18 Mar 2026
 17:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315054227.118344-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260315054227.118344-1-sun.jian.kdev@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Mar 2026 17:14:59 -0700
X-Gm-Features: AaiRm53LivEh_n___lgFy1oE-qeJGpxxOazJpETBsIzh61TvvbR0AF2zOXtjtSs
Message-ID: <CAADnVQ+j3BWFoTaQHDXxkp3ORTc0biQLf06uOYEX7tyhpc+tbA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: trampoline_count: use dedicated target function
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 10:42=E2=80=AFPM Sun Jian <sun.jian.kdev@gmail.com>=
 wrote:
>
> trampoline_count fills all trampoline attachment slots for a single
> target function and verifies that one extra attach fails with -E2BIG.
>
> It currently targets bpf_modify_return_test, which is also used by
> modify_return and get_func_ip_test. When those tests run in parallel,
> they can contend for the same per-function trampoline quota and
> cause unexpected attach failures. This issue is currently masked by
> harness serialization.
>
> Add a dedicated bpf_trampoline_count_test target and switch
> trampoline_count to use it. This keeps the test semantics unchanged
> while isolating it from other modify_return-based selftests, so it no
> longer needs to run in serial mode. Remove the TODO comment as
> well.
>
> Tested:
>   ./test_progs -t trampoline_count -vv
>   ./test_progs -t modify_return -vv
>   ./test_progs -t get_func_ip_test -vv
>   ./test_progs -j$(nproc) -t trampoline_count -vv
>   ./test_progs -j$(nproc) -t
>     trampoline_count,modify_return,get_func_ip_test -vv
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  net/bpf/test_run.c                                        | 7 +++++++
>  tools/testing/selftests/bpf/prog_tests/trampoline_count.c | 3 +--
>  tools/testing/selftests/bpf/progs/test_trampoline_count.c | 6 +++---
>  3 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 178c4738e63b..b41147a29f16 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -580,6 +580,12 @@ __bpf_kfunc int bpf_modify_return_test2(int a, int *=
b, short c, int d,
>         return a + *b + c + d + (long)e + f + g;
>  }
>
> +__bpf_kfunc int bpf_trampoline_count_test(int a, int *b)
> +{
> +       *b +=3D 1;
> +       return a + *b;
> +}

No. We're not adding test code to the kernel anymore.
That's what test_kmod is for.

pw-bot: cr
