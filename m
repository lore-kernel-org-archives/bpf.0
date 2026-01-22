Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464533A8FFD
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118600; cv=pass; b=hWUNH4+la/1F5a/PWMO/bPp/sjrfowD0oA2BWBbp39g0cZHxi+459/QLVe2pIcMHCqDq4sKOmEvXWDRUUj3ueNGDnMIS3DELEefTPS7KKzfQwZHXwqyqsbJWNg+QNhXd74zLwQm6F4obkg1MSKf/dbwuzR27dC/Qb0AUYkagd8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118600; c=relaxed/simple;
	bh=EmRQoEkTFGX4LJ3ePVlnUgVTKMxnk0pub778VGYT1gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fq3cfZ+MciJmRXidiKynjHy+7h5LEFh0CJxYERxPQUiEe070yRvsocMJXCZgtTpxHnc3IpTgQhnsEdc776lkdzp/V7IWmjT7JR5bKLBYyHrbtQUnZUiZg4MKrVwMB1I2B23gQqDAge7s4aFuXUmkh3TuMEXKGXOGySlfFinkCgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja6Ijzau; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja6Ijzau"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6495d592c45so143709d50.2
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 13:49:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769118592; cv=none;
        d=google.com; s=arc-20240605;
        b=G+YbSwx1hkkVkwnYFZ8fgeG6JNdFHeFXa+LHJuk2bP1DVV7ctq3oHh6DZaC/yQitiN
         1x/mi9TdfJEM3S7RYualc7fn1MvwIsGsISy9Ce+vUFTNaR3nweREeRRfM1Tlj5JN6qI7
         XxvQTRs4l9xj224FLB70PfSpuw8DdMtfYSG2gETeSWA2ebUqTeQXjoaiVyKLHnbGoYbC
         pxsLSM/5hBmvMebcNpg13KdU/OyjNza42y1fYGdMr6HhoUFmt4ZdxUk+eG3YgBLvM41M
         PMQBc1Iq/w+TauLT+pKFfcDe2YmHD67ptCxJ/wSam05kCWLEPBQIfeJl6wuy9pzlUfTL
         tXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UzkPmkzePYjgoUzs5+Ke5SWXqQ9CEQ5gR+sAl6u6Z2g=;
        fh=4KubPJPm/oify4h8BPjn9mdYAYp9R/C82vTyHZeZ5Mg=;
        b=Oi4EgkxxGubVfurMRX+HoLEplzkEtjGXDDybE+ImzeCIhpcuNDpJhhVCuNLtmax+al
         KlZgrz5XJC3ArMGvvfazZqyoTBdJ4XBUtE+MC6UeSyjJfF/HCc7zZ0AVH8LxyJfZcKG/
         uiq78oBG6zbd4erG2DvHPLyvA7pADHGkmavXGJvBrY/COe5fCh2Y7yL/nUmtIRIdCkFO
         b3m64LQx3sro/jxFUCIDZqZaY7MdMriFgs5ZMOj3+da5LORk7paQfP7cskw1+u9TNU0w
         Cg8ueL56F+TyrLuHr38GFCZXSDsx9KkB1ENhthdGjavAh/RKWZjcVNebaLHspOT0eHZG
         PFaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769118592; x=1769723392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzkPmkzePYjgoUzs5+Ke5SWXqQ9CEQ5gR+sAl6u6Z2g=;
        b=Ja6IjzauJu583uOs2LKyez0hF26Jf4KFH8s9/N5SIvxvEwnk7pkH6v8kmJavCYGb17
         0NkKd0Jja/jRT9izqpyxBiNcMVnMPNKOP2SDocu3sOaPG59u5JEAZQ0pphnLI9g6eZeW
         qPzVvvizoeEZehbl13nLH7WRqD5fS5xhSnCrC7n0bhsiVRGUrpOAG6qOT7ojXVvCdaHS
         OW8OrDBYIoK5aVSrGqhjtRKZ/UQRYriG5RPfc+UYghkVExNMKq639Ljiv85abQ3/1XNv
         u9A3ba9i4Y2LMa7BUbHR7mEDBiS3b94+ue3cW52gkR9tL/O9JhEFq3wh5XCuhr3s4omD
         Pu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769118592; x=1769723392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UzkPmkzePYjgoUzs5+Ke5SWXqQ9CEQ5gR+sAl6u6Z2g=;
        b=h8aqYWlyg/UzbMkpTqXLJqWWp7UZjZprA0+9GFtDo204D6mPpwxVJMX9Hcs6rqYuAh
         WOyDOmqM2OOyRsmfmCxrv1ig22KzrRoBFkWY4yyufbX1XvyeX29AiUBaRMnCiTMV9+34
         RjHqYpOUd1w8flxj3ua5DN8AUnX6HVrpHOJ7zSp4Jk394IJ/KdQws9Ox/XLi5NOucwzY
         ZYJwjhefgqDdgea9DCwp5z/fgL8f1Z/0GIEQzwQv5/Ocq/l6lVVXrxUDDssq+hK8aKaG
         ba+Qt14LB9X5ugwTzjsbmXhk6jCPPhgai6NAel2A0KC6CL/5LIbt3rtGqcCMNg9bbDPG
         8Dyw==
X-Gm-Message-State: AOJu0Yw1BobTRe6b5UuBGxjncpKeO8TVKsVs+t/QYncIaV498HBzsObx
	Xp/nU2rIYP8tSyoIO6VDWmNyHeBHrHUDGasUmhfdlxV2lxLWY7aJ66kB3dnTKsSCMPe2Ei2T9Zk
	e0mwEu4HbAbNxjY+6MDH4NSUXyw4D/28=
