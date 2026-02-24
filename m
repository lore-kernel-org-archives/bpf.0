Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B252D372D
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961606; cv=pass; b=KNm85g/XS7UbAhwc2GRLxP2szePwMrDKcgd/7rpbUIhyr7SLetlLxx639Tfcv4LjziPk9B+4w8o++1g4cDOJY2ilJVLV+DpSD1D3EUWocarMRBVIkneuU7XvFy2TFAoOwWuR7S1TS/lyKt3wo4IpWIIL+Txmp3V5fkXzaFjCvzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961606; c=relaxed/simple;
	bh=Qi3E8lxAiasJoxhjDairTt0suuDxo1NvocxikjcwkxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obXrVcR8JD1XJIMH7e+xiII/xZrNtCldboTPd5JU4/bIR94L+bhbZvEf2DK5+pNCHEepark3xgRlQzosukb3jf9YEndqz1GL9uXEYyyha+/Cio9z1fVIXQprulw55Hk0tUH/Je7/Y2Z5DiqJ7+Vg2VCBbI3e9fYeQ5ZwclULzOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFQ6BWez; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFQ6BWez"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a321cc53so67643271cf.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:33:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771961604; cv=none;
        d=google.com; s=arc-20240605;
        b=UuYd/M7NcPEioJjNpXzWtCrqQ6ZbGeCnl7jesJuS/pRTS3b2pAUfb3uAgasNls6LP2
         WtSod81w75x8v9Y2acxBJrrOR/HzbDg8YrQi0BNFU//NNqP7vqnmbZ3EpXzUAbbSsPQl
         u8xeUrCpQyuAsm6hHqKFMQBYOwf3JteEQRSCihuPqD4WlmeP5mblae5ak+gIXjWkfTcd
         TUau9uUaQkcb24R80ZB2bsrBnn9HJWtRYpYiaXOQ6957ueX5yewiFfb1825fMr+44WiA
         acMD5vWoYcbsLXk+9WpX+jKjDk3sN6ZClP0HkaBeFsACtMwuunhOjYJ6zcXRbXBIggsG
         dL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fpmiCKHcBcH02P89/1LkI481lYphcfAkiuIQq/g8bh0=;
        fh=4X4Bh8ahNurMEde+Q+6L9p7H5FiEQ35jtVFrRjue9rk=;
        b=S7uXmLoka1jfyw1qdsnvAazBV6A7heMIDl/y1wQ7SPk+xWrdEAkDBzeYHUoQW5VFtO
         pyceXUWwVOLRsN26RFrHftfdmjPP6HFTg+mhD64IDvwuJC7WYxVcFJLVk3Tc9C9ew5tf
         JCAnyjAGqo+qf86pzxz7NhB1oiY74u6eylQVyFteDjd/tq/nHaxWw+WPGt/shLEW2os5
         XxDta/q4OcMS2myM7NyXMrZdLsMLPEQNa/iux18OFVMB4S6RtyksRSjVyPINVfe9viWI
         k3S0ZddW+/cv9h8gQWZYoL2ocpORfIDyeTDqhXsDkmmILEHlaliCwlv/fg+b+OQoeHO1
         pf/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771961604; x=1772566404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpmiCKHcBcH02P89/1LkI481lYphcfAkiuIQq/g8bh0=;
        b=JFQ6BWeziykqAsXWvcGXh2Ym5Zg74nB2GmuM+cvwITUZkMXD4nGijTLw3eQ+WNFW2H
         EnVVTMYuUnR9wJj3cCFOP8wRpm/Mt7pjiWYm4Wfvye1pxzmStIE3of+HnyxOfFQNfj6C
         BgWmTDzwmagG+PzcLRHp31r+Sstu1goidE1TAOmt9FIpwC5jeyoYnkmoolbvNJl4/IsW
         EOsnp+9qNBc+iyE5g8ZEnw7Y/E3O8G5UNwAGAaoruskTJefHJ2VWkg6Ap3PZzAZfkPQW
         KQBADLt4JPid+79bWQXsP7ma1qs3040ZRqFc/yxetxIfbpFLw6OlKuwIlU6QZlId9vNB
         YDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771961604; x=1772566404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpmiCKHcBcH02P89/1LkI481lYphcfAkiuIQq/g8bh0=;
        b=s8Xfqwh2d7P4OrGKcw2xmDixLdAKVdGOuuAT+/G6RyF+H20lAot8tG7Ig5mfdvr1/N
         oAIGaOQ96rk8WiuPut3g7U2SojY8WNGjDOf5AIoM8m2vkrWgAFUiQKqlw6Oviv/JTxlO
         xYa1Tr+SoOrUg0gZNhrhmND+rz0j3f5XNxBqHozl3/lwjqIiAor5laqx7fhwotErJDa2
         jzT2UB8nR5QFamu0UYqJEyzMLmVQFfaskCyixODabSuMOsWvH/ZROBkJeLpQ9EaqJZhF
         ZwnyDCna1mvZodSIZlrpY00OGLLtopEGz7+cLQ+39khtrSuhBRcZrO3HRoqX0rRTC99R
         8oSg==
