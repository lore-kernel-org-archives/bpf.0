Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13BEAD5
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712396730; cv=none; b=eIXnvMXYEHhU7TY/ZfEiPwxtvj8H95+NAOiipp20eQjZ1THXER6Og5kVk2UQ/fdbgHFv+a11Oqjb/CNSX2tdlQg+psZz0/dfVw5vX7SqSi4i3tUgHLZPVEEY5cASwNw+PeGWgE/J8nQP4ZqGwJQ6TmsIAJtGVJYC2MB1j0y2vys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712396730; c=relaxed/simple;
	bh=k6rAmD+OHxGpiV4C2baGU4ne4+kd25Yj9x2ofoODbZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f8FbNcJ+Zkoy5BSXrqMElBBgiirFOE7Vx2A9ALGGSoJlNnahZCafHtOKtuw3U7b/6UtzqX2d1/1xN4CId0Z454cVBjFPlqk9ywGkPe2SMcUVcsYvDcWlEugbau+gOaiFcqW35PUTd4mLSSFFQp+QqdKJ0XoEWNn3B4DdrxKaaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzoA6Yv7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzoA6Yv7"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-416449c7fd0so276125e9.0
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712396726; x=1713001526; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7NVa03Hd/woOra5Ebc55KaziKKOOtwWxPH4ZQvn7uJw=;
        b=kzoA6Yv7yMx0TkjELMzufFalI65OpChm6R7sHZKHQP/if9FHlFUq/rSbZiG330T3eh
         lrCktaqWycsL1Yr0lMb706eyPbRjgcS6PcvjuF7+USoMqgofEOCtpeNPApK6mJZnxn6R
         cW9AKRjxnwI41quR9BJgq8CpIGtcFx4gseZ0oyYdeiCLFzrqF5VPUtIBiRZwbvXmOd2u
         uB/+Eh26TPuHgOBq14XfJSOOzk+d6HsD+LsnUr76B3/RKiHs8V0KJuWaMiIiPSZDrWi+
         yNvxyB882Xu5JdcdbZHK2iRWhP6QmZkhedMVlMXsA4u86h6N3atsZ2qGiH2Q3KLdfIef
         zFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712396726; x=1713001526;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NVa03Hd/woOra5Ebc55KaziKKOOtwWxPH4ZQvn7uJw=;
        b=nN0lkwRYi6J1J1J8vEz1Hi3fZWDOhC5NsX2T16VjuwsEvksVHrzFfPUl7DRC8iK3kX
         6W6N6fifhKg2bEEGTJWKx6H/ouHFsQo2bLsRNMMiqWrcCoDFJhnbgrw2gNb0kpZhRtz8
         yNfD8QLL4ituQz9JSutWg1fNvcroPvYVMPqP1JzTdVMwhq0mmIoD1HbrSCEKyhqOXtVV
         TSH2gsLXv0SzSneMyDj9SnluvPHsStPNbQHxHwbgTkKPZtNSWJ3L4IYUCVJ00hRNCGSL
         5rPto1x3zWy3bxZO0MqMT51woNsklsm53m+hcPPtTLgvmwi8LNmq8JVuYgujT8qAnEWR
         8vjA==
X-Forwarded-Encrypted: i=1; AJvYcCVpQJGhf5k32OWjhYkSLt/kJXZTORiMWXrnmBmSfXbUlY5aT2nidD5rxSs02Y+n6cKgla2/BL1RG1WJFfEaYb9WjmGX
X-Gm-Message-State: AOJu0YyfaqqhKRX65OEj/NAfT4UGVzdaaqazw3XT7qf7kG4PpEg0Tlk9
	WMsHxE4ME2hbx2Vqvf3tlwD2ZaYaqNvuGWDllUdpH7kjxYtXMjhP
X-Google-Smtp-Source: AGHT+IHnVxIsPJ6LORnDY+pBcsSQ1mPAGvEq2DmN4HgCgEzylwIfwDc1G0Nd+4wVPQchOCq6NwFggw==
X-Received: by 2002:a05:600c:1e04:b0:416:3e77:d88b with SMTP id ay4-20020a05600c1e0400b004163e77d88bmr627995wmb.21.1712396726241;
        Sat, 06 Apr 2024 02:45:26 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id o32-20020a05600c512000b004163321790esm3160634wms.19.2024.04.06.02.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:45:25 -0700 (PDT)
