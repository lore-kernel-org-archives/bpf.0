Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1773305674
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463765; cv=none; b=WNbdxj5nu4Li6LPGlw/75m9eP9hrXOvR7WyI1pGQiU49wPlgnjuz5BGBQQtCgGLDEG6hpUG9t9iJ8ycLYSThwmK7vNGBYACsvtQrLV4hTyVa1LVhpXdo2S+WtujMir1aIpoYa8WbrT7dxHEVfCYWeOP1C7gG+98W0bVnZ4gpA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463765; c=relaxed/simple;
	bh=m89jwXhJMxiAmbTJTVwHyzA8noKriKDeJkV/GnrVqSQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DqoE39QjVQYQL0rHwvAzjkcPnpWJQi6urdO+3G5bK+b3M01W0w1jlqZCwl8HNTJ3Sx9uiWcXNcpY6H1C4ITmo3CakBuW9Pkvju5/2wUjJT9bKwd0sVk2d8cBvxBCYF/+4MSDKmfADyAcFyzmzRQgsRSYuIJOSo0XCt3cs6dMfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0pOewn0; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0pOewn0"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46cbf263216so15031f8f.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783463762; x=1784068562; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+q29ZQKchJgApMuqtZbBTPY6dwIg1bHElZDURl009w=;
        b=T0pOewn0OetrfgBuuETQx8xRdzbax4g3sUAo/tBDVt+1UmHwKIC85w0dEcAXCpwcHl
         abXfrlMhZODyfnndE+RatVhbw1dvfEeBkilTdIoa7ueiYZse9Hpgf6o7d7AUCh0IU7r6
         xqT5GZmeOv8XqO1TSapZfeMv/n/ERn/J6u7EEzYGnqdwrl/ZO/IteOND2dzoiKF944jY
         uaYdvbReLqZPHFAko0q5NWEMbPNpUGrnkID4KaWcSCeNfucgsYwsb4hM/ofY9yFLneju
         +o3UPh7e99WH1XS7qZJ88JSeviyvZ1oc0v7Z2hHP7uMPWYjGqgDlXRBio4WLvHnWIK3j
         Wu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783463762; x=1784068562;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+q29ZQKchJgApMuqtZbBTPY6dwIg1bHElZDURl009w=;
        b=IYVCqKHBI/owrMiS89e7tL0D7ufbGr+Exvp8FHmfNpR5r2xPB3gixsXphJsqSJ5Op6
         LBPqFDhqN2kFS1DKDG9n/dueHtqMHevcxDLo+9wfwSTSnHQkqkXLhX0a1myWzdJlGABU
         9GYBxDsQWqQU326MG5BrFIvDsD9kqs9MfA/3yEOzqjx9IoIDKvKqIU6ZusFpGzzesllF
         pFqu2NsN4rodbU+tGknf6uF/nJyy0bnylAshiHxLmuPfhcp7fSrEbhl2In/YQFATbkyU
         vIuDr8qxsZcu6YiILVWhirLtCWZVrLvhkngddGx61EjwB0yK87COe7ChZ+zO2AZnBb59
         7C9w==
X-Gm-Message-State: AOJu0YxRIUyYgIRfZT7b2TLWA5jYsMztx6BwEPCvXVc8eqmPo/5KFl2L
	mAIsphPTEJQzOyEgDov/Sx1S7ccvY9ZZB9PhzIlBoyOgW1D9JsU894Ns
X-Gm-Gg: AfdE7cnLHgW8dqJyymJ1WHAeFWYtLPu8IuXDs7lOUS7PWhAqc2ez30/Hl6uJT7/I0YC
	pAThcUzYIVBsW7heT91OXmFgB3GJBJJJZo20BwJuLvlrbsb8KEXoswmXFQZr9OXayDTcJ5RCi6B
	q2nyLF8I7awmGhSW0OTSy3d4AFmzKGvoBeFa7HDOOXSTaJcaLMmTrAsaiDPU8dMqnRICLFDHwwf
	PY1lIMEaCRZqsdv2RQWc9drCQdD5TXCazn7WgHWL3khOzNRyeM4T3HHrmqbqBIn+GDMtfh4q4IV
	3WuqzDNYytmQ7IQpQT3viT89RomfCxxF+kY2C9apVtZPHOULaOiJEYkd7U9wTwxNEbigigXVIiH
	FMPyhJSK5eFLTGTG2twQHTQ1OH1RrXhENxjRY+wrio9zpEgcfTW0VlhwnTUUVsaATCABHvw/b9n
	I36lr/VgmCO9mG7xWUmfoi/gp3ibPu1qgbZ9Kfm8Tx1QGUSx1bgnAJ/wZlF65wfKj+JvE2FIBQi
	H7j3cjRYuPFs2KtYEwf+kALcHGEDDusfb/O+UGvPqOP+J+p9zcOVqc=
