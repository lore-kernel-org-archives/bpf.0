Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F01382F20
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118843; cv=pass; b=RJ128J9HaoTfqBs/llnpM+c5azpdSnYg1NuC82HQklXCTudCCBg7ZFVqb0VeFIZgvyD8t05bkMyHpIhkQd9zjQOzSkvyWmIQq4C7X9qTmMmv/7zloEX3nwQ2qDSUhbmQb5qqczU9ixpAovagiuNTwcN0sfqkrI+QkRisNbOS25o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118843; c=relaxed/simple;
	bh=L5sRhn39Gq/EuNejgwrQZjyUO/2vF2bKM1TN0xPKjqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0Biw1kOG1IrbM16OXxz991xgrAzXJLkY1SfMaaEKZ+cZLdRrBfKw6V8WCXD6FEIB7b/aLDOf//9UmAHB6aMv9hjIcQH9FLLLdBBiCYgxmH5kBTTG8ggAYEpGvk37OEXm3/nwKACUFVuv7WDRjsjE9ugnCGL7gX6gcmKcbghs2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7iVQ4YE; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7iVQ4YE"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4888375f735so48085255e9.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:20:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776118840; cv=none;
        d=google.com; s=arc-20240605;
        b=izYo0L+CYWZhfFtsKkz2TvA7sA9jjqx/IbY3yvKdgIgptJv+0rgC4BO4V/XpL6RCkr
         bageiziqRytpV2tFbRoqI7TkUHz7EhPyzQ74abnymeZ5Y898H75WHqpO611wMRWF4HNl
         rQIrxGvsGUeG7eQXdNEGFPg1TrgHcjaqDPiuH4tR86eOkz2wB/V0R3/cp5qqTgQUoU7F
         6Jt9F2uCAHV9GbAIGI3IaC7e4JVMJqfnYP/nwKoR/Uvkv9U9m3cT2nL/d+qLyRrHOKwn
         bnIKjqd75vdE+Txm2X5eu3Xk0JoeBHlRUrjmReL59HwDXoe+CGyIC5KASCa7Z+gp3tG3
         0kIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0GtrcgyRY8dcn3VLzUDN93WtruBuz/B9n6Ctjtr0M2A=;
        fh=9IAxlTrDUG5k6ijFEWlPR6HT7byqqLos4lRlPKyYIL0=;
        b=lRpkpokBUoCNba6QLBNS7viqoNtMCo3HST2xsmzqqG6MMCnt9o2PXCWGCvp3exDwFh
         yG8rJuYooq1waaM9DDlHm3//S0C/qsrgZKMciXBwt+FqjfJH5Zk/eeL+w8tL5A/N9ugr
         /K1okDPS303hqn1ML8bsW8C5QGv58av09N3bHozgiTcZE+8Qk7FCxuv44TnkA8VEaGoD
         SenGV/+taKCiket8gwEki1fl6u5yMcpxOQyIDvrOMokjwW/uo+f7w0NPh6fo0G3u+NqN
         3M8aJ01uLlbYYPSfLm93+ODa0Zunr3rxo0ENH+DisTNOu1L/ElsnsiBqeYKqHtgJdK1l
         vTog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776118840; x=1776723640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GtrcgyRY8dcn3VLzUDN93WtruBuz/B9n6Ctjtr0M2A=;
        b=U7iVQ4YEtR4ke+7DcubhsKKyixj5Dkr6VDXTe5lTATEJoAXxx4byxgT6fNj0UvfEDS
         QJtQJa5vN5GbWSh2wvFn1loSdTUrEONym6KQY6MihFnJO/JBwmIEpQHitpp3kesQ0+H6
         9gWWPkYn05gKKg6G9Qn0/0VlOMlDBIzxGaMz2t+GljMiQrJjRyOIgoHhFMDeuwhv8m0e
         1+k+Iu3o9jojTYDiBIMoeyEaUekiUMm2iBiqmPWavCKKl6OliSajZIIumF2kCRmaWY3U
         arnohCXvwaUrcvOJZTt5PiKPLP7XZQ4NILRf6MIT2hFl6XyNHwC1OEBuBqU8BY268JCO
         wd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776118840; x=1776723640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0GtrcgyRY8dcn3VLzUDN93WtruBuz/B9n6Ctjtr0M2A=;
        b=s1xbfVfoiv2LIpX9x5W4ZTiHetHEm7JOcL7fguXPUlAKSkFfZ4pokXhcGHqaZU19dF
         VqNRDLfZ6Ezo9FpTWe4zUR/1wBY3dCNz/ODlcl6TNGAa+cU4SmKECtGWFj7AquwkKScp
         6PK+ENxSn4jB5XjJHJtIyq8W7GahcaI+ITImgF9SV4RgB7ZIFPmXT+3/HarU7r7CD0FT
         /KKj3IE91BdN741j/7ITBc0Oc4bwVPuvpuMssqI9lA27usiPx3KSjASXzRV5KY2gR9Y8
         /w8+9PUEExAHom/xvtqoNat8x+t4CHAFLebXxkknUslc5KjLkhyV+yt4A3/ktHKvRI64
         remg==
