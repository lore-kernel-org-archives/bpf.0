Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D23E314D
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038709; cv=none; b=r872xC/giT73vcai9SPCv1l9gQRShV6OixhSLXoSt2zCQOITPAmtdHh0U4cxZdvpg2oUqqhylueSjaSvIQSVIvj/HAsikE352bcVNmvYIW0Wa5OqrhASlvGbFVuGkqI+CJqYbscAF5TMmREQeCGCvGMUNk4xYrbvojjVwSk+G8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038709; c=relaxed/simple;
	bh=Z/RHnPF7DEhm5hJg9nz9CxlPsF/x9Zd1aLxhKGn6DoM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzG5VTDWwm4BRKRcPktd5uETvh7tcePosf72dlj+GQ+SZ/rqsol5MzcMkf0zyNhf7sz3mINfgq68G0PK7QPTToPv0H2acY18DYyg+M0UswElTB8L4DuwdbRkoi2AzPtT9Lhq+KrziTAAMri0u6h646wjcqSO+1IjgfJeV0CuWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPMOpcqb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPMOpcqb"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fb14227cso88768275e9.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775038699; x=1775643499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=claFTSt439IgZWBE01BixnVIaXDxsHvpAK6NnSOUn5c=;
        b=HPMOpcqbM7joWHV8JoAZ6d2AyE7eb4zIKHxkjUV3KqItWGAVKQSqBjpSybxJ0qS0Go
         ZRIzeFcDnoDbtHtFKQdMuPm53OTBwazhwrCPkuHnYc7G3wZAYppuFXdijroPOMRuH8BI
         caF7zlVupIj7Ce/fSdBb2ifEt8vHBS5iwTqptcvFuY8ywvb5L+uQMAzSRzGr56S+tJl7
         ffm9DBr5qxPX5eGi9J9GUp+po6GndFdloj1SZM110UUoNNL13wolPzAnpemIP2D62D0W
         jn/Q7Uj2vFnVa/doVJJZsQLRtd9HgS+1UCzkg4CKtswztZNfdupzKFCnnodL28/C5i8H
         CVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775038699; x=1775643499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=claFTSt439IgZWBE01BixnVIaXDxsHvpAK6NnSOUn5c=;
        b=cXX0fL4iSgAPFYT3YGjTA6GdR5v3W0vqaxTDA1wdGrcUb8OPOeyIWF0JDJ6jFZLiGu
         T/XsE63XzqWIm84xyDLgx/lYbMB7ROYgQ70Gg9FeM+wN578cV+beos58PyXeNPBFStIE
         q+u4HMYzm8GIqsHa6/uuuW/1UKTTGGoA20hVp/4S2J4VluKAsgR9aELiD1CDYuYo/1do
         QSF8g5vVMovNk1f1yLhxMz1Dlfn521tDU+zk0OktVr8nMDP+LJBYeKPKoxdKgtW3ZoUs
         DhvZtBt5iY5vjzE65JatJgSAqqP1vAZu5VKTHwnqaAJ95W8WcgZWeRWu0NOe0WOSYjbP
         UfQQ==
X-Gm-Message-State: AOJu0YzJYJmcEIuRWxmkUyQymD5FDfRFu3jJKix0qklV/mtwVEjO3jyk
	jSVfM9KxciA54wJ3hdzQdGOOHLOBDcqzolBGcnUV+9TJpTEFzjiMukF9
X-Gm-Gg: ATEYQzxRI5VOWZLrACvIb243kNT7bwWA0rsK50a+rkj7lSxaKSTa4xE6zYUEG59c/a4
	fqL+sjUV8TBz+cPZyrdDwjoYbfb8sguWkUruLpwMIM3drFLAHMRJcJgF1QZBMVZe4hv/K5kBMuB
	Ij0+dFdzKc8IbjHAtGutGj5jE/Ctm3NU/Bv0rjrijRz5Qbvk4Qp6kccdnPqX+y7m8pKbkYCtgtw
	9EAgyKlblhosqxMd7RcG0x3m0E3NEYNjL+9X64nSa70xdcEyDvKklZqFvsyonakUvsGXwqSMxvS
	6DT8IUrTf8LpG1vQ/3c2/WW0PhLkkBXcwgErggFk0j+SrNuO6JRU7XtjT2pPVj9Q9VafsyTJALK
	Ghrm7mSBLCUFXhDs6tZrji+x9ETADiK+ak4wD/GSAOSFlmy/2inZE9MXLIw27W0XK4IrsU/Xt
X-Received: by 2002:a05:600c:1388:b0:485:379b:57bb with SMTP id 5b1f17b1804b1-48883569e7fmr49979365e9.3.1775038699297;
        Wed, 01 Apr 2026 03:18:19 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887adc52b2sm40302145e9.12.2026.04.01.03.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 03:18:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Apr 2026 12:18:16 +0200
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 3/3] selftests/bpf: add test for raw-address
 single kprobe attach
