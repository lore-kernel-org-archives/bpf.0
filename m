Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2064282F2E
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469217; cv=none; b=sALhtDJ/C+xGRLwlK3H9TeFtr1rgdUp3+ois4KsXwQwvbCQvNJ4hHKw9VgHVxltEdIHwjOVEua1Xeby+v59Xj0uLTnB5sZ277bqBEtUQvLsUZHCfaDVoKHQaCdLpkXkdk9jXmrejNa/+k1KaSrZerJmfCWUgBX3bfg47Qp15IAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469217; c=relaxed/simple;
	bh=FyUqZomlR+UwcWtG4PMmycpRcPIRvuK5GCfw0pHmIrg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=l7hOKiOg7IY9HP5wDAlRcDp0XI1KGkp2b5m3052GXt1gxTpIorZcfFYzka/SffcXsi+XDzkUqADnb9jToYpLkrnWXM8H76ikdTtcU/HH780K+A0hx16svxDiA5v+Xl7yZ7Qn3n9SLUzF9NQ9NpkONVzKYtO9mLXZU+xqG+Juc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=0IpdoHVU; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="0IpdoHVU"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f7020a928eso11020713eec.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779469213; x=1780074013; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OoZvY44wHe6OYlEQEn3JZzrKroiLSSjFFEEqP+ezzg=;
        b=0IpdoHVUMLtE5abyzM1gvO2sNCZhdjIVRgKeGTB07J17zBVz5Z9zkRcB6Yc3ZSH72E
         W4rymoXmvrV+MKQLHZzB2i7zqFtg+BiChKX3dGTHQ8mr719cmgJ5cqU8DRIbfEzyFRX4
         3Qv9sZ+kTScQib3QuXcXNdhviBZHMUPT1YE+DD2kd461CQvHwe1eRToePTaCUdbcBVpF
         SNyVnphPsyyAYTFdxVI6O3EfDj/h2daOs25hVgnPzZrmX6rGCRUiQDSZ4R2WhLiH3/+N
         3xiPew8WZKOkijqntai7IcymvfeZKD+3KS7nWsFJ01EMzMNgvdEiFopM0a8q/R6yRTki
         MNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779469213; x=1780074013;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OoZvY44wHe6OYlEQEn3JZzrKroiLSSjFFEEqP+ezzg=;
        b=snemCqQIfbFxHuZMFOEbm3qdM5RZ2C4G0Hvwqa6qG6PzPN4mwZqgG4ZzofFM8k2aCJ
         aOyx7RIMoTfruWdo12VyPdi/UgBrkjVvlt1HUV7zKr5UJ4AIdr0Q6p9qaEDsqvMQvdHe
         vCRn3HhjpJsgNgyAfhhxIjYwL7PnoMHnFGXGu1UC9FE2zN6bSz+ivan5eQKr1YsAqrZK
         rj8jhWxbBoq8pEXyE+nom0n5olTp1bFBN2wMoxXj4pnIFYbV378sJ0OUmqvWxGURI7Mx
         L1qEVS6BiheTKrqZOI5IoETEi4lbydXtZZr8J6AdVxZFw6y6zgTW1yJ3OjSXX2lw88xL
         AdYw==
X-Forwarded-Encrypted: i=1; AFNElJ9Bv5OT/rQqE1PLbXXV3rCQxcU8B5zz9BCPy2a38h12jpD/aNzzDzCuLd1KampOysu1U2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5xaxdij4qx4fHt6Ks1VMDgLvrCAqQLGIJq4B9oxwPOECVDRIT
	NQ6Gq8jbYSOIy0ZDYsbC2ety2WH14t9omtNkkmlKhZQ+Jldq70EOe82K1DVa7oNatXd2YjMfgpz
	SdoUpLcPpvQ==
X-Gm-Gg: Acq92OHY/HAZzh+z8F+UOjwYF2cP/78RpPtlOU3RzGmq9W/x4N/TyuPy1S/DDXheDH7
	RMq0+khowM9v3bNuUtqCFoYi87MEkj5ZdJyKBNssBefvrRZgi2NfDaDE+N9MbdR31SiibGCip7g
	4Zhfc1/ulphDZOqePnRngeHRvYJny6OAgLp00J9OSOrpC0ZOhvtLkYfG8wh73/Mtc1DrPlwpu7P
	pnLc4LNqqVjY6xtmej3GCndUZFgSh3JgSofMqESC6MnqzKt4WP1JR8S03+kmnQuPa+1XwUgFgQz
	5Lyd0ckFy+Y25YpEA2KAMEdDgGqh0/V5nToTo/7ssI7eMRpC8J3YTMjWF2ZZY5AE4wHdpYWeO7H
	l9jj3DU7SKU7fYYYQqcOaiZfZyoFbeRqoblZ3U/vaolIXrjyk0II6WoUSZadA4DGfGr4klXBmNA
	cml6DL
X-Received: by 2002:a05:7300:bc0b:b0:304:2c71:3f61 with SMTP id 5a478bee46e88-304491d4a5amr2172454eec.28.1779469212087;
        Fri, 22 May 2026 10:00:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::69da])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304535ae870sm1305837eec.19.2026.05.22.10.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 10:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 May 2026 13:00:09 -0400
