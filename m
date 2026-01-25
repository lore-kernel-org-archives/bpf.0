Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A51DE2B4
	for <bpf@vger.kernel.org>; Sun, 25 Jan 2026 03:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769312255; cv=pass; b=WkT0KvwZyxFVbSF1EH94tnJjVwzFpq0RPLTysm6qxTFIIEtTXytpxXX8ovHMTrbqxwLcu604TGJ7Nsj9DPNuSIF0eXyBuI72iyuDkyBNSUCKrQycldfD/OR5G5dn+LEaquzvB1+LX3KRfYch2k3xUN+wShT8OWYP5RcaFruYqIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769312255; c=relaxed/simple;
	bh=KHHLDqior8B1P737y/3GiXhhM05h77Asbm7hlK7XFjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwvydNyeBbVCf8xeYAhU4D1XSFQH5nwpKEKdFZfnsI7jaxS1E6Klrc8rv7dkNMBCoM/kx5gsblywkg5P+GmHgCZUEjRtGL7DD5s2g7xUza+I83ZbScPS3IXdZNkNKiUjgPSL8frOlMoi12yod3YlRg73WJXy5ymvRiUgm2in/bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIVmaTSw; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIVmaTSw"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so28205095e9.0
        for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 19:37:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769312251; cv=none;
        d=google.com; s=arc-20240605;
        b=XuII64Znbj9yEUL319g9uK6CRu/y6EduZ3h6Ca9fNpTVZyOprMK1FcolNhK2G+APy0
         z0C173ToXB9dXCpikXuZ/NuRVWdcJwqgj94oRYAb1qg6sR4HTynI9ETJgj5TN1/QFZE3
         +9yIwSG9pN7rzkkn9nUEwFAhgSfwers9UeHIjfpuT2V3b+KO+k9y7o5L1C8sfgKM+0tA
         Xlv0qkfnqdgulxlWvRhkkWHFMIvg8VG4p/3RMwXoweKuON8Ot0DxDkq+pLDEnEPGJ96i
         APB8zLMFyxTtA4HhgHWtBo3HbNSflxPgAyAJTrVj/H6+tl14Jn2tTdW5+oBcutL+Le1I
         PeeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fPmCud2y+M6bkRgBEaGbRSzSQM5OP3Xz+/rlIQC+PcY=;
        fh=8V3yehj6+pULL9JHJd9RQ54eyXrSc5XEsP5FXIrqVdI=;
        b=biAlJSY8+gYEw1lMCuxNSVDCZShNekFVaYvGDYylmNEE/yuxHZNcSoExzgeHJ9eZGE
         2l2QA1RDqaxXeuXfwkwZOvVl94wUlQYxIveiNNa9VB0xIr6IOH2QF8LGAjd34Yjn0kMd
         SlZAkgxC8ihoV5E47qMk/hx5FnwCbo5p9WgrguNvIWuOnz3IflYuz1DAb9vyTigdpSJc
         xvRLekfmVzap8w/xyMNANU6TeGP7GTM64kwJwWj2P9QDGfANr4P9AYgq7Uv8kkMJ8YGr
         9rnaAsUSF5y7KfVhlbJxMXNrm+pditN0haRV3SF/yUE5fxtl8jJaFdJey92Z5+7rNH6V
         rXYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769312251; x=1769917051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPmCud2y+M6bkRgBEaGbRSzSQM5OP3Xz+/rlIQC+PcY=;
        b=KIVmaTSwi89Z5icph7ynQ1D5fE5N2QNKRU3sbwn93YUdSE1tsl8upkuqV40yt+X4Ab
         hTPzGKZ81R+zmqRnOsEdNZLGwoctddvj7UxJmNQpuE9ZHf6Zse6YpOUBe1nCxqlhtf+D
         htuJSBboaDBKQ/61S75Nz8aPN7PZME/OFDgqbAm2TsQg6Le9bi5N+NfHwG0wRBMixJDy
         OJlJmxOmjbyNntL8lM4SCpklG/LTdr+iZk0k3tjCa7+yDjyK0Ii9V/NqIkTZm3jXVy9f
         n562eaFcPMifGxhvUwBAkIpuvthl41dWch82pvOnYqPKx+pU1mXHE/Csj41JGGICnTTX
         uGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769312251; x=1769917051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fPmCud2y+M6bkRgBEaGbRSzSQM5OP3Xz+/rlIQC+PcY=;
        b=NiEjVduPUmRrSZpjDL46hIHuctM89vx+RTmqimSxnFKb/A60WrKFCuCrCYgN9wUdPf
         nzKaCzeN7pMnU1osHSMg6kZA++av915/OtGcdFG9f0PfCUDt4ZrIjHT+DA+mER/OHxTT
         OAJoFRjh6r/hH00bmXZgYNHzJwJ2ktMLi4OLbpeWbEkcaVueu4ik+pWw1i0Z/KMIONU5
         2r1tZE0oNbLGxPXH3vQuIb6Sq0fUi9m4rjk+pSQpwwK/u2FLJ7Jata+5nlq7WZxFVs6x
         BKOxQQEAcMlH4Inwt4czp931hCYM2L0v7/7Do4lrHWI1jPcSq+lqIIueNWYHelCLyW0L
         7FiA==
