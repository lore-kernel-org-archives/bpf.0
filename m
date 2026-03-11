Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA832FA2C
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253943; cv=pass; b=WWWbR7jn28IzrhHXc1k/QG3RNGeEKLV9nLASyHRKfc/ZQKG5nuQUvemIUuUTT7MOfPFFU8uUJUHf56BpgrkO4Yh29Fw/dALQ+Hi4EaDak4GReAuuhTFZ9G5tt4WKNGdggGt8u3rXjSrrR/SFMdmw/XBP0IXSnEdUeq07RpWhTbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253943; c=relaxed/simple;
	bh=4Ylq8wXCnjOHF6Xk4cg3jdFKBRzrz96BZimU1ImLo9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kf+96W6LaA09fMexQ6rYQ5fjIepctRnh6PdFx1nlh2RFvUbckPPR3tb7957rd1U3l44KRszL2LWzRHJI3utXWQYTEJ5GWtJgIkQft5pS8bACbERX1uSgaLkU0zui0bcDFOpwQxmVIWnr/zpjdvAXt5kYiYaUaZZJt540kE9wVRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIZs56B5; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIZs56B5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aea41d4fbcso1267745ad.3
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:32:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773253942; cv=none;
        d=google.com; s=arc-20240605;
        b=KSkOmFZlH7otcrPjU/rUHdW1EKPFyO0AVhvcLdssjKEnGVxafNzwRLDoWsi28mAyqT
         VANvTKxVl5p4gv0/8nVbfqVZrpD/wakJKrqwy94y9ceb/lvDsbTEbdkz3gHkfPdb1Cqf
         uN0vwrhLcBnxuF6joom6nLZwqw63UONrBzf3guwwf2/xfntvW5fJw5lKHCN5QKRCnTgt
         tMtk/pclJnK33rLDAbwLRsO4vbTpX9Pm7xXQsAqIVBqdrOjMOj1Qp5ONDI1PYjUyx2B5
         hw8gN5oWVruaFDM18Y+MIzi4I4g9cTOBs/j5CfF2Z0CbQUPt7M7+6nAZNgzD/BV68xlm
         oR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gz01rdi2ZDcZ4nQ5BDWxE/1AZGr8GW7CnoN9F2pNO7Q=;
        fh=3JFULSt81QhP9ARgOVVWpn+UY1r04WcyvJhNnAO9JVY=;
        b=AsRCa+6UMOcBrqlsbj8lpiFeKl32erEI3bEugsZp1vlWYQavQw7bAU9E12QamrgfOH
         12qIU6S4pP3wI2dqYgOTnYskSwF6dcFrd8V9gNUNrpN/6tFBTyTa4gAofL5pbLO3TQxG
         lH18h4L8FzBsgwYne06qLl8Hx1lud0/S3EOLNpO/5Zj9UoTGIDCmKOARM9QXgaZGMEfg
         ZuoUqDgyTqkhpBnaMIpSs7hOgrYC95oaAS1NK8kxURe+MnNqRDIWBfQqrcYX02c3bZR7
         US/a/W/oSuME8T4025H7x8Z+klC8/MZCa5yBsKsf9aoi8FL1ZSOHGQ3xUhTh7k+zDfVW
         2J5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773253942; x=1773858742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz01rdi2ZDcZ4nQ5BDWxE/1AZGr8GW7CnoN9F2pNO7Q=;
        b=kIZs56B5JkjuSYciZqMzz93vE7ZYTbqTCs0v/4tDKymmc6zl7NIngJafdjgLL96bz6
         RxPcYy/JTZTQG9TmO11LLhEwh7bCEfO47lK5OZ2YOgzJ5Wo7dF/nlAAD3GRA21/LQcRl
         4IM+RntkZnPi6QsaSsjxbWMcyCsvMpwoxJMW1ZVvhA9bBkZ5wv/i3b/EW8593fBhmZkW
         Jg98owkIdkbOUhynSMbPDCuZM7XgkpDIoifhjEyPP8MJKBhOGV+7nm2wmZkRuNbL4ht7
         0T+pYTjzKyBv4/gdm3DKA2NPQ0ptTtQAhuWmhoFAqSfNLkIf/COBZDy1+r3IIPqyIzh+
         8ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253942; x=1773858742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gz01rdi2ZDcZ4nQ5BDWxE/1AZGr8GW7CnoN9F2pNO7Q=;
        b=FljYw0yhCO6aanoPsK0zfJ7kvyoGOEaRWBc2MdChyXvAT6F0MTWng37fWu1nC969o7
         tUxiuV4lvM9GqaXlqDNF+FfGmRBaeVow5rRB4nHrOrdHMTVBby0cxHaXTbN16parQXjT
         eV2CSJuuml00wpp+lsN7JjJuqkKQjacijyp34Vm5abNDcrDdsJJY11WACYI5X65o8fgL
         oL+4ZyXm3O0CMNMoXpjokOt6XFvjlja5oGTq2u9LJWPylCh+4D1cmCKlSYjdmwVFAWkt
         fZg72YGPkMWbvO+z3ZdqdbUh5RlJQxZJ5vswEhIEzJx1tmE4eI/lfpTv7iZ4P/mdxubL
         6tdg==