Message-Id: <DIPD6TO2VNF2.2N8KKUWX68UUG@etsalapatis.com>
To: "Himanshu Anand" <anand.himanshu17@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>
Cc: <yonghong.song@linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: Fix preorder-unaware index in
 replace_effective_prog and purge_effective_progs replace_effective_prog()
 and purge_effective_progs() compute the target index in the effective
 program array by sequentially walking the hlist (pos++).  However, since
 commit 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs"),
 compute_effective_progs() partitions the effective array: preorder programs
 occupy indices 0..preorder_cnt-1 and normal programs occupy indices
 preorder_cnt..end.  The sequential hlist walk does not account for this
 partitioning, so when BPF_F_PREORDER programs coexist with normal programs
 the computed index diverges from the actual position in the effective
 array. In replace_effective_prog() this causes BPF_LINK_UPDATE to overwrite
 the wrong slot: the freed program [snip]
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260522162248.55586-1-anand.himanshu17@gmail.com>
In-Reply-To: <20260522162248.55586-1-anand.himanshu17@gmail.com>

On Fri May 22, 2026 at 12:22 PM EDT, Himanshu Anand wrote:
> Signed-off-by: Himanshu Anand <anand.himanshu17@gmail.com>

Something is misconfigured on your end and your're sending the patch
description in the commit message, both for this and the other patch.

> ---
>  kernel/bpf/cgroup.c | 74 ++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 45 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 876f6a81a9b6..437e1e873bf8 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -923,15 +923,12 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
>   */
>  static void replace_effective_prog(struct cgroup *cgrp,
>  				   enum cgroup_bpf_attach_type atype,
> -				   struct bpf_cgroup_link *link)
> +				   struct bpf_cgroup_link *link,
> +				   struct bpf_prog *old_prog)
>  {
>  	struct bpf_prog_array_item *item;
>  	struct cgroup_subsys_state *css;
>  	struct bpf_prog_array *progs;
> -	struct bpf_prog_list *pl;
> -	struct hlist_head *head;
> -	struct cgroup *cg;
> -	int pos;
> =20
>  	css_for_each_descendant_pre(css, &cgrp->self) {
>  		struct cgroup *desc =3D container_of(css, struct cgroup, self);
> @@ -939,27 +936,20 @@ static void replace_effective_prog(struct cgroup *c=
grp,
>  		if (percpu_ref_is_zero(&desc->bpf.refcnt))
>  			continue;
> =20
> -		/* find position of link in effective progs array */
> -		for (pos =3D 0, cg =3D desc; cg; cg =3D cgroup_parent(cg)) {
> -			if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
> -				continue;
> -
> -			head =3D &cg->bpf.progs[atype];
> -			hlist_for_each_entry(pl, head, node) {
> -				if (!prog_list_prog(pl))
> -					continue;
> -				if (pl->link =3D=3D link)
> -					goto found;
> -				pos++;
> -			}
> -		}
> -found:
> -		BUG_ON(!cg);
> +		/* find the old prog in effective array by direct pointer
> +		 * comparison, since compute_effective_progs() partitions
> +		 * the array (preorder progs first) and the hlist walk
> +		 * order does not match the effective array order.
> +		 */
>  		progs =3D rcu_dereference_protected(
>  				desc->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
> -		item =3D &progs->items[pos];
> -		WRITE_ONCE(item->prog, link->link.prog);
> +		for (item =3D &progs->items[0]; item->prog; item++) {
> +			if (item->prog =3D=3D old_prog) {
> +				WRITE_ONCE(item->prog, link->link.prog);
> +				break;
> +			}
> +		}
>  	}
>  }
> =20
> @@ -1003,7 +993,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
> =20
>  	cgrp->bpf.revisions[atype] +=3D 1;
>  	old_prog =3D xchg(&link->link.prog, new_prog);
> -	replace_effective_prog(cgrp, atype, link);
> +	replace_effective_prog(cgrp, atype, link, old_prog);
>  	bpf_prog_put(old_prog);
>  	return 0;
>  }
> @@ -1078,11 +1068,9 @@ static void purge_effective_progs(struct cgroup *c=
grp, struct bpf_prog *prog,
>  				  struct bpf_cgroup_link *link,
>  				  enum cgroup_bpf_attach_type atype)
>  {
> +	struct bpf_prog *target_prog =3D prog ? : link->link.prog;
>  	struct cgroup_subsys_state *css;
>  	struct bpf_prog_array *progs;
> -	struct bpf_prog_list *pl;
> -	struct hlist_head *head;
> -	struct cgroup *cg;
>  	int pos;
> =20
>  	/* recompute effective prog array in place */
> @@ -1092,28 +1080,24 @@ static void purge_effective_progs(struct cgroup *=
cgrp, struct bpf_prog *prog,
>  		if (percpu_ref_is_zero(&desc->bpf.refcnt))
>  			continue;
> =20
> -		/* find position of link or prog in effective progs array */
> -		for (pos =3D 0, cg =3D desc; cg; cg =3D cgroup_parent(cg)) {
> -			if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
> -				continue;
> -
> -			head =3D &cg->bpf.progs[atype];
> -			hlist_for_each_entry(pl, head, node) {
> -				if (!prog_list_prog(pl))
> -					continue;
> -				if (pl->prog =3D=3D prog && pl->link =3D=3D link)
> -					goto found;
> -				pos++;
> -			}
> -		}
> -
> -		/* no link or prog match, skip the cgroup of this layer */
> -		continue;
> -found:
> +		/* find the prog in the effective array by direct pointer
> +		 * comparison instead of computing index from hlist walk,
> +		 * since compute_effective_progs() partitions the array.
> +		 * Use target_prog which resolves link->link.prog for
> +		 * link-based entries where prog is NULL.
> +		 */
>  		progs =3D rcu_dereference_protected(
>  				desc->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
> =20
> +		for (pos =3D 0; progs->items[pos].prog; pos++) {
> +			if (progs->items[pos].prog =3D=3D target_prog)
> +				break;
> +		}
> +
> +		if (!progs->items[pos].prog)
> +			continue;
> +
>  		/* Remove the program from the array */
>  		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
>  			  "Failed to purge a prog from array at index %d", pos);

