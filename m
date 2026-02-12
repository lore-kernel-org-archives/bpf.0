Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FAB277C96
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770933635; cv=none; b=u8lv9VqTQig3fZX3vseO/ZDZI9RCYK5ucF7Q9rr2OkTeRXkRvNibkt6Icjp7e4uGT9Xl46Ns6KK2XL0m1wuD5BatSlra5w82/080WBmpbdPYYLNEiLCy4SJMW9JHX0+/8qR/0OD2OWc66t5NNcOb3wcZPMjtSCw23N5vaW9181k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770933635; c=relaxed/simple;
	bh=6vS5vqItIC1vDu0x5wT1q2geIhUhMvtak5ngDTLmqdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M6FgyhEEe/j48O1FblMYb2gpyUGoaVqY72ipdlynqxAMDIencYXnRd4HwxgmVKP4oTT5V6NmL61rdK4wW7dvmAwhUg4R3vXAsIXjHI02Qa/PQn49N9rdMsOdB+fpuT1mr4jCOtBrXhbIEZvK2q+uR+cRhgPh/vingbln6oWxOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiPAiVa5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiPAiVa5"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c6e1a67d4b8so159548a12.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 14:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770933634; x=1771538434; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pRNqJQw+tkJ3hFVQXokGgbRqtvLCppLJT7t4ENUrgog=;
        b=FiPAiVa5lNa2mta89XqqRWujscN8qtTRq35LkK9qeAZw3mrAYrnHaLO3Nv+k/qKeZU
         vpR8qcI+efZxmmFKMj3cbyQMWyKa5At7j/NosLi10NPHVXXrXDx+k+EIvAUJ0R5lwiS4
         mnPt04LsvkGkeAMsvALOQ49YCKfRagUtqM1i5E5YBq0dtrA/ADUECKIGViqNYiDDJ6Hg
         zkRk+sslvMjCQzRL+lT5965JbF4s8BYQGJWXif5Rvo0VbmHlWzdrx5eBcj9dr5njg1Bq
         sgZ2HJTkQLbzqQnT5YHXe5/j/NzKtWsetQTEcJ7L8yHV/tthNco6bNhc5+PVX0ItYT6B
         EA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770933634; x=1771538434;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRNqJQw+tkJ3hFVQXokGgbRqtvLCppLJT7t4ENUrgog=;
        b=OkDlWbLkehR2zAfFsgjKwbK+5x/28MnNRd+38it2rIf49n44k3nlupMciMLsqTMaps
         9upfJcnYymO6Q/Qaf1F15HtesKdqcXh6mpQRB+Fo9PFBaj5fNicyhAY4meXoiMwGU75s
         Oog4A1bFTJRb9EIEpvncFR13ttY0IBBAnqEAEGDsTmeajPq2DYdspQrDxHpWVgJ/KKvv
         R/tf7cldiWE8+QzB2pLIin3jo4lyZ4yH5VO4UT3VNz/CGvAcN6wnJvIlBtVULHgYEJu9
         K6X7a5/z3Qv5+3/Ej71YpyPdsx5qw1QyiULI8lyJgjzpnEALlbC/AW0ve6U7VUhUwgft
         YTaw==
X-Forwarded-Encrypted: i=1; AJvYcCVsZrigvrOJky6l2K87XAjO1GZ0BIpDRZKQm3Rmm/zeQHfn54JfVF6LcA2J11cx/NvjBIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMnXUbdm7S2ZqLwGFne0vLI755GCUKkyikF91xAHKTF0lxwuwp
	t6zN/+4/owsMlk1CDZsBEXe8sEGqKnInMW8cJvc1/UPQcmnNDgNzWHZE