X-Forwarded-Encrypted: i=1; AJvYcCUTOaClgD05ahHUleDOyGZDhUsT04tEbMTUodeCjd/qQuhuZFO/0ilIKFgcJaIaKntpMe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yaKjBeBQiZRgjHbxe88mwmKa6buqRUllrNxC/wVWl7Sgyx7m
	HO0AHae+mfMg3U7BOZGeH96PVJwLKfVP47wEarXf85E+r44BFA8xiHu1QPorrto2WigzOHzTUvV
	6gc5adXUJ9L91T98CtHQ2EIRT9/gq1nw=
X-Gm-Gg: AZuq6aK6p+hC1G/CppTfoq20QxSI+CrJUgEz4ks9Xqg5eEegpohrS06gjdmJg69OEJd
	vG/97jZ+3s5h+1sOQAqdsSr6ZXPD3+fh4iX4exGXUZtNvIvVrKCD+yAVqc0f/5hApmrYBgjg019
	4Nich4+wSQa6YaR7idVzlyPUCsz462rw9rUHLhg8wQSExFtYDyGHWqYODoaYQfhBfxGHBf941OF
	EqTAj94aCWf2ByCU+jcLTu2NMuneWRB6cyiUbs3XdAw04bahqPqWZ4xCdCFe3X5k2jgqA7zPv1k
	g4GRlhO6zF1Yy0vI
X-Received: by 2002:a05:622a:164d:b0:4ee:2721:9ebd with SMTP id
 d75a77b69052e-5070bc737a6mr173920921cf.45.1771961603601; Tue, 24 Feb 2026
 11:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733133.3935219.4620873208351971726.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733133.3935219.4620873208351971726.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Feb 2026 11:33:12 -0800
X-Gm-Features: AaiRm50-VsLD_zmLLD3udHzp2NCTKRbMnT9y8JS0gqm_pLEzk3Fb9cwmor2ZxsM
Message-ID: <CAJnrk1ZZ=1jF4DUF-NyedLP-BJM_5d3s0zfD4oHGyR51PM9E7Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] fuse: flush pending FUSE_RELEASE requests before
 sending FUSE_DESTROY
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bpf@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 3:06=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> generic/488 fails with fuse2fs in the following fashion:
>
> generic/488       _check_generic_filesystem: filesystem on /dev/sdf is in=
consistent
> (see /var/tmp/fstests/generic/488.full for details)
>
> This test opens a large number of files, unlinks them (which really just
> renames them to fuse hidden files), closes the program, unmounts the
> filesystem, and runs fsck to check that there aren't any inconsistencies
> in the filesystem.
>
> Unfortunately, the 488.full file shows that there are a lot of hidden
> files left over in the filesystem, with incorrect link counts.  Tracing
> fuse_request_* shows that there are a large number of FUSE_RELEASE
> commands that are queued up on behalf of the unlinked files at the time
> that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> aborted, the fuse server would have responded to the RELEASE commands by
> removing the hidden files; instead they stick around.
>
> For upper-level fuse servers that don't use fuseblk mode this isn't a
> problem because libfuse responds to the connection going down by pruning
> its inode cache and calling the fuse server's ->release for any open
> files before calling the server's ->destroy function.
>
> For fuseblk servers this is a problem, however, because the kernel sends
> FUSE_DESTROY to the fuse server, and the fuse server has to write all of
> its pending changes to the block device before replying to the DESTROY
> request because the kernel releases its O_EXCL hold on the block device.
> This means that the kernel must flush all pending FUSE_RELEASE requests
> before issuing FUSE_DESTROY.
>
> For fuse-iomap servers this will also be a problem because iomap servers
> are expected to release all exclusively-held resources before unmount
> returns from the kernel.
>
> Create a function to push all the background requests to the queue
> before sending FUSE_DESTROY.  That way, all the pending file release
> events are processed by the fuse server before it tears itself down, and
> we don't end up with a corrupt filesystem.
>
> Note that multithreaded fuse servers will need to track the number of
> open files and defer a FUSE_DESTROY request until that number reaches
> zero.  An earlier version of this patch made the kernel wait for the
> RELEASE acknowledgements before sending DESTROY, but the kernel people
> weren't comfortable with adding blocking waits to unmount.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Overall LGTM, left a few comments below

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/fuse_i.h |    5 +++++
>  fs/fuse/dev.c    |   19 +++++++++++++++++++
>  fs/fuse/inode.c  |   12 +++++++++++-
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d15e..1d4beca5c7018d 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1287,6 +1287,11 @@ void fuse_request_end(struct fuse_req *req);
>  void fuse_abort_conn(struct fuse_conn *fc);
>  void fuse_wait_aborted(struct fuse_conn *fc);
>
> +/**
> + * Flush all pending requests but do not wait for them.
> + */

