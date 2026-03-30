Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195A22D1907
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862943; cv=none; b=b+9TOfF3hnsfyNvM1IqXpreN34nY24gAzduntk1m/PVVAFC0QtNpf/YKTfgX0UWiEGa9KpRZiMxRAJlIm8vy5RkZhmNtxD/x6cqc9Yf28knzKyRpG2PNF8MRMeHthWnFoUzVA53M4hOXc3YAV0Kk2003CftBrXSq0D+pA1hFTJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862943; c=relaxed/simple;
	bh=e+FUhHbA4Jajf2W1lfzpcGpsDudB361fBC00sF1fM98=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECbc54h2S2oTVkrlmv2NuSs67qzAY0DZ0q57GtKDur8Un9nk9zVrKwvjjjwppVvbBU9V4cUvUHKXcMH33U9V6GTsnhaJ5C/YEkD0VMYNo3f5KidNRc1wJuyp1dcX70X+n47CW71wa0oZW+YRFksqWTDBcvrCEMiSdPb8sYb1dPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO8HRJI0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO8HRJI0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486ff201041so41817755e9.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774862940; x=1775467740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQABhxo3yPzOnvpgbdKYStGL1AIsTI3bONLS/eN3r+k=;
        b=jO8HRJI0S05izMa8sJ2Rk6P08V/HCiBo4xBdt3UdoTWF/iDdVqVdUZ2u2SYqgkbvto
         64sMPOaYIA4EtyqesWCNClmV8UBp/pm60n60E5ttX28mrG1TWRKj2DTw33pfnWkmdsyx
         vFiAZO/dWtep8+tIcXe5yDMN5psiriwVLko5yqXGfM6RzmFVpTFnvJrL0Mjxf/wQqd4S
         3Dsmhc2YbEk4kFiwYx+BsWQ9GqiKBIj9dF2PbwnCa6vITzcSH2gdGmMjVka5Tr6ERXm5
         dcwytZSt6NzT5aB0b8RpVib+64jjmi2AtQb4qYsOl3CNLAVKXgXHtorGbDz/6lelPEKT
         fugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774862940; x=1775467740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQABhxo3yPzOnvpgbdKYStGL1AIsTI3bONLS/eN3r+k=;
        b=e+kTeWA32wKLPgFDymlureywHpqeU7yrGl9txKhbNTOvBAl5u8Xyr3rnrWmOcE7n7d
         +EbvgXS320wLf0e++kxERAnmwhEJXH13+nNUJxe0mgewXy/kEt2xbOHGqiAfQvTJA5/a
         nfuxxSirty6gmeOIQG3oJUJruPYZ4hvJlqR/3gkhcFQA+gSLmxDhw6WGssxdOa9ZJvvt
         nVEi4CmD0Wg1oAoOsgtNieotMjiXRzWEGipiaX72HM4zlsFqslSqcE754PVpIFHFpW3e
         m0aBM2yVOhUjfjSA/gLq55jZdGYuuZ66Eh21DI6+gvGWJBR8/SUfuuz5chv8U/epRkp6
         oPhA==
X-Gm-Message-State: AOJu0YyA/r+B6WyuJTl2jzZESGz5sSLUPdVNOCzMacm2hwzsvHdm7v1L
	NQih2GQKcG4fjYD9FD7D+LLtkwTGlJMLBKZPraYPTd38WauEZaH42sdG
X-Gm-Gg: ATEYQzxO7aNKE+7Wo8s5xXJ+3AVQHDogCV8D+NmoIj9ly5Nk2L7zuH2enTKdn0aQXni
	LP6ltIOhrA0edjKShnUS14xLV1qjaMj+0oP3AhMi111nLxTplQL5aN5taztIUsuwv8twK6DFPF1
	qqGBZ1mb+XW8wtII/lEcwR6d6ZPRltvIRcyoUHVrGEDdRqr9dRJRT4BjPAtOuBTEGiyei9ERujH
	3l2pT1hU0MgakURLESWLGpim/eyr0md5Rj3971RgX7RvvtI1C/KQQ6K3RejYF8tXPRVWPoQk2sI
	1eNNDbL/fbUteHzm0m7opY/ztnx4E1ExrIjbX6I69iYtHkrmxv7D4wYevh2TM1GFSyoSVXVyUgD
	zDOG+3rEf08GGHJUmApwVTBH+0pIgXUVDkfYyUec4/g8fKT1Gws2QyVPjViZFvmHlWODMFZi0jn
	z4WNl7WMV2Dxw2d7oupr7MNdBv0s//489o0gA=