X-Gm-Message-State: AOJu0Yyr4LVnjX7ietXygACPSAmsSn8RxaLzsoZV3W7zROlwfEwYeFI+
	UdWrgeVPd6Q0uHHP3DYPLw2fadMKv2K25TcTU2I6/pSN96ZGmwNy8xShIKnEDS4p/wzWj+WsK58
	ZR/v1zo+UIcxeWTcJWxpfadjw8DvBAfY=
X-Gm-Gg: ATEYQzzrT5DIZ3mpUQ1HJy7i6j55NKLDZ9tR7p86TsmpRJQUEE9+kXD4TL178dR2gBd
	qBPmZQAAXzWjlhAgOCVjgNtMxdHnDrRVb8fdhZo023OYGvuB9dORr4dq052/WLCLdFW09hL06z7
	q+lBZ+LFSyiu+EV96w1OlmemT/0RVPohKxm/z/aGiFpdPsUkhJg89R91Ow/HoVPEO/3f4ubnPGq
	QHQAjXCpjsi0WnijJyj5JtnpyYMbqcNBm8LPPx73baKN3ZgiMAA6nmxKLhxp70VS7RQ+wpwGi1U
	dhn17NszdLxy5ipjwQ==
X-Received: by 2002:a17:903:b0e:b0:2ad:c66d:ad06 with SMTP id
 d9443c01a7336-2aeae910344mr38891865ad.47.1773253942100; Wed, 11 Mar 2026
 11:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155506.23490-1-puranjay@kernel.org> <20260309155506.23490-2-puranjay@kernel.org>
In-Reply-To: <20260309155506.23490-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 11:32:09 -0700
X-Gm-Features: AaiRm53ldI7HWEdjuBIajE966EQcrSxQRdExAOOpAN9jlbkgBWWRdJFSk09GeL8
Message-ID: <CAEf4BzYEcbNN-xCxAhMqvszaC=c_Ooz+s9Do8HU_r11Gj4hyRw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/4] bpf: rename mmap_unlock_irq_work to bpf_iter_mm_irq_work
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:55=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> The next commit will be reusing mmap_unlock_irq_work to do mmput_async()
> in irq_work. Rather than creating a new structure, rename
> mmap_unlock_irq_work to bpf_iter_mm_irq_work and reuse it.
>
> This is only a rename with no functional changes.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/mmap_unlock_work.h | 12 ++++++------
>  kernel/bpf/stackmap.c         |  2 +-
>  kernel/bpf/task_iter.c        | 12 ++++++------
>  3 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.=
h
> index 5d18d7d85bef..ba8e860f1180 100644
> --- a/kernel/bpf/mmap_unlock_work.h
> +++ b/kernel/bpf/mmap_unlock_work.h
> @@ -6,13 +6,13 @@
>  #define __MMAP_UNLOCK_WORK_H__
>  #include <linux/irq_work.h>
>
> -/* irq_work to run mmap_read_unlock() in irq_work */
> -struct mmap_unlock_irq_work {
> +/* irq_work to run mmap_read_unlock() or mmput_async() in irq_work */
> +struct bpf_iter_mm_irq_work {

given this is used from bpf_find_vma() and
stack_map_get_build_id_offset(), why does it make sense to call this
"bpf_iter_"-something?

and while for those two per-CPU is a necessary evil/compromise, for
vma iterator, why can't we just have irq_work as part of
bpf_iter_task_vma_kern_data? it's dynamically allocated, so no problem
increasing its size. We won't have to have unpredictable same CPU
random "busyness problems"...

>         struct irq_work irq_work;
>         struct mm_struct *mm;
>  };
>

[...]
