Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262E829A9
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065331; cv=none; b=DRwb6g7x4mAZkoxtxVTlKRQV25vy9jiPlmuNeoGqtf6JH3KR7TIqYWLDFHy45pKAzdWSI0Jwkn9X15IJdxNoPccNZT0MuO6c6XjC0ndZG4OMi9Vf4sAZPgrCSh7APXuWqu6qmw95WlSmjCI2q3aB61eyEWBuPh50JP2+ssEU+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065331; c=relaxed/simple;
	bh=q1rNk2Qypc/tfTit3gkomx9rPonl4bOn8DoV8nz8gsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayWT+gPlD2caQyekfk5xlFFQG7yWFgtHgnCToRcnbavEPwjgBYElvSyrgk2flxwzWNbVdofxd0BXVpFEvKGM4n6ErfG7nQLJEwNQHaOyfb9NloXM1EA7LpgsYmERv3498/FoTRGK6kuMmt3ll2U6D/B3jvkXevWrRtBZk81vCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BXwRAbNg; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BXwRAbNg"
Message-ID: <559d9eb6-9832-4947-8d32-9be84c217659@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711065326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=749SQ/wnTfMf4auwGMHH8WqBo4tkmhz/GW5a4J5HslU=;
	b=BXwRAbNgIGI0X/t8M1I1pnDTw7i2B+F3KR3rQl+NN2nx7JDbhjTLp/gSRngoXdiMQpmLI+
	6D9xULm6xnVWhbKeDJjrnw9bFjs/KAjnY8r3cCiLb6NHzTniDr3mPdaGgY/86Rn9awyzz/
	LCLrNxt4a/NRmo9jF71iRqRk4hkeMvQ=
Date: Thu, 21 Mar 2024 16:55:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/5] libbpf: Handle <orig_name>.llvm.<hash>
 symbol properly
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200114.2219721-1-yonghong.song@linux.dev>
 <CAADnVQL3yAnS4+A59OBmpbhEhQx7Was-EnTcLW9k4ddnXQi31w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL3yAnS4+A59OBmpbhEhQx7Was-EnTcLW9k4ddnXQi31w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/21/24 2:54 PM, Alexei Starovoitov wrote:
