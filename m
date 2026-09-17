Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCEC48E0F8
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683278; cv=pass; b=C6evkctEJLO/MRVAsRfqrc+YVKcHh+cPnz0MK5rR6Mfc2jNzY+Z+0mZFHia+Z9uQtep5irrSL+8FF6/7UOctrD5RYK1bG4rDLmdH1bTZQmadf1cYwHSx2oAcO+bI2XpVrepZMwr6CW7RehnJzfKJ75YMSqERVv6RPpZH22sdAfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683278; c=relaxed/simple;
	bh=33JrJP0eBoMTWOsObcZUnprsGVGyOvYEXvVWS++emGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKJDzA2jp/RMqUMAfyWRYqPJYjvpV5p+Vj7Rsdb6TmDauIAcCBCc5AJiR4HpIJFXP0M3XOSw3em8/3LoclTI+i18aXM2SPjWqkbF5V0ZriUmJt3U7mZLLBsBVJdTCUUg3M2lxzKhOr4gsGju8eJV6XVLVkT9ylV4o374qMsKwY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3kDpzW4; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3kDpzW4"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so94735a91.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 15:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789683276; cv=none;
        d=google.com; s=arc-20260327;
        b=dl2gGdpbglfPI7HyObBdY0Hiwg26PtYAwg/BH76o4Svk+Prd/lYuoh4OVxiF1OcaLz
         PbgOcgb/qr2LOsqW+RL89ZCuhsaOwxAHgL37GFYTCwc3N12DG0d+1ch2au4JhPo3SpQY
         2IL2TPBV9j/WAwEHgk1wZP7gx9jQWMDFBpts4SDIsvDqvbUz1CCj2fiOP2yo1wlEt6iW
         pwFGRrzaNllpCdiTgpWBcLhgxMSABj9TAnebQNF2HZpdUaaKLJBFsPvw6hwn/VsNctZw
         7Fq3v6qVR2RKQ1SNzdM/0MfePMzjc6FkSPRrV5T7u/ymj7rPMdNLcOjwWaitxaQYyKJJ
         8lwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wVkLWZwDcftHWkygPUCtZEPadhVhHno/qCcQeOr4QFc=;
        fh=K0Xx2sNdATDdTEazM4lOuy4jN0FmnNrGewpbXY+dyqo=;
        b=hLXqTI90LWEP6wpip5BxaWTiV/AXwaSLFKll7Fz8N3T5BlF/aM36JIATUPJ+n9hE7P
         jgxK9g7YMMJ8nZrfRnV2CTEMojJEcrNxNr0z8zrGuSukjTna9v6C+xFtT5pxZDMfPiCQ
         AV0hZj5Ks3UFeqckYoT3nHUpTRKve61Dq/t2F6/iQwfX58maiyuLPDvHjcfwOF3xlLFR
         VKgyfSfgpm85/RteDCaq+d30CDfG0NW1zecvgsqQXupzwxyGqYvLjMnq+lo04RjMdz5B
         pc8GiN/Czp8Obf2zvFnHfC15F6vo4AKpikafrLQG97UWXVYr9QSgFjyTrzn62f16CLF1
         FmsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789683276; x=1790288076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wVkLWZwDcftHWkygPUCtZEPadhVhHno/qCcQeOr4QFc=;
        b=k3kDpzW4vKUzzrFj57AwwCBiREk823rOjan43sFdP/3nZarIjD6UXejVsp6S3DJ6bw
         DWp6M8uIvr+GH3ulXwRqbnXJZa0/faHb+CCGptCIen6JGk4hdlpnXW8LXAsPAZKH8fE3
         XsKW0Sbu8b/RshFyV4XXLD9HCCfKxOxXo3npy+0FFqeBjvQ0Y3JsL7LOf7kcTqQXf+kA
         nyU+d9h14etwa9XgUCWZ18k6MjGIdTsonnFgqx194x3zZ8UV2ZfXyEnvvR0amCmKQUBK
         bDJOLWmp91AtfXD4zXFA1vFTrM1z7+AY/K+j/ZDyqN4OsoA2+crdcu7h468Zqc0x4F6n
         mIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789683276; x=1790288076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wVkLWZwDcftHWkygPUCtZEPadhVhHno/qCcQeOr4QFc=;
        b=FWP5Z7iNR7gTJt/9sRFLWYTfNrL2gd/eQyvAJwSU3Xy2a9xvdtAzg9Jk5XURqi3GTW
         yqy1uMS3TtpZ17byRsrYLibKZwGvqLJZwJWvJHkB/Z+YLPEqWHb142ZPpm+NgXdVMP6U
         vp10DiM2AMIAi8sXX85mRoYupt/6iCk8rDDjkC9EGiZacA5XvHo85ydzDn1Ji1vc+mtk
         DDOrjeQUj0X6YJBezwrpyUYUauardd82ILmn3snjPso1GP41gT8cTNvU4c3Ua37vYrSx
         YZf/ydAlAQ6kf5o9nL3lf6JvNOrG+RZj5ShYbBOgywc90NH9yOM4bYxzjs8PP4gpzU7Y
         LTJw==
