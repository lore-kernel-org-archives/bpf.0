Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B118EB0
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770942231; cv=none; b=E+zyHC3MoHWkAZKFYcpfgBPCwL0i+lIiLTQiSw8iJ2COgWSQW5CZSKuSICHYGXvpGSYgyPByydktw1eN6PgZxu61gq5cuE7r3Eq9eELqZpE80EoLw2409JS3KfuAfm3FbAa5JMmw3/gKKQRbNBkPiA07cB1jLuycD1zk9AKtjjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770942231; c=relaxed/simple;
	bh=hS0xLmOlT/fTSABi7ZBrYJj6FrfO7xt7pHWko+W2yM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=srJR3ixzpiHX56EL1kpYLPXjC8xUv31jvyf7JMvL/QUEZR8EMN4wPheoOdcO7yzxevrbibZ8XZe1aSuD0U1xQduWTgLrEuWoirjlQnqGfPsWcMMrHkiCaPnNE0EBTaA4NrhXWqtl0HiixqPGHh57hn7RfeXY65iINrxOQDRS8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndyHP+KT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndyHP+KT"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824a3ba5222so237633b3a.2
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 16:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770942229; x=1771547029; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BHzLXUW1J4UMi2J1ReqgoNKrsN3W9FO3n6QaRcEMXrI=;
        b=ndyHP+KTVN+gu4l24v5AmKZylPqCJ/WN9xu5LiJ3HLum4RgwP9tdoX3ilNX+WX1Xhi
         Ejfs2mKj7SvhRhnerlD5tFUoytaMI69kzucbpxz7TT+IYp8AZSA27ZLxPbE4XJ+pqRpV
         tHHWMpBCUcw3XFJpeBUXO0KgzxkDuGO5OPxY33EAB57654XSATc/J/sY6Zz9+wkm7Ecd
         WCa/PrmwNt+IZ1YhkNBk/gpTo/kSnE0AXinX5n2i7IDOPAEGkLjRN8y/jdE6lY+yHeqF
         lMChLy/lBPxWz0TA8W5DYH/CbCmEMsF+uiTHHo56RG/uFY7JTb1Il1z/ZhcsKXSFEMxl
         DM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770942229; x=1771547029;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHzLXUW1J4UMi2J1ReqgoNKrsN3W9FO3n6QaRcEMXrI=;
        b=iVh5DIvDZjo8vxzXZ1KtRighHmpkqTtw7CfXV5uumpozMrrq+IUfwBD+97EEcn+f3l
         zT+RfLcVOHL3xM5tmzPcBMvJHGdVauBVztdanbqXW6ur+oB+9YzB8PHuzmesyqX9yMXw
         RssHbWOXvg56rlEfue7UG3cIZsb2/yjgQTWPD+s6aYupg/KexocwVv4aOxZsgt3JjGhr
         NEHMfI93V1e+SxLnNEIdMQ4WK10xaCy3BONz/QADxYag+GSsXYsRViqAaDC6kQudksbz
         9cGDx/8mv4ypOjDPG9QsvREnIJN6+58L5j6hrQg6bBxyQ4GzndAau9TxzhOkTcL2Aa6q
         fLOA==
X-Forwarded-Encrypted: i=1; AJvYcCVmOQ+Tgx7wJV2eI7pyiD2rmInQd3diRQAAbWUqeD88qQb9GPTovMAoQjklPKC2eCvFmu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwEtFWJG3Qr3py9uO/wRKOQSvQzCUHKycYII10MWIJH8JA9GEm
	n5di3VtssYmIwIB/6GN0KaRhDTExKra5AOfssZ2WGDkJhrTdUBmFYmpVfS/c0qn2
X-Gm-Gg: AZuq6aKU7YvevOxiOwtzMsB0S3rs/jYJYkHrVq8a6w+QwNT1jcP2yTLnMycKNMOSDSz
	z9Z92kCkd52TO+7FKT75lSMR2MTWJMxuHaH0u4g06AHDCYTi2aLjDE791NKnUUY8SrVshSoNTsW
	uicxT7ZRBOe94nadmNQIwGaZDat64+wEVwIQzzS5jEIpy63Mb7aYL97aDHnDY7q64a3OCpPPRou
	SmCOp+5YG3ZIQc9K+L5bc5BROetMPffYi4K8zf4WlhIXjLeOcZlaRf5vSEalfyKGc+9nrjcDX2r
	GLwGNVNcEum9SFYbF4kfoMtv6i18GXbkfjiBuaNdC/saj8P7SNlHJMDmUPqmVIJrZRCpyQkbRw5
	MgdmXZbs274mBNIhSnuFr3n1MjflYujiFi19GGPhlw3UGTN4T20gQ4Xxyw9XX0EusL1HCavv5yA
	bh+65M/A8jJLO/PH4FQkL15/umRIhK0XYvWDgIFkk41bWzUeAcWL61M22QZdGh0g==
X-Received: by 2002:a05:6a00:4507:b0:81f:4a06:6f5 with SMTP id d2e1a72fcca58-824c9450c37mr237847b3a.4.1770942229140;
        Thu, 12 Feb 2026 16:23:49 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2ac83sm443782b3a.12.2026.02.12.16.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 16:23:48 -0800 (PST)
