Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240084E1C73
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780902; cv=pass; b=ntWHBfVRSsumCXIhzlu2yeA3b7ILkphMVV9ATwMqsn4mGqUfq3rv4qfu/Ekp+bR17QC6LGG7flD7aAVBpgAfHUXWwckFXrmSMKzazrDd8RwSoPAlMAfqlQ3WkMcOIFa4+1byXrG3R47HlWk+zvc/TdJ51FxxRWm7iUzVJxaL604=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780902; c=relaxed/simple;
	bh=hT6uKFtdqOcRXKAyppkXaaDZAfO63Yhh/JoACrj3WRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0Sv5AsBls1D79rL+FO2Bv0lkybuOuMVlw+jzRnvvErNq5S51TZFcPvrIUGknO067HJwub+G9Olh7bHg1cvS4Zn7OZH3PRA5MPaLaVSXYzXaV55xVBNLnKfT8u96R6qlG4p3KVRuFNXFYcIrzmbLqWVWqYmCI8RudE5uZQ57Kbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJlmgC4A; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJlmgC4A"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6ae185cc40fso761930a12.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 08:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790780889; cv=none;
        d=google.com; s=arc-20260327;
        b=ka3GMEKph3+uKNy0XBb+GuBvYi84hIza5KB5G+rekmkyyfIIyKnLtUINqJoP9rTPai
         eelV0zN03iE4UUMpbzxhXeTe+GvcTak1jxs+6sYUh+1vf1VIOh17XA+jxCLCLlWjzaQe
         VkIgVNuknQ4bxkUQyhjGPLreu8w9MU/LaSqjSex3YKMsjSXFX23+s+nU6f/nGSBhKrO2
         XJ57ZhOQl9mV68wFOKUKX+SNBZaR55tMZnwC47x7VK0JwibuMhYaxQsGaJtwlicjbOaQ
         SXXFGDZbiBQXsnR2LmOPV+8LHwlc/EJxNUWJG3HAQsP+qPkzwxVXR9Ebh8bfUKYF8Hjp
         DojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NaO1mAirnPnJy57tYk/9v6vRmGk3M0eQnaIUpib3e7I=;
        fh=sTnyLJWU5V2UhHQ9C/gjh2Vd9xdkKp3hkesbBZS826o=;
        b=rmns8LHjIOYfVBqbVkO8M8CnFuppgKHCjD+7gT7pixarVlAyS17beWqqCTxjYJDE9L
         5h7VHuDG9sgf55q+2qFKwcUdupnpiupfEbhw5Rwpf5GBO6XUAyjX3AxW1YcaW1yBrMgQ
         KK4llvqHKyTUeHA5oejnQplXRZHtet18/l6POkIl8+NHDMmt62DkxYCwIQVy13HN+cK5
         rf6CyGIBzmzFZ3JPXtls98p2nEqMEbzmQYRji4UJEZGzqd5iWx02dflqre+aphn/X28s
         NyNkQDsAwTkwKbl6yvg+sItsZ50gVpNMFeFj70zvfR5V5M12mq2ve//Xjej4tJOAM+rO
         6HrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780889; x=1791385689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NaO1mAirnPnJy57tYk/9v6vRmGk3M0eQnaIUpib3e7I=;
        b=iJlmgC4Az06kmQAbbfD9zbPJsV9/ylzCsEQbvsJ+MV/8PIGfPayTaXW9kb5f/Cuuhj
         OapNpxXGKNN8j0TVKGWz9pUZ9a/ykvwHM0Xhp/eUCDxmg1lENLal5MakTWShYfY1qqC9
         hheETli6dYI9nX7Q5+/vL885hOk4VnPYxwQXENBb6h0LiSl05+3TOOO5mtCqn3YUu7hJ
         BGoH1+SDzsktVDBoNzAkZtg+3jltOvrm+SpWuD3ec7b1HODqB5zQPML+TWOm4aFBWCWZ
         7GU9zjOwFGOfJDhiH3BRJq7VaDK9Ubfen/30XVS+O21N/Wp//+Iq87oduyO0KdZ8wnS9
         kKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780889; x=1791385689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NaO1mAirnPnJy57tYk/9v6vRmGk3M0eQnaIUpib3e7I=;
        b=rsbQi9yNrUjQ2RpupJVeVowNC+BXhcI9LB7VgVpEZ8bC6uT6cnWBKjneZ5MrWZAddJ
         1WxBEVsm64adUDQdUAkQUsg4FEd1eq44zFEX1tguGIKFwsifbJydhJ5Uwf2wQI0iqive
         DA1iX9oLhe5tAWY2jXk/YEtkr+q62hPqBA9FxUdICkstyHieZluJNZWrPpznS2VIuYa8
         GpYZ8q5oKE+Zch1EzOZyGBHTON1Apn4/HpKVQ/SV9Sdw1+Y2rz3DMluebZZmep0Da8bC
         mhwcn293FXohPSt54tPz8I0/I06Ifgbhg2dCtYXJlMB+VzSFV4qZH/rgIx45LzHmpCSU
         Gc7g==