X-Gm-Message-State: AFuF++ktuCYA3uOp5fOz2bZ90OX2AsTuZ0FaS831+fOUkJp1+wXZ/vMv
	oMyUI3oY4K/aSdkmfVynvs3MOKGLeRZMXh7j9hOw0eRKuvvK3aE3Yh7APZ/oed2rDkW2LLCos0M
	x6yAS2WKbJ7ZHLvSTRXerxteLfwJPVx4=
X-Gm-Gg: AYBFou0HNFwOhJFGB3e97YtekCh/Ly9FAI+vzR4MBKPELRo8HSBShaHyptVHXhP3V04
	9/n1Rxsr0gRUvXADLgPbHGwjySDLD2g1FpB+Q93GIhOQ5jQ20VgYOsVxda2yZ1a2kEN1YKxZvC0
	rLGOQH7LyPuCDheRXVFf+UE29ZcQMu3H/Fiy7uO6WShhS3ZF/gw2/oL8G/rb5eVuMbbOw667Q70
	zhIiXQ+kUHPnSveZTSwyE5yqCNliBFpV7hr2i9PNLT9WSFl2Nq2gxig8iFHdRQrjxTBbQ9AyJBL
	rgiPQvxZ/YXGAoW532NBfnuQ+6WRYNM1PnyaSjTfKWuqrLZfCX7HrrmM8A+9Nu+bkGVxJMi0nb7
	09IfDbIOA1BRAwkue0mgw5P49N/UK6ANoOGAVkOLz3gPIoL4VI6uQ
X-Received: by 2002:a17:90b:53c3:b0:39d:f130:8f13 with SMTP id
 98e67ed59e1d1-39e54e3c624mr985500a91.21.1789683276095; Thu, 17 Sep 2026
 15:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915080255.48929-1-tasos.papagiannnis@gmail.com> <20260915080255.48929-6-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260915080255.48929-6-tasos.papagiannnis@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Sep 2026 15:14:22 -0700
X-Gm-Features: AcwNN1V6otsO6IWksnCzkd743-EAl1OOZ6ho93SkT0O5q69xaMVQFn98PY1WbH0
Message-ID: <CAEf4BzZui5ywrdEz1Sz+XuSEOyFVBnGR_F0SU0vNuhBpaGpqGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 5/5] selftests/bpf: Test mm_struct user memory
 kfuncs with linux_binprm
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@kernel.org, 
	akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	brauner@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	kpsingh@kernel.org, ljs@kernel.org, matt@bobrowski.net, memxor@gmail.com, 
	song@kernel.org, sun.jian.kdev@gmail.com, utilityemal77@gmail.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:03=E2=80=AFAM Anastasios Papagiannis
<tasos.papagiannnis@gmail.com> wrote:
>
> Add a sleepable BPF LSM program attached to bprm_check_security to test
> bpf_copy_from_user_mm() and bpf_copy_from_user_mm_str() on CONFIG_MMU
> kernels.
>
> Starting at bprm->p, verify that bpf_copy_from_user_mm() can copy the
> contiguous NUL-separated argument and environment data. Then use
> bpf_copy_from_user_mm_str() to read each argument and environment string
> separately, advancing the offset by the length returned from each call.
>
> Skip the test on !CONFIG_MMU. In that configuration, exec argument and
> environment strings remain in bprm->page[] until the binary loader
> transfers them to the new process stack, so they are not accessible
> through bprm->mm at the bprm_check_security hook.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> ---
>  .../bpf/prog_tests/copy_from_user_bprm.c      |  72 +++++++++++
>  .../selftests/bpf/progs/copy_from_user_bprm.c | 122 ++++++++++++++++++
>  2 files changed, 194 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user=
_bprm.c
>  create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm=
.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c=
 b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
