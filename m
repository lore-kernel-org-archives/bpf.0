Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FAD38A29A
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772081816; cv=pass; b=hP8yRSjaigu2mU+cSfzshMF48xHDuPCkFLhdrbIPZN7HrlRMuvWSYDOUjaPH/THpaTT6PMW79aUdlYbnQnyUPemvUf9rhgMtBRJ7Qt7pJnZxGmc64ONEZO4za/DZhG3dzghn3G7S8oByRLGfzU8r/vrugvAOSGj1/I+WplzDO3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772081816; c=relaxed/simple;
	bh=2hChll5BBbjw96pDP2XpQQyvGH1G+zGwcL7JOkIAw0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecSqnrYHJS8GwsRMmUZPe9YyZAqVx+C+AfRVBgRJ/TYL+vk+ozTsDOxEXG+7zPrQ3TYhSCdkdt7+w2ZL+W/q5pOPWNBxAGtqM9Pg4j63QvSzAUOQJhC5PtuV6dhMf6sCJd891qRHltD+4FHCKKXuoiPvNOAf4slFvWCOTAVdWN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNR0W7fu; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNR0W7fu"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43990ea3fbcso249069f8f.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 20:56:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772081814; cv=none;
        d=google.com; s=arc-20240605;
        b=IrZF15Zuj1Rgez1RivEcdyY2a9+IGkgE9q9G+LHHxUjERbzswoeq8G0uv0UhqMnCJP
         Or4cyp+XFvWUX/YecnCVA9f9uzUxqQwnWovOgPFKTdGFoWVuqpKKJy4FFpji/m/aH7/1
         e79Qmdm/9Wu/xZU49swlThmWUMblKkXeSpfuzlPRFTK7HIpfl5cyy7Kp391aIYpRheKo
         6Uu/h++PMpxYyEWAUisMqr4EAAGxnCxd1mDf2uEDA334o2tQmzmOzd5rO7Gmmq19g8qG
         vdDWaxJaf0GdoUgp0g7ViPc6vWk/KMJnbK4vwkxLlh6o2kEVViFdyRxh+QVQfnnpXa4D
         Wb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NfqGd/7ulX9YuIORD7ArL3Me7S3E+4NOv4DsCTEK+iI=;
        fh=/j0KmiVxLkOol74/+J6Mk11Gu7Y9sdTCznjr91CWqtE=;
        b=G0ljl2MRWrv5ms58kAUPzWxe2LqxoKX2G+9PPrQWKksIGaAA1l7Twfu80P02SoNI9t
         Ni84ZswLL68y5I0W9UHW4cxbscOjeAlwFJBsgv0iGlKrbZ76mDf65hMCa8Ao438/8VoO
         GV80gFlV2AYsR2KCVBLUqRCApz1gfHEyt305/OLaf9jrBdexWPWQjh7c9b5AfYQf43rV
         CpJ4ektcCfzvWfF3KjItmhzjhgmgDrfqiGwrq/5lO/j13SUuXAD433Pl/XLz4gEwTJ85
         k59StwwJGsSb2KjQTk7KurF3td6SZXB0J6OeGG+DO+vBn6G7gCXHQUsq2Ww3nse7M8Mw
         puCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772081814; x=1772686614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfqGd/7ulX9YuIORD7ArL3Me7S3E+4NOv4DsCTEK+iI=;
        b=KNR0W7fuuJIS5LNvKv2nvTrrMKaqmwgbPyEo3o+GMrHnS/tqaiGxs/ZMG0vxeNKEfI
         s455rWgu21eWeFWL+8lPoxPT1L+vaJtgLCE97BUa0E/GxxdXRZtrxCDGxqOaDngisnta
         XMI1mwokTEUFHBQfJ5bsmzcyjlKUSXPzk4+CUeS8J6DLt07ZQadtNq88M0QFvJGUbuWG
         4Sb5QBlXTBCwiji3t/ZdCbxv2nSyViD1yawktK+zwOA5hK6IUgD4gvtCmUurfgm+mssB
         b+N5zwDXVAnZz+xzfcN40PxkLrCZs2R3r4g6cvITeQlzCtTry5VE6toCz876LO7K6znY
         +g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772081814; x=1772686614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NfqGd/7ulX9YuIORD7ArL3Me7S3E+4NOv4DsCTEK+iI=;
        b=LV+U7aApVwkiDa2lCGekeCyQAWD42Z460p67DC62MlUpSdfAIvkkURnO+8g9YNFfHe
         zlDNz6apRO5UUbm1LRQeWWq1La6j15/PLQ1PXYZ1zB+rzBsKce1N3W6VU1kmqrrNAz56
         jk5x4q866qspCf6BLGbbA+mK3yUpj1itBiff7YdnrDqdy8nnkYN4FHMC1BzKC11GVYvC
         B3Juj/bEFmn+AR02fuVzCxJzcnJyV1O7PCz9B87y9v+hhWCIyM2L99nhvUjn2l8AH8yT
         WkTKFgHmBNSiJYBWKCfzULMxvO3ntRRcox31dYf+HZ5Tuaj/arP/8V7z2ijVLvy9XDrk
         11tA==
X-Forwarded-Encrypted: i=1; AJvYcCUhQP94J+V/ymKUFQlaViFNhoK6q4KGG914qojTZtnc6QCqnEKQ6L6sj4GBTNEg451BARM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNOBoCNGPRzK7rnTpeKflH4c/TbfQ6yxu+MjsleeohKQ5Lxupm
	qd52mtXCLud20fn8JwpT2VJmBZGzg1CbF6/8FrybA6CqUbyDmdMsiXTzSIBHbUKko4F0pAlZqFH
	ItxtrWeNGgYSDHvCoJY7MowmcNs7gIJE=
