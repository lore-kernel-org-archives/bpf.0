Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF971AAE17
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776544838; cv=pass; b=DuBJrrpaleTUy6le8jueYRVdIlZwZoAH3XXY9l5jMXvgjZtBcmq1rgM2tJXg/vTPtmhSBr5hSZDaVvf2UxoWNZDEGMa0vP+tZC6ft6eity8FymbcsqH7iLbaxEHXm5PbJtP/klAh3wh7iZq6M9xWugy9XJ54yIsvj8/flHUG0bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776544838; c=relaxed/simple;
	bh=7B50zB8QbeX3uPVK9cZOsdCqcRSAMBb3zwUUFGmV4Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwHQkWZN9vX3Hfw+D7FHBjaokK62Zv+hhbByLji2/RLe7kMk4Z7KL50zfLv0nkb0fp6l4axSyJnDX73U6t0tllDM2fzIyxz35FQsPYd4/QihxtTiSXZn1XYh/rTMI/6lW9mGaacJ1NiRLtLNkj+B6bGvergIuRulhRHieMMpsyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtgGd+FO; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtgGd+FO"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso18587425e9.3
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776544835; cv=none;
        d=google.com; s=arc-20240605;
        b=NKh9k8fv0HfMdjsA9QZ3heYDNwjJ5uCfzVkG2htO/FRq9oUsyTte/cQx3FftCAUpGm
         KIdx9r6x2iId3TyVv+7bXo2qLUFvWrtfq1A+lyZqCm/q2NcRGWQvnE2PKj/oOWLeO5PD
         K2KTy4r+PJ4KM6+HOlWg5nAulKzkfrWYEgqUBTBSvs6ZvFbzbnafCfZxJdYjR/BfDzcK
         uzlYFmQaUvgG/yT3umqaXq7VeclE+hoK/djiEw57iFk7Ts7Vve8+5ofcrwl/ywMgVDym
         RFVXwCOP6DPTU+sLGhwSvF5T1VIeNGeeBpyHX5CXIqsCR/V2wfTHwtuD7zNWwhnsYfTd
         ft5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d9I9a7XO9dtIiXmk5hGZfJcYVs5rx/AVNZYg2EtQcA8=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=hHhdaKYp6Ui+5FONnR/9ugCW52aihVe8x7AYeoVRXTkdUreUEHfqTZ782SvCo4PLUw
         m+d7ClSX8n+GkG1sbtvVqoZMhIO984W1LCqgStt44/X77gFR4SO6VY+MZZiWlSAiO4xM
         Wg7BegU4gJs2IyCdMkehsUiNFPLv4of/YR3RgPi6+BXMWb6zLqLARdYXYBupHV+nlRI9
         bhT3N4wtZ78jKE2h7m/KN57QfuwPi/H0uAYU765DLllOxsO4HEKipwLnF7qS4+l1TZ1k
         4lXPAgreSR5u58qva5PeC4Scxt2NlfqtMVvXwxtkK3stxPGr3O6XFm2QR7sr8LixQZJK
         CQBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776544835; x=1777149635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9I9a7XO9dtIiXmk5hGZfJcYVs5rx/AVNZYg2EtQcA8=;
        b=OtgGd+FOo0tGMLIP5R7xCTOzaXkdG6DY6LoAlemPkVjKBte4Grt7fDA5mpUaWJBDw9
         3ekY/Sh3MdSI9Y9oyCoN/pGGaLTU3+q02JKXtLMPPR+qHLKBx62gUgRwebI6/XPCzwQc
         kkcord+M/+f03920qpnfmLfTs6v3yJDvXLn9QA/UPzSzO8LqgshF5IFiIt+G3q4ftAG4
         O3IPL8k5P3uqYL+VnjJwbmIO6JNYuHETEgTiu4WJZ6O0l7iwu84Th1SBxyVovUbm1ldU
         HGyFrV9ns6uhS1WtWWli7Hm/kO+TtCA3XTINFKbA+JcKaqQzgFKOGlokC40geUg4tN/N
         OCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776544835; x=1777149635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9I9a7XO9dtIiXmk5hGZfJcYVs5rx/AVNZYg2EtQcA8=;
        b=PajyQ73YpV/HbP/dY1uQYEynKHLHhmRbvs0AiCtLfGt7OFKVEXGxpl/SRErJNvgB50
         MGBA0f21cWdj9CQRHaDKtiQd0MugW3zo7MdXzTEnKfl4Y7Vzj3SVxnAROed+oSgIY24p
         Ek20JhlO7xdtOHHTWnkYFvbLFZnlPL+iCUk10iJ29F4sW8KTk1VxoBJmlvOIOdW9aLn4
         NqV563nEWsxTQ/CgvhakR9HLfpW4YWrx30DJUNPtUCckIWcM2mfY7qzWoesFKoo9bf42
         CJRhdL2hu4DDkC2r9kkanAVTwdwDTE60M43tVupuVOyN6SHHZ2kIdaDlx8O1ZPM8HumT
         U93w==
X-Gm-Message-State: AOJu0YzdBLoNq8+Jv5BYb4GrMBOXvkIIUL+vTzA1hk55Gj1flgOqRx+O
	MQ5mnvlMJzR+1uF8A8ngZ2eRArKGW0EAdFWWcpvWVEUDj6oNd+/2anNsFhfLZ2ol8oTvLBOL2Po
	60ZA8DVBAuVAZjwLlcUidsP/CUsDXQIU=
