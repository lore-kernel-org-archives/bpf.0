Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E0301493
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 04:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017364; cv=pass; b=ehXrFpritGMEkdlwO9UWh1Y16qxWIJ46CamjNA7RsbkFGyjBfwDb7qnltNic3FUQpMbHP5kdSb2t8EREK2zT2zFZ/6D5xeBbDxuWW64ngRtlmIGA2u+vGni4kZiykVG4ZanJQH5MzUvBZqOaeyG7QTmWjRAhAywg6uR6TT2hoCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017364; c=relaxed/simple;
	bh=osH9UfPwEpGHAtBeI+8vczaO/XRW1uEY6E19waHLhzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAfdgLYeU6+5Wfw4dYOErFsOKCBOOk5DBoa7mpbAgViXAGnHW819DCMzMMQntjHL/pt0/WNJ/GUdoCE3P4bkFQibeyyyDTYE0cgvFkBAiKGLnrTCLeqE06AT7R/wV2AmOse7gR75v71PFbTRo4HOcfHI7rkQ52NQM8qt3zLauA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oaw51Lx/; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaw51Lx/"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7986e0553bdso30053067b3.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775017362; cv=none;
        d=google.com; s=arc-20240605;
        b=IZfiDdl6gEOBNUORJ5YW6tL3enyRY3CqwF+k5+wUuaUUay2ngpP9tGErxMfYk9LGtW
         91LhveiHvQar3vvf11UQdQ0Tqn0889qcd/P/cB1ssspwgpSDC6Op0gXr7Jc3WtBKYaV+
         WMvFDZnWL4+laSjo/l2Rd4Gr0MsUMDA25Gc4kGko66g+j66TXDUCYMQrFZ/WROEkFoLA
         bTU7N3spkFESVQKm6/4lBYbjTOEXUUdWzeIZDKSZ8mhT4ZJScNE0wQp/4OIaW57Uyfhz
         f3Tzi0RxIYnCPXBdLsUnw59ym7G1LV1tEJo2amQpBqHnViHwtmlDEXMUq+JqRA2RmpQo
         wO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=03ZX1Z9CcPPQWfIOUPiqp8RCbe89arZFqETPOrTPHS4=;
        fh=jLrlXpAN1N+6I2c7BxDrN4VK5iGiuQSN/y4zidXjizY=;
        b=BHFhBLH2L4c8vC0wU0RBjhdRT5kcFqeP/B/hxCa2PN6UMf5TKVqzYZ9oG57inUo5uG
         InnRrbnuIE6u9Bsr2NU9wPzJ5lzZ5m8OTiWfPU4Do/OjkoSPdkWFSmBo/wCs7Eo7RfVR
         zd38WMj9jaBUVJFJcNJiq6abAEssKES3Jf0R/B0ESfhQQU6vH91I0XaN7ZMj8jK8Lwt6
         dvp3gtQj+LU8upAZQh599jNvOCMnx2kFnRoH1zZRmAiEi/Q+5DIdrGCJeFjUWp6kApAb
         oDi9yM3twd56gZKE+eXUDnlujH94+44hPLOyGM79A6jNTOYuxCsQJlIYKKGc/z85M2MD
         CfjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775017362; x=1775622162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03ZX1Z9CcPPQWfIOUPiqp8RCbe89arZFqETPOrTPHS4=;
        b=oaw51Lx/hwv1W3sNMAX/EzZHuugc8SuOb30LLR0HBCu2sefX6uximvr60oh5G0Vvvu
         H/cCoXNLuaXREAusIbDLcFhJqB0T4S+mpuwOrp1cl7183UQ9UdS28rIDnwqqElcvdu2N
         5jqC+5lhDTJDU7yTFepKMm8tda5qRkZZzUXmozrgWXqB8vWGxthvkrW2HjwDbsFwTMOG
         sORkJwxC7c1Aa02C8Sob6fy6729EmzIbsgA4FFm6p7T0nKB0LH8ky4hfUdxIeS+EzunO
         iQLsEPPDvwZ2sp/jzCcjyPER/RKHExnWBIxI+L6+ZdBsFCv0NF6qdUkxCtDoiv+HN3oz
         v9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017362; x=1775622162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=03ZX1Z9CcPPQWfIOUPiqp8RCbe89arZFqETPOrTPHS4=;
        b=atXvCfSVSTC5YG8Xsxk5FPLSv3ivM2MHHIdkwfYXeNtm0/l2Li7NsKNAevEFRb4Msp
         FHJk07Zf2ImahfYIo+E6KbYqlhEY3vpFTHurnCbFi4YN2jk2RAo6hoZZv63168jVvwr+
         zg7epXa5AWSTRlAYL8uyJyqjOYU6rze6VvawFnkBd3tXjMCSkfb+YtEfrpYmiHD6ONM1
         DwjejfX2Xokp/YAVvklk29N2NvhTRhR7SQRWoGlIIsBgxaKIvqk/gSBEC+35BYOeCziH
         h2aaI4+Xclg8Es3cJqGNjFhMEqIBZmy5p/ZIM/acx+n/i089AtaYhVLuePrib99vO/uR
         PHow==