X-Gm-Gg: ATEYQzwwYd2q6nnYFcAUuTO28UcmBI0IrjNPtrYwKAeXjbAWyEzsT0AvZ/pgPkuCOaJ
	Qbf0iTA69hdd/pSwsvq/CxlMwZhzX9AxJKzcT3at3qDQi6PlzuMaZuU9FsDLfoT0cTajVwA9pqD
	lm1sYkGFd20Li4mrGXgrb6V/kDzSuj7XgmpV9mZF+ny/cj1mbAtSwAOKGavHJVnXKYKxw2iltRP
	gedRRSCa92rGv01EYwBkBr2j9FEhd9su9mqIjpiRx/rem9QW7kEzaBUzg72KwBWLMlbUMdNlred
	TzXMKsPkfsyj72+QeEq0lKWBZtQoXZVjBUNmn/uAEA9B1cHYepBZWVukegwpw+S1pldrHeNfb1b
	rElbiIAC0X3cgofw7o5wwMzAkXKUUGljyfesg
X-Received: by 2002:a05:6000:402a:b0:435:8dd5:ad4f with SMTP id
 ffacd0b85a97d-439971ae913mr2213638f8f.9.1772081813615; Wed, 25 Feb 2026
 20:56:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772079741.git.sun.jian.kdev@gmail.com> <2697993e938a2f87084cfe92a4117525d700ac9b.1772079741.git.sun.jian.kdev@gmail.com>
In-Reply-To: <2697993e938a2f87084cfe92a4117525d700ac9b.1772079741.git.sun.jian.kdev@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Feb 2026 20:56:42 -0800
X-Gm-Features: AaiRm53eVXo79GEkdqm5L5n5J2hX7hgUMoyYtx-wS3h5uGMWHfRUdmqm1LG9STw
Message-ID: <CAADnVQKq40Sok-PUnyCLhukq0Q0KFptNWo=VQn8ybBWTpjk1KA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/bpf: probe_user: filter by pid to avoid
 cross-test interference
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 8:31=E2=80=AFPM Sun Jian <sun.jian.kdev@gmail.com> =
wrote:
>
> The test installs a kprobe on __sys_connect and checks that
> bpf_probe_write_user() can modify the syscall argument. However, any
> concurrent thread in any other test that calls connect() will also
> trigger the kprobe and have its sockaddr silently overwritten, causing
> flaky failures in unrelated tests.
>
> Fix this by introducing a pid_map (BPF_MAP_TYPE_ARRAY) that stores the
> test process's PID. The kprobe handler returns early if the current PID
> does not match, confining the hook to the test process only.
>
> Also remove the TODO comment that tracked this issue.
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/probe_user.c     | 13 ++++++++++-
>  .../selftests/bpf/progs/test_probe_user.c     | 22 +++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/=
testing/selftests/bpf/prog_tests/probe_user.c
> index 8721671321de..f50ee4066759 100644
> --- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
> +++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
> @@ -13,13 +13,15 @@ void serial_test_probe_user(void)
>         enum { prog_count =3D ARRAY_SIZE(prog_names) };
>         const char *obj_file =3D "./test_probe_user.bpf.o";
>         DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts, );
> -       int err, results_map_fd, sock_fd, duration =3D 0;
> +       int err, results_map_fd, pid_map_fd, sock_fd, duration =3D 0;
>         struct sockaddr curr, orig, tmp;
>         struct sockaddr_in *in =3D (struct sockaddr_in *)&curr;
>         struct bpf_link *kprobe_links[prog_count] =3D {};
>         struct bpf_program *kprobe_progs[prog_count];
>         struct bpf_object *obj;
>         static const int zero =3D 0;
> +       __u32 key =3D 0;
> +       __u32 pid;
>         size_t i;
>
>         obj =3D bpf_object__open_file(obj_file, &opts);
> @@ -38,6 +40,15 @@ void serial_test_probe_user(void)
>         if (CHECK(err, "obj_load", "err %d\n", err))
>                 goto cleanup;
>
> +       pid_map_fd =3D bpf_find_map(__func__, obj, "pid_map");
> +       if (CHECK(pid_map_fd < 0, "find_pid_map", "err %d\n", pid_map_fd)=
)
> +               goto cleanup;
> +
> +       pid =3D getpid();
> +       err =3D bpf_map_update_elem(pid_map_fd, &key, &pid, BPF_ANY);
> +       if (CHECK(err, "update_pid_map", "err %d\n", err))
> +               goto cleanup;
> +
>         results_map_fd =3D bpf_find_map(__func__, obj, "test_pro.bss");
>         if (CHECK(results_map_fd < 0, "find_bss_map",
>                   "err %d\n", results_map_fd))
> diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/=
testing/selftests/bpf/progs/test_probe_user.c
> index a8e501af9604..20a13b984fb0 100644
> --- a/tools/testing/selftests/bpf/progs/test_probe_user.c
> +++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
> @@ -5,6 +5,24 @@
>  #include <bpf/bpf_core_read.h>
>  #include "bpf_misc.h"
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, __u32);
> +       __type(value, __u32);
> +} pid_map SEC(".maps");
> +
> +static __always_inline int pid_ok(void)
> +{
> +       __u32 key =3D 0, *expected_pid;
> +
> +       expected_pid =3D  bpf_map_lookup_elem(&pid_map, &key);
> +       if (!expected_pid ||
> +           *expected_pid !=3D (bpf_get_current_pid_tgid() >> 32))
> +               return 0;

Good idea, but there are much simpler ways to do it
via global variables.
See other selftests.

pw-bot: cr
