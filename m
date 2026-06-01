Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39815306754
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780286345; cv=pass; b=ZcCCb790EnQpzuaQQOuA9nDVGsiW77PvLWT5GbA3EGkBnCqZulR/gfy3TXkSDPVAphJpz0xoVNwtDTc7JNrdLth8xyd/rVtXM9lQpm9Pq/VJmwMyfQIBqx6umamASWwRrVlsL5lN3nTbn0mCRR7mvoXWbY00sYSZh6N7m7iIAJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780286345; c=relaxed/simple;
	bh=R2gda0sh3Y9ZKjnqeBHRoWIg5TBSqprzO9+faDr6yYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sC39KIfqTF56BKnWyfKFHVeZkvtB7OY5xcioPpyAdgv1EkNjgCT5oagH/ftr1LgejODyjtLkrgWrvrmLAzQgAZusRwpOP5vJVON1pIxAUArOccePfEnreY7cdpvZS3huaVVFwAN+Kydtg1gdxAPmk0X7O4cn4BkAFRBAu7w3jBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fgqc1Gu/; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgqc1Gu/"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-46013161068so82941f8f.2
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 20:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780286341; cv=none;
        d=google.com; s=arc-20240605;
        b=S6vtokZvZLsZkkHhNeOO7qlWtWOBvrL533344gXmEFcDc5b8LAFkuQkEy+UyCjIpGQ
         hGZwBuU+4KeLZHAIGTZzlqPej4qVwRNeZM0/kLU/aw8w153fxsuminlFvectjqpqXLG9
         0GfgYHovMWEqzIiUMtRUqJcSDJjd5YH/ekzJLdd4bleaJlWOVmEkOeQVC6twptqMFgvT
         5+nH96GQ7zbCEpx2h4Jp/C/GqxZ8IOXUnKOQ+E2tRgG/OB7j8iFIN8BIsjSygELYE0vT
         d5ug8jsqr/ukD9EQKtjLmeZ7YTIWTc1KY+G+IpLs73RVRaWR3mu+yC0B4jUKExW1E09U
         HGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jNudWB04Wpw+ZJC/nF3aN5jO9/6RuxUwPuu638+/KJo=;
        fh=TlfPYPjJM1udRLgEKD4JYV0cRui9K6vBhn3xESWnDCc=;
        b=ghYJ4Qlmgsx/PI+puBZtin6sQbgg28/ZkhLF8AGC6KwqOC1nZTOkuXMLTLVp6QVmln
         /lcFfrYrB3ySjfbNKMw3pMiNeJW9VRV/igBkdw5I9xkUKEb55PH5z7hd4pu5hG6eH5YX
         VJXSBLhUKaA2kjbWnR9mkP7xZCWoKuAltz2t1NsQLlRZSAXRbVA3IMd0f3b9IQiBMlvi
         HPpbPm7naJbvyOg/4oH5RpeWY8nAMTKKW0uTabw8IksTvLdS1kY+Efe+9ezxJNxS9h6s
         fizzDY3WOFiAwT+4xtH3Y75ENgsTaOF0kNqWh+Uqr9aUSRFJBVxqudHVq+42rZi8TgGT
         HTHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780286341; x=1780891141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNudWB04Wpw+ZJC/nF3aN5jO9/6RuxUwPuu638+/KJo=;
        b=Fgqc1Gu/Xkd5+sMJsaLzfKOZjEHXvGArgaq/+X1LKPNno+gEfoWhSrTTHoUE1uodah
         I20jX+LU4P6h8rnN/oU7jfVjVeBsRu6jx2Bu1B91SvQfPUPf8HTuQh7/KlmGR69/GEVj
         FV4f9fQdbH5FLsZn+E6oEHu5nWVyLRQVhMJlUByS91aMMxqTOtspdEbRMQlqw+DVpxP3
         2JzR/jEW39qD/bm9nvPsfKBsW8eFSMh8AEbWKB0hfPYYI/MWghSv4j/iZvreV9RBg/2+
         tQ95HFqEKdFG7WjdaidMpS+tS1UMulSPd3GswQJIbVS9vbQ3CRk2zb3S+xpkTHRiEnNv
         WCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780286341; x=1780891141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jNudWB04Wpw+ZJC/nF3aN5jO9/6RuxUwPuu638+/KJo=;
        b=iKH++xvRTp6iF5upv2+sIO0XFEfKRQWrJ0BE6shgs05W+pLRW8wILWEwNLr2GGvdZ1
         HzxocPYxVSkj9tfVmCnjPL+DIzyqHWNP12mWX1a7ZVkwpblu6vjn+2pW4nu+TecyO2Ie
         XkMYOw9/ddyXDjDo8DvjrYKqBnv/e3SqKNWhloZnjXHrzecy51cYhqzz4gQNsIP0afBl
         pXbIOXwcWxiH1JvUbRLW8kZP7RW4aw4Yr42XWXcgWM7iYqR5yA6OIUXyukaG/znAfr5/
         68P3hz6FR3Ty18d3PvtKj1i1Sr0JFpFMZCl/OsA7qxJ+xfE9sXCauaU+Upq/lQEU2ZQh
         FYWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p+72V7xnxLdMHFHw11oJcUmP6Vf7/PQKYkXMjdpKxL2AywedBM4LcDfo7VC5pNGAHQC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ssge4P2fNwc8/jK1I1I8qnfjQ6HzKBsKiCJICNzlDuBXUj01
	VXefINm3gqJ6IA3ZhsVC8sQYnm4R99mbv6H+2xN2ACyMWE8fAuTh4nDPU2GBoc2vySue2s85sZF
	GmEzMiiGjttN4RMhNP3xwRKhH6+6IcfU=
