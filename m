Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8D26F2B0
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979843; cv=none; b=LAo47F0/XxqVjn1qtPVdGx94zPLNJWDQ/2V4T2Mddx4DC4XqVboKQ006DMm+StiL9F1F/qI9hju5K5x2yeZ01j3l0Aphtov6TSY8+Afk1H4rUjPPSHrESQWx26bkJri3IGN2bQ29Ayf7iigIdEUyx/O6GDq0pJADjzZZfytnxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979843; c=relaxed/simple;
	bh=coTO6PwuDxPx0SSZlTNrbu8MbSA08SuMKb4lakXTOBw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=SZR9LnX5GqwFZB6PsO9VPcCMN1GEFmhuMZ2oZeavaDBX6kV6Nw9MCezWC0QhelN3SQB4C3GIO95uCUG0G71M8USkw2ndXE7rz76fU+Lgu68sn60d0YVzM3ir2j99DG95BdC6GSn/nytR8aTyL+74K7ono2+ETNLc3e8zflEwGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=bb0Ru0yS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="bb0Ru0yS"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848643382fcso4027832b3a.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 14:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783979841; x=1784584641; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UrqBoQyrxvBcos5JbUmwXjWeYzr52NLOmMrsaM2Ub/k=;
        b=bb0Ru0ySsnkiOLTtWS5HDN9DQ1SqhJ1n4BYvijkz8/uPRIIfhcvcvjIe9t3LkeesoH
         TAK0Qbheuv+7gAgIHKKMSgfCtiWu+aBqtFyO3+V1eFFuI3HvFbgeKxC4RkYz1a7D0PBb
         NgxoxachohereFVr38xS/NCgypn8lfXqNaaBUHV+pL9Dby0+exIj+HEZQpDkg/lJ9xpt
         NglAYV+WKWg2oNKuMRObWZWZ/Z5ISNT0akjdY8xz8oHoZFpQVrVrnZSuCSTErfqp3rE+
         ULJHzPbmMqF/sbNTZtigAinBwA8/Wlr662VWMLPylskLUvo9jkVcGYxFDXksSXR1YF4g
         m29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979841; x=1784584641;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrqBoQyrxvBcos5JbUmwXjWeYzr52NLOmMrsaM2Ub/k=;
        b=O/2DFRNuAJVegMFH+HAq/UlcFrIUu8f+6hB1aIYf9j+grQne3I9caibjxtF97a/IFi
         LqKH3+X0ZbNfL5p9kWD83hr1Rq4n9V73XfGzPKcT0gUwfmwHttGgnz1C87qnFhu5ICka
         XCijrwH9JKUR2aPTg8GPvKIXYEpzAtEbo8AdwdtgiWv7geBmrMQbeI92Gqxog32iaNPB
         DVFbBpt9nkMPk7fEiA2Dxan5lqJDY72maWo2BImqftGiuaapZtKYsmFgi5eGIhlfCGFY
         UDGvw4bdJbGjjcLGj57GcDdijF4nm30el+vS4hDvzRvPnTSe9ZOfb7YoGundxFCROB8G
         L3mQ==
X-Forwarded-Encrypted: i=1; AHgh+RqaxdSivGCKeAL87bAZSSMoye1JOx/4Q9BB5G/pID+xP2KTJxsipCbk/s5E1YAPgF9umMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRuu8fwMmzkK5zAa+oyiGLz9FCUKFqRjmjNyQ04PhA+IVNhpt
	kFWN/j/SGrB6wL6HPIRS4xr9+y/Z/TI9s0XSItqIG4pDoSIKlF2Sqefvn1yuuH1rFvU=
X-Gm-Gg: AfdE7cmGR0/CCv029Coz39tqsnkB7Gy50fLEUrUKlv2yZEzYSz+MsvOPFd94Nxc4Doc
	ZZUG6y8HWvQi2/b3mMNDQdRWHeg9vOA/E2TwAKvi47zTmZrBChrlJa9lZXFwQFnZEtD/aZdd1Uo
	9j0u3beZbnj9MudX/6YZ9kyE+3vMTpU344v6F2jjEBHkBhxaSHtCdgGY4zJ3pQm5/zrUnPswsmf
	rlPJ3/hEfyOt9wZZAP/a9SDr4zYDvoHIU9SpJq2S5FDBMWsuUYD7IvI6EQEPUYg/GMsBgaD3vHK
	oJB47Tehw95HNuer+VS3iiYW6IEMjg9ojNH5/KiK1LX4Ia9ClqVW+2JysLTSkRU83cCM7k/K+XW
	BMYQ6oj/IxvGgpX4ROlwr9jbhFp3MwEDkKT6B5FMWVDv0eVA140oJ9wSPwUAJ8t6fUsagclVmXa
	ze9qMQ8AfS81+8bFVRZwAGe5eQsy7u9pEluS02xrvOog==
