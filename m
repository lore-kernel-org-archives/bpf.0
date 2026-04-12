Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7AB41C71
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022315; cv=pass; b=YESUWpqlXlWlc0U/w0hJ6CVsM0OMT32nB/V27bn8mSvEg+gjmCcHWdwTkBHcXZ+prCpiPwtNVjQhTmnFC4Fqb5l7YuA9sfDwbGYfmgFFDNHxQFatR9VMs/wXeWEGTS//qHD7GaH4gQ1Uj+aM+CC5duPW+AEppi3H08SaX2YS1/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022315; c=relaxed/simple;
	bh=5M8GafkLp/ll4yOPU/ad+imGPcfZ/QcyR0Q30gENvPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzQDtsJ7eqf5HMjKYthlAm8ftFFydJPZQmQYFQma3PT53xmU2lR0LuCEU13F50U6qU+59SmW7T2ZJT0tWEBBq12pSO07cZzWjRHrF4cYY1T7D+2cLM53T5p3Y/1nyEtRXlUxTG37Vi0E+B75m6hq2RP0pGN/l9T2H66+EHVOb0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5Vmj2g+; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5Vmj2g+"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso460723f8f.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 12:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776022312; cv=none;
        d=google.com; s=arc-20240605;
        b=T/G14YCP7+Gd+hYISEoqia8sRSq0QhJSfgSM1Pb5+4v1ja5OFxCErhjbbiwUp7twCI
         fXEYXIY+rfN5QOVrqUPFJaAnad6bQGOLOpArjMBm6sZG2/bhb/VLsC7IuIY2QhWh+Cd4
         RbD8x5rp89AoB0mkJO0HWmQe4awScTZw4phBL9AF2rBOyRBt1BZhKYv9yvlRtZ1YkY8J
         piCFi8y1Ltz+JPiYqIQtdqc3JXJeT8qGpIVzlRcbb3l+h6MvvvlPMcbLZ9a7Wj4BdXG8
         j8ZvVzpx7xBRpiAy925zTJJq9fiHeyxnUbUqifrRX6VllazUSdWhmFaAKF9DXlcCXNid
         Ig6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=be24Vuliy3vfZ30uv5KS3Q63Kwf53mT7iFPrUBaNk/A=;
        fh=biVxOfAQ8y53MvSfca8y15aWHNNleTL0sZ4Yh4c+Sg4=;
        b=ZlJf9B/sdbRlL+D4Wh8okoZ0wRWMia9V/1iLrpRpBWKZ37l1Y7jt80f4opHQNqpRBW
         /0GyE3lN3aBGIsgKSNtozvbvYJbSZ+vtHmCJ1kPmNnQBG5xOb4xx5bMD/iXDiKfvQgWn
         4VpspbmBFFcVoN92rrUZTSbDrjcaKu8tAnJjp7TrLHV3dpk2m1Z8OGyvioMW+BkwWl5g
         qFzsdfT9+e7MIj5quIkq782jz/L4wWFp1qwsISADpOLL+xy44ZKumDAFEyBwUpxmZgoI
         tTeBJ3wXalgXAXQabAS8eVoxzcRDjh+9RvURjM5I1zvskRjyASP50Yx6iNzpk8Q3C/bP
         OhMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022312; x=1776627112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=be24Vuliy3vfZ30uv5KS3Q63Kwf53mT7iFPrUBaNk/A=;
        b=h5Vmj2g+OIFBs7p34baPC7wYj4oDMVY3X9hfd4+lDbXt9PFJpfWIkI0qHChJGMl7oR
         u8ftjDoj05ATJjw/wEBHIG7R/0Y5BobbqK+zKGsy9jUdztG2ahd2G/GViwCDW2uJXi6M
         kN+KMorFXhrbNmdoZmzqAF6FiWqncISn30RmHmySG7qQrTJN1gUxlsdZvKITv6o6wwMo
         5Pe5lF8mELA67swRvL9goYGNE9QDCFEW/lci28WeibraZ1znoPH8uNQWpYFtlo0AsNqa
         UztqvYGBht3QJGphVjwazuuhy16i4ggCzViwAxjUBW8Y8bBvkRXP5Dymwh3LuMpmnlPP
         oB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022312; x=1776627112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=be24Vuliy3vfZ30uv5KS3Q63Kwf53mT7iFPrUBaNk/A=;
        b=VwJ0FTUtHdT36uktf92VecbpCn8XDej3axL+Ym/JbAHlUv1YbNGFNNsOAWo6+x2PpO
         4Tf9Ac/fpVwvE4TIfB20YGLDXFYRDq8mB1tO9TaTTnByzVYUNFOmRP+O6jGJa6rfepQx
         vEbwFfB0dEXZdWKBFgKaFNGEYgGSWFUQzcYKoP0RKgn4/2cJYE3yZRhkaYmpt6AWyEl/
         EyQl+MjfLbHtpbOae+iEqkbP/PuUTErtBwaJPA5v6QUacZNj3AoohzpgHKy5RB4FTeto
         Ypp+OC0Zf1a+JtGrvHOMW6lQ1s5XrCTBQ4L2F+oTASLjvKBkz+4/LrxI/uG0tRBAymdd
         TMpw==