X-Gm-Gg: AZuq6aKitMrObgEs5K8VqaicW1GKyNRIT62eTnmvrSdf5E8aJW6GWsbvHBg8uyBUPdV
	RO7g3WvNmfNKKKqJS4c7ujeRK0HNPivo3VaAxynN1In+e+dffb5s7GVPG5UFS0Aohklep9tghc8
	zF6ff6g4Z8DkS1n1IaPWRXUHW78IJpbV+Hfo0VrM3KG8fjJ+6nihs2Jsm4BShj7sw+D3mjcK0ik
	dIVPTZxNV03XcW3IQ5+WuIuK7qaEl44obtzADEV68Ig9NoQA771VGVz2tB8EmxE6essuHuGAwoT
	6pGxe/UQGN+HNrqt1or+VF3sQZ34n5aRya1JBeJV5RWDrec7g17b9IzKN0yAMVUdagxIhXgacyx
	1VosvgWE18V+4Iq/+tada/wMu9bFr+DxqlAokpy4UIommk9mY6MQQWA29h4VHEQJyevSxLu3yWv
	FLNPHCUQsdbhzIaz2vXLL7U9VSbEVHtsb22ynK+d/QTOxKpxsOuQ4=
X-Received: by 2002:a17:90b:2810:b0:34a:a65e:e6ad with SMTP id 98e67ed59e1d1-356a765b9fbmr467430a91.1.1770933634101;
        Thu, 12 Feb 2026 14:00:34 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567eba9b2esm6279778a91.9.2026.02.12.14.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 14:00:33 -0800 (PST)
Message-ID: <59d226c413864ec7229e4a74af7e663e9982c534.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 00/14] selftests/bpf: Fixes for userspace
 ASAN
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
 Alexis =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Thu, 12 Feb 2026 14:00:30 -0800
In-Reply-To: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:
> This series includes various fixes aiming to enable test_progs run
> with userspace address sanitizer on BPF CI.
>=20
> The first patch fixes the selftests/bpf/test_progs build with:
>=20
> =C2=A0=C2=A0=C2=A0 SAN_CFLAGS=3D"-fsanitize=3Daddress -fno-omit-frame-poi=
nter"
>=20
> The subsequent patches fix bugs reported by the address sanitizer on
> attempt to run the tests.
>=20
> The series is a pre-requisite for enabling "test_progs with ASAN"
> workflow on BPF CI.

I did an experiment:
- applied the diff as at the bottom of the email;
- compiled with export SAN_CFLAGS=3D"-fsanitize=3Daddress -fno-omit-frame-p=
ointer"
  (using gcc 15.2.1);
- double-checked that resulting executable depends on libasan;
- did a test run: ./test_progs -a verifier_and.

The error report looks as follows:

  Caught signal #11!
  Stack trace:
  /lib64/libasan.so.8(+0x525e7) [0x7f6a506525e7]
  ./test_progs(crash_handler+0xb5) [0xd152c9]
  /lib64/libc.so.6(+0x19c30) [0x7f6a50427c30]
  /lib64/libasan.so.8(+0xdf4a) [0x7f6a5060df4a]
  /lib64/libasan.so.8(+0xe5bba) [0x7f6a506e5bba]
  ./test_progs() [0xd19ccc]
  ./test_progs(main+0xcf6) [0xd1aa79]
  /lib64/libc.so.6(+0x35f5) [0x7f6a504115f5]
  /lib64/libc.so.6(__libc_start_main+0x88) [0x7f6a504116a8]
  ./test_progs(_start+0x25) [0x401935]

Am I doing something wrong, or does test_progs signal handler
interfere with ASAN reporting?

[...]

---

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index a0a594de9007..3820077e74e4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -46,7 +46,7 @@ srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
 endif
=20
 CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic -std=3Dgnu11                        =
 \
-         -Wall -Werror -fno-omit-frame-pointer                         \
+         -Wall -fno-omit-frame-pointer                         \
          -Wno-unused-but-set-variable                                  \
          $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                    \
          -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selft=
ests/bpf/test_progs.c
index 02a85dda30e6..8839e00167fa 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1924,7 +1924,7 @@ static void free_test_states(void)
                        free_subtest_state(&test_state->subtest_states[j]);
=20
                free(test_state->subtest_states);
-               free(test_state->log_buf);
+               free(test_state->log_buf + 10);
                test_state->subtest_states =3D NULL;
                test_state->log_buf =3D NULL;