Message-ID: <b1399390b3e34961c3afd5a6a06c3c7bb3a4666a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 00/14] selftests/bpf: Fixes for userspace
 ASAN
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
 Alexis =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Thu, 12 Feb 2026 16:23:46 -0800
In-Reply-To: <2a532f02-a7ed-43d5-a0fc-129ee4eeb0c1@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
	 <59d226c413864ec7229e4a74af7e663e9982c534.camel@gmail.com>
	 <2a532f02-a7ed-43d5-a0fc-129ee4eeb0c1@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-12 at 15:57 -0800, Ihor Solodrai wrote:

[...]

> > =C2=A0CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic -std=3Dgnu11=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -Wall -Werror -fno-om=
it-frame-pointer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -Wall -fno-omit-frame=
-pointer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
>=20
> I think you've cheated a little bit here, because with -Werror

It's just a model of a memory error, see below an example that does
not generate compiler warnings.

> If it's removed, then I can reproduce the same stacktrace, which AFAIU
> is an invalid dereference inside the ASAN itself.

See below, if I remove custom signal handler there is a regular ASAN
error message:

  =3D=3D156=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0xfffffff=
ffffffffa (pc 0x7fa03160df4a bp 0x7fa0317bc980 sp 0x7ffee7c85170 T0)
  =3D=3D156=3D=3DThe signal is caused by a WRITE memory access.
      #0 0x7fa03160df4a in __asan::Allocator::Deallocate(void*, unsigned lo=
ng, unsigned long, __sanitizer::BufferedStackTrace*, __asan::AllocType) (/l=
ib64/libasan.so.8+0xdf4a) (BuildId: d3cb6206dff19da52969c009f4cd93611901c47=
8)
      #1 0x7fa0316e5bb9 in free.part.0 (/lib64/libasan.so.8+0xe5bb9) (Build=
Id: d3cb6206dff19da52969c009f4cd93611901c478)
      #2 0x000000d19cd9 in free_test_states /home/eddy/work/bpf-next/tools/=
testing/selftests/bpf/test_progs.c:1930
      #3 0x000000d1a897 in main /home/eddy/work/bpf-next/tools/testing/self=
tests/bpf/test_progs.c:2107
      #4 0x7fa0313c45f4 in __libc_start_call_main (/lib64/libc.so.6+0x35f4)=
 (BuildId: a1dda014206b55b07f58fe8db80121b752dc3d03)
      #5 0x7fa0313c46a7 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+=
0x36a7) (BuildId: a1dda014206b55b07f58fe8db80121b752dc3d03)
      #6 0x000000401934 in _start (/home/eddy/work/bpf-next/tools/testing/s=
elftests/bpf/test_progs+0x401934) (BuildId: 9190db005d475ee7a8e9294bb32cfbd=
520c330dc)
 =20
  =3D=3D156=3D=3DRegister values:
  rax =3D 0x0000000000000002  rbx =3D 0x000000000000000a  rcx =3D 0x0000000=
000000000  rdx =3D 0x0000000000000003 =20
  rdi =3D 0x000000000000000a  rsi =3D 0x000000000000000a  rbp =3D 0x00007fa=
0317bc980  rsp =3D 0x00007ffee7c85170 =20
   r8 =3D 0x00007ffee7c851d0   r9 =3D 0x0000000000000001  r10 =3D 0x0000000=
000000005  r11 =3D 0x0000000000401935 =20
  r12 =3D 0x00007ffee7c851d0  r13 =3D 0xfffffffffffffffa  r14 =3D 0x0000000=
000000001  r15 =3D 0x0000000000000000 =20
  AddressSanitizer can not provide additional info.
  SUMMARY: AddressSanitizer: SEGV /home/eddy/work/bpf-next/tools/testing/se=
lftests/bpf/test_progs.c:1930 in free_test_states

So, there is indeed a conflict between test_progs signal handler and
ASAN default signal handler.

[...]

--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1913,6 +1913,8 @@ static int worker_main(int sock)
        return 0;
 }
=20
+void *ptr;
+
 static void free_test_states(void)
 {
        int i, j;
@@ -1924,7 +1926,8 @@ static void free_test_states(void)
                        free_subtest_state(&test_state->subtest_states[j]);
=20
                free(test_state->subtest_states);
-               free(test_state->log_buf);
+               ptr =3D test_state->log_buf + 10;
+               free(ptr);
                test_state->subtest_states =3D NULL;
                test_state->log_buf =3D NULL;
        }
@@ -1944,13 +1947,15 @@ int main(int argc, char **argv)
                .parser =3D parse_arg,
                .doc =3D argp_program_doc,
        };
-       struct sigaction sigact =3D {
-               .sa_handler =3D crash_handler,
-               .sa_flags =3D SA_RESETHAND,
-               };
+       /*
+        * struct sigaction sigact =3D {
+        *      .sa_handler =3D crash_handler,
+        *      .sa_flags =3D SA_RESETHAND,
+        *      };
+        */
        int err, i;
=20
-       sigaction(SIGSEGV, &sigact, NULL);
+       //sigaction(SIGSEGV, &sigact, NULL);
=20
        env.stdout_saved =3D stdout;
        env.stderr_saved =3D stderr;
