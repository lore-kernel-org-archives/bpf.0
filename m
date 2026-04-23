Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3785F3D6469
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776980690; cv=pass; b=QkTsPT6UXMWuV3AylqRLOCQACCw8eRmIcQeC+XPe60iE2OwbMajPInYw+c7v//3IKWtcsruUGE1GEDAza0XvaLhd4ujUJd9izkXT18RGi68ExwOYbSni93qnjdH7XQp1riuCgX7zQr4jNKvomRj4DWu1g2xW2zSW/olOn/A5BhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776980690; c=relaxed/simple;
	bh=OU471vN5WHbf/E97j3Av4mFhucZsFb2ZlukPT180myo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3Qz0a2fGDH7MY6r8XoVC2tHJ2Lxao9uoYfbiebz16S1o1l5tl7hn3Or5/Z3FRKWUvqXF0y+kBYPGgzh0G7rq4N1MmTwcD8OhDrN8fnc9/9tkCfEHkXAPUl6XX4G9TkWw1e94CJwUFcLHnQOJ42C7RM/1lmtj7RPR2Wb8bxi2Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQrRp65s; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQrRp65s"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a535e7c00so84501277b3.3
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 14:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776980688; cv=none;
        d=google.com; s=arc-20240605;
        b=X/U+LYaZTNhuYDUdu0ThDOR+brDPtsIwB9RVtb3pX/tTvQX9k2AbQfeWDsaloCpraD
         8xjainisM8MKd2AXYI0pKB6iFSXOLATzEZTh0778rq4ykcud1iBBGav6gYRIurukUhmY
         i7PSoJFPsQgW/KLyR1iM98KUTycGGAji/xO0Fufpfp/lEosLnOc8RyXYzOXpoolvcnje
         kO7rCB3vvTSBB/KCgky/YpMourYXb54mVQrTUbzLq7EnFUSmFeW4RnTkfNdkCRIk6Gsd
         ZlAX5GOrpu72iHd6kQs/5h6PfjxtI23gp5y5I+dxVe6PBPC+L4r9ulSOCgEjDLRTLkM3
         W41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OU471vN5WHbf/E97j3Av4mFhucZsFb2ZlukPT180myo=;
        fh=ZpbOLCJhuasBJOyIovODWVwjJNFuANmOK2aSg6JDcBw=;
        b=c2fuE9ZMtBvciaUHd5Jx7OVHsaSZv2pOR1J100JKQkfG+JCXuX0N280Hv90hqsGqWi
         oQ8O8FwwCyFo4m6lK3tVJY0m2GrW2ZQyGD5Z3sJk3ukPTSvVJ/mfN/WewrmVQEbQ+J1g
         emiDvF8XythXn64mPivW+5xqY6fDuQ7DdmaSurCjlaUcTUtjinrPkFvYn5oEPwWoleCd
         WXcTRIDciGYEe9VfysNehDYoq0PW4DlVg6T8s9VoJCvCkgRK2cz1QA9E5FsK8xFyD4JN
         m3XsHbeEGECPUj6RUJe28Qlrm75kSkKCRFGGXQRu7HlFzMhokVwoxsa6UFeKMujnr54Z
         JWmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776980688; x=1777585488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OU471vN5WHbf/E97j3Av4mFhucZsFb2ZlukPT180myo=;
        b=MQrRp65spx/n/Vuk6wjH9WFslsho9humkYQ/9ICnd01rI1djHhirirBQS8p+S6N8gV
         EU7XVVIu46g7co4I1dq/ROrflsij5A6Goh/rbcw4uwc+Q2xu5k8XAbkN81M687ifv6Ch
         iXskayzQmD054a4z5RFWraSvRGL+9tK1T8bosnBKnIwxsd+Cw99J69PokTOzYpQ//VUG
         KM/jCpYMhEBFyTrJj9hzlzcnyeMAboHN4H8nTciUXBkECCgJjJ3ZnHoSeDZR57zqjzoc
         AHwSLVDUqN2aetO1eaqMm4Ql+L/qyDrrDk/hsBsWap+JEshPd9iYHAYQLoVRIdVzXBS3
         4Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776980688; x=1777585488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OU471vN5WHbf/E97j3Av4mFhucZsFb2ZlukPT180myo=;
        b=B+plK0bX2THUvMl+pzAN0hMtOMzFncr5PJ9h8WtwgS63A12kqvfr5x3qlaxwkHnWeB
         5Ldbc2hYppgdvHWT8nkscFm2Adb/AaWQblC7cQyLpjLvzh5JkXia9KlF71/S5/Zp9wD8
         YWBNcIs0iO4sUGpfAxozfOmMDJhFlmtyfe/c8HzADBM7+nqKwTdxfE/KZij9bMgxASFv
         vUI04OKsuUn09N2VjLcmWzLOMZRBxFqQNWrFr3NztRFxzCbqBHQVFZKj8wJx68j9LGBB
         vxJwPM7UGRBFA964LYrtBtDG8eDq4BRn93rnTKzGAlAQhWTuc2no3jStTkqdK32d5j/Y
         +SIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8L97tx2B8kLVouq4TLf8vAbbZOuNWfw5FhlX0OU1hiI+bOA8OJNNrgwNK+sqmPsfpD0rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzybKnde0F0b4VL6bEnCSIlAO75BDoy4a0nUfsBu3IUjIRtrLU8
	VKZtynd1bnC3BLSaQRihdlQIbk5mkWvRvD82f3aA87ZKxKH0+2hh5FFSBg3q7NjLwcp2DwlqJ8a
	p4ZO34VhT3H5ePhsfR3XvkRmMAKAGUnV75Q==