X-Received: by 2002:a05:600c:4f53:b0:485:3692:e8f7 with SMTP id 5b1f17b1804b1-48727ede47amr193606995e9.25.1774862940141;
        Mon, 30 Mar 2026 02:29:00 -0700 (PDT)
Received: from krava (37-188-160-213.red.o2.cz. [37.188.160.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2463dc2sm17668983f8f.23.2026.03.30.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 02:28:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Mar 2026 11:28:57 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add test to verify the
 fix of kprobe_write_ctx abuse
Message-ID: <acpCWX6h-1IJtorN@krava>
References: <20260326141718.17731-1-leon.hwang@linux.dev>
 <20260326141718.17731-3-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326141718.17731-3-leon.hwang@linux.dev>

On Thu, Mar 26, 2026 at 10:17:18PM +0800, Leon Hwang wrote:

SNIP

> +	prog_fd = bpf_program__fd(skel_kprobe->progs.kprobe_write_ctx);
> +	bpf_program__set_attach_target(prog_ext, prog_fd, "kprobe_write_ctx");
> +
> +	err = kprobe_write_ctx__load(skel_ext);
> +	if (!ASSERT_OK(err, "kprobe_write_ctx__load ext"))
> +		goto out;
> +
> +	prog_fd = bpf_program__fd(prog_kprobe);
> +	link_ext = bpf_program__attach_freplace(prog_ext, prog_fd, "kprobe_dummy");
> +	ASSERT_ERR_PTR(link_ext, "bpf_program__attach_freplace link");
> +	ASSERT_EQ(errno, EINVAL, "bpf_program__attach_freplace errno");

nit, I prefer libbpf_get_error call instead, because it's not obvious
that ASSERT_ERR_PTR sets errno, smth like:

        if (!ASSERT_EQ(libbpf_get_error(link_ext), -EINVAL, ..

anyway lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> +
> +	link_kprobe = bpf_program__attach_kprobe_opts(prog_kprobe, "bpf_fentry_test1",
> +						      &kprobe_opts);
> +	if (!ASSERT_OK_PTR(link_kprobe, "bpf_program__attach_kprobe_opts"))
> +		goto out;
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(prog_fentry), &topts);
> +	ASSERT_OK(err, "bpf_prog_test_run_opts");
> +
> +out:
> +	bpf_link__destroy(link_ext);
> +	bpf_link__destroy(link_kprobe);
> +	kprobe_write_ctx__destroy(skel_ext);
> +	kprobe_write_ctx__destroy(skel_kprobe);
> +}
>  #else
>  static void test_attach_kprobe_write_ctx(void)
>  {
>  	test__skip();
>  }
> +
> +static void test_freplace_kprobe_write_ctx(void)
> +{
> +	test__skip();
> +}
>  #endif
>  
>  static void test_attach_probe_auto(struct test_attach_probe *skel)
> @@ -434,6 +496,8 @@ void test_attach_probe(void)
>  		test_attach_kprobe_long_event_name();
>  	if (test__start_subtest("kprobe-write-ctx"))
>  		test_attach_kprobe_write_ctx();
> +	if (test__start_subtest("freplace-kprobe-write-ctx"))
> +		test_freplace_kprobe_write_ctx();
>  
>  cleanup:
>  	test_attach_probe__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
> index f77aef0474d3..adbf52afe490 100644
> --- a/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
> +++ b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
> @@ -19,4 +19,23 @@ int kprobe_multi_write_ctx(struct pt_regs *ctx)
>  	ctx->ax = 0;
>  	return 0;
>  }
> +
> +SEC("?kprobe")
> +int kprobe_dummy(struct pt_regs *regs)
> +{
> +	return 0;
> +}
> +
> +SEC("?freplace")
> +int freplace_kprobe(struct pt_regs *regs)
> +{
> +	regs->di = 0;
> +	return 0;
> +}
> +
> +SEC("?fentry/bpf_fentry_test1")
> +int BPF_PROG(fentry)
> +{
> +	return 0;
> +}
>  #endif
> -- 
> 2.53.0
> 
