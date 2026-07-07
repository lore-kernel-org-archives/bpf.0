Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBEC18C008
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783465125; cv=pass; b=P8t6qKx21AJlSqD/TxDMoh5q36LHZ8NtJ43vx8f7Z5zy9BBMQQgd4tXtvxrCCYNSJguvY8zyVLTo3SS9CKHoQ6emdcFzViURWQ0u7YKktxlE+OuNcrcOjRlUhRAhkF8RVw0GseYS4n63FinM0iQt85Ja05fne3CrLvdDADf8kvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783465125; c=relaxed/simple;
	bh=ja7uFT9RhrGzP1gsfBvnzE+9YBkDJhlDvlMOvxU+SWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tlrd2SN2DHw6642znOQDHgd4Cvk1UjE1K5DT3eHCsQlR/3wATlEdwNTNu7jE0X0om1++aUZ9Ib9pqPtndLlLEeSGuP6ZEcbBQcpm4zXpPud1esN1DmnjZ+WioFB36HBIAjIQaKkPt1HdfXnjIW65/OtAXcD85bit0y61FLNpZWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzDuOk8u; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzDuOk8u"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6662551100bso46193d50.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 15:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783465123; cv=none;
        d=google.com; s=arc-20260327;
        b=FSq2E4kuQYQshMLfhflRAzsCr/urHEzSXlar+phusVben3HyJ4ZKJH8hK9XZ9TqEhj
         N08wLR+rrwbCkXIj4o6jGzKXGhrphNJ6WmHy/qKWlqEUF6h/OnnCBx1VglHfF9Mfuk6G
         OKaasladclTfzr+ieGCdpWZt5BeFUbqbTv7Hwzh0khJfn3aKxoXXbVqfOADgCivVeQN3
         KxM1ur5r1fPUXgxYWWS2V1AJByIsmCGy04LZxcsT/Be10vJFZOGkPFwA9NHQ0xgkjtx1
         6oRCLpcSuA7VaB4EORLKNpTiSTOdHhzt9w0G61iW+QFWGQ/fNq4Nv7CpF3DdovZJnBqp
         1c4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5fmINe/U58CCkXrmP+TjpA87VVcVAQKtkdU7O3ozLi8=;
        fh=iw7+rQzlbDI58pgaP3Ojwlw8x3F/yp+Z3O6odXgNeYk=;
        b=L23Y0mLfJAM6429zBQQdoEZQ/+AR9s7tiMRSEkb6htugXNRU9hmyS7fVACxL3XnuOO
         a/Hqb2MiStoOkw4mFWMfuhgJdAvlxWQqEw/uKS2/3wlLGOYcXG7UzWrzV7WhxhsE7ELu
         BoIkF9ixW7XOjaVeO+MxYGOw96eEfugIli8miozly3K8g+qo3qrZq2RZzk+3/6hm4PgZ
         ZINjUdgmkZJjqJhTp/uVxa+LwoxRlErMTKZHgFgx2hKLR8ounwkRoVjDfoHtV3Gko4jn
         tqQzh4JBUmiOlrZYz4V8/ROeOcSdJgx2jlhCIG8cDk3TACEaraxxqmcILIO9aNWmP2cQ
         pCSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783465123; x=1784069923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fmINe/U58CCkXrmP+TjpA87VVcVAQKtkdU7O3ozLi8=;
        b=YzDuOk8uSj2dGlCpxZLVlqeO5IDc2zTXdM/7qbT9UZ6MRdrJAOUMngpmSIgOK+y0W+
         62Nm+zPfMXxDWTNL34kHQY4cOSN0dD06IcmjTrVPlQQcaiZsxXYmMI+QLTOcj4c9NMRv
         itY3/ZZt4r5IyUS3ZY7QqVQM4yNVJPV8L/7aI/5w1HzKGc8kktgKm1KGwKWN6pNEAvRW
         UuaAhM96LmR2hBUYo9QD7URrHbeHRSSODDgX1QLZhOPVnaIluyLP+BAPZUCShsS57NHY
         t4Nfg6LLK2j3oubL7jCEiswclG6qsGSSXuzobqx7Ymg/LTOydTtzLMNInEsN2LotjyKO
         XyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783465123; x=1784069923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5fmINe/U58CCkXrmP+TjpA87VVcVAQKtkdU7O3ozLi8=;
        b=bWT+GKhPtyu2Q37W5QCoD0znTE+kpyIEArA/h4XddEgdzefGfepuNrhvZ9MEyIoh9v
         jilGqMcDkNFqpcgi7KKUI4rL5gSaWzMxNzGb8PWNF9A8m0lc2tAfmkzLN4QQ8hcW6tj5
         aTKvOIJU32VRblXtDHk4/5jCxk2qruFPaJDHHbh/T9Tuul2rKixVxg2ud+e2crVzoTyN
         QYnPVwCDwYKTj4HyD0ECzoZVAxymz/Rqpmf4TM28/2QfRvjeWTrkKRsHvm4xbs5dVR/a
         J8dc9E0zEHzAGWp4fSn/qxt7xY3M5W59GBu8BOD450/ZYSaBEQrRWHCVuEuCb0gXFPGR
         3/sw==