> On Thu, Mar 21, 2024 at 1:01 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With CONFIG_LTO_CLANG_THIN enabled, with some of previous
>> version of kernel code base ([1]), I hit the following
>> error:
>>     test_ksyms:PASS:kallsyms_fopen 0 nsec
>>     test_ksyms:FAIL:ksym_find symbol 'bpf_link_fops' not found
>>     #118     ksyms:FAIL
>>
>> The reason is that 'bpf_link_fops' is renamed to
>>     bpf_link_fops.llvm.8325593422554671469
>> Due to cross-file inlining, the static variable 'bpf_link_fops'
>> in syscall.c is used by a function in another file. To avoid
>> potential duplicated names, the llvm added suffix
>> '.llvm.<hash>' ([2]) to 'bpf_link_fops' variable.
>> Such renaming caused a problem in libbpf if 'bpf_link_fops'
>> is used in bpf prog as a ksym as 'bpf_link_fops' does not
>> match any symbol in /proc/kallsyms.
>>
>> To fix this issue, libbpf needs to understand that suffix '.llvm.<hash>'
>> is caused by clang lto kernel and to process such symbols properly.
>>
>> With latest bpf-next code base built with CONFIG_LTO_CLANG_THIN,
>> I cannot reproduce the above failure any more. But such an issue
>> could happen with other symbols.
>>
>> For example, with my current kernel, I got the following from
>> /proc/kallsyms:
>>    ffffffff84782154 d __func__.net_ratelimit.llvm.6135436931166841955
>>    ffffffff85f0a500 d tk_core.llvm.726630847145216431
>>    ffffffff85fdb960 d __fs_reclaim_map.llvm.10487989720912350772
>>    ffffffff864c7300 d fake_dst_ops.llvm.54750082607048300
>>
>> I could not easily create a selftest to test newly-added
>> libbpf functionality with a static C test since I do not know
>> which symbol is cross-file inlined. But based on my particular kernel,
>> the following test change can run successfully.
>>
>>    diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
>>    index 6a86d1f07800..904a103f7b1d 100644
>>    --- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
>>    +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
>>    @@ -42,6 +42,7 @@ void test_ksyms(void)
>>            ASSERT_EQ(data->out__bpf_link_fops, link_fops_addr, "bpf_link_fops");
>>            ASSERT_EQ(data->out__bpf_link_fops1, 0, "bpf_link_fops1");
>>            ASSERT_EQ(data->out__btf_size, btf_size, "btf_size");
>>    +       ASSERT_NEQ(data->out__fake_dst_ops, 0, "fake_dst_ops");
>>            ASSERT_EQ(data->out__per_cpu_start, per_cpu_start_addr, "__per_cpu_start");
>>
>>     cleanup:
>>    diff --git a/tools/testing/selftests/bpf/progs/test_ksyms.c b/tools/testing/selftests/bpf/progs/test_ksyms.c
>>    index 6c9cbb5a3bdf..fe91eef54b66 100644
>>    --- a/tools/testing/selftests/bpf/progs/test_ksyms.c
>>    +++ b/tools/testing/selftests/bpf/progs/test_ksyms.c
>>    @@ -9,11 +9,13 @@ __u64 out__bpf_link_fops = -1;
>>     __u64 out__bpf_link_fops1 = -1;
>>     __u64 out__btf_size = -1;
>>     __u64 out__per_cpu_start = -1;
>>    +__u64 out__fake_dst_ops = -1;
>>
>>     extern const void bpf_link_fops __ksym;
>>     extern const void __start_BTF __ksym;
>>     extern const void __stop_BTF __ksym;
>>     extern const void __per_cpu_start __ksym;
>>    +extern const void fake_dst_ops __ksym;
>>     /* non-existing symbol, weak, default to zero */
>>     extern const void bpf_link_fops1 __ksym __weak;
>>
>>    @@ -23,6 +25,7 @@ int handler(const void *ctx)
>>            out__bpf_link_fops = (__u64)&bpf_link_fops;
>>            out__btf_size = (__u64)(&__stop_BTF - &__start_BTF);
>>            out__per_cpu_start = (__u64)&__per_cpu_start;
>>    +       out__fake_dst_ops = (__u64)&fake_dst_ops;
>>
>>            out__bpf_link_fops1 = (__u64)&bpf_link_fops1;
>>
>> This patch fixed the issue in libbpf such that if clang lto kernel
>> is enabled and the symbol resolution is for ksym's,
>> the suffix '.llvm.<hash>' will be ignored during comparison of
>> bpf prog ksym vs. symbols in /proc/kallsyms, this resolved the issue.
>>
>> Note that currently kernel does not support gcc build with lto.
>>
>>    [1] https://lore.kernel.org/bpf/20240302165017.1627295-1-yonghong.song@linux.dev/
>>    [2] https://github.com/llvm/llvm-project/blob/release/18.x/llvm/include/llvm/IR/ModuleSummaryIndex.h#L1714-L1719
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.c | 64 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index a7a89269148c..8c3861192bc8 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -664,6 +664,7 @@ struct bpf_object {
>>          bool loaded;
>>          bool has_subcalls;
>>          bool has_rodata;
>> +       bool need_kallsyms;
>>
>>          struct bpf_gen *gen_loader;
>>
>> @@ -8016,14 +8017,73 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
>>          return err;
>>   }
>>
>> +static int check_lto_kernel(void)
>> +{
>> +       static int check_lto = 2;
>> +       char buf[PATH_MAX];
>> +       struct utsname uts;
>> +       gzFile file;
>> +       int len;
>> +
>> +       if (check_lto != 2)
>> +               return check_lto;
>> +
>> +       uname(&uts);
>> +       len = snprintf(buf, PATH_MAX, "/boot/config-%s", uts.release);
>> +       if (len < 0) {
>> +               check_lto = -EINVAL;
>> +               goto out;
>> +       } else if (len >= PATH_MAX) {
>> +               check_lto = -ENAMETOOLONG;
>> +               goto out;
>> +       }
>> +
>> +       /* gzopen also accepts uncompressed files. */
>> +       file = gzopen(buf, "re");
>> +       if (!file)
>> +               file = gzopen("/proc/config.gz", "re");
>> +
>> +       if (!file) {
>> +               check_lto = -ENOENT;
>> +               goto out;
>> +       }
>> +
>> +       check_lto = 0;
>> +       while (gzgets(file, buf, sizeof(buf))) {
>> +               /* buf also contains '\n', skip it during comparison. */
>> +               if (!strncmp(buf, "CONFIG_LTO_CLANG=y", 18)) {
>> +                       check_lto = 1;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       gzclose(file);
>> +out:
>> +       return check_lto;
>> +}
>> +
>>   static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
>>                         const char *sym_name, void *ctx)
>>   {
>> +       int lto_enabled = check_lto_kernel();
>> +       char orig_name[PATH_MAX], *res;
>>          struct bpf_object *obj = ctx;
>>          const struct btf_type *t;
>>          struct extern_desc *ext;
>>
>> -       ext = find_extern_by_name(obj, sym_name);
>> +       /* Only check static variables in data sections */
>> +       if (sym_type == 'd' && obj->need_kallsyms && lto_enabled == 1) {
> why bother grepping config.gz ?
> I see no harm in doing below strstr unconditionally.

Do you mean we skip condition
	sym_type == 'd' && obj->need_kallsyms && lto_enabled == 1
all together?

For condition sym_type == 'd', Andrii suggested (in private discussion)
to focus on data first since that is the issue we hitted. Of course
we could do all symbols here too.

For condition obj->need_kallsyms, I can remove this one.

For lto_enabled == 1, the main goal is to avoid extra overhead for
not-lto kernels.

I guess that the overhead is not that bad since typically symbol name
is not long. So removing all conditions seems indeed a viable solution.

>
>> +               strcpy(orig_name, sym_name);
>> +               res = strstr(orig_name, ".llvm.");
>> +               if (res) {
>> +                       *res = '\0';
>> +                       pr_debug("extern (ksym) '%s': use original name '%s' for comparison\n",
>> +                                sym_name, orig_name);
>> +               }
>> +               ext = find_extern_by_name(obj, orig_name);
>> +       } else {
>> +               ext = find_extern_by_name(obj, sym_name);
>> +       }
>>          if (!ext || ext->type != EXT_KSYM)
>>                  return 0;
>>
>> @@ -8322,7 +8382,9 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
>>                          return -EINVAL;
>>          }
>>          if (need_kallsyms) {
>> +               obj->need_kallsyms = true;
>>                  err = bpf_object__read_kallsyms_file(obj);
>> +               obj->need_kallsyms = false;
>>                  if (err)
>>                          return -EINVAL;
>>          }
>> --
>> 2.43.0
>>