X-Forwarded-Encrypted: i=1; AKwUvByQoZUwkkEY8nkJWI2dkx/Ty6F1SdZYTPL0WgfKRxj8hO00W5ClHqT9w4RMh7Gl4jXvOBw=@vger.kernel.org
X-Gm-Message-State: AFuF++lsdFW6AEu/P6MXIgbhPuKlOFyb+xKVuV+xPEmfkYDZTjTV+IM+
	HGGowWQVpfnlRV27FnTjQzjdj8GSHWLoxdhCKvKkCmD3NJHXmrtd7XDI5mifl/y4knhcr+JW1B2
	FqMdkxeSvVKCAXwXYe9VeVHMPhroTp6I=
X-Gm-Gg: AYBFou2IlBrGa9m7VWTuaIzYeGnZXg7kGJYXk0TMkrpZ2kJxa7qfuN28REUe10OFu9H
	OOEezVzAE6Hf7KXQQ3f0itT3zv1GZZWSZofjXjpOMTxF2rv2XyQ33ryHFc5STPKzmXRUrOXFsJy
	awKHfzRo5RHHLrwoPzHDipnjzp219oHXny+t+QYWg1XBHK392SNjkT5DjzvIWzwSBqKPqwiG+ka
	EJ1YVvg4kxVJjhCHK0hmURlX/hVI6dnqnwW1OSDBDcGdU0ieTE/JV0cRrO60QC4CNGKux2C+ski
	TH0fD6lY1NaopL0Gd7xjTZvyeBfYvQHQFKRYwjhSyDS0WBdASopkBXPy
X-Received: by 2002:a17:907:3e1a:b0:c2e:2275:1168 with SMTP id
 a640c23a62f3a-c2e23d9558amr152172866b.19.1790780889315; Wed, 30 Sep 2026
 08:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org> <20260930-work-mount-fixes-3-v1-13-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-13-be34c83956ae@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 30 Sep 2026 17:07:56 +0200
X-Gm-Features: AclHuK9qZXCPpQtL11D39UCo-F3cSnL8zEaPtult057jKkP0CoRv6AK3ktwziVg
Message-ID: <CAOQ4uxgJq_UsqfAxJGtnyeyyoB=2XD=UTXp1Lgr-Ze+XNKPVEw@mail.gmail.com>
Subject: Re: [PATCH 13/17] namespace: remove the fsnotify marks of a mount
 namespace in process context
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <mason@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:32=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> mnt_ns_release() drops the last passive reference of a mount namespace
> and removes its fanotify marks via fsnotify_mntns_delete(). That takes
> the mutex of every group with a mark on the namespace and the spinlock
> of the connector. Fine from process context. But mnt_ns_tree_remove()
> hands the reference the namespace was allocated with to call_rcu() and
> so the marks are removed from the RCU softirq:
>
>   BUG: sleeping function called from invalid context at kernel/locking/mu=
tex.c:623
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper=
/3
>    __mutex_lock+0x113/0x24b0
>    fsnotify_destroy_marks+0x11b/0x3d0
>    mnt_ns_release_rcu+0x57/0xa0
>    rcu_core+0x6b6/0x1e40
>
> and lockdep complains about the connector lock being taken from softirq
> context. A fanotify group with a FAN_MARK_MNTNS mark on the mount
> namespace of another task is all that's needed. Root in a user
> namespace can do that for a mount namespace it owns. The task exits and
> the namespace is freed with the mark still on it.
>
> Remove the marks in free_mnt_ns() before the namespace is handed to RCU.
> That runs in process context once the last active reference is gone. A
> mark is added through a file descriptor to the namespace which holds an
> active reference so no mark can show up after that.
>
> Fixes: bf630c401641 ("vfs: add notifications for mount attach and detach"=
)
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 0a7d50db228d..3c90d853e091 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -130,7 +130,6 @@ static void mnt_ns_release(struct mnt_namespace *ns)
>  {
>         /* keep alive for {list,stat}mount() */
>         if (ns && refcount_dec_and_test(&ns->passive)) {
> -               fsnotify_mntns_delete(ns);
>                 put_user_ns(ns->user_ns);
>                 kfree(ns);
>         }
> @@ -4279,6 +4278,8 @@ static void free_mnt_ns(struct mnt_namespace *ns)
>         if (!is_anon_ns(ns))
>                 ns_common_free(ns);
>         dec_mnt_namespaces(ns->ucounts);
> +       /* the last active reference is gone, no mark can show up anymore=
 */
> +       fsnotify_mntns_delete(ns);
>         mnt_ns_tree_remove(ns);
>  }
>

The question should be not if new marks can show up, but whether new
fsnotify_mnt_ events can show up.

I think the patch is still correct, but maybe change this comment or remove=
 it.

Otherwise, feel free to add

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