X-Gm-Message-State: AOJu0YwiCI11yl/KpToSgqqE/TYAM5FxOKyGfHJsGoOm6KyQu8jj4We1
	6V+CaamgNSVlEwknR6WfNLG2NejnhMaQsJC6ETxCEUkdup7ogp/4WyVHTNeSezEYQIv5/csQZCV
	LGLGg1dVXYFc5nTkAd2cLkk7q22wWmsc=
X-Gm-Gg: AeBDievfd7I4aMwEE6z1rcL6fZ1Yzx6xGBgmPaEajNlQJ5U+rD/TJf/CWFQzYsO+Pz7
	xdQYmGkkhDFKh3ezS1RHAJ58nmOz8a6Vpcv2Q1111vjVHZgaccZ5Fzu9MUcTBMEUARKetH7vUkj
	37qmyzx+KhdrkuOoO0lGxUFo6np2opZznckJhFLWc3F3KV5fwn2kOBj+2mxq9yYYuNZSk44DHB1
	FaAu+l5rlJXisNi5MAzsY4swBrAMrH5F/k694/gOnkYIkhV+6YV6dLee//dtRMA1SA4lKGMVnFM
	OWyKbMRr1nKEN0YJc/mV9LseEzjNlQPXXpuw6FnoStynliEYtXTdLbeUgrO9l1q1JKzrBCikUa3
	+c1cfl1U4FDXTkZveFsmg6diMHSKHvqtXksMbI1HruwltU9a7AlFvQQ==
X-Received: by 2002:a05:6000:250d:b0:43d:77d1:7eec with SMTP id
 ffacd0b85a97d-43d77d18300mr2359762f8f.34.1776022312433; Sun, 12 Apr 2026
 12:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412174546.18684-1-emil@etsalapatis.com> <20260412174546.18684-4-emil@etsalapatis.com>
In-Reply-To: <20260412174546.18684-4-emil@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 12 Apr 2026 21:31:14 +0200
X-Gm-Features: AQROBzBtCxSN631Gp3KcfbKCI7HKlDE38_OOHtB2lNgqc2-QQdE5qAhJ1w9LwO4
Message-ID: <CAP01T77VRccr1feG4uiyWu0zAPf4oDFMJTVBdyBLfpKTf87GZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/9] selftests/bpf: Move bpf_arena_spin_lock.h
 to the top level
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 Apr 2026 at 19:45, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> The bpf_arena_spin_lock.h header is useful for all programs and not
> just the selftests. Move it to the top level of the BPF selftests
> to make it more readily accessible.
>

Please add something to the log to explain why __weak is needed, as
indicated in https://lore.kernel.org/bpf/CAP01T77GwHgS04TM8yTODyiXh2VJq-=L0FPoRvjpfF4dc6T9zw@mail.gmail.com.

Also, since we discussed already, why not move this to libarena?

> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  .../selftests/bpf/{progs => }/bpf_arena_spin_lock.h        | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c   | 7 -------
>  tools/testing/selftests/bpf/progs/arena_spin_lock.c        | 2 +-
>  3 files changed, 3 insertions(+), 10 deletions(-)
>  rename tools/testing/selftests/bpf/{progs => }/bpf_arena_spin_lock.h (99%)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
> similarity index 99%
> rename from tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> rename to tools/testing/selftests/bpf/bpf_arena_spin_lock.h
> index f90531cf3ee5..680c9e6cb35d 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> +++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
> @@ -107,7 +107,7 @@ struct arena_qnode {
>  #define _Q_LOCKED_VAL          (1U << _Q_LOCKED_OFFSET)
>  #define _Q_PENDING_VAL         (1U << _Q_PENDING_OFFSET)
>
> -struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
> +struct arena_qnode __weak __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
>
>  static inline u32 encode_tail(int cpu, int idx)
>  {
> @@ -240,7 +240,7 @@ static __always_inline int arena_spin_trylock(arena_spinlock_t __arena *lock)
>         return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
>  }
>
> -__noinline
> +__noinline __weak
>  int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock, u32 val)
>  {
>         struct arena_mcs_spinlock __arena *prev, *next, *node0, *node;
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> index 693fd86fbde6..acb9d53b5973 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> @@ -5,13 +5,6 @@
>  #include <sys/sysinfo.h>
>
>  struct __qspinlock { int val; };
> -typedef struct __qspinlock arena_spinlock_t;
> -
> -struct arena_qnode {
> -       unsigned long next;
> -       int count;
> -       int locked;
> -};
>
>  #include "arena_spin_lock.skel.h"
>
> diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> index 086b57a426cf..6c04e7707644 100644
> --- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> +++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> @@ -4,7 +4,7 @@
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
> -#include "bpf_arena_spin_lock.h"
> +#include "../bpf_arena_spin_lock.h"
>
>  struct {
>         __uint(type, BPF_MAP_TYPE_ARENA);
> --
> 2.53.0
>