X-Forwarded-Encrypted: i=1; AJvYcCXv6Q1bdWxUVshfhm7Q1fWUIfnu/3tYTgZ2f/SyrLZhEXaKmno/lAP20c+drfXQlXor+0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6fmu6/NPWr2Fowe82i9RAE40WQIBbVm8rdhI3hjkq/HPJ3xcZ
	n32Cuqv14At84jlezNmlaIVteTLQQxk2UsYCoTJvc6KicsbOnKLz1Zl0oELwBaV5HeAcQb64Fr/
	oOgFY+fVAht4SSjVb13YM3QZxQIQMRqs=
X-Gm-Gg: AZuq6aJUybGwE38Djey4y9wNJ5UvWQDWJDQoD/x15h5fDnPkFqBK67z6pbcs1m9u2fb
	XpOkDsjjOqAXSzRJmP6yPNT6N43WGa6DFVdcUiyfYRV7pMlGIrvh09I/DxmvCP/0bjf2iJy0g40
	2AKOqVkoEk9gyTw7i3NPFlUussiwufwPzhF2NsmxIISl67fipdxLvTutl0acXp69yCjFu1gcfDL
	WdKEZYlR7nLsqoqRXfhPFuwVYAZt4/tc799grYrQ5AddNt7Mv4UWz3masW4z9H/8DKEOS7djCFf
	tbLyq4Z2a8w9Hgyd/TDTHOm7gCX4Vash2VeG2+bKqTPl+Y0o5KhYyUbrnE4mDkDwl2E4uGmBNLA
	22G86lxj4GfGu4gCyhdE58Obx
X-Received: by 2002:a05:600c:4e0a:b0:480:1c1c:47d6 with SMTP id
 5b1f17b1804b1-4805cd209b4mr8106025e9.6.1769312251203; Sat, 24 Jan 2026
 19:37:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124132706.183681-1-changwoo@igalia.com> <20260124132706.183681-3-changwoo@igalia.com>
In-Reply-To: <20260124132706.183681-3-changwoo@igalia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 24 Jan 2026 19:37:20 -0800
X-Gm-Features: AZwV_Qj31pcX5ZPXwbOsYn_O2QL4zbHL9yGaFvSAbSLaqW3XuIfAe1fsD78xc_g
Message-ID: <CAADnVQLS4n+Mnti34aaN9_k08WLV0fj_2AM61x-oApFKwKGihQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for execution
 context helpers
To: Changwoo Min <changwoo@igalia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-dev@igalia.com, 
	bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 5:27=E2=80=AFAM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> Add a new selftest suite `exe_ctx` to verify the accuracy of the