X-Forwarded-Encrypted: i=1; AFNElJ9feEbo6T3I2OBvODnlwYI5T5umFrjtMFy30qESkY8rXNHkiY8D8vRsE7k50wQQN0EQcGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzlEz3QScsVRy2F9rIqzvZpa38sSJv4UxOMQQtF3UO3mKW8wIJ
	sZ2pCVJZRAinxfSJfn55skGhj1W5T6rixkBADNBGyJWFN2S0LZc7nlU5Un2CUEX3fA4hH1CGoNh
	ZJehZB35N2DM+CJJnyvyZe3VA4UvncIk=
X-Gm-Gg: AeBDiesyEluht31FVcSRvzsd65SEQEFUruIE5Wtqo2qOb8ZKfswNq+AC7pAcyMB9OKb
	QX0yHjZn3f+WTNPEq3S06w8fAftbndFtJoY/bTHaUh8TZH9CN4AZAJk2L2YEQYfgwR+/SBuybqx
	Us1hDEHNIxriZgJh7t53RIHnIabX+Qa+0c8QQPA/pjqBU2IZyfeDjbII5CILub/AEUvESm1MCQo
	Dbfmh0iCWAoRje4NWeI7+FHmT0++kY7HBeFGoMlrEUDwt126uEYE7dTfV2r9WJGAUhQ7XGdzSjj
	oIWhpBQXt0dAwLUjyxQ0O9kvMDkb/7VEpKZXkehC
X-Received: by 2002:a05:6000:220b:b0:43c:fdd:ea96 with SMTP id
 ffacd0b85a97d-43d642b6e75mr20785387f8f.26.1776118839833; Mon, 13 Apr 2026
 15:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-8-1a5831230821@bootlin.com>
In-Reply-To: <20260413-kasan-v1-8-1a5831230821@bootlin.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 14 Apr 2026 00:20:28 +0200
X-Gm-Features: AQROBzC46tJ1Vulp-Ruy1LR_qNHLJczc_Mec_FX1XvbzAbvB4RmfM9pOdtpD_VM
Message-ID: <CA+fCnZekgcEgsZnRrOB=+HoG=neRg=oLTt2jStyrPJ6mYf2ctQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 8/8] selftests/bpf: add tests to validate
 KASAN on JIT programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundatio=