X-Gm-Message-State: AOJu0Yw1VXZwHZCHjQ/N4RzcemPhDC4G+mk9cnN82M1RrsZHRDeVD+yD
	UWa2joqsIVj8cXg/GXJnLWKwstA9N79na48XTJRHAGH71xxzA5zQKkj5Ff5bLmQkvn64snU2d7i
	VlmMMfGYIhBAX4RhQBANKWfr3/P0QsA8=
X-Gm-Gg: ATEYQzxy4XWJHj1OEEf51D0MxoGmGWH6QDsAIAnBhcRrIU8rxBrxV8xK2PFkKLqaFTf
	C219xgnJ7Kt6jEAAb8i8o/3Xwflm0Hko2oVULu56AQewFqmwIQ7T+wsmTh0cmlrAf8iDkxtPxos
	tBUqYYtML6UvAbWlBmxKSwA0Ys1Ye7Ul0CMREQKyyJW8X9Mrzd+EuxS2PO5RCyGNrXFXMBX1otx
	1VtQZr7rzcCGMMPa/VJDuE2mjM+ycAal0LS+mAFhfU6mnnexxCz/h3iErPVwNQdJhEzS3GdVZtE
	gv30+n+z3gwXr1ZBG6Eul3BfVnxTwR9zuEsoMmFxFh9AUpfi8S5c4CkW0p7Psg==
X-Received: by 2002:a05:690c:6010:b0:7a2:80a9:93cc with SMTP id
 00721157ae682-7a280a99a4dmr6833697b3.25.1775017362455; Tue, 31 Mar 2026
 21:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331213555.1993883-1-ameryhung@gmail.com> <20260331213555.1993883-5-ameryhung@gmail.com>
In-Reply-To: <20260331213555.1993883-5-ameryhung@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 1 Apr 2026 12:22:31 +0800
X-Gm-Features: AQROBzAV8SsXqtUD_OCO62ChfX1ufipF8Iq6u89BauU9yyFcr_xG0c8PXZA9Ing
Message-ID: <CABFUUZEUfJtKOcRYvSA3_e6EJU3fLDwFY3ocaykKK3+F9MF7rQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] selftests/bpf: Remove TLD_READ_ONCE() in
 the user space header
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:48=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> TLD_READ_ONCE() is redundant as the only reference passed to it is
> defined as _Atomic. The load is guaranteed to be atomic in C11 standard
> (6.2.6.1). Drop the macro.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/task_local_data.h  | 8 +++-----
>  .../selftests/bpf/prog_tests/test_task_local_data.c       | 2 +-
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
> index e242c455ddae..91f3486439bf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -67,8 +67,6 @@
>
>  #define TLD_ROUND_UP_POWER_OF_TWO(x) (1UL << (sizeof(x) * 8 - __builtin_=
clzl(x - 1)))
>
> -#define TLD_READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> -
>  #ifndef TLD_DYN_DATA_SIZE
>  #define TLD_DYN_DATA_SIZE 64
>  #endif
> @@ -184,7 +182,7 @@ static int __tld_init_data_p(int map_fd)
>          */
>         map_val.data =3D (void *)(TLD_PAGE_MASK & (intptr_t)data);
>         data->start =3D (~TLD_PAGE_MASK & (intptr_t)data) + sizeof(struct=
 tld_data_u);
> -       map_val.meta =3D TLD_READ_ONCE(tld_meta_p);
> +       map_val.meta =3D tld_meta_p;
>
>         err =3D bpf_map_update_elem(map_fd, &tid_fd, &map_val, 0);
>         if (err) {
> @@ -207,7 +205,7 @@ static tld_key_t __tld_create_key(const char *name, s=
ize_t size, bool dyn_data)
>         int err, i, sz, off =3D 0;
>         __u16 cnt;
>
> -       if (!TLD_READ_ONCE(tld_meta_p)) {
> +       if (!tld_meta_p) {
>                 err =3D __tld_init_meta_p();
>                 if (err)
>                         return (tld_key_t){(__s16)err};
> @@ -338,7 +336,7 @@ static inline int tld_key_err_or_zero(tld_key_t key)
>  __attribute__((unused))
>  static void *tld_get_data(int map_fd, tld_key_t key)
>  {
> -       if (!TLD_READ_ONCE(tld_meta_p))
> +       if (!tld_meta_p)
>                 return NULL;
>
>         /* tld_data_p is allocated on the first invocation of tld_get_dat=
a() */
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.=
c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> index 9556ad3d986f..e219ff506b56 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> @@ -26,7 +26,7 @@ TLD_DEFINE_KEY(value0_key, "value0", sizeof(int));
>   */
>  static void reset_tld(void)
>  {
> -       if (TLD_READ_ONCE(tld_meta_p)) {
> +       if (tld_meta_p) {
>                 /* Remove TLDs created by tld_create_key() */
>                 tld_meta_p->cnt =3D 1;
>                 tld_meta_p->size =3D TLD_DYN_DATA_SIZE;
> --
> 2.52.0
>
>
Acked-by: Sun Jian <sun.jian.kdev@gmail.com>