> bpf_in_task(), bpf_in_hardirq(), and bpf_in_serving_softirq() helpers
> introduced in bpf_experimental.h.
>
> Testing these execution contexts deterministically requires crossing
> context boundaries within a single CPU. To achieve this, the test
> implements a "Trigger-Observer" pattern using bpf_testmod:
>
> 1. Trigger: A BPF syscall program calls a new bpf_testmod kfunc
>    bpf_kfunc_trigger_ctx_check().
> 2. Task to HardIRQ: The kfunc uses irq_work_queue() to trigger a
>    self-IPI on the local CPU.
> 3. HardIRQ to SoftIRQ: The irq_work handler calls a dummy function
>    (observed by BPF fentry) and then schedules a tasklet to
>    transition into SoftIRQ context.
>
> The user-space runner ensures determinism by pinning itself to CPU 0
> before execution, forcing the entire interrupt chain to remain on a
> single core. Dummy noinline functions with compiler barriers are
> added to bpf_testmod.c to serve as stable attachment points for
> fentry programs. A retry loop is used in user-space to wait for the
> asynchronous SoftIRQ to complete.
>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

...

> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_experimental.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +extern void bpf_kfunc_trigger_ctx_check(void) __ksym;
> +
> +int count_hardirq;
> +int count_softirq;
> +int count_task;
> +
> +/* Triggered via bpf_prog_test_run from user-space */
> +SEC("syscall")
> +int trigger_all_contexts(void *ctx)
> +{
> +       if (bpf_in_task())
> +               __sync_fetch_and_add(&count_task, 1);
> +
> +       /* Trigger the firing of a hardirq and softirq for test. */
> +       bpf_kfunc_trigger_ctx_check();
> +       return 0;
> +}
> +
> +/* Observer for HardIRQ */
> +SEC("fentry/bpf_testmod_test_hardirq_fn")
> +int BPF_PROG(on_hardirq)
> +{
> +       if (bpf_in_hardirq())
> +               __sync_fetch_and_add(&count_hardirq, 1);
> +       return 0;
> +}
> +
> +/* Observer for SoftIRQ */
> +SEC("fentry/bpf_testmod_test_softirq_fn")
> +int BPF_PROG(on_softirq)
> +{
> +       if (bpf_in_serving_softirq())
> +               __sync_fetch_and_add(&count_softirq, 1);
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index d425034b72d3..1b04022859b7 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1164,6 +1164,33 @@ __bpf_kfunc int bpf_kfunc_implicit_arg(int a, stru=
ct bpf_prog_aux *aux);
>  __bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_p=
rog_aux *aux);
>  __bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct =
bpf_prog_aux *aux);
>
> +/* hook targets */
> +noinline void bpf_testmod_test_hardirq_fn(void) { barrier(); }
> +noinline void bpf_testmod_test_softirq_fn(void) { barrier(); }
> +
> +/* Tasklet for SoftIRQ context */
> +static void ctx_check_tasklet_fn(struct tasklet_struct *t)
> +{
> +       bpf_testmod_test_softirq_fn();
> +}
> +
> +DECLARE_TASKLET(ctx_check_tasklet, ctx_check_tasklet_fn);
> +
> +/* IRQ Work for HardIRQ context */
> +static void ctx_check_irq_fn(struct irq_work *work)
> +{
> +       bpf_testmod_test_hardirq_fn();
> +       tasklet_schedule(&ctx_check_tasklet);
> +}
> +
> +static struct irq_work ctx_check_irq =3D IRQ_WORK_INIT_HARD(ctx_check_ir=
q_fn);

Nicely done! selftests should work in PREEMPT_RT too
though we don't enable it in bpf CI.

I was about to apply it, but the new tests fails on s390:

test_exe_ctx:FAIL:hardirq_ok unexpected hardirq_ok: actual 0 <=3D expected =
0
test_exe_ctx:FAIL:softirq_ok unexpected softirq_ok: actual 0 <=3D expected =
0

The existing bpf_in_interrupt() also works on x86 and arm64 only.
When it was introduced it came with pretty weak selftest
commit 31329b6 ("selftests/bpf: Introduce experimental bpf_in_interrupt()")
so it's not really testing anything on s390 and non-x86/arm architectures.

So just add your strong selftests to DENYLIST.s390x.
get_preempt_count() on s390 looks like this:
static __always_inline int preempt_count(void)
{
   return READ_ONCE(get_lowcore()->preempt_count) & ~PREEMPT_NEED_RESCHED;
}
but get_lowcore() needs asm.
So it's not going to be easy to make it work purely in bpf.
Let's punt it to people that care about s390.

pw-bot: cr