X-Gm-Gg: AeBDietvm/gFQxGlkHHJiP0NIe739icMvV8qjnPTGyXjBhCMA2GGz1zzJr+CTI3EA7l
	Qu2Jagb4Vc8ILbaUoC/7AEUnnpwu6wwGaHw0Dgvg4COysCkghTuK3bhi0RUams9tRGC8tP8jVMD
	QnBM4zw/VOLPffPyWk8LginRIV4MCGA7aoYerpB4EZpONuS9csR+pyCAyEw4AOgsrnqCQ0mAofB
	+QajvTdMQWRZlKxkfaM/ZTZ932QU0oVrgt2kO2zMd4A+fWHifSPqcWsucCnZG/ug3NygojIV00d
	+iVsEB6tv1MEGISdVxnDg05FgFPncwI=
X-Received: by 2002:a05:690c:ec3:b0:7ba:fd82:9105 with SMTP id
 00721157ae682-7bafd8295d8mr164498907b3.29.1776980688264; Thu, 23 Apr 2026
 14:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422065411.1007737-2-bestswngs@gmail.com> <20260423073813.13F29C2BCAF@smtp.kernel.org>
In-Reply-To: <20260423073813.13F29C2BCAF@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Apr 2026 14:44:34 -0700
X-Gm-Features: AQROBzDfAuSwpbDqZsnLm8Fw4sOOGcDz--R2aLvplRKQ7njUWJRtN5OHHs55hjw
Message-ID: <CAMB2axOh3J92OEL_y0UOe4tpWf5sD=tkybE+gDigqiGBD+cXCw@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
To: sashiko@lists.linux.dev
Cc: Weiming Shi <bestswngs@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 12:38=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [High] diag_get() leaks uninitialized kernel memory to user space when =
dumping BPF map values containing special fields (e.g., bpf_spin_lock, bpf_=
timer).
> --
>
> Note: The format of this review has been altered to provide a free-form
> summary without quoting the original patch code directly due to recitatio=
n
> restrictions.
>
> commit 32307cca407ebdd5cf1feae057cd9956ec19daa4
> Author: Weiming Shi <bestswngs@gmail.com>
> Subject: bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and di=
ag paths
>
> This patch addresses a race condition where a concurrent RCU reader in
> bpf_sk_storage_clone() could observe a selem with a NULL smap, leading to=
 a
> NULL pointer dereference. It adds NULL checks in clone and diag paths and
> updates diag_get() to take the validated smap directly.
>
> While reviewing the changes to the diag_get() function, I noticed a
> potential pre-existing issue regarding how map values are copied to the
> netlink attribute.
>
> Does this function leak uninitialized kernel memory to user space when
> dumping BPF map values that contain special fields like bpf_spin_lock or
> bpf_timer?
>
> The function allocates space for the value using nla_reserve_64bit(), whi=
ch
> reserves space in the skb but does not initialize it. It then copies the
> map value into this space using copy_map_value_locked() or copy_map_value=
().
> However, those copy functions intentionally skip copying special fields,
> leaving holes in the destination buffer.
>
> In the standard bpf_map_lookup_elem() syscall path,
> check_and_init_map_value() is called to explicitly zero out these holes
> after copying. Since diag_get() does not appear to initialize these holes
> before sending the netlink message, could uninitialized skb memory be
> exposed to user space?

Sashiko is correct. Special fields need to be scrubbed here as well.
Will send a fix.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422065411.10=
07737-2-bestswngs@gmail.com?part=3D1
>
