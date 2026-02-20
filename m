Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB982F6591
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617507; cv=pass; b=KvjprcdC/Pl1zwKU5suwkVDUpiTBW7/Ivj0rL7UCAQ1DJFQbFrEt8LSPFSnN2KSWbWNKusKE4yVWEW418XDxM0pPMtamjqS4quYlw4oSpF1EEwzVbNppSR3WgDiPDKDeS+ZfVEp/9oT0XaHinE6Ym/1aAXCdUrjxW/Bx5d0NV4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617507; c=relaxed/simple;
	bh=YRC8rE/ZMU7oNsnsWipKFTFowg+eoBqE9mFbRqxH1Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5UEHh0gWgiD+sEwV8Bv1VJluLRo33p8Fb4XXi6VCQ6uFRjm5ol6FPw9+wdNnh7lpXBsq30mw0O+xam2fCuwuUwXaKgIetmlWNX+oE8w7zKCtKr1SJy80jslPTzDskT6ukldamr9CmXwmFnuVfwQwj8J4/ARuIzFk/cE1uujonI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDnpvc0D; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDnpvc0D"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43638a3330dso2048708f8f.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 11:58:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771617504; cv=none;
        d=google.com; s=arc-20240605;
        b=h1Rp+ryIYfNIrncQnGsSkU5+PschK23Q83KkSbF2RQCjq+kSmZRNTvV581BweiUUPD
         Lr5wzstxVvR4PtWuU46ZLbwnnbqGetidCqMKphVrsC8t+9QSZmRoS3js69yB1UiyxluE
         EnAzLWFXbf9d1USnmxZPv8orb1Ji2ECeBysjGX2ZuVIcMcCvdT1fyRWJM4ktYIKRhFTi
         dmVUysDPP8XFsIjLNa819WCemTvPwNgj1XgHspQaJ2Bf6jBZSeWtZ4hvOOe3b9sF3dgd
         nR2EKRpVCwnpEUr2kCmIiGw0r6bBH/8sXTdCuqMQvM5UayxCoLqkTngic2aC8stytkZ2
         IdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zlQsn4wsaWAW8EAhCQwYiJmyPHvMgVpERAWE7MX+/I4=;
        fh=49moqUCosSNTOuet7KwXEaGENwWlMOX20zIqmNRQdXY=;
        b=W5dUqC1o+tccP82NPYy8xzsThRzvnA9aSW8O2g5wp+LrVeBCBXq9776EGnZ/LVejGM
         cqSp5NLy4ChRpPtyTgUqk346nkqv12AmNul5tdKcQoM9k5tl1dbpOFnTtZO+K6azpAPH
         2m9UWglRfWrT0tDB5k23/8VHajXLY1HH+6iHADHafEgiok5EZjS/Ba3EYEZf7H8WI+uW
         S7uGmVoc1ty2sRUCVJQIUQKsMwYUYdgz3m47NaprOKObsg5Zm6RTsIuExIfjztGH8Vjb
         KIDfcxSeoxPbiOjhK+JObAp7AXmaoPrmMMmav7FUM0u2tORFqgfeCsXv6HnIL1odCAct
         o8Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771617504; x=1772222304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlQsn4wsaWAW8EAhCQwYiJmyPHvMgVpERAWE7MX+/I4=;
        b=cDnpvc0D1tWT3wwS6OlKlPJx0vGlqMQp1NZxoZPSN5oU/oca9xBHNeth0gUVL1gdXI
         CY/gPinEFpy6Oo1uwhdw+JeitN57llQDgvAeaetoFWyfTAFlCKpyaAJWV2cVd6ZDhKe7
         vfxiHM8liGQ46stnqsok38dqMVp0iD1ry3Tr+elwH/jMgKLA4yQYHdKRl9VmvTn7DEW+
         MgBl9zcdJTWSL9tRhYZOOARGF/Uvd5teF/TE9W+6P6pEQvQoC1i5poM8jntJycjCahNB
         hIxmFlyHKk/Djr5bqCEbU9wG5Y8ty6LklYatgS+PoJLG5sZhxGuHv1XzY1HA61wGbQ3m
         wZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771617504; x=1772222304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zlQsn4wsaWAW8EAhCQwYiJmyPHvMgVpERAWE7MX+/I4=;
        b=pbx+VBZmVKBn62EfOIiHpGCeN+7phmFhHUUF4uZOSAH6MUgE2AS9o3SaSNAiQqct5t
         yEGJUNMJUGb+Gws/aDqZNiKzZkHAzHK6p9v9r6dvywY91XhMGUNENiAKlnhJDVONl2jW
         bOXOcPxSf4Srskcfm2tAQSpBOfQUpitqAxETkpsyzw2w/bN7lNcGibh/TFrBJogmD+WD
         9TAEtF0aRh4y5XU4/DsP/haMfuXnZSKkZuKqIXV8xrkrDcLViGm3054mnzUpnsAC4YCJ
         QJCBMF3WSNqM08Dfm1PP050qbYN0kZFXB4qw+h3eXHlNzAdZH0DHQqo1N3ztpvzDDUka
         0cjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdigfH2UIwjS9t1poy2vnBhIW7nyqUJNlZo6rZUG+Gf37ziiDd8VoBEh32uk5+nhUWwB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhkhHOD0DlmZJpvxZghs9EH26lnGz7t23yeVEynWJiQm/8KS+C
	yrL/PgzkDCTBzZYo8oI2hnYACZlteKiHeBNr1AIim9vgTPWxlS672dlQqrlQ4GfWgdy/cQdwO41
	77jbJUZoR1pv8pu9MJ11tSHssMPG4+E4=