X-Gm-Message-State: AOJu0YyeyQ74Oj5Zaz6OxknfX5ArcEOy9Z0vAhuZcxdkWoiDCjRbK1d8
	Io8k4MLG7ml7r0k/Sl2XpDiSVqWuTAq7xad+ItQ06J5abyvKRaAb6TVTa75d7NJepw8Wgh1ZEZu
	DPD5R6UIDrCB0LghVnHnf7yyT2DzWFXo=
X-Gm-Gg: AfdE7clXc/vH+qPPPFRpwElSRFSLEtDx8Mjs3ymmtOjG5dFnZ779DrUODGgpIoLej2j
	lYKzV79QLw+K4p5xQT7LTeAn2B94PqsJXgeD/pj1cR4dYdNy+2RdMW09HABDQISYIESJCJabzcU
	4Y+fo0Udl6hyNHHcvXasa41m8tusRK8Tv+H0GSFPjMXsh1MIyk7PjgjeTAIZzhxJ0Ar08WCEfYt
	D0/Q6zUoL3ZtoSpyjyNz71oT2Hug2AbtWEVRzU6Pww3iGc0c1JXpxMa6COtK4E/uViXh0k5hy4T
	njSlpHEg4w==
X-Received: by 2002:a05:690e:4403:b0:660:68e7:ee50 with SMTP id
 956f58d0204a3-6679f080724mr9755d50.31.1783465123290; Tue, 07 Jul 2026
 15:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707190214.1997705-1-memxor@gmail.com> <20260707190214.1997705-3-memxor@gmail.com>
 <CAMB2axMvA6n-x4SReDCzCPuu2n1i-oxsgeQtk6p5LF1Ce8Ez_A@mail.gmail.com> <DJSP514TVE91.2KYRSI48YO2P3@gmail.com>
