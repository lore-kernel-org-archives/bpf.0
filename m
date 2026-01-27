Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819921B192
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769492997; cv=pass; b=b//iGzuJ6fOH/9Wag1+3HW2Ugl+vco6G6U+Mod+9O1J7jVeiHGXvPfXbzfgYPsaSEjKWUwjNJIwIL3mRjbeKcx0SybJrTkiCUFBqlOxc5Le3kAFsAD69AYPAW8YsNYjoeRJWZCvTgGIaUrc9SxyHYs7LQx9TsKp2xA73LWbNPUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769492997; c=relaxed/simple;
	bh=1gVxj1jUaeC34UWQ2bzWBOtqZMPf0nq4coXO9xLn+Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSqP34SyQ+nYT20YW04cSsVudcmrUc1G+v13Yno4FiZXwhXmmZcGtORNTeEIZItVAPwDelLZDMG3PvEzFd1YbDiPEsD2Nr52jbKcyLBT+5TCvXutPtdc16fDMbzO31DvI/BysZ5WmLm+hzwBNlMGj4kv3slwl2gB5YVHuNJuVz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdLI6o8V; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdLI6o8V"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7942b9663f8so47054657b3.2
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 21:49:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769492995; cv=none;
        d=google.com; s=arc-20240605;
        b=QUN7T7Ouyo+8dVZ5n9ejbV8zn+qNum7uuVfBg1SztBSo1mcjsQmI8jNqqjPSg5WBbe
         mxt0DOLrXWHCEYqFTA36S/9/C9JkiCmvTJss53XlyWWb6NBCsVybbE6/J9zaec9ZLKK+
         OjCFBgZwx3R2cV8b5Gkz8meZlMekdiscsXiN60lb0TK1HahyeJNTQ0XmZ8asr2vdTDe2
         uqcQZNg42PLCXfq7gq3p67RkcE+pLZ5Xmj5vFTyd6s6tzpR4rceYkLxVXseAn9nfPAKN
         6/3uKJyt5c7iDxeeuxQwvWoXunjBawB1PrZFZmX03TGIpgZoPEc/6DYk/ehY179DIde3
         SFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9HzgsJ827sC2LhFGy7sDRVcx3B1Tf/7PzhkQBFCLMF0=;
        fh=S28IKLljYO5ribukOX+7btu0mmxV7tW1bx2QZ2d+1I4=;
        b=bsFZDyDSB9p3UzaZMqXrYow/YeSAl6y4e7zybHnUjtQUmTgTKeJXhNN9QtBoBQzVFe
         W/HkTezpVoC7NYeH/Nvrb0IApmXgVxYgHMPhQi/6/iTIhnYtvER5p5JuY4M1GnElJbur
         hvhOCJdbQbWgrmknuhn72qNlokMj3R4VWmAkmfEQsUZFzOFVXAfECTmdIIWzhWcPbb5S
         YW4qrkWwPyL5oBLB7g6oxIiVxS0blkl1cqUtJTR29OlxNbWoXedG1p37Gizo68d5Lm2H
         eX4D61TqSF4iEShjjFjPfUWcr1V8XsrjnGgQWSNlfRyTbzelhnesWc8Ue8PW2M73Ltfh
         iAhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769492995; x=1770097795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HzgsJ827sC2LhFGy7sDRVcx3B1Tf/7PzhkQBFCLMF0=;
        b=MdLI6o8V58V7Z1qX+tmBpzAnYq7WJZMiG501ITBZAAeq7fIv2RcQz4SMXZa2Lt7JiN
         957iaAV9XEDXX5e9q3hUjKNE9jDQ6NM9gP3vBxKtZAMGfnMb+W3z0kVCnf4vb2gpALAR
         z+WIm/o5Xs5OJa6e2qN/Aq3qBybK5kcOSwkL2RSJgcC/X28IKh+vYQ2NLo3roKfjntL1
         CjTB0kxozhRXTacNDJoqkjHI+l747Muyc65cN4RkhvzK6DssDBDEEny3f38Q7Uf7z8Jd
         SbUI0ib6eKPnDKW7GqxXY7C5A3Q4Xugrx0vIsobXaBWZ+xZs0DpLQ/Ma2bwMheeXRbSa
         xB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769492995; x=1770097795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9HzgsJ827sC2LhFGy7sDRVcx3B1Tf/7PzhkQBFCLMF0=;
        b=SHJOqC7fuJfYyo5sP6MWHeuOczdw7Iig8TwqZ1DtlUyrgvPpeO/AgwaBC1TPWS0yQU
         gNFJCHW2MZN7jzHP/EiR6xb7HRhWqpjGK2kfHjyEobBWiVGwYk0GadIdyJnNJI4gLLAB
         YDuJYtcP5w++ovSRZ+1DSThyYY5YZ8HG2LOKTb/wF4K6Y7QV9Z9T9R1hwWDgMeqsGaO1
         ioYyo+wgb8uCnMiXJpNzfBkWZEM2r8WF5PifBAFPQxyYwvoeIvI7pGeHIq2ntvYL23Gx
         PpRFYmboiyfjCSrH8xopk3CO6C6GBnrV86Qn5T/BulKu1H4v6GRR1v5JONJabsDbQFKf
         69lQ==
