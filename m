Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990A43F09E
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328457; cv=none; b=mbDlOBymqFWtVDNdiEIIhZ7J5PclUBaEW47vGxvHwEOmfifwl8TD0Z6wESdzeaAra+6VIHwZb99CWAGF8BFpK2p080ZyN3QCASXZ/1fSm47DWzZjoOkZrtuMXWoxdkuznleicyXAoFg/R1kdRaDsZPhC1kQURM3zynyd2chX2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328457; c=relaxed/simple;
	bh=TPogc6h1IJHr1Z5MnDB5opWMmtvdrPU2GNaRzTDQYsw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=aCiob+UzfrqGvn/TVwIacoJRPY4L0B8/8hJYaRuZFKMzqxuxNnRN6jhhU/eQQ62sG5JncywIx0+xVYc6kUIMjDszvSKKnAgDxK1LkkQyPNqa4XQabXxu740v2RurrJy/btQF/XoytJYdvZOi1j4zmOT15iqLIrcc0g5tgDoZiH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Uy+ofLhf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Uy+ofLhf"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacf197759so82775895ad.2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 15:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784328454; x=1784933254; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eGjinEEhxzqnU/zEQzJbAf5YC5+TTOU3DQAIqd47APc=;
        b=Uy+ofLhfXNHINwg1Ly/SV+uWWdxA9Iv6Kaa6cyRT4qHK2NSK0rNq0IYmhUZtlB//yX
         YJNZcbT1JkWY9FjgSe1FhkvLU5V80zRu8MeI5FZbVh29swdHZXcQZFDGKT4fnxkcok9K
         uqp0f82JhcSC3ebeN2NTZ2A00+E938lbDG1K9JOSifqyILIWs6FneALV+sYPFzHuaCdV
         oQSMSE7GF1WQPpEmi5fPGNHboe0asrvVLo8Xq2dBmAbl3opjsNeNdqJHCL0Ywzk5K2A+
         HwMgX5yHmZ5XcS+mE5lpo8B8V6cDnBRd1PyGIC1ukw3pNJgYzSDcrEixJnk39dlk4RpV
         SdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784328454; x=1784933254;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGjinEEhxzqnU/zEQzJbAf5YC5+TTOU3DQAIqd47APc=;
        b=WYgco2Y1xdkEIU2WwnD9wVRfxH7Tzn2Rs5sjdQgBuwvpIR7dfUkb0UBh6OVqofnWgn
         YHe6MtdES5IRioKQ+RneuQoea4uMyxxbUy7Ix/SMtYLjhsNK3HZTEOWLuY7lAZMNWPyi
         dm0tnivckEeoCL83mytyMwzBNOKPaXJDWmh/JmLUbIoJUR2hLfko0VVCu6IgsHoIH320
         m2DVV+Lo/IzyKmfJrUth9Kr3CF87tpw0/89bOMQylR2ZjAd+AzOC1L+sc+WDYmPFRxKU
         Lik8PxYy162kcLb1KC0OakRzoVXjJTUNWwklYWP9jexyX16lN0lhDD5qJ5zjNTTwG3kB
         FUwg==
X-Forwarded-Encrypted: i=1; AHgh+RrPkNbP6ociVMOIXjfqUgJ/VMMJGcJ5/JNw54EgQCIoiZmiSpbwIetHPkrUDRjcrFDFvaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJ+/iXJP96lDXuPW04fWd9v1MpCuHJi8hdHgBR8+WsO4sPAnL
	MJR6Q5AL9ITAq/QijSOmLmZyE4s8gBCxw/U7lqaGbrHrj+8A4ZlL2fIT48/xfiakba4=
X-Gm-Gg: AfdE7cnSTaOAi3bW2noucbZDuk+31c3jCDZINC49KAog6zFClw7l0rVN66efQ2BXWui
	24J3tTMd2iNU4fDcD+KPM14SVY6GbXpDZpUXG/GnFpB2hTzTQ9oL6K39EPTe2OQOtCMdYo14IN8
	Y0StKATUjQgM6cZtMdjRYyW/erbAQQklPTQcIt/XlczBdmmUmQ36mRyAJxpFPfU0qO25+UPb3bg
	7NOvAmmVYR+vhaFFZ1DOc7iKdItiDGacyFSP/Ar/dQl7QF3QE2dm7Lh6zG4eZqxkM43CEBefflL
	Qn7zFG2MxoDokZMoaZyl5Asndg5yD3nl5kvHtXr+KPZRoWMWcj0dnDGF/VOdvBQDzlKjXR9/75A
	DqloiA5JPsBtnG6HRjMesxPY+ilNUoaDcwjzUqkEFH2JFTeLTRz+5iKTNcyQ=
