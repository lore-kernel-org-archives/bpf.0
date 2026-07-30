Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8449620
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393234; cv=none; b=u0vMdIRACwyY6Oi7YDBohaX1YHy9lHjkGBPgHmhaJiWopZLnH6Uicxrpn81JoIh93MBISvfPKqq9ku4YGN6OSkBBFfwRR1ZFBHQneW3IKiHAglcksgIDlNMmGxfTx1WdmntU8HN7QvA+SzkoZdhRXfEzJNKOOSSdbwrwK5hed4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393234; c=relaxed/simple;
	bh=1buAZ1J3EJzoK3uKXKjU8iSDVuQnXlUsbpZQK3NC29U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=RDZ/h8jc1v+9uwshtrr01WsW7Xc0PTACZrMWAY71XsqbXBNXKQrBKHquWRvMcPeDnk4SBbOjNh66RgflukI4ChMu5BpMQMwF5K6UJojg6QSXm/9TJn0kOQUeonTPFs6VNaBZ2PCS6NiBU00L999JAHMjOoY2voWHVJ87yvXF0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=w8/bRkfL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="w8/bRkfL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84eb992a881so328761b3a.2
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 23:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785393232; x=1785998032; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mmztpyGDT8bXM2TJcNunZC5IJZ+7bFWL4gwiWczYTvc=;
        b=w8/bRkfLWuCSkZLyzKyPtgJPSq27rBmNSb3ShYEQsr49NjJAtspoHIg55jNjQzpxxw
         n5bH9u83YHuyw0tjWrvckXwV6DStqLSdc6zKdwYfPUJrnGwZVgIsPfnn0qJYzwk39s41
         KGV0EDTj95zciNj+a5JoZ6LRjzgaSxUnQXJ0o8ApqOPA8j1cNZfY32boE1tEMitwm6H5
         2HAIl/WpnWvlRRamsuYGUxOQ1ruokZFJzgiUIkRjeJHcSapqBrijurEDB8GSdPwwGPmW
         pK4ina6WUBhg5taYJjZ7iVk7co3pWDDnd3N7jCUojcaRPSVbQK5VJli9XWLUc4Gm0vRn
         EP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393232; x=1785998032;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mmztpyGDT8bXM2TJcNunZC5IJZ+7bFWL4gwiWczYTvc=;
        b=Qi446q2i/ZpX+5/iMsJzEdvl3zbt9d2ba/SeJraMcAjzAqc/bqslLowDN89KFTqB/M
         BkGCM+HrN3tdWf3YpDtsHyRW1rfuOmqBYYceJb8xrA8N6yLHoLlsGWzdB3trUTS1APK7
         yJUh0ujo9GVUrSmiciqKKlB6aB/KchKDqi9bqOydRX5bo6UOXH9imgzFRZJzvDrPdi7h
         xpj8BGxQrcPtSRzFGzhMdYuHV/uhvRQrHXJSM6reIqP8BPHcxFxWlbjDCOQ4hvUzuvfc
         5qRIYmGTozDlg5I2xvGrOswOH9fFoaV5BENZTGTi3UjZRB0ZpyEix/1Xw9n2tQ+Q7lQL
         a9eA==
X-Forwarded-Encrypted: i=1; AHgh+RozRQAXr4v70KfYMIvGG574VVKV74g/u4kxoZSuvxxunyr6aAkTn1SGTudf1MWaAHXo01E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzs6Uh4AP9h8f/W2YaJc3/gSBCtqpj5kwHR+MuaGt5IFp8pMjM
	z+RlTQRaqrtXNqvSeC1Wr9UZXS1+PhmeK0NNLWHohxknhCh7kZlchsT6GN50X49EHsY=
X-Gm-Gg: AR+sD13gdbKnq70aP6ehQycOybKo93VO7DiAl7qlIMXhMU+Say+YIuWdF0DrjD7bdVA
	5CLDOZ/0BTGZxogUye2qwC7kErhveFklWy4qZ151J2SV9RgSyusOdvVryHoLoxMoRddhUreFD9E
	HrJIod1n2ibUm/XQ57pNNGanex2CBA8+hBKEEE1wGz1pQyc11ZU5kjCvcnQkHztIGMdtpjFsY99
	Z6DPKT9jFNT+SU41ZHanxfKVnUJZAB4ABEVpeHUkc5ZQ4e1bHunVkSFDOEwV5ePVUp90AH2vwOS
	/aW4tf18WNi3P/zPd6V51voUe/uOSMi/RMJoh/TNV8UdxinqJh41DBPvbcTergHQOQd0vAVdCze
	c/U38eZ1qc90fSS2+Z1XPXsKjnKi6BA/3fVTfI+vDPtgIqSW65rN0P6TfZIp+Wx8E0oD1Gj/riQ
	JY+XH37RtsY5+jYYpccHjtyEZ1uIG9is7jir7p2GfMdiN51pM0gvvyK8MYd04HfLNnvVlAb8RGn
	bjrHtZS3Y1YWSlSd/IJhkAWaA0t