In-Reply-To: <DJSP514TVE91.2KYRSI48YO2P3@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 7 Jul 2026 15:58:29 -0700
X-Gm-Features: AVVi8CetwZ_bB-pgGPR33v9tqpDk7QN5fK5RVhZ9YPNAc5PEiTHq6LvbGpJ8ouQ
Message-ID: <CAMB2axNVwFcHQ3LY_8b91XDeMnFw9Jq0mRB2NAH1-Bc1J=Q5QQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add untrusted BTF write regression
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 3:36=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Wed Jul 8, 2026 at 12:31 AM CEST, Amery Hung wrote:
> > On Tue, Jul 7, 2026 at 12:02=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >>
> >> Add a TCP congestion-control struct_ops load test for a write through =
a
> >> BTF pointer produced by bpf_rdonly_cast().
> >>
> >> The test expects the verifier to reject the program before the TCP CA
> >> btf_struct_access callback can whitelist the tcp_sock field write.
> >>
> >> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >> ---
> >>  .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 12 +++++++++
> >>  .../bpf/progs/tcp_ca_untrusted_btf_write.c    | 26 ++++++++++++++++++=
+
> >>  2 files changed, 38 insertions(+)
> >>  create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_untrusted=
_btf_write.c
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> >> index fe30181e6336..eb05fc82f81b 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> >> @@ -14,6 +14,7 @@
> >>  #include "tcp_ca_incompl_cong_ops.skel.h"
> >>  #include "tcp_ca_unsupp_cong_op.skel.h"
> >>  #include "tcp_ca_kfunc.skel.h"
> >> +#include "tcp_ca_untrusted_btf_write.skel.h"
> >>  #include "bpf_cc_cubic.skel.h"
> >>
> >>  static const unsigned int total_bytes =3D 10 * 1024 * 1024;
> >> @@ -579,6 +580,15 @@ static void test_tcp_ca_kfunc(void)
> >>         tcp_ca_kfunc__destroy(skel);
> >>  }
> >>
> >> +static void test_untrusted_btf_write(void)
> >> +{
> >> +       struct tcp_ca_untrusted_btf_write *skel;
> >> +
> >> +       skel =3D tcp_ca_untrusted_btf_write__open_and_load();
> >> +       ASSERT_ERR_PTR(skel, "tcp_ca_untrusted_btf_write__open_and_loa=
d");
> >> +       tcp_ca_untrusted_btf_write__destroy(skel);
> >> +}
> >> +
> >>  static void test_cc_cubic(void)
> >>  {
> >>         struct cb_opts cb_opts =3D {
> >> @@ -637,6 +647,8 @@ void test_bpf_tcp_ca(void)
> >>                 test_link_replace();
> >>         if (test__start_subtest("tcp_ca_kfunc"))
> >>                 test_tcp_ca_kfunc();
> >> +       if (test__start_subtest("untrusted_btf_write"))
> >> +               test_untrusted_btf_write();
> >>         if (test__start_subtest("cc_cubic"))
> >>                 test_cc_cubic();
> >>         if (test__start_subtest("dctcp_autoattach_map"))
> >> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_wr=
ite.c b/tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c
> >> new file mode 100644
> >> index 000000000000..eda4697aac80
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c
> >> @@ -0,0 +1,26 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +#include "bpf_tracing_net.h"
> >> +#include <bpf/bpf_core_read.h>
> >> +#include <bpf/bpf_helpers.h>
> >> +#include <bpf/bpf_tracing.h>
> >> +
> >> +char _license[] SEC("license") =3D "GPL";
> >> +
> >> +SEC("struct_ops")
> >> +void BPF_PROG(untrusted_btf_write_init, struct sock *sk)
> >> +{
> >> +       struct tcp_sock *tp;
> >> +       int v =3D 1;
> >> +       void *p;
> >> +
> >> +       p =3D bpf_rdonly_cast(&v, 0);
> >> +       tp =3D bpf_rdonly_cast(p, bpf_core_type_id_kernel(struct tcp_s=
ock));
> >
> > Do we need two bpf_rdonly_cast()? I tested the following and it also wo=
rks:
> >
>
> Yeah, single case works too, I mostly kept these two because of the origi=
nal
> report.

I see. I was wondering whether the first cast has some special
purposes. Single cast reads a bit cleaner to me, but no strong
preference.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>
> >         tp =3D bpf_rdonly_cast(&v, bpf_core_type_id_kernel(struct tcp_s=
ock));
> >
> >> +       tp->snd_cwnd =3D 1;
> >> +}
> >> +
> >> +SEC(".struct_ops")
> >> +struct tcp_congestion_ops untrusted_btf_write =3D {
> >> +       .init =3D (void *)untrusted_btf_write_init,
> >> +       .name =3D "bpf_ro_btf",
> >> +};
> >> --
> >> 2.53.0
> >>
> >>
>
