Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12EE5C613
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777083457; cv=none; b=JH9UDVoHmhW82IA9ovh/GngYQfrv8o8vqCj+lOKFXasJ+hFhV08JHEmakPpHjVmHSuk8UYooGbjjCkQQtNNCqJOvxdyDL7JxeHcGMehk3Kjx9S6Zu6ZozKdIhNUeeIKLjarLIm2+kR0+DmQfGsSR2cw7ofIFON4K3+wq/oXtgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777083457; c=relaxed/simple;
	bh=B7eKxT0CklwU4a+KUGe/ivPvc9NgmkKrcfstup9BHH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxuZ01HfXE/mBjnIuYNs0uqy0gtkcuC/5QwH0Vg9FeFZtZDjqq+G1twc7IcOFfejmC2tWKZaCNPGxM+Pbrhbhm4IwFTWjQYXQCa+ZZ9r4tJpJR771AUqA6VGJxvL1cRkTfCAWQbMhnPuxyO+e7OxbbFPk+EWvT5gYEQ81fcUJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdKgK7dJ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdKgK7dJ"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-793fdbb8d3aso89368377b3.3
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777083455; x=1777688255; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNwxkb+9lc8LbYT7XYKKUUPdOhjNGqAa21W0MQ/ZC/Q=;
        b=mdKgK7dJsjmT+XTBi7TPvg0BFJFKQI/YsK/IHfsUoHniJB1pNWapgWrNeKoUrG2iB0
         +HSblEH9eUhVuW5f3mcD2mp9EQd+XL3MfQg4tZe8qOLoiaQaFzNNBkmpKw8WvXTO4bCs
         ts3rLCTJkdfHOrfczZ7jQwcz43E2XJ+UNgHHo5c69WhR/cb0t+KkhD6AdB22m3oAlWKV
         ohq986Ty3aibL75DtmB6Mjcivtr6zhlCsrL9wJR06vVbe4Wb7Lz+vU1zdm13mbSKeZTI
         pyfs7FwpU/RI4iJ1VO18xqQJzAW6cmIXB0nkTwpETWhanGJYm9boiXshjikV76Z130fc
         cuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777083455; x=1777688255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNwxkb+9lc8LbYT7XYKKUUPdOhjNGqAa21W0MQ/ZC/Q=;
        b=BENRB5zho6s3LBf260zSHbnzbiXKzFGsXL2L+PMk4xm8tk0ZBxEPQAQUHA/hLs7CrD
         Z6NzEN+BDftafezIE4EFE0u9lS8sObXYu9KJUWNDZEKEeMg5Inxa7dFb7VcjB5AouNZp
         jcU8LuYnHQpe8+Lo7wt5s826rRshdtAJXXUlVNmU399q/maMb9e+5vhoUadMp7TMM3tK
         Arrl/sswGel56v2hATaFOYCE+EaoeJhVRmZM+3M2XrY0tjm0EPtsWf2mcOmlSoGnaAu2
         ahmckaJUnUDpyXCBMs90sNCoga2Ib5wl9YUvcgz42iv+oCF88dwOXydvt9QrkmltnTgx
         f57A==
X-Forwarded-Encrypted: i=1; AFNElJ+cWKerr3HNX+Gx09rPiUK/P67tUtUzfpv0RTiGBTZ3yUY7F62vrQt60rhboDM4iJ/scy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQ1DPfiPBlwpSiQ1+b/i27FMXfofBxQZLiQS1ZFsxtAJx+XhN
	EEgSEhbUJMAZbJ0Yy5WaAXKW/VNXQ9bPJkTtrl2rzIoMWEL5Z62mfbtC
X-Gm-Gg: AeBDieuUWL2QFOT1LMFXSCvqisuZIuEZVGoyfWFPUTAryktevrCM2/q50bE0lBhdw6u
	IfQ8FjTA7XkCvbXCWgLC/66RxXcsJVVx5gk9ZjEtnV4+HkFJsKefl233ouSTGVHhZUvUfLElgrv
	BU9LTw19CSxCE7l1CSSf+rnMsHC5D1npK1nenmD83/tX3d1rFmoe/OMVYM1OwGIeM/vJJU1IwlH
	uyUdWiF+kKQ/KO5IlyQAQsTG6EKQeIMcOzFJsq89LwFmkDq0X4+7PdcxsyCZhJIyVg9sJ3v0gZY
	uaXp/BVRHWSPkhWRUuMoBerIznZ5qSJb1ES1e8pc8DQxCi7tD9iryLHDXQeIFWDiK0E+hzDtRhW
	HS2oHiRA9c8uxV53QOAkkOybBI/pZR2kvyGbxq3WeShw71QBi0oDFzkz21sPSN5SeoAhOJGlFeh
	4n9unka77YdK04h74wDv86LQzuwcr7yoX4VRS7kAQE94koGdSydB8oo7SLkAxiLrfrTfXqxt0ET
	6f/eA==