Message-ID: <a1e48f5d9ae133e19adc6adf27e19d585e06bab4.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix verifier error due to narrower scalar
 spill onto 64-bit spilled scalar slots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Tao Lyu <tao.lyu@epfl.ch>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
 john.fastabend@gmail.com, mathias.payer@nebelwelt.net,
 meng.xu.cs@uwaterloo.ca,  sanidhya.kashyap@epfl.ch
Date: Sat, 06 Apr 2024 12:45:23 +0300
In-Reply-To: <CAEf4BzbpZQtiM-ruX-oO-6jth9ZhX5Sr5bTvRx8pNj+VEH3NfA@mail.gmail.com>
References: 
	<CAEf4BzZL6dCZx8Mve1RYXRJ1JeA6xqZeYN0V4Jfr9Xg04vAZrg@mail.gmail.com>
	 <20240405202607.4146642-1-tao.lyu@epfl.ch>
	 <CAEf4BzbpZQtiM-ruX-oO-6jth9ZhX5Sr5bTvRx8pNj+VEH3NfA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-05 at 13:33 -0700, Andrii Nakryiko wrote:
[...]
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 63749ad5ac6b..da575e295d53 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4493,6 +4493,7 @@ static int check_stack_write_fixed_off(struct bpf=
_verifier_env *env,
> >          */
> >         if (!env->allow_ptr_leaks &&
> >             is_spilled_reg(&state->stack[spi]) &&
> > +           !is_spilled_scalar_reg(&state->stack[spi]) &&
> >             size !=3D BPF_REG_SIZE) {
> >                 verbose(env, "attempt to corrupt spilled pointer on sta=
ck\n");
> >                 return -EACCES;
>=20
> ack for this part:
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>=20
> but I'm not sure if we need all the *_caps logic for selftests just to
> test this, tbh. I'll let other decide, though.

Hi Tao, Andrii,

I agree with Andrii that *_caps logic is a bit heavy-handed.
It works on top of the test_loader.c:drop_capabilities() used for
unpriv testing, so I suggest that we add only one macro: __caps_unpriv(<set=
-of-caps>),
that would enable specified capabilities when testing unpriv.
E.g. as in the patch at the end of this email (based on Tao's work).

A few additional notes:
- changes to the verifier.c, to the test_loader.c and actual feature
  test should be split in separate commits;
- __caps_unpriv as in Tao's or my patches allows to set arbitrary
  capabilities, however restore_capabilities() uses
  cap_enable_effective(requested_caps), which does logical OR
  of current_caps and requested_caps.
  For the purpose of restore_capabilities(), I think
  cap_enable_effective() should be updated with a flag to overwrite
  current_caps with requested_caps. Otherwise it might not undo
  __caps_unpriv() effects in some cases.
- I changed the test case to avoid BPF_ST assembly instructions
  ('*(u64*)(r10 - 8) =3D 1') in order to allow compilation by LLVM 16.
 =20
Thanks,
Eduard

---

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/s=
elftests/bpf/progs/bpf_misc.h
index fb2f5513e29e..14a79bc76b45 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -2,6 +2,10 @@
 #ifndef __BPF_MISC_H__
 #define __BPF_MISC_H__
=20
+/* Expand a macro and then stringize the expansion */
+#define QUOTE(str) #str
+#define EXPAND_QUOTE(str) QUOTE(str)
+
 /* This set of attributes controls behavior of the
  * test_loader.c:test_loader__run_subtests().
  *
@@ -72,6 +76,7 @@
 #define __auxiliary		__attribute__((btf_decl_tag("comment:test_auxiliary")=
))
 #define __auxiliary_unpriv	__attribute__((btf_decl_tag("comment:test_auxil=
iary_unpriv")))
 #define __btf_path(path)	__attribute__((btf_decl_tag("comment:test_btf_pat=
h=3D" path)))
+#define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps=
_unpriv=3D"EXPAND_QUOTE(caps))))
=20
 /* Convenience macro for use with 'asm volatile' blocks */
 #define __naked __attribute__((naked))
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tool=
s/testing/selftests/bpf/progs/verifier_spill_fill.c
index 85e48069c9e6..a043514da4f0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include <../../../tools/include/linux/filter.h>
+#include "../cap_helpers.h"
=20
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
@@ -1244,4 +1245,19 @@ __naked void old_stack_misc_vs_cur_ctx_ptr(void)
 	: __clobber_all);
 }
=20
+/* 32-bit scalars should be able to overwrite 64-bit scalar spilled slots =
*/
+SEC("socket")
+__log_level(2) __success __caps_unpriv(CAP_BPF)
+__naked void spill_32bit_onto_64bit_slot(void)
+{
+	asm volatile("					\
+	r0 =3D 0;						\
+	*(u64*)(r10 - 8) =3D r0;				\
+	*(u32*)(r10 - 8) =3D r0;				\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/self=
tests/bpf/test_loader.c
index 524c38e9cde4..ad79b5948440 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -27,6 +27,7 @@
 #define TEST_TAG_RETVAL_PFX_UNPRIV "comment:test_retval_unpriv=3D"
 #define TEST_TAG_AUXILIARY "comment:test_auxiliary"
 #define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
+#define TEST_TAG_CAPS_UNPRIV "comment:test_caps_unpriv=3D"
 #define TEST_BTF_PATH "comment:test_btf_path=3D"
=20
 /* Warning: duplicated in bpf_misc.h */
@@ -53,6 +54,7 @@ struct test_subspec {
 	size_t expect_msg_cnt;
 	int retval;
 	bool execute;
+	__u64 caps;
 };
=20
 struct test_spec {
@@ -133,6 +135,33 @@ static int parse_int(const char *str, int *val, const =
char *name)
 	return 0;
 }
=20
+static int parse_caps(const char *str, __u64 *val, const char *name)
+{
+	int cap_flag =3D 0;
+	char *token =3D NULL, *saveptr =3D NULL;
+
+	char *str_cpy =3D strdup(str);
+	if (str_cpy =3D=3D NULL) {
+		PRINT_FAIL("Memory allocation failed\n");
+		return -EINVAL;
+	}
+
+	token =3D strtok_r(str_cpy, "|", &saveptr);
+	while (token !=3D NULL) {
+		errno =3D 0;
+		cap_flag =3D strtol(token, NULL, 10);
+		if (errno) {
+			PRINT_FAIL("failed to parse caps %s\n", name);
+			return -EINVAL;
+		}
+		*val |=3D (1ULL << cap_flag);
+		token =3D strtok_r(NULL, "|", &saveptr);
+	}
+
+	free(str_cpy);
+	return 0;
+}
+
 static int parse_retval(const char *str, int *val, const char *name)
 {
 	struct {
@@ -258,6 +287,12 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->mode_mask |=3D UNPRIV;
 			spec->unpriv.execute =3D true;
 			has_unpriv_retval =3D true;
+                } else if (str_has_pfx(s, TEST_TAG_CAPS_UNPRIV)) {
+			val =3D s + sizeof(TEST_TAG_CAPS_UNPRIV) - 1;
+			err =3D parse_caps(val, &spec->unpriv.caps, "test caps");
+			if (err)
+				goto cleanup;
+			spec->mode_mask |=3D UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
 			val =3D s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1;
 			err =3D parse_int(val, &spec->log_level, "test log level");
@@ -575,6 +610,7 @@ void run_subtest(struct test_loader *tester,
 		return;
=20
 	if (unpriv) {
+		fprintf(stderr, "can_execute_unpriv: %d\n", can_execute_unpriv(tester, s=
pec));
 		if (!can_execute_unpriv(tester, spec)) {
 			test__skip();
 			test__end_subtest();
@@ -584,6 +620,13 @@ void run_subtest(struct test_loader *tester,
 			test__end_subtest();
 			return;
 		}
+		if (subspec->caps) {
+			err =3D cap_enable_effective(subspec->caps, NULL);
+			if (err) {
+				PRINT_FAIL("failed to set capabilities: %i, %s\n", err, strerror(err))=
;
+				goto subtest_cleanup;
+			}
+		}
 	}
=20
 	/* Implicitly reset to NULL if next test case doesn't specify */