Message-ID: <aczw6Mz5twb04Pcv@krava>
References: <20260401070738.122709-1-hoyeon.lee@suse.com>
 <20260401070738.122709-4-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401070738.122709-4-hoyeon.lee@suse.com>

On Wed, Apr 01, 2026 at 04:05:04PM +0900, Hoyeon Lee wrote:
> Currently, attach_probe covers manual single-kprobe attaches by
> func_name, but not the raw-address form that the PMU-based
> single-kprobe path can accept.
> 
> This commit adds PERF and LINK raw-address coverage. It resolves
> SYS_NANOSLEEP_KPROBE_NAME through kallsyms, passes the absolute address
> in bpf_kprobe_opts.offset with func_name = NULL, and verifies that
> kprobe and kretprobe are still triggered. It also verifies that LEGACY
> rejects the same form.

left 2 nits below

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---
>  .../selftests/bpf/prog_tests/attach_probe.c   | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index 9e77e5da7097..a41542f4b35d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -123,6 +123,82 @@ static void test_attach_probe_manual(enum probe_attach_mode attach_mode)
>  	test_attach_probe_manual__destroy(skel);
>  }
>  
> +/* manual attach address-based kprobe/kretprobe testings */
> +static void test_attach_kprobe_by_addr(enum probe_attach_mode attach_mode)
> +{
> +	LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> +	struct test_attach_probe_manual *skel;
> +	unsigned long func_addr;
> +
> +	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
> +		return;
> +
> +	func_addr = ksym_get_addr(SYS_NANOSLEEP_KPROBE_NAME);
> +	if (!ASSERT_NEQ(func_addr, 0UL, "func_addr"))
> +		return;
> +
> +	skel = test_attach_probe_manual__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
> +		return;
> +
> +	kprobe_opts.attach_mode = attach_mode;
> +	kprobe_opts.retprobe = false;
> +	kprobe_opts.offset = func_addr;
> +	skel->links.handle_kprobe =
> +		bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
> +						NULL, &kprobe_opts);
> +	if (!ASSERT_OK_PTR(skel->links.handle_kprobe, "attach_kprobe_by_addr"))
> +		goto cleanup;
> +
> +	kprobe_opts.retprobe = true;
> +	skel->links.handle_kretprobe =
> +		bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
> +						NULL, &kprobe_opts);
> +	if (!ASSERT_OK_PTR(skel->links.handle_kretprobe,
> +			   "attach_kretprobe_by_addr"))

nit, no need to split the line

> +		goto cleanup;
> +
> +	/* trigger & validate kprobe && kretprobe */
> +	usleep(1);
> +
> +	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
> +	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
> +
> +cleanup:
> +	test_attach_probe_manual__destroy(skel);
> +}
> +
> +/* reject legacy address-based kprobe attach */
> +static void test_attach_kprobe_legacy_by_addr_reject(void)
> +{
> +	LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> +	struct test_attach_probe_manual *skel;
> +	unsigned long func_addr;
> +
> +	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
> +		return;
> +
> +	func_addr = ksym_get_addr(SYS_NANOSLEEP_KPROBE_NAME);
> +	if (!ASSERT_NEQ(func_addr, 0UL, "func_addr"))
> +		return;
> +
> +	skel = test_attach_probe_manual__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
> +		return;
> +
> +	kprobe_opts.attach_mode = PROBE_ATTACH_MODE_LEGACY;
> +	kprobe_opts.offset = func_addr;
> +	skel->links.handle_kprobe =
> +		bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
> +						NULL, &kprobe_opts);
> +	if (ASSERT_ERR_PTR(skel->links.handle_kprobe,
> +			   "attach_kprobe_legacy_by_addr"))
> +		ASSERT_EQ(libbpf_get_error(skel->links.handle_kprobe),
> +			  -EOPNOTSUPP, "attach_kprobe_legacy_by_addr_err");

nit, maybe we could do just:

       ASSERT_ERR_PTR(skel->links.handle_kprobe, "attach_kprobe_legacy_by_addr");
       ASSERT_EQ(libbpf_get_error(skel->links.handle_kprobe),
                 -EOPNOTSUPP, "attach_kprobe_legacy_by_addr_err");

> +
> +	test_attach_probe_manual__destroy(skel);
> +}
> +
>  /* attach uprobe/uretprobe long event name testings */
>  static void test_attach_uprobe_long_event_name(void)
>  {
> @@ -416,6 +492,12 @@ void test_attach_probe(void)
>  		test_attach_probe_manual(PROBE_ATTACH_MODE_PERF);
>  	if (test__start_subtest("manual-link"))
>  		test_attach_probe_manual(PROBE_ATTACH_MODE_LINK);
> +	if (test__start_subtest("kprobe-perf-by-addr"))
> +		test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_PERF);
> +	if (test__start_subtest("kprobe-link-by-addr"))
> +		test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_LINK);
> +	if (test__start_subtest("kprobe-legacy-by-addr-reject"))
> +		test_attach_kprobe_legacy_by_addr_reject();
>  
>  	if (test__start_subtest("auto"))
>  		test_attach_probe_auto(skel);
> -- 
> 2.52.0
> 