X-Gm-Gg: AZuq6aI2vmFsqNZuzWOFgwvJe1NfITFokH94DkNMy5+QGne1zSpxW7Yysflk9bU4Nus
	98PTgLBP2YS6dyQXjM6SQoyeNs2PfQ5DImboKF0OvrEmkuT3nbuyL3FcBfDmddDUDjJUNvA5+SG
	cLS+/wVmFBKiEO5TrnABUc1G1thJ9k7Jq0zWCk/GPCoZA71yvM25N+bCpBFWvDEsn5wl6C+tl0E
	tZclcqBE+gHnBwHmByYu0qDD75IQ4Xt6z7L+LGRc/dk0gGoVfaHHPBlUponLppVDWPSq9KevVTj
	8kHlkUVpPJMrlaT/70e6UA==
X-Received: by 2002:a53:ba81:0:b0:641:f5bc:6960 with SMTP id
 956f58d0204a3-6495c010094mr628003d50.76.1769118591660; Thu, 22 Jan 2026
 13:49:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122162616.3578898-1-yonghong.song@linux.dev>
In-Reply-To: <20260122162616.3578898-1-yonghong.song@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 22 Jan 2026 13:49:40 -0800
X-Gm-Features: AZwV_Qiq-ReG8Z2Z1JTlRGi_yTX1V-EQz0arTl2nbtpLlKdqxECE5o6DdIhAGCk
Message-ID: <CAMB2axPhNZXj86cby+4mgBFsVCzk4TnX=aC7PROkTd6Shh_sxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Fix task_local_data
 failure with 64K page
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 8:54=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> On arm64 systems with 64K pages, the selftest task_local_data has the fol=
lowing
> failures:
>   ...
>   test_task_local_data_basic:PASS:tld_create_key 0 nsec
>   test_task_local_data_basic:FAIL:tld_create_key unexpected tld_create_ke=
y: actual 0 !=3D expected -28
>   ...
>   test_task_local_data_basic_thread:PASS:run task_main 0 nsec
>   test_task_local_data_basic_thread:FAIL:task_main retval unexpected erro=
r: 2 (errno 0)
>   test_task_local_data_basic_thread:FAIL:tld_get_data value0 unexpected t=
ld_get_data value0: actual 0 !=3D expected 6268
>   ...
>   #447/1   task_local_data/task_local_data_basic:FAIL
>   ...
>   #447/2   task_local_data/task_local_data_race:FAIL
>   #447     task_local_data:FAIL
>
> When TLD_DYN_DATA_SIZE is 64K page size, for
>   struct tld_meta_u {
>        _Atomic __u8 cnt;
>        __u16 size;
>         struct tld_metadata metadata[];
>   };
> fields 'cnt' and 'size' would overflow. For example,
> for 4K page, 'cnt' will be 4096/64 =3D 64. But for 64K page,
> 'cnt' will be 65536/64 =3D 1024 and 'cnt' is not enough for 1024.
> For field 'size', it is okay for value 4K, but it is not enough
> for 64K as maximum 'size' value is '64K - 1'.
>
> To accommodate 64K page, '_Atomic __u8 cnt' becomes '_Atomic __u16 cnt'
> and '__u16 size' becomes '__u32 size'. A few other places are adjusted
> accordingly.
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Cc: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/prog_tests/task_local_data.h    | 6 +++---
>  .../testing/selftests/bpf/prog_tests/test_task_local_data.c | 2 +-
>  tools/testing/selftests/bpf/progs/task_local_data.bpf.h     | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
> index 2de38776a2d4..4c38f9a7bc90 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -94,8 +94,8 @@ struct tld_metadata {
>  };
>
>  struct tld_meta_u {
> -       _Atomic __u8 cnt;
> -       __u16 size;
> +       _Atomic __u16 cnt;
> +       __u32 size;

Agree cnt should be __u16.

size can remain to be __u16 as maximum data size is page_size - 8
byte. The 8 byte is tld_data_u->start recording thread-specific offset
of data in a page.

>         struct tld_metadata metadata[];
>  };
>
> @@ -217,7 +217,7 @@ static int __tld_init_data_p(int map_fd)
>  static tld_key_t __tld_create_key(const char *name, size_t size, bool dy=
n_data)
>  {
>         int err, i, sz, off =3D 0;
> -       __u8 cnt;
> +       __u16 cnt;
>
>         if (!TLD_READ_ONCE(tld_meta_p)) {
>                 err =3D __tld_init_meta_p();
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.=
c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> index 9fd6306b455c..cc4d49222d9d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> @@ -4,7 +4,7 @@
>  #include <test_progs.h>
>
>  #define TLD_FREE_DATA_ON_THREAD_EXIT
> -#define TLD_DYN_DATA_SIZE 4096
> +#define TLD_DYN_DATA_SIZE getpagesize()
>  #include "task_local_data.h"
>
>  struct test_tld_struct {
> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/to=
ols/testing/selftests/bpf/progs/task_local_data.bpf.h
> index 432fff2af844..e13f239b46b0 100644
> --- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> @@ -80,8 +80,8 @@ struct tld_metadata {
>  };
>
>  struct tld_meta_u {
> -       __u8 cnt;
> -       __u16 size;
> +       __u16 cnt;
> +       __u32 size;

Same here. We can keep __u16 size.

>         struct tld_metadata metadata[TLD_MAX_DATA_CNT];
>  };
>
> --
> 2.47.3
>
>