X-Received: by 2002:a17:90a:dfc3:b0:38e:79f:76c6 with SMTP id 98e67ed59e1d1-38e4b5455b4mr4815434a91.24.1784328453705;
        Fri, 17 Jul 2026 15:47:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::f5f9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb6e8sm8132371c88.9.2026.07.17.15.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 15:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 18:47:30 -0400
Message-Id: <DK17N9ROVHRL.23B11VSVOOL6E@etsalapatis.com>
Subject: Re: [PATCH bpf-next v10 6/9] selftests/bpf: Add tests to verify
 global percpu data
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Quentin Monnet"
 <qmo@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260715153254.92010-1-leon.hwang@linux.dev>
 <20260715153254.92010-7-leon.hwang@linux.dev>
In-Reply-To: <20260715153254.92010-7-leon.hwang@linux.dev>

On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:
> If the arch, like s390x, does not support percpu insn, these cases won't
> test global percpu data by checking FEAT_PERCPU_DATA support.
>
> The following APIs have been tested for global percpu data:
>
> 1. bpf_map__set_initial_value()
> 2. bpf_map__initial_value()
> 3. generated percpu struct pointer pointing to internal map's mmaped data
> 4. bpf_map__lookup_elem() for global percpu data map
>
> At the same time, the case is also tested with 'bpftool gen skeleton -L'.
>
> Add a test to verify that the live vars of subskel won't include the vars
> for global percpu data.
>
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  .../bpf/prog_tests/global_data_init.c         | 151 ++++++++++++++++++
>  .../bpf/prog_tests/global_percpu_subskel.c    |  37 +++++
>  .../bpf/progs/test_global_percpu_data.c       |  33 ++++
>  4 files changed, 222 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/global_percpu_=
subskel.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_=
data.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index b642ee489ea6..c37ed9e7b97c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -533,7 +533,7 @@ LSKELS_SIGNED :=3D fentry_test.c fexit_test.c atomics=
.c
> =20
>  # Generate both light skeleton and libbpf skeleton for these
>  LSKELS_EXTRA :=3D test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.=
c \
> -	kfunc_call_test_subprog.c
> +	kfunc_call_test_subprog.c test_global_percpu_data.c
>  SKEL_BLACKLIST +=3D $$(LSKELS) $$(LSKELS_SIGNED)
> =20
>  test_static_linked.skel.h-deps :=3D test_static_linked1.bpf.o test_stati=
c_linked2.bpf.o
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 8466332d7406..f7a56e3fdbce 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> @@ -1,5 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
> +#include "bpf/libbpf_internal.h"
> +#include "test_global_percpu_data.skel.h"
> +#include "test_global_percpu_data.lskel.h"
> =20
>  void test_global_data_init(void)
>  {
> @@ -60,3 +63,151 @@ void test_global_data_init(void)
>  	free(newval);
>  	bpf_object__close(obj);
>  }
> +
> +static void test_percpu_data_on_cpus(int map_fd, int prog_fd)
> +{
> +	__u64 args[2] =3D {0x1234ULL, 0x5678ULL};
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		    .ctx_in =3D args,
> +		    .ctx_size_in =3D sizeof(args),
> +		    .flags =3D BPF_F_TEST_RUN_ON_CPU,
> +	);
> +	int i, err, key =3D 0, num_online;
> +	bool *online;
> +
> +	err =3D parse_cpu_mask_file("/sys/devices/system/cpu/online", &online, =
&num_online);
> +	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
> +		return;
> +
> +	/* run on every online-CPU */
> +	for (i =3D 0; i < num_online; i++) {
> +		struct test_global_percpu_data__percpu data =3D {};
> +		__u64 flags;
> +
> +		if (!online[i])
> +			continue;
> +
> +		topts.cpu =3D i;
> +		topts.retval =3D -1;
> +		err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +		ASSERT_OK(err, "bpf_prog_test_run_opts");
> +		ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval");
> +
> +		flags =3D ((__u64) i << 32) | BPF_F_CPU;
> +		err =3D bpf_map_lookup_elem_flags(map_fd, &key, &data, flags);
> +		if (!ASSERT_OK(err, "bpf_map_lookup_elem_flags"))
> +			break;
> +
> +		ASSERT_EQ(data.data, 1, "data.data");
> +		ASSERT_TRUE(data.run, "data.run");
> +		ASSERT_EQ(data.nums[6], 0xc0de, "data.nums[6]");
> +		ASSERT_EQ(data.struct_data.i, 1, "struct_data.i");
> +		ASSERT_TRUE(data.struct_data.set, "struct_data.set");
> +		ASSERT_EQ(data.struct_data.nums[6], 0xc0de, "struct_data.nums[6]");

Can we add a pre-run assert to ensure that the per-cpu data has not
already been modified by another run? Can we also add some cpuid
specific assignment to ensure the runs are done on the proper CPU?

> +	}
> +
> +	free(online);
> +}
> +
> +static void test_global_percpu_data_init(void)
> +{
> +	struct test_global_percpu_data__percpu init_value =3D {};
> +	struct test_global_percpu_data__percpu *init_data;
> +	struct test_global_percpu_data *skel =3D NULL;
> +	size_t init_data_sz;
> +	struct bpf_map *map;
> +	int prog_fd, err;
> +
> +	skel =3D test_global_percpu_data__open();
> +	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
> +		goto out;
> +	if (!ASSERT_OK_PTR(skel->percpu, "skel->percpu"))
> +		goto out;
> +	if (!ASSERT_OK_PTR(skel->percpu_data, "skel->percpu_data"))
> +		goto out;
> +	if (!ASSERT_OK_PTR(skel->percpu_looooooooong, "skel->percpu_looooooooon=
g"))
> +		goto out;
> +
> +	ASSERT_STREQ(bpf_map__name(skel->maps.percpu_data), ".percpu.data", "da=
ta map name");
> +	ASSERT_STREQ(bpf_map__name(skel->maps.percpu_looooooooong), ".percpu.lo=
oooooooong",
> +		     "long map name");
> +	ASSERT_STREQ(bpf_map__name(skel->maps.percpu), ".percpu", "map name");
> +	ASSERT_EQ(skel->percpu->data, -1, "skel->percpu->data");
> +	ASSERT_FALSE(skel->percpu->run, "skel->percpu->run");
> +	ASSERT_EQ(skel->percpu->nums[6], 0, "skel->percpu->nums[6]");
> +	ASSERT_EQ(skel->percpu->struct_data.i, -1, "struct_data.i");
> +	ASSERT_FALSE(skel->percpu->struct_data.set, "struct_data.set");
> +	ASSERT_EQ(skel->percpu->struct_data.nums[6], 0, "struct_data.nums[6]");
> +
> +	map =3D skel->maps.percpu;
> +	if (!ASSERT_EQ(bpf_map__type(map), BPF_MAP_TYPE_PERCPU_ARRAY, "bpf_map_=
_type"))
> +		goto out;
> +
> +	init_value.data =3D 2;
> +	init_value.nums[6] =3D -1;
> +	init_value.struct_data.i =3D 2;
> +	init_value.struct_data.nums[6] =3D -1;
> +	err =3D bpf_map__set_initial_value(map, &init_value, sizeof(init_value)=
);
> +	if (!ASSERT_OK(err, "bpf_map__set_initial_value"))
> +		goto out;
> +
> +	init_data =3D bpf_map__initial_value(map, &init_data_sz);
> +	if (!ASSERT_OK_PTR(init_data, "bpf_map__initial_value"))
> +		goto out;
> +
> +	ASSERT_EQ(init_data->data, init_value.data, "init_value data");
> +	ASSERT_EQ(init_data->run, init_value.run, "init_value run");
> +	ASSERT_EQ(init_data->struct_data.i, init_value.struct_data.i, "init_val=
ue struct_data.i");
> +	ASSERT_EQ(init_data->struct_data.nums[6], init_value.struct_data.nums[6=
],
> +		  "init_value struct_data.nums[6]");
> +	ASSERT_EQ(init_data_sz, sizeof(init_value), "init_value size");
> +	ASSERT_EQ((void *) init_data, (void *) skel->percpu, "skel->percpu eq i=
nit_data");
> +	ASSERT_EQ(skel->percpu->data, init_value.data, "skel->percpu->data");
> +	ASSERT_EQ(skel->percpu->run, init_value.run, "skel->percpu->run");
> +	ASSERT_EQ(skel->percpu->struct_data.i, init_value.struct_data.i,
> +		  "skel->percpu->struct_data.i");
> +	ASSERT_EQ(skel->percpu->struct_data.nums[6], init_value.struct_data.num=
s[6],
> +		  "skel->percpu->struct_data.nums[6]");
> +
> +	err =3D test_global_percpu_data__load(skel);
> +	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
> +		goto out;
> +
> +	ASSERT_OK_PTR(skel->percpu, "skel->percpu");
> +
> +	prog_fd =3D bpf_program__fd(skel->progs.update_percpu_data);
> +	test_percpu_data_on_cpus(bpf_map__fd(map), prog_fd);
> +
> +out:
> +	test_global_percpu_data__destroy(skel);
> +}
> +
> +static void test_global_percpu_data_lskel(void)
> +{
> +	struct test_global_percpu_data_lskel *lskel =3D NULL;
> +	int prog_fd, map_fd;
> +
> +	lskel =3D test_global_percpu_data_lskel__open_and_load();
> +	if (!ASSERT_OK_PTR(lskel, "test_global_percpu_data_lskel__open_and_load=
"))
> +		goto out;
> +
> +	map_fd =3D lskel->maps.percpu.map_fd;
> +	prog_fd =3D lskel->progs.update_percpu_data.prog_fd;
> +	test_percpu_data_on_cpus(map_fd, prog_fd);
> +
> +out:
> +	test_global_percpu_data_lskel__destroy(lskel);
> +}
> +
> +void test_global_percpu_data(void)
> +{
> +	if (!feat_supported(NULL, FEAT_PERCPU_DATA)) {
> +		test__skip();
> +		return;
> +	}
> +
> +	if (test__start_subtest("init"))
> +		test_global_percpu_data_init();
> +	if (test__start_subtest("lskel"))
> +		test_global_percpu_data_lskel();
> +}
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel=
.c b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
> new file mode 100644
> index 000000000000..8aebd533d86b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "test_global_percpu_data.subskel.h"
> +
> +void test_global_percpu_data_subskel(void)
> +{
> +	struct test_global_percpu_data *subskel =3D NULL;
> +	struct bpf_object *obj;
> +	int i;
> +
> +	obj =3D bpf_object__open_file("./test_global_percpu_data.bpf.o", NULL);
> +	if (!ASSERT_OK_PTR(obj, "bpf_object__open_file"))
> +		return;
> +
> +	subskel =3D test_global_percpu_data__open(obj);
> +	if (!ASSERT_OK_PTR(subskel, "test_global_percpu_data__open"))
> +		goto out;
> +
> +	if (!ASSERT_OK_PTR(subskel->subskel, "subskel"))
> +		goto out;
> +	if (!ASSERT_OK_PTR(subskel->maps.percpu, "maps.percpu"))
> +		goto out;
> +	ASSERT_EQ(bpf_map__type(subskel->maps.percpu), BPF_MAP_TYPE_PERCPU_ARRA=
Y,
> +		  "percpu_map_type");

Not sure why these assertions would be necessary, wouldn't the test crash o=
r
quickly fail if they didn't hold?

> +	ASSERT_GT(subskel->subskel->var_cnt, 0, "var_cnt");
> +
> +	for (i =3D 0; i < subskel->subskel->var_cnt; i++) {
> +		const struct bpf_var_skeleton *var;
> +
> +		var =3D (void *) subskel->subskel->vars + i * subskel->subskel->var_sk=
el_sz;
> +		ASSERT_NEQ(var->map, &subskel->maps.percpu, "var");
> +	}

If we turn the substest to SYSCALL instead of TRACEPOINT we can read
and report the return value as the test happens and keep them
self-contained.

> +
> +out:
> +	test_global_percpu_data__destroy(subskel);
> +	bpf_object__close(obj);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c =
b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> new file mode 100644
> index 000000000000..54380dfb11a5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +int unused SEC(".percpu.looooooooong");
> +int data2 SEC(".percpu.data");
> +int data SEC(".percpu") =3D -1;
> +int nums[7] SEC(".percpu");
> +char run SEC(".percpu") =3D 0;

Can we add a comment that those are used to test the names in the
userspace portion of the test? As they stand they seem unused.

> +struct {
> +	char set;
> +	int i;
> +	int nums[7];
> +} struct_data SEC(".percpu") =3D {
> +	.set =3D 0,
> +	.i =3D -1,
> +};
> +
> +SEC("raw_tp/task_rename")

Is this actually installed as a tracepoint? I think we run it as a
program. Is putting it in raw_tp doing anything in any way?

> +__auxiliary
> +int update_percpu_data(void *ctx)
> +{
> +	struct_data.nums[6] =3D 0xc0de;
> +	struct_data.set =3D 1;
> +	struct_data.i =3D 1;
> +	nums[6] =3D 0xc0de;
> +	data =3D 1;
> +	run =3D 1;
> +	return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

