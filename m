Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BAF3C13EC
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982750; cv=none; b=p0Kcu5B/WUIkFyKUT4REBBiv3Ti9H/gZPe6Fn+N2NXQeM3FNImjAIDJA5vY7o6KJyDIOQ9wgVD4o2dIQzYHkmSG52PKACzsOTyY0n2Rp4+qWyQFB0Yqg7niA05KzbQFhTMFpVorFgoTPrJgoD2Xhc93nhTeE7f73wLs0SachUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982750; c=relaxed/simple;
	bh=9Rm+tBgNVRjYobl03pLy+QZc8ejHkh/KaIaKlECpzjE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cM8TadVF8gsJFL84QcBbVhbWBJbxv0en02NgccYrsdBe7AavcWvGQqaVF8Yas8BF2oZ5BhYklOPy6YafxuBxIivoo65VdsnpSjXpTzLvl9Pei9SDasWxXng0oOyhG9ddEXWkGeQ80+yxznRwgEhztSj+OB+v1koFW9XVrKWEHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Wqc3o6sV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Wqc3o6sV"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52d5bfa4bafso13893621cf.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1788982747; x=1789587547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1GUgXHgHoEl56pUUuNlJgXsrmqq8UKwhkWovOGCgHHU=;
        b=Wqc3o6sVJaV6tlhBxFS5tIYySDkREgBIDorYA/VwP01U90VqLHv1+lEtANetdwPO5c
         a9pV4HAZ3KmC8TEWW+Zws+XckX8fO4DAYaDcS5AWn3tc9XOHSblhEnDy5YcTngkSkJo0
         zdpgvSqG6xZ2wpdabS/GGzUIV375g5nXMkjYP4ocFjyZqKokqwKfA0WpETrkvm3dA6R6
         HC8J0fQfshR1DfbJYdR8pvmzAEiM+kiaw9XRiSYkg+6ZAmEf9izLZHTR6xaVOEw+iwSw
         xjcv3tVlEMuiejY2StHlmTACgHlnQCVhMJ1HDg3qtyU6PITPNYYH74oxGoXsMxx4l80T
         m0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982747; x=1789587547;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1GUgXHgHoEl56pUUuNlJgXsrmqq8UKwhkWovOGCgHHU=;
        b=e519uMhq4TCWs5YDC/+vDqDg3o84U9U4Us59VrR3QRdSu6a4E08s1+2KMpITgBu39j
         FpR+yNVjawQ/xKWj/nhNtQ/Wu/msx7n1UOgnfzMR9rkdJMEf48N2MHM3H6k4PR/RbtQT
         e9bjx+0k3e+L3nfiL8FkBD/kqmR3pmP2R5NAroG1zxhnsDNQC1EIxzW5mEKXmaQW9Qap
         SIpi5ZbjmT9JpN8eIXVpb8neNlmw3k0Ml4FrL/hopYv0lnBYs/Nn0mbYGPRBMo5oWAx7
         9PcUbNUhgWCFKrU+dg9gfYti1EwkC+SXkTdN6mbMQroiKDhtyG0z3FTigog8Oixl9QXy
         jHJg==
X-Forwarded-Encrypted: i=1; AKwUvBxvCalIri+trUO4UihnEiP8OeXhR8JC/PmvepswiVpMvGiuWF7x8ddttcnCfB4AfaoNKi8=@vger.kernel.org
X-Gm-Message-State: AFuF++lI3qg0L7wnR8bFdjQhpe9TTw7ouCyrCKzDkUoeNGcUvX4TOoJ8
	e7czmGmbWX5bJAW/f7Ou0tgkP7GBj7mFnqQBFbD0TVTg+daMNCkMrYAugI074nB6T8w=
X-Gm-Gg: AYBFou3Ypo9s2tz/Zqc3Uw/7/qGHk0Rnx0qhUxl+9P5i+ZxY0N196CTUJqR0vdP3hgs
	CX6iWamEYEj3CiFXtWoRCrSRWG0Qdz4dZlADoCD5I34078NL9gdA/D56KYUqUOHUkZM6MFH+y+R
	9gt1yXgxjTiGG/GyJlWLQzLbeKM2ciktEJN6hOOZ89OGVUtkGe3CAx9DLUcggjPPpyXJ2TuQNg/
	0gFcsQzqk1PZwnPtCzQRDNLbQSxmbmf5iDdwtYmt7DOwAmnbHVerUMlveJYSntGqypeIeZt4vkp
	Mk6t/ZFUMx5aDvXsZFa/2zOXwpuWJbB/LXi+IbySb0HunBk6cbdbJvIzVGPnMkd/W32ZvIwB6Wn
	ovxZlD83IStE6B2jGGbjRqX4sj/PbNAHlY60a0wqzCrmakOSWa4SyCcfB/BHEqg9B3HC9HQUXY6
	mL1bIAqGQ7AJ6Dp6283IuZFr8uJSHMlJYDoNb0dXJsDRedAPeEOD9JvN4Lz4s2jhP5nFrFcp6Fm
	0iIneKGDWYlCdzENctXUloEDqCdidUp4p8Z/lezyh59QvFvlucRw+SyNXQfcWribEU=
X-Received: by 2002:a05:622a:1247:b0:52f:f472:bad1 with SMTP id d75a77b69052e-530549f9b59mr430060511cf.33.1788982747305;
        Wed, 09 Sep 2026 12:39:07 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541c94ddsm151964851cf.23.2026.09.09.12.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:39:06 -0700 (PDT)
Date: Wed, 09 Sep 2026 19:38:20 +0000
Message-ID: <20260909193820.9aac7888ba9d@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, Dennis Zhou <dennis@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] writeback: report a Tasks-RCU quiescent state per cgwb drain pass
In-Reply-To: <aqGilhgcEd0qaHjI@slm.duckdns.org>
References: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com> <aqGilhgcEd0qaHjI@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, Sep 09, 2026 at 08:16:54AM -1000, Tejun Heo wrote:
> On Wed, Sep 09, 2026 at 06:01:07PM +0000, Josef Bacik wrote:
> > +		do {
> > +			cond_resched_tasks_rcu_qs();
> > +		} while (cleanup_offline_cgwb(wb));
> 
> The patch looks fine but this overall seems fragile. cond_resched() was
> already marking "stuff that can take too long" but we need to use
> cond_resched_tasks_rcu_qs() if it can take *really* long. There gotta be a
> way to make this more maintainable. If always doing tasks_rcu_qs from
> cond_resched() is too expensive, can it be be gated behind something cheaper
> e.g. some tick based test?

Yeah I agree, it is fragile.  Every long running loop in the kernel that
only does cond_resched() is a potential multi-minute synchronize_rcu_tasks()
stall now that cond_resched() is a no-op on the preemption models most
people actually run, and playing whack-a-mole with
cond_resched_tasks_rcu_qs() at each site as we trip over them isn't a great
long term answer.

I'm working on something more general so we don't have to sprinkle
cond_resched_tasks_rcu_qs() everywhere, but I expect it to be controversial
and it's going to take a while to shake out.  In the meantime these are real
bugs that are taking machines down today, so I'd like to get the targeted
fixes in and to stable while the broader discussion happens separately.

Thanks,

Josef