X-Received: by 2002:a05:6a00:983:b0:848:79aa:5d37 with SMTP id d2e1a72fcca58-84a5162f3admr637079b3a.55.1783979840901;
        Mon, 13 Jul 2026 14:57:20 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3643cd6sm9131766a12.26.2026.07.13.14.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 14:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 17:57:19 -0400
Message-Id: <DJXS2O9LFN5T.8BCWIJOB6N4M@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 08/15] bpf: Add a few bpf_cgroup_array_*
 helper functions
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-9-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-9-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> In the upcoming patch, the array can store a struct_ops map.
> The array could have a cfi_stubs acting as a dummy instead of
> the dummy_bpf_prog. The array logic will need to skip the cfi_stubs
> also in order to support storing struct_ops map in the array.
>
> bpf_cgroup_array_length(), bpf_cgroup_array_copy_to_user(), and
> bpf_cgroup_array_delete_safe_at() are added as a preparation work
> to allow skipping the cfi_stubs in the upcoming patch. This patch
> only skips the dummy_bpf_prog which is the same as the existing behavior.
> The current bpf_prog_array_*() callers are changed to call the new
> bpf_cgroup_array_*(). This is a no-op change.
>
> Unlike bpf_prog_array_copy_to_user(), bpf_cgroup_array_copy_to_user()
> does not need a temporary buffer. The cgroup caller already holds
> cgroup_mutex and dereferences the effective array with
> rcu_dereference_protected(), so it does not copy to userspace
> from an RCU read-side critical section. Details in commit 0911287ce32b.
>
> Another addition is the bpf_cgroup_array_free(). This prepares
> the array to have a different rcu gp for the struct_ops use case,
> for example, a struct_ops could have mix of sleepable ops and
> non-sleepable ops. In this patch, bpf_cgroup_array_free() only
> goes through the regular rcu gp. This is a no-op change also.
>
> bpf_prog_dummy() is also added to return the global dummy_bpf_prog.
>
> bpf_cgroup_array_dummy() is added to decide the sentinel based on atype.
> It now always returns bpf_prog_dummy(). In the upcoming patch,
> it can return a cfi_stubs if the atype belongs to a struct_ops.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

One style issue below.