> new file mode 100644
> index 000000000000..ef351cda9348
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <errno.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include <test_progs.h>
> +
> +#include "copy_from_user_bprm.skel.h"
> +
> +void test_copy_from_user_bprm(void)
> +{
> +       char arg0[] =3D "first";
> +       char arg1[] =3D "second-argument";
> +       char env0[] =3D "SOME_ENV=3Da";
> +       char env1[] =3D "OTHER_ENV=3Dsomething";
> +       struct copy_from_user_bprm *skel;
> +       pid_t child;
> +       int status;
> +
> +       skel =3D copy_from_user_bprm__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +               return;
> +
> +       /*
> +        * On !CONFIG_MMU, exec strings are held in bprm->page[] rather t=
han
> +        * being mapped in bprm->mm.
> +        */
> +       if (!skel->kconfig->CONFIG_MMU) {
> +               printf("%s:SKIP: test requires CONFIG_MMU\n", __func__);
> +               test__skip();
> +               goto out;
> +       }

I'm not sure I'd bother with this !CONFIG_MMU support, tbh

> +
> +       if (!ASSERT_OK(copy_from_user_bprm__attach(skel), "attach"))
> +               goto out;
> +
> +       child =3D fork();
> +       if (!ASSERT_GE(child, 0, "fork"))
> +               goto out;
> +
> +       if (!child) {
> +               char *const argv[] =3D { arg0, arg1, NULL };
> +               char *const envp[] =3D { env0, env1, NULL };
> +
> +               skel->bss->monitored_pid =3D getpid();
> +               execvpe("true", argv, envp);
> +               _exit(errno);
> +       }
> +
> +       if (!ASSERT_EQ(waitpid(child, &status, 0), child, "waitpid"))
> +               goto out;
> +
> +       if (ASSERT_TRUE(WIFEXITED(status), "child_exited"))
> +               ASSERT_EQ(WEXITSTATUS(status), EPERM, "exec_errno");
> +
> +       ASSERT_EQ(skel->bss->bprm_argc, 2, "bprm_argc");
> +       ASSERT_EQ(skel->bss->bprm_envc, 2, "bprm_envc");
> +       ASSERT_EQ(skel->bss->data_len_match, 1, "data_len_match");
> +       ASSERT_EQ(skel->bss->invalid_flags_ret, -EINVAL, "invalid_flags_r=
et");
> +       ASSERT_EQ(skel->bss->copy_ret, 0, "copy_ret");
> +       ASSERT_EQ(skel->bss->str_arg0_ret, sizeof(arg0), "str_arg0_ret");
> +       ASSERT_EQ(skel->bss->str_arg1_ret, sizeof(arg1), "str_arg1_ret");
> +       ASSERT_EQ(skel->bss->str_env0_ret, sizeof(env0), "str_env0_ret");
> +       ASSERT_EQ(skel->bss->str_env1_ret, sizeof(env1), "str_env1_ret");
> +       ASSERT_EQ(skel->bss->data_match, 1, "data_match");
> +       ASSERT_EQ(skel->bss->str_args_match, 1, "str_args_match");
> +       ASSERT_EQ(skel->bss->str_envs_match, 1, "str_envs_match");
> +
> +out:
> +       copy_from_user_bprm__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c b/to=
ols/testing/selftests/bpf/progs/copy_from_user_bprm.c
> new file mode 100644
> index 000000000000..07ca96d9db45
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <errno.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +static const char expected_data[] =3D "first\0second-argument\0"
> +                                   "SOME_ENV=3Da\0OTHER_ENV=3Dsomething"=
;
> +static const char expected_arg0[] =3D "first";
> +static const char expected_arg1[] =3D "second-argument";
> +static const char expected_env0[] =3D "SOME_ENV=3Da";
> +static const char expected_env1[] =3D "OTHER_ENV=3Dsomething";
> +
> +int monitored_pid;
> +int bprm_argc;
> +int bprm_envc;
> +int data_len_match;
> +int invalid_flags_ret;
> +int copy_ret;
> +int str_arg0_ret;
> +int str_arg1_ret;
> +int str_env0_ret;
> +int str_env1_ret;
> +int data_match;
> +int str_args_match;
> +int str_envs_match;
> +
> +extern bool CONFIG_MMU __kconfig __weak;
> +
> +extern int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
> +                                const void *unsafe_ptr__ign,
> +                                struct mm_struct *mm, u64 flags) __ksym;
> +
> +extern int bpf_copy_from_user_mm_str(void *dst, u32 dst__sz,
> +                                    const void *unsafe_ptr__ign,
> +                                    struct mm_struct *mm, u64 flags) __k=
sym;
> +

these should be already coming from vmlinux.h, no need to explicitly
define them, please drop (and CONFIG_MMU parts as well)

> +SEC("lsm.s/bprm_check_security")
> +int BPF_PROG(check_exec_args, struct linux_binprm *bprm)
> +{
> +       u32 pid =3D bpf_get_current_pid_tgid() >> 32;
> +       char data[sizeof(expected_data)] =3D {};
> +       struct mm_struct *mm;
> +       char arg0[32] =3D {};
> +       char arg1[32] =3D {};
> +       char env0[32] =3D {};
> +       char env1[32] =3D {};
> +       u64 offset =3D 0;
> +       u64 data_len;
> +
> +       if (!CONFIG_MMU)
> +               return 0;
> +
> +       if (pid !=3D monitored_pid)
> +               return 0;
> +
> +       mm =3D bprm->mm;
> +       if (!mm)
> +               return 0;
> +
> +       bprm_argc =3D bprm->argc;
> +       bprm_envc =3D bprm->envc;
> +
> +       /* this is the total size of args and envs starting from bprm->p =
*/
> +       data_len =3D bprm->exec - bprm->p;
> +       data_len_match =3D data_len =3D=3D sizeof(expected_data);
> +
> +       invalid_flags_ret =3D bpf_copy_from_user_mm(data, sizeof(data),
> +                                                 (void *)bprm->p, mm, ~0=
ULL);
> +
> +       copy_ret =3D bpf_copy_from_user_mm(data, sizeof(data), (void *)bp=
rm->p,
> +                                        mm, 0);

single line (limit is 120, not 80), please reformat the rest if it
fits under 120

> +       if (copy_ret)
> +               return 0;
> +
> +       data_match =3D
> +               !__builtin_memcmp(data, expected_data, sizeof(expected_da=
ta));

nit: keep single line

> +
> +       /* arg0 is at bprm->p */
> +       str_arg0_ret =3D bpf_copy_from_user_mm_str(arg0, sizeof(arg0),
> +                                                (void *)(bprm->p + offse=
t),
> +                                                mm, BPF_F_PAD_ZEROS);
> +       if (str_arg0_ret !=3D sizeof(expected_arg0))
> +               return 0;
> +       offset +=3D str_arg0_ret;
> +
> +       /* arg1 is at bprm->p + sizeof(arg0) */
> +       str_arg1_ret =3D bpf_copy_from_user_mm_str(arg1, sizeof(arg1),
> +                                                (void *)(bprm->p + offse=
t),
> +                                                mm, BPF_F_PAD_ZEROS);
> +       if (str_arg1_ret !=3D sizeof(expected_arg1))
> +               return 0;
> +       offset +=3D str_arg1_ret;
> +
> +       /* env0 is at bprm->p + sizeof(arg0) + sizeof(arg1) */
> +       str_env0_ret =3D bpf_copy_from_user_mm_str(env0, sizeof(env0),
> +                                                (void *)(bprm->p + offse=
t),
> +                                                mm, BPF_F_PAD_ZEROS);
> +       if (str_env0_ret !=3D sizeof(expected_env0))
> +               return 0;
> +       offset +=3D str_env0_ret;
> +
> +       /* env1 is at bprm->p + sizeof(arg0) + sizeof(arg1) + sizeof(env0=
) */
> +       str_env1_ret =3D bpf_copy_from_user_mm_str(env1, sizeof(env1),
> +                                                (void *)(bprm->p + offse=
t),
> +                                                mm, BPF_F_PAD_ZEROS);
> +       if (str_env1_ret !=3D sizeof(expected_env1))
> +               return 0;
> +
> +       str_args_match =3D
> +               !__builtin_memcmp(arg0, expected_arg0, sizeof(expected_ar=
g0)) &&
> +               !__builtin_memcmp(arg1, expected_arg1, sizeof(expected_ar=
g1));
> +       str_envs_match =3D
> +               !__builtin_memcmp(env0, expected_env0, sizeof(expected_en=
v0)) &&
> +               !__builtin_memcmp(env1, expected_env1, sizeof(expected_en=
v1));

I'd put env1, env2, etc into global variables and do comparison in user spa=
ce

not that this is broken, but there is no point doing this in BPF code

> +
> +       return data_match && str_args_match && str_envs_match ? -EPERM : =
0;
> +}
> --
> 2.55.0
>