X-Received: by 2002:a05:6a00:1748:b0:84e:1c87:e6dd with SMTP id d2e1a72fcca58-84ebc1fd7efmr1496664b3a.7.1785393231861;
        Wed, 29 Jul 2026 23:33:51 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03869d2sm2439128b3a.49.2026.07.29.23.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 23:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 02:33:50 -0400
Message-Id: <DKBP2V5WYH31.3QHSY5V8WTNDD@etsalapatis.com>
Subject: Re: [PATCH bpf v2] bpf, cgroup: Fix invalid storage access after
 __cgroup_bpf_attach failed
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Pu Lehui" <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Pu Lehui"
 <pulehui@huawei.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260729100208.3076769-1-pulehui@huaweicloud.com>
In-Reply-To: <20260729100208.3076769-1-pulehui@huaweicloud.com>

On Wed Jul 29, 2026 at 6:02 AM EDT, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> Sashiko reported a potential invalid storage access issue after
> replacing a cgroup bpf prog.
>

Nit: No need to mention Sashiko reports in the commit message imo,
the Reported-by is enough and imo it makes it confusing for people
not familiar with the system.

> This occurs in the following scenario:
> 1. prog1 with storage is attached to a cgroup in multi-attach mode.
> 2. prog1 is replaced with prog2 using BPF_F_REPLACE in multi-attach
>    mode, but fails midway (e.g. in bpf_trampoline_link_cgroup_shim or
>    update_effective_progs).
> 3. A new prog3 is attached to the cgroup in multi-attach mode.
>
> The reason is that __cgroup_bpf_attach overwrites pl->storage with the
> new storage prior to attachment completion. When attachment fails
> midway, the cleanup path calls bpf_cgroup_storages_free(new_storage) to
> free the newly allocated storage, but fails to restore pl->storage back
> to old_storage.
>
> Consequently, the still-active prog1 holds invalid or dangling storage
> pointers, leading to an invalid memory access when prog1 executes and
> calls bpf_get_local_storage. Additionally, original pl->flags and
> cgrp->bpf.flags[atype] are left unrestored.
>
> Fix this by saving old_pl_flags, old_storage, and old_flags prior to the
> update, and properly restoring all of them in the cleanup path on error.
>
> Fixes: 7d9c3427894f ("bpf: Make cgroup storages shared between programs o=
n the same cgroup")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> v2:
> - Remove the link relative code as link only support
>   BPF_F_ALLOW_MULTI attach, so will not occur UAF pl.
>
> v1: https://lore.kernel.org/bpf/20260728132336.2857800-1-pulehui@huaweicl=
oud.com
>
>  kernel/bpf/cgroup.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index e2fa0ebeed83..be24ca453cab 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -813,8 +813,10 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	struct bpf_prog *old_prog =3D NULL;
>  	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] =3D {};
>  	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] =3D=
 {};
> +	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] =3D=
 {};
>  	struct bpf_prog *new_prog =3D prog ? : link->link.prog;
>  	enum cgroup_bpf_attach_type atype;
> +	u32 old_flags, old_pl_flags;
>  	struct bpf_prog_list *pl;
>  	struct hlist_head *progs;
>  	int err;
> @@ -865,6 +867,8 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
> =20
>  	if (pl) {
>  		old_prog =3D pl->prog;
> +		old_pl_flags =3D pl->flags;
> +		bpf_cgroup_storages_assign(old_storage, pl->storage);
>  	} else {
>  		pl =3D kmalloc_obj(*pl);
>  		if (!pl) {
> @@ -884,6 +888,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	pl->link =3D link;
>  	pl->flags =3D flags;
>  	bpf_cgroup_storages_assign(pl->storage, storage);
> +	old_flags =3D cgrp->bpf.flags[atype];
>  	cgrp->bpf.flags[atype] =3D saved_flags;
> =20
>  	if (type =3D=3D BPF_LSM_CGROUP) {
> @@ -915,12 +920,15 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	if (old_prog) {
>  		pl->prog =3D old_prog;
>  		pl->link =3D NULL;
> +		pl->flags =3D old_pl_flags;
> +		bpf_cgroup_storages_assign(pl->storage, old_storage);
>  	}
>  	bpf_cgroup_storages_free(new_storage);
>  	if (!old_prog) {
>  		hlist_del(&pl->node);
>  		kfree(pl);
>  	}
> +	cgrp->bpf.flags[atype] =3D old_flags;
>  	return err;
>  }
> =20