n)
<alexis.lothore@bootlin.com> wrote:
>
> Add a basic KASAN test runner that loads and test-run programs that can
> trigger memory management bugs. The test captures kernel logs and ensure
> that the expected KASAN splat is emitted by searching for the
> corresponding first lines in the report.
>
> This version implements two faulty programs triggering either a
> user-after-free, or an out-of-bounds memory usage. The bugs are
> triggered thanks to some dedicated kfuncs in bpf_testmod.c, but two
> different techniques are used, as some cases can be quite hard to
> trigger in a pure "black box" approach:
> - for reads, we can make the used kfuncs return some faulty pointers
>   that ebpf programs will manipulate, they will generate legitimate
>   kasan reports as a consequence
> - applying the same trick for faulty writes is harder, as ebpf programs
>   can't write kernel data freely. So ebpf programs can call another
>   specific testing kfunc that will alter the shadow memory matching the
>   passed memory (eg: a map). When the program will try to write to the
>   corresponding memory, it will trigger a report as well.
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---
> The way of bringing kasan_poison into bpf_testmod is definitely not
> ideal.  But I would like to validate the testing approach (triggering
> real faulty accesses, which is hard on some cases, VS manually poisoning
> BPF-manipulated memory) before eventually making clean bridges between
> KASAN APIs and bpf_testmod.c, if the latter approach is the valid one.

Would it make sense to put these tests into KASAN KUnit tests in
mm/kasan/kasan_test_c.c? I assume there is a kernel API to JIT BPF
programs from the kernel itself?

There, you can just call kasan_poison(), some tests already do this.
And you can also extend the KASAN KUnit test framework to find out
whether the bad access is a read or write, if you want to check this.