X-Gm-Gg: Acq92OEK43/VjjvW0YvTUtLX4gYM8tAWG6BnXBSV9y5qA353EpW7mvb4UeYPUabUORt
	06owDDlsXzI2GniqdI25uE+zVzkEcr5BWA1si5bw02eATWeAZhthkTZCGNgxkIBz+9sdMm4JUnb
	JF7dvsLS0TWGeED3p8VMuzrB8+yus5Mkk9WXmuZ0pMigW2DY0afyl8HWP1jzXyMk0i6WjZPQZRi
	4lkTEhc8aFRXtDxtAFGUhBLD7faV8w2z4po8dpI8uz92cFxLU5YrHT2H+A0oQA5Vi8PYCfgf4Xp
	jKN6x6NEZcr4uVkwQmTDOoGFvyDYFNEQ+Qq1lckwxZqVQgBQKrA7dZILbui/VfH+Twq7dynsi5V
	eyQ==
X-Received: by 2002:adf:f78d:0:b0:45e:ed7e:f8f8 with SMTP id
 ffacd0b85a97d-45ef6b0231bmr12455650f8f.8.1780286340409; Sun, 31 May 2026
 20:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601030649.2513937-1-hushijia1@uniontech.com>
In-Reply-To: <20260601030649.2513937-1-hushijia1@uniontech.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 31 May 2026 20:58:49 -0700
X-Gm-Features: AVHnY4K4C1soJyFxmMVHHhTiOD884427RYesf2FVX6XxkT8y6UJ_fmjeCZLuc_U
Message-ID: <CAADnVQ+=-UM-JC4eM=vqvgK2tLt6PwmDjOcrrDG9kz8BV6n49Q@mail.gmail.com>
Subject: Re: [PATCH] fork: Ensure copy_process() returns a valid error pointer
 on failure
To: Shijia Hu <hushijia1@uniontech.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, stable <stable@vger.kernel.org>, kernel@uniontech.com, 
	Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>, 
	Kaiyan Mei <M202472210@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 8:08=E2=80=AFPM Shijia Hu <hushijia1@uniontech.com>=
 wrote:
>
> copy_process() returns ERR_PTR(retval) from its error path, so retval
> must be a negative errno in the range [-MAX_ERRNO, -1]. Values outside
> that range produce a pointer which is not caught by IS_ERR() in
> kernel_clone().
>
> This can be triggered by attaching a BPF_MODIFY_RETURN program to
> security_task_alloc() and returning an invalid value. copy_process()
> treats the non-zero return as a failure, but ERR_PTR(1) or
> ERR_PTR(-MAX_ERRNO - 1) does not produce an error pointer recognized by
> IS_ERR(). kernel_clone() may then dereference the returned pointer.
>
> Normalize unexpected values before returning ERR_PTR() from the
> copy_process() error path. This keeps the fix local to the fork error
> handling contract and does not change BPF_MODIFY_RETURN verifier behavior=
.
>
> Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN"=
)
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/973a1b7b-8ee7-407a-890a-11455d9cc5bf@=
std.uestc.edu.cn/
> Link: https://lore.kernel.org/all/20260411163556.8567-1-yangfeng59949@163=
.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Shijia Hu <hushijia1@uniontech.com>
> ---
>  kernel/fork.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 8ac38beae360..40bfbdfffbdc 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2599,6 +2599,13 @@ __latent_entropy struct task_struct *copy_process(
>         spin_lock_irq(&current->sighand->siglock);
>         hlist_del_init(&delayed.node);
>         spin_unlock_irq(&current->sighand->siglock);
> +       /*
> +        * The error path returns ERR_PTR(retval), which requires retval =
to be a
> +        * negative errno in the range [-MAX_ERRNO, -1]. Normalize unexpe=
cted
> +        * values to avoid returning non-error pointers to callers.
> +        */
> +       if (unlikely(retval >=3D 0 || retval < -MAX_ERRNO))
> +               retval =3D -EINVAL;

This was reported earlier and there is a fix in the works.
This approach is incorrect.
You have to fix the root cause, not the symptom.

pw-bot: cr
