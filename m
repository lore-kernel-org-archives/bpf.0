Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233A3F165B
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178785; cv=pass; b=d5adNb2Lr5P+C9aoDD2PN1YkhCgOvyy+eTN2EWdItnJQl4FlpZ+TlzuIyaX5N97tI98PxsH0ZprYdU0zIbeUerePQ1L9AXf0USvPTbB0kAKS7kb8kMXgfwHdVDXTmDkb/4i3xgqTo4VZPZt1zm1pKZ4OaQdvECczsXfy8jRkcWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178785; c=relaxed/simple;
	bh=ooPgE7Sn9xp97d/BWgHznsjHvjbKoiaMXoI63LXtWC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUSEgweum8Lj6Y0qNg0E6z96Dty919FHxpljamYXjIeLlonxG6U3lcNZF4iH+Z77IXf79BEXtDAr7TXtP4cJwDNQ4NmsF2IVAdtVjtP2W64VNTrMnvhsyu28bCFaOfR6aETY8Ge6n90IRdCv7vGoVLPE9j+35cuO+vsycIcDAA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZkH4nSy; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZkH4nSy"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439af00d33cso10523193f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 14:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773178781; cv=none;
        d=google.com; s=arc-20240605;
        b=ShQ3HQI1o+LYX9dYM/zXdAOUpmNq1tbt+hMpvbsCn+H12fBIr5pvM8RVBLYCaUtb1V
         Jrmppu62x8JDdttvZXX/LCOCK9BHu2xfrejeQXwpKExPzlhR6N5FxDMzEXzrK5I4SxgX
         PwDCKHmM87Pdb24VQoxJCUwV9tOTSbPc/O6Wqc+m9Z1CHgIQZERil/NSfejXWw3pBvjT
         uT+aMiwu0uIRAdr0fxkJqYkHFV1USNwGhguvJV+VGj0Nhwhxf8Cx7OoGDKmUYXEwMxYi
         yu09qAnrreRJ+brRJFaHy/Pt4D6hqnsuqdZmHb5yTbmzjKyKeE6MfJqJLIIJHO/bzXTZ
         Kr5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=onJJVm9MuvA51KdMNciMK58KV9ZYagkMaZdFSmLvnKo=;
        fh=O2LqXuVYzXRCTIzCJzzfjIGDaR0TjVWFdMaMNYgCmW4=;
        b=Y6/57znwFD20aWXOfkUwstcjj6rjtYIBVPx+3LRqhZER2yrN9PtibMZS9JMIhwJN7t
         LOPY/eqJEQCWVOW2s0frb1ma3lhVenDg1BkDxB/keCL1ckMM/ZuYpKXemF3ZEtwZx1kC
         2hhE3dRbxIbSFKNQFtqTCnMjHjaMcUOwbjbnKNXqyH+RwTAoN6Mgq5OOfBpDEyrUubff
         G6AOcO5Qeo9cXOZuu+lVYTPtclH1PIrrReKtekkKdGK6tku5xPHpRnWx/uO/wrJI4tZf
         T78DqfQQWYXEy/aPGOCH0/5D/8ajblaKj5FY1yreT6yoB3rmq6TqmEfClqFkHJIz2vn0
         a1Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773178781; x=1773783581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=onJJVm9MuvA51KdMNciMK58KV9ZYagkMaZdFSmLvnKo=;
        b=VZkH4nSys1ISNol2GAPPafkIcBa6RBjrc6TUT5XYkZPRcmkou2DB2G1lzNsUhl4W99
         xLET+tQ/JJJZUqtucMHRGo+62YmwJbbQtFnN9Qe+sATFQndQcSEWii82eYdbDJzy0jLa
         kwLu5L+W2toehOjRIR9pmAY0xpcKbNsdvnPkCx7BC1GcWZyYRhs4+CdbjCB+AhJ+MvAC
         yQ2g3cL2xpOLT37GvoMYaqJQ42UaEQwRhk9JQ2xjaAlW6FMu4nKvs58/JHBIgz4GsXkc
         yyd8RXIJGcVI4rHX6Xg4Zxcw3NzympYidmxS5q6DdmGnsnIR10GEXbS/L9iZq2Tnimgk
         ykVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178781; x=1773783581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onJJVm9MuvA51KdMNciMK58KV9ZYagkMaZdFSmLvnKo=;
        b=eOTVKGh4eKvwGrFX2ueJ032XXnt+vdvYmdSpacBTbdC788s4VXvXLPZxbPwet5mYQS
         RX9hdqju41LIIZ2ZWKKHumRLsxi1aJ6h05fX6dVk9ig2PHgGf5GXghzSmWdJC9wJ8e0s
         MwlqqUxpIwETj2QWOLnwpRVlCveQorgUfA5GYoiLILGn5KzAkxoSm9eNAhFh5L4PcHK9
         erw50P89AT5XnWmYnJIhSn/3DVLpYQmUbEqnJqesmXgjTbKVz8gvVhQYlHrtxZp5MV8J
         VR4ipLndD+8moWZHFtfMWQW0zIUzEfeeCff1KvGkzeW+FIuuNrjuUIt/GwlirzMnWcov
         1p7Q==