> ---
>  include/linux/bpf.h |  1 +
>  kernel/bpf/cgroup.c | 79 +++++++++++++++++++++++++++++++++++++++------
>  kernel/bpf/core.c   |  5 +++
>  3 files changed, 76 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 047ffc029666..e371a4733135 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2561,6 +2561,7 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_=
array,
>  			struct bpf_prog *include_prog,
>  			u64 bpf_cookie,
>  			struct bpf_prog_array **new_array);
> +struct bpf_prog *bpf_prog_dummy(void);
> =20
>  struct bpf_run_ctx {};
> =20
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 7abbe12e108f..081d81de1816 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -319,6 +319,67 @@ static void bpf_cgroup_link_auto_detach(struct bpf_c=
group_link *link)
>  	link->cgroup =3D NULL;
>  }
> =20
> +static void bpf_cgroup_array_free(struct bpf_prog_array *array)
> +{
> +	if (!array || array =3D=3D &bpf_empty_prog_array)
> +		return;
> +	kfree_rcu(array, rcu);
> +}
> +
> +static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type atype)
> +{
> +	return bpf_prog_dummy();
> +}
> +
> +static int bpf_cgroup_array_length(struct bpf_prog_array *array,
> +				   enum cgroup_bpf_attach_type atype)
> +{
> +	struct bpf_prog_array_item *item;
> +	int cnt =3D 0;
> +
> +	for (item =3D array->items; item->prog; item++)
> +		if (item->prog !=3D bpf_cgroup_array_dummy(atype))
> +			cnt++;

The outer parenthesis needs braces since its body is an if-statement.

> +
> +	return cnt;
> +}
> +
> +static int bpf_cgroup_array_copy_to_user(struct bpf_prog_array *array,
> +					 __u32 __user *prog_ids, int cnt,
> +					 enum cgroup_bpf_attach_type atype)
> +{
> +	struct bpf_prog_array_item *item;
> +	int i =3D 0;
> +	u32 id;
> +
> +	for (item =3D array->items; item->prog && i < cnt; item++) {
> +		if (item->prog =3D=3D bpf_cgroup_array_dummy(atype))
> +			continue;
> +		id =3D item->prog->aux->id;
> +		if (copy_to_user(prog_ids + i, &id, sizeof(id)))
> +			return -EFAULT;
> +		i++;
> +	}
> +	return item->prog ? -ENOSPC : 0;
> +}
> +
> +static int bpf_cgroup_array_delete_safe_at(struct bpf_prog_array *array,
> +					   int index, enum cgroup_bpf_attach_type atype)
> +{
> +	struct bpf_prog_array_item *item;
> +
> +	for (item =3D array->items; item->prog; item++) {
> +		if (item->prog =3D=3D bpf_cgroup_array_dummy(atype))
> +			continue;
> +		if (!index) {
> +			WRITE_ONCE(item->prog, bpf_cgroup_array_dummy(atype));
> +			return 0;
> +		}
> +		index--;
> +	}
> +	return -ENOENT;
> +}
> +
>  /**
>   * cgroup_bpf_release() - put references of all bpf programs and
>   *                        release all cgroup bpf data
> @@ -356,7 +417,7 @@ static void cgroup_bpf_release(struct work_struct *wo=
rk)
>  		old_array =3D rcu_dereference_protected(
>  				cgrp->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
> -		bpf_prog_array_free(old_array);
> +		bpf_cgroup_array_free(old_array);
>  	}
> =20
>  	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
> @@ -530,7 +591,7 @@ static void activate_effective_progs(struct cgroup *c=
grp,
>  	/* free prog array after grace period, since __cgroup_bpf_run_*()
>  	 * might be still walking the array
>  	 */
> -	bpf_prog_array_free(old_array);
> +	bpf_cgroup_array_free(old_array);
>  }
> =20
>  /**
> @@ -570,7 +631,7 @@ static int cgroup_bpf_inherit(struct cgroup *cgrp)
>  	return 0;
>  cleanup:
>  	for (i =3D 0; i < NR; i++)
> -		bpf_prog_array_free(arrays[i]);
> +		bpf_cgroup_array_free(arrays[i]);
> =20
>  	for (p =3D cgroup_parent(cgrp); p; p =3D cgroup_parent(p))
>  		cgroup_bpf_put(p);
> @@ -625,7 +686,7 @@ static int update_effective_progs(struct cgroup *cgrp=
,
> =20
>  		if (percpu_ref_is_zero(&desc->bpf.refcnt)) {
>  			if (unlikely(desc->bpf.inactive)) {
> -				bpf_prog_array_free(desc->bpf.inactive);
> +				bpf_cgroup_array_free(desc->bpf.inactive);
>  				desc->bpf.inactive =3D NULL;
>  			}
>  			continue;
> @@ -644,7 +705,7 @@ static int update_effective_progs(struct cgroup *cgrp=
,
>  	css_for_each_descendant_pre(css, &cgrp->self) {
>  		struct cgroup *desc =3D container_of(css, struct cgroup, self);
> =20
> -		bpf_prog_array_free(desc->bpf.inactive);
> +		bpf_cgroup_array_free(desc->bpf.inactive);
>  		desc->bpf.inactive =3D NULL;
>  	}
> =20
> @@ -1166,7 +1227,7 @@ static void purge_effective_progs(struct cgroup *cg=
rp, struct bpf_prog_list *pl,
>  				lockdep_is_held(&cgroup_mutex));
> =20
>  		/* Remove the program from the array */
> -		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
> +		WARN_ONCE(bpf_cgroup_array_delete_safe_at(progs, pos, atype),
>  			  "Failed to purge a prog from array at index %d", pos);
>  	}
>  }
> @@ -1296,7 +1357,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>  		if (effective_query) {
>  			effective =3D rcu_dereference_protected(cgrp->bpf.effective[atype],
>  							      lockdep_is_held(&cgroup_mutex));
> -			total_cnt +=3D bpf_prog_array_length(effective);
> +			total_cnt +=3D bpf_cgroup_array_length(effective, atype);
>  		} else {
>  			total_cnt +=3D prog_list_length(&cgrp->bpf.progs[atype], NULL);
>  		}
> @@ -1326,8 +1387,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>  		if (effective_query) {
>  			effective =3D rcu_dereference_protected(cgrp->bpf.effective[atype],
>  							      lockdep_is_held(&cgroup_mutex));
> -			cnt =3D min_t(int, bpf_prog_array_length(effective), total_cnt);
> -			ret =3D bpf_prog_array_copy_to_user(effective, prog_ids, cnt);
> +			cnt =3D min_t(int, bpf_cgroup_array_length(effective, atype), total_c=
nt);
> +			ret =3D bpf_cgroup_array_copy_to_user(effective, prog_ids, cnt, atype=
);
>  		} else {
>  			struct hlist_head *progs;
>  			struct bpf_prog_list *pl;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..1837bb7bb4e9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2740,6 +2740,11 @@ void bpf_prog_array_free_sleepable(struct bpf_prog=
_array *progs)
>  	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
>  }
> =20
> +struct bpf_prog *bpf_prog_dummy(void)
> +{
> +	return &dummy_bpf_prog.prog;
> +}
> +
>  int bpf_prog_array_length(struct bpf_prog_array *array)
>  {
>  	struct bpf_prog_array_item *item;