X-Gm-Gg: AeBDiesva28pAXLpy/a28iCnnJrCu5vTj2PxlBXU1iYIjlFy7z74nPTFJN/VR80e3i+
	LQCJiTMeg8KPM4OY+mLAQWtuPyUPHAvrzfm8Nxuck256KeFqF9Qh5OLAW//T99ka+cc+f+uQzOG
	KkE1HpjC4WhI9vpn3vsljGEK17V+1NzlMdazngaGSYaMrXTcQMX9qKVgpz8r6TgQA1diFnF+Uwb
	fb/RVMMtXTpwhon+5t8Zc8cGKRFWsspt4aUtOXYjiTA0DQDwH6pL7wrJzC7KQjMGLnqLLgqpqkU
	6gCONtnUg4BOXJ7gpq+EHoI6x10RipSei26vQrRR7l6c22K9mMbYNcUDWI5/xTCwp1o/uLZRyk6
	hxDIjZj66ahwiP8FDh7mAmtS+9JWkm1G/gQiEh2n6DXZMFTeynYo=
X-Received: by 2002:a05:6000:144c:b0:43d:6a0c:9571 with SMTP id
 ffacd0b85a97d-43fe3dd339emr11882591f8f.11.1776544835102; Sat, 18 Apr 2026
 13:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418171701.610025-5-memxor@gmail.com> <20260418184552.8C983C19424@smtp.kernel.org>
In-Reply-To: <20260418184552.8C983C19424@smtp.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 18 Apr 2026 21:39:55 +0100
X-Gm-Features: AQROBzAYafRlGmIgiWv38zJIHVmqJb4mIj0aS1xylho8uw7ZrXlAdTce3vbfJsY
Message-ID: <CAP01T75a_-GkmOvQSjcsziSTEFYgn8X-_zn8haLvh4OhoJ0f1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Test verifier warning logging
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Apr 2026 at 19:45, <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [Medium] The custom `libbpf_print_cb` unconditionally buffers all log l=
evels into a fixed 4096-byte buffer, which will inevitably overflow during =
skeleton load and silently drop the expected verifier warnings.
> --
>
> commit 602c54794881684bfce8f29591c7e680ab7d51fe
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> selftests/bpf: Test verifier warning logging
>
> This commit adds test coverage for explicit verifier warning logging and
> libbpf's default warning flush path while keeping the warning bit private
> to the test.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args=
.c b/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
> > index 5e4793c9c29a0..f92a27d764557 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
> > @@ -4,7 +4,99 @@
> >  #include <test_progs.h>
> >  #include "kfunc_implicit_args.skel.h"
> >
> > +#define TEST_BPF_LOG_LEVEL_WARN      (1U << 4)
> > +
> > +static size_t libbpf_log_pos;
> > +static char libbpf_log_buf[4096];
> > +static bool libbpf_log_error;
> > +
> > +static int libbpf_print_cb(enum libbpf_print_level level, const char *=
fmt, va_list args)
> > +{
> > +     int emitted_cnt;
> > +     size_t left_cnt;
> > +
> > +     (void)level;
> > +
> > +     left_cnt =3D sizeof(libbpf_log_buf) - libbpf_log_pos;
> > +     emitted_cnt =3D vsnprintf(libbpf_log_buf + libbpf_log_pos, left_c=
nt, fmt, args);
> > +     if (emitted_cnt < 0 || emitted_cnt + 1 > left_cnt) {
> > +             libbpf_log_error =3D true;
> > +             return 0;
> > +     }
>
> Since libbpf generates a high volume of LIBBPF_DEBUG and LIBBPF_INFO mess=
ages
> during object load, will this unconditionally buffer all log levels and o=
verflow
> the 4096-byte buffer before the load completes?
>
> If the buffer overflows, libbpf_log_error becomes true and subsequent mes=
sages
> (including the expected verifier warnings flushed at the end of the load)=
 will
> be discarded.
>
> Should this callback filter out non-warning levels to avoid filling the b=
uffer
> too quickly?

Perhaps, I will check and adjust if necessary.

>
> [ ... ]
>
> > +static void test_default_warning_flush(void)
> > +{
> > +     libbpf_print_fn_t old_print_cb =3D libbpf_set_print(libbpf_print_=
cb);
> > +     struct kfunc_implicit_args *skel =3D NULL;
> > +     int err;
> > +
> > +     libbpf_log_pos =3D 0;
> > +     libbpf_log_buf[0] =3D '\0';
> > +     libbpf_log_error =3D false;
> > +
> > +     skel =3D kfunc_implicit_args__open();
> > +     if (!ASSERT_OK_PTR(skel, "skel_open"))
> > +             goto cleanup;
> > +
> > +     select_legacy_impl_prog(skel);
> > +
> > +     err =3D kfunc_implicit_args__load(skel);
> > +     ASSERT_OK(err, "skel_load");
> > +     ASSERT_FALSE(libbpf_log_error, "libbpf_log_error");
>
> Will this assertion predictably fail due to the buffer overflow mentioned
> above?

No, it's a non-common case.

>
> > +     ASSERT_OK_PTR(strstr(libbpf_log_buf, "-- BEGIN PROG LOAD WARNINGS=
 --"), "warn_banner");
> > +     ASSERT_OK_PTR(strstr(libbpf_log_buf,
> > +                          "uses deprecated kfunc bpf_kfunc_implicit_ar=
g_legacy_impl()"),
> > +                   "warn_msg");
> > +     ASSERT_NULL(strstr(libbpf_log_buf, "-- BEGIN PROG LOAD LOG --"), =
"no_verbose_log");
> > +
> > +cleanup:
> > +     kfunc_implicit_args__destroy(skel);
> > +     libbpf_set_print(old_print_cb);
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418171701.61=
0025-1-memxor@gmail.com?part=3D4
