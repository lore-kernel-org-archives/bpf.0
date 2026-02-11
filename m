Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79BA29C351
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807233; cv=none; b=FleivPZgIb59pz19rLrU6BSOaQR3Nv5BzQ2HlYqH8qp9/kLmsPCaCRGDTl8V5bKSISrOLQz8VSPOf6xhst8p7z7zT674AfVqcMb9Waa4ngaYVbPgrdxBle9S51Nx+8Pqc7AZDbHuJz34u4D6djVhW6chh43Em2HykIxmLhzrLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807233; c=relaxed/simple;
	bh=t1g1w7UMyuWNEpvXNH3O15O9n/kBxPfKQdApgK2lh6w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6yTV64tCpMTcf/L+z/gXkxqIlVMv2UM6yuDL37+R3DrgKwXFDmSmpiq21lFfggUmXRIpJInygdcPGuDfkksZKmf2iSt8vKFChyKAApXA/UjKMuWOyRJkPnWlQtWeOuz26BLvdYSdhdJQUtkaESFB5zmDkFLnLSVyVDqAd54XcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knzY1hVD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knzY1hVD"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59de8155501so6962737e87.3
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 02:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770807230; x=1771412030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kvmAg2kqzfViwumrS5M3A5Undk34/pw+oV9Ro+ELMA=;
        b=knzY1hVD0/4krU6w+eyEe5Iwr7Lq5Hh1w6au2wnXYt5ZwhJzAaF/HpHBvr0lkCfOM/
         k+mF6aLsrysrtH5pBR56OkWzy7aC8RFLcX+oxyZmnN0BT7Zol/UqfZPhIdwBk+z17T5Q
         EguQCEI1NolQsesF7Nhxwq6ZAy0XkocyqfFIJAql0aDjZkwMzJFwX6Dv+S2ggHfaARS8
         3VsWNt5/TbTBh+jCPvQve6F8yB4k51IrZKSG9l+noeaerFjd4UbhA72nlCt76a2oYTMi
         05VJM2Bk633LvBJu6gWYntwEmOAXLC9cZZZt+f2Gg4y7/BW89Z9WRErZT1EduIOTRFcy
         U6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770807230; x=1771412030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kvmAg2kqzfViwumrS5M3A5Undk34/pw+oV9Ro+ELMA=;
        b=AjY4CNL/h+UTJyk9qsreY+FIfg5ymvacBc+7IpzAlcZ4jNk2W+CN0JAUHuCgpl3sxq
         PTnsYVgtkJrwxBehRqe5k3/g2EQZy2/lQ1so4+0Rm1Z7TXHvHdBYj2YW2OLywdPPo3js
         z3gHS1a4G+QpJYFc0AOsXIl62VAxZI+WcEgsNcrdQxsyvqBOjxcprFMu1+Al+S7ZN/5G
         bv5pp77Exwdf1w3JNNa5Nqz8qE2+R+8NomG2yg3u4rmprBkLYftEPefAWgJJUobdv61V
         ZBehMoWez0KlmljYSUwraaA1JiORwhDOSEAZSjZrTzmhYCeUg6SevaCayaJerOw3MKGI
         0DJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrNBKx/kkxiv10ZHwPwnyUvCecxK01XsaTYF5OL9Nhzbhtt2Rh1dAdSGy1pCP3ulzZjQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzocNdRQLM9Kod8N1RMohiuSywCKSQiAZRybe38+LLEJur+ezii
	nuJKdHO+GS31TqnUORlIQsb9Jr5Loa+0vuCCXtnOnbXe48XI4HOmoui0
X-Gm-Gg: AZuq6aI3JQUpjbNHfG5fPFrhj7lc6Ha0FsAf/gsiPQuQCnVre5VxHDJjNW+dJk8tBFT
	JFRJ2iuaRt9cCX89mXmRirOAlD22dIZHNMwCQAtOXZGDrnkfuwojNsNl9aH0MgvloImSjuQ2n2L
	zW9iTDS5qVTicVU/psXUSlIrqElOXZH3nwyot9K0wUbC6YP80nAM+aaqX2AJTDmo7w44u9heC+l
	sZdYcuA4bLjtMUwpplh40fjeHefO9KsHiPia1VFDgPY5O7mxwdEY3+xkDryBG0J23W1tSgN2WzJ
	87MuUzJMWWkjC8wKD2JF2wfus37ElfHueCBfIYHqEBn+SeFCgUzUHzJLBm8RU/v8ZzbPYBOcsH6
	FZcUi17LU7m4tDkTbfyFNXTWkYJmfUafxmwp6bkTgVWB3D7gcbMkFtFrwC3Qb9hldoCx1fUJFh2
	8=
X-Received: by 2002:a05:6512:3b95:b0:59d:eab0:c836 with SMTP id 2adb3069b0e04-59e5df4670amr507151e87.6.1770807229920;
        Wed, 11 Feb 2026 02:53:49 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5a50a1sm267273e87.57.2026.02.11.02.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 02:53:48 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 11 Feb 2026 11:53:46 +0100
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] mm/slab: introduce k[v]free_rcu() with struct
 rcu_ptr
Message-ID: <aYxfumz5IlwBDS4n@milan>
References: <20260206093410.160622-1-harry.yoo@oracle.com>
 <20260206093410.160622-2-harry.yoo@oracle.com>
 <aYxXE6CC0XQr1KNK@milan>
 <aYxdleYc7_TWj9To@hyeyoo>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYxdleYc7_TWj9To@hyeyoo>

On Wed, Feb 11, 2026 at 07:44:37PM +0900, Harry Yoo wrote:
> On Wed, Feb 11, 2026 at 11:16:51AM +0100, Uladzislau Rezki wrote:
> > If this is supposed to be invoked from NMI, should we better just detect
> > such context in the kvfree_call_rcu()? There are lot of "allow_spin" checks
> > which make it easy to get lost.
> 
> Detecting if it's NMI might be okay, but IIUC re-entrancy requirement
> not only comes from NMI but also from attaching bpf programs to
> kernel functions, something like:
> 
> "Run a BPF program whenever queue_delayed_work() is called,
>  ... and the BPF program somehow frees memory via kfree_rcu_nolock()".
> 
> Then, by the time the kernel calls queue_delayed_work() while holding
> krcp->lock, it run the BPF program and calls kfree_rcu_nolock(),
> it is not allowed to spin on krcp->lock.
> 
> 
> > As i see you maintain llist and the idea is simply to re-enter to the
> > kvfree_rcu() again with allow-spin=true, since then it will be "normal"
> > context.
> 
> It tries to acquire the lock and add it to krcp->head, but if somebody
> is already holding the lock, it re-runs kvfree_rcu() with irq work.
> 
Check no_spin on entry, if true, llist_add, queue-irq-work. Re-enter.
You might need to set-up interval to prevent frequent bouncing.

--
Uladzislau Rezki