nit: /*  */ comment style

> +void fuse_flush_requests(struct fuse_conn *fc);
> +
>  /* Check if any requests timed out */
>  void fuse_check_timeout(struct work_struct *work);
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 0b0241f47170d4..ac9d7a7b3f5e68 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -24,6 +24,7 @@
>  #include <linux/splice.h>
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
> +#include <linux/nmi.h>

I don't think you meant to add this?

>
>  #include "fuse_trace.h"
>
> @@ -2430,6 +2431,24 @@ static void end_polls(struct fuse_conn *fc)
>         }
>  }
>
> +/*
> + * Flush all pending requests and wait for them.  Only call this functio=
n when

I think you meant "don't wait" for them?
> + * it is no longer possible for other threads to add requests.
> + */
> +void fuse_flush_requests(struct fuse_conn *fc)
> +{
> +       spin_lock(&fc->lock);
> +       spin_lock(&fc->bg_lock);
> +       if (fc->connected) {
> +               /* Push all the background requests to the queue. */
> +               fc->blocked =3D 0;
> +               fc->max_background =3D UINT_MAX;
> +               flush_bg_queue(fc);
> +       }
> +       spin_unlock(&fc->bg_lock);
> +       spin_unlock(&fc->lock);
> +}
> +
>  /*
>   * Abort all requests.
>   *
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e57b8af06be93e..58c3351b467221 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -2086,8 +2086,18 @@ void fuse_conn_destroy(struct fuse_mount *fm)
>  {
>         struct fuse_conn *fc =3D fm->fc;
>
> -       if (fc->destroy)
> +       if (fc->destroy) {
> +               /*
> +                * Flush all pending requests (most of which will be
> +                * FUSE_RELEASE) before sending FUSE_DESTROY, because the=
 fuse
> +                * server must close the filesystem before replying to th=
e
> +                * destroy message, because unmount is about to release i=
ts
> +                * O_EXCL hold on the block device.  We don't wait, so li=
bfuse
> +                * has to do that for us.

nit: imo the "because the fuse server must close the filesystem before
replying to the destroy message, because..." part is confusing. Even
if that weren't true, the pending requests would still have to be sent
before the destroy, no? i think it would be less confusing if that
part of the paragraph was removed. I think it might be better to
remove the "we don't wait, so libfuse has to do that for us" part too
or rewording it to something like "flushed requests are sent before
the FUSE_DESTROY. Userspace is responsible for ensuring flushed
requests are handled before replying to the FUSE_DESTROY".

Thanks,
Joanne

> +                */
> +               fuse_flush_requests(fc);
>                 fuse_send_destroy(fm);
> +       }
>
>         fuse_abort_conn(fc);
>         fuse_wait_aborted(fc);
>