X-Received: by 2002:a05:690c:a05c:b0:79f:4e02:50cc with SMTP id 00721157ae682-7b9ecfe1297mr273316837b3.42.1777083454774;
        Fri, 24 Apr 2026 19:17:34 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:cc96:e003:f6cc:4ed])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89abd7sm98290457b3.1.2026.04.24.19.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 19:17:34 -0700 (PDT)
Date: Fri, 24 Apr 2026 22:17:32 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko@lists.linux.dev, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Implement dtor for struct file BTF
 ID
Message-ID: <aewkPGl6vkcWS5z9@zenbox>
References: <20260424192252.695240-2-utilityemal77@gmail.com>
 <20260424195958.AED4EC19425@smtp.kernel.org>
 <aevOssMWH_Vm9CPG@zenbox>
 <CAADnVQKFtuX48V9Yy88GHGVbQyY30M3b3YBvZ2PmYt_-jbohpQ@mail.gmail.com>
 <aev6zU2vj6wmaRMG@zenbox>
 <CAADnVQJEXDh6=rKfUjuR_zjCcXfMAXUaXcXTWgUAx1-mWe_e-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJEXDh6=rKfUjuR_zjCcXfMAXUaXcXTWgUAx1-mWe_e-w@mail.gmail.com>

On Fri, Apr 24, 2026 at 06:25:31PM -0700, Alexei Starovoitov wrote:
> On Fri, Apr 24, 2026 at 4:20 PM Justin Suess <utilityemal77@gmail.com> wrote:
> >
> >
> > So either:
> >
> > 1. allocating memory for a new irq_work on the fly, which is an
> > operation that can fail. So if we're under memory pressure the
> > element never gets freed.
> >
> > 2. preallocate an irq work for every element ahead of time.
> 
> obviously that's not what I was referring to.
> irq_work is rarely used directly like that.
> The common pattern is:
> defer_free()
> {
>         if (llist_add(head + s->offset, &df->objects))
>                 irq_work_queue(&df->work);
>
That's smart. So you can use it like a doorbell pattern and avoid
re-calling it. And avoid locking with llist.
> but before going there.
> Please enumerate "other dtors broken in NMI".
> What exactly is broken?
> What is the sequence of events?
> All map types with kptrs? or particular ones?

Only referenced kptrs.

I only tested hashmaps, not any other map types. But I don't see any
reason why this wouldn't apply to other map types.

Here are the specific dtors that know/suspect are buggy in NMI.

1. bpf_task_struct_release_dtor I confirmed. See below

2. bpf_kfree_skb_dtor can do call_rcu_hurry.

3. bpf_crypto_ctx_release_dtor does call_rcu.

4. bpf_cgroup_release_dtor frees via work queue and takes cgroup_mutex.

bpf_cpumask_release_dtor I think is safe.

I made a reproducer for one of these (task_struct dtor).

I triggered the issue by deleting the last reference to a task_struct kptr within the tp_bpf/nmi_handler prog.

`bpf_map_delete_elem()`
`  -> htab_map_delete_elem()`
`  -> free_htab_elem()`
`  -> bpf_obj_free_fields()`
`  -> bpf_task_release_dtor()`
`  -> put_task_struct_rcu_user()`
`  -> call_rcu()`

Log:
  [    1.358433] ================================
  [    1.358433] WARNING: inconsistent lock state
  [    1.358434] 7.0.0-11169-ge4ef174588b8-dirty #16 Tainted: G           OE      
  [    1.358435] --------------------------------
  [    1.358436] inconsistent {INITIAL USE} -> {IN-NMI} usage.
  [    1.358436] test_progs/134 [HC1[1]:SC0[0]:HE0:SE1] takes:
  [    1.358438] ffff8ae3bbc6f0e8 (&rdp->nocb_lock){....}-{2:2}, at: __call_rcu_common.constprop.0+0x316/0x740
  
This is done by loading a task_struct referenced kptr into a map and
deleting it later from within a tp_btf:nmi_handler BPF_PROG_TYPE_TRACING
program.

For the task_struct case;

I have a bug report:
https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/

With reproducer:
https://gist.githubusercontent.com/RazeLighter777/5539336d79ab1854f9e9550c6dcab118/raw/082f1eeb2dd445936e64dd3a33861764690bde82/task_struct_dtor_deadlock.patch

I didn't make a reproducer for other cases.

Thanks for the tip with llist and irq_work, that blew my mind a bit.

Justin