> ---
>  tools/testing/selftests/bpf/prog_tests/kasan.c     | 165 +++++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/kasan.c          | 146 +++++++++++++++=
+++
>  .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  79 ++++++++++
>  3 files changed, 390 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testi=
ng/selftests/bpf/prog_tests/kasan.c
> new file mode 100644
> index 000000000000..fd628aaa8005
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kasan.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +#include <bpf/bpf.h>
> +#include <fcntl.h>
> +#include <linux/if_ether.h>
> +#include <sys/klog.h>
> +#include <test_progs.h>
> +#include <unpriv_helpers.h>
> +#include "kasan.skel.h"
> +
> +#define SUBTEST_NAME_MAX_LEN   64
> +#define SYSLOG_ACTION_READ_ALL 3
> +#define SYSLOG_ACTION_CLEAR    5
> +
> +#define MAX_LOG_SIZE           (8*1024)
> +#define READ_CHUNK_SIZE                128
> +
> +#define KASAN_PATTERN_SLAB_UAF "BUG: KASAN: slab-use-after-free in bpf_p=
rog_"
> +#define KASAN_PATTERN_GLOBAL_OOB "BUG: KASAN: global-out-of-bounds in bp=
f_prog_"
> +
> +static char klog_buffer[MAX_LOG_SIZE];
> +
> +static int read_kernel_logs(char *buf, size_t max_len)
> +{
> +       return klogctl(SYSLOG_ACTION_READ_ALL, buf, max_len);
> +}
> +
> +static int clear_kernel_logs(void)
> +{
> +       return klogctl(SYSLOG_ACTION_CLEAR, NULL, 0);
> +}
> +
> +static int kernel_logs_have_matching_kasan_report(char *buf, char *patte=
rn,
> +                                                 bool is_write, int size=
)
> +{
> +       char *access_desc_start, *access_desc_end, *tmp;
> +       char access_log[READ_CHUNK_SIZE];
> +       char *kasan_report_start;
> +       int hsize, nsize;
> +       /* Searched kasan report is valid if
> +        * - it contains the expected kasan pattern
> +        * - the next line is the description of the faulty access
> +        * - faulty access properties match the tested type and size
> +        */
> +       kasan_report_start =3D strstr(buf, pattern);
> +
> +       if (!kasan_report_start)
> +               return 1;
> +
> +       /* Find next line */
> +       access_desc_start =3D strchr(kasan_report_start, '\n');
> +       if (!access_desc_start)
> +               return 1;
> +       access_desc_start++;
> +
> +       access_desc_end =3D strchr(access_desc_start, '\n');
> +       if (!access_desc_end)
> +               return 1;
> +
> +       nsize =3D snprintf(access_log, READ_CHUNK_SIZE, "%s of size %d at=
 addr",
> +                is_write ? "Write" : "Read", size);
> +
> +       hsize =3D access_desc_end - access_desc_start;
> +       tmp =3D memmem(access_desc_start, hsize, access_log, nsize);
> +
> +       if (!tmp)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +struct test_spec {
> +       char *prog_name;
> +       char *expected_report_pattern;
> +};
> +
> +static struct test_spec tests[] =3D {
> +       {
> +               .prog_name =3D "bpf_kasan_uaf",
> +               .expected_report_pattern =3D KASAN_PATTERN_SLAB_UAF
> +       },
> +       {
> +               .prog_name =3D "bpf_kasan_oob",
> +               .expected_report_pattern =3D KASAN_PATTERN_GLOBAL_OOB
> +       }
> +};
> +
> +static void run_test_with_type_and_size(struct kasan *skel,
> +                                       struct test_spec *test, bool is_w=
rite,
> +                                       int access_size)
> +{
> +       char subtest_name[SUBTEST_NAME_MAX_LEN];
> +       struct bpf_program *prog;
> +       uint8_t buf[ETH_HLEN];
> +       int ret;
> +
> +       prog =3D bpf_object__find_program_by_name(skel->obj, test->prog_n=
ame);
> +       if (!ASSERT_OK_PTR(prog, "find test prog"))
> +               return;
> +
> +       snprintf(subtest_name, SUBTEST_NAME_MAX_LEN, "%s_%s_%d",
> +                test->prog_name, is_write ? "write" : "read", access_siz=
e);
> +
> +       if (!test__start_subtest(subtest_name))
> +               return;
> +
> +       ret =3D clear_kernel_logs();
> +       if (!ASSERT_OK(ret, "reset log buffer"))
> +               return;
> +
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +       topts.sz =3D sizeof(struct bpf_test_run_opts);
> +       topts.data_size_in =3D ETH_HLEN;
> +       topts.data_in =3D buf;
> +       skel->bss->is_write =3D is_write;
> +       skel->bss->access_size =3D access_size;
> +       ret =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
> +       if (!ASSERT_OK(ret, "run prog"))
> +               return;
> +
> +       ret =3D read_kernel_logs(klog_buffer, MAX_LOG_SIZE);
> +       if (ASSERT_GE(ret, 0, "read kernel logs"))
> +               ASSERT_OK(kernel_logs_have_matching_kasan_report(
> +                                 klog_buffer, test->expected_report_patt=
ern,
> +                                 is_write, access_size),
> +                         test->prog_name);
> +}
> +
> +static void run_test_with_type(struct kasan *skel, struct test_spec *tes=
t,
> +                              bool is_write)
> +{
> +       run_test_with_type_and_size(skel, test, is_write, 1);
> +       run_test_with_type_and_size(skel, test, is_write, 2);
> +       run_test_with_type_and_size(skel, test, is_write, 4);
> +       run_test_with_type_and_size(skel, test, is_write, 8);
> +}
> +
> +static void run_test(struct kasan *skel, struct test_spec *test)
> +{
> +       run_test_with_type(skel, test, false);
> +       run_test_with_type(skel, test, true);
> +}
> +
> +void test_kasan(void)
> +{
> +       struct test_spec *test;
> +       struct kasan *skel;
> +       int i;
> +
> +       if (!is_jit_enabled() || !get_kasan_jit_enabled()) {
> +               test__skip();
> +               return;
> +       }
> +
> +       skel =3D kasan__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "open and load prog"))
> +               return;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
> +               test =3D &tests[i];
> +
> +               run_test(skel, test);
> +       }
> +
> +       kasan__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/kasan.c b/tools/testing/se=
lftests/bpf/progs/kasan.c
> new file mode 100644
> index 000000000000..f713c9b7c9ce
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kasan.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#define KASAN_SLAB_FREE 0xFB
> +#define KASAN_GLOBAL_REDZONE 0xF9
> +
> +extern __u8 *bpf_kfunc_kasan_uaf_1(void) __ksym;
> +extern __u16 *bpf_kfunc_kasan_uaf_2(void) __ksym;
> +extern __u32 *bpf_kfunc_kasan_uaf_4(void) __ksym;
> +extern __u64 *bpf_kfunc_kasan_uaf_8(void) __ksym;
> +extern __u8 *bpf_kfunc_kasan_oob_1(void) __ksym;
> +extern __u16 *bpf_kfunc_kasan_oob_2(void) __ksym;
> +extern __u32 *bpf_kfunc_kasan_oob_4(void) __ksym;
> +extern __u64 *bpf_kfunc_kasan_oob_8(void) __ksym;
> +extern void bpf_kfunc_kasan_poison(void *mem, __u32 mem__sz, __u8 byte) =
__ksym;
> +
> +int access_size;
> +int is_write;
> +
> +struct kasan_write_val {
> +       __u8 data_1;
> +       __u16 data_2;
> +       __u32 data_4;
> +       __u64 data_8;
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, __u32);
> +       __type(value, struct kasan_write_val);
> +} test_map SEC(".maps");
> +
> +static void bpf_kasan_faulty_write(int size, __u8 poison_byte)
> +{
> +       struct kasan_write_val *val;
> +       __u32 key =3D 0;
> +
> +       val =3D bpf_map_lookup_elem(&test_map, &key);
> +       if (!val)
> +               return;
> +
> +       bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val),
> +                              poison_byte);
> +       switch (size) {
> +       case 1:
> +               val->data_1 =3D 0xAA;
> +               break;
> +       case 2:
> +               val->data_2 =3D 0xAA;
> +               break;
> +       case 4:
> +               val->data_4 =3D 0xAA;
> +               break;
> +       case 8:
> +               val->data_8 =3D 0xAA;
> +               break;
> +       }
> +       bpf_kfunc_kasan_poison(val, sizeof(struct kasan_write_val), 0x00)=
;
> +}
> +
> +
> +static int bpf_kasan_uaf_read(int size)
> +{
> +       __u8 *result_1;
> +       __u16 *result_2;
> +       __u32 *result_4;
> +       __u64 *result_8;
> +       int ret =3D 0;
> +
> +       switch (size) {
> +       case 1:
> +               result_1 =3D bpf_kfunc_kasan_uaf_1();
> +               ret =3D result_1[0] ? 1 : 0;
> +               break;
> +       case 2:
> +               result_2 =3D bpf_kfunc_kasan_uaf_2();
> +               ret =3D result_2[0] ? 1 : 0;
> +               break;
> +       case 4:
> +               result_4 =3D bpf_kfunc_kasan_uaf_4();
> +               ret =3D result_4[0] ? 1 : 0;
> +               break;
> +       case 8:
> +               result_8 =3D bpf_kfunc_kasan_uaf_8();
> +               ret =3D result_8[0] ? 1 : 0;
> +               break;
> +       }
> +       return ret;
> +}
> +
> +SEC("tcx/ingress")
> +int bpf_kasan_uaf(struct __sk_buff *skb)
> +{
> +       if (is_write) {
> +               bpf_kasan_faulty_write(access_size, KASAN_SLAB_FREE);
> +               return 0;
> +       }
> +
> +       return bpf_kasan_uaf_read(access_size);
> +}
> +
> +static int bpf_kasan_oob_read(int size)
> +{
> +       __u8 *result_1;
> +       __u16 *result_2;
> +       __u32 *result_4;
> +       __u64 *result_8;
> +       int ret =3D 0;
> +
> +       switch (size) {
> +       case 1:
> +               result_1 =3D bpf_kfunc_kasan_oob_1();
> +               ret =3D result_1[0] ? 1 : 0;
> +               break;
> +       case 2:
> +               result_2 =3D bpf_kfunc_kasan_oob_2();
> +               ret =3D result_2[0] ? 1 : 0;
> +               break;
> +       case 4:
> +               result_4 =3D bpf_kfunc_kasan_oob_4();
> +               ret =3D result_4[0] ? 1 : 0;
> +               break;
> +       case 8:
> +               result_8 =3D bpf_kfunc_kasan_oob_8();
> +               ret =3D result_8[0] ? 1 : 0;
> +               break;
> +       }
> +       return ret;
> +}
> +
> +SEC("tcx/ingress")
> +int bpf_kasan_oob(struct __sk_buff *skb)
> +{
> +       if (is_write) {
> +               bpf_kasan_faulty_write(access_size, KASAN_GLOBAL_REDZONE)=
;
> +               return 0;
> +       }
> +
> +       return bpf_kasan_oob_read(access_size);
> +}
> +
> +char LICENSE[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index d876314a4d67..01554bcbbbb0 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -271,6 +271,76 @@ __bpf_kfunc void bpf_kfunc_put_default_trusted_ptr_t=
est(struct prog_test_member
>          */
>  }
>
> +static void *kasan_uaf(void)
> +{
> +       void *p =3D kmalloc(64, GFP_ATOMIC);
> +
> +       if (!p)
> +               return NULL;
> +       memset(p, 0xAA, 64);
> +       kfree(p);
> +
> +       return p;
> +}
> +
> +#ifdef CONFIG_KASAN_GENERIC
> +extern void kasan_poison(const void *addr, size_t size, u8 value, bool i=
nit);
> +
> +__bpf_kfunc void bpf_kfunc_kasan_poison(void *mem, u32 mem__sz, u8 byte)
> +{
> +       kasan_poison(mem, mem__sz, byte, false);
> +}
> +#else
> +__bpf_kfunc void bpf_kfunc_kasan_poison(void *mem, u32 mem__sz, u8 byte)=
 { }
> +#endif
> +
> +__bpf_kfunc u8 *bpf_kfunc_kasan_uaf_1(void)
> +{
> +       return kasan_uaf();
> +}
> +
> +__bpf_kfunc u16 *bpf_kfunc_kasan_uaf_2(void)
> +{
> +       return kasan_uaf();
> +}
> +
> +__bpf_kfunc u32 *bpf_kfunc_kasan_uaf_4(void)
> +{
> +       return kasan_uaf();
> +}
> +
> +__bpf_kfunc u64 *bpf_kfunc_kasan_uaf_8(void)
> +{
> +       return kasan_uaf();
> +}
> +
> +static u8 test_oob_buffer[64];
> +
> +static void *bpf_kfunc_kasan_oob(void)
> +{
> +       return test_oob_buffer+64;
> +}
> +
> +__bpf_kfunc u8 *bpf_kfunc_kasan_oob_1(void)
> +{
> +       return bpf_kfunc_kasan_oob();
> +}
> +
> +__bpf_kfunc u16 *bpf_kfunc_kasan_oob_2(void)
> +{
> +       return bpf_kfunc_kasan_oob();
> +}
> +
> +__bpf_kfunc u32 *bpf_kfunc_kasan_oob_4(void)
> +{
> +       return bpf_kfunc_kasan_oob();
> +}
> +
> +__bpf_kfunc u64 *bpf_kfunc_kasan_oob_8(void)
> +{
> +       return bpf_kfunc_kasan_oob();
> +}
> +
>  __bpf_kfunc struct bpf_testmod_ctx *
>  bpf_testmod_ctx_create(int *err)
>  {
> @@ -740,6 +810,15 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
>  BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
>  BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
>  BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_poison)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_uaf_1)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_uaf_2)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_uaf_4)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_uaf_8)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_oob_1)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_oob_2)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_oob_4)
> +BTF_ID_FLAGS(func, bpf_kfunc_kasan_oob_8)
>  BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
>
>  BTF_ID_LIST(bpf_testmod_dtor_ids)
>
> --
> 2.53.0
>