X-Gm-Message-State: AOJu0Yzs9ZgDoNkmMVLCynYbzbFs5WrxgPWf1uMdV2+e17lOuz1BZajL
	LN9391OJ1d+/uF7OdR1uL7Hgkf88MoMKZ4NPe+EAATcUouZU5N/rHDADtOE9f/Zj2JLw+Rx2Xds
	xCTzcY3AUrv5qzpAlrnUZiTY3BECoJ+Y=
X-Gm-Gg: AZuq6aI0HBiM+eXvEN9C6IZ1TNJLxcE2Vmbi7OSIst3vtuplaFk8CoTkUH95bDGZz9D
	kWoIj7yuiCg6WAEuoSSKDWH6OS64WnrvpatWRaXFxzEkGwq2/hw4b2bAJnJ3OvENnTm+q96a7dN
	UOxCRttMSPw3yZnbxqkS3JUH3Q/eTRFqoOlY44vb9zbKgMATWhLke33vQepyDutX2ePoGBgrcD0
	dn7xREyEj+xs0Gaa/Sp+8I6E5+xvMLZsG13eQ9A4yZ3hOID+g53mgpBdqNFoSlMmpwMhGe6
X-Received: by 2002:a05:690c:c4fa:b0:78c:32fc:d3c8 with SMTP id
 00721157ae682-7947ac9b9d8mr3193427b3.61.1769492994629; Mon, 26 Jan 2026
 21:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev> <20260127024421.494929-3-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-3-roman.gushchin@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 27 Jan 2026 13:49:18 +0800
X-Gm-Features: AZwV_Qj3kyuk2DA9gge5_s9cvrRhNp_WPMd2pfEpoGaEHp1boZC6Dh8UH00fl4U
Message-ID: <CALOAHbDXmgi=yeB1c2zzQ7-Lz2+MEZvtbxQp1=mWXMJSsg3sgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 02/17] bpf: allow attaching struct_ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:47=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Introduce an ability to attach bpf struct_ops'es to cgroups.
>
> From user's standpoint it works in the following way:
> a user passes a BPF_F_CGROUP_FD flag and specifies the target cgroup

Since both fdinfo and link_info show the cgroup ID, why not use
BPF_F_CGROUP_ID for better alignment?

> fd while creating a struct_ops link. As the result, the bpf struct_ops
> link will be created and attached to a cgroup.
>
> The cgroup.bpf structure maintains a list of attached struct ops links.
> If the cgroup is getting deleted, attached struct ops'es are getting
> auto-detached and the userspace program gets a notification.
>
> This change doesn't answer the question how bpf programs belonging
> to these struct ops'es will be executed. It will be done individually
> for every bpf struct ops which supports this.
>
> Please, note that unlike "normal" bpf programs, struct ops'es
> are not propagated to cgroup sub-trees.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/bpf-cgroup-defs.h |  3 ++
>  include/linux/bpf-cgroup.h      | 16 +++++++++
>  include/linux/bpf.h             |  3 ++
>  include/uapi/linux/bpf.h        |  3 ++
>  kernel/bpf/bpf_struct_ops.c     | 59 ++++++++++++++++++++++++++++++---
>  kernel/bpf/cgroup.c             | 46 +++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h  |  1 +
>  7 files changed, 127 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-d=
efs.h
> index c9e6b26abab6..6c5e37190dad 100644
> --- a/include/linux/bpf-cgroup-defs.h
> +++ b/include/linux/bpf-cgroup-defs.h
> @@ -71,6 +71,9 @@ struct cgroup_bpf {
>         /* temp storage for effective prog array used by prog_attach/deta=
ch */
>         struct bpf_prog_array *inactive;
>
> +       /* list of bpf struct ops links */
> +       struct list_head struct_ops_links;
> +
>         /* reference counter used to detach bpf programs after cgroup rem=
oval */
>         struct percpu_ref refcnt;
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 2f535331f926..a6c327257006 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -423,6 +423,11 @@ int cgroup_bpf_link_attach(const union bpf_attr *att=
r, struct bpf_prog *prog);
>  int cgroup_bpf_prog_query(const union bpf_attr *attr,
>                           union bpf_attr __user *uattr);
>
> +int cgroup_bpf_attach_struct_ops(struct cgroup *cgrp,
> +                                struct bpf_struct_ops_link *link);
> +void cgroup_bpf_detach_struct_ops(struct cgroup *cgrp,
> +                                 struct bpf_struct_ops_link *link);
> +
>  const struct bpf_func_proto *
>  cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog=
 *prog);
>  #else
> @@ -451,6 +456,17 @@ static inline int cgroup_bpf_link_attach(const union=
 bpf_attr *attr,
>         return -EINVAL;
>  }
>
> +static inline int cgroup_bpf_attach_struct_ops(struct cgroup *cgrp,
> +                                              struct bpf_struct_ops_link=
 *link)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline void cgroup_bpf_detach_struct_ops(struct cgroup *cgrp,
> +                                               struct bpf_struct_ops_lin=
k *link)
> +{
> +}
> +
>  static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
>                                         union bpf_attr __user *uattr)
>  {
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 899dd911dc82..391888eb257c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1894,6 +1894,9 @@ struct bpf_raw_tp_link {
>  struct bpf_struct_ops_link {
>         struct bpf_link link;
>         struct bpf_map __rcu *map;
> +       struct cgroup *cgroup;
> +       bool cgroup_removed;
> +       struct list_head list;

We may need to support other structs in the future.
Could we implement a more generic solution, such as:

           int type;  // cgroup, task, etc
           void *private;  // ptr to type-specific data

--=20
Regards
Yafang