X-Received: by 2002:a05:6000:4b1b:b0:47d:ee92:2baa with SMTP id ffacd0b85a97d-47dee922e2emr1753193f8f.57.1783463762087;
        Tue, 07 Jul 2026 15:36:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d91bsm41779217f8f.4.2026.07.07.15.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 00:36:01 +0200
Message-Id: <DJSP514TVE91.2KYRSI48YO2P3@gmail.com>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add untrusted BTF write
 regression
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260707190214.1997705-1-memxor@gmail.com>
 <20260707190214.1997705-3-memxor@gmail.com>
 <CAMB2axMvA6n-x4SReDCzCPuu2n1i-oxsgeQtk6p5LF1Ce8Ez_A@mail.gmail.com>
In-Reply-To: <CAMB2axMvA6n-x4SReDCzCPuu2n1i-oxsgeQtk6p5LF1Ce8Ez_A@mail.gmail.com>

On Wed Jul 8, 2026 at 12:31 AM CEST, Amery Hung wrote:
> On Tue, Jul 7, 2026 at 12:02=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>
>> Add a TCP congestion-control struct_ops load test for a write through a
>> BTF pointer produced by bpf_rdonly_cast().
>>
>> The test expects the verifier to reject the program before the TCP CA
>> btf_struct_access callback can whitelist the tcp_sock field write.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>  .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 12 +++++++++
>>  .../bpf/progs/tcp_ca_untrusted_btf_write.c    | 26 +++++++++++++++++++
>>  2 files changed, 38 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_untrusted_b=
tf_write.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools=
/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>> index fe30181e6336..eb05fc82f81b 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>> @@ -14,6 +14,7 @@
>>  #include "tcp_ca_incompl_cong_ops.skel.h"
>>  #include "tcp_ca_unsupp_cong_op.skel.h"
>>  #include "tcp_ca_kfunc.skel.h"
>> +#include "tcp_ca_untrusted_btf_write.skel.h"
>>  #include "bpf_cc_cubic.skel.h"
>>
>>  static const unsigned int total_bytes =3D 10 * 1024 * 1024;
>> @@ -579,6 +580,15 @@ static void test_tcp_ca_kfunc(void)
>>         tcp_ca_kfunc__destroy(skel);
>>  }
>>
>> +static void test_untrusted_btf_write(void)
>> +{
>> +       struct tcp_ca_untrusted_btf_write *skel;
>> +
>> +       skel =3D tcp_ca_untrusted_btf_write__open_and_load();
>> +       ASSERT_ERR_PTR(skel, "tcp_ca_untrusted_btf_write__open_and_load"=
);
>> +       tcp_ca_untrusted_btf_write__destroy(skel);
>> +}
>> +
>>  static void test_cc_cubic(void)
>>  {
>>         struct cb_opts cb_opts =3D {
>> @@ -637,6 +647,8 @@ void test_bpf_tcp_ca(void)
>>                 test_link_replace();
>>         if (test__start_subtest("tcp_ca_kfunc"))
>>                 test_tcp_ca_kfunc();
>> +       if (test__start_subtest("untrusted_btf_write"))
>> +               test_untrusted_btf_write();
>>         if (test__start_subtest("cc_cubic"))
>>                 test_cc_cubic();
>>         if (test__start_subtest("dctcp_autoattach_map"))
>> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_writ=
e.c b/tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c
>> new file mode 100644
>> index 000000000000..eda4697aac80
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "bpf_tracing_net.h"
>> +#include <bpf/bpf_core_read.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +char _license[] SEC("license") =3D "GPL";
>> +
>> +SEC("struct_ops")
>> +void BPF_PROG(untrusted_btf_write_init, struct sock *sk)
>> +{
>> +       struct tcp_sock *tp;
>> +       int v =3D 1;
>> +       void *p;
>> +
>> +       p =3D bpf_rdonly_cast(&v, 0);
>> +       tp =3D bpf_rdonly_cast(p, bpf_core_type_id_kernel(struct tcp_soc=
k));
>
> Do we need two bpf_rdonly_cast()? I tested the following and it also work=
s:
>

Yeah, single case works too, I mostly kept these two because of the origina=
l
report.

>         tp =3D bpf_rdonly_cast(&v, bpf_core_type_id_kernel(struct tcp_soc=
k));
>
>> +       tp->snd_cwnd =3D 1;
>> +}
>> +
>> +SEC(".struct_ops")
>> +struct tcp_congestion_ops untrusted_btf_write =3D {
>> +       .init =3D (void *)untrusted_btf_write_init,
>> +       .name =3D "bpf_ro_btf",
>> +};
>> --
>> 2.53.0
>>
>>

