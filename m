Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83C368D4D;
	Thu, 23 Jul 2026 04:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784779701; cv=none; b=huG+cVePy2L7OU4TDAxWglyhVc1Se/bKaJMs5ie8ljPZ+C4JQcwYdlh0d6fiLe5rWoo59PFg6OHMYOWrnRhw1vGC4K5MREu9z+ovvTDsIRt/YXh0W8sKsmbRTnR6JWMtw0mY+h3EWAaMr3Kj36LVlpuE0GanjN2AHnFzIh4re+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784779701; c=relaxed/simple;
	bh=EvmoLr2zZKIEp+gy16ySCySwS922FaTI8KUCTeEtFng=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hsEIHFppkXJdLQ7iO5Rnz7XPPc8e8ARJvjyQZKT4Gl1IxnJgKl65fO+im3B99oAslk1/k8X+fbW2BiB9IqxsIRXs+aFXjh2AYhNuxBx79PaOPL1WWtY2T7JnbSJorcDj5I5Gcr9POM0MYuzel1N28eVC3y9c7jzbeCB+GaQo6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1jB1fvbV; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1jB1fvbV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PkwAcbk3wA3nlynzUfzUlT3EsBLKum122AVkyFY+wTU=;
	b=1jB1fvbVKfiPZCGPse198VNqsruTQoEDHRVe1RS4Jmu1lfEWFY93eyTMzdBZJMWF9AD6PowXb
	V1Gaa/XaRy7QmQ+oQjxTkOQWY68xa6yFzoU+Z8qLxyuotPckQMdircvSk4EWEL/otx23HxB40Ra
	KdVdqqklmDA3XgiQi/D8NwU=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h5HRj2qZtzpStj;
	Thu, 23 Jul 2026 11:58:57 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id B24FF2025F;
	Thu, 23 Jul 2026 12:08:03 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 23 Jul
 2026 12:08:02 +0800
Message-ID: <0fb1f779-bbd2-4b7f-a9dd-1e56fa487b50@huawei.com>
Date: Thu, 23 Jul 2026 12:08:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Verify no warning when
 close fexit link
Content-Language: en-US
To: Leon Hwang <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
	<emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, Jingguo Tan
	<tanjingguo@huawei.com>, Lin Ma <malin89@huawei.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kernel-patches-bot@fb.com>
References: <20260722151909.69142-1-leon.hwang@linux.dev>
 <20260722151909.69142-3-leon.hwang@linux.dev>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260722151909.69142-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/22 23:19, Leon Hwang wrote:
> Add a test to verify that there's no WARNING when detaching fexit link by
> following the repro steps of previous commit.
> 
> Without the fix, the WARNING could be triggered by this test.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>   .../selftests/bpf/prog_tests/tailcalls.c      | 48 +++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index c66037162da5..c5c9d6c359bb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -13,6 +13,8 @@
>   #include "tailcall_cgrp_storage.skel.h"
>   #include "tailcall_sleepable.skel.h"
>   #include "tailcall_callback.skel.h"
> +#include "tailcall_bpf2bpf2.skel.h"
> +#include "tailcall_bpf2bpf_fexit.skel.h"
>   
>   /* test_tailcall_1 checks basic functionality by patching multiple locations
>    * in a single program for a single tail call slot with nop->jmp, jmp->nop
> @@ -1907,6 +1909,50 @@ static void test_tailcall_callback(void)
>   	RUN_TESTS(tailcall_callback);
>   }
>   
> +static void test_tailcall_bpf2bpf_fexit_links(void)
> +{
> +	struct tailcall_bpf2bpf_fexit *skel1 = NULL, *skel2 = NULL;
> +	struct tailcall_bpf2bpf2 *skel_tc;
> +	int err, prog_fd;
> +
> +	skel_tc = tailcall_bpf2bpf2__open_and_load();
> +	if (!ASSERT_OK_PTR(skel_tc, "tailcall_bpf2bpf2__open_and_load"))
> +		return;
> +
> +	skel1 = tailcall_bpf2bpf_fexit__open();
> +	if (!ASSERT_OK_PTR(skel1, "tailcall_bpf2bpf_fexit__open"))
> +		goto out;
> +
> +	prog_fd = bpf_program__fd(skel_tc->progs.classifier_0);
> +	err = bpf_program__set_attach_target(skel1->progs.fexit, prog_fd, "subprog_tail");
> +	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
> +		goto out;
> +
> +	err = tailcall_bpf2bpf_fexit__load(skel1);
> +	if (!ASSERT_OK(err, "tailcall_bpf2bpf_fexit__load"))
> +		goto out;
> +
> +	skel1->links.fexit = bpf_program__attach_trace(skel1->progs.fexit);
> +	if (!ASSERT_OK_PTR(skel1->links.fexit, "bpf_program__attach_trace"))
> +		goto out;
> +
> +	skel2 = tailcall_bpf2bpf_fexit__open();
> +	if (!ASSERT_OK_PTR(skel2, "tailcall_bpf2bpf_fexit__open"))
> +		goto out;
> +
> +	err = bpf_program__set_attach_target(skel2->progs.fexit, prog_fd, "subprog_tail");
> +	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
> +		goto out;
> +
> +	err = tailcall_bpf2bpf_fexit__load(skel2);
> +	ASSERT_OK(err, "tailcall_bpf2bpf_fexit__load");
> +
> +out:
> +	tailcall_bpf2bpf_fexit__destroy(skel1);
> +	tailcall_bpf2bpf_fexit__destroy(skel2);
> +	tailcall_bpf2bpf2__destroy(skel_tc);
> +}
> +
>   void test_tailcalls(void)
>   {
>   	if (test__start_subtest("tailcall_1"))
> @@ -1974,4 +2020,6 @@ void test_tailcalls(void)
>   	if (test__start_subtest("tailcall_cgrp_storage_no_storage_bridge"))
>   		test_tailcall_cgrp_storage_no_storage_bridge();
>   	test_tailcall_callback();
> +	if (test__start_subtest("tailcall_bpf2bpf_fexit_links"))
> +		test_tailcall_bpf2bpf_fexit_links();
>   }

Reviewed-by: Pu Lehui <pulehui@huawei.com>