X-Gm-Gg: AZuq6aJ2Cx4Dp6MR21hFJcHXQOf7+QOMyK/Mjqzy7TeEMdpgulBcub7Qx1HbvuVWjuq
	bUsAA2t26rmNk1HdELPNituHMBeQBg360zRp0QoKydAh/7nl8oLSOoYx4gjgYZoKyOlXfX7+jTa
	YZe0zO+9QM16GFbmUy52DOVyB+7c86i6SysIM2WIJtgU2PIouthW5DtsRU4svfFHrH/2lR55QlZ
	sPp5hP5PvlS4YkhyC/ifkVCbh3kGeMd3OkYjDLJ+8nPsMYwyEAJqoySAgzo/uKy2QGb/MmGTDVZ
	IfRIwaYcqMTOd8i6yc9WHfCnRm+lbIjrxSA7jZMSjGXJzdEFjxgIcB4dRpSwKHN74HU5T5Dre7n
	R2RegQgpbrWmJOTc7sKA6Byib1Q==
X-Received: by 2002:a05:6000:250a:b0:435:930a:658e with SMTP id
 ffacd0b85a97d-4396f185229mr2143650f8f.53.1771617504068; Fri, 20 Feb 2026
 11:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220100649.628307-1-jolsa@kernel.org> <20260220100649.628307-3-jolsa@kernel.org>
In-Reply-To: <20260220100649.628307-3-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Feb 2026 11:58:13 -0800
X-Gm-Features: AaiRm53yJlgIUaOKlEeU0wWFR_fe0BcxCEhJ3xRsyeMkCpfXjYK3sNvWKnaBAqY
Message-ID: <CAADnVQ+2-DtgWqeKmrbsP0O7Rz2ZkDjkh1kfHDSxF0K8Xs+1ww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/17] bpf: Use mutex lock pool for bpf trampolines
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 2:07=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding mutex lock pool that replaces bpf trampolines mutex.
>
> For tracing_multi link coming in following changes we need to lock all
> the involved trampolines during the attachment. This could mean thousands
> of mutex locks, which is not convenient.
>
> As suggested by Andrii we can replace bpf trampolines mutex with mutex
> pool, where each trampoline is hash-ed to one of the locks from the pool.
>
> It's better to lock all the pool mutexes (64 at the moment) than
> thousands of them.
>
> Removing the mutex_is_locked in bpf_trampoline_put, because we removed
> the mutex from bpf_trampoline.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h     |  2 --
>  kernel/bpf/trampoline.c | 74 +++++++++++++++++++++++++++++++----------
>  2 files changed, 56 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cd9b96434904..46bf3d86bdb2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1335,8 +1335,6 @@ struct bpf_trampoline {
>         /* hlist for trampoline_ip_table */
>         struct hlist_node hlist_ip;
>         struct ftrace_ops *fops;
> -       /* serializes access to fields of this trampoline */
> -       struct mutex mutex;
>         refcount_t refcnt;
>         u32 flags;
>         u64 key;
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 952cd7932461..05dc0358654d 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -30,6 +30,45 @@ static struct hlist_head trampoline_ip_table[TRAMPOLIN=
E_TABLE_SIZE];
>  /* serializes access to trampoline tables */
>  static DEFINE_MUTEX(trampoline_mutex);
>
> +#define TRAMPOLINE_LOCKS_BITS 6
> +#define TRAMPOLINE_LOCKS_TABLE_SIZE (1 << TRAMPOLINE_LOCKS_BITS)
> +
> +static struct {
> +       struct mutex mutex;
> +       struct lock_class_key key;
> +} *trampoline_locks;
> +
> +static struct mutex *trampoline_locks_lookup(struct bpf_trampoline *tr)

select_trampoline_lock() ?

> +{
> +       return &trampoline_locks[hash_64((u64) tr, TRAMPOLINE_LOCKS_BITS)=
].mutex;
> +}
> +
> +static void trampoline_lock(struct bpf_trampoline *tr)
> +{
> +       mutex_lock(trampoline_locks_lookup(tr));
> +}
> +
> +static void trampoline_unlock(struct bpf_trampoline *tr)
> +{
> +       mutex_unlock(trampoline_locks_lookup(tr));
> +}
> +
> +static int __init trampoline_locks_init(void)
> +{
> +       int i;
> +
> +       trampoline_locks =3D kmalloc_array(TRAMPOLINE_LOCKS_TABLE_SIZE,
> +                                        sizeof(trampoline_locks[0]), GFP=
_KERNEL);

why bother with memory allocation? This is just 64 mutexes.

> +       if (!trampoline_locks)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++) {
> +               lockdep_register_key(&trampoline_locks[i].key);

why special key?