X-Gm-Message-State: AOJu0YwviVUknVTh+MNcFULIQExiSc0hZgMO2jJh4GB/ugBj1E48tSyJ
	QU073XELYEtcCug2tvmgLOlAhhCTMzpxXVv+JzpKmNnUA+k3cJlXi5G3fwrwEk/pf/l2YZ0WYQA
	OUyZYG/EgJVCM7seFPfIzl7EFd3LKbNY=
X-Gm-Gg: ATEYQzynh2QmLt2xxFs7NFd7y2Wfko5nSX1zaqNS02FjGj+bl/rk9KznjG8Y8DCCZbf
	Qfu7utqQAh6gOzYssisLeaGGuYO6ty+ncqoIe3fIr/DtKsvKxwW4SRTHdiOLvBa+DeS6FG4DV+r
	YeKBI9PazpaxjptWIZt9Xnw2RaPf880FDUKl/TK2lFKdbMzEJUidUxONKxcIxVMmO0bDinRpil2
	IyxQl+Tu7WdS8B2RaLuN+ce3Q+bUica+bwYXbGG+PO+1OEWe/UDx/vWTsxrETxML1Cy81fPie1P
	2ijid9bEkG0Lkjg7+iRVoHCY3suSuvWwO6dQKWt7Ae0NyBXgxtcmThXmJ6svzMglbpTjiqE=
X-Received: by 2002:a05:6000:26c6:b0:439:b666:6c9a with SMTP id
 ffacd0b85a97d-439f8225337mr718648f8f.54.1773178781201; Tue, 10 Mar 2026
 14:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773170190.git.grbell@redhat.com> <a46d40ac2b56f96b3b6e953847ad4719694d68eb.1773170190.git.grbell@redhat.com>
In-Reply-To: <a46d40ac2b56f96b3b6e953847ad4719694d68eb.1773170190.git.grbell@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 10 Mar 2026 22:39:04 +0100
X-Gm-Features: AaiRm53fyV6zskrG1gQIuA0fzlmQWA-8dkKBJoB5kjW8RxE_j9mufUIfDzJaLk0
Message-ID: <CAP01T75MFfp8oBrogRvm+BRh7=fvm9pP0vTvNm=RW3r3=WDB7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Fix BTF module cleanup race condition
 in struct_ops
To: Gregory Bell <grbell@redhat.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 21:21, Gregory Bell <grbell@redhat.com> wrote:
>
> When running BPF struct_ops tests consecutively, the second test fails
> because BTF object references take longer to be released while their
> associated module is removed from btf_modules list immediately
> during module unload. This creates a race condition where the second
> test retrieves the cached BTF object but cannot find valid module
> information, causing btf_try_get_module() to return NULL.
>
> Fix this by modifying MODULE_STATE_GOING handling to wait for
> active BTF references to be released before completing module
> cleanup. This ensures BTF objects are properly cleaned up from the
> cache before their module metadata is removed, eliminating the timing
> window that caused the race condition.
>
> Signed-off-by: Gregory Bell <grbell@redhat.com>
> ---
>  kernel/bpf/btf.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 09fcbb125155..81c9f46a7bb7 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8382,7 +8382,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>                 list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
>                         if (btf_mod->module != module)
>                                 continue;
> -
> +                       unsigned int timeout = 1000;
> +                       while (refcount_read(&btf_mod->btf->refcnt) > 1
> +                       && timeout > 0 ) {
> +                               msleep(1);
> +                               timeout--;
> +                       }

This isn't the right way to address such issues. Your diagnosis is
correct but fix is just papering over real problems.

The better way would be to block the discovery of such BTFs once the
module is unloaded.
I.e. once we return to userspace after module unload, subsequent calls
to obtain an fd for such BTFs should not succeed.
If someone is racing to look it up while the unload happens, so be it,
they will fail anyway.

I would use a bool flag in struct btf, set it inside the critical
section at this point with WRITE_ONCE, then test it early in
bpf_find_btf_id and bpf_core_find_cands with || in !btf_is_module
condition.
Using READ_ONCE of course.
Also, we need to add it to btf_get_fd_by_id, so that once conversions
from stale IDs to FDs don't succeed.
Looking at load_module_btfs(), it already handles the ENOENT case when
id lookup succeeds, but fd lookup fails.
So for stale ids it should just skip over their errors if we return
the same ENOENT as the refcount_inc_not_zero case.
We will still report stale ids, but not allow their conversion.
We could filter id lookup too but it will penalize the common code and
we need extra radix tree lookup just for BTF case.

For me locally, these changes seem to address the problem. I could
send the fix, but if you would like to take a stab at the above
change, please go ahead.



>                         list_del(&btf_mod->list);
>                         if (btf_mod->sysfs_attr)
>                                 sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
> --
> 2.52.0
>
>
