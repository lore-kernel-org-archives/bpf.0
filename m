Received: from mta0.migadu.com (out-53.mta0.migadu.com [91.218.175.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDAD3932E4
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187870; cv=none; b=qZ/770PIcAuWgaGAfzIMUe/hI3No16FBSMicMJbGJOwAl/LJkFiBHB5s763kfvTmoZfrdgwWoBweYoH88XfkMreI9Ur7dSKYl2cojtdwHYWxfcao2LZ79UBeBIDgICmS3yEDhsNcc7oMUOnTGi5OMv4mxWzc6ka0c4w+/nXLXkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187870; c=relaxed/simple;
	bh=MP66j0Lj+vPv+9cNySgh/2g4Hk6Zg/qh+664HpT8ajw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KHsK2wRJmXVI/cy4SOW7UDudi4phxGJ4yoeSD366R3bKhd224Hs+7IUf7jLv7/D/8DGKFCis8Q23fHQSx3X/q0BODL0vyY+bbP6tlirdnSQXpKuBd2bRdu5IHNNrqUXJwqoL10uiJ+L7IEe0AAM6AnsGXHH3fHU4/dW9HtKg+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BTr1ZMg+; arc=none smtp.client-ip=91.218.175.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BTr1ZMg+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MP66j0Lj+vPv+9cNySgh/2g4Hk6Zg/qh+664HpT8ajw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788187866; v=1; x=1788792666;
 b=BTr1ZMg+O9IVbjHMeR45LNWyEI+I7K2Q3yF5rNuhxkcF4FT+BpviIsVnYf1nE6qR83stN8qY
 XbFvrAiIT0bPP6uCuMahJTZetFMfAZi4UiGu38fOB44e9h1r6m2la3ubqofXWnjtkZ3IPgypEcS
 upl/4CDQAdrDxDfvze2RZ/7U=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id beb5f4ff7dae3ab5;
	Mon, 31 Aug 2026 14:50:56 +0000
X-Mizu-Trace-ID: beb5f4ff7dae3ab5
X-Migadu-Flow: FLOW_OUT
Message-ID: <425e1052-5c0b-4c0b-8f99-03d90c096ba5@linux.dev>
Date: Mon, 31 Aug 2026 22:50:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Cover attach type checks
 in link update
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Pu Lehui <pulehui@huawei.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260831023918.1857658-1-sanghyun.park.cnu@gmail.com>
 <20260831023918.1857658-2-sanghyun.park.cnu@gmail.com>
Content-Language: en-US
In-Reply-To: <20260831023918.1857658-2-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/8/31 10:39, Sanghyun Park wrote:
> Add regression coverage for link update compatibility. Verify that a UDP6
> sock_addr program cannot replace a UDP4 program and that an LSM_MAC
> program cannot replace an LSM_CGROUP program.
> 
> Also verify that CGROUP_SKB attachment still requires CAP_NET_ADMIN, while
> an existing link can be updated after dropping CAP_NET_ADMIN and
> CAP_SYS_ADMIN.
> 
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/cgroup_link.c    | 51 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/lsm_cgroup.c     | 10 ++++
>  .../testing/selftests/bpf/progs/lsm_cgroup.c  |  6 +++
>  .../selftests/bpf/progs/test_cgroup_link.c    | 14 ++++-
>  4 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_link.c b/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
> index 15093a69510e..b3219314596e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  #include <test_progs.h>
> +#include "cap_helpers.h"
>  #include "cgroup_helpers.h"
>  #include "testing_helpers.h"
>  #include "test_cgroup_link.skel.h"
> @@ -24,6 +25,55 @@ int ping_and_check(int exp_calls, int exp_alt_calls)
>  	return 0;
>  }
>  
> +static void test_cgroup_link_update(int cg_fd)
> +{
> +	const __u64 caps = (1ULL << CAP_NET_ADMIN) | (1ULL << CAP_SYS_ADMIN);
> +	struct bpf_link *link = NULL;
> +	__u64 saved_caps = 0;
> +	int err;
> +
> +	link = bpf_program__attach_cgroup(skel->progs.sendmsg4, cg_fd);
> +	if (!ASSERT_OK_PTR(link, "attach_sendmsg4"))
> +		goto cleanup;
> +
> +	err = bpf_link__update_program(link, skel->progs.sendmsg6);
> +	ASSERT_EQ(err, -EINVAL, "reject_sendmsg6_update");
> +	bpf_link__destroy(link);
> +	link = NULL;
> +
> +	err = cap_disable_effective(caps, &saved_caps);
> +	if (!ASSERT_OK(err, "drop_caps_for_attach"))
> +		goto cleanup;
> +
> +	link = bpf_program__attach_cgroup(skel->progs.egress, cg_fd);
> +	if (!ASSERT_ERR_PTR(link, "attach_without_net_admin"))
> +		goto cleanup;
> +	err = libbpf_get_error(link);
> +	link = NULL;
> +	if (!ASSERT_EQ(err, -EPERM, "attach_err"))
> +		goto cleanup;
> +
> +	err = cap_enable_effective(saved_caps & caps, NULL);
> +	if (!ASSERT_OK(err, "restore_caps_for_attach"))
> +		goto cleanup;
> +
> +	link = bpf_program__attach_cgroup(skel->progs.egress, cg_fd);
> +	if (!ASSERT_OK_PTR(link, "attach_egress"))
> +		goto cleanup;
> +
> +	err = cap_disable_effective(caps, &saved_caps);
> +	if (!ASSERT_OK(err, "drop_caps"))
> +		goto cleanup;
> +
> +	err = bpf_link__update_program(link, skel->progs.egress_alt);
> +	ASSERT_OK(err, "update_without_net_admin");
> +
> +cleanup:
> +	err = cap_enable_effective(saved_caps & caps, NULL);
> +	ASSERT_OK(err, "restore_caps");
> +	bpf_link__destroy(link);
> +}
> +
>  void serial_test_cgroup_link(void)
>  {
>  	struct {
> @@ -61,6 +111,7 @@ void serial_test_cgroup_link(void)
>  	err = join_cgroup(cgs[last_cg].path);
>  	if (CHECK(err, "cg_join", "fail: %d\n", err))
>  		goto cleanup;
> +	test_cgroup_link_update(cgs[last_cg].fd);

imo, it is not a good idea to embed test_cgroup_link_update() here.

Better to add it as a subtest with its own env setup/cleanup:

static void test_cgroup_link_attach(void)
{
	/* previous serial_test_cgroup_link() function body */
}

static void test_cgroup_link_update(void)
{
	/* setup its own skel and cg env */

	/* test link_update */

	/* cleanup the skel and cg env */
}

void serial_test_cgroup_link(void)
{
	if (test__start_subtest("attach"))
		test_cgroup_link_attach();
	if (test__start_subtest("update"))
		test_cgroup_link_update();
}

>  
>  	for (i = 0; i < cg_nr; i++) {
>  		links[i] = bpf_program__attach_cgroup(skel->progs.egress,
> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> index 41e867467f6c..85b0af4f486a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> @@ -74,6 +74,7 @@ static void test_lsm_cgroup_functional(void)
>  	int bind_prog_fd = -1;
>  	int bind_link_fd = -1;
>  	int clone_prog_fd = -1;
> +	int mac_prog_fd;
>  	int err, fd, prio;
>  	socklen_t socklen;
>  
> @@ -156,6 +157,15 @@ static void test_lsm_cgroup_functional(void)
>  	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_socket_bind"), 1, "prog count");
>  	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 4, "total prog count");
>  
> +	fd = bpf_link_create(bpf_program__fd(skel->progs.socket_first),
> +			     cgroup_fd, BPF_LSM_CGROUP, NULL);
> +	if (!ASSERT_GE(fd, 0, "link create socket_first"))
> +		goto detach_cgroup;
> +	mac_prog_fd = bpf_program__fd(skel->progs.socket_create_lsm);
> +	err = bpf_link_update(fd, mac_prog_fd, NULL);

Rewrite to bpf_link_update(fd,
bpf_program__fd(skel->progs.socket_create_lsm), NULL).

Then, the 'mac_prog_fd' can be dropped.

Thanks,
Leon

> +	ASSERT_EQ(err, -EINVAL, "reject lsm_mac link update");> +	close(fd);
> [...]

